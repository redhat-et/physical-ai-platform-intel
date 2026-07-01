# Physical AI Platform — OSS Landscape

**Date**: 2026-06-18
**Classification**: Internal analysis — not for public repo

Candidate open-source projects for each block in the Physical AI Platform architecture. Organized by architecture layer. For each project: license, community size (stars), and one-line description.

---

## Training & Evaluation

### Robot Policy Training Frameworks

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [LeRobot](https://github.com/huggingface/lerobot) | Apache-2.0 | ~25K | HuggingFace's end-to-end robot learning library; trains ACT, Diffusion Policy, TDMPC2, SmolVLA; unified dataset format; de facto community hub |
| [OpenPI](https://github.com/Physical-Intelligence/openpi) | Apache-2.0 | ~12K | Physical Intelligence's pi0/pi0-FAST/pi0.5 VLA models; JAX + PyTorch; strongest pretrained VLA weights |
| [OpenVLA](https://github.com/openvla/openvla) | MIT | ~3K | 7B-param VLA pretrained on 970K episodes from Open X-Embodiment; runs on single A100; LoRA fine-tuning |
| [Octo](https://github.com/octo-models/octo) | MIT | ~1.6K | Transformer diffusion policy trained on 800K trajectories; Octo-Small (27M) and Octo-Base (93M); JAX-based |
| [RLinf](https://github.com/RLinf/RLinf) | Apache-2.0 | ~3.7K | Tsinghua's RL infrastructure for embodied AI; PPO/GRPO/SAC; validated on ManiSkill, LIBERO; scales to 256 H100 GPUs |

### Simulation Engines

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [Genesis World](https://github.com/Genesis-Embodied-AI/Genesis) | Apache-2.0 | ~29K | Hardware-portable (CUDA+ROCm+Metal+Vulkan); differentiable; multi-physics; Python-native |
| [MuJoCo](https://github.com/google-deepmind/mujoco) | Apache-2.0 | ~8K | Google DeepMind's physics engine; MJX for GPU-accelerated JAX backend |
| [Newton](https://github.com/newton-physics/newton) | Apache-2.0 | ~5K | NVIDIA/DeepMind/Disney; wraps MuJoCo-Warp + NVIDIA Warp; multi-physics coupling; Linux Foundation governed. GPU requires NVIDIA (CUDA) |
| [Isaac Lab](https://github.com/isaac-sim/IsaacLab) | BSD-3 | ~3K | NVIDIA's robot learning framework; depends on Isaac Sim (proprietary rendering via Kit SDK/RTX) at runtime |
| [PyBullet](https://github.com/bulletphysics/bullet3) | zlib | ~12K | Erwin Coumans' physics engine; lightweight; CPU-based; mature but less active development |
| [robosuite](https://github.com/ARISE-Initiative/robosuite) | MIT | ~2.5K | MuJoCo-based manipulation sim; underlies RoboCasa, MimicGen, LIBERO |

### Policy Evaluation & Benchmarks

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [RoboVerse](https://github.com/RoboVerseOrg/RoboVerse) | Apache-2.0 | ~1.5K | Unified eval across 8+ simulators (Isaac Lab, MuJoCo, SAPIEN); MetaSim abstraction layer |
| [LIBERO](https://github.com/Lifelong-Robot-Learning/LIBERO) | MIT | ~500 | 130 tasks in 4 suites; de facto standard VLA benchmark; robosuite-based |
| [SimplerEnv](https://github.com/simpler-env/SimplerEnv) | MIT | ~500 | Sim-based eval of real-world policies; SAPIEN-based; 1500+ paired sim-real evaluations |
| [RoboArena](https://github.com/robo-arena/roboarena) | MIT | new | Distributed real-world eval via crowd-sourced pairwise comparisons across 7 institutions |
| [lm-eval-harness](https://github.com/EleutherAI/lm-evaluation-harness) | MIT | ~8K | LLM evaluation standard; 60+ benchmarks; used by NeMo Evaluator under the hood |

### Data Curation & Datasets

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [Open X-Embodiment](https://github.com/google-deepmind/open_x_embodiment) | Apache-2.0 | ~1.7K | Largest open real-robot dataset: 1M+ trajectories, 22 embodiments, 60 source datasets |
| [DROID](https://github.com/droid-dataset/droid) | CC-BY 4.0 | ~300 | 76K in-the-wild manipulation trajectories across 564 scenes; standardized Franka hardware |
| [RoboCasa](https://github.com/robocasa/robocasa) | MIT | ~1.4K | Large-scale sim framework; 365 tasks, 2500+ kitchen scenes, 2200+ hours of demo data |
| [MimicGen](https://github.com/NVlabs/mimicgen) | NVIDIA Source Code | ~550 | Generates 50K+ demos from <200 human demos; simulator-agnostic; used by GR00T N1 |
| [Cosmos-Curate](https://github.com/nvidia-cosmos/cosmos-curate) | Apache-2.0 | ~100 | GPU-accelerated video curation pipeline built on Ray; powers Cosmos WFM training data |
| [Docling](https://github.com/DS4SD/docling) | MIT | ~20K | IBM's document extraction for LLM training data; not Physical AI-specific |

### LLM Eval & Benchmarks

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [lm-eval-harness](https://github.com/EleutherAI/lm-evaluation-harness) | MIT | ~8K | Community standard for LLM benchmarks (MMLU, GSM8K, etc.) |
| [VLMEvalKit](https://github.com/open-compass/VLMEvalKit) | Apache-2.0 | ~3K | Vision-language model evaluation (OpenCompass) |
| [BigCode Eval Harness](https://github.com/bigcode-project/bigcode-evaluation-harness) | Apache-2.0 | ~500 | Code generation benchmarks (HumanEval, MBPP) |

### Training Infrastructure

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [KubeFlow Training Operator](https://github.com/kubeflow/training-operator) | Apache-2.0 | ~1.5K | K8s operator for distributed training jobs (PyTorchJob, MPIJob, etc.) |
| [PyTorch](https://github.com/pytorch/pytorch) | BSD-3 | ~87K | Core DL framework; used by virtually all Physical AI projects |
| [DeepSpeed](https://github.com/microsoft/DeepSpeed) | Apache-2.0 | ~36K | Microsoft's distributed training library; ZeRO optimizer, pipeline parallelism |
| [Ray / KubeRay](https://github.com/ray-project/ray) | Apache-2.0 | ~35K | Distributed compute framework; used by LeRobot, Cosmos, GR00T for training orchestration |
| [Megatron-Core](https://github.com/NVIDIA/Megatron-LM) | Apache-2.0 | ~11K | NVIDIA's large-scale training library; tensor/pipeline/expert parallelism; FP8 |

---

## AI Model & Data Lifecycle (MLOps)

### Model Registry

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [KubeFlow Model Registry](https://github.com/kubeflow/model-registry) | Apache-2.0 | ~200 | K8s-native model registry with ML Metadata backend |
| [MLflow Model Registry](https://github.com/mlflow/mlflow) | Apache-2.0 | ~20K | Part of MLflow; model versioning, staging, deployment lifecycle |
| [HuggingFace Hub](https://huggingface.co/) | Apache-2.0 | — | De facto community model registry; used by LeRobot, GR00T, Cosmos for model distribution |

### ML Pipelines

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [KubeFlow Pipelines](https://github.com/kubeflow/pipelines) | Apache-2.0 | ~3.6K | K8s-native ML pipeline orchestration; DAG-based; Argo Workflows underneath |
| [Argo Workflows](https://github.com/argoproj/argo-workflows) | Apache-2.0 | ~15K | General-purpose K8s workflow engine; CNCF graduated |
| [OSMO](https://github.com/NVIDIA/OSMO) | Apache-2.0 | new | NVIDIA's Physical AI pipeline orchestrator (sim→train→eval→deploy); custom engine, not based on Argo |

### CI/CD & GitOps

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [Tekton](https://github.com/tektoncd/pipeline) | Apache-2.0 | ~8.5K | K8s-native CI/CD pipelines; CNCF project |
| [ArgoCD](https://github.com/argoproj/argo-cd) | Apache-2.0 | ~18K | K8s-native GitOps; CNCF graduated |

### Experiment Tracking

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [MLflow](https://github.com/mlflow/mlflow) | Apache-2.0 | ~20K | Experiment tracking, model registry, deployment; Tech Preview in RHOAI 3.4 |
| [Weights & Biases](https://wandb.ai/) | Proprietary | — | Dominant in research; used by NVIDIA (GR00T, NeMo); proprietary SaaS |
| [TensorBoard](https://github.com/tensorflow/tensorboard) | Apache-2.0 | ~6.5K | Basic experiment visualization; supported by all major frameworks |

### Observability & Monitoring

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [Prometheus](https://github.com/prometheus/prometheus) | Apache-2.0 | ~56K | Metrics collection and alerting; CNCF graduated |
| [OpenTelemetry](https://opentelemetry.io/) | Apache-2.0 | — | Unified observability framework (traces, metrics, logs); CNCF |
| [Perses](https://github.com/perses/perses) | Apache-2.0 | ~1K | CNCF dashboarding; Grafana alternative with GitOps-native config |
| [MCAP](https://github.com/foxglove/mcap) | MIT | ~940 | Open multimodal log format; default in ROS 2 Iron+; serialization-agnostic |
| [Foxglove](https://foxglove.dev/) | Proprietary | — | Robot fleet observability platform; Studio visualization closed-source since 2024; MCAP creator |
| [DCGM Exporter](https://github.com/NVIDIA/dcgm-exporter) | Apache-2.0 | ~500 | GPU metrics → Prometheus; ships with GPU Operator |
| [TrustyAI](https://github.com/trustyai-explainability) | Apache-2.0 | ~100 | AI fairness, explainability, bias detection; shipped in RHOAI |

### Guardrails & Safety

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [NeMo Guardrails](https://github.com/NVIDIA/NeMo-Guardrails) | Apache-2.0 | ~4K | Content safety, topic control; Colang DSL; depends on LangChain; works with any LLM |
| [RoboGuard](https://github.com/KumarRobotics/RoboGuard) | — | new | Safety guardrails for LLM-enabled robots; temporal logic constraints; research prototype |
| [Guardrails AI](https://github.com/guardrails-ai/guardrails) | Apache-2.0 | ~4K | Validation framework for LLM outputs; not robotics-specific |

---

## Inference

### Inference Servers

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [vLLM](https://github.com/vllm-project/vllm) | Apache-2.0 | ~50K | High-throughput LLM inference; PyTorch Foundation; used by NIM 2.0 under the hood |
| vLLM-Omni | Apache-2.0 | (in vLLM) | Developer preview extending vLLM to diffusion transformers, any-to-any modality, robotics policies (RFC #1987) |
| [SGLang](https://github.com/sgl-project/sglang) | Apache-2.0 | ~10K | Alternative LLM serving engine; structured generation; RadixAttention |
| [llama.cpp](https://github.com/ggml-org/llama.cpp) | MIT | ~75K | CPU/GPU inference for GGUF-quantized models; edge deployment |
| [ONNX Runtime](https://github.com/microsoft/onnxruntime) | MIT | ~15K | Cross-platform inference; broad hardware support; edge-optimized |
| [ExecuTorch](https://github.com/pytorch/executorch) | BSD-3 | ~3K | PyTorch's on-device inference framework; mobile/edge focus |
| [Triton Inference Server](https://github.com/triton-inference-server/server) | BSD-3 | ~8K | NVIDIA's multi-framework model server; used by NIM for embeddings |

### Distributed Inference

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [llm-d](https://github.com/llm-d/llm-d) | Apache-2.0 | new | Red Hat's distributed inference gateway; KV-cache-aware routing; K8s-native |

### Model Routing & Serving

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [KServe](https://github.com/kserve/kserve) | Apache-2.0 | ~3.5K | K8s model serving with autoscaling, canary, multi-model serving; CNCF |

### Agentic Frameworks

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [Kagenti](https://github.com/kagenti/kagenti) | Apache-2.0 | ~110 | Red Hat-backed K8s-native agent platform; A2A protocol, MCP Gateway, AuthBridge zero-trust (SPIFFE/SPIRE + Keycloak); framework-neutral (LangGraph, CrewAI, AG2); AgentCard CRDs for lifecycle |
| [kagent](https://github.com/kagent-dev/kagent) | Apache-2.0 | ~3K | Solo.io/Istio-founders' K8s-native agent runtime; CNCF Sandbox; CRD-based lifecycle, long-term memory, human-in-the-loop |
| [EmbodiedAgents (EMOS)](https://github.com/automatika-robotics/embodied-agents) | MIT | ~200 | ROS 2 native; LLM/VLM/VLA integration; edge-optimized (Jetson); most mature embodied option |
| [mbodied](https://github.com/mbodiai/embodied-agents) | Apache-2.0 | ~285 | Multi-modal model integration into robot stacks; experimental |

### Agent Security & Sandboxing

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [OpenShell](https://github.com/NVIDIA/OpenShell) | Apache-2.0 | — | Secure agent sandbox runtime; used by both NVIDIA NemoClaw and Red Hat Kagenti; managed inference, policy management, sandbox monitoring |

---

## Platform

### Robotics Libraries

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [ROS 2](https://github.com/ros2) | Apache-2.0 | — | De facto robot middleware standard; Jazzy (current LTS) |
| [MoveIt 2](https://github.com/moveit/moveit2) | BSD-3 | ~3K | Motion planning framework for ROS 2; manipulation-focused |
| [Nav2](https://github.com/ros-navigation/navigation2) | Apache-2.0 | ~2.5K | Navigation stack for ROS 2; mobile robot navigation |
| [ros2_control](https://github.com/ros-controls/ros2_control) | Apache-2.0 | ~500 | Hardware abstraction + controller framework for ROS 2 |
| [Pinocchio](https://github.com/stack-of-tasks/pinocchio) | BSD-2 | ~2K | Rigid-body dynamics; used by Isaac Lab for IK (via pin-pink) |
| [LeRobot PolicyServer](https://github.com/huggingface/lerobot) | Apache-2.0 | (in LeRobot) | gRPC server for deploying trained policies to real robots |

### Media Libraries

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [GStreamer](https://gstreamer.freedesktop.org/) | LGPL-2.1 | — | Multimedia pipeline framework; RTSP, V4L2, WebRTC; streaming sensor input |
| [FFmpeg](https://github.com/FFmpeg/FFmpeg) | LGPL/GPL | ~48K | Universal media processing; video encode/decode; used by Cosmos data pipeline |

### Fleet Management

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [FlightCtl](https://github.com/flightctl/flightctl) | Apache-2.0 | ~200 | Red Hat's edge device fleet manager (RHEM); manages RHEL devices at scale |
| [ACM](https://www.redhat.com/en/technologies/management/advanced-cluster-management) | Proprietary | — | Red Hat's multi-cluster K8s management |
| [Ansible](https://github.com/ansible/ansible) | GPL-3.0 | ~63K | Automation platform; configuration management, deployment |

### Container Runtimes & Orchestration

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift) | (K8s: Apache-2.0) | — | Red Hat's enterprise K8s platform |
| [Podman](https://github.com/containers/podman) | Apache-2.0 | ~24K | Daemonless container engine; edge device runtime |
| [MicroShift](https://github.com/openshift/microshift) | Apache-2.0 | ~200 | Lightweight OpenShift for edge devices |

### GPU Infrastructure

| Project | License | Stars | Description |
| --- | --- | --- | --- |
| [GPU Operator](https://github.com/NVIDIA/gpu-operator) | Apache-2.0 | ~700 | NVIDIA's K8s operator for GPU lifecycle; bundles NFD, device plugin, DCGM |
| [KAI Scheduler](https://github.com/NVIDIA/KAI-Scheduler) | Apache-2.0 | new | OSS core of Run:ai; forked from kube-batch (2019); CNCF Sandbox |
| [Kueue](https://github.com/kubernetes-sigs/kueue) | Apache-2.0 | ~1.5K | K8s-native job queueing; Red Hat's strategic GPU scheduling path |

---

## Identified Gaps

| Gap | Description | Nearest Option |
| --- | --- | --- |
| **Physical AI pipeline orchestration** | No OSS sim→train→eval→deploy orchestrator | OSMO (Apache-2.0, custom engine); or compose KubeFlow Pipelines + Argo |
| **Robot safety guardrails** | No production-grade safety framework for robot policy deployment | RoboGuard (research prototype) |
| **Robot fleet observability** | No fully OSS equivalent to Foxglove's fleet-level platform | MCAP (format only) + Prometheus + custom dashboards |
| **Embodied agentic framework** | Kagenti (Red Hat) + kagent (CNCF Sandbox) address K8s-native agent lifecycle; OpenShell provides sandboxing. Gap narrows to Physical AI-specific extensions (embodied identity, physical safety) | Kagenti + OpenShell (platform); EmbodiedAgents/EMOS (embodied-specific) |

---

## Key Observations

1. **LeRobot is the gravitational center** of OSS robot learning, analogous to HuggingFace Transformers for NLP. It integrates training, evaluation, data formats, and deployment (PolicyServer). However, the original creator and co-creator departed in late 2025 (founding UMA Robots), taking 31% of commit history. The 58K+ dataset ecosystem creates strong HF Hub lock-in. See [deep dive](oss-landscape-deep-dive.md#lerobot).

2. **vLLM anchors inference** across the entire stack — used directly by Red Hat and also under the hood in NVIDIA NIM 2.0, Cosmos serving, and GR00T inference.

3. **MuJoCo/MuJoCo-Warp anchors physics** — used directly as a sim engine and also inside NVIDIA Newton. Genesis World is the most hardware-portable alternative (ROCm, Metal, Vulkan), but its Quadrants compiler depends on unmaintained Taichi. Newton's Linux Foundation governance is more skewed than it appears — NVIDIA controls ~90% of commits despite 2-2-2 TSC. See [deep dive](oss-landscape-deep-dive.md#simulation-engines).

4. **PyTorch is universal** — every training framework (NeMo, LeRobot, OpenPI, Cosmos, GR00T) uses PyTorch. No JAX adoption outside Octo and some Google projects.

5. **The eval landscape is fragmented** — LIBERO is the standard benchmark but showing limitations. RoboVerse is the most promising unification effort.

6. **Safety is embryonic** — RoboGuard is the only dedicated robot policy safety project. This is a greenfield opportunity.

7. **OpenPI weights are NOT Apache-2.0** — model weights are under Google's Gemma Terms of Use, a restrictive non-OSI-approved license. The code is Apache-2.0 but enterprise deployment of weights requires legal review. See [deep dive](oss-landscape-deep-dive.md#openpi-physical-intelligence).

8. **KubeFlow Pipelines is Red Hat's strongest governance position** — Red Hat holds 2 of 5 Steering Committee seats; Google holds zero. This is the natural foundation for Physical AI pipeline orchestration. See [deep dive](oss-landscape-deep-dive.md#kubeflow-pipelines).

9. **Agentic framework gap is closing** — Kagenti (Red Hat-backed, Apache 2.0) provides K8s-native agent lifecycle, A2A/MCP networking, and zero-trust security (SPIFFE/SPIRE + AuthBridge). OpenShell (NVIDIA, Apache 2.0) provides agent sandboxing and is used by both NVIDIA (NemoClaw) and Red Hat (Kagenti). kagent (Solo.io, CNCF Sandbox) is a parallel effort. The remaining gap is Physical AI-specific extensions: embodied agent identity, physical safety guardrails, and real-time constraints.

For detailed project profiles (contributors, governance, lock-in, dependencies, differentiators): see [oss-landscape-deep-dive.md](oss-landscape-deep-dive.md).
