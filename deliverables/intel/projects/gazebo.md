# Gazebo — Project Intelligence Report

**Date**: 2026-06-22
**Last updated**: 2026-06-22
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | Gazebo (OSRF / OSRA) |
| **Website** | [gazebosim.org](https://gazebosim.org/) |
| **Building block** | Simulation Engines |
| **Competes with** | MuJoCo (Google DeepMind), Newton (Linux Foundation), Genesis World (Genesis AI), Isaac Sim (NVIDIA), PyBullet (Erwin Coumans), Drake (Toyota Research Institute) |

### Repo Scope

Gazebo is a multi-repo project under the `gazebosim` GitHub org. The modular "gz" library architecture means the simulator is composed of ~15 libraries, each in its own repo.

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| [gazebosim/gz-sim](https://github.com/gazebosim/gz-sim) | Core | Analyzed | Primary simulator repo (1.4K stars). Orchestrates physics, rendering, sensors, transport |
| [gazebosim/gz-physics](https://github.com/gazebosim/gz-physics) | Core | Noted | Physics engine abstraction layer. Wraps DART, Bullet, TPE. 89 stars |
| [gazebosim/gz-rendering](https://github.com/gazebosim/gz-rendering) | Core | Noted | Rendering abstraction (OGRE 2.x). 78 stars |
| [gazebosim/gz-sensors](https://github.com/gazebosim/gz-sensors) | Core | Noted | Sensor models (camera, lidar, IMU, etc.). 163 stars |
| [gazebosim/gz-gui](https://github.com/gazebosim/gz-gui) | Core | Noted | Qt-based GUI framework. 102 stars |
| [gazebosim/gz-transport](https://github.com/gazebosim/gz-transport) | Core | Noted | Pub/sub and service transport layer (ZeroMQ). 52 stars |
| [gazebosim/gz-math](https://github.com/gazebosim/gz-math) | Core | Noted | Math library. 72 stars |
| [gazebosim/sdformat](https://github.com/gazebosim/sdformat) | Core | Noted | SDFormat parser — scene description format used by Gazebo. 214 stars |
| [gazebosim/ros_gz](https://github.com/gazebosim/ros_gz) | Ecosystem | Noted | ROS 1/2 integration bridge. 522 stars |
| [gazebosim/gz-omni](https://github.com/gazebosim/gz-omni) | Ecosystem | Noted | Isaac Sim (Omniverse) connector. 156 stars |
| [gazebosim/gz-usd](https://github.com/gazebosim/gz-usd) | Ecosystem | Noted | SDFormat ↔ USD converter. 46 stars |
| [gazebosim/gz-mujoco](https://github.com/gazebosim/gz-mujoco) | Ecosystem | Noted | MuJoCo integration. 39 stars |
| [gazebosim/gazebo-classic](https://github.com/gazebosim/gazebo-classic) | Peripheral | Excluded | Archived — Gazebo Classic (pre-Ignition). 1.3K stars |
| [gazebosim/docs](https://github.com/gazebosim/docs) | Peripheral | Excluded | Documentation. 85 stars |
| [gazebosim/design](https://github.com/gazebosim/design) | Peripheral | Excluded | Design proposals. 8 stars |

---

## Executive Summary

- **What it is**: Open-source multi-physics robotics simulator (since 2002), the standard companion to ROS; CPU-based with modular C++ architecture (physics, rendering, sensors, transport as separate libraries); governed by the OSRF via the Open Source Robotics Alliance (OSRA) with a diverse PMC
- **Health verdict**: Watch — strong governance (OSRA/OSRF with diverse PMC), 20+ years of community trust, and deep ROS integration, but Intrinsic (Alphabet) dominates recent code contributions (~50%+ of 12mo commits), release cadence has slowed (1 release in 12mo), and the CPU-based architecture faces competitive pressure from GPU-native simulators (Newton, Genesis World, Isaac Sim)
- **Technical verdict**: Adequate — most mature plugin architecture and battle-tested simulator (20+ years), but CPU-only physics limits relevance for GPU-parallel RL training workloads
- **Red Hat fit**: Align — strongest governance (OSRA/OSRF non-profit), no GPU vendor lock-in, no CLA, Apache-2.0, deep ROS integration, C++ systems alignment. Best platform fit but CPU-only constrains Physical AI training scope
- **Recommendation**: Partner (runner-up) — strongest open governance (OSRA PMC), no GPU vendor lock-in, deepest ROS 2 integration; preferred for deployment/validation workloads but CPU-only physics limits training-scale use; see [comparison](../project-comparisons/simulation-engines.md)

---

## Part A: Community & Project Health

### CHAOSS Metrics

<!-- Industry-standard community health metrics aligned with CHAOSS (https://chaoss.community) -->
<!-- Metrics are for gz-sim repo only. The full Gazebo project spans ~15 repos; gz-sim is the orchestrator and most active. -->

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | 1 org (Intrinsic/Alphabet at ~50%+ recent) | Low | All-time: 66% from "(unknown)" — but most are former Open Robotics employees (now at Intrinsic, Waabi, KUKA, or Honu Robotics). Recent 12mo: Intrinsic employees (iche033, scpeters, shameekganguly, arjo129, luca-della-vedova, azeey) account for ~50%+ of commits |
| **Contributor Absence Factor** | 2 people for 50% of all-time commits | Risk | chapulina (37%, now at Waabi — inactive), nkoenig (19%, now at KUKA — inactive). Recent 12mo is healthier: iche033 (Intrinsic) leads but no single person dominates |
| **Change Request Closure Ratio** | 615 opened / 534 closed in 12mo | Healthy (0.86) | 464 merged. Responsive to community PRs |
| **Time to First Response** | ~1h median | Fast | Sample of 10 recent PRs. PMC members and committers respond quickly |
| **Release Frequency** | 1 release in 12mo | Adequate | gz-sim10_10.0.0 (Oct 2025). Note: individual gz-* libraries may release independently; gz-sim releases are less frequent because they coordinate across all libraries |
| **Contribution Trend** | Narrowing | Narrowing | All-time CAF of 2 is misleading — the top 2 contributors (chapulina 37%, nkoenig 19%) have both left the project (Waabi and KUKA respectively). Recent 12mo activity is concentrated at Intrinsic (~50%+ of commits). The contributor base has effectively narrowed from the diverse Open Robotics era to Intrinsic-dominated development. Positive signal: XINJIANGMO (DLUT, 25 recent commits) represents genuine new community contribution. Honu Robotics (ex-Open Robotics consultancy) provides continuity but contributes modestly (~3% of recent commits) |
| **Libyears** | <!-- TODO: run project-tech-eval --> | | |

### Strategic Metrics

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | Permissive | Apache-2.0 (SPDX). All gz-* libraries use Apache-2.0. SDFormat uses Apache-2.0 |
| **Governance model** | Foundation | OSRF (Open Source Robotics Foundation) — 501(c)(3) non-profit. OSRA (Open Source Robotics Alliance) manages Gazebo via PMC + TGC oversight. OSRF holds trademarks. Charter publicly available |
| **Contribution model** | None | No CLA or DCO required. Standard GitHub PR workflow. Low barrier to contribute |
| **Corporate control risk** | Medium | OSRA governance genuinely distributes power (PMC has 4 orgs, TGC has broader membership). But Intrinsic (Alphabet) provides the majority of recent code contributions (~50%+ of 12mo commits) and employs 5 of 13 committers+PMC members. If Intrinsic reduced investment, development velocity would drop significantly. Mitigated by: OSRF holds trademarks, Honu Robotics provides independent PMC voice, OSRA charter prevents unilateral control |
| **Community health** | Maintained | 154 total contributors, but recent activity is concentrated. 1.4K stars on gz-sim (modest vs. competitors). Gazebo Classic archived. Community discourse is active. Google Summer of Code 2026 participation. OSRA approved $250K for infrastructure+docs improvements |
| **Ecosystem breadth** | Wide | Deep ROS integration (ros_gz), SDFormat as a widely-used scene format, Gazebo Fuel model repository, connectors to Isaac Sim (gz-omni), MuJoCo (gz-mujoco), USD (gz-usd). 20+ years of academic and industrial adoption. Used in DARPA challenges, NASA, DRC |

### Governance Details

#### PMC Members (Gazebo Project Management Committee)

| Member | Employer | Role |
| --- | --- | --- |
| **Addisu Z. Taddese** (azeey) | Intrinsic (Alphabet) | Project Leader. Also represents Gazebo on the TGC. 5 commits in recent 12mo |
| **Ian Chen** (iche033) | Intrinsic (Alphabet) | PMC member. Most active recent contributor (37 commits in 12mo). 791 all-time commits |
| **Steve Peters** (scpeters) | Intrinsic (Alphabet) | PMC member. 23 commits in 12mo. 378 all-time. Former OSRF |
| **Jenn Nguyen** (jennuine) | Intrinsic (Alphabet) | PMC member. 35 all-time commits. Former OSRF |
| **Michael Carroll** (mjcarroll) | Intrinsic (Alphabet) | PMC member |
| **Carlos Agüero** (caguero) | Honu Robotics | PMC member. 7 commits in 12mo. 101 all-time. Former OSRF |
| **Alejandro Hernández** (ahcorde) | Honu Robotics | PMC member. 91 all-time commits. Former OSRF |
| **Jose Luis Rivero** (j-rivero) | Honu Robotics | PMC member. FOSDEM 2026 speaker on Gazebo's future. Former OSRF |
| **Benjamin Perseghetti** (bperseghetti) | Rudis Labs | PMC member. 18 all-time commits. Independent community member |
| **Silvio Traversaro** (traversaro) | Italian Institute of Technology (IIT) | PMC member. Active in ROS and iDynTree. Independent academic voice |

#### Committers (Non-PMC)

| Committer | Employer | Commits (12mo) |
| --- | --- | --- |
| **Arjo Chakravarty** (arjo129) | Intrinsic (Alphabet) | 12 |
| **Shameek Ganguly** (shameekganguly) | Intrinsic (Alphabet) | 16 |
| **Luca Della Vedova** (luca-della-vedova) | Intrinsic (Alphabet) | 10. Newly approved mentored committer (Jun 2026) |
| **Saurabh Kamat** (sauk2) | ROS-Industrial | — |

#### Notable Historical Contributors (Now Inactive)

| Contributor | Current Employer | All-Time Commits | Note |
| --- | --- | --- | --- |
| **Louise Poubel** (chapulina) | Waabi (prev. OSRF/Open Robotics) | 2,123 (37%) | Largest all-time contributor. Former Ignition Technical Lead. Left Open Robotics ~2022 |
| **Nate Koenig** (nkoenig) | KUKA (prev. OSRF, Intrinsic) | 1,113 (19%) | Co-founder of OSRF, original Gazebo developer. Left Intrinsic for KUKA |
| **Mabel Zhang** (mabelzhang) | Heriot-Watt University (prev. Open Robotics) | 323 (6%) | Transitioned to academia |

#### Employer Breakdown (Recent 12mo Commits to gz-sim)

| Organization | Estimated Commits (12mo) | % | Note |
| --- | --- | --- | --- |
| Intrinsic (Alphabet) | ~103 | ~50% | iche033, scpeters, shameekganguly, arjo129, luca-della-vedova, azeey, methylDragon |
| Dalian University of Technology | ~25 | ~12% | XINJIANGMO — significant recent community contributor |
| Honu Robotics | ~7 | ~3% | caguero — ex-Open Robotics consultancy |
| Others / Community | ~70 | ~34% | ammaarrahmed, srmainwaring, ntfshard, taylorhoward92, gabrielfpacheco, peci1, etc. |

### Funding & Sustainability

Gazebo is stewarded by the **Open Source Robotics Foundation (OSRF)**, a 501(c)(3) non-profit founded in 2012. The **Open Source Robotics Alliance (OSRA)**, launched in 2024, manages Gazebo alongside ROS, Open-RMF, and shared infrastructure.

**Funding model**: OSRA membership tiers from corporate sponsors. Inaugural members include Intrinsic (Alphabet), NVIDIA, Qualcomm, Bosch, Apex.AI, Clearpath, Ekumen, eProsima, PickNik, Zettascale, and others. The TGC approved $250,000 in 2025-2026 for infrastructure and documentation improvements across OSRA projects.

**Historical funding shift**: Before 2022, OSRF received revenue from OSRC (its commercial subsidiary). When Intrinsic (Alphabet) acquired OSRC, those commercial revenue streams ended. OSRF now relies on OSRA membership fees, grants, and donations — a deliberate shift toward community-funded sustainability.

**Sustainability assessment**: Medium risk.

- **Intrinsic dependency**: Intrinsic (Alphabet) provides ~50% of recent code contributions and employs 5 of 10 PMC members plus 3 of 3 non-PMC committers (8 of 13 total). If Alphabet deprioritized robotics OSS (as it has done with other initiatives), Gazebo development capacity would be significantly impacted.
- **Honu Robotics as buffer**: Three PMC members from Honu Robotics (a consultancy founded by ex-Open Robotics engineers) provide an independent voice and development capacity. But Honu Robotics is a small firm (~1-10 employees) — it cannot replace Intrinsic's contribution volume.
- **OSRA governance is a strength**: The PMC structure, TGC oversight, and OSRF trademark ownership prevent unilateral control. The charter requires meritocratic advancement and PMC voting on roadmap decisions. This is materially stronger governance than most competitor simulators.
- **Competitive pressure**: GPU-native simulators (Newton, Genesis World, Isaac Sim) are attracting Physical AI researchers and startups. Gazebo's CPU-based physics may limit its relevance for large-scale RL training workloads. The Gazebo community is discussing this challenge openly ([community thread: "Genesis is here. Will Gazebo catch up?"](https://community.gazebosim.org/t/genesis-is-here-will-gazebo-catch-up/3313)).
- **Low star count signal**: gz-sim has 1.4K stars vs. Genesis World 29K, MuJoCo 8.7K. While star count is a noisy signal, the gap suggests Gazebo may be losing mindshare among newer researchers despite its industrial adoption.

**Mitigating factors**: 20+ years of community trust and ROS integration provide a deep moat for robotics deployments. The modular gz-* architecture allows upgrading individual components (e.g., replacing OGRE renderer with a GPU-accelerated one) without rewriting the whole stack. OSRA's Physical AI SIG (co-led by Intrinsic and NVIDIA) signals awareness of the GPU simulation trend. SDFormat is a widely-used scene description standard that creates ecosystem stickiness.

---

## Part B: Technical Analysis

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | Clear | Highly modular multi-repo architecture. Each gz-* library (physics, rendering, sensors, transport, math, GUI) has clean boundaries and independent APIs. Plugin-based system extensibility via gz-plugin. SimulationRunner orchestrates the ECS (Entity-Component-System) pattern |
| **Tech stack alignment** | Neutral | C++ native (CMake + Bazel build). ROS 2 integration via ros_gz bridge. Not Python-native (unlike competitors). Not PyTorch-integrated. Container support via Dockerfiles. Linux-primary |
| **Dependency health** | Watch | Complex C++ dependency tree across ~15 gz-* libraries. Each library pulls its own deps (OGRE 2.x for rendering, DART/Bullet for physics, ZeroMQ for transport, Qt for GUI). Heavy system-level dependencies. No Python-ecosystem deps to scan |
| **Test coverage** | Adequate | GoogleTest framework. Integration tests for physics, sensors, systems. Test files exist but only 2 detected at gz-sim level (many more in integration/ dir). Coverage not formally configured. Codecov not integrated |
| **Security posture** | Adequate | No SECURITY.md in gz-sim. No SBOM or signed releases. But OSRF/OSRA governance provides organizational security posture. Apache-2.0 license with SPDX |
| **Code quality signals** | Adequate | No linter configured in gz-sim (unusual for 2026). Pre-commit hooks present. Consistent code review via PMC. 50 TODOs (0.5/kLOC — mostly in vendored gz3d.js). Churn in SimulationRunner.cc and physics system (expected) |
| **Extensibility** | Plugin API | First-class plugin architecture via gz-plugin. Systems (physics, rendering, sensors) are all plugins. Users can create custom systems, sensors, and GUI widgets without modifying core. Strongest plugin API of the four projects |
| **Hardware portability** | Portable | CPU-based physics (DART, Bullet, TPE). No GPU requirement. Runs on any platform with a C++ compiler. OGRE 2.x rendering supports OpenGL/Vulkan. No CUDA dependency. Weakest GPU acceleration but strongest portability |

### Architecture Overview

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **gz-sim** | Top-level simulator orchestrator. ECS architecture, SimulationRunner, plugin loading | All gz-* libraries |
| **gz-physics** | Physics abstraction layer. Wraps DART, Bullet, TPE as interchangeable backends | DART, Bullet |
| **gz-rendering** | Rendering abstraction. Wraps OGRE 2.x | OGRE 2.3+ |
| **gz-sensors** | Sensor models: camera, lidar, IMU, depth, GPS, logical camera, contact | gz-rendering, gz-transport |
| **gz-transport** | Pub/sub and service communication layer (ZeroMQ-based) | ZeroMQ, Protobuf |
| **gz-gui** | Qt-based GUI framework for visualization and tooling | Qt 5/6 |
| **gz-math** | Math primitives: vectors, quaternions, poses, noise models | None (standalone) |
| **gz-plugin** | Cross-platform dynamic plugin loading library | None (standalone) |
| **sdformat** | SDFormat XML parser and scene description format | tinyxml2 |
| **ros_gz** | Bidirectional ROS 1/2 ↔ Gazebo bridge | ROS 2, gz-transport |

### Dependency Analysis

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **DART** | 6.x | BSD-2-Clause | Well-maintained physics engine (Georgia Tech). Primary physics backend |
| **Bullet** | 3.x | zlib | Alternative physics backend. Maintained by Erwin Coumans (Google) |
| **OGRE 2.x** | 2.3+ | MIT | Rendering engine. Active development. Moderate community |
| **ZeroMQ** | 4.x | LGPL-3.0 | Transport layer. LGPL — dynamic linking required for redistribution |
| **Qt** | 5/6 | LGPL-3.0 | GUI framework. LGPL — dynamic linking required |
| **Protobuf** | 3.x/4.x | BSD-3-Clause | Message serialization. Google maintained. No risk |
| **tinyxml2** | latest | zlib | XML parsing. Lightweight, no risk |

### Capabilities & Positioning

| Capability | Detail |
| --- | --- |
| **ROS integration** | Deepest ROS integration of any simulator via ros_gz bridge. Standard companion for ROS 2 development. Topic bridging, service bridging, parameter bridging |
| **Plugin architecture** | Most mature plugin API. Systems, sensors, GUI widgets, physics backends all pluggable. 40+ built-in system plugins |
| **Sensor models** | Comprehensive sensor suite: camera, depth, lidar, IMU, GPS, magnetometer, altimeter, logical camera, contact, RGBD. GPU-accelerated rendering for camera sensors via OGRE |
| **Scene format (SDFormat)** | SDFormat is a widely-adopted scene description standard. Includes physics, sensor, and plugin configuration. Older than USD in robotics context |
| **Multi-physics backends** | DART, Bullet, TPE (Trivial Physics Engine) via gz-physics abstraction |
| **Gazebo Fuel** | Cloud model repository for sharing robot and environment models |
| **20+ years maturity** | Most battle-tested robotics simulator. Used in DARPA DRC, NASA Space Robotics Challenge, SubT Challenge. Deep trust in robotics community |

### Lock-in Assessment

| Dimension | Risk | Detail |
| --- | --- | --- |
| **Hardware** | Low | CPU-based physics, no GPU requirement. Runs on commodity hardware. OGRE rendering uses OpenGL/Vulkan (no CUDA). Most portable of the four projects |
| **Vendor** | Low | OSRF holds trademarks. OSRA governance prevents unilateral control. Apache-2.0 license. SDFormat is an open standard. No proprietary runtime dependency |
| **Ecosystem** | Medium | SDFormat is widely used but less universal than URDF/MJCF. Gazebo Fuel model repository creates some ecosystem stickiness. Deep ROS integration creates bidirectional dependency — switching simulators means rebuilding ROS integration |

### Production Adoption

| User | Use Case |
| --- | --- |
| **DARPA** | DARPA Robotics Challenge, Virtual Robotics Challenge, SubT Challenge — funded OSRF to adapt Gazebo for competition use |
| **NASA** | Space Robotics Challenge (Valkyrie R5 robot simulation) |
| **Intrinsic (Alphabet)** | Internal robotics development. Employs majority of Gazebo maintainers |
| **Universal Robots** | Robot simulation and development |
| **Open Robotics / OSRF** | Reference simulator for ROS ecosystem |
| **Academic institutions** | Thousands of universities use Gazebo as the standard robotics teaching and research simulator |
| **Clearpath Robotics** | Simulation of Clearpath robot fleet (Husky, Jackal, etc.) |
| **Amazon (prev.)** | AWS RoboMaker was built on Gazebo for cloud robotics simulation |

### Build & CI

| Aspect | Details |
| --- | --- |
| **Build system** | CMake (primary), Bazel (alternative). colcon for ROS 2 workspace integration |
| **CI** | GitHub Actions — Linux (Ubuntu). Nightly and per-push builds |
| **Reproducibility** | No lockfile (C++ deps managed via apt/rosdep). Dockerfiles for reproducible builds |
| **Platforms tested** | Linux (Ubuntu primary). macOS experimental. Windows experimental |

### Backlog Health

| Metric | Value |
| --- | --- |
| **Open issues** | 598 |
| **Open PRs** | ~80 (estimated) |
| **Median issue response time** | <24h |
| **Median PR merge time** | <1 week |
| **Stale issues (>90 days)** | Moderate — mature project accumulates issues |

---

## Red Hat Platform Fit Assessment

### Alignment Signals

- Apache-2.0 license, fully compatible with downstream redistribution
- OSRA governance under OSRF (non-profit) — strongest governance of the four projects. Red Hat could join OSRA as member and influence direction
- No CLA required — lowest contribution friction
- CPU-based, hardware-neutral — runs on any platform, no GPU vendor lock-in
- Deep ROS 2 integration — aligns with the dominant robotics middleware
- Dockerfiles available — containerization straightforward
- C++ native — aligns with Red Hat's systems engineering expertise
- SDFormat is an open standard maintained by a non-profit

### Risk Signals

- **No GPU acceleration for physics**: CPU-based physics cannot match GPU-native simulators (Newton, Genesis World) for large-scale RL training workloads. This limits relevance for Physical AI training use cases
- **Intrinsic (Alphabet) operational dominance**: ~50%+ of recent code from Intrinsic employees despite open governance
- **C++ complexity**: Multi-repo C++ build is complex. 15+ gz-* libraries with their own build configs, system dependencies, and release cycles
- **LGPL dependencies**: ZeroMQ (LGPL-3.0) and Qt (LGPL-3.0) require dynamic linking for redistribution — manageable but adds compliance burden
- **Declining mindshare**: 1.4K stars vs. competitors at 5-30K. Community is discussing competitive pressure from GPU-native simulators openly
- **Slow release cadence**: 1 release in 12 months for gz-sim (coordinated multi-library releases are inherently slower)

### Supply Chain Assessment

- **License conflicts**: ZeroMQ and Qt are LGPL-3.0 — requires dynamic linking, not static. No copyleft conflict if dynamically linked
- **Known CVEs**: No scanner available to verify for C++ deps
- **Single-maintainer risks**: No critical single-maintainer deps. DART, OGRE, Qt are all multi-maintainer projects

**Technical verdict**: Adequate — strongest plugin architecture and most mature/battle-tested simulator, but CPU-only physics is a growing limitation for Physical AI training workloads. Best for deployment simulation, ROS integration, and sensor validation; weakest for large-scale GPU-parallel RL training.

**Red Hat fit**: Align — strongest governance (OSRA/OSRF), no GPU vendor lock-in, no CLA, Apache-2.0, deep ROS integration, and C++ systems engineering alignment. The best platform fit of the four projects for Red Hat's values and technology stack, but the CPU-only limitation constrains its relevance for the highest-demand Physical AI training use cases.

---

## Sources

- [Gazebo GitHub (gz-sim)](https://github.com/gazebosim/gz-sim)
- [Gazebo Website](https://gazebosim.org/)
- [Gazebo Governance Page](https://gazebosim.org/docs/latest/governance/)
- [OSRA Website](https://osralliance.org/)
- [OSRA Charter (PDF)](https://osralliance.org/wp-content/uploads/2024/03/OSRA-Charter-Plain-English.pdf)
- [Gazebo Project Charter (PDF)](https://osralliance.org/wp-content/uploads/2024/03/gazebo-project-charter.pdf)
- [Intrinsic OSRA Support Blog](https://www.intrinsic.ai/blog/posts/supporting-the-open-source-robotics-alliance)
- [Honu Robotics Announcement](https://discourse.openrobotics.org/t/new-robotics-company-honu-robotics/48384)
- [Gazebo PMC Meeting Minutes 2026-06-15](https://discourse.openrobotics.org/t/gazebo-pmc-meeting-minutes-2026-06-15/55498)
- [FOSDEM 2026 — A Core Developer's Insights on Gazebo's Future](https://fosdem.org/2026/events/attachments/8HTRVV-a_core_developers_insights_on_gazebos_future/slides/266796/fosdem_26_ycnlven.pdf)
- [Open Robotics Wikipedia](https://en.wikipedia.org/wiki/Open_Robotics)
