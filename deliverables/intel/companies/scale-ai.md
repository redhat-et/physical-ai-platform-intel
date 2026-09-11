# Scale AI -- Competitive Profile

**Date**: 2026-09-11
**Last updated**: 2026-09-11
**Classification**: Internal analysis

See [deep-dive](scale-ai-deep-dive.md) for OSS foundations, product architecture, and competitive analysis details.

---

## At a Glance

Scale AI is the dominant data infrastructure company for AI model training, now expanding from its LLM data labeling core into Physical AI demonstration data for robotics. Founded in 2016 by Alexandr Wang (who departed for Meta in June 2025), the company operates a global network of 240,000+ human annotators and purpose-built robotics data factories. Scale collects 1,000+ hours of robot demonstration data per day and delivered 150,000+ hours of Physical AI data in 2025. The June 2025 Meta deal ($14.3B for 49% stake) triggered departures of major AI lab customers (Google, OpenAI, xAI), accelerating Scale's pivot toward government ($500M Pentagon CDAO contract) and enterprise applications. Francis deSouza (ex-Google Cloud COO) became CEO in August 2026, signaling an enterprise sales focus.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | ~$870M revenue (2024); $4.1B total raised; $32.4B valuation; S-1 filed March 2026 |
| **Physical AI thesis** | Whoever controls the ground truth data for Physical AI controls the training flywheel -- robotics foundation models need orders of magnitude more demonstration data than exists today |
| **Platform coverage** | ~10% of blocks -- concentrated in Data (collection, annotation, curation) and Eval (SEAL benchmarks) |
| **Relationship to Red Hat** | Complement -- Scale fills the data operations gap; no competing platform components. Data factory model is upstream of training infrastructure |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Physical AI Data Engine** | End-to-end robotics data collection: global network of data factories, distributed collectors, and customer hardware, producing annotated demonstration data for VLA model training. 1,000+ hours/day throughput |
| **Scale Data Engine** | Core data annotation platform for images, video, text, audio, 3D/LiDAR. Hybrid ML pre-labeling + 240K human annotators. Powers LLM RLHF, AV perception, and robotics data |
| **Scale GenAI Platform (SGP)** | Enterprise platform for building, testing, and deploying GenAI applications. RAG pipelines, fine-tuning, agent orchestration, multi-model support |
| **Scale Donovan** | Government AI platform for defense and intelligence. Deploys AI agents on classified networks (TS/SCI). Processes battlefield intelligence for combatant commands |
| **SEAL / Scale Labs** | AI model evaluation: private benchmark datasets, expert-driven LLM leaderboards, SWE-bench Pro, agentic benchmarks. Expanded into Scale Labs (March 2026) for post-training research |
| **Scale Harness** | Robotless egocentric data collection platform for distributed dexterous manipulation demonstrations. Enables at-home data collection without robot hardware |
| **Scale Agentex** | Open-source agent execution framework for building and evaluating AI agents (488 GitHub stars) |

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
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 Physical AI Data Engine<br>
  <small>(synthetic data generation for rare scenarios; not a full sim engine)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>🟢 SEAL / Scale Labs<br>
  <small>(private benchmarks, expert-driven LLM leaderboards)</small></td>
  <td>🟡 Physical AI Data Engine<br>
  <small>(policy fine-tuning and evaluation pipeline for data validation)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>🟢 Scale Data Engine<br>
  <small>(text/image/video annotation, RLHF)</small></td>
  <td>🟢 Physical AI Data Engine<br>
  <small>(demo collection, annotation, curation at 1K+ hrs/day)</small></td>
  <td>⬜</td>
  <td>🟢 Physical AI Data Engine<br>
  <small>(distributed collectors, residential/commercial sites)</small></td>
  <td>🟡 Scale Harness<br>
  <small>(robotless egocentric collection device)</small></td>
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
  <td>🟡 Scale GenAI Platform<br>
  <small>(agent orchestration for enterprise; Agentex OSS)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<!-- === Models & Policies === -->

<tr>
  <td><b>Models &amp; Policies</b></td>
  <td>🟡 Defense Llama<br>
  <small>(national-security LLM built on Meta Llama 3; govt only)</small></td>
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

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware -- See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Scale Data Engine** | Proprietary platform. Nucleus Python SDK (MIT) for programmatic access |
| **Scale GenAI Platform** | Proprietary. Supports all major commercial and open-source models (Llama, Mistral, etc.) |
| **Scale Agentex** | Open-source agent execution framework (Apache 2.0, 488 GitHub stars) |
| **SEAL / Scale Labs** | SWE-bench Pro open-sourced (522 stars). Core SEAL benchmarks use private datasets |
| **Physical AI Data Engine** | Proprietary. No open-source data formats or tooling published |
| **LLM Engine** | Open-source LLM serving/fine-tuning framework (838 GitHub stars) |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **Universal Robots** | Industrial robotics | Co-developed UR AI Trainer integrating Scale's Physical AI Data Engine. Leader-follower teleoperation for VLA training data. Plan to release large-scale industrial dataset. Announced at GTC March 2026 |
| **Meta** | Strategic investor | 49% non-voting stake ($14.3B, June 2025). Meta's Llama underpins Defense Llama. Wang departed to lead Meta Superintelligence Labs |
| **U.S. DoD / CDAO** | Government | $500M enterprise agreement (May 2026). Donovan deployed on TS/SCI networks. First LLM on classified Army network (2023). Thunderforge prime contractor |
| **Physical Intelligence** | Robot foundation model | Named customer of Physical AI Data Engine. Pete Florence (pi) publicly endorses Scale's data quality |
| **NVIDIA** | Platform | GTC co-announcements. Scale listed among 5 Physical AI infrastructure platforms alongside NVIDIA |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Foxglove** | Managed data collection at 1,000+ hrs/day; annotation workforce; end-to-end data factory operations for robot foundation model training | Robotics data visualization, fleet observability, on-robot debugging, MCAP format ecosystem. Different layer: Scale produces data, Foxglove manages/visualizes it |
| **Labelbox** | Enterprise scale (240K annotators), government security clearances, Physical AI-specific collection infrastructure (data factories, Scale Harness), RLHF expertise | Self-serve platform UX for in-house teams, lower price point for smaller projects. Labelbox is the "factory equipment," Scale is the "contract manufacturer" |
| **Rerun** | Massive annotation workforce, petabyte-scale data operations, established AI lab relationships, government contracts | Developer-first SDK experience, open-source community, GPU-direct training dataloader, column-oriented storage optimized for ML. Rerun operates at the visualization/debugging layer, not data production |

---

## Coverage Summary

- **Strong**: Data collection and annotation at scale (both Language AI and Physical AI); LLM evaluation benchmarks (SEAL); government/defense AI deployment (Donovan); robotics demonstration data production (Physical AI Data Engine)
- **Absent**: Training infrastructure, simulation, model serving, inference, platform runtime, OS, robotics libraries, fleet management, model monitoring. Scale is purely upstream data
- **Conflicts with Red Hat**: None -- Scale operates at the data production layer, upstream of all Red Hat platform components
- **Lock-in**: Proprietary data platform with no open data formats for Physical AI. No published APIs for data export standardization. Government contracts create customer stickiness. Meta's 49% stake raises data confidentiality concerns for non-Meta customers

---

## Strategic Implications for Red Hat

1. **Complementary data layer**: Scale fills the robotics data production gap that no Red Hat product addresses. The Physical AI Data Engine produces the training data that flows into the training infrastructure Red Hat aims to provide. Integration point: data pipeline from Scale's collection to Red Hat's training platform (OpenShift AI, distributed training).

2. **Meta overhang complicates partnership**: Meta's 49% stake and the resulting customer flight (Google, OpenAI, xAI departures) make Scale a risky exclusive partner. Any Red Hat customer using Scale for data would need assurance that Meta cannot access their data. The customer concentration shift toward government and enterprise may mitigate this over time.

3. **No open data format for Physical AI**: Unlike Foxglove (MCAP, MIT) and Rerun (.rrd), Scale has not published or adopted an open standard for robotics data exchange. This means data produced by Scale's Physical AI Data Engine is locked into Scale's pipeline. Red Hat should advocate for open data formats (MCAP, LeRobot datasets) in the Physical AI data layer.

4. **Government market validation**: Scale's $500M Pentagon contract validates the demand for AI data infrastructure in defense. Red Hat's FedRAMP-authorized OpenShift and RHEL provide the classified platform layer that Scale's Donovan deploys on. There is a natural "Scale data + Red Hat platform" stack for government Physical AI.

5. **Watch for IPO and post-IPO strategy**: S-1 filed March 2026, IPO expected Q3-Q4 2026. Post-IPO Scale will face public-market pressure to grow revenue beyond data labeling. The enterprise GenAI platform (SGP) and Physical AI Data Engine are the growth vectors. If SGP expands into MLOps territory, it could begin competing with OpenShift AI.
