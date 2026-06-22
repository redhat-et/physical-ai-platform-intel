# Intrinsic (Google) — Competitive Profile

**Date**: 2026-06-22
**Last updated**: 2026-06-22
**Classification**: Internal analysis

See [deep-dive](intrinsic-deep-dive.md) for acquisition details, Flowstate architecture, ROS/Gazebo governance, and partnership analysis.
See [Google DeepMind profile](google-deepmind.md) for foundation models (Gemini Robotics) and research.
See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

---

## At a Glance

Intrinsic is Google's industrial robotics platform division, folded into Google proper in February 2026 after operating as an independent Alphabet "Other Bet" since 2021. Its thesis is **"Android for robotics"** — a horizontal software platform that runs across robot OEMs (FANUC, UR, KUKA) using Flowstate (low-code IDE), IVM (zero-shot perception), and IntrinsicOS (K8s on industrial PCs). Intrinsic stewards the ROS 2 / Gazebo ecosystem through its acquisition of OSRC engineers, though governance remains with the independent OSRF/OSRA. The critical strategic fact: Intrinsic has no on-prem datacenter infrastructure — no K8s, no server OS, no GPU operator — and relies entirely on Google Cloud for cloud workloads.

| | |
| --- | --- |
| **Type** | Big Tech (Google division) |
| **Revenue / Funding** | Internal Google funding; no disclosed revenue. Formerly Alphabet "Other Bet" |
| **Physical AI thesis** | Horizontal robotics platform across OEMs; "Android for robotics" |
| **Platform coverage** | ~25% of Physical AI blocks — concentrated in simulation (Gazebo), perception (IVM), application platform (Flowstate), edge runtime (IntrinsicOS) |
| **Relationship to Red Hat** | Complement on datacenter infrastructure (no conflict); IntrinsicOS is displacement target at edge; ROS 2/Gazebo are strategic OSS investments |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Flowstate** | Web-based, low-code IDE for industrial robotics. Behavior tree workflows, composable "skills", sim-to-real deployment. Beta; subscription SaaS; no public pricing |
| **IVM** | Industrial perception foundation model (3PT architecture). Zero-shot 6DoF pose from single CAD file. #1 on 7/11 BOP benchmark categories (ICCV 2025). Sub-mm accuracy with RGB cameras ($500-1K vs $5-20K depth sensors) |
| **IntrinsicOS** | Custom Linux + K8s on industrial PCs. Same OS for sim (cloud) and real (on-prem). Connects to robots, PLCs, grippers, sensors |
| **Flowstate-ROS Bridge** | Open-source bidirectional bridge between Flowstate services and ROS 2. Zenoh protocol support |
| **Intrinsic SDK** | Python/C++/Go SDK for custom Flowstate skills. Bazel build, gRPC transport. Apache 2.0 but Copybara-synced from Google monorepo (OSS single-vendor pattern) |
| **IPD** | Industrial Plenoptic Dataset: 2,300 scenes, 22 industrial parts, 100K+ object views. Open dataset |
| **Gazebo** (stewarded) | OSS robotics simulator (Apache 2.0). Current LTS: Harmonic (paired with ROS 2 Jazzy). Physics: ODE, Bullet, DART, TPE. Rendering: OGRE 2 |
| **ROS 2** (stewarded) | OSS robotics middleware (Apache 2.0). Current LTS: Jazzy Jalisco (→ 2029). Google/Intrinsic employs most core maintainers |

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
  <td>🟡 Gemini Robotics<sup>1</sup><br>
  <small>(cloud API; see <a href="google-deepmind.md">DeepMind</a>)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟢 Gazebo<sup>2</sup><br>
  <small>(OSS, hardware-portable)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>⬜</td>
  <td>🟡 BOP benchmark<sup>3</sup>, Gazebo eval<br>
  <small>(partial: 6D pose only)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟡 IPD<sup>4</sup><br>
  <small>(niche: 6DoF pose data only)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">🟡 Google Cloud (GKE, TPU pods)<br>
  <small>(cloud-only, no on-prem)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === AI Model & Data Lifecycle === -->

<tr>
  <td><b>Model Registry</b></td>
  <td colspan="2">🟡 Vertex AI Model Registry<br>
  <small>(cloud-only)</small></td>
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
  <td colspan="2">🟡 Google Cloud AI safety tools<br>
  <small>(cloud-native)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Agentic === -->

<tr>
  <td><b>Agentic</b></td>
  <td colspan="2">⬜</td>
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
  <small>(&lt;10ms, offline capable)</small></td>
</tr>

<tr>
  <td><b>llm-d</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>KServe</b></td>
  <td colspan="2">⬜<br>
  <small>(Vertex AI Endpoints instead)</small></td>
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
  <td>⬜</td>
  <td>🟢 ROS 2<sup>7</sup><br>
  <small>(stewarded via OSRF/OSRA)</small></td>
  <td>⬜</td>
  <td>🟢 ROS 2, Flowstate<sup>8</sup><br>
  <small>(skills, motion planning, IVM)</small></td>
  <td>🟢 ROS 2, Flowstate, IVM<sup>9</sup></td>
</tr>

<!-- === Platform === -->

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">🟡 GKE<br>
  <small>(cloud-only; competes with OpenShift)</small></td>
  <td colspan="2">⬜</td>
  <td>🟢 IntrinsicOS<sup>10</sup><br>
  <small>(proprietary Linux + K8s on IPC)</small></td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">🟡 Cloud TPU drivers<br>
  <small>(cloud-only, no on-prem GPU)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 IntrinsicOS<sup>10</sup><br>
  <small>(custom Linux; proprietary)</small></td>
</tr>
</table>

### OSS Foundations

| # | Product | OSS Foundation |
| --- | --- | --- |
| 1 | **Gemini Robotics** | Built on Gemini 2.0 (proprietary). Training uses JAX + TPU. No OSS deps disclosed. See [DeepMind](google-deepmind.md) |
| 2 | **Gazebo** | Apache 2.0. OSRF governance, OSRA oversight. Physics: ODE, Bullet, DART, TPE. Rendering: OGRE 2 |
| 3 | **BOP benchmark** | MIT. Intrinsic contributes IPD dataset and co-organizes |
| 4 | **IPD** | Open dataset. GitHub: `intrinsic-ai/ipd` |
| 5 | **Gemini API** | Proprietary API. Client: `google-genai` Python SDK (Apache 2.0) |
| 6 | **Gemini On-Device** | Proprietary model. Safari SDK. Runs on-device, fine-tunable with 50-100 demos |
| 7 | **ROS 2** | Apache 2.0. LTS: Jazzy Jalisco (→ 2029). OSRF holds IP; Google/Intrinsic employs most core maintainers |
| 8 | **Flowstate** | Proprietary platform. SDK: `intrinsic-ai/sdk` (Apache 2.0, Copybara sync). Uses Gazebo, Zenoh |
| 9 | **IVM** | Proprietary. 3PT architecture (CVPR 2026 Highlight). No OSS deps disclosed |
| 10 | **IntrinsicOS** | Custom Linux + K8s. Copybara sync from Google monorepo. OSS (single-vendor) pattern |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **FANUC** | Industrial (1.1M robots) | Flagship partner. 1000+ robots shipped with Physical AI since Dec 2025. Gemini + Flowstate |
| **Universal Robots** | Cobots (75K+/yr) | Flowstate hardware partner |
| **KUKA** | Industrial | Flowstate hardware partner |
| **Comau** | Industrial | Long-standing; PHEV supermodule assembly use case |
| **KEBA** | Controllers | 6-DOF controller integration for multi-OEM support |
| **Foxconn** | Manufacturing (230 campuses) | Joint venture for AI factory of the future; US deployment 2026 |
| **Siemens** | Automation | Innovation partner for software solutions |
| **Trinity Robotics** | CNC automation (40K+ machines/yr) | CNC machine tending on Flowstate |
| **NVIDIA** | Infra + simulation | Isaac grasping + Omniverse integration; complementary |
| **ABB** | — | NOT a partner (ABB → NVIDIA + Skild AI instead) |

Note: Humanoid partnerships (Agile Robots, Apptronik, Boston Dynamics) are primarily [Google DeepMind](google-deepmind.md) relationships, not Intrinsic.

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **NVIDIA** | ROS 2/Gazebo ecosystem governance; Gemini Robotics (most capable VLAs); IVM zero-shot perception; multi-OEM hardware abstraction (Flowstate) | Edge hardware (no Jetson equivalent); on-prem infrastructure; simulation rendering (Gazebo OGRE 2 vs RTX); developer population (2M NVIDIA robotics devs) |
| **Amazon Robotics** | Horizontal platform across OEMs; open simulation (Gazebo); foundation model access (Gemini) | Amazon's vertical integration and warehouse-scale deployment experience; Amazon's logistics-specific optimization |
| **Red Hat** | Foundation models (Gemini), perception (IVM), robotics middleware governance (ROS 2), simulation (Gazebo) | Container platform, server OS, on-prem K8s, fleet management, CI/CD, MLOps, GPU operator — all areas where Red Hat leads |

---

## Coverage Summary

- **Strong**: Simulation (Gazebo — de facto OSS standard), perception (IVM — BOP benchmark leader), developer ecosystem (ROS 2 stewardship), hardware partnerships (FANUC, UR, KUKA, Foxconn)
- **Absent**: On-prem datacenter infrastructure (no K8s, no OS, no GPU operator, no drivers), edge hardware (no SoC), fleet management, CI/CD, experiment tracking, media libs, pipeline orchestration, distributed inference
- **Cloud-locked**: Nearly everything beyond Gazebo and ROS 2 requires Google Cloud (GKE, Vertex AI, Gemini API). No on-prem story
- **Lock-in**: IntrinsicOS is proprietary Linux + K8s on IPCs; Flowstate is SaaS-only; IVM is Flowstate-only; Gemini Robotics is API-only

---

## Strategic Implications for Red Hat

1. **No datacenter conflict — pure complement**: Intrinsic has no container platform, server OS, or on-prem K8s. OpenShift/RHEL fills the entire middle layer.

2. **IntrinsicOS is a displacement target**: Proprietary Linux + K8s on industrial PCs. RHEL Device Edge + MicroShift could replace it — if Red Hat can offer the same sim-to-real consistency property (same OS in cloud VMs and on-prem IPCs).

3. **ROS 2 on RHEL is strategic**: Google employs most ROS 2 core maintainers. Red Hat should invest in (a) ROS 2 Jazzy packages for RHEL, (b) ROS 2 nodes in OpenShift containers, and (c) contributing to OSRA governance to reduce Google's single-point-of-failure risk.

4. **Gazebo is the open simulation commons**: Unlike Isaac Sim (NVIDIA GPU-locked), Gazebo runs on any hardware. Natural fit for Red Hat's open platform story. See [Gazebo project report](../projects/gazebo.md).

5. **Cloud lock-in is the counter-narrative**: Customers using Gemini Robotics + Flowstate + GKE are locked into Google Cloud. Red Hat's hybrid/multi-cloud positioning is the alternative for enterprises that need on-prem or multi-cloud deployments.

6. **Flowstate risk**: If Flowstate succeeds as "Android for robotics," it commoditizes the platform layer beneath it. If it fails (currently 26 GitHub stars on SDK — low adoption), the threat is limited. Monitor Foxconn JV results in 2026.

---

## Related Reports

- [Google DeepMind — competitive profile](google-deepmind.md)
- [Gazebo — project report](../projects/gazebo.md)
- [Simulation Engines — comparison](../project-comparisons/simulation-engines.md)
- [NVIDIA — competitive profile](nvidia.md)
