# Qualcomm — Competitive Profile

**Date**: 2026-06-23
**Last updated**: 2026-06-23
**Classification**: Internal analysis — not for public repo

See [deep-dive](qualcomm-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.

---

## At a Glance

Qualcomm is a $44B-revenue semiconductor and wireless technology company pursuing Physical AI through **power-efficient edge inference silicon** across robotics, automotive, and industrial IoT. Its thesis is "training in the cloud, inference on the device" — delivering AI compute at the edge with integrated 5G/Wi-Fi connectivity that no competitor matches. The strategic framing is the inverse of NVIDIA: where NVIDIA builds from datacenter down, Qualcomm builds from the edge up, leveraging billions of shipped mobile SoCs as proof of its power-efficiency advantage. The $45B automotive design-win pipeline and new Dragonwing IQ10 robotics platform (700 TOPS, scalable to 2,000 TOPS) signal serious Physical AI ambitions beyond smartphones.

| | |
| --- | --- |
| **Type** | Big Tech |
| **Revenue / Funding** | $44.3B FY2025 revenue; Automotive $1.3B/quarter (Q2 FY2026, +38% YoY) |
| **Physical AI thesis** | Power-efficient edge inference with integrated connectivity; "training in the cloud, inference on the device" |
| **Platform coverage** | ~20% of blocks — concentrated in edge inference, drivers, and application libs; minimal central-site presence |
| **Relationship to Red Hat** | Complement — Qualcomm has no OS, no container platform, no MLOps; needs partners for the full stack above silicon |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Dragonwing IQ10** | Flagship robotics SoC: 700 TOPS (scalable to 2,000), 18 Oryon cores, 64GB DDR5x. ROS 2, 12 GMSL2 cameras, EtherCAT, CAN-FD. GA Sep 2026 |
| **Robotics RB3/RB5/RB6** | Shipping robotics platforms: 12-200 TOPS, Linux/ROS 2 support, 5G connectivity. AMRs, drones, industrial robots |
| **Snapdragon Digital Chassis** | Automotive compute: Ride (ADAS), Cockpit (infotainment), Car-to-Cloud. 75M+ vehicles, $45B design-win pipeline |
| **Snapdragon Ride Flex** | Mixed-criticality SoC unifying ADAS + cockpit on single chip. In mass production across 8 global programs |
| **Cloud AI 100 / Ultra** | Data center inference accelerators. Ultra runs 70B models on 1 card at 148W vs 2,983W for 8× A100 |
| **AI200** | Next-gen data center inference chip, commercially available 2026 |
| **Qualcomm AI Hub** | Cloud-based model optimization and deployment: convert PyTorch/ONNX models → on-device runtimes (QNN, ONNX RT, LiteRT) |
| **QAIRT (AI Runtime)** | Unified inference runtime (SNPE + QNN) targeting Hexagon NPU, Adreno GPU, CPU |
| **AIMET** | AI Model Efficiency Toolkit: quantization and compression for PyTorch/ONNX. Open-source (BSD-3) |
| **Dragonwing AI On-Prem Appliance** | Sovereign edge inference, supports models up to 120B parameters |

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
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
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
  <td colspan="2">🟡 AI Hub<sup>1</sup><br>
  <small>(model catalog, not K8s-native registry)</small></td>
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
  <td colspan="2">⬜</td>
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
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
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
  <td><b>Models & Policies</b></td>
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
  <td colspan="2">🟡 Cloud AI 100/Ultra<sup>2</sup><br>
  <small>(HW + runtime, limited SW ecosystem)</small></td>
  <td colspan="2">🟡 AI On-Prem Appliance<br>
  <small>(up to 120B models)</small></td>
  <td>🟢 QAIRT<sup>3</sup><br>
  <small>(Hexagon NPU, Adreno GPU)</small></td>
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
  <td>🟣 Hexagon SDK, QNN<sup>4</sup><br>
  <small>(NPU + GPU compute)</small></td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟣 Qualcomm Multimedia<sup>5</sup><br>
  <small>(ISP, video encode/decode)</small></td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 ROS 2 + Nav/SLAM<sup>6</sup><br>
  <small>(RB series, IQ10)</small></td>
</tr>

<!-- === Platform === -->

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜<br>
  <small>(structural dep on partners)</small></td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">🟣 Cloud AI 100 drivers</td>
  <td colspan="2">⬜</td>
  <td>🟣 Dragonwing BSP<sup>7</sup><br>
  <small>(NPU, GPU, ISP, 5G, Wi-Fi)</small></td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟡 Ubuntu Linux<sup>8</sup><br>
  <small>(ships with RB/IQ10; no own OS)</small></td>
</tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| # | Product | OSS Foundation |
| --- | --- | --- |
| 1 | **AI Hub** | Model catalog; integrates ONNX Runtime (Apache 2.0) + LiteRT (Apache 2.0). Optimization tooling proprietary |
| 2 | **Cloud AI 100** | Hardware + proprietary firmware/compiler. No OSS inference engine equivalent to vLLM |
| 3 | **QAIRT** | Proprietary unified runtime (SNPE + QNN). AIMET quantization toolkit is BSD-3 |
| 4 | **Hexagon SDK / QNN** | Proprietary SDK targeting Hexagon DSP/NPU. ONNX Runtime QNN EP is open-source bridge |
| 5 | **Multimedia** | Proprietary ISP/codec stack. GStreamer plugins for integration |
| 6 | **ROS 2 support** | ROS 2 (Apache 2.0) runs on Qualcomm platforms; Qualcomm contributes Hexagon transport layer |
| 7 | **Dragonwing BSP** | Qualcomm-controlled board support package; ships Ubuntu Linux (Canonical) |
| 8 | **AIMET** | AI Model Efficiency Toolkit: quantization/compression. BSD-3 on GitHub |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **BMW** | Automotive | Snapdragon Ride Pilot ADAS in iX3 (2026 MY); co-developed system |
| **Stellantis** | Automotive | Ride Pilot across millions of vehicles; LOI to acquire aiMotive |
| **Volkswagen Group** | Automotive | Primary tech provider for zonal SDV; infotainment from 2027 |
| **Toyota** | Automotive | Snapdragon Cockpit for RAV4 |
| **Li Auto, Leapmotor, Zeekr, NIO** | Automotive (China) | 10+ Chinese OEM programs; first dual Snapdragon Elite mass-production vehicle |
| **NEURA Robotics** | Humanoid | Strategic collaboration (Mar 2026): factory, service, home robots |
| **Figure** | Humanoid | Next-gen compute architecture for humanoid robots |
| **HUMAIN (Saudi Arabia)** | Data Center | First major Cloud AI customer, 200MW inference deployment |
| **Cerebras** | Data Center | Training (Cerebras CS-3) + inference (Cloud AI 100) partnership |
| **Arduino** | Developer Ecosystem | Acquired Oct 2025; open-source HW/SW platform for maker community |
| **Edge Impulse** | MLOps | Training + inference integration for Qualcomm edge platforms |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **NVIDIA (Jetson)** | Superior power efficiency (tokens-per-watt); integrated 5G/Wi-Fi connectivity; $45B automotive pipeline; lower cost points for mass edge deployment | Software ecosystem (no equivalent to CUDA, Isaac Sim, Omniverse, Isaac ROS); no simulation engine; no foundation models; no training stack |
| **Intel (Mobileye)** | Broader edge AI portfolio (robotics + automotive + IoT on unified architecture); stronger connectivity; higher automotive design-win volume | x86 datacenter integration; Mobileye's vision-specific depth; Intel's manufacturing scale (though financially challenged) |
| **MediaTek** | Automotive/robotics design-win lead; brand premium; Oryon CPU performance; AI Hub model optimization | MediaTek approaching in mobile AI (39% smartphone share); entering automotive/AI PCs; lower cost structure |

---

## Coverage Summary

- **Strong**: Edge inference (QAIRT on Hexagon NPU), Automotive compute (Digital Chassis in 75M+ vehicles), Robotics platforms (RB series, IQ10), Connectivity (5G/Wi-Fi on-chip)
- **Absent**: Training (no training stack at all), Simulation (no physics engine), MLOps (no pipelines, CI/CD, experiment tracking, monitoring), Agentic, Container platform, Server OS, Model serving orchestration (no KServe/llm-d equivalent)
- **Conflicts with Red Hat**: None — Qualcomm operates below the OS/platform layer; purely complementary
- **Lock-in**: Hardware-locked to Qualcomm silicon (Hexagon NPU, Adreno GPU); proprietary compiler/runtime (QNN/SNPE); weaker than CUDA lock-in due to ONNX Runtime bridge

---

## Strategic Implications for Red Hat

1. **Cleanest complement in the ecosystem**: Qualcomm has zero overlap with Red Hat's platform layers — no OS, no K8s, no MLOps, no model serving orchestration. Every Physical AI deployment on Qualcomm edge hardware needs an OS partner and fleet management. RHEL Device Edge + MicroShift on Dragonwing IQ10/RB6 is a natural fit.

2. **Automotive is the volume play**: The $45B design-win pipeline across BMW, Stellantis, VW, Toyota, and Chinese OEMs represents the highest-volume Physical AI deployment path. If RHEL Automotive or RHEL-based SDV middleware gains traction, Qualcomm Digital Chassis is the primary silicon partner — not NVIDIA, which has far fewer automotive design wins at scale.

3. **IQ10 is the NVIDIA Jetson competitor to watch**: At 700-2,000 TOPS with ROS 2 and Ubuntu, Dragonwing IQ10 directly competes with NVIDIA Jetson Thor. It ships with Ubuntu — if Red Hat can offer a RHEL-based alternative (RHEL Device Edge), it displaces Canonical at the OS layer. Key question: can RHEL run on IQ10 with full NPU/GPU/connectivity driver support?

4. **Cloud AI 100/AI200 creates a datacenter inference opportunity**: Qualcomm's tokens-per-watt advantage could make Cloud AI chips relevant for inference-heavy Physical AI workloads (running VLAs, perception models). Red Hat could support Cloud AI 100/AI200 in OpenShift the way it supports NVIDIA GPUs via GPU Operator — but Qualcomm would need to build the Kubernetes integration.

5. **Connectivity differentiation matters for distributed Physical AI**: Qualcomm's unique 5G/Wi-Fi integration on the SoC matters for fleet-managed robots, drones, and vehicles — exactly the use cases where MicroShift + FlightCtl fleet management would run. No other edge AI silicon vendor offers this connectivity depth.
