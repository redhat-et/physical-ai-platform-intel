# SteerAI — Competitive Profile

**Date**: 2026-09-21
**Last updated**: 2026-09-21
**Classification**: Internal analysis — not for public repo

See [deep-dive](steerai-deep-dive.md) for corporate timeline, product architecture, and partnership details.

---

## At a Glance

SteerAI is a UAE sovereign technology venture launched by VentureOne (commercialization arm of Abu Dhabi's Advanced Technology Research Council) to bring Technology Innovation Institute (TII) autonomous driving research to market. Focus: converting existing military and industrial vehicle fleets to autonomous operation in off-road, unmapped, GNSS-denied environments (deserts, rocky terrain). Two products — CoreX (vehicle autonomy kit) and CoreConnect (fleet management) — plus xRift, a purpose-built autonomous ATV. Active deployments: 20 THeMIS UGVs with Milrem Robotics for UAE Land Forces, autonomous logistics platform with EDGE Group. ~37 employees (Jul 2026). Acting CEO Michael Sonderby (ex-BCG Digital Ventures, former Danish military officer).

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | Sovereign-backed (ATRC/VentureOne); no disclosed external funding rounds |
| **Physical AI thesis** | Vehicle-agnostic autonomy retrofit for off-road defense and industrial fleets; sovereign UAE technology derived from TII research |
| **Platform coverage** | ~10% of blocks — Edge AI inference, fleet management |
| **Relationship to Red Hat** | Complement — vertical application layer; potential edge platform consumer |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **CoreX** | Vehicle-agnostic autonomous driving kit: perception (cameras + LiDAR), localization, planning, and decision-making for off-road, GNSS-denied environments. Retrofits existing vehicle fleets. |
| **CoreConnect** | Platform-agnostic fleet management system: mission planning, deployment, real-time monitoring across ground, aerial, and marine autonomous platforms. |
| **xRift** | Purpose-built driverless ATV: 225 HP, 50 km/h top speed, 500 kg payload capacity, 1,350 kg weight. Modular utility deck for defense and emergency response payloads. |

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
  <td><b>Models & Policies</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟢 CoreX<br><small>(perception + planning stack)</small></td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡 CoreX<br><small>(embedded inference, proprietary)</small></td>
</tr>

<tr>
  <td><b>Agentic Framework</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡 CoreConnect<br><small>(fleet orchestration, not general agent framework)</small></td>
</tr>

<tr><td colspan="6"><em>(Other rows omitted — SteerAI only covers edge autonomy + fleet management)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **CoreX** | Proprietary. Developed by TII; no OSS components disclosed. Sensor stack uses cameras + LiDAR (vendors not disclosed). |
| **CoreConnect** | Proprietary fleet management platform. No OSS components identified. |
| **xRift** | Hardware platform; 225 HP engine, proprietary chassis design. |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **Milrem Robotics** | Defense UGV | 20 THeMIS UGVs equipped with CoreX for UAE Land Forces trial program (signed IDEX 2025) |
| **EDGE Group** | Defense / Industrial | Autonomous Logistics Platform collaboration — CoreConnect fleet management for industrial facility logistics |
| **Micropolis** | Industrial robotics | M01/M02 heavy-duty logistics UGVs (4-5 ton payload) managed via CoreConnect |
| **Elistair** | Aerial surveillance | Tethered drone integration on xRift for surveillance, recon, and comms (Jun 2026) |
| **TII** | Technology source | Core autonomy algorithms and TACTICAai situational awareness originated from TII research |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Waymo / Wayve** | Off-road specialization (unmapped, GNSS-denied terrain), defense mandate, vehicle-agnostic retrofit model | On-road autonomy, consumer automotive scale, regulatory track record in civilian markets, large-scale public testing |
| **Milrem Robotics** | AI autonomy software (CoreX), fleet management layer (CoreConnect), broader vehicle-agnostic approach | Own vehicle manufacturing capability, THeMIS production scale, 19-country installed base, NATO integration experience |
| **Clearpath / OTTO Motors** | Defense + industrial dual-use positioning, off-road terrain capability, sovereign UAE backing | Warehouse/factory automation expertise, North American market presence, ROS 2 ecosystem integration, larger customer base |

---

## Coverage Summary

- **Strong**: Edge autonomy (CoreX perception + planning), fleet management (CoreConnect)
- **Absent**: Training infrastructure, simulation, model registry, inference serving (beyond embedded), application runtime, OS
- **Conflicts with Red Hat**: None — vertical application layer, no platform components
- **Lock-in**: Proprietary CoreX system; TII technology dependency; UAE sovereign mandate limits multi-vendor flexibility

---

## Strategic Implications for Red Hat

1. **Edge platform consumption opportunity**: CoreX runs on-vehicle inference for perception, localization, and planning — needs an edge OS, container runtime, and driver stack underneath. SteerAI has no disclosed platform layer, presenting integration opportunity for RHEL for Edge or MicroShift.

2. **Fleet orchestration convergence**: CoreConnect manages heterogeneous autonomous fleets (ground, aerial, marine). As fleet scale grows, the orchestration layer will need enterprise infrastructure — monitoring, GitOps-style deployment, multi-site management — that maps to Red Hat's distributed platform capabilities.

3. **Defense vertical entry point**: UAE sovereign mandate + EDGE Group partnership positions SteerAI in defense logistics automation. Red Hat's government/defense credentials (RHEL FIPS, security certifications) could complement SteerAI's application layer in defense supply chain contexts.

4. **Limited competitive threat**: No platform ambitions, no OSS strategy, narrow vertical focus (off-road defense/industrial). Monitor for expansion into maritime autonomy (stated future direction) which could increase platform requirements.

---

## Sources

- [SteerAI website](https://steerai.ai/)
- [SteerAI unveils xRift at UMEX 2026](https://steerai.ai/steerai-unveils-xrift-at-umex-new-autonomous-vehicle-brings-off-road-flexibility-to-the-gulf-region)
- [Milrem Robotics partners with SteerAI](https://steerai.ai/milrem-robotics-partners-with-steerai.php)
- [EDGE, TII, Micropolis, SteerAI autonomous logistics platform](https://edgegroup.ae/news/edge-tii-micropolis-and-steerai-deploy-advanced-autonomous-logistics-platform)
- [TII announces SteerAI launch](https://www.tii.ae/news/abu-dhabi-unveils-steerai-new-tech-venture-set-transform-industrial-vehicles-autonomous)
- [SteerAI xRift — NextGen Defense](https://nextgendefense.com/steerai-xrift-battlefield-autonomy/)
- [SteerAI + Elistair tethered drone partnership](https://steerai.ai/)
- [VentureOne portfolio](https://www.ventureone.ae/)
