# Rockwell Automation — Competitive Profile

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

See [deep-dive](rockwell-automation-deep-dive.md) for acquisition timeline, product architecture, and competitive analysis.

---

## At a Glance

Rockwell Automation (NYSE: ROK) is the world's largest pure-play industrial automation company (~$7B revenue, ~28,000 employees). Physical AI strategy anchored by three pillars: Emulate3D digital twins integrated with NVIDIA Omniverse for factory-scale simulation, OTTO Motors AMRs (via Clearpath Robotics acquisition, 2023) for autonomous material handling, and FactoryTalk software suite + Plex cloud MES ($2.2B acquisition) for manufacturing execution. Edge AI push via NVIDIA Nemotron Nano SLM integration into FactoryTalk Design Studio. Software & Control segment (~29% of revenue, ~$2.4B) growing 17% organically with 35% operating margins in Q2 FY2026. ARR growing 8% YoY. Expanding agentic AI via Augury partnership (Fiix MAX + Reliability Agent). Chairman/CEO: Blake Moret.

| | |
| --- | --- |
| **Type** | Big Tech |
| **Revenue / Funding** | ~$7B annual revenue; Software & Control ~$2.4B (29%, fastest-growing segment) |
| **Physical AI thesis** | Converge OT + IT via digital twins (Emulate3D/Omniverse), autonomous material handling (OTTO AMRs), cloud MES (Plex), and edge AI (Nemotron Nano) — "bringing autonomous operations to life" |
| **Platform coverage** | ~25% of blocks — Simulation, edge inference, robotics libs (AMR), fleet management, model monitoring (predictive maintenance), data (industrial IoT) |
| **Relationship to Red Hat** | Mixed — complement on edge OS/container runtime; partial overlap on industrial edge orchestration; Rockwell is AWS-aligned for cloud (FactoryTalk Hub on AWS) |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Emulate3D** | Digital twin software for factory-scale simulation and virtual commissioning. Integrates NVIDIA Omniverse APIs for OpenUSD interoperability and RTX rendering. 50% increase in project win rates for equipment builders. |
| **OTTO Motors AMRs** | Autonomous mobile robots (OTTO 600, OTTO 1200) for heavy material transport in manufacturing. 5M+ production hours. Milwaukee + Ontario production. Clearpath Robotics acquisition (2023). |
| **FactoryTalk Suite** | Industrial automation software platform: Design Studio (engineering), Optix (HMI/visualization), Analytics, Edge Gateway. NVIDIA Nemotron Nano SLM integrated for edge-based generative AI (Nov 2025). |
| **Plex** | Cloud-native MES/ERP platform. Elastic MES (Dec 2025) adds embedded AI for predictive insights. $2.2B acquisition (2021). |
| **Fiix CMMS** | Cloud-based computerized maintenance management. Fiix MAX: AI-powered maintenance assistant integrated with Augury's Reliability Agent for agentic maintenance workflows. |
| **ControlLogix / Logix** | Programmable logic controllers (PLCs) — industry-leading control platform. ControlLogix 5590 (Oct 2025) adds IEC 62443 security. |
| **Kalypso** | Professional services for industrial AI, digital transformation, and data science in manufacturing environments. |

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

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟢 Emulate3D<br><small>(NVIDIA Omniverse + OpenUSD)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 FactoryTalk DataMosaix<br><small>(industrial DataOps)</small></td>
  <td>⬜</td>
  <td>🟡 FactoryTalk Edge<br><small>(gateway, not full data platform)</small></td>
  <td>🟡 FactoryTalk Edge<br><small>(OT data collection)</small></td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡 Nemotron Nano<br><small>(edge SLM for FactoryTalk)</small></td>
</tr>

<tr>
  <td><b>Agentic Framework</b></td>
  <td>⬜</td>
  <td>🟡 Fiix MAX + Augury<br><small>(maintenance agent workflow)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Monitoring</b></td>
  <td>⬜</td>
  <td>🟢 Fiix CMMS<br><small>(predictive maintenance)</small></td>
  <td>⬜</td>
  <td>🟡 Fiix CMMS<br><small>(cloud-based, AWS)</small></td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 OTTO Motors<br><small>(AMR fleet mgmt + navigation)</small></td>
</tr>

<tr><td colspan="6"><em>(Other rows omitted — Rockwell covers simulation, data, edge inference, maintenance, AMR)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Emulate3D** | Proprietary simulation engine; NVIDIA Omniverse APIs (OpenUSD) for interoperability and rendering |
| **OTTO Motors** | Proprietary autonomy stack; Clearpath research division uses ROS 2 for academic/research robots |
| **FactoryTalk** | Proprietary; NVIDIA Nemotron Nano (open-source SLM) integrated for edge AI |
| **Plex** | Proprietary cloud MES/ERP |
| **Fiix CMMS** | Proprietary SaaS; deployed on AWS |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **NVIDIA** | Technology | Omniverse integration for Emulate3D digital twins; Nemotron Nano for edge AI; deepening across simulation + inference |
| **AWS** | Cloud | FactoryTalk Hub, DataMosaix, Fiix CMMS deployed on AWS Marketplace; joint Hannover Messe 2025 announcement |
| **Microsoft** | Cloud / AI | Azure/OpenAI for FactoryTalk copilot capabilities; reportedly cutting design cycles 40% |
| **Augury** | AI / Maintenance | Agentic AI partnership: Reliability Agent + Fiix MAX for connected maintenance workflows |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Siemens** | Largest pure-play industrial automation focus, OTTO Motors AMR hardware, stronger Americas presence, FactoryTalk installed base in discrete manufacturing | Siemens' breadth (Xcelerator, Teamcenter PLM, industrial software ecosystem), process industry depth, European manufacturing footprint |
| **ABB** | Own AMR fleet (OTTO), Emulate3D digital twin with NVIDIA Omniverse, cloud MES (Plex), stronger PLC market share in Americas | ABB's robot arm portfolio, power/electrification business, process automation depth, global services scale |
| **Dematic / TAL** | Full automation stack (PLCs → AMRs → digital twins → MES), OEM-agnostic integration capability, software ARR growth | Dematic's warehouse-specific depth, TAL's Toyota manufacturing backing, single-vertical system integration expertise |

---

## Coverage Summary

- **Strong**: Factory simulation (Emulate3D + Omniverse), autonomous material handling (OTTO AMRs), cloud MES (Plex), predictive maintenance (Fiix), industrial control (ControlLogix)
- **Absent**: Training infrastructure, model registry, inference serving (beyond edge SLM), application runtime, OS
- **Conflicts with Red Hat**: Partial — FactoryTalk Edge Gateway and industrial edge orchestration overlap with MicroShift/RHEL for Edge positioning; AWS cloud alignment vs Red Hat hybrid cloud
- **Lock-in**: AWS for cloud services (FactoryTalk Hub, Fiix); NVIDIA for simulation/AI; proprietary PLC ecosystem (Logix)

---

## Strategic Implications for Red Hat

1. **Edge OS opportunity beneath FactoryTalk**: Rockwell's edge gateway needs an OS and container runtime. RHEL for Edge / MicroShift could serve as the platform layer beneath FactoryTalk Edge deployments — especially in regulated manufacturing (IEC 62443 alignment with RHEL's security certifications).

2. **NVIDIA alignment creates bridge**: Rockwell's deep NVIDIA integration (Omniverse, Nemotron) mirrors Red Hat's NVIDIA partnership. Joint positioning for AI-at-the-factory-edge is possible — Red Hat provides the platform, Rockwell provides the OT application layer, NVIDIA provides the AI runtime.

3. **AWS cloud dependency is a friction point**: FactoryTalk Hub, Plex, and Fiix are AWS-aligned. Red Hat's hybrid/multi-cloud positioning could be complementary for customers wanting on-premise or hybrid deployments — but Rockwell's cloud strategy currently flows through AWS, not OpenShift.

4. **Clearpath/OTTO ROS 2 connection**: Clearpath's research division is a major ROS 2 contributor. While OTTO's industrial AMRs use a proprietary stack, the Clearpath research side provides a bridge to the open robotics ecosystem — monitor for potential convergence.

5. **Agentic AI in manufacturing**: Fiix MAX + Augury partnership signals enterprise demand for agentic AI workflows on the factory floor. Red Hat's agentic framework positioning (Kagenti) could complement or compete depending on how the middleware layer evolves.

---

## Sources

- [Rockwell + NVIDIA Omniverse integration](https://www.rockwellautomation.com/en-us/company/news/press-releases/Rockwell-Automation-Brings-Autonomous-Operations-to-Life-Using-NVIDIA-Omniverse.html)
- [NVIDIA case study — Rockwell Emulate3D](https://www.nvidia.com/en-us/case-studies/rockwell-automation/)
- [Rockwell + NVIDIA manufacturing AI expansion](https://www.rockwellautomation.com/en-us/company/news/press-releases/Rockwell-Automation-to-Increase-Scale-and-Scope-of-AI-in-Manufacturing-with-NVIDIA.html)
- [Clearpath/OTTO acquisition complete](https://www.rockwellautomation.com/en-us/company/news/press-releases/Rockwell-Automation-completes-acquisition-of-autonomous-robotics-leader-Clearpath-Robotics-and-its-industrial-offering-OTTO-Motors.html)
- [First OTTO AMRs from Milwaukee HQ](https://www.rockwellautomation.com/en-us/company/news/press-releases/First-Autonomous-Mobile-Robots-Roll-Off-the-Line-at-Rockwell-Automations-Milwaukee-Headquarters.html)
- [Nemotron Nano edge AI](https://www.rockwellautomation.com/en-us/company/news/press-releases/rockwell-automation-to-advance-industrial-intelligence-through-e.html)
- [Augury agentic AI partnership](https://www.rockwellautomation.com/en-us/company/news/press-releases/rockwell-automation-and-augury-partner-to-improve-industrial-performance-with-agentic-ai.html)
- [Rockwell + AWS Hannover Messe 2025](https://www.businesswire.com/news/home/20250402085559/en/Rockwell-Automation-and-AWS-Collaborate-to-Transform-Manufacturing-Through-Advanced-Industrial-Automation-Solutions-at-Hannover-Messe-2025)
- [Plex acquisition — $2.2B](https://www.rockwellautomation.com/en-us/company/news/press-releases/Rockwell-Automation-Completes-Acquisition-of-Plex-Systems.html)
- [Rockwell financials overview](https://www.useluminix.com/reports/company-overviews/rockwell-automation-company-overview)
