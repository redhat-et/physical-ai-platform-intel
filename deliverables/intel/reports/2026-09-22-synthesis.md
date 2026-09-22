# Intelligence Synthesis — 2026-09-22

**Date**: 2026-09-22
**Classification**: Internal analysis
**Previous synthesis**: [2026-06-23](2026-06-23-synthesis.md) (9 companies)

Cross-company analysis across all 45 tracked Physical AI players. Identifies coverage patterns, partnership dynamics, ecosystem trends, and strategic implications for Red Hat.

---

## Companies Analyzed

### Silicon & Accelerators (4)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [AMD](../companies/amd.md) | Big Tech (silicon + open ecosystem) | 2026-09-22 | Strong complement — zero conflicts, joint vLLM; MI455X/Helios rack-scale shipping |
| [Intel](../companies/intel.md) | Big Tech (silicon + edge) | 2026-09-22 | Complement — 25+ year partnership; turnaround validated ($16.1B Q2, +25% YoY) |
| [NVIDIA](../companies/nvidia.md) | Big Tech (silicon + full stack) | 2026-09-22 | Mixed — complement on infra, conflict on inference/scheduling |
| [Qualcomm](../companies/qualcomm.md) | Big Tech (edge silicon) | 2026-09-22 | Complement — edge OS partner; IQ10 GA Sep 2026, Mojo/MAX (Modular $3.9B acq) |

### Foundation Models & AI Research (5)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [Archetype AI](../companies/archetype-ai.md) | Startup (sensor foundation models) | 2026-09-17 | Complement — no infra conflict |
| [Google DeepMind](../companies/google-deepmind.md) | Big Tech (research + models) | 2026-09-22 | Complement — MuJoCo/Newton strategic OSS |
| [Mistral AI](../companies/mistral-ai.md) | Startup (LLM/VLM models) | 2026-09-22 | Complement — Apache 2.0 open-weight models |
| [Physical Intelligence](../companies/physical-intelligence.md) | Startup (VLA models) | 2026-09-22 | Complement — OpenPI protocol via vLLM-Omni |
| [Skild AI](../companies/skild-ai.md) | Startup (VLA models + fleet) | 2026-09-22 | Potential customer — needs serving infra |

### Training Data & Simulation (9)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [Config](../companies/config.md) | Startup (bimanual robot data) | 2026-09-16 | Complement — no platform conflict |
| [Imagine.io](../companies/imagine-io.md) | Startup (simulation assets) | 2026-09-16 | Complement — asset layer |
| [Lightwheel](../companies/lightwheel.md) | Startup (sim assets + eval) | 2026-09-16 | Complement — asset/eval layer |
| [Mecka](../companies/mecka.md) | Startup (egocentric data) | 2026-09-16 | Complement — data collection |
| [Palatial](../companies/palatial.md) | Startup (agentic asset gen) | 2026-09-16 | Complement — automated data gen |
| [Physicl](../companies/physicl.md) | Startup (physics assets + API) | 2026-09-16 | Complement — asset/API layer |
| [Scale AI](../companies/scale-ai.md) | Startup (data annotation) | 2026-09-11 | Complement — upstream data |
| [Sunday Robotics](../companies/sunday-robotics.md) | Startup (consumer robot data) | 2026-09-16 | Complement — consumer scope |
| [XDOF](../companies/xdof.md) | Startup (physical robot data) | 2026-09-16 | Complement — physical data |

### Developer Tools & Observability (2)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [Foxglove](../companies/foxglove.md) | Startup (robot data platform) | 2026-07-02 | Complement — data/observability |
| [Rerun](../companies/rerun.md) | Startup (Physical AI data tooling) | 2026-07-02 | Complement — data tooling |

### Robotics Software Platforms (2)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [Intrinsic](../companies/intrinsic.md) | Big Tech (Google subsidiary) | 2026-09-22 | Mixed — IntrinsicOS displacement target |
| [Staer AI](../companies/staer-ai.md) | Startup (spatial intelligence) | 2026-09-21 | Complement — edge deployment consumer |

### Cloud & Infrastructure (2)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [Mistral AI](../companies/mistral-ai.md) | Startup (sovereign AI cloud) | 2026-09-22 | Complement — European compute |
| [Nebius](../companies/nebius.md) | Startup (GPU cloud) | 2026-09-01 | Mixed — managed K8s competes with OpenShift |

### Vertical Solution Providers (8)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [ABB](../companies/abb.md) | Big Tech (robotics + automation) | 2026-09-22 | Complement — Edgenius runs on OpenShift |
| [Dassault Systèmes](../companies/dassault-systemes.md) | Big Tech (PLM + simulation) | 2026-09-22 | Mixed — OUTSCALE OKS vs OpenShift |
| [PTC](../companies/ptc.md) | Big Tech (PLM + IoT) | 2026-09-22 | Complement — infrastructure consumer |
| [Rockwell Automation](../companies/rockwell-automation.md) | Big Tech (industrial automation) | 2026-09-22 | Partial conflict — FactoryTalk Edge vs MicroShift |
| [Siemens](../companies/siemens.md) | Big Tech (industrial conglomerate) | 2026-09-22 | Coopetition — Industrial Edge vs OpenShift, but also supports OpenShift |
| [SteerAI](../companies/steerai.md) | Startup (off-road autonomous) | 2026-09-21 | Complement — edge platform consumer |
| [Tesla](../companies/tesla.md) | Big Tech (vertically integrated) | 2026-09-22 | None — fully closed system |
| [Waymo](../companies/waymo.md) | Big Tech (autonomous driving) | 2026-09-22 | Minimal — Alphabet cloud-locked |

### System Integrators (7)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [Accenture](../companies/accenture.md) | SI (consulting + implementation) | 2026-09-22 | Mixed — channel partner but Physical AI Orchestrator overlaps edge AI orchestration |
| [Bastian Solutions](../companies/bastian-solutions.md) | SI (warehouse automation) | 2026-09-22 | Complement — channel partner |
| [Capgemini](../companies/capgemini.md) | SI (consulting + implementation) | 2026-09-22 | Strong complement — RH 2026 Partner of the Year |
| [Deloitte](../companies/deloitte.md) | SI (consulting + advisory) | 2026-09-22 | Complement — deploys on partner infra |
| [Dematic](../companies/dematic.md) | SI (supply chain automation) | 2026-09-22 | Complement — no platform components |
| [Toyota Automated Logistics](../companies/toyota-automated-logistics.md) | SI (warehouse automation) | 2026-09-22 | Mixed — T-Suite fleet mgmt could complement or compete |
| [Vanderlande](../companies/vanderlande.md) | SI (logistics automation) | 2026-09-22 | Partial — VISION platform overlap |

### Robotics OEMs — Humanoid (4)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [Agility Robotics](../companies/agility-robotics.md) | Startup (humanoid OEM) | 2026-09-22 | Potential customer — Arc fleet mgmt competes with FlightCtl |
| [Figure AI](../companies/figure-ai.md) | Startup (humanoid OEM) | 2026-09-22 | Potential customer — needs edge OS/fleet mgmt |
| [NEURA Robotics](../companies/neura-robotics.md) | Startup (humanoid/cobot OEM) | 2026-07-09 | Potential customer — needs edge OS |
| [Prometheus](../companies/prometheus.md) | Startup (humanoid, pre-product) | 2026-07-09 | Potential customer — expected managed service |

### Robotics OEMs — Industrial (3)

| Company | Type | Last Updated | Relationship to Red Hat |
| --- | --- | --- | --- |
| [FANUC](../companies/fanuc.md) | Big Tech (industrial robots) | 2026-07-17 | Partial conflict — FIELD system at edge |
| [KUKA](../companies/kuka.md) | Big Tech (industrial robots) | 2026-07-17 | Conflict — iiQKA.OS2 at edge |
| [Universal Robots](../companies/universal-robots.md) | Big Tech (cobots) | 2026-07-17 | Neutral — custom Linux + Docker |

---

## Coverage Heat Map

Coverage across 22 platform blocks for all 45 companies, grouped by company category. Companies that cover zero blocks (pure data/asset providers) are omitted from the table for readability but counted in the total.

### Block Coverage Summary

| Block | Companies Covering | Count |
| --- | --- | --- |
| **Train Workloads** | NVIDIA, DeepMind, AMD, Intel, PI, Skild, Figure, Tesla, Waymo, Nebius, Mistral | 11/45 |
| **Simulation Engine** | NVIDIA, DeepMind, Intrinsic, Skild, Figure, Dassault, Siemens, Rockwell, ABB, Dematic, TAL, Bastian, Accenture, Deloitte, Staer | 15/45 |
| **Eval** | NVIDIA, DeepMind, PI, Skild, Figure, Lightwheel, Scale AI | 7/45 |
| **Data** | NVIDIA, DeepMind, Skild, Figure, Config, Imagine, Lightwheel, Mecka, Palatial, Physicl, Scale AI, Sunday, XDOF, Foxglove, Rerun, Staer | 16/45 |
| **Train Infra** | NVIDIA, DeepMind, AMD, Intel, Figure, Tesla, Nebius | 7/45 |
| **Model Registry** | NVIDIA, Intrinsic, Qualcomm | 3/45 |
| **Model Pipelines** | NVIDIA, Intel, Nebius | 3/45 |
| **CI/CD & GitOps** | Nebius | 1/45 |
| **Experiment Tracking** | Intel, Nebius | 2/45 |
| **Model Monitoring** | NVIDIA, Intrinsic, Intel, Siemens, ABB, Rockwell | 6/45 |
| **Agentic Framework** | NVIDIA, Mistral, Siemens, Archetype AI, SteerAI, Bastian, Vanderlande, Dematic, TAL | 9/45 |
| **Models & Policies** | NVIDIA, DeepMind, PI, Skild, Figure, Tesla, Waymo, Mistral, Archetype AI, SteerAI, NEURA | 11/45 |
| **MaaS** | NVIDIA, Intrinsic, DeepMind, Intel, PI, Skild, Mistral, Nebius | 8/45 |
| **Inference Server** | NVIDIA, Intrinsic, DeepMind, AMD, Intel, Qualcomm, Skild, Figure, Tesla, Waymo, Mistral, Nebius, Archetype AI, SteerAI | 14/45 |
| **llm-d** | — | 0/45 ❗ |
| **KServe** | NVIDIA (competes) | 1/45 |
| **App Libs (Math/AI)** | NVIDIA, DeepMind, AMD, Intel, Qualcomm, Figure, Tesla | 7/45 |
| **App Libs (Media)** | NVIDIA, AMD, Intel, Qualcomm, Figure | 5/45 |
| **App Libs (Robotics)** | NVIDIA, Intrinsic, AMD, Intel, Qualcomm, Skild, Figure, ABB, FANUC, KUKA, UR, Rockwell, Staer, TAL, Bastian, Vanderlande, Dematic | 17/45 |
| **Application Runtime** | Intrinsic, Siemens, Rockwell | 3/45 |
| **Drivers** | NVIDIA, AMD, Intel, Qualcomm, Figure, FANUC, KUKA, ABB | 8/45 |
| **OS** | NVIDIA, Intrinsic, Qualcomm, Figure, Tesla, FANUC, KUKA, Siemens, Rockwell | 9/45 |

### Coverage Patterns

**Universal gap** (0/45):

- **llm-d** — distributed inference routing is unaddressed by any vendor. Red Hat owns this by default.

**Near-universal gaps** (1-3/45 — Red Hat leadership opportunity):

- **CI/CD & GitOps** (1/45, Nebius only) — no vendor addresses CI/CD for Physical AI workflows. Red Hat's Tekton + Argo CD + GitOps is the only enterprise answer.
- **Experiment Tracking** (2/45) — Intel Tiber and Nebius only. Everyone else uses W&B or MLflow.
- **KServe** (1/45, and NVIDIA competes with it) — model routing/autoscaling is structurally empty.
- **Model Registry** (3/45) — no enterprise-grade K8s-native registry outside Red Hat's own.
- **Model Pipelines** (3/45) — NVIDIA OSMO, Intel Tiber, Nebius. Massive gap for sim→train→eval→deploy orchestration.
- **Application Runtime** (3/45) — only Intrinsic (IntrinsicOS), Siemens (Industrial Edge), and Rockwell (FactoryTalk Edge). 42 of 45 vendors depend on platform partners.

**Crowded blocks** (10+/45):

- **App Libs (Robotics)** (17/45) — most crowded. Every industrial OEM, SI, and robotics platform has robot-level software.
- **Data** (16/45) — 9 dedicated data startups plus 7 companies with data capabilities.
- **Simulation Engine** (15/45) — simulation has gone mainstream. SIs and OEMs all have digital twin offerings.
- **Inference Server** (14/45) — inference is table stakes. Everyone has it or partners for it.
- **Models & Policies** (11/45) and **Train Workloads** (11/45) — concentrated in tech/AI companies.

**New pattern vs previous synthesis (9→45 companies)**: The "uncovered middle layer" identified at 9 companies is now confirmed at 45-company scale. The platform infrastructure layer (Application Runtime, CI/CD, Model Pipelines, OS, Fleet Management) has near-zero vendor coverage — structurally empty across the entire ecosystem.

---

## Key Developments Since Last Synthesis (2026-06-23)

### Funding & Valuation Shifts

1. **Mistral AI €3B Series D** (Sep 2026) at €21B valuation — largest European tech equity round ever. Samsung led. Positions Mistral as sovereign AI infrastructure provider (hosting third-party models, European Compute Coalition).

2. **Physical Intelligence Series C closed** at $11.2B valuation (Founders Fund lead). Total raised $2.1B. No new model released since π0.7 (April 2026) — 5-month gap raises execution questions.

3. **Skild AI $30M→$100M ARR** confirmed. 60+ paying customers. Amazon Robotics deploying 15K robots on Skild Brain — largest foundation model deployment in robotics. Revenue validation the previous synthesis flagged has materialized.

4. **Figure AI 1,000th Figure 03 produced** (Jul 2026). Pricing crystallized: $89K commercial, $3,200/mo RaaS. $3.5B Nscale compute deal (100K Vera Rubin GPUs). BMW fleet at 120 units with 73% inventory error reduction.

5. **Agility Robotics SPAC S-4 filed** (Jul 2026). Reveals $1.8M 2025 revenue vs $140M operating loss. Digit v5 unveiled (50 lb payload, 90-min runtime, swappable grippers). $300M+ orders (~1,000 units).

6. **ABB robotics divesting to SoftBank** for $5.375B — confirmed since last synthesis.

### Product & Technology Milestones

1. **NVIDIA GR00T N1.7 GA** with Cosmos-Reason2-2B backbone. GR00T N2 preview. GR00T Reference Humanoid (Unitree H2 Plus + Jetson AGX Thor T5000). Revenue $96.2B quarterly (+106% YoY).

2. **Google DeepMind Gemini Robotics 2** (Jul 2026) — whole-body humanoid control (22-DOF five-finger dexterity, multi-robot collaboration). Three models: VLA, ER 2, On-Device 2.

3. **Apptronik Robot Park** — 90K sqft humanoid data factory in Austin. Apollo 2 as primary Gemini Robotics 2 platform. "Android for robotics" explicitly acknowledged.

4. **Intrinsic open-sources Intrinsic Core** (ROSCon Sep 2026) — Apache 2.0 release of control, motion planning, grasp planning, pose estimation (FoundationPose), and camera calibration. Explicit "Android playbook": commoditize robotics infrastructure, monetize Gemini models and Flowstate SaaS. Open Machine Tending reference solution released simultaneously (supports FANUC + UR out of box). Intelligence Cell modular AI workcell also unveiled; Foxconn piloting for electronics assembly.

5. **NVIDIA Isaac ROS 5.0** (Sep 2026) — agentic "Isaac skills" (perception/manipulation primitives callable by VLMs), FoundationPose 5.5x faster, ROS Lyrical + Ubuntu 24.04, vendor-neutral GPU memory transport contributed upstream to OSRA. 7 new production partners. Positions Isaac ROS as the bridge between NVIDIA's proprietary AI stack and the ROS 2 ecosystem.

6. **Skild S1 model** (Aug 2026) — one-shot video learning. Skild Brain 1.0 (500B params, May 2026).

7. **Figure AI Helix 2.5** — zero-shot generalization across 30 unseen homes. Index data engine generating ~35 min/sec of human-experience data.

### Silicon & Accelerator Developments (refreshed Sep 22)

1. **AMD MI455X in production** (Aug 2026) — CDNA 5, 12 chiplets on 2nm/3nm, 320B transistors, 432GB HBM4, 40 PFLOPS FP4. Helios rack-scale system ($5–5.5M, 72× MI455X, 31TB HBM4, 2.9 EFLOPS FP4) shipping late Q3 2026. First credible NVIDIA B200/GB200 competitor at rack scale. AMD datacenter revenue $6.7B/quarter (+107% YoY).

2. **Intel financial turnaround validated** — Q2 2026 $16.1B revenue (+25.4% YoY), 7th consecutive beat. AI businesses now ~70% of total revenue and growing >70% YoY. Stock up 170%+ in 2026. Capex raised to >$20B. Intel is a dramatically stronger partner than 12 months ago.

3. **Intel Crescent Island specs revealed** (Hot Chips 2026) — 32 Xe3P cores, 256 XMX engines, up to 480GB LPDDR5X, 350W TDP, air-cooled. Commercial launch likely 2027. Jaguar Shores (HBM4, rack-scale training) design closure H1 2026, launch potentially H2 2027.

4. **Mobileye robotaxi pivot** — vertically integrated robotaxi business (not just supplying technology). U.S. launch 2027, 100→17K vehicles over 5 years. Combines Mobileye Drive + Moovit fleet platform. $24.5B revenue pipeline over 8 years.

5. **Qualcomm IQ10 GA Sep 2026** — 700 TOPS, 18 Oryon cores, ROS 2 native, 10 OEM partners (NEURA, Advantech, VinMotion, etc.). Modular acquisition ($3.9B) adds Mojo/MAX silicon-agnostic AI compiler (Apache 2.0, Chris Lattner) targeting all accelerators. Automotive $1.6B/quarter (+61% YoY), $45B pipeline.

### Organizational & Partnership Changes

 1. **Toyota Automated Logistics (TAL) launched** (Apr 2026) — merges Bastian Solutions, Vanderlande warehousing, and viastore under unified brand. Largest warehouse automation consolidation in years.

 2. **PTC divested ThingWorx IoT to TPG** (Mar 2026) — retreating from IoT platform to focus on PLM/CAD core. Reduces PTC's Physical AI surface area.

 3. **Capgemini named Red Hat's 2026 Hybrid Cloud Everywhere Partner of the Year** — strongest SI alignment signal. Hoxo humanoid robot at Orano nuclear via NVIDIA sim-to-real pipeline.

---

## Partnership Network

### NVIDIA Partnership Map (expanded from 9→45 companies)

NVIDIA is the most connected node in the Physical AI ecosystem. 30+ of 45 tracked companies have direct NVIDIA partnerships or dependencies.

| Category | NVIDIA Partners | Non-NVIDIA |
| --- | --- | --- |
| **Industrial OEMs** | FANUC, KUKA, ABB, UR | — |
| **Humanoid OEMs** | Figure AI, Agility, NEURA, Boston Dynamics | Apptronik (DeepMind exclusive) |
| **SIs** | Accenture, Capgemini, Deloitte | Bastian, Dematic, Vanderlande, TAL (no direct NVIDIA) |
| **Vertical Providers** | Siemens, Dassault, PTC, Rockwell, ABB | Tesla (fully proprietary), Waymo (Alphabet) |
| **VLA Models** | PI (NVentures investor), Skild (NVentures investor) | Archetype AI |
| **Silicon** | — (is NVIDIA) | AMD (clean competitor), Intel, Qualcomm |

### SI Partnership Landscape (new)

| SI | NVIDIA | Red Hat | AWS | Siemens | Other Key |
| --- | --- | --- | --- | --- | --- |
| **Accenture** | Deep (Omniverse) | — | ✅ | 7K-person BG | Siemens, KION, General Robotics |
| **Capgemini** | Deep (Hoxo) | 2026 Partner of Year | — | — | Intel (Ensconce) |
| **Deloitte** | Deep (Omniverse) | — | Smart Factory Fabric | — | — |
| **Bastian** | — | — | — | — | Rockwell (Emulate3D), AutoStore, OTTO |
| **Dematic** | — | — | — | — | KION Group parent |
| **Vanderlande** | — | — | — | — | Toyota Industries parent, Kollmorgen |
| **TAL** | — | — | — | — | Toyota Industries parent, T-Hive |

Pattern: The Big 3 SIs (Accenture, Capgemini, Deloitte) are NVIDIA-aligned. The logistics SIs (Bastian, Dematic, Vanderlande, TAL) are NVIDIA-independent, operating with proprietary or Rockwell stacks.

### Humanoid Robot Partnerships (updated)

| Company | NVIDIA | DeepMind | Silicon | Status |
| --- | --- | --- | --- | --- |
| **Figure AI** | ✅ Cosmos, investor | — | NVIDIA Jetson Thor | 1,000 produced, 120 at BMW |
| **Agility Robotics** | ✅ Cosmos + Isaac | — | NVIDIA Jetson Thor | Digit v5, SPAC in progress |
| **NEURA Robotics** | ✅ GR00T | — | NVIDIA Jetson Thor | Kawasaki OEM, NEURA Gym |
| **Boston Dynamics** | ✅ Cosmos + Isaac | ✅ Gemini for Atlas | NVIDIA Jetson Thor | Hyundai 30K/yr target by 2028 |
| **Apptronik** | — | ✅ Gemini Robotics 2 (exclusive) | — | Robot Park data factory, Apollo 2 |
| **Prometheus** | — | — | — | Pre-product, $18B+ funded |

### SoftBank Triangle (updated)

SoftBank's position has strengthened since last synthesis:

- **Skild AI**: $1.4B Series C lead. Skild Brain now at $100M ARR, 15K robots at Amazon
- **ABB Robotics**: $5.375B acquisition. 500K+ robot installed base
- **If completed**: SoftBank controls both the "brain" (Skild, $100M ARR) and the "body" (ABB, 500K+ robots). First vertically integrated brain+body at industrial scale. Displaces NVIDIA's current ABB partnership.

---

## Ecosystem Dynamics

### Complementary vs Competitive

**45-company relationship breakdown**:

| Relationship | Count | Companies |
| --- | --- | --- |
| **Complement** | 27 | AMD, Intel, Qualcomm, Archetype AI, Mistral, PI, Config, Imagine, Lightwheel, Mecka, Palatial, Physicl, Scale AI, Sunday, XDOF, Foxglove, Rerun, Staer, SteerAI, PTC, Capgemini, Deloitte, Bastian, Dematic |
| **Potential customer** | 5 | Skild, Figure, Agility, NEURA, Prometheus |
| **Mixed/Coopetition** | 9 | NVIDIA, Intrinsic, Siemens, Rockwell, Dassault, Nebius, TAL, Vanderlande, Accenture |
| **Conflict** | 2 | KUKA (iiQKA.OS2), FANUC (FIELD system) |
| **None/Irrelevant** | 2 | Tesla (closed), Waymo (Alphabet-locked) |

Key insight: 27 of 45 companies are pure complements. Only 2 have direct platform conflicts (KUKA, FANUC). Red Hat's platform sits in a structural gap that the ecosystem needs filled.

### Alliance Blocs Forming

**NVIDIA Ecosystem Bloc**: NVIDIA + Accenture + Capgemini + Deloitte + Siemens + Dassault + Rockwell form a tightly coupled industrial AI stack. Omniverse is the connective tissue. This bloc covers simulation, digital twins, consulting, and deployment — but lacks container platform, OS, and fleet management.

**Google/Alphabet Bloc**: DeepMind + Intrinsic + Apptronik + Boston Dynamics + Waymo. Gemini Robotics is the connective tissue. Intrinsic's Intelligence Cell + Foxconn pilot is the industrial beachhead. MuJoCo/Newton/Gazebo provide the simulation layer.

**Toyota/KION Industrial Automation Bloc**: TAL + Bastian + Vanderlande + Dematic. Two parent companies (Toyota Industries, KION Group) control most of the warehouse automation SI market. NVIDIA-independent — proprietary software stacks.

**Sovereign AI Bloc**: Mistral AI + Dassault (OUTSCALE) + European Compute Coalition (ASML, Amadeus, Capgemini). Targeting 1 GW European compute. Separate from US hyperscaler dependency.

---

## Trend Signals

### 1. Humanoid Economics Are Crystallizing

Three humanoid OEMs now have published pricing or financial data:

| Company | Unit Price | RaaS | Revenue | Units |
| --- | --- | --- | --- | --- |
| **Figure AI** | $89K | $3,200/mo | Negligible | 1,000 produced |
| **Agility Robotics** | ~$300K (implied) | — | $1.8M (2025) | ~1,000 ordered |
| **NEURA Robotics** | — | — | — | Pre-production |

The $89K Figure 03 price point is 70% below Agility's implied Digit pricing. If validated at scale, this changes the ROI equation for warehouse automation — direct competition with AMR-based solutions from TAL, Bastian, Vanderlande, and Dematic.

### 2. VLA Model Layer Is Bifurcating: Open vs Proprietary Revenue

| Company | Revenue | Model Strategy | Customers |
| --- | --- | --- | --- |
| **Skild AI** | $100M ARR | Fully proprietary | 60+ (Amazon 15K robots) |
| **Physical Intelligence** | $0 | Open-weight (Gemma ToU) | 0 paying |
| **NVIDIA GR00T** | Bundled | Open-weight + NIM serving | OEM partners |

Skild's $100M ARR validates proprietary VLA as a business. PI's open-weight approach builds ecosystem but produces zero revenue after $2.1B raised. The gap has widened since the last synthesis ($30M vs $0 → $100M vs $0).

### 3. Robot Middleware Is Splitting Into Two Open-Source Stacks

September 2026 saw two major robot middleware releases in the same month:

- **Intrinsic Core** (Apache 2.0) — Google open-sources control, motion planning, grasp planning, pose estimation. Explicit "Android playbook": commoditize infrastructure, monetize Gemini models + Flowstate SaaS above. Open Machine Tending reference solution ships with FANUC + UR support out of box.
- **Isaac ROS 5.0** — NVIDIA ships agentic "Isaac skills" (perception/manipulation primitives callable by VLMs), FoundationPose 5.5x faster, vendor-neutral GPU memory transport contributed upstream to OSRA. 7 new production partners.

Both build on ROS 2 but pull in different directions: Intrinsic Core commoditizes the runtime to lock in Google Cloud + Gemini; Isaac ROS wraps NVIDIA-proprietary GPU acceleration (NITROS, cuVSLAM, nvblox) in ROS 2 interfaces to lock in NVIDIA silicon. Red Hat's platform sits underneath both — neither provides OS, container runtime, or fleet management. The risk is that one stack becomes dominant and defines the edge runtime assumptions (IntrinsicOS vs L4T) before Red Hat establishes RHEL Device Edge as the neutral base.

### 4. Industrial SIs Are NVIDIA-Aligned; Logistics SIs Are Independent

The Big 3 consulting SIs (Accenture, Capgemini, Deloitte) all have deep NVIDIA Omniverse practices. The logistics SIs (Bastian, Dematic, Vanderlande, TAL) operate on proprietary or Rockwell stacks without NVIDIA dependency. This creates two different platform integration paths for Red Hat:

- **For NVIDIA-aligned SIs**: Red Hat platform complements the NVIDIA simulation/AI layer — OpenShift underneath, vLLM-Omni for inference
- **For logistics SIs**: Red Hat platform fills the infrastructure gap directly — edge OS for AGV/AMR fleets, container runtime for warehouse software

### 5. Simulation Deployment Has Broadened — But Capability Remains Concentrated

15 of 45 companies appear in the Simulation Engine coverage row, but this headline number conflates four distinct categories:

| Category | Companies | Count |
| --- | --- | --- |
| **Build simulation engines** | NVIDIA (Isaac Sim/Omniverse), DeepMind (MuJoCo), Intrinsic (Gazebo digital twin), Dassault (3DEXPERIENCE) | 4 |
| **Build proprietary digital twin products** | Siemens (Digital Twin Composer), Rockwell (Emulate3D), ABB (RobotStudio), Dematic (iQ Digital Twin), Staer (live 3D warehouse map) | 5 |
| **Deploy others' simulation tools** | Accenture (deploys Omniverse), Deloitte (deploys Omniverse), Bastian (uses Rockwell Emulate3D), TAL (inherits subsidiary tools) | 4 |
| **Use simulation for internal R&D only** | Skild (training environments), Figure (synthetic data) | 2 |

Simulation *deployment* has gone mainstream — even SIs now routinely deploy digital twin tooling. But simulation *capability* (building engines or products) remains concentrated in ~9 players. The competitive frontier has moved from "having a digital twin" to:

- Sim-to-real transfer quality (NVIDIA Isaac, DeepMind MuJoCo, ABB RobotStudio 99% accuracy)
- Synthetic data generation at scale (Cosmos, Skild, Figure Index)
- Real-time operational twins (Siemens, Dassault, Vanderlande predictive maintenance)

### 6. Edge OS Displacement Window Is Expanding

The 9-company synthesis identified 6 edge OS targets. At 45 companies, the pattern is stronger:

| Current Edge OS | Companies Using It | RHEL Device Edge Fit |
| --- | --- | --- |
| **Ubuntu / L4T** | NVIDIA, Figure, Qualcomm, NEURA, Agility | High — 5 targets |
| **Proprietary Linux** | FANUC, KUKA, UR, Intrinsic, Tesla, Waymo | Low — deeply proprietary |
| **No own OS** | AMD, Intel, ABB, all SIs, all startups | High — partner opportunity |
| **Industrial edge** | Siemens, Rockwell | Medium — coopetition |

### 7. Warehouse Automation Consolidation Creates Platform Opportunity

Toyota Industries merged three subsidiaries into TAL (Apr 2026). KION Group (Dematic parent) is the other major player. Combined, these two groups cover most warehouse automation globally. Both need:

- Edge OS for AGV/AMR fleets (thousands of vehicles per facility)
- Container runtime for warehouse software
- Fleet management at scale
- OTA updates and device lifecycle management

Neither has a platform layer — both run proprietary software on bare Linux. This is a greenfield platform opportunity.

### 8. Red Hat Has Active Relationships in Three Categories

| Relationship | Companies | Engagement |
| --- | --- | --- |
| **Running on OpenShift** | ABB (Edgenius), Siemens (Amberg factory), Dassault (OUTSCALE) | Production deployments |
| **Partner of the Year** | Capgemini (2026 Hybrid Cloud Partner) | Strategic partnership |
| **Certified/Supported** | AMD (Red Hat AI 3 on Instinct), Intel (Gaudi on OpenShift AI), NVIDIA (GPU Operator) | Hardware ecosystem |

---

## Strategic Implications for Red Hat

### 1. The Structural Middle Layer Is Confirmed at 45-Company Scale

The platform infrastructure gap identified in the 9-company synthesis is now validated across the entire tracked ecosystem:

| Block | Vendor Coverage | Red Hat Product |
| --- | --- | --- |
| Application Runtime | 3/45 | OpenShift, MicroShift |
| CI/CD & GitOps | 1/45 | Tekton, Argo CD |
| llm-d | 0/45 | llm-d |
| KServe | 1/45 (NVIDIA, competes) | KServe |
| Model Pipelines | 3/45 | KubeFlow Pipelines |
| Model Registry | 3/45 | Model Registry |
| OS (server) | 0/45 (for datacenter) | RHEL |
| Fleet Management | 0/45 | FlightCtl |

42 of 45 vendors have no application runtime. Zero vendors provide a server OS or fleet management for Physical AI. The platform layer is structurally empty.

### 2. Three SI Channels — Prioritize Capgemini, Open Logistics SIs

| Channel | SI | Red Hat Status | Action |
| --- | --- | --- | --- |
| **Active** | Capgemini | 2026 Partner of Year | Deepen — Physical AI reference architectures on OpenShift |
| **Warm** | Accenture, Deloitte | No disclosed relationship | Engage — they deploy NVIDIA stacks that need platform infrastructure |
| **Greenfield** | Bastian, Dematic, Vanderlande, TAL | No relationship | Highest opportunity — no NVIDIA dependency, need edge platform |

### 3. ABB and Siemens Are Active OpenShift Users — Expand

Both ABB (Edgenius on OpenShift/Device Edge) and Siemens (Amberg factory on OpenShift, Industrial Edge supports OpenShift) are already running Red Hat infrastructure. These are not prospects — they're existing customers. Expand the footprint:

- ABB: Position RHEL Device Edge as the OS under OmniCore's next generation (especially post-SoftBank transition)
- Siemens: Expand from Amberg to broader Industrial Edge deployment; co-develop Xcelerator marketplace OpenShift integration

### 4. Warehouse Automation Is the Near-Term Physical AI Beachhead

TAL, Bastian, Vanderlande, and Dematic collectively operate 5,000+ warehouse automation installations globally. All need:

- Edge OS for AGV/AMR fleets → RHEL Device Edge
- Container runtime for warehouse software → MicroShift
- Fleet management → FlightCtl
- OTA updates across thousands of vehicles → Image Builder + FlightCtl

None has a platform layer. None has an NVIDIA dependency. This is Red Hat's cleanest Physical AI go-to-market path.

### 5. The SoftBank-ABB-Skild Triangle Needs Monitoring (updated)

Since last synthesis: Skild has grown to $100M ARR with Amazon Robotics deploying 15K robots. ABB divestiture to SoftBank proceeding. If SoftBank unifies Skild Brain + ABB installed base:

- Combined entity needs platform infrastructure (serving, fleet management, edge runtime)
- Red Hat could be the neutral platform partner — ABB already runs Edgenius on OpenShift
- Time-sensitive: position before the consolidation closes and platform choices lock in

### 6. AMD Remains the Cleanest Hardware Partner

Zero product conflicts confirmed across 45-company analysis. Joint vLLM investment validated by both NVIDIA (NIM backend) and AMD (top-3 contributor). No competing edge OS, no competing inference server, no competing scheduler. Deepen: ROCm certification for Physical AI workloads, RHEL Device Edge on Ryzen AI Embedded.

### 7. Humanoid OEMs Are Future Fleet Management Customers

Four humanoid OEMs (Figure, Agility, NEURA, Prometheus) are all potential Red Hat customers. Figure's 1,000 robots and Agility's ~1,000 orders create the first wave of humanoid fleet management demand. Both run Ubuntu today. Both will need commercially supported, security-hardened, fleet-managed OS as they scale to 10K+ units. FlightCtl + RHEL Device Edge is the value proposition.

### 8. Sovereign AI Infrastructure Creates European Opportunity

Mistral's €3B round (Samsung led), Dassault's OUTSCALE (already running OpenShift), and the European Compute Coalition (1 GW target) signal a European sovereign AI infrastructure buildout. Red Hat's presence on OUTSCALE and relationship with Capgemini positions it to be the platform layer for European Physical AI deployments.

---

## Stale Reports

All 45 profiles updated within the last 90 days. AMD, Intel, and Qualcomm refreshed on 2026-09-22 (were 91 days stale).

Key refresh findings:

- **AMD**: MI455X (CDNA 5, 432GB HBM4, 40 PFLOPS FP4) in production Aug 2026. Helios rack-scale system ($5–5.5M, 72× MI455X) first shipments late Q3 2026. ROCm 7.14 with SGLang on Radeon. $11.5B Q2 revenue (+107% YoY datacenter). Silo AI robotics simulation partnerships.
- **Intel**: Q2 2026 $16.1B revenue (+25.4% YoY), 7th consecutive beat. AI businesses ~70% of revenue. Crescent Island specs at Hot Chips (32 Xe3P cores, 480GB LPDDR5X, 350W). Jaguar Shores (HBM4, rack-scale) design closure H1 2026. Mobileye pivoting to own robotaxi fleet (U.S. 2027, 17K vehicles). Capgemini "Dexterity" Physical AI edge partnership.
- **Qualcomm**: IQ10 GA Sep 2026 (10 OEM partners). Modular acquisition ($3.9B) adds Mojo/MAX silicon-agnostic AI software (Apache 2.0). AI200 datacenter inference chip H2 2026. Automotive $1.6B/quarter (+61% YoY). Non-handset revenue target $40B by FY2029.

---

## Open Questions (updated)

1. **Will the SoftBank-ABB acquisition close, and does Skild Brain become ABB's default?** Now more urgent — Skild at $100M ARR makes the integration commercially viable.

2. **Can RHEL run on Jetson Thor T5000 with full accelerator support?** GR00T Reference Humanoid ships on Thor T5000. Figure and Agility both use Jetson Thor. This is the highest-volume edge target.

3. **Does PI ever generate revenue?** $2.1B raised, $0 revenue, 5-month model gap. Skild's $100M ARR is making the open-weight VLA strategy look commercially unviable.

4. **Will TAL standardize on a single software platform?** Three acquired companies (Bastian/Exacta, Vanderlande/VISION, viastore) each have proprietary software. T-Suite (T-Hive) is the unification attempt. Platform consolidation creates a one-time infrastructure decision point.

5. **Does Figure's $89K price point disrupt AMR-based warehouse automation?** If humanoids at $89K can do what $200K+ AMR systems do, TAL/Bastian/Dematic face a disruptive shift. Monitor BMW deployment economics.

6. **How will the KAI Scheduler vs Kueue contest resolve?** Still open from last synthesis. NVIDIA-backed KAI has CNCF Sandbox status.

7. **Does Intrinsic's Intelligence Cell gain traction beyond Foxconn?** IntrinsicOS + Flowstate as the "Android for robotics" depends on multi-OEM adoption. Foxconn is one pilot — watch for OEM announcements.

8. **Will the European Compute Coalition materialize at scale?** 1 GW is ambitious. Mistral + Dassault + Capgemini alignment creates a Red Hat platform opportunity, but only if the infrastructure actually gets built.
