# Key Concepts in World Models Research

> Deep dives into fundamental concepts underlying AI world models

**Last Updated**: 2026-09-01
**Last Synthesized**: 2026-07-01

---

## JEPA (Joint-Embedding Predictive Architecture)

### Overview

Joint-Embedding Predictive Architecture is Yann LeCun's framework for self-supervised learning that learns representations by predicting in an abstract representation space rather than pixel space. Originated in LeCun's 2022 position paper "A Path Towards Autonomous Machine Intelligence." Core idea: an encoder maps inputs to embeddings, a predictor maps context embeddings to target embeddings, and a target encoder (often EMA-updated) provides training signal — all without generating pixels.

### Key Technical Details

**Core Components** (per the JEPA Tutorial, Monemi et al. 2025):

1. **Context-target generation**: Masking strategy determines what the model must predict from what it observes. Patch-level masking (I-JEPA, V-JEPA), object-level masking (Causal-JEPA), antenna-time block masking (WirelessJEPA)
2. **Encoding**: Context and target encoders map inputs to representations. Target encoder typically uses exponential moving average (EMA) of context encoder weights — though LeWorldModel eliminates this requirement
3. **Latent-space prediction**: Predictor network maps context embeddings to predicted target embeddings. AdaLN-zero architecture identified as critical design choice (JEPA-WMs ablation study)
4. **Regularization**: Prevents representation collapse. VICReg-style (variance-invariance-covariance), SIGReg, or Gaussian latent regularization (LeWorldModel's 2-term approach)
5. **Energy minimization**: Compatible (context, target) pairs receive low energy; incompatible pairs receive high energy
6. **Encoder selection shapes planning utility**: The encoder's pretraining objective determines what the representation encodes, which directly affects downstream planning. DINO-style self-distillation (local-global crop matching) forces each patch token to encode spatial identity — "this patch belongs to the cup, not the table" — producing representations with strong object-background separation. Video-predictive encoders (V-JEPA) optimize for temporal coherence, which can be solved without fine-grained object boundaries. The JEPA-WMs ablation found DINO consistently outperforms V-JEPA encoders for manipulation planning, because the planner needs to distinguish target objects from surroundings in embedding space. This is a proxy objective effect: temporal prediction doesn't demand the spatial precision that planning requires

**Collapse Prevention** — the central engineering challenge:

- **VICReg**: Variance preservation (hinge loss), invariance to augmentations (MSE), covariance decorrelation. Used in EB-JEPA, V-JEPA family
- **SIGReg**: Modality-agnostic shared target distribution. Used in Le MuMo JEPA for cross-modal alignment
- **Gaussian regularization**: Enforces Gaussian-distributed latent embeddings. LeWorldModel achieves stability with only this + prediction loss (2 terms vs. 6)
- **Barlow Twins-style redundancy reduction**: Used in R2-Dreamer; conceptually parallel to VICReg
- **Variational formulation (Var-JEPA)**: Derives JEPA as a variational latent-variable model — collapse prevention emerges naturally from the ELBO objective rather than ad-hoc regularizers. Subsumes VICReg and Gaussian regularization as special cases

**JEPA Variant Lineage**:

- I-JEPA (images) → V-JEPA (video) → V-JEPA 2 (world model + action conditioning) → V-JEPA 2.1 (dense features)
- VL-JEPA (vision-language, continuous embedding prediction replacing autoregressive tokens)
- Le MuMo JEPA (multi-modal: RGB + LiDAR/thermal via learnable fusion tokens)
- Causal-JEPA (object-centric masking for causal reasoning)
- LeWorldModel (stable end-to-end from pixels, 2 loss terms, ~15M params) → LeVJEPA (SIGReg for video, no EMA/predictor/stop-gradient, 5-20x cheaper than V-JEPA 2)
- VJEPA/BJEPA (probabilistic/Bayesian extensions for uncertainty quantification)
- Var-JEPA (variational formulation — derives JEPA from latent-variable model, principled uncertainty quantification without ad-hoc regularizers)
- ACT-JEPA (unified policy + world model learning)
- Domain-specific: WirelessJEPA, JEPA-MSAC, EchoJEPA, 3D-JEPA

### How JEPA Differs

**vs. Contrastive Learning** (CLIP, SimCLR): Contrastive methods require explicit negative pairs and learn to push apart non-matching samples. JEPA avoids negatives entirely — it predicts target representations from context, using regularization to prevent collapse. This eliminates the need for carefully constructed negative sampling strategies.

**vs. Masked Autoencoders** (MAE): MAE reconstructs raw pixels/tokens from masked inputs. JEPA predicts in representation space, which (a) filters task-irrelevant variation (e.g., ultrasound speckle in EchoJEPA), (b) operates at higher abstraction enabling efficient planning, and (c) avoids the computational cost of pixel-level reconstruction.

**vs. Autoregressive Models** (GPT, LLMs): Autoregressive models predict next tokens sequentially. JEPA predicts representations of masked regions in parallel. However, Blondel et al. (2025) proved an explicit bijection between ARMs and EBMs, suggesting autoregressive models implicitly learn energy landscapes — the paradigms are more connected than they appear.

**vs. Diffusion/Flow Models** (Cosmos, Genie): Diffusion/flow models generate in pixel space — producing inspectable video outputs. JEPA operates in latent space — more efficient for planning (48x faster, per LeWorldModel) but outputs are not directly visualizable. Historically complementary (Cosmos for synthetic data, JEPA for planning), though Cosmos 3's dual-tower MoT architecture now integrates autoregressive latent reasoning alongside diffusion-based generation, blurring the boundary.

### JEPA Current State (as of 2026-09)

**Maturation signals**:

- Training stability solved: LeWorldModel achieves stable end-to-end training with minimal hyperparameters
- Systematic engineering guidance available: JEPA-WMs ablation study identifies critical design choices
- Accessible tooling: EB-JEPA library, stable-worldmodel framework, LeWM implementation
- AMI Labs ($1.03B seed) commercializing JEPA-based world models
- Var-JEPA derives JEPA from variational principles — collapse prevention emerges naturally from ELBO rather than requiring hand-crafted regularization
- LeVJEPA (Aug 2026) eliminates all architectural heuristics (EMA, stop-gradient, predictor) for video JEPA, matching V-JEPA 2 at 5-20x lower compute — the simplest competitive video pretraining recipe to date

**Active frontiers**:

- Dense features (V-JEPA 2.1): Addressing weakness in per-patch feature quality for fine-grained tasks. LeVJEPA achieves emergent patch-level organization from [cls]-only supervision without explicit patch loss — a potential alternative to V-JEPA 2.1's approach
- Causal reasoning (Causal-JEPA): Object-level masking for counterfactual understanding; 100x reduction in required latent features
- Probabilistic extensions (VJEPA/BJEPA): Uncertainty quantification for planning under stochastic dynamics
- Multi-modal fusion (Le MuMo JEPA, VL-JEPA): Integrating heterogeneous sensor inputs and language
- Cross-embodiment imitation (Demo-JEPA): One-shot transfer across robot embodiments via goal inference in V-JEPA 2.1 latent space
- Domain expansion: Telecommunications (3 papers), healthcare (EchoJEPA), autonomous driving (Le MuMo JEPA on Waymo/nuScenes)
- Regularization diversity: Three alternatives to Gaussian regularization now exist — SIGReg (LeVJEPA), sparse codes (LpWM), and contrastive inverse dynamics (AC-MTM) — suggesting task-dependent regularization rather than a single universal approach

**Open questions**:

- Optimal latent dimensionality remains unclear across papers and domains
- Scaling laws for JEPA-based world models not yet established (unlike LLMs). Worse, the JEPA-WMs ablation shows scaling is *non-monotonic*: larger encoders and deeper predictors hurt performance on simulated environments (larger embedding spaces make it harder for planning optimizers to distinguish nearby states) but consistently improve performance on real-world data (DROID). This suggests scaling benefits depend on task complexity, not a universal "bigger is better" law
- Long-horizon consistency in multi-step rollouts still challenging. The JEPA-WMs ablation found that multi-step rollout training beyond 2 steps *degrades* performance in simulation (though real-world DROID data benefits from up to 6 steps). Current practical approach is MPC — short-horizon planning (W^p=2) with frequent replanning — which sidesteps long-horizon prediction rather than solving it. This works for reversible manipulation but breaks down for irreversible actions (cutting, pouring, assembly) where consequences must be anticipated before commitment. **Emerging solution**: Hierarchical Planning with Latent World Models (Zhang, Terver et al. 2026) addresses this by learning world models at multiple temporal scales — a high-level planner generates subgoals via macro-actions, a low-level planner executes short-horizon plans to reach each subgoal. This model-agnostic approach achieves 70% success on real-robot pick-and-place from a single goal image (vs 0% for flat planning), with up to 4x compute reduction. Validates that hierarchical decomposition, not longer rollouts, is the path to long-horizon JEPA planning
- How to best integrate language reasoning with JEPA's latent prediction (VL-JEPA vs. MLLM-WM fusion)

---

## Energy-Based Models (EBMs)

### EBM Overview

Energy-Based Models learn a scalar energy function E(x, y) that assigns low energy to compatible (x, y) configurations and high energy to incompatible ones. Unlike probabilistic models that must normalize over all possible outputs, EBMs only need to compare relative energies — enabling flexible modeling of complex, multi-modal distributions without tractable partition functions.

### EBM Technical Details

**Connection to JEPA**: JEPA is fundamentally an energy-based architecture. The prediction error between predicted and actual target embeddings defines an energy landscape. Compatible (context, target) pairs receive low prediction error (low energy); incompatible pairs receive high error (high energy). The EB-JEPA library makes this connection explicit.

**ARM-EBM Bijection** (Blondel et al. 2025): Autoregressive language models are secretly energy-based models. The paper establishes an explicit bijection in function space, showing this correspondence is a special case of soft Bellman equations in maximum entropy RL. This explains how next-token prediction enables lookahead planning — the autoregressive model implicitly learns an energy function over sequences.

**Quasimetric Structure** (Kobanda & Radji 2026): Intrinsic (least-action) energies in JEPAs constitute quasimetrics under closure and additivity conditions. This links JEPA energy functions to Quasimetric Reinforcement Learning's value class, providing theoretical grounding for using energy functions in goal-reaching control. Symmetric finite energies are structurally incompatible with one-way reachability, motivating asymmetric formulations.

### How EBMs Differ

**vs. Likelihood-Based Models** (VAEs, normalizing flows): Likelihood-based models must compute or approximate the partition function Z for normalization. EBMs avoid this — they only need relative energy comparisons, enabling more flexible architectures. The trade-off: sampling from EBMs requires MCMC or other iterative methods.

**vs. GANs**: Both avoid explicit likelihood computation. GANs use adversarial training (generator vs. discriminator), while EBMs use contrastive divergence or score matching. EBMs provide a more principled energy landscape that can be used directly for planning and inference.

**vs. Diffusion Models**: Diffusion models learn score functions (gradients of log-probability), which are closely related to energy gradients. Score-based diffusion can be viewed as a specific instantiation of EBM training. The Cosmos family uses flow-based (related to diffusion) generation in pixel space, while JEPA-style EBMs operate in latent space.

### EBM Current State (as of 2026-04)

The EBM framework is converging with JEPA — both use energy-based formulations, both avoid explicit reconstruction, and both use regularization to prevent collapse. The ARM-EBM connection bridges the autoregressive and energy-based paradigms theoretically, while JEPA provides the practical architecture. Key open question: whether EBM-style energy landscapes can enable more principled planning than current rollout-based approaches.

---

## Dragon Hatchling (BDH)

### BDH Overview

Baby Dragon Hatchling (BDH) is a biologically-inspired LLM architecture from Pathway that replaces the transformer's attention mechanism with a scale-free network of locally-interacting neuron particles. Uses Hebbian learning for working memory via synaptic plasticity, producing models that match GPT-2 performance at 10M-1B parameters while providing built-in interpretability.

### BDH Technical Details

- Scale-free network topology with heavy-tailed degree distributions and high modularity matching biological neural networks
- Hebbian working memory via synaptic plasticity; individual synapses strengthen for specific concepts during processing
- Spiking neurons with excitatory/inhibitory dynamics and sparse, positive activation vectors
- Built-in monosemanticity at the architecture level — sparse activations on language tasks provide interpretability without post-hoc analysis (unlike transformers requiring mechanistic interpretability)
- GPU-optimized state-space formulation enables efficient execution despite non-standard architecture

### How BDH Differs

**vs. Transformers**: Transformers use global attention (all-to-all token interaction); BDH uses local interactions in a scale-free topology. Transformers store context in KV cache; BDH uses synaptic plasticity. Transformers require post-hoc interpretability analysis; BDH provides built-in monosemantic activations.

**vs. Other Bio-Inspired Approaches**: Unlike previous spiking neural network research that focused on neuromorphic hardware efficiency, BDH targets competitive language modeling performance at scale, demonstrating that biological principles can match transformer performance rather than merely offering hardware advantages.

### BDH Current State (as of 2026-04)

Single paper (2025-09) with active open-source community (3,400+ GitHub stars). MLX and Burn framework ports underway. Represents an alternative foundation architecture that could eventually be applied to world modeling, though current work focuses on language tasks. The interpretability advantage — knowing which synapses encode which concepts — could be valuable for world models that need transparent causal representations.

---

## World Models

### World Models Overview

World models are internal representations of environment dynamics that enable agents to predict future states, plan actions, and make decisions. They learn "how the world works" from observation, providing a mental simulation capability that allows reasoning about consequences without physical interaction. The term encompasses both the cognitive science concept (humans build internal models of reality) and the technical AI systems that implement this.

### World Model Approaches

**Four-branch taxonomy** (Dong et al. 2026 survey):

1. **Observation-level generative** (Genie, Cosmos-Predict2.5): Generate future observations (video frames) directly. Inspectable outputs, useful for synthetic data generation, but computationally expensive for planning. Genie 3 enables real-time interactive world generation at 720p/24fps. *Note*: Cosmos 3 transcends this category — its MoT architecture pairs autoregressive reasoning with diffusion-based generation, unifying observation-level generation with latent-space understanding and action prediction in one model.
2. **Latent space** (JEPA, Dreamer family): Predict in learned representation space. Efficient for planning (up to 48x faster than observation-level), filter task-irrelevant variation, but outputs are not directly visualizable. JEPA is the primary architecture; DreamerV3/NE-Dreamer/R2-Dreamer are RL-focused variants.
3. **RL-based** (DreamerV3, Optimistic World Models): Task-optimized world models trained within RL loops. Optimistic World Models integrate classical adaptive control (RBMLE) with deep RL for efficient exploration. RLVR-World applies RL post-training to optimize for transition quality rather than maximum likelihood.
4. **Object-centric** (Causal-JEPA): Operate on object-level representations rather than pixel patches. Enable compositional reasoning and causal understanding. Causal-JEPA achieves comparable planning with 1% of the latent features required by patch-based models.

**Integration paradigms** with action systems (VLA survey + Qwen-Robot):

- **Modular**: World model and policy as separate modules (interpretable but error-propagating)
- **Sequential**: Plan-then-execute hierarchical workflows (latency overhead)
- **Unified**: End-to-end fusion of prediction and action (ACT-JEPA, harder to debug)
- **Composable/tool-use**: VLM orchestrator invokes specialized world model and policy models as tools via language interface ([Alibaba](ecosystem.md#alibaba-tongyi-lab) Qwen-RobotClaw). Trades end-to-end optimization for modularity and cross-domain transfer

**Classification axes** (from survey analysis, complementary to the four-branch taxonomy above):

1. **Representation Dimensionality** — the domain in which predictions are computed:
   - *Pixel-space (Visual Simulators)*: Sora, Genie 3, GAIA-2 — high-fidelity video output, indispensable for human-in-the-loop training and visual verification, but computationally intensive
   - *Latent-space (Abstract Dynamics)*: JEPA family, DreamerV3 — compressed embedding spaces, optimized for planning efficiency (up to 48x faster), ignore irrelevant visual variation (lighting, shadows)
   - *3D-space (Geometric Reconstructors)*: [World Labs](ecosystem.md#world-labs) Marble, InfiniCube — lift 2D inputs into persistent 3D layouts (Gaussian splats, meshes), serve as structural foundations for VR/AR and game engines

2. **Functional Coupling** — how tightly the world model is integrated with decision-making:
   - *Decision-coupled*: Intrinsically linked to a controller/policy; purpose is MBRL or MPC. Examples: [Tesla](ecosystem.md#tesla) FSD, [Wayve](ecosystem.md#wayve) AV 2.0
   - *Foundation/General-purpose*: Broad physical knowledge repositories fine-tunable for diverse tasks. Examples: [NVIDIA](ecosystem.md#nvidia) Cosmos, [Google DeepMind](ecosystem.md#google-deepmind) Genie 3
   - *Observational*: Learn representations from passive observation without action conditioning; used as pre-trained backbones. Examples: I-JEPA, early V-JEPA variants

3. **Temporal Processing** — mechanism for state transition and future rollout:
   - *Sequential (Autoregressive)*: Frame-by-frame generation, high local consistency but prone to geometric drift over long horizons. Examples: Genie 3, GAIA-1
   - *Global (Diffusion/Flow)*: Predict distribution of possible futures in one or more steps, better global structural stability. Examples: Sora, GAIA-2, Cosmos-Predict2.5
   - *Hybrid (AR + Diffusion)*: Dual-tower architectures that use autoregressive decoding for reasoning/language and diffusion for continuous modalities (video, audio, action) within shared attention. Examples: Cosmos 3 MoT

**Five representation families** (Wang et al. 2026 manipulation survey, arXiv:2606.00113): Organizes manipulation world models by predicted output type, with a functional taxonomy separating integrated prediction-action models (world model embedded in policy) from explicit predictive planners (world model as separate planning module). Reviews 34 manipulation datasets. Complements the four-branch taxonomy above with a manipulation-specific lens.

### World Model Technical Details

**Five functional roles** (Abbeel & Malik et al. 2026 survey): World models serve robotics across policy learning, planning, simulation, evaluation, and data generation. This taxonomy clarifies that world models are not monolithic — a single model may serve multiple roles, and different architectures suit different roles. JEPA excels at planning; pixel-space models (Cosmos) excel at data generation. Ctrl-World (Finn et al. 2026) demonstrates the evaluation role: ranking policy performance via imagined rollouts without real-world testing, with synthetic trajectories improving policy success by 44.7%.

**Decoder-free trend**: R2-Dreamer and NE-Dreamer both eliminate pixel reconstruction, predicting in embedding space instead. This parallels JEPA's core principle and suggests convergent design across the field. Both use redundancy reduction (Barlow Twins, predictive alignment) to prevent collapse — the same challenge JEPA addresses with VICReg.

**RL post-training**: Emerging paradigm where world models are first pre-trained (self-supervised) then post-trained with RL for task-relevant quality. RLVR-World (+30.7% accuracy), WorldCompass (long-horizon improvement), and RWML (sim-to-real gap rewards) demonstrate this across text, video, and embodied domains.

**Safety verification**: Oracle-efficient ADMM framework (Sapenov 2026) combines fast JEPA planning with deterministic simulator verification, achieving 125x reduction in verification calls. Addresses the deployment barrier that learned world models can produce unsafe plans.

**Physical reasoning**: Cosmos-Reason1 adds explicit physical common sense via hierarchical ontology (space, time, physics). Complementary to JEPA's implicit physics learning — explicit ontologies can guide and constrain predictions. The proposed MLLM-WM fusion architecture (Feng et al. 2025) combines language grounding with physics simulation.

### World Models Current State (as of 2026-07)

**Three paradigms crystallizing**:

- **Pixel-space** (Cosmos-Predict2.5, Genie): Industrial deployment for synthetic data generation, scenario simulation. Waymo uses Genie 3-based world model for AV simulation. *Note*: Cosmos 3 (2026-06) now straddles pixel-space and latent-space — its reasoner tower performs autoregressive understanding while its generator tower produces video/audio/action via diffusion, collapsing the VLM → video generator → VLA pipeline into one model. Adopted by Agile Robots, Doosan, Samsung, Li Auto, Skild AI.
- **Latent-space** (JEPA): Efficient planning and control for robotics. AMI Labs commercializing. Research community producing accessible tooling (EB-JEPA, stable-worldmodel, LeWM).
- **3D-space** ([World Labs](ecosystem.md#world-labs) Marble): Persistent 3D world reconstruction from multimodal inputs. Human-AI co-creation via Chisel editing. Adopted for VFX, architecture, and robot training data generation. Distinct from pixel-space (generates navigable 3D structures, not video) and latent-space (outputs are directly inspectable and editable).

**Embodied AI architecture taxonomy** (a16z framing, complementary to world model paradigms):

The a16z "Frontier Systems for the Physical World" essay proposes a three-way classification for how physical AI systems acquire world knowledge:

- **Vision-Language-Action (VLA) Models**: Scale pretrained vision-language models (internet images + text) with action decoders. *Examples*: [Physical Intelligence](ecosystem.md#physical-intelligence-pi) π0/π0.5, [NVIDIA](ecosystem.md#nvidia) GR00T N1
- **World Action Models (WAMs)**: Build on video diffusion transformers, inheriting physical dynamics priors from video prediction. The world model is embedded in the video backbone — jointly predicts future frames and actions through shared denoising. *Examples*: [NVIDIA](ecosystem.md#nvidia) DreamZero (14B params, 2x generalization vs. VLAs), planned GR00T N2
- **Native Embodied Foundation Models**: Train from scratch on physical interaction data (wearables, teleoperation) rather than internet images. *Examples*: [Generalist AI](ecosystem.md#generalist-ai) GEN-1 (500K hours of wearable data, 99% task success)

*Key insight*: WAMs represent a fusion of world models and policy learning — treating video generation as an implicit visual planner that guides action production. Cosmos 3 takes this further: its three action modes (forward dynamics, inverse dynamics, policy) make a single model simultaneously a VLM, WAM, and VLA depending on input-output configuration — collapsing the a16z taxonomy's first two categories.

**WAM three-axis taxonomy** (Reuss 2026, complementary to a16z paradigm-level framing):

1. **Paradigm** — what the model predicts:
   - *Inverse Dynamics*: Generate future video/latents, then infer actions from predicted transitions (UniPi, [LingBot-VA](ecosystem.md#robbyant-ant-group), [DVA](ecosystem.md#rhoda-ai))
   - *Joint Prediction*: Predict video and actions together in one pass (GR-1, DreamZero, Cosmos Policy)
   - *Representation-Only*: Use video backbone as learned representation; skip video generation at inference (Fast-WAM — arXiv:2603.16666)

2. **Action Integration** — how actions enter the model:
   - *Action Tokens*: Actions as continuous/discrete tokens alongside video tokens (most WAMs)
   - *Action as Image*: Actions encoded as visual targets the model denoises (GENIMA, Cosmos Policy)
   - *Latent Actions/Plans*: Behavior compressed into latent variables from trajectories or unlabeled video (Play-LMP, Genie, [Being-H0.7](ecosystem.md#beingbeyond))

3. **Architecture** — how components are composed:
   - *Hierarchical*: Separate video prediction and action stages connected one-way (UniPi, Pi-0.7 BAGEL subgoals)
   - *Monolithic Transformer*: Single transformer jointly denoises video and actions (DreamZero, Cosmos Policy)
   - *Mixture-of-Transformers (MoT) / Sparse MoE*: Modality-specific experts with shared self-attention (LingBot-VA 2.0 sparse MoE, Fast-WAM, Pi-0, Pi-0.5) — predicted to become dominant

**Fast-WAM representation-only finding**: Fast-WAM (arXiv:2603.16666) demonstrates that a WAM can skip video generation entirely at inference and still match full video-generating WAMs on simulation benchmarks. This cuts inference from 590-800ms (full video generation) to sub-200ms per action chunk, eliminating the 3-4x WAM inference penalty versus VLAs. However, current evidence is simulation-only — real-robot validation is pending. If confirmed, this collapses the WAM deployment cost objection: WAMs would train on video (learning physical dynamics priors) but deploy as fast as VLAs. Both DreamZero and Fast-WAM found that action learning still benefits from co-training with a video-prediction objective during robot fine-tuning.

**WAM compute cost profile**: Full WAM training stack costs ~7.4x more than VLA stack (51 vs 6.9 ZFLOPs), dominated by video backbone pretraining (e.g., Wan-14B). This means WAM adoption depends on the availability of open, pre-trained video backbones (Wan, Cosmos) that amortize the pretraining cost across the community. 1 ZFLOP ~ 936 H100-hours at ~30% utilization.

**Emerging alternative paradigm**: [Active Inference](concepts.md#active-inference) ([Verses AI](ecosystem.md#verses-ai) AXIOM) — unifies perception, planning, and control via the Free Energy Principle. Object-centric, hierarchical agent structure. Theoretically distinct from all three paradigms above but with potential complementarity. See dedicated Active Inference section below.

**Convergence signals**:

- Decoder-free Dreamer variants converge toward JEPA principles
- Cosmos 3 MoT unifies VLM, video generator, and VLA in a single architecture — the most concrete demonstration that pixel-space and latent-space paradigms are merging rather than competing
- RL post-training applicable to both paradigms
- Physical reasoning (Cosmos-Reason) could enhance either approach; Cosmos 3 subsumes Cosmos-Reason into its reasoner tower
- ARM-EBM bijection suggests autoregressive and energy-based approaches are theoretically unified
- MoT/MoE convergence: Mixture-of-Transformers emerging as the dominant architecture for both VLAs (Pi-0, Pi-0.5) and WAMs (LingBot-VA 2.0, Fast-WAM) — modality-specific experts with shared attention as the practical compromise between modularity and coupling. LingBot-VA 2.0's sparse MoE variant achieves 150 Hz inference, potentially closing the WAM latency gap
- WAM+VLA hybrids predicted as the next generation: Pi-0.7 BAGEL subgoals, [Sereact](ecosystem.md#sereact) Cortex 2.0 planning-by-foresight, [Being-H0.7](ecosystem.md#beingbeyond) latent bridge
- Chinese Big Tech entering Physical AI: [Alibaba](ecosystem.md#alibaba-tongyi-lab) Qwen-Robot suite introduces language-as-action-interface paradigm (composable tool-use rather than monolithic VLA/WAM), trained on 8.6M video-text pairs across 20+ embodiments
- VLA field exploding: 18x growth in ICLR submissions (9 at ICLR 2025 → 164 at ICLR 2026), but frontier gap persists between closed-weight (Gemini, Pi-0.5) and open-weight VLAs on zero-shot open-world behavior
- Counterfactual reasoning emerging as new frontier (CWMDT combines digital twins + diffusion + LLM causal reasoning)
- "Robots Need More Than VLAs & World Models" (Karcini et al. 2026) identifies four missing interfaces (data, embodiment, world-model, reward) — argues the bottleneck is converting unstructured behavioral data into grounded robot supervision, not model scale. Counterpoint to the scaling narrative

**Domain expansion beyond vision/robotics**:

- Telecommunications: WirelessJEPA, JEPA-MSAC, Wireless World Model for 6G — 3 papers in 3 months
- Healthcare: EchoJEPA (18M echocardiograms, 300K patients)
- Autonomous vehicles: Waymo World Model, DWM robustness framework, Le MuMo JEPA sensor fusion
- Agentic AI: AWM (synthetic environments for agent RL), WebWorld (web agent training), "Agentic World Modeling" survey (400+ works). World models for digital agents emerging as distinct subfield — governed by digital rather than physical laws
- Industrial / Digital Twins: Two papers (2601.01321, 2603.17420) chart the digital twin → world model transition. Key insight: digital twins mirror and monitor; world models internalize dynamics for autonomous reasoning. Four-stage lifecycle (Modeling → Mirroring → Intervention → Autonomous Management) maps to world model capability levels

**Competing capability taxonomies** (as of 2026-05):

- **Our primer**: L1-L4 (representation → prediction → action-conditioned → planning/control)
- **Agentic World Modeling** (Chu et al. 2026): L1 Predictor → L2 Simulator → L3 Evolver. L3 "Evolver" directly addresses the continual learning gap — world models that self-correct
- **Healthcare survey** (2511.16333): L1-L4 similar to ours, applied to clinical prediction
- **Robot Learning survey** (2605.00080): Five functional roles (policy learning, planning, simulation, evaluation, data generation) — orthogonal to capability levels
- **Governing laws axis** (Chu et al. 2026): Physical, digital, social, scientific — recognizes that world models for web agents face fundamentally different constraints than those for robotics

**Google's convergence bet**: Hassabis (2025-05) explicitly frames extending Gemini 2.5 Pro into a world model — betting on LLM→WM integration rather than purpose-built WM architectures. If realized, validates the thesis that LLMs and world models converge. Contrasts with Meta's JEPA-centric approach (purpose-built architecture for physical world modeling).

**Open challenges**:

- Long-horizon consistency: video-based models limited to minutes; latent-space models accumulate prediction error
- Causal understanding: Causal-JEPA is a step, but systematic causal reasoning remains nascent
- Sim-to-real transfer: Cosmos addresses with Transfer2.5; JEPA approaches lack equivalent
- Evaluation standards: WorldOlympiad (2026-06) introduces physics/geometry/interaction tripartite evaluation for video-based world models, but no consensus cross-domain standard yet. Manipulation-specific surveys (Wang et al. 2026) review 34 datasets but identify gaps in contact modeling and closed-loop benchmarking
- Scaling laws: Established for LLMs but not for world models of either paradigm

---

## Active Inference

### Active Inference Overview

Active Inference is a biology-inspired framework for world models based on Karl Friston's Free Energy Principle. Unlike standard RL (which maximizes reward) or JEPA (which minimizes prediction error in latent space), Active Inference agents minimize *free energy* — a unified objective that combines prediction accuracy with epistemic value (reducing uncertainty). Agents don't just predict the world; they actively seek observations that resolve their uncertainty about it.

### Active Inference Technical Details

[Verses AI](ecosystem.md#verses-ai)'s AXIOM (Active eXpanding Inference with Object-centric Models) is the primary implementation:

- **Unified perception-planning-control**: A single generative model handles all three, unlike modular architectures that separate world model from policy
- **Hierarchical agent architecture**: Every joint in a robot body is an agent with its own local world model. "Shared intelligence" emerges from coordination rather than centralized control
- **Object-centric representations**: AXIOM creates explicit object-level representations, enabling compositional reasoning similar to Causal-JEPA but derived from different theoretical foundations
- **Epistemic foraging**: Agents actively seek observations that maximize information gain, not just reward — moving from "what will happen if I do this?" to "what will I *believe* if I do this?" (termed "Sophisticated Intelligence" or S2)
- **Recovery without retraining**: Hierarchical local models dynamically adjust to unexpected perturbations by resolving prediction errors locally

### How Active Inference Differs

**vs. JEPA**: JEPA predicts in latent space to learn representations; Active Inference uses prediction error as a drive for action selection. JEPA is primarily a learning architecture; Active Inference is a complete perception-action framework. Both avoid pixel reconstruction.

**vs. Standard RL (DreamerV3)**: RL maximizes expected reward; Active Inference minimizes expected free energy (which includes both reward-seeking and uncertainty-reducing terms). This makes Active Inference agents naturally curious and robust to sparse reward.

**vs. LLM-based planning**: LLMs plan via token generation; Active Inference plans via variational inference over future trajectories. Active Inference has principled uncertainty quantification built in; LLMs do not.

### Active Inference Current State (as of 2026-07)

Emerging paradigm with strong theoretical foundations but limited scale demonstrations. [Verses AI](ecosystem.md#verses-ai) reported AXIOM outperforming [Google DeepMind](ecosystem.md#google-deepmind) on Atari "Gameworld 10k" challenge. The hierarchical agent architecture is a fundamentally different approach to robot control — if validated at scale, it could complement JEPA (for representation learning) and Cosmos (for synthetic data) as a third paradigm for embodied AI. Karl Friston's involvement provides deep neuroscience grounding. Key open question: whether the framework can scale to complex, high-dimensional real-world tasks beyond arcade games and simple robotics.

Recent theoretical progress: [Nuijten et al. (2026)](publications.md#what-type-of-inference-is-active-inference-) formally proved that EFE-based planning decomposes into standard variational inference plus explicit planning and epistemic correction terms, yielding a tractable message-passing algorithm. This decomposition clarifies which components of Active Inference are essential — both planning corrections (policy optimization) and epistemic corrections (information-seeking) are required for full performance.

---

## Agent Taxonomy for Physical AI

### Agent Taxonomy Overview

The term "agent" is used across Physical AI literature with at least four distinct meanings. This taxonomy disambiguates them along two axes: **Role** (what the agent does) and **Domain** (where it operates).

| | Actor (acts in an environment) | Orchestrator (manages the lifecycle) |
| --- | --- | --- |
| **Digital** | **Software agent** — LLM/VLM + tools acting in digital environments (web, APIs, databases) | **Lifecycle agent** — automates the AI model lifecycle: design, training, evaluation, deployment, monitoring, retraining |
| **Physical** | **Embodied / simulated agent** — robot, drone, or sim entity executing learned policies in physical or simulated environments | **Physical AI lifecycle agent** — automates the Physical AI lifecycle: simulation, synthetic data generation, domain randomization, policy evaluation, fleet deployment, closed-loop refinement |

### Actor vs. Orchestrator

**Actors** are the systems that perceive and act — a VLA policy controlling a robotic arm, a software agent navigating a website, a simulated entity in a multi-agent training scenario. Actors consume models and policies to produce behavior.

**Orchestrators** manage the lifecycle that produces, validates, and refines the actors' models. This spans the full design → develop → operate → monitor → refine cycle:

- **Design**: scenario authoring, simulation configuration, domain randomization setup
- **Develop**: data curation, synthetic data generation, training orchestration, fine-tuning
- **Operate**: policy deployment, fleet rollout, A/B testing, canary promotion
- **Monitor**: fleet telemetry, anomaly detection, drift detection, safety monitoring
- **Refine**: failure analysis, targeted retraining, sim-to-real gap closure

### Digital vs. Physical

The digital/physical axis captures whether an agent's environment follows digital rules (API contracts, web protocols, database schemas) or physical rules (Newtonian mechanics, sensor noise, contact dynamics, real-time constraints). Physical AI lifecycle agents extend familiar digital lifecycle patterns (CI/CD, MLOps, experiment tracking) with simulation-native capabilities:

| Digital lifecycle agent | Physical AI lifecycle agent (extension) |
| --- | --- |
| Runs test suites | Runs simulation-based evaluations (physics fidelity, domain gap) |
| Monitors model accuracy | Monitors fleet-level policy performance, safety violations |
| Triggers retraining on data drift | Triggers retraining on sim-to-real gap, new failure modes |
| Deploys model to API endpoint | Deploys policy to robot fleet with staged rollout |
| Curates training data from logs | Generates synthetic training data via Cosmos, Isaac Sim |

### How It Differs from Other Taxonomies

**vs. "Agentic AI" (industry usage)**: Industry typically uses "agentic" to mean software agents with tool use and planning. This taxonomy expands the frame to include physical actors and — critically — the lifecycle orchestration layer that industry often conflates with the actors themselves.

**vs. Multi-agent systems (MAS)**: MAS literature focuses on agent coordination protocols. This taxonomy is orthogonal — it classifies agents by role and domain, not by coordination pattern. A multi-agent system could contain actors of any type.

### Current State (as of 2026-06)

- **Software agents**: Mature. LLM-based agents with tool use (MCP, function calling) are production-deployed. Frameworks: LangChain, CrewAI, AutoGen.
- **Embodied / simulated agents**: Active research. VLA policies ([Physical Intelligence](ecosystem.md#physical-intelligence-pi) π0, [NVIDIA](ecosystem.md#nvidia) GR00T, [Skild AI](ecosystem.md#skild-ai) Skild Brain) are deployed in controlled settings but not yet at fleet scale. Simulated agents used for multi-agent training (Odyssey Agora-1).
- **Digital lifecycle agents**: Emerging. AI coding agents (Cursor, Claude Code) automate parts of the develop cycle. Full lifecycle automation (design → monitor → refine) remains fragmented.
- **Physical AI lifecycle agents**: Nascent. [NVIDIA](ecosystem.md#nvidia)'s agent tools and skills release (2026-05) is the first concrete product — repackages Cosmos, Isaac Sim, and Omniverse as callable tools for AI coding agents to orchestrate Physical AI pipelines. NemoClaw provides a safety blueprint. No dominant open-source framework yet — a significant whitespace opportunity.

**Platform implication**: Red Hat's existing AI platform (RHOAI) covers the digital lifecycle agent quadrant — KubeFlow Pipelines, KServe, MLflow, ArgoCD. The Physical AI platform extends this to the Physical AI lifecycle agent quadrant by adding simulation gating, synthetic data pipelines, policy promotion, and fleet-level observability. The actor quadrants (software agents, embodied agents) are complements — model providers like PI and Skild build the actors; the platform manages their lifecycle.

---

## Related Concepts

### Self-Supervised Learning (SSL)

The training paradigm underlying both JEPA and decoder-free world models. Creates learning signal from data structure (masking, prediction) rather than human labels. JEPA's contribution: predicting in representation space rather than input space, filtering irrelevant variation.

### Latent Representations

Learned compressed representations of inputs. In world models, the quality of latent representations determines planning effectiveness. Key insight from tracked papers: dense features (V-JEPA 2.1) matter for fine-grained tasks like robotic grasping — global representations alone are insufficient.

### Contrastive Learning

Alternative SSL paradigm that JEPA explicitly avoids. Contrastive methods (SimCLR, CLIP) learn by pulling positive pairs together and pushing negative pairs apart. JEPA replaces this with predictive objectives + regularization, eliminating the need for negative sampling. However, VL-JEPA shows JEPA can match contrastive baselines (CLIP, SigLIP2) on vision-language tasks.

### Model-Based Reinforcement Learning (MBRL)

Using learned world models to generate imagined trajectories for policy optimization. Dreamer family (DreamerV3, R2-Dreamer, NE-Dreamer) is the primary MBRL framework. Key trend: MBRL converging with JEPA as decoder-free variants adopt latent prediction. Optimistic World Models integrate classical control theory (RBMLE) with deep MBRL.

### Predictive Coding

Neuroscience theory that the brain continuously predicts sensory inputs and learns from prediction errors. JEPA can be viewed as implementing predictive coding in representation space. BDH's Hebbian learning provides a more directly biological implementation of similar principles.

### VICReg (Variance-Invariance-Covariance Regularization)

The dominant regularization technique in JEPA architectures. Prevents representation collapse through three terms: variance preservation (hinge loss ensures embedding dimensions maintain spread), invariance (MSE between augmented views), and covariance decorrelation (reduces redundancy between embedding dimensions). Conceptually parallel to Barlow Twins, which R2-Dreamer uses in the Dreamer family.

### World Foundation Models (WFMs)

NVIDIA's framing: general-purpose world models pre-trained on massive data, fine-tunable for domain-specific applications. Analogous to LLMs but for physical world simulation. Cosmos 3 (2026-06) is the latest implementation — a 4B/16B/64B omnimodel handling text, image, video, audio, and action via Mixture-of-Transformers. Contrasts with JEPA's approach of training domain-specific models from scratch (though AMI Labs may change this with scaled JEPA WFMs).

### Physical AI

Umbrella term for AI systems that interact with the physical world — robotics, autonomous vehicles, embodied agents. World models are positioned as the enabling technology: they provide the "digital twin of the environment" that Physical AI systems need for safe, efficient learning. Cosmos-Reason1 adds explicit physical reasoning; JEPA provides efficient latent planning.

### Scientist AI

Yoshua Bengio's proposal (2025) for non-agentic AI built around a world model that explains observations and answers questions rather than autonomously pursuing goals. Deliberately avoids agency — focuses on accurate world representation with uncertainty quantification. Safety-motivated alternative to the autonomous agent paradigm.

### Sim-to-Real Transfer

**Definition**: Methods for deploying simulation-trained robot policies in the real world, bridging the gap between simulated and physical environments. Three main approaches: domain randomization (train across varied sim parameters), domain adaptation (style transfer between domains), and co-training (joint training on sim + real data).

**Connection to World Models**: World models can serve as sim-to-real bridges in two ways: (1) video generation (Cosmos-Transfer) translates sim scenes to photorealistic visuals, (2) latent-space models (JEPA) learn representations invariant to the sim-real gap. HyperSim (2026) demonstrates co-training achieving 95% sim-to-real success with pi0. Real-is-Sim (2025) inverts the paradigm — a 60Hz dynamic digital twin via Gaussian splatting makes simulation the control authority, eliminating the transfer gap entirely.

### Three-Computer Architecture

NVIDIA's reference architecture for Physical AI systems (Jensen Huang, GTC). Three compute tiers form a continuous learning loop:

1. **Training computer** (datacenter): DGX/HGX clusters for fine-tuning foundation models, RL training, and large-scale data processing. Requires scale, fast networking, resilient scheduling, rapid access to multimodal sensor data
2. **Simulation computer** (datacenter): GPU-accelerated simulation for synthetic data generation, domain randomization, policy evaluation, and scenario replay. Requires rendering GPUs, physics CPUs, fast storage, orchestration for thousands of parallel environments. NVIDIA implementation: Isaac Sim + Omniverse + Cosmos
3. **Edge computer** (on-robot): Constrained hardware running trained policies with low latency. Requires safety, reliability, power efficiency, real-time performance. NVIDIA implementation: Jetson Thor running Cosmos 3 Edge (4B) or GR00T N1

**The gap**: In practice these three computers operate as separate islands — different toolchains, data formats, storage systems, and orchestration. Teams spend more time wrangling infrastructure than improving models. Closing this gap is the core platform challenge for Physical AI.

**Platform implication**: The three-computer architecture maps directly to platform building blocks — training infrastructure, simulation engines, and edge inference runtime — and motivates the [robotics data flywheel](#robotics-data-flywheel) as the integration pattern connecting them.

### Robotics Data Flywheel

Continuous improvement loop connecting the three-computer architecture: edge telemetry feeds back into data lakes → failure cases become simulation scenarios → simulation generates synthetic training data → training produces better models → better models deploy to edge → cycle repeats.

**Why it matters**: The faster this loop runs, the faster the system improves. Currently assembled manually by most teams — stitching together real-world failure data, simulation replay, synthetic data generation, retraining, and redeployment across disconnected tools and formats.

**Early implementations**: NVIDIA's OSMO orchestrator and Physical AI Data Factory Blueprint provide workflow templates. Skild AI's Foxconn deployment demonstrates a production flywheel — real assembly-line data feeding back into model improvement. The pattern requires unified data management across real and synthetic sources, automated failure mining, and seamless model promotion from training to edge.

**Connection to World Models**: World models accelerate the flywheel at multiple points — Cosmos generates synthetic training data, world models enable model-based evaluation without physical deployment (Ctrl-World), and sim-to-real transfer (Cosmos-Transfer) bridges the visual domain gap between simulation and reality.

---

**Note**: This document grows as papers are added and understanding deepens. Each section is expanded with technical details, equations, architectures, and comparisons synthesized from tracked publications.
