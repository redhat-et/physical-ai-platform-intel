# AWS (Amazon Web Services) — Competitive Profile

**Date**: 2026-10-03
**Last updated**: 2026-10-03
**Classification**: Internal analysis — not for public repo

See [deep-dive](aws-deep-dive.md) for service architecture, deprecation history, Strands Agents technical details, and six-capability reference architecture.

---

## At a Glance

AWS is Amazon's $105B+ cloud platform division, positioning itself as the **horizontal compute substrate for Physical AI** — providing GPU training infrastructure, edge runtimes, digital twin services, and model APIs that partners' simulation engines and foundation models run on. Unlike NVIDIA (vertical, silicon-to-model) or Google (research-to-product), AWS follows an **"infrastructure not application"** pattern: it builds no simulation engines or foundation models of its own, instead partnering with NVIDIA (Isaac Sim on EC2, Cosmos on SageMaker), Physical Intelligence (π0 fine-tuning), and Hugging Face (LeRobot integration). This is structurally similar to Red Hat's platform positioning. The Strands Agents framework (Apache 2.0, May 2025) with the experimental Strands Robots extension (Aug 2026) represents AWS's bid to own the agentic orchestration layer for Physical AI, using an edge-cloud System 1/System 2 architecture pattern.

| | |
| --- | --- |
| **Type** | Big Tech |
| **Revenue / Funding** | $105B+ annual run rate (2026), ~60% of Amazon's operating income |
| **Physical AI thesis** | Horizontal compute substrate — GPU training, edge inference, digital twins, agentic orchestration; partners supply engines and models |
| **Platform coverage** | ~45% of blocks — concentrated in training infrastructure, MaaS, agentic framework, application runtime, edge OS |
| **Relationship to Red Hat** | Mixed — complement on partner ecosystem (joint customers run OpenShift on EC2), conflict on application runtime (EKS vs OpenShift), edge OS (Greengrass vs MicroShift), model serving (Bedrock vs self-managed) |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **SageMaker HyperPod** | Managed GPU cluster for distributed training. EKS-native (K8s integration). Supports FSDP, DeepSpeed, NeMo. Used for π0 fine-tuning, Isaac Lab RL, Cosmos model factory |
| **Amazon Bedrock** | MaaS platform — Claude, Llama, Titan, Mistral, Cohere. Task planning for Physical AI via tool-use and function calling |
| **Bedrock AgentCore** | Agent deployment infrastructure — memory (spatial/temporal context), observability (CloudWatch traces), secure execution. Production orchestration for Strands Agents |
| **Strands Agents** | Open-source agent SDK (Apache 2.0, Python + TypeScript). Model-driven, multi-agent orchestration. v1.0 Jul 2025 |
| **Strands Robots** | Experimental OSS extension (Apache 2.0) connecting Strands Agents to physical hardware. LeRobot integration, GR00T VLA support, MuJoCo sim, Zenoh mesh networking |
| **IoT Greengrass V2** | Edge runtime for ML inference on robots/industrial devices. Lambda-based local compute, OTA updates, fleet deployment |
| **IoT TwinMaker** | Digital twin service — 3D visualization, data connectors for industrial telemetry (SiteWise, Timestream) |
| **IoT SiteWise** | Industrial telemetry ingestion — OPC-UA, MQTT, asset modeling, edge gateway |
| **EC2 GPU Instances** | p5.48xlarge (H100 × 8, $54.92/hr on-demand), p6-b300.48xlarge (B300 × 8, $148.54/hr), G6e (L40S for rendering) |
| **ParallelCluster / Batch** | HPC workload orchestration — Slurm-based or serverless batch for simulation sweeps |

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
  <td>🟢 SageMaker HyperPod<br>
  <small>(LLM fine-tuning, FSDP/DeepSpeed)</small></td>
  <td>🟢 SageMaker HyperPod<br>
  <small>(Isaac Lab RL, π0, Cosmos)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 EC2 GPU hosting<br>
  <small>(runs Isaac Sim, MuJoCo — no own engine)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>🟡 SageMaker<br>
  <small>(custom eval pipelines)</small></td>
  <td>🟡 SageMaker<br>
  <small>(custom eval pipelines)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td colspan="2">🟢 S3 + Glue + SageMaker Data Wrangler<br>
  <small>(storage + cataloging + transform)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">🟢 SageMaker HyperPod EKS<br>
  <small>(GPU scheduling, health checks, auto-resume)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === AI Model & Data Lifecycle === -->

<tr>
  <td><b>Model Registry</b></td>
  <td colspan="2">🟢 SageMaker Model Registry</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Pipelines</b></td>
  <td colspan="2">🟢 SageMaker Pipelines<br>
  <small>(DAG orchestration)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>CI/CD & GitOps</b></td>
  <td colspan="2">🟡 CodePipeline + CodeBuild<br>
  <small>(general CI/CD, not ML-specific)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Experiment Tracking</b></td>
  <td colspan="2">🟢 SageMaker Experiments</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Monitoring</b></td>
  <td colspan="2">🟢 SageMaker Model Monitor + CloudWatch<br>
  <small>(drift detection, data quality)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Agentic Framework === -->

<tr>
  <td><b>Agentic Framework</b></td>
  <td>🔵 Strands Agents<br>
  <small>(Apache 2.0, model-driven)</small></td>
  <td>🔵 Strands Robots<br>
  <small>(Apache 2.0, LeRobot + GR00T)</small></td>
  <td>🟡 Bedrock AgentCore<br>
  <small>(cloud-managed)</small></td>
  <td>🟡 Bedrock AgentCore<br>
  <small>(cloud-managed)</small></td>
  <td>🟡 Strands + Ollama<br>
  <small>(edge agent, local models)</small></td>
</tr>

<!-- === Models & Policies === -->

<tr>
  <td><b>Models & Policies</b></td>
  <td>🟢 Bedrock model catalog<br>
  <small>(Claude, Llama, Titan, Mistral)</small></td>
  <td>🟡 Partner models<br>
  <small>(GR00T, π0 via HyperPod)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡 Ollama / llama.cpp<br>
  <small>(Qwen3-VL 2B, quantized)</small></td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td colspan="2">🟢 Amazon Bedrock<br>
  <small>(multi-provider, pay-per-token)</small></td>
  <td colspan="2">🟢 Amazon Bedrock<br>
  <small>(cross-region inference)</small></td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td colspan="2">🟢 SageMaker Endpoints<br>
  <small>(real-time, batch, serverless)</small></td>
  <td colspan="2">🟡 SageMaker Endpoints</td>
  <td>🟡 Greengrass V2<br>
  <small>(Lambda-based local inference)</small></td>
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
  <td colspan="2">🟡 Neuron SDK<br>
  <small>(Trainium/Inferentia only)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td colspan="2">🟡 Kinesis Video Streams<br>
  <small>(ingestion + WebRTC)</small></td>
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
  <td colspan="2">🔴 EKS<br>
  <small>(managed K8s, competes with OpenShift)</small></td>
  <td colspan="2">🔴 EKS Anywhere<br>
  <small>(on-prem K8s)</small></td>
  <td>🟡 Greengrass V2<br>
  <small>(edge runtime, not K8s)</small></td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">🟡 AMI-bundled<br>
  <small>(NVIDIA drivers pre-installed in Deep Learning AMIs)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">🟡 Amazon Linux 2023<br>
  <small>(RHEL-compatible, cloud-only)</small></td>
  <td colspan="2">🟡 Amazon Linux 2023</td>
  <td>🟡 Amazon Linux + Greengrass<br>
  <small>(not real-time capable)</small></td>
</tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Strands Agents** | Apache 2.0, AWS-led. Open-source agent SDK for Python + TypeScript |
| **Strands Robots** | Apache 2.0 (experimental, strands-labs org). Wraps LeRobot + GR00T + MuJoCo |
| **SageMaker HyperPod** | Proprietary management layer over EKS (K8s). Integrates FSDP, DeepSpeed, NeMo (all OSS) |
| **Bedrock** | Proprietary MaaS. Hosts third-party models (Claude, Llama, Mistral) |
| **Bedrock AgentCore** | Proprietary agent infrastructure (memory, observability, deployment) |
| **IoT Greengrass V2** | Proprietary edge runtime. Lambda execution model, OTA deployment |
| **IoT TwinMaker** | Proprietary. Grafana plugin for visualization (OSS Grafana) |
| **EKS** | Managed upstream Kubernetes (CNCF). AWS adds managed control plane, Karpenter (Apache 2.0) |
| **Amazon Linux 2023** | Fedora-derived, RPM-based. AWS-maintained, no external governance |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **NVIDIA** | Silicon + software | Isaac Sim on EC2 G6e, Cosmos 3 on SageMaker, GR00T on Jetson. AWS is largest NVIDIA cloud partner |
| **Physical Intelligence** | Foundation model | π0 fine-tuning on SageMaker HyperPod. Validates AWS for VLA training |
| **Hugging Face** | OSS ecosystem | LeRobot integration in Strands Robots. Hub-to-hardware workflow |
| **Rockwell Automation** | Industrial IoT | FactoryTalk + AWS IoT for connected factory. TwinMaker integration |
| **Edge Impulse** | Edge ML | TinyML on Greengrass devices. Sensor data pipelines |
| **Telexistence** | Robotics | Convenience-store robots running on AWS. Physical AI blog showcase |
| **Luminous Robotics** | Robotics | Agricultural robots. AWS edge inference |
| **Config Intelligence** | Digital twin | 3D scanning to digital twin pipeline on AWS |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **NVIDIA** | Broader cloud portfolio (storage, networking, databases, serverless), vendor-neutral GPU access (H100, B300, Trainium), managed K8s | No simulation engine, no physics engine, no foundation models, no edge silicon. Depends on NVIDIA for all Physical AI application-layer components |
| **Azure** | Larger industrial IoT installed base (Greengrass + SiteWise), more robotics partner showcases, Strands Agents OSS strategy | Azure has AirSim successor, Autonomous Systems platform, and deeper Siemens partnership. AWS has no equivalent to Azure Digital Twins enterprise positioning |
| **Red Hat** | Fully managed cloud infrastructure, MaaS (Bedrock), GPU fleet at scale, edge runtime (Greengrass) | No on-prem Physical AI story, no real-time OS, no device management equivalent to FlightCtl, no OpenShift-class hybrid platform |

---

## Coverage Summary

- **Strong**: Training infrastructure (SageMaker HyperPod), MaaS (Bedrock), agentic framework (Strands, open-source), MLOps lifecycle (SageMaker suite), cloud-native runtime (EKS)
- **Absent**: Simulation engine, physics engine, foundation models (hosts others'), robotics middleware (ROS 2), distributed inference (llm-d/KServe), real-time edge OS
- **Conflicts with Red Hat**: EKS vs OpenShift (application runtime), Amazon Linux vs RHEL (OS), Bedrock vs self-managed inference
- **Lock-in**: Cloud-locked — SageMaker, Bedrock, IoT services all require AWS. Strands Agents is the notable exception (runs anywhere)

---

## Strategic Implications for Red Hat

1. **Structural complement at cloud layer**: AWS's "infrastructure not application" positioning mirrors Red Hat's. AWS provides GPU compute and MaaS; Red Hat provides the hybrid platform layer (OpenShift, RHEL, FlightCtl). Joint customers already run OpenShift on EC2 — extending this to Physical AI workloads is natural.

2. **Strands Agents as co-opetition opportunity**: Strands Agents (Apache 2.0) is genuinely open and runs on any cloud, but Bedrock AgentCore (proprietary) is the production deployment target. Red Hat could integrate Strands Agents with OpenShift AI while offering an alternative to AgentCore via Kagenti + open observability, capturing the OSS layer without ceding production to AWS.

3. **Greengrass vs MicroShift at the edge**: IoT Greengrass V2 competes with MicroShift for edge workload orchestration on robots and industrial devices. Greengrass uses a Lambda execution model (not K8s), which limits composability with cloud-native tooling. Red Hat's K8s-native edge story (MicroShift + Podman + FlightCtl) is architecturally stronger for customers who want consistent dev-to-edge pipelines.

4. **Service deprecation pattern is a risk signal**: AWS deprecated RoboMaker (Sep 2025), is closing IoT FleetWise (Apr 2026), and sunset Greengrass V1 (Jun 2026). This signals AWS's willingness to exit Physical AI services that don't reach scale. Customers building on AWS IoT services face platform risk — an opening for Red Hat's more stable, self-managed alternatives.

5. **Training infrastructure opportunity**: SageMaker HyperPod EKS validates that GPU training clusters run on Kubernetes. Red Hat could offer OpenShift AI as the self-managed alternative for regulated industries (defense, automotive) that cannot use SageMaker but need the same distributed training capabilities.
