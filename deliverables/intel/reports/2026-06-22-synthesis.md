# Intelligence Synthesis — 2026-06-22

**Date**: 2026-06-22
**Classification**: Internal analysis

Cross-company analysis across all tracked Physical AI players. Identifies coverage patterns, partnership dynamics, ecosystem trends, and strategic implications for Red Hat.


---

## Companies Analyzed

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [NVIDIA](../companies/nvidia.md) | Big Tech (silicon + full stack) | 2026-06-22 | Mixed — complement on infra, conflict on inference/scheduling |
| [Intrinsic (Google)](../companies/intrinsic.md) | Big Tech (industrial platform) | 2026-06-22 | Complement on datacenter; IntrinsicOS displacement target at edge |
| [Google DeepMind](../companies/google-deepmind.md) | Big Tech (research + models) | 2026-06-22 | Pure complement — no infrastructure conflict |

---

## Coverage Heat Map

Which platform blocks are covered by each vendor, and where are the gaps?

<table>
<tr>
  <th>Block</th>
  <th>NVIDIA</th>
  <th>Intrinsic</th>
  <th>DeepMind</th>
  <th>Coverage</th>
</tr>

<!-- Training & Evaluation -->

<tr>
  <td><b>Train Workloads</b></td>
  <td>🔴 NeMo Customizer<br>🟢 GR00T N1, Cosmos</td>
  <td>🟡 Gemini Robotics (cloud API)</td>
  <td>🟢 Gemini Robotics</td>
  <td><b>3/3</b></td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>🟢 Isaac Sim, Newton</td>
  <td>🟢 Gazebo</td>
  <td>🟢 MuJoCo, Newton</td>
  <td><b>3/3</b></td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>🔴 NeMo Evaluator<br>🟢 Isaac Lab-Arena</td>
  <td>🟡 BOP benchmark (6D pose only)</td>
  <td>🟡 MuJoCo benchmarks (locomotion only)</td>
  <td><b>3/3</b> (all partial except NVIDIA)</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>🟢 Cosmos-Curate, MimicGen</td>
  <td>🟡 IPD (niche: 6DoF pose)</td>
  <td>🟢 Open X-Embodiment</td>
  <td><b>3/3</b></td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td>🔴 KAI Scheduler</td>
  <td>🟡 Google Cloud (cloud-only)</td>
  <td>🟡 Google Cloud (TPU, cloud-only)</td>
  <td><b>3/3</b> (NVIDIA on-prem; Google cloud-only)</td>
</tr>

<!-- AI Model & Data Lifecycle -->

<tr>
  <td><b>Model Registry</b></td>
  <td>🟡 NGC Catalog</td>
  <td>🟡 Vertex AI Model Registry</td>
  <td>⬜</td>
  <td><b>2/3</b></td>
</tr>

<tr>
  <td><b>Model Pipelines</b></td>
  <td>🟢 OSMO</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>1/3</b> — NVIDIA only</td>
</tr>

<tr>
  <td><b>CI/CD &amp; GitOps</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>0/3</b> — ❗ universal gap</td>
</tr>

<tr>
  <td><b>Experiment Tracking</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>0/3</b> — ❗ universal gap</td>
</tr>

<tr>
  <td><b>Model Monitoring</b></td>
  <td>🟢 DCGM, NeMo Guardrails</td>
  <td>🟡 Google Cloud AI safety</td>
  <td>⬜</td>
  <td><b>2/3</b></td>
</tr>

<!-- Agentic -->

<tr>
  <td><b>Agentic</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡 Gemini Robotics-ER 1.6</td>
  <td><b>1/3</b> — emerging</td>
</tr>

<!-- Model Serving -->

<tr>
  <td><b>MaaS</b></td>
  <td>🟢 NIM</td>
  <td>🟢 Gemini API, Vertex AI</td>
  <td>🟢 Gemini API, Vertex AI</td>
  <td><b>3/3</b></td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td>🔴 NIM (vLLM + packaging)</td>
  <td>🟡 Vertex AI Prediction (cloud)<br>🟢 Gemini On-Device (edge)</td>
  <td>🟡 Vertex AI Prediction (cloud)<br>🟢 Gemini On-Device (edge)</td>
  <td><b>3/3</b></td>
</tr>

<tr>
  <td><b>llm-d</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>0/3</b> — ❗ universal gap</td>
</tr>

<tr>
  <td><b>KServe</b></td>
  <td>🔴 NIM Operator</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>1/3</b></td>
</tr>

<!-- Application Libraries -->

<tr>
  <td><b>App Libs (Math/AI)</b></td>
  <td>🟣 CUDA, NCCL, cuDNN</td>
  <td>🟢 JAX, TensorFlow</td>
  <td>🟢 JAX, TensorFlow</td>
  <td><b>3/3</b></td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td>🟢 DeepStream SDK</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>1/3</b> — NVIDIA only</td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td>🟢 Isaac ROS (edge)</td>
  <td>🟢 ROS 2, Flowstate, IVM</td>
  <td>⬜</td>
  <td><b>2/3</b></td>
</tr>

<!-- Platform -->

<tr>
  <td><b>Application Runtime</b></td>
  <td>⬜</td>
  <td>🟡 GKE (cloud)<br>🟢 IntrinsicOS (edge)</td>
  <td>⬜</td>
  <td><b>1/3</b> — Intrinsic only</td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td>🟢 GPU Operator, JetPack</td>
  <td>🟡 Cloud TPU drivers</td>
  <td>⬜</td>
  <td><b>2/3</b></td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td>🟢 L4T (edge)</td>
  <td>🟢 IntrinsicOS (edge)</td>
  <td>⬜</td>
  <td><b>2/3</b> (both edge-only)</td>
</tr>
</table>

See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### Coverage Patterns

**Crowded blocks** (3/3 coverage — competition or overlap):

- Train Workloads, Simulation Engine, MaaS, Inference Server, App Libs (Math/AI), Data — every tracked vendor plays here. Competition is on model quality and ecosystem gravity, not presence.

**NVIDIA-only blocks** (1/3 — potential partnership or build opportunities):

- **Model Pipelines** (OSMO) — genuine platform gap. Neither Google entity has an equivalent.
- **App Libs (Media)** (DeepStream) — GPU-accelerated media processing is NVIDIA-unique.
- **KServe** (NIM Operator) — NVIDIA is the only vendor with K8s-native model routing, but it competes with KServe.

**Universal gaps** (0/3 — Red Hat owns these by default):

- **CI/CD & GitOps** — no vendor addresses this for Physical AI workflows.
- **Experiment Tracking** — no vendor ships a solution (all rely on W&B, MLflow, or internal tools).
- **llm-d** — distributed inference routing is unaddressed by any tracked vendor.

---

## Partnership Network

### Shared Partners

| Partner | NVIDIA | Intrinsic | DeepMind | Signal |
| --- | --- | --- | --- | --- |
| **FANUC** (1.1M robots) | ✅ Omniverse + Isaac | ✅ Flagship (Gemini + Flowstate) | via Intrinsic | Hedging — FANUC uses both stacks |
| **KUKA** (400K+ robots) | ✅ Omniverse + Isaac | ✅ Flowstate hardware partner | — | Hedging — dual-vendor |
| **Universal Robots** (75K+/yr) | ✅ (via HuggingFace/LeRobot) | ✅ Flowstate hardware partner | — | UR accesses NVIDIA indirectly |
| **Boston Dynamics** | ✅ Cosmos + Isaac Sim | — | ✅ Gemini for Atlas | Humanoid dual-source |
| **Foxconn** (230 campuses) | ✅ Digital twin + AI factory | ✅ JV for factory automation | — | Highest-stakes validation for both |
| **Siemens** | ✅ Omniverse + Xcelerator | ✅ Innovation partner | — | Industrial automation convergence |

### Exclusive Partners

| Partner | Exclusive to | Signal |
| --- | --- | --- |
| **ABB** (500K+ robots) | NVIDIA (+ Skild AI) | ABB is NOT an Intrinsic partner — significant exclusion |
| **YASKAWA** (600K+ robots) | NVIDIA | No Google relationship disclosed |
| **Figure AI, 1X, Agility** | NVIDIA | Humanoid wave partners, all on NVIDIA infra |
| **Agile Robots** (20K+ deployed) | DeepMind | Gemini Robotics fine-tuning; series production 2026 |
| **Apptronik** (Apollo) | DeepMind | Gemini for humanoid control |
| **Trinity Robotics** | Intrinsic | CNC machine tending on Flowstate |

### Partnership Network Dynamics

1. **Industrial OEMs hedge**: FANUC, KUKA, and Foxconn work with both NVIDIA and Intrinsic. This is rational — NVIDIA provides simulation and edge inference, Intrinsic provides the application platform. The stacks are complementary, not substitutive.

2. **Humanoid split**: NVIDIA dominates the humanoid robot wave (Figure, 1X, Agility, Boston Dynamics). DeepMind has selective humanoid partnerships (Agile Robots, Apptronik, Boston Dynamics). Intrinsic has zero humanoid partners — its thesis is industrial arms, not humanoids.

3. **ABB exclusion is significant**: ABB's 500K+ installed base chose NVIDIA + Skild AI over Google/Intrinsic. This is the largest industrial OEM absence from Intrinsic's partner roster.

4. **NVIDIA-Intrinsic are complementary, not competitive**: Their GTC 2025 joint integration (Isaac grasping + Omniverse) confirms they see each other as allies, not rivals. NVIDIA provides infra + simulation, Intrinsic provides the developer platform + application IDE.

---

## Ecosystem Dynamics

### Complementary Relationships

| Pair | Why Complementary | Tension Points |
| --- | --- | --- |
| **NVIDIA ↔ DeepMind** | NVIDIA provides GPU infra + edge HW; DeepMind provides VLA models + MuJoCo physics. Newton (LF) is a joint project | Gemini Robotics (proprietary) vs GR00T N1 (open-weight) — competing model strategies |
| **NVIDIA ↔ Intrinsic** | NVIDIA provides simulation + edge HW; Intrinsic provides application IDE + ROS ecosystem | Simulation overlap (Isaac Sim vs Gazebo); perception overlap (Isaac Perceptor vs IVM) |
| **Intrinsic ↔ DeepMind** | Internal Google division of labor: Intrinsic = platform, DeepMind = intelligence | Joint publications (RoboBallet). Risk: Google could merge/restructure at any time |

### Competitive Relationships

| Pair | Dimension | Details |
| --- | --- | --- |
| **NVIDIA vs Google (combined)** | Foundation models | GR00T N1 (open-weight, assembled from community) vs Gemini Robotics (proprietary, most capable). Different strategies: NVIDIA bets on open ecosystem + hardware gravity; Google bets on model superiority |
| **NVIDIA vs Google (combined)** | Simulation | Isaac Sim (GPU-locked, photorealistic RTX) vs Gazebo (CPU-portable, open, lower fidelity). Newton is shared infrastructure beneath both |
| **NVIDIA vs Google (combined)** | Edge | Jetson + L4T (full SoC + Ubuntu OS) vs Gemini On-Device + IntrinsicOS (software-only on partner IPCs). Hardware vs software approaches |

### Alliance Formation

- **Newton (Linux Foundation)**: NVIDIA + DeepMind + Disney Research co-founded. First cross-vendor physics engine governance. Signals recognition that physics simulation is pre-competitive infrastructure.
- **OSRA**: Intrinsic + NVIDIA + Qualcomm + community members govern ROS 2. Joint Physical AI SIG. Despite competition, both NVIDIA and Google invest in ROS 2 as shared middleware.
- **HuggingFace integration**: NVIDIA's GR00T + Isaac integrated into LeRobot; HuggingFace Physical AI Dataset has 15M+ downloads. Creates a neutral distribution channel.

---

## Key Developments Since Profile Creation

Recent signals (June 2026, post-profile creation):

1. **NVIDIA Cosmos 3** (CVPR 2026): Full omnimodel unifying vision reasoning, world and action generation. Initialized from Qwen3-VL. Represents convergence of world models + VLA into a single architecture.

2. **NVIDIA GR00T N2 preview** (GTC 2026): Based on DreamZero research. Claims 2× success rate on unfamiliar tasks vs leading VLAs. If validated, narrows the Gemini Robotics capability gap.

3. **Intrinsic "Intelligence Cell"** (Automate 2026): Reference design for modular AI workcells — standardized robot cell with IntrinsicOS, pre-integrated AI capabilities. Aims to lower adoption barrier for small/medium manufacturers.

4. **NVIDIA Doosan partnership** (June 2026): Doosan Robotics integrating Isaac Sim, Isaac Lab, Cosmos, Newton, and Jetson Thor into its Agentic Robot OS. Full-stack adoption.

5. **NVIDIA LG AI Factory** (June 2026): Joint AI factory for robotics, autonomous driving, and data center. Expands NVIDIA's manufacturing partnerships beyond traditional robot OEMs.

---

## Trend Signals

### 1. Open-Weight VLAs Parasitically Fork Community VLMs

Every major open-weight VLA is architecturally forked from a community VLM — but the relationship is deeper and more one-directional than "built on top of":

| VLA | Community VLM Backbone | How It's Used |
| --- | --- | --- |
| **GR00T N1.7** (NVIDIA) | Qwen3-VL (Alibaba) via Cosmos-Reason2 | VLM backbone; DiT action expert cross-attends to internal latent representations. End-to-end fine-tuning diverges weights from upstream |
| **Cosmos 3** (NVIDIA) | Qwen3-VL (Alibaba) | Entire weight set duplicated into two towers (reasoning + generation). A 32B Qwen3-VL becomes a 64B Cosmos3-Super. Permanent architectural fork |
| **π₀** (Physical Intelligence) | PaLI-Gemma / SigLIP (Google) + Gemma (Google) | Action expert shares attention with VLM internals via custom mask. Separate weight sets, coupled through shared attention |
| **OpenVLA** (Stanford/Berkeley) | Llama 2 (Meta) + DINOv2 (Meta) | Fuses intermediate vision features with language backbone |

These are not API consumers or downstream users — they structurally fork the internal representations of community models, train divergent weights, and produce derivatives with no merge path back to the original. Different VLAs extract features from different internal layers, making the coupling tight and version-specific.

**Value flow is one-directional.** NVIDIA gets massive value from Alibaba's investment in Qwen3-VL (training data, compute, engineering) across two flagship products (GR00T and Cosmos). The improvements NVIDIA makes — action heads, robot training data, fine-tuning recipes — don't flow back to improve Qwen3-VL. Alibaba effectively subsidizes NVIDIA's Physical AI stack. The same dynamic applies to Google's SigLIP/Gemma being forked by Physical Intelligence.

**This explains Google's strategy.** Google can see this freeloading dynamic from both sides — their models (SigLIP, Gemma) get forked by competitors, while DeepMind's Gemini Robotics is kept proprietary and API-only. Keeping the best VLA closed is a rational response to prevent parasitic forking.

**Dependency concentration is a risk.** The open-weight VLA ecosystem depends on a small number of community VLMs maintained by actors with different incentives. If Alibaba changes Qwen's license, deprioritizes open releases, or faces geopolitical restrictions, NVIDIA's Physical AI model stack is disrupted. This concentration risk is underappreciated because the dependency is hidden inside architectural forks rather than visible as an API call or import.

### 2. Physics Simulation Is Going Pre-Competitive

Newton (Linux Foundation) is the clearest signal. NVIDIA and DeepMind — direct competitors on foundation models — co-steward a shared physics engine. Physics simulation is becoming infrastructure, not differentiation. The competitive frontier has moved up-stack to: (a) rendering quality (RTX vs CPU), (b) synthetic data generation, (c) sim-to-real transfer methods.

### 3. The "Android for Robotics" Race Is Real

Intrinsic's Flowstate + IntrinsicOS is the most explicit play for a horizontal robotics platform. But NVIDIA's full-stack (Isaac + Jetson + GR00T) functions as a de facto platform even without an IDE. The question isn't whether a platform will emerge — it's whether it will be a software platform (Intrinsic model: application IDE over hardware-agnostic runtime) or a hardware-gravity platform (NVIDIA model: best tools require our silicon).

### 4. Edge Deployment Is the Next Battleground

Three competing edge strategies:

| Vendor | Edge Strategy | OS | Hardware |
| --- | --- | --- | --- |
| NVIDIA | Jetson SoCs + L4T + TensorRT | Ubuntu (L4T) | Proprietary (Orin, Thor) |
| Intrinsic | IntrinsicOS on partner IPCs | Custom Linux + K8s | Hardware-agnostic |
| DeepMind | Gemini On-Device (<10ms) | Partner-dependent | Partner-dependent |

NVIDIA owns the edge hardware. Intrinsic owns the edge application runtime. DeepMind owns the edge model. Each needs the others — or a neutral platform partner.

### 5. Industrial OEMs Are Multi-Sourcing

FANUC, KUKA, and Foxconn partner with both NVIDIA and Google. This is not hedging — it's rational architecture. They use NVIDIA for simulation + edge inference and Intrinsic for the application layer. The implication for Red Hat: a platform that works with both stacks (not either/or) is more valuable than picking sides.

---

## Strategic Implications for Red Hat

### 1. Red Hat Owns the Uncovered Middle Layer

No tracked vendor provides: container platform, server OS, fleet management, CI/CD, GitOps, experiment tracking, distributed inference routing (llm-d), or K8s-native model registry. These are all Red Hat strengths. The coverage heat map confirms that Red Hat's platform positioning is **structurally complementary** — not just to one vendor, but to all three.

**Action**: Position OpenShift + RHEL as the neutral substrate for Physical AI, compatible with NVIDIA, Google, and any future entrant. The multi-vendor hedge that OEMs already practice at the application layer should extend down to the platform.

### 2. Three Displacement Targets, Different Urgency

| Target | Product | Red Hat Alternative | Urgency |
| --- | --- | --- | --- |
| L4T (NVIDIA) | Ubuntu-based edge OS for Jetson | RHEL Device Edge on Jetson Thor | High — Jetson Thor launches 2026; first-mover on RHEL support matters |
| IntrinsicOS (Google) | Custom Linux + K8s on IPCs | RHEL Device Edge + MicroShift | Medium — IntrinsicOS is beta; Flowstate adoption still early (26 GitHub stars on SDK) |
| GKE (Google Cloud) | Cloud K8s for training | OpenShift on any cloud | Low — Google's cloud training is internal; enterprises who want on-prem already use OpenShift |

### 3. OSMO Fills a Real Platform Gap

NVIDIA's OSMO (sim→train→eval→deploy pipeline orchestration) is the only tracked solution for Physical AI model pipelines. No Google equivalent exists. Red Hat has three options:

- **Integrate**: Support OSMO as a workload on OpenShift (requires NVIDIA partnership alignment)
- **Build**: Assemble from KubeFlow Pipelines + Argo Workflows + custom gating (significant engineering)
- **Partner**: Find or co-develop an open-source alternative (possibly through Newton/LF ecosystem)

OSMO is Apache 2.0 but custom-engineered (not built on standard workflow engines). Its OpenShift support is undocumented.

### 4. vLLM Convergence Is Strategic Validation

NIM 2.0 uses vLLM as its sole LLM/VLM inference backend. This validates Red Hat's vLLM investment. The remaining NIM differentiation — model profiles, enterprise packaging, security scanning — is operational, not architectural. Red Hat can match or exceed this through vLLM-Omni + OpenShift integration.

Google's inference is entirely proprietary (Vertex AI Prediction, Gemini On-Device) with no vLLM dependency. This means vLLM's strategic importance is as the NVIDIA-compatible open alternative, not a cross-vendor standard.

### 5. ROS 2 Governance Needs Red Hat Engagement

Google/Intrinsic employs most ROS 2 core maintainers. OSRA provides multi-stakeholder governance, but engineering capacity is Google-concentrated. If Google deprioritizes Intrinsic (as it has with prior robotics bets), ROS 2 development capacity could collapse.

Red Hat should:

- Join OSRA or contribute to governance (NVIDIA and Qualcomm already participate)
- Invest in ROS 2 Jazzy packages for RHEL
- Test ROS 2 nodes in OpenShift containers
- Position RHEL as the enterprise-grade ROS 2 target (alternative to Ubuntu, which dominates today)

### 6. Open-Weight VLA Ecosystem Has a Hidden Supply Chain Risk

The open-weight VLA ecosystem depends on community VLMs (primarily Qwen3-VL from Alibaba) that are parasitically forked rather than collaboratively built (see Trend Signal #1). This creates a supply chain risk analogous to a single-source component:

| VLM Backbone | Used By | Maintainer | Risk Vector |
| --- | --- | --- | --- |
| Qwen3-VL | GR00T N1.7, Cosmos 3 | Alibaba | License change, geopolitical restriction, deprioritization |
| PaLI-Gemma (SigLIP + Gemma) | π₀ | Google | Could restrict future releases or reserve robotics-specific versions for Intrinsic |
| Llama 2 + DINOv2 | OpenVLA | Meta | Already more restrictive than Apache 2.0 |

Red Hat should track this dependency chain the same way it tracks upstream kernel or library dependencies. If a backbone VLM becomes unavailable or re-licensed, every VLA built on it needs re-architecture and retraining — not just a version bump.

**Red Hat's hedge**: Ensure open VLAs (GR00T N1, LeRobot, OpenPI) run well on OpenShift + vLLM-Omni regardless of which frontier model leads. The platform should be model-agnostic. Additionally, monitor Qwen licensing and Alibaba's open-weight strategy as a leading indicator for the health of the open Physical AI model supply chain.

### 7. Monitor the Gemini Robotics vs GR00T Capability Race

Gemini Robotics is currently the most capable VLA. GR00T N2 (DreamZero-based) claims 2× improvement. If GR00T N2 closes the gap, the open-weight ecosystem wins — open VLAs on any platform, reducing Google Cloud pull. If Gemini Robotics maintains its lead, Google Cloud lock-in intensifies.

### 8. The "Intelligence Cell" Pattern May Define the Edge Form Factor

Intrinsic's Automate 2026 reference design — a modular, standardized AI workcell — could become the deployment unit for Physical AI in manufacturing. If this pattern gains traction, the edge platform question becomes: what OS and container runtime powers the intelligence cell?

- IntrinsicOS (Google-controlled, proprietary) is the default
- RHEL Device Edge + MicroShift is the enterprise alternative
- Jetson Thor + L4T is the hardware-accelerated option

Red Hat should prototype a "RHEL Intelligence Cell" reference architecture — same concept, open platform.

---

## Open Questions

1. **Will Intrinsic's "intelligence cell" gain OEM adoption?** FANUC and Foxconn partnerships suggest traction, but 26 GitHub stars on the SDK indicate limited external developer uptake. The Foxconn JV results in 2026 will be the definitive signal.

2. **Does Newton (LF) evolve into the universal physics engine?** Currently CUDA-only with ~90% NVIDIA commits. For Newton to become truly vendor-neutral, it needs ROCm support and DeepMind/Disney engineering investment. Monitor TSC governance decisions.

3. **Will Google restructure Intrinsic again?** The Feb 2026 fold into Google is the third organizational change (X → Other Bet → Google). Google's robotics abandonment track record (Everyday Robots, Boston Dynamics sale, Schaft) is well-documented. The Foxconn JV and FANUC partnership provide counter-evidence.

4. **How will the KAI Scheduler vs Kueue contest resolve?** KAI is CNCF Sandbox with NVIDIA backing; Kueue is CNCF with broader community. If KAI becomes the de facto GPU scheduler, Red Hat's Kueue investment is at risk. KAI's OpenShift API dependency suggests NVIDIA sees Red Hat as the target platform.

---

## Stale Reports

No stale reports — all three company profiles were created or updated on 2026-06-22.

---

## Next Companies to Profile

Priority candidates for expanding coverage (not yet profiled):

| Company | Type | Why |
| --- | --- | --- |
| **Meta (FAIR)** | Big Tech | Llama 4, Habitat-Lab, OK-Robot research. Potential open-weight robotics VLA |
| **Hugging Face** | OSS Platform | LeRobot, Physical AI Dataset (15M+ downloads), model distribution hub |
| **Skild AI** | Startup | ABB partnership, frontier foundation models for robots |
| **Qualcomm** | Big Tech | OSRA member, edge SoCs (RB series), ROS 2 investment, power-efficient alternative to Jetson |
| **Siemens** | Industrial | Industrial AI OS partnership with NVIDIA, Xcelerator platform, largest automation installed base |
