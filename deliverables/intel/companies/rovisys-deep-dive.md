# RoviSys — Deep Dive Research

**Date**: 2026-09-25
**Last updated**: 2026-09-25
**Classification**: Internal analysis — not for public repo

Supporting research for the [RoviSys competitive profile](rovisys.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: corporate timeline, service architecture, partnership details, and competitive analysis.

---

## 1. Corporate Timeline

### Timeline

| Date | Event |
| --- | --- |
| 1989-04 | John Robertson founds RoviSys in Cleveland, Ohio after a career at Bailey Controls. Thesis: control systems are moving from proprietary to open — an independent integrator can select best-fit platforms for each customer. |
| 1990 | Staff reaches 12 employees; several large projects underway. |
| ~1993 | College recruiting and co-op programs launch. Headcount grows to 25 engineers. |
| 2000 | GrandView — internal project-management and client-collaboration web app — spun into a product (GrandView Business Systems). Sold to ~10 companies in first year. |
| 2002 | Vertical market strategy introduced, starting with Life Sciences. Directors assume P&L responsibility per vertical. |
| ~2004 | Headcount reaches 150. First satellite office opens near Raleigh, NC; second in Singapore — company transitions from regional to global. |
| 2009 | Singapore office begins supporting clients in Malaysia and Thailand. |
| 2012 | RoviSys Building Technologies (RBT) established by co-presidents Derek Drayer and Craig Lechene. Lands first hyperscale data center account (California-based owner/operator); growth runs 5x ahead of plan. |
| 2015 | RBT diversifies beyond initial hyperscale account. RoviSys opens Netherlands office — first European presence. RBT engineering teams operating on four continents. |
| 2017 | RoviSys begins using Ignition (Inductive Automation) for MES/SCADA projects. |
| 2018 | First year in top-five on CFE Media SI Giants list — a position maintained through 2026. |
| 2022-01 | RBT celebrates 10-year anniversary. RoviSys ranks #1 on SI Giants list. |
| 2022-11 | Rockwell Automation designates RoviSys as Platinum System Integrator Partner — highest tier, reserved for <1% of partners. |
| 2022 | Inductive Automation designates RoviSys as Premier Integrator (highest certification tier). |
| 2023-03 | New offices in Kuala Lumpur (Malaysia) and Bangkok (Thailand). Bill Hurder promoted to President, Asia-Pacific. |
| 2023 | Jakarta (Indonesia) office opens. |
| 2024 | Ranked #2 SI Giant. SI revenue: $264M; total gross revenue: $365M. RoviSys Federal Solutions (RFS) launched — dedicated automation for federal government, led by Managing Partner Graham Staples. Headquartered in Holly Springs, NC. |
| 2025-01 | Ranked #1 SI Giant for 2025. SI revenue: $325.7M; total gross revenue: $453.7M. |
| 2025-04 | RoviSys Europe celebrates 10-year anniversary. 100+ employees across Netherlands and Ireland offices. Matthew Wise promoted to President, Europe. Projects 10–20% growth for 2025–2026. |
| 2025 | Industrial AI practice gains traction — manufacturers move "from curiosity to practical application." Bryan DeBois leads as Director of Industrial AI (North America); Chao Yian Soon leads APAC. |
| 2025 | Ireland office established. Liam Jones appointed Country Manager for Ireland. |
| 2025 | Matt Knott and Matt Cingcade named co-presidents. John Robertson becomes Chairman. |
| 2026-05 | New Northern Virginia (Manassas) office — supports Data Center Alley (Ashburn corridor) and Mid-Atlantic critical environments market. |
| 2026 | Ranked #2 SI Giant for 2026. Diverse market base, robust project pipeline. RBT expanding in data center, power utilities, and construction. RFS continuing federal automation and security work. |

### Acquisitions

No acquisitions identified. RoviSys has grown entirely through organic expansion — new offices, new verticals, and internal practice launches (RBT in 2012, RFS in 2024). This is notable for a firm of its scale and contrasts sharply with acquisition-driven competitors like Barry-Wehmiller Design Group and Rockwell/MAVERICK.

---

## 2. Service Architecture Details

RoviSys is a services company, not a product company. It delivers no proprietary automation platform — instead it configures, programs, and integrates vendor platforms selected on a per-engagement basis. The sections below describe the architecture of its major service lines.

### Process Automation (Control Systems Integration)

| Aspect | Details |
| --- | --- |
| **Architecture** | DCS/PLC programming, HMI/SCADA configuration, loop tuning, alarm management, safety instrumented systems. Builds on vendor platforms — not a proprietary control layer. Typical stack: PLC/DCS (Rockwell, Siemens, Emerson, ABB, Honeywell) → HMI/SCADA (FTView, WinCC, DeltaV Operate, Ignition) → historian (OSIsoft PI, AVEVA Historian, Ignition Tag Historian). |
| **Runtime dependencies** | Customer-selected vendor platforms. No proprietary runtime. |
| **Extension model** | Custom application code (structured text, ladder logic, function blocks) on vendor PLCs/DCS. Custom HMI screens. Custom historian reports. |
| **Key limitations** | Outcome quality depends on vendor platform selection and RoviSys engineer expertise — no proprietary IP to differentiate technically. |

### MES/SCADA Solutions

| Aspect | Details |
| --- | --- |
| **Architecture** | Three strategic MES platforms: (1) Ignition (Inductive Automation) — Java-based, source-available SCADA/MES with Sepasoft MES modules and Cirrus Link MQTT for IIoT; (2) Critical Manufacturing MES — cloud-native, semiconductor-focused; (3) Velotic (GE Vernova) Plant Applications — batch/continuous MES with historian integration. Also deploys Parsec TrakSYS and Rockwell Plex MES. |
| **Runtime dependencies** | Ignition runs on Java (cross-platform). Critical Manufacturing runs on .NET/Azure. Velotic runs on Windows/.NET. All require OPC UA or proprietary drivers to connect to control layer. |
| **Extension model** | Ignition: Python scripting, module SDK, MQTT Sparkplug B for edge. Critical Manufacturing: REST API, .NET SDK. Velotic: proprietary configuration. |
| **Key limitations** | No proprietary MES — RoviSys is a deployment partner, not a platform vendor. Customer owns licenses directly from vendor. |

### Building Management Systems (RoviSys Building Technologies)

| Aspect | Details |
| --- | --- |
| **Architecture** | Master Systems Integrator (MSI) model — unifies HVAC, electrical switchgear (EPMS), lighting, fire alarm, and access control into a single control platform. Deploys Tridium Niagara Framework, Distech Eclypse controllers, Schneider EcoStruxure, Johnson Controls Facility Explorer, Siemens Desigo CC, and Honeywell TREND. Uses BACnet IP/MS-TP/SC as the unifying protocol. |
| **Runtime dependencies** | Tridium Niagara is the dominant supervisory platform — Java-based, runs on-premise. BACnet is the interoperability standard. |
| **Extension model** | Niagara module development (Java). Custom BACnet integrations. Proprietary vendor tools for each subsystem. |
| **Key limitations** | Data center BMS is mission-critical — zero-downtime migration capability is a key differentiator but demands deep domain expertise per facility type. |

### Industrial AI

| Aspect | Details |
| --- | --- |
| **Architecture** | Consulting-led practice — no proprietary AI product. Starts with data readiness assessment, then deploys AI solutions using partner platforms. Technology partners: Rockwell Automation (FactoryTalk Analytics), AVEVA (predictive analytics), Databricks (data lakehouse for industrial data), Cognite (industrial knowledge graph / CDF). |
| **Runtime dependencies** | Varies by engagement — typically customer's existing historian/SCADA data + cloud analytics platform (Databricks, AWS). |
| **Extension model** | Custom model development per engagement. No reusable AI product or framework disclosed. |
| **Key limitations** | No proprietary AI IP. Dependent on partner platforms for analytics infrastructure. "Inside Industrial AI" podcast/content series suggests thought leadership investment but no product roadmap. |

### GrandView (Internal Tool)

| Aspect | Details |
| --- | --- |
| **Architecture** | Web-based project management and client collaboration tool, developed internally circa 2000. Dashboard-driven — tracks alarms, tasks, status logs, file sharing. Spun into GrandView Business Systems for external sales. |
| **Runtime dependencies** | Web application hosted at grandview.rovisys.com. |
| **Extension model** | Internal — no public API or SDK documented. |
| **Key limitations** | Appears to be a legacy internal tool, not a market-facing product. No recent investment or updates visible. |

---

## 3. OSS Foundations Analysis

### Summary Table

| Service Line | Primary OSS/Open Foundation | License | RoviSys Value-Add |
| --- | --- | --- | --- |
| **MES/SCADA (Ignition)** | Ignition (Inductive Automation) | Source-available (custom license) | Configuration, Sepasoft MES module deployment, MQTT/Sparkplug B integration, custom Python scripting |
| **BMS** | Tridium Niagara Framework | Proprietary (Honeywell) | MSI design, BACnet integration, zero-downtime migration, OT cybersecurity |
| **BMS protocols** | BACnet (ASHRAE 135) | Open standard (ANSI/ASHRAE) | Implementation, commissioning, protocol bridging |
| **Industrial networks** | OPC UA (OPC Foundation) | Open standard (foundation-governed) | OPC UA server/client configuration, protocol bridging |
| **Industrial networks** | MQTT / Sparkplug B (Eclipse Foundation) | EPL 2.0 | Cirrus Link MQTT module deployment on Ignition |
| **Process automation** | None — all vendor-proprietary platforms | N/A | Programming, configuration, commissioning |
| **Industrial AI** | None — partner platforms (Databricks uses Apache Spark) | N/A | Data readiness, solution design, deployment |

### Pattern Analysis

RoviSys is an integrator of proprietary vendor platforms, not an OSS steward or contributor. Its engagement with open technology manifests in two ways: (1) expertise in open industrial protocols (BACnet, OPC UA, MQTT, EtherCAT, Modbus) that enable vendor-independent integration; and (2) deployment of platforms with open foundations, most notably Ignition (source-available Java) and Databricks (Apache Spark-based). RoviSys does not maintain, fork, or contribute to any OSS projects.

The company's founding thesis — open systems over proprietary lock-in — aligns with OSS principles at the protocol and interoperability layer but does not extend to software development or community participation. RoviSys selects open-protocol-capable platforms from proprietary vendors and integrates them.

### Notable Dependencies

- **Ignition (Inductive Automation)**: Fastest-growing MES/SCADA platform in RoviSys's portfolio (5x business growth since 2017 adoption). Source-available but governed by a single vendor. If Inductive Automation changes licensing terms, RoviSys's MES practice is directly affected.
- **Tridium Niagara**: Foundation of RBT's supervisory BMS layer. Owned by Honeywell since 2005. Dominates the BMS integration market but creates Honeywell dependency at the supervisory tier.
- **Databricks**: Industrial AI data infrastructure partner. Built on Apache Spark (open-source) but enterprise platform is proprietary.

---

## 4. Partnership & Ecosystem Details

### Technology Partners — Detailed

| Partner | Tier / Status | Relationship Depth | Revenue Significance |
| --- | --- | --- | --- |
| **Rockwell Automation** | Platinum SI (highest, <1% of partners) | 30+ year relationship. 500K+ hours annually. Full platform coverage: PlantPAx, ControlLogix, CompactLogix, FTView, FTOptix, FTBatch, FTHistorian, Plex MES, Stratix networking, Kinetix motion, PowerFlex drives. Strategic Industrial AI partner. | Primary revenue driver — Rockwell platform projects likely represent the largest share of SI revenue. |
| **Siemens** | Certified Solution Partner | Since mid-1990s. SIMATIC PCS 7/PCS neo, TIA Portal, WinCC, SIMIT simulation, Opcenter MES. Also legacy Moore Products APACS migration. Desigo CC and Talon for BMS. | Significant — Siemens is dominant in European process industries where RoviSys Europe operates. |
| **Emerson** | Integration partner | DeltaV DCS, Ovation (power), Rosemount System 3, Fisher PROVOX (legacy), Westinghouse WDPF (legacy). Deep migration expertise. | Significant in process industries (chemical, oil & gas, power). |
| **ABB** | Integration partner | 800xA, Bailey Symphony (legacy), Bailey Network90/Infi 90 (legacy), Fischer & Porter Series 6 (legacy). Migration specialist. | Moderate — largely legacy migration work. |
| **Honeywell** | Integration partner | Experion DCS, TDC2000/3000 (legacy), TREND BMS, CIPer, Spyder, HC 900. | Moderate in process; TREND significant for BMS. |
| **Inductive Automation** | Premier Integrator (highest tier) | Since 2017. Ignition SCADA, Sepasoft MES modules, Cirrus Link MQTT. 5x business growth. 2023 Discovery Gallery finalist. | Fast-growing — Ignition displacing legacy SCADA/HMI in new deployments. |
| **AVEVA (Schneider)** | Strategic Industrial AI partner | InTouch, System Platform, Historian, Batch, APM, MES/MOM. Named as strategic AI platform partner alongside Rockwell. | Significant — AVEVA Historian and System Platform in large process installations. |
| **Critical Manufacturing** | MES partner | Cloud-native MES platform. Strong in semiconductor and advanced manufacturing. | Growing — semiconductor MES is a strategic vertical. |
| **Databricks** | Data infrastructure partner | Industrial data lakehouse for AI/analytics workloads. Listed on platforms page. | Emerging — tied to Industrial AI practice growth. |
| **Cognite** | Data infrastructure partner | Cognite Data Fusion (CDF) — industrial knowledge graph. Listed on platforms page. | Emerging — industrial data contextualization for AI. |
| **AWS** | Select Consulting Partner | Industrial IoT and data analytics. Cloud infrastructure for AI workloads. | Moderate — cloud tier for industrial analytics. |
| **Tridium (Honeywell)** | BMS platform partner | Niagara Framework, Niagara Analytics, Niagara Drivers. Foundation of RBT's supervisory BMS layer. | Significant for RBT division — dominant BMS supervisory platform. |
| **Distech Controls** | BMS platform partner | Eclypse controllers, BACnet, EC BAS. Used in RBT and RFS (federal) projects. | Moderate — controller-level BMS deployments. |
| **Cisco** | Networking partner | Industrial network infrastructure — switches, security appliances. | Moderate — IT/OT convergence projects. |
| **Fortinet / Claroty** | OT cybersecurity partners | Industrial cybersecurity — firewalls, network monitoring, vulnerability assessment. | Growing — OT cybersecurity is a cross-cutting concern for all verticals. |
| **PTC** | IIoT partner | ThingWorx (IIoT platform), Vuforia (AR). Listed on platforms page. | Moderate — IIoT overlay for brownfield installations. |

### Robotics Partners (Discrete Manufacturing)

| OEM | Robots Integrated | Use Cases |
| --- | --- | --- |
| **FANUC** | Industrial robots | Material handling, assembly, palletizing, machine tending |
| **KUKA** | Industrial robots | Pick-on-fly, custom work cells |
| **Omron** | Collaborative + industrial | NX/NJ/CJ controllers, Sysmac platform, cobots |
| **Kawasaki** | Industrial robots | Heavy payload, painting, welding |
| **Yaskawa** | Industrial robots (Motoman) | Arc welding, material handling |
| **Comau** | Industrial robots | Automotive assembly |
| **Staubli** | Industrial robots | Cleanroom, food & beverage |
| **Epson** | SCARA robots | Small-part assembly, precision handling |
| **Universal Robots** | Cobots | Flexible automation, machine tending |

### Developer Ecosystem

RoviSys has no external developer ecosystem, SDK, or app marketplace. Its talent development model is internal:

- **Co-op program**: Structured rotations for engineering students ($24/hr, real project work). Tracks in Software Development, Control Systems Integration, or Hardware Development.
- **University recruiting**: Active at engineering schools. Targets EE, Computer Engineering, and CS degrees.
- **Internal training**: Vendor certification support (Rockwell, Siemens, Ignition certifications for engineers). No public certification program for external partners.
- **GrandView**: Internal project management tool — not a platform others build on.

### Global Office Network (22+ locations)

| Region | Offices |
| --- | --- |
| **North America** | Aurora OH (HQ, 2 buildings), Holly Springs NC (RTP), Manassas VA, Boston, Houston, Atlanta (Peachtree City), Los Angeles (Thousand Oaks), San Diego (Carlsbad), Columbus OH, Kalamazoo/Portage MI, Chicago, Phoenix |
| **Europe** | Netherlands, Ireland |
| **Asia-Pacific** | Singapore (APAC HQ), Taiwan (Taichung), Indonesia (Jakarta), Malaysia (Kuala Lumpur), Thailand (Bangkok), Japan (Tokyo) |

---

## 5. Detailed Competitive Analysis

### vs JR Automation (Hitachi)

| Dimension | RoviSys | JR Automation |
| --- | --- | --- |
| **Ownership** | Privately held, independent since 1989 | Acquired by Hitachi in 2019 |
| **Vendor independence** | Core differentiator — 70+ vendor partnerships, selects best-fit per engagement | Hitachi-owned; bias toward Hitachi Lumada IoT platform, though still integrates third-party |
| **Scope breadth** | Process + discrete + building + warehouse + federal + Industrial AI | Primarily discrete manufacturing — robotic cells, assembly lines, material handling |
| **Process industries** | Deep expertise — DCS migration (DeltaV, 800xA, Experion), batch, continuous | Limited process automation capability |
| **Robotic depth** | Custom robotic cells as part of broader automation scope — not a robotics-first firm | Core competency — designs and builds turnkey robotic manufacturing systems, end-of-arm tooling, custom machines |
| **Digital twin** | Uses vendor simulation tools (Emulate3D, SIMIT) — no proprietary digital twin | Access to Hitachi digital twin capabilities and Lumada IoT platform |
| **Data center BMS** | Major growth area — 4,000+ MW of IT load delivered globally | Not a significant market |
| **SI Giants rank** | #2 (2026), #1 (2025) | Not ranked (Hitachi subsidiary — reports through parent) |
| **Revenue** | $325.7M SI revenue (2025) | ~$600M+ estimated (pre-acquisition was ~$500M) |
| **Employees** | ~2,000 | ~2,000+ across 27 facilities |
| **Automotive/aerospace** | Serves automotive but not a specialist | Core verticals — automotive body-in-white, aerospace assembly |

**Net**: RoviSys competes on breadth and vendor independence; JR Automation competes on turnkey robotic system depth and Hitachi's digital platform. They overlap in discrete manufacturing but rarely compete head-to-head — RoviSys wins on process-heavy or multi-vendor projects; JR wins on dedicated robotic production lines.

### vs MAVERICK Technologies (Rockwell)

| Dimension | RoviSys | MAVERICK Technologies |
| --- | --- | --- |
| **Ownership** | Independent | Acquired by Rockwell Automation in 2016 |
| **Vendor independence** | Full — integrates Rockwell, Siemens, Emerson, ABB, Honeywell | Rockwell-only — fully absorbed into Rockwell's process solutions delivery team |
| **Current status** | Operating independently with own brand, sales, and engineering | Brand exists but capabilities delivered as Rockwell LifecycleIQ Services |
| **Platform coverage** | 70+ vendor platforms | Rockwell stack only (PlantPAx, FactoryTalk, ControlLogix) |
| **Process expertise** | Broad — chemical, life science, oil & gas, food & beverage, power | Originally strong in chemical, food & beverage, oil & gas — now part of Rockwell's process team |
| **Building automation** | Major practice (RBT division, data centers) | No building automation |
| **Scale at acquisition** | N/A | ~300 engineers, 21 locations, largest independent SI at time of acquisition (2016) |

**Net**: MAVERICK was RoviSys's closest independent competitor before Rockwell's 2016 acquisition. Post-acquisition, MAVERICK lost vendor independence — its capabilities are now Rockwell-captive. This removal of an independent competitor benefited RoviSys, which absorbed market share from customers wanting vendor-neutral integration. RoviSys's 2018–2025 rise to #1 SI Giant correlates with MAVERICK's absorption into Rockwell.

### vs Barry-Wehmiller Design Group

| Dimension | RoviSys | BW Design Group |
| --- | --- | --- |
| **Parent** | Independent, privately held | Subsidiary of Barry-Wehmiller (diversified industrial conglomerate, ~$3.6B revenue) |
| **SI Giants rank** | #2 (2026) | #8 (2024) |
| **SI revenue** | $325.7M (2025) | Not separately disclosed |
| **Scope** | Pure automation SI — process, discrete, building, warehouse, AI | Full AEC firm — consulting, design, architecture, construction management + system integration |
| **SI focus** | Primary business — automation integration is the core | SI is one capability within a broader engineering/construction firm |
| **Vendor independence** | Full | Rockwell Platinum Integrator — strong Rockwell alignment |
| **Key verticals** | Chemical, life science, data center, semiconductor, automotive, federal | Food & beverage, life sciences, semiconductor, advanced technology |
| **Building automation** | Dedicated RBT division — data centers, mission-critical facilities | Not a primary focus |
| **Growth model** | Organic — no acquisitions | Acquisition-driven — acquired Malisko (SI firm) among others |

**Net**: BW Design Group is a broader engineering firm where SI is one service line. RoviSys is a pure-play SI where automation integration is the entire business. They overlap in life sciences and semiconductor but BW Design Group's value proposition includes architectural/construction services that RoviSys does not offer.

---

## Sources

- [RoviSys company history](https://www.rovisys.com/about/company-history/)
- [RoviSys about page](https://www.rovisys.com/about/)
- [RoviSys platforms and vendor partnerships](https://www.rovisys.com/about/platforms/)
- [RoviSys Industrial AI](https://www.rovisys.com/capabilities/industrial-artificial-intelligence/)
- [RoviSys ranked #2 SI Giant for 2026](https://www.rovisys.com/news/blog/rovisys-recognized-as-a-top-system-integrator-giant-ranked-2-for-2026/)
- [RoviSys ranked #1 SI Giant for 2025](https://www.prnewswire.com/news-releases/rovisys-recognized-as-top-system-integrator-giant-for-2025-302353260.html)
- [Rockwell Automation Platinum Partner designation](https://www.rovisys.com/news/blog/rockwell-automation-announces-platinum-system-integrator-partner-rovisys-to-its-partnernetwork/)
- [RoviSys Siemens partnership](https://www.rovisys.com/about/platforms/siemens/)
- [RoviSys Inductive Automation Premier Integrator](https://www.rovisys.com/news/blog/rovisys-recognized-as-inductive-automation-premier-integrator/)
- [RoviSys Building Technologies 10-year anniversary](https://www.rovisys.com/news/blog/rovisys-building-technologies-celebrates-ten-year-anniversary-of-engineering-excellence-growth/)
- [RoviSys Europe 10-year anniversary](https://www.rovisys.com/news/blog/rovisys-europe-celebrates-10-year-anniversary-a-decade-of-growth-innovation-and-milestones/)
- [RoviSys Northern Virginia office expansion](https://www.prnewswire.com/news-releases/rovisys-expands-footprint-brings-critical-environment-integration-expertise-to-northern-virginia-with-manassas-office-302777081.html)
- [RoviSys Federal Solutions announcement](https://www.rovisys.com/news/blog/rovisys-announces-federal-solutions-business-dedicated-automation-information-solutions-for-the-federal-government/)
- [RoviSys APAC expansion — Malaysia and Thailand](https://www.rovisys.com/news/blog/rovisys-establishes-new-offices-in-malaysia-thailand-appoints-bill-hurder-president-asia-pacific/)
- [RoviSys Jakarta office](https://www.rovisys.com/news/blog/rovisys-expands-southeast-asia-presence-with-new-office-in-jakarta-indonesia/)
- [RoviSys data center capabilities](https://www.rovisys.com/markets/data-centers/)
- [RoviSys BMS capabilities](https://www.rovisys.com/capabilities/building-management-systems-bms/)
- [RoviSys co-op program](https://www.rovisys.com/careers/co-op-program-opportunities/)
- [RoviSys locations](https://www.rovisys.com/about/locations/)
- [GrandView — Crain's Cleveland Business](https://www.crainscleveland.com/article/20010416/SUB/104160728/rovisys-ready-to-sell-its-software)
- [Rockwell Automation acquires MAVERICK Technologies (2016)](https://www.rockwellautomation.com/en-gb/company/news/press-releases/Rockwell-Automation-Acquires-MAVERICK-Technologies.html)
- [Rockwell LifecycleIQ Services](https://www.rockwellautomation.com/en-us/capabilities/lifecycle-services.html)
- [MAVERICK Technologies current status at Rockwell](https://www.rockwellautomation.com/en-us/capabilities/maverick-technologies.html)
- [CFE Media 2024 SI Giants](https://www.controleng.com/2024-system-integrator-giants/)
- [CFE Media 2025 SI Giants](https://www.controleng.com/2025-system-integrator-giants/)
