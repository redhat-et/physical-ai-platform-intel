# MCAP — Project Intelligence Report

**Date**: 2026-07-02
**Last updated**: 2026-07-02
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | MCAP |
| **Website** | <https://mcap.dev/> |
| **Building block** | Data Management; Recording & Replay |
| **Competes with** | .rrd (Rerun Technologies), ROS 1 bag format (Open Robotics), SQLite3 .db3 (rosbag2 legacy), HDF5 (HDF Group), Parquet (ASF) |
| **Depends on** | — |
| **Depended on by** | [ROS 2](ros2.md) — default bag format since Iron (May 2023), [Rerun](rerun.md) — MCAP importer via re_mcap crate, Isaac ROS (NVIDIA) — default recording format since Isaac ROS 3.0 |

### Repo Scope

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| foxglove/mcap | Core | Analyzed | Monorepo: format spec, C++/Go/Python/Rust/TypeScript/Swift implementations, CLI, conformance tests |
| foxglove/foxglove-sdk | Ecosystem | Noted | Foxglove platform SDK (C++, Python, Rust); uses MCAP internally. 270 stars |
| foxglove/ros-foxglove-bridge | Ecosystem | Noted | ROS 1/2 bridge for Foxglove viewer; uses MCAP for data transport. 285 stars |
| foxglove/nuscenes2mcap | Ecosystem | Noted | Converter from nuScenes dataset format to MCAP. 48 stars |
| foxglove/ws-protocol | Peripheral | Excluded | Archived (2025-08-05). WebSocket protocol for Foxglove viewer |
| foxglove/studio | Peripheral | Excluded | Archived (2024-07-18). Former open-source visualization tool, closed-sourced March 2024 |
| ros2/rosbag2 | Upstream/downstream | Linked | ROS 2 bag system; rosbag2_storage_mcap plugin makes MCAP the default storage backend |

**Discovery notes**: The foxglove GitHub org contains ~35 repos. Most are SDK wrappers, bridges, and dataset converters. MCAP itself is a monorepo containing all language implementations, the CLI, conformance tests, and the mcap.dev website. The format specification is published at mcap.dev/spec, not in a separate repo.

---

## Executive Summary

- **What it is**: Open-source container file format for multimodal log data (MIT license), serialization-agnostic (wraps Protobuf, ROS CDR, JSON, Flatbuffers), adopted as the default bag format in ROS 2 and NVIDIA Isaac ROS -- differentiates from competing formats by being self-contained, indexed for fast seeking, and language-agnostic with implementations in 6 languages.
- **Health verdict**: Watch — Active development (30 releases in 12mo, fast issue response) but critically low contributor diversity: Foxglove Technologies employees produce ~80% of commits with Elephant Factor of 1 (consolidated). No external governance, no CONTRIBUTING.md, no SECURITY.md.
- **Technical verdict**: Strong — clean, minimal design (container format, not a serialization format), lightweight implementations with few dependencies, cross-language conformance testing, and deep ROS 2 ecosystem integration. Well-suited purpose: append-only recording, chunk-based indexing, crash-safe writes.
- **Red Hat fit**: Align — MIT license, no CLA, minimal dependencies, ROS 2 default format (RHEL is ROS 2 Tier 2 platform), format spec is open and well-documented. MCAP is infrastructure (a file format), not a product -- low vendor lock-in risk despite single-vendor development. Red Hat would consume MCAP as a dependency, not downstream it.
- **Recommendation**: <!-- filled by: project-comparison, or manual assessment after both evals complete -->

---

## Part A: Community & Project Health

### CHAOSS Metrics

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | 1 org for 50% of commits | Low | Foxglove Technologies employees contribute ~80% of all commits. Top contributors (jtbandes, james-rms, wkalt, amacneil, defunctzombie, foxymiles, bennetthardwick, gasmith, bryfox) are all current or former Foxglove staff. Script reported 2 orgs because GitHub profile text varied ("foxglove", "CEO @foxglove") -- consolidated, it is a single-org project |
| **Contributor Absence Factor** | 3 people for 50% of commits | Watch | Top 3 (jtbandes 216, james-rms 177, wkalt 130) account for 50% of 1,046 total commits. 78 total contributors, but long tail is very thin |
| **Change Request Closure Ratio** | 226 opened / 217 closed (12mo) | Healthy (0.96) | 179 merged. Near-zero PR backlog growth. Most PRs are self-authored by Foxglove staff |
| **Time to First Response** | < 1 hour median (automated) | Fast | All PRs receive automated review from claude[bot] within minutes. Human review typically within 4-24 hours for internal PRs. External contributor PRs may wait days to weeks |
| **Release Frequency** | 30 releases in 12mo | Active | Per-language release tracks: Python v1.4.0, Go v1.9.0, Rust v0.25.0, C++ v2.1.3, CLI v0.2.0. All releases authored by Foxglove employees |
| **Contribution Trend** | Stable | Stable | Core team composition unchanged. amacneil (CEO) authored ~70 of last 100 PRs (Rust CLI rewrite in June 2026). External contributions exist but are minor: achim-k (24 commits), emersonknapp (5, Polymath Robotics/ROS 2 maintainer), facontidavide (C++ contributor). No new organizational contributors entering |
| **Libyears** | < 1 year | Current | Dependencies across all implementations are current. Rust deps pinned via Cargo.lock. Python/Go deps are minimal and up to date |

### Strategic Metrics

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | Permissive | MIT. Copyright Foxglove Technologies Inc. No patent grants, no unusual terms. Standard permissive license |
| **Governance model** | Single-vendor | No foundation affiliation. No GOVERNANCE.md, no CONTRIBUTING.md, no CODE_OF_CONDUCT.md, no SECURITY.md. Roadmap controlled by Foxglove Technologies. CODEOWNERS file lists exclusively Foxglove employees. Default owner: james-rms |
| **Contribution model** | None | No CLA or DCO required. External contributions accepted via standard GitHub PRs. No documented contribution guidelines |
| **Corporate control risk** | Medium | Foxglove employees produce ~80% of commits and control all releases. Trademark "MCAP" and the mcap.dev website owned by Foxglove. However, risk is mitigated by the nature of the project: MCAP is a file format specification, not a complex runtime. The spec is published and open. Multiple independent implementations could be written without access to Foxglove's codebase. The MIT license is irrevocable |
| **Community health** | Active | 30 releases in 12mo, fast issue response (1-3 days for bugs), active development. 991 stars, 216 forks. Discord community via Foxglove |
| **Ecosystem breadth** | Wide | Default bag format in ROS 2 (since Iron, May 2023). Default recording format in NVIDIA Isaac ROS 3.0 (May 2024). Rerun imports MCAP natively. Implementations in 6 languages (C++, Go, Python, Rust, TypeScript, Swift). CLI tool for inspection and manipulation. Used by Amazon, Anduril, NVIDIA, Wayve, Waabi, Dexterity, and hundreds of robotics companies |

### Governance Details

| Maintainer / Key Contributor | Employer | Role |
| --- | --- | --- |
| **Adrian Macneil (amacneil)** | Foxglove Technologies (CEO, co-founder) | Core maintainer; 125 commits. Authored ~70 of last 100 PRs (Rust CLI rewrite). All releases authored by him or other Foxglove staff |
| **Jacob Bandes-Storch (jtbandes)** | Foxglove Technologies | Core maintainer; 216 commits (highest all-time). CODEOWNER for C++ and TypeScript |
| **james-rms** | Foxglove Technologies (likely) | Core maintainer; 177 commits. Default CODEOWNER for entire repo |
| **Wyatt Alt (wkalt)** | Foxglove Technologies (likely, former) | Core contributor; 130 commits. Go implementation lead |
| **Roman Shtylman (defunctzombie)** | Foxglove Technologies (CTO, co-founder) | Core contributor; 46 commits |
| **John Hurliman (jhurliman)** | MetaverseIndustries (prev. Foxglove co-founder) | Early contributor; 60 commits. Authored the original format evaluation document |
| **Miles Egan (foxymiles)** | Foxglove Technologies | Contributor; 29 commits |
| **Bennett Hardwick (bennetthardwick)** | Foxglove Technologies | Contributor; 21 commits. Rust implementation |
| **Hans-Joachim Krauch (achim-k)** | Unknown | External contributor; 24 commits. Notable non-Foxglove contributor |
| **Emerson Knapp (emersonknapp)** | Polymath Robotics | External contributor; 5 commits. ROS 2 rosbag2 maintainer, bridged MCAP into ROS 2 ecosystem |

### Funding & Sustainability

**Company**: Foxglove Technologies Inc (San Francisco). Founded by Adrian Macneil (CEO, ex-Cruise) and Roman Shtylman (CTO, ex-Cruise).

**Total funding**: $58.7M across 3 rounds.

- **Seed** (January 2022): undisclosed amount, Amplify Partners
- **Series A**: undisclosed
- **Series B** (November 2025): $40M led by Bessemer Venture Partners, with Eclipse and Amplify Partners. Angel investors include Kyle Vogt (Cruise founder)

**Team size**: ~88 employees as of May 2026 (approximately half engineers).

**Business model**: SaaS data infrastructure platform for robotics ("Datadog for robotics"). Cloud, on-premises, and air-gapped deployment options. Foxglove closed-sourced its visualization tool in March 2024 (Foxglove 2.0) while keeping MCAP and SDKs open source (MIT). 2023 revenue: $4.1M.

**Sustainability assessment**: MCAP's sustainability risk is lower than typical single-vendor OSS projects for a specific reason: MCAP is a file format specification, not a complex application. Even if Foxglove Technologies withdrew entirely, the published specification at mcap.dev/spec and the MIT-licensed implementations in 6 languages would allow the community to maintain the format. The ROS 2 ecosystem (via rosbag2_storage_mcap) has its own stake in MCAP's continuity. The format is simple enough that independent implementations can be written from the spec -- in fact, Rerun wrote their own MCAP reader (re_mcap crate) independently. The risk is not format abandonment but rather format evolution: Foxglove controls what goes into the next version of the spec.

**What happens if Foxglove withdraws**: The format spec and all implementations remain MIT-licensed. ROS 2's rosbag2_storage_mcap plugin is maintained within the ROS 2 ecosystem (ros2/rosbag2 repo), not by Foxglove. The format would remain usable but unlikely to evolve. No foundation exists to take stewardship. Community could fork and maintain given the simplicity of the codebase (~72K LOC across all languages).

---

## Part B: Technical Analysis

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | Clear | Deliberately minimal: MCAP is a container format (like AVI for video), not a serialization format. Clean separation between the container layer (chunks, indexes, summary) and the message layer (user-chosen serialization: Protobuf, CDR, JSON, Flatbuffers). Each language implementation is self-contained with no cross-language build dependencies |
| **Tech stack alignment** | Aligned | Pure library with no runtime requirements. C++17 header-only option, Python pip-installable, Rust crate, Go module. No GPU dependency, no cloud dependency, no container requirement. Works on any platform. ROS 2 integration is the primary consumption path for Red Hat |
| **Dependency health** | Healthy | Deliberately minimal dependencies across all implementations. Rust: 8 runtime deps (binrw, byteorder, crc32fast, enumset, log, paste, thiserror, static_assertions) + optional zstd/lz4. Go: 2 deps (klauspost/compress, pierrec/lz4). Python: 2 deps (lz4, zstandard). C++: header-only with optional LZ4/Zstd. No single-maintainer critical deps |
| **Test coverage** | Strong | Cross-language conformance test suite ensures all implementations produce and consume identical output. Per-language unit tests (Go: 6 test files, Python: test_reader.py + test_writer.py, Rust: tests/, C++: unit_tests.cpp). Benchmarks in Rust (criterion) and TypeScript. Test data corpus in testdata/ directory |
| **Security posture** | Weak | OpenSSF Scorecard: 4.3/10. No SECURITY.md, no signed releases, no SBOM, no fuzzing, no SAST. Code review score 1/10 (only 5/28 changesets approved -- most PRs merged by author). Dependencies not pinned by hash in CI. Typical for a single-vendor project prioritizing velocity over supply-chain hardening |
| **Code quality signals** | Adequate | Format enforcement per language: Rust (cargo fmt), Go (golangci-lint), C++ (clang-format), TypeScript (prettier), Swift (swiftformat/swiftlint). Spell checking via typos and cspell. Automated AI code review (claude[bot]). Moderate TODO density. ~72K LOC total across all languages -- small, focused codebase |
| **Extensibility** | SDK | MCAP is consumed as a library. Extension points: custom message encodings (any serialization format can be stored), custom metadata and attachments, custom compression. No plugin API needed -- the format is the interface |
| **Hardware portability** | Portable | Pure software, no hardware requirements. Runs on any platform with a C/Go/Python/Rust/TS/Swift toolchain. No GPU dependency. WASM target supported for TypeScript. Tested on Linux and Windows in CI |

### Architecture Overview

MCAP's design is a container file format with the following structure:

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **Header** | Magic bytes (`\x89MCAP0\r\n`), library version, profile identifier | None |
| **Schema records** | Define message schemas (e.g., Protobuf FileDescriptorSet, ROS 2 .msg definition, JSON Schema) | None |
| **Channel records** | Associate a channel ID with a schema, topic name, and message encoding (e.g., "protobuf", "cdr", "json") | Schema records |
| **Message records** | Timestamped, serialized message data on a channel. Format-agnostic: MCAP stores raw bytes | Channel records |
| **Chunks** | Groups of messages compressed together (LZ4 or Zstd). Configurable chunk size (default 1MB). Each chunk is independently decompressible | Optional compression (LZ4, Zstd) |
| **Chunk indexes** | Per-chunk index of message offsets and timestamps. Enables seeking within a chunk without full decompression | None |
| **Attachment records** | Arbitrary binary data (calibration files, configuration, images) attached to the file | None |
| **Metadata records** | Key-value pairs for file-level metadata (recording device, software version, etc.) | None |
| **Summary section** | Aggregated statistics and indexes at the end of the file. Enables fast seeking to any timestamp without reading all chunks | None |
| **Summary offset section** | Index into the summary section itself, for very large files with many channels | None |
| **Footer** | Pointer to summary section offset. Enables readers to start from the end of the file for fast random access | None |

### Data Flow

```text
Application (sensor data, ROS 2 messages, custom data)
    | serialize with chosen format (Protobuf, CDR, JSON, Flatbuffers)
Message records (raw serialized bytes + timestamp + channel ID)
    | group into chunks (configurable size, default 1MB)
Chunks (optionally compressed: LZ4 or Zstd)
    | write sequentially (append-only)
MCAP file on disk
    | summary section written at end (or omitted for streaming writes)
Random access (read summary → seek to chunk → decompress → read message)
```

**Key design decisions**:

- **Append-only writes**: Messages are written sequentially. The summary section is written last (at file close). This means a crash during recording produces a valid but unindexed file -- readers can still recover all messages by linear scan. The `mcap recover` CLI command can rebuild the index
- **Serialization-agnostic**: MCAP does not interpret message content. It stores raw bytes plus a schema record that describes the encoding. This means MCAP works with any serialization format (Protobuf, CDR, JSON, Flatbuffers, MessagePack, custom binary) without any code changes
- **Self-contained**: Unlike ROS 1 bags (which required external .msg files for deserialization) and ROS 2 .db3 files (which required the message type to be installed), MCAP files embed the full schema definition. A file recorded 5 years ago can be read without any external dependencies
- **Chunk-based compression**: Messages are grouped into chunks and compressed together (better compression ratio than per-message). Each chunk is independently decompressible, enabling parallel reads and random access without decompressing the entire file

### Storage: MCAP vs Competing Formats

| Dimension | MCAP (Foxglove) | .rrd (Rerun Technologies) | ROS 1 .bag | ROS 2 .db3 (SQLite3) |
| --- | --- | --- | --- | --- |
| **Data model** | Message-oriented (serialized blobs) | Column-chunk (Arrow columnar batches) | Message-oriented | Message-oriented (SQLite rows) |
| **Schema storage** | Embedded in file (self-contained) | Arrow schema with FlatBuffers types | External (.msg files required) | External (message type must be installed) |
| **Serialization** | Any (Protobuf, CDR, JSON, etc.) | Apache Arrow only | ROS serialization only | CDR only |
| **Indexing** | Chunk-based with summary section | Entity path + timeline + time | Connection-based index | SQLite index |
| **Compression** | LZ4, Zstd (per-chunk) | None (Arrow IPC) | BZ2, LZ4 (per-chunk) | None |
| **Random access** | Fast (summary section) | Fast (in-memory index) | Fast (index at end) | Fast (SQLite queries) |
| **Crash safety** | Append-only; recoverable | Append-only | Append-only; recoverable | SQLite WAL |
| **Ecosystem** | ROS 2 default, NVIDIA Isaac, broad | Rerun-specific | ROS 1 only | ROS 2 (pre-Iron) |
| **License** | MIT | MIT/Apache-2.0 | BSD | Apache-2.0 |

### Language Implementations

| Language | Package | Version | Read | Write | Dependencies (runtime) |
| --- | --- | --- | --- | --- | --- |
| **C++** | mcap (Conan) | 2.1.3 | Yes | Yes | Header-only core; optional LZ4, Zstd |
| **Go** | github.com/foxglove/mcap/go/mcap | v1.9.0 | Yes | Yes | klauspost/compress, pierrec/lz4 |
| **Python** | mcap (PyPI) | 1.4.0 | Yes | Yes | lz4, zstandard |
| **Rust** | mcap (crates.io) | 0.25.0 | Yes | Yes | binrw, crc32fast, lz4, zstd (+ 5 small deps) |
| **TypeScript** | @mcap/core (npm) | 2.1.7 | Yes | Yes | None (zero dependencies) |
| **Swift** | mcap (SPM) | via releases | Yes | Yes | Minimal |

**Python extension packages** (separate PyPI packages):

- `mcap-protobuf-support` — Protobuf message decoding (depends on protobuf>=4.25)
- `mcap-ros1-support` — ROS 1 message decoding
- `mcap-ros2-support` — ROS 2 CDR message decoding

### Dependency Analysis

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **lz4** (various per lang) | varies | BSD/MIT | Compression. Well-maintained across all language ecosystems |
| **zstd** (various per lang) | varies | BSD/MIT | Compression. Facebook-originated, widely adopted |
| **binrw** (Rust) | 0.15 | MIT | Binary read/write derive macros. Active, 8 contributors |
| **crc32fast** (Rust) | 1.3 | MIT/Apache-2.0 | CRC32 computation. Well-maintained |
| **klauspost/compress** (Go) | 1.16.7 | BSD-3 | Compression library. Well-maintained (Klaus Post) |
| **protobuf** (Python, optional) | >=4.25 | BSD-3 | Google's protobuf library. Well-maintained |

**Supply chain note**: MCAP implementations are deliberately minimal. The core libraries depend only on compression (LZ4/Zstd) and basic I/O utilities. The TypeScript implementation has zero runtime dependencies. This is a conscious design choice documented in the format evaluation paper.

### Capabilities & Positioning

| Capability | Detail |
| --- | --- |
| **Serialization-agnostic container** | Stores any serialized data format: Protobuf, ROS 1/2 CDR, JSON, Flatbuffers, CBOR, MessagePack, custom binary. Schema embedded for self-describing files |
| **Fast random access** | Summary section at file end enables O(1) seek to any timestamp. Chunk indexes enable efficient range queries without full decompression |
| **Crash-safe recording** | Append-only write design. If recording process crashes, all completed chunks are valid. `mcap recover` CLI can rebuild missing summary/index from linear scan |
| **Multi-language support** | Full read/write implementations in 6 languages (C++, Go, Python, Rust, TypeScript, Swift). Cross-language conformance test suite ensures interoperability |
| **ROS 2 native integration** | Default bag format since ROS 2 Iron (May 2023). rosbag2_storage_mcap plugin in ros2/rosbag2. Supports `fastwrite` preset for resource-constrained robots (no CRC, no message index) |
| **CLI tooling** | `mcap` CLI (recently rewritten in Rust): inspect, merge, split, recover, filter, convert. Available via Homebrew and GitHub releases |
| **Attachments and metadata** | Arbitrary binary attachments (calibration data, configuration files) and key-value metadata records embedded in the file. No need for sidecar files |
| **Compression** | Per-chunk LZ4 or Zstd compression. Configurable chunk size. Independent decompression enables parallel reads |

### Lock-in Assessment

| Dimension | Risk | Detail |
| --- | --- | --- |
| **Hardware** | Low | Pure software library with no hardware requirements. Runs on any platform. No GPU, no cloud, no specific OS |
| **Vendor** | Low | MIT license is irrevocable. Format specification is published at mcap.dev/spec. Multiple independent implementations exist (Foxglove's official ones + Rerun's re_mcap + ROS 2 rosbag2_storage_mcap). Even if Foxglove abandons the project, the format and implementations remain usable. Foxglove controls spec evolution but cannot restrict existing usage |
| **Ecosystem** | Medium | MCAP is the ROS 2 default bag format. Data recorded in MCAP is portable (self-contained, schema-embedded), but the tooling ecosystem (Foxglove viewer for visualization, mcap CLI for manipulation) has limited alternatives. Rerun can import MCAP but not export it. No MCAP-to-training-format converter is standard (requires custom pipelines to convert MCAP to HDF5/RLDS/Zarr for ML training) |

### Production Adoption

| User | Use Case |
| --- | --- |
| **ROS 2 ecosystem** | Default bag format since Iron (May 2023). Every ROS 2 Iron/Jazzy/Kilted user records data in MCAP by default. 984M ROS 2 package downloads in 2025 |
| **NVIDIA (Isaac ROS)** | Default recording format in Isaac ROS 3.0 (May 2024). isaac_ros_data_recorder writes MCAP with H.264-compressed camera streams via NVENC |
| **Amazon** | Named Foxglove/MCAP customer (Series B announcement) |
| **Anduril** | Named Foxglove/MCAP customer — defense robotics |
| **Wayve** | Named Foxglove/MCAP customer — autonomous driving |
| **Waabi** | Named Foxglove/MCAP customer — autonomous trucking |
| **Dexterity** | Named Foxglove/MCAP customer — warehouse robotics |
| **Rerun Technologies** | MCAP importer in Rerun viewer (since v0.25, ~October 2025). Reads MCAP files and converts to Rerun's internal format for visualization |

### Build & CI

| Aspect | Details |
| --- | --- |
| **Build system** | Per-language: Conan (C++), Go modules, setuptools (Python), Cargo (Rust), Yarn (TypeScript), Swift Package Manager. No unified build system -- each language is independent |
| **CI** | GitHub Actions — single ci.yml workflow. Per-language jobs: C++ (clang + gcc, Linux + Windows), Go (lint + test), Python (lint + test), Rust (clippy + test + bench), TypeScript (lint + test), Swift (test). Cross-language conformance tests |
| **Reproducibility** | Cargo.lock (Rust), yarn.lock (TypeScript) committed. Go modules pinned. Python deps not locked (setup.cfg specifies ranges). C++ deps via Conan cache |
| **Platforms tested** | Linux (Ubuntu), Windows (C++ only), macOS (Swift only). No ARM-specific CI but no architecture-specific code |

### Backlog Health

| Metric | Value |
| --- | --- |
| **Open issues** | ~30 (GitHub reports 38 including PRs) |
| **Stars** | 991 |
| **Forks** | 216 |
| **Open PRs** | ~9 |
| **Median issue response time** | 1-3 days for bugs |
| **Release cadence** | Very active: 30 releases in last 12 months across all language packages |
| **OpenSSF Scorecard** | 4.3/10 (strong on maintenance, weak on security practices) |

---

## Red Hat Platform Fit Assessment

### Alignment Signals

- **MIT license** — fully compatible with downstream redistribution. No CLA, no contribution friction
- **ROS 2 default format** — RHEL is ROS 2 Tier 2 platform. Any Red Hat investment in ROS 2 implicitly depends on MCAP. Red Hat is OSRA Gold member
- **Minimal dependencies** — small supply chain surface. No transitive dependency risks. Libraries are lightweight and self-contained
- **No GPU/cloud/container dependency** — pure library, runs anywhere. Fits edge (RHEL for Edge), datacenter (RHEL), and container (OpenShift) deployments equally
- **Format is the interface** — MCAP is consumed as a file format, not as a runtime service. Low integration risk. Data written in MCAP by any implementation is readable by any other
- **Self-contained files** — embedded schemas mean MCAP files are portable across environments without external dependencies. Important for air-gapped and edge deployments
- **NVIDIA alignment** — Isaac ROS 3.0 adopted MCAP as default. Red Hat's NVIDIA partnership benefits from shared data format standardization

### Risk Signals

- **Single-vendor development**: Foxglove Technologies employees produce ~80% of commits and control all releases. No external maintainers with significant contributions. However, the risk is mitigated by MCAP being a file format (not a complex application): the spec is published, implementations are small, and independent implementations exist (Rerun's re_mcap)
- **No security practices**: OpenSSF Scorecard 4.3/10. No SECURITY.md, no signed releases, no fuzzing, no SAST. File format parsers are a known attack surface -- a malicious MCAP file could exploit parser bugs. Red Hat would need to assess parser security if shipping MCAP libraries
- **No governance**: No foundation, no steering committee, no contribution guidelines. Foxglove controls the format specification. Spec evolution is at Foxglove's discretion
- **Foxglove closed-sourcing history**: Foxglove closed-sourced its visualization tool in March 2024. While MCAP remains MIT-licensed, this demonstrates willingness to change licensing on related products. The MIT license on MCAP is irrevocable, but Foxglove could theoretically create a proprietary "MCAP 2.0" specification
- **Pre-1.0 Rust implementation**: Rust mcap crate is at v0.25.0 (pre-1.0). API may have breaking changes. Go and C++ implementations are at v1.x (stable)
- **Training pipeline gap**: MCAP is a recording format, not a training format. Converting MCAP data to ML training formats (HDF5, RLDS, Zarr, LeRobot) requires custom tooling. No standard converter exists

### Supply Chain Assessment

- **License conflicts**: None. All MCAP dependencies are MIT, BSD, or Apache-2.0. No copyleft in the dependency tree
- **Known CVEs**: No known CVEs against MCAP libraries. Dependencies (lz4, zstd, protobuf) are well-maintained and actively patched
- **Single-maintainer risks**: No single-maintainer critical dependencies. lz4 and zstd are maintained by large organizations (Facebook for zstd, Yann Collet for lz4). TypeScript implementation has zero dependencies

---

## Sources

- [MCAP GitHub repository](https://github.com/foxglove/mcap)
- [MCAP website and specification](https://mcap.dev/)
- [MCAP format specification](https://mcap.dev/spec)
- [MCAP format evaluation paper](https://mcap.dev/files/evaluation.pdf)
- [Foxglove blog: MCAP as the ROS 2 Default Bag Format](https://foxglove.dev/blog/mcap-as-the-ros2-default-bag-format)
- [Open Robotics Discourse: Default bag storage format changing to MCAP](https://discourse.openrobotics.org/t/psa-default-ros-2-bag-storage-format-is-changing-to-mcap-in-iron/28489)
- [Foxglove blog: NVIDIA announces MCAP as default for Isaac ROS 3.0](https://foxglove.dev/blog/nvidia-announces-mcap-as-the-default-logging-format-for-isaac-ros-3-0)
- [Rerun blog: Introducing Experimental MCAP Support](https://rerun.io/blog/introducing-experimental-support-for-mcap-file-format)
- [Foxglove Series B announcement](https://foxglove.dev/blog/foxglove-series-b)
- [VentureBeat: Foxglove raises $40M Series B](https://venturebeat.com/business/foxglove-raises-40-million-series-b-to-power-the-future-of-physical-ai/)
- [The Robot Report: Foxglove raises $40M](https://www.therobotreport.com/foxglove-raises-40m-scale-data-platform-roboticists/)
- [Foxglove blog: Foxglove 2.x vs 1.x](https://foxglove.dev/blog/foxglove-2-vs-foxglove-1)
- [OpenSSF Scorecard: foxglove/mcap](https://scorecard.dev/viewer/?uri=github.com/foxglove/mcap)
- [ROS 2 rosbag2_storage_mcap](https://github.com/ros2/rosbag2/tree/rolling/rosbag2_storage_mcap)
- [Foxglove company intel](../companies/) <!-- link if Foxglove profile exists -->
