# Red Hat Physical AI Platform — Architecture Design

**Date**: 2026-06-18
**Purpose**: Architectural visuals for a "Red Hat Physical AI Platform" targeting product management and engineering audiences. Shows logical building blocks, deployment tiers, component mapping, and NVIDIA partner/conflict analysis.

---

## Design Goals

1. Show which logical functional building blocks each use case (robotics, digital twins, autonomous vehicles, etc.) requires, distinguishing shared vs unique blocks
2. Show where blocks deploy (central site, edge site, edge device)
3. Show which OSS/proprietary components implement each function
4. Derive build-vs-partner decisions and identify integration opportunities
5. Map NVIDIA AI Enterprise components to identify complements and conflicts

## Decomposition Principles

1. **Sourceable component level**: Decompose until blocks map to software components that can be sourced (built, partnered, or integrated), but no further
2. **OSS project boundaries**: Use existing open-source project boundaries as natural units
3. **NVIDIA as reference architecture**: NVIDIA's Physical AI stack is the most complete reference — use it to validate completeness
4. **Red Hat existing choices as anchors**: vLLM, KServe, Tekton, KubeFlow, etc. are decided — extend rather than replace
5. **Pick winners**: Where multiple options exist, name the primary candidate rather than listing all alternatives

## Architecture Structure

### Three Tiers × Four Layers

The architecture uses three deployment tiers, each with up to four functional layers:

| Tier | Infrastructure | Managed By | Layers Present |
| --- | --- | --- | --- |
| **Tier 1: Central Site** | OpenShift | ACM | Training & Eval, MLOps, Inference, Platform Mgmt, Platform |
| **Tier 2: Edge Site** | OpenShift on GPU servers | ACM | Inference, Platform |
| **Tier 3: Edge Device** | RHEL | RHEM/FlightCtl | Inference, Platform |

### Side-by-Side Domains

Each layer shows **Language/Agentic AI** (existing) alongside **Physical AI** (new/extended), using markers:

- `[EXT]` — existing component needs extension
- `[NEW]` — new component required
- `[GAP]` — no OSS solution exists

---

## Tier 1: Central Site

```text
═══════════════════════════════════════════════════════════════════════════
  TRAINING & EVALUATION
═══════════════════════════════════════════════════════════════════════════

         Language / Agentic             │  Physical AI
        ────────────────────────────────┼──────────────────────────────────
Train   │ LLM Fine-Tuning               │[NEW] Robot Policy Training       │
Work-   │ (SFT, RLHF, DPO               │ (Imitation Learning, RL,         │
loads   │  via example AI pipelines)    │  Sim-to-Real Transfer)           │
        ├───────────────────────────────┼──────────────────────────────────┤
        │                               │[NEW] Simulation Engines          │
        │                               │ (Genesis World, Isaac Lab,       │
        │                               │  MuJoCo MJX — in-process on GPU) │
        ├───────────────────────────────┼──────────────────────────────────┤
Eval    │ LLM Eval & Benchmarks         │[NEW] Policy Eval & Benchmarks    │
        │ (lm-eval-harness)             │ (LeRobot eval harness,           │
        │                               │  RoboVerse, RoboArena)           │
        ├───────────────────────────────┼──────────────────────────────────┤
Data    │ Data Curation                 │[NEW] Physical AI Data            │
        │ (Docling, example AI          │ (Open X-Embodiment, LeRobot      │
        │  pipelines)                   │  datasets, Cosmos-Curator)       │
        ├───────────────────────────────┴──────────────────────────────────┤
Train   │ Training Frameworks — unchanged for Physical AI                  │
Infra   │ (KubeFlow Trainer v2 / KFTO, DeepSpeed, PyTorch, Ray/KubeRay)    │
        │ Sim engines run in-process as training workloads on KFTO         │

═══════════════════════════════════════════════════════════════════════════
  AI MODEL & DATA LIFECYCLE (MLOps)
═══════════════════════════════════════════════════════════════════════════

        │ Model Registry (KubeFlow Model Registry)                         │
        │ [EXT] Policy versioning, multi-embodiment metadata               │
        ├──────────────────────────────────────────────────────────────────┤
        │ ML Pipelines (KubeFlow Pipelines, Argo Workflows)                │
        │ [EXT] Sim-eval gating, canary rollout to real robots             │
        │ [GAP] Multi-stage pipeline orchestration (OSMO-like — no OSS)    │
        ├──────────────────────────────────────────────────────────────────┤
        │ CI/CD (Tekton) + GitOps (ArgoCD)                                 │
        │ [EXT] Policy promotion pipeline (sim → eval → canary → prod)     │
        ├──────────────────────────────────────────────────────────────────┤
        │ Experiment Tracking (MLflow — Tech Preview in RHOAI 3.4)         │
        │ [EXT] Sim reward curves, sim-fidelity metrics                    │
        ├──────────────────────────────────────────────────────────────────┤
        │ Observability: Prometheus, OTel, Grafana                         │
        │ [NEW] Robot fleet telemetry (Foxglove, MCAP format)              │
        │ [EXT] Physical safety dashboards, TrustyAI for policy fairness   │

═══════════════════════════════════════════════════════════════════════════
  INFERENCE
═══════════════════════════════════════════════════════════════════════════

         Language / Agentic              │  Physical AI
        ─────────────────────────────────┼─────────────────────────────────
MaaS    │ Model as a Service                                               │
        │ • Consume external: NIM, OpenAI, partner model APIs              │
        │ • Expose internal: managed model endpoints (KServe API)          │
        ├────────────────────────────────┬─────────────────────────────────┤
Agentic │ Agentic AI                     │[NEW] Physical AI Agents         │
Frmwk   │ Kagenti (K8s-native agent      │ • Embodied agent identity       │
        │  lifecycle, A2A protocol,      │ • Physical safety guardrails    │
        │  MCP Gateway, AuthBridge)      │ • Real-time constraints         │
        │ OpenShell (agent sandboxing)   │ • Sim-based agent evals         │
        │ Guardrails, content filters    │ • Multi-agent coordination      │
        ├────────────────────────────────┴─────────────────────────────────┤
Model   │                                                                  │
Serving │  KServe (routing, autoscaling, multi-model serving)              │
        │                                                                  │
        │  ┌──────────────────────────┬────────────────────────────────┐   │
        │  │ vLLM / vLLM-Omni         │                                │   │
        │  │                          │                                │   │
        │  │ Language:                │ [EXT] Physical AI:             │   │
        │  │ • Autoregressive LLMs    │ • Diffusion transformers       │   │
        │  │ • Multi-modal (text,     │ • Action modality output       │   │
        │  │   audio, video, image)   │ • Multi-cam, LiDAR, IMU input  │   │
        │  │                          │ • Planner/world model integ.   │   │
        │  │                          │ • High-throughput batch eval   │   │
        │  └──────────────────────────┴────────────────────────────────┘   │
        │  ┌───────────────────────────────────────────────────────────┐   │
        │  │ llm-d (distributed inference, KV-cache-aware routing)     │   │
        │  │ [EXT] + long-running session support                      │   │
        │  │ [EXT] + session-aware load balancing                      │   │
        │  └───────────────────────────────────────────────────────────┘   │

═══════════════════════════════════════════════════════════════════════════
  PLATFORM MANAGEMENT (Tier 1 only)
═══════════════════════════════════════════════════════════════════════════

        │ Fleet: ACM (clusters) + RHEM/FlightCtl (devices) + Ansible       │

═══════════════════════════════════════════════════════════════════════════
  PLATFORM
═══════════════════════════════════════════════════════════════════════════

Libs    │ Math libs (CUDA, ROCm, oneAPI, NCCL)                             │
        │ [EXT] Media libs (FFmpeg, GStreamer)                             │
        ├──────────────────────────────────────────────────────────────────┤
Runtime │ OpenShift                                                        │
        ├──────────────────────────────────────────────────────────────────┤
Drivers │ GPU/TPU drivers, NFD, GPU Operator                               │
        ├──────────────────────────────────────────────────────────────────┤
OS      │ RHEL                                                             │
        └──────────────────────────────────────────────────────────────────┘
```

## Tier 2: Edge Site (Near-Edge Inference)

Factory floor / cell tower. Same platform stack as Tier 1, inference-only. Optimized for low-latency serving close to devices.

```text
═══════════════════════════════════════════════════════════════════════════
  INFERENCE
═══════════════════════════════════════════════════════════════════════════

         Language / Agentic              │  Physical AI
        ─────────────────────────────────┼─────────────────────────────────
MaaS    │ Model as a Service                                               │
        │ • Consume external: NIM, OpenAI, partner model APIs              │
        │ • Expose internal: managed model endpoints (KServe API)          │
        ├────────────────────────────────┬─────────────────────────────────┤
Agentic │ Agentic AI                     │[NEW] Physical AI Agents         │
Frmwk   │ Kagenti (local agent lifecycle,│ (scene understanding, anomaly   │
        │  OpenShell sandboxing)         │  detection, fleet coordination) │
        ├────────────────────────────────┴─────────────────────────────────┤
Model   │                                                                  │
Serving │  KServe (routing, autoscaling, multi-model serving)              │
        │                                                                  │
        │  ┌──────────────────────────┬────────────────────────────────┐   │
        │  │ vLLM / vLLM-Omni         │                                │   │
        │  │                          │                                │   │
        │  │ Language:                │ [EXT] Physical AI:             │   │
        │  │ • Autoregressive LLMs    │ • Diffusion transformers       │   │
        │  │ • Multi-modal (text,     │ • Action modality output       │   │
        │  │   audio, video, image)   │ • Multi-cam, LiDAR, IMU input  │   │
        │  │                          │ • Planner/world model integ.   │   │
        │  │                          │ • Low-latency video streaming  │   │
        │  │                          │   input (GStreamer/FFmpeg)     │   │
        │  │                          │ • Real-time inference output   │   │
        │  │                          │ • Long-running sessions        │   │
        │  └──────────────────────────┴────────────────────────────────┘   │
        │  ┌───────────────────────────────────────────────────────────┐   │
        │  │ llm-d (distributed inference, KV-cache-aware routing)     │   │
        │  │ [EXT] + long-running session support                      │   │
        │  │ [EXT] + session-aware load balancing                      │   │
        │  └───────────────────────────────────────────────────────────┘   │

═══════════════════════════════════════════════════════════════════════════
  PLATFORM                                          (identical to Tier 1)
═══════════════════════════════════════════════════════════════════════════

Libs    │ Math libs (CUDA, ROCm, oneAPI, NCCL)                             │
        │ [EXT] Media libs (FFmpeg, GStreamer)                             │
        ├──────────────────────────────────────────────────────────────────┤
Runtime │ OpenShift                                                        │
        ├──────────────────────────────────────────────────────────────────┤
Drivers │ GPU/TPU drivers, NFD, GPU Operator                               │
        ├──────────────────────────────────────────────────────────────────┤
OS      │ RHEL                                                             │
        └──────────────────────────────────────────────────────────────────┘
```

**Tier 1 vs Tier 2 serving profile**: Tier 1 optimizes for high-throughput batch evaluation (world model planning, sim-based eval, many concurrent sessions). Tier 2 optimizes for low-latency streaming and real-time inference (close to robots, latency-sensitive control).

## Tier 3: Edge Device (Robot / Drone / Vehicle)

On-device. Fast control loop — sensor in, action out. Offloads heavy inference to edge site.

```text
═══════════════════════════════════════════════════════════════════════════
  INFERENCE
═══════════════════════════════════════════════════════════════════════════

         Language / Agentic              │  Physical AI
        ─────────────────────────────────┼──────────────────────────────────
Agentic │ Local agents (Kagenti agent    │[NEW] Embodied agents            │
Frmwk   │  runtime, OpenShell sandbox)   │ (on-device planning,            │
        │                                │  human-robot interaction)       │
        ├────────────────────────────────┴─────────────────────────────────┤
Model   │ Inference Server                                                 │
Serving │ • vLLM-Omni (if HW allows — Jetson Thor class)                   │
        │ • OR lightweight: ONNX Runtime, llama.cpp, ExecuTorch            │
        │ [NEW] + RT latency (<50ms), stateful control sessions            │
        │ [NEW] + streaming sensor input (multi-cam, LiDAR, IMU)           │
        │ [NEW] + offload path to edge site for heavy models               │

═══════════════════════════════════════════════════════════════════════════
  PLATFORM
═══════════════════════════════════════════════════════════════════════════

        ┌──────────────────┬──────────────┬─────────────────────────────────┐
Libs    │ Math libs        │[EXT] Media   │[NEW] Robotics libs              │
        │ (CUDA, ROCm)     │ libs (FFmpeg,│ (ROS2, MoveIt, Nav2,            │
        │                  │  GStreamer)  │   ros2_control, sensor drivers) │
        ├──────────────────┴──────────────┴─────────────────────────────────┤
Runtime │ Podman                          │ MicroShift (optional)           │
        ├─────────┬───────────────────────┬─────────────────────────────────┤
Drivers │AI accel.│ Vision accel.         │ Crypto, Network, etc.           │
        │(GPU,    │ (VIC, NVDEC,          │ accelerators                    │
        │ TPU)    │  ISP)                 │                                 │
        ├─────────┴───────────────────────┴─────────────────────────────────┤
OS      │ RHEL (with PREEMPT_RT for real-time control loops)                │
        └───────────────────────────────────────────────────────────────────┘
```

---

## Component Map

Reference table mapping every block to specific sourceable components.

| Block | Existing (Language AI) | New / Extended (Physical AI) | Status |
| --- | --- | --- | --- |
| Training Workloads | SFT, RLHF, DPO pipelines | Imitation Learning, RL, Sim-to-Real Transfer | [NEW] |
| Simulation Engines | — | Genesis World (Apache 2.0, 29K★, multi-backend), Isaac Lab (NVIDIA), MuJoCo MJX (Apache 2.0) | [NEW] |
| Policy Eval | lm-eval-harness | LeRobot eval harness (Apache 2.0), RoboVerse (Early OSS), RoboArena (real-world) | [NEW] |
| Data Curation | Docling | Open X-Embodiment (970K demos), LeRobot datasets, Cosmos-Curator | [NEW] |
| Training Infra | KFTO / KubeFlow Trainer v2, DeepSpeed, PyTorch, Ray/KubeRay — unchanged | (same) | Existing |
| Model Registry | KubeFlow Model Registry | [EXT] Policy versioning, multi-embodiment metadata | [EXT] |
| ML Pipelines | KubeFlow Pipelines, Argo Workflows | [EXT] Sim-eval gating. [GAP] OSMO-like orchestrator (proprietary) | [EXT]+[GAP] |
| CI/CD + GitOps | Tekton, ArgoCD | [EXT] Policy promotion pipeline | [EXT] |
| Experiment Tracking | MLflow (TP in RHOAI 3.4) | [EXT] Sim reward curves, sim-fidelity metrics | [EXT] |
| Observability | Prometheus, OTel, Grafana | [NEW] Foxglove + MCAP (robot fleet telemetry). [EXT] TrustyAI | [NEW]+[EXT] |
| MaaS | KServe API (expose) + NIM, OpenAI (consume) | (same) | Existing |
| Agentic Framework | Kagenti (K8s-native agent lifecycle, A2A/MCP, AuthBridge zero-trust), OpenShell (agent sandboxing) | [EXT] Embodied agent identity, physical safety guardrails, sim-based evals, Physical AI skills | [EXT] |
| Models & Policies | LLMs, VLMs (via vLLM) | [NEW] VLAs, world models, robot policies, digital twin models (via vLLM-Omni) | [NEW] |
| Inference Server | vLLM (autoregressive, multi-modal) | [EXT] vLLM-Omni (diffusion, action I/O, multi-sensor — RFC #1987) | [EXT] |
| Distributed Inference | llm-d (KV-cache routing) | [EXT] Long-running sessions, session-aware load balancing | [EXT] |
| Edge Inference | vLLM-Omni, llama.cpp | [NEW] RT latency, stateful sessions, sensor streaming, offload | [NEW] |
| Robotics Libs | — | [NEW] ROS2, MoveIt, Nav2, ros2_control | [NEW] |
| Media Libs | — | [EXT] GStreamer (RTSP, V4L2, WebRTC), FFmpeg | [EXT] |
| Fleet Mgmt | ACM, Ansible | [EXT] RHEM/FlightCtl for device fleets | [EXT] |

---

## NVIDIA AI Enterprise Mapping

Full component-level mapping between NVAIE and Red Hat Physical AI Platform is recorded in [ecosystem.md — NVIDIA AI Enterprise section](../../research/ecosystem.md#nvidia-ai-enterprise-nvaie-platform-mapping).

### Summary

**Hard conflicts (choose one)**:

- **vLLM vs NIM** — both serve models on GPUs. Red Hat backs vLLM (OSS, portable); NVIDIA backs NIM (proprietary, faster on NVIDIA HW). Compromise: KServe routes to either as backend.
- **Kueue vs Run:ai** — both do GPU scheduling. KAI Scheduler (OSS core of Run:ai) is a middle ground.

**Managed tensions**:

- NIM Operator vs KServe (converging — NIM Op 3.0 adds KServe interop)
- NeMo Customizer vs KFTO (parallel training paths)
- NeMo Guardrails vs TrustyAI (content safety vs fairness — complementary)
- NemoClaw vs Kagenti+OpenShell (NVIDIA's agent sandboxing vs Red Hat's K8s-native agent governance — both use OpenShell for sandboxing; Kagenti adds zero-trust identity and lifecycle management)

**Clean complements (partner opportunity)**:

- GPU Operator + drivers (NVIDIA provides, Red Hat ships)
- Simulation engines + models (workloads/content on Red Hat platform)
- OSMO (fills pipeline orchestration [GAP])
- Isaac ROS (CUDA-accelerated ROS2 perception on enterprise ROS2)
- DCGM → Prometheus (GPU metrics)
- Jetson/IGX HW running RHEL

**Design principle**: Show NVIDIA where it complements Red Hat (sim engines, models, OSMO, Isaac ROS, DCGM). Be explicit that the platform uses its own inference/training/scheduling stack. Position NIM as a MaaS consumption option, not a replacement for vLLM.

### OSS Coverage Validation

Every block has at least one OSS option. Two industry-wide gaps remain:

1. **OSMO-like pipeline orchestration** — no OSS multi-stage sim→train→eval→deploy orchestrator. Approximated by KubeFlow Pipelines + Argo Workflows + custom gating.
2. **Agentic frameworks** — Kagenti (Red Hat-backed, Apache 2.0) provides K8s-native agent lifecycle, A2A/MCP networking, and zero-trust security. OpenShell provides agent sandboxing. Together they address the language/agentic side; Physical AI-specific agent extensions (embodied identity, physical safety guardrails) remain to be built on top.

Note: Isaac Lab (Apache 2.0) depends on Isaac Sim (proprietary). Truly open simulation path is Genesis World (Apache 2.0, multi-backend) or MuJoCo MJX (Apache 2.0).

---

## Key Design Decisions

1. **Training infra unchanged**: Simulation engines run in-process on single GPU as training workloads on KFTO/Kueue. No new platform infrastructure needed.
2. **MLOps is the differentiator**: The AI Model & Data Lifecycle layer is where Red Hat adds unique Physical AI value — model registry with policy versioning, sim-eval gating, canary rollout to real robots.
3. **vLLM-Omni as unified serving layer**: Extends vLLM to diffusion transformers, action modality, multi-sensor input. Potentially unifies serving across datacenter and edge.
4. **Tier 1 = throughput, Tier 2 = latency**: Central site optimizes for batch evaluation; edge site optimizes for streaming input and real-time output.
5. **Platform layers identical across Tier 1 and Tier 2**: OS, Drivers, Runtime, Libs are the same. Infrastructure management factored into Tier 1-only section.
6. **RHEM/FlightCtl for edge devices**: Manages RHEL-based robots/drones with Podman (lightweight) or MicroShift (optional K8s API).
7. **Genesis World as hardware-portable sim pick**: Compiles to CUDA, ROCm, Metal, Vulkan, CPU. Key differentiator vs NVIDIA-locked Isaac Sim.
8. **LeRobot as emerging open standard**: Training, serving (PolicyServer gRPC), and evaluation in one framework. 23K stars, HuggingFace-backed.
9. **Kagenti + OpenShell as agentic foundation**: Kagenti provides K8s-native agent lifecycle management (A2A protocol, MCP Gateway, AuthBridge zero-trust identity via SPIFFE/SPIRE). OpenShell provides agent sandboxing. Both Red Hat-backed, Apache 2.0. Extends from language/agentic agents to Physical AI agents with embodied identity and physical safety guardrails.
