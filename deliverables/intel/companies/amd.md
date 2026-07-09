# AMD — Competitive Profile

**Date**: 2026-06-23
**Last updated**: 2026-06-23
**Classification**: Internal analysis

See [deep-dive](amd-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.

---

## At a Glance

AMD is a $200B+ semiconductor company pursuing a **hardware-first, open-ecosystem** Physical AI strategy. Unlike NVIDIA's vertically integrated silicon-to-models approach, AMD builds the compute substrate (CPUs, GPUs, FPGAs, DPUs, embedded SoCs) and relies on open-source software (ROCm, vLLM, PyTorch) and partner ecosystems (Red Hat, Robotec.ai, Silo AI) to deliver the upper stack. The critical strategic fact: AMD has the broadest silicon portfolio spanning datacenter to edge (EPYC + Instinct + Versal + Ryzen AI Embedded + Pensando) but minimal proprietary AI application software — creating a structural dependency on open-source projects and partners like Red Hat for the platform layer.

| | |
| --- | --- |
| **Type** | Big Tech |
| **Revenue / Funding** | ~$10.3B Q1 2026 revenue ($5.8B datacenter); ~$200B market cap |
| **Physical AI thesis** | Open-ecosystem compute substrate from datacenter to edge; "AI everywhere, for everyone" via hardware diversity + open software |
| **Platform coverage** | ~25% of blocks — concentrated in hardware, drivers, math/AI libs, inference support; minimal application-layer software |
| **Relationship to Red Hat** | Strong complement — Red Hat AI 3 certified on AMD Instinct; joint vLLM contributions; RHEL + OpenShift as AMD's recommended enterprise platform layer |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Instinct MI350/MI355X** | CDNA 4 datacenter AI GPUs. 288 GB HBM3E, 8 TB/s, FP4/FP6. MI355X liquid-cooled at 1,400W. Competitive with NVIDIA B200 at MLPerf |
| **Instinct MI450** | CDNA 5 next-gen GPU (H2 2026). 432 GB HBM4, 19.6 TB/s, 320B transistors. Custom variants for Meta and OpenAI |
| **EPYC (Turin/Venice)** | Server CPUs. 46% x86 server revenue share. Venice (6th Gen) optimized for AI inference co-processing |
| **ROCm** | Open-source GPU compute platform (MIT/Apache 2.0). Supports PyTorch, vLLM, SGLang, JAX. Day-0 model support for Llama, DeepSeek, Qwen |
| **AITER / ATOM** | ROCm-optimized inference kernels for vLLM/SGLang. Fused MoE, MLA, FlashAttention backends for Instinct GPUs |
| **Helios** | Rack-scale AI reference design. 72× MI455X + Venice EPYC + Pensando Vulcano NICs. 31 TB HBM4, 1.4 PB/s bandwidth |
| **Ryzen AI Embedded P100** | Edge AI processors (Zen 5 + RDNA 3.5 + XDNA 2 NPU). Up to 80 TOPS. For robotics, industrial, automotive |
| **Versal AI Edge Gen 2** | Adaptive SoCs (FPGA + AI Engine + Arm cores). Deterministic real-time control + AI inference. For robotics, ADAS, machine vision |
| **Kria SOMs** | System-on-modules with Zynq UltraScale+. Pre-built vision AI and robotics apps. KR260 Robotics Starter Kit |
| **Pensando (Vulcano)** | DPU/SmartNIC for AI infrastructure networking, storage, security. Integrated into Helios rack architecture |
| **AMD Schola** | Open-source RL plugin for Unreal Engine (MIT). Gymnasium-compatible. MuJoCo physics via UnrealRoboticsLab |
| **Silo AI** | In-house AI lab (acquired 2024, $665M). Enterprise AI solutions, model training on AMD hardware, robotics simulation partnerships |

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
  <td colspan="2">🟡 ROCm + PyTorch<br>
  <small>(no proprietary training framework)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 Schola + MuJoCo<br>
  <small>(early-stage, no integrated sim platform)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td colspan="2">⬜<br>
  <small>(relies on OSS: lm-eval-harness)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟡 Genesis SDG pipeline<br>
  <small>(demo-stage, Silo AI + partners)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">🟣 Instinct GPUs + ROCm<br>
  <small>(hardware + drivers, no scheduler)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === AI Model & Data Lifecycle === -->

<tr>
  <td><b>Model Registry</b></td>
  <td colspan="2">⬜</td>
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
  <td colspan="2">🔵 vLLM + AITER/ATOM<br>
  <small>(upstream contributor, not owner)</small></td>
  <td colspan="2">🔵 vLLM + AITER/ATOM</td>
  <td>🟡 ROCm on Ryzen AI<br>
  <small>(consumer/embedded inference)</small></td>
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
  <td colspan="2">🟣 ROCm, hipBLAS, MIOpen, RCCL</td>
  <td colspan="2">🟣 ROCm, hipBLAS, MIOpen, RCCL</td>
  <td>🟣 XDNA NPU, ROCm<br>
  <small>(Ryzen AI Embedded)</small></td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟡 Versal video codec<br>
  <small>(FPGA-based, not a standalone SDK)</small></td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟡 Kria + ROS 2<br>
  <small>(reference designs, not GPU-accel)</small></td>
</tr>

<!-- === Platform === -->

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">⬜<br>
  <small>(structural dep on Red Hat / partners)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">🟢 AMD GPU Operator, ROCm drivers</td>
  <td colspan="2">🟢 AMD GPU Operator, ROCm drivers</td>
  <td>🟣 XDNA drivers, Versal drivers<br>
  <small>(Ryzen AI + FPGA)</small></td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">⬜<br>
  <small>(structural dep on Red Hat / partners)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜<br>
  <small>(no proprietary edge OS)</small></td>
</tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Schola** | Unreal Engine plugin (MIT). MuJoCo + Gymnasium. Stable Baselines 3 / Ray RLlib for training |
| **Genesis SDG** | Silo AI demo pipeline using Genesis (open-source physics engine) for synthetic data on ROCm |
| **vLLM (AMD)** | AMD is a top-3 contributor to vLLM. AITER/ATOM provide ROCm-optimized kernels as vLLM/SGLang plugins |
| **Ryzen AI inference** | ROCm 7.2 on consumer/embedded GPUs. vLLM/SGLang supported on MI-series; XDNA NPU via separate runtime |
| **Kria + ROS 2** | KR260 Starter Kit with ROS 2 reference designs. Vitis AI for FPGA-accelerated inference |
| **AMD GPU Operator** | K8s operator for Instinct GPUs on OpenShift. ROCm drivers + device plugin. Apache 2.0 |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **Meta** | Hyperscaler | 6 GW, multi-year deal (~$60B est.). Custom MI450 + Venice EPYC + Helios racks. Largest AMD GPU deal |
| **OpenAI** | Hyperscaler | 6 GW deal (Oct 2025). MI450-based Helios deployments starting H2 2026 |
| **Microsoft Azure** | Cloud | MI300X instances available; MI350 instances planned. OpenShift AI + AMD GPU support |
| **Red Hat** | Platform | Red Hat AI 3 certified on Instinct. Joint vLLM contributions. AMD GPU Operator on OpenShift |
| **Robotec.ai** | Simulation | Open-source digital twin tools optimized for ROCm. RoSi Sensors (LiDAR/radar sim) |
| **Odyssey** | World Models | AMD Ventures invested in $310M Series B. Agora-1 world model on AMD hardware |
| **Advantech / Kontron / congatec** | Embedded | Ryzen AI Embedded P100 board partners for industrial/robotics edge |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **NVIDIA** | Broadest silicon portfolio (CPU+GPU+FPGA+DPU+embedded SoC); open-source software philosophy; no edge OS lock-in; 12 GW hyperscaler commitments (Meta+OpenAI) | Integrated simulation platform (no Isaac Sim equivalent); foundation models (no GR00T/Cosmos); mature Physical AI software stack; CUDA ecosystem depth and developer tooling |
| **Intel** | Superior GPU performance trajectory (MI350/MI450 vs Gaudi); FPGA portfolio (Versal vs Altera); stronger datacenter CPU position (46% vs Intel's declining share) | Intel's embedded edge heritage; Habana Gaudi's early enterprise AI traction; Intel Foundry Services for custom silicon |
| **Qualcomm** | Datacenter GPU scale; FPGA-based deterministic control for industrial; server CPU attach | Power-efficient mobile SoCs; cellular connectivity; automotive ADAS market share; Snapdragon edge AI maturity |

---

## Coverage Summary

- **Strong**: Datacenter GPUs (Instinct MI350/MI450), Server CPUs (EPYC), GPU drivers and math libs (ROCm), Edge silicon diversity (Ryzen AI Embedded + Versal FPGA + Kria SOMs), Infrastructure networking (Pensando DPUs)
- **Absent**: Simulation platform, Foundation models, Training frameworks, Model registry, Pipelines, CI/CD, Experiment tracking, Model monitoring, Agentic frameworks, MaaS, Media SDK, Fleet management
- **Conflicts with Red Hat**: None — AMD has no container platform, no OS, no inference server product. Purely complementary
- **Lock-in**: Minimal — ROCm is open-source; no proprietary edge OS; standard PCIe/OAM form factors. FPGA tooling (Vivado/Vitis) is proprietary

---

## Strategic Implications for Red Hat

1. **Cleanest partner in the ecosystem**: AMD has zero platform-layer products — no container runtime, no OS, no model serving product, no pipeline orchestrator. Every gap in AMD's stack maps to a Red Hat product. This is the most conflict-free hardware partnership available, unlike NVIDIA (NIM vs vLLM, KAI vs Kueue) or Intel (Tiber AI Cloud, OpenVINO).

2. **Joint vLLM investment creates shared moat**: Both AMD and Red Hat are top contributors to vLLM. AMD's AITER/ATOM kernels make vLLM competitive on Instinct GPUs (90-95% of H100 throughput). Red Hat AI's vLLM-based inference server runs natively on AMD hardware. This shared investment in the same open-source engine strengthens both parties against NVIDIA NIM.

3. **Edge silicon diversity is an opportunity**: AMD's three-tier edge portfolio (Ryzen AI Embedded x86, Versal FPGA, Kria SOM) runs standard Linux — no proprietary L4T-equivalent. RHEL Device Edge + MicroShift could be the default OS layer across all three, unlike Jetson where L4T competes with RHEL. Key question: what is XDNA NPU driver support status on RHEL?

4. **12 GW hyperscaler commitments validate ROCm**: The Meta ($60B) and OpenAI deals prove ROCm has reached production-grade reliability. As these deployments scale, ROCm ecosystem maturity will accelerate — reducing the CUDA switching cost that has historically kept enterprises on NVIDIA. Red Hat should deepen ROCm certification to capture this migration wave.

5. **Simulation gap creates partner dependency**: AMD has no Isaac Sim equivalent. Schola + MuJoCo is early-stage. AMD's Physical AI simulation story depends on partners (Robotec.ai, Odyssey) and open-source engines. Red Hat could facilitate this by ensuring OpenShift supports simulation workloads (GPU-accelerated rendering, physics engines) that run on AMD hardware — positioning as the platform where AMD's partners deploy their simulation tools.

---

## Related Reports

- [NVIDIA — competitive profile](nvidia.md)
- [AMD — ecosystem entry](../../../research/ecosystem.md)
