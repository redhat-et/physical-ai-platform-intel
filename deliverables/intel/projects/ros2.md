# ROS 2 — Project Intelligence Report

**Date**: 2026-06-26
**Last updated**: 2026-06-26
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | ROS 2 (Robot Operating System 2) |
| **Website** | [ros.org](https://www.ros.org/) |
| **Building block** | Robotics Frameworks, Communication Middleware, Robot Control, Navigation & Planning |
| **Competes with** | dora-rs (Dora), LCM (MIT/APRIL Lab), YARP (IIT), OROCOS (KU Leuven — dormant), Rock (DFKI) |
| **Depends on** | Fast DDS (eProsima), Cyclone DDS (ZettaScale), Eclipse Zenoh (ZettaScale) — middleware transports |
| **Depended on by** | [Gazebo](gazebo.md) — simulator integration via ros_gz bridge, [Isaac ROS](isaac-ros.md) — NVIDIA GPU-accelerated perception pipeline, [MoveIt 2](https://github.com/moveit/moveit2) — motion planning framework, [Nav2](https://github.com/ros-navigation/navigation2) — navigation stack, [ros2_control](https://github.com/ros-controls/ros2_control) — hardware abstraction |

### Repo Scope

ROS 2 spans 40+ repos across multiple GitHub organizations. Analysis focuses on the core middleware and client libraries.

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| [ros2/rclcpp](https://github.com/ros2/rclcpp) | Core | Analyzed | C++ client library — primary user-facing API, 76K LOC, 214 contributors |
| [ros2/rcl](https://github.com/ros2/rcl) | Core | Analyzed | C core library — single source of truth for ROS 2 semantics |
| [ros2/rclpy](https://github.com/ros2/rclpy) | Core | Noted | Python client library — wraps rcl via pybind11 |
| [ros2/rmw](https://github.com/ros2/rmw) | Core | Noted | Middleware abstraction layer — pure C ABI for DDS/Zenoh swapping |
| [ros2/rmw_fastrtps](https://github.com/ros2/rmw_fastrtps) | Core | Noted | Default DDS binding (Fast DDS, eProsima) |
| [ros2/rmw_cyclonedds](https://github.com/ros2/rmw_cyclonedds) | Core | Noted | Cyclone DDS binding (ZettaScale) |
| [ros2/rmw_zenoh](https://github.com/ros2/rmw_zenoh) | Core | Noted | Zenoh binding — Tier 1 since Kilted Kaiju (May 2025) |
| [ros2/rosidl](https://github.com/ros2/rosidl) | Core | Noted | Interface definition and code generation (.msg/.srv/.action) |
| [ros2/launch](https://github.com/ros2/launch) | Core | Noted | Launch system — Python-based orchestration of multi-node graphs |
| [ros2/ros2cli](https://github.com/ros2/ros2cli) | Core | Noted | CLI tools (ros2 topic, ros2 node, ros2 param, etc.) |
| [ros2/sros2](https://github.com/ros2/sros2) | Core | Noted | Security — PKI tooling for DDS-Security (authentication, access control, encryption) |
| [ros-navigation/navigation2](https://github.com/ros-navigation/navigation2) | Ecosystem | Noted | Navigation stack — 4.4K stars, BehaviorTree-orchestrated |
| [moveit/moveit2](https://github.com/moveit/moveit2) | Ecosystem | Noted | Motion planning framework — 1.9K stars, maintained by PickNik Robotics |
| [ros-controls/ros2_control](https://github.com/ros-controls/ros2_control) | Ecosystem | Noted | Hardware abstraction — SystemInterface/ActuatorInterface/SensorInterface plugins |
| [gazebosim/ros_gz](https://github.com/gazebosim/ros_gz) | Upstream/downstream | Linked | Gazebo↔ROS 2 bridge — separate governance (OSRA), see [Gazebo report](gazebo.md) |
| [micro-ROS/micro_ros_setup](https://github.com/micro-ROS/micro_ros_setup) | Ecosystem | Noted | MCU support — FreeRTOS, Zephyr, NuttX via Micro XRCE-DDS |

---

## Executive Summary

- **What it is**: The de facto standard open-source robotics middleware framework, providing pub/sub messaging, service calls, lifecycle management, hardware abstraction, and a 6,000+ package ecosystem for navigation, manipulation, perception, and simulation
- **Health verdict**: Healthy — 984M package downloads in 2025 (+85% YoY), 214+ contributors to core libs, annual LTS releases, and broadening contributor base; tempered by Intrinsic (Google) holding 46% of governance seats while contributing only 3-10% of recent code
- **Technical verdict**: Strong — clean layered architecture (rclcpp/rclpy → rcl → rmw → DDS/Zenoh), runtime-swappable middleware via `RMW_IMPLEMENTATION`, zero-copy intra-process communication, component composition, lifecycle nodes, and SROS2 security; multi-platform (Linux/Windows/macOS, amd64/arm64)
- **Red Hat fit**: Align — Apache 2.0 license, RHEL is Tier 2 platform, Red Hat is OSRA Gold member, DCO contribution model, container-friendly colcon build, RHEL 9 targets Jazzy/Kilted, RHEL 10 targets Lyrical LTS
- **Recommendation**: <!-- filled by: project-comparison or manual assessment -->

---

## Part A: Community & Project Health

### CHAOSS Metrics

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | 4+ orgs for 50% of recent commits | High | All-time: Intrinsic/Open Robotics ~35%. Last 12 months: Intrinsic share dropped to 3-10% across core repos. Top recent contributors: Honu Robotics (ahcorde), Sony (fujitatomoya), Independent (clalancette), CivRobotics (InvincibleRMC), cellumation (jmachowinski). Contribution has broadened significantly post-acquisition |
| **Contributor Absence Factor** | 8+ people for 50% of commits (rclcpp) | Healthy | Top contributors: clalancette (207), dirk-thomas (184), wjwwood (180), fujitatomoya (103), ivanpauno (96), ahcorde (73). Well-distributed across core repos |
| **Change Request Closure Ratio** | 150 PRs opened / 109 merged in 6mo (rclcpp) | Healthy (0.73) | Active PR review with reasonable throughput. Core repos maintain ~72% merge rate |
| **Time to First Response** | Median ~2-5 days | OK | PRs from known contributors reviewed within days; external PRs may wait 1-2 weeks. CI runs automatically on all PRs |
| **Release Frequency** | Annual major (May 23), point releases quarterly | Active | Current LTS: Jazzy Jalisco (2024→2029). Latest: Kilted Kaiju (May 2025). Next LTS: Lyrical Lynx (May 2026→2031). Even years = 5-year LTS |
| **Contribution Trend** | Broadening | Broadening | OSRA formation (March 2024) brought AMD, Huawei, Qualcomm, Red Hat as Gold members. 1,579 known ROS companies (+26% YoY). ROSCon attendance growing 700→1000+. Discourse +40% topics in 2025 |
| **Libyears** | < 1 year (core) | Current | Core packages track latest release branches. rosdep resolves to system packages, keeping deps current with distro |

### Strategic Metrics

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | Permissive | Apache 2.0 across all core repos. Ecosystem: Nav2 (3-clause BSD), MoveIt 2 (3-clause BSD), ros2_control (Apache 2.0). Patent grant included in Apache 2.0 |
| **Governance model** | Foundation | OSRF (501(c)(3) nonprofit) owns all IP, trademarks, infrastructure. OSRA (est. March 2024) provides CNCF-style tiered governance with Technical Governance Committee (TGC) and ROS Project Management Committee (PMC) |
| **Contribution model** | DCO | Developer Certificate of Origin — sign-off on commits, no CLA. Low contribution friction. OSRF holds no copyright assignment |
| **Corporate control risk** | Medium | Intrinsic (Google) holds 46% of combined PMC + Committer seats (13 of 28). Brian Gerkey is both Intrinsic CTO and OSRF Board Chair. However, Intrinsic contributes only 3-10% of recent code — governance authority is disconnected from contribution reality. Mitigating: OSRF 501(c)(3) owns IP irrevocably, Apache 2.0 is non-revocable, OSRA charter requires multi-vendor representation |
| **Community health** | Active | 984M package downloads in 2025 (+85% YoY), 91.2% ROS 2 share (vs ROS 1). 1,579 known companies using ROS. Active Discourse forum, annual ROSCon conference, strong academic adoption |
| **Ecosystem breadth** | Wide | 6,000+ packages on rosdistro. Major subsystems: Nav2 (navigation), MoveIt 2 (manipulation), ros2_control (hardware abstraction), Gazebo (simulation), micro-ROS (MCUs), ROS-Industrial (manufacturing). Integrations with every major robot vendor |

### Governance Details

| Maintainer / Key Contributor | Employer | Role |
| --- | --- | --- |
| **Brian Gerkey** | Intrinsic (Google) | OSRF Board Chair, Intrinsic CTO |
| **Michael Carroll (mjcarroll)** | KUKA | Interim Project Leader, ROS PMC |
| **Chris Lalancette (clalancette)** | Independent (prev. Open Robotics) | Former Project Leader, ament_cmake maintainer, top all-time contributor across repos. ROS PMC |
| **William Woodall (wjwwood)** | Intrinsic (Google) | Core maintainer (rclcpp, rcl, rmw), ROS PMC, co-creator of ROS 2 |
| **Dirk Thomas (dirk-thomas)** | Unknown (prev. Open Robotics) | Historical top contributor (ament, ros2cli, rosdistro). Appears to have ceased contributing. Not on current PMC |
| **Tomoya Fujita (fujitatomoya)** | Sony | Core maintainer (rclcpp), 103 commits, ROS PMC. Key non-Intrinsic voice |
| **Ivan Paunovic (ivanpauno)** | Ekumen Labs | Core contributor and declared maintainer (rcl, rclcpp, rmw), 96 commits |
| **Alejandro Hernández Cordero (ahcorde)** | Honu Robotics | Top recent contributor across rclcpp/rclpy/rcl, ROS PMC. Most active committer in last 12 months |
| **Shane Loretz (sloretz)** | Intrinsic (Google) | Declared maintainer (rclpy), ROS PMC |
| **Scott Logan (cottsay)** | Intrinsic (Google) | ROS PMC, ament build system contributor |
| **Audrow Nash** | Intrinsic (Google) | Declared maintainer (rcl, ros2cli), ROS PMC |
| **Steve Macenski** | Open Navigation (prev. Samsung, NVIDIA) | Nav2 lead maintainer, OSRA TSC member |
| **Henning Kayser** | PickNik Robotics | MoveIt 2 lead maintainer |
| **Bence Magyar** | Independent (prev. PAL Robotics) | ros2_control lead maintainer |
| **Michael Carlstrom (InvincibleRMC)** | CivRobotics | Top rclpy contributor in last 12 months, Committer |
| **Janosch Machowinski (jmachowinski)** | cellumation | Active rclcpp contributor, Committer |
| **Barry Xu (Barry-Xu-2018)** | Sony | Active cross-repo contributor, Committer |
| **Tully Foote** | Intrinsic (Google) | OSRF board, ROS infrastructure (rosdep, REPs), Committer |
| **Geoffrey Biggs (gbiggs)** | OSRF | OSRF CTO, ros2cli co-maintainer |

### Funding & Sustainability

**Organizational structure** (three entities):

- **OSRF** (Open Source Robotics Foundation) — 501(c)(3) nonprofit, incorporated 2012. Owns all ROS/Gazebo/Open-RMF IP and trademarks. Cannot be acquired. CEO: Vanessa Yamzon Orsi. CTO: Geoffrey Biggs
- **OSRC** (Open Source Robotics Corporation) — for-profit subsidiary that employed the ~36-person engineering team. Acquired by Intrinsic (Alphabet) in December 2022. Most engineers moved to Intrinsic, including co-founder Brian Gerkey (Intrinsic CTO)
- **OSRA** (Open Source Robotics Alliance) — launched March 2024 as a program within OSRF. Provides CNCF-style tiered governance with membership funding

**OSRF financial data** (IRS 990 filings):

| FY | Revenue | Expenses | Net Assets |
| --- | --- | --- | --- |
| 2021 | $6.05M | $5.52M | $2.64M |
| 2022 | $6.02M | $4.28M | $4.24M |
| 2023 | $1.94M | $1.97M | $4.23M |
| 2024 | $2.60M | $2.03M | $5.80M |

Revenue collapsed from ~$6M to ~$2M after the OSRC acquisition (loss of engineering team and associated contracts). FY2024 shows partial recovery with contributions rising to $482K (vs. $28K in FY2023), likely reflecting OSRA membership dues. Foundation holds ~$5.8M in reserves.

**OSRA membership** (scaled by company FTE): Platinum: $20K-$175K/yr, Gold: $7.5K-$60K/yr, Silver: $3.5K-$30K/yr. Current members: 4 Platinum (Canonical, Intrinsic, NVIDIA, Qualcomm), 5 Gold (AMD, b-robotized, Bosch, Huawei, **Red Hat**), 18 Silver, 4 Associate, 23 Supporting Orgs, ~110 Supporting Individuals. Estimated membership revenue: $700K-$1.2M/year.

**Intrinsic → Google transition** (February 2026): Intrinsic was folded into Google proper (no longer standalone Alphabet subsidiary). CEO Wendy Tan White reports to Hiroshi Lockheimer. Reduces organizational separation that previously offered some protection against broader Google restructuring. Google's track record with robotics (Everyday Robots shutdown) and open source (progressive closing of Android components) are legitimate community concerns.

**Sustainability assessment**: MODERATE. The OSRA model provides sustainable base funding, and $5.8M in reserves provides multi-year runway. However, a critical paradox has emerged: Intrinsic holds 46% of governance seats (7 of 16 PMC, 6 of 12 Committers) but contributes only 3-10% of recent code to core packages. Recent development is increasingly driven by external contributors (Sony, Honu Robotics, Ekumen Labs, CivRobotics, cellumation). The Apache 2.0 license and OSRF 501(c)(3) structure provide strong legal safeguards — the project cannot be relicensed or captured regardless of Google's strategy.

**Key departure**: Dirk Thomas, the single most prolific contributor across the ROS 2 ecosystem (architect of ament, ros2cli, rosdistro — 8,687 commits to rosdistro alone), appears to have ceased contributing. No public announcement found. This is a significant historical loss, though the community has absorbed the work.

---

## Part B: Technical Analysis

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | Clear | Clean layered architecture: rclcpp/rclpy → rcl (C core) → rmw (C ABI) → DDS/Zenoh. Each layer has well-defined responsibilities. rmw provides compile-time middleware swapping. REPs (ROS Enhancement Proposals) document design decisions |
| **Tech stack alignment** | Aligned | Linux-first (Ubuntu Tier 1, RHEL Tier 2), C++17/Python 3 core, colcon build system (containerizable), systemd integration, DEB/RPM packaging. No CUDA dependency. Container-friendly architecture |
| **Dependency health** | Healthy | Core depends on well-maintained libraries: Fast DDS (eProsima), Cyclone DDS (ZettaScale), Zenoh (ZettaScale). rosdep resolves to system packages (libyaml, tinyxml2, poco, spdlog). No single-maintainer critical deps |
| **Test coverage** | Adequate | googletest (C++), pytest (Python). Test directories in all core repos. CI runs tests on every PR. No published coverage percentage. Property-based testing absent. Integration tests via launch_testing |
| **Security posture** | Adequate | SROS2 provides DDS-Security (PKI authentication, access control, AES-GCM encryption). SECURITY.md in core repos. No OpenSSF Scorecard score found. CVE process exists via ROS 2 Security WG. No SBOM generation |
| **Code quality signals** | Strong | 42 TODOs in 76K LOC (0.5/KLOC — low). Enforced linting (ament_lint, uncrustify for C++, flake8 for Python). Code review required for all PRs. CHANGELOG.rst maintained per package. Churn concentrated in CHANGELOG and package.xml (healthy — version bumps, not instability) |
| **Extensibility** | Plugin API | Pervasive plugin architecture via pluginlib (C++ shared library loading). rmw plugins for middleware, ros2_control plugins for hardware, Nav2 plugins for planners/controllers/behaviors, launch plugins for actions. Component composition for zero-copy intra-process |
| **Hardware portability** | Portable | No GPU dependency in core. Runs on amd64, arm64, arm32. Ubuntu Tier 1, Windows Tier 1, RHEL Tier 2, macOS Tier 3. micro-ROS extends to MCUs (FreeRTOS, Zephyr, NuttX). Hardware abstraction via ros2_control SystemInterface |

### Architecture Overview

ROS 2 uses a layered architecture with clean separation between user-facing APIs, core semantics, and transport:

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **rclcpp** | C++ client library — nodes, publishers, subscribers, services, actions, timers, executors | rcl, rosidl |
| **rclpy** | Python client library — mirrors rclcpp API, wraps rcl via pybind11 | rcl, rosidl |
| **rcl** | C core library — single source of truth for ROS 2 semantics (discovery, QoS, lifecycle) | rmw, rosidl |
| **rmw** | ROS Middleware Interface — pure C ABI abstracting the transport layer | None (interface only) |
| **rmw_fastrtps** | Default DDS binding via Fast DDS (eProsima) | Fast DDS |
| **rmw_cyclonedds** | Alternative DDS binding via Cyclone DDS (ZettaScale) | Cyclone DDS |
| **rmw_zenoh** | Non-DDS transport via Eclipse Zenoh — Tier 1 since Kilted Kaiju | Eclipse Zenoh |
| **rosidl** | Interface definition language — .msg/.srv/.action file processing and code generation | Python (generators) |
| **launch** | System orchestration — Python-based launch files for multi-node graph startup | rclpy |
| **sros2** | Security tooling — PKI certificate/permission generation for DDS-Security | OpenSSL |
| **colcon** | Meta-build tool — orchestrates ament_cmake (C++) and ament_python builds | CMake, setuptools |
| **ros2_control** | Hardware abstraction — plugin-based controllers and hardware interfaces | rclcpp, pluginlib |
| **Nav2** | Navigation stack — BehaviorTree-orchestrated planners, controllers, recovery behaviors | rclcpp, pluginlib, tf2 |
| **MoveIt 2** | Motion planning — OMPL/Pilz planners, collision checking, kinematics | rclcpp, pluginlib, Eigen |

**Communication primitives**:

- **Topics**: Pub/sub via DDS with `rt/` prefix mapping. Supports all DDS QoS profiles
- **Services**: Synchronous request/reply via topic pairs (`rq/`/`rr/` prefixes)
- **Actions**: Goal-oriented long-running tasks — 3 services + 2 topics per action, with goal state machine (ACCEPTED→EXECUTING→SUCCEEDED/CANCELED/ABORTED)
- **Parameters**: Node-owned key-value store, replaces ROS 1 global parameter server. Supports dynamic reconfiguration callbacks

**Key architectural patterns**:

- **Lifecycle nodes**: State machine (Unconfigured→Inactive→Active→Finalized) with transition callbacks. nav2_lifecycle_manager coordinates multi-node startup with bond heartbeats
- **Component composition**: Composable nodes loaded as shared libraries into containers at deploy-time. Zero-copy intra-process communication via IntraProcessManager bypassing DDS entirely (4-7x latency reduction with `unique_ptr` publishing)
- **Executor model**: Single-threaded, multi-threaded, and events-based executors for callback scheduling

### Dependency Analysis

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **Fast DDS (eProsima)** | 2.x/3.x | Apache 2.0 | Default middleware. eProsima is OSRA member. Swappable via rmw |
| **Cyclone DDS (ZettaScale)** | 0.10.x | EPL-2.0 | Alternative middleware. EPL-2.0 is weak copyleft (compatible with Apache 2.0 at distribution level) |
| **Eclipse Zenoh (ZettaScale)** | 1.x | EPL-2.0 / Apache 2.0 | Tier 1 since May 2025. Non-DDS alternative solving multicast/discovery overhead |
| **CMake** | ≥ 3.16 | BSD-3 | none |
| **Python** | ≥ 3.10 | PSF | none |
| **spdlog** | 1.x | MIT | Logging backend — well-maintained |
| **libyaml** | 0.2.x | MIT | Parameter file parsing — stable |
| **tinyxml2** | 9.x | Zlib | XML parsing for URDF/launch — stable |
| **Eigen** | 3.x | MPL-2.0 | Linear algebra (MoveIt 2, tf2) — industry standard |
| **Poco** | 1.x | BSL-1.0 | Network utilities — stable |
| **OpenSSL** | 1.1/3.x | Apache 2.0 | SROS2 PKI — system package |

### Capabilities & Positioning

| Capability | Detail |
| --- | --- |
| **Middleware abstraction** | Runtime-swappable transport via `RMW_IMPLEMENTATION` env var. Supports Fast DDS, Cyclone DDS, Zenoh, RTI Connext, GurumDDS. Unique in robotics — no competitor offers this |
| **Zero-copy IPC** | IntraProcessManager enables zero-copy intra-process pub/sub when nodes are composed in the same process. 4-7x latency reduction over DDS path. `unique_ptr` publishing enables true zero-copy |
| **Lifecycle management** | Managed nodes with deterministic state transitions (Unconfigured→Inactive→Active→Finalized). nav2_lifecycle_manager coordinates startup of entire node graphs with bond-based heartbeat monitoring |
| **Component composition** | Nodes compiled as shared libraries, loaded into containers at deploy-time. Enables zero-copy without code changes. Deployment-time optimization without source modification |
| **Security (SROS2)** | Built on DDS-Security spec: X.509 PKI authentication, access control policies per node/topic, AES-GCM encryption. Per-enclave PKI artifacts. sros2 CLI generates certificates and permissions XML |
| **Hardware abstraction** | ros2_control provides SystemInterface, ActuatorInterface, SensorInterface plugins. Controllers (JointTrajectory, DiffDrive, Admittance) are pluggable. Supports real-time kernel scheduling |
| **Navigation stack (Nav2)** | Distributed architecture replacing ROS 1 move_base. BehaviorTree-orchestrated with pluginlib-based planners (NavFn, SMAC, Theta*), controllers (DWB, MPPI, RPP), and recovery behaviors. 4.4K GitHub stars |
| **Motion planning (MoveIt 2)** | OMPL-based sampling planners, Pilz industrial planner, collision checking via FCL, kinematics via KDL/IKFast. Servo for real-time teleoperation. 1.9K GitHub stars |
| **MCU support** | micro-ROS extends ROS 2 to microcontrollers (FreeRTOS, Zephyr, NuttX) via Micro XRCE-DDS client-agent model. Enables sensor nodes on embedded hardware communicating with ROS 2 graphs |
| **Multi-platform** | Ubuntu Tier 1 (amd64, arm64), Windows Tier 1 (amd64), RHEL Tier 2 (amd64), macOS Tier 3. DEB and RPM packaging. Docker images available |

### Lock-in Assessment

| Dimension | Risk | Detail |
| --- | --- | --- |
| **Hardware** | Low | Hardware-agnostic by design. No GPU dependency in core. Runs on x86, ARM, RISC-V (via micro-ROS). ros2_control abstracts specific robot hardware via plugins |
| **Vendor / Governance** | Medium | Intrinsic (Google) holds ~47% of TGC seats and employs top 3 core maintainers. Mitigating: OSRF 501(c)(3) owns all IP, Apache 2.0 is irrevocable, OSRA charter mandates multi-vendor representation. Google cannot relicense or restrict access |
| **Middleware** | Low | rmw abstraction layer enables runtime middleware swapping. Three Tier 1 options (Fast DDS, Cyclone DDS, Zenoh). No vendor lock-in to any single DDS implementation |
| **Ecosystem** | High | 6,000+ packages, thousands of integrations, no comparable OSS alternative. Switching cost is enormous — entire robotics toolchains built on ROS 2 conventions (URDF, tf2, sensor_msgs). This is beneficial lock-in from a platform perspective |
| **License** | Low | Apache 2.0 core. No CLA. DCO-only contribution model. Full freedom to fork, redistribute, and commercialize |

### Production Adoption

| User | Use Case |
| --- | --- |
| **Apex.AI / Toyota** | Apex.OS — safety-certified (ASIL-D) ROS 2 derivative for automotive. Toyota autonomous driving platform |
| **OTTO Motors / Clearpath (Rockwell)** | Warehouse AMR fleet management on ROS 2 + Nav2. Acquired by Rockwell Automation |
| **iRobot** | Create 3 educational robot runs ROS 2 natively. Production consumer robotics |
| **KABAM Robotics** | Autonomous security patrol robots using ROS 2 + Nav2 in production buildings |
| **NASA** | Space ROS — ROS 2 hardened for space applications. ISS robotics research |
| **US DoD** | ROS-M (ROS Military) program. Ground and aerial autonomy systems |
| **FANUC / UR / ABB** | Industrial robot arm integration via ROS-Industrial consortium. ros2_control drivers |
| **Unitree** | Most open humanoid robot vendor. Publishes ROS 2 packages for Go2, H1, G1 robots |
| **Bosch** | Internal robotics platform uses ROS 2. OSRA Gold member. Significant contributor |
| **Samsung** | Samsung Research contributed to Nav2 and core libraries. Autonomous robots division |
| **Canonical** | Ubuntu-ROS 2 commercial support. OSRA Platinum member. Snap packaging for ROS 2 |

**Market metrics**: 984M package downloads in 2025 (+85% YoY), 91.2% ROS 2 share vs ROS 1. 1,579 known ROS companies globally (+26% YoY). ROSCon attendance: 700→1000+ (2023-2025).

### Build & CI

| Aspect | Details |
| --- | --- |
| **Build system** | colcon (meta-build tool) orchestrating ament_cmake (C++) and ament_python (Python). CMake underneath for C/C++. package.xml format 3 (REP 149) for dependency declaration |
| **CI** | ROS 2 CI (Jenkins-based) running on build.ros2.org. Individual repos use GitHub Actions for linting. Centralized nightly builds test full distro integration across all Tier 1 platforms |
| **Reproducibility** | rosdep resolves abstract dependencies to system packages (APT, DNF). No lockfile per se — pinned to rosdistro release snapshots. Docker images available for reproducible builds. Bloom handles release packaging |
| **Platforms tested** | Ubuntu 22.04/24.04 (Tier 1, amd64+arm64), Windows 10/11 (Tier 1, amd64), RHEL 9 (Tier 2, amd64), macOS (Tier 3). Cross-compilation supported for ARM targets |

### Backlog Health

Aggregated across core repos (rclcpp, rcl, rclpy, rmw, rosidl, launch, ros2cli):

| Metric | Value |
| --- | --- |
| **Open issues** | ~1,149 (325 rclcpp + 70 rcl + 157 rclpy + 28 rmw + 106 rosidl + 143 launch + 120 ros2cli + 200 sros2/misc) |
| **Open PRs** | ~60-80 across core repos |
| **Median issue response time** | 2-7 days (varies by repo; core repos faster) |
| **Median PR merge time** | 3-10 days for known contributors; 2-4 weeks for external |
| **Stale issues (>90 days)** | ~40-50% — many are feature requests or long-term enhancements, not bugs |

---

## Red Hat Platform Fit Assessment

### Alignment Signals

- **Apache 2.0 license** across all core repos — fully compatible with Red Hat downstream redistribution model
- **RHEL is Tier 2 platform** — officially supported with RPM packages. RHEL 9 targets Jazzy/Kilted, RHEL 10 targets Lyrical LTS (2026→2031)
- **Red Hat is OSRA Gold member** ($50K/yr) — direct governance influence, seat on advisory council
- **DCO contribution model** — no CLA friction, aligns with Red Hat's preferred contribution approach
- **Container-friendly** — colcon builds work in containers, multi-stage Dockerfiles common in community. systemd integration for production deployment
- **No GPU dependency** — core stack runs on CPU. Hardware abstraction via ros2_control plugins
- **Multi-architecture** — amd64 and arm64 Tier 1. ARM support critical for edge robotics (RHEL for Edge)
- **Zenoh transport** — Tier 1 since May 2025, solves DDS multicast issues in cloud/container environments. Better fit for OpenShift networking than DDS
- **Complementary to RHOAI** — ROS 2 is the deployment target for robot policies trained via PyTorch/vLLM. Isaac ROS demonstrates this: train in Isaac Lab, deploy via ros2_control

### Risk Signals

- **Governance-contribution paradox** — Intrinsic (Google) holds 46% of governance seats (13/28 PMC+Committers) but contributes only 3-10% of recent code. Governance authority disconnected from contribution reality. Google's February 2026 absorption of Intrinsic and its track record (Everyday Robots shutdown) add uncertainty
- **DDS complexity** — DDS middleware adds latency and configuration complexity (QoS profiles, discovery). Zenoh mitigates but is not yet the default
- **RHEL Tier 2** — not Tier 1, meaning community CI may not catch RHEL-specific regressions. RPM packaging requires ongoing Red Hat effort
- **Large dependency surface** — core + ecosystem pulls in hundreds of packages. rosdep resolution to RHEL system packages requires active maintenance
- **EPL-2.0 in middleware** — Cyclone DDS and Zenoh use EPL-2.0 (weak copyleft). Compatible with Apache 2.0 for distribution but requires legal review for bundled redistribution
- **No SBOM generation** — no Software Bill of Materials in the standard build pipeline. Compliance gap for supply chain security requirements

### Supply Chain Assessment

- **License conflicts**: Core is Apache 2.0. Cyclone DDS and Zenoh use EPL-2.0 — weak copyleft, compatible when distributed as separate libraries (standard for ROS 2). No GPL in critical path. Eigen uses MPL-2.0 (compatible). MoveIt 2 and Nav2 use BSD-3 (compatible)
- **Known CVEs**: DDS implementations have had CVEs (Fast DDS CVE-2023-50258, CVE-2023-50259 — both patched). SROS2 mitigates network-level attack surface. No unpatched critical CVEs in core repos at time of analysis
- **Single-maintainer risks**: No single-maintainer critical dependencies. Fast DDS (eProsima, 20+ contributors), Cyclone DDS (ZettaScale, 40+ contributors), Zenoh (ZettaScale, 60+ contributors) are all actively maintained. Core libraries have 5+ active maintainers each

---

## Sources

- [ROS 2 Documentation](https://docs.ros.org/en/rolling/)
- [OSRA Charter and Governance](https://osra.org/)
- [ROS 2 Design Articles](https://design.ros2.org/)
- [ROS Metrics Report 2025](https://metrics.ros.org/)
- [OSRF Annual Report](https://www.openrobotics.org/)
- [GitHub: ros2/rclcpp](https://github.com/ros2/rclcpp)
- [GitHub: ros2/rcl](https://github.com/ros2/rcl)
- [GitHub: ros-navigation/navigation2](https://github.com/ros-navigation/navigation2)
- [GitHub: moveit/moveit2](https://github.com/moveit/moveit2)
- [GitHub: ros-controls/ros2_control](https://github.com/ros-controls/ros2_control)
- [Apex.AI Apex.OS](https://www.apex.ai/)
- [ROSCon Talks Archive](https://roscon.ros.org/)
- [ROS Discourse Community](https://discourse.ros.org/)
- [REP Index (ROS Enhancement Proposals)](https://www.ros.org/reps/rep-0000.html)
