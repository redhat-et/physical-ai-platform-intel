# Google DeepMind — Competitive Profile

**Date**: 2026-06-22
**Last updated**: 2026-06-22
**Classification**: Internal analysis

See [deep-dive](google-deepmind-deep-dive.md) for model architecture details, RT-1/2/X lineage, and research analysis.
See [Intrinsic profile](intrinsic.md) for industrial robotics platform (Flowstate, IVM, IntrinsicOS).

---

## At a Glance

Google DeepMind is Google's AI research division, responsible for the Gemini model family including the **Gemini Robotics** VLAs — currently the most capable vision-language-action models in the field. DeepMind also stewards key open-source simulation infrastructure: **MuJoCo** (physics engine) and co-founded **Newton** (Linux Foundation). Its Physical AI thesis is **foundation models as the intelligence layer for any robot** — cross-embodiment VLAs that work across robot types (industrial arms, humanoids, cobots) without per-robot training. Unlike NVIDIA (which sells infrastructure) or Intrinsic (which sells a platform), DeepMind's business model is cloud API access to proprietary models via Gemini API / Vertex AI.

| | |
| --- | --- |
| **Type** | Big Tech (Google division) |
| **Revenue / Funding** | Internal Google funding; Gemini API revenue via Google Cloud |
| **Physical AI thesis** | Cross-embodiment VLAs as the intelligence layer; foundation models for any robot |
| **Platform coverage** | ~15% of Physical AI blocks — concentrated in foundation models, simulation physics (MuJoCo), and cloud inference |
| **Relationship to Red Hat** | Complement — no on-prem infrastructure; models consumed via API or open-weight releases (Gemma). MuJoCo/Newton are strategic OSS investments |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Gemini Robotics** | VLA (Vision-Language-Action) foundation model. Cross-embodiment; dexterous manipulation; 2× generality vs conventional VLAs. Trusted Tester access only |
| **Gemini Robotics-ER** | Embodied Reasoning VLM. 6D pose, trajectory/grasp prediction, spatial reasoning. Available via Gemini API |
| **Gemini Robotics On-Device** | Edge VLA. <10ms inference, works offline, fine-tunable with 50-100 demos. Via Safari SDK |
| **Gemini Robotics 1.5** | Advanced VLA with transparent reasoning ("thinks before acting"). Most capable. Trusted Tester |
| **Gemini Robotics-ER 1.6** | Updated ER. Agentic capabilities, multi-view understanding. Gemini API + AI Studio |
| **Safari SDK** | `google-deepmind/gemini-robotics-sdk`. Agent framework + `flywheel` CLI for training, serving, data management |
| **MuJoCo** (stewarded) | Physics engine (Apache 2.0). 18K+ stars. CPU + GPU via MJX (JAX). DeepMind acquired from Emo Todorov in 2021 |
| **MuJoCo Warp** | GPU port of MuJoCo for NVIDIA GPUs. Primary backend of Newton (Linux Foundation) |
| **Gemma 4** | Open-weight general-purpose models (Apache 2.0, 1B-27B). Not robotics-specific |
| **Genie 3** | Auto-regressive world model generating interactive 3D environments from text at 720p/24fps. ~1 min spatial memory window. Released Jan 2026 via Google AI Ultra. Waymo adopted fine-tuned version for AV simulation |

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
  <td>🟢 Gemini Robotics<sup>1</sup><br>
  <small>(proprietary VLAs; most capable)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟢 MuJoCo<sup>2</sup>, Newton<sup>3</sup><br>
  <small>(physics; OSS)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>⬜</td>
  <td>🟡 MuJoCo benchmarks<br>
  <small>(locomotion/manipulation only)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Open X-Embodiment<sup>4</sup><br>
  <small>(33 labs, 22 robot types)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">🟡 Google Cloud (TPU pods)<br>
  <small>(cloud-only, no on-prem)</small></td>
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
  <td colspan="2">🟡 Gemini Robotics-ER 1.6<br>
  <small>(embodied reasoning model, not standalone policy)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td colspan="2">🟢 Gemini API, Vertex AI<sup>5</sup></td>
  <td colspan="2">🟢 Gemini API</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td colspan="2">🟡 Vertex AI Prediction<br>
  <small>(cloud-only)</small></td>
  <td colspan="2">⬜</td>
  <td>🟢 Gemini On-Device<sup>6</sup><br>
  <small>(&lt;10ms, offline)</small></td>
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
  <td colspan="2">🟢 JAX, TensorFlow<br>
  <small>(Google-stewarded frameworks)</small></td>
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
  <td colspan="2">⬜<br>
  <small>(structural dep on Google Cloud)</small></td>
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

| # | Product | OSS Foundation |
| --- | --- | --- |
| 1 | **Gemini Robotics** | Built on Gemini 2.0 (proprietary). Training uses JAX + TPU. Open-weight alternative: Gemma 4 (Apache 2.0, not robotics-specific) |
| 2 | **MuJoCo** | Apache 2.0 (since 2022). CPU + GPU (MJX via JAX). DeepMind-stewarded. 18K+ stars |
| 3 | **Newton** | Apache 2.0, Linux Foundation. DeepMind contributed MuJoCo Warp as primary backend. Co-founded with NVIDIA, Disney Research |
| 4 | **Open X-Embodiment** | Open dataset from 33 research labs, 22 robot types. Foundation for RT-X and cross-embodiment research |
| 5 | **Gemini API** | Proprietary API. Client: `google-genai` Python SDK (Apache 2.0) |
| 6 | **Gemini On-Device** | Proprietary model. Safari SDK for deployment. Fine-tunable with 50-100 demos |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **Agile Robots** | Industrial + humanoid (Agile ONE) | Gemini Robotics fine-tuning; 20K+ deployed systems; $270M+ raised; series production 2026 |
| **Apptronik** | Humanoid (Apollo) | Gemini Robotics for humanoid control. Pre-production |
| **Boston Dynamics** | Humanoid (Atlas) + quadruped (Spot) | Gemini for Atlas intelligence. ~1K+ Spot deployed |
| **FANUC** | Industrial (1.1M robots) | Via Intrinsic — Gemini + Flowstate integration |

Note: Industrial OEM partnerships (FANUC, UR, KUKA) are primarily through [Intrinsic](intrinsic.md), which integrates Gemini Robotics models.

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **NVIDIA** | Most capable VLAs (Gemini Robotics); MuJoCo (best-in-class physics engine); ROS 2 ecosystem governance (via Intrinsic); open-weight models (Gemma 4) | Edge hardware (no Jetson equivalent); on-prem infrastructure; simulation rendering; GPU infrastructure stack; developer population scale |
| **OpenAI** | Stronger robotics-specific VLAs; on-device deployment (<10ms); deeper robot OEM partnerships (via Intrinsic) | OpenAI's general model capabilities; ChatGPT's developer mindshare; potential physical AI play |
| **Meta (FAIR)** | Gemini Robotics performance benchmarks; MuJoCo ecosystem; cross-embodiment research depth | Open-weight robotics models (if Meta releases them); Habitat-Lab sim ecosystem |

---

## Coverage Summary

- **Strong**: Foundation models (Gemini Robotics — most capable VLAs), simulation physics (MuJoCo — de facto RL standard), cross-embodiment research (Open X-Embodiment dataset), humanoid partnerships (Agile, Apptronik, Boston Dynamics)
- **Absent**: On-prem infrastructure, edge hardware, fleet management, CI/CD, MLOps, pipeline orchestration, media libs, robotics middleware (that's Intrinsic's domain)
- **Cloud-locked**: All models proprietary, cloud API only. No on-prem inference except On-Device (edge only)
- **Open-weight gap**: Gemma 4 is open-weight but not robotics-specific. No open-weight robotics VLA from Google

---

## Strategic Implications for Red Hat

1. **Pure complement — no infrastructure conflict**: DeepMind has no container platform, OS, GPU operator, or on-prem K8s. Models are consumed via API. Red Hat provides the platform beneath.

2. **MuJoCo is strategic open infrastructure**: The de facto standard physics engine for RL research (18K+ stars, Apache 2.0). MuJoCo Warp feeds Newton (Linux Foundation). Red Hat should support MuJoCo/Newton on OpenShift as first-class simulation workloads. See [MuJoCo project report](../projects/mujoco.md).

3. **Gemini Robotics model dominance risk**: If Gemini Robotics becomes the default VLA, it pulls the ecosystem toward Google Cloud for training and inference. Red Hat's counter: ensure open VLAs (LeRobot, OpenPI, GR00T N1) run well on OpenShift + vLLM, giving enterprises a choice.

4. **Open X-Embodiment is a community asset**: The cross-embodiment dataset from 33 labs is a public good that benefits the entire field. Red Hat should ensure RHOAI data tooling supports this format.

5. **On-Device creates edge deployment question**: Gemini Robotics On-Device runs with <10ms latency without network. If enterprises adopt it, they need an edge platform to manage the devices — Red Hat's RHEL Device Edge + MicroShift fills that gap regardless of which VLA runs on it.

---

## Related Reports

- [Intrinsic — competitive profile](intrinsic.md)
- [MuJoCo — project report](../projects/mujoco.md)
- [Newton — project report](../projects/newton.md)
- [Simulation Engines — comparison](../project-comparisons/simulation-engines.md)
- [NVIDIA — competitive profile](nvidia.md)
