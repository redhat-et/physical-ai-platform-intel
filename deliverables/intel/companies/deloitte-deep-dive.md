# Deloitte — Deep Dive Research

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

Supporting research for the [Deloitte competitive profile](deloitte.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: corporate timeline, Smart Factory network details, NVIDIA alliance architecture, and competitive positioning.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2017–2021 | 14 cloud-technology firm acquisitions including HashedIn Technologies (Jan 2021, ~750 people), innoWake, ATADATA, Keytree |
| 2019 | Smart Factory @ Wichita opens — flagship demonstration facility |
| 2022 | Smart Factory network expands to Germany, Japan, Canada |
| 2023-11 | NVIDIA alliance established — AI Enterprise, Omniverse, DGX Cloud |
| 2025-02 | 2025 Smart Manufacturing Survey published |
| 2025-08 | kAIros project — CV-based anomaly detection at Horse Powertrain plant (Valladolid, Spain) |
| 2025-10 | FY2025 revenue: $70.5B (first firm to surpass $70B) |
| 2026-01 | Tech Trends 2026 report — Physical AI highlighted as key trend |
| 2026-03 | Expanded NVIDIA alliance for Physical AI: digital twins, edge robotics, computer vision |
| 2026 | Physical AI Center of Excellence opened in Shanghai |
| 2026 | State of AI in Enterprise 2026: 58% of firms using Physical AI |
| 2026 | Oracle joins Smart Factory @ Wichita |

### Acquisitions — What Each Brought

#### HashedIn Technologies (2021)

- **Price**: Undisclosed
- **Technology**: Cloud-native software engineering, product development, software modernization
- **Integration**: ~750 engineers absorbed into Deloitte Consulting; co-founders joined as managing directors
- **Significance**: Strengthened cloud engineering capacity for IoT and smart factory implementations

#### Efficientia Solutions (date undisclosed)

- **Price**: Undisclosed
- **Technology**: Smart manufacturing technology integration and support (Australia)
- **Integration**: Manufacturing sector technology practice
- **Significance**: Added hands-on OT integration capabilities for factory floor deployments

<!-- TODO: deep research needed — full acquisition history relevant to Physical AI/manufacturing practice -->

---

## 2. Product Architecture Details

### Enterprise Simulation (SIM)

| Aspect | Details |
| --- | --- |
| **Architecture** | Built on NVIDIA Omniverse: USD-based scene composition, PhysX for physics simulation, RTX for rendering. Integrates with client ERP/MES systems for operational data. AR/VR visualization layer for immersive planning. |
| **Runtime dependencies** | NVIDIA Omniverse (requires NVIDIA GPUs — RTX or A100/H100), client cloud infrastructure (AWS typical). |
| **Extension model** | Consulting-delivered customization per engagement. No public SDK or plugin system. |
| **Key limitations** | NVIDIA GPU dependency. Engagement-based delivery model (not self-service). Custom per client — no standard product with replicable deployment. |

### Smart Factory Fabric

| Aspect | Details |
| --- | --- |
| **Architecture** | Pre-configured IoT application suite on AWS IoT. Connects factory-floor sensors/PLCs to cloud analytics. Modules: visibility dashboards, production optimization, quality monitoring, predictive maintenance. |
| **Runtime dependencies** | AWS IoT Core, AWS analytics services. Factory-floor OT infrastructure (PLCs, sensors, SCADA). |
| **Extension model** | Pre-configured but customizable per engagement. Turnkey approach claimed to deliver outcomes "in weeks, not months." |
| **Key limitations** | AWS-locked. Cloud-first architecture — on-premise/edge deployment capabilities not documented. |

### Physical AI Solutions (NVIDIA Alliance)

| Aspect | Details |
| --- | --- |
| **Architecture** | Three pillars: (1) Digital twins via Omniverse — physically accurate materials, lighting, behavior simulation; (2) Edge robotics via Isaac Sim + Cosmos world models — sim-to-real for humanoid/industrial robots; (3) Computer vision — anomaly detection, quality inspection using deployed camera infrastructure. |
| **Runtime dependencies** | NVIDIA Omniverse, Isaac Sim, Cosmos, Isaac ROS. NVIDIA GPUs at both datacenter (training/simulation) and edge (inference). |
| **Extension model** | Consulting-delivered. Leverages NVIDIA's open frameworks (Isaac ROS — Apache 2.0) but Deloitte's integration and domain expertise is proprietary. |
| **Key limitations** | Fully NVIDIA-dependent. No multi-vendor simulation strategy. Consulting delivery model limits scale — each deployment is a custom engagement. |

<!-- TODO: deep research needed — specific technical architecture of the Shanghai CoE, reference architectures for edge robotics deployments, computer vision model details -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Enterprise SIM** | USD (Apache 2.0 open standard) | Apache 2.0 | NVIDIA Omniverse platform + Deloitte domain customization |
| **Smart Factory Fabric** | None | N/A | AWS IoT platform + Deloitte pre-configuration and domain templates |
| **Physical AI Solutions** | Isaac ROS (Apache 2.0), Cosmos weights (Apache 2.0) | Apache 2.0 | NVIDIA Isaac Sim (proprietary) + Deloitte consulting integration |

### Pattern Analysis

Deloitte follows a classic SI pattern: "build on partner platforms, add domain expertise." They contribute no OSS of their own. Their value-add is consulting methodology, industry domain knowledge, change management, and governance — not technology IP.

The NVIDIA stack they deploy includes both proprietary (Omniverse, Isaac Sim) and open (Isaac ROS, Cosmos weights, USD) components. Deloitte's Physical AI practice is architecturally dependent on NVIDIA — there is no disclosed alternative simulation/robotics stack.

### Notable Dependencies

- **NVIDIA Omniverse**: Core dependency for all digital twin and simulation work. Proprietary platform with GPU hardware requirement.
- **AWS IoT**: Foundation for Smart Factory Fabric. Cloud-locked.
- **Isaac ROS / Cosmos**: Open components that could theoretically be deployed on non-NVIDIA infrastructure, but Deloitte's practice is structured around the full NVIDIA stack.

---

## 4. Governance & Community Risk

Not applicable — Deloitte stewards no OSS projects. Pure consumer of partner technology.

---

## 5. Hardware Platform Details

Not applicable — Deloitte is a consulting firm with no hardware products. Smart Factory network locations (Wichita, Germany, Japan, Canada) are demonstration facilities with partner hardware, not Deloitte-manufactured equipment.

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **NVIDIA** | Global alliance | Long-standing; expanded Mar 2026 for Physical AI. Joint Shanghai CoE. | Deep — Omniverse, Isaac Sim, Cosmos embedded in Deloitte solutions |
| **AWS** | Global alliance | Smart Factory Fabric on AWS IoT. | Deep — cloud infrastructure foundation |
| **Oracle** | Smart Factory | Joined Smart Factory @ Wichita for AI + automation in manufacturing. | Demonstration/co-selling |
| **Cisco** | Manufacturing | Joint smart manufacturing solutions — IT/OT convergence. | Integration partnership |
| **Horse Powertrain** | Client (1 plant) | kAIros project — CV anomaly detection at Valladolid, Spain (Aug 2025). | Custom engagement |

### Developer Ecosystem

No developer ecosystem. Deloitte operates as a consulting firm, not a platform company. Engages developers through hiring (470K+ employees) rather than community building. Published research (Tech Trends, State of AI) influences enterprise decision-makers but is thought leadership, not developer tooling.

---

## 7. Detailed Competitive Analysis

### vs Accenture

| Dimension | Deloitte | Accenture |
| --- | --- | --- |
| **Revenue** | $70.5B (FY2025) | $64.9B (FY2025) |
| **Physical AI approach** | Consulting-delivered solutions on NVIDIA stack | Branded product: Physical AI Orchestrator |
| **AI investment** | $3B+ through 2030 | $3B in AI |
| **AI headcount** | Not disclosed at AI-specific level | ~77,000 AI professionals |
| **NVIDIA relationship** | Expanded alliance (Mar 2026), Shanghai CoE | Also NVIDIA Omniverse partner (Physical AI Orchestrator) |
| **Proven results** | kAIros CV project (automotive) | 20% throughput improvement (consumer goods), Unilever: 20% waste + 30% defect reduction |
| **Smart Factory** | Physical demonstration network (4 locations) | Nano Labs, Industry X Innovation Centers |
| **Key differentiator** | Governance, regulatory, end-to-end consulting breadth | Productized offering (Orchestrator), larger dedicated AI practice |

### vs Capgemini

| Dimension | Deloitte | Capgemini |
| --- | --- | --- |
| **Revenue** | $70.5B | ~$22B |
| **Primary cloud partner** | AWS (Smart Factory Fabric), NVIDIA (Physical AI) | Google Cloud (primary), Microsoft Azure |
| **Physical AI focus** | NVIDIA-first (Omniverse, Isaac Sim) | Google Cloud-native digital twins |
| **Geographic strength** | North America (#1), global | Europe (strong engineering heritage), India delivery |
| **Delivery model** | Premium consulting | Engineering services + consulting (lower cost point) |
| **Key differentiator** | Scale, brand, NVIDIA depth | European manufacturing depth, cost efficiency |

<!-- TODO: deep research needed — detailed project-by-project comparison of manufacturing digital twin deployments across Deloitte/Accenture/Capgemini -->

---

## Sources

- [Deloitte Physical AI + NVIDIA alliance](https://www.deloitte.com/global/en/services/consulting/services/deloitte-nvidia-alliance-physical-ai.html)
- [Deloitte unveils Physical AI solutions with NVIDIA Omniverse](https://www.deloitte.com/global/en/about/press-room/physical-ai-nvidia-omniverse-industrial-transformation.html)
- [Deloitte Enterprise Simulation (SIM)](https://www.deloitte.com/us/en/alliances/nvidia-alliance-enterprise-ai-simulation.html)
- [Deloitte FY2025 revenue](https://www.deloitte.com/global/en/about/press-room/global-revenue-announcement.html)
- [Deloitte #1 consulting — Gartner 2026](https://www.deloitte.com/global/en/about/recognition/analyst-relations/deloitte-ranked-number-one-consulting-service-provider-worldwide-by-revenue.html)
- [Deloitte Tech Trends 2026](https://www.deloitte.com/us/en/about/press-room/deloitte-tech-trends-2026.html)
- [Deloitte State of AI 2026](https://www.deloitte.com/us/en/about/press-room/state-of-ai-report-2026.html)
- [Deloitte Smart Factory @ Wichita](https://www.deloitte.com/us/en/services/consulting/services/smart-manufacturing-solutions.html)
- [Deloitte Smart Factory network](https://www.deloitte.com/global/en/Industries/energy/about/deloitte-smart-factories.html)
- [Deloitte 2025 Smart Manufacturing Survey](https://www.deloitte.com/us/en/insights/industry/manufacturing/2025-smart-manufacturing-survey.html)
- [Deloitte + Oracle Smart Factory](https://www.deloitte.com/us/en/about/press-room/deloitte-oracle-smart-factory.html)
- [HashedIn acquisition](https://www.prnewswire.com/in/news-releases/deloitte-consulting-completes-acquisition-of-hashedin-technologies-838855506.html)
- [Deloitte expands NVIDIA collaboration](https://roboticsandautomationnews.com/2026/03/08/deloitte-expands-partnership-with-nvidia-to-develop-physical-ai-solutions-for-industry/99345/)
- [Accenture Physical AI Orchestrator](https://newsroom.accenture.com/news/2025/accenture-launches-physical-ai-orchestrator-to-help-manufacturers-build-software-defined-facilities)
- [Deloitte robotics turning point 2026](https://www.robotics247.com/article/deloitte_robotics_will_reach_a_turning_point_with_ai_autonomy_in_2026)
