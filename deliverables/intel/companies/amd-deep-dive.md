# AMD — Deep Dive Research

**Date**: 2026-06-23
**Last updated**: 2026-06-23
**Classification**: Internal analysis

Supporting research for the [AMD competitive profile](amd.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, acquisition deep-dives, product architectures, governance risks, and technical dependency chains.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1969-05 | Founded by Jerry Sanders, Ed Turney, et al. as second-source x86 manufacturer |
| 2006-07 | Acquired ATI Technologies ($5.4B) — entered GPU market |
| 2014-10 | Lisa Su becomes CEO; begins turnaround from near-bankruptcy |
| 2016-06 | ROCm 1.0 launched as open-source GPU compute platform |
| 2022-02 | Acquired Xilinx ($49B) — FPGAs, adaptive SoCs, embedded |
| 2022-05 | Acquired Pensando ($1.9B) — DPUs, SmartNICs for datacenter networking |
| 2023-08 | Acquired Mipsology (undisclosed) — FPGA AI compiler technology |
| 2023-10 | Acquired Nod.ai (undisclosed) — MLIR/IREE AI compiler, SHARK runtime |
| 2024-07 | Acquired Silo AI ($665M) — Europe's largest private AI lab |
| 2024-08 | Acquired ZT Systems ($4.9B) — hyperscale rack-scale AI infrastructure design |
| 2025-03 | ZT Systems acquisition closed. Manufacturing arm divested to Sanmina ($3B) |
| 2025-05 | ROCm 7 GA — 3.5× inference, 3× training improvement over ROCm 6 |
| 2025-06 | Acquired Brium (undisclosed) — compiler and AI inference optimization |
| 2025-10 | OpenAI 6 GW partnership announced — MI450 deployments from H2 2026 |
| 2025-11 | AMD Financial Analyst Day — >35% datacenter revenue CAGR target, >$20 non-GAAP EPS |
| 2025-12 | MI350 Series ships (CDNA 4) |
| 2026-01 | CES 2026 — Ryzen AI Embedded P100/X100 Series announced |
| 2026-02 | Meta 6 GW partnership announced (~$60B est.). Custom MI450 + Venice EPYC |
| 2026-03 | Ryzen AI Embedded P100 expanded (8-12 core variants, 80 TOPS) |
| 2026-05 | Q1 2026 earnings: $10.3B revenue, $5.8B datacenter (57% YoY growth) |
| 2026-H2 | MI450/Helios shipments begin (Meta, OpenAI first deployments) |

### Acquisitions — What Each Brought

#### Xilinx (2022)

- **Price**: $49B (all-stock, largest semiconductor acquisition in history)
- **Technology**: FPGAs (Artix, Kintex, Virtex), Adaptive SoCs (Versal, Zynq), AI Engines, Vitis development tools, Vivado design suite
- **Integration**: Became AMD Adaptive Computing division. Versal AI Edge products rebranded. Kria SOMs maintained as edge robotics platform
- **Significance**: Gave AMD deterministic, real-time compute for industrial/robotics edge — a capability neither NVIDIA nor Intel GPU-centric stacks can match. FPGAs enable custom sensor interfaces, functional safety isolation, and sub-microsecond control loops

#### Pensando (2022)

- **Price**: $1.9B
- **Technology**: Elba DPU (P4-programmable data plane), distributed services architecture for networking, storage, security
- **Integration**: Integrated into datacenter infrastructure. Vulcano next-gen DPU designed into Helios rack architecture
- **Significance**: Completes AMD's datacenter silicon portfolio (CPU + GPU + DPU). Enables hardware-accelerated networking within AI racks — competitive with NVIDIA BlueField/ConnectX

#### Silo AI (2024)

- **Price**: $665M (all-cash)
- **Technology**: Enterprise AI solutions, multilingual LLM training (Poro, Viking models), industrial AI deployment
- **Integration**: Became part of AMD Artificial Intelligence Group under SVP Vamsi Boppana. Team of ~300 AI scientists/engineers
- **Significance**: AMD's in-house AI lab. Provides model training expertise, Physical AI partnerships (Robotec.ai, Parallel Domain), and enterprise AI consulting. Trained models on LUMI supercomputer (12K+ MI250X GPUs)

#### ZT Systems (2024–2025)

- **Price**: $4.9B (cash + stock)
- **Technology**: Hyperscale rack-scale AI infrastructure design, 15+ years of hyperscaler deployment experience
- **Integration**: Design and customer enablement teams retained at AMD. Manufacturing arm sold to Sanmina for $3B (preferred NPI manufacturing partner)
- **Significance**: Gives AMD direct rack-scale system design capability — competing with NVIDIA DGX/HGX without owning manufacturing liability. Helios reference design is the first fruit of this acquisition

#### Nod.ai (2023)

- **Price**: Undisclosed
- **Technology**: SHARK ML distribution (LLVM/MLIR/IREE-based), Torch-MLIR contributions, OpenXLA/IREE code generation
- **Integration**: AI compiler team merged into ROCm software group
- **Significance**: Reduced manual kernel optimization needs for ROCm. Compiler-based automation for model deployment across AMD silicon

#### Mipsology (2023)

- **Price**: Undisclosed
- **Technology**: Zebra AI software for FPGA-based inference. Supports TensorFlow, PyTorch, ONNX Runtime on FPGAs
- **Integration**: Merged into Adaptive Computing division
- **Significance**: Enables AI inference on Xilinx FPGAs without manual RTL design — lowers the bar for FPGA-based edge AI

#### Brium (2025)

- **Price**: Undisclosed
- **Technology**: Compiler and AI inference optimization expertise
- **Integration**: Strengthens ROCm compiler and optimization team
- **Significance**: Part of ongoing pattern of acquiring compiler talent to close the CUDA tooling gap

---

## 2. Product Architecture Details

### Instinct MI350/MI355X (CDNA 4)

| Aspect | Details |
| --- | --- |
| **Architecture** | CDNA 4, ground-up redesign. 288 GB HBM3E, 8 TB/s bandwidth. FP4/FP6/FP8 support |
| **Runtime dependencies** | ROCm 7.x. Linux (RHEL 9.6, Ubuntu 24.04/26.04). Standard OAM form factor |
| **Extension model** | ROCm open-source stack. hipBLAS, MIOpen, RCCL for compute libraries. AITER for optimized kernels |
| **Key limitations** | ROCm ecosystem still thinner than CUDA in tooling depth. No equivalent to TensorRT for graph optimization. FlashAttention 3 not yet fully optimized |

### Instinct MI450 / Helios (CDNA 5)

| Aspect | Details |
| --- | --- |
| **Architecture** | 12 compute chiplets on TSMC N2 + 3 chiplets on 3nm. 320B transistors. 432 GB HBM4, 19.6 TB/s |
| **Runtime dependencies** | ROCm (next major version). Venice EPYC CPUs. Pensando Vulcano NICs for rack-scale networking |
| **Extension model** | Helios rack-scale reference design: 72× MI455X GPUs, 31 TB aggregate HBM4, 1.4 PB/s bandwidth |
| **Key limitations** | Not yet shipping (H2 2026). Custom variants for Meta/OpenAI may diverge from general availability product |

### ROCm Software Stack

| Aspect | Details |
| --- | --- |
| **Architecture** | HIP (CUDA-compatible API) → hipBLAS/MIOpen/RCCL (math libs) → PyTorch/JAX/vLLM/SGLang (frameworks). AITER/ATOM as optimized kernel plugins |
| **Runtime dependencies** | Linux kernel with amdgpu driver. Instinct MI300X/MI325X/MI350X/MI355X for datacenter. Radeon RX 7000+ for consumer |
| **Extension model** | Fully open-source (MIT/Apache 2.0, excluding firmware). Triton compiler support. Plugin architecture for vLLM/SGLang |
| **Key limitations** | OneROCm unification still in progress — embedded XDNA NPU uses separate runtime from Instinct GPU ROCm. Some frameworks still hardcode CUDA assumptions |

### Versal AI Edge Gen 2

| Aspect | Details |
| --- | --- |
| **Architecture** | FPGA fabric + AI Engine tiles + Arm Cortex-A78AE (8-core) + Cortex-R52 real-time cores (10-core). Video codec unit |
| **Runtime dependencies** | Vitis AI for inference. Vivado for FPGA design. PetaLinux or standard Linux |
| **Extension model** | Fully programmable FPGA fabric. AI Engine API for inference acceleration. Standard sensor interfaces (GMSL2, CAN-FD) |
| **Key limitations** | Vitis/Vivado toolchains are proprietary. FPGA development requires specialized expertise. Higher per-unit cost than fixed-function ASICs |

### Ryzen AI Embedded P100

| Aspect | Details |
| --- | --- |
| **Architecture** | Zen 5 CPU (8-12 cores) + RDNA 3.5 GPU + XDNA 2 NPU (50 TOPS). BGA package |
| **Runtime dependencies** | Standard Linux (Ubuntu, RHEL). ROCm for GPU compute. Separate XDNA driver for NPU |
| **Extension model** | Standard x86 + GPU + NPU. Compatible with existing ROS 2, VLA model pipelines |
| **Key limitations** | Production shipments starting mid-2026. XDNA NPU runtime separate from ROCm GPU runtime. Limited board partner ecosystem vs Jetson |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **ROCm** | HIP, hipBLAS, MIOpen, RCCL, ROCr | MIT / Apache 2.0 | GPU firmware (closed). No proprietary packaging layer |
| **AITER/ATOM** | ROCm plugins for vLLM/SGLang | Apache 2.0 | Fused kernels optimized for CDNA architecture |
| **Schola** | Unreal Engine plugin + Gymnasium | MIT | None — fully open-source |
| **Kria + Vitis AI** | ROS 2 reference designs | Apache 2.0 (ROS 2) | Vitis AI runtime and Vivado toolchain are proprietary |
| **AMD GPU Operator** | K8s operator + device plugin | Apache 2.0 | None — fully open-source |

### Pattern Analysis

AMD's OSS strategy is **"open compute substrate + upstream contribution"** — fundamentally different from NVIDIA's "open engine + proprietary packaging" pattern. AMD contributes directly to upstream projects (vLLM, SGLang, PyTorch, Triton) rather than wrapping them in proprietary products. There is no AMD equivalent of NIM, NeMo, or OSMO.

The trade-off: AMD has no proprietary software moat, but also no software conflicts with partners. Red Hat, for example, ships vLLM on AMD hardware with zero licensing friction — unlike NIM where NVIDIA's enterprise packaging competes with Red Hat's own serving stack.

The exception is FPGA tooling: Vivado and Vitis are proprietary development tools with no open-source equivalent. This creates a smaller lock-in vector in the edge/embedded space, though the runtime outputs (bitstreams, AI models) run on standard Linux.

### Notable Dependencies

- **vLLM**: AMD is a top-3 contributor. AITER provides ROCm-specific FlashAttention, MoE, and MLA kernels. ATOM integrates these into vLLM/SGLang via plugin architecture. AMD's vLLM roadmap (Q2 2026) targets decode parity with SGLang/ATOM at concurrency 128/512
- **PyTorch**: Full ROCm backend maintained upstream. No fork — AMD contributes directly to pytorch/pytorch
- **Triton**: AMD contributes ROCm backend to OpenAI's Triton compiler. Performance CI runs nightly on AMD hardware
- **Hugging Face**: Day-0 integration for model downloads. Nightly ROCm validation of popular models

---

## 4. Governance & Community Risk

<!-- AMD does not steward major OSS projects in the way NVIDIA stewards Newton or KAI.
     Their strategy is upstream contribution rather than project ownership.
     Governance risk is therefore lower but influence is also lower. -->

### ROCm Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | AMD-controlled (no foundation) |
| **Core maintainer employment** | 100% AMD employees |
| **CLA/DCO** | CLA required for contributions |
| **Commit diversity** | Primarily AMD. Some contributions from Meta, hyperscalers |
| **Abandonment risk** | Low — ROCm is AMD's strategic software platform. 12 GW of hyperscaler commitments depend on it |

### AMD GPU Operator Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | AMD-controlled |
| **Core maintainer employment** | AMD employees |
| **CLA/DCO** | Standard Apache 2.0 |
| **Commit diversity** | AMD-dominated. Red Hat contributes OpenShift integration |
| **Abandonment risk** | Low — required for enterprise GPU deployments |

---

## 5. Hardware Platform Details

### Current Hardware

#### Datacenter GPUs (Instinct Series)

| Product | Architecture | Memory | Bandwidth | TDP | Status |
| --- | --- | --- | --- | --- | --- |
| MI300X | CDNA 3 | 192 GB HBM3 | 5.3 TB/s | 750W | Shipping |
| MI325X | CDNA 3 | 256 GB HBM3E | 6 TB/s | 750W | Shipping |
| MI350X | CDNA 4 | 288 GB HBM3E | 8 TB/s | 1,000W (air) | Shipping |
| MI355X | CDNA 4 | 288 GB HBM3E | 8 TB/s | 1,400W (liquid) | Shipping |
| MI350P | CDNA 4 | PCIe form factor | — | — | Shipping (enterprise) |

#### Server CPUs (EPYC)

| Product | Cores | Status | Note |
| --- | --- | --- | --- |
| Turin (5th Gen) | Up to 192 | Shipping | Zen 5 architecture |
| Venice (6th Gen) | TBD | H2 2026 | AI-optimized. Designed into Helios |
| Verano | TBD | Post-Venice | Workload-specific optimizations for Meta |

#### Edge / Embedded

| Product | Type | AI Performance | Status |
| --- | --- | --- | --- |
| Ryzen AI Embedded P100 (4-6 core) | x86 SoC | ~50 TOPS | Sampling, production Q2 2026 |
| Ryzen AI Embedded P100 (8-12 core) | x86 SoC | ~80 TOPS | Sampling, production Jul 2026 |
| Versal AI Edge Gen 2 | Adaptive SoC (FPGA) | Variable (AI Engine tiles) | Shipping |
| Kria K26 SOM | Zynq UltraScale+ | ~1.4 TOPS (INT8) | Shipping |

#### Networking

| Product | Type | Status |
| --- | --- | --- |
| Pensando Elba | DPU/SmartNIC | Shipping |
| Pensando Vulcano | Next-gen DPU | Designed into Helios, H2 2026 |

### Roadmap

| Product | Timeline | Key Changes |
| --- | --- | --- |
| **MI450 / MI455X** | H2 2026 | CDNA 5, 432 GB HBM4, 19.6 TB/s, 320B transistors |
| **Helios rack** | H2 2026 | 72× MI455X + Venice EPYC + Vulcano NICs |
| **MI500 Series** | 2027 | Next-gen announced at Analyst Day |
| **Venice EPYC** | H2 2026 | 6th Gen server CPU, AI-optimized |

### Pricing

AMD's datacenter GPU pricing is not publicly disclosed but is structured through OEM/hyperscaler deals. MI350P enterprise PCIe cards are priced through channel partners (Dell, HPE, Supermicro, Lenovo). The Meta and OpenAI deals include performance-based equity warrants (160M shares each), suggesting aggressive pricing to capture market share.

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Meta** | Millions of EPYC CPUs, MI300/MI350 GPUs | 6 GW, multi-gen, ~$60B. 160M share warrant | Custom MI450 silicon. Co-designed Helios. Venice/Verano CPUs |
| **OpenAI** | MI300X initial deployment | 6 GW, multi-gen. 160M share warrant | MI450 + Helios. Tied to Stargate buildout |
| **Microsoft Azure** | MI300X cloud instances | Cloud GPU instances. OpenShift AI + AMD GPU support | API-level cloud integration |
| **Red Hat** | — | Red Hat AI 3 certified on Instinct. Joint vLLM development | AMD GPU Operator on OpenShift. RHEL AI bare-metal on MI300X |
| **Robotec.ai** | — | Silo AI collaboration | RoSi sensor simulation optimized for ROCm |
| **Odyssey** | — | AMD Ventures in $310M Series B (Jun 2026) | Agora-1 world model runs on AMD hardware |

### Developer Ecosystem

- **AMD Developer Cloud**: Cloud-based access to Instinct GPUs for development and testing
- **AMD AI DevDay 2026**: Annual developer conference (San Francisco). Technical workshops on Physical AI, VLA pipelines, SDG
- **AMD Advancing AI 2026**: Major event (July 22-23, San Francisco). Customer/partner showcase
- **AMD AI Robotics Hackathon**: 15,000+ student participants in partnership with Hack Club
- **ROCm Developer Hub**: Documentation, tutorials, model support matrix
- **GPUOpen**: Open-source tools and samples, including Schola, game optimization tools

---

## 7. Detailed Competitive Analysis

### vs NVIDIA

| Dimension | AMD | NVIDIA |
| --- | --- | --- |
| **Datacenter GPU perf** | MI355X within single-digit % of B200 at MLPerf Inference 6.0. MI450 targets leadership | H200/B200 currently leading. Rubin (2026) next-gen |
| **Memory capacity** | MI350: 288 GB HBM3E. MI450: 432 GB HBM4 | B200: 192 GB HBM3E. Rubin: HBM4 |
| **Software ecosystem** | ROCm open-source. Thinner tooling, fewer custom kernels. No TensorRT equivalent | CUDA 15+ year ecosystem. TensorRT, NIM, NeMo, deep tooling |
| **Simulation** | Schola (MIT, early-stage). Partner-dependent (Robotec.ai) | Isaac Sim, Newton, Omniverse — vertically integrated |
| **Foundation models** | None (partner/OSS-dependent) | GR00T N1, Cosmos, NeMo models |
| **Edge** | Ryzen AI Embedded (x86 + NPU) + Versal FPGA. No proprietary OS | Jetson (ARM SoC) + L4T (Ubuntu-based). Isaac ROS. Proprietary perception |
| **Enterprise software** | None — relies on Red Hat, partners | NVAIE ($4,500/GPU/year). NIM, NeMo, NGC |
| **Rack-scale** | Helios (ZT Systems design). 72× MI455X | DGX SuperPOD / GB200 NVL72. Liquid-cooled |
| **Hyperscaler deals** | 12 GW (Meta 6 GW + OpenAI 6 GW) | Dominant hyperscaler supplier. Multi-GW with all major clouds |

### vs Intel (Gaudi / Xeon / Altera)

| Dimension | AMD | Intel |
| --- | --- | --- |
| **Datacenter GPU** | MI350/MI450 with clear MLPerf results. 12 GW hyperscaler commitments | Gaudi 3 limited adoption. No comparable hyperscaler deals |
| **Server CPU** | EPYC at 46% x86 server revenue share, gaining | Xeon declining share. Architectural refresh with Sierra Forest/Granite Rapids |
| **Edge/FPGA** | Versal AI Edge Gen 2, Kria SOMs — strong industrial heritage (Xilinx) | Altera (former Intel Foundry). Less mature AI Engine equivalent |
| **AI software** | ROCm (production-grade for PyTorch/vLLM) | OpenVINO, Intel Extension for PyTorch. More fragmented |

---

## Sources

- [AMD Instinct Accelerators](https://www.amd.com/en/products/accelerators/instinct.html)
- [AMD & Meta 6 GW Partnership](https://www.amd.com/en/newsroom/press-releases/2026-2-24-amd-and-meta-announce-expanded-strategic-partnersh.html)
- [AMD & OpenAI 6 GW Partnership](https://www.amd.com/en/newsroom/press-releases/2025-10-6-amd-and-openai-announce-strategic-partnership-to-d.html)
- [AMD Q1 2026 Earnings](https://ir.amd.com/news-events/press-releases/detail/1284/amd-reports-first-quarter-2026-financial-results)
- [ROCm 7 Introduction](https://www.amd.com/en/blogs/2025/enabling-the-future-of-ai-introducing-amd-rocm-7-and-the-amd-developer-cloud.html)
- [AMD Silo AI Acquisition](https://www.amd.com/en/newsroom/press-releases/2024-8-12-amd-completes-acquisition-of-silo-ai-to-accelerate.html)
- [AMD ZT Systems Acquisition](https://www.amd.com/en/newsroom/press-releases/2025-3-31-amd-completes-acquisition-of-zt-systems.html)
- [Ryzen AI Embedded P100](https://www.amd.com/en/newsroom/press-releases/2026-1-5-amd-introduces-ryzen-ai-embedded-processor-portfol.html)
- [AMD Embedded: Powering Physical AI](https://www.amd.com/en/blogs/2025/amd-embedded-business-transformation.html)
- [AMD Schola v2](https://gpuopen.com/learn/announcing-amd-schola-v2-nextgen-rl-unreal-engine/)
- [Robotec.ai + AMD Silo AI](https://www.amd.com/en/blogs/2025/advancing-robotics-simulations-with-robotec-ai-and-amd-silo-ai-.html)
- [vLLM ROCm Attention Backend](https://blog.vllm.ai/2026/02/27/rocm-attention-backend.html)
- [AMD ROCm Development Roadmap Q2 2026](https://github.com/vllm-project/vllm/issues/44092)
- [Red Hat & AMD AI Collaboration](https://www.redhat.com/en/about/press-releases/red-hat-and-amd-collaborate-advance-ai-solutions-and-empower-enterprises-cognitive-era)
- [Red Hat AI with AMD ROCm](https://www.redhat.com/en/blog/agentic-ai-demands-new-infrastructure-stack-amd-and-red-hat-deliver)
- [AMD Financial Analyst Day 2025](https://www.amd.com/en/newsroom/press-releases/2025-11-11-amd-unveils-strategy-to-lead-the-1-trillion-compu.html)
- [MI400 Series Analysis](https://tech-insider.org/amd-mi400-series-ai-gpu-data-center-2026/)
- [ROCm vs CUDA 2026](https://www.spheron.network/blog/rocm-vs-cuda-gpu-cloud-2026/)
- [AMD Odyssey Investment](https://techfundingnews.com/odyssey-310m-series-b-nvidia-amazon-amd-ai-world-models/)
