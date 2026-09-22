# SteerAI — Deep Dive Research

**Date**: 2026-09-21
**Last updated**: 2026-09-21
**Classification**: Internal analysis — not for public repo

Supporting research for the [SteerAI competitive profile](steerai.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: corporate timeline, product architecture, partnership details, and competitive analysis.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2024-11 | VentureOne (ATRC commercialization arm) launches SteerAI as second venture after AI71 |
| 2025-02 | Partnership with Milrem Robotics signed at IDEX 2025 — 20 THeMIS UGVs for UAE Land Forces |
| 2026-01 | EDGE Group, TII, Micropolis, SteerAI collaboration on Autonomous Logistics Platform (ALP) announced at UMEX/SimTEX 2026 |
| 2026-01 | xRift autonomous ATV unveiled at UMEX 2026, supported by UAE Smart and Autonomous Systems Council (SASC) |
| 2026-06 | Elistair partnership — tethered drone integration on xRift for aerial surveillance and comms |
| 2026 (end) | xRift production units expected deployment-ready |

### Acquisitions — What Each Brought

No acquisitions. SteerAI is a venture-built entity, not an acquirer. Technology originates from TII research rather than M&A.

### Organizational Structure

SteerAI sits within the ATRC ecosystem:

- **ATRC** (Advanced Technology Research Council) — Abu Dhabi government body overseeing technology research
- **TII** (Technology Innovation Institute) — ATRC's applied research arm; developed CoreX algorithms, contributes TACTICAai analytics
- **VentureOne** — ATRC's commercialization arm; built SteerAI as a venture (second after AI71, before QuantumGate)
- **SteerAI** — Commercial entity deploying TII autonomy research into defense and industrial markets

---

## 2. Product Architecture Details

### CoreX Autonomous Driving System

| Aspect | Details |
| --- | --- |
| **Architecture** | Modular hardware kit + AI software stack. Pipeline: perception (cameras + LiDAR) → localization (GPS-free, real-time SLAM implied) → planning (route/waypoint following) → decision-making (obstacle avoidance, terrain adaptation). Vehicle-agnostic — mounts on existing platforms via retrofit. |
| **Runtime dependencies** | On-vehicle compute (hardware not disclosed — no NVIDIA/Qualcomm branding visible). Camera and LiDAR sensors (vendors not disclosed). No cloud dependency for real-time autonomy — operates in GNSS-denied, potentially comms-denied environments. |
| **Extension model** | Closed/proprietary. No public SDK, API, or plugin system disclosed. Integration via partnership agreements (Milrem, Micropolis). |
| **Key limitations** | Proprietary and opaque — no disclosed compute platform, sensor vendors, or AI framework details. Off-road only; no on-road capability. Speed limited to 50 km/h (xRift spec). |

<!-- TODO: deep research needed — specific compute hardware, AI/ML frameworks (PyTorch/TensorFlow?), sensor fusion architecture details -->

### CoreConnect Fleet Management System

| Aspect | Details |
| --- | --- |
| **Architecture** | Platform-agnostic C2 (command and control) layer. Capabilities: mission planning, real-time fleet deployment, monitoring, analytics. Supports ground, aerial, and marine autonomous platforms. Integrates with TII's TACTICAai for cross-domain situational awareness. |
| **Runtime dependencies** | Server-side deployment (cloud or on-premises — not specified). Connects to autonomous platforms via unspecified communication links. |
| **Extension model** | Described as "platform-agnostic" — works with any autonomous robot. Integration demonstrated with Milrem THeMIS, Micropolis M01/M02, Elistair drones. No public API documented. |
| **Key limitations** | No disclosed enterprise integration patterns (REST API, ROS 2 bridge, etc.). eCommerce mentioned as target vertical but no known deployments outside defense/industrial. |

<!-- TODO: deep research needed — CoreConnect software stack, deployment model, communication protocols, TACTICAai integration architecture -->

### xRift Autonomous ATV

| Aspect | Details |
| --- | --- |
| **Architecture** | Purpose-built driverless platform with modular utility deck. 225 HP engine, 50 km/h top speed, 47L fuel tank, 1,350 kg weight, 4.2m × 1.9m × 1.4m. 500 kg payload capacity across multiple configurations. |
| **Runtime dependencies** | CoreX autonomous driving system (integral). Fuel-powered (not electric). |
| **Extension model** | Modular payload deck supports multiple mission configurations: logistics, electronic warfare, emergency response. Elistair tethered drone integration demonstrated. |
| **Key limitations** | Fuel-powered (vs electric trend in UGV market). Speed limited vs on-road AVs. Production units not yet deployed (expected end-2026). |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **CoreX** | None identified | N/A | Full autonomy stack: perception, localization, planning, decision-making |
| **CoreConnect** | None identified | N/A | Fleet management, mission planning, cross-platform orchestration |
| **xRift** | N/A (hardware) | N/A | Vehicle design, payload integration |

### Pattern Analysis

SteerAI is fully proprietary with no disclosed OSS dependencies. This is consistent with its origin as a sovereign UAE technology venture — TII develops foundational research, VentureOne commercializes via purpose-built ventures, and IP stays within the ATRC ecosystem. The Falcon LLM (released by TII under Apache 2.0) shows TII can do open-source when strategically motivated, but CoreX's defense application makes open release unlikely.

No evidence of ROS 2, PyTorch, or other standard robotics/ML framework usage in public materials, though these are likely present internally given the sensor fusion and planning requirements.

### Notable Dependencies

- **TII technology dependency**: CoreX algorithms originated at TII. SteerAI's competitive position depends on continued TII research pipeline.
- **TACTICAai**: TII's situational awareness platform provides analytics layer for the EDGE Group logistics deployment. Dependency on TII-maintained component.

---

## 4. Governance & Community Risk

Not applicable — SteerAI has no OSS projects or community governance structures. Fully proprietary, sovereign-backed venture.

---

## 5. Hardware Platform Details

### Current Hardware

**xRift Autonomous ATV**:

| Spec | Value |
| --- | --- |
| **Engine** | 225 HP |
| **Top speed** | 50 km/h |
| **Fuel tank** | 47 L |
| **Weight** | 1,350 kg |
| **Dimensions** | 4.2m (L) × 1.9m (W) × 1.4m (H) |
| **Payload** | 500 kg (modular utility deck) |
| **Propulsion** | Internal combustion (fuel-powered) |

**CoreX Hardware Kit**: Modular sensor package (cameras + LiDAR) plus compute unit. Specific hardware vendors and compute platform not disclosed.

### Roadmap

| Product | Timeline | Key Changes |
| --- | --- | --- |
| **xRift production** | End 2026 | First production units deployment-ready |
| **Maritime expansion** | Not disclosed | Stated future direction — extending CoreX/CoreConnect to maritime autonomous platforms |

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Milrem Robotics** | 20 THeMIS UGVs | Signed IDEX 2025; UAE Land Forces trial program | CoreX embedded in THeMIS; part of combined combat system with VECTOR RCVs + UAVs |
| **EDGE Group** | Pilot | Collaboration agreement signed UMEX/SimTEX 2026; ALP for EDGE industrial facilities | CoreConnect fleet management layer |
| **Micropolis** | Pilot (M01/M02) | Part of EDGE/TII/Micropolis ALP collaboration | CoreConnect manages Micropolis heavy-duty UGVs (4-5 ton, 400V battery, 12-18h runtime) |
| **Elistair** | xRift integration | Partnership announced Jun 2026 | Tethered drone mounted on xRift for aerial surveillance, recon, comms |
| **TII** | Technology source | Ongoing technology transfer from ATRC research arm | CoreX algorithms, TACTICAai analytics |

### Developer Ecosystem

No developer ecosystem identified. SteerAI operates as a systems integrator rather than a platform company — partnerships are B2B integration agreements, not developer community building.

---

## 7. Detailed Competitive Analysis

### vs Milrem Robotics

| Dimension | SteerAI | Milrem Robotics |
| --- | --- | --- |
| **Core offering** | Autonomy software (CoreX) + fleet management (CoreConnect) | UGV hardware (THeMIS, Type-X) + C2 software suite |
| **Vehicle capability** | Vehicle-agnostic retrofit; xRift purpose-built ATV | THeMIS tracked UGV, Type-X combat vehicle; multiple payload variants |
| **Geographic presence** | Abu Dhabi (UAE sovereign) | Tallinn, Estonia; programs in 19 countries |
| **Defense partnerships** | UAE Land Forces, EDGE Group | NATO integration, 19-country installed base |
| **Autonomy level** | Full autonomous driving (CoreX); GNSS-denied navigation | Teleoperation + semi-autonomous modes; autonomy via partner integrations |
| **Relationship** | Complementary — CoreX provides autonomy layer for THeMIS | Complementary — THeMIS provides platform for CoreX |

### vs Waymo / Wayve

| Dimension | SteerAI | Waymo / Wayve |
| --- | --- | --- |
| **Domain** | Off-road, unmapped, GNSS-denied terrain | On-road, mapped urban/suburban environments |
| **Use case** | Defense + industrial logistics | Consumer ride-hailing, delivery |
| **Scale** | 20 UGVs in trial + xRift pilot | Millions of autonomous miles; commercial services live |
| **Technology maturity** | Early deployment (production units end-2026) | Production (Waymo 5th gen; Wayve LINGO-2 foundation model) |
| **Regulatory environment** | Defense procurement (UAE sovereign mandate) | Civilian regulatory frameworks (NHTSA, UNECE) |

---

## Sources

- [SteerAI website](https://steerai.ai/)
- [TII announces SteerAI launch](https://www.tii.ae/news/abu-dhabi-unveils-steerai-new-tech-venture-set-transform-industrial-vehicles-autonomous)
- [VentureOne launches SteerAI](https://www.ventureone.ae/news/abu-dhabi-unveils-steerai-new-tech-venture-set-transform-industrial-vehicles-autonomous)
- [Milrem Robotics partners with SteerAI](https://steerai.ai/milrem-robotics-partners-with-steerai.php)
- [Milrem partnership details](https://milremrobotics.com/milrem-robotics-partners-with-steerai-to-power-unmanned-vehicles-for-uae-land-forces-trial-program/)
- [EDGE Group ALP announcement](https://edgegroup.ae/news/edge-tii-micropolis-and-steerai-deploy-advanced-autonomous-logistics-platform)
- [SteerAI xRift at UMEX 2026](https://steerai.ai/steerai-unveils-xrift-at-umex-new-autonomous-vehicle-brings-off-road-flexibility-to-the-gulf-region)
- [SteerAI xRift — NextGen Defense](https://nextgendefense.com/steerai-xrift-battlefield-autonomy/)
- [ATRC lab-to-market pipeline](https://www.tii.ae/insights/lab-market-atrc-entities-turn-breakthrough-research-real-world-technologies)
- [SteerAI — Unmanned Systems Technology](https://www.unmannedsystemstechnology.com/company/steerai/)
