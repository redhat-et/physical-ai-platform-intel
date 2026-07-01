# Publications

> Papers, talks, videos, and blog posts on Physical AI — world models, robot learning, sim-to-real, and related topics

**Last Updated**: 2026-06-09

---

## JEPA (Joint-Embedding Predictive Architecture)

*Papers, talks, and videos specifically about JEPA*

### V-JEPA 2.1: Unlocking Dense Features in Video Self-Supervised Learning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.14482)

**Authors/Presenters**: Lorenzo Mur-Labadia, Matthew Muckley, Amir Bar, Mido Assran, Koustuv Sinha, Mike Rabbat, [Yann LeCun](ecosystem.md#yann-lecun), Nicolas Ballas, Adrien Bardes

**Date**: 2026-03

**Summary**: New family of self-supervised video models producing dense, high-quality visual representations through dense predictive losses (both visible and masked tokens contribute training signal), hierarchical self-supervision across intermediate encoder layers, multi-modal tokenizers for unified image-video training, and effective scaling. Successor to V-JEPA 2.

**Key Findings**:

- 20-point improvement in robot grasping success over V-JEPA 2; 7.71 mAP on Ego4D object-interaction anticipation, 40.8 Recall@5 on EPIC-KITCHENS action anticipation
- Dense predictive loss where both visible and masked tokens provide training signal, unlike standard JEPA masking where only masked tokens contribute
- Deep self-supervision applied across multiple intermediate encoder layers improves spatial, semantic, and temporal coherence of learned features

**Relevance to World Models**: Direct successor to V-JEPA 2, addressing its weakness in dense (per-pixel/per-patch) feature quality while maintaining strong global representations. The 20-point robotics improvement demonstrates that dense features matter for world model downstream tasks — global scene understanding alone is insufficient for fine-grained manipulation planning.

### VL-JEPA: Joint Embedding Predictive Architecture for Vision-language [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2512.10942)

**Authors/Presenters**: Delong Chen, Mustafa Shukor, Theo Moutakanni, Willy Chung, Jade Yu, Tejaswi Kasarla, Yejin Bang, Allen Bolourchi, [Yann LeCun](ecosystem.md#yann-lecun), Pascale Fung

**Date**: 2025-12 (revised 2026-02)

**Summary**: Extends JEPA to vision-language by predicting continuous text embeddings instead of autoregressive token generation. Achieves stronger performance with 50% fewer trainable parameters than standard VLM training, demonstrating that JEPA's prediction-in-representation-space principle transfers effectively to multimodal settings.

**Key Findings**:

- Replaces token-space prediction with continuous embedding prediction; natively supports adaptive decoding reducing operations by 2.85x
- Surpasses CLIP, SigLIP2, and Perception Encoder across 16 video datasets; comparable to InstructBLIP and QwenVL on VQA benchmarks (GQA, TallyQA, POPE, POPEv2)
- 1.6B parameter model supports open-vocabulary classification, text-to-video retrieval, and discriminative VQA without architectural modification

**Relevance to World Models**: Demonstrates JEPA's scalability beyond vision to multimodal settings, a key step toward world models that integrate language understanding with visual prediction. Validates that predicting in embedding space (rather than token space) is viable for language tasks.

### VLA-JEPA: Enhancing Vision-Language-Action Model with Latent World Model [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.10098)

**Authors/Presenters**: Jingwen Sun, Wenyao Zhang, Zekun Qi, Shaojie Ren, Zezhi Liu, Hanxin Zhu, Guangzhong Sun, Xin Jin, Zhibo Chen

**Date**: 2026-02

**Summary**: JEPA-style pretraining framework for VLA policies using leakage-free state prediction — a target encoder produces latent representations from future frames while the student sees only current observation. Addresses the core VLA limitation that latent-action objectives anchor to pixel variation rather than action-relevant state transitions.

**Key Findings**:

- Leakage-free design: future information used solely as supervision targets, never as input — prevents shortcuts that bypass dynamics learning
- Uses V-JEPA2 encoder + predictor as latent world model; Qwen3-VL-2B as VLM backbone
- Two-stage recipe (JEPA pretraining → action-head fine-tuning) eliminates multi-stage complexity of prior approaches
- Consistent gains on LIBERO, LIBERO-Plus, SimplerEnv, and real-world manipulation in generalization and robustness

**Relevance to World Models**: Directly integrates JEPA world models into VLA training, addressing the key criticism that VLAs lack causal understanding of dynamics. By predicting in latent space rather than pixel space, VLA-JEPA learns abstractions robust to camera motion and irrelevant background changes — the same property that makes JEPA world models effective for planning.

### When Does LeJEPA Learn a World Model? [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2605.26379)

**Authors/Presenters**: David Klindt, [Yann LeCun](ecosystem.md#yann-lecun), Randall Balestriero

**Date**: 2026-05

**Summary**: Proves that LeJEPA (alignment loss + Gaussian regularization) achieves linear identifiability — recovering latent variables up to orthogonal rotation from nonlinear observations — if and only if latents follow a Gaussian distribution under stationary additive-noise transitions. Forward proof uses Hermite polynomial decomposition showing every nonlinear component contributes strictly less temporal correlation than the linear map; converse eliminates all non-Gaussian alternatives. All four theorems formally verified in Lean 4 with Mathlib.

**Key Findings**:

- Gaussian uniqueness: among stationary additive-noise worlds, Gaussian is the *only* latent distribution enabling linear identifiability — non-Gaussian distributions break the guarantee
- Approximate identifiability degrades gracefully: when objectives are only ε- and δ-approximately satisfied, deviation from rotation is bounded by an explicit function of (ε, δ)
- Linear identifiability suffices for optimal planning: for O(n)-invariant costs, optimal value functions and action sequences in learned latent space exactly match those in true latent space
- SIGReg and VICReg maintain R² > 0.999 up to N=1024 dimensions; InfoNCE degrades significantly at scale under fixed kernel width
- Distributional ablation across generalized-normal family confirms recovery peaks sharply at α=2 (Gaussian), validating the uniqueness theorem

**Relevance to World Models**: Provides the missing theoretical guarantee for LeWorldModel's empirically successful recipe. Proves that Gaussian regularization is not merely convenient but *necessary* — no other distribution class yields identifiable latent recovery. Theorem 4 (optimal planning) directly connects identifiability to world model utility: if the learned latent space is a rotation of the true one, planning in it is provably optimal. The Lean 4 formalization sets a new standard for rigor in world model theory.

### LeWorldModel: Stable End-to-End Joint-Embedding Predictive Architecture from Pixels [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.19312)

**Authors/Presenters**: Lucas Maes, Quentin Le Lidec, Damien Scieur, [Yann LeCun](ecosystem.md#yann-lecun), Randall Balestriero

**Date**: 2026-03

**Summary**: First JEPA that trains stably end-to-end from raw pixels using only two loss terms: a next-embedding prediction loss and a regularizer enforcing Gaussian-distributed latent embeddings. Reduces tunable loss hyperparameters from six to one compared to the only existing end-to-end alternative, with ~15M parameters trainable on a single GPU in hours.

**Key Findings**:

- Plans up to 48x faster than foundation-model-based world models while remaining competitive across diverse 2D and 3D control tasks
- Avoids representation collapse without exponential moving averages, pre-trained encoders, or auxiliary supervision — only two loss terms needed
- Latent space encodes meaningful physical structure; model detects physically implausible events through surprise evaluation

**Relevance to World Models**: Directly addresses the fragility problem that has limited JEPA adoption for world modeling. By dramatically simplifying the training recipe (2 loss terms vs. 6), LeWM lowers the barrier to building JEPA-based world models from scratch without relying on foundation model encoders.

### Causal-JEPA: Learning World Models through Object-Level Latent Interventions [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.11389)

**Authors/Presenters**: Heejeong Nam, Quentin Le Lidec, Lucas Maes, [Yann LeCun](ecosystem.md#yann-lecun), Randall Balestriero

**Date**: 2026-02

**Summary**: Extends JEPA masking from image patches to object-centric representations, inducing causal inductive bias via latent interventions. Object-level masking requires an object's state to be inferred from other objects, preventing shortcut solutions and making interaction reasoning essential for learning dynamics.

**Key Findings**:

- ~20% absolute improvement in counterfactual reasoning on visual question answering vs. same architecture without object-level masking
- Achieves comparable planning performance using only 1% of the total latent input features required by patch-based world models
- Formal analysis proves object-level masking induces causal inductive bias via latent interventions with counterfactual-like effects

**Relevance to World Models**: Moves JEPA world models from correlation-based prediction toward causal understanding. The 100x reduction in required latent features for planning suggests object-centric representations are dramatically more efficient for control tasks — a key insight for scaling world models to complex environments.

### What Drives Success in Physical Planning with Joint-Embedding Predictive World Models? [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2512.24497)

**Authors/Presenters**: Basile Terver, Tsung-Yen Yang, Jean Ponce, Adrien Bardes, [Yann LeCun](ecosystem.md#yann-lecun)

**Date**: 2025-12 (revised 2026-01)

**Summary**: Systematic ablation study characterizing JEPA-based world models (JEPA-WMs) for physical planning. Investigates multistep rollout, predictor architecture, training context length, proprioception, encoder type, model size, data augmentation, and planning optimizer to identify what actually drives planning success.

**Key Findings**:

- Combined findings produce a model outperforming two established baselines — DINO-WM and V-JEPA-2-AC — in both navigation and manipulation tasks
- Identifies critical design choices: AdaLN-zero predictor architecture, appropriate training context length, and planning optimizer selection
- Provides pretrained checkpoints, code, and data for reproducibility via [jepa-wms](https://github.com/facebookresearch/jepa-wms)

**Relevance to World Models**: Essential reference for practitioners building JEPA-based world models — the first systematic study of which design decisions matter and why. Bridges the gap between JEPA theory and practical world model engineering.

### Hierarchical Planning with Latent World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2604.03208)

**Authors/Presenters**: Wancong Zhang, Basile Terver, Artem Zholus, Soham Chitnis, Harsh Sutaria, Mido Assran, Amir Bar, Randall Balestriero, [Adrien Bardes](ecosystem.md#adrien-bardes), [Yann LeCun](ecosystem.md#yann-lecun), Nicolas Ballas

**Date**: 2026-04

**Summary**: Addresses the long-horizon planning limitation identified in the JEPA-WMs ablation study by learning latent world models at multiple temporal scales and performing hierarchical MPC across those scales. A high-level planner produces subgoals via macro-actions; a low-level planner executes short-horizon plans to reach them — all in a shared latent space without learned policies or skill libraries.

**Key Findings**:

- Achieves 70% success on real-robot pick-and-place from a single goal image, vs 0% for flat V-JEPA-2-AC planner — demonstrates that hierarchy is necessary, not optional, for multi-step manipulation
- Model-agnostic: consistently improves three diverse latent world models (V-JEPA-2-AC, DINO-WM, PLDM) across navigation and manipulation domains
- Up to 4x reduction in planning-time compute compared to flat planners, because the high-level planner prunes the search space before low-level refinement
- Code and weights available via [HWM_PLDM](https://github.com/kevinghst/HWM_PLDM)

**Relevance to World Models**: Direct follow-up to the JEPA-WMs ablation by the same research group. Validates that hierarchical planning — decomposing long tasks into short sub-goals — is the practical path to L4 closed-loop planning with JEPA world models, rather than extending single-level rollout horizons. The model-agnostic design suggests this is a general solution for latent-space planners, not architecture-specific.

### ACT-JEPA: Novel Joint-Embedding Predictive Architecture for Efficient Policy Representation Learning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2501.14622)

**Authors/Presenters**: Aleksandar Vujinovic, Aleksandar Kovacevic

**Date**: 2025-01 (revised 2026-03)

**Summary**: Unifies imitation learning (IL) and self-supervised learning (SSL) by training end-to-end to jointly predict action sequences and latent observation sequences via JEPA. Filters irrelevant details through latent prediction, learning a robust world model that transfers to action prediction.

**Key Findings**:

- Up to 40% improvement in world model understanding compared to strongest baseline
- Up to 10% higher task success rate across all tested environments
- Demonstrates that predicting latent observations generalizes effectively to action prediction, validating JEPA as a policy backbone

**Relevance to World Models**: Shows JEPA can unify representation learning and policy learning in a single architecture. Rather than training a world model and policy separately, ACT-JEPA learns both jointly — potentially more sample-efficient for robotics applications.

### Intrinsic-Energy Joint Embedding Predictive Architectures Induce Quasimetric Spaces [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.12245)

**Authors/Presenters**: Anthony Kobanda, Waris Radji

**Date**: 2026-02

**Summary**: Bridges JEPA and Quasimetric Reinforcement Learning (QRL) by proving that intrinsic (least-action) energies in JEPAs constitute quasimetrics under specified conditions. Shows that optimal cost-to-go functions in goal-reaching control naturally adopt this intrinsic energy form.

**Key Findings**:

- Proves intrinsic energies satisfying closure and additivity form valid quasimetrics, linking JEPA energy functions to QRL's value class
- Demonstrates symmetric finite energies are structurally incompatible with one-way reachability, motivating asymmetric formulations
- Primarily theoretical; provides mathematical framework connecting JEPA to control-theoretic foundations

**Relevance to World Models**: Provides theoretical grounding for using JEPA-style energy functions in planning and goal-reaching tasks. Connects world model representations to quasimetric structure, potentially enabling more principled planning algorithms.

### A Lightweight Library for Energy-Based Joint-Embedding Predictive Architectures (EB-JEPA) [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.03604)

**Authors/Presenters**: Basile Terver, Randall Balestriero, Megi Dervishi, David Fan, Quentin Garrido, Tushar Nagarajan, Koustuv Sinha, Wancong Zhang, Mike Rabbat, [Yann LeCun](ecosystem.md#yann-lecun), Amir Bar

**Date**: 2026-02

**Summary**: Introduces EB-JEPA, an open-source library for learning representations and world models using JEPAs. Predicts in representation space rather than pixel space, enabling single-GPU training within hours. Provides modular implementations from image representation to action-conditioned world models.

**Key Findings**:

- Achieves 91% probing accuracy on CIFAR-10 and 97% planning success rate on Two Rooms navigation task
- Demonstrates critical importance of regularization components (VICReg-style) in preventing representation collapse through ablation studies
- Modular design shows progressive path from image JEPA → video JEPA → action-conditioned world model with multi-step prediction

**Relevance to World Models**: Directly addresses world modeling with JEPAs, providing accessible implementations and ablations. The action-conditioned video JEPA example demonstrates world modeling where the model predicts future states from observations and actions, enabling planning toward goal embeddings.

### VJEPA: Variational Joint Embedding Predictive Architectures as Probabilistic World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2601.14354)

**Authors/Presenters**: Yongchao Huang

**Date**: 2026-01

**Summary**: Introduces Variational JEPA, a probabilistic generalization that learns predictive distributions over future latent states via variational objectives rather than deterministic regression. Unifies representation learning with Predictive State Representations and Bayesian filtering without autoregressive observation likelihoods. Extension called Bayesian JEPA enables zero-shot task transfer through modular expert architecture.

**Key Findings**:

- Develops probabilistic variant with variational objectives for predicting latent state distributions instead of point estimates
- Proves VJEPA representations serve as sufficient information states for optimal control without pixel reconstruction
- Introduces BJEPA extension factorizing beliefs into learned dynamics and modular priors for zero-shot transfer via Product of Experts
- Demonstrates robustness to high-variance distractors that cause collapse in generative approaches
- Enables principled uncertainty estimation through sampling while remaining likelihood-free regarding observations

**Relevance to World Models**: Foundational framework for scalable, uncertainty-aware world models in stochastic control that bridges representation learning with Bayesian filtering without expensive observation reconstruction. Addresses key limitation of deterministic JEPA by incorporating probabilistic semantics essential for planning under uncertainty.

### WirelessJEPA: A Multi-Antenna Foundation Model using Spatio-temporal Wireless Latent Predictions [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2601.20190)

**Authors/Presenters**: Viet Chu, Omar Mashaal, Hatem Abou-Zeid

**Date**: 2026-01

**Summary**: Applies JEPA to wireless signal processing by predicting latent representations of masked multi-antenna IQ signal regions. Introduces 2D antenna-time representation enabling convolutional processing with block masking, eliminating need for hand-crafted contrastive augmentations. Demonstrates robust generalization across diverse downstream tasks.

**Key Findings**:

- Novel 2D antenna-time representation reshapes multi-antenna IQ streams into structured grids for convolutional processing with efficient sparse computation
- Introduces spatio-temporal mask geometries encoding inductive biases across antenna arrays and temporal dimensions
- Evaluated across six diverse tasks: angle-of-arrival estimation, modulation classification, RF fingerprinting, protocol classification, GNSS jamming, and interference classification
- Establishes JEPA-based learning as promising direction for building generalizable wireless foundation models
- Demonstrates direct learning from real-world multi-antenna data as viable for general-purpose wireless representation learning

**Relevance to World Models**: Domain-specific application demonstrating world model principles—using unsupervised predictive learning to build generalizable representations that transfer across tasks without explicit task engineering. Shows JEPA's applicability beyond vision/language to signal processing domains.

### Le MuMo JEPA: Multi-Modal Self-Supervised Representation Learning with Learnable Fusion Tokens [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.24327)

**Authors/Presenters**: Ciem Cornelissen, Sam Leroux, Pieter Simoens

**Date**: 2026-03

**Summary**: Extends LeJEPA to multi-modal settings (RGB + LiDAR depth, RGB + thermal) by introducing learnable fusion tokens that act as a latent bottleneck between modality-specific patch stems inside a shared transformer. Uses SIGReg as a modality-agnostic shared target distribution, enabling cross-modal alignment without artificial token-wise pairing constraints.

**Key Findings**:

- Learnable fusion tokens aggregate cross-modal information through attention, then modality-specific tokens are pruned — forcing all information through the shared fusion-token grid
- Strongest performance-efficiency trade-off among from-scratch multimodal baselines on Waymo, nuScenes, and FLIR benchmarks
- Substantially lower compute, memory, and training time than alternatives while maintaining best overall accuracy

**Relevance to World Models**: Demonstrates that JEPA-style prediction in latent space extends naturally to multi-modal sensor fusion — a requirement for real-world world models that must integrate heterogeneous inputs (camera, LiDAR, thermal) for autonomous driving and robotics.

### EchoJEPA: A Latent Predictive Foundation Model for Echocardiography [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.02603)

**Authors/Presenters**: Alif Munim, Adibvafa Fallahpour, Teodora Szasz, Ahmadreza Attarpour, River Jiang, Brana Sooriyakanthan, Maala Sooriyakanthan, Heather Whitney, Jeremy Slivnick, Barry Rubin, Wendy Tsang, Bo Wang

**Date**: 2026-02

**Summary**: First foundation-scale JEPA for medical imaging, trained on 18 million echocardiograms across 300K patients. Adapts V-JEPA 2 with domain-specific modifications (higher temporal sampling, conservative cropping, narrower aspect ratios) to learn anatomical representations that filter out ultrasound speckle noise.

**Key Findings**:

- ~20% improvement on LVEF estimation and 17% on RVSP estimation over leading baselines; 79% view classification accuracy with only 1% labeled data vs. 42% for best baseline at 100%
- Under simulated acoustic perturbations, performance drops just 2% vs. 17% for competitors; zero-shot pediatric performance exceeds fully fine-tuned baselines
- Challenges assumption that methods from natural video transfer directly to medical imaging — in ultrasound, texture is interference noise, not semantic signal

**Relevance to World Models**: Demonstrates JEPA's applicability to medical imaging where the distinction between signal and noise is fundamentally different from natural video. The success of latent prediction over reconstruction validates the JEPA principle that predicting in representation space naturally filters task-irrelevant variation.

### JEPA-MSAC: A Joint-Embedding Predictive Architecture for Multimodal Sensing-Assisted Communications [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.29796)

**Authors/Presenters**: Can Zheng, Jiguang He, Guofa Cai, Nannan Li, Mehdi Bennis, Henk Wymeersch, Merouane Debbah

**Date**: 2026-03

**Summary**: Self-supervised multimodal predictive framework for wireless environments. Maps sensing and communication measurements into a unified token space, pretrains via temporal block-masked JEPA to learn predictive latent representations capturing environment dynamics. Frozen backbone reused with lightweight task heads for localization, beam prediction, and RSSI estimation.

**Key Findings**:

- Frozen pretrained backbone + lightweight task heads outperforms dedicated single-task baselines like M2BeamLLM across all three downstream tasks
- One-shot future prediction faster than autoregressive decoding baselines; avoids heavy decoders required by reconstruction-based SSL
- Validated on DeepSense 6G real-world multimodal dataset (urban 60 GHz mmWave scenario)

**Relevance to World Models**: Another domain-specific JEPA application demonstrating the architecture's generality. Learns a predictive world model of wireless environments — capturing how channels, positions, and signals evolve — then reuses representations across multiple downstream tasks without retraining.

### A Wireless World Model for AI-Native 6G Networks [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.25216)

**Authors/Presenters**: Ziqi Chen, Yi Ren, Yixuan Huang, Qi Sun, Nan Li, Yuhong Huang, Chih-Lin I, Yifan Li, Liang Xia

**Date**: 2026-03

**Summary**: Multi-modal foundation framework for predicting spatiotemporal wireless channel evolution using a joint-embedding predictive architecture with multi-modal mixture-of-experts Transformer. Fuses channel state information, 3D point clouds, and user trajectories into a unified representation, pre-trained on ray-traced synthetic data to bridge the sim-to-real gap.

**Key Findings**:

- JEPA + MoE Transformer architecture enables "one-model-for-all" paradigm covering channel prediction, compression/feedback, beam management, and user localization
- Pre-training on ray-traced synthetic data provides physics-aware understanding of electromagnetic wave propagation, enabling generalization to unseen environments
- Consistently outperforms SOTA uni-modal foundation models and task-specific models across five downstream tasks in both seen and unseen scenarios, validated on real-world measurements

**Relevance to World Models**: Builds on WirelessJEPA and JEPA-MSAC by adding multi-modal fusion (CSI + 3D point clouds + trajectories) through MoE, creating a more complete wireless world model. The physics-aware pre-training on synthetic ray-traced data parallels Cosmos's sim-to-real approach but in the wireless domain.

### Tutorial on Joint Embedding Predictive Architectures (JEPA): Foundations, Applications, and Future Directions [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.techrxiv.org/users/866579/articles/1365143)

**Authors/Presenters**: Mehdi Monemi, Maryam Chinipardaz, Mehdi Rasti, Mehdi Bennis

**Date**: 2025-12

**Summary**: Comprehensive tutorial covering JEPA's theoretical foundations, architectural design principles, and diverse application domains. Situates JEPA within the broader taxonomy of representation learning and formulates its core components: context-target generation, encoding, latent-space prediction, regularization, and energy minimization. Presents a framework for agentic AI where a multi-level JEPA predictor functions as a latent-space world model.

**Key Findings**:

- Systematic formulation of JEPA components with cross-referencing to existing implementations across image, audio, video, point-cloud, and multimodal modalities
- Framework for realizing [Yann LeCun](ecosystem.md#yann-lecun)'s agentic AI vision: multi-level JEPA predictor as latent-space world model integrated with actor training for mode-2 planning and control
- Surveys emerging JEPA applications in 6G networks, identifying this as a nascent but promising research direction

**Relevance to World Models**: Serves as the definitive reference for JEPA architecture — bridging LeCun's theoretical vision with practical implementations. The agentic AI framework section directly maps JEPA to world model-based planning, making explicit the connection between representation learning and autonomous decision-making.

### 14 JEPA Milestones as a Map of AI Progress [<img src="templates/icons/website.svg" alt="website" height="16">](https://lifeboat.com/blog/2026/03/14-jepa-milestones-as-a-map-of-ai-progress)

**Authors/Presenters**: Lifeboat News / TuringPost

**Date**: 2026-03

**Summary**: Chronological overview of 14 JEPA milestones tracing the architecture's evolution from foundational concepts through domain-specific applications. Covers JEPA/H-JEPA, I-JEPA, MC-JEPA, V-JEPA, Audio-JEPA, Point-JEPA, 3D-JEPA, ACT-JEPA, V-JEPA 2, LeJEPA, Causal-JEPA, V-JEPA 2.1, LeWorldModel, and ThinkJEPA.

**Key Findings**:

- Maps JEPA expansion from core vision to multi-modal applications: audio, 3D point clouds, video understanding, and robotic manipulation
- Highlights LeWorldModel as notably compact (15M params) and ThinkJEPA as combining dense physical prediction with VLM reasoning for long-term strategic planning
- Underlying principle across all variants: predicting in latent space rather than pixel space enables efficient learning across diverse modalities

**Relevance to World Models**: Provides a concise lineage of JEPA development, useful for understanding how the architecture has evolved toward world modeling. ThinkJEPA's integration of VLM reasoning with JEPA dynamics prediction represents the latest convergence of language understanding and physical world modeling.

### BiJEPA: Bi-directional Joint Embedding Predictive Architecture for Symmetric Representation Learning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.00049)

**Authors/Presenters**: Yongchao Huang

**Date**: 2026-02

**Summary**: Extends JEPA with cycle-consistent bidirectional prediction between data segments. Introduces norm regularization on representation vectors to prevent "Representation Explosion" — a collapse mode specific to symmetric prediction architectures. Validated across synthetic signals, chaotic systems, and image data.

**Key Findings**:

- Bidirectional prediction captures informative signal in the inverse relationship, enabling more complete representation learning
- Identifies "Representation Explosion" as a primary failure mode of bi-directional SSL — norm regularization prevents this while maintaining training stability
- Successfully learns representations across diverse modalities without collapse; captures structural patterns in chaotic dynamical systems

**Relevance to World Models**: Addresses a gap in standard JEPA: unidirectional prediction may miss structure in the reverse mapping. For world models, bidirectional consistency could improve temporal reasoning — knowing that state B follows A should imply A precedes B. The Representation Explosion failure mode is a new collapse category beyond the collapse modes addressed by VICReg.

### US-JEPA: A Joint Embedding Predictive Architecture for Medical Ultrasound [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.19322)

**Authors/Presenters**: Ashwath Radhachandran, Vedrana Ivezić, Shreeram Athreya, Ronit Anilkumar, Corey W. Arnold, William Speier

**Date**: 2026-02

**Summary**: Applies JEPA to ultrasound imaging, addressing the modality's high noise and speckle patterns that undermine standard self-supervised approaches. Uses Static-teacher Asymmetric Latent Training (SALT) objective with a frozen domain-specific teacher for stable latent targets, avoiding the computational expense of dynamically-updated teachers.

**Key Findings**:

- SALT objective decouples student-teacher optimization while expanding semantic understanding; avoids hyperparameter brittleness of standard JEPA
- First comprehensive comparison of ultrasound foundation models using UltraBench (multi-organ, multi-pathology dataset)
- Achieves competitive or superior performance vs. domain-specific and universal vision models under linear probing for classification

**Relevance to World Models**: Extends JEPA to medical imaging domain where EchoJEPA already showed promise. The SALT objective addresses a practical barrier: standard JEPA's EMA-updated teachers are computationally expensive and sensitive to hyperparameters. If SALT transfers to other domains, it could simplify JEPA deployment for world models in healthcare applications.

### Polymer-JEPA: Joint Embedding Predictive Architecture for Polymer Molecular Graphs [<img src="templates/icons/website.svg" alt="website" height="16">](https://pubs.rsc.org/en/content/articlelanding/2026/dd/d5dd00308c)

**Authors/Presenters**: Francesco Piccoli, Gabriel Vogel, Jana M. Weber

**Date**: 2026-01

**Summary**: Applies JEPA self-supervised pretraining to polymer molecular graphs. Pretrained on conjugated copolymer photocatalysts, then fine-tuned on downstream tasks including electron affinity prediction and phase behavior classification in diblock copolymers.

**Key Findings**:

- JEPA-based pretraining enhances downstream performance, particularly when labeled data is scarce
- Cross-domain fine-tuning shows promise — method extracts generalizable knowledge across different polymer classes
- Reduces dependence on extensive labeled datasets by leveraging unlabeled polymer structures

**Relevance to World Models**: Demonstrates JEPA's applicability beyond vision/video to molecular graph domains. For scientific discovery use cases (materials science, drug discovery), this suggests JEPA-style self-supervised learning can build useful representations from unlabeled molecular data — complementing domain-specific world models like those from Periodic Labs and Medra.

### Graph-JEPA: Graph-level Representation Learning with Joint-Embedding Predictive Architectures [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2309.16014)

**Authors/Presenters**: Geri Skenderi, Hang Li, Jiliang Tang, Marco Cristani

**Date**: 2023-09 (revised 2025-01, TMLR)

**Summary**: Extends JEPA to graph-level representation learning through masked subgraph prediction. Introduces a hyperbolic prediction objective that maps encoded subgraphs to coordinates on the unit hyperbola, capturing implicit hierarchical structure in graph concepts without contrastive samples or reconstruction.

**Key Findings**:

- Predicts latent representations of masked subgraphs from context subgraphs, avoiding contrastive negative/positive samples
- Hyperbolic coordinate prediction endows representations with implicit hierarchy — captures tree-like and scale-free structures common in real-world graphs
- Strong downstream performance on graph classification, regression, and non-isomorphic graph discrimination

**Relevance to World Models**: Extends JEPA beyond grid-structured data (images, video, spectrograms) to arbitrary graph topologies. Relevant for world models operating on relational data — molecular dynamics, knowledge graphs, social networks, or scene graphs in robotics where entities and relationships matter more than pixel arrangements.

### Brain-JEPA: Brain Dynamics Foundation Model with Gradient Positioning and Spatiotemporal Masking [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2409.19407)

**Authors/Presenters**: Zijian Dong, Ruilin Li, Yilei Wu, Thuan Tinh Nguyen, Joanna Su Xian Chong, Fang Ji, Nathanael Ren Jie Tong, Christopher Li Hsian Chen, Juan Helen Zhou

**Date**: 2024-09 (NeurIPS 2024 Spotlight)

**Summary**: Foundation model for fMRI brain dynamics using JEPA with two domain-specific innovations: Brain Gradient Positioning (functional coordinate system for ROI encoding) and Spatiotemporal Masking (handles heterogeneous fMRI time-series patches). Achieves SOTA on demographic prediction, disease diagnosis/prognosis, and trait assessment.

**Key Findings**:

- Brain Gradient Positioning establishes a functional coordinate system for brain parcellation, improving positional encoding of Regions of Interest
- Spatiotemporal masking samples targets from three regions: Cross-ROI, Cross-Time, and Double-Cross — tailored to fMRI's unique characteristics
- Superior generalizability across ethnic populations; strong off-the-shelf linear probing performance

**Relevance to World Models**: Demonstrates JEPA's adaptability to complex spatiotemporal biomedical data where standard positional encodings fail. The functional coordinate system approach could transfer to other domains with non-Euclidean structure — network traffic, multi-sensor systems, or distributed robotics where "position" is functional rather than spatial.

### EEG-VJEPA: Adapting Video JEPA for Brain Signal Analysis [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2507.03633)

**Authors/Presenters**: Amirabbas Hojjati, Lu Li, Ibrahim Hameed, Anis Yazidi, Pedro G. Lind, Rabindra Khadka

**Date**: 2025-07 (revised 2026-03)

**Summary**: First application of V-JEPA to EEG classification by treating brain signals as video-like sequences. Combines predictive accuracy with interpretability — learns physiologically relevant spatial and temporal patterns that support human-AI collaboration in clinical diagnostics.

**Key Findings**:

- Treats EEG as video: channels as spatial dimension, time as temporal — enables direct application of V-JEPA's spatiotemporal masking
- Outperforms SOTA on Temple University Hospital (TUH) Abnormal EEG dataset
- Produces interpretable embeddings capturing physiologically meaningful patterns, not just classification accuracy

**Relevance to World Models**: Validates the "treat X as video" strategy for applying V-JEPA to sequential multi-channel data. The interpretability finding is significant: JEPA's latent predictions appear to capture domain-relevant structure (brain dynamics) rather than arbitrary features — a property essential for clinical world models where decisions must be explainable.

### A-JEPA: Joint-Embedding Predictive Architecture Can Listen [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2311.15830)

**Authors/Presenters**: Zhengcong Fei, Mingyuan Fan, Junshi Huang

**Date**: 2023-11 (revised 2024-01)

**Summary**: Adapts I-JEPA to audio spectrograms with a curriculum masking strategy progressing from easy to hard predictions. Introduces time-frequency aware masking that accounts for temporal and spectral correlations specific to audio, plus regularized masking during fine-tuning for improved downstream adaptation.

**Key Findings**:

- Curriculum masking: starts with easier predictions, progressively increases difficulty — mirrors human learning patterns
- Time-frequency aware masking exploits audio-specific structure (harmonic relationships, temporal continuity) vs. random block masking
- SOTA on multiple audio and speech classification tasks, outperforming externally supervised pre-training approaches

**Relevance to World Models**: First successful audio JEPA, demonstrating the architecture generalizes beyond vision. The curriculum strategy addresses a practical training challenge: audio has stronger local correlations than images, making random masking too easy early in training. Relevant for world models incorporating audio — robotics, autonomous vehicles, smart environments.

### Audio-JEPA: Joint-Embedding Predictive Architecture for Audio Representation Learning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2507.02915)

**Authors/Presenters**: Ludovic Tuncay, Etienne Labbé, Emmanouil Benetos, Thomas Pellegrini

**Date**: 2025-06 (ICME 2025)

**Summary**: Straightforward JEPA adaptation for audio using Vision Transformer on mel-spectrograms with random patch masking. Matches wav2vec 2.0 and data2vec performance on X-ARES benchmark while using less than 1/5 of their training data — demonstrates JEPA's data efficiency for audio.

**Key Findings**:

- 96.7M trainable parameters (85.4M at inference — predictor discarded); trained on unlabeled AudioSet clips (10s, 32kHz)
- Competitive with wav2vec 2.0/data2vec across speech, music, and environmental sounds using <20% training data
- No hyperparameter tuning required — robust default configuration

**Relevance to World Models**: Confirms JEPA's data efficiency advantage extends to audio domain. For embodied AI requiring audio understanding (voice commands, environmental sounds, machinery diagnostics), Audio-JEPA offers a practical foundation model that can be trained on modest data — important for specialized domains where labeled audio is scarce.

### Sat-JEPA-Diff: Bridging Self-Supervised Learning and Generative Diffusion for Remote Sensing [<img src="templates/icons/website.svg" alt="website" height="16">](https://openreview.net/forum?id=WBHfQLbgZR)

**Authors/Presenters**: Kursat Komurcu, Linas Petkevicius

**Date**: 2026-03 (ML4RS @ ICLR 2026)

**Summary**: Hybrid architecture combining I-JEPA embeddings with Stable Diffusion for satellite imagery generation. I-JEPA predicts stable semantic representations that guide a frozen diffusion model via cross-attention, eliminating the "regression to the mean" blur of deterministic methods while avoiding hallucinations of pure generative approaches.

**Key Findings**:

- I-JEPA embeddings serve as structural anchors ensuring synthesized textures maintain geographic accuracy
- GSSIM: 0.8984, FID: 0.1475 — leading perceptual scores on global Sentinel-2 data
- Resolves sharp boundaries that deterministic predictors (PredRNN, SimVP) blur

**Relevance to World Models**: Demonstrates a practical JEPA + diffusion hybrid where JEPA provides structure and diffusion provides texture. This division of labor — latent prediction for semantics, generation for appearance — may be a general pattern for world models that need both accurate dynamics and realistic rendering. Directly applicable to earth observation, environmental monitoring, and climate modeling.

### I-JEPA: Self-Supervised Learning from Images with a Joint-Embedding Predictive Architecture [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2301.08243)

**Authors/Presenters**: Mahmoud Assran, Quentin Duval, Ishan Misra, Piotr Bojanowski, Pascal Vincent, Michael Rabbat, [Yann LeCun](ecosystem.md#yann-lecun), Nicolas Ballas

**Date**: 2023-01 (ICCV 2023)

**Summary**: Foundational paper introducing the Image-based Joint-Embedding Predictive Architecture. Predicts representations of masked target blocks from a single context block in latent space, learning semantic image representations without hand-crafted data augmentations or pixel-level reconstruction.

**Key Findings**:

- Masking strategy is the critical design choice: sufficiently large target blocks (for semantic content) combined with spatially distributed context blocks (for informative prediction)
- Achieves strong downstream performance across linear classification, object counting, and depth prediction — without any augmentation-based invariances
- Highly scalable: ViT-Huge/14 trains on ImageNet using 16 A100 GPUs in under 72 hours

**Relevance to World Models**: The paper that launched the JEPA family. Demonstrates that predicting in representation space rather than pixel space naturally captures semantic structure while filtering irrelevant detail — the core principle underlying all subsequent JEPA world models. Every entry in this section traces its lineage to this architecture.

### MC-JEPA: A Joint-Embedding Predictive Architecture for Self-Supervised Learning of Motion and Content Features [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2307.12698)

**Authors/Presenters**: Adrien Bardes, Jean Ponce, [Yann LeCun](ecosystem.md#yann-lecun)

**Date**: 2023-07

**Summary**: Extends I-JEPA to video by learning separate motion and content features through two prediction pathways operating on the same joint-embedding architecture. The motion pathway predicts optical flow representations while the content pathway predicts semantic frame features, enabling the model to disentangle what moves from what things are.

**Key Findings**:

- Dual prediction pathways: motion predictor targets optical flow embeddings, content predictor targets frame-level semantic embeddings — both in latent space
- Motion features capture fine-grained temporal dynamics; content features capture scene semantics — combined features outperform either alone
- Demonstrates JEPA's extensibility from images to video while maintaining the non-generative, augmentation-free design

**Relevance to World Models**: Bridge between I-JEPA (images) and V-JEPA (video). The explicit motion-content decomposition presages world models that separately model dynamics (how things change) and state (what things are) — a design principle that recurs in Causal-JEPA's object-centric approach and NE-Dreamer's temporal transformer.

### V-JEPA: Revisiting Feature Prediction for Learning Visual Representations from Video [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2404.08471)

**Authors/Presenters**: [Adrien Bardes](ecosystem.md#adrien-bardes), Quentin Garrido, Jean Ponce, Xinlei Chen, Michael Rabbat, [Yann LeCun](ecosystem.md#yann-lecun), Mahmoud Assran, Nicolas Ballas

**Date**: 2024-02 (ICLR 2025)

**Summary**: Extends I-JEPA from images to video, learning visual representations purely through feature prediction in latent space — no pretrained encoders, text, negative examples, or pixel reconstruction. Trained on 2M videos from public datasets, producing versatile frozen representations that perform well on both motion and appearance tasks.

**Key Findings**:

- ViT-H/16 achieves 81.9% on Kinetics-400, 72.2% on Something-Something-v2, and 77.9% on ImageNet1K using only frozen backbone features
- Demonstrates that video feature prediction alone — without contrastive pairs or pixel-level supervision — learns representations capturing both temporal dynamics and spatial semantics
- Multi-block spatiotemporal masking strategy adapted from I-JEPA's image masking to video's temporal dimension

**Relevance to World Models**: The foundational video JEPA that establishes feature prediction from video as a viable self-supervised paradigm. All subsequent video JEPA world models (V-JEPA 2, V-JEPA 2.1, VLA-JEPA, EchoJEPA) build on this architecture. The key insight — that latent video prediction naturally captures physical dynamics — makes V-JEPA the bridge between SSL representation learning and world modeling.

### V-JEPA 2: Self-Supervised Video Models Enable Understanding, Prediction and Planning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2506.09985)

**Authors/Presenters**: Mahmoud Assran, [Adrien Bardes](ecosystem.md#adrien-bardes), David Fan, Quentin Garrido, Russell Howes, Mojtaba Komeili, Matthew Muckley, Ammar Rizvi, Claire Roberts, Koustuv Sinha, Artem Zholus, + 14 others, Franziska Meier, [Yann LeCun](ecosystem.md#yann-lecun), Michael Rabbat, Nicolas Ballas

**Date**: 2025-06

**Summary**: Scales V-JEPA to internet-scale pretraining on 1M+ hours of video, then post-trains an action-conditioned world model (V-JEPA 2-AC) using only 62 hours of unlabeled robot video. Achieves SOTA on video understanding, action anticipation, and zero-shot robotic planning from a single self-supervised foundation.

**Key Findings**:

- 77.3% top-1 on Something-Something-v2 (motion understanding); 39.7 Recall@5 on Epic-Kitchens-100 (action anticipation), surpassing task-specific models
- After LLM alignment, achieves 84.0 on PerceptionTest and 76.9 on TempCompass video QA at 8B scale
- V-JEPA 2-AC deployed zero-shot on Franka arms in two labs for pick-and-place — no environment-specific data, no task-specific training, no reward functions
- Progressive resolution training strategy enables efficient pretraining beyond short 16-frame clips

**Relevance to World Models**: Validates the complete JEPA world model pipeline: internet-scale SSL → action-conditioned latent world model → zero-shot robotic control via MPC. The 62-hour robot data requirement for V-JEPA 2-AC is remarkably low, demonstrating that SSL pretraining on general video provides most of the physics understanding needed for manipulation. Direct predecessor to V-JEPA 2.1.

### seq-JEPA: Autoregressive Predictive Learning of Invariant-Equivariant World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2505.03176)

**Authors/Presenters**: Hafez Ghaemi, Eilif Muller, Shahab Bakhtiari

**Date**: 2025-05 (NeurIPS 2025)

**Summary**: Resolves the invariance-equivariance trade-off in JEPA through architectural inductive biases rather than additional loss terms. Processes sequences of observations paired with transformation embeddings, automatically separating invariant aggregate representations (for classification) from equivariant encoder outputs (for spatial reasoning).

**Key Findings**:

- Architectural separation: autoregressor outputs are action-invariant (capturing what persists); encoder outputs are equivariant (capturing how things change) — no dual predictors or extra losses required
- Strong performance on both equivariance-demanding tasks (spatial reasoning, path integration) and invariance-demanding tasks (classification) without sacrificing either
- Excels at sequence aggregation tasks requiring integration across multiple observations, such as path integration and predictive learning across eye movements

**Relevance to World Models**: Addresses a fundamental tension in JEPA world models: planners need invariant state representations (to recognize goals) while dynamics models need equivariant representations (to predict how actions change state). seq-JEPA's architectural solution -- separating these automatically -- offers a principled design for world models that must serve both recognition and prediction.

### DLLM-JEPA: Joint Embedding Predictive Architectures for Masked Diffusion Language Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2606.00091)

**Authors/Presenters**: Sangdae Nam

**Date**: 2026-05

**Summary**: Pairs JEPA with masked-diffusion language models, exploiting bidirectional attention to generate two semantically distinct views via different masking rates without explicit paired data. Cuts training FLOPs by 33% vs. LLM-JEPA while improving accuracy across all evaluated tasks and architectures.

**Key Findings**:

- Diffusion LMs are a more natural substrate for JEPA than autoregressive LMs: bidirectional attention natively provides multi-view structure, eliminating the need for text-code pairs or two gradient-carrying passes
- Consistent gains: up to +18.7pp on LLaDA-8B GSM8K and +11.4pp on Dream-7B GSM8K, with positive results on Spider, NL-RX-SYNTH, and Django
- Dual-win property: simultaneously raises task accuracy while reducing catastrophic forgetting (held-out Wikitext loss below pre-trained baseline)
- Mechanistic insight via layer-wise probing reveals "geometric-functional drift dissociation" concentrated in middle transformer layers

**Relevance to World Models**: Extends JEPA from vision into language, demonstrating that the predict-in-embedding-space principle generalizes beyond video. The finding that diffusion models are a better substrate for JEPA than autoregressive models parallels the Cosmos 3 MoT design insight: different generation mechanisms suit different modalities. Accepted at SPIGM Workshop, ICML 2026.

### Demo-JEPA: One-shot Cross-Embodiment Imitation [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2605.20811)

**Authors/Presenters**: Jingyang He, Guangrun Li, Jieyu Zhang, Chengkai Hou, Zhengping Che, Shanghang Zhang

**Date**: 2026-05

**Summary**: Reframes cross-embodiment imitation as latent goal-conditioned planning within a JEPA-based world model. Rather than reproducing demonstrated actions (which are embodiment-specific), demonstrations are treated as implicit specifications of future goals. Uses V-JEPA 2.1 as the action-conditioned world model for the target embodiment.

**Key Findings**:

- Decouples demonstration intent from execution: translates source visual demonstrations into target-compatible latent trajectories in a shared predictive representation space
- No shared action spaces, heuristic retargeting, or large-scale multi-embodiment co-training required
- Matches specialized in-domain planners on RLBench; generalizes to unseen tasks and embodiment configurations where prior methods fail
- Gains increase with distribution shift, showing robustness of latent goal inference for cross-embodiment transfer

**Relevance to World Models**: Demonstrates JEPA world models as a practical bridge for cross-embodiment robotics. The insight that demonstrations should specify "what state to realize" rather than "what actions to take" leverages JEPA's latent-space prediction to sidestep the action-space alignment problem. Directly builds on V-JEPA 2.1, extending the JEPA lineage into multi-robot deployment scenarios.

### ThinkJEPA: Empowering Latent World Models with Large Vision-Language Reasoning Model [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.22281)

**Authors/Presenters**: Haichao Zhang, Yijiang Li, Shwai He, Tushar Nagarajan, Mingfei Chen, Jianglin Lu, Ang Li, Yun Fu

**Date**: 2026-03

**Summary**: Dual-path embodied prediction framework pairing a VLM "thinker" (cortex-like semantic reasoner) with a JEPA "controller" (cerebellum-like dynamics predictor). The VLM branch samples frames at a larger temporal stride for long-horizon intent; the dense JEPA branch captures fine-grained motion and interaction cues. A hierarchical pyramid module transfers multi-layer VLM representations into guidance features compatible with latent prediction.

**Key Findings**:

- Dual-temporal pathway: dense JEPA frames model fine-grained dynamics while sparse VLM frames provide knowledge-rich semantic guidance — neither branch alone matches the combined system
- Hierarchical pyramid representation extraction aggregates multi-layer VLM features into guidance compatible with latent prediction, avoiding the language-output bottleneck of standalone VLMs
- Uses Qwen3-VL (Thinking) as VLM thinker and V-JEPA 2 predictor as dynamics backbone
- Outperforms both VLM-only and JEPA-predictor baselines on hand-manipulation trajectory prediction with more robust long-horizon rollout behavior

**Relevance to World Models**: Addresses a fundamental limitation of JEPA world models: dense prediction from short observation windows biases predictors toward local extrapolation, missing long-horizon semantic context. ThinkJEPA's solution — VLM as reasoning layer atop JEPA dynamics — parallels the dual-system architecture seen in GR00T N1 and Gemini Robotics but at the world model level rather than the policy level. Code available at [ThinkJEPA](https://github.com/Hai-chao-Zhang/ThinkJEPA).

### LLM-JEPA: Large Language Models Meet Joint Embedding Predictive Architectures [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2509.14252)

**Authors/Presenters**: Hai Huang, [Yann LeCun](ecosystem.md#yann-lecun), [Randall Balestriero](ecosystem.md#randall-balestriero)

**Date**: 2025-09 (ICLR 2026 Poster)

**Summary**: First adaptation of JEPA-style embedding-space training objectives to large language models. Proposes a hybrid objective combining standard LLM loss (preserving generative capabilities) with a joint embedding prediction task (improving abstraction), using a tied-weights predictor via a special [PRED] token that reuses the LLM's internal weights. Applicable to both finetuning and pretraining.

**Key Findings**:

- Outperforms standard LLM training objectives across Llama3, OpenELM, Gemma2, and Olmo families on NL-RX, GSM8K, Spider, and RottenTomatoes
- Striking resistance to overfitting: baseline model performance plateaus and degrades during LoRA finetuning while LLM-JEPA continues to improve with more epochs
- Benefits transfer downstream: models pretrained with LLM-JEPA show improved performance on subsequent finetuning tasks even when using a standard objective
- Minimal architectural overhead: tied-weights predictor and custom attention mask enable efficient computation in a single forward pass

**Relevance to World Models**: Extends JEPA from vision into language, complementing DLLM-JEPA's diffusion-LM approach with a direct LLM integration. The overfitting resistance is particularly notable — it suggests embedding-space objectives provide a regularization effect absent from token-level prediction, potentially relevant to world models that must generalize beyond training distributions. From LeCun and Balestriero's group at Meta FAIR / Galilai. Code at [llm-jepa](https://github.com/galilai-group/llm-jepa).

---

## Energy-Based Models

*Papers, talks, and videos on EBMs for prediction and generation*

### Autoregressive Language Models are Secretly Energy-Based Models: Insights into the Lookahead Capabilities of Next-Token Prediction [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2512.15605)

**Authors/Presenters**: Mathieu Blondel, Michael E. Sander, Germain Vivier-Ardisson, Tianlin Liu, Vincent Roulet

**Date**: 2025-12 (revised 2026-01)

**Summary**: Establishes an explicit bijection between autoregressive models (ARMs) and energy-based models (EBMs) in function space. Shows this correspondence is a special case of soft Bellman equations in maximum entropy RL, providing theoretical explanation for how next-token prediction enables lookahead planning.

**Key Findings**:

- Derives equivalence between supervised learning approaches for ARMs and EBMs; unified view connects two historically distinct paradigms
- Analyzes distillation of energy-based models into autoregressive models with theoretical error bounds
- Explains lookahead planning capabilities of ARMs despite being trained on next-token prediction, via the EBM connection

**Relevance to World Models**: Bridges autoregressive and energy-based frameworks theoretically, suggesting that next-token predictors implicitly learn energy landscapes. Relevant to understanding how world models might plan ahead using energy-based formulations rather than explicit rollouts.

### Kona 1.0: Energy-Based Reasoning Model [<img src="templates/icons/website.svg" alt="website" height="16">](https://logicalintelligence.com/kona-ebms-energy-based-models)

**Authors/Presenters**: Eve Bodnia, [Logical Intelligence](ecosystem.md#logical-intelligence)

**Date**: 2026-01

**Summary**: First commercial Energy-Based Reasoning Model (EBRM) designed for constraint satisfaction in critical systems. Unlike autoregressive LLMs that predict likely next tokens, Kona maps candidate solutions onto an energy landscape and navigates to minimum-energy (valid) states. Non-autoregressive at the trace level — generates complete reasoning traces simultaneously using continuous vector tokens rather than discrete tokens.

**Key Findings**:

- 96.2% Sudoku solve rate in 313ms average vs. 2% for leading LLMs (GPT-5.2, Claude Opus, Gemini, DeepSeek) taking up to 90 seconds — runs on single NVIDIA H100
- Non-autoregressive architecture enables bidirectional optimization — can revise any section of a reasoning trace without regenerating long prefixes
- Continuous latent space reasoning with dense vector tokens enables gradient-based refinement impossible with discrete token representations
- Aleph (orchestration layer) achieved near-perfect score on PutnamBench formal mathematics benchmark

**Relevance to World Models**: First commercial implementation of EBM principles for reasoning, with [Yann LeCun](ecosystem.md#yann-lecun) as Founding Chair of Technical Research Board. Shares key properties with JEPA: continuous latent space, non-autoregressive generation, energy minimization. Where JEPA learns representations via prediction, Kona applies EBM principles to constraint satisfaction — complementary applications of the same paradigm. Validates LeCun's thesis that energy-based approaches offer advantages over autoregressive models for tasks requiring global coherence.

---

## Dragon Hatchling (BDH)

*Research on Baby Dragon Hatchling models*

### The Dragon Hatchling: The Missing Link between the Transformer and Models of the Brain [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2509.26507)

**Authors/Presenters**: [Adrian Kosowski](ecosystem.md#adrian-kosowski), Przemysław Uznański, Jan Chorowski, Zuzanna Stamirowska, Michał Bartoszkiewicz

**Date**: 2025-09

**Summary**: Proposes Baby Dragon Hatchling (BDH), a biologically-inspired LLM architecture based on a scale-free network of locally-interacting neuron particles. Bridges transformers and brain models by using synaptic plasticity with Hebbian learning via spiking neurons, while matching GPT-2 performance at equivalent parameter counts (10M–1B).

**Key Findings**:

- Achieves transformer-like scaling laws rivaling GPT-2 on language and translation tasks at identical parameter counts and training data
- Working memory relies entirely on synaptic plasticity with Hebbian learning; exhibits heavy-tailed degree distributions and high modularity matching biological networks
- Sparse, positive activation vectors demonstrate monosemanticity on language tasks, providing built-in interpretability at the architecture level rather than as a post-hoc analysis
- Individual synapses strengthen for specific concepts during processing, enabling interpretability beyond neuron-level analysis

**Relevance to World Models**: Introduces a fundamentally different architecture for learning world representations, grounded in neuroscience rather than the attention mechanism. The built-in interpretability and biologically plausible learning rules could offer advantages for world models that need to build causal, compositional representations of environments.

---

## World Models & Model-Based RL

*Papers on world models, DreamerV3, latent models, etc.*

### Introducing Agora-1: Multi-Agent World Models [<img src="templates/icons/website.svg" alt="website" height="16">](https://odyssey.ml/introducing-agora-1)

**Authors/Presenters**: Oliver Cameron, Aravind Kaimal, James Grieve, Sirish Srinivasan, Vinh-Dieu Lam, Zygmunt Łenyk et al. ([Odyssey](ecosystem.md#odyssey))

**Date**: 2026-05

**Summary**: Introduces Agora-1, a multi-agent world model that decouples simulation from rendering — a world state model learns dynamics from internal game state while a DiT-based rendering model generates consistent visuals from multiple viewpoints conditioned on shared state. Demonstrated on GoldenEye with up to 4 players interacting in a shared world simultaneously. First world model to support multi-agent interaction in a shared simulation.

**Key Findings**:

- Decoupling simulation (state model) from rendering (DiT conditioned on state) enables multi-agent scaling without frame concatenation; architecturally distinct from Multiverse (split-screen), Solaris (sequence concatenation), and MultiGen (different state/rendering coupling)
- Shared state representation allows direct manipulation — generating entirely new levels while preserving learned dynamics, without retraining
- Multi-agent world models enable training data generation for collaborative robotics, fleet coordination, and adversarial scenarios that single-agent models (Cosmos, Genie 3, GameNGen) cannot produce
- PROWL adversarial RL framework extends to multi-agent settings: agents co-evolve with the world model, exposing failures in increasingly difficult regimes

**Relevance to World Models**: Addresses a fundamental gap in current world models — all major systems (Cosmos, Genie 3, Marble, DreamerV3) support only single-agent interaction. The decoupled state/rendering architecture mirrors traditional game engine structure (physics + renderer) but with entirely learned components, pointing toward a "learned simulation engine" paradigm. Target use cases — multi-robot coordination, AV multi-agent scenarios, defense wargaming — require exactly this multi-agent capability. Architecturally orthogonal to the latent-space (JEPA/Dreamer) vs. pixel-space (Cosmos) debate; the key innovation is in the state representation, not the generation mechanism.

### Qwen-RobotWorld: Unifying Embodied World Modeling through Language-Conditioned Video Generation [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2606.17030)

**Authors/Presenters**: Jie Zhang, Xiaoyue Chen, Anzhe Chen, Chenxu Lv, Deqing Li et al. (38 authors, Alibaba Tongyi Lab)

**Date**: 2026-06

**Summary**: Language-conditioned video world model that uses natural language as a unified action interface to predict physically grounded future visual trajectories across manipulation, driving, navigation, and human-to-robot transfer. Built on a 60-layer double-stream MMDiT coupling frozen Qwen2.5-VL semantics with video-VAE latents, trained on an 8.6M video-text corpus (200M+ frames) spanning 20+ embodiments and 500+ action categories.

**Key Findings**:

- 60-layer double-stream diffusion transformer with layer-wise joint attention between frozen Qwen2.5-VL language/vision features and video-VAE latent representations
- Embodied World Knowledge (EWK) corpus: 8.6M video-text pairs, 200M+ frames, 20+ embodiments, 500+ action categories — language-annotated action mapping enables cross-domain transfer
- Two-stage progressive curriculum: general visual priors first, then embodied specialization under shared language interface
- Ranks 1st overall on EWMBench and DreamGen Bench; outperforms all open-source models on WorldModelBench and PBench
- Zero-shot generalization on RoboTwin-IF benchmark with multi-view consistency
- Three downstream applications: synthetic data augmentation for policy training, scalable virtual evaluation environments, language-guided planning signals

**Relevance to World Models**: First major Chinese Big Tech entry into video world models for robotics. The language-conditioned approach is architecturally distinct from Cosmos (tokenized video + MoT) and DreamZero (video diffusion + joint action prediction) — Qwen-RobotWorld uses language as the action interface rather than native action tokens, enabling cross-embodiment transfer via natural language descriptions. Part of the broader Qwen-Robot suite (RobotManip VLA + RobotNav VLN + RobotWorld + RobotClaw agent framework). The 8.6M video corpus across 20+ embodiments is a significant data asset. Pilot testing with Alibaba Cloud enterprise clients signals commercial deployment intent. [Local copy](library/papers/2026-06-15-qwen-robotworld.pdf).

---

### DreamZero: World Action Models are Zero-shot Policies [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.15922)

**Authors/Presenters**: Seonghyeon Ye, Yunhao Ge, Jim Fan, Yuke Zhu ([NVIDIA](ecosystem.md#nvidia) GEAR Lab)

**Date**: 2026-02

**Summary**: Introduces World Action Models (WAMs), a 14B-parameter architecture that jointly predicts video frames and robot actions through a shared denoising objective built on a pretrained video diffusion backbone (Wan2.1-I2V). Unlike VLAs trained on static image-text pairs, WAMs learn physical dynamics by predicting future world states and using video as a dense representation of how the world evolves.

**Key Findings**:

- 62.2% average task progress on seen tasks vs. 27.4% for pretrained VLAs; 39.5% vs. 16.3% on unseen tasks — 2x better generalization
- Cross-embodiment transfer: 12 minutes of human video yields >42% improvement on unseen tasks; adapts to new robot (YAM) with 30 minutes of play data
- Diverse training data outperforms repetitive demonstrations — key insight reverses conventional robotics wisdom
- DreamZero-Flash achieves single-step inference at ~150ms via decoupled noise schedules; 38x speedup through system/implementation/model optimizations
- GR00T N2 (planned end 2026) will be built on DreamZero architecture

**Relevance to World Models**: Establishes World Action Models as a new architecture family alongside VLAs and JEPA-based world models. WAMs treat video generation as an implicit visual planner guiding action production — the world model is embedded in the video diffusion backbone rather than being a separate component. Jim Fan characterizes this as the "GPT-2 moment" for robotics.

### π*0.6 and RECAP: A VLA that Learns from Experience [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.pi.website/blog/pistar06)

**Authors/Presenters**: [Physical Intelligence](ecosystem.md#physical-intelligence-pi)

**Date**: 2025-11

**Summary**: Introduces RECAP (RL with Experience & Corrections via Advantage-conditioned Policies), a method enabling VLAs to improve through reinforcement learning without policy gradients. Addresses the fundamental challenge that imitation-only training leads to compounding errors in physical environments. π*0.6 trained with RECAP achieves >90% success rates on complex manipulation tasks.

**Key Findings**:

- Converts RL to conditional supervised learning — avoids computing log-probabilities required by standard RL (PPO, SAC), which flow matching models don't provide
- Three-stage learning: demonstrations → expert corrections during errors → autonomous practice with value function feedback
- Value functions solve credit assignment — identifies whether failures originated from early missteps or later actions
- More than doubles throughput on espresso making, box assembly; reduces failure rate by 2x+ on laundry folding
- Enables continuous autonomous operation for extended periods with >90% success rates

**Relevance to World Models**: Demonstrates RL post-training for embodied AI that parallels RLVR-World and WorldCompass. RECAP solves the credit assignment problem critical for long-horizon tasks where world model predictions must identify which past actions caused future failures. Limitation: cannot discover globally optimal policies — only improves within the behavioral distribution of training data.

### RL Tokens (RLT): Precise Manipulation with Efficient Online RL [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.pi.website/research/rlt)

**Authors/Presenters**: Charles Xu, Jost Tobias Springenberg, Michael Equi, Ali Amin, Adnan Esmail, [Sergey Levine](ecosystem.md#sergey-levine), Liyiming Ke — [Physical Intelligence](ecosystem.md#physical-intelligence-pi)

**Date**: 2026-03

**Summary**: Introduces RL Tokens (RLT), a method to add real-time online RL fine-tuning to frozen VLA models for sub-millimeter precision tasks. An encoder-decoder information bottleneck compresses VLA image embeddings into a compact "RL token" that feeds a lightweight actor-critic, enabling hundreds of RL updates per second directly on the robot with as little as 15 minutes of interaction data.

**Key Findings**:

- Decouples foundation model from adaptation: VLA is frozen after RL token training; only a small actor-critic updates during online RL
- Actor learns to *edit* VLA actions rather than replace them, with regularization keeping exploration close to the VLA's baseline behavior
- Speeds up the most precise task phases by up to 3x; on Ethernet insertion, the RL policy's median episode length (66 steps) is 2.2x faster than teleoperation (146 steps)
- Requires only 15 minutes of robot data (2 hours wall-clock including resets) for Ethernet insertion — order-of-magnitude more sample-efficient than typical online RL
- Evaluated on four contact-rich tasks requiring sub-millimeter precision: M3 screw driving, zip tie fastening, Ethernet cable insertion, power cord insertion

**Relevance to World Models**: Complements RECAP — where RECAP improves long-horizon task reliability through offline RL, RLT targets real-time precision refinement through online RL. The information-bottleneck architecture (compressing VLA representations into RL tokens) parallels latent world model approaches but for action adaptation rather than state prediction. The "freeze backbone, adapt lightweight head" pattern mirrors LoRA-style adaptation but operates in the physical control loop at hundreds of Hz, demonstrating that VLA post-training can be split by timescale: slow offline improvement (RECAP) for coarse planning and fast online adaptation (RLT) for fine-grained dexterity.

### GEN-1: Scaling Embodied Foundation Models to Mastery [<img src="templates/icons/website.svg" alt="website" height="16">](https://generalistai.com/blog/apr-02-2026-GEN-1)

**Authors/Presenters**: [Generalist AI](ecosystem.md#generalist-ai)

**Date**: 2026-04

**Summary**: Native embodied foundation model trained from scratch on 500K+ hours of real-world physical interaction data captured via low-cost wearable "data hands" (UMIs) worn by humans — no robot data or internet images in base pretraining. Achieves 99% success rates on production tasks vs. 64% for GEN-0, completing tasks 3x faster with 10x less task-specific data.

**Key Findings**:

- Wearable-first data collection bypasses robotics data bottleneck — captures human reflexes and micro-corrections more efficiently than teleoperation
- 99% success demonstrated across vacuum servicing (200+ reps), box folding (200+ reps), phone packing (100+ reps), block packing (1800+ reps)
- Requires only ~1 hour of robot-specific data for new task adaptation
- Full system redesign vs. VLA approach — "large multimodal model that emits actions in real-time" with inference harnessing components

**Relevance to World Models**: Represents a third paradigm beyond VLAs (internet pretraining + action decoder) and WAMs (video diffusion backbone). Generalist trains on physical interaction data from wearables, suggesting that world dynamics can be learned directly from human movement without intermediate video or simulation. If validated at scale, could offer a more data-efficient path to physical AI than video-based world models.

### VLA-MBPO: Towards Practical World Model-based Reinforcement Learning for Vision-Language-Action Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.20607)

**Authors/Presenters**: Zhilong Zhang, Haoxiang Ren, Yihao Sun, Yifei Sheng, Haonan Wang, Haoxin Lin, Zhichao Wu, Pierre-Luc Bacon, Yang Yu

**Date**: 2026-03

**Summary**: Practical framework for finetuning Vision-Language-Action (VLA) models using world models instead of costly real-world interaction. Addresses three key challenges in VLA+world model RL: pixel-level world modeling, multi-view consistency, and compounding errors under sparse rewards.

**Key Findings**:

- Adapts pretrained unified multimodal models as world model backbone for sample-efficient pixel-space prediction without expensive video rollouts
- Interleaved view decoding enforces cross-view consistency while preserving view-specific details for precise robotic control
- Chunk-level branched rollout limits error accumulation; value model progressively aligns with ground-truth returns through cross-chunk temporal dependencies

**Relevance to World Models**: Bridges VLA models (strong generalization from language grounding) with world model-based RL (sample-efficient learning). Demonstrates practical integration path where world models serve as safe, cheap training environments for large pretrained robotic policies.

### R2-Dreamer: Redundancy-Reduced World Models without Decoders or Augmentation [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.18202)

**Authors/Presenters**: Naoki Morihira, Amal Nahar, Kartik Bharadwaj, Yasuhiro Kato, Akinobu Hayashi, Tatsuya Harada

**Date**: 2026-03 (ICLR 2026)

**Summary**: Decoder-free MBRL framework using Barlow Twins-inspired redundancy reduction as internal regularizer to prevent representation collapse without data augmentation. Removes decoder overhead while maintaining competitive performance, addressing the limitation that data augmentation can distort task-critical information.

**Key Findings**:

- Competitive with DreamerV3 and TD-MPC2 on DeepMind Control Suite and Meta-World while training 1.59x faster
- Substantial gains on DMC-Subtle benchmark (tiny task-relevant regions) where augmentation-based methods struggle
- Releases unified PyTorch codebase with DreamerV3 reimplementation and baselines, plus DMC-Subtle benchmark

**Relevance to World Models**: Advances decoder-free world models by replacing heuristic data augmentation with principled self-supervised regularization. The Barlow Twins connection parallels VICReg in JEPA — both use redundancy reduction to prevent collapse, suggesting convergent design principles across world model architectures.

### NE-Dreamer: Next Embedding Prediction Makes World Models Stronger [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.02765)

**Authors/Presenters**: George Bredis, Nikita Balagansky, Daniil Gavrilov, Ruslan Rakhimov

**Date**: 2026-03

**Summary**: Decoder-free MBRL agent using a temporal transformer to predict next-step encoder embeddings from latent state sequences. Directly optimizes temporal predictive alignment in representation space, eliminating reconstruction losses and auxiliary supervision.

**Key Findings**:

- Matches or exceeds DreamerV3 on DeepMind Control Suite; substantial gains on DMLab tasks requiring memory and spatial reasoning
- Ablations attribute performance to predictive sequence modeling (causal transformer + next-step target shift), not reconstruction
- Decoder-free design removes computational burden of pixel-level reconstruction while improving representation quality

**Relevance to World Models**: Directly implements the JEPA principle — predicting in embedding space rather than pixel space — within the Dreamer family of world models. Demonstrates that next-embedding prediction with temporal transformers is a viable alternative to reconstruction-based world models, with particular advantages for tasks requiring memory and reasoning.

### DINO-WM: World Models on Pre-trained Visual Features Enable Zero-shot Planning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2310.15848)

**Authors/Presenters**: Gaoyue Zhou, Hengkai Pan, [Yann LeCun](ecosystem.md#yann-lecun), Lerrel Pinto

**Date**: 2023-10 (ICML 2025)

**Summary**: Learns visual dynamics models in DINOv2 feature space rather than pixel space, predicting future spatial patch features from offline trajectories. At test time, optimizes action sequences so predicted features match goal observation features, achieving zero-shot goal-reaching without expert demonstrations, reward functions, or inverse models.

**Key Findings**:

- Zero-shot behavioral solutions at test time through action sequence optimization in frozen DINOv2 feature space — no task-specific training required
- Outperforms prior SOTA across arbitrarily configured mazes, push manipulation with varied object shapes, and multi-particle scenarios
- Feature-space world modeling sidesteps pixel-level prediction difficulty while preserving spatial structure needed for control
- Task-agnostic: same world model serves diverse goal-reaching tasks by treating goal features as prediction targets

**Relevance to World Models**: Establishes DINOv2 features as a strong foundation for world models, demonstrating that frozen SSL representations contain sufficient structure for dynamics learning and planning. Frequently used as a baseline alongside V-JEPA-2-AC in subsequent work (JEPA-WMs, Hierarchical Planning). The zero-shot planning capability validates the JEPA principle that predicting in representation space enables effective control without reconstruction.

### DINO-world: Back to the Features — DINO as a Foundation for Video World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2507.19468)

**Authors/Presenters**: Federico Baldassarre, Marc Szafraniec, Basile Terver, Vasil Khalidov, Francisco Massa, [Yann LeCun](ecosystem.md#yann-lecun), Patrick Labatut, Maximilian Seitzer, Piotr Bojanowski

**Date**: 2025-07

**Summary**: Generalist video world model that predicts future frames in DINOv2 latent space. Trains a future predictor on large-scale uncurated video to learn temporal dynamics across driving, indoor scenes, and simulated environments. Fine-tunable with observation-action trajectories for action-conditioned planning via latent trajectory simulation.

**Key Findings**:

- Outperforms previous models on video prediction benchmarks including segmentation and depth forecasting
- Demonstrates strong understanding of intuitive physics from uncurated video training alone
- Action-conditioned variant enables planning by simulating candidate trajectories in latent space
- Generalist capability across diverse scene types without domain-specific engineering

**Relevance to World Models**: Scales the DINO-WM approach from task-specific to generalist video world modeling. Where DINO-WM learns dynamics from offline trajectories per environment, DINO-world trains on diverse uncurated video at scale — closer to the V-JEPA 2 paradigm of learning general physics from internet video, but using DINOv2 rather than JEPA as the feature backbone.

### DINO-Foresight: Looking into the Future with DINO [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2412.11673)

**Authors/Presenters**: Efstathios Karypidis, Ioannis Kakogeorgiou, Spyros Gidaris, Nikos Komodakis

**Date**: 2024-12 (NeurIPS 2025)

**Summary**: Forecasts future VFM features using a masked feature transformer trained in self-supervised fashion. Predicts temporal evolution of frozen DINOv2 features, then applies off-the-shelf task-specific heads (segmentation, depth, surface normals) for future-frame scene understanding — no pixel-level prediction needed.

**Key Findings**:

- Forecasts semantically rich VFM features rather than low-level pixels or VAE latents, inheriting strong scene understanding from the frozen encoder
- Task-agnostic prediction: same predicted features serve semantic segmentation, depth estimation, and surface normal prediction via pluggable heads
- Two-stage training at progressive resolutions (224×448 → 448×896) for efficiency
- Code and models released at [github.com/Sta8is/DINO-Foresight](https://github.com/Sta8is/DINO-Foresight)

**Relevance to World Models**: Complements DINO-WM and DINO-world by focusing on dense scene understanding from predicted features rather than control/planning. The pluggable task-head design validates that future VFM features are general enough for diverse downstream tasks — the same predicted latent serves segmentation, depth, and normals. Particularly relevant for autonomous driving where multiple perception outputs are needed from a single world model.

### Learning Abstract World Models with a Group-Structured Latent Space [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2506.01529)

**Authors/Presenters**: Thomas Delliaux, Nguyen-Khanh Vu, Vincent François-Lavet, Elise van der Pol, Emmanuel Rachelson

**Date**: 2025-06

**Summary**: Imposes geometric priors on latent world model representations by structuring the latent space using group theory. Leverages known rotational and translational symmetries — including in first-person 3D views — to encode environment invariances, yielding simpler, more disentangled representations with better transition model predictions and downstream RL performance.

**Key Findings**:

- Group-structured latent spaces yield better transition model predictions than fully unstructured approaches across multiple environments
- Produces simpler and more disentangled representations compared to baselines
- Framework permits embedding additional unstructured information alongside known symmetries — not all-or-nothing
- Full code released for reproducibility

**Relevance to World Models**: Addresses a fundamental question: what structure should a world model's latent space have? Rather than learning structure entirely from data (JEPA, Dreamer) or imposing full physics (Hamiltonian models), this approach injects known geometric symmetries while allowing data-driven learning for everything else. Complementary to Causal-JEPA's object-centric structure and the Hamiltonian world models' physics-based structure.

### RLVR-World: Training World Models with Reinforcement Learning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2505.13934)

**Authors/Presenters**: Jialong Wu, Shaofeng Yin, Ningya Feng, Mingsheng Long

**Date**: 2025-05 (NeurIPS 2025)

**Summary**: Unified framework applying reinforcement learning with verifiable rewards (RLVR) to optimize world models directly for transition prediction metrics rather than maximum likelihood. Formulates world modeling as autoregressive prediction of tokenized sequences, then evaluates decoded predictions as verifiable rewards.

**Key Findings**:

- +30.7% accuracy for 1.5B LLM as text-based world simulator, rivaling GPT-4; +15.1% F1 on web navigation world models
- +18.4% relative improvement on WebArena success rates when using RLVR-trained world models for web agents
- Demonstrates RLVR as general post-training paradigm applicable to both language and video world models across text games, web navigation, and robot manipulation

**Relevance to World Models**: Introduces RL-based post-training as a complement to supervised pretraining for world models. Rather than learning to predict next tokens/pixels accurately, RLVR optimizes for task-relevant transition quality — a shift that parallels the JEPA philosophy of learning useful representations over faithful reconstruction.

### WorldCompass: Reinforcement Learning for Long-Horizon World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.09022)

**Authors/Presenters**: Zehan Wang, Tengfei Wang, Haiyu Zhang, Xuhui Zuo, Junta Wu, Haoyuan Wang, Wenqiang Sun, Zhenwei Wang, Chenjie Cao, Hengshuang Zhao, Chunchao Guo, Zhou Zhao

**Date**: 2026-02

**Summary**: Introduces an RL post-training framework for long-horizon, interactive video-based world models. Uses clip-level rollout strategy with complementary reward functions to improve both interaction-following accuracy and visual fidelity without reward-hacking.

**Key Findings**:

- Clip-level rollout generates and evaluates multiple samples at single target clips, enabling fine-grained reward signals and improved rollout efficiency
- Dual reward design addresses interaction-following accuracy and visual quality independently, preventing reward-hacking
- Demonstrates significant improvements on WorldPlay (SOTA open-source world model) across interaction accuracy and visual fidelity metrics

**Relevance to World Models**: Directly tackles a core challenge in video-based world models: maintaining consistency and accuracy over long horizons. RL post-training approach is complementary to JEPA-style pretraining and could be applied to JEPA-based world models.

### Reinforcement World Model Learning for LLM-based Agents [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.05842)

**Authors/Presenters**: Xiao Yu, Baolin Peng, Ruize Xu, Yelong Shen, Pengcheng He, Suman Nath, Nikhil Singh, Jiangfeng Gao, Zhou Yu

**Date**: 2026-02

**Summary**: Proposes Reinforcement World Model Learning (RWML), a self-supervised method for learning action-conditioned world models in LLM-based agents using sim-to-real gap rewards. Prioritizes semantic equivalence over token-level fidelity, providing robust training signal less susceptible to reward hacking than LLM-as-a-judge approaches.

**Key Findings**:

- Surpasses direct task-success reward RL by 6.9 points on ALFWorld and 5.7 points on τ² Bench while matching expert-data training performance
- Achieves significant gains over base model entirely through self-supervision without task-success rewards
- Grounds learning in pre-trained embedding spaces rather than surface-level token matching, avoiding model collapse from token-level prediction
- Provides more robust training signal than LLM-as-a-judge by using sim-to-real gap rewards
- Demonstrates that world-modeling capabilities enable LLM agents to anticipate action consequences and adapt to environment dynamics

**Relevance to World Models**: Directly advances world models for textual environments by enabling LLMs to learn action-conditioned dynamics models. Shows that world model learning via RL can be more effective than direct task reward optimization, validating model-based approaches for LLM agents.

### Optimistic World Models: Efficient Exploration in Model-Based Deep Reinforcement Learning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.10044)

**Authors/Presenters**: Akshay Mete, Shahid Aamir Sheikh, Tzu-Hsiang Lin, Dileep Kalathil, P. R. Kumar

**Date**: 2026-02

**Summary**: Introduces Optimistic World Models (OWMs), bringing classical reward-biased maximum likelihood estimation from adaptive control into deep RL. Incorporates optimism directly into model learning via optimistic dynamics loss that biases imagined transitions toward higher-reward outcomes, avoiding need for uncertainty estimates or constrained optimization.

**Key Findings**:

- Gradient-based optimistic exploration mechanism requiring neither uncertainty estimates nor constrained optimization, offering computational advantages over UCB-style methods
- Plug-and-play compatibility demonstrated with DreamerV3 and STORM architectures as Optimistic DreamerV3 and Optimistic STORM
- Demonstrates significant improvements in sample efficiency and cumulative returns compared to baseline methods
- Integrates classical adaptive control principles (RBMLE) with contemporary deep RL world model architectures
- Provides principled alternative to uncertainty-based exploration strategies for sparse-reward environments

**Relevance to World Models**: Directly advances world model-based RL by providing principled methodology for efficient exploration. Demonstrates that classical control theory (RBMLE) can be successfully integrated with modern deep world models, offering scalable exploration without expensive uncertainty quantification.

### World4RL: Diffusion World Models for Policy Refinement with Reinforcement Learning for Robotic Manipulation [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2509.19080)

**Authors/Presenters**: Zhennan Jiang, Kai Liu, Yuxin Qin, Shuai Tian, Yupeng Zheng, Mingcai Zhou, Chao Yu, Haoran Li, Dongbin Zhao

**Date**: 2025-09 (revised 2026-03)

**Summary**: Framework using diffusion-based world models as high-fidelity simulators for refining imitation-learning-initialized manipulation policies entirely in imagination, avoiding costly real-world interaction and sim-to-real gaps from traditional simulators. Pre-trains a diffusion world model on multi-task datasets to capture diverse dynamics, then performs direct end-to-end policy optimization within the frozen world model.

**Key Findings**:

- 16% absolute improvement in simulation and 25% in real-robot settings over baselines — significantly higher success rates compared to imitation learning alone
- Two-hot action encoding scheme tailored for robotic manipulation improves modeling fidelity over standard continuous encoding
- End-to-end policy optimization within frozen world model — uses world model for direct RL rather than only planning, distinguishing it from MPC-based approaches
- Training entirely in imagination eliminates real-world interaction during refinement while maintaining sim-to-real transfer quality

**Relevance to World Models**: Demonstrates diffusion models as a viable backbone for world model-based policy improvement in robotics. Contrasts with JEPA-based approaches (which plan in latent space via MPC) and with VLA-MBPO (which uses multimodal LMs as world model backbone) — World4RL uses diffusion models for direct RL-based policy optimization rather than planning. The frozen-world-model approach parallels Ctrl-World's use of world models as training environments rather than inference-time planners.

### From Word to World: Can Large Language Models be Implicit Text-based World Models? [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2512.18832)

**Authors/Presenters**: Yixia Li, Hongru Wang, Jiahao Qiu, Zhenfei Yin, Dongdong Zhang, Cheng Qian, Zeping Li, Pony Ma, Guanhua Chen, Heng Ji

**Date**: 2025-12 (revised 2026-03)

**Summary**: Proposes a three-level evaluation framework for LLM-based world models: (i) fidelity and consistency, (ii) scalability and robustness, and (iii) agent utility. Evaluates across five text-based environments, identifying when LLM world models help and when they fail.

**Key Findings**:

- Well-trained LLM world models maintain coherent latent state, scale predictably with data and model size, and improve agent performance
- Identifies three improvement mechanisms: action verification, synthetic trajectory generation, and warm-starting reinforcement learning
- Benefits depend critically on behavioral coverage and environment complexity — delineates clear boundaries on when world modeling supports agent learning

**Relevance to World Models**: Complements visual/latent world models by evaluating whether LLMs can serve as text-domain world models. The finding that benefits scale with data/model size but break down with insufficient behavioral coverage mirrors challenges in visual world models, suggesting shared principles across modalities.

### Cosmos World Foundation Model Platform for Physical AI [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2501.03575)

**Authors/Presenters**: Niket Agarwal, Arslan Ali, Maciej Bala, Yogesh Balaji, Erik Barker, + 72 others ([NVIDIA](ecosystem.md#nvidia))

**Date**: 2025-01 (revised 2025-07)

**Summary**: Introduces the Cosmos platform for building customized world models for Physical AI. Defines a World Foundation Model (WFM) as a general-purpose world model fine-tunable into specialized world models for downstream applications. Platform encompasses video curation pipeline, pre-trained WFMs, post-training examples, and video tokenizers. Trained on 20M hours of real-world data (9,000 trillion tokens).

**Key Findings**:

- Frames world models as "digital twins of the physical environment" paired with policy models as "digital twins of the AI system" — two components needed for Physical AI
- Provides end-to-end pipeline: video data curation → tokenization → pre-training → post-training for domain-specific world models
- Open-source platform with permissive licensing (Apache 2 + NVIDIA Open Model License), enabling commercial use
- Positions WFMs as solving the data scaling problem for robotics/AV by generating synthetic training data

**Relevance to World Models**: Defines the industrial paradigm for world foundation models — general-purpose video prediction models fine-tunable into domain-specific world simulators. Contrasts with JEPA's latent-space approach by operating in video/pixel space, making predictions directly renderable and inspectable but potentially less efficient for planning.

### World Simulation with Video Foundation Models for Physical AI (Cosmos-Predict2.5) [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2511.00062)

**Authors/Presenters**: Arslan Ali, Junjie Bai, Maciej Bala, Yogesh Balaji, Aaron Blakeman, + 83 others ([NVIDIA](ecosystem.md#nvidia))

**Date**: 2025-10 (revised 2026-02)

**Summary**: Presents Cosmos-Predict2.5, a flow-based architecture unifying Text2World, Image2World, and Video2World generation into a single model. Integrates Cosmos-Reason1 as text encoder for improved physical grounding. Trained on 200M curated video clips with RL-based post-training at 2B and 14B parameter scales.

**Key Findings**:

- Flow-based architecture replaces diffusion-based approach from Predict1, unifying three generation modalities (text/image/video → world) in a single model
- Cosmos-Transfer2.5 control-net framework enables Sim2Real and Real2Real world translation, 3.5x smaller than predecessor with superior fidelity
- RL-based post-training improves video quality and instruction alignment beyond supervised training alone
- Released with post-training recipes for robot policy models and action-conditioned distillation

**Relevance to World Models**: Represents the current SOTA for industrial video-based world models. The shift from diffusion to flow-based architecture and integration of physical reasoning (via Cosmos-Reason1) shows convergence toward world models that understand physics, not just generate plausible video. The Sim2Real transfer capability directly enables robotics applications.

### Cosmos-Reason1: From Physical Common Sense to Embodied Reasoning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2503.15558)

**Authors/Presenters**: Alisson Azzolini, Junjie Bai, Hannah Brandon, Jiaxin Cao, Prithvijit Chattopadhyay, + 47 others ([NVIDIA](ecosystem.md#nvidia))

**Date**: 2025-03 (revised 2025-05)

**Summary**: Introduces multimodal language models for physical AI reasoning — understanding the physical world and generating embodied decisions via chain-of-thought reasoning. Defines a hierarchical ontology for physical common sense (space, time, physics) and a two-dimensional ontology for embodied reasoning that generalizes across different physical embodiments. Models at 7B and 56B scales.

**Key Findings**:

- Hierarchical ontology captures fundamental knowledge about space, time, and physics; two-dimensional embodied reasoning ontology generalizes across different physical embodiments
- Four-stage training: vision pre-training → general SFT → Physical AI SFT → Physical AI RL; last two stages bring significant improvements
- 7B and 56B model variants; serves as text encoder in Cosmos-Predict2.5 for physically-grounded world simulation
- Chain-of-thought reasoning enables models to explain physical dynamics without human annotations

**Relevance to World Models**: Adds explicit physical reasoning to world models — rather than learning physics implicitly from video prediction, Cosmos-Reason encodes physical common sense as structured knowledge. Complementary to JEPA-style approaches: where JEPA learns physics from prediction, Cosmos-Reason provides explicit physical ontologies that can guide and constrain world model predictions.

### Genie 3: A New Frontier for World Models [<img src="templates/icons/website.svg" alt="website" height="16">](https://deepmind.google/blog/genie-3-a-new-frontier-for-world-models/)

**Authors/Presenters**: Jack Parker-Holder, Shlomi Fruchter (Google DeepMind)

**Date**: 2025-08

**Summary**: General-purpose world model generating interactive environments from text prompts at 24 fps in 720p resolution with real-time user interaction. Extends Genie 2 with real-time interactivity, extended temporal consistency (minutes of coherent environment), promptable world events via text, and dynamic frame-by-frame generation.

**Key Findings**:

- First Genie model supporting live user control — processes inputs multiple times per second while maintaining auto-regressive generation
- Visual memory extends approximately one minute into the past; maintains environmental consistency for several minutes of continuous interaction
- Generates physically richer environments than explicit 3D representation methods, though limited to restricted agent action spaces and poor multi-agent interactions
- Currently available as limited research preview for academics and creators

**Relevance to World Models**: Represents DeepMind's approach to interactive world models — operating in pixel space (like Cosmos) rather than latent space (like JEPA). The real-time interaction capability is a significant engineering achievement, though the minutes-scale consistency horizon and restricted action spaces highlight remaining challenges for using video-based world models as true environment simulators.

### Marble: A Multimodal World Model [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.worldlabs.ai/blog/marble-world-model)

**Authors/Presenters**: [World Labs](ecosystem.md#world-labs) ([Fei-Fei Li](ecosystem.md#fei-fei-li))

**Date**: 2025-11

**Summary**: Generative 3D world model that creates full, persistent 3D environments from diverse inputs — text, images, video, and coarse 3D layouts. Users can iteratively edit, expand, and compose worlds using the Chisel sculpting tool, then export as Gaussian splats, triangle meshes, or video. Integrates with THREE.js via the open-source Spark renderer.

**Key Findings**:

- Decouples structure from style: Chisel provides 3D sculpting control over layout before AI generates visual details, enabling human-AI co-creation
- Supports multimodal world creation: text-to-world, image-to-world, multi-image prompting, and video enhancement with camera control
- Composition mode combines multiple generated worlds into larger traversable spaces; expansion mode adds targeted detail to specific regions
- Outputs in multiple formats (Gaussian splats for fidelity, meshes for downstream tools) enabling integration into existing VFX and game pipelines

**Relevance to World Models**: Represents the 3D-space paradigm — lifting 2D inputs into persistent 3D structures rather than generating video (Cosmos) or predicting in latent space (JEPA). The Chisel tool's human-in-the-loop editing exemplifies "Spatial Intelligence": combining human structural knowledge with AI visual generation. Adopted by studios for VFX pre-visualization and by researchers for robot training data.

### PlaNet: Learning Latent Dynamics for Planning from Pixels [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/1811.04551)

**Authors/Presenters**: Danijar Hafner, Timothy Lillicrap, Ian Fischer, Ruben Villegas, David Ha, Honglak Lee

**Date**: 2019-06 (ICML 2019)

**Summary**: Introduces the Deep Planning Network (PlaNet), a purely model-based agent that learns environment dynamics from pixels and plans entirely in latent space. Proposes the Recurrent State-Space Model (RSSM) — a latent dynamics model combining deterministic and stochastic transitions — trained with a multi-step variational objective called latent overshooting.

**Key Findings**:

- Introduces the RSSM architecture: deterministic recurrent path for long-term memory combined with stochastic latent variables for multi-modal predictions — the foundation later refined by DreamerV1/V2/V3
- Latent overshooting objective enforces consistency of multi-step predictions in latent space, improving planning accuracy beyond single-step training
- Solves continuous control tasks from pixels (DeepMind Control Suite) with 50x fewer environment interactions than model-free methods (D4PG, A3C)
- Plans online using Cross-Entropy Method (CEM) in latent space — no policy network required, demonstrating that accurate dynamics models suffice for control

**Relevance to World Models**: The foundational latent dynamics model that originated the entire Dreamer lineage. PlaNet's RSSM architecture — deterministic + stochastic state transitions — became the standard template for model-based RL from pixels. DreamerV1 added learned behaviors (actor-critic in latent space), DreamerV2 introduced discrete latents, and DreamerV3 achieved domain generality, but all build on PlaNet's core insight: planning in learned latent spaces is more sample-efficient than model-free RL and more tractable than pixel-space prediction.

### Dreamer: Dream to Control — Learning Behaviors by Latent Imagination [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/1912.01603)

**Authors/Presenters**: Danijar Hafner, Timothy Lillicrap, Jimmy Ba, Mohammad Norouzi

**Date**: 2019-12 (ICLR 2020)

**Summary**: First model-based agent to learn behaviors entirely via latent imagination — trains an actor-critic within imagined trajectories generated by PlaNet's RSSM world model, replacing PlaNet's cross-entropy method (CEM) planning with learned policy and value functions. Backpropagates analytic value gradients through imagined rollouts, avoiding the high variance of policy-gradient estimators.

**Key Findings**:

- Replaces PlaNet's online CEM planning with an actor-critic trained on imagined latent trajectories — amortizes planning into a learned policy, enabling faster inference
- Analytic gradient propagation through learned dynamics yields lower-variance updates than model-free policy gradients or shooting-based planning
- Outperforms PlaNet, A3C, and D4PG on 20 continuous-control tasks in data efficiency, wall-clock time, and final performance
- Establishes the three-component Dreamer architecture (world model + actor + critic) that persists through DreamerV2 and DreamerV3

**Relevance to World Models**: The critical bridge between PlaNet (planning-only) and DreamerV3 (general-purpose agent). Demonstrates that learned world models are useful not just for planning but for training policies via imagination — a key insight enabling the Dreamer lineage (PlaNet → Dreamer → DreamerV2 → DreamerV3) to scale to increasingly complex domains.

### DreamerV2: Mastering Atari with Discrete World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2010.02193)

**Authors/Presenters**: Danijar Hafner, Timothy Lillicrap, Mohammad Norouzi, Jimmy Ba

**Date**: 2020-10 (ICLR 2021)

**Summary**: Replaces Dreamer's continuous latent representations with categorical variables (32 classes x 32 variables), achieving the first human-level Atari performance from a world model agent. Introduces KL balancing to stabilize latent dynamics training by separately weighting prior and posterior KL terms.

**Key Findings**:

- Discrete latent representations (categorical posteriors) outperform Gaussian latents on Atari — discrete variables better capture the multimodal, discontinuous dynamics of game environments
- KL balancing (weighting prior vs. posterior KL terms at 0.8/0.2) prevents posterior collapse while keeping the prior informative, stabilizing long-horizon imagination
- First world-model agent to reach human-level performance on the 55-game Atari benchmark (200M frames), surpassing IQN and Rainbow with equivalent compute
- Generalizes to continuous control (humanoid locomotion from pixels), demonstrating the architecture is not Atari-specific

**Relevance to World Models**: Solves the representation bottleneck in the Dreamer lineage — continuous Gaussians struggled with discrete, multimodal environments like Atari. The discrete latent + KL balancing innovations carry directly into DreamerV3, which further generalizes them with symlog predictions and free bits. Validates that world-model-based RL can compete with the best model-free methods on their home turf.

### DreamerV3: Mastering Diverse Domains through World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2301.04104)

**Authors/Presenters**: Danijar Hafner, Jurgis Pasukonis, Jimmy Ba, Timothy Lillicrap

**Date**: 2023-01 (JMLR 2024)

**Summary**: General-purpose MBRL agent using Recurrent State-Space Model (RSSM) to learn world models across diverse domains without task-specific tuning. Decomposes hidden state into deterministic (GRU) and stochastic (learned prior/posterior) components, enabling both long-term memory and uncertainty modeling. First algorithm to collect diamonds in Minecraft from scratch without human data.

**Key Findings**:

- Fixed hyperparameters across 150+ tasks spanning continuous/discrete actions, visual/low-dimensional inputs, 2D/3D environments, and dense/sparse rewards
- Symlog predictions normalize value functions across reward scales; free bits and KL balancing stabilize latent dynamics learning
- First successful diamond collection in Minecraft without human data or curriculum — a long-standing MBRL benchmark
- RSSM architecture decomposes state into deterministic (temporal memory) and stochastic (uncertainty) components, enabling multi-step imagination for policy optimization

**Relevance to World Models**: The foundational RSSM-based world model architecture and primary baseline for subsequent work (R2-Dreamer, NE-Dreamer, Optimistic DreamerV3). DreamerV3's decoder-reconstruction approach contrasts with JEPA's decoder-free prediction — R2-Dreamer and NE-Dreamer independently converge toward JEPA principles by eliminating the decoder, suggesting reconstruction is unnecessary for effective world modeling.

### TD-MPC2: Scalable, Robust World Models for Continuous Control [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2310.16828)

**Authors/Presenters**: Nicklas Hansen, Hao Su, Xiaolong Wang

**Date**: 2023-10 (ICLR 2024)

**Summary**: Model-based RL method that performs trajectory optimization in the latent space of a learned implicit (decoder-free) world model using temporal difference learning. Scales to 104 continuous control tasks across 4 domains with a single hyperparameter configuration, and trains a single 317M-parameter agent on 80 tasks spanning multiple embodiments and action spaces.

**Key Findings**:

- Decoder-free world model with TD-based value learning and latent-space planning — an alternative to DreamerV3's RSSM + actor-critic architecture that avoids pixel reconstruction entirely
- Single set of hyperparameters works across 104 tasks in DMControl, Meta-World, Maniskill2, and MyoSuite — comparable domain generality to DreamerV3's 150+ tasks
- Scaling analysis demonstrates that agent capabilities improve with model and data size, training a single 317M-parameter multi-task agent across 80 tasks with different embodiments
- Local trajectory optimization (MPC) in latent space rather than amortized policy learning — provides planning flexibility at inference time at the cost of per-step computation

**Relevance to World Models**: The primary alternative to DreamerV3 for model-based RL benchmarking. Where DreamerV3 uses RSSM dynamics with decoder reconstruction, TD-MPC2 uses implicit (decoder-free) world models with TD learning — arriving at decoder-free representations independently of JEPA. The scaling results (317M multi-task agent) parallel foundation model trends in world modeling. Referenced alongside DreamerV3 as baseline in R2-Dreamer and NE-Dreamer.

### Object-Centric Learning with Slot Attention [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2006.15055)

**Authors/Presenters**: Francesco Locatello, Dirk Weissenborn, Thomas Unterthiner, Aravindh Mahendran, Georg Heigold, Jakob Uszkoreit, Alexey Dosovitskiy, Thomas Kipf

**Date**: 2020-06 (NeurIPS 2020)

**Summary**: Introduces Slot Attention, an architectural module that decomposes perceptual input into a set of object-centric representations called slots. Slots compete via iterative attention to bind to different objects in a scene without explicit supervision, enabling unsupervised object discovery and compositional generalization to unseen object combinations.

**Key Findings**:

- Iterative competitive attention mechanism: slots are initialized randomly and refined over multiple rounds, each slot attending to different spatial regions — produces object-level decomposition without segmentation labels
- Exchangeable slot representations — slots have no fixed ordering, allowing the model to handle variable numbers of objects and generalize compositionally
- Interfaces with standard perceptual backbones (CNNs, later ViTs) as a modular component, enabling integration into larger architectures for downstream tasks
- Demonstrates unsupervised object discovery and supervised property prediction with generalization to novel object compositions

**Relevance to World Models**: Foundational building block for object-centric world models. SlotFormer extends slots to video prediction, Causal-JEPA applies object-level masking using slot-based decomposition, and AXIOM builds hierarchical world models with object-centric representations. The core insight — that scenes should be modeled as compositions of objects rather than monolithic feature vectors — is increasingly central to world models that require causal reasoning and compositional understanding.

### TesserAct: Learning 4D Embodied World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2504.20995)

**Authors/Presenters**: Haoyu Zhen, Qiao Sun, Hongxin Zhang, Junyan Li, Siyuan Zhou, Yilun Du, Chuang Gan

**Date**: 2025-04

**Summary**: Predicts the dynamic evolution of 3D scenes over time in response to agent actions by jointly generating RGB, depth, and surface normal (RGB-DN) video from a fine-tuned video generation model, then lifting outputs into coherent 4D scene representations. Augments existing robot manipulation datasets with geometric channels using off-the-shelf depth/normal estimators, avoiding the need for 3D ground truth.

**Key Findings**:

- RGB-DN joint prediction captures detailed shape, configuration, and temporal changes beyond what 2D video models provide — enables learning of accurate inverse dynamics models
- Converts generated multi-modal video directly into 4D scene representations supporting novel view synthesis for embodied environments
- Policy learning from 4D predictions significantly outperforms policies derived from prior video-based world models
- Practical pipeline: no 3D ground truth or physics engines required — standard robot videos augmented with off-the-shelf depth/normal models suffice

**Relevance to World Models**: Represents a third paradigm for embodied world models alongside latent-space (JEPA/Dreamer) and pixel-space (Cosmos/DreamZero) approaches: **4D scene-space** prediction. Trades the efficiency of latent prediction for explicit geometric structure — more expensive per inference, but enables spatial reasoning (novel views, 3D understanding) that flat video or latent models cannot provide. Occupies similar ground to Marble (World Labs) but for robotics manipulation rather than creative content. The depth + normal augmentation strategy demonstrates that 3D-aware world models can be bootstrapped from standard 2D video datasets.

### AXIOM: Active Inference for Object-Centric World Models [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.verses.ai/research-blog/axiom-mastering-arcade-games-in-minutes-with-active-inference-and-structure-learning)

**Authors/Presenters**: [Verses AI](ecosystem.md#verses-ai)

**Date**: 2025-06

**Summary**: Active Inference architecture that unifies perception, planning, and control through the Free Energy Principle. Creates object-centric world models with hierarchical agent structure — every joint/component is an agent with its own local world model. Learns game dynamics in minutes rather than hours by combining structure learning with active epistemic exploration (seeking observations that reduce uncertainty).

**Key Findings**:

- Reported to outperform [Google DeepMind](ecosystem.md#google-deepmind) on Atari "Gameworld 10k" challenge, mastering games in minutes vs. hours for standard RL
- Object-centric representations enable compositional reasoning — understands game objects and their relationships rather than raw pixel patterns
- Hierarchical "Shared Intelligence" allows recovery from unexpected perturbations without retraining, via local prediction error resolution
- Epistemic foraging drives exploration: agents seek states that maximize information gain, not just reward

**Relevance to World Models**: Represents a fundamentally different paradigm from both JEPA (energy-based SSL) and Dreamer (RSSM-based RL). Active Inference treats perception and action as two sides of the same coin — both minimize free energy. The object-centric structure parallels Causal-JEPA but from Bayesian rather than SSL foundations. If validated at real-world scale, could complement JEPA for representation learning and Cosmos for synthetic data as a third paradigm for embodied AI.

### Agent World Model: Infinity Synthetic Environments for Agentic Reinforcement Learning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.10090)

**Authors/Presenters**: Zhaoyang Wang, Canwen Xu, Boyi Liu, Yite Wang, Siwei Han, Zhewei Yao, Huaxiu Yao, Yuxiong He

**Date**: 2026-02

**Summary**: Introduces Agent World Model (AWM), a fully synthetic environment generation pipeline for training LLM-based autonomous agents. Scales to 1,000 code-driven, database-backed environments spanning everyday scenarios, with 35 tools per environment on average. Environments provide more reliable state transitions than LLM-simulated alternatives.

**Key Findings**:

- Code-driven environments with database backends provide consistent state transitions, unlike LLM-simulated environments
- Training exclusively in synthetic environments yields strong out-of-distribution generalization — no benchmark-specific tuning needed
- Accessible database states enable reliable reward function design for RL training
- Demonstrates world models as environment generators for agentic AI, not just state predictors
- Code available at Snowflake-Labs/agent-world-model

**Relevance to World Models**: Extends world models beyond physical simulation into digital agent environments. The key insight -- that world models are more valuable for training data synthesis than inference-time search -- aligns with the L1-L2 data amplification role. Contrasts with physical world models (JEPA, Cosmos) by operating in discrete, tool-based action spaces rather than continuous control.

### Latent Geometry Beyond Search: Amortizing Planning in World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2605.08732)

**Authors/Presenters**: Hoang Nguyen, Xiaohao Xu, Xiaonan Huang

**Date**: 2026-05

**Summary**: Demonstrates that well-structured latent spaces in JEPA-style world models encode sufficient local structure to replace iterative online planning with a lightweight learned mapping. Proposes Goal-Conditioned Inverse Dynamics Model (GC-IDM) that maps (current latent, goal latent, horizon) directly to the next action, achieving 100-130x cost reduction per decision vs. CEM-based planning.

**Key Findings**:

- Built on pretrained LeWorldModel with latent geometry regularized for smoothness and uniformity
- GC-IDM matches or exceeds CEM in 7 of 8 environment-protocol settings across navigation, manipulation, and continuous control
- 100-130x cheaper per decision than iterative planning (CEM, MPPI, iCEM, gradient-based)
- Core insight: "much of the structure recovered by test-time planning is already locally encoded in the latent representation"

**Relevance to World Models**: Directly addresses the "planning tax" identified in JEPA-based world models -- the dominant computational cost has shifted from dynamics prediction to search over action sequences. If latent geometry is sufficiently structured (as in LeWorldModel), planning can be amortized into a single forward pass. This challenges the assumption that online search is necessary for world-model-based control and offers a path to real-time JEPA planning without MPC overhead.

### GENE-26.5: Advancing Robotic Manipulation to Human Level [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.genesis.ai/blog/gene-26-5-advancing-robotic-manipulation-to-human-level)

**Authors/Presenters**: [Genesis AI](ecosystem.md#genesis-ai)

**Date**: 2026-05

**Type**: Blog Post

**Summary**: Introduces GENE-26.5, a full-stack robotics foundation model for human-level dexterous manipulation. Uses flow matching (not autoregressive, not JEPA) across language, vision, proprioception, tactile sensing, and action modalities. Demonstrates 20-step cooking, in-air Rubik's Cube solving, lab automation, and wire harnessing with <1 hour of task-specific data per new skill. Custom middleware reduces tracking error from 20mm to 2mm and joint delay from 80ms to 9ms.

**Key Findings**:

- Flow-matching architecture across 5 modalities (language, vision, proprioception, tactile, action) — a distinct approach from VLAs (autoregressive) and WAMs (video diffusion)
- Sensor-equipped data glove with 1:1:1 mapping (human hand → glove → robot hand) at 100x lower cost and 5x more usable data than alternatives
- Full-stack integration: model + hardware + simulation (Genesis World) + data engine. Comparable vertical integration strategy to NVIDIA but for dexterous manipulation
- No independent benchmarks or paper published — demos are impressive but unverified

**Relevance to World Models**: GENE-26.5 represents a third architectural paradigm for robotics (flow matching) alongside VLAs (π0, GR00T) and WAMs (DreamZero). Its tight coupling with Genesis World simulation creates a sim-to-real pipeline similar to NVIDIA's but with a cross-platform compiler (Quadrants) targeting AMD ROCm and Apple Metal in addition to CUDA — a concrete example of hardware-neutral simulation. The full-stack approach (model + hardware + simulation + data) raises the same vertical integration questions as NVIDIA's stack.

---

## Applications & Use Cases

*Papers demonstrating practical applications in robotics, autonomous systems, etc.*

### GAIA-1: A Generative World Model for Autonomous Driving [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2309.17080)

**Authors/Presenters**: Anthony Hu, Lloyd Russell, Hudson Yeo, Zak Murez, George Fedoseev, Alex Mayol Kendall, Jamie Sherrah, [Wayve](ecosystem.md#wayve)

**Date**: 2023-09

**Summary**: 9B-parameter generative world model for autonomous driving that treats world modeling as autoregressive sequence prediction. Encodes video, text, and action into discrete tokens, then predicts next tokens to generate realistic driving scenarios. Trained on 4,700 hours of UK urban driving data. Successor GAIA-3 (Dec 2025) scales to 15B parameters, purpose-built for evaluation of end-to-end driving systems.

**Key Findings**:

- Unified tokenization of video, text, and action enables a single autoregressive transformer to learn 3D geometry, scene dynamics, and language-conditioned generation
- Learns disentangled representations: separate control over ego-vehicle actions, scene layout, and weather/lighting without explicit supervision
- Wayve raised $1.05B (Series C, 2024) scaling to $1.5B total; deploying end-to-end driving with Uber and Nissan partnerships
- GAIA-3 (2025-12) extends to 15B parameters, shifting focus from generation quality to serving as a reliable evaluation environment for driving policies

**Relevance to World Models**: Demonstrates that autoregressive next-token prediction — the same paradigm behind LLMs — can learn a world model of driving dynamics from raw sensor data. Contrasts with JEPA's latent-space approach: GAIA operates in discrete token space, making it directly inspectable but potentially less efficient for planning. The GAIA-1 to GAIA-3 progression mirrors the broader trend from world model as generator to world model as simulator/evaluator.

### NVIDIA Isaac GR00T N1: Open Foundation Model for Humanoid Robots [<img src="templates/icons/website.svg" alt="website" height="16">](https://nvidianews.nvidia.com/news/nvidia-isaac-gr00t-n1-open-humanoid-robot-foundation-model-simulation-frameworks)

**Authors/Presenters**: [NVIDIA](ecosystem.md#nvidia)

**Date**: 2025-03

**Summary**: Open Vision-Language-Action (VLA) foundation model for generalist humanoid robot manipulation. Dual-system architecture combining a fast reactive action model (System 1) with a slow deliberative planning model (System 2). Trained on teleoperation data augmented with synthetic data from Isaac Lab and MimicGen, yielding a 40% performance boost from synthetic data alone.

**Key Findings**:

- Dual-system architecture: System 1 generates low-latency motor actions from visual input; System 2 handles task planning, re-planning, and language grounding
- 40% task success improvement from synthetic data augmentation, demonstrating the sim-to-real transfer value of NVIDIA's simulation stack (Isaac Lab, Omniverse)
- Adopted by 1X, Agility Robotics, Figure AI, Boston Dynamics, Unitree, Sanctuary AI as baseline foundation model for humanoid development
- Open-source release (N1.6) enables community fine-tuning for custom manipulation tasks

**Relevance to World Models**: While not a world model itself, GR00T N1 represents the downstream consumer of world models in robotics — a VLA policy that benefits from synthetic data generated by world simulators (Cosmos, Isaac Sim). The dual-system architecture parallels the MLLM-WM fusion proposed in embodied AI surveys: System 2 provides semantic reasoning while System 1 handles reactive control.

### Gemini Robotics: Bringing AI into the Physical World [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2503.20020)

**Authors/Presenters**: [Google DeepMind](ecosystem.md#google-deepmind)

**Date**: 2025-03 (Gemini Robotics 1.5), updated through 2026-04 (Gemini Robotics-ER 1.6)

**Summary**: Two-part brain architecture for robotics: Gemini Robotics VLA (vision-language-action model mapping visual inputs to motor commands) and Gemini Robotics-ER (embodied reasoning model for spatial understanding and planning). Uses cloud-hosted backbone with on-device decoder to achieve ~250ms end-to-end latency at 50Hz effective control via action chunking. Trained on thousands of hours of teleoperated demonstrations on ALOHA 2 robots.

**Key Findings**:

- Two-component architecture: distilled Gemini Robotics-ER backbone (<160ms) + local action decoder (~250ms end-to-end)
- Effective 50Hz control through action chunking despite cloud latency
- Gemini Robotics On-Device (July 2025): fully local VLA for bi-arm robots, adapts to new tasks with 50-100 demonstrations
- Gemini Robotics-ER 1.6 (April 2026): enhanced spatial reasoning, instrument reading (developed with Boston Dynamics), flexible thinking budget for latency/accuracy tradeoffs
- Outperforms π0 re-implementation on deformable object manipulation and long-horizon tasks; 2x better generalization on tasks where baselines catastrophically fail
- Cross-embodiment: single model adapts to ALOHA, Bi-arm Franka, and Apptronik Apollo humanoid

**Relevance to World Models**: Gemini Robotics-ER provides embodied reasoning (spatial understanding, planning) but does not predict future states — it's a reasoning model, not a world model. The VLA component maps observations to actions without explicit state prediction. However, the two-part architecture (reasoner + actor) parallels the MLLM-WM integration pattern: ER provides semantic/spatial reasoning while VLA handles reactive control. Competitor to NVIDIA GR00T, with similar dual-system design but cloud-first rather than edge-first deployment.

### Oracle-Efficient Safety Verification for Model-Based Robotic Planning via ADMM [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.techrxiv.org/users/1007321/articles/1389422)

**Authors/Presenters**: Khazretgali Sapenov, Aidos Sapenov

**Date**: 2026-02

**Summary**: Planning framework combining learned world models (JEPA) with deterministic simulator verification for safety-constrained trajectory optimization. Uses ADMM to decompose planning into a fast latent-space optimization step and an oracle verification step, minimizing expensive simulator calls.

**Key Findings**:

- ADMM-Oracle requires 1 verification call per planning step — 125x reduction vs. sampling-based verification (CEM) and 240x vs. full simulator planning (MPPI)
- Under tight safety constraints (δ=0.20), oracle-verified planning reduces violations to 11.1% vs. 16.7–18.9% for unverified alternatives
- Demonstrates practical approach to bridging the gap between fast-but-approximate learned world models and slow-but-accurate simulators

**Relevance to World Models**: Directly addresses a critical deployment barrier: learned world models (including JEPA) are fast but can produce unsafe plans. By combining JEPA planning with simulator verification via ADMM, this work provides a practical safety layer that makes world model-based robotic planning viable in safety-critical settings.

### Progressive Robustness-Aware World Models in Autonomous Driving: A Review and Outlook [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.techrxiv.org/users/1003906/articles/1364209)

**Authors/Presenters**: Feiyang Jia, Caiyan Jia, Ziying Song, Zhicheng Bao, Lin Liu, Shaoqing Xu, Yan Gong, Lei Yang, Xinyu Zhang, Bin Sun, Xiaoshuai Hao, Long Chen, Yadan Luo

**Date**: 2025-12

**Summary**: Survey of Driving World Models (DWMs) through the lens of robustness, introducing a three-stage progressive framework. Categorizes existing techniques by paradigms, architectures, and downstream applications, then analyzes robustness from self-metrics (1.0) through AD system contribution (2.0) to open-world challenges (3.0).

**Key Findings**:

- Progressive robustness taxonomy: 1.0 (model self-metrics), 2.0 (contribution to AD pipeline), 3.0 (open-world generalization and human-aligned controllable generation)
- Identifies key challenge: DWMs must generate controllable futures that align with human expectations, adapt to arbitrary downstream tasks, and possess knowledge transfer capabilities
- Comprehensive review spanning video generation, latent space, and occupancy-based world model approaches for autonomous driving

**Relevance to World Models**: Provides the first robustness-centered evaluation framework for driving world models. The three-stage progression mirrors the maturity of the field — from measuring model quality in isolation to assessing real-world deployment readiness. Useful for benchmarking both JEPA-based and video-based (Cosmos, Genie) approaches against robustness criteria.

### NVIDIA Cosmos: Major Platform Release (GTC 2026) [<img src="templates/icons/website.svg" alt="website" height="16">](https://nvidianews.nvidia.com/news/nvidia-announces-major-release-of-cosmos-world-foundation-models-and-physical-ai-data-tools)

**Authors/Presenters**: [NVIDIA](ecosystem.md#nvidia)

**Date**: 2026-03

**Summary**: Major platform release at GTC 2026 expanding the Cosmos ecosystem with new models and tools. Introduces Cosmos Transfer WFM for controllable synthetic data from structured inputs (segmentation, depth, LiDAR, pose), updated Cosmos Predict with multi-frame generation and trajectory prediction, and Cosmos Reason for spatiotemporal-aware chain-of-thought reasoning. All models open and customizable.

**Key Findings**:

- Industry adoption: Agility Robotics, Figure AI, Skild AI, 1X using Cosmos for humanoid robot training data; Uber, Waabi for autonomous vehicles
- Real-time world generation via Grace Blackwell NVL72 systems; post-training via PyTorch or NeMo on DGX Cloud
- Integration with Google DeepMind's SynthID watermarking; available on HuggingFace, GitHub, Google Cloud Vertex AI
- New blueprints for Physical AI Data Factory combining Omniverse and Cosmos for scalable synthetic data generation

**Relevance to World Models**: Marks the transition of video-based world models from research to industrial deployment platform. The breadth of industry adoption (humanoid robots, AVs, surgical robots) validates the WFM approach for generating training data at scale. Complements JEPA-based approaches: Cosmos excels at generating inspectable video data while JEPA excels at efficient latent planning.

### NVIDIA National Robotics Week 2026: Cosmos 3 and GR00T N1.7 [<img src="templates/icons/website.svg" alt="website" height="16">](https://blogs.nvidia.com/blog/national-robotics-week-2026/)

**Authors/Presenters**: [NVIDIA](ecosystem.md#nvidia)

**Date**: 2026-04

**Summary**: Major announcements at National Robotics Week 2026 introducing Cosmos 3, Isaac GR00T N1.7, and the Physical AI Data Factory Blueprint. Newton 1.0 physics engine reaches general availability. New simulation tools include Isaac Sim 6.0, Isaac Lab 3.0, OceanSim for underwater robots, and NemoClaw for natural-language robot control.

**Key Findings**:

- GR00T N1.7 Early Access: 3B-parameter VLA built on Cosmos-Reason2-2B backbone with 32-layer DiT for low-level motor control
- Physical AI Data Factory Blueprint transforms compute into high-quality training data; combines Cosmos WFMs with OSMO operator for unified data curation, augmentation, and evaluation
- Newton 1.0 physics engine now GA — provides foundation for dexterous robot manipulation
- Industry adoption: FieldAI, Skild AI using Cosmos for robot brains; Aigen for agriculture (millions of scenarios); surgical robotics for OR automation
- 10x improved sample efficiency and 2x faster convergence on manipulation tasks using video-action models

**Relevance to World Models**: Confirms NVIDIA's vertical integration strategy: foundation models (Cosmos 3) → simulation (Isaac, Newton) → deployment (GR00T). The Physical AI Data Factory Blueprint formalizes the synthetic data generation pipeline that world models enable, positioning compute as the bottleneck rather than real-world data collection.

### Cosmos 3: Omnimodal World Models for Physical AI [<img src="templates/icons/filetype-pdf.svg" alt="pdf" height="16">](https://research.nvidia.com/labs/cosmos-lab/cosmos3/technical-report.pdf)

**Authors/Presenters**: [NVIDIA](ecosystem.md#nvidia) Cosmos Lab (138 pages, 100+ contributors)

**Date**: 2026-06

**Summary**: Introduces Cosmos 3, a family of omnimodal world models that unify vision-language understanding, video/audio generation, and action prediction within a single Mixture-of-Transformers (MoT) architecture. Subsumes previously separate model classes (VLMs, video generators, world simulators, VLAs) into one framework operating across language, image, video, audio, and action modalities. Three scales: Edge (4B), Nano (16B), Super (64B).

**Key Findings**:

- Dual-tower MoT architecture: autoregressive "reasoner" tower (causal self-attention for language/vision understanding) paired with diffusion-based "generator" tower (bidirectional attention for video/audio/action denoising), sharing parameters through dual-stream joint attention where DM tokens attend to AR context but not vice versa
- Unified action representation maps heterogeneous embodiments (single-arm robots, dual-arm, humanoids, autonomous vehicles) into compact geometric vectors (3D translation + 6D rotation + grasp state), enabling cross-embodiment transfer
- Three action generation modes — forward dynamics (predict future video from actions), inverse dynamics (infer actions from video), and joint video-action policy — all as different masking configurations of the same model
- SOTA across open models: #1 on Artificial Analysis T2I and I2V leaderboards, PAI-Bench, R-Bench, Physics-IQ, RoboLab, and RoboArena; competitive with Gemini 3.1 Pro on general VLM benchmarks while outperforming on robotics/driving/smart-infrastructure domains
- Open release under OpenMDW-1.1 license: code, model weights, five curated synthetic datasets (PhyxSim, RobotSim, DriveSim, SynHuman, Warehouse), and Cosmos-HUE evaluation benchmark

**Relevance to World Models**: Represents the most ambitious unification of world model capabilities to date — collapsing the VLM → video generator → VLA pipeline into a single model. The MoT architecture is a direct answer to the modality-mismatch problem: language works well with autoregressive decoding, but images/video/audio benefit from denoising, so the dual-tower design keeps both mechanisms without forcing a single generation paradigm. Architecturally distinct from JEPA (which operates in latent space without generation) and from prior Cosmos versions (which used separate models). The cross-embodiment action representation and three action modes position Cosmos 3 as a general-purpose backbone for Physical AI agents.

### Develop Physical AI Reasoning, World, and Action Models with NVIDIA Cosmos 3 [<img src="templates/icons/website.svg" alt="website" height="16">](https://developer.nvidia.com/blog/develop-physical-ai-reasoning-world-and-action-models-with-nvidia-cosmos-3/)

**Authors/Presenters**: Asawaree Bhide, Alexander Schwarz ([NVIDIA](ecosystem.md#nvidia))

**Date**: 2026-05

**Summary**: Developer-focused blog post detailing practical workflows for using Cosmos 3 in Physical AI applications. Covers post-training recipes for action-aware models, inference optimization (NVFP4 quantization for 2x speedup, vLLM-Omni serving, Efficient Video Sampling), and NIM microservice deployment. Accompanies six open synthetic datasets on HuggingFace.

**Key Findings**:

- Post-training workflow: SFT adapts Cosmos 3 to custom video datasets; action post-training enables three modes — forward dynamics (predict future from actions), inverse dynamics (infer actions from video), and policy (predict actions from observations + task prompt)
- Inference stack: vLLM-Omni for generator serving with continuous batching and tensor parallelism; NVFP4 (4-bit) quantization achieves 2x speedup; Efficient Video Sampling prunes redundant video token chunks
- Six curated synthetic datasets released: RobotSim, PhyxSim, Spatial Reasoning, SynHuman, DriveSim, Warehouse Operations — all on HuggingFace for post-training
- Cosmos-HUE evaluation benchmark decomposes generated videos into atomic binary verification questions across semantic alignment, physical laws, geometric reasoning, and visual integrity

**Relevance to World Models**: Provides the practical complement to the Cosmos 3 technical report — the "how to use it" rather than the "how it works." The action post-training recipes are particularly significant: they show how a single pre-trained world model can be specialized for forward simulation (synthetic data), inverse dynamics (learning from demonstrations), or direct policy learning, without architectural changes. The NVFP4 quantization enabling Nano on workstation GPUs (RTX PRO 6000) is notable for making world model inference accessible outside datacenters.

### Physical Intelligence π0.7: Compositional Generalization in Robot Policies [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.pi.website/blog)

**Authors/Presenters**: [Physical Intelligence](ecosystem.md#physical-intelligence-pi)

**Date**: 2026-04

**Summary**: New VLA model demonstrating compositional generalization — combining skills learned in different contexts to solve novel problems the model was never explicitly trained on. Most striking demonstration: successful operation of an air fryer with only 2 relevant training episodes in the entire dataset, suggesting emergent combination of web pretraining with limited robot data.

**Key Findings**:

- Core claim: compositional generalization breaks the rote-memorization pattern of traditional robot training; skills transfer and recombine for unseen tasks
- Air fryer demo: near-zero direct training examples, yet model succeeds when coached through task in natural language — emergent synthesis of web knowledge + robot experience
- Matches specialist models on complex manipulation tasks (coffee-making, laundry folding, box assembly) while generalizing beyond training distribution
- Researcher observation (Ashwin Balakrishna): "The last few months have been the first time where I'm genuinely surprised" — capabilities exceeding what training data would predict

**Relevance to World Models**: Demonstrates that VLA foundation models may be approaching a capability threshold where they generalize compositionally rather than memorizing demonstrations. This changes the value proposition: if policies can remix skills, world models become more valuable for generating diverse scenarios that exercise novel combinations rather than exhaustive coverage of specific tasks.

### MolmoSpaces: A Large-Scale Open Ecosystem for Robot Navigation and Manipulation [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2602.11337)

**Authors/Presenters**: Yejin Kim, Wilbert Pumacay, Omar Rayyan, Max Argus, Winson Han, Eli VanderBilt, Jordi Salvador, et al. (Allen Institute for AI)

**Date**: 2026-02

**Summary**: Fully open ecosystem for large-scale benchmarking of robot policies, combining 230k+ diverse indoor environments, 130k annotated object assets (48k manipulable with 42M precomputed stable grasps), and an 8-task benchmark suite spanning static/mobile manipulation, navigation, and multi-room long-horizon tasks. Simulator-agnostic design supports MuJoCo, Isaac Sim, and ManiSkill.

**Key Findings**:

- Strong sim-to-real correlation (R = 0.96, ρ = 0.98), validating that simulation performance transfers meaningfully to real-world outcomes
- Benchmark identifies key policy sensitivities to prompt phrasing, initial joint positions, and camera occlusion — practical failure modes often missed by smaller benchmarks
- Environments span handcrafted (iTHOR), procedurally generated (ProcTHOR), and LLM-generated (Holodeck) scenes, covering the long tail of everyday spatial configurations
- Supports Franka FR3 and Rainbow Robotics RB-Y1 robots; includes iPhone-based teleoperation via TeleDex app

**Relevance to World Models**: Provides the evaluation infrastructure world models need to prove real-world utility. The 230k-environment scale and sim-to-real correlation make it a credible benchmark for comparing world model approaches (JEPA vs. diffusion vs. WAM) on downstream robot task success rather than proxy video metrics. Already used as a primary benchmark by NVIDIA GR00T N2.

### RoboWM-Bench, MotionScape, and EgoVerse: New Robotics World Model Benchmarks [<img src="templates/icons/website.svg" alt="website" height="16">](https://github.com/leofan90/Awesome-World-Models)

**Authors/Presenters**: Various (tracked in Awesome-World-Models)

**Date**: 2026-04

**Summary**: Three new benchmarks released in April 2026 for evaluating world models in robotics contexts: RoboWM-Bench (robotic manipulation), MotionScape (dynamic UAV video), and EgoVerse (egocentric human data for robot learning).

**Key Findings**:

- RoboWM-Bench: First standardized benchmark for evaluating world models specifically on robotic manipulation tasks — addresses gap noted in multiple surveys
- MotionScape: Large-scale real-world UAV video dataset with highly dynamic scenes; stress-tests temporal consistency of world models
- EgoVerse: Egocentric human dataset from diverse global contexts; supports cross-embodiment transfer research (human → robot)
- MultiWorld (also April 2026): Scalable multi-agent multi-view video world models for complex environments

**Relevance to World Models**: Addresses a critical gap: standardized benchmarks for measuring world model quality in robotics contexts. Previously, world model quality was evaluated on proxy tasks (video prediction metrics) rather than downstream policy performance. These benchmarks enable direct comparison of architectures (JEPA vs. diffusion vs. autoregressive) on what matters: robot task success.

### Do World Action Models Generalize Better than VLAs? A Robustness Study [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.22078)

**Authors/Presenters**: Zhanguang Zhang, Zhiyuan Li, Behnam Rahmati, et al. (Huawei Technologies, University of Toronto)

**Date**: 2026-03

**Summary**: First systematic robustness comparison between World Action Models (WAMs) and Vision-Language-Action models (VLAs). Evaluates on LIBERO-Plus and RoboTwin 2.0-Plus under visual perturbations (noise, lighting, layout, camera viewpoint, robot initial state). Finds WAMs excel at visual robustness but suffer critical inference latency trade-offs.

**Key Findings**:

- WAMs outperform VLAs on visual perturbations: LingBot-VA achieves 74.2% on RoboTwin 2.0-Plus bimanual tasks vs. π₀.₅ at 58.6%; robustness attributed to spatiotemporal priors from world model backbones
- Critical trade-off: LingBot-VA inference at 5.2s/step is 83× slower than π₀.₅ (63ms) — even optimized WAMs like GE-Act are 4.8× slower
- VLAs competitive when trained on diverse data: π₀.₅ reaches 85.7% on LIBERO-Plus vs. Cosmos-Policy at 82.2%
- Hybrid approaches (MOTUS, VLA-JEPA) provide intermediate solutions — integration method matters as much as presence of spatiotemporal learning

**Relevance to World Models**: Quantifies the robustness-latency trade-off between world model-based and pure VLA approaches. Key insight: WAMs' robustness advantage comes from spatiotemporal priors, but inference cost is currently prohibitive for real-time applications. Suggests hybrid architectures (VLA-JEPA, MOTUS) may offer the best balance — supporting the case for JEPA-style efficient world models over computationally expensive video generation.

### The Waymo World Model: A New Frontier for Autonomous Driving Simulation [<img src="templates/icons/website.svg" alt="website" height="16">](https://waymo.com/blog/2026/02/the-waymo-world-model-a-new-frontier-for-autonomous-driving-simulation/)

**Authors/Presenters**: Waymo

**Date**: 2026-02

**Summary**: Frontier generative model for large-scale, hyper-realistic autonomous driving simulation built on DeepMind's Genie 3. Generates multi-sensor outputs (camera + LiDAR) for simulating rare long-tail scenarios across multiple modalities. Supports three control mechanisms: driving action control for counterfactual "what-if" scenarios, scene layout control for traffic/road configuration, and language control for weather/time-of-day.

**Key Findings**:

- Transfers vast world knowledge from 2D video pre-training into 3D LiDAR outputs specific to Waymo's sensor suite — bridging general vision understanding with domain-specific sensing
- Generates exceedingly rare events (tornados, animal encounters) that are nearly impossible to capture at scale in reality, addressing the long-tail data problem
- Waymo Driver has completed ~200 million fully autonomous miles while training on billions of virtual miles through simulation
- Three complementary control axes (actions, scene layout, language) enable systematic safety testing and scenario generation

**Relevance to World Models**: Demonstrates the first production deployment of a video-based world model (Genie 3) for safety-critical autonomous driving simulation. The multi-sensor generation (camera + LiDAR) and controllable scenario generation represent a concrete industrial use case where world models directly improve safety outcomes through comprehensive testing of edge cases.

### Nexar BADAS 2.0: Collision Prediction via V-JEPA2 World Model [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.linkedin.com/posts/yann-lecun_badas-20-new-collision-prediction-system-ugcPost-7450523580318216192-X3IC/)

**Authors/Presenters**: Zach Greenberger (Nexar), shared by [Yann LeCun](ecosystem.md#yann-lecun)

**Date**: 2025-12

**Summary**: Production collision prediction system built on V-JEPA2 world model architecture, trained on Nexar's fleet data capturing 100+ million miles monthly. Claims to outperform NVIDIA Cosmos and Google Gemini on collision prediction by using latent-space prediction rather than pixel-based approaches.

**Key Findings**:

- V-JEPA2 architecture enables detection, explanation, and generalization for collision scenarios — latent space prediction filters noise better than pixel-based methods for safety-critical decisions
- Trained exclusively on authentic road footage focusing on long-tail edge cases and rare events, not synthetic data
- Demo available at badas.nexar.app for public testing
- Validates that JEPA-style world models can be deployed in production safety systems

**Relevance to World Models**: First public deployment of V-JEPA2 in a production safety-critical application. Confirms the theoretical advantage of latent-space prediction (JEPA) over pixel-space generation (Cosmos, Gemini) for real-time decision systems where filtering irrelevant detail matters more than visual fidelity. The "explanation" capability suggests interpretable intermediate representations — a key requirement for safety certification.

### Counterfactual World Models via Digital Twin-conditioned Video Diffusion [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2511.17481)

**Authors/Presenters**: Zifan Shen, Alena Maksutova, Dan Zhang, Tobias Weyand

**Date**: 2025-11

**Summary**: Turns standard video diffusion models into Counterfactual World Simulation Models (CWSMs) by constructing digital twins of observed scenes and reasoning over object relationships via an LLM. Enables "what-if" queries — simulating alternative realities where specific variables are changed (e.g., removing an object, changing timing) — for accident reconstruction and causal analysis.

**Key Findings**:

- Pipeline: (1) reconstruct 3D digital twin from video, (2) use LLM to reason about object relationships and define counterfactual modifications, (3) apply modifications to digital twin, (4) render counterfactual video via conditioned diffusion
- Demonstrates causal reasoning beyond statistical correlation — can simulate whether an accident would have been avoided under different conditions
- Applicable to legal/forensic analysis, safety engineering, and training data augmentation for autonomous systems

**Relevance to World Models**: Represents the highest level of causal understanding in world models — counterfactual reasoning ("what would have happened if X?"). Bridges video generation (diffusion), 3D reconstruction (digital twin), and causal reasoning (LLM) into a unified pipeline. Directly relevant to legal and safety use cases where understanding causation, not just correlation, is essential.

### Ctrl-World: A Controllable Generative World Model for Robot Manipulation [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2510.10125)

**Authors/Presenters**: Yanjiang Guo, Lucy Xiaoyang Shi, Jianyu Chen, [Chelsea Finn](ecosystem.md#chelsea-finn)

**Date**: 2026-03

**Summary**: Controllable multi-view world model for evaluating and improving generalist robot manipulation policies without real-world rollouts. Trained on DROID dataset (95K trajectories, 564 scenes), generates spatially and temporally consistent trajectories for over 20 seconds under novel scenarios. Uses pose-conditioned memory retrieval and frame-level action conditioning.

**Key Findings**:

- First world model combining multi-view prediction, fine-grained action control, and consistent long-horizon interactions (20+ seconds)
- Can accurately rank policy performance without real-world robot rollouts — world model as evaluator
- Synthesizing successful imagined trajectories for supervised fine-tuning improves policy success by 44.7%
- Demonstrates world models as practical tools for both policy evaluation and improvement at scale

**Relevance to World Models**: From [Chelsea Finn](ecosystem.md#chelsea-finn)'s IRIS lab at Stanford. Demonstrates a concrete, high-impact use of world models for robotics: replacing costly real-world testing with imagination-space rollouts. The 44.7% policy improvement from synthetic data validates the data amplification role emphasized in our primer. Pixel-space approach trades off against JEPA's speed but offers inspectability.

### From Digital Twins to World Models: Opportunities, Challenges, and Applications for Mobile Edge General Intelligence [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.17420)

**Authors/Presenters**: Jie Zheng, Dusit Niyato, Changyuan Zhao, Jiawen Kang, Jiacheng Wang

**Date**: 2026-03

**Summary**: Charts the evolution from digital twins to world models for 6G-era edge intelligence. Maps classical digital twin applications in integrated sensing and communication, semantic communication, air-to-ground networks, and industrial edge to their world-model-based counterparts. Identifies key challenges including hybrid physics-data world models, federated world modeling at the edge, and explainable world models for safety-critical systems.

**Key Findings**:

- Paradigm shift from "physics-based, centralized, system-centric replicas" (digital twins) to "data-driven, decentralized, agent-centric internal models" (world models)
- Digital twins mirror and monitor; world models internalize dynamics for autonomous reasoning and planning
- World models enable more adaptive, resource-efficient intelligence at the network edge
- Key open challenges: federated world modeling, multi-agent and multi-scale modeling, explainability for safety-critical edge systems
- Applications span ISAC, semantic communication, air-ground networks, low-altitude wireless

**Relevance to World Models**: Bridges the digital twin and world model communities, which have evolved largely independently. Directly relevant to telecommunications use cases — world models for wireless channel modeling, network optimization, and edge computing. The "digital twin to world model" framing is useful for positioning world models in industrial contexts where digital twins are already established.

### Digital Twin AI: Opportunities and Challenges from Large Language Models to World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2601.01321)

**Authors/Presenters**: Rong Zhou, Dongping Chen, Zihan Jia, Yao Su, Yixin Liu et al. (27 authors)

**Date**: 2026-01

**Summary**: Presents a unified four-stage framework for AI-integrated digital twins spanning the full lifecycle: modeling (constructing representations), mirroring (real-time synchronization), intervening (predictive optimization), and autonomous management (self-governing operation via LLMs and foundation models). Cross-domain review covers eleven application areas including healthcare, manufacturing, robotics, and smart cities.

**Key Findings**:

- Four-stage digital twin AI lifecycle: Modeling → Mirroring → Intervention → Autonomous Management
- Traces evolution from traditional numerical solvers to physics-informed and foundation models
- Generative AI (LLMs, world models) transforms digital twins into "proactive and self-improving cognitive systems"
- Cross-domain analysis across eleven verticals identifies shared challenges: scalability, explainability, trustworthiness
- World models enable the transition from reactive monitoring (mirroring) to proactive planning (intervention/autonomy)

**Relevance to World Models**: Complements the "Digital Twins to World Models" paper (2603.17420) with a broader, lifecycle-oriented perspective. The four-stage framework maps cleanly to world model capability levels: L1 (modeling) → L2 (mirroring/prediction) → L3 (intervention/planning) → L4 (autonomous management). Useful for framing world models in enterprise/industrial contexts.

### Meta Acquires Assured Robot Intelligence (ARI) [<img src="templates/icons/website.svg" alt="website" height="16">](https://thetechportal.com/2026/05/01/meta-acquires-assured-robot-intelligence-to-strengthen-robotics-and-physical-ai-capabilities-report/)

**Authors/Presenters**: The Tech Portal

**Date**: 2026-05

**Summary**: Meta acquired Assured Robot Intelligence (ARI), a robotics startup specializing in learning-based control systems that help robots adapt in real-world settings. Co-founders Lerrel Pinto and Xiaolong Wang join Meta Superintelligence Labs and Meta Robotics Studio.

**Key Findings**:

- ARI focuses on motion planning, real-time decision-making, and whole-body coordination — critical for humanoid robots
- Strengthens Meta's physical AI capabilities despite LeCun's departure to AMI Labs
- Strategic move as humanoid robotics market projected to grow from $2-3B (mid-2020s) to ~$250B by 2035
- Team integrates into Meta Robotics Studio (established 2025)

**Relevance to World Models**: Signals Meta's continued investment in physical AI despite losing LeCun. ARI's learning-based control systems (adapting through environmental interaction) align with world model principles. Meta now has both LLM/VLM strength (Llama) and physical AI foundations -- positioning for embodied AI that combines language understanding with physical world modeling.

### Goal-VLA: Image-Generative VLMs as Object-Centric World Models for Zero-shot Robot Manipulation [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2506.23919)

**Authors/Presenters**: Haonan Chen, Jingxiang Guo, Bangjun Wang, Tianrui Zhang, Xuchuan Huang, Boren Zheng, Yiwen Hou, Chenrui Tie, Jiajun Deng, Lin Shao

**Date**: 2026-03

**Summary**: Zero-shot manipulation framework that uses image-generative VLMs as object-centric world models. Rather than fine-tuning VLMs into action-prediction models (standard VLA approach), Goal-VLA generates desired goal-state images from language instructions, then derives target object poses for execution via a training-free low-level policy.

**Key Findings**:

- Object state representation as the "golden interface" naturally separating manipulation into high-level (goal generation) and low-level (pose-based control) policies
- Reflection-through-Synthesis process iteratively validates and refines generated goal images before physical execution
- Generalizes across diverse tasks, objects, and environments (simulated and real) without task-specific training; deploys zero-shot on different robot embodiments
- Sidesteps the VLA data bottleneck: instruction-vision-action data is too limited to cover diverse scenarios, so Goal-VLA avoids fine-tuning VLMs into action predictors

**Relevance to World Models**: Reframes image-generative VLMs as world models for robotics -- predicting what the world should look like after successful manipulation. The object-centric decomposition offers an alternative to end-to-end VLAs (which lack world modeling) and to latent-space planners (whose predictions are not inspectable). Contrasts with JEPA-based planning: Goal-VLA operates in pixel space (generating goal images) while JEPA plans in latent space, but both treat prediction-before-action as the core capability.

---

## Foundational / Theory

*Theoretical foundations, surveys, position papers*

### Do LLMs Build Spatial World Models? Evidence from Grid-World Maze Tasks [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2604.10690)

**Authors/Presenters**: Weijiang Li, Yilin Zhu, Rajarshi Das, Parijat Dube

**Date**: 2026-04

**Summary**: Probes whether LLMs develop internal spatial world models by evaluating them on controlled grid-world maze tasks requiring multi-step planning and spatial abstraction. Finds that LLMs do not build robust spatial world models -- spatial reasoning is representation-dependent, not format-invariant, and models treat questions independently rather than building cumulative spatial knowledge.

**Key Findings**:

- Gemini-2.5-Flash achieves 80-86% accuracy on smaller mazes with tokenized adjacency representations but drops to 16-34% with visual grid formats (2-5x gap)
- Models achieve 96-99% semantic coverage in reasoning traces yet fail at consistent spatial computation
- Chain-of-thought prompting helps surface reasoning but does not overcome fundamental spatial limitations
- Central finding: LLMs exhibit representation-specific and prompting-dependent reasoning that succeeds only under narrow conditions

**Relevance to World Models**: Provides empirical evidence that LLMs do not form genuine internal spatial representations, challenging assumptions about deploying foundation models for spatial planning in robotics and navigation. Supports the thesis that purpose-built world models (JEPA, Dreamer) remain necessary for physical AI -- LLMs can reason about spatial concepts in language but cannot simulate spatial dynamics. Relevant to the ongoing debate about whether LLMs can become world models (cf. Hassabis/Gemini Omni claims).

### DINOv3 [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2508.10104)

**Authors/Presenters**: Oriane Siméoni, Huy V. Vo, Maximilian Seitzer, Federico Baldassarre, Maxime Oquab, Cijo Jose, Vasil Khalidov, Marc Szafraniec, Seungeun Yi, Michaël Ramamonjisoa, Francisco Massa, Daniel Haziza, Luca Wehrstedt, Jianyuan Wang, Timothée Darcet, Théo Moutakanni, Leonel Sentana, Claire Roberts, Andrea Vedaldi, Jamie Tolan, John Brandt, Camille Couprie, Julien Mairal, Hervé Jégou, Patrick Labatut, Piotr Bojanowski

**Date**: 2025-08

**Summary**: Third-generation self-supervised vision foundation model from Meta FAIR. Scales to 7B parameters on 1.7B images (7x model / 12x data vs. DINOv2) and introduces Gram Anchoring — a method that prevents dense feature degradation during long training schedules, a known but previously unsolved issue. First SSL model to consistently outperform weakly-supervised counterparts across both classification and dense prediction tasks.

**Key Findings**:

- Gram Anchoring solves the problem where global representations (classification) keep improving with longer training but dense features (segmentation, detection) degrade — anchoring feature map Gram matrices stabilizes local structure
- Post-hoc strategies enhance flexibility: resolution adaptation, distillation to smaller architectures (ViT-S/B/L/H+, ConvNeXt), and text alignment without retraining
- Outperforms SigLIP 2 and Perception Encoder on classification; significantly widens the gap on dense prediction tasks — all with frozen backbone weights
- Model suite includes a satellite backbone trained on MAXAR imagery, extending SSL to remote sensing domains

**Relevance to World Models**: DINOv3 is a joint-embedding (not predictive) model — it aligns representations of augmented views via teacher-student distillation, whereas JEPA predicts representations of unseen content. Both lineages originate from Meta FAIR / LeCun's group and share the principle of learning in representation space rather than pixel space. DINOv3's frozen features serve as strong visual encoders for downstream world models (cf. DINO-WM baseline), and its Gram Anchoring insight — that dense feature quality requires explicit stabilization — is relevant to JEPA models that also produce dense spatial representations.

### Learning to Model the World: A Survey of World Models in Artificial Intelligence [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.techrxiv.org/doi/full/10.36227/techrxiv.177274570.09578608/v1)

**Authors/Presenters**: Jiahua Dong, Qi Lyu, Baichen Liu, Xudong Wang, Wenqi Liang, Duzhen Zhang, Jiahang Tu, Hongliu Li, Hanbin Zhao, Henghui Ding, Yulun Zhang, Zhi Han, Nicu Sebe, Fahad Shahbaz Khan, Salman Khan, Mubarak Shah, Philip Torr, Ming-Hsuan Yang, Dacheng Tao

**Date**: 2026-03

**Summary**: Comprehensive survey categorizing world models into four branches: observation-level generative, latent space, reinforcement learning-based, and object-centric WMs. Reviews applications spanning robotics, autonomous driving, scientific discovery, game simulation, GUI-based agents, plus interpretability and trustworthiness. Companion repo: [Awesome-World-Models](https://github.com/JiahuaDong/Awesome-World-Models).

**Key Findings**:

- Taxonomy distinguishes four WM families with distinct trade-offs: observation-level models (inspectable but expensive), latent space models (efficient but opaque), RL-based models (task-optimized but domain-specific), and object-centric models (compositional but harder to scale)
- Identifies key open challenges: long-horizon consistency, causal understanding, multi-modal grounding, and sim-to-real transfer
- Cross-institution author list (Oxford, NTU, UCF, Fudan, SJTU) provides broad perspective spanning computer vision, robotics, and AI safety communities

**Relevance to World Models**: Provides a structured map of the entire world models landscape as of early 2026. The four-branch taxonomy is useful for positioning JEPA (latent space branch) and Cosmos (observation-level branch) relative to each other and to alternatives. Companion [Awesome-World-Models](https://github.com/JiahuaDong/Awesome-World-Models) repo serves as a living index of the field.

### Physically Native World Models: A Hamiltonian Perspective on Generative World Modeling [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2605.00412)

**Authors/Presenters**: Sen Cui, Jingheng Ma

**Date**: 2026-05

**Summary**: Proposes Hamiltonian World Models as a physics-grounded alternative to current approaches. Argues the bottleneck in world modeling is not generation quality but whether futures are physically meaningful and useful for action. Encodes observations into structured latent phase space evolving through Hamiltonian-inspired dynamics.

**Key Findings**:

- Current approaches (2D video-generative, 3D scene-centric, JEPA-like latent) still struggle with physically reliable, action-controllable, long-horizon stable predictions
- Proposes Hamiltonian structure with control, dissipation, and residual terms for interpretability and data efficiency
- Acknowledges practical challenges: friction, contact forces, non-conservative dynamics, deformable objects
- Positions physics-native design as prerequisite for embodied decision-making, not just visual fidelity

**Relevance to World Models**: Provides theoretical critique of current world model paradigms from a physics perspective. The argument that "futures must be physically meaningful, not just visually plausible" challenges the video-generation-first approach of Cosmos/Genie. Complements JEPA's latent-space efficiency with explicit physics structure. Early-stage but may influence future architectures.

### Safety, Security, and Cognitive Risks in World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2604.01346)

**Authors/Presenters**: Manoj Parmar

**Date**: 2026-04

**Summary**: First comprehensive risk analysis of world models as learned environment simulators. Introduces formal definitions for trajectory persistence and representational risk, develops a five-profile attacker taxonomy unified with MITRE ATLAS and OWASP LLM frameworks. Demonstrates empirical attacks on GRU-based RSSM architecture achieving 2.26x amplification with 59.5% reward reduction.

**Key Findings**:

- Three risk categories: adversarial attacks (data poisoning, latent representation corruption, rollout error exploitation), alignment challenges (goal misgeneralization, deceptive behavior, reward hacking), human-factors issues (automation bias, miscalibrated trust, planning hallucination)
- Validates attacks across architectures: stochastic RSSM proxy and real DreamerV3 checkpoints
- Proposes mitigations spanning adversarial hardening, alignment engineering, regulatory compliance (NIST AI RMF, EU AI Act), and human-factors design
- Argues world models require rigor equivalent to flight-control or medical device standards

**Relevance to World Models**: Essential reading for anyone deploying world models in safety-critical domains. The paper makes explicit what the robotics and AV communities implicitly know: world models that drive real-world actions create novel attack surfaces. The MITRE ATLAS integration provides a structured vocabulary for security analysis that was previously absent from world models literature.

### Beyond Generative AI: World Models for Clinical Prediction, Counterfactuals, and Planning [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2511.16333)

**Authors/Presenters**: Mohammad Areeb Qazi, Maryam Nadeem, Mohammad Yaqub

**Date**: 2025-11

**Summary**: First focused review of world models in healthcare, covering medical imaging and diagnostics, disease progression modeling, and robotic surgery/surgical planning. Introduces a four-level capability framework: L1 temporal prediction, L2 action-conditioned prediction, L3 counterfactual rollouts for decision support, L4 planning/control.

**Key Findings**:

- Healthcare-specific capability rubric: L1 (predict future state), L2 (predict given intervention), L3 (counterfactual "what-if"), L4 (closed-loop planning) — most current work is L1-L2; L3-L4 remain open challenges
- Identifies critical gaps limiting clinical reliability: under-specified action spaces, weak validation methods, incomplete multimodal state representation, insufficient uncertainty calibration
- Proposes integration of generative backbones with causal/mechanical foundations for safer clinical decision support

**Relevance to World Models**: Provides a healthcare-specific framework for evaluating world model maturity. The L1-L4 capability ladder is useful for positioning EchoJEPA (L1-L2), MeWM (L2-L3), and future clinical world models. Highlights that healthcare requires causal structure beyond correlational prediction — a gap that Causal-JEPA and similar approaches may address.

### Yann LeCun: Self-Supervised Learning, JEPA, World Models, and the Future of AI [<img src="templates/icons/youtube.svg" alt="youtube" height="16">](https://www.youtube.com/watch?v=yUmDRxV0krg)

**Authors/Presenters**: [Yann LeCun](ecosystem.md#yann-lecun) (NYU & Meta)

**Date**: 2025-09

**Duration**: ~60:00

**Summary**: Special lecture at NYU's "Geometry of Machine Learning" series articulating why world models — not LLMs — are the path to human-level AI. Argues that video contains orders of magnitude more structure than text, making it a richer learning signal. Presents V-JEPA 2 results demonstrating robot control from just 62 hours of unlabeled observation video.

**Key Findings**:

- Core thesis: "The world is unpredictable. If you try to build a generative model that predicts every detail of the future, it will fail. JEPA learns abstract representations and makes predictions in that abstract space, ignoring unpredictable details"
- V-JEPA 2 trained on "equivalent of a century of video data" learns physical world model; transfers to robot control with 80% success on novel "move the cup" task (vs. 15% for Octo baseline) using only 62 hours of robot observation
- LLMs structurally limited: "We're absolutely never going to get to human level AI by just training on text" — video provides richer structure through redundancy
- Timeline estimate: "something close to human intelligence or maybe dog intelligence within five to 10 years" (most optimistic); likely unknown obstacles remain

**Relevance to World Models**: Primary source for LeCun's complete articulation of the world models thesis. Key insight: JEPA's latent-space prediction naturally filters unpredictable details (textures, shadows, reflections) while capturing predictable dynamics (physics, object permanence). The V-JEPA 2 robot results demonstrate concrete progress from theory to deployment.

### Beyond Language Models: Yann LeCun's World Models and the Future of AI in Healthcare [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.onhealthcare.tech/p/beyond-language-models-yann-lecuns)

**Authors/Presenters**: Thoughts on Healthcare Markets & Technology (Substack)

**Date**: 2025-06

**Summary**: Position piece arguing for a paradigm shift from language-based AI to world models in healthcare. Cites LeCun's critique that LLMs require 400,000 years of text equivalent to achieve basic competency, while children develop sophisticated understanding through 16,000 hours of visual experience. Proposes world models as foundation for patient monitoring, diagnostic imaging, surgical planning, and drug discovery.

**Key Findings**:

- V-JEPA demonstrates ability to detect physically impossible events in video sequences — applicable to detecting anomalies in medical imaging and physiological data
- Eight healthcare application domains: patient monitoring (early warning), diagnostic imaging (3D understanding), surgical assistance (real-time adaptation), treatment planning, drug discovery (molecular modeling), mental health (behavioral observation), rehabilitation (movement analysis), chronic disease management (trajectory prediction)
- Key barrier: transition requires substantial technical infrastructure, regulatory navigation, and market adoption — current healthcare AI investments concentrate on LLMs
- Health tech entrepreneurs advised to develop LLM solutions while preparing for world model emergence

**Relevance to World Models**: Provides healthcare-specific articulation of LeCun's world models thesis. The eight application domains serve as a roadmap for healthcare world model development. The observation that V-JEPA's "physically impossible event detection" translates to medical anomaly detection connects JEPA's theoretical properties to concrete clinical value.

### Ilya Sutskever: The End of AI Scaling and the Rise of Safe Superintelligence [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.the-ai-corner.com/p/ilya-sutskever-safe-superintelligence-agi-2025)

**Authors/Presenters**: The AI Corner (summary of [Ilya Sutskever](ecosystem.md#ilya-sutskever)'s interview with Dwarkesh Patel)

**Date**: 2025-11

**Summary**: Summary of a rare Sutskever interview articulating SSI's research philosophy. Argues the age of scaling is ending — pretraining has depleted high-quality internet text, diminishing returns are evident in RL training — and the next breakthroughs depend on new learning methods, not more GPUs. Bets on "a new paradigm instead of a bigger transformer."

**Key Findings**:

- Modern AI generalizes "dramatically worse than humans": solves olympiad math while failing basic logic, writes code but misses obvious bugs. Gap stems from lack of evolutionary priors and dense internal reward signals
- AGI will start as "a superintelligent learner" — not omniscient at deployment but capable of rapid skill acquisition through continual learning during real-world deployment
- Alignment framed as a generalization problem: if a model robustly learns human values, it won't break them unpredictably. Proposes centering superintelligent systems on caring for "sentient life" generally
- Estimates 5-20 years for human-level learning systems

**Relevance to World Models**: Sutskever's emphasis on continual learning, generalization beyond benchmarks, and moving beyond the transformer paradigm aligns directly with the world models research agenda. His framing of AGI as a "superintelligent learner" rather than an "all-knowing oracle" echoes the world models premise: intelligence requires building and updating internal models of the world through experience.

### It's Hard to Feel the AGI [<img src="templates/icons/website.svg" alt="website" height="16">](https://tensorlabbet.com/2025/11/30/hard-to-feel-agi/)

**Authors/Presenters**: Taro Langner (Tensor Labbet)

**Date**: 2025-11

**Summary**: Analysis synthesizing views from Sutskever, Karpathy, and LeCun on why current AI falls short of AGI. Discusses the "Big World Hypothesis" (attributed to Rich Sutton): the world is too complex for any agent to navigate without continual learning from experience. Contextualizes the post-scaling shift across multiple thought leaders.

**Key Findings**:

- Rich Sutton's Big World Hypothesis: the world is too complex for agents without continual adaptation — a capability current LLMs fundamentally lack
- Contrasts revised timelines: Sutskever pushes back 5-20 years, Karpathy reframes "year of agents" as "decade of agents", LeCun anticipates 3-5 years for required capabilities
- Highlights Moravec's Paradox as persisting in modern AI: machines imitate high-level cognitive tasks but fail at low-level sensorimotor and social skills
- SSI described as "exploring research ideas that may identify viable new approaches" — no technical specifics disclosed

**Relevance to World Models**: The Big World Hypothesis provides a theoretical motivation for world models: static pre-trained models cannot capture the complexity of dynamic environments. The convergence of Sutskever, Karpathy, and LeCun on continual learning as a key missing ingredient validates the world models research direction.

### Superintelligent Agents Pose Catastrophic Risks: Can Scientist AI Offer a Safer Path? [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2502.15657)

**Authors/Presenters**: Yoshua Bengio, Michael Cohen, Damiano Fornasiere, Joumana Ghosn, Pietro Greiner, Matt MacDermott, Sören Mindermann, Adam Oberman, Jesse Richardson, Oliver Richardson, Marc-Antoine Rondeau, Pierre-Luc St-Charles, David Williams-King

**Date**: 2025-02

**Summary**: Argues that current efforts to build autonomous AI agents pose catastrophic risks — deception, goal-seeking misalignment, irreversible loss of human control. Proposes "Scientist AI" as a safer alternative: a non-agentic system built around a world model that explains observations and answers questions rather than autonomously pursuing goals.

**Key Findings**:

- Contends that leading AI labs' focus on generalist agents creates risks from misuse to irreversible loss of human control
- Proposes Scientist AI: comprises a world model generating theories and a question-answering component; operates with explicit uncertainty quantification
- Scientist AI is deliberately non-agentic — focuses on passive understanding and accurate representations of reality without pursuing independent objectives
- Advocates prioritizing non-agentic AI to capture benefits of AI innovation while mitigating alignment risks

**Relevance to World Models**: Directly advocates world models as the core component of safe AI. The Scientist AI proposal — a system that builds accurate internal representations of reality rather than autonomously acting on goals — aligns with the world models vision. Provides a safety-motivated argument for why world models should be developed before (or instead of) autonomous agents.

### Embodied AI: From LLMs to World Models [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.techrxiv.org/doi/full/10.36227/techrxiv.175977432.27129012/v1)

**Authors/Presenters**: Tongtong Feng, Xin Wang, Wenwu Zhu (Tsinghua University), Yu-Gang Jiang (Fudan University)

**Date**: 2025-10 (IEEE Circuits and Systems Magazine)

**Summary**: Comprehensive survey exploring embodied AI from two pillars: LLMs enabling semantic reasoning and task decomposition, and world models enabling physical dynamics prediction and simulation. Categorizes world model architectures into three families — RSSM-based (Dreamer), JEPA-based, and Transformer-based — and proposes a joint MLLM-WM architecture where multimodal LLMs provide high-level semantics while world models handle physics-aware simulation.

**Key Findings**:

- Identifies complementary strengths: MLLMs enable contextual task reasoning but overlook physical constraints; WMs excel at physics-aware simulation but lack high-level semantics
- Taxonomy of WM architectures for embodied AI: RSSM decomposes hidden states into probabilistic and deterministic components; JEPA predicts in latent space avoiding reconstruction; Transformer-based WMs leverage attention for long-range dependencies
- Proposes joint MLLM-WM-driven embodied AI architecture combining language grounding with physics simulation

**Relevance to World Models**: Provides the clearest side-by-side comparison of the three dominant world model architecture families (RSSM, JEPA, Transformer). The proposed MLLM-WM fusion architecture directly addresses the limitation that world models lack semantic understanding — relevant to bridging JEPA-style physics prediction with language-based task planning.

### Integrating World Models into Vision Language Action and Navigation: A Comprehensive Survey [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.techrxiv.org/users/1002875/articles/1364568)

**Authors/Presenters**: (TechRxiv preprint)

**Date**: 2025-12

**Summary**: Survey classifying world model integration with VLA systems into three architectural paradigms: Modular (world models and policies as distinct modules), Sequential (hierarchical plan-then-execute workflows), and Unified (end-to-end fusion of world prediction and action generation). Covers navigation and manipulation applications.

**Key Findings**:

- Integration-centric taxonomy: Modular architectures offer interpretability but suffer from error propagation; Sequential architectures enable hierarchical planning but increase latency; Unified architectures reduce integration overhead but are harder to debug
- Identifies key challenge: world models must simultaneously predict environment dynamics and inform action selection without introducing compounding errors over long horizons
- Covers both vision-language-action (manipulation) and vision-language-navigation tasks, highlighting shared and divergent requirements

**Relevance to World Models**: Directly addresses the integration problem — how to connect world models to downstream action systems. The three-paradigm taxonomy is useful for positioning different approaches: JEPA-WMs typically follow the Modular pattern, while recent VLA models like ACT-JEPA move toward Unified architectures.

### World Model for Robot Learning: A Comprehensive Survey [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2605.00080)

**Authors/Presenters**: Bohan Hou, Gen Li, Jindou Jia, Tuo An, Xinying Guo, Sicong Leng, Haoran Geng, Yanjie Ze, Tatsuya Harada, Philip Torr, Oier Mees, Marc Pollefeys, Zhuang Liu, Jiajun Wu, [Pieter Abbeel](ecosystem.md#pieter-abbeel), [Jitendra Malik](ecosystem.md#jitendra-malik), Yilun Du, Jianfei Yang

**Date**: 2026-04

**Summary**: Comprehensive 43-page survey of world models for robot learning, unifying a fragmented literature across architectures, functional roles, and embodied application domains. Examines how world models couple with robot policies, serve as learned simulators for RL and evaluation, and traces the evolution of video world models from imagination-based to foundation-scale formulations.

**Key Findings**:

- Identifies world models as central to robot learning across five functional roles: policy learning, planning, simulation, evaluation, and data generation
- Taxonomy organizes coupling patterns between world models and policies (modular, unified, hybrid)
- Traces video world model progression through four paradigms: imagination-based → controllable → structured → foundation-scale
- Connects manipulation, navigation, and autonomous driving applications under a unified framework
- Includes maintained GitHub repository with datasets, benchmarks, and evaluation protocols

**Relevance to World Models**: The most comprehensive robotics-focused world model survey to date, with senior authorship from [Pieter Abbeel](ecosystem.md#pieter-abbeel) and [Jitendra Malik](ecosystem.md#jitendra-malik). Useful reference for mapping how JEPA-based world models fit into the broader robot learning ecosystem. The five functional roles framework complements our primer's L1-L4 capability levels.

### Agentic World Modeling: Foundations, Capabilities, Laws, and Beyond [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2604.22748)

**Authors/Presenters**: Meng Chu, Xuan Billy Zhang, Kevin Qinghong Lin, Lingdong Kong et al. (42 authors)

**Date**: 2026-04

**Summary**: Introduces a "levels × laws" taxonomy for world models spanning two axes: a capability axis (L1 Predictor → L2 Simulator → L3 Evolver) and a governing-law axis (physical, digital, social, scientific). Synthesizes over 400 works and 100+ representative systems across model-based RL, video generation, web/GUI agents, multi-agent social simulation, and scientific discovery.

**Key Findings**:

- Three-level capability taxonomy: L1 Predictor (one-step transition), L2 Simulator (multi-step action-conditioned rollouts respecting domain laws), L3 Evolver (autonomously revises own model when predictions fail)
- Four governing-law regimes determine constraints and failure modes: physical, digital, social, scientific
- Proposes decision-centric evaluation principles rather than perceptual quality metrics
- Identifies L3 (Evolver) as the frontier — world models that self-correct represent the path to continual learning
- Charts roadmap from passive prediction toward models that simulate and reshape agent environments

**Relevance to World Models**: The L1-L2-L3 taxonomy offers a complementary framework to our primer's L1-L4 capability levels. Notably, their L3 "Evolver" directly addresses the continual learning gap identified in our primer. The "laws" axis is a novel contribution — recognizing that world models for web agents (digital laws) face fundamentally different constraints than those for robotics (physical laws). Broadest survey of agentic world modeling to date.

---

## Strategy

*Strategic vision, industry direction, and roadmap communications from key players*

### Our Vision for Building a Universal AI Assistant [<img src="templates/icons/website.svg" alt="website" height="16">](https://blog.google/technology/google-deepmind/gemini-universal-ai-assistant)

**Authors/Presenters**: [Demis Hassabis](ecosystem.md#demis-hassabis) (Google DeepMind)

**Date**: 2025-05

**Summary**: Hassabis outlines Google DeepMind's roadmap to extend Gemini 2.5 Pro into a "world model" capable of planning and simulating aspects of the physical world. Frames world modeling as a critical step toward a universal AI assistant, building on prior game-playing agents (AlphaGo/Zero), Genie 2 (interactive 3D environments), and Gemini Robotics.

**Key Findings**:

- Explicit goal: make Gemini "a world model that can make plans and imagine new experiences by understanding and simulating aspects of the world"
- World model capability already emerging via Veo (intuitive physics understanding), Gemini Robotics (real-time object manipulation), and environment simulation
- Positions world modeling as path from language-only AI to universal AI assistant — context-aware, able to plan and act across any device
- Builds on foundation of game-playing agents, Genie 2 (3D sim from image prompts), and cross-domain scientific breakthroughs
- Integration into consumer products via Project Astra (video understanding), Project Mariner (agentic browser tasks)

**Relevance to World Models**: Notable strategic signal from Google DeepMind's CEO. Frames world models not as a robotics-only capability but as fundamental to the next generation of AI assistants. Contrasts with Meta's JEPA-centric approach — Google bets on extending a general-purpose LLM (Gemini) into world modeling rather than building a purpose-built architecture. If realized, would validate the primer's thesis that LLMs and world models converge.

### The Hardest Problem AI Ever Solved [<img src="templates/icons/youtube.svg" alt="youtube" height="16">](https://www.youtube.com/watch?v=C0gErQtnNFE)

**Authors/Presenters**: [Demis Hassabis](ecosystem.md#demis-hassabis) (Google DeepMind), interviewed by Cleo Abram (HUGE\* Conversations)

**Date**: 2026-04

**Duration**: ~1:30:00

**Summary**: Wide-ranging interview where Hassabis clarifies Google DeepMind's world model strategy. Reveals that Genie (world-generator) and SIMA (embodied agent) form a self-reinforcing training loop — Genie creates environments on demand, SIMA trains within them — eliminating the data bottleneck holding back robotics. Distinguishes world models from LLMs: predicting the next state of a physical environment vs. predicting the next word.

**Key Findings**:

- Genie + SIMA convergence is the core strategy: *"Whatever the SIMA agent is trying to learn, Genie can basically create on the fly"* — creates infinite training scenarios for embodied agents
- Current video models look realistic but are not yet "physics-grade" — DeepMind is building physics benchmarks (pendulums, rolling balls) to test whether models follow Newton's laws with 100% accuracy
- Gemini is necessary but insufficient for physical AI: provides reasoning and language understanding, but language has "inherent limitations" for robotics — world models provide the missing physical understanding layer
- AGI requires AlphaGo-style search and planning layered on top of foundation models — *"still hasn't fully been cracked yet"* for general domains
- Predicts a "ChatGPT moment" for world models; estimates AGI is 5-10 years away with "one or two more breakthroughs" needed

**Relevance to World Models**: Clarifies a common misreading of Google's strategy. Hassabis is not simply extending Gemini into a world model — he describes a portfolio where Gemini handles language/reasoning, Genie handles world simulation, and SIMA handles embodied action. Convergence is at the system level, not the architecture level. The "physics-grade" accuracy standard and Newton's-law benchmarks are notable — sets a higher bar than visual realism for world model evaluation.

### Introducing Gemini Omni [<img src="templates/icons/website.svg" alt="website" height="16">](https://blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-omni/)

**Authors/Presenters**: Koray Kavukcuoglu (CTO, [Google DeepMind](ecosystem.md#google-deepmind))

**Date**: 2026-05

**Summary**: Official announcement of Gemini Omni, a native multimodal model that processes text, images, audio, and video in a single unified token space to generate and iteratively edit video. Positioned explicitly as a world model — not a video generator — with claimed intuitive physics understanding. Fuses capabilities from Gemini (reasoning), Veo (video generation), Nano Banana (image editing), and Project Genie (interactive world simulation) into one architecture.

**Key Findings**:

- Unified architecture processes all modalities in single token space rather than routing through separate pipelines — eliminates "temporal drift" from frame-stitching approaches
- Claims intuitive understanding of physics (gravity, kinetic energy, fluid dynamics, spatial awareness); demo showed marble navigating complex chain-reaction track with physically plausible behavior
- Multi-turn conversational editing with persistent scene state — edits build on prior context, maintaining character consistency and physics continuity
- Two variants: Omni Flash (launched May 2026) and Omni Pro (planned, contingent on "step change above Flash"); replaces Veo in consumer Gemini app but Veo 3.1 persists on Vertex AI/API
- SynthID pixel-level watermark (non-optional, imperceptible) and C2PA Content Credentials on all generated video; digital avatar feature requires identity verification onboarding

**Relevance to World Models**: Concrete realization of [Hassabis's 2025 vision](https://blog.google/technology/google-deepmind/gemini-universal-ai-assistant) to extend Gemini into a world model. Validates the system-level convergence thesis — Omni integrates Gemini (language/reasoning), Genie (world simulation), and Veo (visual rendering) rather than building a purpose-built WM architecture. The unified token space approach contrasts with both JEPA's latent-space prediction and NVIDIA Cosmos's diffusion-based generation. No technical paper, benchmarks, or architecture details disclosed — claims of physics understanding remain unverified against the "physics-grade" standard Hassabis set in his April 2026 interview.

### Google's Gemini Omni Turns Images, Audio, and Text into Video [<img src="templates/icons/website.svg" alt="website" height="16">](https://techcrunch.com/2026/05/19/googles-gemini-omni-turns-images-audio-and-text-into-video-and-thats-just-the-start/)

**Authors/Presenters**: TechCrunch (Kyle Wiggers)

**Date**: 2026-05

**Summary**: News coverage of Gemini Omni launch with key quotes from Sundar Pichai and DeepMind's Nicole Brichtova. Pichai frames the shift: "With world models, AI is moving from predicting text to simulating reality." Brichtova distinguishes Omni from Veo: "the next step towards combining the intelligence of Gemini with the rendering capabilities of our media models."

**Key Findings**:

- Pichai quote positions world models as the successor paradigm to language models: "from predicting text to simulating reality"
- Brichtova clarifies Omni is not a Veo update but a fusion of reasoning + rendering: merges Gemini intelligence with media generation capabilities
- Cross-modal reasoning demonstrated: given "claymation explainer of protein folding," generated stop-motion video with accurate scientific narration about amino acids, alpha helices, beta sheets — showing simultaneous visual and factual reasoning
- 10-second clip limit at launch described as "deliberate deployment cap to manage compute demand," not a model limitation
- Competitive context: OpenAI's Sora app now defunct; Luma AI building unified model for agentic creative workflows

**Relevance to World Models**: The Pichai quote ("from predicting text to simulating reality") is the clearest framing yet of world models as the next paradigm shift after LLMs — from a CEO of one of the three companies capable of sustaining frontier AI capex. The protein-folding demo is notable: it requires both physical simulation (claymation physics) and factual reasoning (biology) simultaneously, suggesting the unified architecture may offer advantages over modality-specific pipelines. However, no quantitative comparison with existing world models (Cosmos, Genie 3) is provided.

### Google I/O 2026: Gemini Omni and the Rise of World Modeling [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.efficientlyconnected.com/google-io-2026-gemini-omni-world-modeling/)

**Authors/Presenters**: Efficiently Connected

**Date**: 2026-05

**Summary**: Enterprise-focused analysis of Gemini Omni's implications for industrial applications. Frames Omni as a potential "simulation substrate" replacing purpose-built physical modeling software. Details the TPU 8t/8i hardware split enabling the model, and warns of significant vendor lock-in risks for enterprises adopting Omni for simulation workloads.

**Key Findings**:

- Positions Omni as enterprise simulation substrate for pharma, climate science, automotive engineering, and manufacturing — domains relying on expensive physical prototyping cycles
- TPU 8t (training): global cluster exceeding 1M TPUs via JAX/Pathways, compresses training from months to weeks; TPU 8i (inference): 1,500 tokens/sec on flash models — first time Google splits TPU into training vs. inference specialized chips
- Token economics: enterprises processing ~1T tokens/day could achieve >$1B annual savings; CIOs reportedly exhausting annual token budgets before fiscal midpoint
- Lock-in warning: anchoring simulation pipelines to Omni + TPU v8 creates "multi-year architectural rebuild" migration cost — more severe than traditional software vendor lock-in
- Competitive thesis: as text-based reasoning benchmarks converge across vendors, physical simulation accuracy and multimodal throughput become the differentiating axis — favoring vertically integrated hyperscalers

**Relevance to World Models**: Provides the enterprise adoption lens missing from Google's announcement. The framing of world models as "simulation substrates" connects to our digital twin and industrial use cases. The TPU 8t/8i split is architecturally significant — purpose-built inference hardware for world models suggests Google expects persistent, high-throughput world model inference as a primary workload, not occasional generation. The lock-in analysis is a practical concern for any organization evaluating world model platforms (Cosmos vs. Omni vs. purpose-built).

### Genesis AI has gone full stack [<img src="templates/icons/website.svg" alt="website" height="16">](https://techcrunch.com/2026/05/06/khosla-backed-robotics-startup-genesis-ai-has-gone-full-stack-demo-shows/)

**Authors/Presenters**: TechCrunch

**Date**: 2026-05

**Type**: Blog Post

**Summary**: Coverage of [Genesis AI](ecosystem.md#genesis-ai)'s GENE-26.5 launch and full-stack thesis. Genesis raised $105M seed (Eclipse, Khosla Ventures, Bpifrance, Schmidt, Daniela Rus, Vladlen Koltun). Founded Dec 2024 by Zhou Xian (PhD CMU) and Théophile Gervet (ex-Mistral). Genesis World simulation platform (29K GitHub stars) provides open-source multi-physics simulation with cross-platform compilation (CUDA, ROCm, Metal). Company plans to unveil its first general-purpose robot.

**Key Findings**:

- $105M seed is one of the largest French seed rounds ever, matching Mistral AI — signals significant investor appetite for full-stack robotics
- Full-stack ownership (model + hardware + simulation + data) mirrors NVIDIA's vertical integration strategy but from a startup posture
- Genesis World 1.0 achieves 0.90 Pearson correlation with real hardware across 14 tasks; Quadrants compiler targets multiple GPU vendors (unlike NVIDIA-only Isaac Sim)
- Still R&D phase: no commercial deployments, no revenue, no independent benchmarks

**Relevance to World Models**: Genesis AI illustrates a third vertical integration strategy (after NVIDIA and Google) for physical AI — one built on open-source simulation (Apache 2.0) with hardware-neutral compilation. For Red Hat's platform implications, the Quadrants compiler targeting ROCm/Metal alongside CUDA demonstrates that hardware-neutral world model simulation is architecturally feasible, not just aspirational. Genesis World's scale (29K stars) makes it a relevant simulation platform alongside NVIDIA Omniverse/Isaac Sim.

### The State of AI in the Enterprise [<img src="templates/icons/filetype-pdf.svg" alt="pdf" height="16">](https://www.deloitte.com/us/en/what-we-do/capabilities/applied-artificial-intelligence/content/state-of-ai-in-the-enterprise.html)

**Authors/Presenters**: Deloitte AI Institute (Beena Ammanath, Jim Rowan, Nitin Mittal, Costi Perricos)

**Date**: 2026-01

**Summary**: Seventh annual enterprise AI survey (3,235 senior leaders across 24 countries, August–September 2025). Covers adoption trajectories for generative, agentic, and physical AI. Reports that 58% of enterprises already deploy physical AI in some form, projected to reach 80% within two years, with Asia Pacific leading early implementation.

**Key Findings**:

- Physical AI types with greatest expected enterprise impact: intelligent security/monitoring (21%), collaborative robotics (20%), digital twins (19%), IoT-driven retail (16%), autonomous logistics (13%)
- 74% of companies plan to deploy agentic AI within two years; only 21% have mature governance models for autonomous agents
- Adoption most advanced in manufacturing, logistics, and defense; warehousing identified as earliest enterprise adopter driven by labor market pressures
- 36% of surveyed companies expect at least 10% of jobs fully automated within one year; 82% within three years
- Insufficient worker skills cited as biggest barrier to AI workflow integration

**Relevance to World Models**: Primary industry data source for physical AI enterprise adoption. The 21% figure for intelligent security/monitoring as the top physical AI type suggests world model-based anomaly detection has near-term market pull. The 58→80% adoption trajectory and SI-dominated go-to-market channel (Deloitte, Accenture, Siemens, Schneider) are key inputs for platform strategy.

---

## Robot Foundation Models

*VLA, WAM, and policy learning architectures*

### State of Vision-Language-Action (VLA) Research at ICLR 2026 [<img src="templates/icons/website.svg" alt="website" height="16">](https://mbreuss.github.io/blog_post_iclr_26_vla.html)

**Authors/Presenters**: Moritz Reuss (NVIDIA)

**Date**: 2025-10

**Type**: Blog Post

**Summary**: Practitioner's survey of the VLA research landscape based on ICLR 2026 submissions. Quantifies the field's explosive growth (1 → 9 → 164 submissions across ICLR 2024-2026), identifies nine research trends, and flags a significant hidden gap between closed-weight frontier VLAs and open-weight academic VLAs.

**Key Findings**:

- VLA submissions to ICLR grew 18x in one year (9 at ICLR 2025 → 164 at ICLR 2026)
- LIBERO is "basically solved" and CALVIN "almost saturated" — marginal differences (98% vs 99%) are uninformative, reinforcing the benchmark audit findings
- Nine research trends: discrete diffusion VLAs, reasoning/ECoT, new tokenizers, efficient VLAs, RL for VLAs, video prediction, evaluation/benchmarking, cross-action-space learning, and others (memory, policy composition)
- Significant frontier gap: closed-weight VLAs (Gemini-Robotics, Pi-0.5) exhibit zero-shot open-world behavior that open-weight models cannot match — simulation benchmarks obscure this difference
- Critically under-explored areas: data quality/curation and in-context learning for VLAs

**Relevance to World Models**: The 18x growth rate quantifies VLA as the dominant robot foundation model paradigm. The frontier gap finding is a key platform strategy input — it means open-weight VLAs are not yet competitive for production deployment despite strong benchmark scores, creating a dependency on proprietary providers. The LIBERO/CALVIN saturation finding directly supports our benchmark audit tracking and the case for multi-benchmark evaluation infrastructure. The video prediction trend (trend 6) documents VLA→WAM convergence from the VLA side.

---

### OpenVLA: An Open-Source Vision-Language-Action Model [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2406.09246)

**Authors/Presenters**: Moo Jin Kim, Karl Pertsch, Siddharth Karamcheti, Ted Xiao, Ashwin Balakrishna, Suraj Nair, Rafael Rafailov, Ethan Foster, Grace Lam, Pannag Sanketi, Quan Vuong, Thomas Kollar, Benjamin Burchfiel, Russ Tedrake, Dorsa Sadigh, [Sergey Levine](ecosystem.md#sergey-levine), Percy Liang, [Chelsea Finn](ecosystem.md#stanford-svl--sail)

**Date**: 2024-06

**Summary**: Open-source 7B-parameter VLA trained on 970K real-world robot demonstrations from the Open X-Embodiment dataset. Combines Llama 2 backbone with fused DINOv2 + SigLIP visual encoders. Outperforms the closed 55B RT-2-X model by 16.5% in absolute success rate across 29 tasks with 7x fewer parameters.

**Key Findings**:

- Outperforms RT-2-X (55B) by 16.5% and Diffusion Policy by 20.4% in absolute success rate
- Fine-tunable on consumer GPUs via LoRA; quantizable without performance loss
- Open X-Embodiment training enables cross-embodiment generalization
- Established OpenVLA as the de facto open-source VLA baseline for the field

**Relevance to World Models**: OpenVLA demonstrates that open-weight VLAs can match or exceed proprietary alternatives, paralleling the Llama moment for LLMs. As a policy model (not a world model), it consumes world model outputs for action generation. The architecture — VLM backbone with tokenized actions — became the template for subsequent VLAs (SmolVLA, GR00T N1). Code at [github.com/openvla/openvla](https://github.com/openvla/openvla).

### OpenVLA-OFT: Optimized Fine-Tuning for VLAs [<img src="templates/icons/website.svg" alt="website" height="16">](https://openvla-oft.github.io/)

**Authors/Presenters**: Moo Jin Kim, Karl Pertsch, [Chelsea Finn](ecosystem.md#stanford-svl--sail), [Sergey Levine](ecosystem.md#sergey-levine) et al.

**Date**: 2025-03

**Summary**: Optimized fine-tuning recipe for VLAs achieving 25-50x faster inference than OpenVLA while improving task success. Uses continuous action outputs (not discrete tokens) for higher model quality, supporting multi-image inputs and high-frequency bimanual control. Achieves 97.1% average success on LIBERO across 4 task suites.

**Key Findings**:

- 97.1% on LIBERO — outperforms π0, MDT, Seer, DiT Policy, Octo, and Diffusion Policy
- 25-50x faster inference via continuous action representation (vs. discrete token decoding)
- Supports multiple input images and bimanual robot control
- FAST action tokenizer (Jan 2025) enables 15x inference speedup with discrete action compression

**Relevance to World Models**: OFT demonstrates that the action representation choice (continuous vs. discrete) significantly impacts both speed and quality. The continuous approach contrasts with the tokenization strategy used in Cosmos 3's unified action representation. Positions OpenVLA as a competitive open alternative to proprietary VLAs for real-time robot control.

### Helix: A Vision-Language-Action Model for Generalist Humanoid Control [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.figure.ai/helix)

**Authors/Presenters**: [Figure AI](ecosystem.md#figure-ai)

**Date**: 2025-02 (Helix), 2026-01 (Helix 02)

**Summary**: VLA with a three-tier System 0/1/2 architecture for full-body humanoid control. System 2 (VLM, 7-9Hz) handles scene understanding and language comprehension; System 1 (visuomotor policy, 200Hz) translates perception to precise actions; System 0 (kHz-rate, added in Helix 02) provides learned balance and coordination from 1000+ hours of human motion data. First VLA to output continuous control of entire humanoid upper body including individual fingers.

**Key Findings**:

- First VLA with simultaneous upper-body control (wrists, torso, head, fingers) at 200Hz
- First VLA demonstrated on two robots solving shared, long-horizon manipulation tasks with unseen objects
- Helix 02 (Jan 2026): extends to full-body control — walking, manipulation, and balance as one continuous system
- System 0 replaces hand-engineered controllers with learned balance prior from large-scale simulation + human motion capture
- 4-minute autonomous task sequences (dishwasher unload/reload across full kitchen) with no resets

**Relevance to World Models**: The three-tier architecture (System 0/1/2) extends the dual-system pattern seen in GR00T N1 and Gemini Robotics by adding a dedicated sub-neural motor layer (System 0) for balance — functionally similar to the cerebellum vs. cortex separation in biological systems. System 0 can be seen as an implicit dynamics model: it predicts the body's response to actions and corrects in real-time. Tightly coupled to Figure hardware, limiting platform generality.

### SmolVLA: A Vision-Language-Action Model for Affordable and Efficient Robotics [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2506.01844)

**Authors/Presenters**: Mustafa Shukor, Dana Aubakirova, Francesco Capuano, Pepijn Kooijmans, Steven Palma, Adil Zouitine, Michel Aractingi, Caroline Pascal, Martino Russi, Andres Marafioti, Simon Alibert, Matthieu Cord, Thomas Wolf, Remi Cadene ([HuggingFace](ecosystem.md#huggingface))

**Date**: 2025-06

**Summary**: Compact 450M-parameter open-source VLA from HuggingFace built on SmolVLM-2 (SigLIP + SmolLM2) with a lightweight flow-matching action expert. Trained on a single GPU using <30K episodes of community-collected LeRobot data. Achieves performance competitive with models 10x larger through asynchronous inference decoupling perception from action execution.

**Key Findings**:

- 450M parameters — trainable on a single GPU, deployable on consumer GPUs or CPUs
- Competitive with OpenVLA (7B), Octo, and π0 on LIBERO and Meta-World benchmarks despite 10x fewer params
- Asynchronous inference stack enables real-time control even on resource-constrained hardware
- Fully open: code, weights, and training data released via LeRobot (github.com/huggingface/lerobot)
- Community-driven: trained exclusively on compatibly-licensed, community-shared datasets

**Relevance to World Models**: SmolVLA represents the efficiency frontier for VLAs — analogous to Phi/SmolLM in the language model space. The flow-matching action expert mirrors π0's approach but at 15x smaller scale, suggesting that flow matching may be more parameter-efficient than autoregressive token prediction for action generation. The LeRobot ecosystem (datasets + models + serving) is emerging as the open alternative to proprietary VLA stacks.

### pi0.5: Cross-Embodiment Generalization Without Per-Robot Fine-Tuning [<img src="templates/icons/website.svg" alt="website" height="16">](https://www.pi.website/blog)

**Authors/Presenters**: [Physical Intelligence](ecosystem.md#physical-intelligence-pi)

**Date**: 2026-04

**Summary**: Claims the first robotics foundation model that generalizes across embodiments without per-robot fine-tuning. Also introduces MEM (Multi-Scale Embodied Memory) for long-horizon tasks exceeding 10 minutes, and RL Token for extracting online RL signals from VLA representations to improve precision with few hours of data.

**Key Findings**:

- Cross-embodiment generalization without per-robot fine-tuning — a step toward truly general robot policies
- MEM (Multi-Scale Embodied Memory): long-term and short-term memory enabling complex tasks >10 minutes
- RL Token: extracts reinforcement learning signals from VLA latent representations for fast online fine-tuning on precise manipulation
- Builds on π0/π0-FAST architecture with flow matching action generation at 50Hz

**Relevance to World Models**: MEM addresses a fundamental limitation of current VLAs — episodic memory. World models predict future states; MEM provides past-state retrieval, complementing forward prediction with backward context. The RL Token approach suggests that VLA representations already encode dynamics information useful for RL, blurring the line between policy models and implicit world models.

### Gemini Robotics 1.5: Pushing the Frontier of Generalist Robot Policies [<img src="templates/icons/filetype-pdf.svg" alt="pdf" height="16">](https://storage.googleapis.com/deepmind-media/gemini-robotics/Gemini-Robotics-1-5-Tech-Report.pdf)

**Authors/Presenters**: [Google DeepMind](ecosystem.md#google-deepmind)

**Date**: 2025-03

**Summary**: Technical report for Gemini Robotics 1.5, the VLA component of Google's robotics stack. Built on Gemini 2.0 with physical actions as a new output modality. More than doubles performance on comprehensive generalization benchmarks compared to other SOTA VLAs. On-Device variant achieves <10ms inference, learns from 50 demonstrations, and transfers across embodiments.

**Key Findings**:

- 2x improvement over SOTA VLAs on comprehensive generalization benchmark
- Cross-embodiment: single model controls ALOHA 2, Franka arms, and Apptronik Apollo humanoid
- Gemini Robotics On-Device: <10ms inference, 50-demo task learning, fully on-robot
- Outperforms π0 re-implementation on deformable object manipulation and long-horizon tasks
- Dexterous capabilities including origami folding and real-time conversational control

**Relevance to World Models**: Gemini Robotics-ER (embodied reasoning) provides planning and spatial understanding without explicit state prediction — a reasoning model, not a world model. But the On-Device variant's <10ms latency makes it viable for closed-loop reactive control where world model prediction would be too slow. The tech report provides detailed ablations useful for benchmarking against GR00T N1 and π0 architectures.

### The Rise of World-Action Models [<img src="templates/icons/website.svg" alt="website" height="16">](https://developer.nvidia.com/blog/pretrained-to-imagine-fine-tuned-to-act-the-rise-of-world-action-models/)

**Authors/Presenters**: Moritz Reuss (NVIDIA)

**Date**: 2026-06

**Type**: Blog Post

**Summary**: Landscape survey of World-Action Models (WAMs) as the emerging second recipe for robot foundation models alongside VLAs. Introduces a three-axis WAM taxonomy (paradigm x action integration x architecture), provides the first quantified compute cost comparison (ZFLOPs) across VLA and WAM training stacks, and predicts WAM+VLA hybrid convergence via Mixture-of-Transformers.

**Key Findings**:

- Three-axis WAM taxonomy: paradigm (inverse dynamics / joint prediction / representation-only), action integration (tokens / image / latent plans), architecture (hierarchical / monolithic / MoT)
- Full WAM training stack costs ~7.4x more than VLA stack (51 vs 6.9 ZFLOPs) due to video backbone pretraining — the key infrastructure sizing input
- Fast-WAM (arXiv:2603.16666) shows representation-only mode matches full video-generating WAMs on simulation benchmarks while cutting inference from 590-800ms to sub-200ms per action chunk — eliminates the 3-4x WAM inference penalty if validated on real robots
- [DreamZero](ecosystem.md#nvidia) reaches 1750 Elo on [RoboArena](../projects.md#roboarena) trained only on DROID, without large-scale cross-embodiment pretraining
- [Being-H0.7](ecosystem.md#beingbeyond) combines V-JEPA 2.1 + InternVL3.5 + Qwen3 with Play-LMP-style prior/posterior latent interface — best current example of VLA+WAM hybrid
- MoT predicted to become the dominant WAM architecture (already default in Pi-0, Pi-0.5, LingBot-VA, Fast-WAM)
- New ecosystem players: [Sereact](ecosystem.md#sereact) Cortex 2.0 (deployed industrial WAM), [Rhoda AI](ecosystem.md#rhoda-ai) DVA (inverse-dynamics WAM)

**Relevance to World Models**: Primary value is the compute normalization table — enables apples-to-apples infrastructure sizing between VLA and WAM training pipelines. The 7.4x gap means WAM adoption depends on open video backbones (Wan, Cosmos) eliminating the pretraining cost. The Fast-WAM representation-only finding, if validated, would collapse WAM inference costs to VLA levels, removing the remaining deployment objection. The three-axis taxonomy provides a structured framework for tracking the WAM landscape.

---

### World Models for Robotic Manipulation: A Survey [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2606.00113)

**Authors**: Fangyuan Wang, Ziyuan Wang, Guorui Pei, Mengshi Zhang, Canxi Liang, Jun Hu, Zhongxuan Li, Jinsong Wu, Ning Han, Zeqing Zhang, Jiaming Qi, Hongmin Wu, Shiyao Zhang, Pai Zheng, Jia Pan, David Navarro-Alarcon, Sichao Liu, Peng Zhou

**Date**: 2026-05

**Summary**: Comprehensive survey organizing world models for robotic manipulation into 5 representation families. Develops a functional taxonomy separating integrated prediction-action models from explicit predictive planners. Reviews 34 manipulation datasets and synthesizes evaluation protocols.

**Key Findings**:

- Defines world model as "action-conditioned predictive system" distinct from perception/policies/value functions; 5 representation families by predicted output type
- Distinguishes integrated prediction-action models from explicit predictive planners
- Maps world model roles across training stages (pretraining, post-training, inference adaptation)
- Identifies open challenges in contact modeling, hallucination control, action alignment, closed-loop benchmarking

**Relevance to World Models**: Most comprehensive manipulation-specific world model survey. The 5-family taxonomy and functional distinction (integrated vs explicit planners) provide a structured framework for comparing robot foundation model approaches (pi0 vs DreamZero vs GR00T). The 34-dataset review informs evaluation infrastructure decisions.

---

### Robots Need More Than VLAs & World Models [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2606.06556)

**Authors**: Elis Karcini, Faisal Mehrban, Quang Nguyen, Mac Schwager, Arash Ajoudani, Cesar Cadena, Jan Peters, Marco Hutter, Haitham Bou-Ammar

**Date**: 2026-06

**Summary**: Position paper arguing that generalist robot intelligence is not primarily a policy-scaling problem. Identifies four missing interface components — data interfaces for autolabelling, embodiment interfaces for cross-embodiment retargeting, world-model interfaces for physics-grounded 3D reasoning, and reward interfaces for task progress inference. Proposes a research agenda for robots to learn from unstructured behavioral data.

**Key Findings**:

- The bottleneck is converting unstructured behavioral data (human motion, internet video, simulation rollouts) into grounded robot supervision, not model scale
- Identifies 4 missing interface types: data, embodiment, world-model, reward
- Discusses World-Action Models (DreamZero, UVA) as emerging paradigm
- Notes 3DGS simulators enable zero-shot sim-to-real for navigation

**Relevance to World Models**: Critical counterpoint to the "scale solves everything" narrative in robot foundation models. The four-interface framework identifies concrete platform capabilities needed beyond model training — data autolabelling, embodiment retargeting, physics-grounded reasoning, reward inference. Directly informs building-block requirements.

---

## Sim-to-Real Transfer

*Domain adaptation, style transfer, sim-to-real pipelines*

### HyperSim: A Holistic Sim-To-Real Framework For Robust Robotic Manipulation [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2605.26638)

**Authors**: Junyi Dong, Haotian Luo, Ziwei Xu, Shengwei Bian, Heng Zhang, Sitong Mao, Jingyi Guo, Yang Xu, Wenhao Chen, Qiuyu Feng, Yao Mu, Ping Luo, Shunbo Zhou, Xiaodong Wu

**Date**: 2026-05

**Summary**: End-to-end sim-to-real framework spanning synthetic data generation through policy deployment. Three pillars: high-fidelity environment synthesis, adversarial trajectory generation, and sim-and-real co-training. Achieves 80% (ACT) and 95% (pi0) sim-to-real success rates across 400 real-world task executions, with 35% higher completion under physical perturbations for adversarially trained policies.

**Key Findings**:

- Three-pillar framework: high-fidelity environment synthesis + adversarial trajectory generation + sim-and-real co-training
- Achieves 80% (ACT) and 95% (pi0) sim-to-real success across 400 real-world trials
- Adversarial training yields 35% higher completion under physical perturbations
- Validates that co-training enforces domain-invariant representations bridging sim-real gap

**Relevance to World Models**: Demonstrates a production-viable sim-to-real pipeline achieving >90% success with pi0. The co-training approach (jointly training on sim + real data) is a concrete pattern for platform sim-to-real infrastructure. The adversarial trajectory generation is a form of automated curriculum — a capability the Training Infrastructure building block should support.

---

### Real-is-Sim: Bridging the Sim-to-Real Gap with a Dynamic Digital Twin for Real-World Robot Policy Evaluation [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2504.03597)

**Authors**: Jad Abou-Chakra, Lingfeng Sun, Krishan Rana, Brandon May, Karl Schmeckpeper, Niko Suenderhauf, Maria Vittoria Minniti, Laura Herlant

**Date**: 2025-04 (revised 2025-07)

**Summary**: Inverts the sim-to-real paradigm: instead of training in sim and transferring to real, builds a dynamic digital twin (powered by Embodied Gaussian simulator) that synchronizes with reality at 60Hz. Policies always act on the simulated robot; the physical robot follows simulated joint states. Virtual evaluations shown to be consistent with real-world results.

**Key Findings**:

- Digital twin powered by Embodied Gaussian simulator synchronizing at 60Hz
- Policies operate on simulated robot — real robot tracks simulated joint states, moving sim-to-real responsibility to twin synchronization
- Virtual evaluations consistent with real-world results on PushT manipulation task
- Real-world data can be augmented with virtual rollouts using multiple representation types

**Relevance to World Models**: Paradigm-shifting approach to sim-to-real: rather than bridging a gap, eliminates it by making simulation the ground truth that reality follows. The 60Hz synchronization requirement is a concrete infrastructure spec for the Digital Twin Runtime building block. Gaussian splatting as the simulation substrate connects to the Simulation Engines building block and complements traditional physics engines.

---

## Digital Twins & Simulation

*Digital twin architectures, simulation methods, synthetic data generation*

---

## Sensor Fusion & Perception

*Multi-modal perception, point cloud processing, spatial understanding*

---

## Evaluation & Benchmarking

*Benchmark validity, evaluation methodology, sim-to-real correlation*

### WorldOlympiad: Can Your World Model Survive a Triathlon? [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2606.11129)

**Authors**: Yuke Zhao, Wangbo Zhao, Weijie Wang, Zeyu Zhang, Dakai An, Akide Liu, Yinghao Yu, Jiasheng Tang, Fan Wang, Wei Wang, Bohan Zhuang

**Date**: 2026-06

**Summary**: Unified benchmark evaluating video-based world models across three dimensions: physical faithfulness (physics rule adherence), geometric consistency (3D structure preservation), and interaction fidelity (controllable interactions). Covers gaming, robotics, and real-world scenarios using 1,000 high-quality long videos.

**Key Findings**:

- Tripartite evaluation: physical (MLLM-as-judge for mechanics/thermal/material rules), geometry (Gaussian splatting reconstruction for 3D consistency), interaction (action-prompted rollout coherence)
- Reveals substantial gaps in SOTA models on physical reasoning, 3D consistency, long-horizon interaction
- Scalable interpretable evaluation exposing failure modes beyond generic video quality

**Relevance to World Models**: Addresses a critical gap in world model evaluation — most benchmarks assess visual quality rather than physical fidelity. The physics/geometry/interaction decomposition maps directly to the requirements of sim-to-real transfer (physics), digital twins (geometry), and robot manipulation (interaction). Complements the manipulation-specific benchmarks (RoboWM-Bench) with a broader evaluation framework.

---

### What Are We Actually Benchmarking in Robot Manipulation? [![arXiv](templates/icons/arxiv.svg)](https://arxiv.org/abs/2606.04233)

**Authors**: Tianchong Jiang, Xiangshan Tan, Samuel Wheeler, Luzhe Sun, Tewodros W. Ayalew, Matthew Walter

**Date**: 2026-06

**Summary**: Systematic audit of five prominent robot manipulation benchmarks (LIBERO, CALVIN, SimplerEnv, RoboCasa, RoboTwin 2.0) identifying four failure modes that undermine benchmark validity. Finds that the most commonly cited benchmarks (LIBERO, CALVIN) fail multiple diagnostics, while less-cited alternatives (RoboCasa, RoboTwin 2.0) fare better.

**Key Findings**:

- Four failure modes identified: shortcut solvability, lack of statistical significance, creeping overfitting, and data-source dependence
- On LIBERO: a 0.09B probe with no language encoder scores at or near reported SOTA; most reported gains between methods are not statistically significant
- SOTA models collapse from ~98% to 0-40% success under moderate perturbations (changed instructions, object poses, viewpoints)
- RoboCasa and RoboTwin 2.0 fail fewer diagnostics despite being less frequently cited in progress claims
- Releases diagnostic toolkit with reference implementations for community use

**Code**: [ripl.github.io/manipulation_benchmark_audit/](https://ripl.github.io/manipulation_benchmark_audit/)

**Relevance**: Directly impacts platform strategy for evaluation infrastructure — an eval pipeline relying solely on LIBERO or CALVIN gives false confidence. Supports the case for multi-benchmark evaluation (RoboVerse, LeRobot eval harness) and real-world validation (RoboArena) as complementary layers.

---

## Physical AI Deployment

*Edge inference, fleet management, production deployment of physical AI*

### NVIDIA Releases Major Collection of Open-Source Agent Tools and Skills for Physical AI [<img src="templates/icons/website.svg" alt="website" height="16">](https://nvidianews.nvidia.com/news/nvidia-releases-major-collection-of-open-source-agent-tools-and-skills-for-physical-ai)

**Authors/Presenters**: [NVIDIA](ecosystem.md#nvidia)

**Date**: 2026-05

**Summary**: Announces a collection of open-source agent-executable skills and tools that repackage NVIDIA's Physical AI platforms (Cosmos, Isaac Sim, Omniverse, Metropolis) as callable tools for AI coding/lifecycle agents. Establishes "Physical AI lifecycle agent" as a concrete product category — agents that autonomously orchestrate simulation, synthetic data generation, training, and deployment pipelines.

**Key Findings**:

- Skills wrap existing NVIDIA platforms as structured multi-step instructions for autonomous agents: neural reconstruction (synthetic data via scene reconstruction), video augmentation, synthetic defect image generation
- NemoClaw blueprint for building and deploying autonomous agents safely; OpenShell provides policy-based security and privacy governance
- Announced at GTC Taipei with manufacturing adoption: Pegatron reports 67% reduction in model training/deployment time using synthetic defect generation skill
- Industry partners span manufacturing (TSMC, Foxconn, Delta Electronics), autonomous vehicles (Li Auto, DeepRoute.ai), industrial software (Cadence, Dassault, Siemens, PTC), and robotics (1X, Agile Robots, Agility, Universal Robots)
- Available on GitHub (github.com/NVIDIA/skills) and via skills.sh; described as open source

**Relevance to World Models**: First concrete product instantiation of the "Physical AI lifecycle agent" category — agents that don't act in the physical world but orchestrate the lifecycle of models that do. Validates the actor/orchestrator distinction in the agent taxonomy: NVIDIA provides both actors (GR00T, Cosmos) and now orchestrator tools. The agentic framework layer is currently a whitespace opportunity — NVIDIA's tools are CUDA-locked and proprietary-ecosystem-bound; no dominant open-source alternative exists. This is the gap the "Agentic Framework" row in coverage tables is designed to surface.

---

### AI+HW 2035: Shaping the Next Decade [<img src="templates/icons/arxiv.svg" alt="arxiv" height="16">](https://arxiv.org/abs/2603.05225)

**Authors**: Deming Chen, Jason Cong, Azalia Mirhoseini, Christos Kozyrakis, Subhasish Mitra, Jinjun Xiong, Cliff Young, Anima Anandkumar, Michael Littman, Aron Kirschen, Sophia Shao, Serge Leef, Naresh Shanbhag, Dejan Milojicic, Michael Schulte, Gert Cauwenberghs, Jerry M. Chow, Tri Dao, Kailash Gopalakrishnan, Richard Ho, Hoshik Kim, Kunle Olukotun, David Z. Pan, Mark Ren, Dan Roth, Aarti Singh, Yizhou Sun, Yusu Wang, Yann LeCun, Ruchir Puri

**Date**: 2026-03

**Summary**: Vision paper from 30 leading researchers (including Yann LeCun, Tri Dao, Anima Anandkumar) presenting a 10-year roadmap for AI+hardware co-design. Argues the future of AI depends on "scaling intelligence per joule" rather than unbounded compute. Targets 1000x efficiency improvement for training and inference through cross-layer optimization from algorithms to silicon.

**Key Findings**:

- Redefines AI scaling around energy efficiency and system-level integration, not raw compute
- Targets 1000x efficiency improvement via cross-layer co-design
- Physical AI applications require end-to-end co-design across models, runtimes, and platforms as prerequisite
- Envisions platforms re-specializable through software without silicon redesign
- Recommends coordinated national initiatives and shared infrastructure

**Relevance to World Models**: Sets hardware context for physical AI platform decisions over the next decade. The "intelligence per joule" framing directly impacts edge deployment strategy — physical AI robots cannot scale with datacenter-class power budgets. The 1000x efficiency target implies current robot inference infrastructure (Jetson, etc.) is an early-stage compromise. The cross-layer co-design vision supports platform investments in hardware abstraction and runtime optimization.

---

## Recent Additions

*Last synthesized: 2026-07-01*

- World Models for Robotic Manipulation: A Survey (Robot Foundation Models)
- Robots Need More Than VLAs & World Models (Robot Foundation Models)
- WorldOlympiad: Can Your World Model Survive a Triathlon? (Evaluation & Benchmarking)
- HyperSim: Holistic Sim-to-Real Framework (Sim-to-Real Transfer)
- Real-is-Sim: Dynamic Digital Twin (Sim-to-Real Transfer)
- AI+HW 2035: Shaping the Next Decade (Physical AI Deployment)

---

**Note**: Organized by topic, not chronologically. Each entry follows the publication-entry template from `templates/publication-entry.md`.

**Videos**: Only includes videos from well-known researchers, institutions, or reputable channels. Types: conference talks, interviews, news coverage, technical tutorials.
