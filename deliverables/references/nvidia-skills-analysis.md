# NVIDIA Skills Repo Analysis

**Date**: 2026-06-25
**Source**: https://github.com/NVIDIA/skills
**Purpose**: Component-up analysis of NVIDIA's agentic skill catalog to identify reusable workflow building blocks for Physical AI platform design.

---

## Overview

- **224 skills** across **33 products**, Apache 2.0 / CC BY 4.0 licensed
- Skills are **agentic instruction sets** (SKILL.md + references + evals), not code libraries
- Every skill is cryptographically signed (OMS) and has evaluation benchmarks
- Follows the agentskills.io specification for portability across agent runtimes

## Skill Families by Product

### Physical AI (7 skills) — The core

| Skill | What It Does |
|---|---|
| `physical-ai-defect-image-generation` | Orchestrates defect image generation with Cosmos AnomalyGen for AOI (PCBA, metal, glass) |
| `physical-ai-video-data-augmentation` | Video data augmentation pipelines |
| `physical-ai-neural-reconstruction` | Neural reconstruction workflows |
| `physical-ai-infrastructure-setup-and-resilient-scaling` | Infrastructure setup and GPU scaling |
| `omniverse-cad-to-simready` | CAD/source-asset to SimReady USD pipeline |
| `omniverse-realtime-viewer` | Realtime USD viewer |
| `omniverse-usd-performance-tuning` | USD performance optimization |

**Key observation**: The "Physical AI" label covers a narrow slice. Most Physical AI workflows are assembled from skills in other families (TAO, VSS, Jetson, NeMo).

### TAO Toolkit (66 skills) — Vision model training workhorse

**Analysis & Gap Detection (4):**

- `tao-analyze-changenet-rca` — Root cause analysis for visual change detection
- `tao-analyze-gaps-visual-changenet` — Gap analysis for visual change networks
- `tao-analyze-gaps-vlm-bcq` — Gap analysis for VLM-based quality control
- `tao-mine-aoi-images` — Mine images for automated optical inspection

**Data Generation & Preparation (6):**

- `tao-convert-dataset-format` — Dataset format conversion
- `tao-generate-image-grounding` — Image grounding data generation
- `tao-generate-referring-expressions` — Referring expression generation
- `tao-generate-video-reasoning-annotations` — Video reasoning annotation
- `tao-route-visual-changenet-samples` — Route samples for visual change detection
- `tao-validate-dataset-format` — Dataset format validation

**Model Fine-tuning (5):**

- `tao-finetune-clip` — CLIP fine-tuning
- `tao-finetune-cosmos-embed` — Cosmos embedding fine-tuning
- `tao-finetune-cosmos-reason` — Cosmos reasoning fine-tuning
- `tao-finetune-huggingface-model` — HuggingFace model fine-tuning
- `tao-port-huggingface-model` — Port HuggingFace models to TAO

**AutoML & Workflows (3):**

- `tao-run-automl` — AutoML pipeline
- `tao-run-automl-deft-pipeline` — Automated defect detection pipeline
- `tao-run-deft-aoi` — Defect detection for AOI

**Training — Vision Models (35):**
Covers: action recognition, BEVFusion, CenterPose, Deformable DETR, Depth Anything v2, DINO, stereo vision, Grounding DINO, image classification, MAE, auto-labeling, Mask2Former, metric learning, NVDINOv2, panoptix3D, OCR (detect+recognize), OneFormer, optical inspection, PointPillars, pose classification, ReID, RT-DETR, SegFormer, Sparse4D, Visual ChangeNet.

**Platform & Infrastructure (9):**
Run-on targets: Brev, Kubernetes, Lepton, local Docker, SLURM. Plus GPU host setup and workflow launch.

**Inference (1):**

- `tao-run-inference-service`

### Video Search & Summarization — VSS (15 skills)

**Deployment (5):**

- Dense captioning, 2D detection+tracking, 3D detection+tracking, profile deployment, video embedding

**Analysis & Search (5):**

- Ask video (VQA), video calibration, video report generation, analytics queries, archive search

**Management (5):**

- Alerts, video I/O storage, behavior analytics setup, video analytics API setup, video summarization

### Jetson BSP (24 skills) + Jetson Device (9 skills) — Edge deployment

**BSP**: Download, init, flash, build, promote, validate images. Customize camera, clocks, fan, networking, PCIe, pinmux, USB. Derive carrier board support.

**Device**: Diagnostics, headless mode, inference memory tuning, LLM benchmarking, LLM serving, memory audit, packaging, speculative decoding.

### NeMo MBridge (20 skills) — Large-scale training optimization

13 performance optimization skills covering: activation recompute, CPU offloading, CUDA graphs, expert parallelism, context parallelism, FSDP, memory tuning, MoE communication overlap, MoE dispatcher, MoE hardware configs, MoE long context, MoE optimization workflows, MoE VLM training, parallelism strategies, sequence packing, TP/DP communication overlap.

Plus: multi-node SLURM, recipe recommender, resiliency, bridge training.

### Medical AI (12 skills)

DICOM handling (3), medical image generation (5 — CT, MR, brain MR with fine-tuning), segmentation & analysis (4 — chest X-ray reasoning, CT segmentation with fine-tuning).

### Holoscan (6) + Sensor Bridge (4) — Streaming sensor processing

Holoscan: Install via conda/container/debian/source/wheel, setup.
Sensor Bridge: App development, flash, setup, test.

### Other Families

- **cuOpt (12)**: Routing optimization, numerical optimization APIs
- **NeMo-RL (5)**: RL training launch, auto-research, documentation
- **Megatron-Core (5)**: Issue creation, linting, SLURM, PR splitting, testing
- **NeMo AutoModel (4)**: Distributed training, launcher config, model onboarding, recipes
- **Dynamo (4)**: Interconnect check, recipe runner, router, troubleshooting
- **Earth2Studio (4)**: Weather/climate forecasting
- **Digital Health (4)**: Clinical ASR (build, eval, finetune, setup)
- **cuPyNumeric (4)**: GPU-accelerated NumPy
- **TileGym (7)**: GPU kernel optimization
- **Nemotron (3)**: Model customization, policy generation, retrieval
- **RAG Blueprint (3)**: RAG deployment, eval, performance
- **DeepStream (2)**: Development, vision model import
- **AIQ (2)**: Deploy, research

## Composition Patterns

### 1. Orchestrator → Atomic Skills

`physical-ai-defect-image-generation` coordinates:

- Infrastructure setup (references `physical-ai-infrastructure-setup-and-resilient-scaling`)
- Data generation workflows (Day 0 / Day 1 flows)
- Monitoring and troubleshooting

### 2. Skill Families with Shared Infrastructure

TAO skills share:

- Common platform skills (`tao-run-on-kubernetes`, `tao-run-on-slurm`, etc.)
- Common setup (`tao-setup-nvidia-gpu-host`)
- Workflow launcher (`tao-launch-workflow`)

### 3. Escalation Chains

Simple API skills → Developer skills for deeper work.
Example: `cuopt-routing-api-python` → `cuopt-developer`

### 4. Cross-Product Composition

A complete Physical AI workflow composes across families:

- **Omniverse** skills for simulation/scene setup
- **TAO** skills for model training
- **DeepStream** skills for inference pipeline
- **Jetson** skills for edge deployment
- **VSS** skills for video analytics

## Workflow Mapping (Initial)

### Industrial Inspection / Defect Detection

```
[Data] physical-ai-defect-image-generation (Cosmos AnomalyGen)
  → tao-mine-aoi-images (curate real defect samples)
  → tao-generate-image-grounding (annotate)
  → tao-run-deft-aoi (train defect detector)
  → tao-train-optical-inspection (specialized training)
  → tao-run-inference-service (deploy)
  → Jetson deployment skills (edge)
```

### Video Analytics

```
[Ingest] deepstream-import-vision-model (import model into DeepStream)
  → deepstream-dev (build pipeline)
  → vss-deploy-detection-tracking-2d (deploy tracking)
  → vss-setup-video-analytics-api (API setup)
  → vss-setup-behavior-analytics (behavior rules)
  → vss-manage-alerts (alerting)
  → vss-search-archive / vss-ask-video (query)
```

### Robotics / Sim-to-Real

```
[Scene] omniverse-cad-to-simready (prepare USD assets)
  → omniverse-realtime-viewer (validate scene)
  → physical-ai-video-data-augmentation (augment training data)
  → physical-ai-neural-reconstruction (reconstruct scenes)
  → [Training via NeMo/TAO]
  → [Deploy via Jetson]
```

### Edge Deployment

```
[Prepare] jetson-download-bsp → jetson-init-image
  → jetson-customize-* (camera, clocks, PCIe, etc.)
  → jetson-build-source → jetson-flash-image
  → jetson-validate-image → jetson-promote-image
  → jetson-llm-serve / jetson-inference-mem-tune (runtime)
  → jetson-diagnostic (monitoring)
```

## Key Observations for Red Hat Platform

### 1. Skills as First-Class Platform Capability

NVIDIA treats agentic skills as shipping features — signed, evaluated, cataloged. This validates the user's instinct that agentic tools/skills are a platform differentiator.

### 2. The "Thin Physical AI" Problem

Only 7 skills carry the "Physical AI" label. The actual Physical AI workflow requires composing across 5+ product families. This suggests the workflow orchestration layer is where platform value concentrates — not in individual components.

### 3. Vendor-Agnostic Abstraction Opportunities

Many TAO skills map to capabilities available in open-source alternatives:

- TAO training → PyTorch + HuggingFace Trainer
- DeepStream → GStreamer + custom plugins
- Omniverse USD → OpenUSD ecosystem
- Jetson BSP → RHEL for Edge / Fedora IoT
- NeMo → vLLM + HuggingFace

The skill abstraction layer could wrap these with the same interface.

### 4. Missing Pieces in NVIDIA's Skills Catalog

Notable gaps (may exist outside the skills repo):

- No Metropolis/DeepStream pipeline orchestration skill
- No Cosmos world model training/fine-tuning skill
- No GR00T / Isaac Lab robotics training skill
- No digital twin / Omniverse simulation orchestration skill
- Limited RLHF / preference learning skills

These gaps suggest either these workflows aren't yet productized as skills, or they live in other repos.

## Next Steps

1. **Deep-dive the Physical AI skills** — Read SKILL.md for each of the 7 core Physical AI skills to understand workflow stages
2. **Map TAO training skills to use cases** — Which vision models serve which Physical AI use cases?
3. **Analyze VSS + DeepStream** — Understand the video analytics pipeline in detail
4. **Research NVIDIA use-case pages** — Use-case-down analysis to complement this component-up view
5. **Identify cross-cutting patterns** — Data ingestion, training, eval, deployment stages shared across workflows
