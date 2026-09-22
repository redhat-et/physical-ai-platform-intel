# Tesla — Deep Dive Research

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

Supporting research for the [Tesla competitive profile](tesla.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: custom silicon roadmap, FSD architecture evolution, Optimus deployment reality, Dojo timeline, and competitive dynamics.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2016 | Tesla begins custom AI chip development (Jim Keller leads HW3 design) |
| 2019-04 | Autonomy Day — reveals HW3 custom FSD chip (144 TOPS), replaces NVIDIA Drive PX |
| 2021-08 | AI Day — reveals Dojo D1 training chip, announces Optimus humanoid concept |
| 2022-09 | AI Day 2 — first Optimus prototype walks on stage |
| 2023-10 | HW4 (AI4) begins shipping in new vehicles (Samsung 7nm, dual-SoC) |
| 2024-01 | FSD v12 — first end-to-end neural network (replaces 300K lines of C++) |
| 2024-10 | Cybercab (Robotaxi) unveiled at "We, Robot" event |
| 2025-02 | FSD v13 launches — 5-6x improvement in miles between interventions |
| 2025-06 | $16.5B AI6 chip deal with Samsung |
| 2025-08 | Dojo project shut down — Musk calls Dojo 2 "evolutionary dead end" |
| 2025-Q3 | Cortex supercluster at Giga Texas reaches 67K H100-equivalent GPUs |
| 2026-01 | Dojo 3 project restarted with AI5-based architecture |
| 2026-01 | Robotaxi launches unsupervised service in Austin |
| 2026-04 | FSD v14.3.2 — unified model across robotaxi and customer vehicles |
| 2026-04 | AI5 chip tape-out completed |
| 2026-05 | Last Model S/X rolls off Fremont line; Optimus line conversion begins |
| 2026-06 | Robotaxi expands to full Austin metro (4K+ sq mi); 1M+ unsupervised miles |
| 2026 (H2) | Robotaxi expanding to Dallas, Houston, Miami, Orlando, Tampa |
| 2026 (late) | Optimus production start targeted at Fremont (low volume) |
| 2026-12 | AI6 tape-out targeted |
| 2027 | Giga Texas second Optimus factory; AI5 volume production |

### Acquisitions — What Each Brought

Tesla has not made acquisitions for its Physical AI stack. All technology is developed internally — custom silicon, custom models, custom simulation. Key talent acquisitions include:

- **Jim Keller** (2016-2018): Designed HW3 FSD chip before departing
- **Andrej Karpathy** (2017-2022): Led Autopilot AI as Sr. Director; built the vision-only, neural-network-first approach
- **Ashok Elluswamy** (current VP AI): Continues FSD and Optimus AI development

---

## 2. Product Architecture Details

### FSD v14 — End-to-End Neural Network

| Aspect | Details |
| --- | --- |
| **Architecture** | Single end-to-end neural network: camera frames in → driving controls out. Video Foundation Model (one encoder, many heads — evolved from HydraNet). Video Language Model perception generates possible futures. RL-trained with reward functions instead of hand-written rules. |
| **Runtime dependencies** | HW4 (AI4) minimum — dual custom SoC, 32GB total RAM. 8 cameras (no LiDAR, no radar since 2022). OTA-updated. |
| **Extension model** | Completely closed. No API, no SDK, no third-party integration. Tesla vehicles only. |
| **Key limitations** | HW4-only for full v14 (older HW3 gets distilled v14 Lite). Camera-only perception limits adverse weather performance vs LiDAR-equipped competitors. No external validation framework — Tesla self-reports safety metrics. |

### FSD Architectural Evolution

| Version | Year | Architecture | Key Change |
| --- | --- | --- | --- |
| v11 | 2023 | Multi-task heads + planner | Unified highway + city driving stack |
| v12 | 2024 | End-to-end neural network | Replaced 300K lines of C++ rules |
| v13 | 2025 | Improved E2E | 5-6x miles between interventions; 10x parameters vs v12 |
| v14 | 2026 | Unified E2E + Video Foundation Model | Single model for supervised + unsupervised; RL training; robotaxi-grade |
| v15 | 2026/2027 | 10B parameter model | "Active reasoning" for complex scenarios; runs on HW4 via distillation |

### Optimus Humanoid Robot

| Aspect | Details |
| --- | --- |
| **Architecture** | VLA (Vision-Language-Action) foundation model. Camera-based perception (shared with FSD architecture). End-to-end imitation learning from human demonstrations + RL in simulation. 22-DOF hands, 50 actuators total. |
| **Runtime dependencies** | Currently runs on HW4-class compute; AI5 targeted as primary platform. 10,000 unique parts. |
| **Extension model** | Completely closed. Internal Tesla use only (no external sales as of Sep 2026). |
| **Key limitations** | ~1K units deployed, primarily for data collection not productive work (Musk Q4 2025). Fremont production line not yet operational. Consumer availability 2028-2029 realistic. Every major timeline has been missed since 2022 announcement. |

### Training Data Flywheel

| Source | Scale | Use |
| --- | --- | --- |
| **Vehicle fleet** | Millions of cars with 8 cameras each | FSD training data — real-world driving scenarios, edge cases |
| **Factory Optimus** | ~1K units generating robot-perspective video | Optimus imitation learning — manipulation, navigation |
| **Neural World Simulator** | 1 demo → 10K synthetic variations | Synthetic data augmentation for both FSD and Optimus |
| **FSD subscriptions** | 1.28M active (Q1 2026) | Data flywheel funding mechanism ($99-199/mo) |

<!-- TODO: deep research needed — Neural World Simulator technical architecture, specific ML frameworks used, Cortex cluster software stack details -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **FSD** | Likely PyTorch (training); custom runtime (inference) | N/A | End-to-end driving model, custom inference compiler |
| **Optimus** | Likely PyTorch (training); no ROS | N/A | VLA foundation model, custom motor control |
| **Cortex** | NVIDIA CUDA + Linux | Apache 2.0 / GPL | Custom orchestration, scheduling, data pipeline |
| **AI4/AI5/AI6** | None | N/A | Full custom silicon + compiler + runtime |
| **Neural World Sim** | None identified | N/A | Proprietary video-generation models |

### Pattern Analysis

Tesla is the most proprietary Physical AI company. Where others (NVIDIA, Google) build ecosystems and release selective open-source, Tesla shares nothing. The only external dependencies are:

1. **NVIDIA GPUs** — for training (Cortex cluster uses H100/H200), but not for inference (custom AI4/AI5)
2. **Linux kernel** — underlying OS for vehicles, robots, and training clusters
3. **TSMC / Samsung** — chip fabrication (moving toward Terafab for partial sovereignty)

Tesla's approach is the polar opposite of Red Hat's platform thesis. It works because Tesla controls the full stack from factory to customer — a luxury no other company in the ecosystem has.

### Notable Dependencies

- **NVIDIA training dependency**: Cortex runs on NVIDIA GPUs. Tesla's Dojo/AI6 strategy aims to eliminate this, but as of Sep 2026, NVIDIA remains essential for training. The Dojo 3 restart suggests this dependency will persist through at least 2027.
- **TSMC/Samsung fab dependency**: AI5 dual-sourced from TSMC and Samsung; AI6 Samsung-exclusive. Terafab (Intel 14A) targets partial fab sovereignty but won't be operational for years.

---

## 4. Governance & Community Risk

Not applicable — Tesla has no open-source projects, no community governance, no external developer ecosystem for Physical AI.

---

## 5. Hardware Platform Details

### Custom Silicon Roadmap

| Chip | Generation | Process | TOPS | Memory | Power | Status |
| --- | --- | --- | --- | --- | --- | --- |
| **HW3 (FSD 1.0)** | 1st gen | Samsung 14nm | 144 | 8GB | ~100W | In older vehicles; receives distilled FSD v14 Lite |
| **AI4 (HW4)** | 2nd gen | Samsung 7nm | 100-150 (dual) | 32GB (dual) | ~160W | Current production; AI4.1 upgrade to 64GB |
| **AI5 (HW5)** | 3rd gen | TSMC 2/3nm + Samsung | 2,000-2,500 | 144-192GB | 250-800W | Tape-out Apr 2026; volume production late 2026/2027 |
| **AI6** | 4th gen | Samsung | TBD | TBD | TBD | $16.5B deal; tape-out target Dec 2026 |

### Terafab

- $20-25B joint semiconductor fab: Tesla + SpaceX + xAI
- Intel 14A process technology
- Austin, Texas
- Timeline: construction phase; production years away
- Significance: sovereign chip manufacturing — reduces TSMC/Samsung dependency

### Cortex Supercluster

- Location: Giga Texas
- Scale: 67K H100-equivalent GPUs (Q2 2025); expanded with 16K H200s
- Use: FSD and Optimus model training
- Buffalo, NY: $500M additional supercomputer facility planned (post-Dojo, NVIDIA-based)

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Samsung** | Chip fab | $16.5B AI6 contract; AI4 manufacturing | Silicon fabrication |
| **TSMC** | Chip fab | AI5 dual-source (2/3nm) | Silicon fabrication |
| **Intel** | Chip fab | Terafab 14A process | Future sovereign fab |
| **NVIDIA** | Training GPUs | H100/H200 for Cortex | Training compute (inference is custom) |

### Developer Ecosystem

None. Tesla has no developer program, no SDK, no API, no partner program for Physical AI. This is deliberate — vertical integration means no ecosystem is needed or wanted.

---

## 7. Detailed Competitive Analysis

### vs NVIDIA (Physical AI Platform)

| Dimension | Tesla | NVIDIA |
| --- | --- | --- |
| **Strategy** | Vertical integration — build everything, share nothing | Horizontal platform — sell to everyone |
| **Silicon** | Custom inference (AI4/5/6); NVIDIA GPUs for training | GPU monopoly across training + inference |
| **Models** | Proprietary FSD + Optimus VLA | GR00T (humanoid), Cosmos (world model) — available to ecosystem |
| **Simulation** | Neural World Simulator (proprietary) | Isaac Sim + Cosmos (platform products) |
| **Data** | Millions of vehicles as data collectors — unique moat | Synthetic data generation via Omniverse |
| **Ecosystem** | Zero — internal only | Thousands of partners, developers, researchers |
| **Revenue from AI** | Embedded in vehicle sales + FSD subscriptions | Direct GPU/software/cloud sales |

### vs Waymo (Autonomous Driving)

| Dimension | Tesla | Waymo |
| --- | --- | --- |
| **Sensing** | Camera-only (8 cameras) | LiDAR + cameras + radar |
| **Fleet scale** | Millions of vehicles collecting data | ~1,000 robotaxi vehicles |
| **Unsupervised miles** | 1M+ (Austin, expanding to 6 cities) | Millions (SF, Phoenix, LA, Austin) |
| **Business model** | Vehicle sales + FSD subscription + robotaxi rides | Ride-hailing only |
| **Compute** | Custom silicon (AI4/AI5) | NVIDIA Drive / custom ASIC |
| **Regulatory** | Expanding market-by-market | Established in more markets, longer track record |

### vs Humanoid Competitors (Figure AI, Agility, Unitree)

| Dimension | Tesla Optimus | Figure AI | Agility Digit | Unitree |
| --- | --- | --- | --- | --- |
| **Units deployed** | ~1K (own factories) | <100 (BMW pilot) | ~100 (Amazon pilot) | ~5,500 shipped (2025) |
| **Factory testbed** | Own Gigafactories | Partner factories | Partner warehouses | Customer sites |
| **Foundation model** | Proprietary VLA | Helix (proprietary) | Proprietary | Open-source models |
| **Custom silicon** | AI5/AI6 | None (NVIDIA) | None | None |
| **Target price** | $20-30K (long-term) | Not disclosed | Not disclosed | ~$16K (G1) |
| **Consumer timeline** | 2028-2029 (analyst est.) | Not announced | Not planned | Shipping now |

---

## Sources

- [Tesla AI & Robotics page](https://www.tesla.com/AI)
- [Tesla Dojo timeline — TechCrunch](https://techcrunch.com/2025/09/02/teslas-dojo-a-timeline/)
- [Dojo shutdown — TechCrunch](https://techcrunch.com/2025/09/02/tesla-dojo-the-rise-and-fall-of-elon-musks-ai-supercomputer/)
- [Tesla FSD architecture evolution — ThinkAutonomous](https://www.thinkautonomous.ai/blog/tesla-end-to-end-deep-learning/)
- [FSD v14.3.2 details — NotATeslaApp](https://www.notateslaapp.com/news/4033/tesla-fsd-v1432-unifies-fsd-models-across-robotaxi-and-customer-vehicles-improves-summon-and-adds-new-menu)
- [Tesla AI5 chip — Black Scarab](https://www.blackscarab.ai/insights/tesla-ai5-hw5-guide)
- [AI5 inference vs NVIDIA — Notebookcheck](https://www.notebookcheck.net/Tesla-AI5-FSD-computer-to-run-inference-10x-cheaper-than-Nvidia-AI-chips.1145221.0.html)
- [Optimus factory deployment status — OptimUSK](https://optimusk.blog/blog/tesla-optimus-factory-deployment/)
- [Optimus AI training — OptimUSK](https://optimusk.blog/blog/ai-training-for-tesla-optimus/)
- [Tesla unified world simulator — Humanoids Daily](https://www.humanoidsdaily.com/news/tesla-ai-chief-details-unified-world-simulator-for-fsd-and-optimus)
- [Tesla 10M Optimus target — The Robot Report](https://www.therobotreport.com/from-evs-to-robotics-tesla-targets-10m-optimus-units-with-new-texas-plant/)
- [Humanoid robots deployed 2026 — Technology.org](https://www.technology.org/2026/07/18/humanoid-robots-in-2026-what-is-actually-deployed/)
- [Tesla revenue — Stock Analysis](https://stockanalysis.com/stocks/tsla/revenue/)
- [Tesla Optimus Gen 3 — Electrek](https://electrek.co/2026/04/22/tesla-optimus-production-fremont-model-sx-line/)
