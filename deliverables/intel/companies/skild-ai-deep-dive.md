# Skild AI — Deep Dive Research

**Date**: 2026-06-23
**Last updated**: 2026-06-23
**Classification**: Internal analysis

Supporting research for the [Skild AI competitive profile](skild-ai.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, acquisition deep-dives, product architectures, governance risks, and technical dependency chains.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2023-05 | Founded by Deepak Pathak and Abhinav Gupta (CMU professors, on leave) |
| 2023 | $14.5M seed round co-led by Lightspeed and Sequoia Capital |
| 2024-07 | $300M Series A at $1.5B valuation. Led by Lightspeed, Coatue, SoftBank, Bezos Expeditions |
| 2025-H1 | Commercial deployment begins. Revenue grows from $0 to ~$30M in first months |
| 2025-03 | HPE partnership — AI-as-a-service training infrastructure |
| 2025-06 | LG CNS partnership (LG Technology Ventures investment) |
| 2025-07 | Skild Brain announced publicly — "omni-bodied" robotics foundation model |
| 2025 | Foxconn deployment — Skild Brain on Blackwell GPU assembly lines in Houston |
| 2025 | ABB Robotics and Universal Robots partnerships announced |
| 2026-01 | $1.4B Series C at $14B+ valuation. Led by SoftBank. NVentures, Macquarie, Bezos, Samsung, LG, Schneider |
| 2026-04 | Acquired Zebra Technologies' robotics automation business (Fetch Robotics + Symmetry) |
| 2026 | SoftBank acquiring ABB robotics ($5.38B, closing mid-to-late 2026) |

### Acquisitions — What Each Brought

#### Zebra Technologies Robotics Automation Business (2026)

- **Price**: Undisclosed (Zebra originally paid $290M for Fetch Robotics in 2021)
- **Technology**: Fetch autonomous mobile robots (AMRs) for warehouse logistics; Symmetry Fulfillment orchestration platform for multi-robot fleet coordination; integration with Zebra wearable devices
- **Integration**: Skild plans to deploy Skild Brain on Fetch AMRs, replacing task-specific programming with omni-bodied foundation model intelligence. Symmetry becomes the fleet orchestration layer for warehouse deployments
- **Significance**: Marks Skild's first move into hardware ownership. Gives direct access to warehouse customers and a fleet management platform. The "orchestrated warehouse" concept — coordinating robots and human workers through a single intelligence layer — is the go-to-market for logistics vertical. Zebra exited robotics after struggling with the RaaS business model

---

## 2. Product Architecture Details

### Skild Brain

| Aspect | Details |
| --- | --- |
| **Architecture** | Hierarchical control: (1) High-level VLA policy — processes camera feeds, language instructions, proprioception → outputs abstract actions ("walk to shelf, grasp box") at ~10 Hz. (2) Low-level motor controller — translates abstract actions into joint torques/voltages at kHz rates. Analogous to cerebrum/cerebellum split in biological systems |
| **Training pipeline** | Pre-training on trillions of synthetic episodes across 100,000+ simulated robot embodiments (Isaac Lab). Data augmentation via Cosmos Transfer. Post-training with customer-specific real-world data. Claims 1,000× more training data points than competing models |
| **Runtime dependencies** | NVIDIA GPUs for training (Isaac Lab, Omniverse, Cosmos). On-robot inference hardware unspecified but targets $4K-$15K systems. Cloud API for high-level policy offloading |
| **Extension model** | API-based model licensing. OEMs integrate Skild Brain via cloud API or on-device deployment. In-context learning enables adaptation without retraining |
| **Key limitations** | Deep NVIDIA training dependency. Unclear edge inference framework. Proprietary model — no open-source components. Real-world deployment data still limited vs simulation scale |

### Key Technical Claims

- **Omni-bodied generalization**: Single model controls humanoids, quadrupeds, tabletop arms, mobile manipulators without embodiment-specific training
- **In-context learning**: Robots improve from failed trials by prepending previous episodes as context — similar to few-shot learning in LLMs
- **Payload adaptation**: Adapts to 1.5× body weight payloads without retraining
- **Cost reduction**: 10× TCO reduction — deploys on $4K-$15K hardware vs $250K+ conventional systems
- **Robustness**: Handles limb loss, jammed wheels, increased payload without explicit failure handling

<!-- TODO: deep research needed — independent verification of these claims is limited -->

### Symmetry Fulfillment Platform

| Aspect | Details |
| --- | --- |
| **Architecture** | Fleet orchestration layer coordinating AMRs and human workers. Task assignment, path planning, conflict resolution |
| **Runtime dependencies** | Zebra infrastructure. Integration with Zebra wearable devices |
| **Extension model** | API for task injection. Coordination with existing WMS systems |
| **Key limitations** | Designed for Fetch AMR fleet — generalization to other OEM robots unclear |

<!-- TODO: deep research needed on Symmetry architecture and integration depth -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Skild Brain** | PyTorch (training). Isaac Lab (BSD-3) for simulation | Apache 2.0 / BSD-3 (foundations) | Entire model architecture, training data, hierarchical control system |
| **Training pipeline** | NVIDIA Isaac Lab, Omniverse (open data layer), Cosmos (open-weight) | Mixed — Isaac Lab BSD-3, Kit SDK proprietary | Data pipeline, training recipes, curriculum design |
| **Symmetry** | Unknown — likely proprietary | Proprietary | Fleet orchestration, task coordination, wearable integration |
| **Fetch AMRs** | ROS-based (original Fetch robots used ROS) | BSD (ROS 1) | Robot hardware, sensor integration, navigation stack |

### Pattern Analysis

Skild AI follows a **"proprietary model on open foundations"** pattern — the core value (Skild Brain model, training data, deployment pipeline) is entirely proprietary, while the underlying simulation and training infrastructure leverages NVIDIA's open and semi-open tools. This is the opposite of AMD's pattern (open infrastructure, no proprietary models) and similar to NVIDIA's pattern (proprietary models on open engines).

The critical dependency is on NVIDIA's simulation stack. If NVIDIA were to restrict Isaac Lab, Cosmos, or Omniverse access, Skild's training pipeline would be disrupted. However, NVentures' investment in Skild suggests alignment for now.

### Notable Dependencies

- **NVIDIA Isaac Lab**: Primary simulation environment for RL training across robot embodiments
- **NVIDIA Cosmos Transfer**: Data augmentation for environmental variation. Open-weight but NVIDIA-controlled
- **NVIDIA Omniverse**: Scene construction and rendering for synthetic data generation. Open data layer (OpenUSD) but proprietary Kit SDK
- **PyTorch**: Training framework — standard, no lock-in
- **NVIDIA GPUs (CUDA)**: Training compute — no evidence of ROCm/AMD support

---

## 4. Governance & Community Risk

<!-- Skild AI does not steward any OSS projects. They are consumers of open-source tools, not producers. -->
<!-- Governance risk is not applicable in the traditional sense. -->

Skild AI does not maintain or steward any significant open-source projects. Their governance risk profile is that of a consumer of open-source infrastructure, not a producer. The primary risk is vendor dependency on NVIDIA's simulation stack rather than community governance concerns.

---

## 5. Hardware Platform Details

<!-- Skild AI is primarily a software company. Hardware details relate to acquired Fetch AMRs
     and partner robot platforms. -->

### Fetch AMR Fleet (acquired from Zebra)

| Product | Type | Status |
| --- | --- | --- |
| Fetch Freight | AMR for material transport | Deployed in warehouses |
| Fetch Roller | AMR for pallet/cart transport | Deployed in warehouses |
| Fetch ForkliftAMR | Autonomous forklift | Deployed in warehouses |

<!-- TODO: deep research needed on current Fetch product line and hardware specs -->

### Partner Robot Platforms

| Partner | Robot Types | Integration Status |
| --- | --- | --- |
| ABB Robotics | Industrial arms, collaborative robots | Partnership announced, integration in progress |
| Universal Robots | UR3e/UR5e/UR10e collaborative arms | Partnership announced, integration in progress |
| Foxconn | Dual-arm manipulators | Deployed on Blackwell assembly lines |

### On-Robot Inference

Skild claims deployment on hardware costing $4K-$15K. The on-robot inference hardware and framework are not publicly documented. Given the NVIDIA relationship, likely NVIDIA Jetson or equivalent edge GPU, but this is unconfirmed.

<!-- TODO: deep research needed on edge inference hardware and framework -->

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **NVIDIA** | — | NVentures investor (Series A + C). Sim infra provider | Deep — training pipeline depends on Isaac Lab, Cosmos, Omniverse |
| **Foxconn** | Global electronics mfg | Blackwell GPU assembly in Houston | Dual-arm manipulator deployment on production lines |
| **ABB Robotics** | 500K+ installed robots | Partnership to embed Skild Brain | API-level integration into ABB robot portfolio |
| **Universal Robots** | 100K+ deployed cobots | Partnership to integrate Skild Brain | API-level integration into UR collaborative robots |
| **SoftBank** | — | Series C lead ($1.4B). Acquiring ABB robotics ($5.38B) | Strategic — could unify Skild + ABB under SoftBank |
| **HPE** | — | AI-as-a-service training infra via STN | European data center for training/inference |
| **Samsung** | — | Strategic investor (Series C) | Access to Korean industrial/consumer markets |
| **LG** | — | LG CNS partnership, LG Technology Ventures investor | Korean market access, potential LG robot integration |
| **Schneider Electric** | — | Strategic investor (Series C) | Industrial automation, energy management |

### Developer Ecosystem

Skild AI does not have a public developer ecosystem comparable to NVIDIA's. The Skild Brain is accessed via API by OEM partners, not by a broad developer community. The company's developer engagement is primarily through its OEM partnerships and academic connections (CMU).

### Investor Network

The investor composition is strategically significant:

- **SoftBank**: Lead Series C investor, acquiring ABB robotics. Could create a vertically integrated SoftBank robotics empire (Skild brain + ABB hardware + SoftBank distribution)
- **NVentures**: Aligns Skild with NVIDIA ecosystem. NVIDIA facilitates OEM partnerships (ABB, UR via Foxconn)
- **Bezos Expeditions**: Amazon warehouse robotics connection. Amazon also participated in Series A
- **Samsung + LG**: Korean chaebol access. Korea deploys 60%+ of world's industrial robots
- **Schneider Electric**: Industrial automation customer base

---

## 7. Detailed Competitive Analysis

### vs Physical Intelligence (π0 / π0.5)

| Dimension | Skild AI | Physical Intelligence |
| --- | --- | --- |
| **Valuation** | $14B (Jan 2026) | $5.6B (2025) |
| **Total funding** | $1.83B | ~$570M+ |
| **Model approach** | Omni-bodied hierarchical VLA. Simulation-heavy training (trillions of episodes) | VLA foundation model (π0, π0.5). More real-world data emphasis (104 homes, 68 tasks) |
| **Form factors** | Humanoids, quadrupeds, arms, AMRs — any embodiment | 7 robot platforms — focused on manipulation |
| **Open-source strategy** | Fully proprietary model | PI-1 pursuing open-source base model — could commoditize foundation layer |
| **Hardware ownership** | Yes (Fetch AMRs via Zebra acquisition) | No — pure software |
| **OEM partnerships** | ABB, Universal Robots, Foxconn | Less public OEM network |
| **Training infra** | NVIDIA Isaac Lab + Cosmos (deep dependency) | Less publicly documented |
| **Revenue** | ~$30M (2025) | Not publicly disclosed |

### vs NVIDIA GR00T N1

| Dimension | Skild AI | NVIDIA GR00T N1 |
| --- | --- | --- |
| **Business model** | Independent software company, brain-as-a-service | Part of $3T+ hardware company, bundled with ecosystem |
| **Hardware neutrality** | Claims hardware-agnostic (but NVIDIA training dependency) | Tied to Jetson edge, CUDA GPUs for training |
| **Simulation** | Consumer of NVIDIA sim tools | Creator of Isaac Sim, Newton, Cosmos — owns the simulation stack |
| **Model architecture** | Hierarchical VLA (high-level + low-level) | Dual-system: VLM (10 Hz) + DiT actor (120 Hz) |
| **Foundation model basis** | Proprietary from scratch | Built from community models (Qwen3-VL, SmolLM2, SigLIP-2) |
| **OEM partnerships** | ABB, UR (OEM-neutral) | ABB, FANUC, KUKA, YASKAWA (deeper but NVIDIA-ecosystem-locked) |

### The SoftBank Factor

SoftBank's simultaneous investment in Skild AI ($1.4B Series C lead) and acquisition of ABB's robotics business ($5.38B) creates a potential vertically integrated robotics stack:

- **Brain**: Skild Brain (omni-bodied foundation model)
- **Body**: ABB industrial robots (500K+ installed base)
- **Distribution**: SoftBank's global enterprise network

If realized, this would be the largest non-NVIDIA vertically integrated Physical AI play. The risk for Red Hat: SoftBank could bring its own platform preferences (not necessarily Red Hat) to the combined entity.

---

## Sources

- [Skild AI — Building the General-Purpose Robotic Brain](https://www.skild.ai/blogs/building-the-general-purpose-robotic-brain)
- [Skild AI — The Case for an Omni-Bodied Robot Brain](https://www.skild.ai/blogs/omni-bodied)
- [Skild AI — Series C Announcement ($1.4B)](https://www.skild.ai/blogs/series-c)
- [Skild AI — Zebra Acquisition](https://www.skild.ai/blogs/skild-zebra)
- [Skild AI Series A ($300M)](https://www.skild.ai/blogs/announcing-our-300m-series-a)
- [NVIDIA Case Study — Skild AI](https://www.nvidia.com/en-us/case-studies/skild-ai/)
- [Crunchbase — Skild AI $1.4B Funding](https://news.crunchbase.com/venture/robotics-startup-skild-ai-triples-valuation/)
- [TechCrunch — Skild AI $14B Valuation](https://techcrunch.com/2026/01/14/robotic-software-maker-skild-ai-hits-14b-valuation/)
- [Bloomberg — Skild AI SoftBank-Led Round](https://www.bloomberg.com/news/articles/2026-01-14/robotics-startup-skild-valued-above-14-billion-after-softbank-led-funding-round)
- [Skild AI + Foxconn + NVIDIA Factory Deployment](https://finance.yahoo.com/news/skild-ai-nvidia-deploy-robot-203231111.html)
- [IndexBox — Skild AI + Foxconn, ABB, Universal Robots](https://www.indexbox.io/blog/skild-ai-deploys-general-purpose-ai-in-foxconn-abb-and-universal-robots-for-us-manufacturing/)
- [HPE — Skild AI Training Partnership](https://www.hpe.com/us/en/newsroom/press-release/2025/03/skild-ai-accelerates-development-of-human-like-robot-brain-with-ai-solutions-from-hewlett-packard-enterprise.html)
- [Zebra Technologies — Robotics Business Sale](https://www.zebra.com/us/en/about-zebra/newsroom/press-releases/2026/skild-ai-acquires-zebra-technologies--robotics-automation-busine.html)
- [Contrary Research — Skild AI Business Breakdown](https://research.contrary.com/company/skild-ai)
- [Sacra — Skild AI Analysis](https://sacra.com/c/skild-ai/)
- [Sequoia — Partnering with Skild](https://sequoiacap.com/article/partnering-with-skild/)
- [Lightspeed — Skild Bringing GenAI to Real World](https://lsvp.com/stories/skild-is-bringing-generative-ai-to-the-real-world/)
