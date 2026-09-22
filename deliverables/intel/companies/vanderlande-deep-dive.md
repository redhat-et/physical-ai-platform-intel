# Vanderlande — Deep Dive Research

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

Supporting research for the [Vanderlande competitive profile](vanderlande.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: corporate timeline, product architectures, partnership details, and competitive analysis.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1949 | Founded in Veghel, Netherlands as material handling equipment manufacturer |
| 2017-03 | Toyota Industries Corporation announces acquisition for €1.16B (¥140B) |
| 2017-05 | Acquisition completed; Vanderlande becomes wholly-owned Toyota Industries subsidiary |
| 2017 | FLEET autonomous baggage AGV system introduced at inter airport exhibition |
| 2024-01 | Andrew Manship becomes CEO (replacing Remo Brunschwiler) |
| 2025-02 | ProMat 2025: showcases STOREPICK, FASTPICK, Hai Robotics ACR integration |
| 2025-05 | Acquires Siemens Logistics non-US operations for €300M (~2,000 employees) |
| 2025-11 | Toyota Industries announces reorganization: Vanderlande warehouse business to join Toyota Automated Logistics (TAL) |
| 2026-04 | TAL formed — combines Bastian Solutions, Vanderlande warehousing, and viastore |
| 2026 | Vanderlande continues independently in airport and parcel (distribution) segments |
| 2026 | CTO Frank van Dijck named Distinguished Digital Engineering Leader |

### Acquisitions — What Each Brought

#### Siemens Logistics non-US operations (2025)

- **Price**: €300M
- **Technology**: Airport baggage handling systems (check-in to aircraft), parcel sorting systems, security screening integration
- **Integration**: Combined with Vanderlande's existing airport automation business; ~2,000 employees added
- **Significance**: Consolidates airport logistics automation market; Vanderlande now dominates with 600+ airports using their systems, including 17 of the 25 largest globally

---

## 2. Product Architecture Details

### VISION WMS/WCS Platform

| Aspect | Details |
| --- | --- |
| **Architecture** | Modular WMS + WCS: functional modules map to logistics process steps (goods receiving through shipping). Cloud-based deployment enables multi-site rollout. Industry-specific packages (food, fashion, general merchandise) can be "plug and play" or customized. |
| **Runtime dependencies** | Cloud infrastructure (provider not disclosed). Connects to warehouse equipment (conveyors, AS/RS, shuttles, AGVs, AMRs, robotic pickers). |
| **Extension model** | Modular — add/replace/change modules without reprogramming. Industry-specific packages configurable. No public API documentation found. |
| **Key limitations** | Proprietary platform — no disclosed cloud provider, no containerization details. Tight coupling to Vanderlande hardware ecosystem. |

<!-- TODO: deep research needed — VISION deployment architecture, cloud provider, containerization approach, API/integration protocols, data model -->

### FLEET Autonomous Baggage System

| Aspect | Details |
| --- | --- |
| **Architecture** | Individual AGVs carry single bags through airport infrastructure. Real-time route planning continuously optimized. Vehicles determine most optimal route for given time and passenger. Designed to replace fixed conveyor systems. |
| **Runtime dependencies** | Built in-house at Veghel. Vehicle-embedded compute for navigation + route optimization. Central fleet management for route coordination. |
| **Extension model** | Scalable — add vehicles or change routes easily. Can act as temporary solution for peak periods or during phased construction. |
| **Key limitations** | Airport-specific; not designed for warehouse or parcel use. Single-bag-per-vehicle design limits throughput density vs conveyors. |

<!-- TODO: deep research needed — FLEET compute platform, sensor stack, navigation technology (SLAM, fixed infrastructure, hybrid?), communication protocols -->

### Smart Item Robotics (SIR)

| Aspect | Details |
| --- | --- |
| **Architecture** | Portfolio of self-learning picking robots. Three components: intelligent gripper technology, sophisticated vision system, control software. Designed to work with AS/RS and goods-to-person workstations. |
| **Runtime dependencies** | Integrated with Vanderlande AS/RS (STOREPICK, FASTPICK). Machine learning for handling diverse shapes and weights. |
| **Extension model** | Part of holistic automated solution — robots + AS/RS + goods-to-person stations. Not standalone. |
| **Key limitations** | Reliability depends on end-to-end system design — best results with Vanderlande's own AS/RS, limiting interoperability with competitor systems. |

<!-- TODO: deep research needed — vision system specifics (vendor, architecture), ML training pipeline, gripper technology details, pick rate and accuracy metrics -->

### AI Predictive Maintenance

| Aspect | Details |
| --- | --- |
| **Architecture** | Sensor data from shuttle systems → AI anomaly detection → GenAI links anomalies to maintenance history and equipment manuals → prioritized maintenance recommendations. |
| **Runtime dependencies** | Sensor instrumentation on shuttle systems. GenAI model (vendor not disclosed). Access to maintenance history and equipment documentation. |
| **Extension model** | Deployed across Vanderlande shuttle systems. Expanding to other equipment types. |
| **Key limitations** | 84% failure reduction is impressive but metric details unknown (baseline, time period, system scope). GenAI model vendor dependency undisclosed. |

<!-- TODO: deep research needed — GenAI model vendor (OpenAI, Google, in-house?), sensor types and protocols, edge vs cloud inference split, deployment architecture -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **VISION** | None identified | N/A | Full WMS/WCS platform, industry packages, multi-site cloud deployment |
| **FLEET** | None identified | N/A | AGV design, real-time route optimization, fleet coordination |
| **Pallet AV** | None identified | N/A | Integration of Toyota hardware + Kollmorgen software |
| **SIR** | None identified | N/A | Vision system, gripper design, self-learning control software |
| **Predictive Maintenance** | None identified | N/A | GenAI anomaly detection, maintenance recommendation engine |

### Pattern Analysis

Vanderlande is fully proprietary across its product portfolio. As a traditional system integrator focused on turnkey logistics automation, the company builds and integrates end-to-end solutions rather than consuming or contributing to open-source robotics frameworks. No evidence of ROS 2, PyTorch, or other standard robotics/ML framework usage in public materials, though these may be used internally. The GenAI predictive maintenance capability likely uses a third-party LLM (OpenAI, Google, or similar) but the vendor is not disclosed.

The Toyota Industries parent operates similarly — Toyota Material Handling's forklift and AGV technology is proprietary, and Kollmorgen's AGV software is closed-source.

### Notable Dependencies

- **Kollmorgen**: AGV navigation and control software for Pallet AV automated forklifts
- **Hai Robotics**: ACR (Automated Case-Handling Robot) integrated as third-party AMR in warehouse solutions
- **GenAI vendor**: Undisclosed LLM provider for predictive maintenance; creates dependency on external AI service

---

## 4. Governance & Community Risk

Not applicable — Vanderlande has no OSS projects or community governance structures. Fully proprietary system integrator.

---

## 5. Hardware Platform Details

Not applicable as primary focus — Vanderlande is primarily a system integrator, not a hardware manufacturer. Key hardware elements:

- **FLEET AGVs**: Designed and built in-house at Veghel for airport baggage
- **Pallet AV**: Uses Toyota Material Handling forklift hardware with Kollmorgen AGV retrofit
- **Conveyors, sorters, AS/RS**: Traditional material handling hardware (designed in-house, manufactured with partners)

<!-- TODO: deep research needed — FLEET vehicle specs (compute, sensors, battery/power), Pallet AV specs, SIR robot specifications -->

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Toyota Industries** | Parent company | €1.16B acquisition (2017) | Full ownership; hardware sharing (forklifts, AGVs) |
| **Bastian Solutions** | TAL sibling | TAL consolidation (Apr 2026) | U.S. warehouse automation; technology stack merging |
| **viastore** | TAL sibling | TAL consolidation (Apr 2026) | European warehouse automation; merging with Vanderlande EU warehouse |
| **Siemens Logistics** | Acquired | €300M (May 2025) | 2,000+ employees; airport baggage + parcel sorting; fully absorbed |
| **Kollmorgen** | Technology partner | Integration partnership | AGV hardware/software for automated forklift solution |
| **Hai Robotics** | Technology partner | AMR integration | ACR robots integrated into Vanderlande warehouse solutions |
| **Airport customers** | 600+ airports | Turnkey system contracts | Design, install, maintain — lifecycle relationship |

### Developer Ecosystem

No external developer ecosystem. Vanderlande operates as a turnkey system integrator — customers buy complete solutions, not developer tools or platforms. VISION's modular architecture suggests internal developer practices but no external SDK, API marketplace, or partner development program identified.

---

## 7. Detailed Competitive Analysis

### vs Dematic (KION Group)

| Dimension | Vanderlande | Dematic |
| --- | --- | --- |
| **Parent** | Toyota Industries (¥2.4T revenue) | KION Group (€11.4B revenue) |
| **Revenue** | €2.3B (FY2025) | ~€4B (estimated, within KION) |
| **Warehouse focus** | E-commerce, omnichannel retail, grocery | Broader: manufacturing, distribution, e-commerce |
| **Airport/parcel** | Market leader (600+ airports, Siemens Logistics acquired) | No airport; limited parcel |
| **AGV/AMR** | FLEET (airports), Pallet AV (warehouses via Toyota/Kollmorgen) | Dematic AGVs, partnership with KION's Linde forklifts |
| **Software** | VISION WMS/WCS | iQ software platform |
| **AI** | GenAI predictive maintenance (84% failure reduction) | AI-powered optimization (details less public) |

### vs Swisslog (KUKA/Midea)

| Dimension | Vanderlande | Swisslog |
| --- | --- | --- |
| **Parent** | Toyota Industries | KUKA (Midea Group) |
| **Specialization** | Airports + warehouses + parcels | Healthcare + warehouses |
| **Software** | VISION | SynQ warehouse management |
| **Robot integration** | SIR picking robots, Hai Robotics ACR | KUKA robot arms integration |
| **Geographic strength** | Global (strongest in Europe + airports worldwide) | Europe + North America |

<!-- TODO: deep research needed — detailed competitive analysis vs FORTNA, Honeywell Intelligrated, Knapp -->

---

## Sources

- [Vanderlande company profile](https://www.vanderlande.com/about-vanderlande/company-profile/)
- [Vanderlande warehousing](https://www.vanderlande.com/warehousing/)
- [VISION software platform](https://www.vanderlande.com/software/vision/)
- [Smart Item Robotics](https://www.vanderlande.com/systems/picking/smart-item-robotics/)
- [FLEET autonomous baggage handling](https://www.airport-technology.com/features/autonomous-baggage-handling-vehicles/)
- [Toyota Industries reorganization](https://www.toyota-industries.com/news/2025/11/11/008891/index.html)
- [AI predictive maintenance](https://www.vanderlande.com/news-insights/delivering-insights-ai-driven-predictive-maintenance/)
- [Vanderlande + Kollmorgen](https://www.robotics247.com/article/vanderlande_kollmorgen_partner_provide_service_autonomous_forklifts/AGV)
- [ProMat 2025 showcase](https://www.robotics247.com/article/promat_2025_vanderlande_to_showcase_how_to_automate_your_warehouse_success)
- [Logistics becomes autonomous (CTO interview)](https://ioplus.nl/en/posts/from-human-to-machine-logistics-becomes-autonomous)
- [Vanderlande Wikipedia](https://en.wikipedia.org/wiki/Vanderlande)
