# ABB Robotics — Deep Dive Research

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

Supporting research for the [ABB Robotics competitive profile](abb.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: corporate timeline, product architecture, acquisition details, and competitive analysis.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1988 | ABB formed from merger of ASEA (Sweden) and Brown Boveri (Switzerland) |
| 2015 | ABB Ability IoT platform launched |
| 2017 | YuMi (IRB 14000) dual-arm cobot released — world's first truly collaborative dual-arm robot |
| 2021 | GoFa CRB 15000 cobot launched; Sevensense wins ABB Robotics Innovation Challenge |
| 2022 | OmniCore controller platform launched — unified controller for robots, cobots, AMRs |
| 2024-01 | ABB acquires Sevensense (ETH Zurich spin-off, visual SLAM for AMRs) |
| 2024 | GoFa family expanded to 5/10/12 kg payload variants |
| 2025-04 | ABB announces intention to spin off Robotics division |
| 2025-10 | ABB signs agreement to divest Robotics to SoftBank Group for $5.375B |
| 2026-02 | ABB introduces Automation Extended program (DCS evolution with AI/edge) |
| 2026-03 | NVIDIA partnership announced — RobotStudio HyperReality with Omniverse integration |
| 2026-06 | IRC5 controller phase-out (new installs must use OmniCore) |
| 2026-07 | AI-powered visual inspection platform launched for mid-market manufacturers |
| 2026 H2 | RobotStudio HyperReality general availability expected |
| Mid-late 2026 | SoftBank acquisition expected to close |

### Acquisitions — What Each Brought

#### Sevensense (January 2024)

- **Price**: Undisclosed (ABB participated in $7.7M Series A earlier)
- **Technology**: Visual SLAM navigation for AMRs — AI-based 3D vision enabling map creation, real-time updates, fleet-wide map sharing. Products: Alphasense Position (localization) and Alphasense Autonomy (full navigation).
- **Integration**: Became global product center for Visual SLAM AMRs within ABB Robotics, based in Zurich. ~35 employees retained. Technology runs on NVIDIA Jetson.
- **Significance**: Transforms ABB from pure industrial robot arm vendor into full mobile robotics player. Visual SLAM eliminates need for fixed infrastructure (reflectors, magnetic tape), reducing commissioning from weeks to days. ABB positions VSLAM as "gateway to generative AI and LLMs in mobile robotics."

---

## 2. Product Architecture Details

### OmniCore Controller

| Aspect | Details |
| --- | --- |
| **Architecture** | Modular controller platform managing industrial robots, cobots, and AMRs from single instance. Integrated AI processing, sensor fusion, cloud connectivity, edge computing. Replaces IRC5 (phase-out June 2026). |
| **Runtime dependencies** | Proprietary embedded platform. Exploring NVIDIA Jetson integration for edge AI inference. Cloud connectivity for ABB Ability telemetry. |
| **Extension model** | OmniCore SDK for custom applications. RAPID programming language for robot motion. SafeMove safety software for collaborative zones. PickMaster Twin for vision-guided picking. |
| **Key limitations** | Proprietary controller — no ROS 2 native support. AI inference capabilities still "exploring" Jetson integration (not shipping). RAPID language proprietary (not Python/C++ standard). |

<!-- TODO: deep research needed — OmniCore internal architecture, real-time OS, communication protocols, SDK capabilities, Jetson integration timeline -->

### RobotStudio HyperReality

| Aspect | Details |
| --- | --- |
| **Architecture** | RobotStudio offline programming + NVIDIA Omniverse simulation libraries. Virtual controller runs identical firmware to physical OmniCore — key differentiator enabling 99% sim-to-real accuracy. Supports synthetic data generation and VLA model training. |
| **Runtime dependencies** | NVIDIA Omniverse libraries (GPU-accelerated physics and rendering). ABB virtual controller. Desktop application. |
| **Extension model** | Inherits Omniverse extensibility (USD scene format, Python scripting). ABB-specific robot models in USD format. |
| **Key limitations** | ABB robot-specific (not a general-purpose sim). Omniverse dependency creates NVIDIA lock-in. H2 2026 availability — not yet shipping. |

### Visual SLAM AMRs (Sevensense)

| Aspect | Details |
| --- | --- |
| **Architecture** | Alphasense Position: stereo camera module + IMU for visual-inertial localization. Alphasense Autonomy: full autonomous navigation stack. AI-based 3D vision differentiates fixed vs mobile objects. Maps auto-update and share across fleet. |
| **Runtime dependencies** | NVIDIA Jetson edge compute. Stereo cameras. No fixed infrastructure required (reflector-free, tape-free). |
| **Extension model** | Sensor module integrates with third-party AMR chassis. Technology sold across segments (material handling, cleaning, service robotics). |
| **Key limitations** | Camera-only sensing (no LiDAR). NVIDIA Jetson dependency. Still early in large-scale fleet deployments. |

### ABB Ability Edgenius

| Aspect | Details |
| --- | --- |
| **Architecture** | Edge analytics platform: data collection from industrial assets, condition monitoring, asset health tracking, predictive analytics. Deployed at industrial edge. |
| **Runtime dependencies** | Runs on Red Hat OpenShift and Red Hat Device Edge. Also supports other container platforms. |
| **Extension model** | Modular analytics applications. Cloud connectivity to ABB Ability cloud. |
| **Key limitations** | Focused on operational analytics, not robot-specific AI. Separate from OmniCore robot control plane. |

<!-- TODO: deep research needed — Edgenius deployment architecture, specific Red Hat integration details, customer deployments on OpenShift -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **OmniCore** | None disclosed | N/A | Unified robot controller, AI processing, sensor fusion |
| **RobotStudio HyperReality** | NVIDIA Omniverse libs (proprietary) | N/A | Virtual controller, ABB robot models, offline programming |
| **Visual SLAM AMRs** | None disclosed (runs on Jetson) | N/A | Alphasense visual SLAM algorithms |
| **ABB Ability Edgenius** | Red Hat OpenShift / Kubernetes | Apache 2.0 (K8s) | Edge analytics applications, condition monitoring |
| **Robot hardware** | N/A | N/A | Mechanical design, motors, sensors, RAPID language |

### Pattern Analysis

ABB Robotics follows a "proprietary core + partner platforms" pattern. The robot control plane (OmniCore, RAPID, motion control) is entirely proprietary — this is the core competitive moat. For simulation, ABB partners with NVIDIA rather than building its own physics engine. For edge infrastructure, ABB runs on Red Hat OpenShift rather than building its own container platform.

This creates a clean separation: ABB owns the robot-specific layers (control, motion, safety) and partners for general-purpose infrastructure (simulation, edge platform, cloud). The Jetson exploration for OmniCore is notable — if realized, it would add NVIDIA silicon dependency to the controller hardware layer.

### Notable Dependencies

- **NVIDIA Omniverse**: RobotStudio HyperReality depends on Omniverse libraries for physics simulation and rendering. Deep coupling — not easily replaceable.
- **NVIDIA Jetson**: Visual SLAM AMRs run on Jetson. OmniCore exploring Jetson for edge AI. Potential for NVIDIA silicon lock-in across product line.
- **Red Hat OpenShift / Device Edge**: Edgenius runs on Red Hat platforms. Active production relationship.
- **SoftBank ownership (pending)**: New owner may shift platform partnerships.

---

## 4. Governance & Community Risk

Not applicable — ABB Robotics has no OSS projects or community governance structures. Edgenius runs on OpenShift but ABB does not steward any OSS projects.

---

## 5. Hardware Platform Details

### Current Robot Hardware

| Family | Type | Payload | Reach | Key Feature |
| --- | --- | --- | --- | --- |
| **IRB series** | Industrial (500+ variants) | 0.5–800 kg | Varies | Welding, painting, handling, machining |
| **GoFa CRB 15000** | Collaborative | 5/10/12 kg | Up to 1.62m | 6-axis torque sensors, Ultra Accuracy (0.03mm path) |
| **YuMi IRB 14000** | Collaborative (dual-arm) | 0.5 kg per arm | 559mm | Small parts assembly, electronics |
| **YuMi IRB 14050** | Collaborative (single-arm) | 0.5 kg | 559mm | Compact single-arm variant |
| **SWIFTI CRB 1100** | Speed-optimized cobot | 4 kg | 580mm | Industrial speed (6.2 m/s) with SafeMove zones |
| **Visual SLAM AMRs** | Autonomous mobile | Varies | N/A | Sevensense visual SLAM, NVIDIA Jetson, reflector-free |

### OmniCore Controller Variants

| Variant | Use Case |
| --- | --- |
| **OmniCore C30** | GoFa cobots |
| **OmniCore C90XT** | Large industrial robots |
| **OmniCore E10** | External axis control |

### Roadmap

| Product | Timeline | Key Changes |
| --- | --- | --- |
| **RobotStudio HyperReality** | H2 2026 | GA release with NVIDIA Omniverse integration |
| **OmniCore + Jetson** | TBD | Edge AI inference on controller hardware |
| **SoftBank ownership** | Mid-late 2026 | New investment priorities, potential AI acceleration |

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **NVIDIA** | — | Technology partnership (Mar 2026) | Omniverse integrated into RobotStudio; Jetson in VSLAM AMRs and exploring OmniCore |
| **SoftBank** | — | $5.375B acquisition (close mid-late 2026) | Full ownership; SoftBank's Physical AI portfolio |
| **Red Hat** | Production | Edgenius on OpenShift / Device Edge | Container platform for edge analytics |
| **Microsoft** | — | Azure integration for ABB Ability; Foundry Local for edge AI | Cloud + edge AI |
| **Foxconn** | Pilot | First HyperReality customer | Synthetic data training for electronics assembly |
| **WORKR** | Channel | SME manufacturer channel (GTC 2026 demo) | WorkrCore AI on ABB robots |
| **Ford** | Deployed | Visual SLAM AMRs at US production sites | Intralogistics automation |
| **Michelin** | Deployed | Visual SLAM AMRs at Spanish factory | Intralogistics automation |

### Developer Ecosystem

ABB has a mature developer ecosystem:

- **RobotStudio**: Widely used offline programming tool (industry standard for ABB customers)
- **RAPID**: Proprietary robot programming language — large user base but not open
- **ABB Robotics Community**: Tech community forums for robot programming and integration
- **NVIDIA Isaac Sim support package**: Community-contributed ABB robot models in USD format for Isaac Sim
- **OmniCore SDK**: Application development kit for controller extensions

---

## 7. Detailed Competitive Analysis

### vs FANUC

| Dimension | ABB Robotics | FANUC |
| --- | --- | --- |
| **Robot portfolio** | Industrial (IRB) + cobots (GoFa, YuMi, SWIFTI) + AMRs (VSLAM) | Industrial + cobots (CRX) — no AMR offering |
| **Controller** | OmniCore (unified for robots/cobots/AMRs) | R-30iB Plus (industrial), proprietary cobot controller |
| **Simulation** | RobotStudio HyperReality (NVIDIA Omniverse) | ROBOGUIDE (proprietary, no Omniverse integration) |
| **Sim-to-real** | Virtual controller with identical firmware — 99% accuracy | Good but separate simulation/real controller codebases |
| **Edge AI** | Exploring Jetson in OmniCore | FANUC FIELD system for edge data |
| **Ownership** | Divesting to SoftBank ($5.375B) | Independent, privately controlled |
| **Installed base** | Strong in Europe, Americas | Dominant in automotive, Asia |

### vs Universal Robots

| Dimension | ABB Robotics | Universal Robots |
| --- | --- | --- |
| **Cobot focus** | Part of broader portfolio (industrial + cobot + AMR) | Pure-play cobot vendor |
| **Market share** | #2-3 in cobots | #1 in cobots globally |
| **Ecosystem** | OmniCore SDK, RAPID language | UR+ marketplace (300+ products), Python/ROS support |
| **Ease of use** | Professional — requires training | Industry benchmark for simplicity |
| **AI integration** | NVIDIA partnership, HyperReality, VSLAM | Teradyne backing; less advanced AI integration |
| **Price point** | Higher (premium positioning) | Lower entry cost |

---

## Sources

- [ABB Robotics partners with NVIDIA](https://www.abb.com/global/en/news/134030/prsrl-abb-robotics-partners-with-nvidia-to-deliver-industrial-grade-physical-ai-at-scale)
- [ABB Robotics × NVIDIA — NVIDIA Blog](https://blogs.nvidia.com/blog/abb-robotics-omniverse/)
- [ABB acquires Sevensense](https://new.abb.com/news/detail/111398/abb-acquires-sevensense-expanding-leadership-in-next-generation-ai-enabled-mobile-robotics)
- [ABB divests Robotics to SoftBank](https://new.abb.com/news/detail/129685/abb-to-divest-robotics-division-to-softbank-group)
- [SoftBank acquisition details — Robot Report](https://www.therobotreport.com/abb-group-sells-abb-robotics-softbank-5-3b/)
- [OmniCore controller](https://www.abb.com/global/en/areas/robotics/products/controllers/omnicore)
- [RobotStudio HyperReality](https://www.abb.com/global/en/areas/robotics/innovation/robotstudio-hyperreality)
- [ABB and Red Hat — industrial edge](https://www.redhat.com/en/blog/abb-and-red-hat-delivering-operational-excellence-industrial-edge)
- [GoFa CRB 15000](https://one.robotics.abb.com/en/robots/p/GoFa-CRB-15000)
- [Sevensense Visual SLAM](https://www.sevensense.ai/blog/abb-acquires-sevensense-to-bring-new-value-to-mobile-robot-manufacturers)
- [ABB Ability Edgenius](https://new.abb.com/ca/ability)
- [ABB Automation Extended](https://new.abb.com/news/detail/133058/abb-introduces-automation-extended-enabling-industrial-innovation-with-continuity)
- [Robot simulation comparison 2026](https://www.grabarobot.com/blog/robot-simulation-software-comparison-2026/)
