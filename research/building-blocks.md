# Building Blocks

> Platform capability map for Physical AI — the building blocks a platform needs to support

**Last Updated**: 2026-07-12

---

## Latent World Models

**What it does**: Models that predict future states in learned abstract representation spaces (not pixel space), enabling planning and decision-making. Includes JEPA variants, Dreamer, TD-MPC, and similar architectures.

**Domain demand**:

| Domain | Demand |
| --------------------- | --------- |
| Robotics | required |
| Industrial Digital Twins | important |
| Autonomous Vehicles | important |
| Visual AI / Inspection | optional |
| Medical AI | optional |
| Scientific Discovery | important |
| Product Design & Engineering | not needed |
| Molecular Design & Engineering | optional |

**Solution landscape**:

| Category               | Solutions                                   | Maturity  | Notes                             |
| ---------------------- | ------------------------------------------- | --------- | --------------------------------- |
| OSS (community-driven) | LeWorldModel, stable-worldmodel, NE-Dreamer | Early OSS | Active research community         |
| OSS (single-vendor)    | V-JEPA 2/2.1, EB-JEPA, JEPA-WMs             | Early OSS | Meta AI Research controls roadmap |
| Proprietary            | (none identified)                           | —         | —                                 |

**Key trade-offs**: Latent prediction is computationally efficient and focuses on task-relevant dynamics, but representations are harder to interpret and validate. Encoder choice (DINO vs. V-JEPA) determines planning utility — spatial precision vs. temporal coherence.

**Platform fit**: `Partner`

- **Rationale**: Models evolve rapidly; platform should serve/fine-tune them, not build them.
- **Partnership surface**: Model providers (Meta/AMI Labs, research groups); platform provides serving infrastructure (vLLM-Omni) and post-training pipelines.

**Related blocks**: [Video Generation Models](#video-generation--prediction-models), [Robot Foundation Models](#robot-foundation-models), [Simulation Engines](#simulation-engines)
**Key ecosystem players**: [Meta AI](ecosystem.md#meta-ai-fair), [AMI Labs](ecosystem.md#ami-labs), [BeingBeyond](ecosystem.md#beingbeyond), [Sereact](ecosystem.md#sereact)
**Relevant research**: [JEPA concepts](concepts.md#jepa-joint-embedding-predictive-architecture), [publications](publications.md#jepa-joint-embedding-predictive-architecture), [Active Inference concepts](concepts.md#active-inference)

---

## Video Generation / Prediction Models

**What it does**: Models that generate or predict video frames conditioned on text, images, or actions. Produce raw visual observations for training data generation, sim-to-real transfer, and scenario simulation.

**Domain demand**:

| Domain | Demand |
| --------------------- | ---------- |
| Robotics | required |
| Industrial Digital Twins | important |
| Autonomous Vehicles | required |
| Visual AI / Inspection | optional |
| Medical AI | not needed |
| Scientific Discovery | optional |
| Product Design & Engineering | not needed |
| Molecular Design & Engineering | not needed |

**Solution landscape**:

| Category               | Solutions                                             | Maturity         | Notes                                     |
| ---------------------- | ----------------------------------------------------- | ---------------- | ----------------------------------------- |
| OSS (community-driven) | (none identified)                                     | -                | -                                         |
| OSS (single-vendor)    | Cosmos-Predict2.5, Cosmos-Transfer2.5                 | Production-ready | NVIDIA controls; open weights, permissive |
| Proprietary            | Qwen-RobotWorld, GAIA-3, Genie 3, RynnWorld-Teleop    | Early OSS        | Alibaba, Wayve, Google DeepMind           |

**Key trade-offs**: High visual fidelity enables downstream policy training but at significant compute cost (~51 ZFLOPs for full WAM stack vs ~6.9 ZFLOPs for VLA stack). Autoregressive generation drifts over long horizons. Hardware acceleration (CUDA) creates vendor lock-in. Fast-WAM finding suggests video generation may be skippable at inference — pending real-robot validation.

**Platform fit**: `Partner`

- **Rationale**: Extremely compute-intensive; model providers (NVIDIA, Google, Alibaba) have the training infrastructure. Platform provides serving.
- **Partnership surface**: NVIDIA Cosmos (strongest partner — open weights, CUDA-dependent); Qwen-RobotWorld (language-conditioned, multi-embodiment); inference via vLLM-Omni.

**Related blocks**: [Latent World Models](#latent-world-models), [Sim-to-Real Transfer Pipeline](#sim-to-real-transfer-pipeline), [Simulation Engines](#simulation-engines)
**Key ecosystem players**: [NVIDIA](ecosystem.md#nvidia), [Google DeepMind](ecosystem.md#google-deepmind), [Wayve](ecosystem.md#wayve), [Alibaba](ecosystem.md#alibaba-tongyi-lab)
**Relevant research**: [publications](publications.md#world-models--model-based-rl)

---

## Robot Foundation Models

**What it does**: Vision-language-action (VLA) and world-action (WAM) models that translate perception into robot actions. The "brains" of robot manipulation and navigation.

**Domain demand**:

| Domain | Demand |
| --------------------- | ---------- |
| Robotics | required |
| Industrial Digital Twins | not needed |
| Autonomous Vehicles | important |
| Visual AI / Inspection | optional |
| Medical AI | not needed |
| Scientific Discovery | not needed |
| Product Design & Engineering | not needed |
| Molecular Design & Engineering | not needed |

**Solution landscape**:

| Category               | Solutions                                                                             | Maturity  | Notes                                                                        |
| ---------------------- | ------------------------------------------------------------------------------------- | --------- | ---------------------------------------------------------------------------- |
| OSS (community-driven) | OpenVLA, SmolVLA, Spirit-v1.5                                                         | Early OSS | Community-driven open VLA baselines; Spirit-v1.5 #1 on RoboChallenge Table30 |
| OSS (single-vendor)    | GR00T N1.7, OpenPI (pi0/pi0.5/pi0.7), DreamZero, LingBot-VA 2.0                       | Early OSS | NVIDIA, Physical Intelligence, Ant Group                                     |
| Proprietary            | Gemini Robotics, GEN-1, Qwen-RobotManip, Being-H0.7, Cortex 2.0, Robostral Navigate   | Early OSS | Google, Generalist AI, Alibaba, BeingBeyond, Sereact, Mistral AI (nav-only)  |

**Key trade-offs**: VLAs (pi0) leverage internet-scale pretraining but lack physics understanding. WAMs (DreamZero) learn dynamics from video but cost ~7.4x more to train. MoT/MoE emerging as dominant architecture for both VLAs and WAMs. LingBot-VA 2.0 claims 150 Hz WAM inference via sparse MoE, potentially closing the WAM latency gap. VLA+WAM hybrids (Being-H0.7, Cortex 2.0, Pi-0.7) converging. Frontier gap: closed-weight VLAs (Gemini, Pi-0.5) exhibit zero-shot open-world behavior that open-weight models cannot yet match.

**Platform fit**: `Partner`

- **Rationale**: Rapidly evolving; platform provides serving (vLLM-Omni) and fine-tuning infrastructure, not the models themselves.
- **Partnership surface**: NVIDIA (GR00T), Physical Intelligence (OpenPI), Alibaba (Qwen-Robot suite); LeRobot as integration framework.

**Related blocks**: [Latent World Models](#latent-world-models), [Model Serving for Physical AI](#model-serving-for-physical-ai), [Edge AI Inference Runtime](#edge-ai-inference-runtime)
**Key ecosystem players**: [NVIDIA](ecosystem.md#nvidia), [Physical Intelligence](ecosystem.md#physical-intelligence-π), [Google DeepMind](ecosystem.md#google-deepmind), [Alibaba](ecosystem.md#alibaba-tongyi-lab), [BeingBeyond](ecosystem.md#beingbeyond), [Mistral AI](ecosystem.md#mistral-ai), Spirit AI
**Relevant research**: [publications](publications.md#robot-foundation-models)

---

## Robot Middleware

**What it does**: Communication, hardware abstraction, and coordination framework for robot software components. Manages message passing between perception, planning, and control nodes.

**Domain demand**:

| Domain | Demand |
| --------------------- | ---------- |
| Robotics | required |
| Industrial Digital Twins | important |
| Autonomous Vehicles | required |
| Visual AI / Inspection | important |
| Medical AI | optional |
| Scientific Discovery | optional |
| Product Design & Engineering | not needed |
| Molecular Design & Engineering | optional |

**Solution landscape**:

| Category               | Solutions          | Maturity          | Notes                                             |
| ---------------------- | ------------------ | ----------------- | ------------------------------------------------- |
| OSS (community-driven) | ROS2               | Industry standard | Open Robotics / OSRA governance; broad ecosystem  |
| OSS (single-vendor)    | Isaac ROS          | Production-ready  | NVIDIA; accelerated layer on ROS2, CUDA-only      |
| Proprietary            | Various OEM stacks | Production-ready  | ABB, FANUC, KUKA, YASKAWA proprietary controllers |

**Key trade-offs**: ROS2 is the industry standard but lacks enterprise support and hardened security. Isaac ROS adds hardware acceleration but locks to NVIDIA GPUs. Proprietary stacks offer reliability but limit interoperability.

**Platform fit**: `Build`

- **Rationale**: Core platform capability — enterprise-grade ROS2 on Linux is a natural extension of Red Hat Device Edge. Directly competes with NVIDIA Isaac ROS on openness and hardware portability.
- **Partnership surface**: Open Robotics / OSRA (community governance); robot OEMs needing enterprise middleware.

**Related blocks**: [Edge AI Inference Runtime](#edge-ai-inference-runtime), [Robot Fleet Management & Observability](#robot-fleet-management--observability), [Sensor Data Ingestion](#sensor-data-ingestion)
**Key ecosystem players**: [NVIDIA](ecosystem.md#nvidia) (Isaac ROS), Open Robotics (ROS2)
**Relevant research**: (to be populated)

---

## Simulation Engines

**What it does**: Physics simulation environments for training robot policies, validating autonomous systems, and creating digital twins. Generate synthetic experience at scale.

**Dependency layers**: Simulation platforms compose a physics engine (dynamics) and a rendering engine (visuals). Lock-in risk and technical capability propagate from these layers:

| Simulation Platform | Physics Engine     | Rendering Engine | Compute Acceleration           |
| ------------------- | ------------------ | ---------------- | ------------------------------ |
| Isaac Sim / Lab     | PhysX 5            | OptiX / RTX      | CUDA only                      |
| Gazebo (Harmonic)   | Custom (DART/ODE)  | OGRE-Next        | OpenGL, Vulkan; CPU fallback   |
| Genesis World       | Custom (Quadrants) | Nyx              | CUDA, ROCm, Metal, Vulkan, CPU |
| Newton              | MuJoCo Warp        | (via OpenUSD)    | CUDA only                      |
| SAPIEN / ManiSkill  | PhysX 5            | Vulkan           | CUDA, CPU                      |
| Webots              | ODE (custom fork)  | WREN (custom)    | OpenGL; CPU only               |
| MuJoCo Playground   | MuJoCo / MJX       | MuJoCo built-in  | CUDA (via JAX), CPU            |
| Genie 3             | Learned            | Learned          | Google TPU/GPU (proprietary)   |

**Domain demand**:

| Domain | Demand |
| --------------------- | --------- |
| Robotics | required |
| Industrial Digital Twins | required |
| Autonomous Vehicles | required |
| Visual AI / Inspection | important |
| Medical AI | optional |
| Scientific Discovery | required |
| Product Design & Engineering | required |
| Molecular Design & Engineering | required |

**Solution landscape**:

| Category               | Solutions                                      | Maturity         | Notes                                                         |
| ---------------------- | ---------------------------------------------- | ---------------- | ------------------------------------------------------------- |
| OSS (community-driven) | Gazebo, MuJoCo, Genesis World, Webots          | Production-ready | Gazebo: OSRA; MuJoCo: Google; Genesis: Apache 2.0, 29K stars  |
| OSS (multi-vendor)     | Newton                                         | Early OSS        | Linux Foundation; NVIDIA + Google DeepMind + Disney Research  |
| OSS (single-vendor)    | PhysicsNeMo, SAPIEN/ManiSkill, MuJoCo Playgnd  | Production-ready | NVIDIA; Google DeepMind; UC San Diego                         |
| Proprietary            | Isaac Sim, Omniverse, Simulink, Genie 3        | Production-ready | NVIDIA (CUDA-locked), MathWorks, Google DeepMind              |

**Key trade-offs**: Fidelity vs. speed — physics engines (MuJoCo, PhysX) are accurate but slow; learned surrogates (PhysicsNeMo, Genie 3) are fast but approximate. Hardware portability: Isaac Sim and Newton require NVIDIA GPUs; Genesis World compiles to CUDA, ROCm, Metal, Vulkan. Rendering realism: OptiX/RTX (photorealistic, CUDA-locked) vs. OGRE-Next (functional, hardware-portable but limited photorealism) vs. Nyx (photorealistic, multi-backend). The rendering engine is the critical risk factor for sim-to-real transfer of vision-based policies.

**Platform fit**: `Partner` / `Integrate`

- **Rationale**: Platform should run simulation workloads (GPU scheduling, multi-node) but not build simulation engines. Genesis World's hardware portability makes it a strong integration candidate. Newton's Linux Foundation governance is attractive but CUDA-only limits hardware flexibility.
- **Partnership surface**: NVIDIA (Omniverse/Isaac Sim), Genesis AI (Genesis World), Open Robotics (Gazebo), Linux Foundation (Newton).

**Related blocks**: [Sim-to-Real Transfer Pipeline](#sim-to-real-transfer-pipeline), [Post-Training Pipeline](#post-training--fine-tuning-pipeline), [Digital Twin Runtime](#digital-twin-runtime), [Evaluation & Benchmarking](#evaluation--benchmarking)
**Key ecosystem players**: [NVIDIA](ecosystem.md#nvidia), [Genesis AI](ecosystem.md#genesis-ai), [Google DeepMind](ecosystem.md#google-deepmind), Open Robotics
**Relevant research**: (to be populated)

---

## Sim-to-Real Transfer Pipeline

**What it does**: Bridges the gap between simulation-trained models and real-world deployment. Includes domain randomization, style transfer, and validation workflows.

**Domain demand**:

| Domain | Demand |
| --------------------- | ---------- |
| Robotics | required |
| Industrial Digital Twins | important |
| Autonomous Vehicles | required |
| Visual AI / Inspection | important |
| Medical AI | optional |
| Scientific Discovery | optional |
| Product Design & Engineering | not needed |
| Molecular Design & Engineering | not needed |

**Solution landscape**:

| Category               | Solutions              | Maturity         | Notes                                                                                        |
| ---------------------- | ---------------------- | ---------------- | -------------------------------------------------------------------------------------------- |
| OSS (community-driven) | HyperSim, Real-is-Sim  | Early OSS        | Holistic co-training (HyperSim); dynamic digital twin via Gaussian splatting (Real-is-Sim)   |
| OSS (single-vendor)    | Cosmos-Transfer2.5     | Early OSS        | NVIDIA; multi-controlnet approach                                                            |
| Proprietary            | Isaac Sim domain rand. | Production-ready | NVIDIA; built into simulation stack                                                          |

**Key trade-offs**: Style transfer (Cosmos-Transfer) produces visually realistic rollouts but may not preserve physics fidelity. Domain randomization is simple but requires careful parameter tuning. HyperSim's co-training approach (sim + real jointly) achieves 95% success with pi0 but requires real data. Real-is-Sim inverts the paradigm entirely — policies run on a 60Hz dynamic digital twin, making simulation the ground truth. Validation of transfer quality lacks standardized metrics.

**Platform fit**: `Partner`

- **Rationale**: Tightly coupled to simulation engines and world models; platform provides the pipeline orchestration (Tekton, KubeFlow) and compute scheduling.
- **Partnership surface**: NVIDIA (Cosmos-Transfer), simulation engine providers.

**Related blocks**: [Simulation Engines](#simulation-engines), [Video Generation Models](#video-generation--prediction-models), [Post-Training Pipeline](#post-training--fine-tuning-pipeline)
**Key ecosystem players**: [NVIDIA](ecosystem.md#nvidia), HyperSim (multi-institutional), Real-is-Sim (Stanford/Princeton)
**Relevant research**: [publications](publications.md#sim-to-real-transfer)

---

## Sensor Data Ingestion

**What it does**: High-throughput, low-latency pipelines for ingesting video, LiDAR, IMU, and other sensor streams from robots, vehicles, and industrial equipment.

**Domain demand**:

| Domain | Demand |
| --------------------- | --------- |
| Robotics | required |
| Industrial Digital Twins | required |
| Autonomous Vehicles | required |
| Visual AI / Inspection | required |
| Medical AI | important |
| Scientific Discovery | optional |
| Product Design & Engineering | optional |
| Molecular Design & Engineering | important |

**Solution landscape**:

| Category               | Solutions                | Maturity         | Notes                                                        |
| ---------------------- | ------------------------ | ---------------- | ------------------------------------------------------------ |
| OSS (community-driven) | MCAP                     | Production-ready | Open format adopted by ROS 2, NVIDIA Isaac                   |
| OSS (single-vendor)    | Rerun SDK                | Production-ready | Multi-rate multimodal logging + visualization; .rrd format   |
| OSS (single-vendor)    | Foxglove                 | Production-ready | Browser-first observability; MCAP native                     |
| Proprietary            | Rerun Hub                | Early OSS        | GPU-direct dataloader, SQL catalog (commercial)              |

**Key trade-offs**: Format war between MCAP (open standard, adopted by ROS 2 and NVIDIA) and .rrd (optimized for ML training random access). Rerun differentiates on code-first SDK and training pipeline integration; Foxglove on native ROS integration and fleet observability. Both are single-vendor OSS with proprietary cloud tiers.

**Platform fit**: `Build`

- **Rationale**: Core data infrastructure capability — extends existing OpenShift data pipeline tooling to physical-world data streams. High overlap with existing middleware expertise.
- **Partnership surface**: Rerun (SDK visualization), Foxglove (fleet observability), sensor hardware vendors, ROS 2 ecosystem.

**Related blocks**: [Robot Middleware](#robot-middleware), [Digital Twin Runtime](#digital-twin-runtime), [Edge AI Inference Runtime](#edge-ai-inference-runtime)
**Key ecosystem players**: Rerun, Foxglove
**Relevant research**: (to be populated)

---

## Edge AI Inference Runtime

**What it does**: Optimized runtime for running AI models on edge/robot hardware with real-time latency constraints. Includes model compilation, quantization, and hardware-specific acceleration.

**Domain demand**:

| Domain | Demand |
| --------------------- | ---------- |
| Robotics | required |
| Industrial Digital Twins | optional |
| Autonomous Vehicles | required |
| Visual AI / Inspection | required |
| Medical AI | important |
| Scientific Discovery | not needed |
| Product Design & Engineering | not needed |
| Molecular Design & Engineering | not needed |

**Solution landscape**:

(to be populated — research needed on NVIDIA TensorRT, ONNX Runtime, OpenVINO, Qualcomm AI Engine)

**Key trade-offs**: Hardware-specific acceleration (TensorRT) delivers best performance but locks to vendor. Cross-platform runtimes (ONNX) are portable but slower. Real-time guarantees require OS-level support (PREEMPT_RT). The AI+HW 2035 roadmap projects a 1000x efficiency target for edge AI hardware, implying current edge inference runtimes are early-stage compromises — platform abstractions should anticipate rapid hardware churn.

**Platform fit**: `Build`

- **Rationale**: Natural extension of Device Edge. Enterprise Linux with PREEMPT_RT + model serving is a core platform capability.
- **Partnership surface**: Hardware vendors (NVIDIA Jetson, Qualcomm), model providers.

**Related blocks**: [Model Serving for Physical AI](#model-serving-for-physical-ai), [Robot Middleware](#robot-middleware), [Sensor Data Ingestion](#sensor-data-ingestion)
**Key ecosystem players**: [NVIDIA](ecosystem.md#nvidia)
**Relevant research**: [publications](publications.md#edge-ai--hardware-co-design)

---

## Model Serving for Physical AI

**What it does**: Infrastructure for serving AI models with the latency, throughput, and multi-modality requirements of physical AI workloads. Distinct from LLM serving — requires action I/O, stateful sessions, and real-time guarantees.

This block has two sub-problems settling at different rates:

- **Data format** (converging): LeRobot v2/v3 is the de facto standard. OpenPI consumes it, GR00T adopted it (with `modality.json` extension), OXE covers TensorFlow workloads. Not a competitive concern.
- **Serving API** (fragmented): Three competing wire formats with no formal spec or open governance on any of them. This is the key risk area.

**Serving API landscape**:

| API | Wire Format | Owner | Governance | Adopters |
| --- | --- | --- | --- | --- |
| **OpenPI** | WebSocket + msgpack-numpy | Physical Intelligence | Single-vendor, no spec doc, no versioning | vLLM-Omni (clean-room reimpl, PR #2162/#3673), AgiBot GO-1-Air, DreamZero |
| **LeRobot PolicyServer** | gRPC + protobuf | HuggingFace | HuggingFace-controlled, broader community | SmolVLA, GR00T N1.5 (ported into LeRobot) |
| **Vendor-specific** | Various (REST, Triton) | NVIDIA, others | Vendor-controlled | GR00T native, NIM deployments |

[Positronic](https://github.com/Positronic-Robotics/positronic) has emerged as a community bridge layer (unified RemotePolicy client across LeRobot, OpenPI, GR00T servers), confirming the ecosystem sees this fragmentation as a problem.

**Domain demand**:

| Domain | Demand |
| --------------------- | --------- |
| Robotics | required |
| Industrial Digital Twins | important |
| Autonomous Vehicles | required |
| Visual AI / Inspection | important |
| Medical AI | important |
| Scientific Discovery | important |
| Product Design & Engineering | optional |
| Molecular Design & Engineering | important |

**Solution landscape**:

| Category               | Solutions                           | Maturity         | Notes                                                                 |
| ---------------------- | ----------------------------------- | ---------------- | --------------------------------------------------------------------- |
| OSS (community-driven) | vLLM-Omni                           | Early OSS        | Omni-modality serving; OpenPI-compatible endpoint (v0.22.0, Jun 2026) |
| OSS (single-vendor)    | LeRobot PolicyServer, openpi server | Early OSS        | LeRobot: gRPC; openpi: WebSocket. No open governance on either        |
| Proprietary            | NVIDIA NIM, Triton                  | Production-ready | NVIDIA; optimized for NVIDIA hardware                                 |

**Key trade-offs**: vLLM-Omni extends proven LLM serving to DiT/video/action modalities and chose OpenPI as its robotics serving protocol (clean-room reimplementation at `/v1/realtime/robot/openpi`). LeRobot provides a robotics-native gRPC API with broader model coverage but a critical unpatched RCE (CVE-2026-25874 via pickle deserialization). NVIDIA NIM/Triton are mature but CUDA-locked. The OpenPI wire format is gaining traction as the common denominator (vLLM-Omni, DreamZero, AgiBot), but PI controls it unilaterally with no formal spec — vLLM-Omni is reverse-engineering compatibility, not implementing against a stable contract.

**Platform fit**: `Build`

- **Rationale**: Direct extension of existing AI model serving stack (vLLM, llm-d). vLLM-Omni is already in scope for the inference server. The OpenPI-compatible endpoint gives Red Hat a robotics serving story through an existing investment.
- **Risk**: OpenPI protocol has no open governance — PI can make breaking changes at any time. vLLM-Omni's parity tests (`test_openpi_e2e_source_parity.py`) mitigate but don't eliminate this. Monitor for a formal spec or foundation governance; absent that, vLLM-Omni's reimplementation may need to fork the protocol.
- **Partnership surface**: vLLM community (primary — already building OpenPI serving), HuggingFace (LeRobot data format + PolicyServer), Positronic (bridge layer).

**Related blocks**: [Robot Foundation Models](#robot-foundation-models), [Edge AI Inference Runtime](#edge-ai-inference-runtime), [Latent World Models](#latent-world-models)
**Key ecosystem players**: vLLM community, [Physical Intelligence](ecosystem.md#physical-intelligence-π) (OpenPI protocol), [NVIDIA](ecosystem.md#nvidia), HuggingFace (LeRobot)
**Relevant research**: [vLLM-Omni World Model RFC (Issue #1987)](https://github.com/vllm-project/vllm-omni/issues/1987)

---

## Post-Training / Fine-Tuning Pipeline

**What it does**: Workflows for adapting foundation models to specific robots, tasks, or environments using simulation data, real-world demonstrations, or reinforcement learning.

**Domain demand**:

| Domain | Demand |
| --------------------- | --------- |
| Robotics | required |
| Industrial Digital Twins | important |
| Autonomous Vehicles | required |
| Visual AI / Inspection | important |
| Medical AI | important |
| Scientific Discovery | important |
| Product Design & Engineering | important |
| Molecular Design & Engineering | required |

**Solution landscape**:

| Category               | Solutions                  | Maturity  | Notes                            |
| ---------------------- | -------------------------- | --------- | -------------------------------- |
| OSS (community-driven) | (none identified)          | —         | —                                |
| OSS (single-vendor)    | Cosmos-RL, Cosmos-Cookbook | Early OSS | NVIDIA; RL + SFT for Physical AI |
| Proprietary            | (none identified)          | —         | —                                |

**Key trade-offs**: Simulation-based post-training is scalable but depends on sim-to-real fidelity. Real-world fine-tuning is accurate but expensive and slow. RL-based optimization (Cosmos-RL) can improve beyond human demonstrations but is unstable.

**Platform fit**: `Build`

- **Rationale**: Extends existing Open Data Hub / KubeFlow pipelines. Post-training on simulation data is a GPU-intensive batch workload — natural for OpenShift.
- **Partnership surface**: Model providers (NVIDIA, Physical Intelligence), simulation engine providers.

**Related blocks**: [Simulation Engines](#simulation-engines), [Sim-to-Real Transfer Pipeline](#sim-to-real-transfer-pipeline), [Model Serving for Physical AI](#model-serving-for-physical-ai)
**Key ecosystem players**: [NVIDIA](ecosystem.md#nvidia)
**Relevant research**: (to be populated)

---

## Digital Twin Runtime

**What it does**: Runtime environment for continuous digital twin operation — maintaining synchronized state between physical assets and their digital representations, running predictions, and triggering actions.

**Domain demand**:

| Domain | Demand |
| --------------------- | ---------- |
| Robotics | important |
| Industrial Digital Twins | required |
| Autonomous Vehicles | optional |
| Visual AI / Inspection | important |
| Medical AI | optional |
| Scientific Discovery | important |
| Product Design & Engineering | important |
| Molecular Design & Engineering | not needed |

**Solution landscape**:

| Category               | Solutions                                                 | Maturity         | Notes                         |
| ---------------------- | --------------------------------------------------------- | ---------------- | ----------------------------- |
| OSS (community-driven) | Eclipse Ditto, DTDL                                       | Production-ready | Eclipse Foundation governance |
| OSS (single-vendor)    | (none identified)                                         | —                | —                             |
| Proprietary            | Siemens Xcelerator, NVIDIA Omniverse, Azure Digital Twins | Production-ready | Major industrial players      |

**Key trade-offs**: Industrial digital twin platforms (Siemens, NVIDIA) are mature but proprietary and expensive. Open-source alternatives (Eclipse Ditto) handle state synchronization but lack physics simulation integration.

**Platform fit**: `Build` / `Partner`

- **Rationale**: State synchronization and event-driven runtime is core platform territory. Physics simulation integration is a partner play.
- **Partnership surface**: Siemens, NVIDIA (Omniverse), Eclipse Foundation.

**Related blocks**: [Simulation Engines](#simulation-engines), [Sensor Data Ingestion](#sensor-data-ingestion), [Safety & Validation Frameworks](#safety-validation--certification-frameworks)
**Key ecosystem players**: [Siemens](ecosystem.md#siemens), [NVIDIA](ecosystem.md#nvidia), [Schneider Electric](ecosystem.md#schneider-electric)
**Relevant research**: (to be populated)

---

## Robot Fleet Management & Observability

**What it does**: Manage, monitor, and update fleets of robots at scale — deployment, telemetry, remote diagnostics, OTA updates, and operational dashboards.

**Domain demand**:

| Domain | Demand |
| --------------------- | ---------- |
| Robotics | required |
| Industrial Digital Twins | optional |
| Autonomous Vehicles | required |
| Visual AI / Inspection | important |
| Medical AI | not needed |
| Scientific Discovery | not needed |
| Product Design & Engineering | not needed |
| Molecular Design & Engineering | not needed |

**Solution landscape**:

| Category               | Solutions            | Maturity         | Notes                                   |
| ---------------------- | -------------------- | ---------------- | --------------------------------------- |
| OSS (community-driven) | (none identified)    | —                | —                                       |
| OSS (single-vendor)    | Foxglove, Formant    | Production-ready | Robot-specific observability/fleet mgmt |
| Proprietary            | AWS IoT RoboRunner   | Production-ready | AWS; cloud-locked                       |

**Key trade-offs**: Cloud-native fleet management (AWS) scales but creates cloud lock-in. Robot-specific tools (Foxglove, Formant) have better UX for robotics but limited enterprise integration. Rerun SDK provides developer-level data visualization and debugging (code-first, multi-rate sensor data) but lacks fleet-level features in OSS tier.

**Platform fit**: `Build`

- **Rationale**: Direct extension of Edge Manager and Advanced Cluster Manager to robot fleets. Observability stack already exists.
- **Partnership surface**: Foxglove (fleet observability), Rerun (data visualization), robot OEMs.

**Related blocks**: [Robot Middleware](#robot-middleware), [Edge AI Inference Runtime](#edge-ai-inference-runtime)
**Key ecosystem players**: Foxglove, Formant, Rerun
**Relevant research**: (to be populated)

---

## Safety, Validation & Certification Frameworks

**What it does**: Tools and processes for validating AI behavior in safety-critical physical systems. Includes formal verification, scenario testing, uncertainty quantification, and regulatory compliance.

**Domain demand**:

| Domain | Demand |
| --------------------- | --------- |
| Robotics | required |
| Industrial Digital Twins | important |
| Autonomous Vehicles | required |
| Visual AI / Inspection | required |
| Medical AI | required |
| Scientific Discovery | optional |
| Product Design & Engineering | important |
| Molecular Design & Engineering | required |

**Solution landscape**:

(to be populated — research needed on safety frameworks, regulatory compliance tools, UQ methods)

**Key trade-offs**: (to be populated)

**Platform fit**: `Build` / `Partner`

- **Rationale**: Certification tooling and audit trails are platform capabilities. Domain-specific safety validation (automotive ISO 26262, medical IEC 62304) requires partner expertise.
- **Partnership surface**: Certification bodies, domain-specific safety consultancies, UQ researchers (Oxford OATML).

**Related blocks**: [Simulation Engines](#simulation-engines), [Digital Twin Runtime](#digital-twin-runtime)
**Key ecosystem players**: [Oxford OATML](ecosystem.md#oxford-oatml)
**Relevant research**: [Yarin Gal's UQ work](concepts.md)

---

## Data Annotation & Curation for Physical AI

**What it does**: Tools for labeling, curating, and managing training data from physical-world sources — video, sensor streams, robot demonstrations, simulation outputs.

**Domain demand**:

| Domain | Demand |
| --------------------- | --------- |
| Robotics | required |
| Industrial Digital Twins | optional |
| Autonomous Vehicles | required |
| Visual AI / Inspection | required |
| Medical AI | required |
| Scientific Discovery | optional |
| Product Design & Engineering | optional |
| Molecular Design & Engineering | important |

**Solution landscape**:

(to be populated — research needed on annotation platforms, active learning, data engines)

**Key trade-offs**: (to be populated)

**Platform fit**: `Partner` / `Integrate`

- **Rationale**: Annotation is domain-specific; platform provides the data pipeline infrastructure.
- **Partnership surface**: Annotation tool vendors, HuggingFace (datasets).

**Related blocks**: [Sensor Data Ingestion](#sensor-data-ingestion), [Post-Training Pipeline](#post-training--fine-tuning-pipeline)
**Key ecosystem players**: HuggingFace
**Relevant research**: (to be populated)

---

## Evaluation & Benchmarking

**What it does**: Standardized frameworks for evaluating robot policies, world models, and simulation quality. Includes benchmark task suites, evaluation harnesses, leaderboards, and sim-to-real correlation validation. Emerging as a standalone platform capability — analogous to software QA/CI for robot policies.

**Domain demand**:

| Domain | Demand |
| --------------------- | --------- |
| Robotics | required |
| Industrial Digital Twins | important |
| Autonomous Vehicles | required |
| Visual AI / Inspection | important |
| Medical AI | optional |
| Scientific Discovery | important |
| Product Design & Engineering | important |
| Molecular Design & Engineering | important |

**Solution landscape**:

| Category               | Solutions                                                | Maturity  | Notes                                              |
| ---------------------- | -------------------------------------------------------- | --------- | -------------------------------------------------- |
| OSS (community-driven) | MolmoSpaces-Bench, RoboArena, RoboVerse, WorldOlympiad   | Early OSS | Ai2, CoRL community, multi-institutional           |
| OSS (single-vendor)    | Isaac Lab-Arena, LeRobot eval harness                    | Early OSS | NVIDIA + Lightwheel; HuggingFace emerging std APIs |
| Proprietary            | (none identified as standalone)                          | -         | Evaluation typically bundled with sim platforms    |

**Dependency on simulation stack**: Evaluation frameworks inherit the physics engine and rendering engine of their underlying simulator. A benchmark running on Isaac Lab (PhysX/OptiX) tests different physics than one on MuJoCo — results are not directly comparable across simulators. RoboVerse and MolmoSpaces address this by supporting multiple backends.

**Key trade-offs**: Sim-based eval scales but recent audits ([arxiv.org/html/2606.04233](https://arxiv.org/html/2606.04233)) expose shortcut solvability and overfitting in popular benchmarks (LIBERO, CALVIN) — both are "basically solved" with marginal differences (98% vs 99%) uninformative (Reuss 2025). Real-world eval (RoboArena, RoboChallenge Table30) captures deployment-relevant failures but is expensive and slow to scale. World model evaluation is fragmenting across domain-specific benchmarks (EWMBench, DreamGen Bench, WorldModelBench, PBench) with no cross-domain standard. The field is converging on a layered approach: fast sim screening → selective real-world validation. WorldOlympiad introduces a tripartite evaluation (physics, geometry, interaction) specifically for video-based world models, addressing the gap between video quality metrics and physical fidelity.

**Platform fit**: `Build`

- **Rationale**: Evaluation pipelines are CI/CD for robot policies — scheduling sim eval jobs, aggregating results, gating deployments. Natural extension of existing MLOps infrastructure (KubeFlow, Tekton). Platform can provide the orchestration and compute scheduling; benchmark content comes from partners and community.
- **Partnership surface**: HuggingFace (LeRobot eval hub), NVIDIA (Isaac Lab-Arena), Ai2 (MolmoSpaces), benchmark authors.

**Related blocks**: [Simulation Engines](#simulation-engines), [Robot Foundation Models](#robot-foundation-models), [Post-Training Pipeline](#post-training--fine-tuning-pipeline), [Safety & Validation Frameworks](#safety-validation--certification-frameworks)
**Key ecosystem players**: HuggingFace, [NVIDIA](ecosystem.md#nvidia), [Allen Institute for AI](ecosystem.md)
**Relevant research**: [publications](publications.md)

---

## Physics-Informed ML Frameworks

**What it does**: Frameworks that combine physics equations/constraints with machine learning — neural operators, physics-informed neural networks (PINNs), and learned surrogates for engineering simulation.

**Domain demand**:

| Domain | Demand |
| --------------------- | ---------- |
| Robotics | optional |
| Industrial Digital Twins | required |
| Autonomous Vehicles | optional |
| Visual AI / Inspection | important |
| Medical AI | optional |
| Scientific Discovery | required |
| Product Design & Engineering | required |
| Molecular Design & Engineering | required |

**Solution landscape**:

| Category | Solutions | Maturity | Notes |
| --- | --- | --- | --- |
| OSS (community-driven) | NeuralOperator | Production-ready | PyTorch Ecosystem; FNO/TFNO/GINO/UNO. NVIDIA + Caltech |
| OSS (community-driven) | DeepXDE | Production-ready | PINNs + DeepONet; 5 backends (PyTorch, JAX, TF, PaddlePaddle). MIT, 4.3K stars |
| OSS (community-driven) | PDEBench | Production-ready | Benchmark suite; 9+ PDE problems; NeurIPS 2022. MIT |
| OSS (single-vendor) | PhysicsNeMo | Production-ready | NVIDIA; Apache 2.0, 3K stars. FNO+DeepONet+MeshGraphNet+PINNs+diffusion |
| Proprietary | Simulink | Industry standard | MathWorks; deep industry adoption |
| Proprietary | Emmi AI (Mistral) | Early OSS | Acquired by Mistral AI May 2026 (~€300M); CFD/FEA/thermal neural surrogates |
| Proprietary | SimAI | Early OSS | Ansys; cloud-based, trained on Ansys solver data |
| Proprietary | PhysicsX | Early OSS | UK startup; $489M raised, $2.4B valuation; neural surrogates for auto/aero |

**Key trade-offs**: Learned surrogates (PhysicsNeMo, Emmi AI) achieve 10³-10⁵x amortized inference speedups vs traditional solvers but sacrifice guaranteed accuracy — not yet accepted for certification-grade analysis (GM engineers confirm physical wind tunnel testing still required). Architecture choice matters: FNO excels on regular grids but degrades catastrophically with noisy inputs (10,000x error increase with 0.1% noise); DeepONet handles irregular domains and noise robustly; PINNs excel at inverse problems with sparse data but require per-instance retraining. Traditional tools (Simulink, Ansys) have regulatory acceptance but don't scale to AI-driven optimization loops. Open-source options are NVIDIA-locked (PhysicsNeMo requires CUDA); DeepXDE (5 backends incl. PyTorch, JAX) is the most hardware-portable alternative but focuses on PINNs/DeepONet only. Surrogates are currently used to augment, not replace, traditional solvers in production — design exploration (100s of variants in seconds) followed by solver validation of final designs.

**Platform fit**: `Partner`

- **Rationale**: Highly specialized; platform provides compute infrastructure for training and inference. Surrogate models are small (5K-2M parameters) compared to LLMs — different serving profile (latency-sensitive, tightly coupled to HPC, not vLLM-shaped). Three deployment coupling modes: tightly coupled (MPI-style), semi-tightly coupled (same node), loosely coupled (K8s-friendly).
- **Partnership surface**: NVIDIA (PhysicsNeMo), MathWorks, Mistral AI (Emmi), PhysicsX, Ansys (SimAI), Pasteur Labs, domain-specific simulation companies.

**Related blocks**: [Simulation Engines](#simulation-engines), [Digital Twin Runtime](#digital-twin-runtime)
**Key ecosystem players**: [NVIDIA](ecosystem.md#nvidia), [Mistral AI](ecosystem.md#mistral-ai), [PhysicsX](ecosystem.md#physicsx), [Pasteur Labs](ecosystem.md#pasteur-labs)
**Relevant research**: [Lu et al. 2022 — FNO vs DeepONet comparison](publications.md#lu-et-al--comprehensive-comparison-of-deeponet-and-fno-2022), [MARIO — training cost reduction](publications.md#mario--modulated-aerodynamic-resolution-invariant-operator-2025), [HPC-DL coupling architectures](publications.md#hpc-dl-coupling-architectures-for-surrogates-2022)

---

**Note**: Each entry follows the building-block-entry template from `templates/building-block-entry.md`.
Building blocks use controlled vocabulary: Demand (`required` | `important` | `optional` | `not needed`), Maturity (`Research` | `Early OSS` | `Production-ready` | `Industry standard`), Platform fit (`Build` | `Partner` | `Integrate`), Category (`OSS (community-driven)` | `OSS (single-vendor)` | `Source-available` | `Proprietary`).
