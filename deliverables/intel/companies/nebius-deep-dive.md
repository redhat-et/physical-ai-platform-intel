# Nebius — Deep Dive Research

**Date**: 2026-09-01
**Last updated**: 2026-09-01
**Classification**: Internal analysis — not for public repo

Supporting research for the [Nebius competitive profile](nebius.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, acquisition deep-dives, product architectures, governance risks, and technical dependency chains.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1997 | Yandex founded as a search engine in Russia by Arkady Volozh |
| 2011-05 | Yandex N.V. IPOs on NASDAQ |
| 2017 | Yandex Self-Driving Group begins autonomous vehicle development |
| 2020 | Yandex SDG spins out as Avride |
| 2023-2024 | Yandex restructuring: Russian assets sold to Russian investors |
| 2024-07 | Yandex N.V. rebrands to Nebius Group N.V.; headquarters in Amsterdam; Volozh returns as CEO |
| 2024-10 | Nebius resumes NASDAQ trading (NBIS) |
| 2024-Q4 | NVIDIA invests $700M in Nebius (initial tranche) |
| 2025-05 | Bezos Expeditions leads $72M round in Toloka; Nebius relinquishes majority control |
| 2025-09 | Microsoft signs $19.4B contract for Azure AI capacity |
| 2025-11 | Meta signs initial $3B Nebius contract |
| 2026-02 | Acquires Tavily (agentic search) for $275M |
| 2026-03 | NVIDIA invests additional $2B; announces strategic partnership for hyperscale AI cloud |
| 2026-03 | Meta expands to $27B total five-year contract (Vera Rubin NVL72 deployment) |
| 2026-03 | Nebius announces Physical AI cloud collaboration with NVIDIA |
| 2026-03 | Missouri gigawatt-scale AI factory approved |
| 2026-05 | Acquires Eigen AI ($643M) for inference optimization |
| 2026-05 | Acquires Clarifai team + patent portfolio for inference IP |
| 2026-06 | Launches Physical AI Living Lab for European robotics startups |
| 2026-07 | Announces asset-light model: partners deploy Nebius stack in their own data centers |
| 2026-08 | Q2 2026: $582M revenue (+454% YoY), $3B ARR, 41% adj. EBITDA margin |

### Acquisitions — What Each Brought

#### Eigen AI (2026)

- **Price**: $643M
- **Technology**: Model-level inference optimization; recognized by NVIDIA as #1 speed inference provider
- **Integration**: Core of Nebius Token Factory managed inference platform
- **Significance**: Gives Nebius proprietary inference optimization IP rather than depending on OSS inference engines. Combined with Clarifai's system-level optimization, creates a full-stack inference advantage

#### Clarifai (2026)

- **Price**: Undisclosed (team acquisition + patent license)
- **Technology**: AI inference and compute orchestration patents; system-level optimization. Led by founder Matthew Zeiler (ImageNet 2013 winner). License excludes legacy computer vision models and US government/defense IP
- **Integration**: Complements Eigen AI — system-level optimization (scheduling, routing, batching) vs. Eigen's model-level optimization (quantization, kernel fusion)
- **Significance**: Patent portfolio provides defensive IP in inference space. Clarifai's experience with enterprise and government AI deployments brings institutional knowledge

#### Tavily (2026)

- **Price**: $275M
- **Technology**: Agentic search — real-time web retrieval and reasoning for AI agents
- **Integration**: Integrated into Nebius cloud offering for AI agent development
- **Significance**: Positions Nebius in the agentic AI stack beyond pure infrastructure. Enables customers to build agents that can search and reason over live data

---

## 2. Product Architecture Details

### Nebius AI Cloud

| Aspect | Details |
| --- | --- |
| **Architecture** | Vertically integrated: in-house server and rack designs → proprietary cloud platform software → managed services layer. GPU clusters with non-virtualized GPUs and InfiniBand (up to 3.2 Tbps per host). Self-healing system restarts VMs and hosts within minutes |
| **Runtime dependencies** | NVIDIA GPUs (H100, H200, B200, B300, GB200 NVL72, GB300 NVL72), NVIDIA InfiniBand (Quantum X800), proprietary server firmware |
| **Extension model** | Terraform provider, API, CLI. Managed Kubernetes for workload orchestration. Slurm-on-K8s for HPC-style training |
| **Key limitations** | NVIDIA-only (no AMD/Intel GPU support); no hybrid/on-prem option (asset-light model is early); limited geographic coverage vs. hyperscalers; no edge tier |

### Nebius Token Factory

| Aspect | Details |
| --- | --- |
| **Architecture** | Managed inference service combining Eigen AI (model-level: quantization, kernel optimization) + Clarifai (system-level: compute orchestration, routing, batching). Serverless and managed deployment options |
| **Runtime dependencies** | NVIDIA GPUs; first to adopt NVIDIA Groq 3 LPX on Vera Rubin NVL72 |
| **Extension model** | API-based; serverless one-click deployment or custom configuration |
| **Key limitations** | Proprietary stack — no portability to other clouds; inference optimization IP is closed-source |

### Physical AI Cloud

| Aspect | Details |
| --- | --- |
| **Architecture** | Managed platform layering NVIDIA Physical AI stack on Nebius infrastructure: NVIDIA OSMO (agentic workload orchestration) → Cosmos (synthetic data generation) → Isaac Sim/Lab (simulation + training) → Token Factory (inference). High-throughput object storage for large robotics datasets. Data labeling integration (Voxel51 FiftyOne, Toloka) |
| **Runtime dependencies** | NVIDIA RTX PRO 6000 Blackwell Server Edition GPUs; NVIDIA OSMO, Cosmos, Isaac Sim/Lab software; NVIDIA Physical AI Data Factory Blueprint |
| **Extension model** | Consumable as managed services; NVIDIA OSMO provides pipeline orchestration; Voxel51 integration for data curation |
| **Key limitations** | Entirely dependent on NVIDIA software stack — Nebius adds managed hosting but not proprietary simulation or world model technology. No edge deployment capability |

<!-- TODO: deep research needed on Physical AI Cloud architecture internals -->

### Avride Autonomous Platform

| Aspect | Details |
| --- | --- |
| **Architecture** | Full-stack autonomous driving: proprietary perception, planning, and control software. Delivery robots (sidewalk, 8 km/h) share software with autonomous vehicles (Hyundai IONIQ 5). Operates through Uber platform integration |
| **Runtime dependencies** | Hyundai IONIQ 5 (robotaxis); custom delivery robot hardware; Avride proprietary sensors and compute |
| **Extension model** | Closed platform; OEM-agnostic model proposed for Munich expansion |
| **Key limitations** | NHTSA safety probe (May 2026, 37 logged accidents); limited to US cities + planned Munich; scale vs. Waymo (200 vs. thousands of vehicles) |

<!-- TODO: deep research needed on Avride software architecture -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Nebius AI Cloud** | Kubernetes (CNCF) | Apache 2.0 | In-house server design, proprietary cloud platform, managed services, self-healing infrastructure |
| **Nebius AI Cloud** | Slurm (SchedMD) | GPLv2 | Slurm-on-K8s integration, fault-tolerant job scheduling, GPU utilization optimization |
| **Token Factory** | Likely vLLM or similar | Apache 2.0 (if vLLM) | Eigen AI model optimization, Clarifai system optimization, Groq 3 LPX integration |
| **Physical AI Cloud** | NVIDIA Cosmos (open weights) | Apache 2.0 (weights) | Managed hosting, integration with Isaac Sim/Lab, OSMO orchestration |
| **Physical AI Cloud** | NVIDIA Isaac Lab | BSD-3 | Managed deployment, GPU infrastructure |
| **Managed MLflow** | MLflow (Databricks) | Apache 2.0 | Zero-maintenance managed service, pre-configured for GPU workloads |
| **Tavily** | None identified | N/A | Proprietary agentic search and reasoning |
| **Avride** | None identified | N/A | Proprietary full-stack autonomous driving (ex-Yandex SDG) |

### Pattern Analysis

Nebius follows an **"OSS infrastructure + proprietary value-add"** pattern common among cloud providers. The base infrastructure (Kubernetes, Slurm, MLflow) is open-source, but Nebius adds proprietary cloud platform software, in-house hardware design, and managed service wrappers. The inference stack (Token Factory) is the most proprietary layer, built on acquired IP from Eigen AI and Clarifai rather than OSS engines.

The Physical AI Cloud is architecturally unusual: Nebius provides the compute and managed hosting, but the core technology (OSMO, Cosmos, Isaac Sim) is NVIDIA's. Nebius's value-add is integration, optimization, and operational management — not the simulation or world model engines themselves. This makes Nebius more of a managed NVIDIA platform than an independent Physical AI technology provider.

The Avride autonomous driving stack and Tavily agentic search are fully proprietary with no identified OSS foundations.

### Notable Dependencies

- **NVIDIA OSMO** is the orchestration backbone for Physical AI workloads — it is proprietary NVIDIA software delivered as a managed service by Nebius. If NVIDIA restricts OSMO access or offers it directly via DGX Cloud, Nebius loses its Physical AI differentiation.
- **Kubernetes** underpins the managed container orchestration, but Nebius's cloud platform layer is proprietary. Workloads are not trivially portable to other K8s environments.
- **MLflow** is the experiment tracking and model management foundation, but the managed wrapper is proprietary.

---

## 4. Governance & Community Risk

Nebius does not steward any significant OSS projects. Its OSS exposure is as a consumer (Kubernetes, Slurm, MLflow) and as a managed host for NVIDIA's OSS-adjacent offerings (Cosmos open weights, Isaac Lab BSD-3).

No governance analysis required — Nebius is a proprietary cloud provider.

---

## 5. Hardware Platform Details

Nebius does not manufacture GPUs or accelerators but designs its own servers and racks.

### Current Hardware

Nebius designs proprietary servers and racks optimized for GPU density, cooling, and InfiniBand connectivity. Available GPU types:

| GPU | Notes |
| --- | --- |
| **GB300 NVL72** | Latest; Nebius is first neocloud to publish B300 on-demand pricing |
| **GB200 NVL72** | Blackwell generation; used for Meta Vera Rubin deployment |
| **B300** | Blackwell |
| **B200** | Blackwell |
| **H200** | Hopper |
| **H100** | Hopper; $3.85/GPU-hr on-demand (lowest among major neoclouds) |

### Data Center Footprint

| Location | Capacity | Status |
| --- | --- | --- |
| **Mantsala, Finland** | 75 MW | Operational (expanded 2026) |
| **Lappeenranta, Finland** | 310 MW | Planned ($10B investment) |
| **Independence, Missouri** | Gigawatt-scale | Approved Mar 2026 |
| **Vineland, New Jersey** | Not disclosed | Under construction (Microsoft contract) |
| **Pennsylvania** | Up to 1.2 GW | Secured Q1 2026 |
| **Alabama** | Not disclosed | Planned |
| **France (Azur Datacenter)** | 240 MW total, ~120 MW by end 2026 | Under construction |
| **UK** | Not disclosed | Operational (Physical AI Living Lab) |

**Power**: 3.5 GW contracted (Q1 2026), targeting 5 GW by end 2026. 75%+ in owned facilities. Target 800 MW-1 GW connected by end 2026.

### Pricing

On-demand pricing positions Nebius below CoreWeave and competitive with Lambda/Crusoe:

- H100: ~$3.85/GPU-hr (CoreWeave ~$6.16)
- B200: Published but exact price not confirmed in sources
- B300: Nebius is the only neocloud publishing B300 on-demand pricing

<!-- TODO: deep research needed on exact B200/B300 pricing and reserved/committed pricing -->

---

## 6. Partnership & Ecosystem Details

| Partner | Deal Details | Integration Depth |
| --- | --- | --- |
| **NVIDIA** | $2B equity investment + early Vera Rubin/Blackwell access + joint Physical AI platform + OSMO/Cosmos/Isaac managed hosting | Deep: NVIDIA technology embedded throughout Nebius platform; Nebius is a preferred deployment target |
| **Meta** | $27B 5-year (initial $3B Nov 2025 + $12B dedicated capacity + up to $15B additional). First large-scale Vera Rubin NVL72 deployment, delivery from early 2027 | Dedicated capacity: Meta-specific clusters built and operated by Nebius |
| **Microsoft** | $19.4B for Azure AI capacity from NJ data center | Capacity provider: Nebius builds and operates, Microsoft resells as Azure AI |
| **Uber** | Co-investor in Avride ($375M); multi-year Uber Eats delivery + ride-hailing integration | Platform integration: Avride robots/vehicles accessible through Uber app |
| **Voxel51** | FiftyOne data curation on Nebius; joint Porsche AV synthetic data pipeline | Application-level: Voxel51 SaaS runs on Nebius GPU clusters |
| **Porsche** | AV data augmentation via Nebius + Voxel51 + Cosmos pipeline | Customer: uses Nebius Physical AI Cloud for synthetic data generation |
| **RoboForce** | Early Physical AI Cloud customer | Customer: cut pipeline setup 70%, reduced iteration from weeks to days |
| **Milestone Systems** | Fine-tunes Cosmos Reason VLMs on Nebius clusters | Customer: selected Nebius for GPU availability, price-performance, European data sovereignty |

### Developer Ecosystem

- **Physical AI Living Lab**: Six-month accelerator for European robotics startups, routed through NVIDIA Inception. First cohort Sep 2026 (UK). Provides full NVIDIA Physical AI stack + Nebius cloud + engineering mentorship.
- **Nebius Robotics & Physical AI Awards and Summit**: Annual event recognizing Physical AI startups (250+ applicants from 18 countries). Moderated by Evan Helda.
- **Nebius Academy**: Education subsidiary (details limited).
- **TripleTen**: EdTech subsidiary offering tech bootcamps.

---

## 7. Detailed Competitive Analysis

### vs CoreWeave

| Dimension | Nebius | CoreWeave |
| --- | --- | --- |
| **Revenue (Q2 2026)** | $582M (+454% YoY) | $2,575M (+112% YoY) |
| **ARR** | $3B | ~$10B (estimated from revenue run-rate) |
| **Contracted power** | 3.5 GW | 3.5 GW |
| **Connected power target (end 2026)** | 800 MW - 1 GW | 1.7 GW |
| **H100 pricing** | ~$3.85/GPU-hr | ~$6.16/GPU-hr |
| **Balance sheet** | $8B cash; cleaner debt profile | Free cash flow -$4.71B; heavy debt load |
| **NVIDIA relationship** | $2B equity investment; early Vera Rubin access | Strategic partner; first Vera Rubin NVL72 validation |
| **Reliability rating** | Not rated (SemiAnalysis) | Platinum (SemiAnalysis ClusterMAX 2.0) |
| **Physical AI** | Dedicated Physical AI Cloud with managed NVIDIA stack | No specific Physical AI offering |
| **Anchor customers** | Meta ($27B), Microsoft ($19.4B) | Microsoft (primary), NVIDIA |

### vs Hyperscalers (AWS/Azure/GCP)

| Dimension | Nebius | Hyperscalers |
| --- | --- | --- |
| **Focus** | AI-only; no general-purpose cloud | Full cloud catalog (compute, storage, databases, analytics, ML, etc.) |
| **GPU pricing** | 30-40% below hyperscaler on-demand rates | Premium pricing but enterprise SLAs and global reach |
| **NVIDIA access** | Early access to latest GPUs via strategic partnership | Large volume but standard availability timelines |
| **Physical AI** | Managed NVIDIA Physical AI stack | AWS RoboMaker (limited); Azure + NVIDIA (partnership); GCP + DeepMind (internal) |
| **Enterprise readiness** | SOC 2 Type II, ISO 27001, HIPAA BAA, GDPR | Full compliance portfolio across all major frameworks |
| **Edge** | None | AWS Outposts/Wavelength, Azure Stack Edge, GCP Distributed Cloud |

---

## Sources

- [NVIDIA and Nebius Partner to Scale Full-Stack AI Cloud](https://nvidianews.nvidia.com/news/nvidia-and-nebius-partner-to-scale-full-stack-ai-cloud)
- [Nebius teams with NVIDIA to build cloud for robotics and physical AI](https://nebius.com/newsroom/nebius-teams-with-nvidia-to-build-cloud-for-robotics-and-physical-ai)
- [Nebius launches Physical AI Living Lab](https://nebius.com/newsroom/nebius-launches-physical-ai-living-lab-for-uk-and-european-robotics-startups-built-with-nvidia-technologies)
- [Nebius Q2 2026 financial results](https://nebius.com/newsroom/nebius-reports-second-quarter-2026-financial-results)
- [Nebius Q1 2026 financial results](https://nebius.com/newsroom/nebius-reports-first-quarter-2026-financial-results)
- [Nebius acquires Eigen AI](https://nebius.com/newsroom/nebius-agrees-to-acquire-eigen-ai-strengthening-nebius-token-factory-as-a-frontier-inference-platform)
- [Nebius welcomes Clarifai team](https://nebius.com/newsroom/nebius-welcomes-clarifai-s-core-team-and-licenses-inference-ip-to-strengthen-nebius-token-factory)
- [Nebius Meta infrastructure agreement](https://nebius.com/newsroom/nebius-signs-new-ai-infrastructure-agreement-with-meta)
- [Nebius Microsoft agreement](https://nebius.com/newsroom/nebius-announces-multi-billion-dollar-agreement-with-microsoft-for-ai-infrastructure)
- [Avride $375M investment](https://nebius.com/newsroom/avride-secures-strategic-investment-and-other-commitments-of-up-to-375-million-backed-by-uber-and-nebius)
- [Nebius opens cloud stack to partner data centers](https://finance.yahoo.com/technology/ai/articles/nebius-opens-ai-cloud-stack-145934893.html)
- [Toloka Bezos investment](https://nebius.com/newsroom/nebius-welcomes-bezos-expeditions-as-lead-investor-in-ai-data-business-toloka)
- [Best GPU Neoclouds 2026](https://www.marktechpost.com/2026/08/23/best-gpu-neoclouds-2026/)
- [CoreWeave vs Nebius pricing](https://computeprices.com/compare/coreweave-vs-nebius)
- [Nebius Wikipedia](https://en.wikipedia.org/wiki/Nebius_Group)
- [Nebius Designs Agentic Era (Futurum)](https://futurumgroup.com/insights/nebius-designs-the-agentic-era-of-ai-cloud-platforms-with-nvidia-investment/)
- [Avride Wikipedia](https://en.wikipedia.org/wiki/Avride)
