# Tesla — Competitive Profile

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

See [deep-dive](tesla-deep-dive.md) for custom silicon roadmap, FSD architecture evolution, Optimus deployment status, and Dojo timeline.

---

## At a Glance

Tesla is the most vertically integrated Physical AI company in the world — designing custom silicon (AI4/AI5/AI6), training infrastructure (Cortex supercluster), foundation models (FSD end-to-end neural net, Optimus VLA), simulation (neural world simulator), and deploying at production scale across autonomous vehicles (FSD on millions of cars, robotaxi in 6+ US cities) and humanoid robots (Optimus in Tesla factories). $95B revenue (2025), ~135K employees, $1.5T market cap. No external dependencies by design — no NVIDIA GPUs in vehicles, no ROS, no cloud providers. The anti-platform: everything proprietary, nothing shared.

| | |
| --- | --- |
| **Type** | Big Tech |
| **Revenue / Funding** | $95B revenue (2025); $1.5T market cap |
| **Physical AI thesis** | Full vertical integration from silicon to deployment — custom chips, custom models, custom training infra, data flywheel from millions of vehicles + factory robots; autonomous driving and humanoid robotics converge on shared architecture |
| **Platform coverage** | ~60% of blocks — but all proprietary and internal-only |
| **Relationship to Red Hat** | No relationship — fully self-contained; relevant as benchmark for what production-scale Physical AI looks like |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **FSD (Full Self-Driving)** | End-to-end autonomous driving neural network. v14 unified model across highway/city/robotaxi; replaced 300K lines of C++ with single neural net. 1.28M active subscriptions (Q1 2026). Deployed on HW4 vehicles. |
| **Robotaxi** | Unsupervised autonomous ride-hailing. Live in Austin (full metro, 4K+ sq mi) since Jan 2026; expanding to Dallas, Houston, Miami, Orlando, Tampa. 1M+ unsupervised miles. |
| **Optimus** | Humanoid robot (173cm, 57kg, 22-DOF hands). VLA foundation model trained via imitation learning + RL in simulation. ~1K units in Tesla factories for data collection. Fremont line converting to production; targeting late 2026 start. |
| **AI5 / AI6 Chips** | Custom inference silicon. AI5: ~2,000-2,500 TOPS, 5x HW4, matches H100 at 250W vs 700W. Dual-sourced TSMC + Samsung. AI6: Samsung fab, $16.5B deal, designed for Cybercab + Optimus + Dojo 3. |
| **Cortex** | Training supercluster at Giga Texas. 67K H100-equivalent GPUs (Q2 2025). Trains FSD and Optimus models. |
| **Neural World Simulator** | Video-generation AI models as neural physics engines — 1 real demonstration generates 10K synthetic variations for Optimus training. Unified simulator for FSD and Optimus. |
| **Terafab** | $20-25B joint semiconductor fab (Tesla/SpaceX/xAI) with Intel 14A process in Austin. Sovereign chip manufacturing. |

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
  <td>⬜</td>
  <td>🟢 Cortex<br><small>(FSD + Optimus model training)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟢 Neural World Simulator<br><small>(video-gen AI as physics engine)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Data Engine<br><small>(fleet-collected video from millions of vehicles)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">🟢 Cortex<br><small>(67K H100-equiv, Giga Texas)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Models & Policies</b></td>
  <td>⬜</td>
  <td>🟢 FSD v14 + Optimus VLA<br><small>(end-to-end unified model)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟢 FSD v14<br><small>(on-vehicle inference)</small></td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟣 AI4 / AI5<br><small>(custom inference silicon)</small></td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟢 Optimus SDK<br><small>(proprietary, internal only)</small></td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">🟣 Custom<br><small>(Cortex GPU cluster drivers)</small></td>
  <td colspan="2">⬜</td>
  <td>🟣 AI4/AI5 drivers<br><small>(custom silicon, custom drivers)</small></td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">🟢 Custom Linux<br><small>(Cortex cluster OS)</small></td>
  <td colspan="2">⬜</td>
  <td>🟢 Custom Linux<br><small>(vehicle + Optimus OS)</small></td>
</tr>

<tr><td colspan="6"><em>(Remaining blocks: all proprietary internal systems or ⬜ — Tesla has no external-facing platform components)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **FSD** | Proprietary end-to-end neural network. Likely PyTorch for training (unconfirmed). Custom inference runtime on custom silicon. |
| **Optimus** | Proprietary VLA. No ROS, no standard robotics middleware. |
| **Cortex** | NVIDIA H100/H200 GPUs with custom orchestration. Linux-based. |
| **AI5/AI6** | Fully custom silicon + custom compiler/runtime. No CUDA dependency. |
| **Neural World Simulator** | Proprietary video-generation models. No Isaac Sim, no MuJoCo. |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **NVIDIA** | Largest real-world driving dataset (millions of vehicles), production-deployed autonomous driving + robotics, custom inference silicon purpose-built for their models, data flywheel competitors can't replicate | General-purpose platform (NVIDIA serves entire ecosystem), GPU training ecosystem (Tesla uses NVIDIA GPUs for training but designs own inference chips), developer community, third-party ecosystem |
| **Waymo** | Fleet data scale (millions of vehicles vs thousands), unified architecture for driving + robotics, custom silicon cost advantage, humanoid robot program | LiDAR-based perception maturity, longer unsupervised driving track record, Google Cloud infrastructure, regulatory approvals in more markets |
| **Figure AI / Agility** | Factory deployment environment (own factories as testbed), data flywheel from production use, custom silicon roadmap, massive capital ($25B capex 2026) | Robotics-specific expertise (Tesla is primarily automaker), dexterous manipulation capability (Optimus hands still limited), customer diversity |

---

## Coverage Summary

- **Strong**: End-to-end autonomous driving (FSD v14), custom inference silicon (AI4→AI5→AI6), training infrastructure (Cortex), data engine (fleet collection), neural simulation, humanoid robotics (Optimus)
- **Absent**: Nothing missing internally — but nothing available externally. No model APIs, no inference serving, no developer tools, no platform components
- **Conflicts with Red Hat**: None — Tesla doesn't sell platform components. Uses custom Linux internally but doesn't compete in enterprise OS/platform markets
- **Lock-in**: Total — Tesla hardware only, fully closed system, no external integration points by design

---

## Strategic Implications for Red Hat

1. **Benchmark, not competitor**: Tesla demonstrates what fully vertically integrated Physical AI looks like — custom silicon, custom models, custom simulation, fleet-scale data collection. Useful as the "what-if you don't need a platform" reference point when positioning Red Hat's open, multi-vendor approach.

2. **Validates the Physical AI thesis**: Tesla's $25B 2026 capex (3x 2025) and Optimus factory buildout confirm that Physical AI is moving from research to production. The scale of investment validates the market Red Hat is targeting, even though Tesla itself is not addressable.

3. **Custom silicon trend**: Tesla's AI5/AI6 chips and Terafab signal that large Physical AI deployers will design custom inference silicon. Red Hat's edge platform must support heterogeneous silicon — not just NVIDIA and AMD — as custom ASICs proliferate.

4. **Data flywheel moat**: Tesla's millions of vehicles as data collectors create a feedback loop competitors cannot replicate. For non-Tesla Physical AI players, this underscores the need for data infrastructure building blocks (collection, curation, synthetic generation) — exactly where Red Hat's platform can add value.

5. **No partnership surface**: Tesla does not partner, does not use external platforms, and does not sell AI components. Zero addressable opportunity. Monitor for any change — Terafab as shared fab with Intel is the only external dependency crack.

---

## Sources

- [Tesla AI & Robotics](https://www.tesla.com/AI)
- [Tesla FSD v14 architecture — ThinkAutonomous](https://www.thinkautonomous.ai/blog/tesla-end-to-end-deep-learning/)
- [Tesla FSD v14.3.2 unified model — NotATeslaApp](https://www.notateslaapp.com/news/4033/tesla-fsd-v1432-unifies-fsd-models-across-robotaxi-and-customer-vehicles-improves-summon-and-adds-new-menu)
- [Tesla Optimus factory deployment status](https://optimusk.blog/blog/tesla-optimus-factory-deployment/)
- [Tesla Optimus AI foundation model](https://humanoid.guide/product/tesla-optimus-ai/)
- [Tesla AI5 chip design complete — Tesorb](https://tesorb.com/tesla-ai5-inference-chip-cybercab-optimus/)
- [Tesla AI5 vs NVIDIA — Notebookcheck](https://www.notebookcheck.net/Tesla-AI5-FSD-computer-to-run-inference-10x-cheaper-than-Nvidia-AI-chips.1145221.0.html)
- [Tesla Dojo shutdown and restart — TechCrunch](https://techcrunch.com/2025/09/02/tesla-dojo-the-rise-and-fall-of-elon-musks-ai-supercomputer/)
- [Tesla Optimus 10M target — The Robot Report](https://www.therobotreport.com/from-evs-to-robotics-tesla-targets-10m-optimus-units-with-new-texas-plant/)
- [Tesla unified world simulator — Humanoids Daily](https://www.humanoidsdaily.com/news/tesla-ai-chief-details-unified-world-simulator-for-fsd-and-optimus)
- [Tesla revenue — Stock Analysis](https://stockanalysis.com/stocks/tsla/revenue/)
