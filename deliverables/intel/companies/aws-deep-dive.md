# AWS (Amazon Web Services) — Deep Dive Research

**Date**: 2026-10-03
**Last updated**: 2026-10-03
**Classification**: Internal analysis — not for public repo

Supporting research for the [AWS competitive profile](aws.md). This document covers the six-capability reference architecture, Strands Agents/Robots technical architecture, service deprecation history, and the edge-cloud System 1/System 2 pattern.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2006 | AWS launches S3 and EC2 — foundational cloud infrastructure |
| 2017-11 | SageMaker launched at re:Invent — managed ML training and deployment |
| 2018-11 | AWS RoboMaker launched — cloud robotics simulation and deployment (Gazebo-based) |
| 2020-12 | IoT Greengrass V2 released — redesigned edge runtime with component-based architecture |
| 2021-11 | IoT TwinMaker launched at re:Invent — digital twin service with 3D visualization |
| 2023-11 | SageMaker HyperPod launched — managed GPU clusters for distributed training |
| 2024-08 | Amazon acqui-hires Covariant (Pieter Abbeel, ~$400M) for internal warehouse robotics |
| 2025-05 | Strands Agents SDK released (Apache 2.0) — open-source agent framework |
| 2025-07 | Strands Agents v1.0 + Bedrock AgentCore launched — production agent infrastructure |
| 2025-09 | AWS RoboMaker deprecated — users directed to ParallelCluster or Batch for simulation |
| 2025-11 | re:Invent 2025: Strands TypeScript SDK, evaluations, streaming, HyperPod EKS integration |
| 2026-01 | SageMaker HyperPod EKS GA — K8s-native GPU training with health checks and auto-resume |
| 2026-04 | IoT FleetWise end-of-life announced (closing Apr 2027) |
| 2026-06 | IoT Greengrass V1 fully sunset |
| 2026-06 | Physical AI Blog launched — ~10 posts, mostly partner spotlights |
| 2026-08 | Strands Labs launched with Strands Robots (experimental) — physical hardware integration |
| 2026-08 | Strands Robots + LeRobot + GR00T demo at AWS summit — SO-101 arm + Spot quadruped |
| 2026-09 | p6-b300.48xlarge instances GA — B300 × 8, $148.54/hr on-demand |

### Acquisitions — What Each Brought

#### Covariant (2024)

- **Price**: ~$400M (reverse acqui-hire, below $625M last valuation)
- **Technology**: RFM-1 robotic foundation model, years of real-world pick trajectory data from 100+ warehouse deployments
- **Integration**: Internal Amazon Robotics only — powers DeepFleet and next-gen warehouse manipulation. Not exposed as AWS service
- **Significance**: Validates foundation model approach to manipulation but confirms AWS's "internal vs external" split: Amazon Robotics is captive, AWS is the platform

---

## 2. Product Architecture Details

### Six-Capability Reference Architecture

AWS structures its Physical AI story around a six-layer reference architecture. This is a marketing framework (from the Physical AI Blog, mid-2026) but maps cleanly to actual services:

| Layer | Capability | AWS Services | Partners |
| --- | --- | --- | --- |
| 1 | **Connect & Digitize** | IoT SiteWise, IoT Core, Kinesis Video Streams | Config Intelligence (3D scanning), Edge Impulse (TinyML) |
| 2 | **Store & Structure** | S3, Timestream, Lake Formation, Glue | Hugging Face Hub (model/dataset storage) |
| 3 | **Segment & Understand** | Bedrock (VLMs), Rekognition, SageMaker Processing | Anthropic (Claude), Meta (Llama) |
| 4 | **Simulate / Train / Optimize** | SageMaker HyperPod, EC2 GPU (G6e, P5, P6), Batch, ParallelCluster | NVIDIA (Isaac Sim, Cosmos), Physical Intelligence (π0) |
| 5 | **Deploy & Manage** | SageMaker Endpoints, EKS, Bedrock AgentCore | Strands Agents (OSS) |
| 6 | **Edge Inference** | Greengrass V2, IoT Core, Kinesis Video Streams | NVIDIA (Jetson), Qualcomm, edge hardware vendors |

### SageMaker HyperPod

| Aspect | Details |
| --- | --- |
| **Architecture** | Managed GPU cluster on EKS. Auto-detects node failures, replaces unhealthy instances, resumes training from checkpoint. Integrates FSDP, DeepSpeed, NeMo as training backends |
| **Runtime dependencies** | EKS (K8s), EC2 GPU instances (P5/P6/Trn2), S3 for checkpoints, VPC networking |
| **Extension model** | Standard K8s — custom training jobs via Helm charts, SageMaker SDK, or kubectl |
| **Key limitations** | AWS-only. No on-prem or multi-cloud option. GPU scheduling is AWS-proprietary (not Kueue/Volcano) |

### Amazon Bedrock + AgentCore

| Aspect | Details |
| --- | --- |
| **Architecture** | Multi-provider MaaS with tool-use / function calling. AgentCore adds: Memory (spatial/temporal context, fleet-shared), Observability (CloudWatch traces of agent execution paths), secure sandboxed execution |
| **Runtime dependencies** | AWS cloud (Bedrock endpoints, CloudWatch, DynamoDB for memory) |
| **Extension model** | Strands Agents SDK (open, pluggable) for agent logic; AgentCore for production infrastructure |
| **Key limitations** | AgentCore is cloud-only — edge agents must use local models (Ollama/llama.cpp) with periodic cloud sync. No on-prem AgentCore deployment |

### Strands Agents + Strands Robots

| Aspect | Details |
| --- | --- |
| **Architecture** | Model-driven agent SDK. Single `Agent(model, tools)` constructor. Strands Robots adds `Robot()` class wrapping hardware config (robot type, cameras, serial ports). Same code runs in MuJoCo sim or on real hardware via `mode="real"` switch |
| **Runtime dependencies** | Python 3.10+, any LLM backend (Bedrock, Ollama, llama.cpp, MLX). Robots: LeRobot, MuJoCo, optional ROS 2 |
| **Extension model** | AgentTools — any Python function becomes a tool. LeRobot policies as tools. GR00T VLA as tool. Zenoh mesh for multi-robot coordination |
| **Key limitations** | Experimental (strands-labs org, 166 GitHub stars). Limited hardware support (SO-101, Spot). No safety certification. Zenoh mesh not production-hardened |

### Edge-Cloud System 1/System 2 Architecture

AWS explicitly invokes Kahneman's framework to justify their edge-cloud split:

| | System 1 (Edge) | System 2 (Cloud) |
| --- | --- | --- |
| **Analogy** | Fast, instinctual responses | Deliberate reasoning, planning |
| **Latency** | Milliseconds (catching a ball, obstacle avoidance) | Seconds (task decomposition, fleet coordination) |
| **Models** | VLA (GR00T), small VLMs (Qwen3-VL 2B via Ollama) | Large LLMs (Claude Sonnet 4.5 via Bedrock) |
| **Hardware** | NVIDIA Jetson, embedded devices | EC2 GPU instances, Bedrock endpoints |
| **Examples** | Gripper force control, balance maintenance | "Prepare breakfast" planning, dietary preference recall |
| **AWS services** | Greengrass V2 (runtime), Strands + local model | Bedrock (MaaS), AgentCore (memory, observability) |

The key insight: edge agents run local models for real-time control but delegate complex planning to cloud agents via tool calls (`plan_task` tool → Claude agent). The cloud agent coordinates multi-robot workflows while each edge robot maintains autonomous real-time control.

### IoT Service Stack (Active)

| Service | Function | Status |
| --- | --- | --- |
| **IoT Greengrass V2** | Edge runtime — local Lambda, ML inference, OTA deployment | Active (V1 sunset Jun 2026) |
| **IoT TwinMaker** | Digital twin — 3D scenes, data connectors, Grafana plugin | Active |
| **IoT SiteWise** | Industrial telemetry — OPC-UA ingestion, asset modeling, edge gateway | Active |
| **IoT Core** | MQTT message broker — device-to-cloud messaging | Active |
| **Kinesis Video Streams** | Video ingestion — WebRTC, HLS, ML integration | Active |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Strands Agents** | Strands Agents SDK | Apache 2.0 | Bedrock model integration, AgentCore production deployment |
| **Strands Robots** | strands-labs/robots | Apache 2.0 | Integration with LeRobot, GR00T, Zenoh. Experimental |
| **SageMaker HyperPod** | Kubernetes (EKS), FSDP, DeepSpeed, NeMo | Mixed OSS | Managed cluster lifecycle, health checks, auto-resume, GPU scheduling |
| **EKS** | Kubernetes | Apache 2.0 | Managed control plane, Fargate integration, Karpenter (Apache 2.0) |
| **Amazon Linux 2023** | Fedora | MIT/various | AWS-maintained, optimized for EC2, no external governance body |
| **Bedrock** | None (proprietary) | — | Multi-model API, guardrails, knowledge bases, agents |
| **IoT Greengrass V2** | None (proprietary) | — | Edge Lambda runtime, component-based deployment |
| **IoT TwinMaker** | Grafana (visualization plugin) | Apache 2.0 (Grafana) | 3D scene composer, data connectors, entity modeling |

### Pattern Analysis

AWS follows an **"open SDK, proprietary infrastructure"** pattern — the developer-facing SDK (Strands Agents) is genuinely open-source under Apache 2.0, but the production deployment infrastructure (Bedrock AgentCore, SageMaker, Greengrass) is proprietary and cloud-locked. This mirrors the pattern seen in NVIDIA (open Isaac Lab, proprietary Omniverse Kit) and Google (open TensorFlow, proprietary Vertex AI), but AWS is more aggressive with the open layer — Strands Agents runs on any LLM backend, not just Bedrock.

The critical difference from NVIDIA: AWS does not build the application-layer components (simulation engines, physics engines, foundation models). It builds the infrastructure those components run on. This makes AWS less of a direct competitor and more of a distribution channel — the same NVIDIA Isaac Sim runs on AWS EC2 as on a local workstation.

### Notable Dependencies

- **Strands Robots depends on LeRobot** (Hugging Face, Apache 2.0) for robot data collection, model training, and hardware abstraction
- **Strands Robots depends on GR00T** (NVIDIA) for VLA inference on edge — creates a transitive dependency on NVIDIA's model ecosystem
- **SageMaker HyperPod EKS** validates that GPU training clusters converge on Kubernetes as the scheduling layer — supports Red Hat's OpenShift AI positioning

---

## 4. Governance & Community Risk

### Strands Agents Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | Single-vendor (AWS). No foundation governance |
| **Core maintainer employment** | All core maintainers are AWS employees |
| **CLA/DCO** | DCO (sign-off) |
| **Commit diversity** | AWS-dominated. Community contributions are growing but early-stage |
| **Abandonment risk** | Medium — AWS has a pattern of deprecating services (RoboMaker, FleetWise). Strands Agents is more strategic (ties to Bedrock revenue) but the Robots extension is explicitly experimental |

### Strands Robots Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | strands-labs GitHub org (AWS experimental). Not even in main strands-agents org |
| **Core maintainer employment** | AWS employees |
| **CLA/DCO** | DCO |
| **Commit diversity** | Minimal external contributions. 166 GitHub stars (as of Sep 2026) |
| **Abandonment risk** | High — experimental label, separate org, low community traction. Could be abandoned like RoboMaker if it doesn't gain adoption |

---

## 5. Hardware Platform Details

### GPU Instance Lineup for Physical AI

| Instance | GPU | Count | GPU Memory | On-Demand $/hr | Physical AI Use |
| --- | --- | --- | --- | --- | --- |
| **p5.48xlarge** | H100 SXM | 8 | 640 GB | $54.92 | VLA fine-tuning (π0, GR00T), RL training |
| **p6-b300.48xlarge** | B300 | 8 | 1.5 TB | $148.54 | Large-scale Cosmos training, multi-agent world models |
| **g6e.48xlarge** | L40S | 8 | 384 GB | ~$24 | Isaac Sim rendering, synthetic data generation |
| **trn2.48xlarge** | Trainium 2 | 16 | 512 GB | ~$22 | Alternative to NVIDIA for training (Neuron SDK required) |

### Custom Silicon

- **Trainium 2**: AWS's custom training chip. 2nd-gen, up to 16 chips per instance. Requires Neuron SDK (proprietary compiler). Used by Wayve for world model training (notable defection from NVIDIA ecosystem)
- **Inferentia 2**: Custom inference chip. Lower cost than GPU for supported models. Limited model compatibility vs NVIDIA

### Pricing

SageMaker HyperPod adds ~20% premium over raw EC2 for managed lifecycle features. Spot instances available at 60-90% discount for fault-tolerant training. Reserved instances (1-year) reduce on-demand cost by ~40%.

---

## 6. Partnership & Ecosystem Details

| Partner | Deal Details | Integration Depth |
| --- | --- | --- |
| **NVIDIA** | Isaac Sim AMIs on EC2 G6e, Cosmos 3 training on HyperPod, GR00T on Jetson edge | API-level — AWS provides compute, NVIDIA provides application |
| **Physical Intelligence** | π0 fine-tuning reference architecture on HyperPod | Co-developed reference architecture |
| **Hugging Face** | LeRobot integration in Strands Robots, Hub for model/dataset storage | SDK-level — deep API integration |
| **Rockwell Automation** | FactoryTalk + IoT SiteWise for connected factory | API-level — data connectors |
| **Telexistence** | Convenience-store manipulation robots on AWS | Customer spotlight |
| **Luminous Robotics** | Agricultural robots with edge inference | Customer spotlight |
| **Config Intelligence** | 3D scanning to digital twin on AWS | Customer spotlight |
| **RLWRLD** | Reinforcement learning platform on SageMaker | Partner solution |
| **Wayve** | World model training on Trainium 2 | Strategic — validates Trainium for Physical AI |

### Developer Ecosystem

- **Strands Agents**: ~5,000 GitHub stars (main SDK), active Discord community, weekly office hours
- **Strands Robots**: 166 GitHub stars (experimental), growing LeRobot integration community
- **AWS Physical AI Blog**: ~10 posts since Jun 2026, primarily partner spotlights and reference architectures
- **re:Invent sessions**: Dedicated Physical AI track since 2025

---

## 7. Detailed Competitive Analysis

### vs NVIDIA

| Dimension | AWS | NVIDIA |
| --- | --- | --- |
| **Positioning** | Horizontal compute substrate | Vertical, silicon-to-model |
| **Simulation** | Hosts Isaac Sim on EC2 (no own engine) | Isaac Sim + Newton (owns the stack) |
| **Foundation models** | Hosts third-party via Bedrock | GR00T, Cosmos (builds own models) |
| **Training infra** | SageMaker HyperPod (managed K8s) | DGX Cloud (managed NVIDIA clusters) |
| **Edge** | Greengrass V2 (software runtime) | Jetson Thor (silicon + L4T OS) |
| **Agent framework** | Strands Agents (Apache 2.0, any LLM) | None (relies on partners like LangChain) |
| **Lock-in mechanism** | Cloud services (SageMaker, Bedrock) | Silicon + CUDA + proprietary SDKs |
| **OSS strategy** | Open SDK, proprietary infrastructure | Open training frameworks, proprietary runtime |
| **Revenue model** | Compute consumption ($/hr, $/token) | Silicon sales + NVAIE subscriptions |
| **Relationship** | Partner — AWS is NVIDIA's largest cloud channel | Partner — NVIDIA supplies application layer |

### vs Azure (Microsoft)

| Dimension | AWS | Azure |
| --- | --- | --- |
| **Industrial IoT** | IoT SiteWise + TwinMaker | Azure Digital Twins + IoT Hub (deeper Siemens partnership) |
| **Simulation** | Hosts partner engines on EC2 | Project AirSim successor, Autonomous Systems <!-- TODO: verify AirSim successor status --> |
| **Robotics** | Deprecated RoboMaker; Strands Robots experimental | No direct robotics service |
| **Agent framework** | Strands Agents (Apache 2.0) | AutoGen (Microsoft Research, MIT) |
| **Training** | SageMaker HyperPod | Azure ML Compute <!-- TODO: deep research needed --> |
| **Edge** | Greengrass V2 | Azure IoT Edge (more enterprise adoption) |
| **Enterprise positioning** | Strong in startups and cloud-native | Stronger in enterprise/industrial (Siemens, ABB partnerships) |

### Service Deprecation History

A pattern worth monitoring — AWS has deprecated multiple Physical AI-adjacent services:

| Service | Launched | Deprecated/Closing | Replacement |
| --- | --- | --- | --- |
| **AWS RoboMaker** | 2018 | Sep 2025 | ParallelCluster / Batch (DIY simulation) |
| **IoT FleetWise** | 2022 | Apr 2027 (announced Apr 2026) | None specified |
| **IoT Greengrass V1** | 2017 | Jun 2026 | Greengrass V2 (breaking change) |

This pattern signals that AWS will exit services that don't reach scale. Customers building critical infrastructure on AWS IoT services face platform risk.

---

## Sources

- [AWS Physical AI Blog](https://aws.amazon.com/blogs/physical-ai/)
- [Building intelligent physical AI: From edge to cloud with Strands Agents](https://aws.amazon.com/blogs/opensource/building-intelligent-physical-ai-from-edge-to-cloud-with-strands-agents-bedrock-agentcore-claude-4-5-nvidia-gr00t-and-hugging-face-lerobot/)
- [Strands Agents SDK](https://strandsagents.com/)
- [Strands Robots GitHub](https://github.com/strands-labs/robots)
- [From Hub to robot hardware — Hugging Face blog](https://huggingface.co/blog/amazon/strands-lerobot-hub-to-hardware)
- [Robots working together: Model Hardware Standard — Strands blog](https://strandsagents.com/blog/robots-working-together-model-hardware-standard-strands-robots/)
- [Introducing Strands Labs — AWS Open Source Blog](https://aws.amazon.com/blogs/opensource/introducing-strands-labs-get-hands-on-today-with-state-of-the-art-experimental-approaches-to-agentic-development/)
- [SageMaker HyperPod documentation](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod.html)
- [Amazon Bedrock documentation](https://docs.aws.amazon.com/bedrock/)
- [IoT Greengrass V2 documentation](https://docs.aws.amazon.com/greengrass/)
- [IoT TwinMaker documentation](https://docs.aws.amazon.com/iot-twinmaker/)
- [AWS RoboMaker deprecation notice](https://docs.aws.amazon.com/robomaker/)
- [EC2 GPU instance pricing](https://aws.amazon.com/ec2/pricing/on-demand/)
