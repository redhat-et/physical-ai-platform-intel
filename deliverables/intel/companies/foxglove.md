# Foxglove -- Competitive Profile

**Date**: 2026-07-02
**Last updated**: 2026-07-02
**Classification**: Internal analysis

See [deep-dive](foxglove-deep-dive.md) for OSS foundations, product architecture, and competitive analysis details.

---

## At a Glance

Foxglove is a San Francisco-based startup building a **multimodal data and observability platform for Physical AI** -- often described as "the Datadog for robots." Co-founded in 2021 by Adrian Macneil (CEO) and Roman Shtylman (CTO), both ex-Cruise engineers who built similar internal tooling for autonomous vehicle development. The company created **MCAP**, the open-source container format now adopted as the default logging format in ROS 2 (from Iron onward) and NVIDIA Isaac ROS 3.0. Foxglove closed-sourced its viewer in March 2024 (Foxglove 2.0), pivoting from open-core to a proprietary platform with a freemium tier. The company positions itself as the infrastructure layer connecting robot development, fleet operations, and data-driven iteration.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | $58.7M total raised ($40M Series B led by Bessemer, Nov 2025) |
| **Physical AI thesis** | Robotics teams need a unified platform for multimodal data observability, fleet connectivity, and data curation -- the same infrastructure layer that Datadog/AWS built for cloud software |
| **Platform coverage** | ~15% of blocks -- concentrated in Data (logging, visualization, search, curation), Model Monitoring (fleet observability), with partial Fleet/Eval |
| **Relationship to Red Hat** | Complement -- Foxglove fills the robotics data observability gap; MCAP is an open standard; no competing platform components. Potential partner for Physical AI data layer |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Foxglove Platform** | Proprietary multimodal data platform: visualization (20+ panel types), data management, search and curation, fleet connectivity, remote teleoperation. Web + desktop app. SOC 2 Type II certified |
| **Foxglove SDK** | OSS SDK (MIT, Rust core with Python/C++ bindings) for logging multimodal data to MCAP files and streaming live data via WebSocket. 269 GitHub stars |
| **MCAP** | OSS container file format (MIT) for multimodal log data. Row-oriented, append-only, serialization-agnostic. Default in ROS 2 Iron+ and NVIDIA Isaac ROS 3.0. ~950 GitHub stars |
| **Foxglove Agent** | Lightweight process deployed on robots for recording upload, live streaming, and remote visualization/teleoperation. Handles unreliable connectivity with automatic resumption |
| **Data Search & Curation** | Query multimodal MCAP data at petabyte scale without a data warehouse. Sessions, events, batch annotation. Launched April 2026 |

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
  <td>🟡 Foxglove Platform<sup>1</sup><br>
  <small>(visual debugging + event annotation, not automated eval)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Foxglove Platform<sup>2</sup><br>
  <small>(log, store, search, curate multimodal data)</small></td>
  <td>⬜</td>
  <td>🟢 Foxglove Platform<br>
  <small>(BYOS + self-hosted sites)</small></td>
  <td>🟢 Foxglove Agent + SDK<br>
  <small>(on-robot logging + upload)</small></td>
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
  <td colspan="2">🟡 Foxglove Platform<sup>3</sup><br>
  <small>(webhooks trigger CI on recording arrival)</small></td>
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
  <td>⬜</td>
  <td>🟢 Foxglove Platform<sup>4</sup><br>
  <small>(fleet-level observability, events, anomaly search)</small></td>
  <td>⬜</td>
  <td>🟡 Foxglove Platform<br>
  <small>(remote visualization + teleoperation)</small></td>
  <td>🟡 Foxglove Agent<br>
  <small>(live streaming, not on-device monitoring)</small></td>
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
  <td><b>Models &amp; Policies</b></td>
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

| # | Product | OSS Foundation |
| --- | --- | --- |
| 1 | **Foxglove Platform (Eval)** | Visual debugging via event annotation and timeline review. Not automated eval. Platform is proprietary |
| 2 | **Foxglove Platform (Data)** | MCAP (MIT) as storage format. Platform proprietary. BYOS keeps data in customer buckets. SDK (MIT) for logging |
| 3 | **Foxglove Platform (CI/CD)** | Webhook-based triggers only -- not a CI/CD system. Integrates with external pipelines |
| 4 | **Foxglove Platform (Monitoring)** | Fleet observability with events, search, remote viz. Remote teleop in private beta (enterprise only) |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **NVIDIA** | Platform integration | MCAP adopted as default in Isaac ROS 3.0; Foxglove used for Isaac ROS visualization tutorials; NVIDIA Drive PX reportedly based visualization on Foxglove |
| **Amazon** | Enterprise customer | Fleet robotics; specific use case undisclosed |
| **Anduril** | Defense robotics | Enterprise customer for defense autonomous systems |
| **Wayve** | Autonomous driving | Enterprise customer; AV data observability |
| **Dexterity** | Logistics robotics | Saved 20%+ dev time, ~$150K/year in tooling costs. Reference customer |
| **ROS 2 / Open Robotics** | Standards body | MCAP storage plugin adopted as default bag format from ROS 2 Iron onward |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Rerun** | Native ROS 1/2 integration (zero-config); MCAP as industry-standard format; fleet-level observability + remote teleop; broader enterprise customer base ($58M raised); petabyte-scale data search and curation | Code-first SDK experience (Rerun's Python/Rust logging is more developer-centric); GPU-direct training dataloader (Rerun Hub); native 3D viewer performance (Rerun's Rust/egui vs Foxglove's browser); column-chunk storage optimized for ML random access |
| **RViz / RViz 2** | Web-based (no X11/display dependency); fleet-scale data management; MCAP format with full schema embedding; cross-platform (browser + desktop); team collaboration features | RViz's deep ROS integration (TF frames, interactive markers); zero latency for local ROS topics; free and fully open source; decades of community plugins |
| **Custom internal tools** | Off-the-shelf product replacing 6-12 months of internal tooling; maintained by dedicated team; SOC 2 compliance out of the box; scales from prototype to fleet | Custom tools can be tailored to exact workflow; no vendor dependency; no per-seat costs at scale |

---

## Coverage Summary

- **Strong**: Multimodal data platform (logging, visualization, search, curation); fleet-level observability and remote teleoperation; MCAP as open industry standard; on-robot data collection (Agent + SDK)
- **Absent**: Everything below the data/observability layer -- no training infrastructure, no models, no inference, no serving, no simulation, no platform runtime, no OS
- **Conflicts with Red Hat**: None -- Foxglove is a pure data/observability company. Complementary to any platform stack
- **Lock-in**: MCAP format is open (MIT), reducing format lock-in. Platform lock-in through proprietary visualization, search, and curation features. Self-hosted and BYOS options mitigate data residency concerns. Switching away requires replacing the visualization + fleet connectivity layer, not the data format

---

## Strategic Implications for Red Hat

1. **Strong data layer partner candidate**: Foxglove fills the robotics data observability gap in the Physical AI platform. No Red Hat product competes here. The SDK runs on any Linux (RHEL/Fedora), Foxglove Agent can be containerized for OpenShift, and self-hosted deployments run on Kubernetes -- natural integration points. The MCAP format is MIT-licensed and already integrated into ROS 2, which is part of our platform story.

2. **MCAP is the format to back**: MCAP has won the standards battle for robotics logging -- adopted by ROS 2, NVIDIA Isaac, and the broader ecosystem. Rerun's .rrd format is ML-training-optimized but ecosystem-specific. Red Hat should treat MCAP as the canonical Physical AI data format and ensure platform tooling (data pipelines, storage, CI/CD) has first-class MCAP support.

3. **Closed-source pivot creates opportunity**: Foxglove's March 2024 decision to close-source the viewer triggered community forks (Lichtblick/BMW, Flora, Trillium) and shifted community sentiment toward alternatives like Rerun. This creates a two-track opportunity: partner with Foxglove for enterprise fleet observability while supporting open-source visualization alternatives (Rerun SDK, Lichtblick) for the developer community.

4. **Fleet observability is the differentiator**: Where Rerun focuses on the development loop (code-first logging + ML training pipelines), Foxglove focuses on the operational loop (fleet connectivity, remote teleoperation, data search across deployed robots). As Physical AI moves from lab to production fleets, the operational observability layer becomes critical. Foxglove is better positioned here than Rerun.

5. **Monitor acquisition risk**: 88 employees, $58.7M raised, Bessemer-backed. Foxglove is a plausible acquisition target for NVIDIA (deepen Isaac ecosystem), Amazon (robotics fleet infra), or a DevOps incumbent (Datadog, Grafana Labs). An acquisition would reshape the competitive landscape for robotics data tooling and potentially lock MCAP governance to a single vendor.
