# Acieta — Competitive Profile

**Date**: 2026-09-25
**Last updated**: 2026-09-25
**Classification**: Internal analysis — not for public repo

See [deep-dive](acieta-deep-dive.md) for corporate timeline, PE roll-up details, product architecture, and competitive analysis.

---

## At a Glance

Acieta is a PE-backed robotic automation integrator formed through a five-company roll-up by Angeles Equity Partners, with roots dating to 1983. Headquartered in Shelbyville, Indiana, with 300+ employees across five facilities in the U.S. and Mexico, Acieta has deployed 10,000+ robotic systems representing over $1B in installed automation. Core capability: turnkey robotic cells for machine tending, welding, palletizing, material handling, press brake tending, and assembly — primarily built on FANUC industrial and collaborative robots. Differentiates on a standardized product line (FastLOAD, FastARC, FastBEND, FastPACK) that delivers faster ROI for mid-market manufacturers facing labor shortages. CEO: Corwin Carson (January 2026); prior leadership: Craig Ulrich (now executive chair).

| | |
| --- | --- |
| **Type** | Machine Builder & Line Integrator (PE-backed roll-up) |
| **Revenue / Funding** | Est. $50–100M annual revenue (private; 25% YoY growth reported for 2024–2025) |
| **Physical AI thesis** | Turnkey robotic automation for manufacturers facing labor shortages — standardized robotic cells and custom systems across 11 industry verticals |
| **Platform coverage** | ~5% of blocks — App Libs (Robotics) partial via custom robotic cells |
| **Relationship to Red Hat** | Complement — SI consuming platform components; no Red Hat relationship identified |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Custom Robotic Systems** | Turnkey automation cells — design, engineering, fabrication, integration, and service for machine tending, welding, palletizing, material handling, assembly, inspection, and material removal; primarily FANUC-based |
| **FastLOAD CX Series** | Mobile collaborative robot cells (FANUC CRX-10iA/CRX-20iA) for machine tending — fenceless, 120V, 80% less floor space than traditional cells; delivery in as fast as one week |
| **FastARC Weld Cells** | Standard robotic welding cells — multi-arm FANUC configurations for 24/7 welding operations |
| **FastBEND** | Robotic press brake tending cell — integrates with new or existing press brakes; exclusive partnership with MC Machinery Systems |
| **FastPACK** | Standard palletizing robotic systems for end-of-line packaging |
| **FastFLEX** | Multi-application cobot system (FANUC CRX-30iA) — handles palletizing, machine tending, and welding on one compact footprint |
| **CX1000 Welding Cobot** | Collaborative welding system with swappable end-of-arm tooling — can be repurposed for machine tending or sanding |
| **AMR Integration** | Autonomous mobile robot deployment — integrates MiR, AutoGuide, and Seegrid AMRs with Plus One Robotics vision systems (via RōBEX legacy) |
| **AIS Lifecycle Service** | 24/7 emergency response, preventive maintenance, spare parts management, operator training, remote troubleshooting |

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
  <td><b>Train Workloads</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 3D simulation<br><small>(pre-project feasibility — vendor tool, not proprietary)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

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
  <td><b>CI/CD & GitOps</b></td>
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

<tr>
  <td><b>Agentic Framework</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Models & Policies</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

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
  <td>⬜</td>
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

<tr>
  <td><b>App Libs (Math/AI)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟡 Custom robotic cells<br><small>(FANUC industrial + CRX cobots, MiR/Seegrid AMRs, Plus One vision — integration, not middleware)</small></td>
</tr>

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
  <td>⬜</td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Custom Robotic Systems** | Integrates proprietary OEM robot controllers (FANUC, KUKA). No OSS robotics middleware disclosed. |
| **AMR Integration** | Deploys proprietary AMR platforms (MiR, AutoGuide, Seegrid) and Plus One Robotics vision. No OSS AMR stack. |
| **3D Simulation** | Vendor simulation tool used in pre-project phase — specific platform not disclosed. |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **FANUC** | Primary robot OEM | Certified Servicing and Vision Integrator — held by <2% of FANUC ASIs; Master Certified Service Engineers on staff; CRX cobots power FastLOAD/FastFLEX product lines |
| **KUKA** | Secondary robot OEM | Industrial robot integration — OEM-agnostic positioning allows KUKA deployments |
| **MiR (Mobile Industrial Robots)** | AMR distributor | Key distributor for MiR autonomous mobile robots (via RōBEX legacy) |
| **Seegrid** | AMR distributor | Vision-guided AMR integration for warehousing and logistics |
| **AutoGuide Mobile Robots** | AMR distributor | Autonomous tugger and forklift integration |
| **Plus One Robotics** | Vision systems | Advanced robotic vision for pick-and-place and AMR applications |
| **MC Machinery Systems** | Press brake OEM | Exclusive partnership for FastBEND robotic bending cell — Diamond BB Series electric press brake |
| **Angeles Equity Partners** | PE owner | Los Angeles-based PE firm; assembled five-company roll-up platform since 2022 |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **RoviSys** | Focused robotic automation expertise, standardized product line (FastLOAD, FastARC, FastBEND), mid-market accessibility, fast delivery (CX Series in one week), FANUC depth (<2% tier) | RoviSys's enterprise scale ($325M+ revenue), multi-vendor breadth (70+ platforms), process automation, MES/SCADA, building management, Industrial AI practice |
| **JR Automation (Hitachi)** | Comparable turnkey robotic system depth, standardized cobot products, PE-backed growth investment, mid-market labor-shortage focus | JR Automation's scale (~$600M+), automotive/aerospace specialization, Hitachi Lumada IoT platform, digital twin capability, global footprint (27 facilities) |
| **FANUC direct (CRX cobots)** | Custom engineering and integration services, multi-application cells, lifecycle support, project management — value-add beyond bare robot | FANUC's direct product pipeline, global manufacturing scale, controller and software IP |

---

## Coverage Summary

- **Strong**: Turnkey robotic cells (machine tending, welding, palletizing, press brake tending), standardized cobot products (FastLOAD, FastARC, FastBEND, FastPACK), FANUC integration depth, AMR deployment, 24/7 lifecycle service
- **Absent**: Training infrastructure, model serving, inference runtime, foundation models, model registry, OS, drivers, container platform, CI/CD, MES/SCADA, process automation, Industrial AI, simulation (uses vendor tools in pre-project only)
- **Conflicts with Red Hat**: None — system integrator with no platform components
- **Lock-in**: FANUC-aligned — while claiming OEM-agnostic positioning, primary certification and product line (FastLOAD, FastFLEX, FastARC) are FANUC-specific

---

## Strategic Implications for Red Hat

1. **Mid-market SI channel for edge infrastructure**: Acieta deploys robotic automation into mid-market manufacturers across 11 verticals — exactly the segment where labor shortages drive automation adoption. These deployments create demand for edge compute, device management, and fleet operations infrastructure that Red Hat provides through RHEL for Edge and MicroShift.

2. **PE-backed growth trajectory creates expanding footprint**: Angeles Equity Partners is investing in Acieta as a national-scale robotics integration platform — 25% YoY revenue growth, five acquisitions in two years, unified brand in 2026. A relationship now could scale with the platform as Angeles continues to acquire and consolidate regional integrators.

3. **Standardized product line as deployment vehicle**: Unlike pure-custom SIs, Acieta's FastLOAD/FastARC/FastBEND/FastPACK product line creates repeatable deployment patterns. If Red Hat edge components were embedded in these standard products, each sale would propagate the platform without per-engagement sales effort.

4. **FANUC alignment limits but does not block**: Acieta's deep FANUC certification creates a single-OEM bias at the robot layer, but the infrastructure layer (compute, OS, networking) remains open. FANUC controllers are proprietary, but the surrounding edge compute, data collection, and fleet management stack is not prescribed — a gap Red Hat can fill.

5. **No existing Red Hat or OSS connection**: No Red Hat partnership, OSS contribution, or open-source tooling adoption was identified. Acieta operates entirely on proprietary vendor platforms (FANUC, MiR, Seegrid, Plus One). This is a greenfield opportunity — but also means no existing champions or integration points.

---

## Sources

- [Acieta — about page](https://acieta.com/about)
- [Acieta — our story](https://www.acieta.com/about-us/)
- [Acieta rebrand press release (June 2026)](https://www.prnewswire.com/news-releases/acieta-unveils-new-brand-identity-as-a-complete-factory-automation-partner-302805663.html)
- [Angeles Equity acquires Acieta from Mitsui (January 2024)](https://peprofessional.com/2024/01/fourth-strategic-transaction-extends-capabilities-and-broadens-end-markets/)
- [Acieta acquires Capital Industries (July 2024)](https://www.businesswire.com/news/home/20240730249003/en/Angeles-Equity-Partners-Portfolio-Company-Acieta-Acquires-Capital-Industries)
- [Corwin Carson appointed CEO (January 2026)](https://www.businesswire.com/news/home/20260120926073/en/Angeles-Equity-Partners-Appoints-Corwin-Carson-as-CEO-of-Acieta)
- [Acieta FANUC Certified Servicing and Vision Integrator](https://www.fanucamerica.com/integrators/robotics)
- [Acieta RIA Certified Robot Integrator recertification](https://www.automate.org/robotics/news/acieta-achieves-robot-integrator-recertification)
- [MC Machinery FastBEND partnership (October 2024)](https://www.businesswire.com/news/home/20241015872704/en/MC-Machinery-Systems-Partners-with-Acieta-to-Offer-the-FastBEND-Robotic-Bending-Cell)
- [Acieta FastLOAD CX Series](https://www.acieta.com/cxseries/)
- [Acieta standard solutions](https://www.acieta.com/standard-solutions/)
- [Acieta PMMI ProSource profile](https://www.prosource.org/company/acieta)
