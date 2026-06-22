# Isaac Sim — Project Intelligence Report

**Date**: 2026-06-22
**Last updated**: 2026-06-22
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | Isaac Sim (NVIDIA) |
| **Website** | [developer.nvidia.com/isaac-sim](https://developer.nvidia.com/isaac/sim) |
| **Building block** | Simulation Engines |
| **Competes with** | MuJoCo (Google DeepMind), Newton (Linux Foundation), Genesis World (Genesis AI), Gazebo (OSRA/Open Robotics), PyBullet (Erwin Coumans), Drake (Toyota Research Institute) |
| **Depends on** | — |
| **Depended on by** | [Isaac Lab](isaac-lab.md) — robot learning framework |

### Repo Scope

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| [isaac-sim/IsaacSim](https://github.com/isaac-sim/IsaacSim) | Core | Analyzed | Primary repo — robotics simulation runtime. Apache-2.0 code but depends on proprietary Omniverse Kit SDK. 3.5K stars |
| [isaac-sim/IsaacLab](https://github.com/isaac-sim/IsaacLab) | Downstream | Linked | Robot learning framework built on Isaac Sim — see [Isaac Lab report](isaac-lab.md). 7.5K stars |
| [isaac-sim/IsaacSim-ros_workspaces](https://github.com/isaac-sim/IsaacSim-ros_workspaces) | Ecosystem | Noted | ROS 2 workspace integration examples. 305 stars |
| [isaac-sim/IsaacSimZMQ](https://github.com/isaac-sim/IsaacSimZMQ) | Ecosystem | Noted | ZMQ communication extension for external app integration. 60 stars |
| [isaac-sim/IsaacLab-Arena](https://github.com/isaac-sim/IsaacLab-Arena) | Ecosystem | Noted | Composable simulation environments extension. 440 stars |
| [isaac-sim/IsaacAutomator](https://github.com/isaac-sim/IsaacAutomator) | Peripheral | Excluded | Cloud deployment tooling. 238 stars |
| [isaac-sim/IsaacGymEnvs](https://github.com/isaac-sim/IsaacGymEnvs) | Peripheral | Excluded | Archived — predecessor (Isaac Gym envs). 2.9K stars |
| [isaac-sim/OmniIsaacGymEnvs](https://github.com/isaac-sim/OmniIsaacGymEnvs) | Peripheral | Excluded | Archived — predecessor (Omniverse Isaac Gym). 1.0K stars |

---

## Executive Summary

- **What it is**: GPU-accelerated robotics simulation platform featuring PhysX and Newton physics, RTX photorealistic rendering, NuRec Gaussian splatting, and USD scene format, built on NVIDIA's proprietary Omniverse Kit SDK; code is Apache-2.0 but requires proprietary runtime and explicitly does not accept external contributions — "published source, proprietary development"
- **Health verdict**: At-risk — source-published NVIDIA-internal project with zero community development model: 5 contributors (all NVIDIA), 36 total commits, explicitly does not accept contributions, no governance docs, proprietary runtime dependency (Omniverse Kit SDK); despite Apache-2.0 license, this is not an open-source project in any meaningful community sense
- **Technical verdict**: Strong — most feature-complete robotics simulation platform with broadest production adoption (ABB, FANUC, Figure AI, J&J MedTech), RTX + NuRec rendering, Newton physics integration (v6.0), 117 Kit extensions, 653K LOC
- **Red Hat fit**: Misalign — proprietary Omniverse Kit SDK runtime (117 `omni.*` deps), CUDA-only hardware, explicit no-contribution policy, and NVIDIA container image dependency make it incompatible with Red Hat's open-source product model
- **Recommendation**: Partner — broadest production adoption and strongest feature set, but proprietary Kit SDK runtime, CUDA-only, and no-contribution policy make it a consume-only relationship; see [comparison](../project-comparisons/simulation-engines.md)

---

## Part A: Community & Project Health

### CHAOSS Metrics

<!-- Industry-standard community health metrics aligned with CHAOSS (https://chaoss.community) -->

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | 1 org (NVIDIA at 100%) | Low | All 36 commits from NVIDIA employees. Every contributor has an @nvidia.com email or -nv GitHub suffix. Zero external organizational participation |
| **Contributor Absence Factor** | 1 person for 64% of commits | Risk | sheikh-nv (Sheikh Dawood, NVIDIA) accounts for 23 of 36 commits (64%). Only 5 contributors total — the lowest of any project assessed |
| **Change Request Closure Ratio** | 19 opened / 6 closed in 12mo | Backlog (0.32) | Misleading metric: NVIDIA explicitly does not accept external contributions. The 19 open PRs are community submissions that will not be merged. Internal development happens outside GitHub |
| **Time to First Response** | ~3h median | Fast | NVIDIA staff respond to issues quickly. Active issue triage despite no-contribution policy |
| **Release Frequency** | 5 releases in 13mo | Active | v5.0.0 (Aug 2025) → v5.1.0 (Oct 2025) → v6.0.0-dev (Dec 2025) → v6.0.0-dev2 (Mar 2026) → v6.0.0 (Jun 2026) |
| **Contribution Trend** | N/A | N/A | Not applicable — project does not accept contributions by policy. All development is NVIDIA-internal |
| **Libyears** | <!-- TODO: run project-tech-eval --> | | |

### Strategic Metrics

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | Source-available | Apache-2.0 for published source code. However, building and running requires proprietary NVIDIA Omniverse Kit SDK, which is not open source and cannot be redistributed. Effective posture is source-available, not open source. Additional components licensed under [NVIDIA Isaac Sim Additional License](https://www.nvidia.com/en-us/agreements/enterprise-software/isaac-sim-additional-software-and-materials-license/) |
| **Governance model** | Single-vendor | No GOVERNANCE.md, CHARTER.md, CODEOWNERS, or steering committee. No foundation affiliation. NVIDIA controls all development, roadmap, and release decisions internally |
| **Contribution model** | None | CONTRIBUTING.md explicitly states: "We currently do not accept any contributions to this repository." No CLA, no DCO — contributions are refused outright. This is the most restrictive model among all projects assessed |
| **Corporate control risk** | High | Total NVIDIA control: 100% of commits, no external contributions accepted, proprietary runtime dependency, no governance framework. NVIDIA can change license, restrict access, or abandon the project at any time with no community recourse beyond forking the Apache-2.0 code |
| **Community health** | Maintained | 3.5K stars, 482 forks, ~670 open issues indicate strong user interest. NVIDIA staff respond to issues and provide support. But there is no community *development* — only community *consumption*. The GitHub repo functions as a public bug tracker and source archive, not a collaborative development space |
| **Ecosystem breadth** | Wide | Isaac Lab (learning framework), Isaac ROS (ROS 2 bridge), GR00T (foundation model), Cosmos (synthetic data), Isaac Perceptor (perception), SDG tools. But the entire ecosystem is NVIDIA-controlled. Third-party integrations exist (ROS 2, USD, URDF/MJCF importers) but the runtime is NVIDIA-only |

### Governance Details

| Maintainer / Key Contributor | Employer | Role |
| --- | --- | --- |
| **Sheikh Dawood** (sheikh-nv) | NVIDIA | Primary maintainer. 23 of 36 commits (64%). Handles releases, issue triage, and all merge decisions |
| **Ben Johnston** (ben-johnston-nv) | NVIDIA | Contributor. 5 commits (14%). <benj@nvidia.com> |
| **Antonio Serrano Munoz** (Toni-SM) | NVIDIA | Contributor. 4 commits (11%). Also contributes to Isaac Lab. <aserranomuno@nvidia.com> |
| **Alexander Poddubny** (nv-apoddubny) | NVIDIA | Contributor. 3 commits (8%). <apoddubny@nvidia.com> |
| **Hammad Mazhar** (hmazhar-nv) | NVIDIA | Contributor. 1 commit (3%). <hmazhar@nvidia.com> |

### Funding & Sustainability

Isaac Sim is a **core NVIDIA product** — not a community open-source project. It was a proprietary product for years before NVIDIA published its source code on GitHub in May 2025 (announced at COMPUTEX 2025, GA at SIGGRAPH 2025 with v5.0.0).

**Development model**: All development happens internally at NVIDIA. The GitHub repo receives periodic source publications aligned with version releases. Community bug reports are triaged via GitHub issues, but code contributions are refused. This is functionally a "source-published proprietary product" with an Apache-2.0 license attached.

**Sustainability assessment**: Low risk for project continuity; maximum risk for community independence.

- **Strong NVIDIA commitment**: Isaac Sim is the foundation of NVIDIA's entire Physical AI platform strategy. It underpins Isaac Lab, GR00T, Isaac ROS, Cosmos, and NVIDIA's $200B+ market cap narrative around robotics and Physical AI. Risk of abandonment is essentially zero.
- **No community development path**: Unlike Isaac Lab (DCO, 197 contributors), Isaac Sim explicitly refuses contributions. There is no path for external organizations to influence the codebase, fix bugs upstream, or shape the roadmap. Users who find bugs must wait for NVIDIA to fix them.
- **Proprietary runtime dependency**: Omniverse Kit SDK is proprietary NVIDIA software. The Apache-2.0 source code cannot be built or run without it. Forking the code requires replacing the entire runtime — a multi-year engineering effort.
- **Newton integration**: Isaac Sim 6.0 added Newton (Linux Foundation) as an alternative physics backend alongside PhysX. This is strategically significant — Newton provides a governance-independent physics path. However, the Omniverse Kit SDK dependency remains regardless of physics backend choice.
- **Platform gravity**: Organizations that adopt Isaac Sim become dependent on NVIDIA GPUs (CUDA-only), NVIDIA runtime (Kit SDK), NVIDIA formats (USD extensions), and NVIDIA ecosystem (Isaac Lab, GR00T, Cosmos). Migration cost is extreme.

**Comparison with Isaac Lab**: Isaac Lab is genuinely community-developed (DCO, 197 contributors, RAI Institute contributions). Isaac Sim is not. They share the same GitHub org but have fundamentally different openness postures. Isaac Lab's openness is strategic for NVIDIA (attracts users to the platform); Isaac Sim's source publication is strategic for developer experience (users can debug, read source) but not for community participation.

---

## Part B: Technical Analysis

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | Clear | Well-structured Omniverse Kit extension architecture: 117 extensions across 22 namespaces (core, physics, sensors, robot, ros2, replicator, etc.). Clean separation between simulation, rendering, asset management, and application layers. Extension dependency graph is explicit via `extension.toml` configs |
| **Tech stack alignment** | Misaligned | Built on proprietary NVIDIA Omniverse Kit SDK. Requires NVIDIA container images (`nvcr.io/nvidia/omniverse`). premake5.lua + Kit extension system (not standard CMake/pip/container patterns). Not K8s-native. Docker support exists but requires NVIDIA runtime |
| **Dependency health** | Risky | 117 unique `omni.*` dependencies — all proprietary Omniverse Kit SDK components. No standard package manager (pip/npm/go) — deps managed entirely through Kit SDK. Cannot build or run without proprietary runtime. Dependency tree is opaque to standard scanning tools |
| **Test coverage** | Strong | 656 test files across extensions. Coverage.py configured. Tests run inside Kit extension test runner. Benchmarks exist. Single CI workflow (build-and-test.yml). Tests cover sensors, physics, ROS 2, asset import, GUI components |
| **Security posture** | Adequate | SECURITY.md present with NVIDIA PSIRT process. No SBOM. No signed releases. NVIDIA corporate security backing. But 117 proprietary deps are unauditable by downstream consumers |
| **Code quality signals** | Adequate | flake8 configured. 151 TODOs (0.2/kLOC — lowest of all assessed projects). No pre-commit hooks. Code review practice is minimal (NVIDIA-internal development). Churn is low (max 3 commits per file in 6mo — reflects periodic source drops, not active GitHub development) |
| **Extensibility** | Plugin API | Omniverse Kit extension system — strongest extension model of all assessed projects. Users create new extensions with Python or C++, declare dependencies, and register with the Kit runtime. Extension templates provided. However, extensions must run inside the proprietary Kit runtime |
| **Hardware portability** | Locked | Requires NVIDIA GPU. RTX required for photorealistic rendering. PhysX runs on NVIDIA GPU. Newton backend also requires CUDA (via Warp). No ROCm, no Metal, no CPU-only path. Linux x86-64 and aarch64 (DGX), Windows. No macOS |

### Architecture Overview

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **Omniverse Kit SDK** | Proprietary application runtime — manages extensions, USD stage, rendering, windowing | NVIDIA proprietary |
| **isaacsim.core.*** | Core simulation: simulation manager, rendering manager, cloner, throttling, versioning | omni.kit.*, omni.usd |
| **isaacsim.core.experimental.*** | New Warp-based API: actuators, materials, objects, prims, utils. Replaces deprecated PyTorch-based Core API | omni.warp.core |
| **isaacsim.physics.newton** | Newton physics backend integration — swaps out PhysX for Newton (Linux Foundation) | omni.warp.core, newton |
| **isaacsim.sensors.*** | Sensor simulation: camera (RTX), contact, IMU, lidar, effort, physics step | omni.hydra.rtx |
| **isaacsim.robot.*** | Robot primitives: manipulators, wheeled robots, drones, schema, policy execution | isaacsim.core.* |
| **isaacsim.robot_motion.*** | Motion planning: cuMotion, PINK IK solver, lula kinematics/path planner | CUDA (cuMotion) |
| **isaacsim.ros2.*** | ROS 2 bridge: joint publisher, TF, camera, lidar, clock, odometry, nav2 | ROS 2 (external) |
| **isaacsim.replicator.*** | Synthetic data generation: domain randomization, SDG pipeline, episode recording, teleop | omni.replicator |
| **isaacsim.asset.*** | Asset pipeline: URDF/MJCF/heightmap importers, URDF exporter, validation, transformation | omni.kit.asset_converter |
| **isaacsim.gui.*** | UI components: content browser, menu, settings, stage preview | omni.ui, omni.kit.menu |
| **isaacsim.streaming.*** | Remote streaming: WebRTC, RTSP, app streaming for cloud deployment | omni.kit.livestream |

### Dependency Analysis

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **Omniverse Kit SDK** | 110.0 (v6.0) | Proprietary | **Critical**: 117 unique `omni.*` extensions required. Proprietary runtime, cannot be redistributed. All Isaac Sim functionality flows through Kit SDK. This is the fundamental lock-in vector |
| **PhysX** | 5.x (via Kit SDK) | BSD-3-Clause | NVIDIA GPU-accelerated physics. Open source but CUDA-only |
| **Newton** | (via isaacsim.physics.newton) | Apache-2.0 | Linux Foundation governed. New in v6.0 as alternative physics backend. Also CUDA-only (via Warp) |
| **Warp** | (via omni.warp.core) | Apache-2.0 | NVIDIA GPU programming framework. Used by Core Experimental API and Newton. CUDA-only |
| **USD / OpenUSD** | (via Kit SDK) | Apache-2.0 | Scene format. Open standard (AOUSD). But Isaac Sim adds proprietary USD schemas |
| **NVIDIA Container Images** | nvcr.io | Proprietary | Docker base images from NVIDIA GPU Cloud. Required for containerized deployment |
| **ROS 2** | (external) | Apache-2.0 | Optional integration via ros2 extensions. Open Robotics / OSRA governed |

### Capabilities & Positioning

| Capability | Detail |
| --- | --- |
| **Multi-physics backends** | PhysX (default, GPU-accelerated) + Newton (v6.0, Linux Foundation). Can swap physics engine via .kit app config. Nested rigid body physics with GPU acceleration |
| **RTX photorealistic rendering** | Ray-traced rendering via NVIDIA RTX. Highest visual fidelity among all assessed simulators. NuRec Gaussian splatting (3DGS) support in v6.0 for photorealistic scene reconstruction |
| **Sensor simulation** | RTX-accelerated cameras, lidar, depth, segmentation, IMU, contact force. OmniSensor USD schema for extensible sensor definitions |
| **Synthetic data generation** | Full SDG pipeline: domain randomization, event/action data generation, episode recording, replicator workflows. Competitive with standalone SDG tools |
| **ROS 2 integration** | Comprehensive bridge: joint state, TF, camera, lidar, clock, odometry, Nav2, MoveIt. Bidirectional communication |
| **Asset pipeline** | Import URDF, MJCF, CAD (via PTC Onshape integration). Export URDF. Asset validation and transformation rules. USD-native scene format |
| **Teleoperation** | Isaac Teleop framework for remote robot control and demonstration data collection. XR/VR support |
| **Cloud deployment** | Headless mode, WebRTC/RTSP streaming, NVIDIA Launchable for cloud instances. Docker + docker-compose support |
| **Extension ecosystem** | 117 built-in extensions. User-extensible via Python/C++ extension templates. Strongest plugin architecture of assessed simulators |
| **Newton integration** | v6.0 adds Linux Foundation's Newton as alternative physics backend, enabling governance-independent physics. Significant for reducing PhysX single-vendor dependency |

### Lock-in Assessment

| Dimension | Risk | Detail |
| --- | --- | --- |
| **Hardware** | High | Requires NVIDIA GPU. RTX for rendering, CUDA for physics (both PhysX and Newton/Warp). No ROCm, Metal, or CPU fallback. Minimum: RTX 4080 workstation, A40 datacenter. Most hardware-locked simulator assessed |
| **Vendor** | High | 117 proprietary `omni.*` Kit SDK dependencies. NVIDIA controls runtime, rendering, asset pipeline, sensor simulation, and streaming. No contributions accepted. Docker images from NVIDIA container registry. Complete NVIDIA vertical stack |
| **Ecosystem** | High | Deep coupling to NVIDIA platform: Isaac Lab (learning), GR00T (foundation model), Cosmos (world model), Isaac ROS (perception), Isaac Perceptor. USD extensions are NVIDIA-specific. Kit app format is proprietary. Migration requires replacing the entire simulation stack — not just physics |

### Production Adoption

| User | Use Case |
| --- | --- |
| **ABB Robotics** | Digital twin validation of robot applications and production lines |
| **FANUC** | Production line simulation with NVIDIA Jetson-enabled controllers |
| **KUKA** | Robot application validation through physically accurate digital twins |
| **Yaskawa** | Manufacturing simulation and robot cell validation |
| **Figure AI** | Humanoid robot simulation and policy training (with Isaac Lab) |
| **Boston Dynamics** | Robot development, simulation, and policy validation |
| **Agility Robotics** | Digit humanoid simulation and training |
| **1X** | Humanoid simulation |
| **NEURA Robotics** | Humanoid development with GR00T models |
| **Skild AI** | Generalized robot intelligence validation (partnered with ABB, Universal Robots) |
| **FieldAI** | Robot brain training and policy validation |
| **Johnson & Johnson MedTech** | Monarch Platform surgical system training and validation |
| **CMR Surgical** | Versius surgical system robotic intelligence training |
| **LEM Surgical** | Dynamis surgical robot autonomous arm training |
| **PTC** | Onshape CAD-to-simulation workflow (announced GTC 2026) |
| **Caterpillar** | Factory digital twins for predictive maintenance |
| **World Labs** | Generative world model validation |
| **NVIDIA (internal)** | GR00T foundation model training and development |

### Build & CI

| Aspect | Details |
| --- | --- |
| **Build system** | premake5.lua (C++ extensions), Omniverse Kit extension system (Python), repo.toml (repo management). Non-standard — requires NVIDIA toolchain |
| **CI** | GitHub Actions — single `build-and-test.yml` workflow. Linux (Ubuntu) |
| **Reproducibility** | No standard lockfile. Dependencies managed via Kit SDK version pinning. Docker images from nvcr.io provide reproducibility boundary |
| **Platforms tested** | Linux x86-64 (primary), Linux aarch64 (DGX), Windows 11. Requires NVIDIA GPU with driver 535+ |

### Backlog Health

| Metric | Value |
| --- | --- |
| **Open issues** | ~670 |
| **Open PRs** | 13 (community-submitted, none will be merged per contribution policy) |
| **Median issue response time** | <24h |
| **Median PR merge time** | N/A — contributions not accepted |
| **Stale issues (>90 days)** | Moderate — rapid growth since GA |

---

## Red Hat Platform Fit Assessment

### Alignment Signals

- Apache-2.0 license for source code — can be read, forked, and redistributed in principle
- Broadest production adoption of any simulator assessed — ABB, FANUC, KUKA, Yaskawa, Figure AI, Boston Dynamics, J&J MedTech, and dozens more
- Docker support with docker-compose — containerized deployment model exists
- ROS 2 integration — aligns with open robotics ecosystem
- Newton physics backend (v6.0) — provides a governance-independent physics path via Linux Foundation
- USD scene format — open standard (AOUSD), though Isaac Sim adds proprietary extensions
- Headless + streaming modes — compatible with cloud/datacenter deployment patterns

### Risk Signals

- **Proprietary runtime dependency**: Omniverse Kit SDK with 117 proprietary `omni.*` extensions. Cannot be built, run, or redistributed without it. This is not solvable — it is a deliberate NVIDIA platform architecture choice
- **Does not accept contributions**: CONTRIBUTING.md explicitly states no contributions accepted. Red Hat cannot fix bugs upstream, contribute features, or influence roadmap. The only open-source engagement path is filing issues
- **CUDA-only**: No ROCm, no CPU fallback. Even the Newton physics backend runs via Warp (CUDA-only). The most hardware-locked simulator assessed
- **NVIDIA container images**: Docker base images from nvcr.io. Proprietary container registry dependency
- **Non-standard build system**: premake5.lua + Kit extension system. Not compatible with standard packaging (RPM, pip, CMake patterns)
- **Single-vendor governance**: No foundation, no charter, no external maintainers. 100% NVIDIA development with no community contribution path
- **Proprietary USD extensions**: While USD is an open standard, Isaac Sim adds NVIDIA-specific schemas (OmniSensor, etc.) that may not be portable

### Supply Chain Assessment

- **License conflicts**: Source code is Apache-2.0. But Omniverse Kit SDK is proprietary — cannot be redistributed. Additional components under NVIDIA Isaac Sim Additional License (proprietary). Effective posture prevents downstream redistribution as a complete product
- **Known CVEs**: Cannot scan — 117 proprietary Kit SDK deps are opaque to standard vulnerability scanners (pip-audit, osv-scanner, grype)
- **Single-maintainer risks**: Not applicable in the traditional sense — NVIDIA as an organization maintains everything. But the "single-vendor" risk is equivalent: all 653K LOC and 117 proprietary deps depend on NVIDIA's continued investment

**Technical verdict**: Strong — most feature-complete robotics simulation platform, strongest production adoption (industrial robots, humanoids, surgical, manufacturing), best rendering fidelity (RTX + NuRec 3DGS), most extensible architecture (117 Kit extensions). Newton integration in v6.0 shows physics backend flexibility. 653K LOC with strong test infrastructure.

**Red Hat fit**: Misalign — despite Apache-2.0 source code and the broadest industry adoption of any simulator, the proprietary Omniverse Kit SDK runtime (117 `omni.*` deps) makes Isaac Sim incompatible with Red Hat's open-source product model. Red Hat cannot ship, redistribute, contribute to, or fully support a platform built on proprietary NVIDIA runtime components. The explicit refusal of contributions eliminates any community engagement path beyond filing issues. The CUDA-only hardware requirement compounds the misalignment.

---

## Sources

- [Isaac Sim GitHub](https://github.com/isaac-sim/IsaacSim)
- [Isaac Sim Documentation](https://docs.isaacsim.omniverse.nvidia.com/)
- [Isaac Sim License](https://docs.isaacsim.omniverse.nvidia.com/5.0.0/common/license-isaac-sim-additional.html)
- [Isaac Sim 5.0 GA Announcement (SIGGRAPH 2025)](https://developer.nvidia.com/blog/isaac-sim-and-isaac-lab-are-now-available-for-early-developer-preview/)
- [Isaac Sim 6.0 GA Discussion](https://github.com/isaac-sim/IsaacSim/discussions/655)
- [Isaac Sim 6.0 Release Notes](https://docs.isaacsim.omniverse.nvidia.com/6.0.0/overview/release_notes.html)
- [NVIDIA Open Frameworks for Robotics (ROSCon 2025)](https://blogs.nvidia.com/blog/roscon-2025-open-framework-robotics/)
- [NVIDIA and Global Robotics Leaders — Physical AI (GTC 2026)](https://nvidianews.nvidia.com/news/nvidia-and-global-robotics-leaders-take-physical-ai-to-the-real-world)
- [PTC Onshape-Isaac Sim Workflow (GTC 2026)](https://www.ptc.com/en/news/2026/ptc-announces-onshape-nvidia-isaac-sim-workflow)
- [GTC 2026 Virtual Worlds & Physical AI](https://blogs.nvidia.com/blog/gtc-2026-virtual-worlds-physical-ai/)
