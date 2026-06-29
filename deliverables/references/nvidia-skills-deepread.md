# NVIDIA Physical AI Skills — Deep Read

**Date**: 2026-06-25
**Source**: https://github.com/NVIDIA/skills (7 Physical AI skills + 2 DeepStream skills)
**Purpose**: Extract detailed workflow stages, data flows, and component dependencies from NVIDIA's Physical AI agentic skills.

---

## 1. physical-ai-defect-image-generation

**Purpose**: End-to-end AOI (Automated Optical Inspection) defect dataset generation for PCBA, metal surfaces, and glass using Cosmos AnomalyGen (finetuned Cosmos-Predict2-2B).

### Day 0 — Texture Defects (Cold Start, CAD → Synthetic)

**DAG**: `usd2roi-render → augment-image-edit → [finetune-job] → anomaly-infer`

| Stage | Component | Inputs | Outputs | GPU | Tools/Models |
|---|---|---|---|---|---|
| **usd2roi-render** | IsaacSim Kit + paidf-simulation | CAD USD scene, target/image/crop YAMLs | Per-cell ROI crops + CAD masks | 1 GPU (render) | Kit OptiX ray-tracer, scan_grid renderer, usd2roi_crop.py |
| **augment-image-edit** | paidf-augmentation + Qwen Image-Edit NIM | Per-cell normal_img + cad_mask | SL-styled augmented images | 1 GPU (augment) | `nvidia/Qwen-Image-Edit-NVPCB-OVSL2SL` NIM |
| **finetune-job** (optional, Jinja-gated) | paidf-anomalygen | Pretrained models (NVDINOV2, SAM2, Qwen3-VL, T5), raw training masks | Finetuned Cosmos-AnomalyGen checkpoint | 1+ GPU (train) | torchrun DDP, prep_testcase.sh, ag_config.yaml |
| **anomaly-infer** | paidf-anomalygen | Augmented images, cad_masks, submasks, checkpoint | Labeled defect reconstructions per-defect | 1+ GPU (infer) | prep_testcase.sh, run_sdg.sh, AMP defect placement |

### Data Flows

- **Config propagation**: Cookbook YAML files mounted via `localpath:` and patched in-pod with `yq` or Python
- **Metadata threading**: Per-cell structure (`crop/<MATERIAL>/<x*_y*>/`) preserved through usd2roi → augment; staged into canonical anomalygen layout before inference
- **Checkpoint handoff**: Finetune outputs `ag_config.yaml` + `checkpoints/model/iter_*.pt`; inference wraps these into canonical structure
- **Best checkpoint selection**: `pick_best_step.sh` auto-derives inference step from `valid/<STEP>/valid_kpi.csv` (peak average nn_score)

### Component Dependencies

- **Isaac Sim Kit** (paidf-simulation image): OptiX binaries (`/usr/share/nvidia/nvoptix.bin`), /dev/shm ≥16GB
- **Qwen Image-Edit NIM**: `nvidia/Qwen-Image-Edit-NVPCB-OVSL2SL` (NOT generic — AnomalyGen finetuned)
- **Pretrained models tree**: NVDINOV2, nvidia, google-t5, facebook, C-RADIOv2_B.pth, sam2, Qwen
- **OSMO storage**: S3/Azure-compatible URL schemes

### Day 0 Variants

- **Good Image flow**: `good_image_generation.yaml` (usd2roi + image-edit, NO anomalygen)
- **Structural Defect flow**: `structural_defect_generation.yaml` (IsaacSim pose perturbations: shift/tombstone/sideflip + image-edit, NO AMP)
- **Finetune-only flow**: `finetune.yaml` (no rendering/augmentation, just training)

### Day 0 vs Day 1

- **Day 0** = cold-start from CAD, full synthetic pipeline
- **Day 1** = real photo → MI registration → inference (requires USD + real PCBA photo for registration)
- **Day 1 manual-ROI**: For metal/glass with pre-captured ROI masks

### Key Design Patterns

- **Two-stage knobs**: `render_patches=N` caps raw scan_grid patches; `crop_max_emit=N` caps final per-cell crops
- **Jinja-gated finetune**: `{% if use_pretrained_checkpoint|string|lower not in ["true", "1", "yes"] %}` — passthrough mode omits finetune group entirely
- **ChangeNet golden/defect pairs**: Submit `good_image_generation.yaml` + `structural_defect_generation.yaml` with same `--set name=` for pairing

---

## 2. physical-ai-video-data-augmentation

**Purpose**: Video augmentation (Cosmos generative model), auto-labeling (Qwen3-VL + Qwen2.5-14B), and end-to-end VDA workflows on OSMO.

### Default Workflow: augmentation_and_al

**DAG**: `setup → augmentation → auto_labeling_augmented`

| Stage | Component | Inputs | Outputs | GPU |
|---|---|---|---|---|
| **setup** | paidf-vda | storage_url, dataset, cookbook YAML | Config manifests, smoke-test frames | 0 GPU (CPU) |
| **augmentation** | paidf-vda | Source video, cosmos_model_cache_url, scene profile | Augmented video (`*_aug0.mp4`) | 1+ GPU (Cosmos) |
| **auto_labeling_augmented** | paidf-vda | Augmented video, auto_labeling_model_cache_url | Pseudo-labeled frames (per-frame JSON with bbox) | 1+ GPU (VLM+LLM) |

### Workflow Variants

- **auto_labeling**: Setup → auto_labeling (label original videos only)
- **augmentation_and_al**: Setup → augmentation → auto_labeling_augmented (default)
- **e2e**: Setup → (auto_labeling_original + augmentation in parallel) → auto_labeling_augmented (throughput-first)
- **e2e_super_resolution**: Setup → auto_labeling_original → augmentation → auto_labeling_augmented (SR gate)

### Data Flows

- **Model cache**: `cosmos_model_cache_url` and `auto_labeling_model_cache_url` point to OSMO storage; setup downloads if missing
- **Config expansion**: Cookbook defines camera trajectory, scene params (translation_magnitude, rotation_magnitude, object_removal_prob)
- **Metadata threading**: `sampled_vars` written to `manifest.yaml`; auto-labeling writes per-frame JSON with bbox annotations

### Key Design Patterns

- **Cache auto-remediation**: `pre_submit_guard.py` detects cache failure → auto-submit `setup_model_cache.yaml`, rerun guard, proceed
- **Execution continuity**: No approval pauses between green stages; heartbeat updates every 2min for long runs
- **Encoder fallback**: `nvv4l2h264enc` (NVENC) primary; `theoraenc + oggmux` fallback; x264enc/openh264enc prohibited
- **Cold vs warm start**: Cold = NIM deploy + cache setup (~45-80min); warm = cache/NIM healthy (~20-45min)

---

## 3. physical-ai-neural-reconstruction

**Purpose**: Thin router for NVIDIA Neural Reconstruction (NuRec) — USDZ training/rendering, NCore conversion, sensor simulation.

### Workflow Routes

| Workflow | DAG | Purpose |
|---|---|---|
| **Make NuRec scene from recording** | Sensor recording → NCore V4 → NRE training → USDZ | Train 3DGS scene from driving/robotics data |
| **Use published scene** | Download USDZ → NRE rendering | Render pre-trained NuRec scenes |
| **Add/remove/replace objects** | Asset Harvester → edit scene → render | Object manipulation in scenes |
| **Clean up rendered frames** | Rendered frames → DiffusionHarmonizer → cleaned frames | Remove ghosting/floaters/flicker |
| **Benchmark reconstruction** | PhysicalAI-NuRec-PPISP benchmark → eval | PSNR/SSIM/LPIPS quality metrics |
| **Connect to simulator** | USDZ → gRPC server → CARLA/Isaac Sim/AlpaSim client | Real-time sensor sim |

### Data Flows

- **NCore V4 format**: Canonical input (camera, LiDAR, radar, depth, ego mask, segmentation masks)
- **USDZ output**: 3D Gaussian Splatting scene (3DGUT or 3DGRT flavor)
- **gRPC serve**: Persistent server for low-latency batch rendering

### Dependencies

- NGC containers: `nvcr.io/nvidia/nre/nre`, `nvcr.io/nvidia/nre/nre-tools`
- HuggingFace gated datasets: `nvidia/PhysicalAI-Autonomous-Vehicles-NuRec`
- Asset Harvester (Apache-2.0): 3D object extraction from sparse views
- DiffusionHarmonizer: Frame cleanup (successor to Difix3D+)
- Heavy footprint: 150GB+ on disk

---

## 4. physical-ai-infrastructure-setup-and-resilient-scaling

**Purpose**: Orchestrate Kubernetes, OSMO, NIM Operator, and NVCF inference setup.

### Component Matrix

| Stage | Component | Outputs |
|---|---|---|
| **Kubernetes** | `cluster-microk8s` OR `cluster-azure` | Cluster API, GPU capacity |
| **OSMO** | `osmo-k8s` OR `osmo-azure` | OSMO pods Ready, pool ONLINE, storage credentials |
| **Inference** | `inference-nim-operator` OR `inference-nvcf` OR `inference-azure` | Endpoint URLs, health checks |
| **Workload** | VDA/DIG/NuRec skill references | Workflow COMPLETED |

### Target Selection Matrix

- Kubernetes: MicroK8s OR Azure
- OSMO: MicroK8s OSMO (when K8s=MicroK8s) OR Azure OSMO (when K8s=Azure)
- Inference: NIM Operator (both), NVCF (both), Azure AI Foundry (Azure only)

### Key Design Patterns

- **Setup flow**: Kubernetes first → OSMO + Inference in parallel → Workload after all gates green
- **Preflight before provision**: Every component has mandatory preflight
- **Verification gates**: Each stage has green gate before next
- **Avoid over-deploying**: Scan workflow spec for endpoint refs, deploy only required NIMServices
- **Resilient scaling**: Size cluster from workload needs; treat Pending/Unknown/ImagePullBackOff as layer failures

---

## 5. omniverse-cad-to-simready

**Purpose**: End-to-end CAD/source asset → SimReady workflow.

### Pipeline Stages

| Stage | Inputs | Outputs | Tools |
|---|---|---|---|
| **Preflight** | Source asset path | Preflight manifest JSON | Upstream checkout validation |
| **Convert to USD** | CAD/URDF/MJCF/mesh | USD file | `nvidia-omniverse/usd-convert-cad` |
| **Validate USD minimum** | Converted USD | Viability report | OpenUSD validation |
| **Content Agents assignment** | Minimum-valid USD | Property-assigned USD | Material Agent, Physics Agent, Texture Agent (optional) |
| **SimReady conform profile** | Property-assigned USD | FET-repaired USD | FET000, FET001, FET004, FET005 |
| **Validation gates** | FET-repaired USD | Structured findings | Asset Validator, SimReady profile rules |
| **OVRTX render** | Final USD | Preview/thumbnail images | OVRTX service |
| **Package assembly** | Final USD + thumbnail | Clean USDZ package | Two-zone assembly |

### Key Design Patterns

- **Property assignment intent gate**: `run` (default, deploy Content Agents) vs `skip` (conversion-only + validation-minimum)
- **FET repair loop**: `simready-validate` findings → FET repairs → revalidate → final disposition
- **Two-zone package assembly**: `deliverable/` contains only final USD + thumbnail
- **Preflight as dependency bootstrap**: `PHYSICAL_AI_REQUIRE_PREFLIGHT=1` blocks downstream on missing manifest

---

## 6. omniverse-realtime-viewer

**Purpose**: Router for Omniverse Realtime Viewer USD apps.

### Delivery Paths

| Path | Components | Rendering |
|---|---|---|
| **Browser streaming** | ovrtx (GPU server) + ovstream (WebRTC) + React UI | Server-side ovrtx, WebRTC to browser |
| **Local workstation** | ovrtx + ovui (OpenGL + Dear ImGui) | Local ovrtx + OpenGL viewport |
| **Tauri local** | ovrtx + Tauri (Rust + web frontend) | Local ovrtx, Tauri webview |
| **Electron SHM** | ovrtx + Electron + shared-memory transport | Local ovrtx, SHM to Electron |
| **C++ native** | ovrtx + C++ UI (Dear ImGui / Qt) | Local ovrtx, native C++ |
| **Headless SHM CLI** | ovrtx + SHM to WebGL | Headless ovrtx, offscreen WebGL |

### Key Design Patterns

- **Render ownership**: Single owner for renderer.step(), stage mutation, picking, selection
- **Camera/session isolation**: Viewer state in session layers, not user USD
- **All rendering via ovrtx**: No WebGL/Three.js/Babylon.js/glTF browser viewers

---

## 7. omniverse-usd-performance-tuning

**Purpose**: USD performance diagnosis and optimization.

### Pipeline (9 Phases)

| Phase | Purpose | Tools |
|---|---|---|
| **0: Runtime setup** | Detect Kit vs standalone | Kit version probe |
| **1: Baseline profile** | Load time, memory, FPS | Kit profiler, Tracy, usdview |
| **2: Structure assessment** | Composition audit, instancing readiness | USD introspection, usdchecker |
| **3: Validation** | Tier 1/2/3 findings | Asset Validator, Scene Optimizer |
| **4: Restructure decision** | Monolithic → multi-asset, payloads | User decision gate |
| **5: Apply restructure** | Rewrite USD | USD authoring |
| **6: SO validators/ops** | Mesh cleanup, dedup, material merge | Scene Optimizer ops |
| **7: After profile** | Post-optimization metrics | Same as Phase 1 |
| **8: Compare profiles** | Δ load time, Δ memory, Δ FPS | Profiling diffs |
| **9: Optimization report** | Structured JSON + Markdown + HTML | Template rendering |

---

## DeepStream Skills (Video Analytics Bridge)

### deepstream-dev

**Pipeline Flow**: `Source (nvurisrcbin) → Stream Muxer → Inference (nvinfer) → [Tracker] → OSD → Renderer`

- **pyservicemaker API**: Python bindings for DeepStream SDK 9.0 (GStreamer 1.24.2, CUDA 13.1, TensorRT 10.14.1)
- **Memory model**: NVMM zero-copy GPU buffers
- **Kafka integration**: `nvmsgconv` (metadata → JSON) → `nvmsgbroker`
- **Encoder fallback**: nvv4l2h264enc primary; theoraenc fallback; x264enc/openh264enc prohibited

### deepstream-import-vision-model

**Pipeline**: Model Acquire (HF/NGC download → ONNX) → Engine Build (TRT) → DS Pipeline (single-stream + KITTI dump + perf sweep) → Report (charts + PDF)

- **Engine naming**: Always `{model}_dynamic_b{MAX_BS}.engine`
- **KITTI validation gate**: Detection rate ≥90% before proceeding
- **Parser patterns**: YOLO v8/v11 = `[batch, 84, 8400]` pre-NMS (cluster-mode: 2); v10/v26+ = `[batch, 300, 6]` post-NMS (cluster-mode: 4)
- **Report**: Markdown → styled HTML (charts base64-inlined) → PDF

---

## Cross-Skill Synthesis

### 1. Day 0 / Day 1 Paradigm (Universal)

- **Day 0 (Cold Start)**: CAD/synthetic → full pipeline
- **Day 1 (Operational)**: Real data → inference/registration
- Appears in: DIG, VDA, NuRec

### 2. OSMO Orchestration Primitives

- **Jinja-gated composition**: Conditional groups for passthrough vs finetune modes
- **Task chaining**: `inputs: - task: upstream-task-name` (outputs auto-resolve)
- **Cookbook patching**: `localpath:` mounts YAML templates; in-pod `yq`/Python patches

### 3. NIM Endpoint Integration

- **In-cluster persistent NIMs**: Deployed via NIM Operator; health checks via `/v1/health/ready`
- **Auto-deploy on missing/unhealthy**: VDA auto-invokes infrastructure skill
- **External endpoints opt-in**: NVCF/Azure AI Foundry only when explicit URLs provided

### 4. Preflight Discipline

- **Credentials**: `preflight_credentials.sh` (secrets + image registry)
- **URL artifacts**: `preflight_urls.sh <flow> <usecase> [variant]`
- **Pod template**: `preflight_pod_template.sh` (OptiX mount, /dev/shm ≥16GB)
- **Runtime preflights**: In-pod checks at task start
- **Manifest-based**: Skills write `*-preflight.json`; downstream reads via env var

### 5. Model Cache & Artifact Staging

- **Shared model caches**: VDA uses cosmos/auto-labeling cache URLs; DIG uses pretrained models tree
- **Auto-remediation**: Pre-submit guard detects failure → auto-submit setup workflow → rerun guard
- **Artifact naming**: Strict conventions (`*_dynamic_b{MAX_BS}.engine`, `iter_<step>.pt`)

### 6. Monitoring & Reporting

- **Polling**: `osmo workflow query` JSON parsing
- **Heartbeat**: ≥1 update every 2min for long runs
- **Reports**: JSON + Markdown + HTML (template-rendered)
