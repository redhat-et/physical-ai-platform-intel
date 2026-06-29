# NVIDIA OSMO — Workflow Orchestrator Deep-Dive

**Date**: 2026-06-25
**Purpose**: Understand OSMO's workflow DAG model, execution semantics, and how it compares to Tekton/Argo/KubeFlow for Physical AI pipeline orchestration.

---

## Overview

OSMO is an **open-source (Apache 2.0), cloud-native workflow orchestrator purpose-built for Physical AI**. It solves the "Three Computer Problem" — coordinating training GPUs (GB200/H100), simulation clusters (RTX PRO 6000/L40), and edge devices (Jetson AGX Thor) through unified YAML workflows.

Originally internal to NVIDIA (Project GR00T, Isaac Lab, Isaac Sim, Isaac ROS), OSMO orchestrates thousands of GPU-hours daily across heterogeneous compute.

---

## Workflow Definition Format

### YAML Structure

```yaml
workflow:
  name: <workflow-name>
  timeout:
    exec_timeout: 15m

  resources:
    default:
      cpu: 1
      gpu: 1
      memory: 16Gi
      storage: 1Gi
      platform: ovx-l40       # Hardware class

    x86_gpu:
      cpu: 4
      gpu: 8
      memory: 64Gi
      platform: dgx-h100

  groups:
  - name: <group-name>        # Co-scheduled, inter-communicating tasks
    tasks: [...]

  tasks:
  - name: <task-id>
    image: <container-image>
    command: [<exe>]
    args: [<arg1>, <arg2>]
    platform: <hardware-target>
    resource: <resource-name>
    inputs:
    - task: <upstream-task>    # DAG edge
    - url: s3://bucket/path   # External data
    outputs:
    - url: s3://bucket/path
    - dataset:
        name: <dataset-name>
    files:
    - path: /tmp/run.sh
      contents: |
        echo "inline script"

default-values:
  experiment_name: my-experiment
```

### Template Tokens

- `{{workflow_id}}` — Unique execution ID
- `{{experiment_name}}` — Parameterized name
- `{{output}}` — Task's output directory path
- `{{input:0}}`, `{{input:1}}` — Indexed upstream task outputs
- `{{host:<task-name>}}` — Network hostname for peer task (groups)

### Jinja-Gated Composition

Physical AI skills use Jinja conditionals in OSMO workflows:

```yaml
{% if use_pretrained_checkpoint|string|lower not in ["true", "1", "yes"] %}
- name: finetune-job
  image: ...
{% endif %}
```

---

## DAG Execution Model

### Three Patterns

1. **Serial**: Tasks chain via `inputs: - task: <upstream>`
2. **Parallel**: Tasks without dependencies run simultaneously
3. **Groups**: Co-scheduled tasks with inter-task networking (`{{host:peer}}`)

### Data Passing

```yaml
- name: generate-data
  args: ["echo data > {{output}}/dataset.txt"]

- name: train-model
  inputs:
  - task: generate-data
  args: ["cat {{input:0}}/dataset.txt"]  # Receives upstream output
```

### Platform Targeting (The "Three Computer Problem")

```yaml
- name: train-policy
  platform: gb200           # Cloud training GPU

- name: simulate
  platform: ovx-l40         # Simulation GPU

- name: validate-edge
  platform: jetson-agx-thor # Edge device
  inputs:
  - task: train-policy      # Cross-cluster data flow
```

---

## Architecture

### Control Plane + Compute Backends

```text
┌─────────────────────────┐
│ OSMO Control Plane      │  API server, scheduler, Web UI, dataset store
│ (central)               │
└───────┬─────────────────┘
        │ outbound registration (firewall-friendly)
   ┌────┼────┬────────────┐
   ▼    ▼    ▼            ▼
┌──────┐┌──────┐┌──────┐┌──────┐
│ AKS  ││ EKS  ││On-prem││Jetson│  OSMO Operators on each cluster
│(train)││(sim) ││(DGX) ││(edge)│
└──────┘└──────┘└──────┘└──────┘
```

- **Operators**: Deployed on each K8s cluster, initiate outbound connections (no inbound access required)
- **Multi-cluster native**: Single workflow spans cloud, on-prem, and edge
- **Air-gapped support**: Disconnected environments with MQTT telemetry

### Storage

- **Content-addressable datasets**: Built-in versioning, deduplication (10-100x savings claimed), lineage tracking
- **Backends**: Any S3-compatible (AWS, MinIO, Ceph) or Azure Blob
- **Cluster-local caching**: Transparent caching for frequently used datasets; supports Lustre, NFS alongside object storage

### Credentials

- **OIDC authentication** (Keycloak as sample IdP)
- **Azure workload identity**: Automatic IAM integration, no manual credential config
- **Secrets injection**: `secrets` field in workflow spec (syntax not publicly detailed)

---

## CLI

| Command | Purpose |
|---|---|
| `osmo workflow submit <yaml> --pool <pool>` | Submit workflow |
| `osmo workflow port-forward <wf-id> <task> --port <range>` | Tunnel ports (Isaac Sim livestream, Jupyter) |
| `osmo workflow exec <wf-id> <task>` | Shell into running task |
| `osmo workflow rsync <wf-id> <task> <local> <remote>` | Sync files with running task |
| `osmo pool list` | List GPU pools |
| `osmo resource` | Inspect GPU availability |
| `osmo dataset` | Dataset management |
| `osmo credential` | Credential management |
| `osmo login <url>` | Authenticate |

---

## Interactive Sessions

Three mechanisms for remote development on cloud GPUs:

1. **Exec**: Shell into running containers
2. **Port-forward**: Tunnel for Isaac Sim livestream, Jupyter, VSCode Server
3. **Rsync**: Bidirectional file sync with running tasks

Cookbook examples: JupyterLab, VSCode, Ray clusters, W&B tracking, Isaac Sim livestreaming.

---

## Agent Integration

OSMO is an **"agentic orchestrator enabling prompt-driven physical AI development"**:

- **MCP skill**: `nvidia-osmo/osmo-osmo-agent` on MCP App Store
- **Supported agents**: Claude Code, OpenAI Codex, Cursor
- **Capabilities**: Discover GPU resources, submit/monitor workflows, fetch logs, publish workflows as apps
- **Security**: Agents operate within same RBAC/managed identity boundaries as manual workflows; all actions logged and auditable

---

## Comparison to Red Hat Alternatives

| Feature | OSMO | Tekton | Argo Workflows | KubeFlow Pipelines |
|---|---|---|---|---|
| Multi-cluster orchestration | Native | Single-cluster | Single-cluster | Single-cluster |
| Platform-aware GPU routing | `platform` field | Manual node selectors | Manual node selectors | Manual node selectors |
| Content-addressable datasets | Built-in | External artifacts | External artifacts | Via ML Metadata |
| Interactive workflow exec | `osmo workflow exec` | kubectl only | kubectl only | kubectl only |
| Agent MCP integration | MCP skill | None | None | None |
| Domain-specific abstractions | Physical AI focus | General CI/CD | General DAGs | ML focus |
| Firewall-friendly backends | Outbound-only registration | N/A | N/A | N/A |
| Air-gapped support | MQTT telemetry | Limited | Limited | Limited |

---

## Key Insights for Red Hat Platform

### 1. OSMO is Open Source (Apache 2.0) — Partner or Extend?

Three strategic options:

- **Integrate OSMO**: Offer as managed service on OpenShift, contribute upstream
- **Extend Tekton/Argo**: Add Physical AI capabilities (GPU routing, dataset CRDs, multi-cluster, MCP)
- **Hybrid**: KubeFlow for general ML, OSMO for Physical AI

### 2. The Infrastructure Abstraction is the Value

OSMO hides Kubernetes from robotics engineers. `platform: dgx-h100` is easier than node selectors + tolerations + affinity rules. Any Red Hat alternative needs this simplicity.

### 3. Multi-Cluster is Non-Negotiable

Physical AI workflows inherently span training clusters, simulation clusters, and edge devices. Single-cluster orchestrators (Tekton, Argo) cannot solve this without significant extension.

### 4. Content-Addressable Datasets are a Differentiator

Built-in dataset versioning with deduplication is valuable for Physical AI's massive data volumes. Neither Tekton nor Argo provide this.

### 5. Interactive Sessions Matter

Robotics developers need to exec into running simulations, forward ports for visualization, and sync code. This is a developer experience feature that workflow-only orchestrators miss.
