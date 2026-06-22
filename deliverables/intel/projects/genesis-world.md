# Genesis World — Project Intelligence Report

**Date**: 2026-06-22
**Last updated**: 2026-06-22
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | Genesis World (Genesis AI) |
| **Website** | [genesis.ai](https://www.genesis.ai/) |
| **Building block** | Simulation Engines |
| **Competes with** | MuJoCo (Google DeepMind), Newton (Linux Foundation), Gazebo (Open Robotics/OSRA), Isaac Sim (NVIDIA), PyBullet (Erwin Coumans), Drake (Toyota Research Institute) |

### Repo Scope

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| [Genesis-Embodied-AI/genesis-world](https://github.com/Genesis-Embodied-AI/genesis-world) | Core | Analyzed | Primary repo — multi-physics simulation platform (29.4K stars) |
| [Genesis-Embodied-AI/quadrants](https://github.com/Genesis-Embodied-AI/quadrants) | Core | Noted | GPU compiler (fork of Taichi) — critical dependency for cross-platform GPU acceleration. 152 stars |
| [Genesis-Embodied-AI/genesis-nyx](https://github.com/Genesis-Embodied-AI/genesis-nyx) | Core | Noted | Nyx path-traced renderer plugin for photorealistic rendering. 114 stars |
| [Genesis-Embodied-AI/RoboGen](https://github.com/Genesis-Embodied-AI/RoboGen) | Ecosystem | Noted | Generative robotic agent framework. 1.2K stars |
| [Genesis-Embodied-AI/DiffTactile](https://github.com/Genesis-Embodied-AI/DiffTactile) | Ecosystem | Noted | Differentiable tactile simulator (ICLR 2024). 314 stars |
| [Genesis-Embodied-AI/ThinShellLab](https://github.com/Genesis-Embodied-AI/ThinShellLab) | Ecosystem | Noted | Thin-shell manipulation (ICLR 2024). 55 stars |
| [Genesis-Embodied-AI/gs-madrona](https://github.com/Genesis-Embodied-AI/gs-madrona) | Ecosystem | Noted | Madrona integration fork for batch GPU simulation |
| [Genesis-Embodied-AI/genesis-doc](https://github.com/Genesis-Embodied-AI/genesis-doc) | Peripheral | Excluded | Documentation site |
| [Genesis-Embodied-AI/genesis-embodied-ai.github.io](https://github.com/Genesis-Embodied-AI/genesis-embodied-ai.github.io) | Peripheral | Excluded | Website |

---

## Executive Summary

- **What it is**: Multi-physics simulation platform for robotics and embodied AI, featuring cross-platform GPU acceleration (CUDA, ROCm, Metal, Vulkan), differentiable simulation, and three rendering paths including the photorealistic Nyx renderer; backed by $105M seed from Eclipse and Khosla Ventures
- **Health verdict**: Watch — explosive growth (29K stars, 27 releases in 12mo) but extreme contributor concentration (top 2 people = 56% of commits), no governance docs, single-vendor control by a $105M-funded startup whose long-term OSS commitment is unproven, and critical dependency on Quadrants (Genesis AI's fork of unmaintained Taichi compiler)
- **Technical verdict**: Adequate — broadest multi-physics and multi-GPU coverage, but weak test infrastructure (29 tests for 165K LOC), heavy dependency tree (32 deps), and critical Quadrants compiler risk
- **Red Hat fit**: Neutral — uniquely attractive ROCm support via Quadrants, but single-vendor control by young VC-backed startup with no governance framework creates long-term risk
- **Recommendation**: Integrate — uniquely attractive ROCm support via Quadrants compiler, but single-vendor governance by VC-backed startup and critical Quadrants dependency risk place it behind Newton; watch for governance maturation; see [comparison](../project-comparisons/simulation-engines.md)

---

## Part A: Community & Project Health

### CHAOSS Metrics

<!-- Industry-standard community health metrics aligned with CHAOSS (https://chaoss.community) -->

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | 1 org (Genesis AI at ~60%+) | Low | 78% of commits from "(unknown)" company field — most are Genesis AI employees/affiliates without company set (duburcqa, YilingQiao, zhouxian, zswang666). Identifiable Genesis AI: 2% tagged + ~50% untagged. Next: CMU ~9% |
| **Contributor Absence Factor** | 2 people for 50% of commits | Risk | duburcqa (46%), YilingQiao (10%). Top 2 = 56% of all commits. Extreme bus-factor risk |
| **Change Request Closure Ratio** | 1194 opened / 1180 closed in 12mo | Healthy (0.98) | 933 merged. Very high closure ratio — responsive to PRs |
| **Time to First Response** | <1h median | Fast | Sample of 10 recent PRs. Core team responds quickly |
| **Release Frequency** | 27 releases in 12mo | Very active | v0.4.7 → v1.0.0 → v1.1.2. Multiple releases per month. Reached v1.0 (May 2026) |
| **Contribution Trend** | Narrowing | Narrowing | Project launched mid-2024 with academic contributors (CMU, UMD). Since Genesis AI's $105M seed (Jul 2025), the company has professionalized development — duburcqa (Genesis AI) now accounts for 46% of all commits, up from a more distributed early pattern. Academic contributors (YilingQiao, Kashu7100) remain active but their share is declining as Genesis AI employees drive the v1.0 push. Hugh Perkins (8%, independent) is a notable external contributor but has not been active recently |
| **Libyears** | <!-- TODO: run project-tech-eval --> | | |

### Strategic Metrics

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | Permissive | Apache-2.0 (SPDX). No unusual patent clauses. Quadrants compiler also Apache-2.0 |
| **Governance model** | Single-vendor | No GOVERNANCE.md, CHARTER.md, CODEOWNERS, or steering committee. Genesis AI controls all merge decisions, release schedule, and roadmap. No foundation affiliation |
| **Contribution model** | None | No CLA or DCO required. No CONTRIBUTING.md in main repo. Low barrier to contribute but also no structured contribution process |
| **Corporate control risk** | High | Single-vendor (Genesis AI) controls all repos, including the critical Quadrants compiler. No governance docs, no external maintainers with merge access. $105M VC funding creates incentive alignment risk — OSS may be deprioritized if commercialization demands diverge |
| **Community health** | Active | 29.4K stars, 2.8K forks, 89 contributors, 133 open issues. Explosive growth. Very fast issue/PR response. But contributor base is narrow — top 4 account for ~72% of commits |
| **Ecosystem breadth** | Moderate | Supports URDF, MJCF, USD scene loading. Integrations with LeRobot, Gymnasium. Growing academic adoption (CMU, UMD, Peking U, Zhejiang U, Imperial). No major industrial integrations yet |

### Governance Details

| Maintainer / Key Contributor | Employer | Role |
| --- | --- | --- |
| **Alexis Duburcq** (duburcqa) | Genesis AI | Lead engineer. 678 commits (46%). Built Quadrants compiler and core simulation framework |
| **Yiling Qiao** (YilingQiao) | University of Maryland (PhD) | Core contributor. 145 commits (10%). Differentiable simulation expert. Meta PhD Fellow. Larry S. Davis Dissertation Award |
| **Kashu Yamazaki** (Kashu7100) | Carnegie Mellon University (PhD) | Core contributor. 127 commits (9%). Robotics & AI |
| **Hugh Perkins** (hughperkins) | Independent | Contributor. 116 commits (8%). Significant external contributor |
| **Zhou Xian** (zhouxian) | Genesis AI (co-founder) | Co-founder. 45 commits (3%). PhD CMU robotics. Company leadership, less code |
| **Tsun-Hsuan Wang** (zswang666) | Unknown | Contributor. 40 commits (3%) |
| **Sanghyun Son** (SonSang) | Genesis AI | MTS. 28 commits (2%). UMD PhD |
| **Zhenjia Xu** (zhenjia-xu) | Unknown | Contributor. 29 commits (2%) |

### Funding & Sustainability

Genesis AI emerged from stealth in July 2025 with a **$105M seed round** co-led by Eclipse and Khosla Ventures, with participation from Bpifrance, HSG, Eric Schmidt, Xavier Niel, Daniela Rus, and Vladlen Koltun. Founded in December 2024 by Zhou Xian (CMU PhD) and Théophile Gervet (ex-Mistral AI, ex-Skild AI).

**Company profile**: ~20+ researchers with backgrounds from NVIDIA, Google, and Mistral AI. Offices in Paris, California, and London. Plans targeted customer deployments (automotive, electronics, pharma, logistics) by end of 2026 in France, Germany, and Italy. Unveiled GENE-26.5 foundation model with robotic hand manipulation in May 2026.

**Sustainability assessment**: Medium-high risk.

- **VC-funded OSS tension**: Genesis World is the simulation platform for a VC-backed startup building commercial robotics products. The $105M seed creates pressure to monetize. If the company's commercial strategy diverges from OSS, the open-source project may be deprioritized (reduced releases, slower community engagement, proprietary features held back).
- **Extreme contributor concentration**: duburcqa (46%) and YilingQiao (10%) account for 56% of commits. If either leaves, the project loses its primary development capacity.
- **Quadrants compiler risk**: The Quadrants GPU compiler (critical for cross-platform acceleration) is a fork of Taichi, which is effectively unmaintained by its original creators. Genesis AI maintains the fork. If Genesis AI deprioritizes Quadrants, the cross-platform GPU story (ROCm, Metal, Vulkan) breaks.
- **No governance firewall**: Unlike Newton (Linux Foundation), there is no foundation or charter preventing Genesis AI from relicensing, restricting, or abandoning the project.

**Mitigating factors**: Apache-2.0 license means the project can be forked if Genesis AI changes direction. Strong academic contributor base (CMU, UMD, Imperial, Zhejiang, Peking) provides some resilience. The ROCm/Metal/Vulkan support is a genuine differentiator that attracts users who cannot or will not use NVIDIA-only solutions.

---

## Part B: Technical Analysis

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | Clear | Well-structured engine hierarchy: simulator → scene → solvers/entities/sensors. Each physics solver (rigid, FEM, MPM, PBD, SPH, SF) has matching entity type. Clean separation between scene graph, physics, and rendering |
| **Tech stack alignment** | Neutral | Python-native (pip install), PyTorch interop via Quadrants→CUDA tensors. No K8s or container infrastructure. Linux-first but cross-platform GPU via Quadrants. Not container-friendly by default |
| **Dependency health** | Watch | 32 direct dependencies — significantly heavier than Newton (1). Key risk: Quadrants compiler (Genesis AI's fork of unmaintained Taichi). Also depends on MuJoCo, VTK, z3-solver, numba, trimesh, and many mesh processing libs |
| **Test coverage** | Weak | Only 29 test files. No coverage reporting configured. Benchmarks exist but test infrastructure is minimal for a project of this complexity (165K LOC) |
| **Security posture** | Weak | No SECURITY.md, no SBOM, no signed releases. No CVE scanning detected. Apache-2.0 with SPDX headers. The 32-dependency surface is unaudited |
| **Code quality signals** | Adequate | Ruff/pylint/black configured, pre-commit hooks. 225 TODOs/FIXMEs (1.3/kLOC — elevated). Code review is partial (many PRs merged by single maintainer). Churn hotspots in rigid physics solver and collider code |
| **Extensibility** | SDK | Users extend via Python API: create custom entities, materials, sensors, and force fields. No formal plugin system but the solver/entity pattern allows adding new physics types |
| **Hardware portability** | Portable | Quadrants compiler targets CUDA, ROCm, Metal, Vulkan, x86 CPU, ARM64. This is the broadest hardware support among all four projects. However, Quadrants is a fork of unmaintained Taichi — long-term portability depends on Genesis AI maintaining it |

### Architecture Overview

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **Quadrants compiler** | GPU kernel compiler — lowers Python to CUDA/ROCm/Metal/Vulkan/CPU. Fork of Taichi | quadrants (Genesis AI) |
| **simulator** | Top-level orchestrator. Manages scenes, time stepping, parallelization | quadrants, numpy, torch |
| **scene** | Scene graph management, entity registration, solver dispatch | quadrants |
| **solvers/rigid** | Rigid body dynamics with penetration-free contact solver | quadrants |
| **solvers/fem** | Finite Element Method for deformable bodies | quadrants |
| **solvers/mpm** | Material Point Method for granular/fluid materials | quadrants |
| **solvers/pbd** | Position-Based Dynamics for soft bodies | quadrants |
| **solvers/sph** | Smoothed Particle Hydrodynamics for fluids | quadrants |
| **solvers/sf** | Surface flow solver | quadrants |
| **entities** | Typed entities (rigid, FEM, MPM, PBD, drone, tool, hybrid, emitter) matching solver types | quadrants |
| **sensors** | Camera, depth, segmentation, lidar, contact force, IMU | quadrants, Nyx renderer (optional) |
| **Nyx renderer** | Path-traced photorealistic renderer (separate repo) | genesis-nyx |

### Dependency Analysis

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **quadrants** | 1.0.2 | Apache-2.0 | **Critical risk**: Genesis AI's fork of Taichi (unmaintained). Single-vendor maintained. All GPU acceleration flows through this. If Genesis AI deprioritizes it, cross-platform GPU breaks |
| **mujoco** | latest | Apache-2.0 | Google DeepMind maintained. Used for MJCF import and reference physics |
| **numpy** | latest | BSD-3-Clause | No risk |
| **torch** | (implicit) | BSD-3-Clause | PyTorch interop for RL training pipelines |
| **trimesh** | latest | MIT | Mesh processing. Well-maintained |
| **VTK** | latest | BSD-3-Clause | Visualization toolkit. Large dependency |
| **z3-solver** | latest | MIT | SMT solver — unusual dependency for physics engine. Used in constraint solving |
| **numba** | latest | BSD-2-Clause | JIT compiler. Alternative code path for some computations |

### Capabilities & Positioning

| Capability | Detail |
| --- | --- |
| **Multi-physics unified** | 7 solver types (rigid, FEM, MPM, PBD, SPH, SF, kinematic) in single framework with entity coupling. Broadest physics coverage among competitors |
| **Cross-platform GPU** | Quadrants compiler targets CUDA, ROCm, Metal, Vulkan, x86, ARM64. Only simulator in this comparison with non-NVIDIA GPU support |
| **Differentiable simulation** | End-to-end differentiability via Quadrants AD for gradient-based optimization |
| **Photorealistic rendering** | Nyx path-traced renderer for synthetic data generation. Competitive with Isaac Sim's RTX rendering |
| **Speed claims** | Claims 10-80× faster than Isaac Gym/MuJoCo MJX for robotics simulation. ~89% sim-to-real transfer reported |
| **Scene format support** | URDF, MJCF import. Collada, glTF, mesh formats via trimesh |
| **Batch simulation** | Madrona integration (gs-madrona) for large-scale parallel environment rollouts |

### Lock-in Assessment

| Dimension | Risk | Detail |
| --- | --- | --- |
| **Hardware** | Low | Quadrants compiler supports CUDA, ROCm, Metal, Vulkan, CPU. Broadest hardware portability. But Quadrants' long-term maintenance is uncertain |
| **Vendor** | High | Genesis AI controls all repos (genesis-world, quadrants, genesis-nyx). No governance docs, no foundation. $105M VC funding creates relicensing/abandonment risk. Quadrants compiler is the linchpin — if Genesis AI restricts it, the entire platform breaks |
| **Ecosystem** | Low | Uses standard formats (URDF, MJCF). No proprietary scene format. Gymnasium integration. Assets are portable |

### Production Adoption

| User | Use Case |
| --- | --- |
| **Genesis AI** (internal) | Primary user — simulation-based evaluation and training for GENE robotics foundation models |
| **Wuji Tech** (China) | Hardware partner — robotic hand development and validation with Genesis AI |
| **Carnegie Mellon University** | Academic research — robotics and embodied AI (3 contributors) |
| **University of Maryland** | Academic research — differentiable simulation (YilingQiao) |
| **Imperial College London** | Academic research — robot learning |
| **Zhejiang University, Peking University** | Academic research — physics simulation |

*Note: Genesis World is in early commercial deployment. No external enterprise production users have been publicly disclosed as of June 2026.*

### Build & CI

| Aspect | Details |
| --- | --- |
| **Build system** | pyproject.toml (pip install). Dockerfile and Dockerfile.amdgpu available |
| **CI** | GitHub Actions — Linux (Ubuntu). 3 CI workflows detected |
| **Reproducibility** | No lockfile. Dependencies unpinned. Dockerfile provides reproducibility boundary |
| **Platforms tested** | Linux (primary). macOS and Windows via Quadrants cross-platform support |

### Backlog Health

| Metric | Value |
| --- | --- |
| **Open issues** | 133 |
| **Open PRs** | ~14 (estimated from closure ratio) |
| **Median issue response time** | <1h |
| **Median PR merge time** | <24h |
| **Stale issues (>90 days)** | Low — rapid growth phase |

---

## Red Hat Platform Fit Assessment

### Alignment Signals

- Apache-2.0 license, fully compatible with downstream redistribution
- Cross-platform GPU support via Quadrants (CUDA, ROCm, Metal, Vulkan) — the only project in this comparison with ROCm support, which aligns with Red Hat's hardware-neutral positioning
- Python-native, pip install — containerization possible
- No CLA required — lowest contribution friction
- Dockerfile and Dockerfile.amdgpu provided — container-ready including AMD GPU path
- PyTorch interop for RL/IL training pipelines

### Risk Signals

- **Single-vendor control (Genesis AI)**: No foundation, no governance docs, no external maintainers with merge access. $105M VC funding creates commercialization pressure that may diverge from OSS interests
- **Quadrants compiler dependency**: Fork of unmaintained Taichi, controlled entirely by Genesis AI. This is the single most critical dependency — all GPU acceleration and cross-platform support flows through it. If Genesis AI restricts or abandons Quadrants, the platform breaks
- **Young startup risk**: Genesis AI was founded Dec 2024, raised $105M Jul 2025. No track record of sustained OSS commitment. The company's commercial interests (robotics foundation models, customer deployments) may take priority over OSS community building
- **Weak test coverage**: 29 test files for 165K LOC is inadequate. No coverage reporting. Risky for downstream integration
- **Heavy dependency tree**: 32 direct deps (vs Newton's 1) increases supply chain attack surface
- **No SECURITY.md**: No vulnerability disclosure process

### Supply Chain Assessment

- **License conflicts**: All scanned dependencies are Apache-2.0, BSD, or MIT — no copyleft conflicts detected
- **Known CVEs**: No scanner available to verify
- **Single-maintainer risks**: Quadrants (Genesis AI fork of Taichi) is the critical single-vendor dependency. duburcqa maintains 46% of genesis-world commits — extreme bus factor

**Technical verdict**: Adequate — broadest multi-physics and multi-GPU coverage among competitors, clean architecture, but weak test infrastructure, heavy dependency tree, and Quadrants compiler risk undercut the technical strengths.

**Red Hat fit**: Neutral — ROCm support via Quadrants is uniquely attractive for Red Hat's hardware-neutral positioning, but single-vendor control by a young VC-backed startup with no governance framework creates unacceptable long-term risk for platform dependency. Best positioned as a "watch and engage" — if Genesis AI matures governance (e.g., contributes Quadrants to a foundation), fit improves significantly.

---

## Sources

- [Genesis World GitHub](https://github.com/Genesis-Embodied-AI/genesis-world)
- [Genesis AI Website](https://www.genesis.ai/)
- [Genesis World 1.0 Blog Post](https://www.genesis.ai/blog/the-role-of-simulation-in-scalable-robotics-genesis-world-10-and-the-path-forward)
- [Genesis AI $105M Seed — TechCrunch](https://techcrunch.com/2025/07/01/genesis-ai-launches-with-105m-seed-funding-from-eclipse-khosla-to-build-ai-models-for-robots/)
- [Genesis AI Full Stack Demo — TechCrunch](https://techcrunch.com/2026/05/06/khosla-backed-robotics-startup-genesis-ai-has-gone-full-stack-demo-shows/)
- [Quadrants Compiler GitHub](https://github.com/Genesis-Embodied-AI/quadrants)
- [Nyx Renderer GitHub](https://github.com/Genesis-Embodied-AI/genesis-nyx)
