# Intelligence Synthesis — 2026-06-23

**Date**: 2026-06-23
**Classification**: Internal analysis
**Previous synthesis**: [2026-06-22](2026-06-22-synthesis.md) (3 companies)

Cross-company analysis across all 9 tracked Physical AI players. Identifies coverage patterns, partnership dynamics, ecosystem trends, and strategic implications for Red Hat.

---

## Companies Analyzed

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [NVIDIA](../companies/nvidia.md) | Big Tech (silicon + full stack) | 2026-06-22 | Mixed — complement on infra, conflict on inference/scheduling |
| [Intrinsic (Google)](../companies/intrinsic.md) | Big Tech (industrial platform) | 2026-06-22 | Complement on datacenter; IntrinsicOS displacement target at edge |
| [Google DeepMind](../companies/google-deepmind.md) | Big Tech (research + models) | 2026-06-22 | Pure complement — no infrastructure conflict |
| [AMD](../companies/amd.md) | Big Tech (silicon + open ecosystem) | 2026-06-23 | Strong complement — Red Hat AI 3 certified on Instinct; joint vLLM |
| [Intel](../companies/intel.md) | Big Tech (silicon + edge) | 2026-06-23 | Complement — 25+ year partnership; Gaudi on OpenShift AI |
| [Qualcomm](../companies/qualcomm.md) | Big Tech (edge silicon + connectivity) | 2026-06-23 | Complement — no platform overlap; edge OS partner opportunity |
| [Physical Intelligence](../companies/physical-intelligence.md) | Startup (VLA models) | 2026-06-23 | Complement — pure model provider; OpenPI protocol via vLLM-Omni |
| [Skild AI](../companies/skild-ai.md) | Startup (VLA models + fleet) | 2026-06-23 | Potential customer — needs serving infra and fleet management |
| [Figure AI](../companies/figure-ai.md) | Startup (humanoid hardware + AI) | 2026-06-23 | Potential customer — needs edge OS and fleet management at scale |

---

## Coverage Heat Map

<table>
<tr>
  <th>Block</th>
  <th>NVIDIA</th>
  <th>Intrinsic</th>
  <th>DeepMind</th>
  <th>AMD</th>
  <th>Intel</th>
  <th>Qualcomm</th>
  <th>PI</th>
  <th>Skild</th>
  <th>Figure</th>
  <th>Count</th>
</tr>

<!-- Training & Evaluation -->

<tr>
  <td><b>Train Workloads</b></td>
  <td>🔴🟢</td>
  <td>🟡</td>
  <td>🟢</td>
  <td>🟡</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>🟢</td>
  <td>🟢</td>
  <td>🟢</td>
  <td><b>8/9</b></td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>🟢</td>
  <td>🟢</td>
  <td>🟢</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>🟡</td>
  <td><b>6/9</b></td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>🔴🟢</td>
  <td>🟡</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>🟡</td>
  <td>🟡</td>
  <td><b>6/9</b></td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>🟢</td>
  <td>🟡</td>
  <td>🟢</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>🟢</td>
  <td>🟢</td>
  <td><b>7/9</b></td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td>🔴</td>
  <td>🟡</td>
  <td>🟡</td>
  <td>🟣</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td><b>6/9</b></td>
</tr>

<!-- AI Model & Data Lifecycle -->

<tr>
  <td><b>Model Registry</b></td>
  <td>🟡</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>3/9</b></td>
</tr>

<tr>
  <td><b>Model Pipelines</b></td>
  <td>🟢</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>2/9</b></td>
</tr>

<tr>
  <td><b>CI/CD &amp; GitOps</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>0/9</b> ❗</td>
</tr>

<tr>
  <td><b>Experiment Tracking</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>1/9</b></td>
</tr>

<tr>
  <td><b>Model Monitoring</b></td>
  <td>🟢</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>3/9</b></td>
</tr>

<!-- Agentic Framework -->

<tr>
  <td><b>Agentic Framework</b></td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>1/9</b></td>
</tr>

<!-- Models & Policies -->

<tr>
  <td><b>Models & Policies</b></td>
  <td>🟢</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>🟢</td>
  <td>🟢</td>
  <td><b>5/9</b></td>
</tr>

<!-- Model Serving -->

<tr>
  <td><b>MaaS</b></td>
  <td>🟢</td>
  <td>🟢</td>
  <td>🟢</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>🟢</td>
  <td>⬜</td>
  <td><b>6/9</b></td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td>🔴</td>
  <td>🟡🟢</td>
  <td>🟡🟢</td>
  <td>🔵</td>
  <td>🟡🟢</td>
  <td>🟡🟢</td>
  <td>⬜</td>
  <td>🟢</td>
  <td>🟢</td>
  <td><b>8/9</b></td>
</tr>

<tr>
  <td><b>llm-d</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>0/9</b> ❗</td>
</tr>

<tr>
  <td><b>KServe</b></td>
  <td>🔴</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>1/9</b></td>
</tr>

<!-- Application Libraries -->

<tr>
  <td><b>App Libs (Math/AI)</b></td>
  <td>🟣</td>
  <td>🟢</td>
  <td>🟢</td>
  <td>🟣</td>
  <td>🔵</td>
  <td>🟣</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟣</td>
  <td><b>7/9</b></td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td>🟢</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>🔵</td>
  <td>🟣</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟢</td>
  <td><b>5/9</b></td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td>🟢</td>
  <td>🟢</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>🟢</td>
  <td>🟢</td>
  <td>⬜</td>
  <td>🟢</td>
  <td>🟢</td>
  <td><b>7/9</b></td>
</tr>

<!-- Platform -->

<tr>
  <td><b>Application Runtime</b></td>
  <td>⬜</td>
  <td>🟡🟢</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td><b>1/9</b></td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td>🟢🟣</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>🟢🟣</td>
  <td>🟢🟣</td>
  <td>🟣</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟣</td>
  <td><b>6/9</b></td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td>🟢</td>
  <td>🟢</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟢</td>
  <td><b>4/9</b></td>
</tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### Coverage Patterns

**Universal gaps** (0/9 — Red Hat owns by default):

- **CI/CD & GitOps** — zero vendors address this for Physical AI workflows
- **llm-d** — distributed inference routing is unaddressed

**Near-universal gaps** (1-2/9 — Red Hat leadership opportunity):

- **Application Runtime** — only Intrinsic (IntrinsicOS at edge, GKE cloud). 8/9 vendors have a structural dependency on platform partners
- **Experiment Tracking** — only Intel (Tiber AI Studio). Everyone else uses W&B or MLflow
- **Model Pipelines** — NVIDIA (OSMO) and Intel (Tiber). A genuine platform gap
- **KServe** — only NVIDIA (NIM Operator, which competes with KServe)

**Crowded blocks** (7+/9 — competition on quality, not presence):

- **Train Workloads** (8/9), **Inference Server** (8/9), **App Libs Math/AI** (7/9), **App Libs Robotics** (7/9), **Data** (7/9)

**New pattern vs previous synthesis**: With 9 companies vs 3, the "middle layer" gap is even more dramatic. 8 of 9 vendors have no application runtime, no OS (or edge-only), and no CI/CD. The platform layer is structurally empty across the entire ecosystem.

---

## Key Developments Since Last Synthesis

Since the 3-company synthesis of 2026-06-22:

1. **OpenPI wire protocol emerging as de facto VLA serving standard**: vLLM-Omni v0.22.0 (June 2026) clean-room reimplemented OpenPI serving. GR00T-N1.7, DreamZero, AgiBot GO-1-Air, and LingBot-VA ports in-flight — all using OpenPI-compatible endpoints. But Physical Intelligence controls the protocol unilaterally: no spec, no versioning, no governance body. See [PI deep-dive — protocol adoption](../companies/physical-intelligence-deep-dive.md).

2. **LeRobot v2/v3 converged as universal data format**: OpenPI consumes it, GR00T adopted it (with `modality.json` extension), NVIDIA Cosmos uses it. Data format is settled; serving API is not.

3. **Skild AI is the commercialization benchmark**: $30M revenue (confirmed at Series C) while keeping models fully proprietary. Physical Intelligence remains at $0 revenue. The open-weight strategy builds ecosystem but doesn't build revenue.

4. **Three-way edge silicon competition**: NVIDIA Jetson Thor vs Intel Core Ultra 3 vs Qualcomm Dragonwing IQ10. All three ship with Ubuntu or proprietary Linux — RHEL Device Edge has a displacement opportunity across the board.

5. **NVentures hedging the VLA layer**: NVIDIA's venture arm invested in both Physical Intelligence (Series B) and Skild AI (Series C). Combined with GR00T N1.7, NVIDIA has positions across three competing VLA strategies. Signals that the VLA model layer may commoditize.

6. **AMD confirmed as cleanest partner**: Zero product conflicts with Red Hat across the entire platform. Joint vLLM investment (AMD is top-3 contributor). Red Hat AI 3 certified on Instinct. No competing edge OS, no competing inference server, no competing scheduler.

---

## Partnership Network

### Investor Overlap

| Investor | Companies | Signal |
| --- | --- | --- |
| **NVIDIA NVentures** | PI (Series B), Skild (Series A + C), Figure (Series C) | Hedging across VLA model layer + humanoid hardware |
| **Jeff Bezos** | PI, Figure | Personal bets on both model-only and vertically integrated approaches |
| **Intel Capital** | Figure (Series C) | Edge compute customer opportunity |
| **Qualcomm Ventures** | Figure (Series C) | Edge compute alternative to NVIDIA for humanoids |
| **SoftBank** | Skild (Series C lead) + acquiring ABB robotics | Could unify Skild Brain + ABB installed base — a vertical integration play |

### Hardware OEM Partnerships

| OEM | NVIDIA | Intrinsic | Skild | Signal |
| --- | --- | --- | --- | --- |
| **FANUC** (1.1M robots) | ✅ Omniverse + Isaac | ✅ Flagship (Gemini + Flowstate) | — | Dual-sourcing |
| **KUKA** (400K+ robots) | ✅ Omniverse + Isaac | ✅ Flowstate | — | Dual-sourcing |
| **ABB** (500K+ robots) | ✅ Omniverse + Isaac | ❌ NOT a partner | ✅ Brain integration | NVIDIA + Skild, not Google |
| **Universal Robots** (75K+/yr) | ✅ (via LeRobot) | ✅ Flowstate | ✅ Brain integration | Triple-sourcing |
| **Foxconn** (230 campuses) | ✅ Digital twin + AI factory | ✅ JV for factory automation | ✅ Brain on Blackwell lines | Triple-sourcing — highest-stakes validation |
| **YASKAWA** (600K+ robots) | ✅ Omniverse + Isaac | — | — | NVIDIA exclusive |
| **BMW** | — | — | — | Figure (humanoid) + Qualcomm (ADAS) |

### Humanoid Robot Partnerships

| Company | NVIDIA | DeepMind | Other |
| --- | --- | --- | --- |
| **Figure AI** | ✅ Cosmos, investor | — | Qualcomm, Intel (investors) |
| **Boston Dynamics** | ✅ Cosmos + Isaac | ✅ Gemini for Atlas | — |
| **Agility (Digit)** | ✅ Cosmos + Isaac | — | — |
| **1X (NEO)** | ✅ Cosmos + Isaac Lab | — | — |
| **Agile Robots** | — | ✅ Gemini fine-tuning (exclusive) | — |
| **Apptronik** | — | ✅ Gemini (exclusive) | — |
| **NEURA Robotics** | — | — | Qualcomm (strategic collab) |

### Partnership Dynamics

1. **Industrial OEMs are triple-sourcing**: Foxconn works with NVIDIA, Intrinsic, AND Skild. Universal Robots works with all three. This is not hedging — it's rational architecture: NVIDIA for simulation + edge inference, Intrinsic for the application platform, Skild for the model layer. A platform that works with all three stacks is more valuable than picking sides.

2. **Humanoid partnerships are NVIDIA-dominated**: 4 of 6 tracked humanoid companies partner with NVIDIA. DeepMind has 2 exclusive relationships (Agile, Apptronik). Intrinsic has zero humanoid partners — its thesis is industrial arms, not humanoids.

3. **SoftBank-ABB-Skild triangle is forming**: SoftBank led Skild's $1.4B Series C AND is acquiring ABB's robotics division ($5.38B). If completed, SoftBank could unify Skild Brain + ABB's 500K+ installed base under one umbrella — the first vertically integrated "brain + body" at industrial scale.

4. **AMD is the clean partner, NVIDIA is the complex one**: AMD has zero product conflicts with Red Hat. NVIDIA has 4 (NIM vs vLLM, KAI vs Kueue, NIM Operator vs KServe, NeMo Customizer vs KFTO). This makes AMD the preferred hardware partner for Red Hat's platform story, even though NVIDIA has broader Physical AI coverage.

---

## Ecosystem Dynamics

### Complementary Relationships

| Pair | Why Complementary | Tension Points |
| --- | --- | --- |
| **NVIDIA ↔ DeepMind** | GPU infra + edge HW / VLA models + MuJoCo. Newton (LF) is joint | GR00T vs Gemini Robotics — competing model strategies |
| **NVIDIA ↔ Intrinsic** | Simulation + edge HW / Application IDE + ROS. GTC joint integration | Isaac Sim vs Gazebo, Isaac Perceptor vs IVM |
| **AMD ↔ Red Hat** | Silicon substrate / Platform layer. Joint vLLM. Zero conflict | None identified |
| **Intel ↔ Red Hat** | Edge silicon + OpenVINO / OS + fleet management. 25+ year partnership | Tiber AI Studio overlaps slightly with OpenShift AI MLOps |
| **PI ↔ vLLM-Omni** | VLA model weights / Serving infrastructure via OpenPI protocol | PI controls protocol unilaterally; no governance |

### Competitive Relationships

| Pair | Dimension | Details |
| --- | --- | --- |
| **PI vs Skild** | VLA commercialization | Most direct competitor. PI: open-weight + $0 revenue. Skild: proprietary + $30M revenue. NVentures invested in both |
| **NVIDIA vs Google** | Foundation models | GR00T N1.7 (open-weight, community VLM forks) vs Gemini Robotics (proprietary, most capable) |
| **NVIDIA vs Google** | Simulation | Isaac Sim (GPU-locked, photorealistic) vs Gazebo (hardware-portable, lower fidelity) |
| **NVIDIA vs Intel vs Qualcomm** | Edge silicon | Jetson Thor vs Core Ultra 3 vs IQ10. All target Physical AI robots. Different strengths: GPU power (NVIDIA), single-SoC simplicity (Intel), connectivity (Qualcomm) |
| **NVIDIA L4T vs Ubuntu vs IntrinsicOS** | Edge OS | All three are RHEL Device Edge displacement targets |

### Alliance Formation (new since last synthesis)

- **vLLM-Omni + OpenPI**: vLLM-Omni clean-room reimplemented OpenPI serving. Creates a de facto alliance between Red Hat's inference investment and PI's protocol — without formal agreement or governance
- **Qualcomm + NEURA**: Strategic collaboration for humanoid robotics on Dragonwing — first non-NVIDIA humanoid silicon partnership
- **Intel + Oversonic**: Switching from NVIDIA to Core Ultra 3 for humanoid robots — first confirmed NVIDIA-to-Intel migration in robotics

---

## Trend Signals

### 1. VLA Serving API Fragmentation Is the New Battleground

Three competing wire formats, no formal spec or governance on any:

| API | Wire Format | Owner | Adopters |
| --- | --- | --- | --- |
| **OpenPI** | WebSocket + msgpack | Physical Intelligence | vLLM-Omni, DreamZero, AgiBot GO-1-Air |
| **LeRobot PolicyServer** | gRPC + protobuf | HuggingFace | SmolVLA, GR00T N1.5 (via LeRobot) |
| **Vendor-specific** | Various | NVIDIA, others | GR00T native, NIM |

OpenPI is gaining traction via vLLM-Omni, but PI controls it unilaterally. LeRobot has broader model coverage but a critical unpatched RCE (CVE-2026-25874). Positronic emerged as a community bridge layer. The data format question is settled (LeRobot v2/v3); the serving API is not.

### 2. Open-Weight VLAs Parasitically Fork Community VLMs (unchanged)

Every major open-weight VLA structurally forks a community VLM backbone. Updated table with PI's progression:

| VLA | Community VLM Backbone | Risk |
| --- | --- | --- |
| **GR00T N1.7** | Qwen3-VL (Alibaba) | License change, geopolitical |
| **Cosmos 3** | Qwen3-VL (Alibaba) | Same backbone, 2× exposure |
| **π0 → π0.5** | PaliGemma/SigLIP + Gemma (Google) | Gemma ToU includes revocation clause |
| **π0.7** | Gemma 3-4B (Google) + BAGEL 14B (community) | Gemma ToU + community model stability |
| **OpenVLA** | Llama 2 + DINOv2 (Meta) | Already more restrictive than Apache 2.0 |

### 3. Commercialization Gap Between Open and Proprietary

| Company | Revenue | Model Strategy | Implication |
| --- | --- | --- | --- |
| **Skild AI** | ~$30M | Fully proprietary | Proves VLA business model works |
| **Physical Intelligence** | $0 | Open-weight (code Apache 2.0, weights Gemma ToU) | Ecosystem but no revenue |
| **Figure AI** | Negligible | Fully proprietary (Helix) | Hardware revenue, not model revenue |

Open-weight VLA strategies build community but may not build companies. If PI follows Skild's path toward commercialization, on-prem VLA model deployment becomes Red Hat's opportunity.

### 4. Edge OS Is Ubuntu-Dominated — Displacement Wave Opportunity

| Vendor | Current Edge OS | RHEL Device Edge Fit |
| --- | --- | --- |
| **NVIDIA** | L4T (Ubuntu-based) | High — Jetson Thor launching 2026 |
| **Figure AI** | Ubuntu Linux | High — scaling to 100K+ units |
| **Qualcomm** | Ubuntu (ships with RB/IQ10) | High — no competing OS |
| **Intrinsic** | IntrinsicOS (custom Linux + K8s) | Medium — beta; Flowstate adoption early |
| **Intel** | Partner OS (no own) | High — explicit need for enterprise edge OS |
| **AMD** | No proprietary edge OS | High — zero conflict |

Every Physical AI edge deployment today runs Ubuntu or vendor-specific Linux. Enterprise robotics deployments will need commercially supported, security-hardened, fleet-managed OS — RHEL Device Edge's value proposition.

### 5. Three-Way Edge Silicon Race

| Vendor | SoC | TOPS | Strengths | OS Dependency |
| --- | --- | --- | --- | --- |
| **NVIDIA** | Jetson Thor | 800+ | GPU power, Isaac ROS, full sim stack | L4T (Ubuntu) |
| **Intel** | Core Ultra 3 | 130+ | Single SoC (no discrete GPU), OpenVINO Physical AI | Partner (no own) |
| **Qualcomm** | IQ10 | 700-2000 | Power efficiency, 5G/Wi-Fi on-chip, 12 GMSL2 cameras | Ubuntu (ships default) |

All three need an enterprise OS partner. Red Hat can be the neutral OS across all three silicon vendors — a unique positioning that no other OS vendor currently offers for Physical AI edge.

### 6. Physics Simulation Going Pre-Competitive (confirmed)

Newton (Linux Foundation) — NVIDIA + DeepMind + Disney Research — confirms physics simulation is infrastructure, not differentiation. AMD is investing in Genesis World (multi-backend, including ROCm) as its simulation strategy. The competitive frontier has moved to rendering quality, synthetic data generation, and sim-to-real transfer.

---

## Strategic Implications for Red Hat

### 1. Red Hat Owns the Structural Middle Layer — Now Confirmed at 9x Scale

The 3-company synthesis identified the "uncovered middle layer." With 9 companies, the pattern is even stronger:

| Block | Vendor Coverage | Red Hat Product |
| --- | --- | --- |
| Application Runtime | 1/9 (Intrinsic only) | OpenShift, MicroShift |
| CI/CD & GitOps | 0/9 | Tekton, Argo CD |
| Experiment Tracking | 1/9 (Intel only) | (partner: W&B, MLflow) |
| llm-d | 0/9 | llm-d |
| KServe | 1/9 (NVIDIA, competes) | KServe |
| Model Pipelines | 2/9 | KubeFlow Pipelines |
| OS (server) | 0/9 | RHEL |
| Fleet Management | 0/9 | FlightCtl |

Zero vendors provide a container platform, server OS, or fleet management for Physical AI. Red Hat's platform is structurally complementary to every tracked company.

### 2. AMD Is the Strategic Hardware Partner — Cleanest Alignment in the Ecosystem

| Dimension | AMD | NVIDIA | Intel |
| --- | --- | --- | --- |
| Product conflicts with Red Hat | 0 | 4 (NIM, KAI, NIM Op, NeMo Cust) | 1 (Tiber AI Studio) |
| Joint OSS investment | vLLM (top-3 contributor) | vLLM (via NIM backend) | OpenVINO (separate) |
| Edge OS conflict | None | L4T competes | None |
| Certification | Red Hat AI 3 on Instinct | GPU Operator on OpenShift | Gaudi on OpenShift AI |

AMD's "hardware substrate + open ecosystem" strategy creates zero conflicts. Deepen: ROCm certification for Physical AI workloads, RHEL Device Edge on Ryzen AI Embedded, vLLM-Omni acceleration on Instinct.

### 3. The OpenPI Protocol Requires a Governance Strategy

vLLM-Omni's clean-room reimplementation of OpenPI serving puts Red Hat on the right side of the emerging VLA serving standard. But PI controls the protocol unilaterally. Three options:

- **Wait and monitor**: Let the protocol stabilize organically. Risk: PI makes breaking changes, or the protocol forks
- **Propose formal governance**: Work with vLLM community and HuggingFace to propose an open specification under a neutral body (Linux Foundation, CNCF). Risk: PI declines, fragmenting the ecosystem
- **Fork and own via vLLM-Omni**: If PI doesn't formalize, vLLM-Omni's reimplementation becomes the de facto spec. vLLM-Omni already serves at a different path (`/v1/realtime/robot/openpi`) and supports both native and OpenPI numpy markers. Risk: divergence from PI's reference implementation

The serving API fragmentation (OpenPI vs LeRobot gRPC vs vendor-specific) will eventually need resolution. Red Hat, via vLLM-Omni, is positioned to drive that convergence.

### 4. Edge OS Displacement Is a 6-Vendor Opportunity

Ubuntu or vendor-specific Linux runs on every Physical AI edge deployment today. Red Hat can offer RHEL Device Edge + MicroShift as the enterprise alternative across 6 silicon/robot vendors:

| Target | Current OS | Replacement Urgency |
| --- | --- | --- |
| NVIDIA Jetson Thor | L4T (Ubuntu) | High — Thor launching 2026; first-mover matters |
| Qualcomm IQ10 | Ubuntu | High — GA Sep 2026; no competing OS |
| Intel Core Ultra 3 | Partner-dependent | High — Intel explicitly needs a partner OS |
| Figure AI (Figure 03) | Ubuntu | Medium — scaling to 12K units/yr; fleet management gap emerging |
| AMD (Ryzen AI Embedded) | No own OS | Medium — reference designs need a supported OS |
| Intrinsic (IntrinsicOS) | Custom Linux + K8s | Low — IntrinsicOS beta; Flowstate adoption still early |

### 5. OSMO Remains the Only Pipeline Orchestrator — Gap Persists

Even with 9 companies, NVIDIA's OSMO is the only sim→train→eval→deploy pipeline solution (Intel's Tiber AI Studio is MLOps, not Physical AI pipeline). The gap identified in the 3-company synthesis is confirmed. Options remain: integrate OSMO on OpenShift, build from KubeFlow + Argo, or co-develop through the Newton/LF ecosystem.

### 6. Monitor the SoftBank-ABB-Skild Triangle

SoftBank's simultaneous investment in Skild ($1.4B Series C lead) and acquisition of ABB's robotics division ($5.38B) could create the first integrated "brain + body" at industrial scale. If SoftBank unifies Skild Brain + ABB's 500K+ robot installed base:

- Skild becomes the default intelligence for ABB robots — displacing NVIDIA's current ABB partnership
- The combined entity needs platform infrastructure: serving, fleet management, edge runtime
- Red Hat could be the neutral platform partner — if positioned before the consolidation closes (mid-to-late 2026)

### 7. vLLM Convergence Validated Across Two Hardware Vendors

NIM 2.0 uses vLLM as its sole LLM/VLM backend (NVIDIA). AMD is a top-3 vLLM contributor with AITER/ATOM kernels. Red Hat's vLLM/vLLM-Omni investment is validated by both major GPU vendors. The remaining competitive differentiation — NVIDIA NIM's model profiles and enterprise packaging — is operational, not architectural.

With vLLM-Omni's OpenPI endpoint adding robotics serving capability, the inference server block extends from LLM/VLM to VLA models — a direct Physical AI value proposition running through Red Hat's existing investment.

### 8. ROS 2 Governance Still Needs Red Hat Engagement (unchanged)

Google/Intrinsic employs most ROS 2 core maintainers. With 7/9 tracked vendors using ROS 2 at the edge (NVIDIA, Intrinsic, AMD, Intel, Qualcomm, Skild via Fetch, Figure is the exception with proprietary), ROS 2 is the de facto robotics middleware. Red Hat should join OSRA, invest in ROS 2 Jazzy packages for RHEL, and position RHEL as the enterprise-grade ROS 2 target.

---

## Open Questions

1. **Will the OpenPI protocol get formal governance?** vLLM-Omni's adoption creates pressure for a spec, but PI has no incentive to cede control. Watch for vLLM community proposals or Linux Foundation interest.

2. **Does the SoftBank-ABB acquisition close, and does Skild Brain become ABB's default?** Closing mid-to-late 2026. Would reshape the industrial robotics competitive landscape.

3. **Can RHEL run on Jetson Thor with full accelerator support?** The highest-urgency displacement target. Thor launches 2026. Answer determines whether Red Hat has an NVIDIA edge story.

4. **Will PI ever generate revenue, or does Skild prove the proprietary model wins?** If PI's open-weight approach doesn't produce revenue by 2027, the "open VLA" narrative weakens. If it does, on-prem VLA serving on Red Hat's platform becomes the business model.

5. **Does Newton (LF) get ROCm support?** Currently CUDA-only with ~90% NVIDIA commits. AMD needs Newton on ROCm for its simulation story. Would validate the pre-competitive physics engine thesis.

6. **How will the KAI Scheduler vs Kueue contest resolve?** KAI has CNCF Sandbox status and NVIDIA backing. If KAI becomes the de facto GPU scheduler, Red Hat's Kueue investment is at risk.

7. **Does Intel's Crescent Island inference GPU (H2 2026) change the datacenter dynamics?** If competitive, it gives Red Hat a third GPU vendor option beyond NVIDIA and AMD.

---

## Stale Reports

No stale reports — all 9 company profiles created or updated within the last 48 hours.

---

## Next Companies to Profile

| Company | Type | Why | Priority |
| --- | --- | --- | --- |
| **Meta (FAIR)** | Big Tech | Llama 4, Habitat-Lab, DINOv2/V-JEPA. Potential open-weight robotics VLA. Major VLM backbone supplier (Llama, DINOv2) | High — backbone supply chain risk |
| **HuggingFace** | OSS Platform | LeRobot (data format standard), Physical AI Dataset (15M+ downloads), model distribution hub, SmolVLA | High — ecosystem infrastructure |
| **Siemens** | Industrial | Industrial AI OS partnership with NVIDIA, Xcelerator platform, largest automation installed base | Medium — industrial platform competitor |
| **Alibaba (Tongyi Lab)** | Big Tech | Qwen3-VL is backbone of GR00T N1.7 + Cosmos 3. Qwen-RobotWorld, Qwen-RobotManip | High — backbone supply chain risk |
| **Agile Robots** | Startup | DeepMind exclusive partner, 20K+ deployed systems, $270M+ raised, series production 2026 | Medium — deployment proof point |
