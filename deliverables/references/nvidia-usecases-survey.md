# NVIDIA Use Cases & Solution Guides Survey

**Date**: 2026-06-25
**Purpose**: Use-case-down analysis of NVIDIA's Physical AI workflows — extracting end-to-end pipeline stages, data flows, and component dependencies from their solution documentation.

---

## 1. Video Analytics / Metropolis Platform (Most Mature)

### Use Case: Vision AI agents for smart cities, manufacturing, retail

### End-to-End Workflow

**Stage 1: Data Collection & Preparation**

- Input: Live/recorded video streams, existing CV pipeline outputs
- Synthetic data generation via Cosmos skills (defect images, video augmentation with weather/lighting variations)
- Data curation via **Cosmos Curator** (processing, refinement, annotation)

**Stage 2: Model Selection & Fine-Tuning**

- Foundation models: **Cosmos 3**, **Cosmos Embed**, **C-RADIO**, **NV-CLIP**, **NV-DINOv2**
- Fine-tuning via **TAO agent skills** (autonomous iteration toward accuracy targets)
- Self-supervised learning (SSL) domain adaptation using unlabeled domain images
- Supervised fine-tuning (SFT) with annotated task-specific data
- Knowledge distillation to compress models for edge deployment

**Stage 3: Agent Construction**

- **Metropolis VSS (Video Search & Summarization) Blueprint** provides reference architecture
- Components: VLMs for visual understanding, LLMs for reasoning, RAG for contextual search, embedding-based fusion search, report generation
- VSS skills enable agent building with natural language prompts

**Stage 4: Inference & Processing**

- **NIM microservices** provide optimized inference with industry-standard APIs
- **DeepStream SDK** (v8) for real-time streaming analytics (GStreamer-based pipeline)
- **DeepStream Inference Builder**: Low-code tool generating containerized microservices from YAML config
- Supports both streaming (real-time event detection) and batch (archived video search/summarization)

**Stage 5: Deployment**

- Edge: **Jetson Orin**, **Jetson Thor** (up to 2070 FP4 TFLOPS), **IGX Platform**
- Workstation: **RTX PRO 6000 Blackwell**, **DGX Spark** (GB10 Superchip, 128GB memory)
- Cloud: NIM microservices on Azure, Nebius, CoreWeave

### Data Types

Video streams, RGB images, depth data, embeddings, annotations, event metadata

### Batch vs Streaming

- **Streaming**: Real-time event detection, alerting
- **Batch**: Archived video search, summarization, report generation

### Customer Examples

- Kaohsiung City — traffic optimization (Linker Vision partnership)
- City of Raleigh — 95% vehicle detection accuracy for traffic analysis
- Factories, warehouses, retail stores, airports, traffic intersections

### Reference Architectures

- Metropolis VSS Blueprint (smart city and warehouse examples)
- metropolis-nim-workflows on GitHub
- VSS Skills in NVIDIA/skills repo

---

## 2. Industrial Inspection / Manufacturing

### Use Case: Automated visual inspection, defect detection, quality control

### End-to-End Workflow

**Stage 1: Domain Adaptation (Unlabeled Data)**

- Input: Large corpus of unlabeled domain images (e.g., ~700K PCB images)
- Tool: **TAO 6** with **NV-DINOv2** or **C-RADIOv2** backbone
- Process: Self-supervised learning adapts general visual features to domain-specific features
- Output: Domain-adapted backbone checkpoint

**Stage 2: Supervised Fine-Tuning**

- Input: Smaller annotated dataset (e.g., ~600 training samples with OK/Defect labels)
- Process: Linear probing + full fine-tuning (backbone + task head)
- Architecture: **RT-DETR** (Real-Time Detection Transformer) with swappable backbones
- Output: Fine-tuned task-specific model

**Stage 3: Knowledge Distillation**

- Input: Large teacher model + training data (e.g., 9,602 COCO-format training images)
- Process: Student learns backbone representations, logits, spatial features from teacher
- Result: 81% model size reduction, 5% accuracy gain (ResNet50→ResNet18), 3% gain (ConvNeXt→ResNet34)
- Output: Compressed student model for edge deployment

**Stage 4: Deployment via DeepStream**

- Tool: **DeepStream 8 Inference Builder**
- Input: config.yaml + Dockerfile + optional OpenAPI spec
- Output: Packaged microservice (.tgz) with GPU-accelerated preprocessing, inference, post-processing
- Deployment: Docker Compose with REST API endpoints

**Stage 5: Factory Integration (2026)**

- Factory manager agents automate full model lifecycle using **TAO skills**
- Agents identify accuracy gaps, source/generate training data, fine-tune, redeploy
- Visual inspection/process compliance agents use NVIDIA open models and blueprints

### Performance Metrics

- PCB classification: 93.8% → **98.5% accuracy** (4.7pp improvement from domain adaptation)
- PCB defect detection: 5% accuracy gain with distillation, 81% size reduction

### Reference Architectures

- TAO 6 + DeepStream 8 Visual Inspection Pipeline (developer blog)
- NVIDIA Factory Operations (FOX) Blueprint

---

## 3. Robotics (Isaac Platform)

### Use Case: Autonomous mobile robots, manipulators, humanoid robots

### End-to-End Workflow

**Stage 1: Environment Reconstruction & Scene Creation**

- Tool: **Omniverse NuRec** (NeRFs, 3DGS, 3DGUT) → renders in OpenUSD
- Assets: **SimReady Warehouse 01 Assets Pack** (OpenUSD models with semantic labels, physics via USDPhysics)
- Interactive editing: **Isaac Sim** (local RTX workstation, Azure VDI, or OSMO interactive session with livestream)

**Stage 2: Synthetic Data Generation**

- Tool: **MobilityGen** (built on Isaac Sim) for robot navigation data
- Data types: Occupancy maps, trajectory data (position/velocity/orientation), RGB camera, depth camera
- Augmentation: **Cosmos Transfer 2.5** (diffusion-based WFM) adds photorealistic visual diversity
- Prompt example: "realistic warehouse environment with consistent lighting, perspective, camera motion"

**Stage 3: Training**

- Framework: **Isaac Lab** (open-source, unified RL/learning-from-demonstrations/motion-planning framework)
- Methods: Reinforcement learning controllers for locomotion, manipulation policies
- Data: Synthetic + real-world robot data combined
- Scale: Large-scale cloud GPU clusters enable parallel simulation (thousands of simulations in parallel)

**Stage 4: Orchestration**

- Tool: **NVIDIA OSMO** (open-source cloud-native orchestrator)
- Workflow submission: `osmo workflow submit workflows/<file>.yaml --pool <pool-name>`
- Interactive sessions: Port-forwarding + Isaac Sim livestream client
- Infrastructure: Azure AKS with GPU node pools, scalable to other CSPs/NCPs
- Scaling: Elastic GPU capacity, artifact throughput planning, observability (GPU utilization, scenarios/hour)

**Stage 5: Deployment**

- Middleware: **Isaac ROS** (accelerated ROS 2 middleware)
- Onboard compute: **Jetson Thor** (real-time inference), **Jetson Orin**
- Perception: **DOCA Argus** (camera data processing, low-latency visual inference)
- Models run onboard to minimize cloud dependency

### Closed-Loop Evaluation Results (Synthetic + Cosmos-augmented vs synthetic-only)

Navigate transparent obstacles, avoid camouflaged obstacles, reduce travel distance near obstacles, navigate dimly lit environments, traverse narrow passages

### Customer Examples

- 1X Technologies NEO humanoid — Jetson Thor onboard, Blackwell HGX B200 for training
- Skild AI — General-purpose robot foundation models
- Agility, Apptronik, Fourier Intelligence, Unitree — humanoid robot learning
- Lightwheel — serving AgiBot, BYD, ByteDance, Figure, Fourier, Galbot, Geely, Google DeepMind, Zordi

### Reference Architectures

- Isaac Sim + OSMO Synthetic Data Pipeline (developer blog)
- Azure NVIDIA Robotics Reference Architecture (GitHub)
- Omniverse Mega Blueprint — digital twin + AI-powered robot + video analytics

---

## 4. Humanoid Robots (GR00T Platform)

### Use Case: General-purpose humanoid robot development

### End-to-End Workflow

**Stage 1: Data Collection**

- Tool: **Isaac Teleop** (teleoperation system for demonstrating tasks)
- Process: Record high-quality training data via VR teleoperation with SONIC
- Output: Multimodal demonstrations (vision, language, action)

**Stage 2: Foundation Model Fine-Tuning**

- Model: **Isaac GR00T N1.7** (open VLA model: vision-language-action)
- Input: Multimodal (language + images) → Output: Manipulation tasks
- Fine-tuning: VLA workflow on collected data (GR00T-WholeBodyControl repo)
- Training environment: **Isaac Lab** for simulation, training, testing, evaluation

**Stage 3: Simulation & Evaluation**

- Tool: **Isaac Lab** runs whole-body control policies in simulation
- Physics-based environments expose models to diverse scenarios
- Task execution measurement, success rates, supplementary training data generation

**Stage 4: Deployment**

- Middleware: **Isaac ROS** for real-time control
- Onboard compute: **Jetson Thor**
- Process: VLA inference for real-time whole-body control

**Stage 5: Continuous Improvement**

- Closed loop: collect → finetune → deploy (VR teleoperation → VLA workflow → VLA inference)

### Customer Examples

- Agile Robots, Doosan Robotics, LG Electronics, Samsung Electronics
- NVIDIA Isaac GR00T Reference Humanoid Robot from Unitree — late 2026

---

## 5. Autonomous Vehicles (DRIVE Platform)

### Use Case: Level 4 autonomy, robotaxis, self-driving cars

### End-to-End Workflow (Three-Computer Architecture)

**Stage 1: Data Preparation & AI Training**

- Infrastructure: **NVIDIA DGX** systems and GPUs
- Process: Dataset preparation, model training, AV software development

**Stage 2: Simulation & Validation**

- Tools: **Omniverse** + **Cosmos** platforms on **NVIDIA OVX** systems
- Capabilities: High-fidelity sensor simulation, synthetic data generation, testing/validation of AV scenarios
- Models: **Cosmos** conditioned on Omniverse physics libraries for diverse sensor data and realistic behavior

**Stage 3: In-Vehicle Computing**

- Hardware: **DRIVE AGX Orin** (automotive-grade in-vehicle computer)
- Process: Real-time sensor data processing for safe, highly automated/autonomous driving

**Stage 4: Safety Framework**

- Tool: **NVIDIA Halos** (end-to-end safety system)
- Scope: Hardware, software, AI models, tools for safe AV development/deployment from cloud to car
- Guardrails across simulation, training, deployment

**Stage 5: Reasoning & Long-Tail Scenario Handling**

- Model: **NVIDIA Alpamayo** (reasoning model for autonomous driving, open VLA for Level 4 autonomy)
- Purpose: Reasoning-based decision-making for long-tail edge cases

### Reference Platform

- **DRIVE Hyperion**: Production-ready reference architecture (standardized sensor suite + high-performance DRIVE compute + robust software stack)

### Customer Examples

- Jaguar Land Rover — built on NVIDIA DRIVE from cloud to car

---

## 6. Physical AI Data Factory Blueprint (Cross-Cutting Infrastructure)

### Use Case: Massive-scale training data production for robotics, vision AI, AVs

### End-to-End Workflow

**Stage 1: Curate and Search**

- Tool: **Cosmos Curator** (open-source, available on GitHub)
- Process: Process, refine, annotate large-scale real-world and synthetic datasets
- Output: Curated datasets ready for augmentation

**Stage 2: Augment and Multiply**

- Tool: **Cosmos Transfer** (WFM)
- Process: Exponentially expand and diversify curated data
- Capability: Capture rare and long-tail scenarios (expensive/impractical to capture in real world)
- Variations: Environments, lighting conditions, edge cases

**Stage 3: Evaluate and Validate**

- Tool: **Cosmos Evaluator** (powered by **Cosmos Reason**, available on GitHub)
- Process: Automatically score, verify, filter generated data for physical accuracy and training readiness
- Output: Model-ready training sets

**Stage 4: Orchestration**

- Tool: **NVIDIA OSMO** (open-source)
- Capabilities: Unifies workflows across compute environments, reduces manual tasks
- Agent integration: Claude Code, OpenAI Codex, Cursor
- AI-native operations: Agents proactively manage resources, resolve bottlenecks, accelerate model delivery

**Stage 5: Cloud Infrastructure**

- Providers: Microsoft Azure (IoT Operations, Fabric, Real-Time Intelligence, Foundry), Nebius (ultrafast object storage, native data management/labeling, serverless execution, managed inference)
- GPU: NVIDIA RTX PRO 6000 Blackwell Server Edition

### Customer Examples

- Uber — AV development
- FieldAI, Hexagon Robotics, Linker Vision, Teradyne Robotics — testing Azure toolchain
- Milestone Systems, Voxel51, RoboForce — on Nebius infrastructure

---

## 7. Cosmos 3 World Foundation Model Workflow

### Use Case: Omnimodal world models for Physical AI (robotics, AVs, vision AI)

### Model Architecture

Mixture-of-transformers (reasoning transformer + expert generation transformer)

### Three Model Tiers

| Model | Purpose | Deployment | Status |
|---|---|---|---|
| **Cosmos 3 Super** | Highest physics accuracy for robotics/AV post-training | Cloud (DGX Cloud) | Available |
| **Cosmos 3 Nano** | High-quality video/action reasoning in fractions of a second | Workstation/cloud | Available |
| **Cosmos 3 Edge** | Real-time inference at the edge | Edge devices | Coming soon |

### Workflow Integration

- **Vision Language Model**: Understands and reasons across modalities
- **World/Video Foundation Model**: Simulates physical environments, predicts future states for training/evaluation
- **World Action Model Backbone**: Supports training robots for specific tasks

---

## 8. NIM Microservices Deployment (Edge-to-Cloud Inference)

### Architecture

- Self-contained containers: model weights + inference backend (TensorRT-LLM, vLLM, SGLang) + OpenAI-compatible API
- Deployment: Any Kubernetes cluster with NVIDIA GPUs
- Observability: Metrics, Helm charts, NIM Operator for scaling/health monitoring

### Deployment Targets

- **Cloud**: CSPs with NVIDIA GPUs
- **Data center**: On-prem servers
- **Workstation**: RTX PRO series
- **Edge**: Jetson platform (via Jetson Platform Services)

### Licensing (2026)

- **Developer tier**: Free for NVIDIA Developer Program (up to 16 GPUs, eval/dev)
- **Production**: NVIDIA AI Enterprise ($4,500/GPU/year)

---

## Cross-Cutting Patterns Identified

### Common Workflow Stages

1. **Data Curation** → Cosmos Curator
2. **Synthetic Data Generation** → Cosmos Transfer, Isaac Sim, Omniverse
3. **Foundation Model Selection** → Cosmos 3, C-RADIO, NV-CLIP, NV-DINOv2, Isaac GR00T
4. **Fine-Tuning/Post-Training** → TAO agent skills, Isaac Lab, HuggingFace Diffusers
5. **Optimization** → Knowledge distillation (TAO), TensorRT
6. **Orchestration** → OSMO (cloud-native, agent-integrated)
7. **Deployment** → NIM microservices, DeepStream, Isaac ROS
8. **Edge Inference** → Jetson Thor/Orin, IGX Platform, DGX Spark
9. **Cloud Training** → DGX Cloud, Azure, Nebius

### Data Types Across Workflows

- Video streams (RGB, depth)
- Sensor data (LiDAR for AVs, camera arrays for vision AI)
- Occupancy maps, trajectory data (robotics)
- Point clouds (AVs)
- Embeddings (vision, language)
- Action trajectories (robotics, AVs)
- Synthetic data (images, video, augmented sensor data)

### Batch vs Streaming

- **Streaming/Real-time**: Video analytics event detection, robot control loops, AV perception
- **Batch**: Archived video search/summarization, large-scale synthetic data generation (OSMO workflows), model training (DGX Cloud)

### Deployment Tiers

- **Edge**: Jetson (Thor 2070 TFLOPS, Orin), IGX Platform
- **Workstation**: RTX PRO 6000 Blackwell, DGX Spark (GB10, 128GB)
- **Cloud**: Azure, Nebius, CoreWeave, Baseten, Deep Infra
- **Hybrid**: OSMO orchestrates across environments

---

## Sources

### Video Analytics & Metropolis

- NVIDIA Video Analytics AI Agents Use Case page
- Metropolis Platform page
- Metropolis Developer Portal
- DeepStream Coding Agents blog post
- Smart City AI Blueprint Europe blog

### Industrial Inspection

- TAO 6 + DeepStream 8 Visual Inspection Pipeline (developer blog)
- Transforming Industrial Defect Detection with TAO (developer blog)
- Factory Operations FOX Blueprint blog

### Robotics (Isaac)

- Isaac Developer Portal
- Isaac Sim + OSMO Synthetic Data Pipelines (developer blog)
- 1X Technologies Humanoid Robot Stack
- PTC Onshape + Isaac Sim Workflow
- Azure NVIDIA Robotics Reference Architecture (GitHub)

### Humanoid Robots (GR00T)

- Isaac GR00T Reference Humanoid Robot announcement
- Isaac GR00T N1 Foundation Model announcement
- Isaac GR00T GitHub

### Autonomous Vehicles (DRIVE)

- NVIDIA DRIVE Platform
- DRIVE Hyperion L4 Platform
- Alpamayo Autonomous Vehicle Development
- CES 2026 announcements

### Physical AI Data Factory

- Physical AI Data Factory Blueprint announcement
- Physical AI Agent Skills (CVPR 2026) blog

### Cosmos 3

- Cosmos 3 launch announcement
- Cosmos Platform page
- Develop Physical AI with Cosmos 3 (developer blog)
- NVIDIA Cosmos GitHub
