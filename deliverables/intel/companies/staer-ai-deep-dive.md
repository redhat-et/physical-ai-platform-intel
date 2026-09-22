# Staer AI — Deep Dive Research

**Date**: 2026-09-21
**Last updated**: 2026-09-21
**Classification**: Internal analysis — not for public repo

Supporting research for the [Staer AI competitive profile](staer-ai.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: founding team history, product architecture, spatial intelligence approach, and competitive analysis.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2010 | Jan Erik Solem sells Polar Rose (facial recognition) to Apple |
| 2014 | LDV Capital first invests in Mapillary (street-level imagery platform) |
| 2020 | Meta acquires Mapillary; founding team exits |
| 2025 | Staer AI founded by Solem + five Mapillary co-founders (Carl Silbersky, Johan Gyllenspetz, Yubin Kuang, Peter Neubauer, Pau Gargallo) |
| 2025-10 | €3.5M pre-seed closed (Pale Blue Dot lead, LDV Capital) |
| 2026 | €4.3M follow-on round closed (total €7.6M raised) |
| 2026 | Accepted into Google DeepMind Accelerator for Robotics and Physical AI |
| 2026 | Multiple commercial pilots signed: e-commerce, logistics, retail, OEM |

### Acquisitions — What Each Brought

No acquisitions. Pre-revenue startup.

### Founding Team Deep Dive

The team's competitive advantage is their shared history building Mapillary — a platform that crowdsourced street-level imagery and built large-scale 3D maps from user-contributed photos. The same technical challenge (reconstructing 3D environments from diverse camera sources at scale) directly transfers to warehouse spatial intelligence.

| Founder | Background | Relevance |
| --- | --- | --- |
| **Jan Erik Solem** | CEO. Polar Rose → Apple (2010), Mapillary → Meta (2020). LDV Capital Expert in Residence. | Serial entrepreneur with two exits to FAANG; deep computer vision expertise |
| **Yubin Kuang** | Co-founder. Mapillary, Apple. | Computer vision / 3D reconstruction |
| **Pau Gargallo** | Co-founder. Mapillary, Meta. | Visual mapping at scale |
| **Carl Silbersky** | Co-founder. Mapillary. | Product / engineering |
| **Johan Gyllenspetz** | Co-founder. Mapillary. | Product / engineering |
| **Peter Neubauer** | Co-founder. Mapillary. | Engineering |

Sequoia, Atomico, and BMWi were co-investors in Mapillary — the team has Tier 1 VC relationships.

---

## 2. Product Architecture Details

### Staer Platform

| Aspect | Details |
| --- | --- |
| **Architecture** | Camera feeds from existing forklifts → visual SLAM-style 3D reconstruction → continuously updated live 3D map → multiple perception pipelines run simultaneously on same sensor data (mapping, identification, tracking). Cloud-hosted (EU). Modules layer on top of foundational spatial map. |
| **Runtime dependencies** | EU-hosted cloud infrastructure (provider not disclosed). Cameras mounted on forklifts (no specific vendor/model required). No LiDAR, beacons, or fixed infrastructure needed. |
| **Extension model** | Closed platform. No public API or SDK documented. Integration implied via WMS/ERP for inventory reconciliation. Robot orchestration described as vendor-agnostic but integration mechanism not specified. Canvas portal at `canvas.staer.ai` (authenticated). |
| **Key limitations** | Cloud-dependent (no disclosed edge/on-premise option). Camera-only sensing may limit accuracy vs LiDAR-equipped solutions. Early-stage — commercial pilots not yet at scale production. |

### Technical Approach: Spatial Intelligence

The core technical insight from the Mapillary lineage: reconstructing 3D environments from many diverse camera viewpoints at scale. Applied to warehouses:

1. **Data collection**: Cameras on existing forklifts capture continuous imagery during normal operations — no dedicated mapping runs needed
2. **3D reconstruction**: Multi-pipeline perception processes each camera feed simultaneously for mapping, object identification, and tracking (visual SLAM implied)
3. **Shared map**: Unlike single-vendor AMR maps (each robot keeps its own), Staer creates a single live 3D map that any robot from any vendor can reference
4. **Continuous learning**: Map updates as robots traverse the facility — handles dynamic environments (pallets move, layouts change)

<!-- TODO: deep research needed — specific ML models used for 3D reconstruction, object detection architecture, how multi-vendor robot orchestration interfaces work (ROS 2 bridge? proprietary API?), cloud infrastructure provider -->

### Open Dataset

Published `staerrobotics/warehouses` on Hugging Face — warehouse environment dataset. Signals engagement with open ML research community, though core platform is proprietary.

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Staer Platform** | None disclosed; Hugging Face presence suggests PyTorch ecosystem | N/A | Live 3D mapping, multi-vendor orchestration, warehouse analytics modules |

### Pattern Analysis

Staer follows a "proprietary platform, open data" pattern — the core spatial intelligence platform is closed, but they publish research datasets on Hugging Face. This is a common early-stage strategy to build academic credibility and attract ML talent while keeping the product proprietary.

The Mapillary precedent is informative: Mapillary open-sourced some tools and datasets while keeping the core platform commercial. Staer may follow a similar path — contributing to the computer vision commons while monetizing the warehouse-specific integration layer.

### Notable Dependencies

- **Hugging Face**: Dataset hosting suggests PyTorch/transformers ecosystem, not TensorFlow
- **Google DeepMind Accelerator**: May influence cloud infrastructure choices toward GCP
- No disclosed dependency on ROS 2, NVIDIA Isaac, or other standard robotics frameworks

---

## 4. Governance & Community Risk

Not applicable — no OSS projects stewarded. The Hugging Face dataset (`staerrobotics/warehouses`) is a data release, not a software project with governance requirements.

---

## 5. Hardware Platform Details

Not applicable — Staer is a pure software company. Uses cameras already mounted on customer forklifts; no proprietary hardware.

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Pale Blue Dot** | Investor (lead) | €3.5M pre-seed (Oct 2025) | Board-level |
| **LDV Capital** | Investor (co-lead) | Pre-seed + follow-on; second-time investor (after Mapillary 2014) | Board-level; Solem is LDV Expert in Residence |
| **Google DeepMind** | Accelerator | Robotics and Physical AI accelerator program (2026) | Program-level; potential GCP/ML infrastructure influence |
| **Commercial pilots** | Multiple | e-commerce, logistics, retail, OEM (names not disclosed) | Pilot deployments |

### Developer Ecosystem

No developer ecosystem. Product is deployed as a managed service, not a developer tool. The Hugging Face dataset is the only public-facing technical artifact.

### Business Model

Hybrid model:

1. **Forward-deployed engineering**: Engineers embed with customers for initial deployment — builds domain expertise and customer trust
2. **SaaS**: Recurring annual license per site or fleet — high-margin once deployed

Target: reduce the 20-33% of warehouse labor cost spent on searching, empty travel, and waiting.

---

## 7. Detailed Competitive Analysis

### vs 6 River Systems / Locus Robotics (Warehouse AMR vendors)

| Dimension | Staer AI | 6 River / Locus |
| --- | --- | --- |
| **Core offering** | Software-only spatial intelligence + fleet orchestration | Robot hardware + proprietary fleet management |
| **Hardware dependency** | None — uses existing forklift cameras | Requires vendor-specific robots |
| **Multi-vendor support** | Yes — any robot on shared map | No — manages own fleet only |
| **Revenue model** | SaaS per site/fleet | Robot leasing + SaaS |
| **Market maturity** | Pre-revenue, commercial pilots | Established, deployed at scale |
| **Spatial intelligence** | Live 3D map, continuous reconstruction | Static maps, single-robot SLAM |

### vs Foxglove / Rerun (Robotics data platforms)

| Dimension | Staer AI | Foxglove / Rerun |
| --- | --- | --- |
| **Primary use** | Production operations (live fleet management) | Development (debugging, visualization) |
| **3D mapping** | Live operational map, continuously updated | Point-in-time visualization of recorded data |
| **Fleet orchestration** | Built-in multi-vendor coordination | Not included — dev tools only |
| **Target user** | Warehouse operations teams | Robotics engineers |
| **Domain scope** | Warehouse/logistics specialized | General-purpose robotics |
| **OSS engagement** | Dataset on Hugging Face | Foxglove: OSS studio; Rerun: OSS SDK |

### vs Traditional WMS (Warehouse Management Systems)

| Dimension | Staer AI | Traditional WMS |
| --- | --- | --- |
| **Spatial awareness** | Live 3D map from cameras — knows physical location of items | Database records — knows logical location (bin/shelf ID) |
| **Real-time accuracy** | Continuous camera-based verification | Depends on manual scans, periodic counts |
| **Robot integration** | Native multi-vendor orchestration | Bolt-on integrations, typically single-vendor |
| **Infrastructure** | Cameras on existing forklifts | Barcode scanners, RFID, fixed infrastructure |

---

## Sources

- [Staer website](https://staer.ai/)
- [Staer product page](https://staer.ai/product/)
- [LDV Capital partnership announcement](https://www.ldv.co/blog/2026/7/2/partnering-with-staer-to-deliver-spatial-intelligence-and-physical-ai-for-autonomous-mobile-robotics)
- [Pre-seed funding — StartupMafia](https://startupmafia.eu/malmo-based-robotics-startup-staer-raised-e3-5m-pre-seed-for-ai-driven-autonomous-robot-fleets)
- [Pale Blue Dot spatial intelligence thesis](https://palebluedotvc.substack.com/p/why-spatial-intelligence-will-power)
- [Staer on Hugging Face](https://huggingface.co/staerrobotics)
- [Staer — Crunchbase](https://www.crunchbase.com/organization/staer-f747)
- [Staer — Skåne Startup Map](https://www.pampam.city/skane-startup-map-bAF110D4hzeZC1WR69qz/QpwkXRlgD2PSQ4cHIImn)
