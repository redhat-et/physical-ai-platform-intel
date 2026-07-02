# Rerun — Deep Dive Research

**Date**: 2026-07-02
**Last updated**: 2026-07-02
**Classification**: Internal analysis

Supporting research for the [Rerun competitive profile](rerun.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, acquisition deep-dives, product architectures, governance risks, and technical dependency chains.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2022 | Founded in Stockholm by Nikolaus West, Emil Ernerfeldt, Moritz Schiebold (all ex-Volumental) |
| 2022-06 | $3.2M pre-seed from Costanoa Ventures and Seedcamp |
| 2023 | OSS beta launch of Rerun SDK; installable via pip and cargo |
| 2024 | C++ SDK reaches parity with Python and Rust; Blueprint APIs for programmatic viewer control |
| 2024 | MCAP format support added; ROS 2 reflection-based ingestion |
| 2025-03 | $17M Seed led by Point Nine (Sunflower Capital, Costanoa, Seedcamp). Angels: Eric Jang (1X VP AI), Wes McKinney (pandas/Arrow creator), Guillermo Rauch (Vercel CEO), Nicolas Dessaigne (YC GP) |
| 2025 | Rerun 0.27–0.30: streaming video, geospatial views, graph views, H.264 support |
| 2025-H2 | Releases 0.24–0.29: streaming video, ROS 2 MCAP reflection support, URDF/Collada loaders, GridMap |
| 2026-05 | Rerun 0.32 — "biggest release since OSS launch." Chunk processing API, PyTorch dataloader (random access, DDP), dataset review UI, OSS catalog server. Rebranded as "The Data Layer for Physical AI" |
| 2026-05 | Rerun Hub enters private preview — data catalog over S3-compatible storage. Claims "handling petabytes of robot training data" |
| 2026-06 | Rerun 0.33.1 (78 total releases). ~78 employees. 14 minor releases in 12 months |

### Acquisitions — What Each Brought

No acquisitions to date. Rerun is organic growth only.

---

## 2. Product Architecture Details

### Rerun SDK + Viewer

| Aspect | Details |
| --- | --- |
| **Architecture** | Column-chunk storage engine (`.rrd` format) optimized for multi-rate temporal data. Immediate-mode GUI via egui (Rust). Renderer uses wgpu (WebGPU/WebGL2). Entity Component System (ECS) as core data model — every logged datum is an entity with components (position, color, label) evolving over time. Viewer queries the in-RAM data store each frame, massages results, feeds to renderer |
| **Runtime dependencies** | Rust toolchain for native build; Python 3.8+ for SDK; WebAssembly runtime for browser viewer. No GPU required for viewer (CPU rendering fallback) but GPU recommended for 3D. No cloud services required |
| **Extension model** | Plugin system for loading arbitrary file types. Custom views via egui integration. Blueprint APIs for programmatic layout control. Dataframe API for custom queries |
| **Key limitations** | `.rrd` format is Rerun-specific (not an industry standard like MCAP). No native ROS 1/2 message decoding (requires bridge nodes or MCAP conversion). Viewer is single-user (no collaboration without Hub). No fleet-level features in OSS tier |

### Rerun Hub

| Aspect | Details |
| --- | --- |
| **Architecture** | Proprietary backend catalog service. SQL-based query engine across recordings. Transformation layer adds derived columns without duplicating raw data. GPU-direct dataloader streams training batches from catalog — column-aware and video-codec-aware, avoiding the traditional export-to-disk step. Byte-range indexing across object stores |
| **Runtime dependencies** | Single-tenant deployment in customer's region. Data stays in customer's own S3-compatible buckets. Requires Rerun SDK for data ingestion. PyTorch integration for training |
| **Extension model** | SQL queries, REST APIs, auth/SSO, link sharing (details limited — early availability) |
| **Key limitations** | Proprietary transformation engine. Early-availability product — select-partner phase. Pricing per-deployment based on team size and data scale (contact sales) |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Rerun SDK** | Original (Rerun-authored) | Apache-2.0 + MIT (dual) | None — fully OSS |
| **Rerun Viewer** | egui (Rust GUI, by CTO), wgpu (WebGPU) | egui: MIT; wgpu: Apache-2.0/MIT | Visualization archetypes, Blueprint system, plugin loader |
| **Rerun Hub** | Likely uses Apache Arrow/DataFusion (unconfirmed) | N/A (proprietary) | Catalog service, SQL engine, GPU-direct dataloader, transformation layer |
| **egui** | Original (created by Emil Ernerfeldt pre-Rerun) | MIT | Rerun sponsors development; upstream project, not Rerun-owned |
| **egui_tiles** | Original (Rerun-authored) | Apache-2.0 | Tiling layout engine for egui |

### Pattern Analysis

Rerun follows a **"build the OSS ecosystem, monetize the cloud layer"** pattern. The SDK and viewer are genuinely open-source with a permissive dual license (Apache-2.0 + MIT). The company invests heavily in upstream OSS: the CTO created and maintains egui (the biggest Rust GUI framework), and the team contributes to wgpu (Rust WebGPU implementation). This creates a strong technical moat — Rerun controls the GUI framework and rendering layer that power their own product.

The commercial value-add is the **data catalog and training pipeline** (Rerun Hub). This mirrors the Elastic/MongoDB pattern: the core engine is open, the operational layer is proprietary. The key strategic question is whether the `.rrd` format becomes entrenched enough to create switching costs before MCAP (Foxglove's open format, adopted by ROS 2 and NVIDIA) becomes the universal standard.

### Notable Dependencies

- **egui**: Created by Rerun CTO Emil Ernerfeldt. Rerun sponsors its development. 24K+ GitHub stars. Used by >100 projects. While technically independent, Rerun effectively controls the roadmap via employment of the creator. This is an asset, not a risk — egui improvements directly benefit Rerun.
- **wgpu**: Rust implementation of WebGPU standard. Maintained by gfx-rs team (multi-vendor). Rerun contributes but doesn't control. Dependency risk: low (large community, standards-based).
- **Apache Arrow / DataFusion**: Likely used in Hub's columnar query engine (Angel investor Wes McKinney created Arrow; team includes key Apache DataFusion contributors). Unconfirmed but architecturally consistent.

---

## 4. Governance & Community Risk

### Rerun SDK Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | Single-vendor (Rerun Technologies AB) |
| **Core maintainer employment** | All core maintainers employed by Rerun |
| **CLA/DCO** | No CLA required. Standard GitHub PR workflow |
| **Commit diversity** | >95% Rerun employees. Community contributions exist but are not structural |
| **Abandonment risk** | Medium — well-funded ($20M) with 78 employees and strong adoption signals, but single-vendor OSS with no foundation governance. If Rerun is acquired or pivots, SDK maintenance could stall |

### egui Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | Single maintainer (Emil Ernerfeldt, Rerun CTO) |
| **Core maintainer employment** | Employed by Rerun; Rerun sponsors egui development |
| **CLA/DCO** | No CLA |
| **Commit diversity** | Broad contributor base (24K+ stars, many PRs), but core direction set by one person |
| **Abandonment risk** | Low-Medium — very popular (biggest Rust GUI framework), but bus factor = 1. If Emil leaves Rerun or Rerun stops sponsoring, egui maintenance becomes uncertain |

---

## 5. Hardware Platform Details

Not applicable — Rerun is a pure-software company with no hardware products.

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Hugging Face / LeRobot** | Integrated in LeRobot OSS | OSS integration | Native format support (LeRobot datasets readable by Rerun) |
| **NVIDIA** | PyCuVSLAM uses Rerun | OSS adoption | Visualization layer for GPU-accelerated SLAM |
| **Meta Reality Labs** | Project Aria uses Rerun | OSS adoption | Aria Dataset Explorer visualization |
| **Google DeepMind** | Brush (Gaussian splatting) uses Rerun | OSS adoption | Training visualization for 3D reconstruction |
| **Unitree** | Uses Rerun in OSS robotics work | OSS adoption | Sensor data visualization |

### Developer Ecosystem

- **Discord**: Active community (size not publicly stated)
- **GitHub**: 11K stars, 781 forks, 78 releases
- **Examples**: Extensive example monorepo covering robotics, CV, simulation, and ML use cases
- **Agent skills**: Ships coding agent integration (LLM agent skills for Rerun API)
- **Conferences**: Presented at ROSCon, PyData, RustConf

---

## 7. Detailed Competitive Analysis

### vs Foxglove

| Dimension | Rerun | Foxglove |
| --- | --- | --- |
| **Core approach** | Code-first SDK (log from Python/Rust/C++) | Browser-first platform (connect to live robot or upload bags) |
| **Log format** | `.rrd` (proprietary, Rerun-specific) | MCAP (open standard, adopted by ROS 2, NVIDIA Isaac) |
| **ROS integration** | Via bridge nodes or MCAP import; experimental reflection-based ROS2 support | Native zero-config for ROS 1/2 |
| **Training pipeline** | GPU-direct dataloader in Hub (column-aware, codec-aware) | No training integration — focused on observability |
| **Visualization** | Native app + WASM browser; immediate-mode (60fps) | Browser-only; panel-based layout |
| **Fleet features** | None in OSS; Hub for team collaboration | Foxglove 2.0: fleet-level observability, events, device management |
| **Language** | Rust (83%), Python, C++ | TypeScript (browser), Go (backend) |
| **Funding** | $20.2M (Seed) | $40M+ |
| **OSS model** | SDK fully open (Apache-2.0/MIT); Hub proprietary | MCAP open; Foxglove platform proprietary |

### Format War: .rrd vs MCAP

The most strategically significant competitive dimension. MCAP is an open standard co-developed by Foxglove, adopted in ROS 2 Jazzy as a default bag format, and used by NVIDIA Isaac ROS. Rerun's `.rrd` is optimized for ML training workflows (column-chunk storage, fast random access by time range) but is ecosystem-specific. Rerun added MCAP read support (v0.25+) but writes `.rrd` natively. If MCAP becomes the universal Physical AI data format, Rerun risks being a "viewer" rather than a "platform." If `.rrd`'s ML-training advantages prove decisive, Rerun could set a new standard.

### Foxglove Open-Source Pivot (March 2024)

Foxglove closed-sourced its viewer in March 2024 (Foxglove 2.0), triggering community backlash: forks emerged (Flora, AD-EYE/foxglove-opensource, Tier4 fork), and Hacker News/Reddit commentary was sharply negative. Rerun directly benefits from this dynamic — community sentiment shows users explicitly choosing Rerun over Foxglove because of open-source commitment. This creates strategic pressure on Rerun to maintain its OSS stance, as any similar move would trigger even harsher backlash given the precedent.

### Other Competitors

- **PlotJuggler**: Open-source time-series plotting (ROS ecosystem). Handles millions of data points, but 2D plots only — no 3D/multimodal. Rerun supersedes it for multimodal but PlotJuggler remains preferred for pure numeric analysis.
- **Weights & Biases**: ML experiment tracking platform. Increasingly targeting Physical AI (robotics visualization features, sim-to-real events). Complementary rather than competitive — W&B handles training metrics/sweeps; Rerun handles sensor data visualization.
- **Webviz**: Web-based ROS bag viewer open-sourced by Cruise (2019). Effectively defunct — Foxglove was forked from it. Established the category.
- **Custom internal tools**: Waymo, Tesla, Boston Dynamics all build bespoke visualization. Rerun and Foxglove both aim to replace this custom tooling.

---

## Sources

- [Rerun website](https://rerun.io/)
- [Rerun GitHub](https://github.com/rerun-io/rerun)
- [Rerun blog](https://rerun.io/blog)
- [TechCrunch: $17M seed](https://techcrunch.com/2025/03/20/reruns-open-source-ai-platform-for-robots-drones-and-cars-revs-up-with-17m-seed/)
- [GlobeNewsWire: $17M announcement](https://www.globenewswire.com/news-release/2025/03/20/3046617/0/en/Rerun-Raises-17M-to-Build-the-Data-Infrastructure-Powering-the-Physical-AI-Revolution.html)
- [VentureScout profile](https://www.venturescout.io/p/rerun)
- [Rerun docs](https://rerun.io/docs)
- [egui GitHub](https://github.com/emilk/egui)
- [RViz vs Foxglove vs Rerun comparison](https://foxglove.dev/robotics/rviz-vs-foxglove-vs-rerun)
- [ReductStore robotics tools comparison](https://www.reduct.store/blog/comparison-rviz-foxglove-rerun)
