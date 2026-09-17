# XDOF — Competitive Profile

**Date**: 2026-09-16
**Last updated**: 2026-09-16
**Classification**: Internal analysis — not for public repo

See [deep-dive](xdof-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.

---

## At a Glance

XDOF is a UC Berkeley spinout (founded 2024) positioning as the "outsourced data-supply chain for the robotics industry" — building teleoperation rigs, data collection pipelines, and annotation systems that frontier AI labs use to train robot foundation models. Founded by Philipp Wu (CEO), Fred Shentu (CTO), and Nemo Jin (COO) based on their GELLO low-cost teleoperation research. Emerged from stealth June 2026 with $70M Series A (Thrive, a16z, Lux, Spark, WndrCo); already in talks for $1.2B Series B (Sep 2026, led by 8VC) just 3 months later. ~$50M ARR, 60 employees, ~20 customers including frontier AI labs. Released ABC-130K (130,000+ episodes, 195 bimanual tasks, Apache 2.0 open source) as largest open bimanual manipulation dataset.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | $70M Series A (June 2026), $1.2B Series B in talks (Sep 2026); ~$50M ARR |
| **Physical AI thesis** | Training data is robotics' biggest bottleneck; three-tier data pyramid (bespoke teleop, generalized teleop, egocentric) plus proprietary collection infrastructure enables frontier labs to scale robot training faster than building in-house |
| **Platform coverage** | ~5% of blocks — Data (physical robot training data collection) |
| **Relationship to Red Hat** | Complement — provides physical training data collection services; no platform conflict |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **ABC-130K Dataset** | Largest open-source bimanual manipulation dataset: 130,919 episodes (43,090 annotated), 3,553 hours, 195 tasks (pick-and-place, folding, sorting, handover, insertion, tool use, assembly). Collected on $8K bimanual YAM rigs (two 6-DoF arms, parallel-jaw grippers). Three camera views, joint states, end-effector poses, gripper aperture, task/subtask annotations. Apache 2.0 license on Hugging Face. Partnership with UC Berkeley BAIR. |
| **GELLO Teleoperation Rig** | Low-cost teleoperation system ($300/arm) from UC Berkeley research. Rebuilds leader from hobby-grade Dynamixel servos + printed parts. Widely adopted in academic labs. Enables human operators to control robotic arms for generating training data. |
| **ABC Box Hardware** | GELLO-compatible teleoperation hardware product. Pairs with passive encoder-only leader arms or YAM leader arms. Ties to ABC open-source behavior cloning stack (UC Berkeley, MIT, Amazon FAR, XDOF). |
| **Data Collection Services** | Three-tier data pyramid: (1) Bespoke teleoperation (robot-specific, remote operation), (2) Generalized teleoperation (GELLO-style, transferable), (3) Egocentric data (planned wearable-sensor data from humans performing everyday tasks). Includes cleaning, annotation, quality control. |
| **Annotation Pipeline** | MCAP file format for episodes. Subtask annotations as separate artifacts (revisable/extendable independent of episode data). Proprietary task design, quality-control methods, transformation pipelines. Sells infrastructure/pipelines, not just labels. |

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
  <td>⬜</td>
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
  <td>⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Physical Robot Data<br><small>(teleoperation, annotation, ABC-130K dataset)</small></td>
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
  <td><b>CI/CD & GitOps</b></td>
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
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<!-- === Models & Policies === -->

<tr>
  <td><b>Models & Policies</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td colspan="2">⬜</td>
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
| **ABC-130K Dataset** | Apache 2.0 license, hosted on Hugging Face (XDOF/ABC-130k). MCAP file format (open format from Foxglove). Partnership with UC Berkeley BAIR for open-source behavior cloning stack. |
| **GELLO Rig** | Open research from UC Berkeley ($300/arm design using Dynamixel servos, printed parts). Widely adopted in academic labs before XDOF commercialization. |
| **ABC Box / Data Services** | Proprietary hardware product, proprietary collection pipeline (task design, QC, transformation, annotation). |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **UC Berkeley BAIR** | Research Lab | Co-release ABC-130K dataset, ABC behavior cloning stack collaboration (with MIT, Amazon FAR). GELLO rig originated from Wu/Shentu's UC Berkeley research. |
| **Frontier AI Labs** | Customers | ~20 customers including "several frontier AI labs" (names not disclosed). CEO: "All of the top labs are trying to pursue robotics." |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Scale AI** | Focus on physical robot data (teleoperation) vs Scale's annotation-first model; three-tier data pyramid (bespoke/generalized/egocentric); GELLO hardware ecosystem; $1.2B valuation trajectory in <6 months | Scale's mature data labeling platform, diverse data types (not just robotics), broader enterprise customer base, public company trajectory |
| **Mecka** | Larger dataset (ABC-130K: 130K episodes vs unknown for Mecka), open-source contribution (Apache 2.0), UC Berkeley pedigree, faster growth ($1.2B talks 3 months post-launch) | Mecka's $100M ARR claim (vs XDOF's ~$50M ARR), Mecka's earlier Series A + follow-on timing |
| **Config** | Stronger funding ($70M Series A vs Config's $27M seed), larger public dataset (ABC-130K vs Config's undisclosed), bimanual focus | Config's Korean manufacturing connections (Samsung Venture Investment), Config's dual Seoul/San Jose presence for Asia-Pacific market |

---

## Coverage Summary

- **Strong**: Physical robot training data (teleoperation, bimanual manipulation), open-source datasets (ABC-130K), low-cost hardware (GELLO rig), annotation pipeline
- **Absent**: Simulation/synthetic data, training infrastructure, model serving, evaluation platforms — pure physical data collection provider
- **Conflicts with Red Hat**: None — complementary physical data layer
- **Lock-in**: Proprietary collection pipeline and task design; ABC-130K open source reduces dataset lock-in but services remain proprietary

---

## Strategic Implications for Red Hat

1. **Physical data as complement to simulation**: XDOF's rapid growth ($70M → $1.2B valuation in 3 months, ~$50M ARR) validates 2026 consensus that simulation and physical data are **complements, not substitutes**. Sim-to-real transfer degrades for contact-rich, deformable, fine manipulation tasks — physical teleoperation data required. Red Hat RHOAI should support ingestion of both simulated (OpenUSD from Lightwheel/Physicl/Palatial) and physical (MCAP from XDOF/Mecka/Config) training data formats.

2. **Teleoperation infrastructure as emerging category**: XDOF selling "pipelines, not labels" represents shift from annotation-as-a-service (Scale AI model) to **infrastructure-as-a-service** for data collection. Proprietary task design, QC methods, transformation pipelines, and GELLO hardware ecosystem create moat beyond manual labor. Red Hat should evaluate whether platform customers need teleoperation infrastructure support or if this remains outsourced.

3. **Open-source dataset strategy as GTM**: ABC-130K (Apache 2.0, 130K episodes) released at launch drives awareness, academic adoption, and validates XDOF's quality. This OSS-dataset-as-marketing mirrors Hugging Face's strategy. Red Hat could partner on open robotics dataset hosting/tooling to support ecosystem development.

4. **Frontier AI lab demand signal**: "All of the top labs are trying to pursue robotics" (CEO quote) + ~20 customers including frontier labs signals Physical AI is priority for OpenAI/Anthropic/DeepMind tier. These labs chose to outsource data collection to XDOF rather than build in-house — validates that data collection infrastructure is non-trivial and benefits from specialization.

5. **Three-tier data pyramid architecture**: Bespoke (robot-specific) → Generalized (transferable) → Egocentric (human tasks) represents data diversity strategy for robust robot foundation models. Red Hat platform should support all three tiers in training pipelines, not just single-source ingestion.

6. **MCAP format adoption risk**: XDOF uses MCAP (Foxglove's open format) for episode storage. This ties XDOF's data to Foxglove's tooling ecosystem. Red Hat should ensure RHOAI supports MCAP ingestion if MCAP becomes de facto standard for robot training data (similar to how OpenUSD is emerging for sim data).
