# Newton — Project Intelligence Report

**Date**: 2026-06-22
**Last updated**: 2026-06-22
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | Newton (Linux Foundation) |
| **Website** | [developer.nvidia.com/newton-physics](https://developer.nvidia.com/newton-physics) |
| **Building block** | Simulation Engines |
| **Competes with** | MuJoCo (Google DeepMind), Genesis World (Genesis Embodied AI), Gazebo (Open Robotics/OSRA), Isaac Sim (NVIDIA), PyBullet (Erwin Coumans), Drake (Toyota Research Institute), Brax (Google) |

### Repo Scope

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| [newton-physics/newton](https://github.com/newton-physics/newton) | Core | Analyzed | Primary repo — GPU-accelerated physics engine built on NVIDIA Warp |
| [newton-physics/newton-governance](https://github.com/newton-physics/newton-governance) | Peripheral | Read | Governance docs, TSC/maintainer lists, CLA terms — read for governance analysis |
| [newton-physics/newton-assets](https://github.com/newton-physics/newton-assets) | Ecosystem | Noted | Permissively licensed test assets (53 stars) |
| [newton-physics/mujoco-usd-converter](https://github.com/newton-physics/mujoco-usd-converter) | Ecosystem | Noted | MJCF → OpenUSD converter (70 stars) |
| [newton-physics/urdf-usd-converter](https://github.com/newton-physics/urdf-usd-converter) | Ecosystem | Noted | URDF → OpenUSD converter (56 stars) |
| [newton-physics/newton-usd-schemas](https://github.com/newton-physics/newton-usd-schemas) | Ecosystem | Noted | OpenUSD schemas for Newton (11 stars) |
| [newton-physics/newton-asv](https://github.com/newton-physics/newton-asv) | Peripheral | Excluded | Airspeed velocity benchmarking dashboard (4 stars) |
| [newton-physics/.github](https://github.com/newton-physics/.github) | Peripheral | Excluded | Org readme |
| [newton-physics/newton-actuators](https://github.com/newton-physics/newton-actuators) | Peripheral | Excluded | Archived — actuator model library (7 stars) |
| [google-deepmind/mujoco_warp](https://github.com/google-deepmind/mujoco_warp) | Upstream | Linked | MuJoCo Warp — GPU physics backend consumed by Newton; different governance (Google DeepMind) |
| [google-deepmind/mujoco](https://github.com/google-deepmind/mujoco) | Upstream | Linked | MuJoCo core — MuJoCo Warp is a GPU port of this; see [MuJoCo report](mujoco.md) |

---

## Executive Summary

- **What it is**: GPU-accelerated, extensible physics engine targeting robotics RL and sim-to-real, built on NVIDIA Warp with multiple solvers (MuJoCo Warp, Kamino); contributed to the Linux Foundation by NVIDIA, Disney Research, and Google DeepMind
- **Health verdict**: Watch — Linux Foundation governance provides structural safeguards (balanced TSC with 3 founding orgs), but NVIDIA dominates commits (~61%) and the maintainer list (5 of 8), and the hard dependency on NVIDIA Warp (CUDA-only) means vendor-neutral governance does not extend to the technology stack
- **Technical verdict**: Strong — clean modular architecture, 8 pluggable solvers, extremely lean dependency tree (1 direct dep), strong test/CI infrastructure, GPU-parallel performance leadership
- **Red Hat fit**: Misalign — CUDA-only via NVIDIA Warp conflicts with hardware-neutral positioning; excellent governance (LF) and license (Apache-2.0) but architectural lock-in is fundamental
- **Recommendation**: Integrate (recommended pick) — best governance fit (LF charter, DCO), pluggable solver architecture, and strategic positioning as vendor-neutral simulation standard; CUDA-only hardware is the main gap; see [comparison](../project-comparisons/simulation-engines.md)

---

## Part A: Community & Project Health

### CHAOSS Metrics

<!-- Industry-standard community health metrics aligned with CHAOSS (https://chaoss.community) -->

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | 1 org (NVIDIA at ~61%) | Low | Script reports 2 due to fragmented NVIDIA company fields ("NVIDIA", "NVIDIA ", "Simulation Technology, Nvidia") and untagged NVIDIA employees (adenzler-nvidia, nvtw, preist-nvidia). Consolidated: NVIDIA ~61%, USC ~25%, Disney Research ~3%, others ~11% |
| **Contributor Absence Factor** | 3 people for 50% of commits | Watch | eric-heiden (25%), adenzler-nvidia (17%), shi-eric (14%). Top 3 = 56% of all commits |
| **Change Request Closure Ratio** | 1706 opened / 1652 closed in 12mo | Healthy (0.96) | 1452 merged. Very responsive to PRs — likely reflects high internal contribution rate |
| **Time to First Response** | <1h median | Fast | Sample of 10 recent PRs. Most PRs are internal; CodeRabbit AI bot provides instant automated review |
| **Release Frequency** | 5 releases in ~14mo | Active | v0.1.0 (Apr 2025) → v1.3.0 (Jun 2026). Reached v1.0 in Sep 2025, now at v1.3. Monthly cadence |
| **Contribution Trend** | N/A (young project) | Stable | Project is only ~14 months old — no meaningful all-time vs. recent divergence yet. NVIDIA has dominated from inception (~61%). Watch for whether Disney Research and Google DeepMind increase code contributions beyond governance participation |
| **Libyears** | <!-- TODO: run project-tech-eval --> | | |

### Strategic Metrics

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | Permissive | Apache-2.0 (SPDX). Standard Apache 2.0 patent grant. Documentation under CC-BY-4.0 |
| **Governance model** | Foundation | Linux Foundation project. TSC with 6 members from 3 orgs (NVIDIA, Disney Research, Google DeepMind). Charter in [newton-governance](https://github.com/newton-physics/newton-governance) repo |
| **Contribution model** | CLA | Linux Foundation [EasyCLA](https://lfcla.com/) required. Supports individual (ICLA) and corporate (CCLA) agreements. `linux-foundation-easycla[bot]` enforces on PRs |
| **Corporate control risk** | High | Despite LF governance, NVIDIA dominates: ~61% of commits, 5 of 8 maintainers, product manager (Mohajerani) co-chairs TSC. Hard runtime dependency on NVIDIA Warp (CUDA-only) creates architectural lock-in that governance cannot override. TSC itself is balanced (2-2-2). |
| **Community health** | Active | 5.1K stars, 576 forks, 266 open issues, 75 contributors. Very young project (first commit Apr 2025). Rapid growth — reached 5K stars in 14 months. CodeRabbit AI and Codecov integrated |
| **Ecosystem breadth** | Moderate | Integrates with Isaac Lab (NVIDIA), MuJoCo Warp, OpenUSD. Supported by TU Munich, Peking University, Lightwheel, Style3D. Young project — ecosystem still forming |

### Governance Details

#### TSC Members

| Member | Employer | Role |
| --- | --- | --- |
| **Moritz Baecher** | Disney Research, Zurich | TSC member. Leads Disney Research. Created Kamino solver for animatronic robotics (Olaf). PhD Harvard, MSc ETH |
| **Vassilios Tsounis** | Disney Research, Zurich | TSC co-chair. Lead author of Kamino solver. PhD ETH Zurich (robotics, RL) |
| **Yuval Tassa** | Google DeepMind | TSC member. Creator of MuJoCo. Provides physics engine expertise |
| **Erik Frey** | Google DeepMind | TSC member. Co-author of Brax (JAX physics engine). Contributor to Gemini Robotics |
| **Mohammad Mohajerani** | NVIDIA | TSC co-chair. Senior product manager for Warp and Newton. Previously at Sanctuary AI, Haply Robotics, CM Labs |
| **Miles Macklin** | NVIDIA | TSC member. Creator of NVIDIA Warp. Principal research scientist |

#### Maintainers

| Maintainer | Employer | Commits | Role |
| --- | --- | --- | --- |
| **Eric Heiden** (eric-heiden) | University of Southern California | 519 (25%) | Core maintainer. Largest individual contributor. Research focus on differentiable simulation |
| **Alain Denzler** (adenzler-nvidia) | NVIDIA | 353 (17%) | Core maintainer |
| **Eric Shi** (shi-eric) | NVIDIA | 280 (14%) | Core maintainer |
| **Kenny Vilella** (Kenny-Vilella) | NVIDIA | 75 (4%) | Maintainer |
| **Miles Macklin** (mmacklin) | NVIDIA | 31 (2%) | Maintainer (also TSC). Warp creator |
| **Philipp Reist** (preist-nvidia) | NVIDIA | 25 (1%) | Maintainer |
| **Vassilios Tsounis** (vastsoun) | Disney Research | ~20 | Maintainer (also TSC co-chair). Focus on Kamino solver |
| **Saran Tunyasuvunakool** (saran-t) | Google DeepMind | <10 | Maintainer. Also core MuJoCo maintainer — bridge role between MuJoCo and Newton |

#### Employer Breakdown (Commits)

| Organization | Estimated Commits | % | Contributors |
| --- | --- | --- | --- |
| NVIDIA | ~1,260 | ~61% | adenzler-nvidia, shi-eric, vreutskyy, nvtw, Kenny-Vilella, camevor, AnkaChan, mmacklin, daniela-hase, preist-nvidia, mzamoramora-nvidia, gyeomannvidia, Milad-Rakhsha-NV, nvlukasz |
| University of Southern California | 519 | 25% | eric-heiden |
| Disney Research | ~60 | ~3% | vastsoun, gdaviet |
| Google DeepMind | <10 | <1% | saran-t |
| Style3D / Linctex | 23 | 1% | WenchaoHuang |
| Others / Unaffiliated | ~190 | ~9% | AntoineRichard, jvonmuralt, jumyungc, and others |

### Funding & Sustainability

Newton is funded by its three founding corporate sponsors — NVIDIA, Disney Research, and Google DeepMind — through direct employee contributions under the Linux Foundation umbrella. There is no external funding, grant mechanism, or donation model.

**Sustainability assessment**: Medium risk. The Linux Foundation governance structure is a significant mitigation — the TSC is balanced (2-2-2 across NVIDIA, Disney, Google), the charter and CLA are standard LF practices, and the trademark is held by LF (not NVIDIA). However:

- **Operational control is NVIDIA-heavy**: 5 of 8 maintainers are NVIDIA employees, ~61% of commits come from NVIDIA, and NVIDIA's product manager co-chairs the TSC. Day-to-day development is effectively NVIDIA-led despite the balanced TSC.
- **Architectural dependency**: Newton is built on NVIDIA Warp, which is a proprietary-ecosystem technology (CUDA-only, NVIDIA-maintained). If NVIDIA withdrew Warp support, Newton would need to be substantially re-architectured.
- **USC dependency**: Eric Heiden (USC) contributes 25% of all commits as a single academic contributor. If he moved to an employer that restricted contributions, the non-NVIDIA contributor base would shrink dramatically.
- **Disney and Google are governance participants, not code drivers**: Disney Research (~3% commits) and Google DeepMind (<1% commits) sit on the TSC but contribute minimally to code. Their value is governance balance, not development capacity.

**Mitigating factors**: LF governance means the project cannot be unilaterally relicensed or redirected. The TSC charter requires majority vote for significant decisions. Multiple solvers (MuJoCo Warp, Kamino) reduce single-solver dependency. The converter tools (MJCF→USD, URDF→USD) enable some portability of assets.

---

## Part B: Technical Analysis

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | Clear | Clean modular separation: sim (model/state/builder), solvers (pluggable backends), geometry, sensors, actuators, viewer. Public API in top-level `newton/*.py`, internals in `newton/_src/` |
| **Tech stack alignment** | Neutral | Python-native (pip install), no K8s/container dependency. Not PyTorch-based but interoperates via Warp tensors. CUDA-primary but macOS CPU mode exists. Linux-first |
| **Dependency health** | Healthy | Only 1 direct dependency: `warp-lang>=1.14.0`. Optional: `mujoco-warp`, `mujoco`, `scipy`, `requests`. Extremely lean dependency tree |
| **Test coverage** | Strong | 179 test files, pytest framework, Codecov integration, benchmarks (ASV). CI runs on AWS GPU instances. Coverage reporting configured |
| **Security posture** | Adequate | SECURITY.md present. No CVE scanner installed to verify. Apache-2.0 with SPDX headers. No SBOM or signed releases detected |
| **Code quality signals** | Adequate | Ruff/pylint/black configured, pre-commit hooks. 260 TODOs (0.6/kLOC — acceptable for young project). Churn concentrated in builder.py and solver files (expected for active development). Consistent code review via CodeRabbit AI |
| **Extensibility** | Plugin API | Multiple solver backends (MuJoCo Warp, Kamino, XPBD, VBD, Semi-implicit, Featherstone, Style3D, Implicit MPM) demonstrate pluggable solver architecture. Users can implement custom solvers via the `Solver` base class |
| **Hardware portability** | Limited | CUDA-primary via NVIDIA Warp. macOS supported CPU-only. No ROCm or Vulkan backend. Warp itself is CUDA-only for GPU acceleration |

### Architecture Overview

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **sim** (model, state, builder) | Scene representation — models, states, contacts, controls. `ModelBuilder` creates simulation scenes from URDF/MJCF/USD | warp-lang |
| **solvers** | Pluggable physics backends. 8 solver implementations available | warp-lang, mujoco-warp (optional) |
| **solvers/mujoco** | MuJoCo Warp integration — primary solver for robotics RL | mujoco-warp, mujoco |
| **solvers/kamino** | Disney Research solver — deformable bodies, animatronic robotics | warp-lang |
| **geometry** | Collision detection, raycasting, mesh operations, particle systems | warp-lang |
| **sensors** | Camera (tiled), IMU, contact sensors | warp-lang |
| **actuators** | Motor models, PD controllers, implicit actuators | warp-lang |
| **viewer** | OpenGL-based visualization | warp-lang |
| **usd** | OpenUSD import/export for scene descriptions | usd-core (optional) |
| **math** | Quaternion, transform, spatial vector utilities | warp-lang |

### Dependency Analysis

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **warp-lang** | >=1.14.0 | Apache-2.0 | NVIDIA single-vendor. CUDA-only for GPU. Critical runtime — Newton cannot function without it |
| **mujoco-warp** | >=3.8.0.3 (optional) | Apache-2.0 | Google DeepMind maintained. GPU port of MuJoCo. Primary solver backend |
| **mujoco** | ~=3.8.0 (optional) | Apache-2.0 | Google DeepMind maintained. CPU reference implementation |
| **scipy** | >=1.11.0 (optional) | BSD-3-Clause | Well-maintained, no risk |
| **usd-core** | (optional) | Modified Apache-2.0 | Pixar/Alliance for OpenUSD. Large dependency |

### Capabilities & Positioning

| Capability | Detail |
| --- | --- |
| **GPU-parallel physics** | Massively parallel simulation via NVIDIA Warp. MuJoCo Warp achieves up to 252× MJX speed for locomotion, 475× for manipulation on RTX PRO 6000 |
| **Multi-solver architecture** | 8 pluggable solvers: MuJoCo Warp (rigid body robotics), Kamino (deformable/animatronic), XPBD, VBD, Semi-implicit, Featherstone, Style3D (cloth), Implicit MPM (granular) |
| **Differentiable simulation** | End-to-end differentiability via Warp's AD, enabling gradient-based policy optimization |
| **Scene format support** | URDF, MJCF, OpenUSD import. USD-first scene representation with converters for other formats |
| **Sensor simulation** | Tiled camera (GPU-accelerated), IMU, contact sensors |
| **Python-native API** | `pip install newton`, no build dependencies. Clean Python API with Warp kernel extension points |

### Lock-in Assessment

| Dimension | Risk | Detail |
| --- | --- | --- |
| **Hardware** | High | NVIDIA Warp is CUDA-only for GPU acceleration. macOS runs CPU-only. No ROCm, no Vulkan, no Metal GPU path. Using Newton for GPU workloads requires NVIDIA GPUs |
| **Vendor** | Medium | NVIDIA contributes ~61% of code and controls Warp (the sole runtime dependency). LF governance provides structural protection but cannot change the CUDA-only architecture. MuJoCo Warp (Google DeepMind) as primary solver provides some counterweight |
| **Ecosystem** | Low | OpenUSD, URDF, MJCF are open standards. Assets are portable. No proprietary scene format or asset store lock-in |

### Production Adoption

| User | Use Case |
| --- | --- |
| **Skild AI** | RL policies for GPU rack assembly (connector insertion, board placement) with Newton + Isaac Lab; partnering with Foxconn for Blackwell production lines |
| **Samsung + Lightwheel** | Deformable simulation for cable manipulation in refrigerator assembly |
| **Disney Research** | Animatronic character robots (Olaf-class) using Kamino solver; planned deployment at Disneyland Paris |
| **Toyota Research Institute** | Advancing solver development as TSC participant |
| **Universal Robots** | Robot simulation and learning via NVIDIA Isaac platform with OpenUSD digital twins |
| **Agility Robotics** | Whole-body control foundation model training for Digit humanoid robot |
| **TU Munich, Peking University** | Academic research in robot learning and simulation |

### Build & CI

| Aspect | Details |
| --- | --- |
| **Build system** | pyproject.toml with uv build backend |
| **CI** | GitHub Actions — GPU tests on AWS instances |
| **Reproducibility** | uv.lock lockfile. Pinned optional deps via version ranges |
| **Platforms tested** | Linux x86-64, Linux aarch64, Windows x86-64, macOS (CPU only) |

### Backlog Health

| Metric | Value |
| --- | --- |
| **Open issues** | 266 |
| **Open PRs** | ~50-60 (estimated from closure ratio) |
| **Median issue response time** | <24h |
| **Median PR merge time** | <24h |
| **Stale issues (>90 days)** | Low — project is only 14 months old |

---

## Red Hat Platform Fit Assessment

### Alignment Signals

- Apache-2.0 license, fully compatible with downstream redistribution
- Linux Foundation governance with balanced TSC — Red Hat could contribute and influence direction
- CLA is Linux Foundation EasyCLA (standard, well-understood) — not a blocker for Red Hat
- Python-native, `pip install` — containerization straightforward
- Clean modular architecture with pluggable solvers — could integrate alternative backends
- OpenUSD, URDF, MJCF support — no proprietary scene format lock-in
- Very lean dependency tree (1 direct dep) — low supply chain risk

### Risk Signals

- **CUDA-only GPU backend**: NVIDIA Warp has no ROCm support. GPU workloads require NVIDIA hardware. This is the primary platform fit risk — it conflicts with Red Hat's hardware-neutral positioning
- **NVIDIA operational dominance**: Despite LF governance, NVIDIA contributes ~61% of code and employs 5/8 maintainers. Day-to-day development direction is effectively NVIDIA-led
- **Warp single-point dependency**: All of Newton's GPU acceleration flows through NVIDIA Warp. If Warp's license or direction changes, Newton has no fallback
- **Young project**: Only 14 months old, API still evolving (v1.4.0-dev). Breaking changes possible

### Supply Chain Assessment

- **License conflicts**: None detected. All dependencies are Apache-2.0 or BSD-3-Clause
- **Known CVEs**: No scanner available to verify; no known issues surfaced in research
- **Single-maintainer risks**: warp-lang is NVIDIA-maintained (not single-person, but single-vendor). mujoco-warp is Google DeepMind-maintained. Both are well-resourced

**Technical verdict**: Strong — clean architecture, extremely lean dependencies, strong test infrastructure, 8 pluggable solvers, and GPU-parallel performance. The multi-solver design is the most extensible among competitors.

**Red Hat fit**: Misalign — CUDA-only GPU requirement via NVIDIA Warp directly conflicts with hardware-neutral platform positioning. The LF governance and Apache-2.0 license are excellent, but the architectural lock-in to NVIDIA hardware is a fundamental barrier. Would require a non-NVIDIA Warp backend (which does not exist) to become viable for Red Hat's platform.

---

## Sources

- [Newton GitHub](https://github.com/newton-physics/newton)
- [Newton Governance](https://github.com/newton-physics/newton-governance)
- [Linux Foundation Announcement](https://www.linuxfoundation.org/press/linux-foundation-announces-contribution-of-newton-by-disney-research-google-deepmind-and-nvidia-to-accelerate-open-robot-learning)
- [NVIDIA Newton Developer Page](https://developer.nvidia.com/newton-physics)
- [NVIDIA Newton 1.0 Launch (Dataconomy)](https://dataconomy.com/2026/03/17/nvidia-launches-newton-1-0-physics-engine-for-industrial-robot-training/)
- [Newton technical blog — NVIDIA](https://developer.nvidia.com/blog/announcing-newton-an-open-source-physics-engine-for-robotics-simulation/)
- [Kamino paper (arXiv:2603.16536)](https://arxiv.org/abs/2603.16536)
