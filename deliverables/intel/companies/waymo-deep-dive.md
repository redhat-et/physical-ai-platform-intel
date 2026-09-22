# Waymo — Deep Dive Research

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

Supporting research for the [Waymo competitive profile](waymo.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: corporate timeline, EMMA architecture, simulation research, sensor evolution, and partnership details.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2009 | Google Self-Driving Car Project founded by Sebastian Thrun |
| 2016-12 | Spun out from Alphabet X as Waymo LLC |
| 2020 | Waymo One launches fully driverless rides in Phoenix (no safety driver) |
| 2020 | SurfelGAN published at CVPR — neural sensor data synthesis for simulation |
| 2021 | Partnership with Geely/Zeekr for purpose-built robotaxi |
| 2024-08 | 6th-generation Waymo Driver announced — 42% sensor reduction |
| 2024-10 | EMMA (End-to-end Multimodal Model) research published |
| 2024-10 | Hyundai IONIQ 5 multi-year partnership announced |
| 2024-10 | Series C: $5.6B at $45B valuation |
| 2025-04 | Toyota partnership — exploring Waymo Driver for personally owned vehicles |
| 2025-05 | Magna manufacturing facility announced in Mesa, Arizona |
| 2026-01 | Waymo One launches in Miami |
| 2026-02 | Series D: $16B at $126B valuation (Alphabet ~$13B, Sequoia, DST, Dragoneer) |
| 2026-02 | 6th-gen Driver begins fully autonomous operations |
| 2026-02 | Expansion to Dallas, Houston, San Antonio, Orlando |
| 2026-07 | San Diego, Las Vegas, Tampa, Denver launch |
| 2026-08 | Zeekr "Ojai" begins rider service in SF, LA, Phoenix |

### Acquisitions — What Each Brought

No significant recent acquisitions identified. Waymo has grown organically from Google's self-driving car project, with technology developed in-house rather than via M&A. The Alphabet relationship provides access to Google DeepMind research (Gemini foundation models) without formal acquisition.

<!-- TODO: deep research needed — historical acquisitions (Latent Logic 2019, others) -->

---

## 2. Product Architecture Details

### Waymo Driver (6th Generation)

| Aspect | Details |
| --- | --- |
| **Architecture** | Multi-sensor fusion: 13 cameras (custom 17MP imagers) + 4 LiDARs (custom chips/optics, long-range + short-range) + 6 radars (in-house algorithms for rain/snow) + audio receivers (EARs for emergency vehicles). Sensor data fused through custom silicon → perception → prediction → planning → vehicle control. |
| **Runtime dependencies** | Custom on-vehicle compute (proprietary silicon). No cloud dependency for real-time driving — operates independently. Remote Assistance (70 agents globally) for edge cases, not real-time control. |
| **Extension model** | Fully closed. No public API, SDK, or third-party integration. Vehicle integration via OEM partnerships (Zeekr, Hyundai). |
| **Key limitations** | Operates only in pre-mapped urban areas (geofenced). Expanding to freeways but not arbitrary unmapped terrain. Custom hardware — cannot retrofit arbitrary vehicles (requires OEM partnership + Magna assembly). |

### EMMA (End-to-End Multimodal Model)

| Aspect | Details |
| --- | --- |
| **Architecture** | Built on Google Gemini VLM. Maps raw camera sensor data → driving outputs (planner trajectories, 3D objects, road graph). All non-sensor inputs/outputs represented as natural language text — navigation instructions, ego status, trajectories, 3D locations all tokenized. Joint training across planning + perception + road graph shows positive task transfer. |
| **Runtime dependencies** | Google Gemini (proprietary). TPU compute for training/inference. Camera-only input (no LiDAR/radar in current version — future work to add). |
| **Extension model** | Research paper published (arXiv 2410.23262) but model not released. OpenEMMA is an independent open reproduction using GPT-4/LLaVA. |
| **Key limitations** | Camera-only (no LiDAR/radar), processes small number of frames, computationally expensive. No long-term memory. Research-stage — not yet deployed in production Waymo Driver. |

<!-- TODO: deep research needed — relationship between EMMA research and production Waymo Driver stack, whether EMMA components are being integrated into 6th-gen system -->

### Waymax Simulator

| Aspect | Details |
| --- | --- |
| **Architecture** | JAX-based closed-loop simulator. Uses Waymo Open Dataset scenarios as initialization. Supports agent behavior simulation, scenario generation, and policy evaluation. |
| **Runtime dependencies** | JAX, Python. Runs on CPU/GPU/TPU. |
| **Extension model** | Open-source (Apache 2.0). GitHub: waymo-research. 1,094 stars. Designed for research use — not production simulation. |
| **Key limitations** | Research-grade — not Waymo's production simulation stack. Limited to scenarios available in Waymo Open Dataset. |

### SurfelGAN

| Aspect | Details |
| --- | --- |
| **Architecture** | Texture-mapped surfel scene reconstruction from LiDAR + camera data → GAN-based novel view synthesis for realistic camera image generation at new viewpoints. Enables "what-if" scenario simulation by moving vehicles/objects and re-rendering sensor data. |
| **Runtime dependencies** | GPU compute for neural rendering. |
| **Key limitations** | CVPR 2020 paper — foundational research, likely superseded by newer internal simulation approaches (neural radiance fields, 3D Gaussian splatting, etc.). |

<!-- TODO: deep research needed — current production simulation stack (SimulationCity?), newer neural rendering approaches, scale of simulation (billions of miles simulated?) -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Waymo Driver** | None disclosed | N/A | Full autonomous driving stack: custom sensors, custom silicon, perception, prediction, planning |
| **EMMA** | Google Gemini (proprietary) | N/A | End-to-end driving model; natural language trajectory representation |
| **Waymax** | Open-source | Apache 2.0 | JAX-based AV simulator; Waymo-maintained |
| **Waymo Open Dataset** | Open data | Custom research license | Perception + motion prediction benchmarks |

### Pattern Analysis

Waymo follows a "open research, closed product" pattern — publishing datasets, research papers, and research-grade tools while keeping the production stack entirely proprietary and vertically integrated on Alphabet infrastructure. This approach attracts research talent, advances the field (which Waymo benefits from as the leader), and builds academic credibility — without exposing competitive advantages.

The Waymo Open Dataset has become a standard benchmark in AV research. Waymax provides a research-grade simulator. But the production Waymo Driver, production simulation stack, and fleet management systems are fully closed.

### Notable Dependencies

- **Google Gemini**: EMMA is built on Gemini — deep dependency on Alphabet's foundation model research. If Gemini capabilities advance, EMMA benefits directly.
- **TPU compute**: Training and large-scale simulation likely run on Google TPUs — infrastructure dependency that reinforces Alphabet lock-in.
- **Custom silicon**: On-vehicle compute uses proprietary chips — no disclosed dependency on NVIDIA, Qualcomm, or other commercial silicon.

---

## 4. Governance & Community Risk

### Waymo Open Dataset Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | Single-vendor (Waymo/Alphabet) |
| **Core maintainer employment** | All Waymo employees |
| **CLA/DCO** | Google CLA for code contributions |
| **Commit diversity** | Single-vendor — Waymo only |
| **Abandonment risk** | Low — strategic value to Waymo for talent pipeline and research positioning. 2026 challenges paused but leaderboards remain active. |

---

## 5. Hardware Platform Details

### 6th-Generation Sensor Suite

| Component | Spec |
| --- | --- |
| **Cameras** | 13 cameras (down from 29), custom 17MP imagers — generation ahead in resolution, dynamic range, low-light sensitivity |
| **LiDAR** | 4 units (down from 5) — custom chips and California-designed optics. Long-range + short-range (centimeter precision) |
| **Radar** | 6 units — next-gen in-house algorithms for rain/snow |
| **Audio** | External Audio Receivers (EARs) — siren detection and localization |
| **Compute** | Custom silicon (proprietary) |
| **System cost** | <$20,000 per unit (>50% reduction from 5th gen) |

### Vehicle Platforms

| Vehicle | Status | Notes |
| --- | --- | --- |
| **Zeekr "Ojai"** | Active (Aug 2026) | Purpose-built robotaxi. At risk — US connected-car restrictions on Chinese vehicles. |
| **Hyundai IONIQ 5** | Testing, deliveries Q4 2026 | 50K unit order. Built at Georgia Metaplant. 800V architecture for fast charging. Magna upfit in Arizona. |
| **Jaguar I-PACE** | Legacy (5th gen) | Being phased out as 6th-gen fleet scales. |

### Manufacturing

Magna-operated facility in Mesa, Arizona. Vehicles arrive from OEM, upfitted with rooftop "tiara" (LiDAR, radar, cameras, microphones) plus additional sensors. Target: tens of thousands of units/year at full capacity.

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Alphabet** | Parent company | ~$13B anchor in $16B Series D. Provides Gemini, Cloud, TPU. | Deep — infrastructure, R&D, capital |
| **Hyundai** | 50K unit order | Multi-year deal. IONIQ 5 built at Georgia Metaplant. | OEM — autonomous-ready mods (redundant hardware, power doors) |
| **Geely / Zeekr** | Active fleet | Purpose-built "Ojai" robotaxi. Swedish design. | Deep — purpose-built vehicle. Risk: US restrictions |
| **Magna** | Manufacturing partner | Mesa, Arizona assembly plant | Vehicle upfit — sensor integration |
| **Uber** | Distribution | Waymo AVs on Uber network in Austin, Atlanta | App-level integration |
| **Toyota** | Exploration | Apr 2025 — Waymo Driver for personally owned vehicles | Early-stage — targeting consumer market |

### Developer Ecosystem

Waymo Open Dataset community: annual challenges (6 rounds through 2025), active leaderboards, research papers. Waymax used by academic researchers. No commercial developer ecosystem — Waymo does not sell its technology as a platform for third-party developers.

---

## 7. Detailed Competitive Analysis

### vs Tesla FSD

| Dimension | Waymo | Tesla |
| --- | --- | --- |
| **Sensor approach** | Multi-sensor: camera + LiDAR + radar + audio | Camera-only (vision-only since 2021) |
| **Autonomy level** | Fully driverless, no safety driver, commercial service | Supervised FSD; unsupervised launching 2026 but most rides still have safety driver |
| **Data collection fleet** | ~4,000 purpose-built vehicles | 6M+ consumer vehicles collecting data |
| **Per-mile cost** | $1.36–1.43 | ~$0.81 |
| **Wait time** | 5.7 min average | 15+ min average |
| **Geographic reach** | 14 US cities + London/Tokyo planned | Expanding (Austin first, 2026) |
| **Foundation model** | EMMA (Gemini-based) | FSD v13 (vision transformer) |
| **Manufacturing** | OEM partners + Magna upfit | Vertically integrated (own factory) |

### vs Cruise (GM)

| Dimension | Waymo | Cruise |
| --- | --- | --- |
| **Commercial status** | Live in 14 cities, 500K rides/week | Rebuilding after Oct 2023 incident; not yet relaunched at scale |
| **Valuation** | $126B | Significantly lower post-incident |
| **Fleet size** | ~4,000 vehicles | Reduced fleet |
| **Technology generation** | 6th gen (Feb 2026) | Rebuilding technology stack |

<!-- TODO: deep research needed — Cruise's 2026 relaunch status, competitive comparison updates -->

---

## Sources

- [Waymo 6th-gen Driver launch](https://waymo.com/blog/2026/02/ro-on-6th-gen-waymo-driver/)
- [6th-gen Driver announcement](https://waymo.com/blog/2024/08/meet-the-6th-generation-waymo-driver/)
- [Waymo $16B funding round](https://waymo.com/blog/2026/02/waymo-raises-usd16-billion-investment-round/)
- [EMMA research paper — arXiv](https://arxiv.org/abs/2410.23262)
- [Waymo EMMA blog](https://waymo.com/blog/2024/10/introducing-emma/)
- [SurfelGAN — Waymo Research](https://waymo.com/research/surfelgan-synthesizing-realistic-sensor-data-for-autonomous-driving/)
- [Waymo Open Dataset](https://waymo.com/open/)
- [Waymax — GitHub](https://github.com/waymo-research/waymo-open-dataset)
- [Waymo One expansion — Dallas, Houston, San Antonio, Orlando](https://waymo.com/blog/2026/02/dallas-houston-san-antonio-orlando/)
- [Hyundai IONIQ 5 partnership — CNBC](https://www.cnbc.com/2024/10/04/hyundai-waymo-strategic-partnership.html)
- [Hyundai 50K unit order — Electrek](https://electrek.co/2026/02/11/hyundai-supply-waymo-50000-ioniq-5-robotaxis/)
- [Magna IONIQ 5 upfit](https://www.telemetryagency.com/post/april-30-2026-magna-to-upfit-hyundai-ioniq-5-for-waymo)
- [Toyota partnership — Waymo Driver for personal vehicles](https://waymo.com/blog/2025/05/scaling-our-fleet-through-us-manufacturing/)
- [Waymo revenue — Sacra](https://sacra.com/c/waymo/)
- [Waymo targets 1M rides/week — Forbes](https://www.forbes.com/sites/alanohnsman/2025/12/10/waymo-targets-1-million-robotaxi-rides-a-week/)
- [Waymo valuation analysis](https://valueaddvc.com/blog/waymo-valuation-2026-126b-16b-round-and-how-it-compares-to-tesla-robotaxi)
- [6th-gen 42% fewer sensors — Automotive World](https://www.automotiveworld.com/news/waymos-6th-gen-driver-goes-live-with-42-fewer-sensors/)
- [Waymo employee data — Revelio Labs](https://www.reveliolabs.com/companies/waymo/employees)
