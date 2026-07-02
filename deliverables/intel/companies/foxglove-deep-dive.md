# Foxglove -- Deep Dive Research

**Date**: 2026-07-02
**Last updated**: 2026-07-02
**Classification**: Internal analysis

Supporting research for the [Foxglove competitive profile](foxglove.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, product architectures, governance risks, and technical dependency chains.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2019 | Cruise open-sources Webviz, a browser-based ROS bag viewer. Adrian Macneil and Roman Shtylman work on Cruise's internal data tooling |
| 2021 | Foxglove founded by Macneil (CEO) and Shtylman (CTO) in San Francisco. Fork Webviz into Foxglove Studio under MPL-2.0 open-core model |
| 2022-01 | Seed round (amount undisclosed). Investors: Amplify Partners, Boost VC |
| 2022-06 | MCAP format launched -- open-source container format for multimodal log data (MIT license) |
| 2022-10 | $15M Series A led by Eclipse, with Amplify Partners. Total raised: ~$18.7M |
| 2023 | MCAP storage plugin for ROS 2 released. Foxglove Studio gains broad ROS 1/2 support |
| 2023 | ROS 2 Iron adopts MCAP as default bag format (replacing SQLite3). Subsequent distributions (Jazzy, Kilted) inherit this default |
| 2024-03 | **Foxglove 2.0**: closed-source pivot. Viewer no longer open source. Free tier for individuals/small teams retained. Community forks emerge (Flora, Lichtblick/BMW, AD-EYE, Trillium) |
| 2024-06 | NVIDIA announces MCAP as default logging format for Isaac ROS 3.0 |
| 2025-09 | Remote Visualization & Teleoperation enters private beta (enterprise only). Foxglove Agent enables live streaming and control over unreliable networks |
| 2025-11 | $40M Series B led by Bessemer Venture Partners (Eclipse, Amplify Partners follow). Total raised: $58.7M |
| 2026-04 | Data Search & Curation launch -- query MCAP data at petabyte scale. BYOS (Bring Your Own Storage) deployment model. Free Basic Seat tier introduced |
| 2026-04 | Self-service pricing reduced: Pro starts at $20/month for 1 TB + 3 dev seats |
| 2026-05 | 88 employees (Tracxn). Active development with Foxglove SDK v0.25.1 (June 2026) |

### Acquisitions -- What Each Brought

No acquisitions to date. Foxglove is organic growth only, built on the Cruise Webviz fork.

---

## 2. Product Architecture Details

### Foxglove Platform (Visualization + Data Management)

| Aspect | Details |
| --- | --- |
| **Architecture** | TypeScript/React frontend (browser-based). Go backend. 20+ built-in panel types (3D, images, plots, diagnostics, maps, raw messages, state transitions). Panel-based layout system with shareable configurations. WebSocket-based live connections to robots via Foxglove SDK or rosbridge |
| **Runtime dependencies** | Browser (Chrome/Firefox/Safari) or desktop app (Electron). No GPU required. Cloud-hosted metadata service for search/curation. Data stored in Foxglove cloud, customer S3 buckets (BYOS), or self-hosted Kubernetes clusters |
| **Extension model** | Custom panels (JavaScript/TypeScript). Message converters for custom types. Topic aliasing. Webhooks for CI/CD integration. REST API and CLI for automation |
| **Key limitations** | Browser-based rendering limits 3D performance vs native apps (Rerun, RViz). Visualization is proprietary (no open-source viewer since March 2024). Per-seat pricing at scale can be expensive for large organizations. No GPU-direct training dataloader (data stays in observability layer, not ML training layer) |

### Foxglove SDK

| Aspect | Details |
| --- | --- |
| **Architecture** | Rust core with Python and C++ bindings. Writes MCAP files and streams live data via WebSocket server. High-level APIs for common schemas (CompressedImage, SceneEntity, etc.) and low-level APIs for custom message types. Optional remote access via gateway connection for live viz/teleop through Foxglove Platform |
| **Runtime dependencies** | Python >= 3.10 (Python SDK). No Rust toolchain needed for users -- prebuilt wheels/libraries published. Platform-agnostic (Linux, macOS, Windows) |
| **Extension model** | Custom schemas via Protobuf, JSON Schema, or FlatBuffers. Low-level channel API for arbitrary data. Integration with ROS 2 message types |
| **Key limitations** | Younger than Rerun SDK (269 vs 11K GitHub stars). No built-in viewer -- requires connection to Foxglove app. No column-chunk storage (MCAP is row-oriented, optimized for append/write, not ML random access) |

### MCAP Format

| Aspect | Details |
| --- | --- |
| **Architecture** | Row-oriented, append-only container format. Serialization-agnostic (supports ROS 1/2, Protobuf, JSON, FlatBuffers, custom). Chunk-based compression (LZ4 or Zstandard). Schemas embedded alongside data for long-term readability. Optional indexing for random access. Published specification at mcap.dev |
| **Runtime dependencies** | Libraries in C++, Go, Python, Rust, Swift, TypeScript. No external dependencies -- fully self-contained files |
| **Extension model** | Attachments for arbitrary metadata. Metadata records for key-value pairs. Statistics records for summary information. Channels for multiple data streams. Custom serialization formats |
| **Key limitations** | Row-oriented design is optimized for sequential write/read, not random access by column (contrast with Rerun's column-chunk .rrd optimized for ML training). No built-in columnar query engine -- search requires Foxglove Platform or external tooling |

### Foxglove Agent

| Aspect | Details |
| --- | --- |
| **Architecture** | Lightweight daemon deployed on robots. Monitors directories for new recordings and uploads to Foxglove Platform. Handles unreliable connectivity with automatic upload resumption. For remote viz/teleop: forwards messages from Foxglove SDK to cloud gateway. Adaptive video encoding for bandwidth-constrained links |
| **Runtime dependencies** | Linux (ARM or x86). Docker image available. Foxglove Platform account required. Outbound HTTPS connectivity (no inbound ports needed) |
| **Extension model** | Configuration-driven (directory watching, upload rules). Integrates with Foxglove SDK for live streaming |
| **Key limitations** | Proprietary. Requires Foxglove Platform -- cannot be used standalone. Remote teleop in private beta (enterprise only) |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **MCAP** | Original (Foxglove-authored) | MIT | None -- fully open. Published spec at mcap.dev |
| **Foxglove SDK** | Original (Foxglove-authored) | MIT | Remote access gateway (requires Foxglove Platform) |
| **Foxglove Platform** | Originally forked from Cruise Webviz (MPL-2.0), closed-sourced in March 2024 | Proprietary | Everything: visualization, data management, search, curation, fleet connectivity, remote teleop |
| **Foxglove Agent** | None | Proprietary | On-robot data collection, upload, live streaming |
| **foxglove_msgs** | Original (Foxglove-authored) | MIT | ROS message definitions for Foxglove schemas |

### Pattern Analysis

Foxglove follows a **"open format + proprietary platform"** pattern. The strategic open-source assets are the MCAP format and the SDK -- both MIT-licensed, creating ecosystem adoption and industry-standard status. The monetizable platform (visualization, data management, fleet operations) is fully proprietary.

This pattern inverts the typical open-core model. Most open-core companies open-source the product and monetize hosted/enterprise features. Foxglove open-sourced the data format and closed the product. The bet is that format standardization (MCAP in ROS 2, NVIDIA Isaac) creates an ecosystem moat that drives users to the proprietary platform for visualization and management.

The March 2024 closed-source decision was explicitly motivated by economics: Foxglove stated that visualization consumed the majority of development effort, community contributions accounted for fewer than 1% of commits, and Fortune 50 companies were forking and reselling the viewer without payment. The decision traded community goodwill for monetization control.

### Notable Dependencies

- **Cruise Webviz**: The original codebase. Webviz was open-sourced by Cruise in 2019 but tightly coupled with proprietary extensions. Foxglove forked and extended it into a general-purpose robotics tool. The lineage is now largely historical -- Foxglove 2.0 has diverged substantially.
- **ROS 2 ecosystem**: MCAP's adoption as the default ROS 2 bag format creates a mutual dependency. ROS 2 distributions ship the MCAP storage plugin. Foxglove maintains the plugin and the format specification. This gives Foxglove significant influence over the ROS 2 data layer.
- **Protobuf / FlatBuffers / JSON Schema**: MCAP's serialization-agnostic design depends on these serialization frameworks. No lock-in to any single one.

---

## 4. Governance & Community Risk

### MCAP Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | Single-vendor (Foxglove Inc.) |
| **Core maintainer employment** | All core maintainers employed by Foxglove |
| **CLA/DCO** | No CLA required. Standard GitHub PR workflow |
| **Commit diversity** | >90% Foxglove employees. Some external contributions from ROS ecosystem users |
| **Abandonment risk** | Low -- MCAP is embedded in ROS 2 and NVIDIA Isaac as a default format. Even if Foxglove disappears, the MIT-licensed spec and libraries would persist. However, governance remains single-vendor with no foundation affiliation |

### Foxglove SDK Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | Single-vendor (Foxglove Inc.) |
| **Core maintainer employment** | All core maintainers employed by Foxglove |
| **CLA/DCO** | No CLA required |
| **Commit diversity** | >95% Foxglove employees |
| **Abandonment risk** | Medium -- the SDK is a means to drive platform adoption, not an independent community project. If Foxglove pivots or is acquired, SDK maintenance could stall. Unlike MCAP, the SDK is not embedded in external standards |

### Community Fork Landscape (Post-Foxglove 2.0)

The March 2024 closed-source pivot produced several forks of the last open-source version (v1.87.0):

| Fork | Maintainer | Status | Notes |
| --- | --- | --- | --- |
| **Lichtblick** | BMW / community | Active | Most mature fork. Continues MPL-2.0 development. Available as desktop + browser app |
| **Flora** | flora-suite community | Active | Independent fork focusing on data resource management for MCAP/bag files |
| **Trillium** | pixel-robotics | Active | Lightweight fork (40% smaller than Lichtblick). Web-focused |
| **AD-EYE** | AD-EYE project | Maintained | Preserves last open-source version for research use |
| **Tier4** | Tier IV (Autoware) | Maintained | Fork for autonomous driving ecosystem |

The fork landscape is fragmented -- no single successor has consolidated the community. This fragmentation benefits Foxglove commercially (forks compete with each other, not with Foxglove) but creates risk if a well-resourced fork (e.g., BMW's Lichtblick) gains critical mass.

---

## 5. Hardware Platform Details

Not applicable -- Foxglove is a pure-software company with no hardware products.

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **NVIDIA** | Isaac ROS 3.0+ | MCAP as default format; Foxglove in Isaac tutorials | Format-level + documentation. NVIDIA reportedly based Drive PX visualization on Foxglove without attribution |
| **ROS 2 / Open Robotics** | All ROS 2 Iron+ users | MCAP storage plugin as default bag format | Format-level. Foxglove maintains the rosbag2_storage_mcap plugin |
| **Amazon** | Enterprise customer | Undisclosed | Customer relationship |
| **Anduril** | Enterprise customer | Undisclosed | Defense robotics observability |
| **Wayve** | Enterprise customer | Undisclosed | AV data observability |
| **Dexterity** | Enterprise customer | Reference customer | 20%+ dev time savings, ~$150K/year cost reduction |
| **Shield AI** | Enterprise customer | Undisclosed | Defense/aerospace |
| **ANYbotics** | Enterprise customer | Undisclosed | Industrial inspection robots |
| **Saronic** | Enterprise customer | Undisclosed | Maritime autonomous systems |

### Developer Ecosystem

- **Customers**: "Hundreds" of customers across automotive, aerospace, defense, logistics, agriculture, construction, consumer robotics (company claim)
- **Users**: "Tens of thousands" of developers (company claim)
- **GitHub**: MCAP repo ~950 stars, SDK repo 269 stars. Foxglove GitHub org has multiple active repos
- **Conference presence**: Actuate (Foxglove's own event, 2025), ROSCon, various robotics meetups
- **Security certifications**: SOC 2 Type II, GDPR compliant

---

## 7. Detailed Competitive Analysis

### vs Rerun

| Dimension | Foxglove | Rerun |
| --- | --- | --- |
| **Core approach** | Browser-first platform (connect, upload, or stream) | Code-first SDK (log from Python/Rust/C++) |
| **Log format** | MCAP (open standard, MIT, adopted by ROS 2 + NVIDIA) | .rrd (proprietary, column-chunk, ML-training-optimized) |
| **ROS integration** | Native zero-config for ROS 1/2; maintains MCAP plugin | Via bridge nodes or MCAP import; experimental ROS 2 reflection |
| **Training pipeline** | No training integration -- focused on observability | GPU-direct dataloader in Hub (column-aware, codec-aware) |
| **Visualization** | Browser + desktop app (Electron); panel-based layout | Native app + WASM browser; immediate-mode (60fps); Rust/egui |
| **Fleet features** | Fleet connectivity, remote viz/teleop, device timeline, events | None in OSS; Hub for team collaboration |
| **Data management** | Petabyte-scale search, curation, sessions, events, BYOS | Hub (private preview): SQL queries over S3 |
| **Language** | TypeScript (frontend), Go (backend) | Rust (83%), Python, C++ |
| **Funding** | $58.7M (Series B) | $20.2M (Seed) |
| **Headcount** | ~88 (2026) | ~78 (2026) |
| **OSS model** | MCAP + SDK open (MIT); platform proprietary | SDK fully open (Apache-2.0/MIT); Hub proprietary |

### Format War: MCAP vs .rrd

MCAP has effectively won the standards war for robotics data logging. It is the default format in ROS 2 (from Iron/2023) and NVIDIA Isaac ROS (from 3.0/2024). Libraries exist in six languages. The format is serialization-agnostic, meaning it can wrap any data type.

Rerun's .rrd format is optimized for a different use case: ML training workflows requiring fast random access by time range, column-aware queries, and GPU-direct streaming. Rerun added MCAP read support but writes .rrd natively.

The strategic implication: MCAP is the "recording format" standard; .rrd is a "training-ready" format. Both may coexist -- MCAP for collection, .rrd (or similar) for training -- but MCAP's ecosystem entrenchment makes it the safer long-term bet.

### vs Weights & Biases

| Dimension | Foxglove | W&B |
| --- | --- | --- |
| **Primary domain** | Robotics data observability (sensor data, fleet ops) | ML experiment tracking (training metrics, sweeps) |
| **Data types** | Multimodal physical data (lidar, cameras, IMUs, joint states) | Metrics, images, video, tables, model artifacts |
| **Fleet/device** | Yes -- device management, remote viz, fleet timeline | No fleet concept |
| **Training integration** | No -- upstream of training | Yes -- core use case |
| **Positioning** | Complementary -- Foxglove for operational data, W&B for training data | Complementary |

### The Closed-Source Decision in Detail

Foxglove's March 2024 closed-source pivot was motivated by three factors:

1. **Development economics**: Visualization was the majority of engineering effort. Community contributions were fewer than 1% of commits. The open-core model was giving away the expensive part.
2. **Free-rider problem**: Fortune 50 companies (reportedly including NVIDIA for Drive PX) forked the viewer and embedded it in their own products without payment or attribution.
3. **Integration pressure**: Unifying visualization with data management, fleet connectivity, and search required tighter coupling that the open-source model made difficult.

The decision created measurable backlash: Hacker News/Reddit commentary was negative, and community members specifically cited the change as reason to evaluate Rerun. The fork landscape (Lichtblick, Flora, Trillium) demonstrates the community's desire for an open alternative but has not consolidated into a credible competitor.

---

## Sources

- [Foxglove website](https://foxglove.dev/)
- [Foxglove product page](https://foxglove.dev/product)
- [Foxglove pricing](https://foxglove.dev/pricing)
- [Foxglove SDK GitHub](https://github.com/foxglove/foxglove-sdk)
- [MCAP GitHub](https://github.com/foxglove/mcap)
- [MCAP specification](https://mcap.dev/)
- [Foxglove 2.0 announcement](https://foxglove.dev/blog/foxglove-2-0-unifying-robotics-observability)
- [Foxglove 2.0 Hacker News discussion](https://news.ycombinator.com/item?id=39672287)
- [BusinessWire: $40M Series B](https://www.businesswire.com/news/home/20251112126106/en/Foxglove-Raises-$40-Million-Series-B-to-Power-the-Future-of-Physical-AI)
- [Bessemer investment thesis](https://www.bvp.com/news/leading-the-future-of-robotics-infrastructure-with-foxglove)
- [VentureBeat: Series B](https://venturebeat.com/business/foxglove-raises-40-million-series-b-to-power-the-future-of-physical-ai/)
- [The Robot Report: $40M raise](https://www.therobotreport.com/foxglove-raises-40m-scale-data-platform-roboticists/)
- [Tracxn: Foxglove profile](https://tracxn.com/d/companies/foxglove/__3ko1rOUPw9RjvO7r4xCtOxp6Aq1gck6cGP-imJktP5A)
- [BusinessWire: Data Search & Curation launch](https://www.businesswire.com/news/home/20260421818840/en/Foxglove-Launches-Unified-Data-Search-and-Curation-Platform-to-Accelerate-Physical-AI-Development)
- [Foxglove blog: MCAP as ROS 2 default](https://foxglove.dev/blog/mcap-as-the-ros2-default-bag-format)
- [Foxglove blog: NVIDIA Isaac ROS 3.0 MCAP adoption](https://foxglove.dev/blog/nvidia-announces-mcap-as-the-default-logging-format-for-isaac-ros-3-0)
- [Foxglove blog: Remote Viz & Teleop beta](https://foxglove.dev/blog/announcing-remote-visualization-teleoperation-private-beta)
- [Foxglove blog: Reduced self-service pricing](https://foxglove.dev/blog/reduced-self-service-pricing)
- [Foxglove docs: Data platform](https://docs.foxglove.dev/docs/data)
- [Foxglove docs: Self-hosting](https://docs.foxglove.dev/docs/primary-sites/self-hosting/manage-data)
- [Foxglove blog: Index-in-place](https://foxglove.dev/blog/index-in-place-for-self-hosted-sites)
- [Flora fork on DEV Community](https://dev.to/flora-suite/continuing-the-journey-flora-a-fork-of-foxglove-3pd3)
- [Lichtblick GitHub](https://github.com/Lichtblick-Suite/lichtblick)
- [RViz vs Foxglove vs Rerun comparison (Foxglove)](https://foxglove.dev/robotics/rviz-vs-foxglove-vs-rerun)
- [RViz vs Foxglove vs Rerun comparison (ReductStore)](https://www.reduct.store/blog/comparison-rviz-foxglove-rerun)
- [NVIDIA Isaac ROS Foxglove visualization docs](https://nvidia-isaac-ros.github.io/v/release-3.1/concepts/visualization/foxglove.html)
