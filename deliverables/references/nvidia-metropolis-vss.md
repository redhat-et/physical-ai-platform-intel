# NVIDIA Metropolis & VSS Blueprint — Architecture Deep-Dive

**Date**: 2026-06-25
**Purpose**: Understand the complete video analytics pipeline architecture — microservice decomposition, data flows, streaming vs batch, agent integration.

---

## Architecture: Three Processing Tiers

### Tier 1: Real-Time Video Intelligence (GPU-Accelerated Feature Extraction)

| Microservice | Technology | Purpose | Outputs |
|---|---|---|---|
| **RT-CV** | DeepStream SDK 9 + TensorRT/Triton | Object detection, classification, multi-object tracking | Detection metadata (bboxes, tracking IDs, confidences) → message broker |
| **RT-Embedding** | Cosmos-Embed1 models | Semantic embeddings from video/images/RTSP | Vector embeddings → message broker |
| **RT-VLM** | Cosmos Reason 1/2, Qwen3-VL | Natural language captions, incident detection | Text captions, incident alerts → message broker |

Detection models in RT-CV: RT-DETR (warehouse/smart city), Grounding DINO, Mask-Grounding-DINO, Sparse4D (3D multi-camera).

All three use "streaming batched inference" — GPU batches across concurrent camera streams.

### Tier 2: Downstream Analytics (Enrichment)

| Microservice | Purpose | Input | Output |
|---|---|---|---|
| **Behavior Analytics** | Spatial AI analytics, incident detection | Frame metadata from broker | Trajectories, speed/direction/dwell-time, spatial violation alerts |
| **Alerts** | VLM-based alert verification | Alerts from Behavior Analytics | Verified alerts (confirmed/rejected/unverified) with VLM reasoning traces |

Behavior Analytics capabilities: MTMC tracking, trajectory analysis, tripwire crossing, ROI entry/exit, proximity detection, restricted zones, confined area violations.

### Tier 3: Agent & Offline Processing (MCP-Based)

Agent orchestrates vision tools via **Model Context Protocol (MCP)**:

- Video understanding (VLM Q&A over clips)
- Semantic search (embedding-based retrieval)
- Video summarization (chunked caption aggregation)
- Clip/snapshot retrieval
- Report generation

Agent harnesses: Claude Code, OpenAI Codex, NemoClaw/OpenClaw.

---

## Data Flow Diagram

```text
Cameras/NVRs/Files
        │ RTSP
        ▼
┌────────────────┐
│ VIOS (Video    │  NVStreamer + 6 REST APIs
│ IO & Storage)  │  (sensor, live, replay, record, proxy, storage mgmt)
└────────┬───────┘
         │ RTSP
   ┌─────┼─────┐
   ▼     ▼     ▼
RT-CV  RT-VLM  RT-Embedding
   │     │     │
   └─────┼─────┘
         │ Metadata streams
         ▼
┌───────────────────┐
│ Message Broker    │  Kafka (KRaft, no ZK) or Redis Streams
│ (15+ topics)      │
└────────┬──────────┘
   ┌─────┼─────┐
   ▼     ▼     ▼
Behavior  Alerts  Logstash
Analytics Verif.  (Protobuf decode)
   │       │       │
   └───────┼───────┘
           ▼
   Elasticsearch
           │
           ▼
   VSS Agent (MCP + REST)
           │
           ▼
   UI / Reports / External
```

---

## Kafka Topic Taxonomy

```text
mdx-raw              — Raw detection metadata
mdx-bev              — Bird's-eye-view 3D detections
mdx-behavior         — Behavior analytics events
mdx-behavior-plus    — Extended behavior analytics
mdx-frames           — Frame-level metadata
mdx-mtmc             — Multi-target multi-camera tracking
mdx-alerts           — Alerts from behavior analytics
mdx-vlm-alerts       — Real-time VLM alerts
mdx-vlm-incidents    — VLM-verified incidents
mdx-vlm-captions     — VLM-generated captions
mdx-embed            — Video embeddings
mdx-embed-filtered   — Filtered embeddings
mdx-incidents        — Confirmed incidents
mdx-notification     — System notifications
mdx-events           — Spatial events (tripwire, ROI)
```

Message broker is swappable: Kafka or Redis via `STREAM_TYPE` env var.

---

## DeepStream Pipeline Architecture

### GStreamer Pipeline Stages

```text
Source → Decode → Preprocess → Batch → Inference → Postprocess → Track → Analytics → OSD → Encode/Display
```

### Key GStreamer Plugins (20+)

**Inference**: nvinfer (TensorRT), nvinferserver (Triton), nvdspreprocess, nvdspostprocess
**Tracking**: nvtracker (IOU, NvSORT, NvDeepSORT, NvDCF, MaskTracker)
**Analytics**: nvdsanalytics (line crossing, ROI counting, direction)
**Stream Mgmt**: nvstreammux (batching), nvstreamdemux, nvmultiurisrcbin, nvurisrcbin
**Display**: nvmultistreamtiler, nvdsosd, nvsegvisual, nvofvisual
**Video**: nvvideoconvert, nvdewarper, nvof (optical flow)
**Encode/Decode**: nvvideo4linux2 (NVDEC/NVENC), nvjpegdec/enc
**Messaging**: nvmsgconv (metadata → JSON/Protobuf), nvmsgbroker (Kafka, MQTT, AMQP, Redis)
**3D/Depth**: nvds3dfilter, nvds3dbridge, nvds3dmixer
**Networking**: NvDsUcx, nvdsxfer (multi-dGPU), nvunixfd (cross-process)

### Hardware Acceleration Points

| Hardware | Plugins | Function |
|---|---|---|
| NVDEC | nvvideo4linux2 (decoder) | H.264/H.265/VP9 decoding |
| NVENC | nvvideo4linux2 (encoder) | H.264/H.265 encoding |
| GPU (CUDA) | nvinfer, nvtracker, nvvideoconvert, nvdsosd, nvof | Inference, tracking, conversion |
| VIC (Jetson) | nvvideoconvert | Hardware scaling/color conversion |
| TensorRT | nvinfer | Deep learning inference |
| Triton | nvinferserver | Multi-framework inference serving |

### Metadata Schema Hierarchy

```text
NvDsBatchMeta (root)
├── NvDsFrameMetaList
│   └── NvDsFrameMeta (per-frame)
│       ├── source_id, frame_num, timestamp
│       ├── NvDsObjectMetaList
│       │   └── NvDsObjectMeta (per-object)
│       │       ├── class_id, tracking_id, confidence
│       │       ├── rect_params (bbox), mask_params (segmentation)
│       │       ├── NvDsClassifierMetaList (secondary classifiers)
│       │       └── NvDsUserMetaList (custom)
│       ├── NvDsDisplayMetaList (OSD rendering)
│       └── NvDsUserMetaList (custom frame-level)
└── NvDsUserMetaList (custom batch-level)
```

---

## Deployment Model

### Docker Compose (Primary)

Hierarchical compose structure with developer profiles and industry profiles:

**Developer Profiles**: base, lvs (video summarization), search, alerts
**Industry Profiles**: warehouse-operations (2D/3D/MV3DT), smart-city

**Infrastructure stack**: Kafka (KRaft), Redis, Elasticsearch 9.3, Kibana, Logstash, Phoenix (ML observability), HAProxy

### Kubernetes/Helm

- 8×GPU default (one per service)
- GPU allocation via `NVIDIA_VISIBLE_DEVICES`
- NVIDIA Cloud Native Stack + GPU Operator

### Hardware Platforms

**Datacenter**: H100, A100, L40S, RTX Pro 6000
**Edge**: DGX Spark, IGX Thor, AGX Thor, Jetson Orin

---

## Batch vs Streaming

| Mode | Mechanism | Use Case |
|---|---|---|
| **Real-time streaming** | RT-CV/RT-VLM/RT-Embedding process live RTSP with GPU-batched inference | Live monitoring, alerts |
| **Batch/offline** | Video Summarization microservice + Agent on-demand analysis | Report generation, archival search, post-event investigation |

DeepStream batching: `nvstreammux` batches multiple streams into single GPU batch. VLM batching requires single-stream-per-batch (temporal coherence).

---

## Customization Mechanisms

1. **Model swapping**: VLM/LLM via env vars (`VLM_ENDPOINT_URL`, `LLM_ENDPOINT_URL`); detection models via ONNX path in config
2. **Fine-tuning**: TAO Toolkit for RT-DETR, Sparse4D on custom datasets
3. **Behavior rules**: YAML/JSON config for tripwire, ROI, proximity, zones
4. **Custom DeepStream plugins**: Template interfaces for video processing, tracking, messaging
5. **Agent skills**: agentskills.io spec for adding domain-specific capabilities
6. **Developer/industry profiles**: Pre-configured microservice bundles

---

## Key Findings for Red Hat Platform

### 1. Three-Tier Architecture is the Pattern

The RT feature extraction → analytics enrichment → agentic reasoning decomposition is clean and reusable. Each tier scales independently. Red Hat could replicate this with: GStreamer + vLLM (Tier 1), custom analytics services (Tier 2), MCP-based agents (Tier 3).

### 2. Message Broker as Integration Backbone

Kafka/Redis with well-defined topic taxonomy is the glue. This is standard infrastructure Red Hat already supports (AMQ Streams / Strimzi).

### 3. DeepStream is GStreamer + NVIDIA plugins

The core pipeline is GStreamer. The NVIDIA value-add is hardware-accelerated plugins (NVDEC, nvinfer, nvtracker). A vendor-agnostic alternative would use GStreamer with open-source or partner inference plugins.

### 4. VIOS is the Missing Piece

Video IO & Storage (NVStreamer + 6 REST APIs) handles camera management, recording, playback, proxy. This is infrastructure that any video analytics platform needs and is not NVIDIA-specific.

### 5. Security Model is Absent

VSS assumes deployment in trusted, isolated network. No built-in auth. This is a differentiation opportunity for Red Hat (RBAC, TLS, audit logging from OpenShift).
