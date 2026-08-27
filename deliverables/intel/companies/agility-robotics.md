# Agility Robotics — Competitive Profile

**Date**: 2026-07-22
**Last updated**: 2026-07-22
**Classification**: Internal analysis — not for public repo

See [deep-dive](agility-robotics-deep-dive.md) for manufacturing details, product architecture, and competitive analysis.

---

## At a Glance

Agility Robotics is a venture-backed humanoid robotics company (Oregon State University spinout, 2015) building purpose-built logistics humanoids. Its Physical AI thesis is **"bipedal humanoids as warehouse labor, sold as a service"** — a vertically integrated approach spanning robot hardware (Digit), fleet orchestration software (Arc), and dedicated manufacturing (RoboFab). Agility is going public via SPAC merger with Churchill Capital Corp XI at a $2.5B valuation, becoming the first publicly listed pure-play humanoid robotics company. Unlike general-purpose competitors (Figure AI, Tesla Optimus), Agility focuses narrowly on logistics — tote handling, conveyor loading, warehouse traversal — where bipedal locomotion solves problems wheeled robots cannot (ramps, dock plates, human-scale aisles).

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | ~$683M raised (Series C $400M, March 2025 at $2.1B). SPAC proceeds ~$620M ($420M trust + $200M PIPE led by Foxconn). $300M+ in multi-year booked revenue |
| **Physical AI thesis** | Purpose-built bipedal humanoid for logistics, delivered as Robot-as-a-Service ($30/hr). Own hardware + fleet software + manufacturing |
| **Platform coverage** | ~8% of blocks — concentrated in edge inference, robotics application layer, and fleet orchestration |
| **Relationship to Red Hat** | Mixed — potential customer for edge OS and training infrastructure, but Arc fleet platform competes with FlightCtl at the fleet management layer |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Digit v4** | Current-generation bipedal humanoid: 175 cm, 65 kg, 28 DOF, 16 kg payload, 360° vision (LiDAR + 4× Intel RealSense + IMU), ~8-hr battery. BOM ~$125K. First OSHA-recognized safety field inspection for a humanoid |
| **Digit v5** | Next-generation: 50 lb (23 kg) payload, 22-hr operation, rapid-charge batteries. "Cooperatively safe" — designed for barrier-free human-robot collaboration via NVIDIA Halos. $300M+ in pre-orders. Commercial launch imminent |
| **Agility Arc** | Cloud fleet orchestration platform (SaaS). Real-time KPIs (uptime, throughput, MTBI), WMS/WES/MES integration via standard APIs, fleet support/troubleshooting. Launched March 2024 |
| **RoboFab** | 70K sq ft humanoid manufacturing facility in Salem, OR. 10K units/year nameplate capacity, currently ~8 units/shift. ~75% US-sourced components. 500 employees at peak |

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
  <td>⬜</td>
  <td>🟢 RL policy training<br>
  <small>(MuJoCo + Isaac Lab)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 NVIDIA Isaac Sim<br>
  <small>(uses open tools, no proprietary sim)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>⬜</td>
  <td>🟡 Internal eval<br>
  <small>(deployment metrics via Arc)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Proprietary<br>
  <small>(65K+ hrs operational data, 9 sites)</small></td>
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
  <td>🟡 Arc metrics<br>
  <small>(uptime, throughput, MTBI)</small></td>
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
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟢 Whole-body control<br>
  <small>(RL-trained foundation model)</small></td>
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
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 Onboard inference<br>
  <small>(NVIDIA Jetson AGX Thor)</small></td>
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
  <td>🟣 NVIDIA CUDA<br>
  <small>(Jetson AGX Thor)</small></td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 Sensor fusion<br>
  <small>(LiDAR + 4× RealSense + IMU)</small></td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 Proprietary stack<br>
  <small>(bipedal locomotion + manipulation)</small></td>
</tr>

<!-- === Platform === -->

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟣 NVIDIA GPU drivers<br>
  <small>(Jetson AGX Thor)</small></td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 Linux<br>
  <small>(likely L4T / Jetson OS)</small></td>
</tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Digit locomotion** | RL-trained whole-body control model. Training uses MuJoCo (Apache 2.0) + NVIDIA Isaac Lab (BSD-3). Proprietary policy |
| **Digit perception** | Proprietary sensor fusion. Hardware: Intel RealSense (Apache 2.0 SDK), LiDAR |
| **Agility Arc** | Proprietary cloud platform. No disclosed OSS foundations |
| **Edge compute** | NVIDIA Jetson AGX Thor. L4T (NVIDIA proprietary Linux), CUDA |
| **Safety** | NVIDIA Halos (proprietary). First humanoid to integrate Halos Core + IGX Thor |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **NVIDIA** | Silicon + software | Jetson AGX Thor compute, Isaac Sim/Lab for simulation, Halos for safety certification. NVIDIA is also an investor |
| **Amazon** | Investor + customer | Industrial Innovation Fund investor. Pilot customer for tote recycling. Dual role creates concentration risk |
| **GXO Logistics** | Customer | Industry-first multi-year commercial RaaS agreement. 100K+ totes moved. Deployed at Spanx facility |
| **Foxconn** | Investor | Led $200M PIPE for SPAC. Manufacturing expertise potentially relevant for RoboFab scale-up |
| **Schaeffler** | Customer | Active deployment site — industrial manufacturing |
| **Toyota** | Customer | Toyota Motor Manufacturing Canada — active deployment |
| **Mercado Libre** | Customer | Latin American logistics — geographic expansion proof point |
| **Intel** | Component supplier | RealSense depth cameras (4× per Digit) |
| **Zion Solutions** | Systems integrator | Channel partner for customer deployment and integration |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Figure AI** | Fleet orchestration platform (Arc); 65K+ operational hours across 9 commercial sites; purpose-built logistics form factor; RaaS business model with proven unit economics ($30/hr, $10-12/hr operating cost) | Figure's dexterous manipulation (16-DOF hands vs Digit's simpler grippers); general-purpose ambition; Helix VLA end-to-end neural control; $39B valuation / $1.9B funding advantage |
| **Tesla Optimus** | Commercial deployments with paying customers today; dedicated manufacturing (RoboFab); fleet software (Arc); first OSHA safety inspection | Tesla's manufacturing scale, automotive supply chain, Dojo training compute, and vastly larger capital base |
| **Boston Dynamics** | Public market access (SPAC); commercial RaaS revenue model; purpose-built for logistics workflows | Boston Dynamics' 30+ years locomotion R&D; Hyundai manufacturing backing; proven extreme-environment reliability; broader mobility capabilities (Atlas parkour-class) |
| **Apptronik Apollo** | Deployed across 9 customer sites vs Apollo's limited pilots; integrated fleet software (Arc); OSHA safety milestone | Apollo's NASA heritage, broader partnership network (Mercedes-Benz, GXO also), more general-purpose design |

---

## Coverage Summary

- **Strong**: Edge inference (Jetson AGX Thor onboard), Bipedal locomotion (RL-trained whole-body control), Fleet orchestration (Arc), Manufacturing (RoboFab), Commercial deployments (9 sites, 65K+ hrs)
- **Absent**: Training infrastructure, Model registry, Model pipelines, CI/CD, GitOps, Experiment tracking, Agentic framework, MaaS, KServe, llm-d, Container platform
- **Conflicts with Red Hat**: Arc fleet platform competes with FlightCtl at the fleet management / device lifecycle layer
- **Lock-in**: Vertically integrated (hardware + software + manufacturing + fleet management); NVIDIA GPU dependency at edge; proprietary Arc platform ties fleet management to Agility

---

## Strategic Implications for Red Hat

1. **Arc competes with FlightCtl at the fleet layer**: Agility Arc is a cloud SaaS platform for fleet orchestration, device monitoring, and OTA management — directly overlapping with FlightCtl's scope. Unlike Figure AI (which has no fleet software), Agility is building its own fleet management stack. This makes Agility a less natural Red Hat customer for fleet management, though the underlying OS and training infrastructure remain open.

2. **Edge OS opportunity below Arc**: Digit runs on NVIDIA Jetson AGX Thor with L4T (NVIDIA's proprietary Linux). As Agility scales from ~75 units to thousands, the need for a commercially supported, security-hardened, fleet-managed base OS increases. RHEL Device Edge could slot underneath Arc as the OS layer — Agility owns fleet orchestration, Red Hat owns the OS lifecycle. This requires positioning RHEL Device Edge as complementary to Arc, not competing with it.

3. **Training infrastructure is an unmet need**: Agility uses MuJoCo + Isaac Lab for RL training but has no disclosed training infrastructure stack (no model registry, no experiment tracking, no pipeline orchestration). As Digit v5 introduces more complex behaviors and the fleet generates more operational data for fine-tuning, the training workflow will need to scale. OpenShift AI + KubeFlow could serve this need.

4. **RaaS model amplifies fleet management importance**: At $30/hr RaaS, Agility owns the full lifecycle — hardware, software, updates, monitoring. This is structurally different from selling robots. It means Agility must solve fleet management at enterprise scale (multi-tenant, multi-site, SLA-driven). Watch whether Arc scales to this or whether Agility eventually needs to partner for fleet lifecycle tooling.

5. **SPAC creates transparency — monitor the S-1**: As a public company (ticker AGLT), Agility will disclose technology partnerships, infrastructure costs, and customer concentration. The S-1 will reveal whether they build or buy training infrastructure, what cloud provider underpins Arc, and how dependent they are on NVIDIA's Halos for safety certification. These disclosures will clarify partnership opportunities.

---

## Sources

- [TechCrunch — SPAC announcement](https://techcrunch.com/2026/06/24/agility-robotics-plans-to-go-public-via-spac-in-a-2-5b-deal/)
- [GeekWire — SPAC financials](https://www.geekwire.com/2026/digit-maker-agility-robotics-to-go-public-in-2-5b-deal-heres-what-the-filings-say-about-its-finances/)
- [The Robot Report — SPAC](https://www.therobotreport.com/humanoid-maker-agility-robotics-go-public-through-spac-merger/)
- [Agility — Arc launch](https://www.agilityrobotics.com/content/agility-robotics-brings-operational-visibility-to-deployment-of-digit-fleets-with-the-launch-of-agility-arc-tm)
- [Agility — GXO agreement](https://www.agilityrobotics.com/content/gxo-signs-industry-first-multi-year-agreement-with-agility-robotics)
- [Agility — NVIDIA expansion](https://www.agilityrobotics.com/content/agility-robotics-expands-relationship-with-nvidia)
- [NVIDIA — Halos announcement](https://nvidianews.nvidia.com/news/nvidia-announces-halos-for-robotics-the-industrys-first-full-stack-safety-system-for-physical-ai)
- [Agility — AI and simulation](https://www.agilityrobotics.com/content/agility-and-ai)
- [Contrary Research — business breakdown](https://research.contrary.com/company/agility-robotics)
- [Interesting Engineering — going public](https://interestingengineering.com/ai-robotics/us-digit-robot-maker-agility)
- [Ecosystem entry](../../../research/ecosystem.md#agility-robotics)
