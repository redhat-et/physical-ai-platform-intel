# FANUC — Deep Dive Research

**Date**: 2026-07-17
**Last updated**: 2026-07-17
**Classification**: Internal analysis — not for public repo

Supporting research for the [FANUC competitive profile](fanuc.md). Covers FANUC's product architectures, OSS foundations, partnership details, and competitive dynamics relevant to Physical AI platform strategy.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1955 | Founded by Seiuemon Inaba as Fuji Automatic Numerical Control |
| 1972 | First commercial industrial robot |
| 1982 | GMFanuc joint venture with General Motors (dissolved 1992) |
| 2016 | FIELD system launched (IoT edge platform) |
| 2019 | CRX collaborative robot series launched |
| 2025-12 | IREX Tokyo: Demonstrated NVIDIA Isaac Sim integration and AI-powered bin picking. 1,000+ robots shipped for Physical AI applications |
| 2026-01 | CRX-3iA portable cobot (11 kg weight, 3 kg payload) introduced |
| 2026-02 | Intrinsic folded from Alphabet Other Bets into Google core business |
| 2026-03 | NVIDIA GTC: ROBOGUIDE integrated with Isaac Sim and Omniverse; FANUC robots available as OpenUSD SimReady assets |
| 2026-05 | Google/Intrinsic flagship partnership announced: all FANUC robots supported on Flowstate. Gemini Enterprise integration via Google Cloud. FANUC shares surged 16% |
| 2026 | R-50iA next-generation controller announced |

### Acquisitions — What Each Brought

FANUC has made no significant acquisitions relevant to Physical AI. The company follows an organic growth and partnership strategy, preferring to integrate external AI (Intrinsic, NVIDIA, PFN) rather than acquire it. This is consistent with its conservative, profitability-focused culture (zero debt, ~22.5% operating margins, highly automated production in Oshino).

---

## 2. Product Architecture Details

### R-30iB Plus / R-50iA Controllers

| Aspect | Details |
| --- | --- |
| **Architecture** | Proprietary RTOS running on custom hardware. Hard real-time motion control with sub-millisecond servo loops. Integrated safety (DCS — Dual Check Safety), fieldbus connectivity (EtherNet/IP, PROFINET, DeviceNet, CC-Link), iRVision processing |
| **Runtime dependencies** | Fully self-contained: no external PC, no network required for basic operation. Optional: FIELD system connectivity, Flowstate/IntrinsicOS companion compute |
| **Extension model** | KAREL (proprietary structured programming language) for custom logic; TP (Teach Pendant) programs for basic operation; paid software options for advanced features (Remote Motion, HMI Device, ROS 2 Interface). Third-party access via FIELD system REST APIs |
| **Key limitations** | Closed platform — no Linux, no containers, no standard programming languages. KAREL is FANUC-specific with no ecosystem outside FANUC. R-50iA architecture details not yet disclosed |

### FIELD System

| Aspect | Details |
| --- | --- |
| **Architecture** | Edge computing platform running Linux with Docker container support. Collects data from FANUC and third-party equipment (via OPC UA). REST API for third-party applications. ZDT (Zero Down Time) predictive maintenance as flagship app |
| **Runtime dependencies** | Linux-based; Docker for containerized apps; Cisco networking infrastructure (partnership); connected to FANUC Cloud for analytics |
| **Extension model** | Open REST API; Docker container deployment; partner applications (Preferred Networks deep learning, Rockwell FactoryTalk integration) |
| **Key limitations** | Launched 2016 — aging architecture. No Kubernetes, no GitOps, no modern MLOps integration. May be functionally superseded by Intrinsic/Flowstate for AI workloads. Current adoption and evolution status unclear |

### ROBOGUIDE Simulation

| Aspect | Details |
| --- | --- |
| **Architecture** | Windows-based offline programming and simulation. 3D workcell design with FANUC robot kinematic models. Cycle time estimation, collision detection, path optimization |
| **Runtime dependencies** | Windows PC; FANUC-specific robot models |
| **Extension model** | Import/export of robot programs (TP/KAREL); now integrated with NVIDIA Isaac Sim and Omniverse for physics-based simulation and digital twins |
| **Key limitations** | Windows-only; no headless/server mode for automated testing; FANUC robots only (no multi-vendor workcells). Isaac Sim integration extends capabilities but adds NVIDIA dependency |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **R-30iB Plus** | None | — | Entire controller: RTOS, motion planning, safety, fieldbus stack |
| **ROBOGUIDE** | None | — | Entire simulation environment; now bridges to Isaac Sim (NVIDIA proprietary) |
| **FIELD system** | Linux + Docker | Various OSS | Edge orchestration, ZDT analytics, MT-LINKi monitoring, partner app framework |
| **iRVision** | None | — | Entire vision pipeline; runs on controller hardware with no external dependencies |
| **ROS 2 driver** | ROS 2 | Apache 2.0 (PC-side) | PC-side client is free/open-source. Robot-side requires paid software options (Remote Motion, HMI Device, ROS 2 Interface — bundled as "External Control Package") |

### Pattern Analysis

FANUC follows a **"closed core, open periphery"** pattern. The controller (R-30iB/R-50iA) is entirely proprietary — no OSS components, no Linux, no standard APIs beyond fieldbus protocols. The FIELD system introduces a Linux + Docker layer for edge computing, but it sits alongside the controller rather than replacing it. The ROS 2 driver (released on GitHub as [FANUC-CORPORATION/fanuc_driver](https://github.com/FANUC-CORPORATION/fanuc_driver)) opens the robot to the ROS 2 ecosystem for external motion planning, simulation, and application development — but the robot-side interface requires paid FANUC software options.

This hybrid model — free PC-side client, paid robot-side interface — is the standard hardware OEM pattern (similar to Universal Robots' RTDE/URCap model). It allows ecosystem participation while preserving controller revenue. The Intrinsic/Flowstate integration adds another proprietary layer (IntrinsicOS) between FANUC's hardware and AI applications, further abstacting the controller.

### Notable Dependencies

- **Intrinsic/Google**: Flowstate is becoming the primary AI programming interface for FANUC robots. All FANUC models are supported. This creates a Google dependency for AI capabilities — FANUC does not build its own AI
- **NVIDIA**: Isaac Sim integration for digital twins and simulation. NVIDIA Jetson modules for edge AI inference. OpenUSD SimReady assets for FANUC robots. This is complementary to (not competing with) the Intrinsic partnership — Intrinsic handles programming, NVIDIA handles simulation
- **Preferred Networks**: Japan's largest AI unicorn, long-standing partner for deep learning on FIELD system. PFN provides bin picking AI and anomaly detection. This is a Japan-specific partnership that predates the Intrinsic deal

---

## 4. Governance & Community Risk

FANUC does not steward any significant OSS projects. The ROS 2 driver ([FANUC-CORPORATION/fanuc_driver](https://github.com/FANUC-CORPORATION/fanuc_driver)) is FANUC-published but small in scope (driver, not framework). No governance analysis needed.

FANUC's risk is inverted: it depends on others' governance decisions:

| Dependency | Risk |
| --- | --- |
| **ROS 2** | Governed by OSRA (Intrinsic/Google employs most maintainers). Low direct risk to FANUC — ROS 2 is a standard, not a single-vendor product |
| **Intrinsic/Flowstate** | Proprietary Google product. Google reorganized Intrinsic from Other Bets to core business (Feb 2026) — signals commitment, but Google's track record of product discontinuation is a known risk |
| **NVIDIA Isaac Sim** | Proprietary. Omniverse dependency. NVIDIA is unlikely to discontinue but may change pricing or lock-in terms |

---

## 5. Hardware Platform Details

### Current Hardware

#### Industrial Robot Families

| Family | Payload | Reach | Key Application |
| --- | --- | --- | --- |
| LR Mate | 3–14 kg | 550–911 mm | Small parts assembly, machine tending |
| M-10/M-20 | 10–25 kg | 1,108–2,009 mm | Material handling, welding |
| M-710/M-900 | 50–700 kg | 2,050–3,100 mm | Heavy material handling, spot welding |
| M-2000 | 900–2,300 kg | 3,100–3,734 mm | Largest payload industrial robot |
| CRX Series | 3–50 kg | 590–1,889 mm | Collaborative (12 models). Drag-and-drop teach |
| SCARA | 3–20 kg | 350–1,000 mm | Pick-and-place, assembly |
| Delta | 1–12 kg | — | High-speed picking |
| Paint | Various | Various | Automotive and general painting |

#### Controllers

| Model | Status | Key Features |
| --- | --- | --- |
| R-30iB Plus | Current | Real-time RTOS, DCS safety, integrated iRVision, KAREL/TP, fieldbus, ROS 2 interface option |
| R-50iA | Announced 2026 | Next-generation; details not disclosed. Expected to support AI acceleration |

### Roadmap

| Product | Timeline | Key Changes |
| --- | --- | --- |
| **R-50iA** | 2026 | Next-gen controller; architecture details pending |
| **CRX expansion** | Ongoing | 12 models now; CRX-3iA (Jan 2026) adds portable segment |
| **Flowstate integration** | 2026+ | All FANUC robots progressively integrated with Intrinsic/Flowstate |
| **Isaac Sim digital twins** | 2026+ | ROBOGUIDE → Isaac Sim pipeline for AI training |

### Pricing

FANUC does not publicly disclose robot pricing. Typical ranges (via integrators):

| Segment | Estimated Price Range | Notes |
| --- | --- | --- |
| CRX cobots | $25K–$60K | Robot only; total cell $50K–$150K |
| Small industrial (LR Mate) | $25K–$50K | Robot only |
| Medium industrial (M-10/M-20) | $40K–$80K | Robot only |
| Large industrial (M-710+) | $80K–$300K+ | Robot only; heavy-payload commands premium |

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Intrinsic (Google)** | 1,000+ robots with Physical AI | Flagship partner. All FANUC robots on Flowstate. Gemini Enterprise via Google Cloud | Deep: IntrinsicOS runs alongside FANUC controller; Gemini provides AI reasoning |
| **NVIDIA** | — | ROBOGUIDE + Isaac Sim integration; OpenUSD SimReady assets; Jetson edge AI | Moderate: simulation and digital twin layer; complementary to Intrinsic |
| **Rockwell Automation** | — | Joint ventures since 1990s; FANUC robots in FactoryTalk ecosystem | Deep: co-selling in North American market |
| **Preferred Networks** | — | Deep learning for FIELD system; bin picking and anomaly detection | Moderate: AI apps on FIELD edge platform |
| **Cisco** | — | Networking infrastructure for FIELD system and connected factory | Infrastructure: networking layer |

### Developer Ecosystem

- **250+ authorized system integrators** globally — FANUC's primary go-to-market channel
- **KAREL programming**: Proprietary structured language for controller customization. Active user community but no open ecosystem
- **TP programs**: Standard teach pendant programming for basic applications
- **ROS 2 driver**: Opens FANUC robots to the 100K+ ROS developer ecosystem. Supports MoveIt2 and Gazebo simulation
- **FIELD system apps**: Third-party Docker apps for edge analytics. Ecosystem size undisclosed
- **FANUC Academy**: Training programs in major markets. Physical training centers

---

## 7. Detailed Competitive Analysis

### vs ABB

| Dimension | FANUC | ABB |
| --- | --- | --- |
| **Installed base** | 1.1M robots + 5M CNCs | 500K+ robots |
| **AI partner** | Intrinsic/Google (flagship) | Skild AI (foundation model) |
| **Simulation** | ROBOGUIDE + Isaac Sim | RobotStudio (more modern, web-based) |
| **Cloud/IoT** | FIELD system (aging) | ABB Ability (mature cloud platform) |
| **Cobots** | CRX series (12 models, competing) | GoFa / SWIFTI (established) |
| **Reliability** | MTBF >100K hrs (industry highest) | Strong but FANUC's reliability is legendary |
| **Revenue** | ~$5.4B (diversified: CNC + robot + robomachine) | ~$32B total (robotics is one division) |

### vs KUKA

| Dimension | FANUC | KUKA |
| --- | --- | --- |
| **Ownership** | Independent, publicly traded Japan | Midea Group (China) since 2016 |
| **AI strategy** | Intrinsic/Google partnership | Flowstate partner + Nate Koenig hire (Gazebo creator) |
| **Software openness** | Closed controller + ROS 2 driver | KUKA.OS (more modern, Linux-based) |
| **Geographic strength** | Asia-Pacific, Americas | Europe (automotive), China (via Midea) |
| **Geopolitical risk** | None (Japan) | Chinese ownership limits US/EU government contracts |

---

## Sources

- [FANUC-Google collaboration press release](https://www.fanuc.co.jp/en/profile/pr/newsrelease/2026/notice20260513.html)
- [Intrinsic blog on FANUC integration](https://www.intrinsic.ai/blog/posts/accelerating-physical-ai-fanuc-integrates-with-intrinsic-and-flowstate)
- [FANUC-NVIDIA partnership (GTC 2026)](https://www.fanucamerica.com/news-resources/fanuc-america-press-releases/2026/03/16/fanuc-accelerates-physical-ai-in-industrial-robotics-leveraging-nvidia-technologies)
- [FANUC Physical AI overview](https://www.fanucamerica.com/solutions/physical-ai)
- [FANUC ROS 2 driver (GitHub)](https://github.com/FANUC-CORPORATION/fanuc_driver)
- [FANUC ROS 2 overview](https://www.fanucamerica.com/solutions/ros-2-driver)
- [FANUC FIELD system](https://www.fanuc.co.jp/en/product/field/index.html)
- [FANUC Wikipedia](https://en.wikipedia.org/wiki/FANUC)
