# Waymo — Competitive Profile

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

See [deep-dive](waymo-deep-dive.md) for corporate timeline, EMMA architecture, simulation research, and partnership details.

---

## At a Glance

Waymo is Alphabet's autonomous driving subsidiary and the only company operating a commercial fully driverless ride-hailing service at scale in the US. Raised $16B Series D (Feb 2026) at $126B valuation — Alphabet contributed ~$13B as anchor investor, with Sequoia, DST Global, and Dragoneer. ~500K paid rides/week (Mar 2026), targeting 1M/week by end-2026 across 20+ US cities. ~$355M annualized revenue (Feb 2026), projected to reach $1B by year-end. 6th-generation Waymo Driver reduces sensor count 42% (13 cameras, 4 LiDARs, 6 radars) at <$20K per unit. Fleet ~4,000 vehicles across 14 US cities, with London and Tokyo as first international markets. ~3,000–4,500 employees. EMMA (End-to-end Multimodal Model for Autonomous Driving) built on Gemini demonstrates state-of-the-art motion planning. Open contributions: Waymo Open Dataset, Waymax JAX-based simulator, annual research challenges. CEO: Dmitri Dolgov.

| | |
| --- | --- |
| **Type** | Big Tech (Alphabet subsidiary) |
| **Revenue / Funding** | $16B Series D at $126B valuation; ~$355M annualized revenue (Feb 2026) |
| **Physical AI thesis** | Full-stack autonomous driving — custom sensor suite, multi-modal foundation models (EMMA/Gemini), massive simulation, end-to-end from R&D through commercial ride-hailing operations |
| **Platform coverage** | ~25% of blocks — Models & Policies, Data, Simulation, Inference (edge), App Libs (Robotics) |
| **Relationship to Red Hat** | Minimal overlap — vertically integrated, Alphabet cloud infrastructure; no disclosed platform consumption from Red Hat |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Waymo Driver (6th gen)** | Full autonomous driving system: 13 cameras (17MP custom imagers), 4 LiDARs (custom chips/optics), 6 radars, audio receivers (EARs). 42% fewer sensors than 5th gen, <$20K per unit. Runs on Zeekr "Ojai" and Hyundai IONIQ 5. |
| **Waymo One** | Commercial fully driverless ride-hailing service. 14 US cities live, expanding to 20+ by end-2026. ~500K rides/week, ~$15-17 average fare, 5.7 min average wait time. |
| **EMMA** | End-to-end Multimodal Model for Autonomous Driving, built on Gemini. Maps raw camera data to planner trajectories, 3D object detection, and road graph estimation via natural language representation. State-of-the-art on nuScenes motion planning. |
| **Waymo Open Dataset** | Large-scale AV perception and motion dataset. Annual research challenges (6 rounds through 2025). Active leaderboards for 3D detection, motion prediction, sim agents, scenario generation. |
| **Waymax** | JAX-based open-source simulator for autonomous driving research. Enables closed-loop evaluation and agent behavior research. 1,094 GitHub stars. |

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
  <td>🟢 Waymax / SurfelGAN<br><small>(JAX-based sim + neural sensor synthesis)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Waymo Open Dataset<br><small>(perception + motion, public)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Models & Policies</b></td>
  <td>⬜</td>
  <td>🟢 EMMA<br><small>(Gemini-based end-to-end driving model)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟢 Waymo Driver<br><small>(on-vehicle perception + planning)</small></td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟢 Waymo Driver<br><small>(custom silicon, on-vehicle inference)</small></td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 Waymo Driver<br><small>(perception, localization, planning stack)</small></td>
</tr>

<tr><td colspan="6"><em>(Other rows omitted — Waymo is vertically focused on autonomous driving)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Waymo Driver** | Proprietary. Custom sensors, custom silicon, proprietary perception/planning stack. Built on internal Alphabet infrastructure. |
| **EMMA** | Built on Google Gemini (proprietary). Research paper published but model not open-sourced. OpenEMMA exists as independent open reproduction. |
| **Waymax** | Open-source (Apache 2.0). JAX-based simulator for AV research. |
| **Waymo Open Dataset** | Open data (custom license). Perception + motion prediction benchmarks. |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **Alphabet** | Parent company | ~$13B of $16B Series D; provides Gemini foundation models, cloud infrastructure, TPU compute |
| **Geely / Zeekr** | Vehicle OEM | Zeekr "Ojai" purpose-built robotaxi — first 6th-gen platform. At risk due to US connected-car restrictions on Chinese vehicles. |
| **Hyundai** | Vehicle OEM | IONIQ 5 robotaxi, 50K unit order, built at Georgia Metaplant. Zero-tariff US-built alternative to Zeekr. |
| **Magna** | Manufacturing | Mesa, Arizona assembly plant — retrofits OEM vehicles with Waymo Driver. Targeting tens of thousands of units/year capacity. |
| **Uber** | Distribution | Waymo AVs available on Uber network in Austin and Atlanta |
| **Toyota** | Consumer AV | Partnership (Apr 2025) to bring Waymo Driver to personally owned vehicles — targeting Tesla's consumer self-driving market |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Tesla (FSD)** | Multi-sensor fusion (LiDAR + camera + radar), fully driverless commercial service at scale, purpose-built fleet, Alphabet/Gemini AI backing | Tesla's 6M+ vehicle data collection fleet, consumer market reach, lower per-mile cost ($0.81 vs $1.36-1.43), integrated manufacturing |
| **Cruise (GM)** | Live commercial service in 14 cities, $126B valuation, 6th-gen cost reductions, Uber distribution partnership | Cruise has rebuilt after 2023 incident but not yet relaunched commercial service at comparable scale |
| **SteerAI** | On-road urban autonomy at scale, massive dataset (200M+ autonomous miles), Gemini-powered foundation model, $16B war chest | No off-road capability, no defense applications, higher per-vehicle cost vs retrofit approach |

---

## Coverage Summary

- **Strong**: End-to-end autonomous driving (Waymo Driver), foundation models (EMMA/Gemini), simulation (Waymax/SurfelGAN), open data (Waymo Open Dataset), commercial ride-hailing (Waymo One)
- **Absent**: Training infrastructure (uses Alphabet/Google Cloud), model registry, CI/CD, application runtime, OS — fully vertically integrated on Alphabet stack
- **Conflicts with Red Hat**: Minimal — Alphabet cloud-locked, no platform exposure
- **Lock-in**: Alphabet cloud infrastructure, Google Gemini dependency, custom silicon

---

## Strategic Implications for Red Hat

1. **Benchmark for Physical AI maturity**: Waymo represents the most mature Physical AI deployment globally — 200M+ autonomous miles, 500K+ rides/week, commercial revenue. Its architecture (multi-sensor fusion → foundation model → edge inference → fleet operations) is the template other Physical AI verticals will follow.

2. **EMMA/Gemini signals end-to-end model trend**: EMMA shows multimodal foundation models (VLMs) can directly generate driving trajectories from sensor data, bypassing traditional modular pipelines. This pattern will repeat in robotics (pi0, GR00T) — Red Hat's inference serving stack (vLLM/KServe) needs to handle these large end-to-end models at the edge.

3. **Open data, closed platform**: Waymo open-sources datasets and research tools (Waymax) while keeping the production stack fully proprietary and Alphabet-locked. No platform consumption opportunity — but Waymo Open Dataset and Waymax are useful for Red Hat's own AV/robotics ecosystem validation.

4. **Toyota consumer AV partnership**: Waymo + Toyota exploring Waymo Driver in personally owned vehicles could create demand for edge platform infrastructure at automotive OEM scale — worth monitoring as a potential downstream platform opportunity through Toyota's supply chain.

5. **No direct competitive threat**: Fully vertically integrated on Alphabet infrastructure. The strategic signal is competitive intelligence on where Physical AI is heading, not a platform competition concern.

---

## Sources

- [Waymo 6th-gen Driver launch](https://waymo.com/blog/2026/02/ro-on-6th-gen-waymo-driver/)
- [6th-gen Driver announcement](https://waymo.com/blog/2024/08/meet-the-6th-generation-waymo-driver/)
- [Waymo $16B funding round](https://waymo.com/blog/2026/02/waymo-raises-usd16-billion-investment-round/)
- [EMMA research paper](https://arxiv.org/abs/2410.23262)
- [Waymo EMMA blog post](https://waymo.com/blog/2024/10/introducing-emma/)
- [Waymo Open Dataset](https://waymo.com/open/)
- [Waymax simulator — GitHub](https://github.com/waymo-research/waymo-open-dataset)
- [Dallas, Houston, San Antonio, Orlando expansion](https://waymo.com/blog/2026/02/dallas-houston-san-antonio-orlando/)
- [Hyundai IONIQ 5 partnership — CNBC](https://www.cnbc.com/2024/10/04/hyundai-waymo-strategic-partnership.html)
- [Magna IONIQ 5 upfit](https://www.telemetryagency.com/post/april-30-2026-magna-to-upfit-hyundai-ioniq-5-for-waymo)
- [Waymo fleet scaling — US manufacturing](https://waymo.com/blog/2025/05/scaling-our-fleet-through-us-manufacturing/)
- [Waymo revenue estimates — Sacra](https://sacra.com/c/waymo/)
- [Waymo targets 1M rides/week — Forbes](https://www.forbes.com/sites/alanohnsman/2025/12/10/waymo-targets-1-million-robotaxi-rides-a-week/)
