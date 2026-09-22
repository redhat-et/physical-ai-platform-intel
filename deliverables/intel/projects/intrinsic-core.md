# Intrinsic Core — Project Intelligence Report

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | Intrinsic Core (Intrinsic / Google Alphabet) |
| **Website** | [developer.intrinsic.ai](https://developer.intrinsic.ai) |
| **Building block** | Robotics Frameworks, Robot Control, Motion Planning |
| **Competes with** | ROS 2 (OSRA) — middleware framework, Isaac ROS (NVIDIA) — GPU-accelerated robotics stack, dora-rs (Dora) — dataflow runtime |
| **Depends on** | [ROS 2](ros2.md) — middleware framework (via `rules_ros2` Bazel integration), NVIDIA CUDA / TensorRT / Triton — GPU inference, NVIDIA FoundationPose — 6-DoF pose estimation |
| **Depended on by** | Flowstate (Intrinsic, proprietary) — SaaS IDE and cloud orchestration, [intrinsic-omts](https://github.com/intrinsic-ai/intrinsic-omts) — Open Machine Tending Solution reference design |

### Repo Scope

The `intrinsic-ai` GitHub org contains 14 repos. Intrinsic Core is the monorepo; satellite repos provide hardware integration, inference, examples, and the proprietary SDK bridge.

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| [intrinsic-ai/intrinsic-core](https://github.com/intrinsic-ai/intrinsic-core) | Core | Analyzed | Primary monorepo: runtime, control (ICON), motion planning, perception, kinematics, SDK, APIs. 740K+ LOC |
| [intrinsic-ai/icon-hwm-controller](https://github.com/intrinsic-ai/icon-hwm-controller) | Core | Noted | ros2_control bridge to ICON real-time control. Required for hardware execution |
| [intrinsic-ai/icon-shared-memory](https://github.com/intrinsic-ai/icon-shared-memory) | Core | Noted | Shared-memory IPC transport for ICON real-time loop |
| [intrinsic-ai/intrinsic-inference](https://github.com/intrinsic-ai/intrinsic-inference) | Core | Noted | ML inference framework with ROS 2 integration, Triton-based |
| [intrinsic-ai/intrinsic-moveit](https://github.com/intrinsic-ai/intrinsic-moveit) | Ecosystem | Noted | MoveIt 2 integration for motion/grasp planning |
| [intrinsic-ai/intrinsic-ros-camera-drivers](https://github.com/intrinsic-ai/intrinsic-ros-camera-drivers) | Ecosystem | Noted | ROS camera driver wrappers |
| [intrinsic-ai/malloc-guard](https://github.com/intrinsic-ai/malloc-guard) | Ecosystem | Noted | RT-safe heap allocation detector for real-time threads |
| [intrinsic-ai/intrinsic-omts](https://github.com/intrinsic-ai/intrinsic-omts) | Ecosystem | Noted | Open Machine Tending Solution — reference application |
| [intrinsic-ai/sdk](https://github.com/intrinsic-ai/sdk) | Ecosystem | Noted | Flowstate SDK (proprietary SaaS bridge) |
| [intrinsic-ai/sdk-ros](https://github.com/intrinsic-ai/sdk-ros) | Ecosystem | Noted | ROS wrappers for Flowstate SDK |
| [intrinsic-ai/sdk-examples](https://github.com/intrinsic-ai/sdk-examples) | Peripheral | Excluded | Examples for Flowstate SDK |
| [intrinsic-ai/sdk-ros-examples](https://github.com/intrinsic-ai/sdk-ros-examples) | Peripheral | Excluded | Examples for SDK ROS wrappers |
| [intrinsic-ai/collision-avoidance-metric](https://github.com/intrinsic-ai/collision-avoidance-metric) | Peripheral | Excluded | Research metric, 1 star, inactive |
| [intrinsic-ai/ipd](https://github.com/intrinsic-ai/ipd) | Peripheral | Excluded | Jupyter notebooks, 2 stars, inactive |

---

## Executive Summary

- **What it is**: Google/Alphabet's production-proven industrial robotics runtime open-sourced under Apache 2.0 at ROSCon 2026, providing integrated real-time control (ICON), collision-free motion planning, NVIDIA FoundationPose-based perception, grasp planning, and a k3s-containerized runtime — positioned as "Android for robotics" to drive Gemini model adoption through open infrastructure.
- **Health verdict**: Watch — brand-new open-source project (Sep 8, 2026) with only 14 days of public history, 64 commits from 31 authors (all Google/Intrinsic employees), Google CLA required, and Copybara-synced from internal monorepo meaning external contributions may face friction integrating upstream.
- **Technical verdict**: Strong — 740K+ LOC production-proven codebase with clean modular architecture (runtime, control, planning, perception, kinematics, SDK), hardware-agnostic HAL supporting ABB/FANUC/KUKA/UR, deterministic real-time control loop (ICON), 536 proto API definitions, and k3s-containerized deployment; however Bazel-only build system and heavy Google infrastructure dependencies (Abseil, gRPC, Protobuf) create integration overhead.
- **Red Hat fit**: Neutral — Apache 2.0 license and k3s/container-native architecture align well, but Google CLA, Bazel build system (vs. CMake/colcon ROS 2 standard), CUDA dependency for perception, and Copybara-gated contribution model limit Red Hat's ability to co-develop or integrate into RHEL-based stacks.
- **Recommendation**: Integrate — production-proven industrial runtime under Apache 2.0 with strong manipulation capabilities, but Google CLA, Copybara sync, Bazel build, and 14-day-old community limit co-development; monitor for genuine community formation, see [comparison](../project-comparisons/robot-middleware.md)

---

## Part A: Community & Project Health

### CHAOSS Metrics

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | 1 org (Google/Intrinsic at ~100%) | Low | 34 of 64 commits from @google.com emails, remainder from Intrinsic employees using GitHub noreply or @intrinsic.ai. Zero external contributors. 1 non-Intrinsic commit (gmx.net) |
| **Contributor Absence Factor** | 2 people for 50%+ of commits | Risk | intrinsic-renovate[bot] (9), simkli (7), drigz (4) account for ~31% of commits; insrc-copybara[bot] handles bulk syncs. Very early-stage — only 14 days of history |
| **Change Request Closure Ratio** | 0 opened / 0 closed | N/A | No external issues or PRs filed yet. Too early to measure |
| **Time to First Response** | N/A | N/A | No external issues filed. Community support via [developer.intrinsic.ai](https://developer.intrinsic.ai) forum |
| **Release Frequency** | 2 releases in 2 weeks | Active | Daily-ish releases: 20260921.0, 20260922.0. CalVer scheme (YYYYMMDD.N) |
| **Contribution Trend** | N/A | N/A | Too early to assess — project is 14 days old. Initial burst from monorepo export |
| **Libyears** | < 1 year | Current | Go 1.27.1, Abseil 20250814, Eigen 5.0.1, ROS 2 Lyrical, CUDA 12.8.1. All current |

### Strategic Metrics

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | Permissive | Apache-2.0 (SPDX: Apache-2.0). Copyright held by Intrinsic Innovation LLC. All repos in the org use Apache 2.0 — no proprietary-licensed core components (unlike Isaac ROS) |
| **Governance model** | Single-vendor | No governing body, no steering committee, no external roadmap input. Roadmap controlled by Intrinsic (Google/Alphabet subsidiary). Trademark held by Intrinsic Innovation LLC |
| **Contribution model** | CLA | Google CLA required ([cla.developers.google.com](https://cla.developers.google.com/)). Standard Google open-source CLA — contributor retains copyright, grants broad license. Follows Google Open Source Community Guidelines |
| **Corporate control risk** | High | 100% Google/Intrinsic-controlled. Copybara sync from internal monorepo (confirmed by `insrc-copybara[bot]`, `GitOrigin-RevId` markers, Google internal bug tracker references `b/NNNNNN` in TODOs). External PRs must be compatible with internal codebase to merge |
| **Community health** | Active | Frequent commits (daily Copybara syncs), active releases, but no external community participation yet. Developer community forum at developer.intrinsic.ai |
| **Ecosystem breadth** | Moderate | 14 repos covering runtime, control, planning, perception, inference, MoveIt integration, and reference applications. Hardware support for ABB, FANUC, KUKA, Universal Robots. OMTS reference solution provides end-to-end template |

### Governance Details

All identified maintainers are Google or Intrinsic employees. Commit email domains: 53% @google.com, 6% @intrinsic.ai, 37% GitHub noreply (likely also Google/Intrinsic).

| Maintainer / Key Contributor | Employer | Role |
| --- | --- | --- |
| **simkli** (sklimek@google.com) | Google | Top human contributor (7 commits), likely core maintainer |
| **drigz** (rodrigoq@google.com) | Google | Active contributor (4 commits), infrastructure and CI |
| **dfreese** (freese@google.com) | Google | Active contributor (3 commits) |
| **feuerste** (feuer@google.com) | Google | Active contributor (3 commits) |
| **mbeards** (beardsworth@google.com) | Google | Active contributor (3 commits) |
| **yannickkemp** (@intrinsic.ai) | Intrinsic | Active contributor (3 commits), Intrinsic employee |
| **insrc-copybara[bot]** | Google | Automated Copybara sync bot — handles bulk monorepo exports |
| **intrinsic-renovate[bot]** | Intrinsic | Automated dependency update bot (9 commits) |

**Company leadership** (not code contributors but control roadmap):

| Leader | Role | Background |
| --- | --- | --- |
| **Wendy Tan White** | CEO | Reports to Hiroshi Lockheimer (Google SVP) |
| **Brian Gerkey** | CTO | Creator of ROS, Board Chair of Open Robotics (acquired by Intrinsic 2022) |
| **Torsten Kroeger** | CSO | Robotics research background |
| **Stefan Nusser** | CPO | Product strategy |

### Funding and Sustainability

Intrinsic was founded in 2021 as an Alphabet "Other Bet," acquired Open Source Robotics Corp (OSRC, maintainers of ROS and Gazebo) in 2022, and was folded into Google proper in February 2026. The company has ~230 employees. The open-sourcing follows a deliberate platform strategy: open the infrastructure layer to drive adoption of proprietary Flowstate SaaS and Gemini AI model integration. Google CEO Sundar Pichai calls Intrinsic "the Android of robotics."

Funding risk is low in the near term given full Google backing and commercial traction (Foxconn JV, FANUC partnership, 1,000+ robots shipped). The "Android playbook" monetizes cloud services (Flowstate) and Gemini AI models rather than the runtime itself. However, Google has a history of abandoning robotics projects (Everyday Robots shutdown 2023), and the connection between Intrinsic and DeepMind's Gemini Robotics 2 remains unclear — the two halves do not visibly connect yet.

---

## Part B: Technical Analysis

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | Clear | Clean modular decomposition: `intrinsic_runtime` (k3s orchestration), `intrinsic_control` (ICON real-time), `intrinsic_motion_planning`, `intrinsic_perception`, `intrinsic_kinematics`, `intrinsic_sdk`, `intrinsic_apis` (536 proto definitions). Well-defined component boundaries |
| **Tech stack alignment** | Neutral | k3s container-native is promising; but Bazel build (not CMake/colcon), Abseil/gRPC/Protobuf (Google stack vs. ROS 2 standard), Go for infrastructure (not typical in robotics). C++20 for control/planning is standard |
| **Dependency health** | Watch | Heavy dependency on Google-maintained libraries (Abseil, gRPC, Protobuf, Bazel rules). NVIDIA CUDA 12.8.1 / TensorRT / Triton for inference. 6725 pinned Python requirements. Go module with 100+ dependencies. All well-maintained but tightly coupled to Google ecosystem |
| **Test coverage** | Weak | Only 8 test files identified in open-source export (7 unit, 1 integration). 35 `*_test.cc`/`*_test.py` files across 740K LOC. No coverage reporting configured. Tests likely run internally but stripped from Copybara export |
| **Security posture** | Adequate | SECURITY.md present with private vulnerability reporting. No CVE scanning configured in CI. No SBOM generation. No OpenSSF Scorecard badge. Too new for CVE history |
| **Code quality signals** | Adequate | 194 TODO markers (1.1 per KLOC) — many reference Google internal bug tracker (`b/NNNNNN`). No linter configuration in open-source export. No pre-commit hooks. `aspect_rules_lint` declared in MODULE.bazel but not configured for external use |
| **Extensibility** | SDK | `intrinsic_sdk` provides base interfaces for custom skills, hardware assets, and execution nodes. 536 proto API definitions provide clear extension surface. MoveIt 2 plugin architecture for motion planning. Hardware Abstraction Layer (HAL) for adding robot drivers |
| **Hardware portability** | Limited | CUDA required for perception (FoundationPose) and inference (Triton). Real-time control (ICON) is CPU-based and hardware-agnostic via HAL. Build declares `rules_cuda` but no ROCm/CPU fallback for perception |

### Architecture Overview

The architecture follows a layered design with clean separation between runtime orchestration, real-time control, planning, and perception.

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **intrinsic_runtime** | k3s-containerized execution engine: process lifecycle, event scheduling, application state sync. Setup scripts for k3s cluster and real-time kernel configuration | k3s, Helm, Kubernetes |
| **intrinsic_control (ICON)** | Deterministic real-time control loop with single-cycle controller switching. HAL for arms, grippers, fieldbus I/O. 161K LOC | icon-shared-memory (IPC), icon-hwm-controller (ros2_control bridge), Pinocchio, Eigen |
| **intrinsic_motion_planning** | Collision-free path generation: Cartesian and C-space solvers, heterogeneous motion blending, multi-segment trajectory fusion. 54K LOC | OR-Tools, NLopt, Coal, CGAL, Eigen |
| **intrinsic_perception** | Camera/point-cloud interfaces, NVIDIA FoundationPose 6-DoF pose estimation, sensor processing. 45K LOC | OpenCV, PCL, CUDA, TensorRT, FoundationPose |
| **intrinsic_inference** | Local ML model serving on edge. Multi-framework support (TensorFlow, PyTorch, JAX). Triton-based inference | NVIDIA Triton, CUDA, TensorRT, TensorFlow, PyTorch |
| **intrinsic_kinematics** | Kinematic modeling and solver library for robotic manipulators. 23K LOC | Eigen, Pinocchio |
| **intrinsic_sdk** | Developer toolkit: base interfaces, serialization helpers, data structures for custom skills, hardware assets, execution nodes. 73K LOC | Protobuf, gRPC, Abseil |
| **intrinsic_apis** | 536 Protocol Buffer definitions defining the full API surface. 26K LOC | Protobuf |
| **intrinsic_hardware** | Hardware device drivers for ABB (EGM), FANUC (12 models), KUKA, Universal Robots, Orbbec cameras, Weiss WSG32 grippers | HAL interface from ICON |
| **intrinsic (core platform)** | Executive engine (behavior trees), world/scene management, simulation integration, manipulation pipeline, solutions framework. 329K LOC | Gazebo, OpenUSD, Zenoh |
| **incode** | Cloud services, frontend UI, ML pipelines. Partially exported from internal — includes GCP API integrations | GCP APIs, LangChain, Google ADK |

### Dependency Analysis

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **Abseil (C++ and Python)** | 20250814.2 / 2.1.0 | Apache-2.0 | Google-maintained, stable. Core dependency throughout codebase |
| **gRPC** | 1.74.0 | Apache-2.0 | Google-maintained. Used for all service communication |
| **Protobuf** | 32.1 | BSD-3-Clause | Google-maintained. 536 proto files define API surface |
| **Eigen** | 5.0.1 | MPL-2.0 | Community-maintained. Used in kinematics and planning |
| **Pinocchio** | 2.6.21 | BSD-2-Clause | LAAS-CNRS. Rigid-body dynamics and kinematics |
| **OpenCV** | 4.12.0 | Apache-2.0 | Community-maintained. Image processing in perception pipeline |
| **OR-Tools** | 9.15 | Apache-2.0 | Google-maintained. Constraint solving for motion planning |
| **Ceres Solver** | 2.2.0 | BSD-3-Clause | Google-maintained. Nonlinear optimization |
| **Gazebo (gz-sim)** | 10.5.0 | Apache-2.0 | OSRA-governed. Native digital twin / simulation |
| **OpenUSD** | 25.11 | Apache-2.0 | Pixar/Alliance. Scene description for digital twin |
| **PCL** | 1.15.1 | BSD-3-Clause | Community-maintained. Point cloud processing |
| **Boost** | 1.90.0 | BSL-1.0 | Community-maintained. Multiple modules for planning/CGAL |
| **CUDA** | 12.8.1 | NVIDIA proprietary | Required for perception and inference. No ROCm alternative |
| **NVIDIA Triton** | via container image | BSD-3-Clause | Required for inference serving. NVIDIA-controlled |
| **TensorFlow / PyTorch / JAX** | 2.20.0 / 2.9.0 / 0.5.3 | Apache-2.0 | All three ML frameworks included in Python deps |
| **ROS 2 (rules_ros2)** | Lyrical | Apache-2.0 | OSRA-governed. Bazel integration via `com_github_mvukov_rules_ros2` |
| **Zenoh** | 1.7.2 | Apache-2.0 | Eclipse Foundation. Middleware transport alternative |
| **k3s** | system install | Apache-2.0 | Rancher/SUSE-maintained. Runtime orchestration layer |
| **Go** | 1.27.1 | BSD-3-Clause | Google-maintained. Used for infrastructure services |
| **LangChain / Google ADK / A2A** | 1.2.10 / 2.3.0 / 0.3.25 | MIT / Apache-2.0 | Agentic AI integration — LLM orchestration and Agent-to-Agent protocol |

### Capabilities and Positioning

| Capability | Detail |
| --- | --- |
| **Real-time control (ICON)** | Deterministic control loop with single-cycle controller switching. Shared-memory IPC for RT-safe communication. HAL abstraction enables hardware-agnostic arm/gripper control |
| **Motion planning** | Collision-free path generation with Cartesian and C-space solvers. Multi-segment trajectory blending with heterogeneous velocity/acceleration profiles. MoveIt 2 integration available via `intrinsic-moveit` |
| **6-DoF pose estimation** | Integrated NVIDIA FoundationPose for CAD-model-free 6-DoF object pose estimation. Directly feeds into grasp planning and manipulation pipelines |
| **Grasp planning** | Built-in grasp planning capability using pose estimation output. Supports un-fixtured part manipulation |
| **Hardware abstraction** | Unified HAL supporting ABB (EGM), FANUC (12 models), KUKA, Universal Robots. Swap robot arms without driver rewrites |
| **Container-native runtime** | k3s-based deployment with declarative YAML manifests. Process lifecycle management, event scheduling, state sync |
| **Digital twin** | Native Gazebo-based digital twin with OpenUSD scene description. Integrated simulation for sim-to-real workflows and validation |
| **Edge inference** | Triton-based local ML serving with multi-framework support (TensorFlow, PyTorch, JAX). CUDA/TensorRT acceleration |
| **Behavior tree executive** | Built-in execution engine using behavior trees for task sequencing. Supports skill composition and reactive behaviors |
| **Agentic AI integration** | LangChain, Google ADK (Gemini), and A2A (Agent-to-Agent) protocol support in Python dependencies — indicates Gemini-driven agentic robotics pipeline |
| **ROS 2 interoperability** | Bridges modern C++/Bazel development with ROS 2 ecosystem. Camera drivers, ros2_control integration, Zenoh transport |

### Lock-in Assessment

| Dimension | Risk | Detail |
| --- | --- | --- |
| **Hardware** | Medium | Control (ICON) is hardware-agnostic via HAL. Perception and inference require NVIDIA GPU (CUDA 12.8.1, TensorRT, Triton). No ROCm or CPU fallback for vision pipeline |
| **Vendor** | High | Copybara sync from Google monorepo means Google controls the canonical codebase. External contributions must be compatible with internal code. Google CLA required. 194 TODOs reference internal bug tracker (b/NNNNNN). Trademark held by Intrinsic Innovation LLC |
| **Ecosystem** | Medium | Apache 2.0 enables forking, but the 740K+ LOC codebase with deep Google infrastructure dependencies (Abseil, gRPC, Protobuf, Bazel) creates significant migration cost. Flowstate SaaS creates upgrade gravity toward Intrinsic's proprietary cloud |

### Production Adoption

| User | Use Case |
| --- | --- |
| **Foxconn** | Joint venture (Oct 2025) for general-purpose intelligent robots; U.S. factory deployment expected 2026 |
| **FANUC** | Full robot lineup integration including CRX collaborative series. 1,000+ robots shipped with physical AI since Dec 2025 IRE demo |
| **Trumpf Machine Tools** | Working with prototype of the Intrinsic system for CNC machine tending |
| **Intrinsic (Google)** | Internal production use for customer robotics deployments. The open-source release is an export of Intrinsic's production codebase |

Hardware ecosystem partners include ATI, Schunk, Robotiq (grippers), Basler (cameras), plus native drivers for ABB, KUKA, and Universal Robots. Market context: only 8% of U.S./European fabrication shops have any automation; McKinsey projects the general-purpose robot market at $370B by 2040.

### Build and CI

| Aspect | Details |
| --- | --- |
| **Build system** | Bazel (primary), Go modules for infrastructure services. `MODULE.bazel` with bzlmod for dependency management. Not compatible with standard ROS 2 `colcon build` workflow |
| **CI** | GitHub Actions: `postsubmit.yml` (Bazel build on push to main), `release.yml` (release artifacts). Runs on `ubuntu-24.04-8core` runner |
| **Reproducibility** | `go.sum` lockfile for Go deps. `requirements.txt` with 6725 pinned Python packages (with hashes). Bazel provides hermetic builds. No Dockerfile in main repo |
| **Platforms tested** | Ubuntu 24.04 LTS (primary), Ubuntu 26.04 LTS, Ubuntu 22.04 LTS (supported). Linux only — no macOS/Windows. x86_64 assumed |

### Backlog Health

| Metric | Value |
| --- | --- |
| **Open issues** | 0 |
| **Open PRs** | 0 |
| **Median issue response time** | N/A (no external issues yet) |
| **Median PR merge time** | N/A (no external PRs yet) |
| **Stale issues (>90 days)** | 0 |

The project is 14 days old with no external issues or PRs filed. Internal development continues via Copybara sync (commits reference internal PR numbers in the thousands, e.g., `#55873`, `#55893`, indicating extensive internal development history).

---

## Red Hat Platform Fit Assessment

### Alignment Signals

- Apache 2.0 license across all repos — compatible with downstream redistribution and RHEL packaging
- k3s-containerized runtime architecture aligns with OpenShift/Kubernetes deployment model
- Hardware-agnostic HAL (ABB, FANUC, KUKA, UR) aligns with Red Hat's vendor-neutral strategy
- ROS 2 Lyrical integration — compatible with existing ROS 2 ecosystem investments
- 536 Protobuf API definitions provide clear integration surface for platform services
- Production-proven codebase (exported from Google internal use) reduces technology risk

### Risk Signals

- Google CLA required — limits Red Hat contribution model (Red Hat prefers DCO)
- Copybara sync from internal monorepo — external contributions face friction; Google controls canonical codebase
- Bazel build system — incompatible with standard ROS 2 colcon/CMake workflow and RHEL packaging (rpmbuild expects CMake/Autotools/Meson)
- CUDA dependency for perception/inference — no ROCm support, conflicts with AMD GPU strategy
- Heavy Google infrastructure stack (Abseil, gRPC, Protobuf) — different from ROS 2 community norms
- 194 TODOs reference Google internal bug tracker (`b/NNNNNN`) — indicates incomplete decoupling from internal codebase
- Trademark restrictions — "Intrinsic" and "Intrinsic Core" are trademarked by Intrinsic Innovation LLC
- Google's history of abandoning robotics projects (Everyday Robots, 2023) introduces long-term sustainability risk

### Supply Chain Assessment

- **License conflicts**: No copyleft dependencies detected in direct dependency scan. Eigen uses MPL-2.0 (compatible with Apache 2.0). Boost uses BSL-1.0 (permissive). CUDA runtime is proprietary but dynamically linked
- **Known CVEs**: No security scanner available to assess. SECURITY.md provides private vulnerability reporting process. Too new for CVE history
- **Single-maintainer risks**: No critical single-maintainer dependencies identified. Major dependencies (Abseil, gRPC, Protobuf, Eigen, Boost) are all well-maintained multi-contributor projects. Google infrastructure deps are Google-maintained (low bus factor risk but high vendor concentration)

---

## Sources

- [intrinsic-ai/intrinsic-core GitHub](https://github.com/intrinsic-ai/intrinsic-core) — primary repository
- [Intrinsic Developer Community](https://developer.intrinsic.ai) — official documentation and forums
- [intrinsic-ai GitHub org](https://github.com/intrinsic-ai) — 14 repos in the organization
- [Intrinsic company profile](../companies/intrinsic.md) — competitive intelligence profile
- [Intrinsic blog: Introducing Intrinsic Core](https://www.intrinsic.ai/blog/posts/introducing-intrinsic-core) — ROSCon 2026 announcement
- [Forbes: Google Is Giving Away 'The Android Of Robotics'](https://www.forbes.com/sites/johnkoetsier/2026/09/22/google-is-giving-away-the-android-of-robotics/) — announcement coverage
- [TechCrunch: Intrinsic joins Google](https://techcrunch.com/2026/02/25/alphabet-owned-robotics-software-company-intrinsic-joins-google/) — organizational history
- [FANUC integration announcement](https://www.intrinsic.ai/blog/posts/accelerating-physical-ai-fanuc-integrates-with-intrinsic-and-flowstate) — production adoption
- [CNBC: Google wants Intrinsic to be Android for robots](https://www.cnbc.com/2026/02/28/google-wants-intrinsic-to-be-android-for-robots-moves-into-physical-ai.html) — strategy analysis
- [CONTRIBUTING.md](https://github.com/intrinsic-ai/intrinsic-core/blob/main/CONTRIBUTING.md) — Google CLA requirement
- [TRADEMARK.md](https://github.com/intrinsic-ai/intrinsic-core/blob/main/TRADEMARK.md) — trademark usage guidelines
