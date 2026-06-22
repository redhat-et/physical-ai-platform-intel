# Physical AI & World Models: The Next Frontier Beyond LLMs

## The Physical World Problem

Large language models have transformed enterprise workflows where information is the product: document processing, code generation, customer service, content creation. The next transformation is AI improving physical processes and products: manufacturing, robotics, drug discovery, autonomous systems. This is where LLMs and VLMs reach their limits: they can *speculate* about the physical world based on language reasoning, but they don't *understand* its mechanics. An LLM can describe why tall stacks collapse or explain fluid dynamics principles. But it cannot predict the precise trajectory when a robot's gripper applies force at a specific angle, simulate how a drug binds to a protein, or forecast when a turbine blade will fatigue. Even for basic spatial reasoning, LLMs fall short: tested on grid-world mazes, they achieve 80-86% accuracy under favorable text representations but drop to 16-34% with visual formats, treating each question independently rather than building cumulative spatial knowledge (Li et al. 2026).

These problems require models that don't just process language, they need internal representations of physics, causality, and temporal dynamics. World models are AI systems that learn these representations from data, building compressed simulations of how systems evolve over time. They're the next conceptual shift beyond transforming text: transforming our ability to plan, optimize, and act in physical environments where mistakes are costly and understanding consequences matters.

## The Conceptual Shift: Tokens to States

The difference between LLMs and world models goes beyond data or architecture. It's a fundamental shift in what gets predicted and how planning works:

| Dimension       | LLMs                        | World Models                       |
|-----------------|-----------------------------|------------------------------------|
| **Predicts**    | Next token                  | Next state of a system             |
| **Learns from** | Text (internet scale)       | Video, sensor data, simulation     |
| **State**       | Stateless (context window)  | Persistent internal representation |
| **Planning**    | Generate text about actions | Simulate consequences, then act    |

LLMs are powerful at reasoning *about* the world through language, but they can't simulate what happens when you execute an action. World models enable a different approach: *imagine before acting*. A robot equipped with a world model can internally simulate "what happens if I grasp here vs. there?" and choose the trajectory less likely to knock over adjacent objects. An autonomous vehicle can predict "if I change lanes now, will that car need to brake hard?" before committing to the maneuver.

This matters because mistakes in the physical world have consequences LLMs never face. A wrong token can be regenerated; a collision or a dropped part cannot. World models make it possible to fail safely, in simulation, thousands of times before acting once in reality.

## What World Models Learn

World models build internal representations of four core concepts that enable intelligent behavior in physical environments:

| Concept                | Example                                               | Benefit                                       |
|------------------------|-------------------------------------------------------|-----------------------------------------------|
| **Object permanence**  | Ball rolls behind couch → model knows it still exists | Plan to retrieve occluded objects             |
| **Physics & dynamics** | Stack blocks too high → model predicts collapse       | Avoid failures, safe manipulation             |
| **Causality & time**   | Push cup → liquid spills → stain forms                | Predict multi-step consequences before acting |
| **Spatial structure**  | Build room layout from partial views                  | Navigate, avoid collisions                    |

Humans don't need to knock over every tall stack to know they'll fall, we have internal physics models built from experience. World models give AI the same capability: learning dynamics from observation (video, sensors, simulation) rather than hardcoded rules. A robot trained on millions of grasping attempts learns that soft objects deform, rigid objects slip, and fragile objects shatter. A diagnostic model learns that hearts contract in specific patterns, and deviations signal disease. This learned understanding enables planning ("if I do X, Y will happen") rather than reactive control ("given X, do Y").

## Defining World Models

### Defining Characteristics

A world model is an AI system with four defining characteristics:

**1. Learns representations from data.** Rather than hand-coded rules or physics equations, world models extract patterns from observations. A robotic manipulation model learns object dynamics from thousands of grasp attempts; a medical imaging model learns cardiac patterns from annotated echocardiograms. The representations are discovered, not designed.

**2. Maintains internal state.** A compressed model of "how things are right now." Unlike stateless models that process each input independently, world models build internal representations of state: object positions, velocities, occlusions, system configurations.

*Caveat on "internal state":* In current implementations, this typically means building state from a context window of recent observations, not true persistent memory across sessions. Models like DreamerV3 maintain recurrent hidden state during rollouts but reset between episodes. Interactive systems like Genie 3 maintain session state but don't learn from it. See "The Continual Learning Gap" below.

**3. Predicts future states.** Given current state and a potential action, the model forecasts what happens next. "If the robot grasps here, the object tilts 15° and adjacent items shift." "If this heart valve degenerates further, ejection fraction drops below 40%." The model answers "what if?" queries by projecting forward in time.

**4. Enables simulation.** By chaining predictions, world models can roll out hypothetical futures: simulate entire trajectories, test multiple strategies, identify failure modes, all before committing to action in the real world. This is the key capability that separates world models from reactive policies.

**The litmus test:** Can the model predict what happens next *without executing the action*? If yes, it's a world model. If it only maps observations directly to actions, it's a policy or controller, valuable but not a world model.

<img src="diagrams/conceptual-venn.png" alt="World Models in Context" width="800">

### Taxonomy of Approaches

Not everything called a "world model" meets these criteria. The field spans several categories:

| Category | Predicts | Examples | World Model? |
| -------- | -------- | -------- | ------------ |
| Latent-space WM | Future states in embedding space | V-JEPA 2, DreamerV3, TD-MPC2 | ✓ Yes |
| Pixel-space WM | Future video frames | Cosmos, Genie 3 | ✓ Yes |
| 4D scene-space WM | Future 3D geometry over time | TesserAct, Marble | ✓ Yes |
| Physics-informed WM | States with physics constraints | PhysicsNeMo | ✓ Yes |
| World Action Models | States + actions jointly | DreamZero, Being-H0.7 | ✓ Yes |
| Language-conditioned WM | Future video via language actions | Qwen-RobotWorld | ✓ Yes |
| Multi-agent WM | Shared state across N agents | Agora-1 (Odyssey) | ✓ Yes |
| Omnimodal WM | States + video + audio + actions | Cosmos 3 | ✓ Yes |
| Unified multimodal WM | Video from any-modality | Gemini Omni | ⚠️ Claimed |
| Vision-Language-Action | Actions only | π0, GR00T N1, Gemini Robotics | ✗ Policy |
| Knowledge-based | Outputs from encoded rules | Leap71 Noyron | ✗ Not learned |

**Latent-space models** like V-JEPA 2 and DreamerV3 predict in compressed representation spaces, faster and more efficient than pixel prediction, but harder to inspect. TD-MPC2 offers an alternative latent-space approach using temporal-difference learning rather than reconstruction, scaling to 104 continuous control tasks. **Pixel-space models** like NVIDIA Cosmos Predict and Google DeepMind's Genie 3 generate full video frames, making predictions visually interpretable but computationally expensive and sensitive to pixel-level noise that latent-space models filter out. **Omnimodal models** like NVIDIA's Cosmos 3 (June 2026) go further, unifying latent-space reasoning with pixel-space generation in a single Mixture-of-Transformers architecture: an autoregressive "reasoner" tower handles language and vision understanding while a diffusion-based "generator" tower produces video, audio, and action outputs, collapsing what were previously separate VLM, video generator, and VLA pipelines into one model. **4D scene-space models** like TesserAct and Marble predict the evolution of explicit 3D geometry over time, enabling novel-view synthesis and spatial reasoning that flat video cannot provide, at higher computational cost. **Physics-informed models** blend learned dynamics with known constraints (conservation laws, kinematic limits), useful when some physics is understood. **World Action Models** like DreamZero and Being-H0.7 learn state transitions and action affordances together, enabling both prediction and policy learning in a unified framework. A three-axis taxonomy (Reuss 2026) decomposes WAMs along paradigm (inverse dynamics vs. joint prediction vs. representation-only), action integration (tokens vs. image vs. latent plans), and architecture (hierarchical vs. monolithic vs. Mixture-of-Transformers). MoT is emerging as the dominant WAM architecture, already the default in Pi-0, Pi-0.5, LingBot-VA, and Fast-WAM. **Language-conditioned world models** like Alibaba's Qwen-RobotWorld take a different approach: rather than encoding actions as tokens or latent variables, they use natural language descriptions as the action interface. Qwen-RobotWorld couples a frozen VLM (Qwen2.5-VL) with a video-VAE via a 60-layer MMDiT, trained on 8.6M video-text pairs across 20+ embodiments. This enables cross-domain transfer (manipulation, driving, navigation) through a shared language interface, at the cost of language's imprecision for fine-grained motor control. **Unified multimodal models** like Google's Gemini Omni process text, images, audio, and video in a single token space, generating video outputs grounded in cross-modal reasoning. Google positions Omni as a world model with intuitive physics understanding, but no technical paper, benchmarks, or architecture details have been disclosed, and its world model status remains a marketing claim pending verification. **A cross-cutting limitation:** all approaches above support only a single active agent. **Multi-agent world models** like Odyssey's Agora-1 address this by decoupling simulation from rendering: a world state model tracks multiple agents' positions and interactions, while a separate DiT-based renderer generates consistent visuals from each agent's viewpoint. This mirrors traditional game engine architecture (physics engine + renderer) but with entirely learned components, enabling shared-world simulation for fleet robotics, multi-robot coordination, and adversarial scenarios where agents must reason about each other's actions.

In contrast, **Vision-Language-Action models** (VLAs) like π0, NVIDIA GR00T N1, or Google's Gemini Robotics map observations directly to robot actions without explicit world modeling -- they're powerful policies, but lack the predictive simulation capability that defines world models. A middle ground is emerging: Goal-VLA (Chen et al. 2026) uses image-generative VLMs not as action predictors but as goal-state generators -- imagining what the world should look like after successful manipulation, then deriving poses from the generated image. This reframes the VLM as an object-centric world model without fine-tuning it into a policy. **Knowledge-based systems** encode rules manually rather than learning from data.

**Can LLMs become world models?** Google DeepMind's Gemini Omni (May 2026) is the most direct attempt. It fuses Gemini's reasoning, Veo's video generation, and Genie's world simulation into a single multimodal model: processing text, images, audio, and video in one token space. Pichai frames the shift as "from predicting text to simulating reality," a strategic pivot from DeepMind's earlier portfolio approach (separate systems for reasoning, simulation, and action) toward architectural unification.

The caveat: Omni's world model credentials are unverified. No technical paper or benchmarks exist. Hassabis himself set a "physics-grade" bar: models must follow Newton's laws accurately, not just produce visually plausible video. Whether Omni meets this standard is unknown. Until quantitative evaluation exists, it belongs in the "claimed" category.

**JEPA as cross-domain principle:** The Joint-Embedding Predictive Architecture (JEPA) originated in image self-supervised learning (I-JEPA, 2023) and scaled through video (V-JEPA, V-JEPA 2) to internet-scale pretraining with action-conditioned planning. Beyond this core vision lineage, JEPA has proven surprisingly versatile. Researchers have adapted it to healthcare diagnostics (EchoJEPA), materials science (Polymer-JEPA), wireless telecommunications (WirelessJEPA), and even language modeling itself (LLM-JEPA applies JEPA training objectives to Llama3, Gemma2, and Olmo, producing representations that match or exceed masked-prediction baselines on downstream tasks, ICLR 2026). The core idea, predict in embedding space rather than raw observations, generalizes beyond video to any domain with temporal or spatial structure, including the token sequences that LLMs already operate on. See sidebars for detailed applications.

### A Note on Terminology

The term "world model" has become marketing-inflated. Not everything labeled "World Foundation Model" meets the definition.

**The strict definition** requires: (1) learned from data, (2) maintains internal state, (3) predicts future states, (4) enables simulation. This is the consensus view across academic surveys and reflects the cognitive science origins of the term. A consequence: systems that genuinely learn dynamics, rather than memorizing artifact-specific transitions, naturally generalize across environments. Transferability is therefore a strong indicator of a true world model (Richens & Everitt, ICML 2025).

**What's often mislabeled:**

| System | Marketing Label | Reality |
| ------ | --------------- | ------- |
| Cosmos Reason (standalone) | "World Foundation Model" | VLM that analyzes video and outputs text, no future prediction. Now subsumed into the Cosmos 3 unified architecture |
| Cosmos Transfer | Part of Cosmos family | Domain translation (transforms style, doesn't predict futures) |
| VLAs (π0, GR00T N1) | "Physical AI" / "Foundation Model" | Policies that map observations to actions without state prediction |
| Agentic "world models" | "World Model" for digital agents | Ranges from narrow UI-transition simulators to broader frameworks. Wang et al. (2025) propose a "levels × laws" taxonomy (Predictor → Simulator → Evolver across physical, digital, social, and scientific domains) that partially maps to the L1-L4 levels above, but most deployed agentic "world models" remain environment-specific |

**Why this matters:** When evaluating vendor claims, apply the litmus test: *can it predict what happens next without executing the action?* Cosmos Predict passes. Cosmos Reason does not. It's a powerful VLM trained on physical reasoning, but it analyzes rather than simulates. Both are useful; only one is a world model.

**The broader pattern:** As world models gain attention, expect more systems to adopt the label. The four defining characteristics provide a filter: if it doesn't predict future states from learned representations, it may be valuable but isn't a world model.

## Current Capabilities and Limitations

### Capability Levels

Not all world models are equally capable. A useful framework from healthcare AI research distinguishes four capability levels:

| Level | Capability | Description | Current Status |
| ----- | ---------- | ----------- | -------------- |
| **L1** | Temporal prediction | Predict next state from observations | ✓ Broadly achieved |
| **L2** | Action-conditioned | Predict next state given an action | ✓ Research + emerging production |
| **L3** | Counterfactual | "What if X instead of Y?" | ⚠️ Nascent research |
| **L4** | Closed-loop planning | Simulate trajectories, select best action | ⚠️ Domain-specific only |

**Where production systems land:** Tesla FSD and BADAS 2.0 operate at L2: they predict future states conditioned on actions, but within narrow domains (driving). Cosmos Predict is L1-L2, primarily used for synthetic data generation rather than planning. No general-purpose L4 system exists for real-world physical tasks.

**The research frontier:** L3 counterfactual reasoning is where active research concentrates. Causal-JEPA demonstrates ~20% improvement on counterfactual question-answering by using object-level masking, but isn't deployed. L4 closed-loop planning works in simulation (DreamerV3 achieves superhuman performance in Atari and DMControl) but hasn't transferred to general-purpose physical world planning. DINO-WM demonstrates a promising middle ground: by learning dynamics in frozen DINOv2 feature space, it achieves zero-shot goal-reaching across diverse manipulation tasks without task-specific training, but remains limited to short-horizon, single-step goals.

**WAMs: Designed for L3-L4.** World Action Models represent the first architecture explicitly designed to reach L3-L4 in real-world robotics. They unify world modeling and action generation, enabling a model to simulate multiple action trajectories ("what if I grasp here vs. there?") and select the best one before execution. DreamZero reached 1750 Elo on RoboArena trained only on DROID, and Sereact's Cortex 2.0 is the first confirmed industrial WAM deployment. NVIDIA's GR00T N2 (planned late 2026) bets on this architecture, integrating Cosmos as the world model backbone. See Sidebar B for architecture details, cost analysis, and deployment status.

**Key limitations:** Video-based models maintain consistency for minutes at most. Latent-space models accumulate prediction error over long rollouts. Systematic causal reasoning remains nascent. These gaps explain why world models excel at synthetic data generation (L1-L2) but haven't yet displaced traditional planning systems for real-world robotics.

**The benchmark crisis:** Popular robot manipulation benchmarks are less informative than they appear. A systematic audit (Jiang et al. 2026) found that LIBERO, the most-cited benchmark, is solvable by a 0.09B probe with no language encoder, scoring at or near reported SOTA. Models claiming 98% success collapse to 0-40% under moderate perturbations (changed instructions, object poses, viewpoints). CALVIN is similarly saturated. The implication: benchmark scores in recent VLA papers often reflect overfitting to narrow evaluation setups, not genuine manipulation capability. When evaluating vendor claims, ask for results on multiple benchmarks (RoboVerse, RoboChallenge Table30) and real-world validation (RoboArena), not just LIBERO numbers.

**The L4 workaround in practice:** Current JEPA-based planners sidestep long-horizon planning rather than solving it. Prediction quality degrades beyond short rollouts, so the practical strategy is MPC (Model Predictive Control): plan a short action sequence, execute a few steps, replan. This works for reversible manipulation but cannot anticipate irreversible consequences (cutting, pouring, precision assembly). An emerging alternative, amortized planning (Nguyen et al. 2026), eliminates the iterative search loop by training a single-pass goal-conditioned model, matching iterative planners at 100-130x lower cost (see Speed-Inspectability Tradeoff below for details). For longer horizons, hierarchical planning decomposes tasks into subgoals at multiple temporal scales: Hierarchical World Models (Zhang, Terver et al. 2026) achieves 70% success on real-robot pick-and-place from a single goal image versus 0% for flat planning, model-agnostic across V-JEPA-2-AC, DINO-WM, and PLDM.

### The Continual Learning Gap

Current world models are essentially static after training. They can simulate futures but don't learn from deployment experience. The core obstacle is catastrophic forgetting: updating weights with new observations erodes previously learned physics. Production systems like Tesla work around this with offline cycles (collect data in shadow mode, retrain in clusters, push firmware updates) rather than adapting in real-time.

The vision of long-running agents that refine their world model through reinforcement learning from lived experience remains unrealized. **Active Inference** (Verses AI's AXIOM) attempts to solve this with hierarchical local updates: instead of retraining the entire model, agents update small modular branches for specific environments or tools. It's shown promise in limited domains (Atari) but hasn't scaled to real-world robotics.

This gap matters because, as Rich Sutton's "Big World Hypothesis" argues, the world is too complex for agents that can't continually adapt.

### The Sim-to-Real Gap

Models trained purely in simulation often fail when deployed in the real world. Friction, lighting, and sensor noise differ from their mathematical abstractions. World models address this through domain-bridging strategies: pretraining on real-world video before simulation fine-tuning (JEPA), domain randomization during training, or explicit style transfer (Cosmos Transfer). The goal is learning physics representations that generalize beyond any single environment's quirks.

## Selecting an Approach

### The Speed-Inspectability Tradeoff

When selecting a world model approach, there's a fundamental tradeoff between inference speed and the ability to inspect what the model predicts. **Latent-space models** like JEPA and DreamerV3 achieve fast inference (100-500ms per prediction) by predicting future states in compressed embedding spaces -- but these predictions aren't human-readable. The total planning cost is higher: iterative search (CEM, MPPI) over candidate action sequences adds significant overhead. Recent work on amortized planning (Nguyen et al. 2026) replaces this search with a learned goal-conditioned mapping, matching iterative planners at 100-130x lower decision cost. You can't visualize what the model thinks will happen; you can only observe the downstream decisions it makes. **Pixel-space models** like Cosmos and Genie operate at the opposite extreme: they generate full video frames, making predictions directly inspectable, but at a computational cost, often 5000ms or more per prediction.

**World Action Models** like DreamZero-Flash represent an emerging middle ground, achieving both speed (~150ms) and interpretability by learning compact action-conditioned representations that can be decoded into visual predictions when needed. **4D scene-space models** like TesserAct sit beyond pixel-space on the inspectability axis: they produce full 3D geometry that supports novel views and spatial reasoning, at the highest computational cost. **Physics-informed models** occupy a variable position depending on the domain and how much computation the physics constraints require.

<img src="diagrams/speed-inspectability.png" alt="Speed vs Inspectability Tradeoff" width="800">

Different use cases demand different positions on this spectrum. **Real-time robotics control** requires sub-second inference, making latent-space models the practical choice even if predictions are opaque. **Synthetic training data generation** needs visible, inspectable outputs (generating video frames for robot vision models or simulation scenarios), making pixel-space models worth the computational cost despite slower inference. **Human oversight and debugging** benefit from inspectability; if you need to understand why a model made a particular prediction, pixel-space or WAM approaches provide interpretability that latent-space models cannot.

### Matching Approaches to Use Cases

Here's how to map requirements to approaches:

| Use Case                 | Key Requirement   | Best Fit                     | Why                 |
| ------------------------ | ----------------- | ---------------------------- | ------------------- |
| Real-time robot control  | Speed (<100ms)    | VLA or distilled WM          | Latency dominates   |
| Synthetic training data  | Inspectable video | Cosmos, Genie                | Need to see output  |
| Medical diagnostics      | Noise filtering   | JEPA                         | Filters artifacts   |
| Digital twins            | Multi-physics     | PhysicsNeMo + Omniverse      | Known physics       |
| Materials/drug discovery | Sparse data       | Graph-JEPA, physics-informed | Sample efficiency   |
| Autonomous vehicles      | Noise resilience  | V-JEPA 2                     | Lighting invariance |
| Multi-robot coordination | Shared state      | Multi-agent WM (Agora-1)     | N-agent interaction |

**Honest caveats:** no approach is universally superior. What to watch for:

| Approach           | What to watch for                                                                              |
| ------------------ | ---------------------------------------------------------------------------------------------- |
| JEPA               | Strong in research; production emerging (BADAS 2.0); AMI Labs has no shipped products yet      |
| Cosmos/Pixel-space | Slow for planning loops; best for data generation, not real-time control                       |
| VLAs               | Not world models, can't simulate alternatives; limited physics understanding                   |
| WAMs               | 7.4x training cost over VLAs; first industrial deploy (Sereact); Fast-WAM may fix inference    |
| Physics-informed   | Requires domain expertise to encode constraints correctly                                      |
| Knowledge-based    | Powerful when rules are codifiable (Noyron); not applicable when physics must be learned       |
| Multi-agent WM     | Only demonstrated on game environments (GoldenEye); real-world physics transfer unproven       |

### Foundation vs Custom

Like LLMs, world models now come in foundation variants. NVIDIA Cosmos (Apache 2.0), Meta's V-JEPA 2, and GR00T N1 offer open weights for fine-tuning to specific domains. The challenge is data: pixel-space models may require millions of domain-specific frames to specialize. JEPA-based models can fine-tune on thousands, making them practical for organizations with limited labeled data.

**A scaling caveat:** Unlike LLMs, bigger is not always better. The JEPA-WMs ablation found that larger models hurt planning performance on simulated tasks but helped on real-world robotic data. Task complexity, not parameter count, determines whether scaling pays off.

## Integration and Ecosystem

### LLMs and World Models Together

LLMs and world models are complementary, not competing. LLMs excel at language understanding, goal interpretation, and human interface. World models excel at physics simulation, dynamics prediction, and consequence forecasting. The most capable systems combine both.

**Combined architectures** are emerging at varying levels of integration. At the loose end, Cosmos Predict uses Cosmos Reason as its text encoder for richer prompt understanding, but they don't run jointly at inference; developers chain them in workflows. At the tighter end, ThinkJEPA (Gao et al. 2025) pairs a VLM "thinker" (Qwen3-VL) with a JEPA "controller" (V-JEPA 2) in a dual-path architecture: the VLM reasons about goals and context while the JEPA model handles latent-space dynamics prediction, enabling long-horizon embodied planning that neither component achieves alone. A third pattern is **composable tool-use**: Alibaba's Qwen-RobotClaw uses a general-purpose VLM as an orchestrator that invokes specialized models (Qwen-RobotWorld for simulation, Qwen-RobotManip for manipulation, Qwen-RobotNav for navigation) as callable tools via language interface, with context and memory management for long-horizon tasks. This trades end-to-end optimization for modularity: each model can be updated independently, and the VLM handles task decomposition and sequencing.

The emerging pattern: human intent expressed in language → LLM/VLM interprets and decomposes goals → world model simulates candidate actions → LLM/VLM selects best option → execution in physical environment. The integration level varies: pipeline (Cosmos), dual-path (ThinkJEPA), tool-use (Qwen-RobotClaw), or fully unified (Cosmos 3).

This matters for agentic AI. Current autonomous agents plan by generating tokens, sequences of actions described in text. Future agents will plan by simulating futures, evaluating trajectories in learned world models before committing to action. LLMs provide the interface and reasoning; world models provide the physics. Together, they enable agents that understand what you want and predict what will happen.

### The NVIDIA Ecosystem

NVIDIA offers the broadest ecosystem for physical AI, spanning world models, robot control, physics simulation, and deployment infrastructure. Understanding which components are actually world models (vs. policies or platforms) helps clarify what you're getting:

| Component              | What It Does                                      | World Model?                   |
| ---------------------- | ------------------------------------------------- | ------------------------------ |
| **Cosmos Predict**     | Generates future video frames from observations   | ✓ Yes — pixel-space WM         |
| **Cosmos 3**           | Unified reasoning + video/audio/action generation | ✓ Yes — omnimodal WM           |
| **Cosmos Transfer**    | Domain translation (sim→real style transfer)      | ✗ No — translation             |
| **Cosmos Reason**      | VLM for physical reasoning about video            | ✗ No — analyzes, no simulation |
| **PhysicsNeMo**        | Predicts physical states with physics constraints | ✓ Yes — physics-informed WM    |
| **GR00T N1**           | Maps observations → robot actions                 | ✗ No — VLA policy              |
| **GR00T N2** (planned) | Combines Cosmos backbone with action prediction   | ✓ Yes — WAM                    |
| **Isaac Sim**          | Physics simulation environment                    | ✗ No — pure simulation         |
| **Omniverse**          | 3D collaboration/visualization platform           | ✗ No — platform                |

**PhysicsNeMo explained:** An open-source framework for building physics-informed neural surrogates, i.e. AI models that predict how physical systems evolve while respecting known physics constraints. Rather than learning physics from scratch, it embeds partial differential equations (Navier-Stokes, heat transfer) directly into training, achieving 500x speedup over traditional computational fluid dynamics while respecting conservation laws. It qualifies as a world model because it predicts future physical states, but it's narrower in scope than video-based approaches.

**Cosmos evolution:** Earlier Cosmos releases separated reasoning (Cosmos Reason) from generation (Cosmos Predict), requiring developers to chain them in workflows. Cosmos 3 (June 2026) unifies both into a single Mixture-of-Transformers model: its reasoner tower performs physical understanding while its generator tower simulates futures, eliminating the pipeline.

<img src="diagrams/nvidia-ecosystem.png" alt="NVIDIA Physical AI Ecosystem" width="800">

**What's open:** Cosmos 3 is released under the OpenMDW-1.1 license with open weights, code, and five curated synthetic datasets. GR00T N1 remains Apache 2.0. PhysicsNeMo and Isaac ROS are open source. This enables on-premise deployment and fine-tuning for specialized domains. **What's proprietary:** Omniverse and Isaac Sim remain closed, requiring licenses and often NVIDIA hardware for full functionality. An open-source alternative is emerging: Genesis World (29K GitHub stars, Apache 2.0) provides unified multi-physics simulation with a cross-platform compiler (Quadrants) that targets CUDA, AMD ROCm, Apple Metal, and Vulkan, demonstrating that hardware-neutral physics simulation is architecturally feasible, not just aspirational.

**The insight:** Open weights lower the entry barrier, but extracting full value from the ecosystem often requires proprietary components or NVIDIA GPUs. For organizations with compliance constraints or limited budgets, the open components provide a viable starting point. For those seeking turnkey solutions, the full stack delivers integration at the cost of vendor lock-in.

## What's Deployed Today

World models are not speculative research. Production deployments exist today, with significant expansion planned over the next 24 months.

| Horizon        | Examples                                                                                   |
| -------------- | ------------------------------------------------------------------------------------------ |
| Deployed today | Tesla FSD (millions of vehicles), BADAS 2.0/Nexar, Cosmos (2M+ DLs), Sereact Cortex 2.0    |
| Deploying 2026 | Wayve Tokyo robotaxi, GXO humanoid warehouse pilots, Alibaba Qwen-Robot (enterprise pilot) |
| 1-2 years      | GR00T N2 (next-gen robot foundation model), AMI Labs commercial products                   |
| Research       | Scaling laws for world models, long-horizon temporal consistency                           |

**Funding and competitive signals indicate enterprise confidence:** AMI Labs raised $1.03B (JEPA commercialization), World Labs $1B (3D world generation), Odyssey $310M (multi-agent world simulation), Periodic Labs $300M (materials discovery), Genesis AI $105M (full-stack dexterous robotics). Alibaba entered with a full composable model suite (Qwen-RobotWorld + RobotManip + RobotNav + RobotClaw), already in enterprise pilot testing, making it the fifth Big Tech player in Physical AI alongside NVIDIA, Meta, Google, and Tesla. VLA research submissions to ICLR grew 18x in one year (9 at ICLR 2025 to 164 at ICLR 2026). The question is no longer "will world models work?" but "which approaches scale fastest and where?"

---

## Sidebars

### Sidebar A: Healthcare, Where Noise Filtering Wins

Medical imaging is a domain where JEPA's core advantage, predicting in latent space rather than pixel space, delivers measurable clinical value. The problem isn't a lack of data or compute; it's that raw medical images are inherently noisy, and pixel-level predictions amplify that noise rather than filtering it.

**The noise problem:** Ultrasound imaging suffers from speckle artifacts (granular interference patterns caused by coherent wave interference) that obscure anatomical boundaries. MRI scans contain motion artifacts when patients breathe or shift position during acquisition. Low-dose CT (used to minimize radiation exposure) introduces photon noise that degrades image quality. Traditional approaches that predict or reconstruct at the pixel level treat these artifacts as signal, learning to reproduce noise patterns rather than filtering them out. The result: models that hallucinate false structures or miss clinically relevant features hidden beneath noise.

**Why JEPA fits:** By predicting future states in embedding space rather than reconstructing raw pixels, JEPA-based models naturally filter noise. The latent representations learned during pretraining capture the underlying anatomical structure (cardiac wall motion, valve dynamics, tissue boundaries) while discarding pixel-level variation that doesn't contribute to these patterns. When fine-tuned for clinical tasks like ejection fraction estimation or valve classification, the model operates on representations where noise has already been compressed away. This isn't a side benefit; it's the fundamental advantage of latent-space prediction in high-noise domains.

**Concrete evidence (EchoJEPA):** Researchers at Stanford pretrained a JEPA model on 18 million echocardiogram frames spanning 300,000 patients, then fine-tuned for cardiac function assessment. The result: approximately 20% improvement in accuracy on metrics like ejection fraction and left ventricular volume compared to supervised baselines trained on the same labeled data. The key insight: most of that improvement came from the model's ability to ignore speckle artifacts and focus on structural patterns (wall thickening, chamber dilation) that correlate with disease.

**US-JEPA and foundation model benchmarks:** The first comprehensive comparison of foundation models for ultrasound imaging introduced the SALT (Stable Adversarial Learning with high-norm Token units) objective to stabilize JEPA training on ultrasound data, which exhibits more extreme noise than natural video. The study compared JEPA against contrastive methods (SimCLR, MoCo) and masked approaches (MAE) across multiple ultrasound tasks. Finding: JEPA variants consistently outperformed alternatives on noisy data, confirming that latent-space prediction generalizes beyond echocardiography to broader ultrasound applications.

**Beyond imaging:** The noise-filtering principle extends to temporal prediction in medical contexts. MeWM (Medical World Model) simulates tumor evolution over time, learning representations that capture disease progression while filtering patient-specific noise. Foresight predicts medical event timelines (disease onset, treatment response, complications) from electronic health records, where data is sparse, noisy, and irregularly sampled. These aren't imaging tasks, but the same principle applies: predict in latent space to focus on clinically meaningful patterns.

**Cross-domain applicability:** Any domain with high observation noise benefits from latent-space prediction: industrial vibration sensors, satellite imagery, RF signals (WirelessJEPA for telecommunications), and financial time series. The pattern holds: when raw observations contain artifacts that obscure underlying structure, predicting in embedding space filters noise naturally.

**The regulatory angle (timing matters):** FDA issued its first guidance on using AI in drug development in January 2025, signaling regulatory acceptance of AI-driven discovery but leaving validation pathways undefined. The EU AI Act's high-risk provisions for medical devices take effect in August 2026, requiring conformity assessments for clinical decision support systems. This creates an early-mover advantage: organizations that validate JEPA-based diagnostic models now can establish precedent before regulatory frameworks solidify. Noise filtering is both a technical and compliance advantage when models must demonstrate robustness to real-world data variability.

**NVIDIA's position (weak here):** The leading work comes from academic labs (Stanford, MIT) and startups like AMI Labs. Medical imaging requires sample efficiency, noise resilience, and interpretability for clinicians, where JEPA has advantage but production deployments remain unproven at scale.

### Sidebar B: Robotics, Three Paths to Robot Actions

Robot manipulation requires completing a perception-prediction-action cycle at 7-30 Hz, meaning the system has just 33-143ms to process sensor data, predict consequences, and output motor commands. This tight latency constraint shapes which architectures can deploy in production versus remaining in research labs. Three distinct approaches have emerged, each making different tradeoffs between speed, physics understanding, and deployability.

<img src="diagrams/robotics-three-paths.png" alt="Three Paths to Robot Actions" width="800">

| Path          | Speed           | Physics Understanding   | Deployed?                                      |
| ------------- | --------------- | ----------------------- | ---------------------------------------------- |
| VLA           | ~50ms           | Limited (static images) | Yes (Figure AI, Boston Dynamics)               |
| WAM           | ~150-800ms      | Good (video backbone)   | Industrial (Sereact), planned (GR00T N2)       |
| WAM (rep-only)| ~sub-200ms      | Good (video backbone)   | Research (Fast-WAM) -- pending real-robot eval |
| JEPA-planning | ~100-500ms      | Good (temporal)         | Research (V-JEPA 2-AC), production (BADAS 2.0) |

**Vision-Language-Action (VLA) models** map directly from camera images and language instructions to robot joint angles with no intermediate world model, no prediction of future states. They're fast because they skip simulation, achieving ~50ms inference on modern GPUs. But this speed comes at a cost: VLAs learn reactive control patterns without building internal physics representations. They know "when I see this gripper configuration and you say 'grasp', output these motor commands," but they can't answer "what happens if I grasp 2cm to the left?" That limits their ability to adapt to novel scenarios or recover from unexpected perturbations.

**World Action Models (WAMs)** like DreamZero, Being-H0.7, and the planned GR00T N2 unify state prediction and action generation in a single architecture, typically using video foundation models as backbones. They learn joint representations of observations and actions, enabling them to simulate future states *while* predicting optimal actions. Standard WAM inference runs at 590-800ms per action chunk (3-4x slower than VLAs) because the model must generate video alongside actions. Fast-WAM demonstrates a representation-only mode that skips video generation at inference, cutting latency to sub-200ms while matching performance on simulation benchmarks, pending real-robot validation. Sereact's Cortex 2.0 is the first confirmed industrial WAM deployment, using latent-space trajectory scoring for manipulation planning.

**JEPA-based planning** decouples world modeling from action selection: the JEPA model predicts future states in latent space, then a separate policy network or planning algorithm selects actions. This architecture enables sophisticated multi-step planning, simulating dozens of candidate trajectories and selecting the one most likely to succeed, but at the cost of higher latency (100-500ms depending on how many rollouts are evaluated). V-JEPA 2-AC demonstrates this in research settings; BADAS 2.0 (deployed by Nexar for autonomous driving) uses V-JEPA2 predictions to improve real-time decision-making.

**Not all encoders are equal for planning.** Image encoders (DINO) outperform video encoders (V-JEPA) for manipulation planning. DINO's training forces each patch to encode which object it belongs to, producing sharp object-background separation in embedding space. Video encoders optimize for temporal coherence, which doesn't require precise spatial boundaries. For a planner that needs to distinguish "cup here" from "cup there," spatial precision matters more than motion understanding. This encoder advantage has spawned a family of DINO-based world models: DINO-WM learns dynamics in frozen DINOv2 features for zero-shot planning, DINO-world scales this to a generalist video world model trained on uncurated video, and DINO-Foresight forecasts future DINO features for scene understanding tasks like segmentation and depth prediction.

**The practical pattern emerging in production robotics: use slow-but-accurate approaches for offline training, then distill into fast VLAs for real-time deployment.** The workflow: train a JEPA-based planner to solve manipulation tasks by simulating thousands of trajectories per grasp. Record the successful action sequences. Train a VLA to imitate those JEPA-planned trajectories using behavioral cloning. The result: a VLA that executes at 50ms but has inherited physics knowledge from the world model that generated its training data. This distillation strategy lets you have both speed and understanding. The VLA doesn't *contain* a world model, but it was shaped by one.

**Who's deploying what today:** VLAs dominate production robotics. Figure AI's Figure 02, Unitree's G1, 1X's NEO, and Agility's Digit use VLA-style architectures based on GR00T N1 or Physical Intelligence's π0. Boston Dynamics partners with multiple providers, including Google DeepMind's Gemini Robotics for inspection tasks. These systems achieve the 7-30 Hz control rates required for stable bipedal locomotion and dexterous manipulation. Genesis AI takes a different approach with GENE-26.5: a flow-matching architecture (rather than autoregressive) across five modalities (language, vision, proprioception, tactile, action), demonstrating complex dexterous tasks like in-air Rubik's Cube solving and 20-step cooking with <1 hour of task-specific data, though no independent benchmarks have been published. WAMs have their first industrial deployment: Sereact's Cortex 2.0 uses WAM-style trajectory scoring in production manipulation systems. NVIDIA's GR00T N2 (planned late 2026) will integrate Cosmos as a world model backbone. JEPA-based approaches have exactly one confirmed production deployment (BADAS 2.0), making them the most theoretically promising but least commercially validated path.

**The key insight: VLAs are not world models.** They map observations to actions without predicting future states, so they can't simulate "what if I do X instead of Y?" But they can *benefit* from world models during training through distillation, inheriting physics knowledge without the inference cost. This distinction matters when evaluating vendor claims: a robot using GR00T N1 is running a VLA policy, not a world model, even though world models may have contributed to its training data.

**The multi-agent gap:** All three paths assume a single robot acting independently. Real-world deployments increasingly involve fleets — warehouse robots sharing aisles, collaborative assembly cells, multi-vehicle coordination. Current world models can't simulate these interactions: each agent gets its own rollout with no shared state. Odyssey's Agora-1 ($310M Series B, Jun 2026) is the first world model to address this, decoupling a shared state model from per-agent rendering, but it has only been demonstrated on game environments. Until multi-agent world models prove out on real-world physics, fleet coordination relies on traditional multi-agent planning algorithms layered on top of single-agent perception.

**NVIDIA's positioning:** Strong in both VLA (GR00T N1 deployed broadly) and WAM (GR00T N2 in development with Cosmos integration). Primary VLA competitors are Physical Intelligence's π0 and Google DeepMind's Gemini Robotics (~250ms latency, cloud-first architecture). The real test comes in late 2026 when GR00T N2 deploys: if WAMs prove faster and more capable than distilled VLAs, NVIDIA pulls ahead. If the distillation pattern continues to dominate, the market fragments across multiple vendors.

### Sidebar C: Discovery, From Learned to Engineered

Scientific discovery (materials, drugs, and product design) is where world models meet their most demanding economics. Traditional R&D cycles span 20+ years and cost hundreds of millions per successful new material or drug. AI-enabled discovery aims to compress these timelines by 10x, exploring thousands of candidate designs computationally before committing to expensive physical validation. The bottleneck isn't compute or data; it's choosing the right approach along a spectrum from purely learned world models to hand-engineered knowledge systems.

**The spectrum from learned to engineered** spans three categories, each with distinct data requirements and physics encoding strategies:

1. **Pure learned world models** require large datasets but discover patterns implicitly. DeepMind's GNoME predicted 2.2 million stable crystal structures by learning formation energy landscapes from materials databases, with no physics equations encoded. It identified 528 new lithium-ion conductors, 39 experimentally validated. This approach excels when labeled data is abundant and physics is too complex to write down, but demands millions of training examples to generalize reliably.

2. **Physics-informed models** blend learned dynamics with explicit constraints (partial differential equations, conservation laws, kinematic limits). NVIDIA's PhysicsNeMo embeds Navier-Stokes equations into neural networks for fluid simulation, achieving 500x speedup over traditional CFD for aircraft fatigue analysis while guaranteeing mass and momentum conservation. Hamiltonian Neural Networks learn dynamics that preserve energy, preventing the drift errors that plague pure learned models in long-horizon simulation. These approaches need less data than pure learning because physics priors constrain the hypothesis space, but they require domain expertise to encode constraints correctly.

3. **Knowledge-based systems** encode expert rules directly, no learning required. Leap71's Noyron designed and hot-fired rocket engines without a single neural network: pure computational engineering, codifying thermodynamics, fluid mechanics, and material constraints as explicit rules. When physics is fully understood and codifiable, knowledge-based approaches win: they're faster, deterministic, and require no training data. But they fail when dynamics must be *discovered* rather than *written*: drug-protein binding, material phase transitions, turbulent flow regimes where first principles are intractable.

**JEPA in molecular domains** demonstrates how latent-space prediction extends beyond video to scientific discovery. **Graph-JEPA** applies JEPA principles to molecular graphs for drug discovery, predicting latent representations of molecular substructures without contrastive pairs. This enables pretraining on vast unlabeled chemical databases, then fine-tuning for specific binding affinity or toxicity prediction tasks with limited labeled data. **Polymer-JEPA** learns from unlabeled polymer structures, achieving cross-domain transfer: a model pretrained on synthetic polymers generalizes to biopolymers with minimal fine-tuning, critical when experimental data is sparse and expensive.

**Concrete impact across verticals:** In **materials**, DeepMind's GNoME predictions accelerated discovery timelines from years to months; Mitra Chem (battery materials) claims 10x faster development using learned world models. In **drugs**, Insilico Medicine's ISM001-055 went from target identification to preclinical candidate in 18 months versus the typical 4-5 years, potentially becoming the first AI-designed drug to reach Phase 3 trials. In **product design**, GM uses learned aerodynamics models to iterate vehicle designs in minutes rather than days of wind tunnel testing; PhysicsNeMo enables engineers to simulate stress, fatigue, and thermal dynamics in real-time.

**When world models lose:** Leap71 Noyron proves that when physics is fully codifiable (thermodynamics, structural mechanics, constrained-geometry flow), knowledge-based engineering outperforms learning. No training data, no hallucinations, no generalization risk. World models excel when dynamics are too complex to write as equations. But if you can write the rules, don't learn them.

**NVIDIA's positioning varies by domain.** Strong in **product design**: PhysicsNeMo integrates with Omniverse for digital twins in automotive, aerospace, and energy. Weak in **drug discovery** and **materials**: no competitive offerings against Insilico Medicine, Recursion Pharmaceuticals, or Periodic Labs. NVIDIA provides the GPUs and infrastructure, but domain expertise and specialized world models come from vertical-focused startups. Foundation world models generalize across physics-heavy domains (Cosmos for video, GR00T for robotics), but scientific discovery requires domain-specific architectures where NVIDIA's ecosystem doesn't yet extend.

---

## References

**Production Deployments:**

- **Tesla Full Self-Driving v14** — Occupancy networks deployed in millions of vehicles globally, representing the largest real-world deployment of world model concepts for autonomous driving decision-making.
- **Nexar BADAS 2.0** — First production deployment of V-JEPA2 for driver-assistance and collision avoidance, demonstrating JEPA viability in consumer automotive applications.
- **Wayve Tokyo Robotaxi Pilot** — Late 2026 launch of fully autonomous robotaxi service using world models for real-time planning and safety-critical decision-making.
- **GXO/Spanx Humanoid Deployment** — Agility Digit robot deployment in warehouse automation, powered by foundation world models for manipulation and navigation tasks.

**Key Research:**

- **EchoJEPA and US-JEPA** — Healthcare applications demonstrating JEPA's noise-filtering advantage in medical imaging across echocardiography and ultrasound domains.
- **Graph-JEPA and Polymer-JEPA** — Molecular and materials science extensions of JEPA principle, showing cross-domain applicability from video to chemical and polymer structures.
- **NVIDIA Cosmos Platform** — Foundation world model for video prediction, dynamics modeling, and synthetic data generation; Apache 2.0 licensed with 2M+ downloads.
- **[NVIDIA Cosmos 3](https://research.nvidia.com/labs/cosmos-lab/cosmos3/technical-report.pdf)** (June 2026) — Omnimodal world model unifying reasoning, video/audio generation, and action prediction in a single Mixture-of-Transformers architecture; 4B/16B/64B scales; OpenMDW-1.1 license.
- **DeepMind GNoME** — Pure learned world model discovering 2.2 million stable crystal structures, with 528 new lithium-ion conductors; validates scale of learned physics representations for materials discovery.
- **[JEPA-WMs](https://arxiv.org/abs/2512.24497)** (Terver et al. 2025) — Systematic ablation of JEPA-based world models for physical planning; identifies critical design choices for encoder, predictor architecture, rollout training, and planning optimizer.
- **[Hierarchical World Models](https://arxiv.org/abs/2604.03208)** (Zhang, Terver et al. 2026) — Hierarchical planning with latent world models at multiple temporal scales; achieves 70% real-robot pick-and-place success vs 0% for flat planning.

**Evaluation & Benchmarking:**

- **[What Are We Actually Benchmarking in Robot Manipulation?](https://arxiv.org/abs/2606.04233)** (Jiang et al. 2026) — Systematic audit of LIBERO, CALVIN, SimplerEnv, RoboCasa, and RoboTwin 2.0 exposing shortcut solvability, statistical insignificance, and overfitting in popular benchmarks.
- **[State of VLA Research at ICLR 2026](https://mbreuss.github.io/blog_post_iclr_26_vla.html)** (Reuss 2025) — Practitioner survey documenting 18x submission growth, benchmark saturation, and nine VLA research trends.
- **[The Rise of World-Action Models](https://developer.nvidia.com/blog/pretrained-to-imagine-fine-tuned-to-act-the-rise-of-world-action-models/)** (Reuss 2026) — WAM landscape survey with three-axis taxonomy, compute cost normalization (ZFLOPs), and Fast-WAM representation-only finding.
- **[Qwen-RobotWorld](https://arxiv.org/abs/2606.17030)** (Zhang et al. 2026) — Language-conditioned video world model; 60-layer MMDiT coupling frozen Qwen2.5-VL with video-VAE; 8.6M video-text corpus across 20+ embodiments.
- **[Agora-1](https://odyssey.ml/introducing-agora-1)** (Cameron et al. 2026) — First multi-agent world model; decouples simulation (world state model) from rendering (DiT conditioned on shared state); demonstrated with up to 4 agents in shared GoldenEye environment.

**Industry Analysis:**

- **Insilico Medicine ISM001-055** — First AI-designed drug candidate advancing toward Phase 3 trials, compressing drug development timeline from 4-5 years to 18 months through learned world models.
