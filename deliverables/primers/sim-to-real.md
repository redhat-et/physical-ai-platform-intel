# Sim-to-Real Transfer: Why Simulation Fidelity Isn't What You Think

Simulation is the dominant training paradigm for robot learning. Reinforcement learning for locomotion, synthetic data for perception, imitation learning for manipulation: all depend on simulators producing experience that transfers to real hardware. A policy that achieves 95% success in simulation drops to 30–60% on the physical robot. Closing that gap is the central engineering problem in robotics deployment, and the intuitive response (make the simulation more realistic) is only half right.

This primer decomposes the sim-to-real gap into independent axes, surveys the techniques that close it, and maps how they compose into modern transfer pipelines. The audience is robotics engineers and solution architects evaluating simulation infrastructure.

## The Gap and Its Three Axes

The sim-to-real gap decomposes into three independent fidelity axes. Each has different failure modes, different mitigation techniques, and different cost profiles. Most sim-to-real literature conflates them under a single "fidelity" dimension. Separating them is how you make good infrastructure decisions.

### Axis 1: Physics Fidelity

Physics fidelity measures how well the simulator reproduces the dynamics a robot experiences: contact forces, friction, joint behavior, object mass and inertia, deformable body mechanics.

**Matters for** contact-rich manipulation (grasping, insertion, in-hand reorientation), locomotion on varied terrain, and any task where policy success depends on force-level interactions. A survey of the sim-to-real gap (Zhao et al. 2025) found that contact dynamics inaccuracy accounts for ~32% of transfer failures in manipulation, with sensor noise modeling adding another ~24%. Over half the gap traces back to physics, not visuals.

**Matters less for** visual navigation, high-level task planning, and perception-only pipelines (object detection, segmentation). The "Rethinking Sim2Real" study (Truong et al., CoRL 2022) showed this: for visual navigation across three quadruped robots (A1, AlienGo, Spot), kinematic simulation (no physics, just teleportation) *outperformed* full dynamic simulation. Faster simulation produced more training data, which produced better generalization.

Real-world contact involves deformation, micro-slip, adhesion, and stochastic surface interactions. Most physics engines use simplified rigid-body contact models (complementarity-based or penalty-based) that skip these effects. Policies trained on simplified contact can exploit simulator artifacts, learning strategies that succeed only because the friction model behaves in a specific (wrong) way. This "physics exploitation" is a well-documented failure mode.

**Fidelity spectrum**: MuJoCo's contact modeling and solver stability remain the benchmark for articulated-body accuracy. PhysX 5 (used in Isaac Sim, SAPIEN) adds GPU-accelerated rigid and soft body simulation with TGS solvers. PhysX 4.1 (used in Unity) relies on older CPU-only PGS solvers with game-mode defaults. Saying "both use PhysX" understates a significant fidelity and throughput gap. At the frontier, differentiable physics engines enable gradient-based system identification, the most efficient way to calibrate simulator parameters to match real hardware.

### Axis 2: Visual Fidelity

Visual fidelity measures how closely rendered images match real camera observations: lighting, material appearance, reflections, shadows, texture detail.

**Matters for** any policy or model that takes RGB images as input: visuomotor manipulation policies, object detectors trained on synthetic data, visual navigation with ego-centric cameras. The gap shows up most in reflections, transparent surfaces, specular materials, and variable lighting.

**Matters less for** policies that operate on proprioceptive state only (joint positions, forces, torques), depth-only perception, or policies using pre-trained visual backbones that abstract away pixel-level appearance.

**Fidelity spectrum**: Full path tracing (Isaac Sim's OptiX/RTX) models real light transport (global illumination, caustics, accurate material interaction). It is the most accurate but compute-intensive and CUDA-locked. Hybrid rasterization with selective ray tracing (Unity HDRP, Unreal Engine) approximates most effects and uses selective RT for reflections or GI. Visually convincing, but systematic approximation gaps remain. 3D Gaussian Splatting (SplatSim, VR-Robo, Re3Sim) reconstructs real scenes as splat fields, producing photorealistic novel views from actual environments. You photograph the real workspace and train in its reconstruction, bypassing asset creation altogether.

SplatSim (Qureshi et al. 2024) achieved 86.25% zero-shot real-world manipulation success vs. 97.5% with real data. That ~11% gap, without domain randomization or fine-tuning, shows photorealistic rendering alone gets most of the way. But teams using photorealistic simulators with imperfect physics still see 20–40% drops on contact-rich tasks. Visual fidelity cannot compensate for physics gaps when contact dynamics matter.

### Axis 3: Sensor Fidelity

Sensor fidelity measures how well the simulator reproduces non-camera sensor modalities: LiDAR, radar, depth cameras (ToF, structured light), IMUs, force/torque sensors.

**Matters for** autonomous vehicles (LiDAR and radar are primary sensors), warehouse robotics (LiDAR-based navigation), and any application where the dominant sensor is not an RGB camera. LiDAR is the clearest example: a basic raycast model treats all surfaces as opaque perfect reflectors. Real LiDAR interacts with material properties (transparent barriers, wet roads, retroreflective signs, shrink-wrapped pallets). The difference between raycast and physics-based LiDAR is not subtle. It changes whether the sensor sees obstacles at all.

**Fidelity spectrum**: Isaac Sim's RTX sensor SDK models material interaction in non-visual spectra: LiDAR transparency, reflectivity, radar Doppler and radio-spectrum emissivity. Nothing else offers this today. Unity and Gazebo use basic raycasts for LiDAR and lack native radar simulation. Depth cameras show a similar split: Z-buffer depth (most engines) vs. physics-based time-of-flight or structured-light noise modeling (Isaac Sim).

A simulator can have excellent physics (MuJoCo) and poor sensor simulation, or excellent sensor simulation (Isaac Sim RTX) with physics that's less stable for contact-rich tasks. Sensor fidelity is orthogonal to both other axes.

### Task Determines Priority

The three axes carry different weight depending on the application:

| Use Case | Dominant Axis | Reason |
| --- | --- | --- |
| Contact-rich manipulation (grasping, insertion) | Physics | Policy success depends on force-level contact dynamics |
| Synthetic data for perception (detection, segmentation) | Visual | Model quality depends on image realism |
| AV sensor validation | Sensor | LiDAR/radar fidelity determines obstacle detection |
| Locomotion on varied terrain | Physics + Visual | Foot contact dynamics + visual terrain understanding |
| Visual navigation | Visual (+ throughput) | Obstacle avoidance from RGB; physics secondary |
| Factory layout / virtual commissioning | Low on all | Visualization and spatial accuracy, not policy training |

There is no single "simulation fidelity" dial. Three independent investment axes, and the right allocation depends on the task.

## Closing the Gap

No simulator is perfect on any axis. Five approaches dominate, each targeting different aspects of the problem.

### Domain Randomization

Domain randomization (DR) varies simulation parameters during training (textures, lighting, camera position, object colors, masses, friction, actuator delays, sensor noise) so the policy learns robustness across a distribution broad enough that reality falls within it.

**Visual DR** works well. Randomizing textures, lighting, and camera parameters reduces the visual domain gap even with rasterization-based renderers. OpenAI's dexterous manipulation result (Rubik's Cube solving on a real Shadow Hand) relied on heavy visual and dynamics DR. A benchmarking study found that a small number of high-quality images beats a large number of low-quality images for transfer, and that both distractors and varied textures aid generalization.

**Dynamics DR** (randomizing masses, friction, actuator parameters) helps with physics gaps but is less effective. The asymmetry matters: inaccurate contact dynamics produce *systematic* policy failures (wrong force profiles), while visual variation produces *statistical* gaps (insufficient visual diversity). Systematic errors are harder to randomize away because the mean of the distribution may still be wrong.

Wide randomization makes the learning problem harder. The policy must handle conditions it will never encounter, which caps peak performance. Targeted randomization (varying only task-relevant parameters) outperforms uniform randomization.

### System Identification

System identification calibrates simulator parameters to match measured real-world behavior. Instead of randomizing over uncertainty, you *reduce* uncertainty by measuring the real system.

**Classical approach**: Record real robot trajectories (joint positions, velocities, torques), then optimize simulator parameters (masses, inertias, friction coefficients, actuator gains) until the simulator reproduces the measured behavior. Least-squares optimization over the inverse dynamics equation.

**Differentiable physics**: Differentiable simulators (emerging in Isaac Lab via Newton, also in Brax and DiffTaichi) let gradients flow through the physics engine. Gradient-based parameter optimization converges orders of magnitude faster than black-box search. Engineers optimize log-space parameters (masses, inertias, and friction must stay positive) and smooth Coulomb friction's discontinuity at zero velocity for differentiability.

The "How Should a Sim-to-Real Budget Be Spent?" study (Rizvi & Tomar 2026) formalized the tradeoff: given limited real-robot measurement time, calibrating simulation parameters outperforms broadening randomization distributions. Even minimal calibration rollouts close most of the transfer gap. **Calibrate first. Randomize only the residual uncertainty.**

### Residual Learning

Instead of building a perfect simulator or replacing it with a learned model, you can learn the *difference* between simulator and reality.

Contact-Aware Neural Dynamics (2026) demonstrates the pattern: an off-the-shelf physics engine serves as a base prior, and a neural network learns a residual correction using real-world observations. Tactile sensing provides the critical signal for modeling contact discontinuities that visual observation misses. The simulator handles bulk dynamics; the neural network handles the contact subtleties that rigid-body engines skip.

Simulators don't need to solve contact perfectly. They need a good-enough prior that residual learning can correct. The platform implication: simulators should expose APIs for residual learning overlays.

### Foundation Model Visual Backbones

Instead of making the simulator's *rendering* match reality, you can use visual encoders *invariant* to rendering quality.

Vision foundation models (DINOv2, SigLIP) pretrained on internet-scale data produce visual features robust across domains. They map both simulated and real images into similar embedding spaces. A policy trained on these features in simulation transfers better because the feature extractor already ignores domain-specific pixel details.

A policy using DINOv2 features trained in a game-engine renderer may transfer as well as one trained in a ray-traced renderer. The foundation model absorbs the visual domain gap that used to require photorealistic rendering or heavy DR.

**Limitation**: Works for policies using learned visual features. Does not help perception models that need pixel-accurate training data (object detectors, instance segmentors).

### Hybrid Sim-and-Real

The most reliable modern approach: simulation for pre-training, then fine-tuning on a small amount of real-world data.

Simulation provides the behavioral prior. The policy learns the structure of the task (reach, grasp, lift, place) from millions of simulated episodes. Real data (10–200 demonstrations) corrects for the specific physics and visual gaps the simulation missed. The combination outperforms either approach alone and requires 5–10x less real data than training from scratch.

HyperSim (2026) is the most complete implementation: high-fidelity environment synthesis + adversarial trajectory generation + sim-and-real co-training reaches 95% success with pi0 across 400 real-world manipulation trials. Adversarial training adds 35% higher robustness under physical perturbations.

Physical Intelligence's production pattern (pi0 family) follows the same template: simulation pre-training + 50–200 real demonstrations for task-specific fine-tuning.

## Modern Pipeline Architectures

These techniques compose into pipeline architectures that define how simulation and reality interact across the training lifecycle.

### Traditional: Sim-to-Real (One-Way)

```text
Simulation → Train Policy → Deploy on Real Robot
     ↑
     Domain Randomization / System ID
```

Train in simulation, transfer to real hardware. DR and system identification make the simulation good enough. No mechanism to learn from deployment experience, no feedback loop to improve the simulation.

Still the right choice for locomotion on known terrain types, warehouse navigation, and tasks where the physics gap is small and well-characterized.

### Real-to-Sim-to-Real

```text
Real Environment → Reconstruct (3DGS/NeRF) → Train in Reconstruction → Deploy
```

Reconstruct the *actual* deployment environment instead of building a synthetic one from scratch. 3D Gaussian Splatting and NeRF enable photorealistic reconstruction from multi-view images or video.

VR-Robo (2025) demonstrates this for locomotion: reconstruct real environments as 3DGS scenes, integrate them with mesh-based physical interactions, train ego-centric navigation policies, deploy on quadrupeds. The visual gap shrinks because the training environment *is* reality, reconstructed.

Re3Sim (2025) applies the pattern to manipulation, addressing both the geometric gap (shape mismatches from CAD models) and the visual gap (imperfect rendering).

ReBot (2025) replays real-world robot trajectories in simulation to diversify manipulated objects (real-to-sim), then composites simulated movements with inpainted real-world backgrounds (sim-to-real). Simulation's scalability meets reality's visual authenticity.

SplatSim showed that decoupling physics (PyBullet) from rendering (3DGS) works well. The platform should support composable subsystems, not monolithic simulators.

### World Model-Based Training

```text
Real Data → Train World Model → Train Policy in World Model → Deploy
```

Train a learned world model from real or simulated data, then train the policy inside the learned model. The world model *is* the simulator.

World models learn dynamics from data, capturing effects that physics engines approximate. No manual parameter tuning, no system identification. The model learns what matters.

The risk: world models trained with video generation objectives (diffusion models) optimize for visual plausibility, not physical accuracy. A generated video that *looks* right may violate conservation of energy, produce impossible contact forces, or create physically inconsistent object interactions. Policies trained on such data learn incorrect dynamics.

PhysisForcing (Peking University + NVIDIA, 2026) addresses this by injecting physics supervision into video diffusion models during fine-tuning. The method identifies physics-informative regions (manipulators, objects, contact areas) and applies trajectory alignment (via point tracking) and relational alignment (via frozen video understanding encoders). Closed-loop manipulation success improves from 16% to 24%, with no inference overhead.

A world model that generates plausible but physically wrong video produces *worse* training data than a physics simulator with cartoonish rendering. Physics accuracy in training dynamics is non-negotiable. Visual quality is secondary and compensable.

### Co-Training and Dynamic Digital Twins

**Co-training** (HyperSim pattern): train on simulation data and real data at the same time. The training objective enforces domain-invariant representations, so the model extracts task-relevant features regardless of data source.

**Dynamic digital twins** (Real-is-Sim, TwinRL) maintain a continuously-synchronized replica of the real environment. Real-is-Sim (2025) inverts the paradigm: policies act on the simulated robot at 60Hz, and the physical robot tracks the simulated joint states. The sim-to-real gap becomes a synchronization problem. TwinRL (2026) uses digital twins as exploration guides: the twin identifies failure-prone configurations, then targeted rollouts on the real robot address those gaps.

## Simulator Landscape Through the Fidelity Lens

The three-axis decomposition maps to simulator selection. See [Building Blocks: Simulation Engines](../../research/building-blocks.md#simulation-engines) for detailed dependency analysis.

| Platform | Physics Fidelity | Visual Fidelity | Sensor Fidelity | GPU-Parallel Throughput | Hardware Lock-in |
| --- | --- | --- | --- | --- | --- |
| Isaac Sim / Lab | High (PhysX 5, TGS) | High (OptiX path tracing) | High (RTX sensor SDK) | 1000s of parallel envs | CUDA only |
| MuJoCo / MJX | Highest (contact accuracy) | Low (built-in renderer) | Low (basic) | High (via JAX/MJX) | CUDA via JAX; CPU fallback |
| Genesis World | High (custom solver) | High (Nyx renderer) | Medium | High (Quadrants compiler) | CUDA, ROCm, Metal, Vulkan |
| Gazebo (Harmonic) | Medium (DART/ODE) | Medium (OGRE-Next) | Low (raycast) | Low (single scene) | Hardware-portable |
| Unity Industry | Medium (PhysX 4.1 CPU) | Medium-High (HDRP) | Low (basic raycast) | Low (CPU physics) | Multi-platform |
| SAPIEN / ManiSkill | High (PhysX 5) | Medium (Vulkan) | Medium | High (GPU batched) | CUDA, CPU |
| Unreal Robotics Lab | Highest (MuJoCo backend) | High (Unreal Engine) | Medium | Low (MuJoCo CPU) | Multi-platform |

No single platform leads on all axes. Isaac Sim is the most complete but CUDA-locked. MuJoCo has the best contact physics but minimal rendering. Genesis World offers the best hardware portability with competitive fidelity. The Unreal Robotics Lab pairs best-in-class physics (MuJoCo) with best-in-class rendering (UE) but sacrifices GPU-parallel throughput, since MuJoCo runs on CPU.

The composable architecture pattern (SplatSim: PyBullet + 3DGS; Unreal Robotics Lab: MuJoCo + UE) suggests the right answer may be a stack pairing best-in-class subsystems per axis, not a single platform.

## Platform Implications

- **Decompose fidelity requirements by task.** Contact-rich manipulation needs physics accuracy first. Synthetic data for perception needs visual fidelity first. AV sensor validation needs sensor fidelity first. Don't optimize uniformly.
- **Calibrate before you randomize.** Fitting the simulator to measured real-world behavior closes more gap per engineering hour than broadening randomization distributions.
- **Support composable simulation stacks.** The best physics engine and the best renderer may not live in the same platform. Infrastructure that mixes subsystems (MuJoCo + 3DGS, or PhysX + Unreal) beats monolithic simulators.
- **Build real-to-sim, not just sim-to-real.** 3DGS/NeRF scene reconstruction from real environments is becoming standard. The platform needs infrastructure for scene capture, reconstruction, and integration with simulation.
- **Plan for hybrid data.** The production pattern is simulation pre-training + real-world fine-tuning. Data pipelines must mix simulated and real demonstration data with consistent formats and labeling.
- **Treat throughput as a fidelity multiplier.** Running 1000s of parallel environments enables training at billions of steps. Policies encounter rare edge cases invisible at lower sample counts. The transfer improvement from 10x more training data can exceed the improvement from 2x better physics fidelity.

---

*Last updated: 2026-10-03. Covers research through September 2026.*

*Key references: "The Reality Gap in Robotics" (arXiv 2510.20808), "Rethinking Sim2Real" (arXiv 2207.10821), SplatSim (arXiv 2409.10161), PhysisForcing (arXiv 2606.28128), HyperSim (arXiv 2605.26638), "How Should a Sim-to-Real Budget Be Spent?" (arXiv 2606.22062), Contact-Aware Neural Dynamics (arXiv 2601.12796), VR-Robo (arXiv 2502.01536), Re3Sim (arXiv 2502.08645), ReBot (arXiv 2503.14526). See [publications.md: Sim-to-Real Transfer](../../research/publications.md#sim-to-real-transfer) for full entries.*
