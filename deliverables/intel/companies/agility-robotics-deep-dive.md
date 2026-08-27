# Agility Robotics — Deep Dive Research

**Date**: 2026-07-22
**Last updated**: 2026-07-22
**Classification**: Internal analysis — not for public repo

Supporting research for the [Agility Robotics competitive profile](agility-robotics.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, product architecture, manufacturing details, and competitive dynamics.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2015 | Founded as Oregon State University spinout by Damion Shelton, Jonathan Hurst, Mikhail Jones. Based on Hurst's Dynamic Robotics Lab work on legged locomotion |
| 2017 | Introduced Cassie — bipedal research robot, precursor to Digit |
| 2019 | Launched first Digit prototype — bipedal humanoid with arms for carrying |
| 2020 | Ford partnership announced for last-mile delivery concept |
| 2022 | Digit v3 introduced with updated design for warehouse logistics |
| 2023 | Amazon begins testing Digit for tote recycling. RBR50 Robot of the Year. First OSHA-recognized safety field inspection for a humanoid |
| 2024-03 | Launched Agility Arc fleet orchestration platform at MODEX |
| 2024 | Peggy Johnson (ex-Magic Leap CEO, ex-Microsoft) appointed CEO. Damion Shelton moves to Chairman/Chief Engagement Officer |
| 2024 | RoboFab opens in Salem, OR — 70K sq ft, 10K units/year nameplate capacity |
| 2024 | RBR50 Robot of the Year (second consecutive) |
| 2025-03 | Series C: $400M at $2.1B valuation. Total raised ~$683M |
| 2025-03 | Expanded NVIDIA partnership at GTC 2025: Isaac Sim/Lab adoption, Jetson AGX Thor integration |
| 2025 | GXO multi-year commercial RaaS agreement — industry first. 100K+ totes moved |
| 2026-06 | SPAC merger with Churchill Capital Corp XI announced. $2.5B valuation, $620M gross proceeds. Ticker: AGLT |
| 2026 | First to integrate NVIDIA Halos safety system. Preparing Digit v5 commercial launch |

### Acquisitions — What Each Brought

No acquisitions disclosed. Agility has grown organically from its OSU spinout roots. All IP (locomotion, manipulation, Arc software) developed in-house.

---

## 2. Product Architecture Details

### Digit v4 / v5

| Aspect | Details |
| --- | --- |
| **Architecture** | Bipedal humanoid: 175 cm, 65 kg, 28 DOF (4 per arm). Sensor fusion pipeline: 4× Intel RealSense depth cameras (360° spatial awareness) + onboard LiDAR (3D mapping) + MEMS IMU/gyroscope (balance) + force sensors per arm (compliant manipulation). No external infrastructure required (no QR codes, magnetic strips) |
| **Compute** | NVIDIA Jetson AGX Thor (Blackwell-class). Runs locomotion policy, perception, and manipulation inference onboard. v5 adds Halos Core safety layer on IGX Thor |
| **Locomotion model** | Whole-body control foundation model trained via reinforcement learning. Simulation-first pipeline: MuJoCo (physics) + NVIDIA Isaac Lab (RL framework). Virtual Digit discovers movements via reward optimization, not prescriptive rules |
| **Runtime dependencies** | NVIDIA Jetson AGX Thor (compute), L4T (OS), CUDA (acceleration), Intel RealSense SDK. Cloud connectivity to Arc for fleet management (not required for autonomous operation) |
| **Extension model** | Closed. Arc provides WMS/WES/MES integration APIs but robot behaviors are not user-programmable |
| **Key limitations** | 16 kg payload (v4) limits to light tote handling; simpler grippers vs competitors' dexterous hands (Figure AI 16-DOF); ~8 hr battery (v4, v5 targets 22 hr); bipedal-only — no wheeled mode for efficiency on flat surfaces |

### Digit v5 Delta

| Aspect | v4 → v5 Change |
| --- | --- |
| **Payload** | 16 kg → 23 kg (50 lb) |
| **Reach** | Standard → 7.2 ft |
| **Battery** | ~8 hr → ~22 hr (rapid-charge) |
| **Safety** | OSHA field inspection → "cooperatively safe" (barrier-free) via NVIDIA Halos |
| **Backlog** | — $300M+ multi-year orders |

### Agility Arc

| Aspect | Details |
| --- | --- |
| **Architecture** | Cloud-native SaaS. Real-time fleet monitoring, task assignment, KPI dashboards (uptime, throughput, MTBI, robot status). SSO + RBAC + encrypted comms |
| **Integration** | Standard APIs for WMS, WES, MES. Connects Digit to existing warehouse automation (AMRs, conveyors, management systems) |
| **Extension model** | API-based integration. Mixed-fleet orchestration (Digit + AMRs + conveyors) |
| **Key limitations** | Cloud-dependent (no on-prem option disclosed). Digit-only — not available as general fleet management for third-party robots |

<!-- TODO: deep research needed — Arc architecture details, cloud provider, API specifications -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Digit locomotion** | MuJoCo (Google DeepMind) | Apache 2.0 | Whole-body control foundation model (RL-trained proprietary policy) |
| **Digit training** | NVIDIA Isaac Lab | BSD-3-Clause | Training pipeline, reward shaping, sim-to-real transfer procedures |
| **Digit perception** | Intel RealSense SDK | Apache 2.0 | Proprietary sensor fusion across LiDAR + 4× depth cameras + IMU |
| **Digit compute** | L4T (Jetson Linux) | NVIDIA proprietary | Integration with proprietary locomotion/perception stack |
| **Agility Arc** | Unknown | — | Full fleet orchestration platform |

### Pattern Analysis

Agility follows an **"open simulation engine + proprietary policy"** pattern. The simulation and RL training tools are open-source (MuJoCo, Isaac Lab), but the trained policies, sensor fusion, and fleet orchestration software are fully proprietary. This differs from companies like NVIDIA that steward both the tools and the outputs.

The choice of MuJoCo + Isaac Lab is pragmatic: both are industry-standard for legged robot sim-to-real transfer, and using open tools avoids dependency on a single vendor's simulation stack. However, the trained policies and the operational data (65K+ hours) represent the real competitive moat — these are not shared.

Arc's OSS foundations are undisclosed. Given its cloud-native architecture with SSO/RBAC, it likely uses standard web frameworks, but no specific dependencies have been identified.

### Notable Dependencies

- **NVIDIA Jetson AGX Thor**: Critical hardware dependency. Digit's onboard compute is entirely NVIDIA silicon. Migration to alternative accelerators (Qualcomm, AMD) would require significant software rework.
- **NVIDIA Halos**: Digit v5's safety certification strategy depends on Halos Core. This creates a dependency on NVIDIA's safety ecosystem for the "cooperatively safe" differentiation.
- **Intel RealSense**: 4 cameras per robot. Intel discontinued RealSense consumer sales (2022) but maintains the industrial/robotics line. Supply continuity risk worth monitoring.

<!-- TODO: deep research needed — Arc technology stack, cloud provider dependencies -->

---

## 4. Governance & Community Risk

Not applicable. Agility does not steward any OSS projects. It is a consumer of open-source tools (MuJoCo, Isaac Lab, RealSense SDK) but does not contribute upstream in any disclosed capacity.

---

## 5. Hardware Platform Details

### Current Hardware

**Digit v4 Specifications:**

| Spec | Value |
| --- | --- |
| Height | 175 cm (5'9") |
| Weight | 65 kg |
| DOF | 28 (4 per arm) |
| Payload | 16 kg (35 lb) |
| Speed | 5.0 km/h walking |
| Battery | ~8 hours |
| Sensors | 4× Intel RealSense, LiDAR, MEMS IMU, force sensors per arm |
| Compute | NVIDIA Jetson AGX Thor |
| BOM | ~$125,000 |

### Roadmap

| Product | Timeline | Key Changes |
| --- | --- | --- |
| **Digit v5** | H2 2026 | 23 kg payload, 22-hr battery, 7.2 ft reach, NVIDIA Halos safety, barrier-free human collaboration |

### Pricing

| Model | Pricing |
| --- | --- |
| **Direct purchase** | ~$250,000 per unit |
| **RaaS** | $30/hr (operating cost $10-12/hr, path to $2-3/hr at scale) |
| **Arc** | SaaS subscription (bundled with RaaS, or separate for purchased units) |

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Amazon** | Pilot scale | Industrial Innovation Fund investor + pilot customer. Tote recycling use case | API-level — Digit integrates into Amazon warehouse workflows |
| **GXO Logistics** | Multi-site | Industry-first multi-year RaaS agreement. Spanx facility (Georgia). 100K+ totes moved | Embedded — Arc integrated with GXO warehouse execution systems |
| **Schaeffler** | Single site | Active commercial deployment — industrial manufacturing | API-level |
| **Toyota** | Single site | Toyota Motor Manufacturing Canada — active deployment | API-level |
| **Mercado Libre** | Single site | Latin American logistics — geographic expansion | API-level |
| **NVIDIA** | Technology partner | Jetson AGX Thor, Isaac Sim/Lab, Halos. Also investor (Series B/C) | Co-developed — Halos integration, Omniverse Blueprint collaboration |
| **Zion Solutions** | Channel | Systems integrator for customer deployment | Reseller / integration partner |

### Developer Ecosystem

No public developer ecosystem. Digit is not programmable by customers — all behaviors are developed in-house by Agility's software team. Arc provides integration APIs for warehouse systems but not a developer platform for custom robot behaviors. This contrasts with the ROS ecosystem approach taken by companies like Universal Robots.

<!-- TODO: deep research needed — developer documentation, API specifications, community engagement -->

---

## 7. Detailed Competitive Analysis

### vs Figure AI

| Dimension | Agility Robotics | Figure AI |
| --- | --- | --- |
| **Form factor** | Purpose-built logistics humanoid. Simpler grippers optimized for totes | General-purpose humanoid. 16-DOF hands with tactile sensing for dexterous manipulation |
| **AI approach** | RL-trained locomotion + classical perception. Simulation-first (MuJoCo + Isaac Lab) | End-to-end VLA (Helix 02). System 0/1/2 architecture. Replaced 100K+ lines of C++ with learned model |
| **Fleet software** | Arc — shipping SaaS platform with WMS/WES integration | No fleet orchestration software disclosed |
| **Commercial traction** | 9 customer sites, 65K+ operational hours, 100K+ totes, $300M+ backlog | BMW Spartanburg (30K+ vehicles, 40 units). UPS (reported) |
| **Manufacturing** | RoboFab: 10K/yr nameplate, ~8 units/shift current | BotQ: 12K/yr capacity, 1 robot every 90 minutes |
| **Valuation** | $2.5B (SPAC) | $39B (Series C, Sep 2025) |
| **Business model** | RaaS ($30/hr) + direct purchase ($250K) | Direct sale, exploring RaaS |
| **Target market** | Logistics narrow (totes, conveyors, warehouse traversal) | General-purpose (manufacturing, consumer, logistics) |

### vs Apptronik Apollo

| Dimension | Agility Robotics | Apptronik Apollo |
| --- | --- | --- |
| **Locomotion** | Bipedal, navigates ramps/dock plates/stairs | Bipedal, similar warehouse navigation |
| **Payload** | 16 kg (v4), 23 kg (v5) | 25 kg |
| **Heritage** | Oregon State University robotics lab | NASA / UT Austin human-centered robotics |
| **Fleet software** | Arc platform (shipping) | No disclosed fleet platform |
| **Partners** | Amazon, GXO, NVIDIA | Mercedes-Benz, GXO, NASA |
| **Deployments** | 9 commercial sites, 65K+ hrs | Limited pilot deployments |
| **Safety** | First OSHA inspection, NVIDIA Halos | ISO compliance path (details limited) |

---

## Sources

- [TechCrunch — SPAC announcement](https://techcrunch.com/2026/06/24/agility-robotics-plans-to-go-public-via-spac-in-a-2-5b-deal/)
- [GeekWire — SPAC financials](https://www.geekwire.com/2026/digit-maker-agility-robotics-to-go-public-in-2-5b-deal-heres-what-the-filings-say-about-its-finances/)
- [The Robot Report — SPAC](https://www.therobotreport.com/humanoid-maker-agility-robotics-go-public-through-spac-merger/)
- [Agility — Arc launch](https://www.agilityrobotics.com/content/agility-robotics-brings-operational-visibility-to-deployment-of-digit-fleets-with-the-launch-of-agility-arc-tm)
- [Agility — GXO agreement](https://www.agilityrobotics.com/content/gxo-signs-industry-first-multi-year-agreement-with-agility-robotics)
- [Agility — NVIDIA expansion](https://www.agilityrobotics.com/content/agility-robotics-expands-relationship-with-nvidia)
- [NVIDIA — Halos announcement](https://nvidianews.nvidia.com/news/nvidia-announces-halos-for-robotics-the-industrys-first-full-stack-safety-system-for-physical-ai)
- [Agility — AI and simulation](https://www.agilityrobotics.com/content/agility-and-ai)
- [Contrary Research — business breakdown](https://research.contrary.com/company/agility-robotics)
- [Interesting Engineering — going public](https://interestingengineering.com/ai-robotics/us-digit-robot-maker-agility)
- [IEEE Spectrum — RoboFab](https://spectrum.ieee.org/agility-humanoid-robotics-factory)
- [Agility — RoboFab](https://www.agilityrobotics.com/about/robofab)
- [Agility — leadership](https://www.agilityrobotics.com/about/leadership)
- [Agility — Peggy Johnson CEO](https://www.agilityrobotics.com/content/agility-robotics-appoints-peggy-johnson-as-chief-executive-officer)
