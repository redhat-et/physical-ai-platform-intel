# Physical Intelligence — Competitive Profile

**Date**: 2026-06-23
**Last updated**: 2026-06-23
**Classification**: Internal analysis — not for public repo

See [deep-dive](physical-intelligence-deep-dive.md) for OSS foundations, technical architecture, and research timeline.

---

## At a Glance

Physical Intelligence (π) is a VC-backed startup ($1.1B raised, $5.6B valuation) building **hardware-agnostic foundation models for robot control**. Founded in 2024 by a team from Google DeepMind, Stanford, and UC Berkeley (Karol Hausman, Sergey Levine, Chelsea Finn, Brian Ichter, Lachy Groom, Quan Vuong, Adnan Esmail), the company's thesis is that a single generalist policy — trained on internet-scale vision-language data plus cross-embodiment robot data — can control any robot on any task. PI is a pure model company: no simulation, no hardware, no platform infrastructure. It competes at the VLA (Vision-Language-Action) model layer against NVIDIA GR00T, Google DeepMind RT-X, and Tesla Optimus.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | $1.1B raised (Series B Nov 2025 at $5.6B); ~$1B Series C reportedly in talks |
| **Physical AI thesis** | One generalist policy for all robots; software-only, hardware-agnostic |
| **Platform coverage** | ~5% of blocks — concentrated on VLA models and fine-tuning |
| **Relationship to Red Hat** | Complement — pure model provider with no infrastructure ambitions; potential workload on OpenShift for training/inference |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **π0.7** | 5B-param VLA foundation model (4B VLM + 860M action expert). Compositional generalization: recombines skills across embodiments without task-specific data. Latest in the π0 → π0-FAST → π0.5 → π\*0.6 → π0.7 progression |
| **π\*0.6 (RECAP)** | Self-improving VLA via RL with Experience and Corrections. Three-stage learning (instruct → coach → practice). Demonstrated full-shift autonomy: >90% success on T-shirt folding, box assembly, espresso operation |
| **openpi** | Open-source VLA server + fine-tuning framework (Apache 2.0 code, Gemma ToU weights). WebSocket policy server + client SDK. π0, π0-FAST, π0.5 weights. 12.5K GitHub stars. PyTorch + JAX. LeRobot data format |
| **Fine-tuning API** | Private beta API for robotics companies to fine-tune π0 models on their hardware. Requires 1–20 hours of task-specific data |

---

## Architecture Coverage

<table>
<tr>
  <th rowspan="2">Block</th>
  <th colspan="2">Central Site</th>
  <th colspan="2">Distributed Sites</th>
  <th rowspan="2">Edge</th>
</tr>
<tr>
  <th>Language</th><th>Physical AI</th>
  <th>Language</th><th>Physical AI</th>
</tr>

<!-- === Training & Evaluation === -->

<tr>
  <td><b>Train Workloads</b></td>
  <td>⬜</td>
  <td>🟢 π0.7, openpi<br>
  <small>(VLA fine-tuning pipeline)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>⬜</td>
  <td>🟡 π\*0.6 RECAP<br>
  <small>(self-eval via RL, not standalone)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟡 pi-data-sharing<br>
  <small>(data utilities, not full pipeline)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === AI Model & Data Lifecycle === -->

<tr>
  <td><b>Model Registry</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Pipelines</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>CI/CD &amp; GitOps</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Experiment Tracking</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Monitoring</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Agentic Framework === -->

<tr>
  <td><b>Agentic Framework</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Models & Policies === -->

<tr>
  <td><b>Models & Policies</b></td>
  <td>⬜</td>
  <td>🟡 π0.7<br>
  <small>(VLA foundation model, Gemma ToU weights)</small></td>
  <td>⬜</td>
  <td>🟡 π0.7</td>
  <td>🟡 π0.7</td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td colspan="2">🟡 Fine-tuning API<br>
  <small>(private beta)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>llm-d</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>KServe</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Application Libraries === -->

<tr>
  <td><b>App Libs (Math/AI)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Platform === -->

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **openpi (code)** | PyTorch + JAX; WebSocket server/client; Apache 2.0 |
| **openpi (weights)** | PaliGemma 3B (Google) as VLM backbone; **Gemma Terms of Use** (not Apache 2.0 — includes revocation clause) |
| **π\*0.6** | Not open-sourced; community requests ignored (GitHub issue #789) |
| **π0.7** | Gemma 3-4B backbone (Google) + BAGEL 14B (community) for world model; not open-sourced |
| **Fine-tuning API** | Proprietary; wraps openpi fine-tuning pipeline |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **Weave Robotics** | Laundry/home services (YC S24) | Isaac 0 robot ($7,999 or $450/mo). Deployed in SF Bay Area. π0.6 with Weave pre-training data reduced missed grasps by 42%, interventions by 50% vs. without |
| **Ultra** | Warehouse packaging (YC S24) | OP1 robot ($2,500–3,000/mo). Revenue-generating fleet across US; 96.4% autonomy (single demonstrated shift); scaling toward hundreds of deployments |
| **Dandelion Chocolate** | Food manufacturing | Test site across the street from PI HQ. π\*0.6 assembles 59 boxes. Not a paying customer |
| **NVIDIA** | Investor + ecosystem | NVentures in Series B. PI deployed models at Foxconn on NVIDIA Blackwell lines. Complementary today, competitive on VLA layer |
| **HuggingFace** | OSS ecosystem | openpi uses LeRobot data format; models on HuggingFace Hub |

**Supported robot hardware**: ALOHA (dual-arm bimanual), UR5e (single/dual-arm industrial), Franka/DROID, mobile manipulators (Fibocom), bimanual Trossen — 7 configurations total.

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **NVIDIA GR00T** | Hardware-agnostic (runs on any robot); open-source weights (openpi, 12.5K stars); flow matching for smoother continuous actions; self-improvement via RECAP RL | Simulation (no Isaac Sim equivalent), edge inference runtime, enterprise infrastructure, OEM partnerships at scale |
| **Google DeepMind RT-X** | Open-source models and weights; shipping commercial deployments (Weave, Ultra); fine-tuning API; faster iteration (7 releases in 18 months) | Google's scale of data and compute; Google's industrial partners (Boston Dynamics, Hyundai); chain-of-thought reasoning in policies |
| **Skild AI** | Open-source weights (openpi); flow matching architecture (GR00T cites π0); faster model iteration (7 releases in 18 months); academic pedigree | Revenue ($0 vs. Skild's ~$30M); simulation-first data generation; higher valuation ($14B vs. ~$5.6B); SoftBank backing |
| **Tesla Optimus** | Cross-embodiment generalization; third-party robot support; academic pedigree and published research | Manufacturing scale; vertically integrated data flywheel; Optimus units shipping to factories |

---

## Coverage Summary

- **Strong**: VLA foundation models (π0 → π0.7), cross-embodiment generalization, open-source model weights (openpi), fine-tuning pipeline
- **Absent**: Simulation, training infrastructure, model registry, inference server, CI/CD, monitoring, platform runtime, OS, edge — everything except the model itself
- **Conflicts with Red Hat**: None — pure model provider with no infrastructure products
- **Lock-in**: Low — code is Apache 2.0 but weights under Gemma Terms of Use (includes revocation clause). Fine-tuning API creates soft lock-in via data and workflow. CUDA-only (JAX[cuda12])

---

## Strategic Implications for Red Hat

1. **Natural workload, zero conflict**: PI builds only models — no platform, no runtime, no inference server. Training runs on OCI with WEKA storage and Anyscale/Ray for data processing. These workloads are a natural fit for OpenShift AI. openpi's WebSocket policy server could be containerized and served via KServe.

2. **The OpenPI protocol is winning — via vLLM-Omni**: Distinguish the *repo* (declining: 37% health, ignored PRs) from the *protocol* (spreading: vLLM-Omni v0.22.0 clean-room reimplemented OpenPI serving at `/v1/realtime/robot/openpi`; DreamZero, AgiBot GO-1-Air, GR00T-N1.7 ports in-flight). The OpenPI WebSocket wire format is becoming the robotics equivalent of the Chat Completions API — the interface everyone implements against. Red Hat is already on the right side through vLLM-Omni investment.

3. **Protocol governance is the risk, not repo health**: PI controls the OpenPI wire format unilaterally — no spec document, no versioning, no multi-vendor governance body. vLLM-Omni maintains parity tests against PI's reference server but is reverse-engineering compatibility, not implementing against a stable contract. If PI makes breaking changes, vLLM-Omni's endpoint breaks. Monitor for formal spec or foundation governance; absent that, vLLM-Omni may need to fork and own the protocol definition.

4. **Skild AI is the benchmark for commercialization**: Skild ($14B valuation, ~$30M revenue) has outpaced PI on commercial traction while keeping models fully proprietary. PI's open-weight strategy builds ecosystem but may not build revenue. If PI follows Skild's path to commercialization, the on-prem deployment market for VLA models is Red Hat's opportunity.

5. **NVIDIA is both investor and partner**: NVentures invested in PI's Series B AND Skild's Series C — hedging bets on the VLA layer. PI deployed models at Foxconn on NVIDIA Blackwell lines. The relationship is complementary today but GR00T N1.7 competes directly on the model layer. PI may need platform partners independent of NVIDIA's stack.

---

## Related Reports

- [NVIDIA — competitive profile](nvidia.md) (GR00T, investor relationship)
- [Physical Intelligence — ecosystem entry](../../../research/ecosystem.md#physical-intelligence-pi)
