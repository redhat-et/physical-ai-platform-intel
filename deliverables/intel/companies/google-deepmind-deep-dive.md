# Google DeepMind — Deep Dive Research

**Date**: 2026-06-22
**Last updated**: 2026-06-22
**Classification**: Internal analysis

Supporting research for the [Google DeepMind competitive profile](google-deepmind.md). Covers the Gemini Robotics model family architecture, RT-1/2/X lineage, MuJoCo stewardship, and humanoid partnership details.

For Intrinsic's industrial platform (Flowstate, IVM, IntrinsicOS, ROS/Gazebo governance), see [Intrinsic deep-dive](intrinsic-deep-dive.md).

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2010 | DeepMind founded (London) by Demis Hassabis, Shane Legg, Mustafa Suleyman |
| 2014 | Acquired by Google for ~$500M |
| 2016 | AlphaGo defeats Lee Sedol |
| 2021 | Acquires MuJoCo from Emo Todorov; open-sources it (Apache 2.0) |
| 2022 | RT-1 released — first large-scale robot learning on Everyday Robots fleet |
| 2023-01 | Everyday Robots (X) shut down; team + data absorbed into DeepMind |
| 2023-04 | Google Brain merges into DeepMind → "Google DeepMind" |
| 2023-07 | RT-2 — first VLA (fine-tuned PaLM-E/PaLI-X on robot data) |
| 2023-10 | RT-X / Open X-Embodiment — pooled data from 33 labs, 22 robot types |
| 2025-03 | Gemini Robotics announced — production VLA successor to RT line |
| 2025-06 | Gemini Robotics On-Device — <10ms edge VLA |
| 2025-09 | Gemini Robotics-ER 1.5 — first broadly available Gemini Robotics model |
| 2025-09 | RoboBallet — multi-robot coordination (joint with Intrinsic, Science Robotics) |
| 2026-01 | Newton 1.0 co-founded (Linux Foundation) with NVIDIA and Disney Research |
| 2026-03 | Agile Robots partnership — Gemini Robotics on Agile ONE humanoid |
| 2026-04 | Gemini Robotics-ER 1.6 — agentic capabilities, AI Studio access |
| 2026-05 | Gemini Robotics 1.5 — transparent reasoning, most capable VLA |

### Key Figures in Physical AI

| Person | Role | Significance |
| --- | --- | --- |
| **Demis Hassabis** | CEO, Google DeepMind | Sets overall AI research direction |
| **Vincent Vanhoucke** | VP Research | Leads robotics research; absorbed Everyday Robots team |
| **Yuval Tassa** | MuJoCo team lead | Primary maintainer of MuJoCo; hired with acquisition |
| **Keerthana Gopalakrishnan** | Research Scientist | Gemini Robotics lead author |
| **Ted Xiao** | Research Scientist | RT-2 and cross-embodiment research |

### Acquisitions Relevant to Physical AI

#### MuJoCo (2021)

- **Creator**: Emo Todorov (University of Washington)
- **Technology**: High-performance physics engine optimized for contact-rich manipulation and locomotion
- **Integration**: Open-sourced under Apache 2.0. Team (including Yuval Tassa) joined DeepMind. MuJoCo became the de facto physics engine for RL research
- **Significance**: Gave DeepMind control of a critical research infrastructure component. Community benefit: free access replaced expensive licenses

#### Everyday Robots (2023 — absorbed, not acquired)

- Separate Alphabet X moonshot for general-purpose learning robots
- Shut down Jan 2023; team absorbed into DeepMind under Vincent Vanhoucke
- Brought: hardware fleet, 130K demonstrations, 700+ tasks — fed directly into RT-1 and RT-2 training
- Both teams had collaborated ~7 years before merger

#### Vicarious (2022 — partial)

- CTO Dileep George + research team → Google DeepMind for AGI research
- CEO Scott Phoenix → Intrinsic as CCO
- See [Intrinsic deep-dive](intrinsic-deep-dive.md) for Vicarious details

---

## 2. Product Architecture Details

### Gemini Robotics — Evolution from RT-1/2/X

| Model | Date | Architecture | Key Advance |
| --- | --- | --- | --- |
| **RT-1** | 2022 | EfficientNet + FiLM conditioning + TokenLearner | First large-scale robot learning. 97% success on 700+ tasks. Trained on 130K Everyday Robots demos |
| **RT-2** | Jul 2023 | Fine-tuned PaLM-E / PaLI-X | First VLA — language model directly outputs robot actions. 62% novel vs RT-1's 32% |
| **RT-X** | Oct 2023 | RT-1/RT-2 trained on Open X-Embodiment | Cross-embodiment: pooled data from 33 labs, 22 robot types. Positive transfer demonstrated |
| **Gemini Robotics** | Mar 2025 | Built on Gemini 2.0 | Production VLA. Cross-embodiment (ALOHA, Franka, Apollo). 2× generality vs conventional VLAs |
| **Gemini Robotics 1.5** | 2026 | Extended Gemini 2.0+ | "Thinks before acting"; transparent reasoning; agentic capabilities; most capable VLA |

### Current Model Family

| Model | Type | Access | Key Capability |
| --- | --- | --- | --- |
| **Gemini Robotics** | VLA | Trusted Tester | Direct robot control; dexterous manipulation (origami, Ziploc bags) |
| **Gemini Robotics-ER** | Embodied Reasoning VLM | Gemini API (preview) | 6D pose, trajectory/grasp prediction, spatial reasoning |
| **Gemini Robotics On-Device** | Edge VLA | Safari SDK (Trusted Tester) | <10ms inference; offline; fine-tunable with 50-100 demos |
| **Gemini Robotics-ER 1.5** | ER upgrade | Gemini API | First broadly available; can call tools including VLA models |
| **Gemini Robotics 1.5** | Advanced VLA | Trusted Tester | Transparent reasoning; agentic; most capable |
| **Gemini Robotics-ER 1.6** | ER upgrade | Gemini API + AI Studio | Improved spatial reasoning, multi-view understanding |

All proprietary — API access only. No open-weight robotics VLA from Google.

### Open-Weight Alternatives from Google

| Model | License | Parameters | Robotics? |
| --- | --- | --- | --- |
| **Gemma 4** | Apache 2.0 | 1B, 4B, 12B, 27B | No — general-purpose |
| **Gemini Nano** | Apache 2.0 | 7B, 20B | No — on-device general-purpose |

### Safari SDK

- `google-deepmind/gemini-robotics-sdk` on GitHub
- Comprehensive agent framework for building interactive robotics agents
- **flywheel CLI** for model training, serving, data management, artifact download
- Supports all Gemini Robotics models (On-Device from SDK v2.4.1)

### MuJoCo — Architecture & Stewardship

| Aspect | Details |
| --- | --- |
| **Physics** | Contact-rich rigid body dynamics optimized for manipulation and locomotion |
| **GPU acceleration** | MJX (JAX-based) provides GPU batched simulation. MuJoCo Warp provides NVIDIA Warp-based GPU acceleration |
| **Scene format** | MJCF (open XML) + URDF import |
| **Stars** | 18K+ |
| **License** | Apache 2.0 (since 2022; previously commercial) |
| **Differentiable** | Yes (via MJX/JAX) |
| **Multi-GPU portability** | MJX via JAX supports CUDA, ROCm, TPU, Metal |

MuJoCo Warp is the primary backend of Newton (Linux Foundation). Newton adds multi-physics coupling, USD scene format, and multi-solver architecture. See [MuJoCo project report](../projects/mujoco.md) and [Newton project report](../projects/newton.md).

### Genie 3

| Aspect | Details |
| --- | --- |
| **Architecture** | Auto-regressive frame prediction (same mechanism as LLMs, applied to video frames). Predicts next frame based on previous trajectory, modeling causality |
| **Resolution / FPS** | 720p at 24 fps, real-time interaction |
| **Memory** | Spatial memory window of ~1 minute. Retains object locations and environmental structure when out of view |
| **Physics** | Learned physics dynamics informed by Veo research — water dynamics, surface friction, aerodynamic effects |
| **Input** | Text prompt → interactive 3D world. Also accepts image input |
| **Availability** | Released Jan 2026 via "Project Genie" to Google AI Ultra subscribers (US, 18+) |
| **Lineage** | Genie 1 (2024, arXiv:2402.15391) → Genie 2 (short 3D clips, 10-20s, not real-time) → Genie 3 (real-time, extended memory) |
| **Deployments** | Waymo adopted fine-tuned Genie 3 ("Waymo World Model") for AV edge-case simulation (Feb 2026) |
| **Paper** | No formal Genie 3 paper published. Genie 1 paper: arXiv:2402.15391 |
| **Limitations** | Cannot simulate real-world locations accurately; text generation limited; few minutes max interaction; compute-intensive |

### Open X-Embodiment Dataset

- Created by collaboration of 33 research labs
- 22 robot types (manipulators, mobile robots, humanoids)
- Foundation for cross-embodiment research
- Used in RT-X training — demonstrated positive transfer across robot types

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add |
| --- | --- | --- | --- |
| **Gemini Robotics** | Gemini 2.0 (proprietary) | Proprietary | Cross-embodiment VLA capabilities |
| **MuJoCo** | — (DeepMind is the steward) | Apache 2.0 | DeepMind maintains and develops the engine itself |
| **MuJoCo Warp** | NVIDIA Warp | Apache 2.0 | GPU acceleration of MuJoCo on NVIDIA GPUs |
| **Newton** | MuJoCo Warp + NVIDIA Warp | Apache 2.0 (LF) | DeepMind contributed MuJoCo Warp as primary backend |
| **Safari SDK** | Python ecosystem | Apache 2.0 | Agent framework + flywheel CLI |
| **Gemma 4** | — | Apache 2.0 | Open-weight models (not robotics-specific) |

### Pattern Analysis

DeepMind's OSS strategy is selective: open the infrastructure (MuJoCo, Open X-Embodiment, Gemma), keep the frontier models proprietary (Gemini Robotics). This creates a research ecosystem that feeds back into DeepMind's proprietary model training — researchers worldwide use MuJoCo and X-Embodiment data, publish results, and those results inform DeepMind's next model generation.

The pattern benefits DeepMind disproportionately: open infrastructure creates a research commons that DeepMind can harvest, while proprietary models maintain competitive advantage.

---

## 4. Governance & Community Risk

### MuJoCo Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | None — DeepMind single-vendor stewardship |
| **Core maintainer employment** | All employed by Google DeepMind (Yuval Tassa, team) |
| **CLA/DCO** | Google CLA required |
| **Commit diversity** | Single-vendor — DeepMind dominates |
| **Abandonment risk** | Low (central to DeepMind's research) but CLA and single-vendor governance limit contribution depth |

See [MuJoCo project report](../projects/mujoco.md) for detailed CHAOSS metrics.

### Newton Co-Stewardship

DeepMind is a founding contributor to Newton (Linux Foundation, Apache 2.0) alongside NVIDIA and Disney Research. DeepMind contributed MuJoCo Warp as the primary backend. Newton has 2-2-2 TSC governance structure but ~90% NVIDIA commits in practice. DeepMind's role is upstream physics engine provider rather than active Newton developer.

---

## 5. Hardware Platform Details

DeepMind has no hardware products. All training runs on Google Cloud TPU pods. Edge inference via Gemini On-Device runs on partner hardware.

---

## 6. Partnership & Ecosystem Details

### Humanoid Robot Partners

| Partner | Product | Installed Base | Integration |
| --- | --- | --- | --- |
| **Agile Robots** | Agile ONE humanoid | 20K+ deployed systems | Gemini Robotics fine-tuning; $270M+ raised; series production 2026 |
| **Apptronik** | Apollo humanoid | Pre-production | Gemini Robotics for humanoid control |
| **Boston Dynamics** | Atlas (humanoid) + Spot (quadruped) | ~1K+ Spot | Gemini for Atlas intelligence |

### Intrinsic Integration

DeepMind provides foundation models that Intrinsic integrates into Flowstate. The relationship is internal to Google — DeepMind builds the intelligence, Intrinsic builds the platform. Joint publications (RoboBallet, Science Robotics 2025) demonstrate deepening collaboration.

### Research Ecosystem

- Open X-Embodiment: collaboration with 33 research labs globally
- MuJoCo: de facto standard for RL research (used by virtually every robotics lab)
- Publication record: RT-1, RT-2, RT-X papers are among the most cited in robot learning

---

## 7. Detailed Competitive Analysis

### vs NVIDIA (foundation models)

| Dimension | Google DeepMind | NVIDIA |
| --- | --- | --- |
| **VLA models** | Gemini Robotics (most capable, proprietary) | GR00T N1 (open-weight, assembled from community models) |
| **World models** | Genie 3 (interactive 3D environments) | Cosmos (video/world data generation) |
| **Physics engines** | MuJoCo (de facto RL standard) | Newton (wraps MuJoCo Warp), PhysX (Omniverse) |
| **Model access** | API-only (Gemini API, Vertex AI) | Open-weight (N1), NVAIE license (NIM) |
| **Training infra** | TPU (Google Cloud only) | NVIDIA GPUs (datacenter + edge) |
| **Strategy** | Proprietary frontier → open trailing models | Open-weight models + proprietary packaging |

### vs Meta FAIR

| Dimension | Google DeepMind | Meta FAIR |
| --- | --- | --- |
| **Robotics VLAs** | Gemini Robotics (production, cross-embodiment) | No production robotics VLA (research only: OK-Robot) |
| **Simulation** | MuJoCo (physics), Newton (co-steward) | Habitat-Lab (navigation-focused) |
| **Open models** | Gemma 4 (not robotics) | Llama 4 (not robotics) |
| **Research approach** | End-to-end VLAs | Embodied agents, navigation-first |

### vs OpenAI

| Dimension | Google DeepMind | OpenAI |
| --- | --- | --- |
| **Robotics** | Gemini Robotics (production VLAs, robot OEM partnerships) | No announced robotics VLA (historically exited robotics in 2021) |
| **General models** | Gemini (competitive with GPT-4o) | GPT-4o, o1 (general-purpose frontier) |
| **Potential** | Established robotics research pipeline (RT-1 → Gemini Robotics) | Could re-enter with general model capabilities |

---

## Sources

- [Gemini Robotics announcement](https://deepmind.google/discover/blog/gemini-robotics/)
- [Gemini Robotics-ER 1.5](https://deepmind.google/discover/blog/gemini-robotics-er/)
- [Gemini Robotics 1.5 announcement](https://blog.google/technology/google-deepmind/gemini-robotics-15/)
- [Gemini Robotics On-Device](https://deepmind.google/discover/blog/gemini-robotics-on-device/)
- [Safari SDK GitHub](https://github.com/google-deepmind/gemini-robotics-sdk)
- [MuJoCo GitHub](https://github.com/google-deepmind/mujoco)
- [MuJoCo Warp GitHub](https://github.com/google-deepmind/mujoco_warp)
- [Newton GitHub](https://github.com/newton-physics/newton)
- [RT-1 paper](https://arxiv.org/abs/2212.06817)
- [RT-2 paper](https://arxiv.org/abs/2307.15818)
- [Open X-Embodiment paper](https://arxiv.org/abs/2310.08864)
- [RoboBallet paper (Science Robotics)](https://www.science.org/doi/10.1126/scirobotics.adt4462)
- [Agile Robots partnership](https://deepmind.google/discover/blog/agile-robots/)
- [Gemma 4](https://blog.google/technology/developers/gemma-4/)
- [Genie 3 blog](https://deepmind.google/blog/genie-3-a-new-frontier-for-world-models/)
- [Genie 3 model page](https://deepmind.google/models/genie/)
- [Genie 1 paper (arXiv:2402.15391)](https://arxiv.org/abs/2402.15391)
- [Genie 3 Wikipedia](https://en.wikipedia.org/wiki/Genie_(world_model))
