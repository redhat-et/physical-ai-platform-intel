# Scale AI -- Deep Dive Research

**Date**: 2026-09-11
**Last updated**: 2026-09-11
**Classification**: Internal analysis

Supporting research for the [Scale AI competitive profile](scale-ai.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, product architectures, governance risks, and technical dependency chains.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2016 | Founded by Alexandr Wang and Lucy Guo through Y Combinator. Initial focus: API for data labeling |
| 2017 | Series A ($4.5M, Accel). Early customers in autonomous driving perception |
| 2019 | Series C ($100M, Founders Fund / Peter Thiel). Crossed $1B valuation (unicorn status) |
| 2021-04 | Series E ($325M at $7.3B valuation) |
| 2023-05 | First AI company to deploy LLM on classified U.S. Army network |
| 2023-11 | SEAL leaderboards launched for LLM evaluation |
| 2024-05 | Series F ($1B at $14B valuation, led by Accel) |
| 2025-03 | Thunderforge prime contract for Pentagon AI mission planning |
| 2025-08 | $99M Army R&D contract (Aberdeen Proving Ground) |
| 2025-09 | Physical AI Data Engine launched. $100M five-year CDAO agreement. 100K+ production hours logged at SF lab |
| 2025-06 | Meta acquires 49% non-voting stake ($14.3B at $29B valuation). Alexandr Wang departs for Meta as Chief AI Officer. Jason Droege (CSO) becomes Interim CEO |
| 2025-H2 | Customer departures: Google ($200M/yr contract canceled), OpenAI, xAI reduce engagement. 14% staff layoff |
| 2026-03 | Scale Labs launched (expanded from SEAL). S-1 filed confidentially with SEC. UR AI Trainer partnership announced at GTC |
| 2026-05 | CDAO contract expanded to $500M enterprise agreement |
| 2026-07 | Series G ($1.1B). Total raised: $4.1B. Valuation: $28-30B |
| 2026-08 | Francis deSouza (ex-Google Cloud COO, ex-Illumina CEO) appointed CEO |

### Acquisitions -- What Each Brought

<!-- TODO: Scale AI has not made publicly known acquisitions in the Physical AI space.
     The company has grown organically. Monitor for acqui-hires of robotics teams. -->

No publicly disclosed acquisitions relevant to Physical AI. Growth has been organic, with key hires from robotics labs and the establishment of in-house robotics research capabilities at the San Francisco lab.

---

## 2. Product Architecture Details

### Physical AI Data Engine

| Aspect | Details |
| --- | --- |
| **Architecture** | Three-tier collection: (1) centralized data factories with bimanual manipulators, (2) distributed residential/commercial collectors using Scale Harness (robotless egocentric platform), (3) bespoke customer hardware managed by Scale. Petabyte-scale ingestion infrastructure. Multi-modal grounding annotations applied to all demonstrations |
| **Runtime dependencies** | Scale's cloud infrastructure for data ingestion and annotation. No published hardware requirements for collection endpoints beyond compatible robot platforms |
| **Extension model** | White-glove service model -- Scale engineers customize collection specs per customer. No public SDK or API for the Physical AI pipeline (contrast with Nucleus SDK for the text/image Data Engine) |
| **Key limitations** | Proprietary end-to-end: no open data format, no self-serve option, no published API. Enterprise-only pricing ($200K-$300K minimum). Data sovereignty concerns post-Meta deal |

### Scale Data Engine (Core Annotation Platform)

| Aspect | Details |
| --- | --- |
| **Architecture** | Hybrid ML pre-labeling + human annotation. 240K+ annotators on Remotasks and Outlier platforms. Supports images, video, text, audio, 3D/LiDAR, sensor fusion. Forward Deployed Engineers (200+) embedded at customer sites |
| **Runtime dependencies** | Cloud-hosted (AWS, Azure options). Customer data can remain in customer VPC (BYOS) |
| **Extension model** | Nucleus Python SDK (MIT) for programmatic dataset management. REST API for task submission and retrieval |
| **Key limitations** | High minimum engagement cost. Post-Meta customer concentration risk. FDE model does not scale linearly |

### Scale GenAI Platform (SGP)

| Aspect | Details |
| --- | --- |
| **Architecture** | Full-stack enterprise AI platform: RAG pipelines, model fine-tuning, agent orchestration, evaluation. Supports all major commercial and OSS models (OpenAI, Llama, Mistral, Cohere). Available on Azure Marketplace |
| **Runtime dependencies** | Deploys in customer VPC (AWS, Azure). Requires cloud infrastructure |
| **Extension model** | Multi-model support, API-driven. Agentex open-sourced for agent execution |
| **Key limitations** | Relatively new product line ($200-300M revenue segment). Competes with established MLOps platforms. Enterprise sales motion required |

### Scale Donovan

| Aspect | Details |
| --- | --- |
| **Architecture** | GenAI decision-making platform for defense. Deploys AI agents for intelligence analysis and mission operations. Operates on NIPR, SIPR, and JWICS (TS/SCI) networks. Defense Llama built on Meta Llama 3 |
| **Runtime dependencies** | Classified network infrastructure. Government cloud (GovCloud, C2S) |
| **Extension model** | Mission-tailored agent configuration. Full audit trail and source-cited outputs |
| **Key limitations** | Government-only. Dependent on Meta's Llama licensing for Defense Llama. OTA procurement structure limits competitive scrutiny |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Scale Data Engine** | None (proprietary core) | N/A | ML pre-labeling, 240K annotator network, QA processes, FDE program |
| **Physical AI Data Engine** | None (proprietary core) | N/A | Data factories, collection hardware (Scale Harness), robotics research team, annotation pipeline |
| **Scale GenAI Platform** | Integrates OSS models (Llama, Mistral) | Varies by model | RAG pipeline, fine-tuning UI, agent orchestration, enterprise deployment |
| **Scale Donovan** | Meta Llama 3 (community license) | Llama 3 Community | Classified network deployment, mission agents, defense workflow |
| **SEAL / Scale Labs** | SWE-bench Pro (open) | MIT | Private benchmark datasets, expert evaluator network |
| **Agentex** | Self-published OSS | Apache 2.0 | Agent execution framework (488 stars) |
| **LLM Engine** | Self-published OSS | Apache 2.0 | LLM serving/fine-tuning framework (838 stars) |
| **Nucleus SDK** | Self-published OSS | MIT | Python client for Scale's data platform |

### Pattern Analysis

Scale AI follows an **"overwhelmingly proprietary with selective OSS publishing"** pattern. The core revenue-generating products (Data Engine, Physical AI Data Engine, SGP, Donovan) are fully proprietary SaaS platforms with no open-source components at the infrastructure layer. The company publishes evaluation benchmarks (SWE-bench Pro) and developer tools (Agentex, LLM Engine, Nucleus SDK) as open source, primarily to drive ecosystem adoption and credibility rather than to build community-governed projects.

The Physical AI Data Engine is notably closed compared to competitors' approaches. Foxglove created MCAP (MIT), Rerun open-sourced its entire SDK, and Hugging Face/LeRobot publish open datasets. Scale publishes neither its data formats nor its collection tooling. The UR AI Trainer integration uses Scale's proprietary pipeline throughout.

### Notable Dependencies

- **Defense Llama** depends on Meta Llama 3's community license, which includes usage restrictions and could be affected by Meta's evolving licensing strategy
- **SGP** integrates all major model providers but has no proprietary model; it is a pure platform play
- **PandaSet** (280 stars) was Scale's early autonomous driving dataset contribution -- now largely superseded by larger datasets from Waymo and nuScenes

---

## 4. Governance & Community Risk

<!-- Scale AI does not steward any significant OSS projects with external community governance.
     Agentex and LLM Engine are Scale-controlled repos with minimal external contribution.
     No foundation affiliation. No CLA/DCO requirements found. -->

Scale AI does not steward community-governed OSS projects. Published repositories (Agentex, LLM Engine, SWE-bench Pro) are single-vendor controlled with Scale employees as sole maintainers. No foundation governance, no external maintainer diversity, no CLA requirements documented. Abandonment risk for these repos is moderate -- they serve Scale's product strategy and would be deprioritized if strategy shifts.

---

## 5. Hardware Platform Details

<!-- Scale AI does not manufacture hardware, but the Scale Harness is a proprietary
     data collection device worth tracking. -->

### Scale Harness

The Scale Harness is a "robotless" egocentric data collection platform for distributed dexterous manipulation demonstrations. It enables data collection without requiring a robot -- operators wear the harness and perform manipulation tasks while sensors capture the demonstration data. This allows Scale to collect data at residential locations globally rather than requiring centralized robot cells.

Technical specifications are not publicly available. The device is proprietary and not sold separately from Scale's data collection service.

<!-- TODO: obtain Scale Harness technical specs -- sensor suite, data format, sampling rates -->

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Universal Robots** | 100,000+ cobots deployed globally | Co-developed UR AI Trainer. Leader-follower teleoperation system. Planned large-scale industrial dataset release | Co-developed -- Scale software embedded in UR hardware. Joint product announcement at GTC 2026 |
| **Meta** | N/A | $14.3B for 49% non-voting stake. Wang became Meta Chief AI Officer | Deep financial -- Meta is largest shareholder. Wang on Scale board. Defense Llama built on Llama 3 |
| **Physical Intelligence** | N/A | Customer of Physical AI Data Engine | API-level -- Scale produces training data, pi trains models |
| **Cobot** | N/A | Customer of Physical AI Data Engine | API-level -- data production partnership |
| **Generalist AI** | N/A | Named customer and technical partner | Co-developed -- deep technical partnership cited |
| **U.S. DoD** | All military branches | $500M OTA agreement via CDAO. Multiple component access | Embedded -- Donovan on classified networks. FDEs in defense organizations |

### Developer Ecosystem

Scale's developer ecosystem is modest compared to its enterprise footprint. GitHub org (scaleapi) has 54 public repos, with the largest being LLM Engine (838 stars) and SWE-bench Pro (522 stars). The Remotasks/Outlier annotator network of 240K+ workers is the actual "community" -- a labor force, not a developer ecosystem. Scale Labs publishes research but does not maintain a developer conference or structured developer program.

---

## 7. Detailed Competitive Analysis

### vs Foxglove

| Dimension | Scale AI | Foxglove |
| --- | --- | --- |
| **Primary function** | Data production (collection + annotation) | Data management (visualization + observability) |
| **Data flow position** | Upstream -- produces training datasets | Midstream -- manages and visualizes operational data |
| **Robotics data format** | Proprietary, unpublished | MCAP (MIT), adopted by ROS 2 and Isaac ROS |
| **Collection capability** | 1,000+ hrs/day, global factories | None -- ingests data from robots, does not collect |
| **Fleet operations** | None | Remote teleoperation, live streaming, fleet observability |
| **Pricing** | $200K-$300K minimum programs | Freemium + enterprise tiers |
| **Overlap** | Minimal -- different layers of the data stack | Minimal -- complementary to Scale |

### vs Labelbox

| Dimension | Scale AI | Labelbox |
| --- | --- | --- |
| **Operating model** | Contract manufacturer (Scale runs the operation) | Factory equipment (customer runs their own operation) |
| **Workforce** | 240K+ managed annotators | Customer provides annotators |
| **Physical AI** | Dedicated data factories, Scale Harness, robotics researchers | No Physical AI-specific infrastructure |
| **Government** | $500M+ DoD contracts, TS/SCI clearances | No significant government presence |
| **Self-serve** | No -- enterprise-only, white-glove | Yes -- self-serve platform with usage-based pricing |
| **Post-Meta risk** | Customer flight from major AI labs | Beneficiary of Scale's customer departures |

### vs Hugging Face / LeRobot

| Dimension | Scale AI | Hugging Face / LeRobot |
| --- | --- | --- |
| **Data model** | Proprietary, managed service | Open datasets on Hugging Face Hub, community-contributed |
| **Collection** | Professional annotators and data factories | Community contributions, academic labs |
| **Data quality** | Validated with policy fine-tuning, expert QA | Variable -- community-sourced with limited validation |
| **Cost** | $200K+ minimum | Free (open datasets) |
| **Scale** | 150K+ hours delivered in 2025 | Open X-Embodiment + DROID: ~5,000 hours combined |
| **Format** | Proprietary | LeRobot dataset format (open, HF Hub native) |

---

## Sources

- [Scale AI Physical AI page](https://scale.com/physical-ai)
- [Expanding Our Data Engine for Physical AI (Scale blog, Sep 2025)](https://scale.com/blog/physical-ai)
- [Scale AI and Universal Robots partnership (Scale blog, Mar 2026)](https://scale.com/blog/scale-ai-universal-robots-physical-ai)
- [UR and Scale AI launch imitation learning system (UR press release)](https://www.universal-robots.com/news-and-media/news-center/universal-robots-scale-ai-launch-imitation-learning-system-accelerate-ai-training-lab-to-factory/)
- [5 Physical AI Infrastructure Platforms Shaping Robotics in 2026 (The Robot Report)](https://www.therobotreport.com/5-physical-ai-infrastructure-platforms-shaping-robotics-in-2026/)
- [Scale AI confirms Meta investment, Wang departure (TechCrunch, Jun 2025)](https://techcrunch.com/2025/06/13/scale-ai-confirms-significant-investment-from-meta-says-ceo-alexandr-wang-is-leaving/)
- [Meta invests $14.3bn in Scale AI (Silicon Republic)](https://www.siliconrepublic.com/business/meta-scale-ai-funding-investment-alexander-wang)
- [Scale AI $1B Series F at $14B valuation (Fortune, May 2024)](https://fortune.com/2024/05/21/scale-ai-funding-valuation-ceo-alexandr-wang-profitability/)
- [Scale AI Expands Pentagon AI Partnership to $500M (Scale blog, May 2026)](https://scale.com/blog/scale-ai-pentagon-cdao-500-million-agreement)
- [Scale AI and DoD expand Army R&D partnership (Scale blog, Aug 2025)](https://scale.com/blog/scale-ai-dod-expand-army-rd-partnership)
- [Scale AI appoints Francis deSouza as CEO (Scale blog, Aug 2026)](https://scale.com/blog/scale-appoints-new-ceo)
- [Scale AI IPO S-1 filed (TechStackIPO)](https://www.techstackipo.com/ipo/scale-ai)
- [Scale AI revenue, funding, valuation (ValueAddVC)](https://valueaddvc.com/company/scale-ai)
- [Physical AI hits a data labeling wall (Forbes, Jun 2026)](https://www.forbes.com/sites/josipamajic/2026/06/29/physical-ai-hits-a-data-labeling-wall-that-only-cash-can-fix/)
- [Scale AI Wikipedia](https://en.wikipedia.org/wiki/Scale_AI)
- [Scale's next era: building for 2026 (Scale blog)](https://scale.com/blog/scales-next-era-building-for-2026)
- [Scale AI GitHub (scaleapi)](https://github.com/scaleapi)
- [How Alexandr Wang built a $29B AI giant (Product Market Fit)](https://www.productmarketfit.tech/p/how-alexandr-wang-built-a-29-billion)
- [Scale AI competitors comparison (Label Your Data)](https://labelyourdata.com/articles/scale-ai-competitors)
- [Scale AI Forward Deployed Engineers (Perspective AI)](https://getperspective.ai/blog/scale-ai-forward-deployed-engineers-rl-data-annotation-enterprise-2026)
