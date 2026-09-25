# Comau — Deep Dive Research

**Date**: 2026-09-25
**Last updated**: 2026-09-25
**Classification**: Internal analysis — not for public repo

Supporting research for the [Comau competitive profile](comau.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: corporate timeline, product architecture, OSS foundations analysis, partnership details, and competitive analysis.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1973 | Comau (Consorzio Macchine Utensili) formed in Turin from several Fiat supplier companies that had equipped the AvtoVAZ plant in Russia |
| 1978 | Builds first Robogate robotic assembly system — pioneering multi-robot body-in-white production |
| 1979 | Delivers first robotic assembly line to Fiat Mirafiori plant for Fiat 131 production |
| 1997 | Establishes Comau Automotive Equipment Co. in Shanghai — foundation for APAC operations |
| 1999 | Acquires car body and welding activities of French firm Sciaky S.A.; purchases 51% stake in Renault Automation |
| 2014-10 | Fiat Group merges with Chrysler to form FCA; Comau becomes FCA subsidiary |
| 2021-01 | FCA and Groupe PSA merge to form Stellantis N.V.; Comau becomes Stellantis subsidiary with planned spinoff commitment |
| 2022-10 | Selected by ACC (Stellantis/TotalEnergies/Mercedes JV) to build battery module production lines for Gigafactory |
| 2024-07 | ONE Equity Partners signs binding agreement for majority investment in Comau |
| 2024-12 | OEP completes majority investment (50.1%); Stellantis retains 49.9% minority stake |
| 2025-04 | Signs binding agreement to acquire Automha (warehouse/intralogistics automation) |
| 2025-06 | Unveils MyMR autonomous mobile robot family at Automatica 2025 (developed with Milvus Robotics) |
| 2025-07 | Completes Automha acquisition — 100% of shares |
| 2025-09 | Launches partnership with CEAD, KraussMaffei, Prima Additive, and Titomic for robotic additive manufacturing |
| 2025-10 | Invests in Intecells (cold plasma specialist for battery manufacturing) |
| 2025-12 | European Investment Bank invests €50M for robotics R&D |
| 2026-01 | Deploys in.Grid Robot Monitoring at IVECO Valladolid plant |
| 2026-02 | Launches MATE-XT GO exoskeleton — latest generation wearable robotics |
| 2026-03 | Hyperflex solution wins Robotics Innovation Award at MecSpe 2026 |
| 2026-05 | Signs MoU with Aptiv for next-gen robotics, autonomous systems, and AI-enabled logistics |
| 2026-05 | Signs strategic collaboration with Omron Robotics for electronics, semiconductors, and medical manufacturing |

### Acquisitions — What Each Brought

#### Sciaky S.A. welding activities + Renault Automation stake (1999)

- **Price**: Undisclosed
- **Technology**: Car body welding expertise (Sciaky); automated assembly systems (Renault Automation)
- **Integration**: Strengthened Comau's European BIW capabilities and customer base beyond Fiat
- **Significance**: Established Comau as a pan-European system integrator, not just a captive Fiat supplier

#### Automha (2025)

- **Price**: Undisclosed
- **Technology**: Automated storage and retrieval systems (ASRS), intelligent warehousing, intralogistics automation; manufacturing in Italy and China, four global subsidiaries
- **Integration**: Operates as wholly-owned subsidiary with original leadership (Franco Togni as CEO); Togni family joined Comau Executive Committee
- **Significance**: First major acquisition under OEP ownership. Opens logistics automation market (10%+ annual growth). Complements Comau's MyMR AMR portfolio and factory automation with warehouse-to-production-line integration. Reinforces Italian industrial hub strategy.

#### IUVO (majority stake, date undisclosed)

- **Price**: Undisclosed
- **Technology**: Wearable robotics and exoskeleton technology; spin-off from Scuola Superiore Sant'Anna (Pisa) — a leading European robotics research university
- **Integration**: Core technology provider for MATE exoskeleton family; Comau holds majority share
- **Significance**: Gives Comau deep biomechanics and human-robot interaction R&D; academic lineage provides credibility in wearable robotics market

---

## 2. Product Architecture Details

### Industrial Robots (CRC Controller Architecture)

| Aspect | Details |
| --- | --- |
| **Architecture** | Fifth-generation CRC (Comau Robot Controller) — multi-core architecture running Wind River VxWorks RTOS. Manages peripherals control, application software, and real-time motion functions simultaneously. Supports PDL2 proprietary programming language. 50x faster processing than previous generation (C4G). |
| **Runtime dependencies** | Wind River VxWorks (commercial RTOS); proprietary CRC hardware; PDL2 runtime; motor drives and encoders |
| **Extension model** | CRCOpen option exposes robot control to external Linux PC via UDP at 400µs intervals. ORL (Open Robot Library) runs on Linux RTOS and provides advanced motion planning. Third-party ROS-Industrial driver (UKAEA CRCOpenROS2Driver) enables ROS 2 integration. |
| **Key limitations** | Proprietary PDL2 programming language limits portability. VxWorks dependency creates coupling to Wind River. CRCOpen requires separate external PC. Robot portfolio narrower than FANUC/ABB/KUKA at the high-payload end. |

### Robot Product Range

| Family | Payload | Reach | Key Application |
| --- | --- | --- | --- |
| **Racer-5** | 3–7 kg | 630–1,436 mm | High-speed pick-and-place, assembly; Racer-5 COBOT dual-mode variant |
| **Racer-5 SE** | 5 kg | 809 mm | Pharma/sensitive environments |
| **NJ Series** | 6–650 kg | 1,400–4,200 mm | Welding, material handling, palletizing, heavy assembly |
| **AURA** | 170 kg | 2,800 mm | High-payload collaborative tasks; full-body proximity sensor skin |

### in.Grid IoT Platform

| Aspect | Details |
| --- | --- |
| **Architecture** | SaaS platform with three modules: (1) Robot Monitoring — autonomous data capture from robot controllers, anomaly detection, KPI tracking; (2) Line Monitoring — real-time PLC data collection, OEE tracking, bottleneck identification; (3) Traceability — end-to-end production tracking and compliance. Data collection at machine/line/plant level; analytics platform with AI/ML algorithms hosted on-premise, external datacenter, or private cloud. |
| **Runtime dependencies** | Requires connectivity to Comau robot controllers or PLCs; SaaS infrastructure (cloud or on-premise); web browser for dashboard access |
| **Extension model** | Connects to Comau and non-Comau equipment; standard industrial protocols for data acquisition; web-based interface accessible from any device |
| **Key limitations** | Primarily designed for Comau robot environments. AI capabilities described as "being enriched" — still evolving beyond statistical/trend-based analysis. Digital twin capabilities are monitoring-oriented, not physics simulation. No disclosed API or third-party integration ecosystem. |

### Body-in-White (OpenGate) Systems

| Aspect | Details |
| --- | --- |
| **Architecture** | Modular OpenGate (formerly Open RoboGate) framing system: customizable work-holding "gates" hold body parts for welding. Gates work in pairs per vehicle model; up to 12 gates stored per station, deployable in any sequence for multi-model flexibility. Integrated joining technologies: spot welding, laser welding/brazing/cutting, 3D plasma cutting, roller hemming (RHEvo). |
| **Runtime dependencies** | Comau robots, PLC/safety controllers, conveyor systems, end-of-arm tooling, vision systems |
| **Extension model** | Modular gate design allows new vehicle models to be added by inserting new gate pairs. Virtual commissioning reduces physical commissioning time. |
| **Key limitations** | Capital-intensive turnkey systems. Each installation is custom-engineered. 9–12 month lead time for new vehicle introduction (down from 18–24 months historically). |

### E-Mobility Solutions

| Aspect | Details |
| --- | --- |
| **Architecture** | End-to-end electrification manufacturing: (1) Battery — cell formation, module assembly, pack assembly (prismatic/cylindrical/pouch formats); (2) E-drive — stator/rotor assembly, hairpin stator core assembly, e-Axle assembly, electric transmission housing machining; (3) End-of-line test. Proprietary Battery Competence Center and Laser Labs for next-gen technologies including solid-state batteries. |
| **Runtime dependencies** | Comau robots, laser systems, vision systems, PLCs, test equipment |
| **Extension model** | Flexible format support (multiple cell types on same line); scalable from prototype to high-volume production |
| **Key limitations** | Heavy capital investment per line. Customer concentration risk (Stellantis/ACC is largest customer). Competition from Asian battery equipment suppliers (particularly Chinese firms) intensifying. |

### MATE Exoskeletons

| Aspect | Details |
| --- | --- |
| **Architecture** | Fully passive (mechanical) — no motors, batteries, or electronics. Chain of passive degrees of freedom aligned with human joint flexion-extension axes. MATE-XT: shoulder/arm support for overhead and repetitive tasks. MATE-XB: lumbar support with spring energy storage for lifting. MATE-XT GO: latest generation, <3 kg, 30-second don/10-second doff, Category II PPE certified. |
| **Runtime dependencies** | None — purely mechanical |
| **Extension model** | Adjustable assistance levels; size-adaptable to different body types |
| **Key limitations** | Passive-only design limits assistance range compared to powered exoskeletons. No sensing or data collection capability (unlike powered competitors). Market is fragmented with many competitors. |

### MyMR Autonomous Mobile Robots

| Aspect | Details |
| --- | --- |
| **Architecture** | Three models: MyMR-300 (300 kg), MyMR-500 (500 kg), MyMR-1500 (1,500 kg). Infrastructure-free navigation (no magnetic tapes or floor markings). MyMR Fleet Manager web-based central management. Software-switchable between AMR (autonomous) and AGV (guided) modes. |
| **Runtime dependencies** | Wi-Fi network for fleet management; Milvus Robotics navigation stack |
| **Extension model** | Modular payload configurations; fleet scaling via Fleet Manager |
| **Key limitations** | New product family (launched 2025) — limited installed base. Based on Milvus Robotics technology, not Comau-developed from scratch. Competing against established AMR players (MiR/Teradyne, OTTO Motors/Rockwell, Locus Robotics). |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **CRC Robot Controller** | None — Wind River VxWorks (commercial RTOS) | Commercial | PDL2 runtime, motion control, safety systems |
| **Open Controller** | Linux RTOS (external PC) | GPL v2 (kernel) | ORL motion library, CRCOpen interface protocol |
| **ROS 2 Integration** | CRCOpenROS2Driver (third-party, UKAEA) | Apache 2.0 | Not Comau-developed; community contribution |
| **in.Grid IoT** | None identified | N/A | Full SaaS platform — data collection, AI analytics, dashboards |
| **MyMR AMRs** | None identified | N/A | Fleet management, navigation (via Milvus Robotics) |
| **OpenGate BIW** | None identified | N/A | Framing system design, virtual commissioning, joining technology |
| **E-Mobility Lines** | None identified | N/A | Battery/e-drive assembly processes, laser welding, test systems |
| **MATE Exoskeletons** | N/A — no software | N/A | Mechanical design, biomechanics (IUVO) |

### Pattern Analysis

Comau is fundamentally a proprietary-stack company. Its core robot controller runs Wind River VxWorks (commercial RTOS), and its programming environment uses the proprietary PDL2 language. The in.Grid IoT platform is a proprietary SaaS offering. There are no Comau-stewarded open-source projects.

The one significant opening is the CRCOpen/Open Controller architecture, which deliberately exposes robot control to external Linux PCs. This creates a pathway for Linux-based software stacks to control Comau hardware — but the interface itself (ORL library) is proprietary. The third-party ROS-Industrial driver (developed by UK Atomic Energy Authority, not Comau) demonstrates that Comau robots can participate in ROS 2 ecosystems, but this is a community effort, not a Comau strategy.

Comau's May 2026 Aptiv collaboration explicitly references "Wind River cloud and edge technologies" and "Wind River VxWorks" as the RTOS foundation — reinforcing the Wind River dependency rather than signaling a move toward open-source alternatives.

### Notable Dependencies

- **Wind River VxWorks**: Foundation of all Comau robot controllers since the C5G generation (2011). The Aptiv collaboration deepens this dependency by extending VxWorks into edge computing and AMR platforms. VxWorks is also used by competitor KUKA for its KR C4 controller.
- **Milvus Robotics**: Provides the core navigation and autonomy stack for MyMR AMRs. Comau selected Milvus as its "technology partner" — Comau does not own the AMR software stack.
- **Linux RTOS (Open Controller)**: The CRCOpen external PC requires a Linux-based RTOS. The specific distribution is not prescribed, creating an opportunity for RHEL for Edge or similar.

---

## 4. Hardware Platform Details

### Current Robot Hardware

| Product | Payload | Axes | Reach | Repeatability | Key Feature |
| --- | --- | --- | --- | --- | --- |
| Racer-5 COBOT | 5 kg | 6 | 809 mm | N/A | Dual-mode: collaborative + full industrial speed |
| Racer-5 SE | 5 kg | 6 | 809 mm | N/A | Pharma/sensitive environment rated |
| Racer-7 | 7 kg | 6 | 1,436 mm | N/A | Compact high-speed industrial |
| NJ-60 | 60 kg | 6 | N/A | 0.05 mm | Mid-range industrial |
| NJ-130 | 130 kg | 6 | 2,050 mm | N/A | Welding, material handling |
| NJ-650 | 650 kg | 6 | 2,700 mm | 0.15 mm | Heavy-duty (largest in portfolio) |
| AURA-170 | 170 kg | 6+ | 2,800 mm | N/A | Full-body sensor skin, collaborative |

### Wearable Robotics Hardware

| Product | Type | Weight | Support Region | Key Feature |
| --- | --- | --- | --- | --- |
| MATE-XT | Passive exoskeleton | ~4 kg | Shoulders/arms | Ruggedized for indoor/outdoor |
| MATE-XT GO | Passive exoskeleton | <3 kg | Shoulders/arms | 30s don / 10s doff; Cat II PPE certified |
| MATE-XB | Passive exoskeleton | N/A | Lumbar/back | Spring energy storage; loads up to 25 kg |

### AMR Hardware

| Product | Payload | Navigation | Key Feature |
| --- | --- | --- | --- |
| MyMR-300 | 300 kg | Infrastructure-free | Smallest model; kitting, light transport |
| MyMR-500 | 500 kg | Infrastructure-free | Mid-range; production line supply |
| MyMR-1500 | 1,500 kg | Infrastructure-free | Heavy transport; warehouse operations |

---

## 5. Partnership & Ecosystem Details

### Stellantis (49.9% Minority Shareholder)

| Dimension | Details |
| --- | --- |
| **History** | Comau was Fiat's captive automation arm for 50+ years; built production lines for virtually every Fiat/FCA/Stellantis vehicle |
| **Current relationship** | Stellantis retains 49.9% stake; remains one of Comau's major customers; CEO Filosa confirmed ongoing industrial partnership |
| **Exit timeline** | OEP holds option to purchase remaining 49.9% within three years (by end 2027); Stellantis gains right to sell from 2027 onward |
| **Revenue dependency** | Stellantis historically represented a large share of Comau's revenue — OEP's primary strategy is reducing this concentration |

### ONE Equity Partners (50.1% Majority Owner)

| Dimension | Details |
| --- | --- |
| **Investment thesis** | Middle market PE firm ($6B+ assets); focused on industrial, healthcare, technology in North America and Europe; seeks "transformative business combinations" |
| **Strategy for Comau** | Diversify beyond automotive/Stellantis; expand into logistics, pharma, electronics, renewable energy; Automha acquisition is first major move |
| **Timeline** | Full ownership likely by end 2027 via call option on Stellantis's 49.9% |
| **Capital access** | €50M EIB loan (Dec 2025) for robotics R&D; additional PE capital available for bolt-on acquisitions |

### Aptiv (MoU, May 2026)

| Dimension | Details |
| --- | --- |
| **Scope** | Co-development of advanced robotics, autonomous systems, AI-enabled warehouse/logistics, radar/vision-based safety |
| **Technology exchange** | Aptiv brings Wind River edge platforms, PULSE sensor/interconnect solutions, perception and compute architectures; Comau brings robotics, automation, large-scale deployment |
| **Pre-existing relationship** | Comau robots used in Aptiv manufacturing facilities; Comau controllers already run Wind River VxWorks |
| **Significance** | Signals Comau's direction toward AI-enabled, edge-compute-driven automation; Wind River (Aptiv subsidiary) provides compute and RTOS foundation |

### Omron Robotics (Strategic Collaboration, May 2026)

| Dimension | Details |
| --- | --- |
| **Scope** | Joint solutions for electronics, semiconductors, medical manufacturing, light industrial intralogistics |
| **Rationale** | Comau's industrial robotics expertise + Omron's complementary automation technologies (PLCs, sensors, vision, motion control) |
| **Significance** | Opens new verticals for Comau beyond automotive; Omron's portfolio fills gaps in Comau's controls and sensor stack |

### Fincantieri (Shipbuilding)

| Dimension | Details |
| --- | --- |
| **Project** | MR4WELD — mobile robot for autonomous outdoor welding in shipyards |
| **Capability** | Welds up to 170 meters of steel per shift — 3x improvement over manual processes |
| **Significance** | Demonstrates Comau's expansion into unstructured, non-automotive environments; combines mobile robotics with welding expertise |

### Developer Ecosystem

No developer ecosystem in the traditional sense. Comau operates as a project-based automation company delivering custom-engineered solutions. Notable openings:

- **Comau Academy**: Training programs for industrial automation and robotics — focused on operator/technician skill development, not software development
- **CRCOpen/Open Controller**: Provides a documented interface for external PC control, but no public SDK, marketplace, or developer community
- **ROS-Industrial**: Third-party ROS 2 driver exists (UKAEA), but Comau does not officially support or contribute to ROS ecosystem
- **Harvard Business School**: Comau hosts HBS students annually, positioning itself as an Italian industrial automation case study — academic engagement, not developer community

---

## 6. Detailed Competitive Analysis

### vs JR Automation (Hitachi)

| Dimension | Comau | JR Automation |
| --- | --- | --- |
| **Revenue** | ~€1B (estimated) | ~$600M (estimated) |
| **Employees** | ~4,000–5,400 | 2,000+ |
| **Parent** | ONE Equity Partners (PE) + Stellantis (minority) | Hitachi ($76B+) |
| **Robot hardware** | Manufactures own robots (6–650 kg) | None — pure integrator (FANUC, ABB, KUKA, etc.) |
| **Robot neutrality** | Uses primarily own robots; can integrate others | Vendor-neutral — integrates 6+ OEM brands |
| **BIW capability** | Deep — OpenGate framing, 50+ years Fiat/FCA/Stellantis | Strong — Esys Automation acquisition added automotive BIW |
| **EV/Battery** | 60+ electrification projects; ACC Gigafactory lines; hairpin stator expertise | E-mobility solutions via integration |
| **Digital platform** | in.Grid IoT (robot/line monitoring, SaaS) | INGENOVA360 (SCADA/MES) + Hitachi Lumada IoT |
| **AI/Simulation** | Virtual commissioning for BIW; in.Grid AI analytics | Line Builder (NVIDIA Omniverse, prototype) + Hitachi AI COE |
| **Wearable robotics** | MATE exoskeletons (3,000+ companies) | None |
| **Logistics** | Automha ASRS + MyMR AMRs | Not a focus |
| **Geographic strength** | Europe (Italy-based), strong in China/APAC | North America (#1 SI), expanding globally |
| **Red Hat connection** | None direct | Indirect via Hitachi (250+ OpenShift AI projects) |

Comau and JR Automation differ fundamentally in vertical integration. Comau makes its own robots and builds production lines — a single-source model similar to KUKA Systems. JR Automation is a pure integrator that assembles solutions from third-party robot OEMs. For customers seeking vendor neutrality, JR Automation is preferred; for customers wanting a single-source Italian engineering partner, Comau has the edge. Comau's EV battery assembly expertise is notably deeper than JR Automation's, reflecting decades of Stellantis electrification programs.

### vs KUKA Systems (Midea)

| Dimension | Comau | KUKA Systems |
| --- | --- | --- |
| **Parent** | ONE Equity Partners (PE) | Midea Group ($55B+, China) |
| **Vertical integration** | Own robots + system integration | Own robots + system integration (same model) |
| **Robot portfolio** | 6–650 kg; cobots (Racer-5, AURA) | 3–1,300+ kg; cobots (LBR iiwa, LBR iisy) |
| **BIW strength** | OpenGate framing — deep Fiat/Stellantis heritage | Dominant in German automotive BIW — VW, BMW, Mercedes history |
| **Digital platform** | in.Grid IoT | KUKA.Connect IoT |
| **Simulation** | Virtual commissioning | KUKA.Sim (in-house) |
| **Geopolitical** | Italian heritage, PE-backed; neutral positioning | Chinese-owned (Midea); faces geopolitical scrutiny in EU/US defense and security-adjacent applications |
| **Market positioning** | Diversifying beyond automotive under PE pressure | Automotive-dominant; Midea pushing into consumer/general industry |

Comau and KUKA Systems are the closest structural competitors — both manufacture robots and build production lines. KUKA has a broader robot portfolio and deeper German automotive OEM relationships. Comau has stronger electrification expertise and is more aggressively diversifying under PE ownership. KUKA's Chinese ownership under Midea creates geopolitical considerations that Comau's Italian identity avoids.

### vs ABB Robotics

| Dimension | Comau | ABB Robotics |
| --- | --- | --- |
| **Scale** | ~€1B revenue; ~4,000–5,400 employees | ABB Robotics ~$3.5B revenue; part of ABB ($32B+) |
| **Robot portfolio** | 6–650 kg; narrower range | 0.5–800+ kg; broadest portfolio in industry |
| **System integration** | Deep BIW and EV battery line expertise | Less emphasis on turnkey line building; stronger in cell-level integration |
| **Cobots** | AURA (high-payload, sensor skin); Racer-5 COBOT | GoFa, SWIFTI, YuMi — broader cobot range |
| **Digital platform** | in.Grid IoT | ABB Ability platform (far larger digital ecosystem) |
| **Service network** | 12 countries | 100+ countries |
| **Wearable robotics** | MATE exoskeletons | None |

ABB operates at a fundamentally different scale. Comau competes with ABB on specific applications (automotive BIW, EV assembly) rather than across the full robotics market. Comau's advantage is deep system integration expertise — it delivers entire production lines, not just robot cells. ABB's advantage is breadth, service network, and digital platform maturity.

---

## Sources

- [Comau history](https://www.comau.com/en/about-us/history/)
- [Comau — Wikipedia](https://en.wikipedia.org/wiki/Comau)
- [ONE Equity Partners invests in Comau (Jul 2024)](https://www.comau.com/en/2024/07/25/one-equity-partners-invests-in-comau/)
- [ONE Equity Partners completes investment (Dec 2024)](https://www.comau.com/en/2024/12/30/one-equity-partners-completes-investment-in-comau/)
- [Stellantis completes Comau transaction (Dec 2024)](https://www.stellantis.com/en/news/press-releases/2024/december/stellantis-successfully-completes-comau-transaction)
- [Stellantis to fully exit Comau — Yahoo Finance](https://finance.yahoo.com/news/stellantis-fully-exit-comau-one-194803023.html)
- [Comau acquires Automha (Jul 2025)](https://www.comau.com/en/2025/07/31/comau-completes-its-acquisition-of-automha/)
- [Comau enters binding agreement for Automha (Apr 2025)](https://www.comau.com/en/2025/04/16/comau-enters-into-a-binding-agreement-to-acquire-automha/)
- [Comau robot product line](https://www.comau.com/en/our-offer/products-and-solutions/robot-team/)
- [Comau Racer series](https://www.comau.com/en/our-offer/products-and-solutions/compact-industrial-robots-racer-series/)
- [Comau AURA collaborative robot](https://www.comau.com/en/aura-collaborative-robotics-for-high-payload-applications/)
- [Comau Open Controller](https://www.comau.com/en/our-offer/robotics-automation/open-controller/)
- [Comau robotic control and software](https://www.comau.com/en/our-offer/products-and-solutions/robotic-control-and-software/)
- [CRCOpenROS2Driver — UKAEA GitHub](https://github.com/ukaea/CRCOpenROS2Driver)
- [Comau Wind River VxWorks (2011)](https://www.windriver.com/news/press/news-9883)
- [Comau in.Grid digital IoT platforms](https://www.comau.com/en/our-offer/products-and-solutions/digital-iot-platforms/)
- [in.Grid Robot Monitoring](https://www.comau.com/en/our-offer/products-and-solutions/digital-iot-platforms/in-grid-robot-monitoring/)
- [in.Grid Line Monitoring](https://www.comau.com/en/our-offer/products-and-solutions/digital-iot-platforms/in-grid-line-monitoring/)
- [in.Grid at IVECO (Jan 2026)](https://www.comau.com/en/2026/01/28/comaus-intelligent-in-grid-robot-monitoring-platform-accelerates-digital-transformation-at-iveco/)
- [Comau body-in-white manufacturing](https://www.comau.com/en/our-offer/systems/body-in-white-manufacturing/)
- [Comau electromobility](https://www.comau.com/en/our-offer/systems/battery-manufacturing-and-assembly/electromobility/)
- [Comau e-drives and transmission assembly](https://www.comau.com/en/competencies/electromobility/e-drives-and-transmission-assembly/)
- [Comau selected for ACC Gigafactory (Oct 2022)](https://www.comau.com/en/2022/10/10/comau-selected-to-build-battery-module-production-lines-for-acc/)
- [Comau battery innovations China (Mar 2025)](https://www.comau.com/en/2025/03/27/comau-showcased-advanced-battery-manufacturing-innovations-at-the-6th-new-energy-battery-conference-in-china/)
- [MATE-XT exoskeleton](https://www.comau.com/en/our-offer/products-and-solutions/wearable-robotics-exoskeletons/wearable-robotics-mate-xt-exoskeleton/)
- [MATE-XT GO (Feb 2026)](https://www.comau.com/en/2026/02/11/comau-expands-wearable-robotics-with-the-new-mate-xt-go-exoskeleton/)
- [MATE-XB exoskeleton](https://www.comau.com/en/our-offer/products-and-solutions/wearable-robotics-exoskeletons/mate-xb-exoskeleton/)
- [Comau wearable robotics](https://www.comau.com/en/our-offer/products-and-solutions/wearable-robotics-exoskeletons/)
- [Comau MyMR autonomous mobile robots](https://www.comau.com/en/our-offer/products-and-solutions/robot-team/autonomous-mobile-robots/)
- [Milvus Robotics and Comau partnership](https://milvusrobotics.com/blog/milvus-robotics-and-comau-forge-strategic-partnership)
- [Comau at Automatica 2025 — cobots and AMRs](https://control.com/news/comau-debuts-collaborative-robots-cobots-and-autonomous-mobile-robots-amrs-at-automatica-2025/)
- [Aptiv and Comau collaboration (May 2026)](https://www.comau.com/en/2026/05/05/aptiv-and-comau-to-co-develop-next-generation-solutions/)
- [Comau and Omron Robotics collaboration (May 2026)](https://www.comau.com/en/2026/05/11/comau-and-omron-robotics-to-collaborate-on-expanding-advanced-industrial-automation-solutions/)
- [Comau additive manufacturing partnerships (May 2025)](https://roboticsandautomationnews.com/2025/05/30/comau-to-collaborate-with-multiple-companies-to-develop-on-demand-manufacturing/91344/)
- [Comau Fincantieri MR4WELD](https://www.comau.com/en/2026/04/20/comau-to-showcase-advanced-automation-products-and-solutions-for-diversified-industries-hannover-messe-2026/)
- [Comau automotive industry](https://www.comau.com/en/industries/automotive/)
- [Comau flexible BIW for Hycan EVs](https://www.comau.com/en/about-us/success-stories/comau-enables-flexible-production-for-hycan/)
- [Comau BIW for JMC Ford](https://www.americanindustrialmagazine.com/blogs/machine-industries/comau-delivers-a-highly-flexible-assembly-solution-for-jmc-ford-s-high-end-pickup-manufacturing)
- [Comau Hannover Messe 2026](https://www.comau.com/en/2026/04/20/comau-to-showcase-advanced-automation-products-and-solutions-for-diversified-industries-hannover-messe-2026/)
- [Comau at Automate Summit China (Mar 2026)](https://www.comau.com/en/2026/03/27/comau-showcases-advanced-automation-solutions-at-the-12th-automotive-advanced-manufacturing-technology-summit/)
- [Robot maker Comau spins out from Stellantis — The Robot Report](https://www.therobotreport.com/comau-robot-maker-spins-stellantis-one-equity-partners/)
- [ROS-I Interface for COMAU Robots — ResearchGate](https://www.researchgate.net/publication/301776243_ROS-I_Interface_for_COMAU_Robots)
- [Comau Tracxn profile](https://tracxn.com/d/companies/comau/__6XoXrYGiAGD-HdPwya5g_w4hFPiOZHI2O29-6DE6_dw)
