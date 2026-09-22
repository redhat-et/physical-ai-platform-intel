# Rockwell Automation — Deep Dive Research

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

Supporting research for the [Rockwell Automation competitive profile](rockwell-automation.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: acquisition history, product architectures, NVIDIA/AWS dependency analysis, and competitive comparisons.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1903 | Founded as Allen-Bradley Company (Milwaukee, WI) |
| 1985 | Rockwell International acquires Allen-Bradley for $1.65B |
| 2002 | Spun off from Rockwell Collins as Rockwell Automation |
| 2018 | Emulate3D acquired — digital twin simulation for factory automation |
| 2019 | Kalypso acquired — digital transformation consulting for manufacturing |
| 2020 | Fiix Inc. acquired — cloud CMMS for predictive maintenance |
| 2021 | Plex Systems acquired for $2.2B — cloud-native MES/ERP |
| 2022 | CUBIC acquired — modular industrial analytics |
| 2023 | Clearpath Robotics / OTTO Motors acquired — autonomous mobile robots |
| 2023 | Verve Industrial Protection acquired — OT cybersecurity |
| 2023 | Knowledge Lens acquired — industrial AI/analytics |
| 2024-03 | NVIDIA partnership deepened — Omniverse Cloud APIs for Emulate3D |
| 2025-10 | ControlLogix 5590 launched — IEC 62443 edge-to-cloud security |
| 2025-10 | First OTTO AMRs produced at Milwaukee HQ (25,000 sq ft facility) |
| 2025-11 | NVIDIA Nemotron Nano SLM integrated into FactoryTalk Design Studio |
| 2025-12 | Elastic MES launched via Plex — cloud SaaS with embedded AI |
| 2026 | Augury agentic AI partnership — Fiix MAX + Reliability Agent |

### Acquisitions — What Each Brought

#### Clearpath Robotics / OTTO Motors (2023)

- **Price**: Undisclosed
- **Technology**: OTTO 600/1200 AMRs (heavy material transport), fleet management software, autonomous navigation for manufacturing floors. Clearpath research division — ROS 2-based mobile robots for academia and R&D (500+ customers, 40+ countries).
- **Integration**: Reports to Intelligent Devices segment. Milwaukee production line opened Oct 2025. Canadian facilities maintained.
- **Significance**: Gives Rockwell own AMR hardware — completing the "PLC → robot arm → AMR → digital twin" automation stack. 5M+ production hours of autonomy experience.

#### Plex Systems (2021)

- **Price**: $2.2B
- **Technology**: Cloud-native MES/ERP for discrete and process manufacturing. Multi-tenant SaaS. ~700 customers.
- **Integration**: Became core of Rockwell's cloud strategy. Elastic MES (Dec 2025) adds AI-powered predictive insights.
- **Significance**: Largest acquisition. Shifted Rockwell toward recurring software revenue. ARR growing 8% YoY.

#### Emulate3D (2018)

- **Price**: Undisclosed
- **Technology**: Dynamic digital twin software for virtual commissioning of automated production systems.
- **Integration**: Now integrated with NVIDIA Omniverse APIs for factory-scale OpenUSD digital twins.
- **Significance**: Cornerstone of Rockwell's Physical AI strategy — virtual commissioning reduces deployment risk and accelerates time-to-market.

#### Fiix Inc. (2020)

- **Price**: Undisclosed
- **Technology**: Cloud-based CMMS for maintenance management and asset optimization.
- **Integration**: Available on AWS Marketplace. Fiix MAX (AI maintenance assistant) integrated with Augury for agentic workflows.
- **Significance**: Completes the "monitor → predict → act" maintenance loop with AI.

<!-- TODO: deep research needed — Kalypso acquisition details, CUBIC integration status, Knowledge Lens technology -->

---

## 2. Product Architecture Details

### Emulate3D + NVIDIA Omniverse

| Aspect | Details |
| --- | --- |
| **Architecture** | Physics-based simulation engine creating dynamic digital twins of production lines. NVIDIA Omniverse APIs provide OpenUSD interoperability and RTX photorealistic rendering. Multiple digital twins composable into factory-scale visualization via web app. PLC and robot controllers connect to virtualized Emulate3D systems. |
| **Runtime dependencies** | NVIDIA GPU (RTX for rendering), Omniverse Cloud APIs, real PLCs or virtualized PLC instances for control logic validation |
| **Extension model** | Vendor-agnostic via OpenUSD — can import CAD models from multiple sources. Web-based streaming for distributed team access. |
| **Key limitations** | NVIDIA GPU dependency for full rendering; Omniverse Cloud APIs require NVIDIA cloud infrastructure or compatible on-premise GPU clusters |

### OTTO Motors AMR Platform

| Aspect | Details |
| --- | --- |
| **Architecture** | OTTO 600 (600 kg payload) and OTTO 1200 (1200 kg payload) AMRs. LiDAR + camera perception, autonomous navigation in manufacturing environments. Fleet management software for multi-robot coordination. |
| **Runtime dependencies** | On-board compute (specifics not disclosed), LiDAR sensors, facility Wi-Fi for fleet coordination |
| **Extension model** | Integration with Rockwell ControlLogix PLCs and FactoryTalk for unified automation. Not ROS 2-based (proprietary industrial stack — distinct from Clearpath research robots which use ROS 2). |
| **Key limitations** | Manufacturing/warehouse-focused — not general-purpose outdoor AMR. Proprietary fleet management (no multi-vendor fleet support like Staer AI or VDA 5050 standard). |

### FactoryTalk Suite

| Aspect | Details |
| --- | --- |
| **Architecture** | Modular industrial software platform: Design Studio (engineering), Optix (HMI/visualization), Analytics (process optimization), Edge Gateway (OT data collection), Hub (cloud management on AWS). NVIDIA Nemotron Nano SLM runs at the edge for generative AI assistance in design workflows. |
| **Runtime dependencies** | Windows (Design Studio), AWS (Hub, cloud services), FactoryTalk Edge requires on-premise compute |
| **Extension model** | FactoryTalk Optix supports custom visualization development. Design Studio copilot via Microsoft Azure/OpenAI. |
| **Key limitations** | AWS-aligned cloud strategy — not cloud-agnostic. Edge gateway is proprietary — no Kubernetes/container orchestration layer disclosed. |

<!-- TODO: deep research needed — Plex Elastic MES architecture, FactoryTalk Edge compute requirements, Nemotron Nano deployment model details -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Emulate3D** | OpenUSD (via NVIDIA Omniverse) | Apache 2.0 (OpenUSD) | Physics simulation engine, virtual commissioning, PLC integration |
| **OTTO Motors** | None disclosed (industrial); ROS 2 (research/Clearpath) | Apache 2.0 (ROS 2) | AMR hardware, industrial navigation, fleet management |
| **FactoryTalk** | NVIDIA Nemotron Nano | Apache 2.0 (Nemotron) | Industrial workflow integration, Design Studio, Edge Gateway |
| **Plex** | None identified | N/A | Cloud MES/ERP, Elastic MES with embedded AI |
| **Fiix** | None identified | N/A | Cloud CMMS, Fiix MAX AI assistant |

### Pattern Analysis

Rockwell follows a "proprietary platform, selective OSS integration" pattern. Core products (FactoryTalk, Plex, Fiix, OTTO industrial stack) are fully proprietary. OSS enters via strategic partnerships: OpenUSD through NVIDIA Omniverse, Nemotron Nano through NVIDIA NeMo, and ROS 2 through the Clearpath research division (not the industrial OTTO stack).

The Clearpath/OTTO split is notable: Clearpath's research robots are ROS 2-based and widely used in academia (500+ customers), while the industrial OTTO AMRs use a proprietary stack optimized for manufacturing reliability. This dual approach lets Rockwell benefit from the ROS 2 ecosystem for R&D pipeline without exposing industrial products to open-source governance risks.

### Notable Dependencies

- **NVIDIA**: Deep dependency across simulation (Omniverse), edge AI (Nemotron), and rendering (RTX). Rockwell's Physical AI story is largely built on NVIDIA infrastructure.
- **AWS**: Cloud services (FactoryTalk Hub, Plex, Fiix) deployed on AWS. AWS Marketplace distribution. Joint go-to-market at Hannover Messe 2025.
- **Microsoft**: Azure/OpenAI for FactoryTalk copilot capabilities. Secondary cloud relationship vs AWS primary.

---

## 4. Governance & Community Risk

### Clearpath / ROS 2

| Dimension | Assessment |
| --- | --- |
| **Governing body** | Open Source Robotics Alliance (OSRA) under Open Source Robotics Foundation |
| **Core maintainer employment** | Multi-vendor: Intrinsic (Google), NVIDIA, Apex.AI, PickNik, and others. Clearpath/Rockwell is a contributor but not dominant. |
| **CLA/DCO** | DCO (Developer Certificate of Origin) |
| **Commit diversity** | Multi-vendor — no single-company dominance |
| **Abandonment risk** | Low — broad industry adoption, foundation governance, multiple corporate sponsors |

Rockwell's ROS 2 exposure is through Clearpath research products, not industrial offerings. Low governance risk for Rockwell since ROS 2 dependency is optional and compartmentalized.

---

## 5. Hardware Platform Details

### OTTO AMR Specifications

| Model | Payload | Use Case |
| --- | --- | --- |
| **OTTO 600** | 600 kg | Mid-weight material transport in manufacturing |
| **OTTO 1200** | 1,200 kg | Heavy material transport, pallet-level loads |

Production: Milwaukee HQ (25,000 sq ft, opened Oct 2025) + Ontario, Canada (Clearpath original facility).

### ControlLogix 5590

- Latest PLC platform (Oct 2025)
- IEC 62443 security certification
- Edge-to-cloud scalability
- Unified software environment

<!-- TODO: deep research needed — OTTO sensor specs, compute platform details, Clearpath research robot lineup -->

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **NVIDIA** | Strategic | Multi-year deepening: Omniverse APIs (2024), Nemotron Nano (2025), ongoing R&D | Core technology dependency — Emulate3D rendering + edge AI |
| **AWS** | Strategic | FactoryTalk Hub, Plex, Fiix on AWS; AWS Marketplace distribution; Hannover Messe 2025 joint launch | Cloud platform dependency |
| **Microsoft** | Strategic | Azure/OpenAI for FactoryTalk copilot; 40% design cycle reduction claim | AI copilot integration |
| **Augury** | Partnership | Agentic AI: Reliability Agent + Fiix MAX for maintenance workflows | Agent-to-agent integration |

### Developer Ecosystem

Rockwell has a large OT developer ecosystem via the ControlLogix/Logix platform — millions of deployed PLCs with trained automation engineers. FactoryTalk developer tools, Plex partner integrations, and the Clearpath research community (500+ institutions) provide additional developer surface. The Rockwell Automation Fair (annual event, ~20,000 attendees) is the primary community gathering.

---

## 7. Detailed Competitive Analysis

### vs Siemens

| Dimension | Rockwell Automation | Siemens |
| --- | --- | --- |
| **Revenue** | ~$7B (pure-play automation) | ~€18B Digital Industries (part of €75B Siemens AG) |
| **Digital twin** | Emulate3D + NVIDIA Omniverse | Xcelerator + Siemens NX + Tecnomatix |
| **Cloud MES** | Plex ($2.2B acquisition) | Opcenter (on-premise legacy + cloud transition) |
| **AMR/robotics** | OTTO Motors (own AMR) | Partner ecosystem (no own AMR hardware) |
| **PLM** | No PLM offering | Teamcenter (market leader) |
| **PLC market** | #1 in Americas (ControlLogix) | #1 globally (SIMATIC) |
| **Edge AI** | Nemotron Nano + FactoryTalk Edge | Siemens Industrial Edge (own platform) |
| **Cloud alignment** | AWS primary | AWS + Azure (multi-cloud, own MindSphere declining) |

### vs ABB

| Dimension | Rockwell Automation | ABB |
| --- | --- | --- |
| **Focus** | Pure-play automation + software | Automation + electrification + process industries |
| **Robot arms** | Partner integrations (FANUC, etc.) | Own portfolio (6-axis, delta, collaborative — #2 globally) |
| **AMR** | OTTO Motors (own) | Partner ecosystem |
| **Digital twin** | Emulate3D + Omniverse | ABB Ability Digital Twin (RobotStudio) |
| **Revenue** | ~$7B | ~$32B (total); ~$8B robotics & automation |
| **Geographic strength** | Americas dominant | Europe + Asia dominant |

---

## Sources

- [Rockwell + NVIDIA Omniverse](https://www.rockwellautomation.com/en-us/company/news/press-releases/Rockwell-Automation-Brings-Autonomous-Operations-to-Life-Using-NVIDIA-Omniverse.html)
- [NVIDIA case study — Rockwell](https://www.nvidia.com/en-us/case-studies/rockwell-automation/)
- [Clearpath/OTTO acquisition](https://www.rockwellautomation.com/en-us/company/news/press-releases/Rockwell-Automation-completes-acquisition-of-autonomous-robotics-leader-Clearpath-Robotics-and-its-industrial-offering-OTTO-Motors.html)
- [OTTO Milwaukee production](https://www.rockwellautomation.com/en-us/company/news/press-releases/First-Autonomous-Mobile-Robots-Roll-Off-the-Line-at-Rockwell-Automations-Milwaukee-Headquarters.html)
- [Nemotron Nano edge AI](https://www.rockwellautomation.com/en-us/company/news/press-releases/rockwell-automation-to-advance-industrial-intelligence-through-e.html)
- [Augury partnership](https://www.rockwellautomation.com/en-us/company/news/press-releases/rockwell-automation-and-augury-partner-to-improve-industrial-performance-with-agentic-ai.html)
- [Rockwell + AWS Hannover Messe 2025](https://www.businesswire.com/news/home/20250402085559/en/)
- [Plex acquisition](https://www.rockwellautomation.com/en-us/company/news/press-releases/Rockwell-Automation-Completes-Acquisition-of-Plex-Systems.html)
- [Rockwell financials](https://www.useluminix.com/reports/company-overviews/rockwell-automation-company-overview)
- [Emulate3D + Omniverse — Robot Report](https://www.therobotreport.com/rockwell-automation-adds-nvidia-omniverse-to-digital-twin-software/)
- [Fiix + DLG deployment](https://www.ainvest.com/news/rockwell-automation-fiix-cmms-deal-main-character-2026-story-2602/)
