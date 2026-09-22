# Dassault Systèmes — Deep Dive Research

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

Supporting research for the [Dassault Systèmes competitive profile](dassault-systemes.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: corporate timeline, product architecture, NVIDIA partnership architecture, and competitive analysis.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1981 | Founded as Dassault Systèmes, spun out of Dassault Aviation. CATIA 3D CAD software. |
| 1997 | Acquired SolidWorks (mainstream 3D CAD) |
| 2005 | Acquired Abaqus (finite element simulation → became SIMULIA) |
| 2012 | Launched 3DEXPERIENCE platform — unified cloud/on-prem platform connecting all brands |
| 2014 | Acquired Accelrys → created BIOVIA (molecular modeling, materials science) |
| 2018 | Acquired majority stake in Centric Software (fashion/retail PLM) |
| 2019-10 | Acquired Medidata Solutions ($5.8B) — clinical trials, life sciences virtual twins |
| 2025 | Joined KUKA mosaixx digital ecosystem for robotics simulation |
| 2026-02 | Pascal Daloz promoted to Chairman & CEO (Bernard Charlès stepped down) |
| 2026-02 | NVIDIA strategic partnership announced at 3DEXPERIENCE World — Industry World Models, Omniverse integration, AI physics |
| 2026-04 | Hannover Messe — humanoid robot design demo, DELMIA + NVIDIA autonomous factory showcase |

### Acquisitions — What Each Brought

#### Medidata Solutions (2019)

- **Price**: $5.8B (all-cash, $92.25/share)
- **Technology**: Clinical trial platform — data management, analytics, patient-centric trial design
- **Integration**: Operates as Dassault Systèmes brand; life sciences became second-largest vertical after transportation/mobility
- **Significance**: Extended Virtual Twin concept from products to patients; diversified revenue into healthcare

#### Accelrys → BIOVIA (2014)

- **Price**: ~$750M
- **Technology**: Molecular modeling, lab informatics, materials science simulation
- **Integration**: Became BIOVIA brand on 3DEXPERIENCE platform
- **Significance**: Extended simulation from mechanical/structural to molecular and biological domains

<!-- TODO: deep research needed — SolidWorks acquisition terms, Centric Software deal structure, smaller bolt-on acquisitions -->

---

## 2. Product Architecture Details

### 3DEXPERIENCE Platform

| Aspect | Details |
| --- | --- |
| **Architecture** | Unified platform connecting 12 brands (CATIA, SIMULIA, DELMIA, ENOVIA, BIOVIA, Medidata, etc.). Cloud SaaS + on-premises deployment. Web-based collaboration with role-based apps. |
| **Runtime dependencies** | On-prem: RHEL 9 supported. Cloud: OUTSCALE sovereign cloud (SecNumCloud 3.2) or public cloud partners. |
| **Extension model** | Partner ecosystem, marketplace apps, API access. KUKA mosaixx integration demonstrated. |
| **Key limitations** | Heavy platform — complex deployment, steep learning curve. Cloud migration ongoing (25% of software revenue from cloud in 2025). Proprietary data formats create switching costs. |

### SIMULIA (Physics Simulation)

| Aspect | Details |
| --- | --- |
| **Architecture** | Multi-physics simulation suite. Core: Abaqus (structural FEA), CST (electromagnetics), PowerFLOW (CFD), Tosca (topology optimization). New: AI-based Virtual Twin Physics Behavior using NVIDIA CUDA-X. |
| **Runtime dependencies** | HPC clusters for large simulations. NVIDIA GPU acceleration for AI physics (CUDA-X libraries). |
| **Extension model** | User subroutines (Abaqus), scripting API, integration with CATIA/DELMIA through 3DEXPERIENCE. |
| **Key limitations** | Computationally expensive — requires HPC infrastructure. AI physics acceleration (NVIDIA partnership) still emerging. |

### DELMIA (Manufacturing & Robotics)

| Aspect | Details |
| --- | --- |
| **Architecture** | Manufacturing operations platform: process planning, robotics simulation (1,500+ robot types), virtual commissioning, factory layout, AMR fleet planning. Now integrating NVIDIA Omniverse physical AI libraries for autonomous factory simulation. |
| **Runtime dependencies** | 3DEXPERIENCE platform. NVIDIA Omniverse for physical AI features. GPU compute for real-time robotics simulation. |
| **Extension model** | Robot controller integration, OPC-UA connectivity to factory floor, PLC integration for virtual commissioning. |
| **Key limitations** | Design-time focused — runtime factory control requires additional integration. Autonomous factory capabilities (NVIDIA partnership) still in development. |

### OUTSCALE (Sovereign Cloud)

| Aspect | Details |
| --- | --- |
| **Architecture** | Sovereign cloud infrastructure — IaaS, PaaS, managed Kubernetes (OKS). SecNumCloud 3.2 certified (French national security standard). Deploying NVIDIA AI factories on 3 continents. |
| **Runtime dependencies** | Physical datacenters in France (primary), expanding to other sovereign jurisdictions. |
| **Extension model** | Marketplace (Red Hat OpenShift available), API-compatible with major cloud patterns. |
| **Key limitations** | Small scale vs hyperscalers. Geographic focus on European sovereign requirements. OKS competes with OpenShift but is less mature. |

<!-- TODO: deep research needed — OUTSCALE vs OpenShift feature comparison, OKS adoption metrics, NVIDIA AI factory deployment timeline -->

### Virtual Companions (Agentic AI)

| Aspect | Details |
| --- | --- |
| **Architecture** | Three domain-specific AI agents on 3DEXPERIENCE: Aura (requirements/project orchestration), Leo (multi-discipline engineering), Marie (scientific discovery in chemistry/biology). Built on NVIDIA Nemotron open models + Dassault industry world models. |
| **Runtime dependencies** | 3DEXPERIENCE platform, NVIDIA AI infrastructure, industry-specific knowledge graphs |
| **Extension model** | Not disclosed — likely closed to 3DEXPERIENCE platform |
| **Key limitations** | Early stage (announced Feb 2026). Domain-locked to 3DEXPERIENCE workflows. Not a general-purpose agent framework. |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **3DEXPERIENCE** | None identified | N/A | Unified PLM platform, collaboration, data management |
| **SIMULIA** | None identified (Abaqus is proprietary) | N/A | Multi-physics solvers, AI physics acceleration |
| **DELMIA** | NVIDIA Omniverse (USD-based, partially open) | Apache 2.0 (OpenUSD) | Robotics simulation, manufacturing domain models, virtual commissioning |
| **OUTSCALE OKS** | Kubernetes (CNCF) | Apache 2.0 | Managed service, SecNumCloud certification, sovereign isolation |
| **Virtual Companions** | NVIDIA Nemotron (open weights) | Permissive | Industry world models, domain-specific agent behavior |

### Pattern Analysis

Dassault Systèmes follows a "proprietary platform, selective OSS integration" pattern. The core 3DEXPERIENCE platform and major solvers (Abaqus, CATIA kernel) are fully proprietary — 40+ years of accumulated IP. OSS enters at the infrastructure and AI layers: Kubernetes underneath OUTSCALE, NVIDIA's partially-open Omniverse/USD ecosystem for physical AI, and Nemotron open models for Virtual Companions.

The NVIDIA partnership is the most significant OSS-adjacent development: OpenUSD (Apache 2.0) as the interchange format and Omniverse libraries bring open standards into Dassault's historically closed simulation stack.

### Notable Dependencies

- **NVIDIA CUDA-X**: SIMULIA AI physics depends on NVIDIA GPU ecosystem. No disclosed AMD/ROCm alternative.
- **NVIDIA Omniverse**: DELMIA physical AI features depend on Omniverse libraries. Deeper coupling than typical vendor integration.
- **Kubernetes**: OUTSCALE OKS uses upstream Kubernetes. Red Hat OpenShift available as alternative on OUTSCALE marketplace.

---

## 4. Governance & Community Risk

Not directly applicable — Dassault Systèmes does not steward major OSS projects. However, their increasing dependence on NVIDIA-governed open ecosystems (OpenUSD, Omniverse, Nemotron) creates indirect governance exposure.

<!-- TODO: deep research needed — Dassault's role in OpenUSD Alliance, contributions to NVIDIA open projects, any OSS releases from Dassault R&D -->

---

## 5. Hardware Platform Details

Not applicable — Dassault Systèmes is a pure software company. No proprietary hardware.

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **NVIDIA** | Strategic | Long-term partnership (Feb 2026). NVIDIA adopts Dassault MBSE for AI factory design; Dassault integrates Omniverse, CUDA-X, Nemotron. | Deep — joint architecture for Industry World Models, cross-platform integration |
| **Red Hat** | Infrastructure | OpenShift on OUTSCALE marketplace; 3DEXPERIENCE Server certified on RHEL 9 | Platform-level — OS and container runtime |
| **KUKA** | Robotics | Joined KUKA mosaixx ecosystem (2025) | Robot model library integration in DELMIA |
| **Omron** | Manufacturing | NVIDIA physical AI + Dassault Virtual Twin for autonomous production | Pilot/demo stage |
| **Lucid Motors** | Automotive | SIMULIA + AI physics for EV engineering | Customer deployment |
| **Westwood Robotics** | Humanoid | THEMIS humanoid robot linked to 3DEXPERIENCE (MWC 2026 demo) | Demo/showcase |

### Developer Ecosystem

Large established ecosystem — 390,000 customers, partner certification programs, annual 3DEXPERIENCE World conference, extensive documentation and training. Developer community primarily in CAD/PLM/simulation, not robotics-native. The NVIDIA partnership may bring new Physical AI developer engagement.

---

## 7. Detailed Competitive Analysis

### vs Siemens (Xcelerator / Tecnomatix)

| Dimension | Dassault Systèmes | Siemens |
| --- | --- | --- |
| **Platform** | 3DEXPERIENCE (unified cloud/on-prem) | Xcelerator (portfolio of distinct tools) |
| **Simulation** | SIMULIA multi-physics (Abaqus, CST, PowerFLOW) | Simcenter (Star-CCM+, FLOEFD, Amesim) |
| **Manufacturing DT** | DELMIA + NVIDIA Omniverse | Tecnomatix + NVIDIA Omniverse |
| **Edge/IoT** | No offering (cloud/design-time focus) | MindSphere / Industrial Edge (deployed) |
| **Hardware** | None | PLCs, drives, factory automation hardware |
| **AI partnership** | NVIDIA (exclusive strategic) | NVIDIA (also strategic, plus Microsoft) |
| **Sovereign cloud** | OUTSCALE (SecNumCloud) | No equivalent |
| **Revenue** | $7.1B | €18.9B (Digital Industries ~€4.7B) |

Both Dassault and Siemens have NVIDIA Omniverse partnerships, but Dassault's is positioned as a deeper architectural integration ("Industry World Models") while Siemens focuses on factory-floor digital twins.

### vs PTC (Creo / Windchill / ThingWorx)

| Dimension | Dassault Systèmes | PTC |
| --- | --- | --- |
| **Platform breadth** | 12 brands, 390K customers | Focused: Creo, Windchill, ThingWorx, Vuforia, ServiceMax |
| **Simulation** | Deep (SIMULIA multi-physics) | Limited (Creo Simulation, relies on partners) |
| **IoT / AR** | Weak (OUTSCALE cloud-centric) | Strong (ThingWorx IoT, Vuforia AR) |
| **SaaS transition** | 25% cloud revenue, growing | Onshape (cloud-native CAD), SaaS-first strategy |
| **Revenue** | $7.1B | ~$2.3B |

PTC's IoT/AR strength (ThingWorx, Vuforia) gives it factory-floor presence that Dassault lacks, but Dassault's simulation depth and NVIDIA partnership create a stronger Physical AI story for autonomous factory design.

---

## Sources

- [Dassault Systèmes + NVIDIA partnership](https://nvidianews.nvidia.com/news/dassault-systemes-nvidia-industrial-ai)
- [Jensen Huang at 3DEXPERIENCE World 2026](https://blogs.nvidia.com/blog/huang-3dexperience-2026/)
- [DELMIA & NVIDIA autonomous factories](https://www.roboticstomorrow.com/story/2026/02/delmia-nvidia-hardcoding-the-future-of-autonomous-factories/26164/)
- [Dassault + NVIDIA Industry World Models — Next Platform](https://www.nextplatform.com/2026/02/04/dassault-and-nvidia-bring-industrial-world-models-to-physical-ai/)
- [Dassault FY2025 results](https://www.3ds.com/newsroom/press-releases/dassault-systemes-q4-revenue-growth-1-solid-operating-margin-and-eps-expansion-initiating-2026-revenue-guidance-3-5-growth)
- [Dassault Q1 2026 results](https://investor.3ds.com/news-releases/news-release-details/dassault-systemes-reports-first-quarter-2026-results-line)
- [OUTSCALE OKS sovereign Kubernetes](https://www.3ds.com/newsroom/press-releases/outscale-enhances-outscale-kubernetes-service-support-and-accelerate-sovereign-ai-initiatives)
- [3DEXPERIENCE Server on RHEL 9](https://www.3ds.com/support/hardware-and-software/3dexperience-server-support-red-hat-enterprise-linux-9)
- [Hannover Messe 2026 showcase](https://www.3ds.com/newsroom/media-alerts/mobile-robots-industrial-ai-and-virtual-twins-dassault-systemes-builds-factory-future-hannover-messe)
- [Dassault industrial AI blog](https://blog.3ds.com/topics/company-news/industrial-ai-with-virtual-twins/)
- [DELMIA Robotics capabilities](https://www.3ds.com/products/delmia/industrial-engineering/robotics)
- [Dassault acquisitions history](https://www.3ds.com/about/company/acquisitions)
- [NVIDIA Omniverse DSX + Vera Rubin](https://nvidianews.nvidia.com/news/nvidia-releases-vera-rubin-dsx-ai-factory-reference-design-and-omniverse-dsx-digital-twin-blueprint-with-broad-industry-support)
