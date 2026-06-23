# Figure AI — Competitive Profile

**Date**: 2026-06-23
**Last updated**: 2026-06-23
**Classification**: Internal analysis — not for public repo

See [deep-dive](figure-ai-deep-dive.md) for technology architecture, manufacturing details, and competitive analysis.
See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

---

## At a Glance

Figure AI is a venture-backed humanoid robotics startup building general-purpose humanoid robots (Figure 02/03) powered by a proprietary vision-language-action model (Helix). Founded in 2022 by serial entrepreneur Brett Adcock, the company has raised $1.9B+ at a $39B valuation. Its Physical AI thesis is **"own the full stack from hardware to AI to manufacturing"** — a vertically integrated approach spanning robot design, the Helix VLA, and a dedicated manufacturing facility (BotQ, 12K units/year capacity). Figure ended its OpenAI partnership in February 2025 to build fully in-house AI. BMW is the primary deployment customer (30,000+ vehicles, 40 Figure 03 units deployed), with logistics expansion (reportedly UPS) underway. Figure 03 targets a $20K consumer price point by leveraging BotQ manufacturing scale.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | $1.9B+ raised, $39B valuation (Sep 2025). First revenue Dec 2024. Revenue negligible vs valuation |
| **Physical AI thesis** | Full vertical integration: robot hardware + Helix VLA + BotQ manufacturing. Own the stack, don't depend on vendors |
| **Platform coverage** | ~10% of blocks — concentrated in edge inference (Helix) and robotics application layer |
| **Relationship to Red Hat** | Potential customer — needs edge OS, fleet management, simulation infrastructure as it scales beyond vertical integration |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Figure 03** | General-purpose humanoid: 168 cm, 60 kg, 44 DOF, 16-DOF hands with tactile sensing, 5-hr battery with wireless charging, dual embedded GPUs. $20K target consumer price. TIME Best Invention 2025 |
| **Figure 02** | Industrial humanoid predecessor: 35 DOF, 25 kg payload, deployed at BMW Spartanburg for 11 months. Being replaced by Figure 03 |
| **Helix 02** | Proprietary VLA model — full-body autonomy. System 2 (7B VLA, 7-10 Hz reasoning) + System 1 (200 Hz reactive control) + System 0 (1 kHz balance/contact physics). Runs entirely onboard |
| **BotQ** | Dedicated humanoid manufacturing facility in San Jose, CA. 12K units/year capacity, producing 1 robot every 90 minutes (April 2026). In-house MES with full traceability |

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

<!-- === Training & Evaluation === -->

<tr>
  <td><b>Train Workloads</b></td>
  <td>⬜</td>
  <td>🟢 Helix VLA training<sup>1</sup><br>
  <small>(proprietary, in-house)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 NVIDIA ecosystem<sup>2</sup><br>
  <small>(Cosmos for synthetic data)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>⬜</td>
  <td>🟡 Internal eval<br>
  <small>(BMW deployment metrics)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Proprietary<sup>3</sup><br>
  <small>(1,000+ hrs human motion, BMW telemetry)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">🟡 NVIDIA GPUs<br>
  <small>(likely cloud-based)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === AI Model & Data Lifecycle === -->

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
  <td><b>CI/CD &amp; GitOps</b></td>
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

<!-- === Agentic === -->

<tr>
  <td><b>Agentic</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟢 Helix multi-robot<sup>4</sup><br>
  <small>(dual-robot collaboration)</small></td>
</tr>

<!-- === Model Serving === -->

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
  <td>🟢 Helix onboard<sup>5</sup><br>
  <small>(dual GPU, fully onboard)</small></td>
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

<!-- === Application Libraries === -->

<tr>
  <td><b>App Libs (Math/AI)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟣 NVIDIA CUDA<br>
  <small>(dual embedded GPUs)</small></td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 Proprietary vision<br>
  <small>(6 cameras, palm cams, tactile)</small></td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 Proprietary stack<sup>6</sup><br>
  <small>(end-to-end neural, no ROS)</small></td>
</tr>

<!-- === Platform === -->

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜<br>
  <small>(likely custom container/bare-metal)</small></td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟣 NVIDIA GPU drivers</td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 Ubuntu Linux<sup>7</sup></td>
</tr>
</table>

### OSS Foundations

| # | Product | OSS Foundation |
| --- | --- | --- |
| 1 | **Helix VLA** | Proprietary end-to-end neural network. S0 trained on 1,000+ hrs human motion data. No public OSS dependencies disclosed |
| 2 | **Simulation** | Uses NVIDIA Cosmos for synthetic data generation; NVIDIA Isaac ecosystem for simulation |
| 3 | **Training data** | Proprietary datasets from BMW deployment telemetry and in-house data collection |
| 4 | **Multi-robot** | Helix operates two robots simultaneously from single VLA — proprietary coordination |
| 5 | **Edge inference** | Runs onboard dual embedded GPUs. Fully self-contained — no cloud dependency for inference |
| 6 | **Robotics stack** | End-to-end neural control replaces traditional robotics stack (100K+ lines of C++ replaced by System 0 learned model) |
| 7 | **OS** | Ubuntu Linux on dual embedded GPUs |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **BMW** | Manufacturing customer | Primary deployment: 11 months at Spartanburg, 30K+ vehicles, 90K+ parts, >99% accuracy. 40 Figure 03 units deployed. Expanding to Leipzig (Germany) summer 2026 |
| **UPS** | Logistics customer (reported) | Second major customer — logistics/package handling |
| **NVIDIA** | Technology / Investor | Cosmos for synthetic data; GR00T ecosystem. NVIDIA is Series C investor |
| **Microsoft** | Investor | Series B investor. No disclosed technology integration |
| **Intel Capital** | Investor | Series C investor |
| **Qualcomm Ventures** | Investor | Series C investor |
| **OpenAI** | Former partner | Collaboration ended Feb 2025; Figure built Helix fully in-house |
| **Brookfield** | Investor | Series C lead ($250M+) |
| **Jeff Bezos** | Investor | Personal investment in Series B |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Tesla Optimus** | Faster iteration (3 robot generations in 3 years); dedicated robotics focus; BMW production deployment proof point | Tesla's manufacturing scale, vertically integrated supply chain, Dojo training compute, and automotive sensor/actuator expertise |
| **Agility (Digit)** | Hands with 16-DOF tactile sensing (vs Digit's simpler grippers); full-body VLA (Helix 02); home-ready design (Figure 03) | Agility's fleet orchestration platform (Arc); prior Amazon deployment experience; purpose-built warehouse form factor |
| **Boston Dynamics (Atlas)** | Lower price target ($20K vs Atlas not commercially priced for mass market); VLA-based learning vs Atlas's model-predictive control | Boston Dynamics' 30+ years of locomotion R&D; Hyundai manufacturing backing; proven extreme-environment reliability |
| **1X (NEO)** | More advanced dexterous manipulation (16-DOF hands, palm cameras, tactile sensing); larger funding ($1.9B vs $400M+) | 1X's simpler, cheaper design philosophy; focus on practical task completion over hardware sophistication |

---

## Coverage Summary

- **Strong**: Edge inference (Helix onboard), Dexterous manipulation (16-DOF hands + tactile), Manufacturing proof (BMW 30K+ vehicles), VLA model (System 0/1/2 architecture)
- **Absent**: Simulation engine, Model registry, Pipelines, CI/CD, GitOps, Experiment tracking, Model monitoring, MaaS, KServe, llm-d, Container platform, Fleet management (at scale)
- **Conflicts with Red Hat**: None — Figure is a potential customer, not a platform competitor
- **Lock-in**: Fully vertically integrated (hardware + AI + manufacturing); NVIDIA GPU dependency at edge; proprietary Helix model not available to third parties

---

## Strategic Implications for Red Hat

1. **Customer archetype for Physical AI platform**: Figure represents the class of humanoid robotics companies that will need platform services as they scale beyond 100-1000 units. Today they build everything in-house, but fleet management, OTA updates, model versioning, and compliance tooling don't scale with vertical integration. Red Hat's edge platform (RHEL Device Edge + MicroShift) is the natural fit as these companies outgrow custom solutions.

2. **Ubuntu is the current edge OS — a displacement opportunity**: Figure 03 runs Ubuntu Linux on its dual embedded GPUs. As Figure scales toward 100K units with enterprise customers (BMW, UPS), the need for a commercially supported, security-hardened, fleet-managed OS increases. RHEL Device Edge offers image-based updates, FIPS compliance, and long-term support that Ubuntu IoT does not match at enterprise scale.

3. **NVIDIA dependency creates platform leverage**: Figure depends on NVIDIA GPUs for edge inference and NVIDIA Cosmos/Isaac for simulation/training. Red Hat's position as the neutral platform layer (OpenShift for training, RHEL for edge) allows it to serve Figure without competing with NVIDIA — the same complementary dynamic as with other NVIDIA-dependent robotics companies.

4. **Fleet management gap will emerge at scale**: BotQ targets 12K units/year, scaling to 100K over 4 years. Managing software updates, model deployments, and compliance across a fleet of this size requires purpose-built fleet management (like FlightCtl). Figure has no disclosed fleet orchestration — unlike Agility, which built Arc for this purpose.

5. **Monitor the vertical integration thesis**: Figure's "own the full stack" strategy works at startup scale but creates scaling bottlenecks. Watch for signs of unbundling — if Figure opens its hardware to third-party models, or its models to third-party hardware, the platform opportunity expands significantly. The $20K consumer price point will force supply chain partnerships that break the vertical integration.
