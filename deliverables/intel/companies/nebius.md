# Nebius — Competitive Profile

**Date**: 2026-09-01
**Last updated**: 2026-09-01
**Classification**: Internal analysis — not for public repo

See [deep-dive](nebius-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.

---

## At a Glance

Nebius Group (NASDAQ: NBIS) is an ex-Yandex AI cloud infrastructure provider, spun out in 2024 and backed by a $2B NVIDIA strategic investment. Its Physical AI thesis frames the challenge as NVIDIA's "three-computer problem" — training, simulation, and edge deployment each require distinct infrastructure that robotics teams currently stitch together manually, losing 30-40% of engineering time to integration. Nebius positions as the **cloud execution layer for the entire Physical AI ecosystem**, offering managed GPU clusters with integrated NVIDIA simulation and world-model tooling (OSMO, Cosmos, Isaac Sim/Lab) as a turnkey platform. The company operates a subsidiary, Avride, that builds autonomous delivery robots and robotaxis — providing a captive Physical AI workload that informs platform design.

| | |
| --- | --- |
| **Type** | Startup (public, ex-Big Tech spinout) |
| **Revenue / Funding** | $582M Q2 2026 revenue (+454% YoY); $3B ARR run-rate; $2B NVIDIA investment (Mar 2026); $27B Meta contract; $19.4B Microsoft contract |
| **Physical AI thesis** | Cloud execution layer for the robotics data flywheel: synthetic data generation (Cosmos) → simulation (Isaac Sim) → training → edge deployment, all managed |
| **Platform coverage** | ~25% of blocks — concentrated in training infrastructure, managed inference, and GPU compute; no edge, no robot middleware, no models |
| **Relationship to Red Hat** | Mixed — complements on edge/OS/fleet management (Nebius has none); competes on managed Kubernetes and MLOps tooling in the cloud tier |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Nebius AI Cloud** | Full-stack AI cloud: bare-metal GPU clusters (H100/H200/B200/B300/GB200 NVL72), managed Kubernetes, Slurm-on-K8s, object storage, IaC via Terraform. In-house server and rack designs |
| **Nebius Token Factory** | Managed inference platform combining Eigen AI model-level optimization and Clarifai system-level optimization. First to adopt NVIDIA Groq 3 LPX on Vera Rubin NVL72 |
| **Physical AI Cloud** | Managed platform for robotics lifecycle: NVIDIA OSMO orchestration, Cosmos synthetic data, Isaac Sim/Lab simulation, RTX PRO 6000 Blackwell GPUs, high-throughput storage, data labeling integration |
| **Physical AI Living Lab** | Six-month accelerator for European robotics startups: full NVIDIA Physical AI stack on Nebius cloud + engineering mentorship. First cohort Sep 2026 (UK) |
| **Managed MLOps** | Managed MLflow, PostgreSQL, Apache Spark, experiment tracking, model management. CI/CD pipelines and serverless features |
| **Asset-Light Cloud Model** | Partners deploy Nebius's full software stack in their own data centers; Nebius supplies architecture, supply-chain access, hardware design, and software (Jul 2026) |
| **Avride** (subsidiary) | Autonomous delivery robots (Uber Eats in Austin/Dallas/Jersey City) and robotaxis (200 vehicles in Dallas on Uber app). $375M Uber+Nebius investment. Munich expansion planned |
| **Toloka** (minority stake) | AI data services: human-in-the-loop annotation, LLM red-teaming, agent safety evaluation. 235+ languages. Bezos Expeditions-led $72M round (May 2025); Nebius relinquished majority control |
| **Tavily** (acquired Feb 2026) | Agentic search: real-time web retrieval and reasoning for AI agents. $275M acquisition |

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
  <td>🟢 Nebius AI Cloud<br>
  <small>(managed Slurm-on-K8s, multi-host training)</small></td>
  <td>🟢 Physical AI Cloud<br>
  <small>(OSMO-orchestrated sim+train pipelines)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 Physical AI Cloud<br>
  <small>(managed Isaac Sim/Lab; NVIDIA engine, not Nebius)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>🟡 Toloka integration<br>
  <small>(annotation; minority stake, not owned)</small></td>
  <td>🟡 Cosmos + Voxel51<br>
  <small>(synthetic data gen; NVIDIA models)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">🟢 Nebius AI Cloud<br>
  <small>(GPU clusters, InfiniBand, self-healing VMs, fault-tolerant scheduling)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === AI Model & Data Lifecycle === -->

<tr>
  <td><b>Model Registry</b></td>
  <td colspan="2">🟡 Managed MLflow<br>
  <small>(model versioning via managed service)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Pipelines</b></td>
  <td colspan="2">🟡 OSMO<br>
  <small>(NVIDIA orchestration, managed by Nebius)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>CI/CD &amp; GitOps</b></td>
  <td colspan="2">🟡 Managed CI/CD<br>
  <small>(cloud-native pipelines; limited detail)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Experiment Tracking</b></td>
  <td colspan="2">🟡 Managed MLflow<br>
  <small>(experiment tracking + pipeline visibility)</small></td>
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
  <td>🟡 Tavily<br>
  <small>(agentic search/retrieval only)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<!-- === Models & Policies === -->

<tr>
  <td><b>Models &amp; Policies</b></td>
  <td colspan="2">⬜<br>
  <small>(hosts NVIDIA models; builds none)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td colspan="2">🟢 Token Factory<br>
  <small>(managed inference API; Eigen AI + Clarifai optimization)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td colspan="2">🟢 Token Factory<br>
  <small>(serverless + managed; Eigen AI #1 NVIDIA speed benchmark)</small></td>
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
  <td colspan="2">🔴 Managed Kubernetes<br>
  <small>(competes with OpenShift for AI workloads)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">🟢 Pre-installed NVIDIA<br>
  <small>(GPU + InfiniBand drivers, pre-configured)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">🟢 Proprietary cloud OS<br>
  <small>(in-house Linux stack)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Nebius AI Cloud** | Managed Kubernetes (CNCF, Apache 2.0) + Slurm (SchedMD, GPLv2). Proprietary cloud platform, in-house server designs |
| **Token Factory** | Proprietary; built on acquired Eigen AI and Clarifai inference IP. Likely uses vLLM (Apache 2.0) or similar OSS inference backends |
| **Physical AI Cloud** | NVIDIA OSMO, Cosmos (Apache 2.0 weights), Isaac Sim (proprietary), Isaac Lab (BSD-3). Nebius provides managed hosting, not the engines |
| **Managed MLflow** | MLflow (Apache 2.0). Managed service wrapper is proprietary |
| **Tavily** | Proprietary agentic search platform |
| **Avride** | Proprietary autonomous driving stack (ex-Yandex SDG). Runs on Hyundai IONIQ 5 hardware |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **NVIDIA** | Strategic investor + technology | $2B investment (Mar 2026); early access to Vera Rubin, Blackwell; joint Physical AI cloud; NVIDIA OSMO/Cosmos/Isaac integration |
| **Meta** | Anchor customer | $27B five-year contract for dedicated AI compute; first large-scale Vera Rubin NVL72 deployment (delivery from early 2027) |
| **Microsoft** | Anchor customer | $19.4B contract for Azure AI capacity from Vineland, NJ data center |
| **Uber** | AV/delivery partner | Multi-year deal for Avride robots on Uber Eats + robotaxis on Uber ride-hailing; co-investor in Avride ($375M round) |
| **Voxel51** | Data partner | FiftyOne data curation on Nebius GPU clusters; joint synthetic data pipeline for Porsche AV data augmentation |
| **NVIDIA Inception** | Startup pipeline | Applications for Physical AI Living Lab routed through Inception; feeds Nebius's startup customer funnel |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **CoreWeave** | Lower pricing ($3.85 vs $6.16/H100-hr); faster revenue growth (454% vs 112% YoY); cleaner balance sheet; Physical AI-specific platform (simulation + training + inference integrated); in-house server/rack design; European data sovereignty | CoreWeave's scale (4x revenue), Platinum SemiAnalysis reliability rating, larger GPU fleet, first Vera Rubin NVL72 validation |
| **AWS / Azure / GCP** | Purpose-built for AI (no general-purpose cloud bloat); tighter NVIDIA integration (early chip access); lower latency for GPU workloads; Physical AI Living Lab for startup acquisition | Breadth of services; enterprise sales relationships; global compliance certifications at scale; managed databases, analytics, and application services beyond AI |
| **Lambda Labs** | Managed Kubernetes and MLOps (Lambda is more bare-metal); Physical AI platform layer; anchor contracts (Meta $27B, Microsoft $19.4B) | Lambda's simplicity and developer-friendliness; lower B200 pricing ($6.69 vs Nebius higher); Lambda's research community reputation |

---

## Coverage Summary

- **Strong**: Training infrastructure (managed GPU clusters with InfiniBand, self-healing, fault-tolerant scheduling), Managed inference (Token Factory with Eigen AI + Clarifai optimization), Physical AI pipeline (managed NVIDIA OSMO + Cosmos + Isaac Sim/Lab), Data center scale (3.5 GW contracted, targeting 5 GW by end 2026)
- **Absent**: Edge (no edge hardware, no edge OS, no fleet management), Robot middleware (no ROS 2 or equivalent), Models (hosts NVIDIA models, builds none), Distributed sites, Model monitoring, Robotics application libraries
- **Conflicts with Red Hat**: Managed Kubernetes (competes with OpenShift for AI training/inference workloads in cloud), Managed MLOps (MLflow, experiment tracking, CI/CD — overlaps with OpenShift AI MLOps)
- **Lock-in**: NVIDIA GPU-locked (entire platform built on NVIDIA silicon, InfiniBand, CUDA); cloud-locked (no hybrid/on-prem option until asset-light model matures); proprietary inference stack (Eigen AI + Clarifai)

---

## Strategic Implications for Red Hat

1. **Edge is the structural gap**: Nebius has zero presence below the cloud tier — no edge OS, no device management, no robot middleware, no on-device inference. Every Nebius Physical AI customer that moves from simulation to real-world deployment needs an edge partner. RHEL Device Edge + MicroShift + FlightCtl fleet management fills exactly this gap. The Avride subsidiary itself needs edge infrastructure that Nebius does not provide internally.

2. **Managed Kubernetes is the conflict surface**: Nebius's managed K8s for AI workloads competes directly with OpenShift AI in the cloud training/inference tier. However, Nebius targets AI-native startups and hyperscaler overflow (Meta, Microsoft), not enterprise IT — different buyer, different procurement. The conflict is real but the customer overlap is currently small.

3. **Physical AI Living Lab is a startup capture mechanism**: The Living Lab funnels European robotics startups into Nebius's cloud via NVIDIA Inception. These startups will eventually need edge deployment infrastructure. Red Hat could position RHEL Device Edge as the deployment target for Living Lab graduates — partnering with Nebius on the "last mile" from cloud training to real-world robots.

4. **Asset-light model creates a partnership opening**: Nebius's July 2026 announcement that partners can deploy Nebius's software stack in their own data centers suggests openness to infrastructure partnerships. If Nebius's platform runs on standard Linux + K8s, there may be an opportunity for RHEL/OpenShift as the base OS and container platform in partner-operated Nebius deployments — particularly for sovereign AI projects requiring Red Hat's certification and support model.

5. **NVIDIA dependency is both strength and risk**: Nebius's entire Physical AI value proposition is built on NVIDIA technology (OSMO, Cosmos, Isaac, Blackwell GPUs, InfiniBand). This makes Nebius the most NVIDIA-aligned cloud provider in the neocloud space. For Red Hat, this means engaging Nebius likely requires NVIDIA alignment. It also means Nebius is vulnerable to NVIDIA's own cloud ambitions (DGX Cloud) and to any diversification of GPU supply (AMD MI-series, Intel Gaudi).

---

## Sources

- [NVIDIA and Nebius Partner to Scale Full-Stack AI Cloud](https://nvidianews.nvidia.com/news/nvidia-and-nebius-partner-to-scale-full-stack-ai-cloud)
- [Nebius teams with NVIDIA to build cloud for robotics and physical AI](https://nebius.com/newsroom/nebius-teams-with-nvidia-to-build-cloud-for-robotics-and-physical-ai)
- [Nebius launches Physical AI Living Lab](https://nebius.com/newsroom/nebius-launches-physical-ai-living-lab-for-uk-and-european-robotics-startups-built-with-nvidia-technologies)
- [Nebius reports Q2 2026 financial results](https://nebius.com/newsroom/nebius-reports-second-quarter-2026-financial-results)
- [Nebius reports Q1 2026 financial results](https://nebius.com/newsroom/nebius-reports-first-quarter-2026-financial-results)
- [Nebius acquires Eigen AI](https://nebius.com/newsroom/nebius-agrees-to-acquire-eigen-ai-strengthening-nebius-token-factory-as-a-frontier-inference-platform)
- [Nebius welcomes Clarifai team](https://nebius.com/newsroom/nebius-welcomes-clarifai-s-core-team-and-licenses-inference-ip-to-strengthen-nebius-token-factory)
- [Nebius signs Meta infrastructure agreement](https://nebius.com/newsroom/nebius-signs-new-ai-infrastructure-agreement-with-meta)
- [Nebius Microsoft agreement](https://nebius.com/newsroom/nebius-announces-multi-billion-dollar-agreement-with-microsoft-for-ai-infrastructure)
- [Avride $375M investment](https://nebius.com/newsroom/avride-secures-strategic-investment-and-other-commitments-of-up-to-375-million-backed-by-uber-and-nebius)
- [Nebius opens AI cloud stack to partner-owned data centers](https://finance.yahoo.com/technology/ai/articles/nebius-opens-ai-cloud-stack-145934893.html)
- [Nebius Toloka Bezos investment](https://nebius.com/newsroom/nebius-welcomes-bezos-expeditions-as-lead-investor-in-ai-data-business-toloka)
- [Best GPU Neoclouds 2026 pricing comparison](https://www.marktechpost.com/2026/08/23/best-gpu-neoclouds-2026/)
- [Nebius Wikipedia](https://en.wikipedia.org/wiki/Nebius_Group)
