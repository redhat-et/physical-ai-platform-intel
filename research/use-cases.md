# Physical AI Domains

> Solution domains for Physical AI — each with distinct technology stacks, ecosystems, and workflow patterns

**Last Updated**: 2026-07-12

---

## Taxonomy

Physical AI spans multiple **domains** — independent solution areas, each with its own technology stack, ISV/SI ecosystem, canonical workflow, and building-block requirements. Domains share common platform infrastructure but differ in how they close the AI-physical-world loop.

### Terminology

| Term | Definition |
| ---- | ---------- |
| **Domain** | An independent Physical AI solution area. Each domain passes a four-part independence test: (a) distinct technology stack, (b) distinct core problems, (c) distinct ISV/SI ecosystem, (d) distinct canonical workflow pattern. |
| **Vertical** | An industry segment within a domain. Verticals share the domain's technology stack and workflow but differ in regulatory requirements, deployment context, and specific ISV solutions. |
| **Cross-cutting capability** | A technology or pattern used across multiple domains — not a domain itself. Examples: autonomous agents (planning/reasoning), gaming & simulation (training data generation). |

### Domain Overview

| # | Domain | Core Loop | Example Verticals |
| - | ------ | --------- | ----------------- |
| 1 | [Robotics](#robotics) | Sense → plan → manipulate/navigate | Manufacturing, logistics, agriculture, defense |
| 2 | [Autonomous Vehicles](#autonomous-vehicles) | Perceive → predict → navigate | Passenger vehicles, trucking, last-mile delivery |
| 3 | [Visual AI / Inspection](#visual-ai--inspection) | Capture → detect → classify → act | Factory QC, security/safety, retail analytics, traffic |
| 4 | [Industrial Digital Twins](#industrial-digital-twins) | Sense → simulate → optimize → actuate | Manufacturing, energy/utilities, infrastructure |
| 5 | [Product Design & Engineering](#product-design--engineering) | Design → simulate → validate → iterate | Mechanical/structural, electronics, aerospace |
| 6 | [Molecular Design & Engineering](#molecular-design--engineering) | Design → simulate → synthesize → assay | Drug design (pharma/biotech), materials design (chemicals, energy) |
| 7 | [Medical AI](#medical-ai) | Image → diagnose → predict → treat | Radiology, cardiology, pathology, surgical planning |
| 8 | [Scientific Discovery](#scientific-discovery) | Hypothesize → experiment → analyze → iterate | Self-driving labs, fundamental research |

### Cross-Cutting Capabilities (Not Domains)

- **Autonomous Agents** — planning with internal simulation, tool use, multi-step reasoning. Used within Robotics, Digital Twins, and Scientific Discovery domains rather than constituting its own domain.
- **Gaming & Simulation** — interactive world generation (Genie 3, World Labs Marble). Technology enabler for training data and synthetic environments across domains, not a standalone solution area.

### Verticals That Map to Domains

- **Telecommunications** (WirelessJEPA, beam management) → applies Visual AI + Industrial Digital Twins building blocks
- **Defense** (drone coordination, battlefield awareness) → Robotics or Autonomous Vehicles depending on application
- **Construction / AEC** → Industrial Digital Twins + Visual AI
- **Agriculture** → Robotics + Visual AI

---

## Robotics

**Description**: Robot manipulation, navigation, and task planning using learned world models to generate synthetic training data, predict action outcomes, and enable zero-shot or few-shot transfer to real-world tasks.

**Common building blocks** (across all verticals):

| Building Block | Role in this domain |
| -------------- | ------------------- |
| [Robot Foundation Models](building-blocks.md#robot-foundation-models) | Required — Policy networks that execute manipulation/navigation tasks |
| [Simulation Engines](building-blocks.md#simulation-engines) | Required — Generate synthetic scenarios for policy training |
| [Sim-to-Real Transfer Pipeline](building-blocks.md#sim-to-real-transfer-pipeline) | Required — Bridge gap between simulated and real-world performance |
| [Robot Middleware](building-blocks.md#robot-middleware) | Required — Connect models to robot hardware (control, sensing) |
| [Sensor Data Ingestion](building-blocks.md#sensor-data-ingestion) | Required — Process camera, proprioceptive, tactile sensor streams |
| [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime) | Required — Real-time on-robot inference for closed-loop control |
| [Model Serving for Physical AI](building-blocks.md#model-serving-for-physical-ai) | Required — Serve world models during policy training rollouts |

### Manufacturing & Logistics (Robotics)

**Verticals**: Manufacturing | Logistics

**Additional building blocks**: [Robot Fleet Management & Observability](building-blocks.md#robot-fleet-management--observability) (important for factory-scale deployment)

**Vertical-specific requirements**:

- **Functional**: High-fidelity visual generation at sufficient resolution for manipulation (object textures, gripper contact). Action conditioning — the world model must accept robot action inputs to generate plausible outcomes. Zero-shot grasping success for novel objects (V-JEPA 2-AC demonstrated 45% vs. 8% baseline).
- **Non-functional**: GPU clusters for world model inference during policy training. Real-time inference (<50ms) for closed-loop deployment. Reduce real-world data collection budgets by 40-60% through synthetic data generation.
- **Regulatory**: ISO 10218 (industrial robot safety), ISO/TS 15066 (collaborative robots)

**Current solutions**: [NVIDIA](ecosystem.md#nvidia) Cosmos + GR00T N1 (adopted by [Figure AI](ecosystem.md#figure-ai), Agility, 1X, Boston Dynamics, Unitree); [Physical Intelligence](ecosystem.md#physical-intelligence-pi) π0.5 (open-world manipulation); V-JEPA 2-AC (zero-shot grasping via JEPA representations)

**Gaps**: Sim-to-real gap remains significant for contact-rich manipulation (deformable objects, liquids). No standardized benchmark for world model quality as measured by downstream policy performance. Long-horizon multi-step task generation (>30s) still unreliable.

---

## Autonomous Vehicles

**Description**: Self-driving systems using world models to predict future vehicle and environment states, simulate safety-critical scenarios, and train perception-planning-control policies for autonomous navigation.

**Common building blocks** (across all verticals):

| Building Block | Role in this domain |
| -------------- | ------------------- |
| [Video Generation / Prediction Models](building-blocks.md#video-generation--prediction-models) | Required — Generate multi-camera, spatiotemporally consistent driving scenarios |
| [Simulation Engines](building-blocks.md#simulation-engines) | Required — Simulate rare, safety-critical events (collisions, adverse weather) |
| [Sensor Data Ingestion](building-blocks.md#sensor-data-ingestion) | Required — Multi-modal fusion (camera, LiDAR, radar) |
| [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime) | Required — Real-time occupancy prediction for deployment |
| [Safety, Validation & Certification Frameworks](building-blocks.md#safety-validation--certification-frameworks) | Required — Validate AV systems against regulatory standards |

### Transport & Logistics (Autonomous Vehicles)

**Verticals**: Transport & Logistics

**Additional building blocks**: [Post-Training / Fine-Tuning Pipeline](building-blocks.md#post-training--fine-tuning-pipeline) (important for scenario-specific adaptation)

**Vertical-specific requirements**:

- **Functional**: Multi-camera, spatiotemporally consistent video generation (GAIA-2 achieves this). LiDAR point cloud synthesis alongside camera views. Controllable scenario parameters (weather, traffic density, pedestrian behavior). Real-time occupancy prediction for deployment (Tesla FSD). Minutes-scale scenario generation with geometric consistency.
- **Non-functional**: Real-time inference (<100ms) for occupancy networks in production. 720p+ multi-view generation at 24fps for simulation. Geometric consistency over 30+ second rollouts.
- **Regulatory**: ISO 26262 (functional safety), UNECE WP.29 (automated driving), SAE J3016 (automation levels)

**Current solutions**: Waymo World Model (Genie 3-based, multi-sensor); [Wayve](ecosystem.md#wayve) GAIA-2/3 (controllable multi-view generation); [Tesla](ecosystem.md#tesla) FSD v14 (occupancy networks in production); DriveDreamer-2 (LLM-prompted scene generation); HERMES (unified 3D scene understanding)

**Gaps**: Geometric drift in autoregressive generation over long horizons. No industry-standard fidelity metric for generated driving scenarios. Regulatory acceptance of world-model-generated scenarios for safety validation is undefined.

---

## Visual AI / Inspection

**Description**: Visual and sensor-based detection, classification, and monitoring of physical environments and manufactured goods using AI — spanning real-time video analytics and production-line quality control.

**Common building blocks** (across all verticals):

| Building Block | Role in this domain |
| -------------- | ------------------- |
| [Sensor Data Ingestion](building-blocks.md#sensor-data-ingestion) | Required — Process camera, thermal, ultrasonic sensor streams |
| [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime) | Required — Real-time detection on production lines or camera feeds |
| [Model Serving for Physical AI](building-blocks.md#model-serving-for-physical-ai) | Important — Serve inspection/analytics models at scale |
| [Data Annotation & Curation for Physical AI](building-blocks.md#data-annotation--curation-for-physical-ai) | Required — Label defect examples or event types for training |

### Manufacturing (Quality Control)

**Verticals**: Manufacturing

**Additional building blocks**: TBD

**Vertical-specific requirements**:

- **Functional**: TBD — Defect detection, dimensional measurement, surface quality assessment
- **Non-functional**: TBD — Real-time inspection (<100ms per part), 99.9%+ detection accuracy
- **Regulatory**: TBD — ISO 9001 (quality management)

**Current solutions**: TBD

**Gaps**: TBD

### Food & Beverage (Quality Control)

**Verticals**: Food & Beverage

**Additional building blocks**: TBD

**Vertical-specific requirements**:

- **Functional**: TBD — Food safety inspection, contamination detection, packaging quality
- **Non-functional**: TBD
- **Regulatory**: TBD — FDA Food Safety Modernization Act, HACCP

**Current solutions**: TBD

**Gaps**: TBD

---

## Industrial Digital Twins

**Description**: Autonomous digital twins that continuously simulate, predict, and optimize industrial operations in real time using learned dynamics models coupled to live sensor feeds.

**Common building blocks** (across all verticals):

| Building Block | Role in this domain |
| -------------- | ------------------- |
| [Simulation Engines](building-blocks.md#simulation-engines) | Required — Multi-physics simulation (thermal, structural, fluid dynamics) |
| [Digital Twin Runtime](building-blocks.md#digital-twin-runtime) | Required — Real-time predict-then-act loop with safety verification |
| [Sensor Data Ingestion](building-blocks.md#sensor-data-ingestion) | Required — Process industrial sensors (temperature, pressure, vibration) |
| [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks) | Important — Incorporate domain physics into learned models |

### Manufacturing (Digital Twins)

**Verticals**: Manufacturing

**Additional building blocks**: [Edge AI Inference Runtime](building-blocks.md#edge-ai-inference-runtime) (important for latency-sensitive control)

**Vertical-specific requirements**:

- **Functional**: Real-time physics simulation coupled to sensor feeds (temperature, pressure, vibration). Predict-then-act loop with safety verification before executing changes. Integration with industrial control systems (PLCs, SCADA). On-premises or sovereign cloud deployment (manufacturing IP sensitivity). Multi-physics simulation (thermal, structural, fluid dynamics).
- **Non-functional**: Real-time update rates for closed-loop control (<1s). High-fidelity physics simulation balancing accuracy and speed. Support for thousands of sensors per factory.
- **Regulatory**: IEC 61508 (functional safety), IEC 62443 (industrial cybersecurity)

**Current solutions**: [Siemens](ecosystem.md#siemens) Digital Twin Composer + [NVIDIA](ecosystem.md#nvidia) Omniverse (Erlangen factory); [Schneider Electric](ecosystem.md#schneider-electric) EcoStruxure + Omniverse (energy/chemicals); PepsiCo factory digital twins (with Siemens)

**Gaps**: Bridging simulation fidelity and real-time update rates for closed-loop control. No standardized interoperability between digital twin platforms. Autonomous decision-making in safety-critical industrial processes requires formal verification. Edge deployment of world models for latency-sensitive manufacturing control.

### Energy & Utilities (Digital Twins)

**Verticals**: Energy & Utilities

**Additional building blocks**: [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks) (required for grid/plant dynamics)

**Vertical-specific requirements**:

- **Functional**: TBD — Power grid optimization, renewable energy forecasting, plant efficiency prediction
- **Non-functional**: TBD
- **Regulatory**: NERC CIP (grid cybersecurity), IEC 61850 (power systems communication)

**Current solutions**: [Schneider Electric](ecosystem.md#schneider-electric) EcoStruxure (energy management with Omniverse)

**Gaps**: TBD

---

## Product Design & Engineering

**Description**: AI-driven product design, simulation, and virtual prototyping — using generative design, multi-physics simulation, and learned surrogates to explore design spaces, validate performance, and predict manufacturability before physical prototyping.

**Common building blocks** (across all verticals):

| Building Block | Role in this domain |
| -------------- | ------------------- |
| [Simulation Engines](building-blocks.md#simulation-engines) | Required — Multi-physics FEA/CFD for virtual prototyping |
| [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks) | Required — Learned surrogates for rapid design space exploration |
| [Digital Twin Runtime](building-blocks.md#digital-twin-runtime) | Important — Design-to-manufacturing digital thread |
| [Post-Training / Fine-Tuning Pipeline](building-blocks.md#post-training--fine-tuning-pipeline) | Important — Adapt foundation models to domain-specific CAD/CAE data |

### Manufacturing / Aerospace / Automotive (Product Design)

**Verticals**: Manufacturing | Aerospace | Automotive | Electronics

**Additional building blocks**: [Evaluation & Benchmarking](building-blocks.md#evaluation--benchmarking) (important for surrogate model validation against traditional solvers)

**Vertical-specific requirements**:

- **Functional**: Generative design under physical constraints (structural, thermal, fluid dynamics). Neural surrogate models replacing FEA/CFD for rapid design-space exploration (100-1000x speedup over traditional solvers). Multi-physics co-simulation (structural + thermal + fluid). Virtual crash/stress testing. Manufacturability prediction. CAD/CAE tool integration. Hybrid workflow: AI surrogates for screening, traditional solvers for final validation.
- **Non-functional**: Support for large assemblies (millions of elements), parametric sweep at scale. Automotive crash predictions at <0.5% error vs. LS-DYNA. Cloud-burst capacity for large-scale design sweeps.
- **Regulatory**: DO-178C (aerospace software), ISO 26262 (automotive functional safety), industry-specific certification requirements

**Current solutions**: [Siemens](ecosystem.md#siemens) Simcenter PhysicsAI (neural surrogates, 100x speedup) + PhysicsAI Generate (diffusion-based generative design, 2026.1) + Altair romAI/PhysicsAI (acquired March 2025, ~$10B); Ansys SimAI Pro/Premium (physics-agnostic surrogates using FNOs/PINNs/GNNs, <0.5% error on crash/aero); [Dassault Systèmes](ecosystem.md#dassault-systèmes) 3DEXPERIENCE Virtual Twin + NVIDIA partnership (Feb 2026, targeting 100-1000x acceleration); Autodesk Neural CAD (foundation models generating editable BREP geometry from text, 2026); PTC Creo 13 AI + Onshape-Isaac Sim integration (CAD-to-robotics pipeline); [PhysicsX](ecosystem.md#physicsx) (neural surrogates, $500M raised at $2.4B valuation, Jun 2026, NVIDIA/Siemens investor); Neural Concept (geometric deep learning, crash sim 48h→30s, $100M Series C)

**Gaps**: No standardized benchmark for neural surrogate accuracy vs. traditional solvers. 3D geometry processing and CAD interoperability remain ISV-proprietary — no open-source alternative for production CAD-to-ML pipelines. Regulatory acceptance of AI-surrogate-validated designs is undefined. Hybrid workflow orchestration (surrogate screening → solver validation → design iteration) lacks standard tooling.

---

## Molecular Design & Engineering

**Description**: AI-driven design, simulation, and optimization of molecules, proteins, and materials — using generative models, molecular dynamics, and closed-loop experimentation to accelerate drug discovery and materials development. Structurally parallel to Product Design & Engineering but operating at molecular scale with different tools, ecosystems, and regulatory frameworks.

**Common building blocks** (across all verticals):

| Building Block | Role in this domain |
| -------------- | ------------------- |
| [Simulation Engines](building-blocks.md#simulation-engines) | Required — Molecular dynamics, DFT, docking simulations |
| [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks) | Required — Machine learning interatomic potentials (MLIPs), ADMET prediction |
| [Post-Training / Fine-Tuning Pipeline](building-blocks.md#post-training--fine-tuning-pipeline) | Required — Adapt foundation models to domain-specific molecular/materials data |
| [Safety, Validation & Certification Frameworks](building-blocks.md#safety-validation--certification-frameworks) | Required — FDA validation, GLP compliance |

### Drug Design (Pharma / Biotech)

**Verticals**: Pharmaceuticals | Biotechnology

**Additional building blocks**: [Robot Middleware](building-blocks.md#robot-middleware) (important for laboratory automation integration), [Data Annotation & Curation for Physical AI](building-blocks.md#data-annotation--curation-for-physical-ai) (important for experimental data management)

**Vertical-specific requirements**:

- **Functional**: Generative molecular design (de novo small molecules, antibodies, proteins). ADMET prediction and binding affinity optimization (FEP+ level accuracy). Protein structure prediction and docking. DMTA (Design-Make-Test-Analyze) cycle compression (from 2.5-4 years to 12-18 months). Multi-modal data fusion (genomics, imaging, chemistry). Autonomous lab integration for closed-loop synthesis.
- **Non-functional**: Large-scale virtual screening (1,000+ molecules/day). Federated learning across proprietary compound libraries. GxP-validated compute environments with audit trails. Elastic GPU scaling for FEP calculations.
- **Regulatory**: FDA (drug development), GLP (Good Laboratory Practice), ICH guidelines, FDA/EMA joint AI guidelines (Jan 2026) requiring human approval for quality-critical decisions

**Current solutions**: Recursion Pharmaceuticals (merged with Exscientia Nov 2024, $688M; most vertically integrated AI-biotech, 10+ clinical programs, Roche/Sanofi/Bayer partnerships); Insilico Medicine (Pharma.AI end-to-end platform, rentosertib in Phase III Jul 2026, 31 preclinical candidates); Schrödinger (FEP+ physics-based platform, ~70% market penetration in drug design); XtalPi (quantum-mechanics + AI molecular digital twins, XFEP 10-100x FEP throughput, $400M+ GPCR partnership Jun 2026); Isomorphic Labs (IsoDDE — integrated structure prediction + docking + affinity, outperforms AlphaFold 3 by 2.3x, ~$3B in Novartis/Lilly/J&J partnerships); Chai Discovery ($130M Series B at $1.3B, biomolecular foundation models, partially open weights); [NVIDIA](ecosystem.md#nvidia) BioNeMo (open platform for biological foundation models, NIM microservices, $1B co-innovation lab with Eli Lilly)

**Gaps**: Regulatory pathway for AI-designed drugs is emerging but undefined — rentosertib (Insilico) and Isomorphic's first candidates will test FDA acceptance. Federated learning for cross-pharma collaboration is nascent. Integration of autonomous labs with AI design platforms remains bespoke. Transfer between molecular domains (small molecules → biologics → gene therapy) is untested.

### Materials Design (Chemicals / Energy / Semiconductors)

**Verticals**: Chemicals | Energy | Semiconductors | Materials Science

**Additional building blocks**: [Robot Middleware](building-blocks.md#robot-middleware) (important for autonomous lab integration)

**Vertical-specific requirements**:

- **Functional**: Inverse materials design via generative models. Crystal structure prediction and stability analysis. Machine Learning Interatomic Potentials (MLIPs) for atomistic simulation at DFT accuracy. Integrated Computational Materials Engineering (ICME) pipelines connecting simulation to manufacturing. Self-driving lab (SDL) integration for closed-loop synthesis and characterization.
- **Non-functional**: Universal MLIPs covering 96+ elements. High-throughput computational screening at 20M× DFT speed. Autonomous synthesis integration (SDL 2.0: LLM-orchestrated, multi-instrument). Open data formats for interoperability with national lab databases.
- **Regulatory**: EPA/REACH (chemical safety), industry-specific material certification

**Current solutions**: Materials Project (Berkeley Lab, 650K+ users, 32K citations, fully open, ~150K+ computed material properties; FORUM-AI agentic platform for automated discovery, Feb 2026); Matlantis (Preferred Networks, cloud SaaS universal atomistic simulator, PFP v8 MLIP covering 96 elements at 20M× DFT speed, 100+ organizations); Citrine Informatics (materials informatics with Bayesian optimization for sparse experimental data, Rolls-Royce/EMD customers, $76M raised); MACE (Cambridge, open-source equivariant MLIP, leading OSS universal potential, ASL/CC-BY); Google DeepMind GNoME (predicted 2.2M crystal structures, contributed ~400K to Materials Project, model proprietary); A-Lab (Berkeley, autonomous robotic lab synthesizing AI-predicted materials)

**Gaps**: SDL 2.0 architectures are emerging but most labs remain at Level 2-3 autonomy. No standardized platform integrates generative design → simulation → autonomous synthesis → characterization. Transfer across material classes (inorganic → organic → polymer → composite) is untested. Open-source MLIPs (MACE) compete with proprietary (Matlantis) on accuracy but lack enterprise support.

---

## Medical AI

**Description**: World models learn representations from medical imaging data to predict disease progression, simulate treatment outcomes, and support clinical decisions through learned latent dynamics.

**Common building blocks** (across all verticals):

| Building Block | Role in this domain |
| -------------- | ------------------- |
| [Latent World Models](building-blocks.md#latent-world-models) | Required — Learn representations from imaging data (echocardiograms, CT, MRI) |
| [Simulation Engines](building-blocks.md#simulation-engines) | Important — Simulate post-treatment outcomes (tumor evolution, cardiac function) |
| [Model Serving for Physical AI](building-blocks.md#model-serving-for-physical-ai) | Required — Integrate with clinical workflows (PACS, EHR systems) |
| [Safety, Validation & Certification Frameworks](building-blocks.md#safety-validation--certification-frameworks) | Required — FDA/CE marking for clinical use |

### Healthcare & Life Sciences (Medical AI)

**Verticals**: Healthcare & Life Sciences

**Additional building blocks**: [Data Annotation & Curation for Physical AI](building-blocks.md#data-annotation--curation-for-physical-ai) (required for clinical data labeling)

**Vertical-specific requirements**:

- **Functional**: Foundation-scale training on clinical data (EchoJEPA: 18M studies). Uncertainty quantification — clinicians need confidence bounds, not point predictions. Patient privacy preservation during model training. Integration with clinical workflows (PACS, EHR systems). Multi-modal fusion (imaging + genomics + lab results).
- **Non-functional**: Inference latency <5s for clinical decision support. Support for 300K+ patient cohorts. Uncertainty bounds with 95% confidence intervals.
- **Regulatory**: FDA 510(k) (medical devices), IEC 62304 (medical device software), EU MDR (medical device regulation), HIPAA (data privacy)

**Current solutions**: EchoJEPA (University of Toronto / Vector Institute); MeWM (action-conditioned 3D tumor simulation); Foresight (medical event timeline prediction); [AMI Labs](ecosystem.md#ami-labs) (targeting healthcare applications via Nabla partnership)

**Gaps**: Regulatory pathway for world-model-based clinical decision support is undefined. Causal reasoning required for treatment planning (beyond correlation). Limited multi-modal fusion (imaging + genomics + lab results). Generalization across patient populations and imaging equipment.

---

## Scientific Discovery

**Description**: Autonomous experimentation systems that generate hypotheses, design experiments, execute them robotically, analyze results, and iterate in closed loops for fundamental research and exploratory science.

**Common building blocks** (across all verticals):

| Building Block | Role in this domain |
| -------------- | ------------------- |
| [Simulation Engines](building-blocks.md#simulation-engines) | Required — Predict experimental outcomes before physical execution |
| [Physics-Informed ML Frameworks](building-blocks.md#physics-informed-ml-frameworks) | Required — Incorporate domain constraints (chemistry, physics) into models |
| [Post-Training / Fine-Tuning Pipeline](building-blocks.md#post-training--fine-tuning-pipeline) | Important — Adapt foundation models to domain-specific experimental data |

### Fundamental Research (Scientific Discovery)

**Verticals**: Academic research | National labs

**Additional building blocks**: [Robot Middleware](building-blocks.md#robot-middleware) (important for laboratory automation integration)

**Vertical-specific requirements**:

- **Functional**: Robotic laboratory automation (liquid handling, synthesis, characterization). Multi-modal sensing beyond vision (spectroscopy, chromatography, mass spectrometry). Closed-loop integration of hypothesis → experiment → analysis. Long-horizon planning across experiment sequences (days to weeks). Domain-specific world models that predict experimental outcomes under physical/chemical constraints.
- **Non-functional**: Data efficiency — learn from sparse scientific data (not internet-scale). Long-horizon credit assignment over multi-day experiments. Support for symbolic scientific knowledge (equations, constraints).
- **Regulatory**: EPA (chemical safety), GLP (Good Laboratory Practice) where applicable

**Current solutions**: [Periodic Labs](ecosystem.md#periodic-labs) (AI scientist platform for materials discovery); [Medra](ecosystem.md#medra) Platform (autonomous drug discovery with Genentech); Emerald Cloud Lab (cloud laboratory infrastructure); academic self-driving labs (MIT, Berkeley, Toronto)

**Gaps**: Scientific data is sparse compared to internet-scale datasets — data efficiency is critical. Experimental "credit assignment" over long horizons (which early decision caused a late failure?). Integrating symbolic scientific knowledge (equations, constraints) with learned world models. Transfer across scientific domains (chemistry → biology → materials) untested.

---

**Note**: Each domain section follows a consistent structure: description, common building blocks, and vertical-specific entries with requirements, solutions, and gaps.
Verticals include technical requirements, current solutions, and research gaps.
