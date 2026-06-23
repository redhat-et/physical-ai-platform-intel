# Skild AI — Competitive Profile

**Date**: 2026-06-23
**Last updated**: 2026-06-23
**Classification**: Internal analysis

See [deep-dive](skild-ai-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.
See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

---

## At a Glance

Skild AI is a $14B-valued robotics foundation model startup building the **Skild Brain** — a universal, omni-bodied policy model that controls any robot form factor (humanoids, quadrupeds, arms, AMRs) without embodiment-specific training. Founded in 2023 as a CMU spinout by Deepak Pathak and Abhinav Gupta, the company pursues a **"brain-as-a-service" platform strategy**: license the foundation model to robot OEMs rather than build hardware. Training relies heavily on NVIDIA's simulation stack (Isaac Lab, Cosmos, Omniverse). The April 2026 acquisition of Zebra's robotics division (formerly Fetch Robotics) added warehouse AMR hardware and the Symmetry fleet orchestration platform, marking a partial shift toward vertical integration in logistics.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | ~$30M revenue (first months of 2025); $1.83B total raised (Series C: $1.4B at $14B, Jan 2026) |
| **Physical AI thesis** | Universal omni-bodied foundation model as the "Android for robots" — one brain, any body |
| **Platform coverage** | ~15% of blocks — concentrated in robot policy training, simulation (via NVIDIA), edge inference |
| **Relationship to Red Hat** | Potential complement — Skild deploys on cloud/enterprise infrastructure but has no platform layer; could run on OpenShift for model serving and fleet management |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Skild Brain** | Omni-bodied robotics foundation model. Hierarchical architecture: high-level VLA policy (10 Hz reasoning) + low-level motor control (kHz reflexes). Trained on trillions of simulated episodes + real-world video. Adapts to new embodiments via in-context learning without retraining |
| **Skild Brain API** | Cloud-based API for licensing Skild Brain to OEMs. Customers pay for robot intelligence rather than developing proprietary control |
| **Symmetry Fulfillment** | Fleet orchestration platform (acquired from Zebra). Coordinates tasks between robots and human workers. Integrates with Zebra wearable devices |
| **Fetch AMR fleet** | Autonomous mobile robots for warehouse logistics (acquired from Zebra/Fetch Robotics). Hardware base for Skild Brain deployment in logistics |

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
  <td>🟢 Skild Brain training<sup>1</sup><br>
  <small>(omni-bodied policy training)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 Via NVIDIA<sup>2</sup><br>
  <small>(Isaac Lab + Cosmos, not owned)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>⬜</td>
  <td>🟡 Internal eval<br>
  <small>(sim + real-world benchmarks)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Synthetic data generation<sup>3</sup><br>
  <small>(trillions of sim episodes)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">⬜<br>
  <small>(uses NVIDIA GPUs, HPE infra)</small></td>
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

<!-- === Agentic === -->

<tr>
  <td><b>Agentic</b></td>
  <td>⬜</td>
  <td>🟢 Skild Brain<sup>4</sup><br>
  <small>(embodied agent — hierarch. VLA)</small></td>
  <td>⬜</td>
  <td>🟢 Skild Brain</td>
  <td>🟢 Skild Brain<br>
  <small>(on-robot inference)</small></td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td>⬜</td>
  <td>🟢 Skild Brain API<br>
  <small>(cloud-based model licensing)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 On-robot inference<br>
  <small>(low-latency motor control)</small></td>
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
  <td>🟢 Symmetry + Fetch<sup>5</sup><br>
  <small>(fleet orchestration + AMR)</small></td>
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

### OSS Foundations

| # | Product | OSS Foundation |
| --- | --- | --- |
| 1 | **Skild Brain training** | Uses NVIDIA Isaac Lab (BSD-3) for RL training. PyTorch-based. Proprietary model architecture |
| 2 | **Simulation** | NVIDIA Isaac Lab + Omniverse (open data layer, proprietary Kit SDK) + Cosmos (open-weight) |
| 3 | **Synthetic data** | Cosmos Transfer for data augmentation. Proprietary data pipeline |
| 4 | **Skild Brain (inference)** | Proprietary model. Hierarchical VLA — high-level policy + low-level motor control |
| 5 | **Symmetry / Fetch** | Proprietary fleet orchestration. Fetch AMRs are proprietary hardware |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **NVIDIA** | Training infra + investor | Isaac Lab, Cosmos, Omniverse for simulation/training. NVentures investor (Series A + C). Foxconn factory co-deployment |
| **Foxconn** | Manufacturing | Skild Brain on dual-arm manipulators for NVIDIA Blackwell GPU assembly in Houston |
| **ABB Robotics** | Industrial OEM | Embedding Skild Brain into ABB robot portfolio. SoftBank acquiring ABB robotics ($5.38B) |
| **Universal Robots** | Industrial OEM | Integrating Skild Brain into UR collaborative robots |
| **SoftBank** | Strategic investor | Series C lead ($1.4B). Acquiring ABB robotics — could unify Skild + ABB under SoftBank umbrella |
| **HPE** | Training infra | AI-as-a-service training infrastructure via STN. European data center presence |
| **Samsung / LG** | Strategic investors | LG CNS partnership. Access to Korean industrial/consumer robot markets |
| **Zebra Technologies** | Acquisition | Fetch AMR fleet + Symmetry orchestration platform. ~$290M original Zebra purchase price |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Physical Intelligence (π0)** | Omni-bodied generalization across more form factors; warehouse deployment via Fetch acquisition; stronger OEM partnership network (ABB, UR, Foxconn); 2.5× higher valuation ($14B vs $5.6B) | π0's open-source base model strategy could commoditize the foundation layer; π0.5 trained across 7 platforms, 68 tasks, 104 homes — more diverse real-world data |
| **NVIDIA (GR00T N1)** | Hardware-agnostic software play (not tied to Jetson); OEM-neutral positioning; Zebra fleet orchestration | GR00T is vertically integrated with Isaac Sim, Newton, Jetson; NVIDIA has deeper simulation stack and 2M+ robotics developers |
| **Figure AI** | Platform approach serves all robot makers vs Figure's single humanoid; lower capex (no manufacturing); broader form-factor coverage | Figure has $37B valuation, vertically integrated hardware-software optimization, BMW deployment; hardware control enables tighter sim-to-real loop |

---

## Coverage Summary

- **Strong**: Robot policy training (omni-bodied foundation model), Synthetic data generation (at scale via NVIDIA sim), Embodied agent intelligence (hierarchical VLA), Cloud model API (brain-as-a-service), Warehouse fleet orchestration (Symmetry/Fetch)
- **Absent**: Simulation engine (depends on NVIDIA), Training infrastructure (uses NVIDIA GPUs, HPE servers), Model registry, Pipelines, CI/CD, Experiment tracking, Monitoring, Math/AI libs, Media libs, Container platform, OS, Drivers — entire platform layer
- **Conflicts with Red Hat**: None — Skild is a pure application-layer company with no infrastructure products
- **Lock-in**: Deep NVIDIA dependency for training (Isaac Lab, Cosmos, Omniverse, CUDA GPUs). NVentures investor creates alignment incentive

---

## Strategic Implications for Red Hat

1. **Potential customer, not competitor**: Skild AI has zero platform-layer products. Their Skild Brain API needs model serving infrastructure, fleet management, and edge deployment — all Red Hat products. As Skild scales from $30M to enterprise deployments, they will need a K8s-based platform for cloud inference and fleet orchestration.

2. **NVIDIA dependency creates platform risk**: Skild's entire training pipeline depends on NVIDIA (Isaac Lab, Cosmos, Omniverse, CUDA GPUs). NVentures is an investor. If NVIDIA tightens its ecosystem (e.g., requiring NIM for model serving, or Jetson for edge inference), Skild may be channeled away from Red Hat's stack. Monitor whether Skild's deployment infrastructure remains hardware-neutral.

3. **Symmetry/Fetch acquisition signals vertical integration**: The Zebra acquisition gives Skild warehouse robots + fleet orchestration software. This "orchestrated warehouse" play requires fleet management at scale — managing hundreds of AMRs, coordinating with human workers, handling firmware updates. Red Hat's fleet management (FlightCtl) and edge deployment (MicroShift) could be the infrastructure layer beneath Symmetry.

4. **Brain-as-a-service model needs inference at the edge**: Skild Brain runs hierarchical inference — high-level VLA at ~10 Hz (could be cloud/edge server) and low-level motor control at kHz (must be on-robot). The high-level policy serving is a natural fit for vLLM/KServe on OpenShift, while low-level control runs directly on robot hardware. Question: what inference framework does Skild use for on-robot deployment?

5. **OEM partnerships are the distribution channel**: Skild's go-to-market is through ABB, Universal Robots, and (via SoftBank) potentially the combined ABB robotics portfolio. If Red Hat is already the platform layer for these OEMs' robot deployments, Skild Brain becomes a workload running on Red Hat infrastructure. The SoftBank-ABB acquisition (closing mid-to-late 2026) could reshape this dynamic.

---

## Related Reports

- [NVIDIA — competitive profile](nvidia.md)
- [Skild AI — ecosystem entry](../../../research/ecosystem.md#skild-ai)
