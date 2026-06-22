# MuJoCo — Project Intelligence Report

**Date**: 2026-06-22
**Last updated**: 2026-06-22
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | MuJoCo (Multi-Joint dynamics with Contact) |
| **Website** | [mujoco.org](https://mujoco.org/) |
| **Building block** | Simulation Engines |
| **Competes with** | Newton (Linux Foundation), Isaac Sim (NVIDIA), PyBullet (Erwin Coumans), Drake (Toyota Research Institute), Brax (Google), Genesis World (Genesis Embodied AI), Gazebo (OSRA/Open Robotics) |
| **Depends on** | — |
| **Depended on by** | [Newton](newton.md) — wraps MuJoCo Warp as physics backend |

### Repo Scope

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| [google-deepmind/mujoco](https://github.com/google-deepmind/mujoco) | Core | Analyzed | Primary repo — C/C++ physics engine + Python bindings + MJX (JAX backend) |
| [google-deepmind/mujoco_warp](https://github.com/google-deepmind/mujoco_warp) | Core | Noted | GPU port of MuJoCo using NVIDIA Warp; feeds into Newton (LF). Different runtime target but same physics model |
| [google-deepmind/mujoco_playground](https://github.com/google-deepmind/mujoco_playground) | Ecosystem | Noted | RL training environments and locomotion tasks built on MuJoCo/MJX; independently viable |
| [google-deepmind/dm_control](https://github.com/google-deepmind/dm_control) | Ecosystem | Noted | DeepMind control suite using MuJoCo; widely used RL benchmark |
| [newton-physics/newton](https://github.com/newton-physics/newton) | Upstream/downstream | Linked | Linux Foundation project wrapping MuJoCo Warp; different governance (LF vs Google) |

---

## Executive Summary

- **What it is**: General-purpose physics engine for robotics, biomechanics, and RL research; the most widely cited simulator in academic robotics literature (9,250+ citations)
- **Health verdict**: Watch — extremely active development (13 releases/year) but 89% of commits from Google DeepMind; single-vendor project with Google CLA requirement
- **Technical verdict**: Strong — mature C physics engine (207K LOC) with clean architecture, multi-platform CI, pytest+googletest suites, and multi-GPU-backend support (CUDA, ROCm, Metal via MJX/JAX)
- **Red Hat fit**: Neutral — Apache 2.0 license and multi-backend GPU support are positive; CLA requirement, single-vendor governance, and CMake-only build (no containers) limit integration ease
- **Recommendation**: Integrate — strongest technical maturity and multi-GPU portability (via MJX/JAX), but CLA and single-vendor governance limit contribution depth; see [comparison](../project-comparisons/simulation-engines.md)

---

## Part A: Community & Project Health

### CHAOSS Metrics

<!-- Industry-standard community health metrics aligned with CHAOSS (https://chaoss.community) -->

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | 1 org (Google DeepMind at 89%) | Low | Google DeepMind produces ~89% of all commits. Next: Imperial College London (~1.5%), independent (~9.5%) |
| **Contributor Absence Factor** | 3 people for 50% of commits | Watch | yuvaltassa (28%), quagla (17%), haroonq (10%). Top 3 = 54.5% of all commits |
| **Change Request Closure Ratio** | 299 opened / 167 closed in 12mo | Watch (0.56) | Significant external PR backlog; many community PRs wait weeks-months for review |
| **Time to First Response** | ~3 days median | OK | Internal DeepMind PRs: minutes-hours. External PRs: days to months. Bimodal distribution |
| **Release Frequency** | 13 releases in 12mo | Active | Monthly cadence; adopted modified semver from v3.5.0. Latest: 3.9.0 (2026-05-27) |
| **Contribution Trend** | N/A | N/A | No meaningful external contribution to trend — 89% Google DeepMind historically and currently. Nimrod Gileadi departed DeepMind for Genesis Embodied AI; Kevin Zakka left for independent work. No new external contributors replacing them |
| **Libyears** | <!-- TODO: from project-tech-eval --> | | |

### Strategic Metrics

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | Permissive | Apache-2.0 (SPDX). No unusual patent clauses beyond standard Apache 2.0 patent grant |
| **Governance model** | Single-vendor | No GOVERNANCE.md, CHARTER.md, or CODEOWNERS. No steering committee. Google DeepMind controls all merge decisions, release schedule, and roadmap |
| **Contribution model** | CLA | Google CLA required ([cla.developers.google.com](https://cla.developers.google.com/)). `google-cla[bot]` enforces on PRs. Adds friction for corporate contributors (legal review) |
| **Corporate control risk** | High | 89% commit dominance + CLA + no governance docs + Google trademark + unilateral roadmap control. Partially mitigated by Newton (LF project) as downstream |
| **Community health** | Active | 13.9k stars, 1.6k forks, 344 open issues. Active monthly releases. Strong academic community engagement via GitHub Discussions |
| **Ecosystem breadth** | Wide | De facto standard for RL/robotics research. Integrations: Gymnasium, dm_control, ROS 2 (via mujoco_ros), Isaac Lab, LeRobot. MJX (JAX backend) extends to TPU/GPU |

### Governance Details

| Maintainer / Key Contributor | Employer | Role |
| --- | --- | --- |
| **Yuval Tassa** (yuvaltassa) | Google DeepMind | Creator, lead maintainer (28% of commits). Originally developed MuJoCo at U. Washington |
| **Levi Gruspe** (quagla) | Google DeepMind | Core maintainer (17% of commits) |
| **Haroon Qureshi** (haroonq) | Google DeepMind | Core contributor (10%) |
| **Saran Tunyasuvunakool** (saran-t) | Google DeepMind | Core contributor (7%) |
| **Kevin Bayes** (kbayes) | Google DeepMind | Core contributor (7%) |
| **Taylor Howell** (thowell) | Google DeepMind | Core contributor, MuJoCo MJX/Warp (6%) |
| **Baruch Tabanpour** (btaba) | Google DeepMind | Contributor (4%) |
| **Henrique de Almeida Voss** (havess) | Google DeepMind | Contributor (4%) |
| **Nimrod Gileadi** (nimrod-gileadi) | Genesis Embodied AI (prev. DeepMind) | Contributor (3%) |
| **Kevin Zakka** (kevinzakka) | Unaffiliated (prev. DeepMind) | Contributor (3%), co-author of MuJoCo Playground |
| **Balint Hodossy** (Balint-H) | Imperial College London | External contributor (1.5%), largest non-DeepMind contributor |

### Funding & Sustainability

MuJoCo is fully funded by Google DeepMind as part of its robotics research infrastructure. There is no foundation, no external funding, and no donation mechanism. DeepMind acquired MuJoCo from Roboti LLC (Yuval Tassa's company) in October 2021 and open-sourced it in May 2022.

**Sustainability assessment**: Medium risk. The project is well-funded but entirely dependent on Google DeepMind's continued investment. If DeepMind deprioritized MuJoCo, the project would likely stall — 89% of commits come from DeepMind employees, there is no external maintainer community with merge rights, and the CLA discourages building one.

**Mitigating factor**: The Newton project (Linux Foundation, jointly with NVIDIA and Disney Research) absorbs MuJoCo's physics engine as a backend (MuJoCo Warp). Newton's LF governance provides a hedge — if DeepMind withdrew from MuJoCo core, the GPU-accelerated fork (MJWarp) would continue under broader governance. However, CPU-only MuJoCo core would likely orphan.

---

## Part B: Technical Analysis

<!-- Produced by project-tech-eval skill, 2026-06-22 -->

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | Clear | Well-separated C engine (`src/engine/`), rendering (`src/render/`), Python bindings (`python/`), JAX backend (`mjx/`), plugin system (`plugin/`). Public API in `include/mujoco/mujoco.h`. Experimental subsystems (Filament renderer, Studio, USD) isolated in `src/experimental/` |
| **Tech stack alignment** | Neutral | C/C++ core with CMake build — runs natively on Linux but no container images, no K8s deployment model. Python bindings via pybind11. MJX uses JAX (not PyTorch), though JAX is interoperable. No Dockerfile or Helm chart provided |
| **Dependency health** | Healthy | Minimal C dependencies (Threads only via CMake). Python layer depends on numpy, absl-py, glfw, pyopengl (all well-maintained). MJX depends on JAX (Google-maintained). No single-maintainer transitive deps in the Python ecosystem |
| **Test coverage** | Adequate | 53 test files across pytest (Python) and googletest (C++). 9 fixture/testdata directories. Benchmarks present. Coverage configured (go-cover detected in CI). CI runs on Ubuntu, macOS, Windows. No property-based testing |
| **Security posture** | Adequate | SECURITY.md present. No CVEs in public databases for MuJoCo itself. No security scanner ran (osv-scanner/grype not installed), but minimal dependency surface reduces risk. No signed releases or SBOM. No OpenSSF Scorecard available |
| **Code quality signals** | Adequate | 0.9 TODO/KLOC (low). Pre-commit hooks configured. No linter config detected (no ruff/pylint/black in pyproject.toml). Code review signal: minimal (sampled 5 merged PRs, 1 had reviews). Top churn in `src/experimental/filament/` (new Filament renderer) and `doc/changelog.rst` |
| **Extensibility** | Plugin API | Native plugin system for custom actuators, sensors, SDF functions, and mesh decoders. Plugins are shared libraries loaded at runtime via `mjp_registerPlugin()`. SDK headers in `include/mujoco/mjplugin.h`. Users can also extend via Python bindings and MJX's JAX-based API |
| **Hardware portability** | Portable | CPU: cross-platform (Linux, macOS, Windows, WebAssembly). GPU: MJX runs on CUDA, ROCm, and Metal via JAX's XLA backend. MuJoCo Warp (separate repo) is CUDA/Warp-only. Native rendering via OpenGL; experimental Filament renderer adds Vulkan/Metal |

### Architecture Overview

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **Engine** (`src/engine/`) | Core physics: collision detection (GJK, convex, SDF), constraint solver, forward/inverse dynamics | None (pure C, POSIX threads) |
| **Model/Data** (`include/mujoco/`) | Public C API: `mjModel` (static), `mjData` (dynamic state). XML/MJCF model loading | None |
| **Rendering** (`src/render/`) | OpenGL-based visualization for simulation scenes | OpenGL |
| **Filament renderer** (`src/experimental/filament/`) | Experimental photorealistic renderer using Google Filament | Filament (Google) |
| **Studio** (`src/experimental/studio/`) | Experimental interactive GUI application | Filament, platform HAL |
| **Python bindings** (`python/mujoco/`) | pybind11 wrappers, Pythonic API, interactive viewer | pybind11, numpy, glfw |
| **MJX** (`mjx/mujoco/mjx/`) | JAX re-implementation of MuJoCo for GPU/TPU-accelerated batched simulation | JAX (Google) |
| **Plugins** (`plugin/`) | Runtime-loadable extensions: actuators, sensors, SDF, mesh decoders (OBJ, STL, USD) | None (plugin API) |
| **WASM** (`wasm/`) | WebAssembly build for browser-based simulation | Emscripten |
| **Unity** (`unity/`) | Unity engine integration via C# bindings | Unity (proprietary) |

### Dependency Analysis

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **JAX** (MJX) | 0.5.3–0.8.3 | Apache-2.0 | Google-maintained; version-pinned with hashes |
| **numpy** | (unpinned) | BSD-3 | None |
| **absl-py** | (unpinned) | Apache-2.0 | Google-maintained |
| **pybind11** | (build-time) | BSD-3 | Well-maintained, broad community |
| **glfw** | (unpinned) | MIT | None |
| **Filament** | (experimental) | Apache-2.0 | Google-maintained; experimental use only |

### Build & CI

| Aspect | Details |
| --- | --- |
| **Build system** | CMake (C/C++ core + Python extensions via setup.py/pyproject.toml) |
| **CI** | GitHub Actions (`build.yml`, `lint.yml`, `live.yml`, `publish-wasm.yml`) |
| **Reproducibility** | MJX: full lockfile with hashes (`requirements.txt`). Core: no lockfile, CMake fetches deps. WASM: `package-lock.json` |
| **Platforms tested** | Ubuntu, macOS, Windows (from CI matrix). WebAssembly via Emscripten |

### Backlog Health

| Metric | Value |
| --- | --- |
| **Open issues** | 344 |
| **Open PRs** | ~30 |
| **Median issue response time** | ~3 days (bimodal: internal fast, external slow) |
| **Median PR merge time** | ~14 days median (337 hours from TTFR sample) |
| **Stale issues (>90 days)** | Significant — many external feature requests and bug reports remain open |

---

## Red Hat Platform Fit Assessment

### Alignment Signals

- Apache 2.0 license, compatible with downstream redistribution
- C/C++ core with Python bindings, runs on Linux natively
- MJX provides GPU portability via JAX/XLA — supports CUDA, ROCm, and Metal without MuJoCo-side code changes
- Plugin API allows extension without forking — custom actuators, sensors, SDF functions
- Dominant position in RL/robotics research; de facto standard simulator in academic robotics
- Newton (Linux Foundation) provides a governance-friendly entry point for GPU-accelerated simulation contribution
- Pre-commit hooks configured; SECURITY.md present

### Risk Signals

- Google CLA required — limits Red Hat's preferred DCO contribution model
- 89% commit concentration at Google DeepMind — no community path to maintainership
- No governance docs, no steering committee, no roadmap input mechanism for external contributors
- No container images (Dockerfile, Helm, Kustomize) — not cloud-native deployable out of the box
- MuJoCo Warp (GPU port) targets NVIDIA hardware specifically (CUDA/Warp); only MJX via JAX provides ROCm support
- Competing with Newton (which Google co-funds) creates strategic ambiguity about MuJoCo's long-term role
- Code review practices minimal — sampled PRs show low review engagement
- No linter/formatter configuration enforced (despite pre-commit hooks)

### Supply Chain Assessment

- **License conflicts**: Apache 2.0 core. All Python deps are permissive (Apache-2.0, BSD-3, MIT). JAX is Apache-2.0. No copyleft in dependency tree
- **Known CVEs**: SECURITY.md present. No CVEs in public databases for MuJoCo itself. Security scanner not available for automated check, but minimal native dependency surface (Threads only) reduces risk
- **Single-maintainer risks**: Yuval Tassa is creator and lead (28% of commits), but Google DeepMind employs him and 7+ other core contributors — personal bus-factor risk mitigated by institutional backing. Risk is institutional (Google withdrawal), not individual

---

## Sources

- [MuJoCo GitHub](https://github.com/google-deepmind/mujoco)
- [Open-sourcing MuJoCo — Google DeepMind blog](https://deepmind.google/blog/open-sourcing-mujoco/)
- [MuJoCo Documentation](https://mujoco.readthedocs.io/)
- [MuJoCo Warp GitHub](https://github.com/google-deepmind/mujoco_warp)
- [Newton Physics Engine — NVIDIA Developer](https://developer.nvidia.com/newton-physics)
- [Announcing Newton — NVIDIA Blog](https://developer.nvidia.com/blog/announcing-newton-an-open-source-physics-engine-for-robotics-simulation/)
- [MuJoCo Wikipedia](https://en.wikipedia.org/wiki/MuJoCo)
- [MuJoCo CONTRIBUTING.md](https://github.com/google-deepmind/mujoco/blob/main/CONTRIBUTING.md)
