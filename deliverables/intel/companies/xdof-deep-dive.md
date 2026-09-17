# XDOF — Deep Dive Research

**Date**: 2026-09-16
**Last updated**: 2026-09-16
**Classification**: Internal analysis — not for public repo

Supporting research for the [XDOF competitive profile](xdof.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, acquisition deep-dives, product architectures, governance risks, and technical dependency chains.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2024 (founding) | Founded by Philipp Wu (CEO), Fred Shentu (CTO), Nemo Jin (COO) — UC Berkeley spinout based on GELLO teleoperation research |
| 2024-10 | Company launch (stealth mode) |
| 2026-06 | Emerged from stealth with $70M Series A from Thrive Capital, Andreessen Horowitz, Lux, Spark Capital, WndrCo |
| 2026-06 | Released ABC-130K dataset (130K+ episodes, Apache 2.0) in partnership with UC Berkeley BAIR |
| 2026-09 | In talks for Series B at $1.2B valuation (led by 8VC) — just 3 months after stealth exit |
| 2026 (ongoing) | ~$50M ARR, 60 employees, ~20 customers including frontier AI labs |

**Funding velocity**: $70M Series A → $1.2B Series B talks in 3 months represents one of fastest valuation ramps in Physical AI data infrastructure. Driven by ~$50M ARR traction and frontier lab customer validation.

### Acquisitions — What Each Brought

<!-- TODO: deep research needed --> No acquisitions identified. XDOF is a greenfield startup from UC Berkeley research.

---

## 2. Product Architecture Details

### ABC-130K Dataset

| Aspect | Details |
| --- | --- |
| **Architecture** | 130,919 episodes (43,090 annotated) totaling 3,553 hours. Collected on $8K bimanual YAM rigs (two 6-DoF arms, parallel-jaw grippers). 195 tasks: pick-and-place, folding, sorting, handover, insertion, tool use, assembly. MCAP file format: episodes as primary files, subtask annotations as separate artifacts (revisable/extendable independently). Three camera views (one top, two wrist), joint states, end-effector poses, gripper aperture, task/subtask annotations. 400 hours of accompanying sim-teleop data. |
| **Runtime dependencies** | MCAP readers (Foxglove ecosystem), behavior cloning training frameworks. Compatible with ABC behavior cloning stack (UC Berkeley, MIT, Amazon FAR, XDOF collaboration). |
| **Extension model** | Apache 2.0 license on Hugging Face (XDOF/ABC-130k, also mirrored at Voxel51/ABC-130k). Community can extend tasks, add annotations, build on dataset. |
| **Key limitations** | Bimanual focus only (not single-arm, not mobile manipulation). $8K YAM rig embodiment may not transfer perfectly to other robot platforms. "White walls" environment — limited visual diversity compared to real-world deployment scenarios. |

### GELLO Teleoperation Rig

| Aspect | Details |
| --- | --- |
| **Architecture** | Low-cost leader arm rebuilt from hobby-grade Dynamixel servos ($300/arm) + 3D-printed parts. Encoder-only design (passive, no motors on leader). Operator manipulates leader arm; follower robot arm mirrors movements. Designed for academic lab adoption (low cost, reproducible). |
| **Runtime dependencies** | Dynamixel servos (hobby-grade), 3D printer for parts. Compatible with various follower robots (YAM arms, other 6-DoF manipulators). |
| **Extension model** | Open research from UC Berkeley — design widely adopted in academic labs before XDOF commercialization. XDOF now sells commercial ABC Box hardware that's GELLO-compatible. |
| **Key limitations** | Passive leader (no force feedback). Lower precision than professional teleoperation systems. Bimanual setup doubles cost ($600 for two arms). |

### ABC Box Hardware

| Aspect | Details |
| --- | --- |
| **Architecture** | <!-- TODO: deep research needed --> GELLO-compatible teleoperation hardware product. Pairs with passive encoder-only leader arms or YAM leader arms. Tied to ABC behavior cloning stack. Exact technical specs not publicly documented. |
| **Runtime dependencies** | GELLO-compatible leader arms, follower robot arms, ABC software stack. |
| **Extension model** | Commercial product (not open source). Integrates with ABC open-source behavior cloning stack. |
| **Key limitations** | <!-- TODO: deep research needed --> Pricing, availability, full specifications not disclosed publicly. |

### Data Collection Services

| Aspect | Details |
| --- | --- |
| **Architecture** | Three-tier data pyramid: (1) **Bespoke teleoperation**: Robot-specific data collected via remote operation of customer's exact robot embodiment. Highest fidelity, task-specific. (2) **Generalized teleoperation**: GELLO-style data on standard rigs (YAM, etc.). Transferable across similar robots. (3) **Egocentric data** (planned): Wearable-sensor data capturing humans performing everyday tasks. Broadest coverage, lowest robot-specificity. Proprietary task design, quality-control methods, transformation pipelines. |
| **Runtime dependencies** | XDOF teleoperation rigs (bespoke per customer robot or generalized YAM rigs), wearable sensors (future), human operators, annotation workforce. |
| **Extension model** | Services model — customers contract for data collection at scale. XDOF provides end-to-end pipeline: rig deployment, operator training, data collection, cleaning, annotation, delivery in customer-specified format. |
| **Key limitations** | Human-in-the-loop bottleneck — scales linearly with operator hours. "Dirty, unglamorous work" (TechCrunch characterization) — labor-intensive vs automated approaches (simulation). Cost per data sample likely higher than sim data. |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **ABC-130K Dataset** | MCAP format (Foxglove, Apache 2.0) | Apache 2.0 (dataset itself) | 130K+ episodes of human-teleoperated bimanual manipulation; proprietary collection process (rig design, task design, operator training, QC) |
| **GELLO Rig** | Open UC Berkeley research | Academic open research (not formal OSS license) | Commercialization via ABC Box hardware product |
| **ABC Box / Data Services** | ABC behavior cloning stack (UC Berkeley, MIT, Amazon FAR collaboration) | Unknown (ABC stack license unclear) | Proprietary commercial hardware, proprietary data collection pipeline, annotation services |

### Pattern Analysis

XDOF follows a **"open dataset, proprietary infrastructure"** strategy similar to Hugging Face's model: release high-quality open datasets (ABC-130K) to build brand/trust/ecosystem, monetize via proprietary infrastructure (teleoperation rigs, collection services, annotation pipelines) that customers can't easily replicate.

**GELLO → ABC Box commercialization**: GELLO started as open UC Berkeley research ($300/arm academic rig). XDOF founders (Wu/Shentu) built GELLO, then commercialized it via ABC Box hardware product. This academic-to-commercial pipeline mirrors how many robotics startups (Boston Dynamics from MIT, Skydio from MIT, etc.) commercialize university research.

**ABC stack collaboration**: UC Berkeley + MIT + Amazon FAR + XDOF collaboration on ABC behavior cloning stack suggests XDOF positions as **ecosystem builder** not just vendor. Sharing OSS tooling while monetizing data/services.

### Notable Dependencies

- **MCAP format**: Complete dependency on Foxglove's MCAP file format for episode storage. MCAP is Foxglove's open format (Apache 2.0) designed for robotics data logging. If MCAP becomes standard (similar to how ROS bags were de facto standard), XDOF benefits from format adoption; if competing formats win (e.g., proprietary formats from other data providers), XDOF may need migration tooling.
- **UC Berkeley BAIR relationship**: Co-release of ABC-130K + ABC stack collaboration provides academic credibility and research talent pipeline. Risk if relationship deteriorates or Berkeley launches competing commercial effort.
- **Hugging Face hosting**: ABC-130K hosted on Hugging Face Datasets (XDOF/ABC-130k). Dependency on Hugging Face infrastructure for dataset distribution, discovery, community engagement.

### MCAP Format as Strategic Choice

**Why MCAP matters**: Foxglove's MCAP format is designed for robotics time-series data (sensor streams, joint states, video). Compared to alternatives (ROS bags, HDF5, custom formats), MCAP offers:

- **Indexed access** (random access to data without full scan)
- **Efficient storage** (compression, chunking)
- **Schema evolution** (forward/backward compatibility)
- **Tooling ecosystem** (Foxglove Studio for visualization/analysis)

**XDOF's bet**: Using MCAP ties XDOF's dataset to Foxglove's tooling but benefits from ecosystem investment Foxglove makes in format/tools. If MCAP becomes standard (similar to OpenUSD for sim data), XDOF's early adoption creates advantage. If MCAP doesn't win format war, XDOF bears migration cost.

---

## 4. Governance & Community Risk

<!-- Not applicable — XDOF does not steward any OSS projects beyond dataset release. ABC-130K is Apache 2.0 with no governance body (pure data release, not maintained software). UC Berkeley BAIR collaboration is research partnership, not governance structure. -->

**Open dataset strategy risk**: ABC-130K (Apache 2.0) is fully open — anyone can use/modify/commercialize without attribution. This is intentional (drives ecosystem adoption) but means competitors could build on XDOF's data without reciprocity. XDOF's moat is **collection infrastructure**, not dataset IP.

---

## 5. Hardware Platform Details

### GELLO Rig Technical Specifications

| Aspect | Details |
| --- | --- |
| **Cost** | ~$300/arm (Dynamixel servos + printed parts) |
| **Design** | Passive encoder-only leader (no motors on leader side) |
| **DoF** | Matches follower robot (typically 6-DoF for YAM arms) |
| **Force feedback** | None (passive design) |
| **Adoption** | Widely adopted in academic labs before XDOF commercialization |

### ABC Box (Commercial Product)

<!-- TODO: deep research needed --> Full specifications, pricing, availability not publicly documented. Marketed as GELLO-compatible, pairs with YAM or passive encoder leaders.

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **UC Berkeley BAIR** | N/A (research partner) | Co-release ABC-130K dataset, ABC behavior cloning stack collaboration. GELLO rig originated from Wu/Shentu's research at Berkeley. | Deep collaboration — joint dataset release, shared tooling (ABC stack) |
| **MIT, Amazon FAR** | N/A (research collaborators) | ABC behavior cloning stack co-development | Unknown integration depth beyond ABC stack collaboration |
| **Frontier AI Labs** | ~20 customers total, "several" frontier labs | Customers for data collection services (names not disclosed). CEO: "All of the top labs are trying to pursue robotics." | Service integration — XDOF provides teleoperation data at scale for robot foundation model training |

### Developer Ecosystem

**Hugging Face presence**: ABC-130K hosted on Hugging Face Datasets (XDOF/ABC-130k, mirrored at Voxel51/ABC-130k) provides distribution, discoverability, community engagement. Hugging Face's robotics community can discover/use dataset, cite in papers, build models.

**Academic adoption via GELLO**: GELLO's open research origins + low cost ($300/arm) drove adoption in academic labs. These labs become potential customers for ABC Box hardware or XDOF data services as they transition to commercial-scale training.

**No public community programs** identified — no Discord, Slack, GitHub org beyond dataset release. Focus appears to be B2B services sales to frontier labs, not community-driven ecosystem building.

---

## 7. Detailed Competitive Analysis

### vs Scale AI

| Dimension | XDOF | Scale AI |
| --- | --- | --- |
| **Data type focus** | Physical robot teleoperation data (bimanual manipulation) | Multi-modal annotation (text, image, video, lidar, 3D) — robotics is one vertical |
| **Business model** | Infrastructure-as-a-service (rigs, pipelines, annotation) | Annotation-as-a-service (human labelers + tools) |
| **OSS contribution** | ABC-130K (130K episodes, Apache 2.0) | Limited open datasets (focus on proprietary tools) |
| **Founding/maturity** | Founded 2024, emerged stealth June 2026 | Founded 2016, mature public company trajectory |
| **Revenue scale** | ~$50M ARR (Sep 2026) | $1B+ ARR (public company scale) |
| **Valuation** | $1.2B Series B talks (Sep 2026) | Multi-billion public company |
| **Moat** | Proprietary teleoperation infrastructure (task design, QC, transformation pipelines) | Annotation platform, global labeling workforce, multi-vertical customer base |

**Assessment**: XDOF is **narrow-but-deep** in robotics teleoperation vs Scale AI's **broad annotation platform**. XDOF's "pipelines not labels" positioning suggests infrastructure play (selling collection systems) vs Scale's labor arbitrage model (selling annotator access). XDOF's rapid growth ($1.2B in <6 months) validates robotics data as high-value vertical.

### vs Mecka

| Dimension | XDOF | Mecka |
| --- | --- | --- |
| **Funding** | $70M Series A (June 2026), $1.2B Series B talks (Sep 2026) | $68M total ($8M seed Aug 2025, $25M + $35M Series A Jun 2026) |
| **Revenue** | ~$50M ARR | $100M ARR claim from signed contracts |
| **Dataset** | ABC-130K (130K episodes, Apache 2.0 open source) | Unknown dataset size/openness |
| **Academic pedigree** | UC Berkeley BAIR partnership, GELLO rig from research | Unknown academic ties |
| **Investors** | Thrive, a16z, Lux, Spark, WndrCo, 8VC (Series B) | Neo (seed), Framework Ventures (Series A) |

**Assessment**: Mecka claims higher ARR ($100M vs XDOF's ~$50M) but XDOF's valuation momentum ($1.2B talks 3 months post-launch) suggests investor conviction in growth trajectory. XDOF's open dataset strategy (ABC-130K) vs Mecka's unknown dataset approach represents different GTM: ecosystem-building vs proprietary data.

### vs Config

| Dimension | XDOF | Config |
| --- | --- | --- |
| **Funding** | $70M Series A (larger round) | $27M seed at $200M valuation |
| **Geography** | U.S.-focused (UC Berkeley roots) | Seoul/San Jose — dual Asia-Pacific + U.S. presence |
| **Positioning** | "Outsourced data-supply chain for robotics industry" | "Data infrastructure for general-purpose bimanual robotics" |
| **Investors** | Thrive, a16z, Lux (U.S. VCs) | Samsung Venture Investment (Korean manufacturing connection) |
| **Dataset** | ABC-130K (130K episodes, open source) | Unknown |

**Assessment**: Config's Samsung Venture Investment backing suggests **Korean manufacturing market** focus (different customer base than XDOF's U.S. frontier labs). Config's dual Seoul/San Jose presence enables Asia-Pacific expansion XDOF lacks. XDOF's larger funding + open dataset suggests U.S. ecosystem dominance strategy.

---

## Sources

- [XDOF raises $70M Series A — TechCrunch](https://techcrunch.com/2026/06/17/collecting-robot-training-data-is-dirty-unglamorous-work-some-ai-labs-are-already-paying-xdof-to-do-it/)
- [XDOF Series B talks at $1.2B valuation — TechCrunch](https://techcrunch.com/2026/09/04/xdof-just-three-months-out-of-stealth-is-in-talks-for-a-series-b-at-a-1-2b-valuation/)
- [ABC-130K dataset — Hugging Face](https://huggingface.co/datasets/XDOF/ABC-130k)
- [ABC-130K announcement — XDOF blog](https://www.xdof.ai/blog/abc-130k)
- [XDOF teleoperation rig overview — Pebblous](https://blog.pebblous.ai/blog/xdof-teleoperation-data-collection-rig/en/)
- [XDOF company overview — Altis Research](https://www.altis.vc/research/companies/xdof)
- [Robot Training Data Companies: The 2026 Landscape — DreamVu](https://www.dreamvu.ai/blog/robot-training-data-companies-2026)
- [XDOF funding — Dealroom](https://dealroom.co/news/135015-xdof-raises-70m-to-build-the-data-pipelines-for-training-robots/)
