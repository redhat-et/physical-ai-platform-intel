# Rerun — Project Intelligence Report

**Date**: 2026-07-02
**Last updated**: 2026-07-02
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | Rerun |
| **Website** | <https://rerun.io/> |
| **Building block** | Visualization & Debugging; Data Management |
| **Competes with** | Foxglove (Foxglove Technologies), RViz (Open Robotics / OSRA), Weights & Biases (Weights & Biases), Grafana (Grafana Labs) |
| **Depends on** | [egui](https://github.com/emilk/egui) — immediate-mode GUI framework (created and maintained by Rerun CTO) |
| **Depended on by** | — |

### Repo Scope

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| rerun-io/rerun | Core | Analyzed | Primary repo: SDK, viewer, data store |
| emilk/egui | Upstream | Noted | GUI framework maintained by Rerun CTO; critical dependency, different governance (personal repo) |
| rerun-io/egui_tiles | Ecosystem | Noted | Tiling layout engine for egui, used in Rerun viewer; 548 stars |
| rerun-io/ewebsock | Ecosystem | Noted | WebSocket client for Rust (native + WASM); 295 stars |
| rerun-io/revy | Ecosystem | Noted | Bevy time-travel debugger proof-of-concept; 379 stars |
| rerun-io/egui_table | Ecosystem | Noted | Advanced table viewer for egui; 77 stars |
| rerun-io/kittest | Ecosystem | Noted | Automated GUI testing using accesskit; 90 stars |
| rerun-io/cpp-example-ros2-bridge | Peripheral | Excluded | Example / integration demo |
| rerun-io/pi0-lerobot | Peripheral | Excluded | Example integration with LeRobot |
| rerun-io/sam3d-body-rerun | Peripheral | Excluded | Example visualization |
| rerun-io/examples-monorepo | Peripheral | Excluded | Example aggregation repo |

**Discovery notes**: The rerun-io GitHub org contains ~30 repos. Most are example/demo repos showing Rerun integrations with third-party tools (LeRobot, ROS 2, SLAM pipelines, depth estimation). The core product is concentrated in a single monorepo (rerun-io/rerun). The critical upstream dependency egui lives under the CTO's personal GitHub account (emilk/egui), not the org.

---

## Executive Summary

- **What it is**: Open-source SDK and viewer for visualizing, querying, and streaming multimodal time-series data (point clouds, images, sensor streams) for robotics and Physical AI development — differentiates from Foxglove (Foxglove Technologies) by being code-first with Rust/Python/C++ SDKs rather than GUI-first.
- **Health verdict**: Watch — Active development with strong commit cadence (2,942 commits/12mo, 31 releases) and rapid response times, but contributor diversity is critically low: Rerun Technologies AB employees produce ~90% of commits with Elephant Factor of 1 (consolidated). Bus factor risk concentrated in CTO emilk. No external governance.
- **Technical verdict**: Strong — exceptionally well-architected Rust monorepo (60+ crates), Apache Arrow-native columnar storage, cross-platform rendering via wgpu (Vulkan/Metal/WebGPU), DataFusion SQL queries over multimodal sensor data, deep robotics ecosystem integration (LeRobot, ROS 2, MCAP), and very fast release cadence (5 releases in 2 months)
- **Red Hat fit**: Neutral — dual MIT/Apache-2.0 license, no CLA, and Arrow/DataFusion alignment are positive; but single-vendor control (all top 10 contributors are Rerun Technologies AB employees), commercial product incentive misalignment (Rerun Hub), no K8s-native deployment model, and unfamiliar rendering stack (egui/wgpu) introduce adoption risk
- **Recommendation**: <!-- filled by: project-comparison, or manual assessment after both evals complete -->

---

## Part A: Community & Project Health

### CHAOSS Metrics

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | 1 org for 50% of commits | Low | Rerun Technologies AB employees contribute ~90% of all commits (emilk 27%, Wumpf 19%, teh-cmc 12%, abey79 10%, jprochazk 5%, lucasmerlin 2%, oxkitsune 2%, MichaelGrupp 2%). Script counted variations of "Rerun.io", "rerun-io", "rerun.io", "Rerun" as separate orgs — consolidated, it is a single-org project. |
| **Contributor Absence Factor** | 3 people for 50% of commits | Watch | Top 3 (emilk, Wumpf, teh-cmc) account for 59% of all-time commits. 164 total contributors, but long tail is very thin. |
| **Change Request Closure Ratio** | 1,873 opened / 1,864 closed (12mo) | Healthy (0.99) | 1,592 merged — healthy throughput. Near-zero PR backlog growth. |
| **Time to First Response** | ~1 hour median | Fast | Sampled 10 recent PRs — median 1h to first review comment. Reflects dedicated full-time team. |
| **Release Frequency** | 31 releases in 12mo | Active | Latest: v0.33.1 (2026-06-22). 78 total releases. Roughly weekly cadence. Follows semver. |
| **Contribution Trend** | Stable | Stable | 2,942 commits in last 12mo. Core team composition unchanged. grtlr (freelance contractor) is a notable non-employee contributor (366 commits all-time). 286 merged PRs from non-core contributors in 12mo — external engagement exists but is small relative to total volume. No significant new organizational contributors entering. |
| **Libyears** | — | — | Deferred to project-tech-eval |

### Strategic Metrics

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | Permissive | Dual-licensed Apache-2.0 + MIT. No CLA. No unusual patent grants or restrictions. Standard Rust ecosystem practice. |
| **Governance model** | Single-vendor | No foundation affiliation. No external governance body. Roadmap controlled by Rerun Technologies AB. No GOVERNANCE.md or CHARTER.md. Has CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md. |
| **Contribution model** | None | No CLA or DCO required. External contributions accepted but require maintainer approval for CI runs. Large undiscussed changes may be rejected per CONTRIBUTING.md. |
| **Corporate control risk** | High | Rerun Technologies AB employees produce ~90% of commits. CTO emilk controls both the main repo and the critical upstream dependency (egui). Trademark "Rerun" owned by company. Open-core model planned — commercial cloud platform under development. No governance mechanism limits corporate control. |
| **Community health** | Active | 2,942 commits/12mo, 31 releases, 1h median TTFR. 1,303 open issues indicate active usage. Discord community. |
| **Ecosystem breadth** | Moderate | Adopted by Meta (Project Aria), Hugging Face (LeRobot default visualizer), NVIDIA (cuVSLAM wrapper), Google DeepMind, Unitree. Python, Rust, C++ SDKs. Jupyter integration. ROS 2 bridge examples. Gradio widget. Growing but still niche compared to established tools like Foxglove (Foxglove Technologies). |

### Governance Details

| Maintainer / Key Contributor | Employer | Role |
| --- | --- | --- |
| **Emil Ernerfeldt (emilk)** | Rerun Technologies AB (CTO, co-founder) | Core maintainer, creator of egui; 2,264 commits (27%) |
| **Andreas Reich (Wumpf)** | Rerun Technologies AB | Core maintainer; 1,595 commits (19%) |
| **Clement Rey (teh-cmc)** | Rerun Technologies AB | Core maintainer; 1,033 commits (12%) |
| **Antoine Beyeler (abey79)** | Rerun Technologies AB | Core maintainer; 840 commits (10%) |
| **Jan Procházka (jprochazk)** | Rerun Technologies AB | Maintainer; 434 commits |
| **Jochen Görtler (grtlr)** | Freelance contractor (working with Rerun) | Contributor; 366 commits |
| **Isse (IsseW)** | Unknown (Sweden-based) | Contributor; 252 commits |
| **Lucas Meurer (lucasmerlin)** | Rerun Technologies AB | Maintainer, egui co-maintainer; 177 commits |
| **Gijs de Jong (oxkitsune)** | Rerun Technologies AB | Maintainer; 176 commits |
| **Michael Grupp (MichaelGrupp)** | Rerun Technologies AB | Maintainer; 169 commits |
| **Nick Johnson (ntjohnson1)** | Rerun Technologies AB | Contributor; 116 commits |

**Co-founders**: Moritz Schiebold (CEO) and Nikolaus West. Emil Ernerfeldt (CTO) is the dominant technical contributor.

### Funding & Sustainability

**Total funding**: $20.2M across 2 rounds (pre-seed + seed).

- **Pre-seed** (June 2022): ~$3.2M from Costanoa Ventures, Seedcamp.
- **Seed** (March 2025): $17M led by Point Nine, with Sunflower Capital; existing investors Costanoa Ventures, Seedcamp participated. Angel investors include Guillermo Rauch (CEO, Vercel), Oliver Cameron (CEO, Odyssey), Wes McKinney (creator of pandas/Arrow), Eric Jang (VP AI, 1X), Nicolas Dessaigne (GP, Y Combinator).

**Team size**: ~78 employees as of May 2026.

**Business model**: Open-core. The SDK and viewer are fully open source (Apache-2.0 + MIT). A commercial cloud platform is under development offering managed data storage, team collaboration, and enterprise support.

**Sustainability assessment**: Current burn rate with 78 employees on $20.2M seed implies ~18-24 months of runway from March 2025 (depending on revenue). The company will likely need a Series A by late 2026 or early 2027. Key risk: if fundraising stalls, the open-source project's development velocity would drop sharply since almost all contributors are employees. The planned commercial product could generate revenue but is not yet launched.

**What happens if Rerun Technologies AB withdraws**: The project would effectively stall. There is no foundation, no external governance, and no significant non-employee contributor base. The egui dependency would also be at risk since its primary maintainer (emilk) is the CTO. The Apache-2.0 + MIT license means the code could be forked, but the Rust-heavy codebase and complex architecture would make community-driven maintenance difficult.

### Sibling Ecosystem Health

#### egui (emilk/egui) — Critical Upstream Dependency

| Signal | Assessment |
| --- | --- |
| **Stars / adoption** | 29,551 stars, 2,056 forks — one of the most popular Rust GUI frameworks |
| **Release cadence** | Monthly releases (0.34.0 through 0.35.0 in 2026) |
| **Contributor diversity** | Critically low: emilk accounts for ~85% of commits (2,994 of ~3,500). lucasmerlin (Rerun) is second with 178. Rerun staff contribute ~93% of all code |
| **External contributors** | Present but minor: YgorSouza (50), rustbasic (50), bircni (22) |
| **Backlog** | 920 open issues + 178 open PRs — large backlog relative to maintainer capacity |
| **Governance** | No formal governance. BDFL model under emilk. No foundation |
| **Risk** | High bus factor risk (1-2 people). If Rerun pivots away from egui or emilk becomes unavailable, the 29K-star ecosystem is at risk |

#### egui_tiles (rerun-io/egui_tiles)

- 548 stars, 15 total contributors, 95% Rerun-employee commits
- Maintained (tracks egui releases) but not actively developed
- Essentially a Rerun internal utility

#### ewebsock (rerun-io/ewebsock)

- 295 stars, 10 total contributors, single-maintainer (emilk)
- Lightly maintained utility; last commit March 2026
- Small scope, low maintenance burden

---

## Part B: Technical Analysis

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | Clear | Exemplary modular Rust workspace with 60+ crates organized into 5 domains (build, store, top, utils, viewer). Clean separation: SDK crates have zero viewer dependencies; chunk store is independent of rendering. FlatBuffers code generation ensures cross-language type consistency (Rust/Python/C++) |
| **Tech stack alignment** | Neutral | Rust-native (not Red Hat's primary language). Python SDK via PyO3/maturin (good). Apache Arrow/DataFusion align with data engineering trends. egui/wgpu rendering stack has no overlap with RHEL/OpenShift UI tooling. gRPC transport (tonic) aligns well. No K8s-native deployment; CI Dockerfile exists but no Helm/Kustomize |
| **Dependency health** | Watch | ~75 external Rust crate dependencies plus 60+ internal workspace crates. Key concerns: egui 0.35 (CTO-maintained, healthy but single-person origin), wgpu 29.0 (Mozilla/Rust foundation, healthy), arrow 58.3 and datafusion 53.1 (ASF, very healthy). cargo-deny enforces license policy and rustsec advisories. 3 known advisories explicitly ignored (paste, generational-arena, bincode — all unmaintained deps). PyO3/numpy pinned due to incompatibility with pyo3 0.29 |
| **Test coverage** | Adequate | 175 unit test files + 16 integration test files across Rust and Python. cargo-nextest for Rust testing. pytest for Python. Catch2 for C++. Benchmarks present. No formal coverage reporting (no Codecov/Coveralls). Snapshot testing via egui_kittest. No property-based testing |
| **Security posture** | Adequate | SECURITY.md with responsible disclosure policy (opensource@rerun.io). cargo-deny scans for rustsec advisories and license violations. No SBOM generation. No signed releases. rustls preferred over OpenSSL (openssl banned in deny.toml). re_auth crate handles authentication |
| **Code quality signals** | Strong | 562K LOC Rust + 136K LOC Python + 32K LOC C++. Clippy + rustfmt enforced (clippy.toml configured). Ruff/black for Python. TODO count: 1,581 (2.1/kLOC — moderate, mostly tracked with issue references like `TODO(#10068)`). Churn hotspots: re_redap_client (data protocol client) and viewer app module (expected for active development) |
| **Extensibility** | SDK | Primary extension model is the SDK: log data from any language, viewer renders it. View system is pluggable (each view type is a registered module). Importer plugins for file formats (MCAP, Parquet, MP4). No formal plugin API for external viewer extensions. MCP server (`re_viewer_mcp`) enables AI agent interaction |
| **Hardware portability** | Portable | wgpu abstracts across Vulkan, Metal, D3D12, WebGPU, and WebGL. No GPU compute requirement — GPU used only for rendering. CPU-only headless mode available for data processing. SDK and server run without any GPU |

### Architecture Overview

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **re_sdk / rerun_py / rerun_c** | Logging SDKs (Rust, Python via PyO3, C/C++) — encode data as Apache Arrow and transmit via gRPC or write to .rrd files | arrow, pyo3, flatbuffers |
| **re_chunk / re_chunk_store** | In-memory columnar time-series database. Data stored as Arrow-encoded chunks indexed by entity path, component, timeline, and time. O(log N) queries | arrow |
| **re_datafusion** | DataFusion integration — SQL queries over Rerun data via Arrow table providers. Powers the dataframe API and UI | datafusion 53.1 |
| **re_viewer** | Immediate-mode visualization application. Queries chunk store each frame, renders via re_renderer. Runs native or as WASM in browser | egui, eframe, re_renderer |
| **re_renderer** | Custom wgpu-based 3D/2D renderer. First-class support for point clouds, lines, meshes, images. WebGL compatibility tier for browsers | wgpu 29.0 |
| **re_server / re_grpc_server** | In-memory data server with gRPC API (tonic). Receives log data from SDKs, serves to viewers | tonic, tokio |
| **re_redap_client** | Client for Rerun Data Protocol (REDAP) — the wire protocol for Rerun Hub and self-hosted servers | tonic, prost |
| **re_mcap** | MCAP file importer with ROS 2 message parsers. Converts MCAP recordings to Rerun chunks | mcap (crate) |
| **re_sdk_types / re_types_builder** | Type system: datatypes, components, archetypes defined in FlatBuffers, code-generated to Rust/Python/C++ | flatbuffers |
| **re_web_viewer_server** | Serves WASM viewer bundle over HTTP. Enables `rr.serve()` in Python to open browser-based viewer | hyper |

### Data Flow

```text
SDK (Python/Rust/C++)
    | encode as Apache Arrow chunks
LogMsg (Arrow-encoded data)
    | transport: gRPC (tonic) / .rrd file / in-memory channel
re_chunk_store (columnar time-series DB, indexed by entity+timeline+time)
    | query: O(log N) latest-at / range queries, or SQL via DataFusion
re_viewer (immediate-mode: re-queries + re-renders every frame)
    | render: re_renderer (wgpu -> Vulkan/Metal/WebGPU/WebGL)
Screen (native window via eframe, or browser via WASM)
```

### Storage: Column-Chunk Design vs MCAP

Rerun's `.rrd` format stores data as a sequence of Apache Arrow-encoded chunks, each containing a batch of log messages for a given entity path and timeline. This is fundamentally different from MCAP (Foxglove Technologies):

| Dimension | .rrd (Rerun) | MCAP (Foxglove Technologies) |
| --- | --- | --- |
| **Data model** | Column-chunk (Arrow columnar batches) | Message-oriented (serialized message blobs) |
| **Schema** | Arrow schema with FlatBuffers-defined types | Schema stored per-channel (Protobuf, CDR, JSON) |
| **Indexing** | Entity path + timeline + time, in-memory index | Chunk-based indexing with summary statistics |
| **Query model** | SQL via DataFusion, latest-at, range queries | Sequential read, chunk-level seeking |
| **Interop** | Imports MCAP, Parquet; exports Arrow/Parquet | Broad ROS 1/2 ecosystem support |
| **Multi-rate data** | First-class: each entity logs at its own rate | Each channel has its own rate, interleaved in file |
| **Ecosystem** | Rerun-specific format, Arrow standard internals | Open standard, Foxglove/ROS ecosystem |

Key trade-off: .rrd is optimized for columnar queries and interactive scrubbing (immediate-mode viewer re-queries every frame), while MCAP is optimized for sequential replay and ROS bag compatibility. Rerun bridges this gap by importing MCAP natively via the `re_mcap` crate with ROS 2 CDR message parsers.

### egui/wgpu Dependency Chain

The viewer's rendering stack is:

```text
re_viewer -> egui (immediate-mode GUI) -> eframe (windowing)
          -> re_renderer -> wgpu -> Vulkan / Metal / D3D12 / WebGPU / WebGL
```

**Implications for enterprise deployment**:

- **egui** (v0.35): Created by Rerun CTO Emil Ernerfeldt, 29K+ GitHub stars, active community. Rerun is the largest commercial user and primary driver of features. Risk: tight coupling between egui roadmap and Rerun's needs; benefit: Rerun effectively controls its own GUI framework
- **wgpu** (v29.0): Rust implementation of WebGPU standard, backed by Mozilla/Rust foundation. Multi-backend (Vulkan, Metal, D3D12, WebGPU). Well-maintained. No CUDA dependency — purely for rendering, not compute
- **Headless/server deployment**: The SDK and data server (`re_server`) run without any GPU. Only the viewer requires GPU rendering. Headless data ingestion, storage, and querying work on CPU-only servers
- **WASM viewer**: Compiles to WebAssembly for browser deployment. Uses WebGPU when available, falls back to WebGL. Enables deployment behind a web server without native installation
- **RHEL compatibility**: wgpu requires Vulkan drivers on Linux. RHEL ships Mesa with Vulkan support. No GTK/Qt dependency (egui uses its own rendering). This is both an advantage (no system UI toolkit dependency) and a risk (unfamiliar rendering stack for Red Hat support)

### Dependency Analysis

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **egui** (Emil Ernerfeldt) | 0.35 | MIT/Apache-2.0 | Rerun CTO is author. Healthy project (29K stars) but Rerun is the primary commercial driver. Tight coupling |
| **wgpu** (Mozilla/gfx-rs) | 29.0 | MIT/Apache-2.0 | Multi-backend GPU abstraction. Well-maintained by Mozilla/Rust foundation |
| **arrow** (ASF) | 58.3 | Apache-2.0 | Official Rust Arrow implementation. Very healthy |
| **datafusion** (ASF) | 53.1 | Apache-2.0 | SQL engine over Arrow. Growing adoption in data engineering |
| **tokio** (Tokio Project) | 1.52 | MIT | De facto Rust async runtime. Very healthy |
| **tonic** (Hyperium) | 0.14.6 | MIT | gRPC framework for Rust. Healthy |
| **prost** (Tokio Project) | 0.14.4 | Apache-2.0 | Protobuf for Rust. Healthy |
| **pyo3** (PyO3 Project) | 0.28.3 | MIT/Apache-2.0 | Python-Rust bridge. Healthy. Pinned (can't upgrade to 0.29 due to numpy) |
| **flatbuffers** (Google) | 25.12 | Apache-2.0 | Used for type schema definitions and code generation |
| **serde** (dtolnay) | 1.0 | MIT/Apache-2.0 | Serialization framework. Ubiquitous in Rust. No risk |

### Capabilities & Positioning

| Capability | Detail |
| --- | --- |
| **Multimodal data visualization** | Point clouds, images, tensors, time series, graphs, maps, text, video, bar charts, state timelines. 15+ view types. Immediate-mode rendering ensures responsive scrubbing at any data scale |
| **Column-chunk storage** | Arrow-native columnar storage in .rrd format. Time-indexed by entity path. O(log N) queries. Supports multi-rate, multimodal data streams from heterogeneous sensors |
| **SQL/DataFrame queries** | Full SQL query support via Apache DataFusion integration. Query any logged data with standard SQL. Extend with post-processing or annotations as easily as adding DataFrame columns |
| **Cross-language SDKs** | Python (PyO3, pip-installable), Rust (native), C/C++ (CMake). Type-safe logging via FlatBuffers-generated archetypes (Points3D, Image, Transform3D, etc.) |
| **MCAP/ROS 2 import** | Native MCAP importer with ROS 2 CDR message parsers. Direct import of ROS 2 bag files. Bridges the Foxglove/ROS ecosystem |
| **WebAssembly viewer** | Full viewer compiles to WASM. Runs in browser via WebGPU (fallback to WebGL). Enables web-based deployment without native installation |
| **LeRobot (Hugging Face) integration** | Built-in importer for LeRobot datasets. Real-time visualization during teleoperation and training. RRD-to-LeRobot v3 conversion for training pipelines |
| **PyTorch dataloader** | Direct integration: load RRD files as PyTorch datasets for training. Bridges the gap between data collection and model training |
| **MCP server** | `re_viewer_mcp` crate enables AI agent interaction with the viewer. Aligns with agentic AI workflows |
| **Rerun Data Protocol (REDAP)** | gRPC-based wire protocol for client-server communication. Powers Rerun Hub (commercial) and self-hosted servers |

### Lock-in Assessment

| Dimension | Risk | Detail |
| --- | --- | --- |
| **Hardware** | Low | wgpu abstracts across Vulkan, Metal, D3D12, WebGPU, WebGL. No CUDA requirement. GPU needed only for viewer rendering; SDK and server are CPU-only. Headless data processing works without GPU |
| **Vendor** | Medium | All top 10 contributors are Rerun Technologies AB employees. CTO created egui. Commercial product (Rerun Hub) is the monetization path. REDAP protocol is open but Rerun-specific. Data format (.rrd) is Rerun-specific with Arrow internals. Risk: feature development prioritizes commercial product needs |
| **Ecosystem** | Medium | .rrd format is Rerun-specific (not a cross-tool standard like MCAP). Arrow internals provide theoretical interop, but practical tooling is Rerun-only. MCAP import bridges the gap. LeRobot integration and PyTorch dataloader create adoption gravity. Growing ecosystem of integrations (ROS 2, cuVSLAM, LeRobot) increases switching cost |

### Production Adoption

| User | Use Case |
| --- | --- |
| **Hugging Face (LeRobot)** | Integrated visualization for robot learning — dataset inspection, training debugging, policy rollout visualization, teleoperation monitoring |
| **Google DeepMind** | 3D reconstruction (Gaussian splatting) training visualization |
| **NVIDIA** | cuVSLAM (GPU-accelerated visual SLAM) visualization wrapper |
| **Meta Reality Labs** | Egocentric AI platform (Project Aria) visualization |
| **Physical AI startups** | Widely adopted across robotics/Physical AI startups for sensor data debugging and training pipelines |

### Build & CI

| Aspect | Details |
| --- | --- |
| **Build system** | Cargo (primary, Rust workspace), maturin (Python wheels via PyO3), CMake (C++ SDK), pixi (task runner and conda env management) |
| **CI** | GitHub Actions — 20+ workflow files. Nightly builds, contributor checks, wheel testing, C++ matrix, documentation builds |
| **Reproducibility** | Cargo.lock committed (Rust deps pinned). Python deps managed via pixi.toml. C++ SDK distributed as pre-built zip |
| **Platforms tested** | Linux (Ubuntu), macOS, Windows. WASM (wasm32-unknown-unknown). aarch64 and x86_64 via cargo-deny target triples |
| **Containerization** | Single CI Dockerfile (`ci_docker/Dockerfile`). No Helm, Kustomize, or K8s manifests. No production container image |

### Backlog Health

| Metric | Value |
| --- | --- |
| **Open issues** | 1,303 |
| **Stars** | 11,039 |
| **Forks** | 781 |
| **Release cadence** | Very active: 5 releases in last 2 months (0.32.0 through 0.33.1) |
| **Current version** | 0.34.0-alpha.1 (development); 0.33.1 (latest stable, 2026-06-22) |

---

## Red Hat Platform Fit Assessment

### Alignment Signals

- Dual MIT/Apache-2.0 license — fully compatible with downstream redistribution
- No CLA required — standard GitHub PR workflow, low contribution friction
- Apache Arrow and DataFusion alignment — ASF projects with growing Red Hat ecosystem relevance
- gRPC transport (tonic) — standard cloud-native protocol, aligns with OpenShift service mesh
- GPU-portable via wgpu (Vulkan/Metal/WebGPU) — no CUDA lock-in for rendering
- MCAP/ROS 2 import — bridges the dominant robotics middleware ecosystem
- Python SDK (pip-installable) — fits into RHOAI/Jupyter workflows for data exploration
- Headless SDK+server mode — data ingestion and querying work without GPU, suitable for server/container deployment
- LeRobot/PyTorch integration — aligns with RHOAI training pipelines
- Active development with fast release cadence — project is well-funded and moving quickly

### Risk Signals

- **Single-vendor control**: All top 10 contributors employed by Rerun Technologies AB (78-person VC-backed startup). No external committers with significant contributions. If Rerun pivots, gets acquired, or fails, there is no independent contributor base to sustain the project
- **Commercial product incentive misalignment**: Rerun Hub (commercial data catalog/storage) is the monetization path. Feature development may prioritize commercial needs over OSS community. REDAP protocol is open but designed primarily for Rerun Hub connectivity
- **No K8s-native deployment**: No Helm charts, Kustomize overlays, or Kubernetes manifests. The viewer is a desktop/browser application, not a cloud-native service. The data server (`re_server`) could be containerized but no packaging exists
- **Unfamiliar rendering stack**: egui/wgpu is not in Red Hat's technology portfolio (GTK, Qt). Supporting viewer issues would require wgpu/Vulkan expertise. However, the SDK and server are rendering-independent
- **Proprietary format**: .rrd is a Rerun-specific format. While Arrow-based internally, it is not a cross-tool standard. Creates vendor dependency for stored data (mitigated by Parquet export and MCAP import)
- **Pre-1.0 API stability**: Current version is 0.33.x. .rrd files have limited backward compatibility (current version opens previous version's files, but not older). API is evolving rapidly
- **egui single-person origin**: While egui has 29K stars and a healthy community, the CTO of Rerun created it and remains its primary maintainer. This creates a concentration of critical knowledge

### Supply Chain Assessment

- **License conflicts**: None. All Rust dependencies are permissive (MIT, Apache-2.0, BSD, Zlib). cargo-deny enforces a strict allowlist of permissive-only licenses. No LGPL, GPL, or copyleft dependencies in the Rust tree. Python SDK deps (numpy, pyarrow, pillow) are all permissive
- **Known CVEs**: cargo-deny configured with rustsec advisory scanning. 3 advisories explicitly acknowledged and ignored: RUSTSEC-2024-0436 (paste — unmaintained), RUSTSEC-2024-0014 (generational-arena — unmaintained), RUSTSEC-2025-0141 (bincode — unmaintained). 2 PyO3-related advisories tracked (RUSTSEC-2026-0176, -0177) pending numpy crate update
- **Single-maintainer risks**: egui (single original author, Rerun CTO) is the primary GUI dependency. wgpu has broad Mozilla/Rust foundation backing. arrow/datafusion are ASF projects. No single-maintainer transitive deps identified in critical path (cargo-deny bans known problem crates like openssl)

### Platform Integration Opportunities

- **RHOAI integration**: The Python SDK could serve as a visualization and data exploration layer within RHOAI Jupyter notebooks. DataFusion SQL queries over training data align with data science workflows
- **ROS 2 bridge**: MCAP/ROS 2 import enables Rerun as a debugging tool for ROS 2 workloads running on RHEL or OpenShift. Complements RViz2 with richer data types and web deployment
- **Headless server deployment**: `re_server` could be containerized for OpenShift deployment, providing a central data ingestion point for distributed robotics systems. Would need Helm/Kustomize packaging
- **Data pipeline**: Arrow-native storage and DataFusion queries make Rerun data compatible with broader Arrow-based data pipelines (Spark, Polars, DuckDB)

**Technical verdict**: Strong — exceptionally well-architected Rust codebase with clear modular boundaries (60+ crates), Apache Arrow-native storage, cross-platform rendering via wgpu, deep robotics ecosystem integration (LeRobot, ROS 2, MCAP), and fast release cadence. The DataFusion integration for SQL queries over multimodal sensor data is a distinctive capability.

**Red Hat fit**: Neutral — strong license (MIT/Apache-2.0), no CLA, and Arrow/DataFusion alignment are positive. However, single-vendor control (all contributors from one VC-backed startup), no K8s-native deployment, commercial product incentive misalignment (Rerun Hub), and unfamiliar rendering stack (egui/wgpu) introduce adoption risk. Best consumed as an upstream dependency or integration partner rather than a downstreaming candidate.

---

## Sources

- [Rerun GitHub repository](https://github.com/rerun-io/rerun)
- [Rerun website](https://rerun.io/)
- [Rerun raises $17M — Yahoo Finance](https://finance.yahoo.com/news/rerun-raises-17m-build-data-174100460.html)
- [TechCrunch: Rerun's open source AI platform revs up with $17M seed](https://techcrunch.com/2025/03/20/reruns-open-source-ai-platform-for-robots-drones-and-cars-revs-up-with-17m-seed/)
- [Costanoa VC: Why we're doubling down on Rerun](https://costanoa.vc/why-were-doubling-down-on-rerun-visualizing-the-future-of-physical-ai/)
- [Foxglove: RViz vs Foxglove vs Rerun comparison](https://foxglove.dev/robotics/rviz-vs-foxglove-vs-rerun)
- [ReductStore: Comparing RViz, Foxglove, Rerun](https://www.reduct.store/blog/comparison-rviz-foxglove-rerun)
- [Rerun blog: The Missing Data Infrastructure for Physical AI](https://rerun.io/blog/physical-ai-data)
- [emilk/egui GitHub](https://github.com/emilk/egui)
- [rerun-io/egui_tiles GitHub](https://github.com/rerun-io/egui_tiles)
- [rerun-io/ewebsock GitHub](https://github.com/rerun-io/ewebsock)
- [Rerun ARCHITECTURE.md](https://github.com/rerun-io/rerun/blob/latest/ARCHITECTURE.md)
- [Rerun SECURITY.md](https://github.com/rerun-io/rerun/blob/latest/SECURITY.md)
- [Rerun deny.toml (cargo-deny config)](https://github.com/rerun-io/rerun/blob/latest/deny.toml)
- [wgpu GitHub](https://github.com/gfx-rs/wgpu)
- [Apache DataFusion](https://datafusion.apache.org/)
- [LeRobot Visualization Tools (DeepWiki)](https://deepwiki.com/huggingface/lerobot/9.3-visualization-tools)
- [Rerun $17M Seed (TechCrunch)](https://techcrunch.com/2025/03/20/reruns-open-source-ai-platform-for-robots-drones-and-cars-revs-up-with-17m-seed/)
- [Rerun Company Intel](../companies/rerun.md)
