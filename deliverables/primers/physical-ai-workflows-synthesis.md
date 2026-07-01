# Physical AI Data Pipelines & Workflows — Synthesis

**Date**: 2026-06-25
**Status**: Draft for discussion
**Based on**: Deep research of NVIDIA's [skills catalog](../references/nvidia-skills-analysis.md) (224 skills, [deep read](../references/nvidia-skills-deepread.md)), [use-case documentation](../references/nvidia-usecases-survey.md), [Metropolis/VSS architecture](../references/nvidia-metropolis-vss.md), [OSMO orchestrator](../references/nvidia-osmo.md), and [FOX Blueprint](../references/nvidia-fox-blueprint.md).

---

## Part 1: Canonical Workflow Patterns

### 1.1 The Four-Layer Pipeline

Every Physical AI workflow we analyzed — across robotics, video analytics, industrial inspection, autonomous vehicles, and digital twins — decomposes into four layers. The layers always appear in this order, though not every use case instantiates every stage within each layer.

```text
┌─────────────────────────────────────────────────────────────────────┐
│  DATA LAYER                                                         │
│  Ingest → Curate → Augment → Label                                  │
│  Raw data in, training-ready datasets out                           │
├─────────────────────────────────────────────────────────────────────┤
│  MODEL LAYER                                                        │
│  Select → Fine-Tune → Optimize → Evaluate [→ Gate]                  │
│  Foundation model in, deployment-ready model out                    │
├─────────────────────────────────────────────────────────────────────┤
│  SERVING LAYER                                                      │
│  Deploy → Infer (batch | streaming) → Post-Process → Deliver        │
│  Model + data in, predictions/actions out                           │
├─────────────────────────────────────────────────────────────────────┤
│  OPERATIONS LAYER                                                   │
│  Orchestrate → Monitor → Detect Drift → Trigger Improvement         │
│  Continuous loop feeding back into Data and Model layers            │
└─────────────────────────────────────────────────────────────────────┘
```

Each layer has distinct compute characteristics:

| Layer | Compute Profile | Latency Tolerance | Data Volume |
| --- | --- | --- | --- |
| Data | Batch, GPU-heavy (rendering, generation) | Hours–days | TB-scale (video, synthetic imagery) |
| Model | Batch, GPU-heavy (training, RL) | Hours–days | GB-scale (curated datasets, checkpoints) |
| Serving | Dual-mode: batch (throughput) + streaming (latency) | ms–seconds (streaming), minutes (batch) | Continuous streams or batch archives |
| Operations | Event-driven, lightweight compute + occasional GPU | Seconds–minutes (detection), hours (retraining trigger) | Metrics, logs, alert metadata |

### 1.2 Five Canonical Workflows

From NVIDIA's documentation, we identified five distinct workflow families. Each instantiates the four-layer pipeline differently.

#### Workflow 1: Robotics Policy Training

**Customer problem**: "I have a robot (or fleet) and need it to perform manipulation/navigation tasks reliably in my specific environment."

```text
DATA LAYER
  ├── Environment Reconstruction ── Scan real environment → NuRec (NeRF/3DGS) → USDZ scene
  ├── Asset Preparation ─────────── CAD models → USD conversion → SimReady conformance
  ├── Synthetic Data Generation ─── Isaac Sim → MobilityGen (nav) or manipulation scenarios
  ├── Data Augmentation ─────────── Cosmos Transfer adds visual diversity (lighting, weather)
  └── [Optional] Teleoperation ──── Human demonstrations via VR → training data

MODEL LAYER
  ├── Foundation Model Selection ── GR00T N1.7 (VLA), or pi0, or LeRobot policy
  ├── Fine-Tuning ───────────────── Isaac Lab (RL), imitation learning from demos
  ├── Sim-to-Real Transfer ──────── Domain randomization, Cosmos-augmented sim data
  └── Evaluation Gate ───────────── Success rate on benchmark tasks, sim-to-real gap metrics

SERVING LAYER
  ├── On-Robot Inference ────────── Jetson (Thor/Orin) + Isaac ROS, <50ms control loop
  └── Cloud Policy Serving ──────── vLLM/KServe for world model rollouts during training

OPERATIONS LAYER
  ├── Fleet Telemetry ───────────── Robot performance metrics, failure cases
  ├── Data Collection ───────────── In-operation video/sensor data feeds back to Data Layer
  └── Continuous Improvement ────── Detect task failures → collect new demos → retrain
```

**Key characteristics**: Simulation-heavy data layer; RL-based training; hard real-time inference at edge; closed-loop improvement from operational data.

**NVIDIA components**: Isaac Sim, Isaac Lab, Isaac ROS, Omniverse (NuRec, SimReady), Cosmos Transfer, GR00T, OSMO, Jetson.

#### Workflow 2: Video Analytics (Real-Time)

**Customer problem**: "I have camera feeds and need to detect events, track objects, and alert operators in real time."

```text
DATA LAYER
  ├── Video Ingest ──────────────── RTSP streams from cameras/NVRs → VIOS (stream mgmt)
  ├── [Optional] Synthetic Data ─── Cosmos AnomalyGen for rare event training data
  └── [Optional] Auto-Labeling ──── VLM (Qwen3-VL) labels video frames for fine-tuning

MODEL LAYER
  ├── Detection Model ───────────── RT-DETR, Grounding DINO, or custom detector
  ├── Domain Adaptation ─────────── SSL on unlabeled domain images (NV-DINOv2/C-RADIO)
  ├── Supervised Fine-Tuning ────── Annotated domain data → task-specific detector
  ├── Knowledge Distillation ────── Compress for edge (81% size reduction, 5% accuracy gain)
  └── Evaluation Gate ───────────── Detection rate ≥90% on KITTI-format validation

SERVING LAYER (Three Tiers — the [Metropolis pattern](../references/nvidia-metropolis-vss.md))
  ├── Tier 1: RT Feature Extraction
  │   ├── RT-CV ─────────────────── GStreamer + TensorRT: detection, tracking, batched across streams
  │   ├── RT-Embedding ──────────── Cosmos-Embed: semantic vectors for search
  │   └── RT-VLM ────────────────── Cosmos Reason / Qwen3-VL: captions, incident detection
  ├── Tier 2: Analytics Enrichment
  │   ├── Behavior Analytics ────── Trajectories, tripwire, ROI, proximity, dwell time
  │   └── Alert Verification ────── VLM confirms/rejects alerts with reasoning trace
  └── Tier 3: Agent & Offline
      ├── Semantic Search ───────── Embedding-based retrieval over video archives
      ├── Summarization ─────────── Chunked caption aggregation (100x faster than watching)
      └── Report Generation ─────── Agent synthesizes multi-source video data

OPERATIONS LAYER
  ├── Message Broker ────────────── Kafka/Redis with 15+ structured topics (mdx-*)
  ├── Metadata Store ────────────── Elasticsearch for indexed detections, alerts, incidents
  ├── Monitoring ────────────────── Stream health, inference throughput, GPU utilization
  └── Model Refresh ─────────────── Detect accuracy drift → trigger retraining pipeline
```

**Key characteristics**: Streaming-first serving layer with batch search/summarization; three-tier decomposition (extraction → enrichment → reasoning); message broker as integration backbone; dual-mode processing is architectural, not just a feature.

**NVIDIA components**: DeepStream SDK 9 (GStreamer), [Metropolis VSS Blueprint](../references/nvidia-metropolis-vss.md), NIM microservices, Cosmos Embed/Reason, Kafka, Elasticsearch, MCP agent.

#### Workflow 3: Video/Image Data Processing (Batch)

**Customer problem**: "I have recorded video or images and need to generate training datasets — curated, augmented, and labeled."

```text
DATA LAYER
  ├── Source Ingestion ──────────── Recorded video, captured images, or CAD renders
  ├── Curation ──────────────────── Cosmos Curator: filter, deduplicate, quality-score
  ├── Augmentation ──────────────── Cosmos Transfer: lighting, weather, viewpoint variations
  │                                 or Cosmos AnomalyGen: synthetic defect generation
  ├── Super-Resolution ──────────── [Optional] SeedVR upscaling for augmented video
  └── Auto-Labeling ─────────────── VLM (Qwen3-VL) vision + LLM (Qwen2.5) text → bbox JSON

MODEL LAYER
  ├── [Downstream] ──────────────── Labeled dataset feeds into Workflow 1, 2, or 4
  └── [Optional] Fine-Tune ──────── Cosmos AnomalyGen fine-tune for domain-specific defects

SERVING LAYER
  └── Batch Processing ──────────── GPU-intensive, throughput-optimized, no latency constraint

OPERATIONS LAYER
  ├── Pipeline Orchestration ────── OSMO DAGs with Jinja-gated composition
  ├── Model Cache Management ────── Auto-remediation (detect cache failure → re-download)
  ├── Quality Validation ────────── Cosmos Evaluator scores physical accuracy
  └── Artifact Management ──────── Content-addressable datasets with versioning
```

**Key characteristics**: Pure batch processing; feeds into other workflows; the "Data Factory" pattern (Curate → Augment → Evaluate); model cache management is operationally significant (cold start 45-80min vs warm start 20-45min).

**NVIDIA components**: Cosmos Curator, Cosmos Transfer, Cosmos AnomalyGen, Cosmos Evaluator, Qwen3-VL, Qwen2.5-14B, OSMO.

#### Workflow 4: Industrial Inspection / Defect Detection

**Customer problem**: "I need to detect defects on my production line with high accuracy and deploy to factory-floor edge devices."

```text
DATA LAYER (Day 0: synthetic bootstrap)
  ├── CAD → USD Render ──────────── IsaacSim Kit renders CAD model → per-cell ROI crops
  ├── Style Transfer ────────────── Qwen Image-Edit NIM: synthetic → realistic appearance
  ├── Defect Generation ─────────── Cosmos AnomalyGen: inject defects (texture + structural)
  └── [Day 2] Real Photo Ingest ── Production line cameras → MI registration → inference

MODEL LAYER
  ├── Domain Adaptation ─────────── SSL on ~700K unlabeled domain images (NV-DINOv2)
  ├── Supervised Fine-Tuning ────── ~600 annotated samples → RT-DETR detector
  ├── Knowledge Distillation ────── Teacher → student (81% smaller, 5% more accurate)
  ├── [Optional] AnomalyGen FT ─── Fine-tune defect generator for domain-specific defects
  └── Evaluation Gate ───────────── 98.5% accuracy on PCB classification benchmark

SERVING LAYER
  ├── Edge Deployment ───────────── DeepStream Inference Builder → containerized microservice
  │                                 (config.yaml + Dockerfile → .tgz package → Docker Compose)
  └── Factory Floor ─────────────── Jetson / RTX PRO servers, REST API endpoints

OPERATIONS LAYER ([FOX Blueprint](../references/nvidia-fox-blueprint.md) pattern)
  ├── Factory Manager Agent ─────── Orchestrates specialized inspection/compliance agents
  ├── Accuracy Monitoring ───────── Detect model degradation from production quality metrics
  ├── Automated Retraining ──────── Agent triggers TAO skills → fine-tune → redeploy
  └── Synthetic Data Loop ───────── Generate new defect examples for long-tail scenarios
```

**Key characteristics**: Day 0/Day 2 split is sharpest here — Day 0 is entirely synthetic (CAD-based), Day 2 uses real production data; the FOX Blueprint's agentic continuous improvement loop is the Day 2 differentiator; edge deployment via DeepStream Inference Builder is a one-command packaging step.

**NVIDIA components**: Isaac Sim Kit, Cosmos AnomalyGen, Qwen Image-Edit NIM, TAO Toolkit, DeepStream 8, NV-DINOv2, C-RADIO, [FOX Blueprint](../references/nvidia-fox-blueprint.md), NemoClaw.

#### Workflow 5: Autonomous Vehicles

**Customer problem**: "I need to train, validate, and deploy autonomous driving systems with safety certification."

```text
DATA LAYER
  ├── Sensor Recording ──────────── Multi-camera, LiDAR, radar → NCore V4 format
  ├── Scene Reconstruction ──────── NuRec: recordings → 3DGS USDZ scenes
  ├── Scenario Generation ───────── Omniverse + Cosmos: weather, traffic, pedestrian variations
  └── Object Manipulation ──────── Asset Harvester: add/remove/replace objects in scenes

MODEL LAYER
  ├── Perception Models ─────────── BEVFusion, Sparse4D (3D multi-camera detection)
  ├── World Model ───────────────── Cosmos 3 Super: physics-accurate future prediction
  ├── Reasoning Model ───────────── Alpamayo: VLA for Level 4 long-tail decisions
  └── Evaluation Gate ───────────── Scenario-based safety validation (billions of miles equivalent)

SERVING LAYER
  ├── In-Vehicle ────────────────── DRIVE AGX Orin, real-time sensor fusion, <100ms
  └── Cloud Simulation ──────────── OVX systems for continuous scenario testing

OPERATIONS LAYER
  ├── Safety Framework ──────────── NVIDIA Halos: end-to-end safety from cloud to car
  ├── Regulatory Compliance ─────── ISO 26262, UNECE WP.29, SAE J3016
  └── Fleet Data Collection ─────── Real-world driving data → retrain scenarios
```

**Key characteristics**: Safety/regulatory requirements dominate; multi-sensor fusion (camera + LiDAR + radar) unlike single-modality robotics or video analytics; the scene reconstruction → scenario generation pipeline is unique to AV and partially shared with robotics.

**NVIDIA components**: NuRec, Omniverse, Cosmos 3, Alpamayo, DRIVE AGX Orin, Halos, Asset Harvester.

### 1.3 Cross-Workflow Analysis: What's Shared

Mapping which pipeline stages appear across the five workflows:

| Pipeline Stage | Robotics | Video Analytics (RT) | Video/Image (Batch) | Inspection | AV |
| --- | :---: | :---: | :---: | :---: | :---: |
| **DATA LAYER** | | | | | |
| Video/sensor ingest | ● | ● | ● | ● | ● |
| Data curation | ● | ○ | ● | ○ | ● |
| Synthetic data generation | ● | ○ | ● | ● | ● |
| Data augmentation (Cosmos Transfer) | ● | ○ | ● | ● | ● |
| Auto-labeling (VLM) | ○ | ○ | ● | ○ | ○ |
| Scene reconstruction (NuRec) | ● | | | | ● |
| CAD → SimReady asset prep | ● | | | ● | |
| **MODEL LAYER** | | | | | |
| Foundation model selection | ● | ● | | ● | ● |
| Domain adaptation (SSL) | ○ | ● | | ● | ○ |
| Supervised fine-tuning | ● | ● | ○ | ● | ● |
| RL / policy training | ● | | | | ○ |
| Knowledge distillation | | ● | | ● | |
| Evaluation gate | ● | ● | ● | ● | ● |
| **SERVING LAYER** | | | | | |
| Streaming inference (<100ms) | ● | ● | | ● | ● |
| Batch inference | ○ | ● | ● | | ● |
| Edge deployment (Jetson) | ● | ● | | ● | ● |
| GStreamer video pipeline | | ● | ○ | ● | |
| VLM-based reasoning | ○ | ● | ● | ○ | ● |
| **OPERATIONS LAYER** | | | | | |
| Workflow orchestration (DAGs) | ● | ● | ● | ● | ● |
| Model performance monitoring | ● | ● | | ● | ● |
| Automated retraining trigger | ○ | ○ | | ● | ● |
| Agentic operations (FOX-style) | ○ | ○ | | ● | |

● = core to this workflow, ○ = optional/partial

**Highest-value shared stages** (appear in ≥4 workflows):

1. Video/sensor ingest
2. Synthetic data generation / augmentation
3. Foundation model fine-tuning
4. Evaluation gates
5. Streaming inference at edge
6. Workflow orchestration (DAGs)
7. Model performance monitoring

### 1.4 Cross-Workflow Analysis: Two Processing Modes

A fundamental architectural pattern emerged: every workflow that involves video/sensor data needs **both** batch and streaming processing, but for different stages.

| Mode | Where It Appears | Characteristics |
| --- | --- | --- |
| **Batch / Throughput-Optimized** | Data curation, augmentation, synthetic generation, auto-labeling, model training, video archive search, report generation | GPU-heavy, hours to days, TB-scale, fault-tolerant (restart on failure) |
| **Streaming / Latency-Optimized** | Live video analytics, robot control loops, AV perception, real-time alerts, edge inference | GPU-efficient, ms latency, continuous, must not drop frames |

This dual-mode requirement is not a feature — it's an architectural constraint. The [Metropolis/VSS architecture](../references/nvidia-metropolis-vss.md) handles it with separate microservices (RT-CV for streaming, Video Summarization for batch). DeepStream handles it with GStreamer pipeline topology (live sources vs. file sources with different muxer configs).

**A platform must support both modes** and allow workflows to compose them. For example, a defect detection workflow uses batch mode for training data generation (Day 0) and streaming mode for production inference (Day 1+), with the operations layer bridging them (detect drift in streaming → trigger batch retraining).

### 1.5 Lifecycle: Day 0/1/2 and the Data Maturity Dimension

#### Terminology: Two "Day" Definitions in Conflict

NVIDIA's Physical AI documentation uses "Day 0" and "Day 1" to describe **data availability stages**:

- **NVIDIA Day 0 (Cold Start)**: No real-world data exists. The entire pipeline runs on synthetic data — CAD renders, simulated environments, generated defect images. This is the bootstrapping phase.
- **NVIDIA Day 1 (Warm Start)**: Real operational data is available. Models can be fine-tuned or validated against actual production inputs. The pipeline shifts from synthetic-only to mixed or real data.

This conflicts with the widely accepted software engineering lifecycle definition:

- **Day 0 (Design/Build)**: Design the system, develop and test it, prepare for deployment.
- **Day 1 (Deploy)**: Ship to production — package, deploy, configure, validate.
- **Day 2 (Operate)**: Run in production — monitor, maintain, update, scale.

Both definitions are useful but for different purposes. This primer adopts the **standard Day 0/1/2 lifecycle** (Design → Deploy → Operate) as the primary framework, and treats NVIDIA's cold-start vs. warm-start distinction as a **data maturity dimension** that cuts across the lifecycle.

#### Data Maturity as an Orthogonal Dimension

Data maturity describes *what data is available*, independent of where a workflow sits in its lifecycle:

| Data Maturity | Available Data | Typical Techniques | When It Occurs |
| --- | --- | --- | --- |
| **Synthetic-only** | CAD models, simulated environments, generated imagery | Domain randomization, style transfer, physics simulation | First deployment of a new use case (any lifecycle phase) |
| **Synthetic + collected** | Synthetic data plus teleoperation demos, initial field recordings | Mixed training sets, sim-to-real transfer | After initial data collection campaigns |
| **Operational** | Production sensor data, real-world failure cases, fleet telemetry | Fine-tuning on real data, continuous learning | Established deployments with production feedback loops |

A workflow can be in Day 2 (Operate) while still at synthetic-only data maturity for a newly added task — e.g., a factory adding inspection of a new component type. Conversely, a Day 0 (Design/Build) effort can leverage operational data from a prior deployment. The two dimensions are independent.

#### The Standard Lifecycle Applied to Physical AI

| Phase | What Happens | Compute Profile | Data Source |
| --- | --- | --- | --- |
| **Day 0 (Design/Build)** | Bootstrap from synthetic or collected data. Full pipeline: generate scenes, render data, augment, train from scratch. Validate in simulation. | Heavy GPU (simulation + training), days–weeks | CAD models, synthetic scenes, collected demos, or prior operational data |
| **Day 1 (Deploy)** | Deploy trained models to staging/production. Package as containerized microservice. Configure behavior rules and inference pipelines. | Light (packaging, config), hours | Model artifacts, deployment configs |
| **Day 2 (Operate)** | Monitor production performance. Detect accuracy degradation. Collect in-operation data. Trigger incremental retraining. Redeploy improved models. | Event-driven monitoring + occasional GPU (retraining), continuous | Production telemetry, real-world sensor data |

The Day 2 loop is the [FOX Blueprint's](../references/nvidia-fox-blueprint.md) core pattern — and arguably the highest-value platform capability:

```text
Monitor → Detect Drift → Collect/Generate Data → Retrain → Evaluate → [Gate] → Redeploy
    ▲                                                                           │
    └───────────────────────────────────────────────────────────────────────────┘
```

This loop should be a first-class platform capability, not something each customer builds from scratch.

### 1.6 The NVIDIA Stack Hierarchy

NVIDIA organizes its Physical AI offerings in four layers that compose bottom-up:

```text
┌─────────────────────────────────────────────────────────┐
│  Customer Applications                                  │
│  (Foxconn MoMClaw, Pegatron agents, etc.)               │
├─────────────────────────────────────────────────────────┤
│  AI Blueprints                                          │
│  Opinionated workflow compositions:                     │
│  FOX, Mega, VSS, Physical AI Data Factory               │
│  Each = a pre-built reference workflow for a use case   │
├─────────────────────────────────────────────────────────┤
│  [Agent Skills](../references/nvidia-skills-analysis.md) (224 in catalog)  │
│  Reusable capabilities as SKILL.md + evals:             │
│  TAO training (66), VSS analytics (15), Jetson (33),    │
│  Physical AI (7), DeepStream (2), NeMo (20+)            │
│  Signed, evaluated, following agentskills.io spec       │
├─────────────────────────────────────────────────────────┤
│  NIM Microservices                                      │
│  Model + optimized runtime + API:                       │
│  Cosmos 3, Nemotron, Qwen3-VL, NV-DINOv2, C-RADIO       │
│  Self-contained containers, OpenAI-compatible API       │
├─────────────────────────────────────────────────────────┤
│  Infrastructure                                         │
│  OSMO (orchestration), DGX/OVX (compute),               │
│  Jetson (edge), Isaac Sim (simulation)                  │
└─────────────────────────────────────────────────────────┘
```

Key observation: **Blueprints encode domain expertise as workflow patterns.** The FOX Blueprint doesn't just wire together skills — it embodies years of manufacturing experience about how inspection, root cause analysis, and retraining should work together. This is the insight behind "most customers don't have enough skilled engineers to design non-standard workflows."

### 1.7 Composition Patterns Observed

From the [skills deep-read](../references/nvidia-skills-deepread.md), several composition patterns recur:

**1. Preflight → Execute → Report**
Every NVIDIA skill follows: validate prerequisites (credentials, models, infrastructure, pod template) → execute workflow DAG → generate structured report (JSON + Markdown + HTML). This discipline prevents wasted GPU-hours from misconfigured runs.

**2. Jinja-Gated Pipeline Stages**
[OSMO](../references/nvidia-osmo.md) workflows use Jinja conditionals to skip expensive stages when not needed (e.g., skip fine-tuning if using a pretrained checkpoint). This makes a single workflow definition serve multiple operational modes.

**3. Model Cache Auto-Remediation**
Skills automatically detect missing or corrupted model caches, download weights, and retry — without user intervention. Cold start (~45-80min) vs. warm start (~20-45min) is a significant operational difference.

**4. Orchestrator Skills Reference Infrastructure Skills**
Workload skills (defect image generation, video augmentation) reference infrastructure skills (infrastructure-setup-and-resilient-scaling) for Kubernetes, OSMO, and NIM Operator setup. The infrastructure skill is a prerequisite, not a stage in the workflow.

**5. Data Maturity as Workflow Variants, Not Separate Workflows**
A single workflow definition (e.g., `physical-ai-defect-image-generation`) serves both synthetic-only mode (CAD → synthetic → train → infer) and operational-data mode (real photo → registration → infer) via different entry points and parameter sets. This is NVIDIA's "Day 0 / Day 1" distinction — the same DAG adapts to data availability rather than requiring separate workflow definitions.

---

## Part 2: Red Hat Platform Mapping

### 2.1 Platform Architecture Overview

Based on the workflow patterns identified in Part 1, a Red Hat Physical AI platform maps to four layers that parallel NVIDIA's hierarchy but with different build/partner boundaries:

```text
┌──────────────────────────────────────────────────────────────────┐
│  BLUEPRINTS (Red Hat builds)                                     │
│  Opinionated workflow templates as Tekton/KubeFlow pipelines     │
│  Starting with: Robotics Policy Training, Video Analytics,       │
│  Video/Image Data Processing, Industrial Inspection              │
├──────────────────────────────────────────────────────────────────┤
│  AGENTIC SKILLS (Red Hat builds, agentskills.io format)          │
│  Vendor-agnostic skill interfaces wrapping partner tools         │
│  Platform: Kagenti (lifecycle, A2A, MCP, AuthBridge)             │
│  Agent: OpenClaw/Hermes  |  Security: OpenShell                  │
│  Each skill: SKILL.md + skill-card + evals + signature           │
├────────────────────────┬─────────────────────────────────────────┤
│  RED HAT COMPONENTS    │  PARTNER COMPONENTS (swappable)         │
│  (builds/owns)         │  (initially NVIDIA, later others)       │
│                        │                                         │
│  ● Video processing    │  ● Data curation (Cosmos Curator)       │
│    pipeline framework  │  ● Data augmentation (Cosmos Transfer)  │
│    (GStreamer + VLM    │  ● Synthetic generation (Isaac Sim)     │
│    integration)        │  ● Foundation models (GR00T, Cosmos)    │
│  ● Model serving       │  ● Robot middleware (Isaac ROS)         │
│    (vLLM + KServe)     │  ● Simulation (Isaac Lab)               │
│  ● Workflow engine     │  ● Scene reconstruction (NuRec)         │
│    (Tekton/KubeFlow)   │  ● Model optimization (TensorRT)        │
│  ● Edge platform       │  ● Advanced orchestration (OSMO)        │
│    (RHEL + MicroShift) │                                         │
│  ● Cluster mgmt (ACM)  │                                         │
│  ● Messaging (AMQ)     │                                         │
│  ● Search (OpenSearch) │                                         │
├────────────────────────┴─────────────────────────────────────────┤
│  INFRASTRUCTURE                                                  │
│  OpenShift (central) | MicroShift/RHEL (edge) | ACM (multi-site) │
│  GPU scheduling via OpenShift + NVIDIA GPU Operator              │
└──────────────────────────────────────────────────────────────────┘
```

### 2.2 Build/Partner Boundary Rationale

**Red Hat Builds** — components where Red Hat has existing technology, strategic interest, or where vendor neutrality is the value:

| Component | Why Red Hat Builds | Existing Foundation |
| --- | --- | --- |
| **Video processing pipeline framework** | Cross-cutting infrastructure needed by all video-related workflows; vendor neutrality (not locked to NVIDIA GPUs); integrates with VLMs and agents | GStreamer is open source; Red Hat has media pipeline expertise from RHEL |
| **Model serving** | Already invested, core AI platform capability | vLLM, KServe, RHOAI |
| **Workflow orchestration** | Core platform capability; Kubernetes-native is Red Hat's strength | Tekton, KubeFlow Pipelines, RHOAI Pipelines |
| **Edge platform** | Core product portfolio | RHEL for Edge, MicroShift, FlightCtl |
| **Messaging / event streaming** | Standard infrastructure | AMQ Streams (Strimzi/Kafka) |
| **Metadata / search** | Standard infrastructure | OpenSearch |
| **Blueprints** | Domain expertise encoding; differentiation through opinionated workflows | New — but builds on Tekton pipeline templates |
| **Agentic skills** | Control plane for partner ecosystem; vendor neutrality layer | New — adopt agentskills.io |

**Partner Provides** — components where deep domain expertise, model training, or hardware-specific optimization is the value:

| Component | Why Partner | Initial Partner | Swap Candidates |
| --- | --- | --- | --- |
| **Data curation** | Evolving rapidly; specialized tooling | NVIDIA Cosmos Curator | Lilac, Argilla, Scale AI |
| **Data augmentation** | World model expertise, compute-intensive | NVIDIA Cosmos Transfer | Open-source diffusion models |
| **Synthetic data generation** | Physics simulation, domain-specific | NVIDIA Isaac Sim | Genesis World, MuJoCo MJX |
| **Foundation models** | Model training is partner territory | NVIDIA GR00T, Cosmos | HuggingFace LeRobot, pi0 |
| **Robot middleware** | Deep robotics domain, ROS 2 ecosystem | NVIDIA Isaac ROS | Open Robotics ROS 2 |
| **Model optimization** | Hardware-specific acceleration | NVIDIA TensorRT | ONNX Runtime, OpenVINO |
| **Advanced orchestration** | Multi-cluster Physical AI workflows beyond basic Tekton | NVIDIA OSMO | — |

### 2.3 Platform Component Mapping

Mapping NVIDIA components to Red Hat equivalents for the two priority workflows:

| Function | NVIDIA Component | Red Hat Equivalent | Status |
| --- | --- | --- | --- |
| **Workflow orchestration** | OSMO | Tekton Pipelines / KubeFlow Pipelines | Exists, needs Physical AI pipeline templates |
| **Model serving** | NIM microservices | vLLM + KServe (RHOAI) | Exists |
| **Model registry** | (none standard) | KubeFlow Model Registry | Exists, needs policy/embodiment metadata |
| **Edge inference** | Jetson + DeepStream | RHEL for Edge + MicroShift + vLLM/ONNX RT | Exists, needs video pipeline integration |
| **Edge fleet management** | (none standard) | FlightCtl | Exists |
| **Multi-cluster management** | [OSMO](../references/nvidia-osmo.md) multi-cluster | ACM | Exists, different abstraction level |
| **Event streaming** | Kafka (in VSS) | AMQ Streams (Strimzi) | Exists |
| **Metadata store** | Elasticsearch (in VSS) | OpenSearch | Exists |
| **Video processing** | DeepStream SDK 9 | **GStreamer + plugins (NEW)** | Needs building |
| **VLM integration in pipelines** | RT-VLM (in VSS) | **vLLM pipeline integration (NEW)** | Needs building |
| **Agentic skills** | NVIDIA Skills (224) | **Red Hat skills (NEW)** | Needs building |
| **Agent platform** | NemoClaw | Kagenti (K8s-native lifecycle, A2A/MCP, AuthBridge) | Adopt/extend |
| **Agent runtime** | NemoClaw | OpenClaw / Hermes | Adopt/extend |
| **Agent security** | OpenShell | OpenShell | Adopt |
| **Blueprints** | AI Blueprints | **Pipeline templates (NEW)** | Needs building |
| **Data curation** | Cosmos Curator | Partner (NVIDIA initially) | Partner |
| **Data augmentation** | Cosmos Transfer | Partner (NVIDIA initially) | Partner |
| **Synthetic data** | Isaac Sim | Partner (NVIDIA initially) | Partner |
| **Foundation models** | GR00T, Cosmos | Partner (NVIDIA, HF initially) | Partner |
| **Simulation** | Isaac Lab | Partner (NVIDIA initially) | Partner |
| **Model optimization** | TensorRT, TAO distillation | Partner (NVIDIA initially) | Partner |

### 2.4 Priority Areas

Based on the cross-workflow analysis in Part 1, the highest-value platform capabilities — appearing across ≥4 workflows — are:

1. **Workflow orchestration** — DAG execution with conditional stages, multi-cluster compute routing, and content-addressable dataset management. This is the backbone that all five canonical workflows depend on.
2. **Video processing pipeline framework** — GStreamer-based pipelines with pluggable inference backends (vendor-neutral), VLM integration, and message broker output. Shared by video analytics, inspection, and batch data processing workflows.
3. **Model serving and edge deployment** — Unified model serving (vLLM/KServe) for central and edge, with containerized packaging for edge targets (MicroShift/RHEL). Required by all workflows at the serving layer.
4. **Day 2 operations loop** — Model monitoring, drift detection, automated retraining triggers, and agent-orchestrated continuous improvement (the [FOX Blueprint](../references/nvidia-fox-blueprint.md) pattern). This is arguably the highest-value capability — the difference between a one-time deployment and a self-improving system.
5. **Agentic skills layer** — Vendor-neutral skill interfaces (agentskills.io) that abstract partner-specific implementations behind standard contracts, enabling backend swappability.

Detailed architecture design, blueprint parameter structures, skill format specifications, and phased implementation plans are downstream work items that should be addressed once the patterns and build/partner boundaries described in this primer are validated.

---

## Open Questions for Discussion

1. **Workflow orchestration strategy**: Physical AI workflows look more like ML pipelines than CI/CD. OSMO provides purpose-built Physical AI orchestration (platform-aware GPU routing, content-addressable datasets, multi-cluster). Red Hat has Tekton, KubeFlow Pipelines, and ACM. What's the right combination, and where do gaps remain?

2. **Video pipeline scope**: The Metropolis/VSS architecture spans stream management (VIOS), real-time inference (DeepStream), behavior analytics, and agent-driven reasoning. How deep should a Red Hat framework go — GStreamer + pluggable inference only, or full three-tier architecture?

3. **Dataset management**: OSMO's content-addressable datasets with versioning and deduplication are valuable for Physical AI's TB-scale data volumes. Neither Tekton nor KubeFlow provides this natively. Is this a Red Hat build, a partner capability, or solvable with existing storage (Ceph + metadata)?

4. **Cross-vendor validation**: This primer uses NVIDIA's ecosystem as a proxy. The identified patterns should be validated against other Physical AI stacks (Google DeepMind, Meta FAIR, open robotics community) to confirm they are universal rather than NVIDIA-specific.
