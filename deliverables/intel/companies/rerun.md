# Rerun — Competitive Profile

**Date**: 2026-07-02
**Last updated**: 2026-07-02
**Classification**: Internal analysis

See [deep-dive](rerun-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.

---

## At a Glance

Rerun is a Swedish startup building **"The Data Layer for Physical AI"** — a multimodal data infrastructure stack for logging, visualizing, querying, and training on sensor data from robots, drones, and autonomous vehicles. Founded in 2022 by Nikolaus West (CEO), Emil Ernerfeldt (CTO, creator of egui), and Moritz Schiebold (COO), all former teammates at 3D body-scanning startup Volumental. Chief Architect Jeremy Leibs previously worked on core ROS at Willow Garage and created the rosbag format. The company pursues an **open-core strategy**: the Rerun SDK (Apache-2.0 + MIT) handles visualization and data logging, while the commercial **Rerun Hub** provides team-scale data cataloging, transformation, and GPU-direct training pipelines.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | $20.2M total raised ($17M Seed led by Point Nine, Mar 2025). Estimated ~$7.5M ARR (GetLatka, Sep 2025, unconfirmed) |
| **Physical AI thesis** | Multimodal data infrastructure is the missing layer between robotics hardware and ML training — equivalent to what Snowflake/Databricks did for language AI |
| **Platform coverage** | ~10% of blocks — concentrated in Data (visualization + querying + storage) with partial Eval and Experiment Tracking |
| **Relationship to Red Hat** | Complement — Rerun fills the data visualization/management gap in the Physical AI stack; runs on any Linux; no competing platform components |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Rerun SDK** | OSS multimodal data SDK (Python, Rust, C++). Logs images, point clouds, transforms, time series, joint states, video at different rates. Column-chunk .rrd storage. Built-in viewer (native + WASM browser). 11K GitHub stars |
| **Rerun Viewer** | Synchronized multi-view visualization: scrub timelines, compare sensors side-by-side, watch CV pipelines live. Extends via custom views and plugins. Native desktop + WebAssembly browser |
| **Rerun Hub** | Commercial data catalog (private preview). SQL-based querying across recordings over S3-compatible storage. Transformations without copying raw data. GPU-direct dataloader for training (codec-aware, column-aware streaming). Claims petabytes of robot training data under management |

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
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>⬜</td>
  <td>🟡 Rerun Viewer<br>
  <small>(visual debugging, not automated eval)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Rerun SDK + Hub<br>
  <small>(log, store, query, transform multimodal data)</small></td>
  <td>⬜</td>
  <td>🟡 Rerun SDK<br>
  <small>(local logging, no Hub)</small></td>
  <td>🟡 Rerun SDK<br>
  <small>(lightweight logging)</small></td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td>⬜</td>
  <td>🟡 Rerun Hub<br>
  <small>(GPU-direct dataloader only)</small></td>
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
  <td colspan="2">🟡 Rerun SDK<br>
  <small>(visual experiment logging, not W&B-class tracking)</small></td>
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
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
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
| **Rerun Viewer** | Visual debugging for Physical AI data — not automated eval. Built on egui (MIT) + wgpu (Apache-2.0/MIT) |
| **Rerun SDK + Hub** | SDK is OSS (Apache-2.0 + MIT). Hub is proprietary. Column-chunk .rrd storage. Reads MCAP, LeRobot formats |
| **Rerun Hub (Train Infra)** | Proprietary GPU-direct dataloader. Codec-aware, column-aware streaming to GPUs without export step |
| **Rerun SDK (Experiment Tracking)** | Temporal multimodal logging usable for experiment visualization. Not a replacement for W&B/MLflow |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Foxglove** | Code-first SDK (vs browser-first platform); ecosystem-agnostic (works outside ROS); Rust performance; GPU-direct training pipeline (Rerun Hub); column-chunk storage optimized for ML training | Native ROS 1/2 integration (Foxglove zero-config); MCAP as industry standard log format (Rerun uses own .rrd); fleet-level observability (Foxglove 2.0); $40M raised (vs $20M) and broader enterprise customer base |
| **RViz / RViz 2** | Modern multi-view visualization; cross-platform (native + web); not tied to ROS; handles non-ROS data (sim, ML training); time series + 3D in one viewer; Python/Rust/C++ SDKs | RViz's deep ROS integration (TF frames, interactive markers); zero setup for ROS users; decades of community tooling; standard in academic robotics |
| **Weights & Biases** | Purpose-built for multimodal physical data (point clouds, transforms, video); temporal synchronization of multi-rate sensors; 3D visualization native; works at edge/on-robot | W&B's mature experiment tracking (hyperparameter sweeps, model versioning, team collaboration); broader ML ecosystem integrations; established enterprise presence |

---

## Coverage Summary

- **Strong**: Physical AI data logging, visualization, and querying (SDK + Viewer); multimodal temporal data storage (.rrd format); GPU-direct training dataloader (Hub)
- **Absent**: Everything below the data layer — no models, no inference, no serving, no platform, no OS, no simulation, no fleet management
- **Conflicts with Red Hat**: None — Rerun is a pure data tooling company. Complementary to any platform
- **Lock-in**: None for SDK (OSS, runs anywhere). Rerun Hub creates data-catalog lock-in (proprietary format, proprietary transformation engine). Migrating away requires re-exporting datasets

---

## Strategic Implications for Red Hat

1. **Natural data layer partner**: Rerun fills a specific gap in the Physical AI platform — multimodal sensor data visualization and management. No Red Hat product competes here. The SDK runs on RHEL/Fedora, can be containerized for OpenShift, and integrates with LeRobot (which runs on our stack). Embedding Rerun Viewer in OpenShift for robot data review is a plausible integration point.

2. **Open-core model aligns well**: The SDK is genuinely open (Apache-2.0 + MIT, dual-licensed). Red Hat can package and ship the SDK without license complications. The commercial Hub is where Rerun monetizes — this is the same open-core pattern Red Hat understands well. No CLA required for contributions.

3. **Ecosystem overlap is strong**: Rerun is already integrated with LeRobot (Hugging Face), NVIDIA PyCuVSLAM, Meta Reality Labs (Project Aria), and DeepMind. These are the same players in our Physical AI ecosystem. As the "visualization layer" becomes standard, whoever controls data infrastructure shapes training pipelines — monitor whether Rerun Hub becomes a de facto standard or whether MCAP/Foxglove wins the format war.

4. **Foxglove is the competitive benchmark**: Foxglove ($40M raised, acquired by [pending], MCAP format adopted in ROS 2 and NVIDIA Isaac) is the incumbent for robot data infrastructure. Rerun differentiates on developer experience (code-first vs browser-first) and ML training integration (GPU-direct dataloader). Both are potential partners for Red Hat — but Foxglove's MCAP is more standards-aligned while Rerun's .rrd is proprietary-format. Track which format becomes dominant.

5. **Small company, high technical quality**: 78 employees, $20M raised, Rust-first engineering culture. The rosbag-creator-as-chief-architect and egui-creator-as-CTO signals deep technical credibility. Risk: small startup in a competitive space — acquisition target for larger players (NVIDIA, Google, AWS). If acquired, data tooling decisions may be made by the acquirer.

---

## Related Reports

- [Rerun — deep dive](rerun-deep-dive.md)
- [Rerun — ecosystem entry](../../../research/ecosystem.md#rerun)
- [Foxglove — ecosystem entry](../../../research/ecosystem.md#foxglove)
