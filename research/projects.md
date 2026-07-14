# Projects

> Open-source and proprietary implementations organized by building block

**Last Updated**: 2026-07-09

---

## Latent World Models

*Projects that learn predictive models in latent/embedding space rather than pixel space. Includes JEPA variants, decoder-free world models, and other latent predictive architectures.*

### EB-JEPA: Energy-Based Joint-Embedding Predictive Architectures

**URL**: [github.com/facebookresearch/eb_jepa](https://github.com/facebookresearch/eb_jepa)

**Description**: Open-source library providing community examples of Joint Embedding Predictive Architectures for learning representations from images, video, and action-conditioned video, with planning capabilities. Self-contained training examples runnable on single GPU within hours.

**Tech Stack**: Python, PyTorch, Weights & Biases integration, optional Conda/SLURM support

**Key Features**:

- Three main examples: Image JEPA, Video JEPA, and Action-Conditioned Video JEPA
- Single-GPU training within hours per example (91% CIFAR-10 probing accuracy, 97% Two Rooms planning success)
- SLURM launcher support for multi-seed sweeps and distributed training
- Comprehensive testing framework with code formatting standards
- Modular design showing progressive path from image → video → action-conditioned world model

**Status**: Active

**Stats**: 464 stars, 35 forks, 34 commits (Meta AI Research)

**Last Updated**: 2025-12 (created), actively maintained through 2026-02

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Research

**Competes with**: V-JEPA 2, LeWorldModel

**Complements**: Simulation engines (Genesis, PhysicsNeMo) for downstream deployment

**Openness assessment**: (to be assessed by oss-health skill)

### V-JEPA 2: Self-Supervised Video Models

**URL**: [github.com/facebookresearch/vjepa2](https://github.com/facebookresearch/vjepa2)

**Description**: PyTorch implementation of state-of-the-art self-supervised video encoders achieving top performance on motion understanding and action anticipation. Includes V-JEPA 2 (pre-trained encoder) and V-JEPA 2-AC (action-conditioned variant for robot manipulation with zero-shot planning). V-JEPA 2.1 (March 2026) adds a new training recipe producing high-quality, temporally consistent dense features.

**Tech Stack**: Python 3.12, PyTorch, Vision Transformer (ViT), CUDA, TimM, Einops

**Key Features**:

- Masked latent feature prediction on internet-scale video data
- Multiple model sizes: ViT-L/16 (300M), ViT-H/16 (600M), ViT-g/16 (1B parameters)
- V-JEPA 2.1: improved temporally consistent dense features via novel training recipe
- Action-conditioned world model for robot task solving (45% grasping success vs. 8% baseline, 73% pick-and-place vs. 13%)
- Pre-trained checkpoints via PyTorch Hub and HuggingFace
- Benchmark results: EK100 (39.7%), SSv2 (77.3%), Diving48 (90.2%)

**Status**: Active

**Stats**: 3,100+ stars, 347 forks (Meta AI Research)

**Last Updated**: 2025-06 (released), V-JEPA 2.1 released 2026-03-16

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Early OSS

**Competes with**: EB-JEPA, LeWorldModel, NE-Dreamer

**Complements**: Robot foundation models (GR00T, OpenPI) for downstream manipulation tasks

**Openness assessment**: (to be assessed by oss-health skill)

### JEPA-WMs: Physical Planning with Joint-Embedding Predictive World Models

**URL**: [github.com/facebookresearch/jepa-wms](https://github.com/facebookresearch/jepa-wms)

**Description**: Code, data, and pretrained weights for systematic ablation of JEPA-based world models for physical planning. Includes pretrained JEPA-WMs alongside DINO-WM and V-JEPA-2-AC baselines, with environments for navigation and manipulation tasks.

**Tech Stack**: Python, PyTorch, HuggingFace (models + datasets)

**Key Features**:

- Pretrained checkpoints for JEPA-WMs, DINO-WM, and V-JEPA-2-AC(fixed) baselines
- Multiple simulated environments for navigation and manipulation
- Comprehensive ablation framework covering predictor architecture, encoder type, rollout strategy, and planning optimizer
- CC-BY-NC 4.0 licensed models and datasets on HuggingFace

**Status**: Active

**Stats**: 160 stars, 17 forks, 1 contributor (Meta AI Research)

**Last Updated**: 2026-02

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Research

**Competes with**: HWM, stable-worldmodel

**Complements**: Simulation engines for environment evaluation

**Openness assessment**: (to be assessed by oss-health skill)

### HWM: Hierarchical Planning with Latent World Models

**URL**: [github.com/kevinghst/HWM_PLDM](https://github.com/kevinghst/HWM_PLDM)

**Description**: Code and pretrained weights for hierarchical MPC with latent world models. Implements two-level planning (macro-action subgoal generation + short-horizon execution) across multiple world model backbones (V-JEPA-2-AC, DINO-WM, PLDM) for navigation and manipulation tasks.

**Tech Stack**: Python, PyTorch

**Key Features**:

- Model-agnostic hierarchical planning layer that plugs into existing latent world models
- Multi-temporal-scale predictor training with macro-action encoding
- Evaluated on real-robot Franka manipulation, Push-T, and maze navigation
- Achieves 70% success on real-robot pick-and-place (vs 0% for flat planner)

**Status**: Active

**Stats**: 113 stars, 14 forks, NYU + Meta AI Research

**Last Updated**: 2026-05

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Research

**Competes with**: JEPA-WMs, stable-worldmodel

**Complements**: Any latent world model backbone (V-JEPA-2-AC, DINO-WM, PLDM)

**Openness assessment**: (to be assessed by oss-health skill)

### LeWorldModel (LeWM): Stable End-to-End JEPA from Pixels

**URL**: [github.com/lucas-maes/le-wm](https://github.com/lucas-maes/le-wm)

**Description**: Official implementation of LeWorldModel, the first JEPA that trains stably end-to-end from raw pixels using only two loss terms. ~15M parameters trainable on a single GPU in hours, plans up to 48x faster than foundation-model-based world models.

**Tech Stack**: Python, PyTorch

**Key Features**:

- Minimal training recipe: next-embedding prediction loss + Gaussian latent regularizer (2 loss terms vs. 6 in alternatives)
- Single-GPU training in hours at ~15M parameters
- Competitive across 2D and 3D control tasks
- MIT licensed

**Status**: Active

**Stats**: 1,623 stars, 139 forks, 3 contributors (Mila, NYU, Brown)

**Last Updated**: 2026-03

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Research

**Competes with**: EB-JEPA, V-JEPA 2

**Complements**: Simulation engines for control tasks

**Openness assessment**: (to be assessed by oss-health skill)

### EchoJEPA: Latent Predictive Foundation Model for Echocardiography

**URL**: [github.com/bowang-lab/EchoJEPA](https://github.com/bowang-lab/EchoJEPA)

**Description**: First foundation-scale JEPA for medical imaging, trained on 18M echocardiograms across 300K patients. Adapts V-JEPA 2 with domain-specific modifications for cardiac ultrasound, learning anatomical representations that filter speckle noise. EchoJEPA-L released on public data for independent evaluation.

**Tech Stack**: Python, PyTorch, Vision Transformer

**Key Features**:

- ~20% improvement on LVEF, 17% on RVSP over leading baselines
- 79% view classification with 1% labels vs. 42% for best baseline at 100%
- Domain-specific adaptations: 24 fps sampling, conservative cropping, narrow aspect ratio augmentation
- Apache 2.0 licensed

**Status**: Active

**Stats**: 273 stars, 42 forks, 2 contributors (U. Toronto, Vector Institute, U. Chicago)

**Last Updated**: 2026-02

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Research

**Competes with**: Traditional medical imaging foundation models

**Complements**: Clinical decision support systems, diagnostic AI workflows

**Openness assessment**: (to be assessed by oss-health skill)

### Locate 3D / 3D-JEPA: Object Localization via Self-Supervised 3D Learning

**URL**: [github.com/facebookresearch/locate-3d](https://github.com/facebookresearch/locate-3d)

**Description**: 3D-JEPA encoder and Locate 3D model for localizing objects in 3D scenes from natural language referring expressions. 3D-JEPA applies masked prediction in latent space to sensor point clouds featurized with 2D foundation models (CLIP, DINO), then fine-tunes with a language-conditioned decoder for 3D mask and bounding box prediction.

**Tech Stack**: Python, PyTorch, Conda, HuggingFace (model: facebook/3d-jepa)

**Key Features**:

- 3D-JEPA: self-supervised learning on point clouds via masked latent prediction — extends JEPA principle to 3D spatial data
- Locate 3D: SOTA referential grounding from referring expressions ("the small coffee table between the sofa and the lamp")
- Operates directly on sensor observation streams (posed RGB-D frames), enabling deployment on robots and AR devices
- Locate 3D Dataset: 130K+ annotations across multiple capture setups for systematic generalization study

**Status**: Active

**Stats**: (Meta AI Research)

**Last Updated**: 2025-04

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Research

**Competes with**: Traditional 3D object detection models

**Complements**: Robot foundation models, AR/VR systems

**Openness assessment**: (to be assessed by oss-health skill)

### ThinkJEPA: VLM-Guided Latent World Models

**URL**: [github.com/Hai-chao-Zhang/ThinkJEPA](https://github.com/Hai-chao-Zhang/ThinkJEPA)

**Description**: Dual-path embodied prediction framework combining a VLM "thinker" (Qwen3-VL-Thinking) with a JEPA "controller" (V-JEPA 2 predictor) for trajectory prediction. VLM provides long-horizon semantic guidance via hierarchical pyramid features; JEPA branch handles fine-grained dynamics.

**Tech Stack**: Python 3.10/3.11, PyTorch 2.10.0, Qwen3-VL, V-JEPA 2 (bundled subtree), EgoDex dataset, HuggingFace, DDP multi-GPU training

**Key Features**:

- Dual-temporal pathway: dense JEPA frames + sparse VLM frames with hierarchical pyramid guidance transfer
- Pre-extracted Qwen3-VL feature cache available on HuggingFace (haichaozhang/cache)
- Bundled V-JEPA 2 subtree and EgoDex data helpers
- BSD-3-Clause-based custom license with attribution requirements

**Status**: Active

**Stats**: 38 stars, 5 forks, 1 contributor

**Last Updated**: 2026-03

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Research

**Competes with**: V-JEPA 2, LLM-JEPA

**Complements**: VLM reasoning models, embodied AI applications

**Openness assessment**: (to be assessed by oss-health skill)

### NE-Dreamer: Next Embedding Prediction for World Models

**URL**: [github.com/corl-team/nedreamer](https://github.com/corl-team/nedreamer)

**Description**: Decoder-free MBRL agent using a temporal transformer to predict next-step encoder embeddings from latent state sequences. Matches or exceeds DreamerV3 on DeepMind Control Suite with substantial gains on DMLab memory/reasoning tasks.

**Tech Stack**: Python, PyTorch

**Key Features**:

- Decoder-free architecture — no pixel reconstruction, learns entirely in embedding space
- Temporal transformer with next-step target shift for predictive sequence modeling
- Competitive with DreamerV3 on DMC, superior on DMLab memory tasks
- MIT licensed

**Status**: Active

**Stats**: 31 stars, 1 fork, 1 contributor

**Last Updated**: 2026-03

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Research

**Competes with**: DreamerV3, V-JEPA 2

**Complements**: RL training frameworks

**Openness assessment**: (to be assessed by oss-health skill)

### RLVR-World: Training World Models with Reinforcement Learning

**URL**: [github.com/thuml/RLVR-World](https://github.com/thuml/RLVR-World)

**Description**: Unified framework applying RL with verifiable rewards (RLVR) to optimize world models for transition prediction metrics. Supports both language-based and video-based world models across text games, web navigation, and robot manipulation. NeurIPS 2025.

**Tech Stack**: Python, PyTorch, Hugging Face Transformers

**Key Features**:

- +30.7% accuracy for text world models (1.5B LLM rivaling GPT-4)
- +15.1% F1 on web navigation; +18.4% relative on WebArena agent success
- Covers language and video modalities with unified RLVR post-training paradigm
- MIT licensed

**Status**: Maintained

**Stats**: 237 stars, 11 forks, 3 contributors (Tsinghua University)

**Last Updated**: 2025-10

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models), [Post-Training & Fine-Tuning Pipeline](building-blocks.md#post-training--fine-tuning-pipeline)

**Maturity**: Research

**Competes with**: Standard supervised world model training

**Complements**: Language models, video models, RL frameworks

**Openness assessment**: (to be assessed by oss-health skill)

### stable-worldmodel: Reproducible World Model Research & Evaluation

**URL**: [github.com/galilai-group/stable-worldmodel](https://github.com/galilai-group/stable-worldmodel)

**Description**: Standardized library for world model research providing integrated data collection, model training, and evaluation with model predictive control. Analogous to Stable Baselines3 but for world models — ships pre-implemented baselines (DINO-WM, GCBC, HILP, GCIVL, GCIQL) across 16 environments with both zeroth-order and gradient-based planning solvers.

**Tech Stack**: Python 3.10+, PyTorch, HDF5/MP4 datasets, uv package manager, Ruff

**Key Features**:

- Pre-implemented baselines: DINO-WM, GCBC, HILP, GCIVL, GCIQL
- Planning solvers: zeroth-order (CEM, MPPI) and gradient-based (SGD, Adam, PGD)
- 16 environments across DeepMind Control Suite, OGBench, PushT, Two-Room
- Optimized data loading (HDF5/MP4) to reduce CPU bottlenecks and maximize GPU utilization
- Gymnasium-compatible interface for custom environments
- `pip install stable-worldmodel`

**Status**: Active

**Stats**: 181 stars, 28 forks, 8 contributors (Galilai group — academic; lead contributors: Lucas Maes, Quentin Llavador, Randall Balestriero)

**Last Updated**: 2026-02

**Building block(s)**: [Latent World Models](building-blocks.md#latent-world-models)

**Maturity**: Early OSS

**Competes with**: JEPA-WMs, HWM

**Complements**: Simulation engines, benchmarking datasets

**Openness assessment**: (to be assessed by oss-health skill)

---

## Video Generation / Prediction Models

*Pixel-space generative models that predict future video frames. Includes text-to-world, image-to-world, and video-to-world models.*

### Cosmos 3: Unified Omnimodal World Model

**URL**: [github.com/nvidia/Cosmos](https://github.com/nvidia/Cosmos)

**Description**: NVIDIA's unified omnimodal world model platform combining vision-language reasoning, video/audio generation, and action prediction in a single Mixture-of-Transformers architecture. Released May 31, 2026 at GTC Taipei. Supersedes the separate Predict/Transfer/Reason model repos with a unified framework supporting text, image, video, audio, and action modalities.

**Tech Stack**: Python, PyTorch, Hugging Face Diffusers, vLLM, vLLM-Omni, Qwen3-VL (base for Nano/Super)

**Key Features**:

- Three model scales: Nano (16B: 8B reasoner + 8B generator), Super (64B: 32B reasoner + 32B generator), Edge (2B, announced for later release)
- Five open model checkpoints: Super, Nano, Super-Text2Image, Super-Image2Video, Nano-Policy-DROID
- Five curated synthetic datasets (PhyxSim, RobotSim, DriveSim, SynHuman, Warehouse) on HuggingFace
- Available on Hugging Face under OpenMDW 1.1 license (commercial use permitted)
- Cosmos-HUE evaluation benchmark for Physical AI video generation
- ABB Robotics, FANUC, KUKA, Yaskawa (2M+ combined robot install base) using Omniverse + Isaac with Cosmos

**Status**: Active

**Stats**: 8,500 stars, 543 forks, 84 watchers (NVIDIA)

**Last Updated**: 2026-06

**Building block(s)**: [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models)

**Maturity**: Production-ready

**Competes with**: Cosmos-Predict2.5, Genie 2, Sora

**Complements**: Cosmos-Tokenizer, vLLM-Omni for serving

**Openness assessment**: (to be assessed by oss-health skill)

### Cosmos-Predict2.5: World Simulation Foundation Model

**URL**: [github.com/nvidia-cosmos/cosmos-predict2.5](https://github.com/nvidia-cosmos/cosmos-predict2.5)

**Description**: Latest generation of NVIDIA's Cosmos World Foundation Models, a flow-based model unifying Text2World, Image2World, and Video2World into a single architecture for simulating and predicting future world states as video. Uses Cosmos-Reason1 as text encoder for physically-grounded generation.

**Tech Stack**: Python, PyTorch, CUDA, Hugging Face Diffusers, NeMo Framework

**Key Features**:

- Unified flow-based architecture for text/image/video-conditioned world generation at 2B and 14B scales
- RL-based post-training for improved video quality and instruction alignment
- Distilled 2B checkpoint available via Hugging Face Diffusers
- Post-training recipes for robot policy models and action-conditioned distillation (via cosmos-cookbook)
- NVIDIA Open Model License (commercial use permitted)

**Status**: Active

**Stats**: 855 stars, 94 forks, 14 contributors (NVIDIA)

**Last Updated**: 2026-02

**Building block(s)**: [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models)

**Maturity**: Production-ready

**Competes with**: Cosmos 3, Genie 2

**Complements**: Cosmos-Transfer2.5, Cosmos-Reason2, Cosmos-Tokenizer

**Openness assessment**: (to be assessed by oss-health skill)

### Cosmos-Transfer2.5: World Translation (Sim2Real/Real2Real)

**URL**: [github.com/nvidia-cosmos/cosmos-transfer2.5](https://github.com/nvidia-cosmos/cosmos-transfer2.5)

**Description**: Multi-controlnet built on Cosmos-Predict2.5 for producing world simulations conditioned on multiple spatial control inputs (RGB, depth, segmentation). Includes general Physical AI/robotics checkpoints and specialized autonomous vehicle checkpoints. 3.5x smaller than predecessor with superior fidelity.

**Tech Stack**: Python, PyTorch, CUDA, NeMo Framework

**Key Features**:

- Multi-modal structured input: RGB, depth, segmentation maps
- General checkpoints for Physical AI/robotics + specialized AV checkpoints
- Sim2Real and Real2Real world translation capabilities
- 3.5x smaller than Transfer1 with superior long-horizon video generation
- NVIDIA Open Model License (commercial use permitted)

**Status**: Active

**Stats**: 477 stars, 74 forks, 18 contributors (NVIDIA)

**Last Updated**: 2026-03

**Building block(s)**: [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)

**Maturity**: Production-ready

**Competes with**: Domain randomization, style transfer techniques

**Complements**: Cosmos-Predict2.5, simulation engines

**Openness assessment**: (to be assessed by oss-health skill)

### Cosmos-Tokenizer: Video & Image Neural Tokenizers

**URL**: [github.com/NVIDIA/Cosmos-Tokenizer](https://github.com/NVIDIA/Cosmos-Tokenizer)

**Description**: Suite of image and video neural tokenizers supporting the Cosmos WFM pipeline. Provides the tokenization layer that converts raw video/image data into the token representations consumed by Cosmos world foundation models.

**Tech Stack**: Python, PyTorch, CUDA

**Key Features**:

- Neural tokenizers for both image and video modalities
- Foundation component of the Cosmos WFM pipeline
- Open-source under Apache 2 License

**Status**: Maintained

**Stats**: 1,711 stars, 87 forks (NVIDIA)

**Last Updated**: 2025-02

**Building block(s)**: [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models)

**Maturity**: Production-ready

**Competes with**: Other video tokenizers (e.g., MAGVIT)

**Complements**: Cosmos-Predict2.5, Cosmos 3

**Openness assessment**: (to be assessed by oss-health skill)

---

## Robot Foundation Models

*Foundation models for robot manipulation and navigation. Includes VLAs (Vision-Language-Action models) and World Action Models (WAMs).*

### Isaac-GR00T: Foundation Model for Generalist Humanoid Robots

**URL**: [github.com/NVIDIA/Isaac-GR00T](https://github.com/NVIDIA/Isaac-GR00T)

**Description**: NVIDIA's open foundation model for generalist humanoid robot skills. VLA model taking multimodal input (language instructions + camera images) and outputting manipulation actions. Dual-system architecture with fast reactive control and slow deliberative planning. Latest version N1.7 (April 2026) built on Cosmos-Reason2-2B backbone (Qwen3-VL architecture, replacing Eagle) with 32-layer DiT for low-level motor control. GR00T N2 (previewed GTC 2026, coming end 2026) will be built on DreamZero WAM architecture with 2x generalization improvement.

**Tech Stack**: Python, PyTorch, CUDA, Isaac Lab, LeRobot integration, ONNX, TensorRT

**Key Features**:

- Open VLA foundation model for humanoid manipulation with dual-system (reactive + deliberative) architecture
- N1.7 (April 2026): 3B parameters, Cosmos-Reason2-2B backbone (Qwen3-VL architecture), 32-layer DiT for motor control
- N1.7 expanded capabilities: state/action dimensions from 29 to 132, action_horizon from 16 to 40; full ONNX and TensorRT export support
- N2 Preview (GTC 2026): Based on DreamZero WAM architecture; 2x generalization vs VLAs; #1 on MolmoSpaces and RoboArena
- 40% task success boost from synthetic data (Isaac Lab, MimicGen)
- Adopted by 1X, Agility, Figure AI, Boston Dynamics, Unitree, Sanctuary AI, Humanoid, LG Electronics, NEURA, Noble Machines
- LeRobot integration (July 6, 2026): NVIDIA + HuggingFace collaboration — Isaac Teleop for demo data collection, LeRobot as common library, GR00T N1.7 as humanoid VLA policy
- Big 4 industrial robotics (ABB, FANUC, YASKAWA, KUKA) integrating Omniverse + Isaac for virtual commissioning
- N1.7 (April 2026): Apache 2.0 licensed — fully commercially licensable
- Prior versions: NVIDIA Open Model License (commercial use permitted)

**Status**: Active

**Stats**: 6,568 stars, 1,095 forks, 34 contributors (NVIDIA)

**Last Updated**: 2026-07 (N1.7 + LeRobot integration)

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)

**Maturity**: Production-ready

**Competes with**: OpenPI, DreamZero, LingBot-VA 2.0

**Complements**: Isaac Lab simulation, LeRobot serving framework, vLLM-Omni

**Openness assessment**: (to be assessed by oss-health skill)

### Isaac GR00T Reference Humanoid Robot

**URL**: [nvidianews.nvidia.com/news/nvidia-open-humanoid-robot-reference-design](https://nvidianews.nvidia.com/news/nvidia-open-humanoid-robot-reference-design)

**Description**: First open humanoid robot reference design, announced June 1, 2026 at GTC Taipei. Combines Unitree H2 Plus chassis with Sharpa Wave five-finger tactile hands and NVIDIA Jetson AGX Thor T5000 onboard compute. Ships the full Isaac stack: Isaac Sim, Isaac Lab, Cosmos, ROS middleware, and CUDA-X libraries. Intended as a research platform for academic and industry partners.

**Tech Stack**: Unitree H2 Plus chassis, Sharpa Wave tactile hands, NVIDIA Jetson AGX Thor T5000, Isaac Sim, Isaac Lab, Cosmos, ROS, CUDA-X

**Key Features**:

- Open reference design: ~6ft, ~150 lbs, 75 DOF
- Sharpa Wave five-finger tactile hands for dexterous manipulation
- Jetson AGX Thor T5000 onboard compute (Blackwell, 2070 FP4 TFLOPS)
- Full Isaac software stack pre-integrated
- Research partners: Ai2, ETH Zurich, Stanford, UCSD
- Available from Unitree late 2026

**Status**: Announced

**Stats**: NVIDIA + Unitree + Sharpa Wave

**Last Updated**: 2026-06

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Simulation Engines](building-blocks.md#simulation-engines)

**Maturity**: Early OSS

**Competes with**: Figure 03, Unitree G1 (standalone), 1X NEO — as research humanoid platform

**Complements**: Isaac-GR00T (VLA policy), Isaac Sim (simulation), LeRobot (training framework)

**Openness assessment**: Open reference design; hardware proprietary (Unitree, Sharpa Wave); software stack mixed (Isaac Sim Apache 2.0, GR00T Apache 2.0)

### OpenPI: Open-Source π0 VLA Foundation Models

**URL**: [github.com/Physical-Intelligence/openpi](https://github.com/Physical-Intelligence/openpi)

**Description**: Physical Intelligence's open-source VLA foundation models for general-purpose robot manipulation. Includes model variants: π0 (flow-based VLA), π0-FAST (autoregressive VLA using FAST action tokenizer), π0.5 (knowledge insulation for open-world generalization), and π0.7 (April 2026, compositional generalization). Pre-trained on 10K+ hours of robot data across 7 platforms and 68 tasks. Fine-tuning requires only 1-20 hours of data for new tasks.

**Tech Stack**: Python, JAX (native), PyTorch (HuggingFace port via LeRobot)

**Key Features**:

- Model variants: π0 (flow-based), π0-FAST (autoregressive), π0.5 (open-world), π0.7 (compositional generalization)
- π0.7 (April 2026): Demonstrates compositional generalization — combines skills from different contexts to solve novel problems; air fryer demo with only 2 training episodes
- Pre-trained on 10K+ hours across 7 robot platforms, 68 tasks
- 1-20 hours of data sufficient for fine-tuning to new tasks
- Multi-platform support: ALOHA, DROID, and custom robots
- HuggingFace/LeRobot PyTorch port available for those preferring PyTorch over JAX
- vLLM-Omni targeting OpenPI-style WebSocket API as standard robotics interface ([RFC #1987](https://github.com/vllm-project/vllm-omni/issues/1987))

**Status**: Active

**Stats**: 11,484 stars, 1,817 forks (Physical Intelligence)

**Last Updated**: 2026-04

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)

**Maturity**: Production-ready

**Competes with**: Isaac-GR00T, DreamZero, LingBot-VA 2.0

**Complements**: LeRobot framework, vLLM-Omni, ALOHA/DROID hardware

**Openness assessment**: (to be assessed by oss-health skill)

### DreamZero: World Action Model for Zero-Shot Robot Policies

**URL**: [github.com/dreamzero0/dreamzero](https://github.com/dreamzero0/dreamzero)

**Description**: NVIDIA's 14B-parameter World Action Model (WAM) that jointly predicts video frames and robot actions through shared denoising on a pretrained video diffusion backbone. Unlike VLAs trained on static image-text, WAMs learn physical dynamics from video, achieving 2x better generalization to unseen tasks. DreamZero-Flash achieves single-step inference at ~150ms via decoupled noise schedules (38x speedup). Cross-embodiment transfer adapts to new robots with 30 minutes of play data. GR00T N2 (planned end 2026) will be built on DreamZero architecture.

**Tech Stack**: Python, PyTorch, CUDA

**Key Features**:

- 14B-param WAM jointly predicting video + actions via shared denoising
- 2x better generalization than VLAs on unseen tasks (39.5% vs 16.3% task progress)
- DreamZero-Flash: single-step inference at ~150ms (38x speedup)
- Cross-embodiment: adapts to new robots with 30 min of play data
- P0 priority in vLLM-Omni world model support ([RFC #1987](https://github.com/vllm-project/vllm-omni/issues/1987))
- Apache 2.0 licensed

**Status**: Active

**Stats**: 1,740 stars, 135 forks (NVIDIA)

**Last Updated**: 2026-04

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)

**Maturity**: Research

**Competes with**: Isaac-GR00T, OpenPI, LingBot-VA

**Complements**: Video generation models, vLLM-Omni

**Openness assessment**: (to be assessed by oss-health skill)

### LingBot-VA 2.0: Native Video-Action Foundation Model for Robot Control

**URL**: [github.com/Robbyant/lingbot-va](https://github.com/robbyant/lingbot-va)

**Description**: Video-action foundation model from Robbyant (Ant Group) pretrained from scratch for embodied control. v2.0 replaces v1's retrofitted bidirectional-to-causal approach with native causal DiT pretraining on web-scale video, decoupling model quality from scarce robot data. Features semantic visual-action tokenizer (aligned to frozen UMT5), sparse MoE backbone (~5B params), and asynchronous foresight inference predicting future latents in parallel with action execution. Real-time 150 Hz single-GPU inference eliminates the WAM latency penalty.

**Tech Stack**: Python (96.7%), PyTorch 2.9.0, CUDA 12.6, flash-attn, diffusers, HuggingFace transformers

**Key Features**:

- Native causal pretraining on web-scale image/video — no robot data needed for pretraining
- 150 Hz real-time inference on single GPU (~24 GB VRAM) — eliminates 83x WAM latency gap vs VLAs
- 20-shot in-context generalization to new tasks without parameter updates
- RoboTwin 2.0: 92.9% Easy / 91.6% Hard (+4.2/+4.6 over Motus); +8.2%/+9.1% at Horizon=3
- LIBERO: 98.5% success rate (industry record)
- Sparse MoE architecture (~5B params DiT + ~20 GB frozen VAE+UMT5)
- Integrated into LeRobot v0.6.0 as first-class policy
- Part of six-model LingBot stack: VA 2.0, VLA 2.0, World 2.0, Depth 2.0, Vision, Video
- Three model variants: lingbot-va-base, lingbot-va-posttrain-robotwin, lingbot-va-posttrain-libero-long

**Status**: Active

**Stats**: 1.5k stars, 138 forks (Robbyant / Ant Group)

**Last Updated**: 2026-07

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)

**Maturity**: Early OSS

**Competes with**: OpenPI, Isaac-GR00T, DreamZero

**Complements**: LeRobot (integrated policy), vLLM-Omni (targeted for serving), simulation engines

**Openness assessment**: Apache-2.0 license; code, weights, and training recipes on GitHub/HuggingFace. Single-vendor (Ant Group) controlled.

### OpenVLA: Open-Source Vision-Language-Action Model

**URL**: [github.com/openvla/openvla](https://github.com/openvla/openvla)

**Description**: Open-source 7B-parameter VLA from Stanford, trained on 970K real-world demonstrations from the Open X-Embodiment dataset. Combines Llama 2 backbone with fused DINOv2 + SigLIP visual encoders. Outperforms closed 55B RT-2-X by 16.5% with 7x fewer parameters. OFT update (March 2025) achieves 97.1% on LIBERO with 25-50x faster inference.

**Tech Stack**: Python, PyTorch, Transformers (HuggingFace)

**Key Features**:

- 7B-param VLA outperforming RT-2-X (55B) by 16.5% across 29 tasks
- OFT (Optimized Fine-Tuning, Mar 2025): continuous actions for 25-50x faster inference, 97.1% LIBERO
- FAST action tokenizer (Jan 2025): 15x inference speedup via action chunk compression
- Fine-tunable on consumer GPUs via LoRA; quantizable without quality loss
- Open X-Embodiment training enables cross-embodiment generalization
- De facto open VLA baseline — referenced by GR00T, π0, SmolVLA, Cosmos-RL

**Status**: Active

**Stats**: 3,200+ stars, 400+ forks (Stanford, UC Berkeley)

**Last Updated**: 2025-03

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)

**Maturity**: `Production-ready`

**Competes with**: OpenPI, Isaac-GR00T — on open-source robot manipulation policy

**Complements**: Cosmos-RL (training), LeRobot (serving), LIBERO/SimplerEnv (evaluation)

**Openness assessment**: (to be assessed by oss-health skill)

### SmolVLA: Compact Vision-Language-Action Model

**URL**: [github.com/huggingface/lerobot](https://github.com/huggingface/lerobot) (integrated into LeRobot)

**Description**: HuggingFace's 450M-parameter compact VLA built on SmolVLM-2 (SigLIP + SmolLM2) with flow-matching action expert. Trainable on a single GPU, deployable on consumer GPUs or CPUs. Competitive with models 10x larger on LIBERO and Meta-World benchmarks. Fully open-source with community-collected LeRobot training data.

**Tech Stack**: Python, PyTorch, Transformers (HuggingFace), LeRobot

**Key Features**:

- 450M params — 15x smaller than OpenVLA, trainable on single GPU
- Flow-matching action expert with asynchronous inference for real-time control
- Competitive with OpenVLA (7B), Octo, π0 on LIBERO and Meta-World
- Community-driven: trained exclusively on compatibly-licensed, community-shared datasets (<30K episodes)
- Integrated into LeRobot framework with PolicyServer/RobotClient serving
- Fully open: code, weights, and training data under permissive licenses

**Status**: Active

**Stats**: (part of LeRobot — 12K+ stars)

**Last Updated**: 2025-06

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)

**Maturity**: `Research`

**Competes with**: OpenVLA, OpenPI — on accessible open-source VLA

**Complements**: LeRobot (hosting framework), Isaac Lab-Arena (evaluation)

**Openness assessment**: (to be assessed by oss-health skill)

### Spirit-v1.5: Open Robot Foundation Model

**URL**: [spirit-ai.com](https://www.spirit-ai.com/en/blog/spirit-v1-5)

**Description**: Open robot foundation model ranking #1 on the RoboChallenge Table30 benchmark, outperforming pi0.5 with statistical significance. Weights and codebase open-sourced on GitHub and Hugging Face. Emphasizes that clean, curated data matters more than model scale for real-world robot performance.

**Tech Stack**: Python, PyTorch

**Key Features**:

- #1 on RoboChallenge Table30 benchmark (as of Jan 2026)
- Open weights and code (GitHub + HuggingFace)
- Outperforms pi0.5 with statistical significance
- "Clean data > model scale" design philosophy

**Status**: Active

**Last Updated**: 2026-01

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)

**Category**: `OSS (single-vendor)`

**Competes with**: OpenPI, Isaac-GR00T, SmolVLA

**Complements**: LeRobot (evaluation/deployment), simulation platforms (training)

**Openness assessment**: (to be assessed by oss-health skill)

### Cosmos-RL: Reinforcement Learning Framework for Physical AI

**URL**: [github.com/nvidia-cosmos/cosmos-rl](https://github.com/nvidia-cosmos/cosmos-rl)

**Description**: Flexible and scalable async post-training framework specialized for RL and SFT in Physical AI applications. Supports training across LLM/VLM, world foundation models, and VLA paradigms with fault-tolerant elastic large-scale training.

**Tech Stack**: Python, PyTorch, CUDA, NeMo Framework

**Key Features**:

- SOTA RL algorithms: GRPO, DAPO for LLM/VLM; FlowGRPO, DDRL, DiffusionNFT for world foundation models; VLA-specific algorithms
- 6D Parallelism: Sequence, Tensor, Context, Pipeline, FSDP, DDP
- Dynamic NCCL Process Groups for on-the-fly GPU registration/unregistration enabling fault-tolerant elastic training
- Native support for OpenVLA, OpenVLA-OFT, PI0.5 series models; integrated with LIBERO and BEHAVIOR-1K simulators
- Apache 2.0 licensed (code), NVIDIA Open Model License (models)

**Status**: Active

**Stats**: 367 stars, 53 forks (NVIDIA)

**Last Updated**: 2026-03

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models), [Post-Training & Fine-Tuning Pipeline](building-blocks.md#post-training--fine-tuning-pipeline)

**Maturity**: Production-ready

**Competes with**: Traditional RL frameworks (RLlib, Stable Baselines3)

**Complements**: OpenVLA, OpenPI, Isaac-GR00T, LIBERO/BEHAVIOR-1K simulators

**Openness assessment**: (to be assessed by oss-health skill)

### Robostral Navigate: Single-Camera Robot Navigation

**URL**: [mistral.ai/news/robostral-navigate](https://mistral.ai/news/robostral-navigate/)

**Description**: Mistral AI's 8B-parameter VLM for embodied navigation using a single RGB camera. Pointing-based approach predicts target image coordinates and orientation from natural-language instructions. Trained entirely in simulation (~400K trajectories across 6K scenes) with prefix-caching (22x token reduction) and CISPO online RL.

**Tech Stack**: Mistral proprietary VLM backbone (built in-house), simulation-based training, online RL (CISPO algorithm)

**Key Features**:

- 76.6% success on unseen R2R-CE benchmark — beats multi-sensor systems by 4.5 pts, best single-camera by 9.7 pts
- Hardware-agnostic: deploys on wheeled, legged, and flying robots
- Pointing-based navigation robust to camera intrinsics and world scale
- Prefix-caching with tree-based attention masking reduces training tokens by 22x
- CISPO online RL for failure recovery and exploratory behavior (+3.2% success rate)
- Navigation only — no manipulation capability

**Status**: Active

**Stats**: Mistral AI, AI Science Robotics group

**Last Updated**: 2026-07

**Building block(s)**: [Robot Foundation Models](building-blocks.md#robot-foundation-models)

**Maturity**: Research

**Competes with**: GR00T N1, OpenPI, Gemini Robotics — on robot foundation models (navigation scope only)

**Complements**: Robot middleware (ROS2), simulation platforms, fleet management systems

**Openness assessment**: Proprietary — no open-source release or open weights announced. Built fully in-house without existing open-source VLMs.

---

## Robot Middleware

*Robot Operating Systems, middleware, and communication layers for robot control and coordination.*

### Nav2 (Navigation 2): ROS 2 Navigation Framework

**URL**: [github.com/ros-navigation/navigation2](https://github.com/ros-navigation/navigation2)
**Building block(s)**: [Robot Middleware](building-blocks.md#robot-middleware)

**Description**: Complete mobile robot navigation stack for ROS 2. Provides path planning, obstacle avoidance, localization (AMCL), costmap management, and behavior-tree-based task orchestration. Supports differential drive, omnidirectional, and Ackermann kinematics.
**Tech Stack**: C++, Python, ROS 2, Behavior Trees

**Key Features**:

- Multiple planners: NavFn, Smac (Hybrid A*, State Lattice, 2D), Theta Star
- Multiple controllers: DWB, MPPI, Regulated Pure Pursuit, Graceful Controller
- Costmap 2D with pluggable layers; Collision Monitor for safety
- Behavior-tree navigator for composable multi-step missions
- Docking support (opennav_docking) and waypoint following
- Simple Commander Python API for programmatic access

**Openness assessment**:

| Dimension              | Rating     | Detail                                                      |
| ---------------------- | ---------- | ----------------------------------------------------------- |
| License                | Permissive | Apache-2.0 and BSD-3-Clause mix                             |
| Governance             | BDFL       | Open Navigation LLC (Steve Macenski) leads; community PRs   |
| Contributor diversity  | Medium     | Sponsors include NVIDIA, AMD, Dexory; BDFL-driven core      |
| Community health       | Active     | 3.5K+ commits, ROS 2 Humble/Jazzy/Kilted releases           |
| Corporate control risk | Medium     | Open Navigation LLC holds project leadership                |

**Maturity**: Production-ready

**Competes with**: Isaac ROS Nav (NVIDIA-accelerated wrapper around Nav2), proprietary OEM navigation stacks
**Complements**: ROS 2, MoveIt (manipulation + navigation integration), Gazebo (sim testing)

**Stats**: 4.5K stars, 1.9K forks; sponsored by NVIDIA, AMD, Dexory, Stereolabs
**Last Updated**: 2026-07

### PX4-Autopilot: Open-Source Drone Flight Controller Stack

**URL**: [github.com/PX4/PX4-Autopilot](https://github.com/PX4/PX4-Autopilot)
**Building block(s)**: [Robot Middleware](building-blocks.md#robot-middleware)

**Description**: Open-source autopilot for drones and unmanned vehicles. Supports multirotors, fixed-wing, VTOL, rovers, and experimental platforms. Runs on NuttX RTOS and Linux; interfaces with ROS 2 via DDS/MAVROS.
**Tech Stack**: C++ (51%), C (36%), NuttX RTOS, uORB middleware (DDS-compatible), MAVLink protocol

**Key Features**:

- Modular publish-subscribe architecture (uORB); fully parallelized and thread-safe modules
- First-class ROS 2 / DDS integration; native MAVLink protocol support
- Pixhawk ecosystem hardware support (Pixhawk 6X, Cube, etc.)
- SITL (software-in-the-loop) simulation for development and CI
- Vendor-neutral governance under Dronecode Foundation (Linux Foundation)

**Openness assessment**:

| Dimension              | Rating     | Detail                                                        |
| ---------------------- | ---------- | ------------------------------------------------------------- |
| License                | Permissive | BSD-3-Clause                                                  |
| Governance             | Foundation | Dronecode Foundation (Linux Foundation); holds all trademarks |
| Contributor diversity  | High       | 50K+ commits, 15.7K forks; multi-vendor contributor base      |
| Community health       | Active     | v1.17.0 (May 2026); weekly dev calls, active Discord          |
| Corporate control risk | Low        | Foundation governance; no single vendor controls roadmap      |

**Maturity**: Industry standard

**Competes with**: ArduPilot (copyleft alternative), DJI SDK (proprietary), Auterion PX4-based commercial
**Complements**: ROS 2 (via MAVROS / DDS bridge), Gazebo (SITL), QGroundControl (ground station)

**Stats**: 12.1K stars, 15.7K forks, 135 releases; Dronecode Foundation
**Last Updated**: 2026-07

---

## Simulation Engines

*Physics-based simulation for training and evaluating world models and robot policies. Organized in three tiers: simulation platforms (user-facing), physics engines (dynamics backends), and rendering engines (visual backends). Dependency fields link the tiers so platform lock-in and technical risk propagate visibly.*

### Simulation Platforms

*End-to-end environments combining physics, rendering, and tooling for robot/agent training.*

#### Genesis World: Multi-Physics Simulation Platform

**URL**: [github.com/Genesis-Embodied-AI/Genesis](https://github.com/Genesis-Embodied-AI/Genesis)

**Description**: Open-source simulation platform for physical AI combining a unified multi-physics engine, photo-realistic renderer (Nyx), and cross-platform compiler (Quadrants) behind a Pythonic API. Started as an academic project (Dec 2024), now backed by [Genesis AI](../research/ecosystem.md#genesis-ai). Sim-to-real correlation of 0.90 Pearson across 14 tasks. v1.2.1 (July 2026) delivers real-time CPU performance for large scenes (120 FPS with 100 entities / 1,000 geometries) via sparse incremental Hessian updates, adds JointTorqueSensor, and fixes composite-link center-of-mass alignment.

**Tech Stack**: Python, Quadrants compiler (CUDA, ROCm, Metal, Vulkan, x86/ARM64), Nyx renderer, Luisa (ray tracer), Pyrender (rasterizer)

**Dependencies**:

| Layer            | Engine             | Acceleration                   |
| ---------------- | ------------------ | ------------------------------ |
| Physics backend  | Custom (Quadrants) | CUDA, ROCm, Metal, Vulkan, CPU |
| Rendering engine | Nyx                | CUDA, Vulkan, Metal            |

**Key Features**:

- Unified multi-physics: Rigid, FEM, MPM, Particle (PBD/SPH), uipc, explicit coupler, SAP — all sharing one scene and state
- Quadrants compiler: Python kernels JIT-compiled to CUDA, AMD ROCm, Apple Metal, Vulkan, x86/ARM64 via LLVM (forked from Taichi, June 2025)
- Three rendering paths: Nyx (real-time path-traced, noise-free 1080p in <4ms, 45% lower FID), Luisa (ray tracer), Pyrender (rasterizer)
- v1.2.x: CPU rigid solver scaling — 120 FPS at 100 entities / 1,000 geometries via sparsity and incremental Hessian updates
- JointTorqueSensor for measuring joint torques
- Rich sensor suite: depth cameras, IMU, lidar, tactile, contact force, surface distance, temperature grids
- Parses URDF, MJCF, OBJ, GLB, USD asset formats
- Docker support for NVIDIA and AMD GPUs; scales from laptop to datacenter

**Status**: Active

**Stats**: 29.5K stars, 2.8K forks, multi-contributor ([Genesis AI](../research/ecosystem.md#genesis-ai) + community)

**Last Updated**: 2026-07 (v1.2.1)

**Building block(s)**: [Simulation Engines](building-blocks.md#simulation-engines)

**Maturity**: Early OSS

**Competes with**: Isaac Sim, MuJoCo, Newton

**Complements**: Robot foundation models (GR00T, OpenPI), latent world models

**Openness assessment**: (to be assessed by oss-health skill)

#### PhysicsNeMo: Physics-ML Framework for AI Surrogate Models

**URL**: [github.com/NVIDIA/physicsnemo](https://github.com/NVIDIA/physicsnemo)

**Description**: Open-source framework for building, training, and inferring physics-informed ML models. Provides optimized model architectures (neural operators, graph neural networks, diffusion transformers) and scalable data pipelines for scientific/engineering data (point clouds, meshes). Enables AI surrogate models that combine physics-driven causality with simulation data for real-time predictions — the physics simulation layer underlying NVIDIA's autonomous digital twin vision.

**Tech Stack**: Python, PyTorch, CUDA, PyTorch Geometric

**Key Features**:

- Built-in model families: Neural Operators (FNO), Graph Neural Networks, Diffusion Transformers (DiT), Transformers
- PhysicsNeMo Sym: symbolic PDE integration, domain sampling, physics-informed residual computation
- PhysicsNeMo CFD: inference recipes for pre-trained CFD models (e.g., DoMINO Automotive Aerodynamics NIM)
- Domain parallelism for kNN, radius search; distributed training across multi-GPU/multi-node
- Domain packages: Earth-2 Studio (weather/climate), CFD, Curator (data curation for engineering datasets)
- Apache 2.0 licensed

**Status**: Active

**Stats**: 2,600+ stars, 629 forks (NVIDIA)

**Last Updated**: 2026-03

**Building block(s)**: [Simulation Engines](building-blocks.md#simulation-engines), [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks)

**Maturity**: Production-ready

**Competes with**: Traditional CFD/FEM solvers (ANSYS, OpenFOAM)

**Complements**: Digital twin runtime, autonomous systems

**Openness assessment**: (to be assessed by oss-health skill)

#### NeuralOperator: PyTorch Library for Neural Operators

**URL**: [github.com/neuraloperator/neuraloperator](https://github.com/neuraloperator/neuraloperator)

**Description**: Official PyTorch Ecosystem library for learning neural operators — function-to-function mappings that generalize across PDE instances. Implements FNO, TFNO, GINO, UNO, SFNO, FNOGNO, and other architectures. Co-developed by NVIDIA Research and Caltech. Provides clean API for training, evaluating, and deploying neural operator surrogates. Complements DeepXDE (which covers DeepONet but not FNO).

**Tech Stack**: Python, PyTorch

**Key Features**:

- FNO family: FNO, TFNO (tensor-factorized), SFNO (spherical), GINO (geometry-informed), UNO (U-shaped)
- Official PyTorch Ecosystem member (Dec 2025)
- Training utilities, data loaders for standard PDE benchmarks
- Apache 2.0 licensed (inferred from PyTorch Ecosystem standards)

**Status**: Active

**Stats**: PyTorch Ecosystem member; actively maintained by NVIDIA Research + Caltech

**Last Updated**: 2026-07

**Building block(s)**: [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks)

**Maturity**: Production-ready

**Competes with**: DeepXDE (complementary — NeuralOperator covers FNO family; DeepXDE covers DeepONet + PINNs)

**Complements**: PhysicsNeMo (higher-level framework that includes FNO implementations)

**Openness assessment**: (to be assessed by oss-health skill)

#### DeepXDE: Multi-Backend PINNs and DeepONet Library

**URL**: [github.com/lululxvi/deepxde](https://github.com/lululxvi/deepxde)

**Description**: Library for scientific machine learning and physics-informed learning. Supports PINNs (physics-informed neural networks) and multiple DeepONet variants for operator learning. Key differentiator: supports 5 deep learning backends (TensorFlow 1.x, TensorFlow 2.x, PyTorch, JAX, PaddlePaddle), making it the most hardware-portable framework in this space. Does not implement standalone FNO — complementary to NeuralOperator.

**Tech Stack**: Python, PyTorch / TensorFlow / JAX / PaddlePaddle

**Key Features**:

- PINNs for forward and inverse PDE problems
- DeepONet variants: vanilla, multi-fidelity, physics-informed
- 5 backend support — most portable physics-ML library
- Extensive documentation and tutorial ecosystem
- MIT licensed

**Status**: Active

**Stats**: 4,300+ stars, 72 releases

**Last Updated**: 2026-07

**Building block(s)**: [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks)

**Maturity**: Production-ready

**Competes with**: PhysicsNeMo (NVIDIA-locked), NeuralOperator (FNO-focused)

**Complements**: NeuralOperator (DeepXDE handles DeepONet/PINNs; NeuralOperator handles FNO family)

**Openness assessment**: (to be assessed by oss-health skill)

#### PDEBench: Standardized Benchmarks for Neural PDE Solvers

**URL**: [github.com/pdebench/PDEBench](https://github.com/pdebench/PDEBench)

**Description**: Standardized benchmark suite comparing FNO, U-Net, and PINN architectures across 9+ PDE problems (1D advection, Burgers, diffusion-reaction, 2D Darcy flow, shallow-water, compressible and incompressible Navier-Stokes). Published at NeurIPS 2022 with follow-on work at ICML, ICLR, TMLR. Datasets hosted on DaRUS in HDF5 format. Enables reproducible comparison of neural surrogate architectures.

**Tech Stack**: Python, PyTorch, HDF5

**Key Features**:

- 9+ PDE benchmark problems with pre-generated datasets
- Baseline implementations of FNO, U-Net, PINN
- HDF5 datasets on DaRUS for reproducibility
- Widely adopted evaluation standard at top ML venues
- MIT licensed

**Status**: Active

**Last Updated**: 2026-07

**Building block(s)**: [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks)

**Maturity**: Production-ready (as benchmark tooling)

**Competes with**: Ad-hoc benchmark practices (provides standardization)

**Complements**: NeuralOperator, DeepXDE, PhysicsNeMo (evaluation target for all three)

**Openness assessment**: (to be assessed by oss-health skill)

#### Newton: GPU-Accelerated Physics Engine for Robotics

**URL**: [github.com/newton-physics/newton](https://github.com/newton-physics/newton)

**Description**: Open-source, extensible physics engine built on NVIDIA Warp and OpenUSD. Joint project of NVIDIA, Google DeepMind, and Disney Research, contributed to the Linux Foundation (September 2025). Newton 1.0 released at GTC 2026. Ships MuJoCo Warp and Kamino rigid-body solvers, Vertex Block Descent for deformables, SDF collision, and hydroelastic contact modeling.

**Tech Stack**: Python, NVIDIA Warp, OpenUSD, CUDA

**Dependencies**:

| Layer            | Engine                       | Acceleration        |
| ---------------- | ---------------------------- | ------------------- |
| Physics backend  | MuJoCo Warp, Kamino, VBD     | CUDA (NVIDIA only)  |
| Rendering engine | (none built-in; via OpenUSD) | —                   |

**Key Features**:

- MuJoCo Warp on RTX PRO 6000: 252x faster than MJX (locomotion), 475x (manipulation)
- Differentiable physics via NVIDIA Warp — gradients through simulation steps
- Deformable simulation: cables, cloth, volumetric objects (Vertex Block Descent solver)
- OpenUSD scene description for asset pipeline integration
- Linux Foundation governance, Apache 2.0 license

**Status**: Active

**Stats**: ~5.1K stars (NVIDIA + Google DeepMind + Disney Research)

**Last Updated**: 2026-03 (Newton 1.0)

**Building block(s)**: [Simulation Engines](building-blocks.md#simulation-engines)

**Maturity**: Early OSS

**Competes with**: Genesis World, Isaac Sim, MuJoCo (standalone)

**Complements**: Isaac Lab, MuJoCo Playground, OpenUSD ecosystem

**Openness assessment**: (to be assessed by oss-health skill)

#### Genie 3 / Project Genie: Generative World Simulator

**URL**: [deepmind.google/models/genie/](https://deepmind.google/models/genie/)

**Description**: Google DeepMind's learned world model generating interactive 3D environments from text prompts at 720p / 24fps. Not a physics engine — a generative simulator producing explorable worlds that respond to user input in real-time. Waymo adopted a fine-tuned version (February 2026). Street View integration announced at Google I/O 2026.

**Tech Stack**: Proprietary (Google infrastructure)

**Dependencies**:

| Layer            | Engine               | Acceleration    |
| ---------------- | -------------------- | --------------- |
| Physics backend  | Learned (generative) | Google TPU/GPU  |
| Rendering engine | Learned (generative) | Google TPU/GPU  |

**Key Features**:

- Text-to-world generation: interactive 3D environments from natural language
- 720p at 24fps, ~60 second sessions (current limit)
- Waymo World Model: fine-tuned variant with lidar output at 4x Genie 3 speed
- Street View integration: simulates real-world locations for robot/agent training
- Consumer product for Google AI Ultra subscribers; API access for partners

**Status**: Active

**Stats**: Proprietary (Google DeepMind)

**Last Updated**: 2026-05 (Street View integration)

**Building block(s)**: [Simulation Engines](building-blocks.md#simulation-engines), [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models)

**Maturity**: Production-ready

**Competes with**: Cosmos-Predict2.5, Genesis World (different paradigm — learned vs. physics-based)

**Complements**: Waymo autonomous driving stack, Google Cloud robotics

**Openness assessment**: Proprietary; no open-source release. Partner access via API only.

#### SAPIEN / ManiSkill: GPU-Parallelized Robotics Simulator

**URL**: [github.com/haosulab/ManiSkill](https://github.com/haosulab/ManiSkill)

**Description**: GPU-parallelized robotics simulator and benchmark framework built on the SAPIEN engine. Provides standardized manipulation and locomotion tasks with parallel environment execution. Powers SimplerEnv and is one of MolmoSpaces' supported backends.

**Tech Stack**: Python, PhysX 5, Vulkan, CUDA

**Dependencies**:

| Layer            | Engine  | Acceleration     |
| ---------------- | ------- | ---------------- |
| Physics backend  | PhysX 5 | CUDA (GPU), CPU  |
| Rendering engine | Vulkan  | Vulkan (GPU)     |

**Key Features**:

- GPU-parallelized environment execution for fast RL training
- Standardized task suites for manipulation, locomotion, and mobile manipulation
- Soft-body and articulated object simulation via PhysX 5
- Gymnasium-compatible API
- Apache 2.0 licensed

**Status**: Active

**Stats**: ~3K stars, Apache 2.0 (UC San Diego HAOSU Lab + community)

**Last Updated**: 2026-06

**Building block(s)**: [Simulation Engines](building-blocks.md#simulation-engines), [Evaluation & Benchmarking](#evaluation--benchmarking)

**Maturity**: Early OSS

**Competes with**: Isaac Lab, Robosuite, RLBench

**Complements**: MolmoSpaces (as backend), SimplerEnv, PhysX 5

**Openness assessment**: (to be assessed by oss-health skill)

#### Isaac Sim: GPU-Accelerated Robot Simulation Platform

**URL**: [github.com/isaac-sim/IsaacSim](https://github.com/isaac-sim/IsaacSim)

**Description**: NVIDIA's simulation platform on Omniverse for building, testing, training, and deploying AI-powered robots using physically accurate virtual worlds. Open-sourced under Apache 2.0 (previously proprietary). Supports URDF, MJCF, and CAD asset import with GPU-accelerated physics (PhysX 5) and multi-sensor RTX rendering. v6.0.0 (June 2026) adds experimental Newton physics engine support, OpenUSD robot/sensor schemas (engine-agnostic articulation via `NewtonArticulationRootAPI`), MJCF-OpenUSD interop with bidirectional conversion rules, multitick rendering, and NuRec neural rendering. v6.0.1 (June 2026) adds NuRec utilities extension (`isaacsim.replicator.nurec_utils`) with Sparse Pixel Gaussian (SPG) teleoperation support.

**Tech Stack**: Python 3.12 (85%), C++ (12%), CUDA, Kit SDK, OpenUSD, PhysX 5

**Dependencies**:

| Layer            | Engine                    | Acceleration              |
| ---------------- | ------------------------- | ------------------------- |
| Physics backend  | PhysX 5, Newton (exp.)    | CUDA (GPU), CPU           |
| Rendering engine | OptiX / RTX, NuRec (SPG)  | CUDA + RT cores           |

**Key Features**:

- GPU-accelerated physics via PhysX 5 with experimental Newton engine support (engine-agnostic tensor APIs)
- RTX ray-traced sensor simulation: cameras, depth, LiDAR, radar, ultrasonic (acoustic)
- v6.0: OpenUSD robot/sensor schemas — `NewtonArticulationRootAPI`, `NewtonMimicAPI` replace PhysX-specific schemas
- v6.0: MJCF-OpenUSD interop — `MjcToPhysxConversionRule`, `UrdfToMjcPhysxConversionRule`, MuJoCo Menagerie robot assets
- v6.0: Multitick rendering — cameras and RTX LiDARs scheduled at physics-driven rates and offsets
- v6.0.1: NuRec neural rendering via SPG graphs with teleoperation support
- Synthetic data generation: Replicator functional API, episode recorder (HDF5), AI behavior tree generation from natural language
- Isaac Lab: GPU-accelerated RL, imitation learning, and motion planning framework
- ROS 2 Bridge with full Windows support; Docker Compose deployment with WebRTC viewer
- SimReady assets: FANUC (84+ models), Comau robots; Luxonis, SICK, TI sensor assets
- Apache 2.0 licensed (open-sourced; previously proprietary NVIDIA license)

**Status**: Active

**Stats**: ~3,600 stars, ~497 forks (NVIDIA)

**Last Updated**: 2026-06 (v6.0.1)

**Building block(s)**: [Simulation Engines](building-blocks.md#simulation-engines), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)

**Maturity**: Production-ready

**Competes with**: Genesis World, MuJoCo Playground, Gazebo

**Complements**: Isaac Lab, Isaac-GR00T, Newton, PhysX 5, OpenUSD ecosystem, LeRobot

**Openness assessment**: (to be assessed by oss-health skill)

#### Webots: General-Purpose Robot Simulator

**URL**: [github.com/cyberbotics/webots](https://github.com/cyberbotics/webots)

**Description**: Open-source general-purpose robot simulator with 200+ pre-built robot models and native ROS 2 integration. Originally developed at EPFL, commercially maintained by Cyberbotics. Strong in education, prototyping, and swarm scenarios. Lower visual fidelity than Isaac Sim or Genesis but runs on modest hardware without GPU.

**Tech Stack**: C++, Python, Java, MATLAB, ROS 2

**Dependencies**:

| Layer            | Engine            | Acceleration |
| ---------------- | ----------------- | ------------ |
| Physics backend  | ODE (custom fork) | CPU only     |
| Rendering engine | WREN (custom)     | OpenGL       |

**Key Features**:

- 200+ pre-built robot models (UR5, ABB, TIAGo, etc.) with standard ROS 2 interfaces
- `webots_ros2` package: native ROS 2 integration with automatic topic mapping
- No GPU required — runs on CPU, suitable for CI/CD and cloud-based testing
- Cross-platform: Linux, macOS, Windows
- Apache 2.0 licensed

**Status**: Active

**Stats**: ~4.4K stars (Cyberbotics + community)

**Last Updated**: 2026-06

**Building block(s)**: [Simulation Engines](building-blocks.md#simulation-engines), [Robot Middleware](building-blocks.md#robot-middleware)

**Maturity**: Production-ready

**Competes with**: Gazebo (closest competitor — both target ROS 2 production)

**Complements**: ROS 2 ecosystem, CI/CD pipelines

**Openness assessment**: (to be assessed by oss-health skill)

#### MuJoCo Playground: Sim-to-Real Training Environments

**URL**: [github.com/google-deepmind/mujoco_playground](https://github.com/google-deepmind/mujoco_playground)

**Description**: Collection of MuJoCo-based training environments and tasks designed for zero-shot sim-to-real transfer. Won RSS 2025 Outstanding Demo Paper. Covers quadrupeds, humanoids, dexterous hands, and robot arms with validated real-world transfer.

**Tech Stack**: Python, MuJoCo, MJX (JAX), CUDA

**Dependencies**:

| Layer            | Engine          | Acceleration        |
| ---------------- | --------------- | ------------------- |
| Physics backend  | MuJoCo / MJX    | CUDA (via JAX), CPU |
| Rendering engine | MuJoCo built-in | OpenGL, EGL         |

**Key Features**:

- Zero-shot sim-to-real demonstrated across multiple embodiments
- MJX backend for GPU-accelerated parallel training via JAX
- RSS 2025 Outstanding Demo Paper
- Pre-configured tasks for locomotion, manipulation, dexterous grasping
- Apache 2.0 licensed

**Status**: Active

**Stats**: Google DeepMind

**Last Updated**: 2026-05

**Building block(s)**: [Simulation Engines](building-blocks.md#simulation-engines), [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline)

**Maturity**: Early OSS

**Competes with**: Isaac Lab, Genesis World

**Complements**: MuJoCo, Newton (MuJoCo Warp backend), LeRobot

**Openness assessment**: (to be assessed by oss-health skill)

#### CARLA: Open-Source Autonomous Driving Simulator

**URL**: [github.com/carla-simulator/carla](https://github.com/carla-simulator/carla)

**Description**: Open-source simulator for autonomous driving research and development. Provides urban environments, vehicle models, and flexible sensor suites for training and validating AD stacks. Migrated to Unreal Engine 5.5; 150K+ developer community. Founded on Dosovitskiy et al. (CoRL 2017).

**Tech Stack**: C++ (79%), Python (14%), Unreal Engine 5.5 (ue5-dev) / UE 4.26 (ue4-dev), CMake/Ninja

**Dependencies**:

| Layer            | Engine            | Acceleration         |
| ---------------- | ----------------- | -------------------- |
| Physics backend  | PhysX (via UE)    | CPU, GPU             |
| Rendering engine | Unreal Engine 5.5 | RTX, DirectX, Vulkan |

**Key Features**:

- Flexible sensor suite: cameras, LiDAR, radar, GNSS, IMU — configurable via Python API
- Open digital assets (cities, buildings, vehicles) under CC-BY
- Native ROS 2 integration (`-DENABLE_ROS2=ON`); separate [ROS-bridge](https://github.com/carla-simulator/ros-bridge)
- Scenario Runner and Leaderboard for reproducible AD benchmarking
- AutoWare and MathWorks RoadRunner interop
- UE 5.5 migration brings Nanite, Lumen, and modern rendering pipeline

**Status**: Active

**Stats**: 14.2K stars, 4.6K forks, 6.7K+ commits, 28 releases

**Last Updated**: 2026-07

**Building block(s)**: [Simulation Engines](building-blocks.md#simulation-engines)

**Maturity**: Production-ready

**Competes with**: Isaac Sim (higher fidelity, NVIDIA-locked), Gazebo (robotics-first, lighter weight), LGSVL (archived), NVIDIA DRIVE Sim (proprietary)
**Complements**: ROS 2 (via ROS-bridge), AutoWare (AD stack), OpenDRIVE/OpenSCENARIO standards

**Openness assessment**:

| Dimension              | Rating       | Detail                                                                |
| ---------------------- | ------------ | --------------------------------------------------------------------- |
| License                | Permissive   | MIT (code), CC-BY (assets); UE 5.5 has separate license terms         |
| Governance             | Multi-vendor | carla-simulator org; originated from CVC/Intel Labs research          |
| Contributor diversity  | High         | 14.2K stars, 4.6K forks; broad academic + industry contributor base   |
| Community health       | Active       | v0.9.16 (Sep 2025); active UE5 migration; 150K+ developer community   |
| Corporate control risk | Medium       | Unreal Engine dependency introduces Epic Games coupling               |

### Physics Engines

*Dynamics backends that simulation platforms build on. Ownership and acceleration support here determine platform lock-in risk upstream.*

#### MuJoCo: Multi-Joint Dynamics with Contact

**URL**: [github.com/google-deepmind/mujoco](https://github.com/google-deepmind/mujoco)

**Description**: The most widely used physics engine for robotics research. Originally developed by Emo Todorov, acquired by Google DeepMind and open-sourced (2022). Accurate contact physics for grasping and dexterous manipulation. MJX provides GPU-accelerated parallel simulation via JAX. Over 3,800 citations.

**Tech Stack**: C, Python bindings, MJX (JAX/XLA for GPU)

**Acceleration**: CPU (native), CUDA/TPU (via MJX/JAX)

**Key Features**:

- Most accurate contact physics for grasping and dexterous manipulation
- MJX: GPU-accelerated via JAX — enables thousands of parallel environments
- Convex collision geometries (non-convex requires V-HACD decomposition)
- Native Python bindings, Gymnasium integration
- Apache 2.0 licensed

**Status**: Active

**Stats**: ~9K stars (Google DeepMind)

**Last Updated**: 2026-06

**Used by**: MuJoCo Playground, Newton (MuJoCo Warp), MolmoSpaces, Robosuite, LIBERO, stable-worldmodel, many research projects

**Category**: OSS (single-vendor) — Google DeepMind controls roadmap

**Openness assessment**: (to be assessed by oss-health skill)

#### PhysX 5: GPU-Accelerated Multi-Physics SDK

**URL**: [github.com/NVIDIA-Omniverse/PhysX](https://github.com/NVIDIA-Omniverse/PhysX)

**Description**: NVIDIA's multi-physics SDK. Originally a game physics engine, now the primary physics backend for Omniverse, Isaac Sim, and SAPIEN/ManiSkill. Full GPU source code (500+ CUDA kernels) open-sourced under BSD-3 in April 2025. Supports rigid bodies, soft bodies, fluids, cloth, and inflatables.

**Tech Stack**: C++, CUDA

**Acceleration**: CUDA (GPU), CPU fallback

**Key Features**:

- GPU articulation solver (Featherstone) enabling 4,096+ parallel robot instances
- Soft body dynamics (FEM), cloth, fluids, inflatables (inherited from NVIDIA Flex)
- Signed distance field (SDF) collision for complex meshes
- Full GPU kernel source now open (BSD-3) — theoretically portable to non-NVIDIA hardware, but 500+ CUDA kernels make this impractical
- BSD-3 license

**Status**: Active

**Stats**: ~3.6K stars (NVIDIA)

**Last Updated**: 2026-05 (PhysX 5.6)

**Used by**: Isaac Sim, Isaac Lab, SAPIEN/ManiSkill, Omniverse, Unity (legacy)

**Category**: OSS (single-vendor) — NVIDIA controls roadmap; CUDA lock-in despite open source

**Openness assessment**: (to be assessed by oss-health skill)

#### Bullet / PyBullet: Lightweight Physics Engine

**URL**: [github.com/bulletphysics/bullet3](https://github.com/bulletphysics/bullet3)

**Description**: Lightweight open-source physics engine with Python bindings (PyBullet). Historically important in RL research but declining in usage — no GPU acceleration, no ROS 2 bridge, no photorealistic rendering. Included here because it remains a dependency for some legacy benchmarks and datasets.

**Tech Stack**: C++, Python (PyBullet)

**Acceleration**: CPU only

**Key Features**:

- Rigid body, soft body, and constraint-based dynamics
- PyBullet: simple Python API popular for RL prototyping
- Headless mode for server-side training
- zlib license

**Status**: Maintained (declining)

**Stats**: ~12.5K stars (historical accumulation)

**Last Updated**: 2025 (sporadic commits)

**Used by**: Legacy RL environments, some robotics benchmarks

**Category**: OSS (community-driven) — no single vendor, but also limited active development

### Rendering Engines

*Visual backends that determine photorealism, sensor simulation fidelity, and synthetic data quality. Key differentiator for sim-to-real transfer.*

#### OptiX / RTX Rendering (NVIDIA)

**URL**: [developer.nvidia.com/rtx/ray-tracing/optix](https://developer.nvidia.com/rtx/ray-tracing/optix)

**Description**: NVIDIA's GPU ray tracing engine powering photorealistic rendering in Isaac Sim and Omniverse. Uses RTX hardware acceleration (RT cores) for real-time ray tracing. OptiX is the API layer; RTX is the hardware acceleration technology. Produces the highest-fidelity synthetic sensor data (cameras, LiDAR) but is completely NVIDIA-locked.

**Acceleration**: CUDA + RT cores (NVIDIA RTX GPUs only)

**Key Features**:

- Hardware-accelerated ray tracing via RT cores
- Photorealistic sensor simulation (cameras, depth, LiDAR)
- Replicator integration for domain randomization and synthetic data generation
- Denoising AI for real-time noise-free rendering

**Used by**: Isaac Sim, Omniverse, Gazebo (optional backend via gz-rendering)

**Category**: Proprietary — free to use on NVIDIA hardware, closed source

**Lock-in risk**: High — hardware-locked to NVIDIA RTX GPUs; no alternative implementation

#### Nyx Renderer (Genesis AI)

**URL**: Part of [Genesis World](https://github.com/Genesis-Embodied-AI/genesis-world)

**Description**: Real-time path-traced renderer developed as part of the Genesis World platform. Achieves noise-free 1080p in <4 ms with 45% smaller reality gap (FID) than the next-best simulator renderer. Cross-platform via Quadrants compiler — not locked to NVIDIA hardware.

**Acceleration**: CUDA, Vulkan, Metal (via Quadrants compiler)

**Key Features**:

- Path-traced rendering — physically accurate lighting and reflections
- <4 ms per frame at 1080p (noise-free)
- 45% smaller reality gap (FID) vs. next-best simulator
- Cross-platform: CUDA, Vulkan, Metal — hardware-portable

**Used by**: Genesis World

**Category**: OSS (single-vendor) — Genesis AI; part of Genesis World codebase, Apache 2.0

**Lock-in risk**: Low — multi-backend support via Quadrants

#### OGRE-Next: Open-Source Rendering Backend

**URL**: [github.com/OGRECave/ogre-next](https://github.com/OGRECave/ogre-next)

**Description**: Modular C++ rendering engine, the primary visual backend for Gazebo. OGRE-Next (formerly OGRE 2.x) supports Vulkan, Direct3D, and OpenGL. Version 3.0 "Eris" released 2025; version 4.0 in development with multithreaded shader compilation. Functional for robotics but lacks the photorealism of path-traced renderers (OptiX, Nyx), creating a fidelity gap for sim-to-real transfer of vision-based policies.

**Acceleration**: Vulkan, OpenGL, Direct3D (CPU rasterization fallback)

**Key Features**:

- Multi-backend: Vulkan, OpenGL, Direct3D
- Rasterization-based (not path-traced) — fast but lower photorealism
- v4.0: multithreaded shader compilation (Vulkan, Metal), advanced particle systems
- MIT license

**Used by**: Gazebo (primary renderer)

**Category**: OSS (community-driven) — independent project, MIT license

**Lock-in risk**: Low (open, multi-platform) — but photorealism gap is a **technical risk** for sim-to-real transfer of vision-based policies

#### Filament: Mobile-First PBR Renderer

**URL**: [github.com/google/filament](https://github.com/google/filament)

**Description**: Google's physically-based rendering engine targeting mobile and embedded platforms. Supports OpenGL ES 3.0+, Vulkan, Metal, and WebGL2. Smallest footprint of the tracked renderers — designed for Android/iOS first, now also used in automotive (Toyota Fluorite engine). Not currently used by any major robotics simulator but relevant as a lightweight rendering option for edge/embedded robot visualization.

**Acceleration**: Vulkan, OpenGL ES, Metal, WebGL2

**Key Features**:

- Physically-based rendering (PBR) with accurate lighting
- Minimal footprint — designed for mobile/embedded
- Runtime material compiler (GLSL/SPIR-V)
- Toyota Fluorite engine adoption (FOSDEM 2026) for automotive HMI
- Apache 2.0 licensed

**Used by**: Android AR, Toyota Fluorite (automotive), web 3D viewers

**Category**: OSS (single-vendor) — Google controls roadmap

**Lock-in risk**: Low — multi-platform, Apache 2.0; but no robotics simulator integration yet

---

## Evaluation & Benchmarking

*Frameworks and benchmark suites for evaluating robot policies, world models, and simulation quality. An emerging platform capability — standardized evaluation is becoming as critical as training infrastructure.*

### Isaac Lab-Arena: Scalable Robot Policy Evaluation in Sim

**URL**: [developer.nvidia.com/blog/simplify-generalist-robot-policy-evaluation-in-simulation-with-nvidia-isaac-lab-arena/](https://developer.nvidia.com/blog/simplify-generalist-robot-policy-evaluation-in-simulation-with-nvidia-isaac-lab-arena/)

**Description**: NVIDIA's open-source framework for scalable robot policy evaluation in simulation, built as an extension to Isaac Lab. Integrated with HuggingFace LeRobot Environment Hub. 250+ tasks available via Lightwheel co-developed suites (RoboCasa-Tasks, LIBERO-Tasks). Becoming the de facto sim eval layer for GR00T, pi0, and SmolVLA.

**Tech Stack**: Python, Isaac Lab, PhysX 5, CUDA

**Key Features**:

- 250+ evaluation tasks via Lightwheel-RoboCasa-Tasks and Lightwheel-LIBERO-Tasks
- LeRobot Environment Hub integration — register custom environments, share via HuggingFace
- Supports evaluation of GR00T N, pi0, SmolVLA policies
- Sim-to-real validated evaluation methods and datasets
- Open source

**Status**: Active

**Stats**: NVIDIA + Lightwheel

**Last Updated**: 2026-06

**Building block(s)**: [Evaluation & Benchmarking](building-blocks.md#evaluation--benchmarking), [Simulation Engines](building-blocks.md#simulation-engines)

**Maturity**: Early OSS

**Competes with**: RoboVerse, MolmoSpaces-Bench

**Complements**: LeRobot eval harness, Isaac Lab, LIBERO, RoboCasa

**Openness assessment**: (to be assessed by oss-health skill)

### RoboArena: Distributed Real-World Robot Policy Evaluation

**URL**: [github.com/robo-arena/roboarena](https://github.com/robo-arena/roboarena)

**Description**: Framework for crowd-sourced real-world evaluation of generalist robot policies. Instead of standardizing on fixed tasks, evaluators freely choose tasks and environments but perform double-blind pairwise comparisons — producing ELO-style rankings for VLA/WAM policies. Built on the DROID platform. Published at CoRL 2025.

**Tech Stack**: Python, DROID hardware platform

**Key Features**:

- Real-world evaluation (not sim) — captures deployment-relevant failure modes
- Double-blind pairwise comparison methodology
- ELO-style leaderboard for generalist robot policies
- Distributed evaluator network — scales diversity without fixed infrastructure
- Integrates with openpi for policy training

**Status**: Active

**Stats**: (early-stage, CoRL 2025 publication)

**Last Updated**: 2026-06

**Building block(s)**: [Evaluation & Benchmarking](building-blocks.md#evaluation--benchmarking)

**Maturity**: Research

**Competes with**: MolmoSpaces-Bench (sim-based), Isaac Lab-Arena (sim-based)

**Complements**: OpenPI, DROID dataset, LeRobot

**Openness assessment**: (to be assessed by oss-health skill)

### LeRobot Eval Harness: Unified Robot Policy Evaluation CLI

**URL**: [github.com/huggingface/lerobot](https://github.com/huggingface/lerobot) (eval module)

**Description**: HuggingFace's unified `lerobot-eval` CLI for evaluating robot policies across benchmarks. Standard Gymnasium interface wrapping third-party simulators (LIBERO, Meta-World, RoboTwin 2.0, Isaac Lab-Arena) behind a common `gym.Env` API. Becoming the integration layer between benchmarks and policies — the "pytest for robot policies."

**Tech Stack**: Python, PyTorch, Gymnasium

**Key Features**:

- Unified `lerobot-eval` CLI across all supported benchmarks
- Standardized metrics: `pc_success`, `avg_sum_reward`, `avg_max_reward`
- Hierarchical aggregation: episode → task → suite → overall
- Supported benchmarks: LIBERO, Meta-World, RoboTwin 2.0, Isaac Lab-Arena
- Supported policies: ACT, Diffusion, VQ-BeT, TDMPC, pi0-FAST, pi0.5, GR00T N1.5, SmolVLA, XVLA
- Apache 2.0 licensed

**Status**: Active

**Stats**: Part of LeRobot (23.5K stars)

**Last Updated**: 2026-06

**Building block(s)**: [Evaluation & Benchmarking](building-blocks.md#evaluation--benchmarking), [Model Serving for Physical AI](building-blocks.md#model-serving-for-physical-ai)

**Maturity**: Early OSS

**Competes with**: Custom per-benchmark eval scripts

**Complements**: Isaac Lab-Arena, MolmoSpaces, LIBERO, OpenPI, GR00T

**Openness assessment**: Part of LeRobot — (to be assessed by oss-health skill)

### RoboVerse: Unified Cross-Benchmark Evaluation Platform

**URL**: [roboverse.wiki](https://roboverse.wiki/)

**Description**: Unified platform, dataset, and benchmark for scalable robot learning across previously fragmented evaluation ecosystems. Supports ManiSkill, RLBench, CALVIN, Meta-World, Robosuite, LIBERO, SimplerEnv, and others under a common evaluation interface. Enables cross-benchmark comparison of policies — a direct response to the fragmentation problem in robotics evaluation.

**Tech Stack**: Python, multiple simulator backends

**Key Features**:

- Cross-benchmark evaluation: test one policy across LIBERO, RLBench, Robosuite, etc.
- Unified data format and task specification across simulators
- Addresses reproducibility issues from simulator-specific rendering and physics differences
- Multi-institutional (SJTU, Tsinghua, UC Berkeley, etc.)

**Status**: Active

**Last Updated**: 2026-03

**Building block(s)**: [Evaluation & Benchmarking](building-blocks.md#evaluation--benchmarking)

**Maturity**: Research

**Competes with**: LeRobot eval harness (different approach — RoboVerse unifies simulators, LeRobot unifies the eval API)

**Complements**: All supported benchmarks (LIBERO, RLBench, CALVIN, etc.)

**Openness assessment**: (to be assessed by oss-health skill)

### RLBench: Large-Scale Robot Learning Benchmark

**URL**: [github.com/stepjam/RLBench](https://github.com/stepjam/RLBench)

**Description**: 80 task categories for robot manipulation learning built on CoppeliaSim/PyRep. Widely used for evaluating VLA models (BridgeVLA at 88.2%, InternVLA at 95%+ on subsets). Mature benchmark but coupled to CoppeliaSim — increasingly accessed through RoboVerse rather than directly.

**Tech Stack**: Python, CoppeliaSim, PyRep

**Key Features**:

- 80 diverse manipulation task categories
- ~150K demonstration trajectories
- Franka Emika Panda arm in single-scene setup
- Widely cited in VLA evaluation literature

**Status**: Maintained

**Stats**: ~2.6K stars (Imperial College London)

**Last Updated**: 2025

**Building block(s)**: [Evaluation & Benchmarking](building-blocks.md#evaluation--benchmarking)

**Maturity**: Production-ready

**Competes with**: LIBERO, MolmoSpaces-Bench, Robosuite

**Complements**: RoboVerse (as backend), CoppeliaSim

**Openness assessment**: Coupled to CoppeliaSim (source-available, $3K+ commercial); being accessed via RoboVerse as intermediary

### Robosuite: MuJoCo-Based Simulation Framework for Robot Learning

**URL**: [github.com/ARISE-Initiative/robosuite](https://github.com/ARISE-Initiative/robosuite)

**Description**: Modular simulation framework for robot learning built on MuJoCo. Provides standardized manipulation tasks with 10 robot models, domain randomization, and teleoperation interfaces. Foundation for the LIBERO benchmark. Active community with regular releases.

**Tech Stack**: Python, MuJoCo

**Key Features**:

- 10 robots out of the box (Franka, Sawyer, IIWA, UR5e, etc.)
- Modular task design with configurable environments
- Domain randomization and procedural generation
- Teleoperation interfaces for demonstration collection
- Foundation for LIBERO benchmark
- MIT licensed

**Status**: Active

**Stats**: ~1.8K stars (Stanford ARISE Initiative)

**Last Updated**: 2026-03

**Building block(s)**: [Evaluation & Benchmarking](building-blocks.md#evaluation--benchmarking), [Simulation Engines](building-blocks.md#simulation-engines)

**Maturity**: Production-ready

**Competes with**: ManiSkill, RLBench

**Complements**: MuJoCo, LIBERO, RoboVerse

**Openness assessment**: (to be assessed by oss-health skill)

### LIBERO: Lifelong Robot Learning Benchmark

**URL**: [github.com/Lifelong-Robot-Learning/LIBERO](https://github.com/Lifelong-Robot-Learning/LIBERO)

**Description**: Benchmark suite for lifelong robot learning and knowledge transfer, built on Robosuite/MuJoCo. 130 manipulation tasks across four suites (LIBERO-Spatial, LIBERO-Object, LIBERO-Goal, LIBERO-100) with controlled distribution shifts testing declarative vs. procedural knowledge transfer. The most commonly reported benchmark for VLA evaluation — pi0.5, GR00T, OpenVLA, and LingBot-VA all cite LIBERO scores. NeurIPS 2023 Dataset & Benchmark Track.

**Tech Stack**: Python, Robosuite, MuJoCo

**Key Features**:

- 130 tasks across 4 suites with controlled knowledge transfer requirements
- ~50 demonstrations per task
- Procedural generation pipeline for unlimited task variants
- LIBERO-100: 100 entangled-knowledge tasks (LIBERO-90 pretrain + LIBERO-10 test)
- HuggingFace fork (lerobot-libero) for LeRobot integration
- MIT licensed

**Validity concerns**: A June 2026 audit ("[What Are We Actually Benchmarking?](https://arxiv.org/abs/2606.04233)") found LIBERO fails multiple diagnostics — a 0.09B probe with no language encoder scores near reported SOTA, and models collapse from ~98% to 0-40% under moderate perturbations. Most reported gains are not statistically significant. Despite these issues, LIBERO remains the de facto VLA evaluation standard.

**Status**: Active

**Stats**: ~900 stars (UT Austin, Sony AI)

**Last Updated**: 2026-05

**Building block(s)**: [Evaluation & Benchmarking](building-blocks.md#evaluation--benchmarking)

**Maturity**: Production-ready

**Competes with**: MolmoSpaces-Bench, RLBench, CALVIN

**Complements**: Robosuite, MuJoCo, LeRobot eval harness, RoboVerse

**Openness assessment**: (to be assessed by oss-health skill)

---

## Model Serving for Physical AI

*Inference engines, serving frameworks, and APIs for deploying world models and robot policies.*

### vLLM-Omni: Omni-Modality Model Serving

**URL**: [github.com/vllm-project/vllm-omni](https://github.com/vllm-project/vllm-omni)

**Description**: Extension of vLLM for omni-modality model inference and serving, supporting text, image, video, and audio I/O plus non-autoregressive architectures including Diffusion Transformers (DiT). Reduces job completion time by up to 91.4% vs baselines. Active RFC (#1987) for world model support targeting robotics (DreamZero, Pi0, OpenVLA, GR00T) and interactive video (Genie 3, LingBot-World, Matrix Game) with stateful multi-turn sessions and action I/O.

**Tech Stack**: Python, PyTorch, CUDA, vLLM core

**Key Features**:

- Omni-modality: text, image, video, audio I/O
- Diffusion Transformer (DiT) support for parallel generation
- Disaggregated stage execution for any-to-any model architectures
- 91.4% reduction in job completion time vs baselines
- World Model RFC: targeting OpenPI-style WebSocket API and LeRobot gRPC API as standard robotics interfaces
- Apache 2.0 licensed

**Status**: Active

**Stats**: 4,439 stars, 819 forks (vLLM Project)

**Last Updated**: 2026-04

**Building block(s)**: [Model Serving for Physical AI](building-blocks.md#model-serving-for-physical-ai)

**Maturity**: Production-ready

**Competes with**: TensorRT-LLM, TorchServe

**Complements**: OpenPI, Isaac-GR00T, DreamZero, LeRobot

**Openness assessment**: (to be assessed by oss-health skill)

### LeRobot: End-to-End Learning for Robotics

**URL**: [github.com/huggingface/lerobot](https://github.com/huggingface/lerobot)

**Description**: HuggingFace's framework for making AI for robotics more accessible with end-to-end learning. Provides models, datasets, and tools including a gRPC-based PolicyServer/RobotClient architecture for distributed inference. Supports imitation learning (ACT, Diffusion, VQ-BeT), RL (gaussian_actor), and VLA/WAM models (π0-FAST, π0.5, GR00T N1.7, SmolVLA, VLA-JEPA, EVO1, MolmoAct2, FastWAM, LingBot-VA). v0.6.0 (July 2026) adds 6 new policy types, 6 new benchmarks, 2x faster dataloading, FSDP checkpointing, depth map support, reward models (SARM), and a rebuilt RL stack.

**Tech Stack**: Python, PyTorch, gRPC, HuggingFace Hub

**Key Features**:

- PolicyServer/RobotClient gRPC architecture (~5x faster than REST)
- Asynchronous inference: robot acts while next chunk computes (~2x task completion speedup)
- v0.6.0 policies: ACT, Diffusion, VQ-BeT, TDMPC, π0-FAST, π0.5, GR00T N1.7, SmolVLA, VLA-JEPA, EVO1, MolmoAct2, FastWAM, LingBot-VA
- v0.6.0 benchmarks: RoboCasa365, RoboTwin 2.0, RoboCerebra, RoboMME, LIBERO-plus, VLABench (plus third-party env plugin discovery via entry points)
- 2x faster dataloader via parallel decode, uint8 transport, and persistent workers
- Depth map support with depth unit metadata; language annotation pipeline
- FSDP checkpoint saving; inline offline validation with train/eval split
- Reward models (SARM): TOPReward, ROBOMETER with zero-shot configs
- `lerobot-rollout` CLI decouples policy deployment from data recording
- Rebuilt RL stack: modular `gaussian_actor` API replacing legacy `sac`
- Remote training on HF Jobs via `--job.target`; Foxglove visualization support
- Supported hardware: SO100, SO101, LeKiwi, Koch, HopeJR, OMX, EarthRover, Reachy2, Gamepads, Keyboards, Phones, OpenARM, Unitree G1, reBot B601
- Dataset ecosystem on HuggingFace Hub; libaom-av1 codec support
- vLLM-Omni targeting LeRobot API compatibility

**Status**: Active

**Stats**: 23,488 stars, 4,328 forks (HuggingFace)

**Last Updated**: 2026-07 (v0.6.0)

**Building block(s)**: [Model Serving for Physical AI](building-blocks.md#model-serving-for-physical-ai), [Evaluation & Benchmarking](building-blocks.md#evaluation--benchmarking)

**Maturity**: Production-ready

**Competes with**: ROS1/ROS2 action servers, custom robot control stacks

**Complements**: OpenPI, Isaac-GR00T, vLLM-Omni

**Openness assessment**: (to be assessed by oss-health skill)

---

## Biologically-Inspired Architectures

*Research projects exploring brain-inspired architectures. These don't map directly to a single building block but are tracked as research references.*

### Baby Dragon Hatchling (BDH)

**URL**: [github.com/pathwaycom/bdh](https://github.com/pathwaycom/bdh)

**Description**: Biologically-inspired LLM architecture based on a scale-free network of locally-interacting neuron particles with Hebbian learning. Bridges deep learning and neuroscience while matching GPT-2 performance at 10M–1B parameters.

**Tech Stack**: Python, PyTorch

**Key Features**:

- Scale-free network topology with excitatory/inhibitory neuron dynamics
- Hebbian working memory via synaptic plasticity with monosemantic properties
- GPU-optimized state-space formulation
- Sparse, positive, interpretable activations
- Active community: MLX port, Burn framework port, dynamic vocabulary extensions

**Status**: Active

**Stats**: 3,400+ stars, 211 forks, 5 contributors (Pathway)

**Last Updated**: 2025-09

**Building block(s)**: Research reference — doesn't map to single building block

**Maturity**: Research

**Competes with**: Traditional transformer architectures

**Complements**: Neuroscience-informed AI research, interpretability tools

**Openness assessment**: (to be assessed by oss-health skill)

---

## EBM Libraries & Frameworks

*Energy-based model tools relevant to latent world models and self-supervised learning.*

(No current entries — section reserved for future EBM-specific tools)

---

## Data Infrastructure

*Tools for logging, storing, visualizing, and querying multimodal sensor data from robots, vehicles, and physical AI systems.*

### Rerun: The Data Layer for Physical AI

**URL**: [github.com/rerun-io/rerun](https://github.com/rerun-io/rerun)

**Description**: Open-source SDK for logging, storing, querying, and visualizing multi-rate, multimodal Physical AI data. Column-chunk .rrd storage format optimized for temporal data with multi-rate sensors. Built-in viewer runs native (desktop) and in-browser (WebAssembly). Positioned as "the missing data infrastructure" between robotics hardware and ML training pipelines.

**Tech Stack**: Rust (83.6%), Python (12.3%), C++ (2.5%), egui (immediate-mode GUI), wgpu (WebGPU/WebGL2 renderer), Apache Arrow (columnar data)

**Key Features**:

- SDKs in Python, Rust, and C++ for logging images, point clouds, transforms, time series, joint states, video
- Column-chunk .rrd storage with 20-30x time-series speedup over naive approaches
- Synchronized multi-view visualization with timeline scrubbing and sensor comparison
- Dataframe and SQL query APIs; reads MCAP, LeRobot, and .rrd formats
- Blueprint APIs for programmatic layout control; plugin system for custom file types and views
- WebAssembly browser viewer (no install required for review/sharing)
- GPU-direct dataloader via commercial Rerun Hub (PyTorch integration, codec-aware streaming)

**Status**: Active
**Category**: `OSS (single-vendor)` — Rerun Technologies AB controls development; Hub is proprietary
**License**: Apache-2.0 + MIT (dual license)
**Stars**: 11,000 | **Forks**: 781 | **Recent Contributors**: ~78 (mostly Rerun employees)
**Last Updated**: 2026-06-22 (v0.33.1; 78 total releases)

**Building block mapping**: [Sensor Data Ingestion](building-blocks.md#sensor-data-ingestion), [Robot Fleet Management & Observability](building-blocks.md#robot-fleet-management--observability)

**Notable integrations**: LeRobot (Hugging Face), NVIDIA PyCuVSLAM, Meta Reality Labs (Project Aria), Google DeepMind (Brush), Unitree

**Sibling projects**: egui (24K+ stars, MIT, Rust GUI framework — created by Rerun CTO), egui_tiles (543 stars, tiling layout engine), ewebsock (296 stars, Rust WebSocket client)

---

## Datasets & Benchmarks

*Training datasets, evaluation benchmarks, and data collection tools for world models and robot policies.*

### MolmoSpaces

**URL**: [github.com/allenai/molmospaces](https://github.com/allenai/molmospaces)

**Description**: Large-scale open ecosystem for benchmarking robot navigation and manipulation policies. Provides 230k+ indoor environments, 130k annotated objects (48k manipulable with 42M stable grasps), and an 8-task benchmark suite. Simulator-agnostic across MuJoCo, Isaac Sim, and ManiSkill.

**Tech Stack**: Python, MuJoCo, NVIDIA Isaac Sim, ManiSkill, PyTorch, cuRobo, Open3D

**Key Features**:

- 230k+ environments (handcrafted iTHOR, procedural ProcTHOR, LLM-generated Holodeck)
- 130k annotated object assets with 42M precomputed stable grasps
- MolmoSpaces-Bench: 8-task suite (pick, open, close, etc.) for standardized evaluation
- Sim-to-real correlation R = 0.96, ρ = 0.98
- Scripted data generation pipelines, grasp generation, iPhone teleoperation (TeleDex)
- Supports Franka FR3 and Rainbow Robotics RB-Y1 robots

**Status**: Active

**Stats**: 347 stars, 45 forks; Allen Institute for AI (Ai2)

**Last Updated**: 2026-05 (v0.1.0)

**Building block(s)**: [Datasets & Benchmarks](building-blocks.md#data-annotation--curation-for-physical-ai)

**Maturity**: Early OSS

**Competes with**: Other robot manipulation benchmarks (RLBench, Robosuite)

**Complements**: Simulation engines (Genesis, Isaac Sim, ManiSkill)

**Openness assessment**: (to be assessed by oss-health skill)

---

## Reference Resources

*Curated lists, surveys, and reference collections for world models research.*

### Awesome-World-Models: Curated Survey Companion

**URL**: [github.com/JiahuaDong/Awesome-World-Models](https://github.com/JiahuaDong/Awesome-World-Models)

**Description**: Curated list of world model research, companion to the survey "Learning to Model the World: A Survey of World Models in Artificial Intelligence" (TechRxiv, 2026-03). Covers observation-level generative, latent space, RL-based, and object-centric world models across robotics, autonomous driving, scientific discovery, and game simulation.

**Tech Stack**: Markdown (curated list)

**Key Features**:

- Organized by application domain and methodology
- Companion to comprehensive ACM CSUR 2025 survey
- Regularly updated with new papers and resources

**Status**: Active

**Stats**: 165 stars, 3 forks, 3 contributors

**Last Updated**: 2026-03

**Building block(s)**: Reference resource — no specific building block

**Maturity**: Research

**Competes with**: Other world model curated lists

**Complements**: Research literature, academic surveys

**Openness assessment**: (to be assessed by oss-health skill)

### Awesome-World-Model-for-Robotics-Policy: Robot Learning Survey Companion

**URL**: [github.com/NTUMARS/Awesome-World-Model-for-Robotics-Policy](https://github.com/NTUMARS/Awesome-World-Model-for-Robotics-Policy)

**Description**: Curated list of world model research for robotic policy learning, companion to the survey "World Model for Robot Learning: A Comprehensive Survey" (arXiv:2605.00080). Policy-centric taxonomy covering world models as policies (IDM-style, single-backbone, MoE/MoT, unified VLA, latent-space), as simulators (for RL, evaluation), and for video generation.

**Tech Stack**: Markdown (curated list)

**Key Features**:

- Policy-centric organization: categorizes by how world models integrate with robot policies
- Covers 100+ papers with links to arXiv, code, project pages, and HuggingFace resources
- Tracks latest entries including GigaBrain, X-WAM, Cortex 2.0, Persistent Robot World Models
- Multi-institutional authorship: NTU, UC Berkeley, Stanford, U. Tokyo, Oxford, ETH Zurich, Princeton, Harvard

**Status**: Active

**Stats**: 581 stars, 10 forks, 33 commits

**Last Updated**: 2026-05

**Building block(s)**: Reference resource — no specific building block

**Maturity**: Research

**Competes with**: Other robotics literature collections

**Complements**: Academic research, robotics surveys

**Openness assessment**: (to be assessed by oss-health skill)

### Cosmos-Cookbook: Post-Training Recipes & Workflows

**URL**: [github.com/nvidia-cosmos/cosmos-cookbook](https://github.com/nvidia-cosmos/cosmos-cookbook)

**Description**: Community-driven collection of post-training scripts, proven workflows, and domain-specific adaptations for the NVIDIA Cosmos ecosystem. Includes recipes for robot policy training, action-conditioned model distillation, and fine-tuning Cosmos models for specific Physical AI domains.

**Tech Stack**: Python, PyTorch, NeMo Framework, Jupyter notebooks

**Key Features**:

- Post-training recipes for robot policy models (RoboCasa, Libero)
- Action-conditioned distillation guides for Predict2.5
- Domain-specific adaptation workflows for AV and robotics
- Community contribution framework for sharing Physical AI workflows

**Status**: Active

**Stats**: 286 stars, 68 forks, 7 contributors (NVIDIA + community)

**Last Updated**: 2026-02

**Building block(s)**: [Post-Training & Fine-Tuning Pipeline](building-blocks.md#post-training--fine-tuning-pipeline)

**Maturity**: Early OSS

**Competes with**: Custom post-training pipelines

**Complements**: Cosmos ecosystem (Predict2.5, Reason2, RL)

**Openness assessment**: (to be assessed by oss-health skill)

---

**Note**: Openness assessments (corporate control, license restrictions, build-from-source viability) to be performed by future `oss-health` skill.
