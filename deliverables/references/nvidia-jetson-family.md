# NVIDIA Jetson Thor Family Analysis

*July 2026 — Based on NVIDIA announcements at Computex/GTC Taipei and July 15, 2026 launch event*

## Overview

NVIDIA expanded its Jetson edge AI platform from a single flagship (AGX Thor / T5000, shipping since Q3 2025) to a four-tier family spanning 400–2,070 FP4 TFLOPS. The T3000 and T2000 modules, announced July 15, 2026, target mainstream robotics and edge AI — positioned as successors to the Orin AGX and Orin NX, respectively. Both ship Q1 2027.

All four modules share the Blackwell GPU architecture, Arm Neoverse V3AE CPUs, and a unified software stack (JetPack 7.2.1), enabling code portability across tiers. Developers can emulate T3000/T2000 performance on the existing AGX Thor dev kit — no dedicated dev kits for the lower tiers.

## Hardware Specifications

### Compute and Memory

| | **Thor T2000** | **Thor T3000** | **Thor T4000** | **Thor T5000** |
| --- | --- | --- | --- | --- |
| GPU | Blackwell, 1024 CUDA | Blackwell, 1536 CUDA | Blackwell, 1536 CUDA | Blackwell, 2560 CUDA |
| CPU | 6-core Neoverse V3AE | 8-core Neoverse V3AE | 12-core Neoverse V3AE | 14-core Neoverse V3AE |
| AI compute | 400 FP4 TFLOPS | 865 FP4 TFLOPS | 1,200 FP4 TFLOPS | 2,070 FP4 TFLOPS |
| Memory | 16GB LPDDR5X | 32GB LPDDR5X | 64GB LPDDR5X | 128GB LPDDR5X |
| Mem bus | 128-bit (implied) | 256-bit | 256-bit | 256-bit |
| Mem bandwidth | 137 GB/s | 273 GB/s | 273 GB/s | 273 GB/s |
| MIG support | — | — | 6 TPCs | 10 TPCs |
| Power | ~40W | ~65–70W | 40–70W | 40–130W |
| Status | Q1 2027 | Q1 2027 | Shipping | Shipping |
| Price (module) | TBD | TBD | $1,999 | $2,999 |

### I/O Interfaces

Detailed I/O specifications for T3000 and T2000 are **not yet published** (listed as TBD by NVIDIA and carrier board partners). The table below captures what is confirmed vs. what can only be referenced from the T4000/T5000 baseline.

| | **Thor T2000** | **Thor T3000** | **Thor T4000** | **Thor T5000** |
| --- | --- | --- | --- | --- |
| PCIe | Gen5 (lane count TBD) | Gen5 (lane count TBD) | Gen5 (x8+x4+x2, 14 lanes) | Gen5 (x8+x4+x2, 14 lanes) |
| Ethernet | 2× 10GbE | 25GbE (port count TBD) | 3× 25GbE | 4× 25GbE (100 Gbps) |
| USB | TBD | TBD | 3× USB 3.2, 4× USB 2.0 | 3× USB 3.2, 4× USB 2.0 |
| CSI camera | TBD | TBD | 16 lanes MIPI CSI-2 | 16 lanes MIPI CSI-2 |
| CAN | TBD | TBD | Not listed | 4× CAN-FD |
| Display | TBD | TBD | 4× HDMI 2.1 / DP 1.4a | 4× HDMI 2.1 / DP 1.4a |
| Video encode | TBD | TBD | 1× NVENC | 2× NVENC |
| Video decode | TBD | TBD | 1× NVDEC | 2× NVDEC |
| I2C / SPI / UART | TBD | TBD | 13× I2C, 3× SPI, 4× UART | 13× I2C, 3× SPI, 4× UART |
| Storage | TBD | TBD | NVMe (PCIe Gen5) | NVMe (PCIe Gen5) |

### Form Factor

| | **Thor T2000** | **Thor T3000** | **Thor T4000/T5000** |
| --- | --- | --- | --- |
| Dimensions | TBD (~50×87mm est.) | TBD (~50×87mm est.) | 100×87mm |
| Connector | TBD | TBD | 699-pin B2B |

Both T3000 and T2000 are described as "roughly half the size" of the T4000/T5000, suggesting a **new, smaller module form factor** — neither the 699-pin B2B (AGX class) nor the 260-pin SO-DIMM (Orin NX/Nano class). This is a critical unknown for carrier board partners.

**Not pin-compatible with Orin.** All Thor modules require new carrier board designs. Partners (Connect Tech, Auvidea, Antmicro, AAEON, Seeed Studio) are preparing carrier boards; Connect Tech confirms support for both standard T3000 and IGX T3000 at launch.

## Comparison with Orin Family (Replacement Targets)

### T3000 vs. AGX Orin 64GB

| | **AGX Orin 64GB** | **Thor T3000** | Delta |
| --- | --- | --- | --- |
| AI compute | 275 INT8 TOPS | 865 FP4 TFLOPS | ~3x (precision-adjusted) |
| Memory | 64GB LPDDR5 | 32GB LPDDR5X | Half capacity, faster type |
| Mem bandwidth | 205 GB/s | 273 GB/s | +33% |
| Ethernet | 1× 10GbE | 25GbE | 2.5x per-port |
| PCIe | Gen4 | Gen5 | 2x per-lane bandwidth |
| Power | 15–60W | ~65–70W | Similar envelope |
| SDMMC | 1× | Dropped (Thor family) | No SD card boot |

The T3000 trades memory capacity (32GB vs. 64GB) for higher bandwidth and compute density. NVIDIA addresses the capacity gap through software: Jetson Agent Skills demonstrated 15GB memory savings at UBTech, Agile Robots, and Connect Tech — enough to migrate 64GB Orin workloads to 32GB Thor.

**Memory bandwidth is the key metric for LLM inference.** The T3000's 273 GB/s vs. Orin's 205 GB/s yields ~33% improvement on bandwidth-bound workloads (autoregressive LLM decoding, VLM inference). The claim that T3000 "matches T5000 inference performance" is credible because T3000 and T5000 share the same 273 GB/s bandwidth ceiling — the T5000's extra compute headroom only helps on compute-bound workloads (batched inference, training).

### T2000 vs. Orin NX 16GB

| | **Orin NX 16GB** | **Thor T2000** | Delta |
| --- | --- | --- | --- |
| AI compute | 157 INT8 TOPS | 400 FP4 TFLOPS | ~2.5x (precision-adjusted) |
| Memory | 16GB LPDDR5 | 16GB LPDDR5X | Same capacity, faster type |
| Mem bandwidth | 102 GB/s | 137 GB/s | +34% |
| Ethernet | 1× GbE | 2× 10GbE | 20x aggregate |
| PCIe | Gen4 | Gen5 | 2x per-lane bandwidth |
| Power | 10–25W | ~40W | Notably higher |

The T2000's networking upgrade (GbE → 2× 10GbE) is the most dramatic interface leap — enables multi-camera fusion and fleet telemetry patterns infeasible on Orin NX. Power draw roughly doubles, which matters for battery-powered AMRs.

**Bandwidth caveat:** T2000 at 137 GB/s is below AGX Orin's 205 GB/s. For large LLM inference, the T2000 would be slower than AGX Orin despite higher TFLOPS. The T2000 is suited for vision-only or smaller model workloads, not as a general AGX Orin replacement.

## Software Stack

### JetPack 7.2.1

Unified SDK across all Thor tiers. T3000 emulation available July 2026; T2000 emulation in a future release.

### Cosmos 3 Edge

4-billion-parameter world foundation model designed for on-device inference on Thor. Developers can post-train for specific embodiments and sensors "in about a day." Distinct from the larger Cosmos models (Cosmos 2, Cosmos Predict1/Transfer1) — specifically optimized for edge deployment constraints.

### Jetson Agent Skills

Open-source AI-assisted development workflows packaged as structured skill files for AI coding assistants. Two repositories:

- **[jetson-device-skills](https://github.com/NVIDIA-AI-IOT/jetson-device-skills)** — On-device: diagnostics, memory audit, headless mode, inference tuning (vLLM, SGLang, llama.cpp, TensorRT), LLM serving, benchmarking, speculative decoding (EAGLE-3)
- **[jetson-bsp-skills](https://github.com/NVIDIA-AI-IOT/jetson-bsp-skills)** — Host-side BSP customization: pinmux, PCIe, USB, camera, clocks, flash, validation

Supported agent runtimes: Claude Code, OpenAI Codex, Cursor, NemoClaw/OpenClaw. Developers describe tasks in natural language; the agent follows structured procedures. This is a signal of NVIDIA investing in AI-assisted developer experience — and notably supporting open agent runtimes rather than proprietary-only tooling.

### NemoClaw Blueprints

Agentic orchestration framework making Jetson an "agentic-ready platform." Orchestrates intelligent agents for physical AI workloads. Ties into the broader NemoClaw/OpenClaw ecosystem.

### NVIDIA Halos for Robotics

Full-stack functional safety system available on the IGX T3000 variant. Required for industrial deployments needing safety certification (ISO 13849, IEC 61508). Key differentiator for production robotics vs. research/prototyping.

## Ecosystem Partners

### Robotics / Humanoid

1X, Agile Robots, Amazon Robotics, Boston Dynamics, FANUC, GROOVE X, Hitachi, Techman Robot, UBTech

### Carrier Board Partners

ADLINK, Advantech, AAEON, Aetina, Auvidea, AVerMedia, Connect Tech, ForeCR, JWIPC, NEXCOM, Realtimes, Seeed Studio, Twowin, TZTEK, YUAN

### Software / Migration Partners

Antmicro, Neurealm, REBOTNIX, RidgeRun — providing emulation and migration solutions

## Platform Implications

1. **Cost-down path for production robotics.** The T3000 enables OEMs to deploy Thor-class inference at roughly half the BOM cost of T5000, with the IGX safety variant covering industrial certification needs. This accelerates the transition from prototype (AGX Orin/Thor dev kits) to mass production.

2. **Memory bandwidth > TFLOPS for LLM workloads.** The T3000 and T5000 share the 273 GB/s bandwidth ceiling, making T3000 the cost-efficient choice for inference-only deployments. The T2000 at 137 GB/s is positioned for vision and smaller models, not full LLM stacks.

3. **New form factor creates ecosystem friction.** The smaller module size means new carrier boards — not a drop-in Orin replacement despite the "replacement" positioning. Partners are preparing but designs won't finalize until connector specs are published.

4. **AI-assisted development as platform strategy.** Jetson Agent Skills lower the barrier to BSP customization and memory optimization — the two biggest pain points in moving from Orin to Thor. NVIDIA is using AI agents to solve the migration problem that the hardware incompatibility creates.

5. **Edge world models become practical.** Cosmos 3 Edge (4B parameters, post-trainable in ~1 day) on T3000 hardware makes on-device world model inference viable for mainstream robotics — not just flagship humanoids.

## Sources

- [NVIDIA Blog — Jetson Thor Robotics Edge AI Agent](https://blogs.nvidia.com/blog/jetson-thor-robotics-edge-ai-agent/) (July 15, 2026)
- [NVIDIA — Jetson Thor Product Page](https://www.nvidia.com/en-us/autonomous-machines/embedded-systems/jetson-thor/)
- [CNX Software — T2000 and T3000 Modules](https://www.cnx-software.com/2026/07/16/nvidia-jetson-t2000-and-t3000-modules-for-edge-ai-and-robotics-applications/)
- [ServeTheHome — Expanded Thor Lineup](https://www.servethehome.com/nvidia-announces-expanded-jetson-thor-lineup-with-mid-range-t3000-and-t2000-modules/)
- [Connect Tech — T3000/T2000 Launch](https://connecttech.com/jetson-t3000-t2000-launch/)
- [NVIDIA Developer Forums — Jetson Agent Skills](https://forums.developer.nvidia.com/t/jetson-agent-skills-ai-assisted-workflows-for-device-bsp-customization/374150)
- [RidgeRun — Jetson Thor Features Guide](https://developer.ridgerun.com/wiki/index.php/NVIDIA_Jetson_Thor:_Powering_the_Future_of_Physical_AI)
- [Forecr — Orin vs Thor Comparison](https://www.forecr.io/blogs/all/nvidia-jetson-orin-family-vs-thor-what-you-need-to-know)
