# Simulation Engines — Solution Comparison

**Date**: 2026-06-22
**Last updated**: 2026-06-22
**Building block**: Simulation Engines
**Classification**: Internal analysis — not for public repo

Compares solutions for the **Simulation Engines** platform capability to inform Red Hat's build/partner/integrate decision.

**Solutions compared**: Newton (Linux Foundation) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA/Open Robotics) | Isaac Sim (NVIDIA)

---

## Decision Summary

**Recommended pick**: **Newton (Linux Foundation)** — best governance fit (LF charter, multi-vendor steering with NVIDIA + Google DeepMind + Disney Research), most production-ready GPU physics (8 pluggable solvers), and the only project where Red Hat can contribute to governance and roadmap. CUDA-only hardware is a gap, but the LF governance path provides the strongest long-term strategic position.

**Runner-up**: **Gazebo (OSRA/Open Robotics)** — strongest open governance (OSRA PMC), no GPU vendor lock-in, deepest ROS 2 integration, and the standard deployment/validation simulator. Preferred when the use case is ROS 2 validation or sensor simulation rather than large-scale RL training.

---

## Feature Comparison

<!-- Feature dimensions identified from building-blocks.md Simulation Engines section + project capabilities. -->
<!-- Use ✅/⚠️/❌ for boolean features; comma-separated lists for multi-valued features. -->

| Feature | Newton (Linux Foundation) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) |
| --- | --- | --- | --- | --- | --- |
| **Physics types** | Rigid, FEM, XPBD, VBD, MPM, Featherstone, cloth, fluid | Rigid, tendon, contact, soft (FEM via plugin) | Rigid, FEM, MPM, PBD, SPH, SF, cloth | Rigid, joint, contact (DART, Bullet, TPE) | Rigid, deformable, fluid (PhysX + Newton v6.0) |
| **GPU backends** | CUDA (via Warp) | CUDA, ROCm, Metal, TPU (via MJX/JAX); CUDA (Warp) | CUDA, ROCm, Metal, Vulkan, CPU (Quadrants) | ❌ CPU only | CUDA only |
| **Parallel envs** | ✅ Thousands (GPU-batched) | ✅ Thousands (MJX batched) | ✅ Thousands (GPU-batched + Madrona) | ❌ Single-threaded | ✅ Thousands (PhysX GPU) |
| **Photorealistic rendering** | ⚠️ Via OpenUSD/Isaac Sim | ⚠️ Experimental Filament renderer | ✅ Nyx path-traced renderer | ⚠️ OGRE 2.x (functional, not photorealistic) | ✅ RTX ray-tracing + NuRec 3DGS |
| **Differentiable simulation** | ⚠️ Partial (Warp AD) | ✅ Full (MJX reverse-mode AD) | ✅ Full (Quadrants AD) | ❌ | ❌ |
| **Sensor simulation** | ⚠️ Basic (via Isaac Sim) | ⚠️ Basic (camera, touch) | ✅ Camera, depth, lidar, contact, IMU | ✅ Camera, lidar, IMU, GPS, altimeter, contact (strongest plugin set) | ✅ RTX camera, lidar, IMU, contact, OmniSensor |
| **ROS 2 integration** | ⚠️ Via Isaac Sim | ⚠️ Via mujoco_ros (community) | ⚠️ Basic Gymnasium integration | ✅ Native (gz-transport, ros_gz bridge) | ✅ Native (ros2 extensions, Nav2, MoveIt) |
| **Scene format support** | MJCF, URDF, USD | MJCF (native), URDF (via converter) | URDF, MJCF, USD, glTF, Collada | SDF (native), URDF, USD (experimental) | USD (native), URDF, MJCF, CAD |
| **Pluggable physics** | ✅ 8 solver backends | ❌ Single engine | ❌ Single engine (7 types, 1 framework) | ✅ 3 backends (DART, Bullet, TPE) | ✅ 2 backends (PhysX, Newton v6.0) |
| **CPU fallback** | ❌ | ✅ Primary mode | ✅ Via Quadrants CPU backend | ✅ CPU primary | ❌ |
| **WebAssembly** | ❌ | ✅ Browser-based simulation | ❌ | ❌ | ❌ |

---

## Lock-in Comparison

| Dimension | Newton (LF) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) |
| --- | --- | --- | --- | --- | --- |
| **Hardware** | High — CUDA-only via Warp | Low — CPU native; CUDA/ROCm/Metal via MJX/JAX | Low — CUDA, ROCm, Metal, Vulkan, CPU via Quadrants | Low — CPU only, no GPU vendor | High — CUDA-only, RTX for rendering |
| **Vendor** | Medium — LF governance mitigates, but NVIDIA controls Warp dependency | High — Google DeepMind 89% commits, CLA, no external maintainers | High — Genesis AI controls all repos + Quadrants compiler (fork of unmaintained Taichi) | Low — OSRA PMC governance, multiple maintainer orgs | High — 117 proprietary omni.* deps, no contributions accepted |
| **Ecosystem** | Low — open formats (MJCF, URDF, USD), standard APIs | Low — MJCF open standard, wide ecosystem support | Low — standard formats (URDF, MJCF), Gymnasium integration | Low — SDF open standard, native ROS 2 ecosystem | High — proprietary Kit extensions, NVIDIA-only ecosystem (Isaac Lab, GR00T, Cosmos) |

---

## Production Adoption

| Solution | Notable Users |
| --- | --- |
| **Newton (LF)** | Skild AI + Foxconn (GPU rack assembly), Samsung + Lightwheel (cable manipulation), Disney Research (Olaf robots), Toyota Research Institute, Universal Robots, Agility Robotics |
| **MuJoCo (Google DeepMind)** | Google DeepMind (dm_control, MuJoCo Playground), Toyota Research Institute, Samsung, Skild AI, Disney Research, Farama Foundation (Gymnasium); dominant in academic robotics RL (9,250+ citations) |
| **Genesis World (Genesis AI)** | Genesis AI (internal — GENE robotics model), Wuji Tech (robotic hand); no external enterprise production users confirmed |
| **Gazebo (OSRA)** | DARPA DRC, NASA Space Robotics Challenge, Intrinsic, Universal Robots, Clearpath Robotics, Amazon RoboMaker; standard for ROS 2 development and validation |
| **Isaac Sim (NVIDIA)** | ABB, FANUC, KUKA, Yaskawa (industrial robots), Figure AI, Boston Dynamics, Agility (humanoids), J&J MedTech, CMR Surgical (surgical), Caterpillar (manufacturing), Skild AI, FieldAI; broadest production adoption |

---

## Red Hat Platform Fit

| Dimension | Newton (LF) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) |
| --- | --- | --- | --- | --- | --- |
| **Runs on OpenShift** | With effort | With effort | With effort | With effort | No (proprietary Kit SDK) |
| **RHEL compatible** | Yes | Yes | Yes | Yes | Partial (NVIDIA runtime) |
| **License compatible** | Yes (Apache-2.0) | Yes (Apache-2.0) | Yes (Apache-2.0) | Yes (Apache-2.0) | Caution (code Apache-2.0, runtime proprietary) |
| **Contribution model** | Open (DCO) | CLA (Google CLA) | None (no CLA/DCO) | Open (DCO) | Closed (no contributions accepted) |
| **Vendor relationship** | Partner (LF member) | Neutral | Neutral | Partner (OSRA) | Competitor |
| **Platform fit** | **Integrate** | Integrate | Integrate | **Partner** | Partner |

---

## Health & Risk Comparison

| Dimension | Newton (LF) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) |
| --- | --- | --- | --- | --- | --- |
| **License** | Apache-2.0 | Apache-2.0 | Apache-2.0 | Apache-2.0 | Apache-2.0 (code) + Proprietary (runtime) |
| **Governance** | Foundation (LF) | Single-vendor | Single-vendor | Foundation (OSRA) | Single-vendor |
| **Elephant Factor** | Low (1 — NVIDIA ~75%) | Low (1 — Google ~89%) | Low (1 — Genesis AI ~60%) | Low (1 — Intrinsic ~50%) | Low (1 — NVIDIA 100%) |
| **Contributor diversity** | Watch (CAF=3) | Watch (CAF=3) | Risk (CAF=2) | Risk (CAF=2) | Risk (CAF=1) |
| **Contribution trend** | Stable | N/A | Narrowing | Narrowing | N/A |
| **Corporate control risk** | Medium (LF mitigates) | High (CLA + 89% commits) | High (no governance) | Medium (OSRA mitigates) | High (no contributions) |
| **Community health** | Active | Active | Active | Active | Maintained |
| **Tech stack alignment** | Neutral | Neutral | Neutral | Neutral | Misaligned |
| **Hardware portability** | Locked (CUDA) | Portable (CPU + MJX multi-GPU) | Portable (multi-GPU via Quadrants) | Limited (CPU only) | Locked (CUDA) |
| **Dependency health** | Healthy (1 dep: Warp) | Healthy (minimal C deps) | Watch (32 deps, Quadrants risk) | Watch (15+ gz-* libs, LGPL deps) | Risky (117 proprietary omni.* deps) |
| **Security posture** | Adequate | Adequate | Weak | Adequate | Adequate |
| **Technical verdict** | Strong | Strong | Adequate | Adequate | Strong |

---

## Architecture Comparison

| Aspect | Newton (LF) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) |
| --- | --- | --- | --- | --- | --- |
| **Design philosophy** | Pluggable solver framework | Monolithic C engine + JAX port | Unified multi-physics with GPU compiler | Modular C++ library set with plugin system | Monolithic Kit extension platform |
| **Language** | Python (406K LOC) | C/C++ (207K LOC) + Python | Python (165K LOC) | C++ (multi-repo) | Python (592K) + C++ (62K) |
| **Runtime requirements** | NVIDIA GPU + Warp | CPU (native) or GPU (MJX/JAX) | GPU (Quadrants) or CPU | CPU (Linux/macOS/Windows) | NVIDIA GPU + Omniverse Kit SDK (proprietary) |
| **Extension model** | Pluggable solver backends | Plugin API (actuators, sensors, SDF) | Python SDK (entities, materials) | Plugin API (strongest: physics, sensors, rendering, GUI) | Kit extension system (117 extensions) |
| **Data format** | MJCF, URDF, USD | MJCF (native), URDF (converter) | URDF, MJCF, USD, glTF | SDF (native), URDF | USD (native), URDF, MJCF, CAD |
| **Key dependencies** | Warp (NVIDIA) | JAX (Google), pybind11 | Quadrants (Genesis AI fork of Taichi) | DART, OGRE, ZeroMQ, Qt | Omniverse Kit SDK (NVIDIA proprietary) |
| **Rendering** | Via OpenUSD / Isaac Sim | OpenGL (native), Filament (experimental) | Nyx (photorealistic), LuisaRender, Pyrender | OGRE 2.x (functional) | RTX (photorealistic) + NuRec 3DGS |

---

## Recommendation Rationale

### Why Newton (Linux Foundation)

- **Governance**: Only simulation engine under foundation governance (Linux Foundation). Multi-vendor steering (NVIDIA, Google DeepMind, Disney Research). DCO contribution model — Red Hat can contribute without CLA friction
- **Technical maturity**: 8 pluggable physics solver backends (most flexible architecture), 179 test files, Codecov integration, clean single-dependency design (Warp only)
- **Strategic positioning**: Absorbs MuJoCo's physics model (via MuJoCo Warp) while providing LF governance. Represents the industry's attempt to create a vendor-neutral simulation standard. Red Hat contributing here builds influence over the future of open simulation
- **Production adoption**: Already used by Skild AI + Foxconn, Samsung + Lightwheel, Disney Research, Toyota, Universal Robots — demonstrates real-world viability at 14 months old
- **Isaac Sim integration**: Newton is now a physics backend in Isaac Sim 6.0, meaning Newton adoption does not require abandoning the Isaac Sim ecosystem — it provides a governance-independent physics path within it

### What we give up

- **Hardware portability**: Newton is CUDA-only (via Warp). MuJoCo (via MJX/JAX) and Genesis World (via Quadrants) support ROCm, Metal, and multi-backend GPU. This is Newton's biggest gap for Red Hat's hardware-neutral positioning
- **Rendering**: Newton has no built-in renderer — relies on Isaac Sim or OpenUSD for visualization. Genesis World (Nyx) and Isaac Sim (RTX) have photorealistic rendering built in
- **Maturity**: At 14 months, Newton is the youngest project. MuJoCo has 14 years and 9,250+ citations. Gazebo has 20+ years and NASA/DARPA pedigree
- **CPU path**: Newton has no CPU fallback. MuJoCo, Genesis World, and Gazebo all run on CPU, which matters for development, CI, and non-GPU environments
- **ROS 2 integration**: Gazebo has native, battle-tested ROS 2 integration. Newton's ROS path is indirect (via Isaac Sim)

### Conditions / Watch items

- **If Newton adds ROCm support** (via Warp multi-backend or JAX integration): strengthens significantly — eliminates the hardware portability gap
- **If Genesis World matures governance** (e.g., contributes Quadrants to a foundation): becomes a strong contender — it already has the best hardware portability
- **If MuJoCo drops the CLA**: becomes more attractive for Red Hat contribution, though governance would still be single-vendor
- **If Gazebo adds GPU physics**: becomes viable for training workloads, not just validation. Currently no indication Intrinsic plans this
- **If Newton community narrows further** (NVIDIA share grows beyond 75%): LF governance becomes a paper shield rather than real multi-vendor collaboration

---

## Full Reports

| Solution | Report |
| --- | --- |
| Newton (Linux Foundation) | [project report](../projects/newton.md) |
| MuJoCo (Google DeepMind) | [project report](../projects/mujoco.md) |
| Genesis World (Genesis AI) | [project report](../projects/genesis-world.md) |
| Gazebo (OSRA/Open Robotics) | [project report](../projects/gazebo.md) |
| Isaac Sim (NVIDIA) | [project report](../projects/isaac-sim.md) |

---

## Sources

- [Building Blocks — Simulation Engines](../../research/building-blocks.md#simulation-engines)
- [OSS Landscape Deep Dive](../oss-landscape-deep-dive.md#simulation-engines)
- [Newton GitHub](https://github.com/newton-physics/newton)
- [MuJoCo GitHub](https://github.com/google-deepmind/mujoco)
- [Genesis World GitHub](https://github.com/Genesis-Embodied-AI/genesis-world)
- [Gazebo GitHub](https://github.com/gazebosim/gz-sim)
- [Isaac Sim GitHub](https://github.com/isaac-sim/IsaacSim)
- [NVIDIA and Global Robotics Leaders — GTC 2026](https://nvidianews.nvidia.com/news/nvidia-and-global-robotics-leaders-take-physical-ai-to-the-real-world)
