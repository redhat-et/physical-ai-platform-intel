# Figure AI — Deep Dive Research

**Date**: 2026-06-23
**Last updated**: 2026-06-23
**Classification**: Internal analysis — not for public repo

Supporting research for the [Figure AI competitive profile](figure-ai.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: Helix architecture details, manufacturing strategy, deployment learnings, and competitive dynamics.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2022-01 | Founded by Brett Adcock (serial entrepreneur — Archer Aviation, Vettery) |
| 2023-05 | $70M Series A; Brett Adcock invested $100M seed personally |
| 2024-01 | BMW Spartanburg deployment begins (Figure 02) |
| 2024-02 | $675M Series B at $2.6B valuation. Investors: Microsoft, OpenAI Startup Fund, Jeff Bezos, NVIDIA, Intel, Samsung, Qualcomm |
| 2024-08 | Figure 02 unveiled — 35 DOF, 5-fingered hands, 25 kg payload |
| 2024-12 | First revenue generated (31 months from incorporation) |
| 2025-02 | Ends OpenAI collaboration; announces Helix VLA built fully in-house |
| 2025-03 | BotQ manufacturing facility unveiled — 12K units/year capacity |
| 2025-09 | Series C exceeds $1B at $39B valuation. Lead: Parkway Venture Capital + Brookfield |
| 2025-10 | Figure 03 unveiled — $20K target price, TIME Best Invention 2025 |
| 2025-11 | BMW Spartanburg pilot completes: 11 months, 30K+ vehicles, 90K+ parts. Federal whistleblower safety lawsuit filed |
| 2026-01 | Helix 02 released — full-body autonomy |
| 2026-04 | BotQ producing 1 robot every 90 minutes (240/month) |
| 2026-06 | 40 Figure 03 units deployed at BMW Spartanburg; Leipzig expansion announced for summer 2026 |

### Acquisitions — What Each Brought

No acquisitions to date. Figure has built its technology stack entirely in-house, recruiting heavily from Boston Dynamics, Tesla, Google DeepMind, and Apple.

---

## 2. Product Architecture Details

### Helix 02 VLA Model

| Aspect | Details |
| --- | --- |
| **Architecture** | Three-tier neural architecture: **System 2** (7B-parameter VLA, 7-10 Hz — high-level reasoning, task decomposition); **System 1** (200 Hz reactive policy — translates S2 plans into joint-level motor commands); **System 0** (1 kHz — balance, contact physics, replaces 100K+ lines of C++ with learned motion prior trained on 1,000+ hrs human motion data) |
| **Inputs** | Head cameras (6-camera system, 2x frame rate, 1/4 latency, 60% wider FOV vs F02), palm cameras, fingertip tactile sensors (3g force resolution), full-body proprioception |
| **Outputs** | Complete joint-level control of all 44 DOF — legs, torso, head, arms, wrists, individual fingers |
| **Runtime dependencies** | Dual embedded NVIDIA GPUs; Ubuntu Linux; fully onboard — no cloud dependency for inference |
| **Key limitations** | Proprietary and closed; no public model weights or architecture details beyond marketing materials; 7B parameter ceiling limits reasoning compared to cloud-scale VLMs |

### Figure 03 Hardware

| Aspect | Details |
| --- | --- |
| **Architecture** | 168 cm, 60 kg, 44 DOF total. 16-DOF hands per arm with palm cameras and fingertip tactile sensors. Dual embedded GPUs. Soft textile covering for safe human interaction |
| **Battery** | 2.3 kWh swappable battery, 5-hour runtime, 2 kW wireless charging via foot-mounted coils |
| **Connectivity** | 10 Gbps mmWave wireless for fleet data upload |
| **Compute** | Dual embedded NVIDIA GPUs running Ubuntu Linux |
| **Safety** | Multi-density foam at pinch points; soft goods covering; action limits, speed limits, emergency stop in Helix runtime |
| **vs Figure 02** | 9% less mass, significantly less volume; redesigned forearms/wrists (reliability learnings from BMW); textile exterior vs exposed metal |

### BotQ Manufacturing

| Aspect | Details |
| --- | --- |
| **Architecture** | Purpose-built humanoid manufacturing facility in San Jose, CA. In-house production of robots, batteries, actuators, and control systems |
| **Capacity** | 12K units/year, scaling to 100K. April 2026: 1 robot every 90 minutes (240/month) |
| **MES** | In-house Manufacturing Execution System with full traceability |
| **Supply chain** | Designed to scale to 3M actuators over 4 years |
| **Key limitations** | Single facility; consumer $20K price target requires manufacturing efficiencies not yet proven at scale |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Helix 02** | None disclosed | Proprietary | Entire VLA model (S0/S1/S2 architecture) |
| **Edge OS** | Ubuntu Linux | GPL/Canonical | Custom robotics configuration |
| **Training** | PyTorch (likely) | BSD | VLA training pipeline, data collection |
| **Simulation** | NVIDIA Cosmos/Isaac (partner) | N/A | Integration into training loop |

### Pattern Analysis

Figure's OSS strategy is **"maximally proprietary."** Unlike companies that build on open foundations and add proprietary layers (NVIDIA's pattern), Figure owns the entire AI stack end-to-end with no disclosed OSS dependencies beyond the OS and likely PyTorch for training. The decision to end the OpenAI partnership and build Helix in-house reinforces this thesis.

The strategic rationale is explicit — CEO Adcock argues that "owning the full stack, from CAD files to the AI models running on the robot" is the durable competitive position. This is the Tesla approach applied to humanoid robotics.

The risk for Figure is that this vertical integration becomes a bottleneck at scale. The robotics industry's history (ROS 2's emergence, OpenAI's commoditization of language models) suggests that platform layers eventually standardize. The question is when.

### Notable Dependencies

- **NVIDIA GPUs**: Dual embedded GPUs in Figure 03 create hardware dependency. No evidence of Intel or AMD GPU support
- **NVIDIA Cosmos**: Used for synthetic data generation — a training-time dependency on NVIDIA's ecosystem
- **Ubuntu Linux**: The edge OS choice. Canonical's Ubuntu IoT/Core is the incumbent for robotics, but lacks enterprise fleet management at the scale Figure targets (100K units)

---

## 4. Governance & Community Risk

Not applicable — Figure AI does not steward any OSS projects. The company is fully proprietary.

---

## 5. Hardware Platform Details

### Current Hardware

#### Figure 03

| Spec | Detail |
| --- | --- |
| **Height** | 168 cm (5'6") |
| **Weight** | 60 kg (132 lbs) |
| **DOF** | 44 total |
| **Hands** | 16 DOF per hand, palm cameras, fingertip tactile sensors (3g resolution) |
| **Payload** | 20 kg while walking |
| **Speed** | 1.2 m/s walking |
| **Battery** | 2.3 kWh swappable, 5-hour runtime |
| **Charging** | 2 kW wireless via foot coils |
| **Connectivity** | 10 Gbps mmWave |
| **Compute** | Dual embedded NVIDIA GPUs |
| **Cameras** | 6-camera head system + 2 palm cameras |
| **Safety** | Soft textile covering, multi-density foam, action/speed limits |

#### Figure 02 (Legacy)

| Spec | Detail |
| --- | --- |
| **DOF** | 35 total |
| **Hands** | 16 DOF, 5-fingered |
| **Payload** | 25 kg |
| **Cabling** | Integrated into limbs |
| **Status** | Being replaced by Figure 03; 11-month BMW deployment complete |

### Roadmap

<!-- TODO: deep research needed -->

| Product | Timeline | Key Changes |
| --- | --- | --- |
| **Figure 03 consumer** | 2026-2027 | $20K target price; home alpha testing announced |
| **BotQ scale-up** | 2026-2027 | 12K → 100K units/year capacity ramp |
| **Next-gen Helix** | Unknown | Likely increased S2 parameter count; expanded multi-robot coordination |

### Pricing

| Model | Price | Notes |
| --- | --- | --- |
| **Figure 02** | ~$130K (estimated) | Commercial lease/enterprise deployment contracts |
| **Figure 03** | $20K (target) | Consumer price target; requires BotQ manufacturing efficiencies at scale |
| **RaaS** | TBD | Robot-as-a-Service subscription model under development |

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **BMW** | 40 Figure 03 units | Phased expansion through 2027; Leipzig (Germany) pilot summer 2026 | Production line integration (sheet metal handling, welding prep) |
| **UPS** | Unknown | Reported second major customer | Logistics/package handling |
| **NVIDIA** | N/A | Technology + investment | Cosmos for synthetic data; NVIDIA GPUs for edge compute |

### Developer Ecosystem

Figure has no public developer ecosystem. The company is closed-platform — no SDK, no API, no third-party model support. Helix is proprietary and tightly coupled to Figure hardware (palm cameras, tactile sensors).

This is a strategic choice: at current scale (hundreds of units), a developer ecosystem provides no value. At 100K units, this will likely change — the same dynamic that forced Apple to open iOS to third-party apps.

---

## 7. Detailed Competitive Analysis

### vs Tesla Optimus

| Dimension | Figure AI | Tesla Optimus |
| --- | --- | --- |
| **Robot generations** | 3 (F01→F02→F03) in 3 years | 2 (Optimus Gen 1→Gen 2) in 3 years |
| **Production deployment** | BMW Spartanburg: 30K+ vehicles, 11 months | Tesla factories only: internal deployment, scale unknown |
| **Manufacturing** | BotQ: 12K/year capacity, scaling to 100K | Tesla Gigafactory: manufacturing scale advantage but shared with vehicles |
| **AI model** | Helix (proprietary VLA, System 0/1/2) | FSD-derived vision + learned control; Dojo training compute |
| **Hands** | 16 DOF, tactile sensing, palm cameras | Simpler grippers; improving but less dexterous |
| **Funding** | $1.9B raised, $39B valuation | Tesla corporate funds; no separate fundraising needed |
| **Risk** | $39B valuation on negligible revenue | Optimus deprioritized vs Tesla's core auto/energy business |

### vs Agility Robotics (Digit)

| Dimension | Figure AI | Agility Robotics |
| --- | --- | --- |
| **Form factor** | Humanoid (full upper body + legs) | Purpose-built for logistics (lighter, simpler upper body) |
| **Hands** | 16 DOF, tactile sensing | Simple grippers (sufficient for box handling) |
| **Fleet management** | No disclosed solution | Arc fleet orchestration platform |
| **Customers** | BMW, reportedly UPS | Amazon (primary), GXO Logistics |
| **Manufacturing** | BotQ (12K/year) | RoboFab (10K/year capacity) |
| **AI model** | Helix 02 (full-body VLA) | More traditional perception + planning stack |

### vs Humanoid Market Broadly

<!-- TODO: deep research needed -->

Goldman Sachs projects the entire humanoid robot market at $38B by 2035. Figure's current $39B valuation already exceeds the projected total addressable market nine years out. This creates significant valuation risk regardless of execution quality.

The competitive landscape includes 30+ humanoid companies (1X, Sanctuary AI, Apptronik, Unitree, UBTECH, etc.). Differentiation is currently on hardware capability (hands, locomotion, sensing), but will shift to AI model quality and manufacturing cost as the market matures.

---

## Sources

- [Figure AI Series C — $1B+ at $39B valuation](https://www.figure.ai/news/series-c)
- [Figure AI Wikipedia](https://en.wikipedia.org/wiki/Figure_AI)
- [Helix VLA announcement](https://www.figure.ai/news/helix)
- [Helix 02 — Full-Body Autonomy](https://www.figure.ai/news/helix-02)
- [Introducing Figure 03](https://www.figure.ai/news/introducing-figure-03)
- [F.02 at BMW — 30,000 Cars](https://www.figure.ai/news/production-at-bmw)
- [BMW Leipzig humanoid expansion](https://www.press.bmwgroup.com/global/article/detail/T0455864EN/bmw-group-to-deploy-humanoid-robots-in-production-in-germany-for-the-first-time)
- [Helix accelerating real-world logistics](https://www.figure.ai/news/helix-logistics)
- [Brett Adcock ends OpenAI partnership](https://x.com/adcock_brett/status/1886860098980733197)
- [Figure AI — Forge Growth Analysis](https://forgeglobal.com/insights/figure-ai-robotics-growth-2026/)
- [Figure AI — TSG Invest Valuation Analysis](https://tsginvest.com/figure-ai/)
- [Figure AI — Contrary Research Business Breakdown](https://research.contrary.com/company/figure)
- [BMW-Figure reality check — Fortune](https://fortune.com/2025/04/06/figure-ai-bmw-humanoid-robot-partnership-details-reality-exaggeration/)
- [NVIDIA Physical AI partners — Cosmos, GR00T ecosystem](https://nvidianews.nvidia.com/news/nvidia-releases-new-physical-ai-models-as-global-partners-unveil-next-generation-robots)
- [Figure 03 specifications — Aparobot](https://www.aparobot.com/robots/figure-03)
