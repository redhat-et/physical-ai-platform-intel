# Vanderlande — Competitive Profile

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

See [deep-dive](vanderlande-deep-dive.md) for corporate timeline, product architecture, and partnership details.

---

## At a Glance

Vanderlande is a Netherlands-based logistics automation system integrator, wholly owned by Toyota Industries Corporation since 2017 (acquired for €1.16B). Market-leading in warehouse, airport baggage, and parcel sorting automation. Revenue €2.3B (FY2025), ~12,000 employees. As of April 2026, warehouse business reorganized under Toyota Automated Logistics (TAL) alongside Bastian Solutions and viastore; Vanderlande continues independently in airport and parcel segments. Acquired Siemens Logistics (non-US operations, €300M, May 2025), adding 2,000+ employees and expanding airport/parcel portfolio. Physical AI relevance centers on autonomous vehicles (FLEET for airports, Pallet AV for warehouses), robotic picking (Smart Item Robotics), AI-driven predictive maintenance (84% failure reduction), and the VISION WMS/WCS platform.

| | |
| --- | --- |
| **Type** | Big Tech (subsidiary of Toyota Industries, ¥2.4T revenue parent) |
| **Revenue / Funding** | €2.3B revenue (FY2025); order book €4.3B |
| **Physical AI thesis** | Integrated automation systems — from conveyors and AS/RS to autonomous vehicles and robotic picking — orchestrated by VISION software with AI-driven predictive maintenance. "The future of logistics revolves around autonomy and flexibility." |
| **Platform coverage** | ~15% of blocks — Simulation (system design), Inference Server (edge AI for predictive maintenance), App Libs Robotics (AGV/AMR control), Agentic Framework (VISION orchestration) |
| **Relationship to Red Hat** | Mixed — large enterprise customer potential (VISION runs on cloud infrastructure); partial overlap in fleet orchestration; Red Hat platform could underpin VISION deployments |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **VISION** | WMS + WCS platform: orchestrates equipment, robotics, people, and processes across warehouse operations. Cloud-based, modular, industry-specific packages (food, fashion, general merchandise). |
| **FLEET** | Autonomous baggage logistics for airports — intelligent AGVs transport individual bags via real-time route optimization, replacing fixed conveyors. Deployed at Rotterdam The Hague Airport. |
| **Pallet AV** | Autonomous vehicles for warehouse pallet transport — automated forklifts + AMRs using Toyota Material Handling hardware with Kollmorgen AGV software. |
| **Smart Item Robotics (SIR)** | Self-learning robotic picking portfolio — intelligent gripper technology, vision systems, and control software for piece-level picking. |
| **STOREPICK** | Modular robotic system for retail replenishment — integrates AS/RS with goods-to-person workstations. |
| **FASTPICK** | High-speed fulfillment system optimized for e-commerce peak demand. |
| **SPOX / PARCELTRAX** | Parcel sorting solutions — cross-belt and tilt-tray sorters with predictive maintenance integration. |
| **AI Predictive Maintenance** | GenAI-powered maintenance — links sensor anomalies in shuttle behavior to maintenance history and manuals. 84% failure reduction. |

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
  <td>🟡 System Design Tools<br><small>(warehouse layout simulation, not general physics sim)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Monitoring</b></td>
  <td colspan="2">🟢 Predictive Maintenance<br><small>(GenAI anomaly detection, 84% failure reduction)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Agentic Framework</b></td>
  <td>⬜</td>
  <td>🟡 VISION AI Assistant<br><small>(operator decision support, not general agent framework)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡 SIR / AGV inference<br><small>(on-device ML for picking and navigation)</small></td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 FLEET / Pallet AV<br><small>(AGV/AMR fleet control + route optimization)</small></td>
</tr>

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">🟡 VISION<br><small>(cloud-based WMS/WCS, proprietary runtime)</small></td>
  <td colspan="2">🟡 VISION<br><small>(multi-site deployment)</small></td>
  <td>⬜</td>
</tr>

<tr><td colspan="6"><em>(Other rows omitted — Vanderlande is a system integrator, not a platform vendor)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **VISION** | Proprietary WMS/WCS. Cloud-based deployment (provider not disclosed). No OSS components identified. |
| **FLEET** | Proprietary AGV system built in-house at Veghel. Real-time route optimization algorithms proprietary. |
| **Pallet AV** | Toyota Material Handling hardware + Kollmorgen AGV software (proprietary). |
| **Smart Item Robotics** | Proprietary vision + gripper + control software. ML framework not disclosed. |
| **AI Predictive Maintenance** | Uses GenAI (vendor/model not disclosed) for anomaly-to-maintenance linking. |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **Toyota Industries Corp** | Parent company | 100% owner since 2017. Access to Toyota Material Handling forklift hardware, Toyota Automated Logistics group. |
| **Siemens Logistics** | Acquired (2025) | €300M acquisition of non-US operations; 2,000+ employees; airport baggage + parcel sorting portfolio. |
| **Bastian Solutions** | TAL sibling | U.S. warehouse automation; merged with Vanderlande US warehouse business under TAL (Apr 2026). |
| **viastore** | TAL sibling | European warehouse automation; merged under TAL (Apr 2026). |
| **Kollmorgen** | AGV technology | Provides AGV hardware/software for Vanderlande's automated forklift solution. |
| **Hai Robotics** | AMR partner | Automated Case-Handling Robot (ACR) integrated into Vanderlande warehouse solutions. |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Dematic (KION)** | Toyota parent backing (forklift + AGV hardware), airport segment dominance (600+ airports), Siemens Logistics acquisition expanding airport/parcel reach | Dematic's larger warehouse automation revenue, KION's broader forklift/industrial truck portfolio, Dematic's stronger software/simulation platform |
| **KUKA (Midea)** | End-to-end system integration (design through lifecycle services), stronger AGV/AMR portfolio via Toyota/Kollmorgen, airport/parcel specialization | KUKA's industrial robot arms, broader manufacturing automation beyond logistics, stronger presence in automotive assembly |
| **Swisslog (KUKA/Midea)** | Broader solution portfolio (airport + parcel + warehouse), Toyota parent integration depth, FLEET autonomous innovation | Swisslog's healthcare logistics specialization, SynQ warehouse software maturity |

---

## Coverage Summary

- **Strong**: System integration (design-to-lifecycle), airport baggage handling (600+ airports), warehouse automation (STOREPICK, FASTPICK), AGV/AMR fleet (FLEET, Pallet AV), AI predictive maintenance
- **Absent**: Training infrastructure, model registry, foundation models, general-purpose inference serving, OS, drivers
- **Conflicts with Red Hat**: Partial — VISION cloud platform could overlap with OpenShift-based warehouse management deployments; GenAI assistant overlaps with agentic framework concepts
- **Lock-in**: Toyota Industries ecosystem (hardware + software tightly coupled); VISION proprietary WMS/WCS; Kollmorgen AGV dependency

---

## Strategic Implications for Red Hat

1. **Large enterprise infrastructure consumer**: VISION is cloud-based and deploys across multiple sites — Vanderlande/TAL needs enterprise container platforms, multi-site orchestration, and edge infrastructure. Red Hat OpenShift + ACM is a natural fit for VISION's multi-warehouse deployment model.

2. **Toyota Automated Logistics consolidation creates opportunity**: The TAL reorganization (Bastian + Vanderlande warehouse + viastore) needs unified infrastructure across three previously separate technology stacks. Platform standardization on RHEL/OpenShift could underpin this consolidation.

3. **Edge AI for predictive maintenance**: GenAI-powered predictive maintenance (84% failure reduction) runs close to warehouse equipment. As this capability scales across TAL's customer base, edge inference infrastructure becomes critical — MicroShift or RHEL AI at the Edge could serve this.

4. **AGV/AMR fleet management convergence**: FLEET and Pallet AV autonomous vehicles need edge compute, fleet orchestration, and OTA updates — similar patterns to automotive/robotics edge deployments where Red Hat has reference architectures.

5. **Monitor TAL platform decisions**: The April 2026 TAL formation is an inflection point for infrastructure choices. If TAL standardizes on a cloud/edge platform, early engagement matters. Competitor risk: Toyota's existing relationship with AWS and Google Cloud.

---

## Sources

- [Vanderlande company profile](https://www.vanderlande.com/about-vanderlande/company-profile/)
- [Vanderlande warehousing](https://www.vanderlande.com/warehousing/)
- [VISION software platform](https://www.vanderlande.com/software/vision/)
- [Smart Item Robotics](https://www.vanderlande.com/systems/picking/smart-item-robotics/)
- [FLEET autonomous baggage handling](https://www.airport-technology.com/features/autonomous-baggage-handling-vehicles/)
- [Toyota Industries reorganization (Nov 2025)](https://www.toyota-industries.com/news/2025/11/11/008891/index.html)
- [Vanderlande AI predictive maintenance](https://www.vanderlande.com/news-insights/delivering-insights-ai-driven-predictive-maintenance/)
- [ProMat 2025 showcase — Robotics 24/7](https://www.robotics247.com/article/promat_2025_vanderlande_to_showcase_how_to_automate_your_warehouse_success)
- [Vanderlande + Kollmorgen autonomous forklifts](https://www.robotics247.com/article/vanderlande_kollmorgen_partner_provide_service_autonomous_forklifts/AGV)
- [From human to machine: logistics becomes autonomous](https://ioplus.nl/en/posts/from-human-to-machine-logistics-becomes-autonomous)
