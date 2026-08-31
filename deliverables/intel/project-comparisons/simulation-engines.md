# Simulation Engines — Solution Comparison

**Date**: 2026-06-22
**Last updated**: 2026-08-31
**Building block**: Simulation Engines
**Classification**: Internal analysis — not for public repo

Compares solutions for the **Simulation Engines** platform capability to inform Red Hat's build/partner/integrate decision.

**Solutions compared**: Newton (Linux Foundation) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA/Open Robotics) | Isaac Sim (NVIDIA) | O3DE (Open 3D Foundation)

---

## Decision Summary

**Recommended pick**: **Newton (Linux Foundation)** — best governance fit (LF charter, multi-vendor steering with NVIDIA + Google DeepMind + Disney Research), most production-ready GPU physics (8 pluggable solvers), and the only project where Red Hat can contribute to governance and roadmap. CUDA-only hardware is a gap, but the LF governance path provides the strongest long-term strategic position. **August 2026 update**: IsaacLab 3.0 (beta) introduces a multi-backend factory architecture (`PhysicsManager` ABC) with Newton/MJWarp as a first-class backend alongside PhysX — and a Kit-less mode that runs Newton workflows without Isaac Sim/Omniverse Kit dependency. This strengthens Newton's strategic position: the dominant RL framework now treats Newton as a peer backend, not an Isaac Sim plugin.

**Runner-up**: **Gazebo (OSRA/Open Robotics)** — strongest open governance (OSRA PMC), no GPU vendor lock-in, deepest ROS 2 integration, and the standard deployment/validation simulator. Preferred when the use case is ROS 2 validation or sensor simulation rather than large-scale RL training.

---

## Feature Comparison

<!-- Feature dimensions identified from building-blocks.md Simulation Engines section + project capabilities. -->
<!-- Use ✅/⚠️/❌ for boolean features; comma-separated lists for multi-valued features. -->

| Feature | Newton (LF) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) | O3DE (O3DF/LF) |
| --- | --- | --- | --- | --- | --- | --- |
| **Physics types** | Rigid, FEM, XPBD, VBD, MPM, Featherstone, cloth, fluid | Rigid, tendon, contact, soft (FEM via plugin) | Rigid, FEM, MPM, PBD, SPH, SF, cloth | Rigid, joint, contact (DART, Bullet, TPE) | Rigid, deformable, fluid (PhysX + Newton v6.0) | Rigid, joints, cloth (PhysX 5), terrain |
| **GPU backends** | CUDA (via Warp) | CUDA, ROCm, Metal, TPU (via MJX/JAX); CUDA (Warp) | CUDA, ROCm, Metal, Vulkan, CPU (Quadrants) | ❌ CPU only | CUDA only | DX12, Vulkan, Metal (rendering); CUDA optional (PhysX GPU accel) |
| **Parallel envs** | ✅ Thousands (GPU-batched) | ✅ Thousands (MJX batched) | ✅ Thousands (GPU-batched + Madrona) | ❌ Single-threaded | ✅ Thousands (PhysX GPU) | ❌ Single scene (game engine design) |
| **Photorealistic rendering** | ⚠️ Via OpenUSD/Isaac Sim | ⚠️ Experimental Filament renderer | ✅ Nyx path-traced renderer | ⚠️ OGRE 2.x (functional, not photorealistic) | ✅ RTX ray-tracing + NuRec 3DGS | ✅ Atom renderer (PBR, real-time ray tracing, Forward+) |
| **Differentiable simulation** | ⚠️ Partial (Warp AD) | ✅ Full (MJX reverse-mode AD) | ✅ Full (Quadrants AD) | ❌ | ❌ | ❌ |
| **Sensor simulation** | ⚠️ Basic (via Isaac Sim) | ⚠️ Basic (camera, touch) | ✅ Camera, depth, lidar, contact, IMU | ✅ Camera, lidar, IMU, GPS, altimeter, contact (strongest plugin set) | ✅ RTX camera, lidar, IMU, contact, OmniSensor | ✅ Camera, depth, lidar 2D/3D, IMU, GNSS, contact, odometry (via ROS 2 Gem) |
| **ROS 2 integration** | ⚠️ Via Isaac Sim | ⚠️ Via mujoco_ros (community) | ⚠️ Basic Gymnasium integration | ✅ Native (gz-transport, ros_gz bridge) | ✅ Native (ros2 extensions, Nav2, MoveIt) | ✅ Native (ROS 2 Gem — direct node, no bridge) |
| **Scene format support** | MJCF, URDF, USD | MJCF (native), URDF (via converter) | URDF, MJCF, USD, glTF, Collada | SDF (native), URDF, USD (experimental) | USD (native), URDF, MJCF, CAD | URDF, SDF, XACRO (via importer Gem); custom AZ format (native) |
| **Pluggable physics** | ✅ 8 solver backends | ❌ Single engine | ❌ Single engine (7 types, 1 framework) | ✅ 3 backends (DART, Bullet, TPE) | ✅ 2 backends (PhysX, Newton v6.0) | ⚠️ PhysX only (but engine is modular via Gem system) |
| **CPU fallback** | ❌ | ✅ Primary mode | ✅ Via Quadrants CPU backend | ✅ CPU primary | ❌ | ✅ CPU primary (PhysX CPU + Atom CPU fallback) |
| **WebAssembly** | ❌ | ✅ Browser-based simulation | ❌ | ❌ | ❌ | ❌ |
| **Animation system** | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ EMotionFX (skeletal, motion matching, blend trees) |
| **Visual scripting** | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ Script Canvas (node-based) + Lua + Python |
| **3D editor** | ❌ | ❌ | ❌ | ⚠️ gz-gui (functional) | ✅ Omniverse Create | ✅ Full 3D editor (Qt-based, asset browser, viewport) |

---

## Fidelity Comparison

<!-- Physics and rendering accuracy tiers. Critical for understanding which simulator fits which workload. -->
<!-- Game-grade = optimized for interactive frame rates, iterative solvers, "looks right at 60fps". -->
<!-- Research-grade = validated contact models, analytical solvers, designed for sim-to-real transfer. -->

### Physics Fidelity

| Tier | Simulator | Approach | Sim-to-Real | Detail |
| --- | --- | --- | --- | --- |
| Research-grade | MuJoCo (Google DeepMind) | Analytical contact model, convex optimization solver | ✅ Validated | 14 years of academic validation, 9,250+ citations. Gold standard for robotics RL sim-to-real transfer. Continuous contact dynamics, not iterative |
| Research-grade | Newton (LF) | 8 pluggable solvers including MuJoCo Warp, FEM, MPM | ✅ Via solver choice | Inherits MuJoCo's contact model via MuJoCo Warp backend. Also offers FEM, MPM, XPBD for deformables and fluids. Newest — less independently validated |
| Research-grade | Genesis World (Genesis AI) | 7 physics types in unified GPU framework | ⚠️ Early | MPM, FEM, PBD, SPH, rigid body. Differentiable. Less validated than MuJoCo but broader physics coverage |
| Functional | Gazebo (OSRA) | DART/Bullet/TPE backends | ⚠️ Adequate for deployment | DART provides reasonable rigid body accuracy. 20+ years of use in DARPA/NASA challenges. Not designed for GPU-parallel RL training |
| Game-grade | Isaac Sim (NVIDIA) | PhysX 5 (real-time) + Newton (research) | ✅ Via Newton backend | PhysX alone is game-grade (iterative solvers, speed over accuracy). Newton backend (added in 6.0) provides research-grade physics when needed |
| Game-grade | O3DE (O3DF/LF) | PhysX 5 (real-time only) | ❌ Not validated | PhysX iterative solvers optimized for interactive frame rates. No research-grade physics option. No differentiable physics. Suitable for visualization and deployment validation, not RL training |

### Rendering Fidelity

| Tier | Simulator | Approach | Sensor Sim Quality | Detail |
| --- | --- | --- | --- | --- |
| Highest | Isaac Sim (NVIDIA) | RTX hardware ray tracing + NuRec 3DGS | Highest | Full path tracing on RTX GPUs. Neural reconstruction (3DGS) bridges real-to-sim. OmniSensor provides ray-traced lidar, radar, camera. Locked to NVIDIA hardware |
| High | Genesis World (Genesis AI) | Nyx offline path tracer + LuisaRender | High | Photorealistic offline rendering. Not real-time but produces high-quality synthetic training data |
| Good | O3DE (O3DF/LF) | Atom PBR + real-time ray tracing (DX12/Vulkan/Metal) | Good | AAA game-quality rendering. PBR materials, real-time GI, SSAO/SSR. GPU Lidar Gem (Robotec.ai) provides ray-traced lidar. Multi-API — not locked to NVIDIA |
| Functional | Gazebo (OSRA) | OGRE 2.x rasterization | Adequate | Functional but not photorealistic. Good sensor plugin set (camera, lidar, IMU, GPS) but rasterized, not ray-traced |
| Minimal | MuJoCo (Google DeepMind) | OpenGL (native), Filament (experimental) | Basic | Simple viewport rendering. Camera and touch sensors. Not designed for perception training |
| Minimal | Newton (LF) | No built-in renderer | N/A | Relies on Isaac Sim or OpenUSD for visualization. Pure physics engine |

### Best Fit by Use Case

| Use Case | Best Fit | Runner-up | Rationale |
| --- | --- | --- | --- |
| **GPU-parallel RL training** | Newton (LF), MuJoCo (DeepMind) | Genesis World (Genesis AI) | Requires research-grade physics + thousands of parallel environments. MuJoCo has most validated contact model; Newton adds LF governance |
| **Sim-to-real transfer** | MuJoCo (DeepMind) | Newton (LF) via MuJoCo Warp | MuJoCo's analytical contact model is the academic gold standard for sim-to-real. Newton inherits it via MuJoCo Warp backend |
| **Synthetic data generation** | Isaac Sim (NVIDIA) | Genesis World (Genesis AI) | Requires photorealistic rendering for perception training. RTX ray tracing produces highest-fidelity sensor data |
| **ROS 2 deployment validation** | Gazebo (OSRA) | O3DE (O3DF/LF) | Gazebo is the standard ROS 2 companion with 20+ years of trust. O3DE offers better rendering + native ROS 2 (no bridge) |
| **Digital twin / visualization** | O3DE (O3DF/LF) | Isaac Sim (NVIDIA) | O3DE provides AAA rendering + full 3D editor + open governance. Isaac Sim has better rendering but proprietary lock-in |
| **Deformable / fluid simulation** | Newton (LF) | Genesis World (Genesis AI) | Newton offers FEM, MPM, XPBD for soft bodies and fluids. Genesis World also covers this with MPM, SPH, PBD |
| **Differentiable simulation** | MuJoCo (DeepMind) via MJX | Genesis World (Genesis AI) | MJX provides full reverse-mode AD through JAX. Genesis World offers differentiable physics via Quadrants |

---

## Lock-in Comparison

| Dimension | Newton (LF) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) | O3DE (O3DF/LF) |
| --- | --- | --- | --- | --- | --- | --- |
| **Hardware** | High — CUDA-only via Warp | Low — CPU native; CUDA/ROCm/Metal via MJX/JAX | Low — CUDA, ROCm, Metal, Vulkan, CPU via Quadrants | Low — CPU only, no GPU vendor | High — CUDA-only, RTX for rendering | Low — multi-API rendering (DX12/Vulkan/Metal); PhysX GPU optional |
| **Vendor** | Medium — LF governance mitigates, but NVIDIA controls Warp dependency | High — Google DeepMind 89% commits, CLA, no external maintainers | High — Genesis AI controls all repos + Quadrants compiler (fork of unmaintained Taichi) | Low — OSRA PMC governance, multiple maintainer orgs | High — 117 proprietary omni.* deps, no contributions accepted. IsaacLab 3.0 Kit-less Newton mode partially mitigates by bypassing Kit SDK for RL training | Low — LF governance, DCO, Amazon donated and cannot reclaim; PhysX vendored as O3DE fork (BSD-3-Clause) |
| **Ecosystem** | Low — open formats (MJCF, URDF, USD), standard APIs. IsaacLab 3.0 multi-backend architecture elevates Newton to a first-class physics backend in the dominant RL framework | Low — MJCF open standard, wide ecosystem support | Low — standard formats (URDF, MJCF), Gymnasium integration | Low — SDF open standard, native ROS 2 ecosystem | High — proprietary Kit extensions, NVIDIA-only ecosystem (Isaac Lab, GR00T, Cosmos). But IsaacLab 3.0 factory pattern decouples RL framework from Kit for Newton backend | Medium — custom AZ asset formats not widely adopted outside O3DE; but URDF/SDF import, 83 Gems, Gem registry |

---

## Production Adoption

| Solution | Notable Users |
| --- | --- |
| **Newton (LF)** | Skild AI + Foxconn (GPU rack assembly), Samsung + Lightwheel (cable manipulation), Disney Research (Olaf robots), Toyota Research Institute, Universal Robots, Agility Robotics |
| **MuJoCo (Google DeepMind)** | Google DeepMind (dm_control, MuJoCo Playground), Toyota Research Institute, Samsung, Skild AI, Disney Research, Farama Foundation (Gymnasium); dominant in academic robotics RL (9,250+ citations) |
| **Genesis World (Genesis AI)** | Genesis AI (internal — GENE robotics model), Wuji Tech (robotic hand); no external enterprise production users confirmed |
| **Gazebo (OSRA)** | DARPA DRC, NASA Space Robotics Challenge, Intrinsic, Universal Robots, Clearpath Robotics, Amazon RoboMaker; standard for ROS 2 development and validation |
| **Isaac Sim (NVIDIA)** | ABB, FANUC, KUKA, Yaskawa (industrial robots), Figure AI, Boston Dynamics, Agility (humanoids), J&J MedTech, CMR Surgical (surgical), Caterpillar (manufacturing), Skild AI, FieldAI; broadest production adoption |
| **O3DE (O3DF/LF)** | Carbonated (MadWorld mobile game), Robotec.ai (warehouse robotics simulation, ROSCon 2023), Cloud Imperium Games (active contributor), Genome Studios, Red Hat (General member + active contributor), RIT/Kutztown (academic), Discovery Grid (virtual world); 27 foundation member organizations |

---

## Red Hat Platform Fit

| Dimension | Newton (LF) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) | O3DE (O3DF/LF) |
| --- | --- | --- | --- | --- | --- | --- |
| **Runs on OpenShift** | With effort | With effort | With effort | With effort | No (proprietary Kit SDK); but IsaacLab 3.0 Kit-less Newton mode bypasses Kit SDK | With effort (Dockerfile available) |
| **RHEL compatible** | Yes | Yes | Yes | Yes | Partial (NVIDIA runtime) | Yes (Linux primary platform) |
| **License compatible** | Yes (Apache-2.0) | Yes (Apache-2.0) | Yes (Apache-2.0) | Yes (Apache-2.0) | Caution (code Apache-2.0, runtime proprietary) | Yes (Apache-2.0 + MIT dual) |
| **Contribution model** | Open (DCO) | CLA (Google CLA) | None (no CLA/DCO) | Open (DCO) | Closed (no contributions accepted) | Open (DCO) |
| **Vendor relationship** | Partner (LF member) | Neutral | Neutral | Partner (OSRA) | Competitor | **Partner (LF member, Red Hat is O3DF General member)** |
| **Platform fit** | **Integrate** | Integrate | Integrate | **Partner** | Partner | **Partner** |

---

## Health & Risk Comparison

| Dimension | Newton (LF) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) | O3DE (O3DF/LF) |
| --- | --- | --- | --- | --- | --- | --- |
| **License** | Apache-2.0 | Apache-2.0 | Apache-2.0 | Apache-2.0 | Apache-2.0 (code) + Proprietary (runtime) | Apache-2.0 + MIT (dual) |
| **Governance** | Foundation (LF) | Single-vendor | Single-vendor | Foundation (OSRA) | Single-vendor | Foundation (LF — Open 3D Foundation) |
| **Elephant Factor** | Low (1 — NVIDIA ~75%) | Low (1 — Google ~89%) | Low (1 — Genesis AI ~60%) | Low (1 — Intrinsic ~50%) | Low (1 — NVIDIA 100%) | High (4 — diverse; no single org >32% all-time) |
| **Contributor diversity** | Watch (CAF=3) | Watch (CAF=3) | Risk (CAF=2) | Risk (CAF=2) | Risk (CAF=1) | Healthy (CAF=19 all-time; but recent 12mo has ~30 active) |
| **Contribution trend** | Stable | N/A | Narrowing | Narrowing | N/A | Narrowing (Amazon withdrawal; diversifying but low volume) |
| **Corporate control risk** | Medium (LF mitigates) | High (CLA + 89% commits) | High (no governance) | Medium (OSRA mitigates) | High (no contributions) | Medium (LF governance + 27 members; but post-Amazon transition risk) |
| **Community health** | Active | Active | Active | Active | Maintained | Maintained (162 commits/12mo from ~30 contributors; resurgent) |
| **Tech stack alignment** | Neutral | Neutral | Neutral | Neutral | Misaligned | Neutral (C++ primary, not PyTorch; but Linux CI, Docker, multi-API) |
| **Hardware portability** | Locked (CUDA) | Portable (CPU + MJX multi-GPU) | Portable (multi-GPU via Quadrants) | Limited (CPU only) | Locked (CUDA) | Portable (DX12/Vulkan/Metal rendering; PhysX CPU + optional GPU) |
| **Dependency health** | Healthy (1 dep: Warp) | Healthy (minimal C deps) | Watch (32 deps, Quadrants risk) | Watch (15+ gz-* libs, LGPL deps) | Risky (117 proprietary omni.* deps) | Watch (vendored PhysX fork, Qt LGPL, AZSL compiler fork, 2.5M LOC) |
| **Security posture** | Adequate | Adequate | Weak | Adequate | Adequate | Adequate (SECURITY.MD, CODEOWNERS, DCO; no OpenSSF Scorecard) |
| **Technical verdict** | Strong | Strong | Adequate | Adequate | Strong | Adequate (AAA rendering, Gem architecture; but weak testing, low activity) |

---

## Architecture Comparison

| Aspect | Newton (LF) | MuJoCo (Google DeepMind) | Genesis World (Genesis AI) | Gazebo (OSRA) | Isaac Sim (NVIDIA) | O3DE (O3DF/LF) |
| --- | --- | --- | --- | --- | --- | --- |
| **Design philosophy** | Pluggable solver framework | Monolithic C engine + JAX port | Unified multi-physics with GPU compiler | Modular C++ library set with plugin system | Monolithic Kit extension platform | Full 3D game engine with modular Gem architecture |
| **Language** | Python (406K LOC) | C/C++ (207K LOC) + Python | Python (165K LOC) | C++ (multi-repo) | Python (592K) + C++ (62K) | C++ (2.2M LOC) + Python (205K LOC) |
| **Runtime requirements** | NVIDIA GPU + Warp | CPU (native) or GPU (MJX/JAX) | GPU (Quadrants) or CPU | CPU (Linux/macOS/Windows) | NVIDIA GPU + Omniverse Kit SDK (proprietary) | CPU + GPU (any: DX12/Vulkan/Metal). No proprietary runtime |
| **Extension model** | Pluggable solver backends | Plugin API (actuators, sensors, SDF) | Python SDK (entities, materials) | Plugin API (strongest: physics, sensors, rendering, GUI) | Kit extension system (117 extensions) | Gem system (83 built-in Gems; custom Gems via JSON + CMake) |
| **Data format** | MJCF, URDF, USD | MJCF (native), URDF (converter) | URDF, MJCF, USD, glTF | SDF (native), URDF | USD (native), URDF, MJCF, CAD | URDF, SDF, XACRO (importer); AZ format (native) |
| **Key dependencies** | Warp (NVIDIA) | JAX (Google), pybind11 | Quadrants (Genesis AI fork of Taichi) | DART, OGRE, ZeroMQ, Qt | Omniverse Kit SDK (NVIDIA proprietary) | PhysX (vendored fork), Qt, LLVM/Clang (AZSL), Python |
| **Rendering** | Via OpenUSD / Isaac Sim | OpenGL (native), Filament (experimental) | Nyx (photorealistic), LuisaRender, Pyrender | OGRE 2.x (functional) | RTX (photorealistic) + NuRec 3DGS | Atom (PBR, real-time ray tracing, Forward+, DX12/Vulkan/Metal) |

---

## Recommendation Rationale

### Why Newton (Linux Foundation)

- **Governance**: Only simulation engine under foundation governance (Linux Foundation). Multi-vendor steering (NVIDIA, Google DeepMind, Disney Research). DCO contribution model — Red Hat can contribute without CLA friction
- **Technical maturity**: 8 pluggable physics solver backends (most flexible architecture), 179 test files, Codecov integration, clean single-dependency design (Warp only)
- **Strategic positioning**: Absorbs MuJoCo's physics model (via MuJoCo Warp) while providing LF governance. Represents the industry's attempt to create a vendor-neutral simulation standard. Red Hat contributing here builds influence over the future of open simulation
- **Production adoption**: Already used by Skild AI + Foxconn, Samsung + Lightwheel, Disney Research, Toyota, Universal Robots — demonstrates real-world viability at 14 months old
- **Isaac Sim integration**: Newton is now a physics backend in Isaac Sim 6.0, meaning Newton adoption does not require abandoning the Isaac Sim ecosystem — it provides a governance-independent physics path within it
- **IsaacLab 3.0 multi-backend architecture (Aug 2026)**: IsaacLab 3.0 (beta) introduces a `PhysicsManager` ABC with factory pattern, supporting three backends: PhysX (`isaaclab_physx`), Newton/MJWarp (`isaaclab_newton`), and OvPhysX (`isaaclab_ov`). Newton is now a first-class peer backend in the dominant robot learning framework, not just an Isaac Sim plugin. Kit-less Newton mode runs IsaacLab RL training workflows without Isaac Sim or Omniverse Kit dependency — removing the proprietary runtime from the critical path for RL training. MJWarp (MuJoCo-Warp by Google DeepMind) serves as the primary validated solver within the Newton backend. Active development: PR #7429 (backend registry), PR #7393 (MuJoCo schema, merged), PR #7386 (MJC attributes). Component support matrix across backends covers Articulation, Rigid Object, and Deformable (partial for Newton)

### What we give up

- **Hardware portability**: Newton is CUDA-only (via Warp). MuJoCo (via MJX/JAX) and Genesis World (via Quadrants) support ROCm, Metal, and multi-backend GPU. This is Newton's biggest gap for Red Hat's hardware-neutral positioning. IsaacLab 3.0's `use_mujoco_cpu=True` diagnostic mode provides a CPU fallback via MuJoCo's native C engine, but it is not validated for training — it is a development/debugging tool only
- **Rendering**: Newton has no built-in renderer — relies on Isaac Sim or OpenUSD for visualization. Genesis World (Nyx) and Isaac Sim (RTX) have photorealistic rendering built in
- **Maturity**: At 14 months, Newton is the youngest project. MuJoCo has 14 years and 9,250+ citations. Gazebo has 20+ years and NASA/DARPA pedigree
- **CPU path**: Newton has no production CPU fallback. MuJoCo, Genesis World, and Gazebo all run on CPU, which matters for development, CI, and non-GPU environments
- **ROS 2 integration**: Gazebo has native, battle-tested ROS 2 integration. Newton's ROS path is indirect (via Isaac Sim)

### Where O3DE fits

O3DE occupies a distinct niche: it's a full AAA game engine with simulation capabilities, not a purpose-built physics/RL simulator. Its strengths — photorealistic Atom renderer, full 3D editor, animation system (EMotionFX), visual scripting (Script Canvas), native ROS 2 integration — make it compelling for **visualization, digital twin, and deployment validation** use cases where scene fidelity matters more than GPU-parallel RL training throughput.

Red Hat's existing investment (General member of O3DF, Roddie Kieley co-chairs SIG Platform, Nick Schuetz is #2 recent contributor) and O3DE's governance fit (LF, DCO, Apache-2.0 + MIT, no CLA) are the strongest of any project in this comparison. However, O3DE does not compete on the GPU-batched physics simulation dimension that drives the Newton recommendation — it cannot run thousands of parallel environments for RL training.

**O3DE is complementary to Newton/MuJoCo rather than a substitute**: use O3DE for high-fidelity visualization and ROS 2 deployment simulation, use Newton/MuJoCo for GPU-parallel policy training.

### Conditions / Watch items

- **If Newton adds ROCm support** (via Warp multi-backend or JAX integration): strengthens significantly — eliminates the hardware portability gap
- **If Genesis World matures governance** (e.g., contributes Quadrants to a foundation): becomes a strong contender — it already has the best hardware portability
- **If MuJoCo drops the CLA**: becomes more attractive for Red Hat contribution, though governance would still be single-vendor
- **If Gazebo adds GPU physics**: becomes viable for training workloads, not just validation. Currently no indication Intrinsic plans this
- **If Newton community narrows further** (NVIDIA share grows beyond 75%): LF governance becomes a paper shield rather than real multi-vendor collaboration
- **If O3DE contributor base stabilizes and grows**: the post-Amazon transition is the key risk. If the resurgence (May–Jul 2026) sustains and broadens, O3DE becomes the strongest governance + rendering + ROS 2 combination. If it stalls, the 2.5M LOC codebase becomes unmaintainable
- **When IsaacLab 3.0 reaches GA** (currently beta2): the multi-backend factory pattern and Kit-less Newton mode become production-grade. At GA, IsaacLab becomes a Kit-free RL framework for Newton — significantly reducing the lock-in argument against Newton adoption. Full tech eval of Isaac Lab warranted at that point
- **If IsaacLab adds non-CUDA backends** (e.g., MuJoCo MJX via JAX/ROCm, or Genesis World Quadrants): would create a truly hardware-portable RL framework. The `PhysicsManager` ABC is architecturally ready for this, but no non-CUDA backend exists yet

---

## Full Reports

| Solution | Report |
| --- | --- |
| Newton (Linux Foundation) | [project report](../projects/newton.md) |
| MuJoCo (Google DeepMind) | [project report](../projects/mujoco.md) |
| Genesis World (Genesis AI) | [project report](../projects/genesis-world.md) |
| Gazebo (OSRA/Open Robotics) | [project report](../projects/gazebo.md) |
| Isaac Sim (NVIDIA) | [project report](../projects/isaac-sim.md) |
| O3DE (Open 3D Foundation) | [project report](../projects/o3de.md) |

---

## Sources

- [Building Blocks — Simulation Engines](../../research/building-blocks.md#simulation-engines)
- [OSS Landscape Deep Dive](../oss-landscape-deep-dive.md#simulation-engines)
- [Newton GitHub](https://github.com/newton-physics/newton)
- [MuJoCo GitHub](https://github.com/google-deepmind/mujoco)
- [Genesis World GitHub](https://github.com/Genesis-Embodied-AI/genesis-world)
- [Gazebo GitHub](https://github.com/gazebosim/gz-sim)
- [Isaac Sim GitHub](https://github.com/isaac-sim/IsaacSim)
- [O3DE GitHub](https://github.com/o3de/o3de)
- [Open 3D Foundation](https://o3df.org/)
- [O3DE 25.05.0 Release](https://www.linuxfoundation.org/blog/open-3d-foundation-launches-o3de-25.05.0-release)
- [NVIDIA and Global Robotics Leaders — GTC 2026](https://nvidianews.nvidia.com/news/nvidia-and-global-robotics-leaders-take-physical-ai-to-the-real-world)
