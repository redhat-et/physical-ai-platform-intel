# Staer AI — Competitive Profile

**Date**: 2026-09-21
**Last updated**: 2026-09-21
**Classification**: Internal analysis — not for public repo

See [deep-dive](staer-ai-deep-dive.md) for founding team background, product architecture, and competitive analysis.

---

## At a Glance

Staer AI is a Malmö-based startup building the spatial intelligence layer for autonomous mobile robot (AMR) fleets in warehouse and logistics environments. Founded by serial entrepreneur Jan Erik Solem (previous exits: Polar Rose → Apple 2010, Mapillary → Meta 2020) with five co-founders from the Mapillary team, bringing 15+ years of computer vision and large-scale visual mapping experience. Core product: a live 3D map built from cameras on existing forklifts — no new infrastructure required — that provides observability, item tracking, inventory, and vendor-agnostic robot orchestration. Accepted into Google DeepMind Accelerator for Robotics and Physical AI. €7.6M raised across two rounds (2025–2026). 13 employees. Multiple commercial pilots in e-commerce, logistics, retail, and OEM.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | €7.6M across pre-seed + follow-on (Pale Blue Dot, LDV Capital); pre-revenue, signing commercial pilots |
| **Physical AI thesis** | Spatial intelligence is the missing infrastructure layer — a shared live 3D map lets any robot from any vendor navigate, and gives operators real-time observability over fleets, inventory, and space |
| **Platform coverage** | ~10% of blocks — Robot middleware (fleet orchestration), Digital Twin Runtime (live 3D spatial map) |
| **Relationship to Red Hat** | Complement — spatial intelligence layer sits above platform; potential edge deployment consumer |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Staer Platform** | Spatial intelligence infrastructure: live 3D map from forklift cameras, multi-vendor robot orchestration, item/pallet tracking, inventory reconciliation, fleet analytics, incident geofencing, simulation. EU-hosted cloud, ISO 27001 certified. |

Platform modules:

| Module | Function |
| --- | --- |
| **Fleet Activity** | Route visualization, dwell/idle analysis, replay, heatmaps |
| **Item Tracking** | Pallet-level location via label reading |
| **Inventory** | Live shelf/rack occupancy reconciled against WMS/ERP records |
| **Trailer Analytics** | Dock-door throughput, trailer fill measurement |
| **Incidents** | Geofenced exclusion zones and speed limits on live map |
| **Space Explorer** | Interactive 3D walkthrough across space and time |
| **Robot Orchestration** | Vendor-agnostic AMR navigation on shared map |
| **Simulation** | Test layout changes, automation cells, staffing plans against historical flows |

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
  <td>🟡 Staer Simulation<br><small>(layout/staffing simulation on historical data, not physics sim)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Staer Platform<br><small>(spatial data from fleet cameras)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟡 Robot Orchestration<br><small>(vendor-agnostic fleet coordination)</small></td>
</tr>

<tr><td colspan="6"><em>(Other rows omitted — Staer covers spatial data, simulation, and robot orchestration)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Staer Platform** | Proprietary. Open dataset on Hugging Face (`staerrobotics/warehouses`) suggests PyTorch ecosystem. No disclosed OSS dependencies. |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **6 River Systems / Locus Robotics** | Vendor-agnostic (works with any robot), spatial intelligence layer (live 3D map), no hardware dependency, camera-only sensing (no infrastructure install) | Own robot hardware, established warehouse deployments at scale, proven revenue model, larger teams |
| **Foxglove / Rerun** | Live operational 3D map (not just dev-time visualization), fleet orchestration built-in, warehouse domain specialization | Developer tool ecosystem, broad robotics community adoption, open-source engagement, multi-domain applicability |
| **Nav2 / ROS 2 navigation** | Unified multi-vendor map (shared spatial context across fleet), higher-level orchestration (not just single-robot nav), no ROS dependency | Open-source community, broad hardware/simulator integrations, academic research pipeline, free to use |

---

## Coverage Summary

- **Strong**: Spatial intelligence (live 3D mapping from cameras), multi-vendor fleet orchestration, warehouse analytics
- **Absent**: Training infrastructure, model serving, inference runtime, application runtime, OS, drivers
- **Conflicts with Red Hat**: None — application-layer spatial intelligence, no platform components
- **Lock-in**: Cloud service dependency (EU-hosted), proprietary spatial intelligence models

---

## Strategic Implications for Red Hat

1. **Spatial intelligence as platform building block**: Staer's live 3D map is the kind of "digital twin runtime" that warehouse/logistics Physical AI deployments need. If spatial intelligence becomes a standard layer, Red Hat should track whether it integrates with or competes against ROS 2 navigation and fleet management standards.

2. **Edge deployment opportunity**: Currently EU-hosted cloud. As customers demand on-premise processing for latency and data sovereignty, Staer will need edge infrastructure — potential fit for MicroShift or RHEL for Edge at warehouse sites.

3. **Vendor-agnostic philosophy alignment**: Staer's explicit multi-vendor, sensor-agnostic, robot-agnostic approach mirrors Red Hat's platform philosophy. Stronger alignment signal than single-vendor robotics stacks.

4. **Google DeepMind accelerator connection**: Acceptance into DeepMind's robotics accelerator suggests potential Google Cloud dependency. Monitor whether Staer remains cloud-agnostic or gravitates toward GCP.

5. **Repeat founders, early stage**: Solem's track record (two exits to Apple and Meta) de-risks execution. At €7.6M and 13 people, still early enough for partnership conversations before they lock into infrastructure choices.

---

## Sources

- [Staer website](https://staer.ai/)
- [Staer product page](https://staer.ai/product/)
- [Staer pre-seed funding — StartupMafia](https://startupmafia.eu/malmo-based-robotics-startup-staer-raised-e3-5m-pre-seed-for-ai-driven-autonomous-robot-fleets)
- [LDV Capital partnership with Staer](https://www.ldv.co/blog/2026/7/2/partnering-with-staer-to-deliver-spatial-intelligence-and-physical-ai-for-autonomous-mobile-robotics)
- [Pale Blue Dot spatial intelligence thesis](https://palebluedotvc.substack.com/p/why-spatial-intelligence-will-power)
- [Staer on Hugging Face](https://huggingface.co/staerrobotics)
