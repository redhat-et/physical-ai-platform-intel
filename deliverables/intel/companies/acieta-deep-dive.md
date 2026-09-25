# Acieta — Deep Dive Research

**Date**: 2026-09-25
**Last updated**: 2026-09-25
**Classification**: Internal analysis — not for public repo

Supporting research for the [Acieta competitive profile](acieta.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: PE roll-up timeline, product architecture, partnership details, and competitive analysis.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1983 | John and Marlo Burg found Automated Concepts, Inc. (ACI) in Omaha, Nebraska with eight employees. Vision: bring robotic automation beyond the automotive industry to general manufacturing. |
| 1992 | ACI relocates manufacturing operations to Council Bluffs, Iowa. |
| 2004 | Ellison Technologies Automation acquires ACI, combining complementary automation capabilities. |
| ~2012-05 | Acieta achieves initial RIA Certified Robot Integrator designation — among the first cohort of certified integrators nationally. |
| 2014 | Organization rebranded as Acieta, creating a unified identity. |
| ~2018 | Mitsui & Co. (U.S.A.) acquires Acieta (exact date not disclosed). |
| 2022-03 | Angeles Equity Partners acquires RōBEX (Perrysburg, OH) — first platform acquisition. RōBEX is a FANUC ASI and key distributor for MiR, Plus One Robotics, AutoGuide, and Seegrid AMRs. CEO: Jon Parker. |
| 2022 | Angeles acquires Mid-State Engineering — automation integrator focused on mechanical and electrical engineering. Second platform acquisition. |
| 2022-11 | Angeles acquires +Vantage Corporation (Michigan) — industrial robotics manufacturer and integrator. Third platform acquisition. |
| 2024-01 | Angeles acquires Acieta from Mitsui & Co. (U.S.A.) — fourth platform acquisition. 115 employees, 67,000 sq ft across Waukesha WI and Council Bluffs IA. Installed 5,500+ robots. CEO: Robby Komljenovic. Lincoln International advised Acieta. |
| 2024-07 | Acieta acquires Capital Industries LLC (Indiana) — fifth platform acquisition. All four companies (RōBEX, +Vantage, Mid-State Engineering, Capital Industries) become divisions of Acieta. Combined manufacturing footprint: ~207,000 sq ft. |
| 2024-10 | MC Machinery Systems enters exclusive partnership with Acieta for FastBEND robotic bending cell — unveiled at FABTECH Orlando. |
| 2025-01 | Angeles appoints Craig Ulrich as CEO of Acieta. |
| 2025-04 | Acieta and MC Machinery showcase FastBEND at FABTECH 2025 in Chicago. |
| 2025 | 25% year-over-year revenue growth. 4x increase in average project size under Corwin Carson's leadership as president and CCO. |
| 2026-01 | Angeles appoints Corwin Carson as CEO. Craig Ulrich becomes executive chair. Carson served on board since 2023, president and CCO since 2024. |
| 2026-06 | Unified rebrand — all five divisions consolidated under the Acieta brand. New visual identity, rebuilt website, tagline: "Integration is a team sport." HQ officially moved to Shelbyville, Indiana. |

### Acquisitions — The Angeles Equity Roll-Up

Angeles Equity Partners assembled Acieta through five acquisitions over two years. The strategic thesis: consolidate regional robotics integrators into a nationally scaled platform with broader technical capabilities, end-market diversification, and operational discipline.

#### RōBEX (March 2022 — Platform Foundation)

- **Price**: Undisclosed
- **Technology**: Robotic system design, fabrication, and installation for consumer goods and logistics. FANUC ASI. Key AMR distributor (MiR, Plus One Robotics, AutoGuide, Seegrid).
- **Integration**: Became the initial platform entity; all subsequent acquisitions folded into it before rebranding to Acieta in 2026.
- **Significance**: Brought AMR and vision system distribution capabilities that original Acieta lacked. Facilities in Perrysburg OH and Aylett VA.

#### Mid-State Engineering (2022)

- **Price**: Undisclosed
- **Technology**: Mechanical and electrical engineering for automation systems.
- **Integration**: Became an Acieta division.
- **Significance**: Added engineering depth — mechanical design and electrical integration capabilities.

#### +Vantage Corporation (November 2022)

- **Price**: Undisclosed
- **Technology**: Industrial robotics manufacturing and integration, Michigan-based.
- **Integration**: Became an Acieta division. Livonia MI facility retained.
- **Significance**: Added Michigan manufacturing presence and automotive-adjacent capabilities.

#### Acieta / ACI (January 2024)

- **Price**: Undisclosed
- **Technology**: Full-service robotics provider — systems, controls, and software engineering. Large standard products business (FastLOAD, FastARC). 40+ years of history, 5,500+ robots installed.
- **Integration**: Combined entity eventually took the Acieta name (recognized brand, longest heritage). HQ to Shelbyville IN.
- **Significance**: The largest acquisition — brought FANUC Certified Servicing and Vision Integrator status (<2% of ASIs), the FastLOAD/FastARC standard product line, and deep machine tending/welding/palletizing expertise across agriculture, foundry, and construction verticals.

#### Capital Industries LLC (July 2024)

- **Price**: Undisclosed
- **Technology**: Industrial robotics manufacturing and integration, Indiana-based.
- **Integration**: Became an Acieta division. Added Tipton IN and Shelbyville IN facilities.
- **Significance**: Expanded Indiana manufacturing footprint. Brought the combined platform to ~207,000 sq ft and seven North American facilities.

---

## 2. Product Architecture Details

Acieta is a system integrator with a growing standard product line. It delivers no proprietary automation platform — instead it designs, fabricates, and integrates robotic cells using FANUC robots and proprietary OEM controllers.

### Custom Robotic Systems

| Aspect | Details |
| --- | --- |
| **Architecture** | Turnkey robotic cells — mechanical design, fabrication, controls integration, programming, commissioning. Typical stack: FANUC robot controller → FANUC TP/Karel programming → custom end-of-arm tooling (EOAT) → safety system (fencing, light curtains, or collaborative mode). Vision integration via FANUC iRVision or Plus One Robotics. |
| **Runtime dependencies** | FANUC robot controller (proprietary R-30iB Plus or R-30iB Mate Plus). FANUC teach pendant for programming. Vendor-specific safety controllers. |
| **Extension model** | Custom TP (Teach Pendant) programs per application. Karel programming for complex logic. FANUC iRVision for visual guidance. No public API or SDK for end-user extension. |
| **Key limitations** | Each cell is custom-engineered — limited reusability across customers. No software platform layer; intelligence resides in FANUC controller firmware. |

### FastLOAD CX Series (Standard Cobot Products)

| Aspect | Details |
| --- | --- |
| **Architecture** | Mobile collaborative robot cell on wheeled platform. CX1000: FANUC CRX-10iA (10 kg payload). CX2000: FANUC CRX-20iA (20 kg payload). Standard 120V power — no hardwired connection. No safety fencing required (collaborative operation). Configurable cart system (up to four carts) for part staging. |
| **Runtime dependencies** | FANUC CRX collaborative robot controller. Standard 120V outlet. |
| **Extension model** | FANUC CRX tablet-based programming (drag-and-drop). Swappable EOAT. Custom cart configurations per application. |
| **Key limitations** | Limited to FANUC CRX payload range (10–20 kg). Collaborative speed limits constrain cycle time vs. industrial robots. Single-robot cells — not multi-robot coordinated systems. |

### FastBEND (Press Brake Tending)

| Aspect | Details |
| --- | --- |
| **Architecture** | Purpose-built robotic press brake tending cell. Diamond BB Series electric press brake (MC Machinery). Dual pallet stations, squaring station, automatic gripper changing, tool storage. Integrates with new or existing press brakes. |
| **Runtime dependencies** | FANUC robot (model varies by part size/weight). MC Machinery press brake or compatible third-party brake. |
| **Extension model** | Configurable for various part geometries via automatic gripper changing. Can process bin, pallet, and conveyor outputs. |
| **Key limitations** | Exclusive MC Machinery partnership for press brake component — limits press brake vendor choice. Small-to-medium parts at mid-to-high volume (not suited for large-format or low-volume). |

### FastARC Weld Cells

| Aspect | Details |
| --- | --- |
| **Architecture** | Standard robotic welding cells — multi-arm FANUC configurations. Example: three FANUC arms running 24/7 for bending-to-welding-to-palletizing workflow. FANUC ARC Mate or similar welding robots. |
| **Runtime dependencies** | FANUC robot controller with welding-specific firmware. Welding power source (vendor varies). Wire feeder, torch, and consumables. |
| **Extension model** | Multi-pass welding programs. Fixture design per part family. |
| **Key limitations** | Welding-specific — limited multi-application flexibility vs. FastFLEX. |

### FastFLEX Multi-Application Cobot

| Aspect | Details |
| --- | --- |
| **Architecture** | Compact, fenceless multi-application system built on FANUC CRX-30iA (30 kg payload). Handles palletizing, machine tending, and welding on one platform. Mechanism for up to four securely attached carts. Mobile — one worker can relocate. |
| **Runtime dependencies** | FANUC CRX-30iA controller. Application-specific EOAT. |
| **Extension model** | Swappable EOAT allows repurposing between applications. FANUC tablet programming. |
| **Key limitations** | 30 kg payload ceiling. Collaborative speed limits. Jack-of-all-trades positioning may compromise cycle time vs. dedicated cells. |

### Preflight (Pre-Project Simulation)

| Aspect | Details |
| --- | --- |
| **Architecture** | On-site discovery → 3D simulation modeling → feasibility testing → RFQ development. Simulation tool not publicly identified (likely FANUC ROBOGUIDE or similar OEM tool). |
| **Runtime dependencies** | 3D simulation software (vendor not disclosed). |
| **Extension model** | N/A — internal pre-sales engineering process. |
| **Key limitations** | Simulation used for pre-project feasibility only, not digital twin or continuous optimization. No evidence of simulation-to-deployment pipeline or sim-to-real transfer capability. |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Acieta Value-Add |
| --- | --- | --- | --- |
| **Custom Robotic Systems** | None — FANUC proprietary controllers | Proprietary | Cell design, fabrication, EOAT, integration, commissioning |
| **FastLOAD CX Series** | None — FANUC CRX proprietary platform | Proprietary | Mobile platform, cart system, application engineering |
| **FastBEND** | None — FANUC + MC Machinery proprietary | Proprietary | Cell design, gripper changing, workflow engineering |
| **AMR Integration** | None — MiR, Seegrid, AutoGuide all proprietary | Proprietary | System design, deployment, fleet configuration |
| **Vision Systems** | None — FANUC iRVision and Plus One Robotics both proprietary | Proprietary | Vision application engineering, calibration |

### Pattern Analysis

Acieta operates entirely on proprietary vendor platforms. It does not maintain, fork, contribute to, or meaningfully consume any open-source software. The company's value-add is mechanical design, fabrication, electrical integration, and application engineering — not software development.

The FANUC robot controller ecosystem is among the most proprietary in industrial robotics: closed firmware, proprietary programming languages (TP, Karel), no Linux runtime, no ROS integration, no public APIs beyond basic I/O protocols. This contrasts sharply with more open ecosystems (Universal Robots' URScript, or ROS 2-native robots from Clearpath/OTTO).

Acieta's AMR partners (MiR, Seegrid) are similarly proprietary. Plus One Robotics uses computer vision for pick-and-place but runs on its own proprietary cloud platform.

### Notable Dependencies

- **FANUC controller ecosystem**: Acieta's entire standard product line (FastLOAD, FastARC, FastBEND, FastFLEX) is built on FANUC robots and controllers. Switching OEMs would require complete product redesign. This is the deepest vendor dependency in the profile.
- **MC Machinery Systems**: Exclusive partnership for FastBEND press brake component. If MC Machinery terminates exclusivity, Acieta loses its press brake product line.

---

## 4. Partnership & Ecosystem Details

### Technology Partners — Detailed

| Partner | Relationship | Integration Depth | Revenue Significance |
| --- | --- | --- | --- |
| **FANUC** | Certified Servicing and Vision Integrator (<2% of ASIs); A3 Certified Robot Integrator | Deep — FANUC controllers, firmware, programming languages, iRVision, CRX cobots are the foundation of all products and custom cells | Primary revenue driver — FANUC robots in virtually every Acieta project |
| **MiR (Mobile Industrial Robots)** | Key distributor (via RōBEX legacy) | Moderate — deploys MiR AMRs in warehousing and material transport applications | Growing — AMR demand increasing as warehousing vertical expands |
| **Seegrid** | Distributor (via RōBEX legacy) | Moderate — vision-guided AMR deployment | Moderate — warehouse and logistics projects |
| **AutoGuide Mobile Robots** | Distributor (via RōBEX legacy) | Moderate — autonomous tugger and forklift integration | Moderate — material transport applications |
| **Plus One Robotics** | Vision systems partner (via RōBEX legacy) | Moderate — advanced robotic vision for pick-and-place | Growing — vision-guided picking increasingly demanded |
| **MC Machinery Systems** | Exclusive press brake partnership | Deep — co-developed FastBEND product; co-marketing at FABTECH | Moderate — FastBEND is one standard product line |
| **Angeles Equity Partners** | PE owner | Deep — controls board, appoints CEO, drives acquisition strategy, operational transformation | N/A — investor, not technology partner |

### Customer Base

Acieta serves mid-market manufacturers across 11 verticals:

| Vertical | Typical Applications |
| --- | --- |
| **Aerospace + Defense** | Assembly, inspection, material handling |
| **Agriculture + Construction** | Equipment component welding, material handling |
| **Appliances** | Assembly, pick-and-place |
| **Automotive** | Welding, assembly, machine tending |
| **Building Products** | Material handling, palletizing |
| **Consumer Goods** | Packaging, palletizing (RōBEX legacy) |
| **Food + Beverage** | Palletizing, packaging |
| **Glass + Plastic Packaging** | Material handling, inspection |
| **Medical** | Assembly, inspection |
| **Non-Auto Transport** | Heavy component handling (e.g., Great Dane trailer manufacturing) |
| **Warehousing + Logistics** | AMR deployment, palletizing, pick-and-place (RōBEX legacy) |

### Notable Customers

- **Honeywell**: "Choosing Acieta transformed more than our systems; it transformed our perspective." (Aaron Lanning, Adv. Mfg. Engineering Principal)
- **Great Dane**: Long-haul automation — FANUC M-2000iA on 160-foot Acieta RTU for heavy component loading, replacing forklifts
- **Prince Manufacturing**: Reportedly doubled productivity through automation

### Facilities

| Location | Function | Size |
| --- | --- | --- |
| **Shelbyville, Indiana** | HQ (post-2026 rebrand) | Not disclosed |
| **Council Bluffs, Iowa** | Manufacturing, integration | Part of ~207,000 sq ft total |
| **Tipton, Indiana** | Manufacturing (Capital Industries legacy) | Part of ~207,000 sq ft total |
| **Livonia, Michigan** | Manufacturing (+Vantage legacy) | Part of ~207,000 sq ft total |
| **Saltillo, Mexico** | Manufacturing, service | Not disclosed |

Field service technicians are based across the U.S. for 24/7 emergency response.

### Developer Ecosystem

Acieta has no external developer ecosystem, SDK, or app marketplace. Its talent and service model is internal:

- **Operator training**: Customized training programs for each installed system
- **FANUC certifications**: Staff holds FANUC Certified Service Engineer and Master Certified Service Engineer designations
- **A3/RIA certification**: Certified Robot Integrator since 2012, recertified on two-year cycle
- No public engineering community, open-source contributions, or third-party developer program

---

## 5. Detailed Competitive Analysis

### vs RoviSys

| Dimension | Acieta | RoviSys |
| --- | --- | --- |
| **Ownership** | PE-backed (Angeles Equity Partners) | Privately held, independent since 1989 |
| **Revenue** | Est. $50–100M (25% YoY growth) | $325.7M SI revenue (2025) |
| **Employees** | 300+ | ~2,000 |
| **Scope** | Robotic cells only — machine tending, welding, palletizing, AMRs | Full automation scope — process, discrete, building, warehouse, federal, Industrial AI |
| **Robot depth** | Core competency — standard product line + custom cells, FANUC <2% tier certification | Custom robotic cells as part of broader scope — not robotics-first |
| **Vendor independence** | FANUC-aligned (entire product line), OEM-agnostic claim but limited evidence | Full vendor independence — 70+ vendor partnerships, Rockwell Platinum |
| **Process automation** | None | Deep — DCS migration, batch, continuous across Rockwell, Siemens, Emerson, ABB, Honeywell |
| **MES/SCADA** | None | Major practice — Ignition, Critical Manufacturing, Velotic |
| **Industrial AI** | None | Growing practice — Rockwell, AVEVA, Databricks, Cognite |
| **Standard products** | FastLOAD, FastARC, FastBEND, FastPACK, FastFLEX — repeatable, fast-delivery | No standard products — pure custom integration |
| **Geographic coverage** | 5 facilities across U.S. and Mexico | 22+ locations across 4 continents |

**Net**: Acieta competes on focused robotic automation depth with fast-delivery standard products for mid-market manufacturers. RoviSys competes on enterprise-scale breadth across all automation domains. They overlap in discrete manufacturing robotic cells but target different customer segments — Acieta wins on standardized, labor-shortage-driven deployments; RoviSys wins on complex, multi-vendor, multi-discipline projects.

### vs JR Automation (Hitachi)

| Dimension | Acieta | JR Automation |
| --- | --- | --- |
| **Ownership** | PE-backed (Angeles, since 2022) | Hitachi subsidiary (since 2019) |
| **Revenue** | Est. $50–100M | Est. $600M+ |
| **Scope** | Robotic cells, standard products, AMRs | Turnkey robotic manufacturing systems, custom machines, assembly lines |
| **Automotive** | Serves automotive but not a specialist | Core vertical — body-in-white, aerospace assembly |
| **Standard products** | FastLOAD/FastARC/FastBEND product line | No comparable standard product line |
| **Digital twin** | 3D simulation for pre-project feasibility only | Hitachi digital twin and Lumada IoT platform |
| **Scale** | 5 facilities, 300+ employees | 27 facilities, 2,000+ employees |
| **FANUC relationship** | <2% Certified Servicing and Vision Integrator | Certified Robot Integrator (standard tier) |
| **Growth strategy** | PE roll-up of regional integrators | Organic growth within Hitachi ecosystem |

**Net**: JR Automation is 6x larger and has deeper automotive/aerospace specialization with Hitachi's digital platform behind it. Acieta differentiates on standardized product delivery speed, mid-market accessibility, and FANUC integration depth. They compete head-to-head in discrete manufacturing robotic cells, but Acieta targets the labor-shortage-driven mid-market while JR Automation serves large-enterprise programs.

### vs FANUC Direct (CRX Cobots)

| Dimension | Acieta | FANUC Direct |
| --- | --- | --- |
| **Robot supply** | Integrates FANUC robots into complete cells | Sells robots directly to end users |
| **Value-add** | Cell design, fabrication, EOAT, vision integration, programming, project management, lifecycle support | Robot hardware and controller — bare platform |
| **Standard products** | FastLOAD CX builds on CRX-10iA/20iA/30iA with mobile platform, carts, and application engineering | CRX sold as standalone cobot |
| **Service** | 24/7 emergency response, preventive maintenance, spare parts | FANUC service network (large but not application-specific) |

**Net**: Acieta is FANUC's channel to manufacturers who need turnkey solutions, not bare robots. The relationship is symbiotic — FANUC sells robots through Acieta, and Acieta depends on FANUC for its entire product platform. Tension exists only if FANUC pushes more direct-to-customer solutions (e.g., pre-configured CRX packages that bypass integrators).

---

## Sources

- [Acieta — about page](https://acieta.com/about)
- [Acieta — our story](https://www.acieta.com/about-us/)
- [Acieta rebrand press release (June 2026)](https://www.prnewswire.com/news-releases/acieta-unveils-new-brand-identity-as-a-complete-factory-automation-partner-302805663.html)
- [Angeles acquires Acieta — PE Professional (January 2024)](https://peprofessional.com/2024/01/fourth-strategic-transaction-extends-capabilities-and-broadens-end-markets/)
- [Angeles acquires Acieta — Lincoln International advisory](https://www.lincolninternational.com/transactions/mitsui-co-u-s-a-has-sold-acieta-to-robex-a-portfolio-company-of-angeles-equity-partners/)
- [Angeles acquires Acieta — The Robot Report](https://www.therobotreport.com/private-equity-firm-acquires-robotics-integrator-acieta/)
- [Capital Industries acquisition (July 2024)](https://www.businesswire.com/news/home/20240730249003/en/Angeles-Equity-Partners-Portfolio-Company-Acieta-Acquires-Capital-Industries)
- [Corwin Carson appointed CEO (January 2026)](https://www.businesswire.com/news/home/20260120926073/en/Angeles-Equity-Partners-Appoints-Corwin-Carson-as-CEO-of-Acieta)
- [MC Machinery FastBEND partnership (October 2024)](https://www.businesswire.com/news/home/20241015872704/en/MC-Machinery-Systems-Partners-with-Acieta-to-Offer-the-FastBEND-Robotic-Bending-Cell)
- [Acieta RIA Certified Robot Integrator recertification](https://www.automate.org/robotics/news/acieta-achieves-robot-integrator-recertification)
- [RIA first certified robot integrators](https://www.automate.org/news/ria-announces-first-certified-robot-integrators)
- [Acieta PMMI ProSource profile](https://www.prosource.org/company/acieta)
- [Acieta FastLOAD CX Series](https://www.acieta.com/cxseries/)
- [Acieta standard solutions](https://www.acieta.com/standard-solutions/)
- [Acieta FastARC weld cells](https://www.acieta.com/robotics-products/fastarc-weld-cells/)
- [RōBEX AMR capabilities](https://robex.us/capabilities/autonomous-mobile-robotics-amrs/)
- [Kona Equity — Acieta financials](https://www.konaequity.com/company/acieta-llc-4388589452/)
