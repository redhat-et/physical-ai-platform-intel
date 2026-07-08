# Ecosystem

> Players in Physical AI — their solutions, reference architectures, and platform relevance

**Last Updated**: 2026-07-07

---

## Big Tech

*Established technology companies with major Physical AI initiatives*

### NVIDIA

**Type**: `Big Tech`
**About**: Largest industrial investor in world foundation models via the Cosmos platform. Frames world models as "the ChatGPT moment for robotics." Building a full-stack Physical AI platform spanning world models, simulation, robot foundation models, physics ML, edge inference, and digital twins. An investor in SSI and AMI Labs. Released open-source Physical AI agent skills and tools (May 2026, [github.com/NVIDIA/skills](https://github.com/NVIDIA/skills)) covering robotics, AV, vision AI, industrial digital twins, and healthcare — adopted by Pegatron (67% training time reduction), Delta Electronics, Foxconn, and Li Auto.

**Solutions**:

#### Cosmos Platform

- **What it does**: World foundation models for Physical AI — general-purpose video prediction models trained on 20M hours of real-world data for generating synthetic training data, sim-to-real transfer, and world simulation.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models), [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)
- **Key features (functional)**: Cosmos-Predict2.5 (world simulation), Cosmos-Transfer2 / Transfer2.5 (sim2real from depth/segmentation/edge/HD map inputs), Cosmos-Reason2 (7B physical reasoning VLM, #1 on Hugging Face Physical Reasoning Leaderboard), Cosmos-Tokenizer. Distilled Cosmos Transfer collapses 70-step generation to 1 step for RTX PRO Server deployment
- **Key features (non-functional)**: Trained on 20M hours of video; open-weight models under permissive licensing; 2M+ total downloads. Adopters include Lightwheel, Moon Surgical, Skild AI, Uber (AV data annotation), Magna (autonomous delivery)
- **Competes with**: Genie 3, Sora, GAIA series — on synthetic data generation and world simulation
- **Complements**: Isaac Sim (simulation source), GR00T (policy consumer), Omniverse (rendering)
- **Openness**: `OSS-single-vendor`
- **Lock-in vectors**: NVIDIA GPU dependency, Cosmos tokenizer format, integration with NVIDIA ecosystem
- **Source**: [Cosmos Platform](https://www.nvidia.com/en-us/ai/cosmos/), [GitHub](https://github.com/nvidia-cosmos)

#### Isaac Sim

- **What it does**: Physics-based simulation platform for developing and testing robot applications in photorealistic virtual environments.
- **Building blocks covered**: [Simulation Engines](building-blocks.md#simulation-engines), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)
- **Key features (functional)**: High-fidelity physics (PhysX), photorealistic rendering, domain randomization, ROS2 integration, sensor simulation
- **Key features (non-functional)**: GPU-accelerated, multi-robot support, cloud deployment
- **Competes with**: Gazebo, Genesis World, MuJoCo — on fidelity and integration
- **Complements**: Cosmos (synthetic data), GR00T (policy training), Omniverse (rendering backbone)
- **Openness**: `Proprietary` (free for individual use)
- **Lock-in vectors**: NVIDIA GPU required, Omniverse dependency, proprietary scene format
- **Source**: [Isaac Sim](https://developer.nvidia.com/isaac-sim)

#### Isaac ROS

- **What it does**: GPU-accelerated middleware for robot perception and navigation, providing hardware-accelerated ROS2 packages.
- **Building blocks covered**: [Robot Middleware](building-blocks.md#robot-middleware), [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime)
- **Key features (functional)**: GPU-accelerated perception (stereo depth, visual SLAM, object detection), navigation stack, DNN inference integration
- **Key features (non-functional)**: Jetson-optimized, real-time capable, ROS2 Humble/Iron compatible
- **Competes with**: Standard ROS2 perception stack — on latency and throughput via GPU acceleration
- **Complements**: ROS2 (extends, not replaces), Jetson (target hardware), Isaac Sim (sim-to-real)
- **Openness**: `OSS-single-vendor`
- **Lock-in vectors**: Jetson/NVIDIA GPU required for acceleration benefits
- **Source**: [Isaac ROS](https://developer.nvidia.com/isaac-ros), [GitHub](https://github.com/NVIDIA-ISAAC-ROS)

#### GR00T N1

- **What it does**: Open VLA foundation model for humanoid robots with dual-system architecture — System 1 (fast reactive control) + System 2 (deliberative reasoning via VLM).
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Cross-embodiment transfer, bimanual manipulation, dual-system architecture, pre-trained on diverse robot data
- **Key features (non-functional)**: Adopted by 1X, Agility, Figure AI, Boston Dynamics, Unitree, Sanctuary AI. Isaac GR00T Reference Humanoid Robot (GTC Taipei, Jun 2026): first open humanoid reference design combining Unitree H2 Plus + Sharpa Wave tactile hands + Jetson AGX Thor T5000 (Blackwell, 2070 FP4 TFLOPS). Partners: Ai2, ETH Zurich, Stanford, UCSD. Available from Unitree late 2026
- **Competes with**: pi0/pi0.5, Gemini Robotics, GEN-1 — on generalist robot control
- **Complements**: Isaac Sim (training), Cosmos (synthetic data), Jetson (deployment)
- **Openness**: `OSS-single-vendor`
- **Lock-in vectors**: Optimized for Jetson deployment, NVIDIA training infrastructure
- **Source**: [GR00T](https://developer.nvidia.com/groot), [Reference Robot](https://nvidianews.nvidia.com/news/nvidia-open-humanoid-robot-reference-design)

#### Omniverse

- **What it does**: Platform for building and operating digital twins — connects 3D design tools, simulation, and AI in a shared virtual environment using USD (Universal Scene Description).
- **Building blocks covered**: [Digital Twin Runtime](building-blocks.md#digital-twin-runtime), [Simulation Engines](building-blocks.md#simulation-engines)
- **Key features (functional)**: USD-based interoperability, real-time collaboration, physically accurate rendering, digital twin orchestration, connector ecosystem. NuRec libraries add RTX ray-traced 3D Gaussian splatting for large-scale world reconstruction from sensor data. New MJCF-to-OpenUSD SDKs enable interop for 250K+ MuJoCo developers. NuRec integrated into CARLA (150K+ developers), Foretellix AV toolchain, and Isaac Sim 5.0
- **Key features (non-functional)**: Cloud and on-prem deployment, multi-GPU scaling. DGX Cloud on Azure Marketplace for streaming OpenUSD/RTX at scale
- **Competes with**: Siemens Xcelerator, Eclipse Ditto — on industrial digital twin capability
- **Complements**: Isaac Sim (robot simulation layer), Cosmos (world model integration), PhysicsNeMo (physics ML)
- **Openness**: `Proprietary` (free tier available)
- **Lock-in vectors**: NVIDIA GPU required, USD format dependency, connector ecosystem
- **Source**: [Omniverse](https://www.nvidia.com/en-us/omniverse/)

#### Jetson

- **What it does**: Edge AI computing platform for deploying AI models on robots, autonomous machines, and IoT devices.
- **Building blocks covered**: [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime)
- **Key features (functional)**: TensorRT optimization, CUDA acceleration, JetPack SDK, container support
- **Key features (non-functional)**: Low power (10-75W), real-time inference, industrial temperature range (Orin NX/Nano)
- **Competes with**: Qualcomm RB series, Intel/Mobileye EyeQ — on edge AI performance
- **Complements**: Isaac ROS (middleware), GR00T (model deployment), Isaac Sim (sim-to-real target)
- **Openness**: `Proprietary` (JetPack SDK free)
- **Lock-in vectors**: NVIDIA-only hardware, CUDA dependency, TensorRT model format
- **Source**: [Jetson](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/)

#### PhysicsNeMo

- **What it does**: Framework for building physics-informed neural network models — surrogate models that approximate physical simulations orders of magnitude faster.
- **Building blocks covered**: [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks)
- **Key features (functional)**: PDE solvers, mesh-based models, Fourier Neural Operators, physics-informed loss functions
- **Key features (non-functional)**: Multi-GPU training, Omniverse integration
- **Competes with**: JAX-based physics simulators, custom PINN implementations — on ease of use and scale
- **Complements**: Omniverse (digital twin physics), Isaac Sim (simulation fidelity)
- **Openness**: `OSS-single-vendor`
- **Lock-in vectors**: NVIDIA GPU required, integration with NVIDIA stack
- **Source**: [PhysicsNeMo](https://developer.nvidia.com/physicsnemo), [GitHub](https://github.com/NVIDIA/physicsnemo)

#### NVIDIA AI Enterprise (NVAIE)

NVAIE is NVIDIA's end-to-end enterprise AI software platform, licensed per-GPU ($4,500/GPU/year, or bundled with H100/B200 purchases). Two layers:

- **Infrastructure Layer**: GPU Operator, Network Operator, NIM Operator, Run:ai (self-hosted + SaaS), Container Toolkit, GPU drivers, vGPU
- **Application Layer**: NIM (inference microservices), NeMo (Customizer, Evaluator, Guardrails), Omniverse, Cosmos WFMs, Isaac Sim/Lab, GR00T, Blueprints

- **Sources**: [NVAIE Software Stack](https://docs.nvidia.com/ai-enterprise/reference-architecture/latest/software-stack.html), [NVAIE Components](https://docs.nvidia.com/ai-enterprise/release-4/4.4/overview/whats-included.html), [NIM on OpenShift AI](https://developers.redhat.com/articles/2025/03/26/generative-ai-nvidia-nim-openshift-ai), [NIM Operator 3.0](https://developer.nvidia.com/blog/deploy-scalable-ai-inference-with-nvidia-nim-operator-3-0-0/)

**Implied reference architecture**: Full vertical integration from silicon (Jetson) through simulation (Isaac Sim/Omniverse) to foundation models (Cosmos/GR00T). Envisions a loop: Cosmos generates synthetic data, Isaac Sim provides simulation, GR00T trains robot policies, Jetson deploys at the edge, and Omniverse orchestrates digital twins. PhysicsNeMo handles physics-informed components. Every layer is GPU-accelerated and optimized for NVIDIA hardware.

- **Source**: [NVIDIA Physical AI Platform](https://www.nvidia.com/en-us/ai/)

**Platform relevance**:

- **Partnership surface**: Middleware layer (Isaac ROS extends ROS2), simulation engines and models as workloads, GPU telemetry (DCGM), edge hardware (Jetson/IGX) — areas where NVIDIA complements without overlapping
- **Competitive surface**: Several NVAIE components target the same platform functions as existing enterprise Kubernetes AI stacks (inference serving, GPU scheduling, training orchestration, model routing)
- **What they need from a platform**: Standards-based interoperability beyond their ecosystem, fleet-level orchestration, safety certification frameworks, vendor-neutral model serving

---

### Meta AI (FAIR)

**Type**: `Big Tech`
**About**: Largest contributor to the JEPA ecosystem, having developed the full progression from I-JEPA to V-JEPA 2 and VL-JEPA. Post-LeCun departure (Jan 2026), Meta continues physical AI investment through Meta Superintelligence Labs and Meta Robotics Studio. Acquired Assured Robot Intelligence (ARI) in May 2026 for learning-based robot control.

**Solutions**:

#### V-JEPA Family

- **What it does**: Self-supervised video representation learning via joint-embedding predictive architecture — learns visual representations by predicting masked spatiotemporal regions in latent space rather than pixel space.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: I-JEPA (images), V-JEPA (video), V-JEPA 2 (world model with planning), V-JEPA 2.1 (improved), VL-JEPA (vision-language)
- **Key features (non-functional)**: Open-weight models, Apache 2.0 license
- **Competes with**: VideoMAE, Cosmos latent models — on self-supervised video understanding
- **Complements**: EB-JEPA (energy-based training), downstream VLA models
- **Openness**: `OSS-single-vendor`
- **Lock-in vectors**: Minimal — open weights and code, standard PyTorch
- **Source**: [GitHub](https://github.com/facebookresearch)

#### EB-JEPA

- **What it does**: Energy-based training library for JEPA architectures — provides energy-based model primitives and training loops as an alternative to the EMA teacher-student paradigm.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: Energy-based training, VICReg integration, configurable architectures
- **Key features (non-functional)**: Open-source, PyTorch-based
- **Competes with**: Standard SSL frameworks (DINO, MAE) — on JEPA-specific training
- **Complements**: V-JEPA family (shared architecture), downstream policy models
- **Openness**: `OSS-single-vendor`
- **Lock-in vectors**: Minimal
- **Source**: [GitHub](https://github.com/facebookresearch)

**Implied reference architecture**: JEPA as the perception backbone — V-JEPA learns world representations, VL-JEPA adds language grounding, and downstream models consume these representations for planning and action. Meta envisions JEPA replacing contrastive and generative pretraining for physical AI. Post-ARI acquisition, expects to connect JEPA representations to learned robot control.

**Platform relevance**:

- **Partnership surface**: JEPA models as perception building blocks, integration with robot middleware and simulation
- **Competitive surface**: Limited — Meta's focus is research and open-source, not commercial platforms
- **What they need from a platform**: Deployment infrastructure for JEPA models, integration with robot hardware, sim-to-real pipelines

---

### Google DeepMind

**Type**: `Big Tech`
**About**: Leading AI research lab (Alphabet) with multiple world-model-adjacent efforts spanning interactive world models, robotics foundation models, and physics engines. Gemini Omni (May 2026) fuses reasoning, video generation, and world simulation into a unified multimodal model explicitly positioned as a world model. Launched the Robotics Accelerator for EMEA (Jun-Sep 2026) — equity-free program for 15 early-stage European robotics startups with access to Gemini Robotics models, up to $350K in Google Cloud credits, and mentorship. Signals intent to build a robotics startup ecosystem around Gemini.

**Solutions**:

#### Gemini Robotics

- **What it does**: VLA foundation model for robot control — translates visual observations and language instructions into robot actions with embodied reasoning capabilities.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Gemini Robotics 1.5/On-Device (VLA), Gemini Robotics-ER 1.6 (embodied reasoning, spatial understanding, instrument reading), action chunking for high-frequency control, cross-embodiment (ALOHA 2, Franka, Apptronik Apollo)
- **Key features (non-functional)**: Cloud: ~250ms latency, 50Hz via action chunking; On-Device: <10ms inference, learns from 50 demos, cross-embodiment transfer
- **Competes with**: GR00T N1, pi0/pi0.5, GEN-1 — on generalist robot control
- **Complements**: Gemini Omni (reasoning backbone), Newton (physics simulation)
- **Openness**: `Proprietary` (API access)
- **Lock-in vectors**: Google Cloud dependency, Gemini API, proprietary model
- **Source**: [Gemini Robotics](https://deepmind.google/models/gemini-robotics/)

#### Genie 3

- **What it does**: Interactive world model generating playable 720p/24fps environments from text or image prompts — learns physics and dynamics from video data.
- **Building blocks covered**: [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models), [Simulation Engines](building-blocks.md#simulation-engines)
- **Key features (functional)**: Interactive generation (responds to actions), 720p resolution, 24fps, physics-aware generation
- **Key features (non-functional)**: Prompt-driven world creation
- **Competes with**: Cosmos, Sora — on interactive world simulation
- **Complements**: Gemini Robotics (training environments), Gemini Omni (unified model)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Google Cloud, no open weights
- **Source**: [DeepMind Research](https://deepmind.google/research/)

#### Newton

- **What it does**: Physics engine co-developed with NVIDIA and Disney Research — aims to provide differentiable physics simulation for training and evaluating world models.
- **Building blocks covered**: [Simulation Engines](building-blocks.md#simulation-engines), [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks)
- **Key features (functional)**: Differentiable physics, multi-body dynamics, contact simulation
- **Key features (non-functional)**: (to be populated)
- **Competes with**: MuJoCo, PhysX, Genesis World — on differentiable physics simulation
- **Complements**: Genie 3 (physics backbone), Gemini Robotics (sim-to-real)
- **Openness**: (to be populated)
- **Lock-in vectors**: (to be populated)
- **Source**: [DeepMind](https://deepmind.google/research/)

**Implied reference architecture**: Gemini as universal backbone — Gemini Omni provides multimodal reasoning, Genie 3 generates interactive environments for training, Newton handles physics, and Gemini Robotics translates it all into robot actions. Envisions a single model family spanning language, vision, simulation, and control.

**Platform relevance**:

- **Partnership surface**: Newton physics engine (potential open collaboration), Gemini Robotics-ER for industrial inspection
- **Competitive surface**: Full-stack AI platform ambition overlaps broadly with any Physical AI platform
- **What they need from a platform**: Hardware-agnostic deployment (beyond Google Cloud), integration with diverse robot ecosystems, industrial certification

---

### Alibaba (Tongyi Lab)

**Type**: `Big Tech`
**About**: Alibaba's AI research unit Tongyi Lab entered the Physical AI space with the Qwen-Robot suite (June 2026) — a composable set of embodied intelligence models covering world modeling, manipulation, navigation, and agentic orchestration. Builds on the Qwen foundation model family. Pilot testing with Alibaba Cloud enterprise clients.

**Solutions**:

#### Qwen-RobotWorld

- **What it does**: Language-conditioned video world model predicting physically grounded future visual trajectories across manipulation, driving, navigation, and human-to-robot transfer. Uses natural language as the unified action interface.
- **Building blocks covered**: [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models), [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: 60-layer double-stream MMDiT coupling frozen Qwen2.5-VL with video-VAE latents, 8.6M video-text corpus (200M+ frames, 20+ embodiments, 500+ action categories), progressive curriculum training
- **Key features (non-functional)**: 1st on EWMBench and DreamGen Bench, outperforms all open-source models on WorldModelBench and PBench
- **Competes with**: Cosmos (NVIDIA), Genie 3 (Google DeepMind), DreamZero — on video world models for robotics
- **Complements**: Qwen-RobotManip (VLA), Qwen-RobotNav (VLN), Qwen-RobotClaw (agent framework)
- **Openness**: (to be confirmed — technical report published, weights TBD)
- **Source**: [arXiv:2606.17030](https://arxiv.org/abs/2606.17030)

#### Qwen-RobotManip

- **What it does**: Generalist VLA model for robotic manipulation built on Qwen3.5-4B, with 80-dimensional unified action representation and relative perception for cross-hardware adaptation.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: 80-dim unified action representation, relative perception for cross-hardware transfer, dexterous manipulation
- **Key features (non-functional)**: Top 2 on RoboChallenge Table30 v1 benchmark (30 real-world tasks, 4 robot platforms)
- **Competes with**: pi0/pi0.5, GR00T N1, OpenVLA — on generalist VLA manipulation
- **Openness**: (to be confirmed)

#### Qwen-RobotNav

- **What it does**: Vision-language navigation model unifying instruction following, goal navigation, object tracking, and autonomous driving under controllable observation encoding and tool interfaces.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Competes with**: Gemini Robotics (navigation), specialized VLN models
- **Openness**: (to be confirmed)

#### Qwen-RobotClaw

- **What it does**: Robotic agent framework enabling Qwen VLM agents to invoke the Qwen-Robot Suite models as tools for physical world interaction, with context and memory management for long-horizon tasks.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Compositional model invocation via language, long-horizon task memory, tool-use interface connecting VLM reasoning to physical execution
- **Competes with**: Isaac Lab agent pipelines, custom VLA orchestration frameworks
- **Openness**: (to be confirmed)

**Implied reference architecture**: VLM-as-orchestrator pattern — general-purpose Qwen VLM reasons and plans, then invokes specialized robot models (world model, manipulation, navigation) as tools via RobotClaw. Distinct from monolithic VLA/WAM approaches. Deployed on Alibaba Cloud.

**Platform relevance**:

- **Partnership surface**: Full model suite needs deployment infrastructure, edge serving, cross-cloud portability
- **Competitive surface**: Alibaba Cloud as deployment platform competes with other cloud-based Physical AI offerings
- **What they need from a platform**: Hardware-agnostic deployment beyond Alibaba Cloud, integration with global robot ecosystems, industrial certification for Chinese-origin models

**Links**: [Qwen-Robot Blog](https://qwen.ai/blog?id=qwen-robotworld), [arXiv:2606.17030](https://arxiv.org/abs/2606.17030)

---

### Tesla

**Type**: `Big Tech`
**About**: Applies world model principles at production scale in its Full Self-Driving (FSD) system. Not a standalone world model product, but the largest-scale deployment of world-model-based prediction in production vehicles.

**Solutions**:

#### Full Self-Driving (FSD)

- **What it does**: End-to-end autonomous driving system using Occupancy Networks 2.0 — 3D voxel-based prediction of future occupancy states as a core world model component.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models), [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime)
- **Key features (functional)**: 3D occupancy prediction, end-to-end learned driving, temporal future prediction
- **Key features (non-functional)**: FSD v14 has 10x more parameters than v13; deployed on millions of production vehicles
- **Competes with**: Waymo, GAIA series — on autonomous driving world models
- **Complements**: (fully vertically integrated)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Tesla hardware only, fully closed system
- **Source**: [Tesla AI](https://www.tesla.com/AI)

**Implied reference architecture**: Fully vertical — custom silicon (HW4/5), custom inference stack, custom data engine (fleet-collected video), custom world model (Occupancy Networks), custom planner. No external dependencies or integration points by design.

**Platform relevance**:

- **Partnership surface**: Minimal — Tesla does not partner on AI stack
- **Competitive surface**: Autonomous driving world models
- **What they need from a platform**: Nothing — fully self-contained. Relevant as a benchmark for what production-scale world model deployment looks like.

---

### Siemens

**Type**: `Big Tech`
**About**: Industrial conglomerate building "autonomous digital twins" — AI-driven simulations that optimize manufacturing in real time. Partnership with NVIDIA (CES 2026) to create an "Industrial AI Operating System." First AI-driven adaptive factory in Erlangen, 2026.

**Solutions**:

#### Xcelerator

- **What it does**: Open digital business platform for industrial digital twins — connects IoT data, simulation, and AI for manufacturing optimization, predictive maintenance, and autonomous operations.
- **Building blocks covered**: [Digital Twin Runtime](building-blocks.md#digital-twin-runtime), [Simulation Engines](building-blocks.md#simulation-engines)
- **Key features (functional)**: Industrial IoT integration, CAD/PLM tools, simulation (Simcenter), low-code automation, PepsiCo digital twin reference case
- **Key features (non-functional)**: Cloud and on-prem, industrial-grade reliability
- **Competes with**: Omniverse (digital twins), Eclipse Ditto (open-source), PTC ThingWorx — on industrial digital twin capability
- **Complements**: NVIDIA Omniverse (rendering/physics via partnership), PhysicsNeMo (physics ML)
- **Openness**: `Proprietary` (marketplace with partner apps)
- **Lock-in vectors**: Siemens tool ecosystem (NX, Teamcenter), proprietary data formats, Siemens Cloud
- **Source**: [Xcelerator](https://xcelerator.siemens.com)

**Implied reference architecture**: Industrial AI Operating System built on Xcelerator + NVIDIA Omniverse. Siemens provides domain expertise (manufacturing processes, PLM, MES), NVIDIA provides GPU-accelerated simulation and AI. Digital twins feed autonomous control loops for factory optimization.

**Platform relevance**:

- **Partnership surface**: Industrial domain expertise, manufacturing process knowledge, OT integration
- **Competitive surface**: Industrial digital twins, factory automation AI
- **What they need from a platform**: AI model management for industrial models, safety/certification frameworks, cross-vendor interoperability

---

### Schneider Electric

**Type**: `Big Tech`
**About**: Energy management and industrial automation company deploying AI-driven digital twins for autonomous industrial operations. Targets 80% operational autonomy by 2030 across energy and chemicals verticals.

**Solutions**:

#### EcoStruxure

- **What it does**: IoT-enabled platform for energy management and industrial automation — integrates connected products, edge control, and cloud analytics with AI-driven digital twins.
- **Building blocks covered**: [Digital Twin Runtime](building-blocks.md#digital-twin-runtime), [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime)
- **Key features (functional)**: AI factory power digital twin (with ETAP on Omniverse), generative AI co-pilot for automation engineering, energy optimization, predictive maintenance
- **Key features (non-functional)**: Industrial-grade, targets 80% operational autonomy by 2030
- **Competes with**: Siemens Xcelerator, Honeywell Forge — on industrial automation and energy management
- **Complements**: NVIDIA Omniverse (rendering/physics), ETAP (power systems)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Schneider hardware ecosystem, proprietary protocols, EcoStruxure platform dependency
- **Source**: [EcoStruxure](https://www.se.com/ww/en/work/campaign/innovation/overview.jsp)

**Implied reference architecture**: Connected products at the edge feeding data to EcoStruxure cloud, with AI digital twins for autonomous decision-making. NVIDIA Omniverse provides simulation backbone for power and process digital twins. Generative AI co-pilot assists human operators during transition to autonomous operations.

**Platform relevance**:

- **Partnership surface**: Energy/utilities domain expertise, OT integration, edge deployment
- **Competitive surface**: Industrial digital twins for energy and process industries
- **What they need from a platform**: AI model lifecycle management, cross-vendor digital twin interoperability, safety certification for autonomous operations

---

### Amazon

**Type**: `Big Tech`
**About**: Largest deployer of warehouse robots globally (1M+ robots across 300+ fulfillment centers). Robotics AI is exclusively internal — no external robotics products or services. Reverse-acquihired [Covariant](#covariant-acquired-by-amazon-2024) (RFM-1, Pieter Abbeel) in Aug 2024 for ~$400M. Deprecated AWS RoboMaker (robotics cloud service) in 2024, signaling exit from robotics-as-a-service. Validates the warehouse automation use case at unprecedented scale but does not participate as a platform vendor or partner.

**Solutions**:

#### DeepFleet

- **What it does**: Generative AI foundation model for fleet coordination — predicts traffic patterns for mobile robot fleets, optimizes routing, reduces congestion. Trained on millions of hours of fulfillment center data.
- **Building blocks covered**: Fleet Management (internal)
- **Key features (functional)**: Real-time fleet coordination, traffic prediction, route optimization (~10% efficiency improvement)
- **Key features (non-functional)**: Operates across 1M+ robots in 300+ fulfillment centers
- **Openness**: `Proprietary`
- **Source**: [Amazon DeepFleet announcement](https://www.aboutamazon.com/news/operations/amazon-million-robots-ai-foundation-model)

#### Vulcan

- **What it does**: Dual-arm manipulation robot with tactile sensing ("sense of touch") for warehouse pick/stow tasks. AI-driven force feedback for handling items in tightly packed pods.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models) (internal)
- **Key features (functional)**: Tactile grasping, dual-arm coordination, ergonomic task offloading (top/bottom shelf access)
- **Key features (non-functional)**: Completed pilot, entering beta testing (2026)
- **Openness**: `Proprietary`
- **Source**: [Amazon Vulcan](https://www.aboutamazon.com/news/operations/amazon-vulcan-robot-pick-stow-touch)

**Implied reference architecture**: Captive fleet of 1M+ robots (Proteus, Hercules, Pegasus, Vulcan) coordinated by DeepFleet foundation model, with RFM-1/Covariant Brain technology for manipulation intelligence. All internal — no external platform exposure.

**Platform relevance**:

- **Partnership surface**: None for robotics. AWS remains relevant for general AI/ML (SageMaker, Bedrock) and as Intel Foundry customer (18A for AI Fabric chips)
- **Competitive surface**: None — Amazon's robotics is captive. Validates warehouse automation as the largest real-world Physical AI deployment
- **What they need from a platform**: Nothing external — Amazon builds its own infrastructure end-to-end

**Collaborations**: [Covariant](#covariant-acquired-by-amazon-2024) (acquihire), Rivr (acquired Mar 2026, last-mile delivery robots)

**Links**: [Amazon Robotics](https://www.aboutamazon.com/news/tag/robotics), [Amazon Science — Robotics](https://www.amazon.science/research-areas/robotics)

---

## Startups

*Venture-backed companies building Physical AI products*

### AMI Labs

**Type**: `Startup`
**Stage/Scale**: Seed — $1.03B raised (March 2026) at $3.5B pre-money valuation (largest European seed round ever)
**About**: Paris-based startup founded by [Yann LeCun](#yann-lecun) (Chairman) in Jan 2026 after leaving Meta FAIR. Building JEPA-based world models for industrial, robotic, and healthcare applications as an alternative to the LLM paradigm. Offices in Paris, New York, Montreal, and Singapore.

**Key People**: Alex LeBrun (CEO), Laurent Solly (COO, ex-Meta VP Europe), Saining Xie (Chief Science Officer), Pascale Fung (Chief Research & Innovation Officer), Michael Rabbat (VP World Models)

**Focus Areas**: World models, JEPA, autonomous machine intelligence, robotics, industrial AI, healthcare

**Key Work**: Founded Jan 2026; focused on JEPA-based world models for Physical AI

**Collaborations**: NVIDIA (investor), Samsung (investor), Toyota Ventures (investor), Bezos Expeditions (investor)

**Platform relevance**:

- **Partnership surface**: JEPA world models as perception building blocks, potential early adopter of platform infrastructure
- **Competitive surface**: Could build own platform if successful at scale
- **What they need from a platform**: Deployment infrastructure, robot middleware integration, industrial data pipelines

**Links**: [MIT Tech Review announcement](https://www.technologyreview.com/2026/01/22/1131661/yann-lecuns-new-venture-ami-labs/), [TechCrunch $1B raise](https://techcrunch.com/2026/03/09/yann-lecuns-ami-labs-raises-1-03-billion-to-build-world-models/)

---

### Physical Intelligence (pi)

**Type**: `Startup`
**Stage/Scale**: $400M+ raised (reportedly seeking $1B round in 2026). Investors: Bezos Expeditions, Khosla Ventures, OpenAI Fund
**About**: Robotics foundation model company building vision-language-action (VLA) models for general-purpose robot manipulation. Co-founded by [Sergey Levine](#sergey-levine) and [Chelsea Finn](#chelsea-finn). ~80 employees; reportedly blown through their 5-10 year roadmap in 18 months. pi0/pi0.5 are policy models (not dynamics predictors) that represent a key consumer of world model outputs. pi0.5 (Apr 2026) claims first cross-embodiment generalization without per-robot fine-tuning. pi0.7 enables zero-shot task generalization to untrained tasks.

**Solutions**:

#### pi0 / pi0.5 / pi0.7

- **What it does**: VLA foundation models that translate visual observations and language instructions into dexterous robot actions. pi0.5 enables open-world generalization.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Cross-embodiment transfer, bimanual manipulation, open-world generalization (pi0.5), multi-task learning, MEM (multi-scale embodied memory for 10+ min tasks), RL Token for online RL fine-tuning
- **Key features (non-functional)**: 50Hz action generation via flow matching, trained on 10K+ hours robot data across 7 platforms
- **Competes with**: GR00T N1, Gemini Robotics, GEN-1 — on generalist robot policy
- **Complements**: World models (upstream perception), simulation platforms (training)
- **Openness**: `OSS-single-vendor` (via OpenPI)
- **Lock-in vectors**: Minimal — open-source release via OpenPI
- **Source**: [Website](https://www.physicalintelligence.company), [GitHub (OpenPI)](https://github.com/Physical-Intelligence/openpi)

**Platform relevance**:

- **Partnership surface**: VLA models as policy layer, OpenPI as integration point
- **Competitive surface**: Minimal — focused on models, not platforms
- **What they need from a platform**: Sim-to-real pipelines, model serving, robot middleware integration

**Links**: [Website](https://www.physicalintelligence.company), [GitHub (OpenPI)](https://github.com/Physical-Intelligence/openpi)

---

### Wayve

**Type**: `Startup`
**Stage/Scale**: $1.5B raised
**About**: UK-based autonomous driving company that built the GAIA series of generative world models (GAIA-1/2/3, 9B-15B params) for AV development. Deploying robotaxi service with Uber/Nissan (Tokyo pilot, late 2026). [Yann LeCun](#yann-lecun) is an investor.

**Solutions**:

#### GAIA Series

- **What it does**: Generative world models for autonomous driving — generates realistic driving scenarios for training and evaluating end-to-end driving systems.
- **Building blocks covered**: [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)
- **Key features (functional)**: GAIA-1 (2023), GAIA-2 (2024), GAIA-3 (Dec 2025, 15B params, driving system evaluation), controllable scenario generation
- **Key features (non-functional)**: 9B-15B parameters, purpose-built for AV evaluation
- **Competes with**: Cosmos, Genie 3 — on driving world simulation
- **Complements**: End-to-end driving policies (downstream consumer)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Wayve driving stack dependency
- **Source**: [Research](https://wayve.ai/thinking/)

**Collaborations**: Uber, Nissan (robotaxi deployment), [Yann LeCun](#yann-lecun) (investor)

**Links**: [Website](https://wayve.ai), [Research](https://wayve.ai/thinking/)

---

### World Labs

**Type**: `Startup`
**Stage/Scale**: (to be researched)
**About**: Founded by [Fei-Fei Li](#fei-fei-li) to pursue "Spatial Intelligence" as the scaffolding for cognition. Targeting VFX pre-visualization, architectural design, and synthetic data generation for robot training.

**Solutions**:

#### Marble

- **What it does**: Reconstructs persistent 3D worlds from multimodal inputs (text, images, 360-degree panoramas) with human-AI co-creation via "Chisel" feature.
- **Building blocks covered**: [Simulation Engines](building-blocks.md#simulation-engines), [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models)
- **Key features (functional)**: Multimodal 3D world reconstruction, persistent worlds, Chisel (interactive 3D editing by humans before AI visual fill)
- **Key features (non-functional)**: (to be populated)
- **Competes with**: Genie 3 — on 3D world generation from prompts
- **Complements**: Robot training pipelines (synthetic 3D data)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary model and platform
- **Source**: [Marble Blog](https://www.worldlabs.ai/blog/marble-world-model)

**Collaborations**: [Stanford](#stanford-svl--sail) (via [Fei-Fei Li](#fei-fei-li))

**Links**: [Website](https://www.worldlabs.ai/), [Marble Blog](https://www.worldlabs.ai/blog/marble-world-model)

---

### Figure AI

**Type**: `Startup`
**Stage/Scale**: $2.6B+ raised across three rounds. Valuation $39B (Sep 2025, IPO rumored at similar valuation). Investors: Brookfield, Intel, NVIDIA, Qualcomm, Salesforce, T-Mobile, Microsoft, OpenAI
**About**: Humanoid robotics company building general-purpose humanoid robots (Figure 02, Figure 03) with in-house VLA models (Helix). BotQ factory now producing 1 robot/hour (55+ Figure 03/week, 12K annual capacity). F.02 retired after BMW Spartanburg deployment (30K+ BMW X3s, 90K+ sheet metal parts with 5mm precision). 350+ units produced with Helix AI. Figure 03 ($20K, Oct 2025) designed for home and enterprise deployment. BMW expanding deployment from Figure 02 to Figure 03 at Spartanburg plant (Jun 2026), validating the humanoid-in-manufacturing use case at scale.

**Solutions**:

#### Helix / Helix 02

- **What it does**: VLA foundation model with a three-tier "System 0/1/2" architecture for full-body humanoid control. System 2 (VLM, 7-9Hz) handles scene understanding and language; System 1 (visuomotor policy, 200Hz) translates perception to actions; System 0 (kilohertz-rate) provides learned balance and coordination.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Full-body humanoid control (walking + manipulation as one system), dual-robot coordination on shared tasks, dexterous manipulation (pill extraction, syringe dispensing), 1000+ hours human motion data for System 0
- **Key features (non-functional)**: System 1 at 200Hz, System 0 at kHz rates, 4-minute autonomous task sequences (dishwasher unload/reload) with no resets
- **Competes with**: pi0/pi0.5, GR00T N1, Gemini Robotics — on dexterous humanoid control
- **Complements**: Figure 03 hardware (embedded tactile sensing, palm cameras), NVIDIA Cosmos (training data)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Tightly coupled to Figure hardware (tactile sensing, palm cameras)
- **Source**: [Helix](https://www.figure.ai/helix), [Helix 02](https://www.figure.ai/news/helix-02)

**Platform relevance**:

- **Partnership surface**: Potential consumer of simulation and synthetic data pipelines; Figure 03 as hardware target for third-party policies
- **Competitive surface**: Vertically integrated (model + hardware + manufacturing) — limited platform play
- **What they need from a platform**: Sim-to-real pipelines, synthetic data at scale, edge deployment infrastructure

**Collaborations**: [NVIDIA](#nvidia) (Cosmos, GR00T N1 adopter)

**Links**: [Website](https://www.figure.ai/), [Helix](https://www.figure.ai/helix), [Helix 02](https://www.figure.ai/news/helix-02)

---

### Generalist AI

**Type**: `Startup`
**Stage/Scale**: (to be researched)
**About**: Robotics foundation model company pursuing a "native embodied" approach — training directly on physical interaction data from wearable devices rather than internet images or teleoperation. Represents an alternative paradigm to VLAs (internet pretraining) and WAMs (video diffusion).

**Solutions**:

#### GEN-1

- **What it does**: Native embodied foundation model trained on 500K+ hours of human movement data captured via low-cost "data hands" (UMIs) for production manipulation tasks.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Data Annotation & Curation for Physical AI](building-blocks.md#data-annotation--curation-for-physical-ai)
- **Key features (functional)**: Native embodied training (not internet pretraining), wearable data collection, production manipulation
- **Key features (non-functional)**: 99% success rates on production tasks, 3x faster than SOTA (GEN-1, April 2026)
- **Competes with**: pi0/pi0.5, GR00T N1, Gemini Robotics — on robot manipulation
- **Complements**: Wearable data collection devices (data engine)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary data collection pipeline, closed model
- **Source**: [GEN-1 Blog](https://generalistai.com/blog/apr-02-2026-GEN-1)

**Links**: [Website](https://generalistai.com/), [GEN-1 Blog](https://generalistai.com/blog/apr-02-2026-GEN-1)

---

### Genesis AI

**Type**: `Startup`
**Stage/Scale**: Seed — $105M raised (one of the largest French seeds, matching Mistral's). Backers: Eclipse, Khosla Ventures, Bpifrance, Eric Schmidt, Daniela Rus, Vladlen Koltun
**About**: Full-stack robotics company building general-purpose robots with human-level physical manipulation. Founded Dec 2024 by Zhou Xian (PhD CMU) and Theophile Gervet (ex-Mistral). Offices in Paris, San Carlos CA, and London. Owns the full stack: foundation model (GENE), dexterous hands, simulation (Genesis World), and data engine (sensor gloves + egocentric video).

**Solutions**:

#### Genesis World

- **What it does**: Open-source multi-physics simulation platform with cross-platform compilation and path-traced rendering.
- **Building blocks covered**: [Simulation Engines](building-blocks.md#simulation-engines), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)
- **Key features (functional)**: Multi-physics simulation, Quadrants compiler (CUDA, ROCm, Metal, Vulkan, x86/ARM64), Nyx renderer (path-traced, noise-free 1080p in <4ms)
- **Key features (non-functional)**: 29K GitHub stars, Apache 2.0 license, cross-platform
- **Competes with**: Isaac Sim, MuJoCo, Gazebo — on physics simulation for robotics
- **Complements**: GENE (training environment), robot hardware (sim-to-real)
- **Openness**: `OSS-single-vendor`
- **Lock-in vectors**: Minimal — Apache 2.0, cross-platform
- **Source**: [GitHub](https://github.com/Genesis-Embodied-AI)

#### GENE

- **What it does**: Flow-matching foundation model for dexterous manipulation — trained on proprietary data from sensor gloves and egocentric video.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: GENE-26.5 (May 2026): 20-step cooking, Rubik's Cube solving, lab automation
- **Key features (non-functional)**: Human-level manipulation benchmarks
- **Competes with**: pi0/pi0.5, GR00T N1, GEN-1 — on dexterous manipulation
- **Complements**: Genesis World (simulation training), custom dexterous hands (hardware)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary data pipeline, Genesis hardware ecosystem
- **Source**: [Blog](https://www.genesis.ai/blog/gene-26-5-advancing-robotic-manipulation-to-human-level)

**Links**: [Website](https://www.genesis.ai), [GitHub](https://github.com/Genesis-Embodied-AI)

---

### Periodic Labs

**Type**: `Startup`
**Stage/Scale**: Seed — $300M raised (Oct 2025). Led by Andreessen Horowitz; backed by Jeff Bezos, Eric Schmidt, Jeff Dean, NVentures
**About**: Building autonomous "AI scientists" — closed-loop self-driving laboratories where AI agents propose hypotheses, run physical experiments, and analyze results with minimal human intervention. Founders William Fedus and Ekin Dogus Cubuk cite contributions to ChatGPT, GNoME, and MatterGen.

**Focus Areas**: Autonomous science, self-driving labs, materials discovery, physical AI for scientific research

**Key Work**: AI scientist platform for materials discovery (high-temperature superconductors, chip designs)

**Links**: [Website](https://periodic.com/)

---

### Medra

**Type**: `Startup`
**Stage/Scale**: $52M raised
**About**: Building autonomous self-driving labs for drug discovery — integrating AI with robotic laboratory automation in closed-loop systems that design, execute, and learn from biological experiments.

**Focus Areas**: Autonomous drug discovery, self-driving labs, laboratory robotics, closed-loop experimentation

**Key Work**: Medra Platform (autonomous robotic system for biological experiments), Genentech partnership

**Collaborations**: Genentech (drug discovery partnership)

**Links**: [Website](https://www.medra.ai/)

---

### Robbyant (Ant Group)

**Type**: `Startup`
**Stage/Scale**: Division of Ant Group (Alibaba affiliate)
**About**: Embodied AI division of Ant Group building a comprehensive foundation model stack for robotics. The LingBot family covers spatial perception, VLAs, world models, and video-action models.

**Solutions**:

#### LingBot Family

- **What it does**: Comprehensive foundation model stack: LingBot-Depth (spatial perception), LingBot-VLA (vision-language-action), LingBot-World (interactive world model), LingBot-VA (video-action model).
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Latent World Models](building-blocks.md#latent-world-models), [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models)
- **Key features (functional)**: LingBot-VA (autoregressive video-action, 20% better than pi0.5), LingBot-World (interactive simulator), LingBot-Depth (spatial perception), LingBot-Map (streaming 3D reconstruction)
- **Key features (non-functional)**: LingBot-VA: 98.5% on LIBERO benchmark (industry record); LingBot-World: 16 FPS, sub-second interaction latency
- **Competes with**: pi0/pi0.5, GR00T N1, Cosmos — across multiple building blocks
- **Complements**: vLLM-Omni community (LingBot-VA targeted for P1 integration)
- **Openness**: `OSS-single-vendor` (partially open)
- **Lock-in vectors**: Ant Group ecosystem, partially open-source
- **Source**: [GitHub](https://github.com/Robbyant), [LingBot-VA](https://github.com/Robbyant/lingbot-va)

**Links**: [Website](https://technology.robbyant.com/), [GitHub](https://github.com/Robbyant)

---

### Skild AI

**Type**: `Startup`
**Stage/Scale**: Series B — $1.7B+ raised ($14.5M seed 2023, $300M Series A July 2024, $1.4B Series B Jan 2026). Valuation >$14B. Investors: SoftBank (lead), NVIDIA NVentures, Macquarie Capital, Bezos Expeditions, Lightspeed, Coatue
**About**: Building the first omni-bodied robotics foundation model (Skild Brain) — a single model that controls any robot form factor without prior knowledge of embodiment. Founded 2023 as CMU spinout. Offices in Pittsburgh, San Francisco, and Bengaluru. Revenue ~$30M in first months of commercial deployment (2025).

**Solutions**:

#### Skild Brain

- **What it does**: Omni-bodied robot foundation model pre-trained on large-scale simulation and internet video, post-trained with targeted real-world data. Controls quadrupeds, humanoids, tabletop arms, and mobile manipulators without embodiment-specific retraining.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Cross-embodiment generalization (zero/few-shot to new robot forms), spatial reasoning, real-time adaptation, internet-video affordance extraction (treats humans as "biological robots")
- **Key features (non-functional)**: Handles 1.5x body-weight payloads, 10x reduction in total cost of ownership ($4K-$15K vs $250K+ conventional)
- **Competes with**: pi0/pi0.5, GR00T N1, Gemini Robotics — on generalist cross-embodiment robot control
- **Complements**: NVIDIA Isaac Lab (simulation), Cosmos (data augmentation), Omniverse (rendering)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary model, NVIDIA infrastructure dependency
- **Source**: [Skild Brain Blog](https://www.skild.ai/blogs/building-the-general-purpose-robotic-brain)

Skild Brain deployed on Foxconn assembly lines building NVIDIA Blackwell GPU servers in Houston, TX. Partnership accelerates data flywheel — more tasks, more real-world data, smarter model. Revenue ~$30M in first months of commercial deployment across warehousing, construction, and inspections.

**Implied reference architecture**: Software-only play — Skild Brain as a universal policy layer deployed on third-party robot hardware. Pre-training loop: simulation (Isaac Lab) + internet video → omni-bodied foundation model → post-training with customer-specific real-world data → deployment on customer robots.

**Platform relevance**:

- **Partnership surface**: Robot policy layer that needs deployment infrastructure, model serving, and sim-to-real pipelines
- **Competitive surface**: Minimal — focuses on brain, not platform or hardware
- **What they need from a platform**: Model hosting, edge deployment on diverse robot compute (not just Jetson), data pipelines for post-training

**Links**: [Website](https://www.skild.ai/), [NVIDIA Case Study](https://www.nvidia.com/en-us/case-studies/skild-ai/), [Foxconn deployment](https://technical.ly/entrepreneurship/pittsburgh-skild-ai-nvidia-foxconn-robotics-deployment/)

---

### 1X Technologies

**Type**: `Startup`
**Stage/Scale**: Series B — raised $125M (Jan 2025). Investors: EQT Ventures, Samsung Next, NVIDIA NVentures
**About**: Norwegian humanoid robotics company building household humanoid robots (NEO). Launched World Model Lab (June 2026) led by Sam Sinha (ex-Luma AI founding researcher). Distinctive approach: insists on force/action-consequence data paired with human-like embodiment rather than internet-pretrained VLAs. 20K pre-ordered NEO robots, shipping in 2026. NEO priced at $20K upfront or $499/month.

**Solutions**:

#### NEO

- **What it does**: Humanoid robot designed for household tasks (cleaning, laundry, basic meal prep) with full autonomy target.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: World-model-driven control (via World Model Lab), force/action-consequence learning, household task autonomy
- **Key features (non-functional)**: $20K price point, 4-week CAD-to-production iteration cycle, 20K pre-orders
- **Competes with**: Figure AI, Apptronik Apollo, Tesla Optimus, Unitree G1 — on household humanoid robotics
- **Complements**: NVIDIA GR00T N1 (adopter)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Vertically integrated hardware + software
- **Source**: [Website](https://www.1x.tech/)

**Platform relevance**:

- **Partnership surface**: World Model Lab may produce open research; robot hardware as deployment target
- **Competitive surface**: Vertically integrated — limited platform play
- **What they need from a platform**: Sim-to-real pipelines, world model training infrastructure, edge deployment

**Links**: [Website](https://www.1x.tech/), [Forbes (World Model Lab)](https://www.forbes.com/sites/johnkoetsier/2026/06/04/1x-launches-humanoid-robot-world-model-lab-you-cant-fine-tune-your-way-to-agi/)

---

### Unitree Robotics

**Type**: `Startup`
**Stage/Scale**: Filing $610M Shanghai A-share IPO (mid-2026). 335% revenue growth in 2025. Chinese firms led by Unitree account for >80% of global humanoid installations
**About**: Chinese robotics company building affordable quadruped and humanoid robots. G1 humanoid ($16K) and H2 Plus are volume leaders in humanoid production. 5,500+ units shipped in 2025 with 10K-20K+ targets for 2026. Selected by NVIDIA as hardware partner for Isaac GR00T Reference Humanoid Robot. Televised autonomous kung fu routine (Feb 2026) and -47°C arctic endurance test demonstrated platform maturity.

**Solutions**:

#### G1 / H2 Plus

- **What it does**: Affordable humanoid robot platforms for research, education, and enterprise deployment.
- **Building blocks covered**: [Robot Hardware Platforms](building-blocks.md#robot-hardware-platforms)
- **Key features (functional)**: Full-body locomotion, standing jump 1.4m (exceeds own height), cold-weather autonomy (-47°C tested), kung fu-level dynamic motion
- **Key features (non-functional)**: G1 at $16K price point (130cm tall), H2 Plus as NVIDIA reference robot base, 5500+ shipped in 2025
- **Competes with**: Figure AI Figure 03, Tesla Optimus, Agility Digit — on volume humanoid production
- **Complements**: NVIDIA Isaac GR00T (reference robot), LeRobot (supported hardware), third-party VLA models
- **Openness**: `Proprietary` (hardware), SDK available
- **Lock-in vectors**: Proprietary hardware, Chinese supply chain
- **Source**: [Website](https://www.unitree.com/)

**Platform relevance**:

- **Partnership surface**: Volume hardware platform for third-party software stacks; NVIDIA reference robot partnership; LeRobot integration
- **Competitive surface**: Hardware-focused — complementary to software platforms
- **What they need from a platform**: Robot middleware, fleet management, edge deployment infrastructure

**Links**: [Website](https://www.unitree.com/), [NVIDIA Reference Robot](https://nvidianews.nvidia.com/news/nvidia-open-humanoid-robot-reference-design), [Forbes](https://www.forbes.com/sites/jonmarkman/2026/04/27/unitree-g1-humanoid-robots-are-reshaping-the-robotics-investment-stack/)

---

### Covariant (acquired by Amazon, 2024)

**Type**: `Startup`
**Stage/Scale**: $222M raised ($625M valuation at Series C, Apr 2023). Co-founded by [Pieter Abbeel](#pieter-abbeel), Peter Chen, Rocky Duan, Tianhao Zhang. **Effectively defunct** — reverse-acquihired by Amazon in Aug 2024 for ~$400M (below last valuation).
**About**: Was a robotics AI company building foundation models for industrial manipulation. RFM-1 was deployed on 100+ warehouse robot arms. Differentiator was years of real-world pick trajectory data from commercial deployments. In Aug 2024, Amazon hired the three co-founders (Abbeel, Chen, Duan) plus ~25% of staff and licensed RFM-1 non-exclusively for ~$400M — structured as a "reverse acquihire" to avoid antitrust scrutiny (same pattern as Microsoft/Inflection, Google/Character.AI). Remaining company (~20 people) led by COO Ted Stinson and co-founder Tianhao Zhang. No product updates since Aug 2024; described as a "zombie company" in a 2025 FTC whistleblower complaint. RFM-1 technology now powers Amazon's warehouse robotics fleet (1M+ robots).

**Solutions**:

#### RFM-1

- **What it does**: 8B-parameter multimodal any-to-any robotics foundation model. Tokenizes text, images, video, robot actions, and physical measurements into a common space for next-token prediction. Enables language-guided programming, physics world model prediction, and in-context learning.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: Physics world model (predicts action outcomes via generated video), language-guided task specification, in-context learning (adapts grasping strategy on-the-fly from recent failures), any-to-any modality mapping
- **Key features (non-functional)**: Originally deployed on 100+ warehouse arms. Now absorbed into Amazon's robotics stack
- **Competes with**: pi0/pi0.5, GR00T N1, Gemini Robotics — on industrial manipulation (warehouse picking)
- **Complements**: Third-party robot arms (hardware-agnostic), warehouse management systems
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary model, now Amazon-controlled via non-exclusive license
- **Source**: [RFM-1](https://covariant.ai/rfm/)

**Platform relevance**:

- **Partnership surface**: No longer relevant — technology absorbed by Amazon for internal use
- **Competitive surface**: RFM-1 validates the robot foundation model approach for warehouse manipulation at scale
- **What they need from a platform**: N/A (Amazon runs its own infrastructure)

**Links**: [Website](https://covariant.ai/), [RFM-1](https://covariant.ai/rfm/), [IEEE Spectrum](https://spectrum.ieee.org/covariant-foundation-model), [Amazon deal announcement](https://www.aboutamazon.com/news/company-news/amazon-covariant-ai-robots), [Whistleblower report](https://www.hardresetmedia.com/p/whistleblower-ftc-complaint-about-amazon-covariant)

---

### BeingBeyond

**Type**: `Startup`
**Stage/Scale**: (to be researched)
**About**: Building a series of robot foundation models that combine VLA and WAM approaches. The Being-H family progresses from VLA-only (H0.5) to VLA+WAM hybrid (H0.7), demonstrating a clear path from language-grounded control to world-model-augmented planning.

**Solutions**:

#### Being-H0.5 / Being-H0.7

- **What it does**: Being-H0.5 is a VLM-based VLA for cross-embodiment generalization. Being-H0.7 adds a latent world-action model using V-JEPA 2.1 encodings with a Play-LMP-style prior/posterior latent interface, trained on 200K hours of egocentric human video + 15K hours of robot demonstrations.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: V-JEPA 2.1 visual encoder with Perceiver resampler, InternVL3.5 understanding expert, Qwen3 action expert with flow-matching policy, MoT transformer backbone
- **Key features (non-functional)**: Fast inference via posterior branch removal at test time (latent interface without full video regeneration)
- **Competes with**: pi0/pi0.5/pi0.7, GR00T N1, LingBot-VA — on VLA+WAM hybrid robot foundation models
- **Complements**: V-JEPA 2.1 (visual backbone), Cosmos (data augmentation)
- **Openness**: `Proprietary`
- **Source**: [Being-H0.5](https://arxiv.org/abs/2601.12993), [Being-H0.7](https://arxiv.org/abs/2605.00078)

**Platform relevance**:

- **Partnership surface**: Hybrid VLA+WAM architecture needs model serving, edge deployment, V-JEPA integration
- **Competitive surface**: Minimal — focuses on model, not platform
- **What they need from a platform**: Model hosting, V-JEPA 2.1 serving, edge inference for latent planning

---

### Rhoda AI

**Type**: `Startup`
**Stage/Scale**: (to be researched)
**About**: Building Direct Video Action (DVA) models — inverse-dynamics WAMs that leverage causal video models as data-efficient robot policy learners. DVA leans on generated or predicted future rollouts to derive actions.

**Solutions**:

#### DVA (Direct Video Action)

- **What it does**: Inverse-dynamics WAM that generates future video rollouts then infers actions from predicted transitions. Positions causal video models as a data-efficient path to robot policies.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models)
- **Key features (functional)**: Causal video model backbone, inverse-dynamics action inference, data-efficient robot policy learning
- **Competes with**: DreamZero (joint prediction WAM), pi0/pi0.5 (VLA), LingBot-VA
- **Openness**: (to be researched)
- **Source**: [Research blog](https://rhoda.ai/research/direct-video-action)

---

### Sereact

**Type**: `Startup`
**Stage/Scale**: (to be researched) — deployed in industrial manipulation
**About**: Industrial robotics company that has added WAM-style foresight as a planning layer inside deployed manipulation systems. Cortex 2.0 represents an industry signal for WAM adoption in production, not just research.

**Solutions**:

#### Cortex 2.0

- **What it does**: WAM-style planning system that generates candidate future trajectories in visual latent space, scores them for expected progress, risk, and efficiency, and conditions execution on the best-scored rollout. Described in "Grounding World Models in Real-World Industrial Deployment" (arXiv:2604.20246).
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: Visual latent space trajectory generation, multi-criteria scoring (progress, risk, efficiency), best-rollout conditioned execution
- **Key features (non-functional)**: Deployed in real industrial manipulation environments
- **Competes with**: pi0/pi0.5, GR00T N1 — on deployed robotic manipulation
- **Complements**: Simulation engines (for trajectory pre-training)
- **Openness**: `Proprietary`
- **Source**: [Project page](https://cortex2.sereact.ai), [Paper](https://arxiv.org/abs/2604.20246)

**Platform relevance**:

- **Partnership surface**: Industrial WAM deployment needs edge inference, model serving, safety certification
- **Competitive surface**: Minimal — niche industrial manipulation focus
- **What they need from a platform**: Edge deployment for real-time trajectory scoring, safety-certified runtimes

---

### Logical Intelligence

**Type**: `Startup`
**Stage/Scale**: (to be researched). Investors: Pantera Capital
**About**: Building Energy-Based Reasoning Models (EBRMs) as an alternative to LLMs for critical systems. [Yann LeCun](#yann-lecun) serves as Founding Chair of the Technical Research Board, connecting directly to the JEPA/EBM research lineage.

**Solutions**:

#### Kona

- **What it does**: Energy-based reasoning model using energy minimization rather than next-token prediction — operates in continuous latent space with non-autoregressive trace generation for mathematical and logical reasoning.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: Energy-based reasoning, constraint satisfaction, mathematical verification, deterministic outputs for critical systems
- **Key features (non-functional)**: (to be populated)
- **Competes with**: LLM-based reasoning (GPT, Claude, Gemini) — on deterministic reasoning for critical systems
- **Complements**: Aleph (verified coding AI, near-perfect PutnamBench score)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary model and API
- **Source**: [Kona Technical](https://logicalintelligence.com/kona-ebms-energy-based-models)

**Links**: [Website](https://logicalintelligence.com/), [Blog](https://logicalintelligence.com/blog/energy-based-models-for-reasoning)

---

### Verses AI

**Type**: `Startup`
**Stage/Scale**: (to be researched)
**About**: Pursues a biology-inspired approach to world models based on Active Inference and the Free Energy Principle. Key differentiator: creates a hierarchy of intelligent agents within a single robot body — every joint is an agent with its own local understanding.

**Solutions**:

#### AXIOM

- **What it does**: Active Inference architecture (Active eXpanding Inference with Object-centric Models) that unifies perception, planning, and control in a single generative model where agents actively seek to resolve epistemic uncertainty.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models), [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Hierarchical agent architecture (per-joint agents), active uncertainty resolution, object-centric modeling, recovery from unexpected problems without retraining
- **Key features (non-functional)**: (to be populated)
- **Competes with**: Standard VLA/world model approaches — on adaptive, uncertainty-aware control
- **Complements**: Karl Friston's Free Energy Principle (theoretical foundation)
- **Openness**: (to be populated)
- **Lock-in vectors**: (to be populated)
- **Source**: [Research](https://www.verses.ai/research)

**Collaborations**: Karl Friston (scientific advisor, Free Energy Principle originator)

**Links**: [Website](https://www.verses.ai/), [Research](https://www.verses.ai/research)

---

### Pathway

**Type**: `Startup`
**Stage/Scale**: (to be researched)
**About**: Company behind the Baby Dragon Hatchling (BDH) architecture — a biologically-inspired alternative to transformers demonstrating that scale-free spiking networks with Hebbian learning can match GPT-2 performance while providing built-in interpretability.

**Solutions**:

#### BDH (Baby Dragon Hatchling)

- **What it does**: Biologically-inspired language model using scale-free spiking networks with Hebbian learning as an alternative to transformers.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: Scale-free spiking network, Hebbian learning, neuroscience-grounded interpretability, matches GPT-2 performance
- **Key features (non-functional)**: Open-source implementation
- **Competes with**: Transformers (GPT, Llama) — on interpretable language modeling
- **Complements**: Neuroscience research (biological plausibility)
- **Openness**: `OSS-single-vendor`
- **Lock-in vectors**: Minimal — open-source
- **Source**: [GitHub](https://github.com/pathwaycom/bdh)

**Collaborations**: [Adrian Kosowski](#adrian-kosowski) (lead researcher), University of Wroclaw

**Links**: [GitHub](https://github.com/pathwaycom/bdh), [Website](https://pathway.com)

---

### Safe Superintelligence Inc. (SSI)

**Type**: `Startup`
**Stage/Scale**: $3B raised at $32B valuation (as of April 2025)
**About**: Israeli-American AI research company co-founded by [Ilya Sutskever](#ilya-sutskever), Daniel Gross, and Daniel Levy in June 2024. Single-mission company focused solely on building safe superintelligence — no products, no revenue, pure research. Sutskever advocates a "post-scaling" paradigm, betting on JEPA-style architectures and continual learning.

**Focus Areas**: Safe superintelligence, continual learning, generalization, alignment-as-generalization

**Key Work**: No publications (extremely secretive); Sutskever's public statements point to JEPA-style architectures, continual learning, and the "Big World Hypothesis" as research directions

**Collaborations**: Google Cloud (TPU access partnership, April 2025)

**Links**: [Website](https://ssi.inc/), [Wikipedia](https://en.wikipedia.org/wiki/Safe_Superintelligence_Inc.)

---

### OpenAI

**Type**: `Startup`
**Stage/Scale**: (to be researched)
**About**: Built Sora/Sora 2, diffusion transformer models for video generation positioned as "teaching AI to understand and simulate the physical world." Illustrates both the ambition and the commercial challenge of pixel-space world simulation at scale.

**Solutions**:

#### Sora

- **What it does**: Diffusion transformer for video generation — generates realistic video from text/image prompts with physical world simulation capabilities. Standalone product discontinued March 2026 due to unsustainable compute costs; model continues to exist.
- **Building blocks covered**: [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models)
- **Key features (functional)**: Text-to-video generation, image-to-video, physics-aware generation (Sora 2 improved coherence)
- **Key features (non-functional)**: Sora 2 (Sept 2025) improved physics; product discontinued March 2026
- **Competes with**: Cosmos, Genie 3, Veo — on video generation
- **Complements**: (standalone, no integration ecosystem)
- **Openness**: `Proprietary`
- **Lock-in vectors**: OpenAI API dependency (while product existed)
- **Source**: [Website](https://openai.com)

**Links**: [Website](https://openai.com), [Research](https://openai.com/research)

---

### Intrinsic (Google)

**Type**: `Big Tech`
**Stage/Scale**: Alphabet X graduate (2021); folded into Google Feb 2026. Foxconn JV (Oct 2025)
**About**: Robotics software platform building the "Android for industrial robots." Flowstate dev environment + Intrinsic Vision Model (IVM) + Model M behavioral AI. Only ~10% of factories are fully automated; Intrinsic targets the other 90% by making robot programming accessible to non-experts. Now operates under Google alongside DeepMind, leveraging Gemini models and Google Cloud.

**Solutions**:

#### Flowstate

- **What it does**: Hardware-agnostic, drag-and-drop developer environment for building and deploying AI-powered robot applications — from design through deployment, including sim-to-real.
- **Building blocks covered**: [Robot Middleware](building-blocks.md#robot-middleware), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)
- **Key features (functional)**: Visual workflow builder, modular AI capabilities (perception, motion planning, sensor-based control), hardware-agnostic (any robot/camera/sensor manufacturer)
- **Key features (non-functional)**: Web-based, sim-to-real with "a few clicks"
- **Competes with**: ROS2/MoveIt (on ease of use), NVIDIA Isaac (on platform completeness) — differentiates on accessibility for non-roboticists
- **Complements**: NVIDIA Isaac Sim/Omniverse (rendering/physics via GTC 2025 partnership), Google Gemini (reasoning), Google Cloud (infrastructure)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Google Cloud dependency (post-integration), Flowstate workflow format, Intrinsic API
- **Source**: [Flowstate](https://www.intrinsic.ai/flowstate)

#### Intrinsic Vision Model (IVM)

- **What it does**: Industrial perception foundation model — AI-powered pose estimation achieving sub-millimeter precision with standard RGB cameras and zero application-specific training.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Sub-mm pose estimation, zero-shot (no per-application training), standard RGB camera input
- **Key features (non-functional)**: 1st place in 7/11 ICCV 2025 benchmarks
- **Competes with**: Custom perception pipelines, Isaac Perceptor — on industrial pose estimation
- **Complements**: Flowstate (integrated perception capability)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Intrinsic platform dependency
- **Source**: [Intrinsic AI](https://www.intrinsic.ai/capabilities)

**Implied reference architecture**: Flowstate as the developer layer, IVM for perception, Model M for behavior, running on Google Cloud with Gemini for reasoning. NVIDIA Omniverse/Isaac Sim for digital twins and simulation. Foxconn JV as the manufacturing integration partner for electronics assembly.

**Platform relevance**:

- **Partnership surface**: Potential integration partner — Flowstate could consume platform services (model serving, data pipelines, fleet management)
- **Competitive surface**: Direct competitor for "robot platform" positioning; Google backing makes this a serious threat
- **What they need from a platform**: Vendor-neutral deployment (beyond Google Cloud), safety certification, multi-vendor fleet orchestration

**Links**: [Website](https://www.intrinsic.ai/), [TechCrunch (Google integration)](https://techcrunch.com/2026/02/25/alphabet-owned-robotics-software-company-intrinsic-joins-google/), [Foxconn JV](https://siliconangle.com/2025/11/20/alphabets-intrinsic-foxconn-plan-accelerate-factory-automation-smarter-robots/)

---

### Liquid AI

**Type**: `Startup`
**Stage/Scale**: $250M raised (Dec 2024). MIT CSAIL spinout. Cambridge, MA
**About**: Building edge-optimized Liquid Foundation Models (LFMs) using a novel "liquid neural network" architecture rooted in dynamical systems theory. Models from 350M–24B params run on GPUs, CPUs, or NPUs across phones, cars, wearables, and robots. Differentiates from cloud-centric AI companies by targeting on-device inference with frontier-grade performance at a fraction of the compute. Liquid Nanos (350M–2.6B) claim GPT-4o-class performance on specialized agentic tasks while running under 1GB.

**Solutions**:

#### Liquid Foundation Models (LFMs)

- **What it does**: General-purpose AI models purpose-built for edge deployment — text, vision-language, audio, and embedding models using proprietary device-aware architecture search.
- **Building blocks covered**: [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime), [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Multi-modal (text, vision-language, audio, embedding), Liquid Nanos (350M–2.6B for on-device), MoE architectures, LEAP fine-tuning/deployment platform
- **Key features (non-functional)**: Sub-1GB models, sub-20ms latency (Shopify deployment), runs on GPU/CPU/NPU across wearables to robots
- **Competes with**: Qualcomm AI Engine, MediaTek NeuroPilot, NVIDIA Jetson stack — on edge AI inference; also competes with Mistral/Llama on small efficient models
- **Complements**: AMD (hardware partnership), robot platforms (on-board inference)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary architecture, LEAP deployment platform, model format
- **Source**: [Website](https://www.liquid.ai/), [Models](https://www.liquid.ai/models)

**Platform relevance**:

- **Partnership surface**: LFMs as on-device inference layer for robot perception/control; LEAP as deployment target for platform-managed models
- **Competitive surface**: Edge inference runtime overlaps with platform edge deployment
- **What they need from a platform**: Model lifecycle management, fleet-wide model updates, integration with robot middleware

**Collaborations**: Mercedes-Benz (in-car intelligence), Shopify (sub-20ms models), AMD (hardware), Insilico Medicine (drug discovery), Robotec.ai (robotics demo)

**Links**: [Website](https://www.liquid.ai/), [Funding announcement](https://www.liquid.ai/blog/we-raised-250m-to-scale-capable-and-efficient-general-purpose-ai), [McKinsey analysis](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-case-for-liquid-foundation-models)

---

### Staer AI

**Type**: `Startup`
**Stage/Scale**: Pre-seed — €3.5M raised (Oct 2025, Pale Blue Dot, LDV Capital). Preparing €4.3M follow-on. Malmö, Sweden (fully remote)
**About**: Building spatial intelligence software for autonomous mobile robot fleets in warehouse and logistics environments. Founded by Jan Erik Solem (previous exits to Apple in 2010 and Meta in 2020) with team from Apple, Mapillary, and Meta with 15+ years computer vision experience. Sensor- and robot-agnostic platform solving multi-vendor fleet coordination.

**Solutions**:

#### Staer Platform

- **What it does**: Spatial intelligence + fleet orchestration for autonomous mobile robots — semantic 3D mapping, real-time activity monitoring, and multi-robot coordination from existing sensors.
- **Building blocks covered**: [Robot Middleware](building-blocks.md#robot-middleware), [Digital Twin Runtime](building-blocks.md#digital-twin-runtime)
- **Key features (functional)**: Semantic 3D facility maps, continuous cycle counts, multi-vendor robot coordination, sensor-agnostic (works with any robot's existing sensors), real-time congestion/bottleneck detection
- **Key features (non-functional)**: Cloud-based map service, continuous updates as robots traverse facility
- **Competes with**: 6 River Systems, Locus Robotics, Fetch Robotics — on warehouse fleet orchestration; differentiates on vendor-agnostic spatial intelligence layer
- **Complements**: Any mobile robot hardware (sensor-agnostic), warehouse management systems
- **Openness**: `Proprietary`
- **Lock-in vectors**: Cloud service dependency, proprietary spatial intelligence models
- **Source**: [Website](https://staer.ai/), [Platform](https://staer.ai/platform/)

**Platform relevance**:

- **Partnership surface**: Spatial intelligence as a building block for robot fleet management; vendor-agnostic approach aligns with platform philosophy
- **Competitive surface**: Fleet orchestration overlaps with platform fleet management capabilities
- **What they need from a platform**: Edge deployment for on-premise spatial processing, integration with broader robot middleware, scale beyond warehouses

**Links**: [Website](https://staer.ai/), [Funding](https://startupmafia.eu/malmo-based-robotics-startup-staer-raised-e3-5m-pre-seed-for-ai-driven-autonomous-robot-fleets), [Pale Blue Dot thesis](https://palebluedotvc.substack.com/p/why-spatial-intelligence-will-power)

---

### LiveKit

**Type**: `Startup`
**Stage/Scale**: $183M total raised. $1B valuation (Series C, Jan 2026, Index Ventures). San Francisco
**About**: Open-source (Apache 2.0) real-time media framework for voice, video, and physical AI agents. Built on WebRTC. 200K+ developers. Powers ChatGPT Advanced Voice Mode (OpenAI), used by xAI, Meta, Spotify. Positioned as the real-time communication infrastructure layer for AI agents — including robots that need cloud-based reasoning with low-latency media streaming.

**Solutions**:

#### LiveKit Agents Framework

- **What it does**: Open-source Python framework for building real-time voice/video AI agents with STT-LLM-TTS pipeline, turn detection, interruption handling, multi-agent handoff, and native MCP tool support.
- **Building blocks covered**: [Model Serving for Physical AI](building-blocks.md#model-serving-for-physical-ai), [Robot Middleware](building-blocks.md#robot-middleware)
- **Key features (functional)**: Voice/video/text multimodal agents, native MCP support, multi-agent handoff, tool use with any LLM, adaptive interruption handling
- **Key features (non-functional)**: 11K GitHub stars (agents), 19.3K stars (server), Apache 2.0, Python 1.5.x, sub-second latency
- **Competes with**: Daily.co, Twilio — on real-time media; Rasa, Voiceflow — on voice agents
- **Complements**: Any LLM (OpenAI, Anthropic, etc.), robot platforms (cloud brain connectivity), MCP servers
- **Openness**: `OSS-single-vendor`
- **Lock-in vectors**: LiveKit Cloud for managed deployment, proprietary cloud features beyond OSS
- **Source**: [Website](https://livekit.com/), [GitHub (agents)](https://github.com/livekit/agents), [GitHub (server)](https://github.com/livekit/livekit)

**Platform relevance**:

- **Partnership surface**: Real-time media layer for robot teleoperation, cloud-brain architectures, and voice-controlled robotics
- **Competitive surface**: Minimal — infrastructure layer, not a robot platform
- **What they need from a platform**: Integration with robot middleware (ROS2), edge-to-cloud media routing, fleet-scale agent orchestration

**Links**: [Website](https://livekit.com/), [Docs](https://docs.livekit.io/agents/), [Series C](https://siliconangle.com/2026/01/22/livekit-raises-100m-1b-valuation-scale-real-time-ai-media-platform/)

---

### Field AI

**Type**: `Startup`
**Stage/Scale**: $405M raised across two rounds ($314M co-led by Bezos Expeditions, Prysm Capital, Temasek). $2B valuation. Irvine, CA
**About**: Building "physics-first" Field Foundation Models (FFMs) — embodiment-agnostic autonomy software enabling robots to navigate dynamic unstructured environments without maps, GPS, or predefined trajectories. Founded by Ali Agha (ex-NASA JPL robotics technologist). Team from DeepMind, Google Brain, Tesla Autopilot, JPL, SpaceX, Zoox, Cruise. Proven across quadrupeds, humanoids, wheeled robots, and passenger-scale vehicles.

**Solutions**:

#### Field Foundation Models (FFMs)

- **What it does**: Physics-first foundation models for embodied intelligence in unstructured environments — designed from the ground up for uncertainty, risk, and physical constraints rather than retrofitted from vision/language models.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)
- **Key features (functional)**: Hardware-agnostic (quadrupeds, humanoids, wheeled, vehicles), GPS/map-free navigation, dynamic environment adaptation without reprogramming, NVIDIA Cosmos world model integration for training
- **Key features (non-functional)**: Operates in unstructured/dynamic conditions, safety-aware decision-making
- **Competes with**: Skild Brain, Boston Dynamics (navigation), Waymo (AV segment) — on autonomous navigation in unstructured environments
- **Complements**: NVIDIA Cosmos (training data), Isaac Sim (simulation), any robot hardware (embodiment-agnostic)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary FFMs, NVIDIA infrastructure for training
- **Source**: [Website](https://www.fieldai.com/), [Funding](https://www.fieldai.com/news/fieldai-announces-over-400m-in-funds-raised-to-advance-embodied-ai-at-scale)

**Platform relevance**:

- **Partnership surface**: FFMs as autonomy layer for platform-managed robots; needs deployment infrastructure, fleet management
- **Competitive surface**: Minimal — focused on autonomy software, not platform
- **What they need from a platform**: Model hosting, edge deployment across diverse hardware, data pipelines, safety certification

**Links**: [Website](https://www.fieldai.com/), [The Robot Report](https://www.therobotreport.com/fieldai-raises-405m-scales-physics-first-foundation-models-robots/)

---

### Agility Robotics

**Type**: `Startup`
**Stage/Scale**: ~$683M total raised. $2.1B valuation (Series C, $400M, March 2025, WP Global Partners, SoftBank, Amazon). Oregon State University spinout (2015). Salem, OR
**About**: Only humanoid robot company with meaningful commercial deployments. Digit robot (5'9", 35 lb lift capacity) operating in Amazon, GXO, Schaeffler, Spanx, and Mercado Libre facilities — 100K+ totes moved. RoboFab manufacturing facility (70K sq ft) in Salem, OR. Robot-as-a-Service at $30/hr. Multi-year commercial agreement with GXO (industry first). Powered by NVIDIA Jetson AGX Thor.

**Solutions**:

#### Digit

- **What it does**: Bipedal humanoid robot purpose-built for logistics — tote handling, conveyor loading, warehouse traversal including ramps, curbs, and dock plates that stop wheeled robots.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime)
- **Key features (functional)**: Bipedal locomotion, 35 lb payload, 360° vision (cameras + lidar + IMU), human-scale environment navigation, tote handling
- **Key features (non-functional)**: $30/hr RaaS model, 100+ units deployed, RBR50 Robot of the Year (2023, 2024)
- **Competes with**: Figure AI, Apptronik Apollo, Tesla Optimus, 1X — on humanoid logistics
- **Complements**: NVIDIA Jetson AGX Thor (compute), Agility Arc (fleet orchestration platform)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Vertically integrated (hardware + software + manufacturing + fleet management)
- **Source**: [Website](https://www.agilityrobotics.com/), [Digit](https://www.agilityrobotics.com/digit)

**Platform relevance**:

- **Partnership surface**: Potential consumer of sim-to-real and training infrastructure; Agility Arc fleet platform could integrate with broader fleet management
- **Competitive surface**: Vertically integrated — limited platform interop by design
- **What they need from a platform**: Sim-to-real training infrastructure at scale, safety certification frameworks, multi-site fleet management

**Collaborations**: Amazon (investor + pilot customer), GXO (multi-year commercial deployment), NVIDIA (Jetson AGX Thor), Schaeffler, Mercado Libre

**Links**: [Website](https://www.agilityrobotics.com/), [GXO agreement](https://www.agilityrobotics.com/content/gxo-signs-industry-first-multi-year-agreement-with-agility-robotics), [Contrary Research profile](https://research.contrary.com/company/agility-robotics)

---

### Foxglove

**Type**: `Startup`
**Stage/Scale**: $58.7M total (Series B $40M, Nov 2025, led by Bessemer). 88 employees. San Francisco
**About**: Multimodal data and observability platform for robotics — the "Datadog for robots." Co-founded by Adrian Macneil and Roman Shtylman (both ex-Cruise). MCAP open-source logging format adopted as standard in ROS 2 and NVIDIA Isaac. Closed-sourced the viewer in March 2024 (Foxglove 2.0), triggering community forks (Flora, AD-EYE). Customers include NVIDIA, Amazon, Anduril, Wayve, Dexterity.

**Solutions**:

#### Foxglove Platform

- **What it does**: Full-stack observability for robotics — unified visualization and debugging of 3D, video, audio, GPS, and time-series sensor data. Combines data collection, analysis, and fleet-level insights.
- **Building blocks covered**: [Data Annotation & Curation for Physical AI](building-blocks.md#data-annotation--curation-for-physical-ai), [Evaluation & Benchmarking Infrastructure](building-blocks.md#evaluation--benchmarking-infrastructure)
- **Key features (functional)**: Multimodal data visualization (3D, video, audio, GPS, time-series), fleet-level observability, event/incident debugging, data pipeline for training
- **Key features (non-functional)**: Dexterity reports 20% dev time savings and $150K annual savings in tooling
- **Competes with**: Custom internal tools, Webviz (predecessor) — on robotics observability
- **Complements**: ROS 2, NVIDIA Isaac, any robot middleware (via MCAP format)
- **Openness**: `OSS-single-vendor` (MCAP format is open-source; platform is proprietary)
- **Lock-in vectors**: Foxglove Cloud for fleet-level features, MCAP format adoption (though open)
- **Source**: [Website](https://foxglove.dev/), [MCAP](https://mcap.dev/)

#### MCAP

- **What it does**: Open-source container file format for multimodal robotics data — stores heterogeneous sensor data (images, point clouds, poses, time-series) in a single file with efficient random access.
- **Building blocks covered**: [Data Annotation & Curation for Physical AI](building-blocks.md#data-annotation--curation-for-physical-ai)
- **Key features (functional)**: Multi-topic, multi-format, efficient seeking, append-only writing
- **Key features (non-functional)**: Adopted by ROS 2 and NVIDIA Isaac as standard logging format
- **Competes with**: ROS bags (legacy), custom formats — on robotics data serialization
- **Openness**: `OSS-community` (MIT license)
- **Lock-in vectors**: Minimal — open format
- **Source**: [MCAP](https://mcap.dev/), [GitHub](https://github.com/foxglove/mcap)

**Platform relevance**:

- **Partnership surface**: Observability layer that any robot platform needs; MCAP as data format standard
- **Competitive surface**: Data pipeline overlaps with platform data management
- **What they need from a platform**: Integration with model training pipelines, fleet management, deployment infrastructure

**Links**: [Website](https://foxglove.dev/), [Funding](https://www.therobotreport.com/foxglove-raises-40m-scale-data-platform-roboticists/), [Foxglove 2.0](https://foxglove.dev/blog/foxglove-2-0-unifying-robotics-observability)

---

### Rerun

**Type**: `Startup`
**Stage/Scale**: $20.2M total (Seed $17M, Mar 2025, led by Point Nine). ~78 employees. Stockholm, Sweden
**About**: "The Data Layer for Physical AI" — multimodal data infrastructure for logging, visualizing, querying, and training on sensor data from robots, drones, and autonomous vehicles. Founded 2022 by Nikolaus West (CEO, ex-Volumental), Emil Ernerfeldt (CTO, creator of egui — largest Rust GUI framework), and Moritz Schiebold (COO, ex-Volumental CEO). Chief Architect Jeremy Leibs (ex-Willow Garage, created rosbag format). Team from Apple, AWS, Meta, Unity, Zipline. Open-core model: SDK is OSS (Apache-2.0 + MIT), commercial Rerun Hub for team-scale data catalog + GPU-direct training. Angel investors include Eric Jang (1X VP AI), Wes McKinney (pandas/Arrow creator). Adopted by LeRobot (Hugging Face), NVIDIA PyCuVSLAM, Meta Reality Labs (Project Aria), Google DeepMind (Brush), Unitree.

**Solutions**:

#### Rerun SDK

- **What it does**: Open-source SDK for logging, storing, querying, and visualizing multi-rate, multimodal Physical AI data. Column-chunk .rrd storage format. Built-in viewer (native + WASM browser). SDKs in Python, Rust, C++.
- **Building blocks covered**: [Sensor Data Ingestion](building-blocks.md#sensor-data-ingestion), [Robot Fleet Management & Observability](building-blocks.md#robot-fleet-management--observability)
- **Key features (functional)**: Logs images, point clouds, transforms, time series, joint states, video; timeline scrubbing with multi-view synchronization; dataframe/SQL queries; reads MCAP, LeRobot, .rrd formats; Blueprint APIs for programmatic layout; plugin system for custom views
- **Key features (non-functional)**: 11K GitHub stars, 781 forks, 78 releases. Rust-first (83.6%) for performance. WebAssembly browser viewer. Column-chunk storage 20-30x faster than naive time-series approaches
- **Competes with**: Foxglove, RViz — on robotics data visualization and debugging
- **Complements**: LeRobot, ROS 2, any robot middleware; ML training frameworks (PyTorch)
- **Openness**: `OSS-community` (Apache-2.0 + MIT dual license; no CLA required)
- **Lock-in vectors**: .rrd format is Rerun-specific (not an industry standard like MCAP)
- **Source**: [Website](https://rerun.io/), [GitHub](https://github.com/rerun-io/rerun)

#### Rerun Hub

- **What it does**: Commercial data catalog and training platform for Physical AI data. SQL-based querying across recordings, transformation layer (derived columns without copying raw data), GPU-direct dataloader for training (column-aware, codec-aware streaming).
- **Building blocks covered**: [Data Annotation & Curation for Physical AI](building-blocks.md#data-annotation--curation-for-physical-ai)
- **Key features (functional)**: SQL queries across recordings (down to columns, time ranges, values), transformations without duplicating raw data, GPU-direct training dataloader, shared viewer and recordings
- **Key features (non-functional)**: Cloud-hosted; early-access product (GA timing uncertain)
- **Competes with**: Foxglove Cloud, Scale AI — on robotics data management and curation
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary transformation engine, cloud-hosted catalog, .rrd format
- **Source**: [Website](https://rerun.io/)

**Platform relevance**:

- **Partnership surface**: Data visualization and management layer for any Physical AI platform; SDK integrates with LeRobot, ROS 2, PyTorch. Natural complement to OpenShift-based ML pipelines
- **Competitive surface**: None — Rerun has no platform components
- **What they need from a platform**: Container runtime for SDK/Viewer deployment, GPU infrastructure for Hub training features, fleet management for edge data collection

**Links**: [Website](https://rerun.io/), [GitHub](https://github.com/rerun-io/rerun), [Blog](https://rerun.io/blog), [$17M Seed announcement](https://techcrunch.com/2025/03/20/reruns-open-source-ai-platform-for-robots-drones-and-cars-revs-up-with-17m-seed/)

---

### Eka Robotics

**Type**: `Startup`
**Stage/Scale**: $13M raised (E14 Fund). Founded 2025. Cambridge, MA
**About**: Building Vision-Force-Action (VFA) foundation models — argues that language is a "helpful crutch" that misses the fundamental reality of force. Robots learn mass, friction, and inertia through sim-to-real RL rather than human imitation. Co-founded by MIT professor Pulkit Agrawal (Improbable AI Lab, IEEE Early Academic Career Award 2024) and ex-DeepMind researcher Tuomas Haarnoja (co-creator of SAC/Soft Actor-Critic). Team from MIT, Berkeley, Harvard, DeepMind, Boston Dynamics.

**Solutions**:

#### VFA Foundation Model

- **What it does**: Vision-Force-Action model that learns dexterous manipulation through self-supervised learning in high-fidelity simulation, then transfers to real-world via proprietary sim-to-real algorithms. Emphasizes force/torque sensing over language conditioning.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)
- **Key features (functional)**: Force-based manipulation learning (not language-conditioned), self-supervised sim-to-real transfer, claims to bridge sim-to-real gap without human-in-the-loop
- **Key features (non-functional)**: Targets "superhuman" performance rather than human imitation
- **Competes with**: pi0/pi0.5 (VLA), GR00T N1 (VLA), GEN-1 (native embodied) — differentiates on force-first approach
- **Complements**: High-fidelity simulation (training environment), force/torque sensors (hardware)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary sim-to-real algorithms, proprietary VFA model
- **Source**: [Website](https://ekarobotics.com/)

**Platform relevance**:

- **Partnership surface**: VFA model needs simulation infrastructure, model serving, edge deployment
- **Competitive surface**: Minimal — focused on model, not platform
- **What they need from a platform**: High-fidelity simulation at scale, model lifecycle management, edge deployment for force control loops

**Links**: [Website](https://ekarobotics.com/), [Humanoids Daily profile](https://www.humanoidsdaily.com/news/the-era-of-eka-new-startup-unveils-vision-force-action-model-to-crack-dexterity)

---

### ANYbotics

**Type**: `Startup`
**Stage/Scale**: $150M+ total raised (Series B €127M, Sep 2025). Investors: Bessemer, Aramco Ventures, NGP Capital, Qualcomm Ventures, Climate Investment. Zurich, Switzerland. ETH Zurich spinout
**About**: Autonomous legged robots for industrial inspection in hazardous environments — oil/gas, power, mining, chemicals. 200+ ANYmal units shipped, conducting thousands of inspections weekly. ANYmal X (2026 launch) is world's first Ex-certified legged robot (approved for explosive atmospheres). Customers: bp, Equinor, ENI, Petrobras, SLB, Siemens Energy, GE Vernova, AWS, SAP.

**Solutions**:

#### ANYmal

- **What it does**: Quadruped inspection robot with onboard AI for autonomous navigation, stair climbing, and anomaly detection in industrial facilities. Patrols refineries, chemical plants, power stations, and mines.
- **Building blocks covered**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime)
- **Key features (functional)**: Autonomous patrol, stair climbing, anomaly detection, CO₂ monitoring (Northern Lights CCS facility), automatic analysis and reporting
- **Key features (non-functional)**: 200+ units deployed, Ex-certified (ANYmal X), operates in hazardous/uncrewed facilities
- **Competes with**: Boston Dynamics Spot, Ghost Robotics — on industrial quadruped inspection
- **Complements**: NVIDIA (partner), SAP/AWS (enterprise integration), industrial IoT systems
- **Openness**: `Proprietary`
- **Lock-in vectors**: Vertically integrated (hardware + software), proprietary fleet management
- **Source**: [Website](https://www.anybotics.com/)

**Platform relevance**:

- **Partnership surface**: Industrial inspection needs fleet management, data analytics, integration with industrial IoT/digital twin platforms
- **Competitive surface**: Minimal — niche vertical player
- **What they need from a platform**: Fleet orchestration across sites, integration with industrial digital twins (Siemens Xcelerator, Omniverse), safety certification frameworks

**Links**: [Website](https://www.anybotics.com/), [Climate Investment](https://theaiinsider.tech/2025/09/23/anybotics-total-funding-at-150-million-after-climate-investments-joins-to-scale-autonomous-inspection-in-hazardous-sites/)

---

### Zeromatter

**Type**: `Startup`
**Stage/Scale**: $45M raised (Seed). Investors: Bessemer, Spark Capital, Brighton Park Capital, Linse Capital, AE Ventures. Founded 2021. Mountain View, CA. 87 employees
**About**: High-performance simulation platform — "one platform to build, test, and train anything." Founded by Ian Glow (ex-Tesla simulation team pioneer). Team from NVIDIA, Tesla, Cruise. Focuses on physics-based sensor simulation (cameras, LiDAR, radar, ultrasonics) producing virtual sensor data indistinguishable from reality. Serves autonomy, aerospace, automotive, agriculture, drones, and energy.

**Solutions**:

#### Zeromatter Simulation Platform

- **What it does**: Unified simulation environment with photorealistic sensor simulation, automatic environment generation, and multi-agent co-simulation for autonomous systems development.
- **Building blocks covered**: [Simulation Engines](building-blocks.md#simulation-engines), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)
- **Key features (functional)**: Physics-based sensor models (camera, LiDAR, radar, ultrasonics), photorealistic rendering, automatic environment generation, multi-agent co-simulation, flight dynamics simulation
- **Key features (non-functional)**: Enterprise-grade, cross-domain (ground, air, sea)
- **Competes with**: Isaac Sim, Gazebo, Genesis World, Applied Intuition — on high-fidelity simulation for autonomous systems
- **Complements**: Any autonomy stack (sensor simulation input), ML training pipelines (synthetic data output)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Proprietary simulation engine, proprietary sensor models
- **Source**: [Website](https://zeromatter.com/)

**Platform relevance**:

- **Partnership surface**: Simulation layer that platform could integrate for synthetic data generation and policy evaluation
- **Competitive surface**: Simulation capabilities overlap with platform simulation offerings
- **What they need from a platform**: Integration with training pipelines, model evaluation frameworks, cloud/on-prem deployment options

**Links**: [Website](https://zeromatter.com/), [Linse Capital](https://www.linsecapital.com/portfolio/zeromatter)

---

### NODA AI

**Type**: `Startup`
**Stage/Scale**: $28.9M total ($25M Series A, Feb 2026, led by Bessemer). Strategic investment from Booz Allen Ventures (Apr 2026). Founded 2024. Austin, TX
**About**: Building vendor-agnostic, cross-platform orchestration layer for mixed-fleet autonomous operations in defense. Founded by Global War on Terrorism veterans. Coordinates manned and unmanned systems across domains (air, ground, sea) without building the vehicles themselves. Integrated with 30+ autonomous platforms. Selected by DoW to lead multi-domain collaborative autonomy orchestration.

**Solutions**:

#### NODA Orchestration Platform

- **What it does**: AI-powered reasoning engine for multi-domain autonomous systems orchestration — coordinates mixed fleets of manned and unmanned vehicles across air, ground, and maritime domains.
- **Building blocks covered**: [Robot Middleware](building-blocks.md#robot-middleware)
- **Key features (functional)**: Vendor-agnostic (30+ platform integrations), cross-domain orchestration (air/ground/sea), algorithmic warfare tactics, multi-agent coordination
- **Key features (non-functional)**: DoW and UK MoD customers, interoperable with major defense contractor systems
- **Competes with**: Anduril Lattice, Shield AI Hivemind — on autonomous systems orchestration
- **Complements**: Defense hardware platforms (any vendor), command and control systems (Booz Allen)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Defense procurement cycles, classified integrations
- **Source**: [Morningstar press release](https://www.morningstar.com/news/pr-newswire/20260226ny96396/noda-ai-raises-25-million-in-series-a-led-by-bessemer-venture-partners-to-accelerate-development-of-ai-powered-orchestration-platform-and-autonomous-plays-for-department-of-war-dow-and-intelligence-community)

**Platform relevance**:

- **Partnership surface**: Multi-domain orchestration patterns applicable to industrial multi-robot coordination
- **Competitive surface**: Defense-specific — no direct overlap with industrial platform
- **What they need from a platform**: Cross-vendor interoperability standards, real-time communication infrastructure, safety-certified runtimes

**Links**: [Bessemer funding](https://ventureburn.com/noda-ai-raises-25m-series-a-to-advance-defense-ai-platform/), [Booz Allen investment](https://investors.boozallen.com/news-releases/news-release-details/booz-allen-expands-autonomy-ecosystem-noda-ai-investment)

---

### Odyssey

**Type**: `Startup`
**Stage/Scale**: ~$340M+ total. $310M Series B (Jun 2026, AMD Ventures, AWS, IQT) + $18M Series A (Nov 2024, EQT, GV) + $9M seed (Jul 2024, GV, DCVC). NVentures/Samsung strategic investment (Feb 2026), but Series B pivoted to AMD/AWS. ~55 staff across London, Zurich, Palo Alto. Notable angels: Jeff Dean, Garry Tan, Kyle Vogt, Elad Gil, Guillermo Rauch
**About**: World model research lab building general-purpose learned simulation engines. Founded late 2023 by Oliver Cameron (ex-Cruise/Voyage CEO) and Jeff Hawke (founding engineer at Wayve). Positions as a learned simulation layer upstream of VLA policy training — multi-agent world models that generate training scenarios rather than outputting robot actions directly. PROWL adversarial RL framework and founders' AV pedigree hint at potential scope expansion into policy training. Notable for AWS/AMD pivot away from NVIDIA ecosystem after taking NVentures money. IQT (CIA-affiliated) backing signals defense as a target domain.

**Solutions**:

#### Agora-1

- **What it does**: Multi-agent world model that decouples simulation from rendering. World state model learns game dynamics directly from internal state; DiT-based rendering model generates consistent visuals from multiple independent viewpoints conditioned on shared state. Enables up to 4 agents interacting in a shared world simultaneously.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models), [Simulation Engines](building-blocks.md#simulation-engines)
- **Key features (functional)**: Multi-agent shared simulation (up to 4 agents), decoupled state/rendering architecture, direct state manipulation for novel scenario generation, consistent multi-viewpoint rendering, PROWL adversarial RL integration
- **Key features (non-functional)**: Real-time generation, scalable state representation (architecturally unbounded agent count)
- **Competes with**: Cosmos (NVIDIA), Genie 3 (Google DeepMind), Marble (World Labs), GameNGen — differentiates on multi-agent shared simulation; all competitors are single-agent
- **Complements**: VLA policies (pi0, GR00T, Helix) as downstream consumers of generated training data
- **Openness**: `Proprietary`
- **Lock-in vectors**: AWS/Trainium compute dependency, proprietary state representation format
- **Source**: [Agora-1 blog post](https://odyssey.ml/introducing-agora-1)

#### Odyssey-2 Max

- **What it does**: Physics-accurate world generation model for realistic environment simulation.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: Accurate physics simulation in generated worlds
- **Competes with**: Cosmos-Predict2.5 — on physics-faithful video world generation
- **Openness**: `Proprietary`
- **Source**: [TechCrunch coverage](https://techcrunch.com/2025/05/28/odysseys-new-ai-model-streams-3d-interactive-worlds/)

#### Starchild-1

- **What it does**: Real-time multimodal world model — first model to generate interactive worlds in real time across multiple modalities.
- **Building blocks covered**: [Latent World Models](building-blocks.md#latent-world-models)
- **Key features (functional)**: Real-time generation, multimodal output
- **Competes with**: Genie 3 — on real-time interactive world generation
- **Openness**: `Proprietary`
- **Source**: [Odyssey website](https://odyssey.ml)

**Implied reference architecture**: Learned simulation engine that replaces or augments hand-authored simulators (Isaac Sim, MuJoCo) in the robot training pipeline. Odyssey world models generate diverse multi-agent training scenarios; downstream VLA/policy models consume these for training. PROWL framework creates a co-evolutionary loop where agents stress-test world models and world models challenge agents. Does not own the policy layer or hardware — expects partners for downstream deployment.

**Platform relevance**:

- **Partnership surface**: Learned simulation as a service — could complement platform-hosted robot training pipelines. Multi-agent coordination scenarios for fleet robotics. Defense simulation for multi-domain autonomous operations.
- **Competitive surface**: Overlaps with simulation & synthetic data building block; competes for the "world model as training data generator" role that Cosmos fills in NVIDIA's stack.
- **What they need from a platform**: Scalable compute infrastructure (AWS/Trainium currently), data pipelines for training data ingestion, deployment infrastructure for serving world models to downstream policy training.

**Collaborations**: AWS (preferred cloud, Trainium compute), AMD Ventures (GPU alternative), IQT (defense applications)

**Links**: [Website](https://odyssey.ml), [Agora-1](https://odyssey.ml/introducing-agora-1), [Series B coverage](https://techfundingnews.com/odyssey-310m-series-b-nvidia-amazon-amd-ai-world-models/)

---

### NEURA Robotics

**Type**: `Startup`
**Stage/Scale**: Series C — up to $1.4B raised (Jun 2026, milestone-contingent) at $7B valuation. Largest private financing round by a German company. Investors: Tether (lead), Amazon, NVIDIA, Qualcomm, Bosch, Schaeffler, European Investment Bank. ~1,200 employees
**About**: German humanoid robotics company building "cognitive robots" with integrated perception and AI. Flagship 4NE-1 humanoid priced at ~$98K. Orderbook and deployment pipeline exceed $1B. Partnership with AWS for global rollout of Neuraverse training platform. Plans to scale to multi-million unit production by 2030 via "Neura Gyms" training environments. Large-scale shipments expected late 2026.

**Solutions**:

#### 4NE-1

- **What it does**: Humanoid robot with integrated cognitive capabilities for industrial and commercial deployment.
- **Building blocks covered**: [Robot Hardware Platforms](building-blocks.md#robot-hardware-platforms), [Robot Foundation Models](building-blocks.md#robot-foundation-models)
- **Key features (functional)**: Integrated perception and AI, cognitive robot control
- **Key features (non-functional)**: ~$98K price point, serial production scaling to multi-million units by 2030
- **Competes with**: Figure AI Figure 03, Unitree G1/H2, Agility Digit, 1X NEO — on humanoid robots for industrial deployment
- **Complements**: NVIDIA (investor, simulation/training), AWS (Neuraverse deployment)
- **Openness**: `Proprietary`
- **Lock-in vectors**: Vertically integrated hardware + software, proprietary Neuraverse platform
- **Source**: [Website](https://neura-robotics.com/)

**Platform relevance**:

- **Partnership surface**: Humanoid hardware platform for third-party software; AWS/NVIDIA ecosystem alignment
- **Competitive surface**: Vertically integrated — limited platform interop
- **What they need from a platform**: Fleet management, sim-to-real training infrastructure, edge deployment, safety certification

**Collaborations**: Amazon (investor + AWS partnership), NVIDIA (investor), Bosch (investor), Schaeffler (investor)

**Links**: [Website](https://neura-robotics.com/), [Series C announcement](https://neura-robotics.com/record-series-c/), [Sifted coverage](https://sifted.eu/articles/neura-robotics-1-4bn-series-c)

---

## OSS Communities

*Open-source communities and foundations governing key Physical AI infrastructure*

### Open Robotics / OSRA

**Type**: `OSS Community`
**About**: Governs ROS2 (Robot Operating System 2) and Gazebo — the de facto standard middleware and simulation platform for robotics research and increasingly for production deployments. ROS2 provides the publish-subscribe communication layer, hardware abstraction, and tool ecosystem that most robot software builds on. Gazebo provides physics-based simulation integrated with ROS2.

**Focus Areas**: Robot middleware, simulation, hardware abstraction, interoperability standards

**Key Projects**:

- **ROS2**: Middleware framework — DDS-based communication, lifecycle management, real-time capable. Building block: [Robot Middleware](building-blocks.md#robot-middleware)
- **Gazebo**: Multi-physics simulation with ROS2 integration, sensor simulation, environment modeling. Building block: [Simulation Engines](building-blocks.md#simulation-engines)

**Openness**: `OSS-community` (Apache 2.0)

**Platform relevance**:

- **Partnership surface**: ROS2 is the integration layer most robot platforms must support; Gazebo is baseline simulation
- **Competitive surface**: Minimal — community-governed, not commercially competitive
- **What they need from a platform**: Better cloud deployment, fleet management, model serving integration, real-time performance improvements

**Links**: [ROS2](https://www.ros.org/), [Gazebo](https://gazebosim.org/), [GitHub](https://github.com/ros2)

---

### vLLM Community

**Type**: `OSS Community`
**About**: Community developing vLLM — the leading open-source inference engine for large language models — and vLLM-Omni, which extends it to serve multimodal and Physical AI models (world models, VLAs, video-action models). Relevant as the emerging model serving layer for Physical AI workloads.

**Focus Areas**: Model serving, inference optimization, multimodal serving, Physical AI model deployment

**Key Projects**:

- **vLLM**: High-throughput LLM inference engine with PagedAttention. Building block: [Model Serving for Physical AI](building-blocks.md#model-serving-for-physical-ai)
- **vLLM-Omni**: Extension for multimodal and Physical AI model serving. Building block: [Model Serving for Physical AI](building-blocks.md#model-serving-for-physical-ai)

**Openness**: `OSS-community` (Apache 2.0)

**Platform relevance**:

- **Partnership surface**: Model serving backbone for Physical AI platforms, integration with robot middleware
- **Competitive surface**: Minimal — open-source serving layer
- **What they need from a platform**: Real-time serving guarantees, edge deployment support, integration with robot middleware and simulation

**Links**: [GitHub (vLLM)](https://github.com/vllm-project/vllm), [GitHub (vLLM-Omni)](https://github.com/vllm-project/vllm-omni)

---

### HuggingFace

**Type**: `OSS Community`
**About**: AI model hub and open-source ecosystem provider. Increasingly relevant to Physical AI through LeRobot (open-source robot learning framework), model hosting for robot foundation models, and datasets for embodied AI.

**Focus Areas**: Model hub, open-source ML tooling, robot learning, datasets

**Key Projects**:

- **LeRobot**: Open-source robot learning framework — standardized training, evaluation, and deployment of robot policies. Building block: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Post-Training / Fine-Tuning Pipeline](building-blocks.md#post-training--fine-tuning-pipeline)
- **Model Hub**: Hosting for world models, VLAs, and robot foundation models
- **Datasets**: Hosting for robot demonstration datasets, simulation data

**Openness**: `OSS-community` (Apache 2.0 for tools; hub is a mix)

**Platform relevance**:

- **Partnership surface**: Model distribution, dataset hosting, LeRobot as training framework
- **Competitive surface**: Model hub could compete with platform model management
- **What they need from a platform**: Deployment infrastructure beyond hosting, real-time serving, robot hardware integration

**Links**: [Website](https://huggingface.co/), [LeRobot](https://github.com/huggingface/lerobot)

---

### Eclipse Foundation

**Type**: `OSS Community`
**About**: Open-source foundation governing Eclipse Ditto — a framework for digital twins in IoT and industrial applications. Provides vendor-neutral digital twin infrastructure as an alternative to proprietary platforms.

**Focus Areas**: Digital twins, IoT, industrial open-source

**Key Projects**:

- **Eclipse Ditto**: Digital twin framework for IoT — manages digital representations of physical devices with APIs for state management, search, and change notification. Building block: [Digital Twin Runtime](building-blocks.md#digital-twin-runtime)

**Openness**: `OSS-community` (Eclipse Public License)

**Platform relevance**:

- **Partnership surface**: Vendor-neutral digital twin layer, integration with industrial IoT
- **Competitive surface**: Minimal — community-governed alternative to proprietary digital twins
- **What they need from a platform**: AI integration (current focus is state management, not AI), physics simulation, scale beyond IoT to full Physical AI twins

**Links**: [Eclipse Ditto](https://www.eclipse.org/ditto/), [GitHub](https://github.com/eclipse-ditto/ditto)

---

## Research Labs

*Universities and research institutions advancing Physical AI foundations*

### Meta FAIR / AMI Labs

**About**: Meta's Fundamental AI Research lab developed the JEPA ecosystem. Post-LeCun departure (Jan 2026), FAIR continues JEPA research while AMI Labs pursues commercial applications. The Galilai group (Randall Balestriero) leads theoretical foundations work.

**Focus Areas**: JEPA architectures, self-supervised learning, energy-based models, world models, identifiability theory

**Key Work**: I-JEPA, V-JEPA, V-JEPA 2, VL-JEPA, EB-JEPA, VICReg, LeJEPA, SIGReg, LeWorldModel, identifiability theory

**Key People**:

#### Yann LeCun

Turing Award laureate (2018) and originator of JEPA and the energy-based model framework. His 2022 position paper "A Path Towards Autonomous Machine Intelligence" laid out the JEPA vision. Former Chief AI Scientist at Meta FAIR; founded [AMI Labs](#ami-labs) in Jan 2026.

- **Focus**: JEPA, self-supervised learning, energy-based models, world models
- **Key Work**: I-JEPA, V-JEPA, V-JEPA 2, VL-JEPA, EB-JEPA; "A Path Towards Autonomous Machine Intelligence" (2022)
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=WLN3QrAAAAAJ), [Twitter](https://twitter.com/ylecun)

#### Adrien Bardes

Research Scientist at Meta FAIR and key architect of the JEPA ecosystem. Creator of VICReg — the variance-invariance-covariance regularization that solved collapse prevention for joint-embedding architectures. Co-author on V-JEPA 2, V-JEPA 2.1, VL-JEPA, JEPA-WMs ablation, and Hierarchical World Models.

- **Focus**: Self-supervised learning, JEPA, VICReg, world models for planning
- **Key Work**: VICReg (ICLR 2022), VICRegL (NeurIPS 2022), V-JEPA 2, VL-JEPA, Hierarchical Planning with Latent World Models
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=SvRU8F8AAAAJ), [Website](https://adrien987k.github.io/), [GitHub](https://github.com/Adrien987k)

#### Randall Balestriero

Research Scientist at Meta FAIR leading the Galilai group. Originated LeJEPA and SIGReg — a Gaussian regularization approach replacing the EMA teacher-student paradigm with explicit distributional constraints. Co-developed LeWorldModel, the first JEPA trained end-to-end from raw pixels with only two loss terms. Proved (with Klindt) that Gaussian regularization is necessary and sufficient for linear identifiability in JEPA architectures.

- **Focus**: LeJEPA, SIGReg, identifiability theory, self-supervised learning
- **Key Work**: LeJEPA (2025), SIGReg, LeWorldModel (2026-03), identifiability theory (2026-05), Le MuMo JEPA (2026-03)
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=osi2F5IAAAAJ), [GitHub](https://github.com/galilai-group)

**Links**: [FAIR GitHub](https://github.com/facebookresearch), [FAIR Blog](https://ai.meta.com/blog/)

---

### MIT CSAIL

**About**: MIT's Computer Science and Artificial Intelligence Laboratory hosts the Embodied Intelligence community, bringing together researchers working on physically grounded AI. Key groups: Computational Cognitive Science (commonsense reasoning, CLEVRER benchmark) and Distributed Robotics Laboratory (liquid neural networks, VISTA simulation).

**Focus Areas**: Embodied intelligence, commonsense reasoning, intuitive physics, distributed robotics, autonomous driving simulation

**Key Work**: CLEVRER benchmark (counterfactual video reasoning), liquid neural networks, VISTA simulation, Embodied Intelligence Summit

**Key People**:

#### Josh Tenenbaum

Professor studying how humans acquire commonsense understanding of the physical and social world from remarkably little data. His work on intuitive physics and probabilistic programs of thought has directly influenced world model benchmarks and evaluation methodology.

- **Focus**: Commonsense reasoning, intuitive physics, probabilistic programming, cognitive science
- **Key Work**: CLEVRER benchmark, BabyAI, probabilistic programs of thought, Bayesian models of cognition
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=rRJ9wTJMUB8C), [Homepage](https://cocosci.mit.edu/)

#### Daniela Rus

Director of MIT CSAIL and leader of the Distributed Robotics Laboratory. Pioneered liquid neural networks and VISTA simulations for safe autonomous driving training. Her "Science of Autonomy" research focuses on scalable multi-robot systems.

- **Focus**: Distributed robotics, liquid neural networks, autonomous driving simulation, science of autonomy
- **Key Work**: Liquid neural networks, VISTA simulation platform, distributed robotics systems
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=910z20QAAAAJ), [Homepage](https://www.csail.mit.edu/person/daniela-rus)

**Links**: [Website](https://www.csail.mit.edu/), [Embodied Intelligence](https://www.csail.mit.edu/research/embodied-intelligence-community-research)

---

### Stanford SVL / SAIL

**About**: Stanford's Vision and Learning Lab (SVL) and AI Lab (SAIL) develop methods for robot perception in real-world variability. Key research includes "Motion Intelligence" for humanoid robots and the "Common Ground" problem — how to create stable shared representations between humans and AI systems.

**Focus Areas**: Spatial intelligence, motion intelligence, common ground, humanoid robotics, visual understanding

**Key Work**: Motion Intelligence for humanoids, Common Ground research, Stanford HAI AI Index Report

**Key People**:

#### Fei-Fei Li

Stanford professor and co-director of Stanford HAI. Founded [World Labs](#world-labs) to pursue "Spatial Intelligence." Creator of ImageNet. Pioneered the Marble model for persistent 3D world reconstruction.

- **Focus**: Spatial intelligence, 3D world models, computer vision
- **Key Work**: ImageNet (2009), [World Labs](#world-labs) (founded 2024), Marble, Stanford HAI (co-director)
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=rDfyQnIAAAAJ), [Homepage](https://profiles.stanford.edu/fei-fei-li)

#### Chelsea Finn

Associate Professor, co-founder of [Physical Intelligence](#physical-intelligence-pi). Leads the IRIS lab (Intelligence through Robotic Interaction at Scale). Pioneer in meta-learning for robotics and few-shot adaptation.

- **Focus**: Robot learning, meta-learning, world models for manipulation, few-shot adaptation
- **Key Work**: MAML, Ctrl-World, RoboReward, co-founder of [Physical Intelligence](#physical-intelligence-pi)
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=vfPE6hgAAAAJ), [Homepage](https://ai.stanford.edu/~cbfinn/)

**Links**: [SVL](https://svl.stanford.edu/), [SAIL](https://ai.stanford.edu/), [HAI](https://hai.stanford.edu/)

---

### UC Berkeley RAIL

**About**: The Robotic AI and Learning Lab argues that robots will eventually outpace LLMs in data because they can autonomously collect physical experience cheaply. Pioneered offline RL and "extreme" robot designs that test architectures without hand-engineered crutches. Directly tied to [Physical Intelligence](#physical-intelligence-pi).

**Focus Areas**: Offline RL, robot learning, model-based RL, autonomous data collection, bimanual manipulation

**Key Work**: Offline RL methods, pi0/pi0.5 (via Physical Intelligence), extreme robot manipulation, "World Model for Robot Learning" survey (2026)

**Key People**:

#### Sergey Levine

Professor and co-founder of [Physical Intelligence](#physical-intelligence-pi). Argues robots will have a data advantage over language models. Pioneered offline RL methods for safe deployment.

- **Focus**: Offline RL, robot learning, model-based RL, autonomous data collection
- **Key Work**: Offline RL, pi0/pi0.5 (via Physical Intelligence), extreme robot designs
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=8R35rCwAAAAJ), [Homepage](https://people.eecs.berkeley.edu/~svlevine/)

#### Pieter Abbeel

UC Berkeley professor, co-founder of [Covariant](#covariant-acquired-by-amazon-2024). Joined [Amazon](#amazon) in Aug 2024 as part of the Covariant reverse-acquihire; leads AI robotics work in Amazon's Fulfillment Technologies & Robotics team. Co-authored the "World Model for Robot Learning" survey (2026) unifying the fragmented world model literature for robotics.

- **Focus**: Robot learning, deep RL, sim-to-real transfer, world models for robotics
- **Key Work**: World Model for Robot Learning survey (2026, with Jitendra Malik), Covariant RFM-1, Amazon robotics AI
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=X4Qth8YAAAAJ), [Homepage](https://people.eecs.berkeley.edu/~pabbeel/)

#### Jitendra Malik

Professor and Research Director at Meta. Pioneer in computer vision spanning four decades. Co-authored the "World Model for Robot Learning" survey (2026) bridging vision, world models, and robot policy learning.

- **Focus**: Computer vision, 3D understanding, embodied perception, world models for robotics
- **Key Work**: World Model for Robot Learning survey (2026, with Pieter Abbeel), Mesh R-CNN
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=oY9R5YQAAAAJ), [Homepage](https://people.eecs.berkeley.edu/~malik/)

**Links**: [Website](https://rail.eecs.berkeley.edu/)

---

### CMU Robotics Institute

**About**: Carnegie Mellon's Robotics Institute has been a birthplace of autonomous vehicle technology since 1984. Current research includes "World Modeling" (temporally abstract world models from offline demonstrations), "Physical Perception" using physics as meta-supervision, and error propagation analysis for navigation.

**Focus Areas**: World modeling, field robotics, autonomous vehicles, physical perception, error propagation

**Key Work**: World Modeling archive, temporally abstract world models, physical perception, AV technology

**Key People**:

#### Shubham Tulsiani

Assistant Professor focusing on "Physical Perception" — leveraging the laws of the physical world as meta-supervisory signals to reduce reliance on human annotation. Enables robots to build 3D understanding from minimal labeled data.

- **Focus**: Physical perception, 3D understanding, self-supervised learning from physics
- **Key Work**: Physical perception research, physics-as-supervision for 3D understanding
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=gPyFsMQAAAAJ), [Homepage](https://shubhtuls.github.io/)

#### Alonzo Kelly

Professor specializing in how errors accumulate and propagate in world models used for robot navigation. Research on odometry and triangulation error propagation is foundational to understanding world model prediction degradation.

- **Focus**: Error propagation, odometry, triangulation, mobile robotics, field robotics
- **Key Work**: Error propagation analysis for navigation systems, mobile robot localization
- **Links**: [Homepage](https://www.ri.cmu.edu/ri-faculty/alonzo-kelly/)

**Links**: [Website](https://www.ri.cmu.edu/), [World Modeling](https://www.ri.cmu.edu/research-topic/world-modeling/)

---

### Oxford OATML

**About**: The Oxford Applied and Theoretical Machine Learning group specializes in uncertainty quantification (UQ) for deep learning and world models. Their "Deep Ignorance" framework addresses when AI systems should recognize they lack sufficient knowledge to act — critical for safety in world-model-driven autonomous systems.

**Focus Areas**: Uncertainty quantification, Bayesian deep learning, verification, safe AI, autonomous discovery

**Key Work**: Bayesian UQ for LLMs and world models, step-wise verification for reasoning, Deep Ignorance framework

**Key People**:

#### Yarin Gal

Associate Professor and head of OATML. Specializes in uncertainty quantification applying Bayesian principles to build reliable verification for reasoning models and autonomous systems.

- **Focus**: Uncertainty quantification, Bayesian deep learning, safe AI, verification
- **Key Work**: Concrete Dropout, Bayesian deep learning framework, uncertainty-aware verification
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=H2BVqkwAAAAJ), [Homepage](https://www.cs.ox.ac.uk/people/yarin.gal/website/)

**Links**: [Website](https://oatml.cs.ox.ac.uk/), [Blog](https://oatml.cs.ox.ac.uk/blog.html)

---

### Mila

**About**: Quebec AI Institute, founded by Yoshua Bengio. Focuses on "System 2" deep learning — architectures that move beyond statistical correlation to causal reasoning. Bengio's "Scientist AI" proposal envisions non-agentic world models for understanding rather than acting.

**Focus Areas**: System 2 thinking, causal reasoning, scientific AI, safe AGI, compositional learning

**Key Work**: GFlowNets, System 2 deep learning, Scientist AI proposal

**Key People**:

#### Yoshua Bengio

Turing Award laureate (2018), founder and scientific director of Mila. Advocates for "System 2" deep learning and causal reasoning. His "Scientist AI" proposal envisions non-agentic world models focused on understanding, targeting "Scientific and Safe" AGI.

- **Focus**: System 2 thinking, causal reasoning, scientific AI, world models for understanding
- **Key Work**: "Scientist AI" proposal, GFlowNets, System 2 deep learning position papers
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=kukA0LcAAAAJ), [Homepage](https://yoshuabengio.org/)

**Links**: [Website](https://mila.quebec/), [Research](https://mila.quebec/en/publications/)

---

### Additional Researchers

*Key researchers not primarily affiliated with the labs above*

#### Ilya Sutskever

Co-founder and CEO of [Safe Superintelligence Inc. (SSI)](#safe-superintelligence-inc-ssi). Former chief scientist of OpenAI; co-inventor of AlexNet. Advocates a "post-scaling" paradigm shift — new learning methods over bigger models — with emphasis on continual learning, generalization, and JEPA-style architectures.

- **Focus**: Safe superintelligence, continual learning, generalization, post-scaling paradigm
- **Key Work**: AlexNet (2012), sequence-to-sequence learning (2014), co-founded OpenAI (2015), co-founded SSI (2024); "Big World Hypothesis"
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=x04W_mMAAAAJ&hl=en), [Twitter](https://twitter.com/ilyasut), [Homepage](https://www.cs.toronto.edu/~ilya/)

#### Adrian Kosowski

Lead researcher behind the BDH architecture at [Pathway](#pathway). Originated the biologically-inspired LLM design bridging transformers and neuroscience models.

- **Focus**: BDH, biologically-inspired architectures, spiking neural networks, interpretability
- **Key Work**: "The Dragon Hatchling: The Missing Link between the Transformer and Models of the Brain" (2025-09)
- **Links**: [GitHub](https://github.com/pathwaycom/bdh)

#### Yair Carmon

ML researcher at [SSI](#safe-superintelligence-inc-ssi) (Tel Aviv office). PhD from Stanford; background in adversarial robustness and optimization.

- **Focus**: Machine learning, adversarial robustness, optimization
- **Key Work**: Research at SSI (details undisclosed)
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=LyA_iI0AAAAJ)

#### Demis Hassabis

CEO of [Google DeepMind](#google-deepmind), Nobel Prize in Chemistry (2024, with John Jumper for AlphaFold). Publicly frames world models as the critical next step toward a universal AI assistant — plans to extend Gemini into a world model capable of planning and simulating physical dynamics.

- **Focus**: AGI, world models as path to universal AI, physics simulation, scientific discovery
- **Key Work**: AlphaGo/AlphaZero, AlphaFold (Nobel Prize 2024), Genie 3, Gemini, vision for Gemini as world model
- **Links**: [Google Scholar](https://scholar.google.com/citations?user=dYpPMQEAAAAJ), [Homepage](https://www.demishassabis.com/)

---

**Note**: Only includes seminal contributors and recognized thought leaders. Each entry follows the ecosystem-entry template from `templates/ecosystem-entry.md`. Solution entries follow `templates/solution-entry.md`.
