# Prometheus — Competitive Profile

**Date**: 2026-07-09
**Last updated**: 2026-07-09
**Classification**: Internal analysis — not for public repo

See [deep-dive](prometheus-deep-dive.md) for acquisition details, technical architecture, and competitive analysis.
See [visual language](../_templates/visual-language.md) for coverage indicator definitions.
🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware

---

## At a Glance

Prometheus (formerly Project Prometheus) is a VC-backed startup ($18B+ raised, $41B valuation) building an "artificial general engineer" — foundation models that reason about geometries, materials, tolerances, manufacturing constraints, and physics to automate the design of physical objects. Co-founded in November 2025 by Jeff Bezos (his first operational CEO role since Amazon) and Vik Bajaj (former Google X, Foresite Labs), with Transformer co-authors Ashish Vaswani and Jakob Uszkoreit as founding advisors. Prometheus is not a robotics company: it targets the $13B CAD software market and adjacent engineering workflows in aerospace, automotive, manufacturing, and drug discovery. No product has shipped; first commercial offering expected 2027.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | $18B+ raised ($6.2B launch Nov 2025, $10B Apr 2026, $12B Series B Jun 2026 at $41B valuation); pre-revenue |
| **Physical AI thesis** | Foundation models that compress multi-year engineering design into months; AI as collaborator for engineers designing physical objects |
| **Platform coverage** | ~5% of blocks — concentrated on model training and data pipelines (all pre-product) |
| **Relationship to Red Hat** | Minimal overlap — Prometheus builds design tools for engineers, not platform infrastructure; potential compute customer via AWS |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **AGE (Artificial General Engineer)** | Foundation model trained to reason about physical design — geometries, materials, manufacturing constraints, multi-physics. Not yet publicly available. Output: CAD files, simulation results, manufacturing specifications |
| **Ace** | Agentic computer-use system (acquired via General Agents). VLA model that interprets visual inputs and executes tasks via natural language commands. Operates at the screen/application level, not robot-control level |
| **$100B Manufacturing Fund** | Proposed Berkshire Hathaway-style holding company to acquire manufacturing firms and deploy Prometheus AI tools. Creates captive demand channel + proprietary training data flywheel. In fundraising talks (Mar 2026) |

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
  <td>🟡 AGE<sup>1</sup><br>
  <small>(pre-product; training on engineering/physics data)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 AGE<sup>2</sup><br>
  <small>(multi-physics reasoning, not standalone sim)</small></td>
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
  <td>⬜</td>
  <td>🟡 Proprietary<sup>3</sup><br>
  <small>(engineering/manufacturing data pipelines)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">🟡 Internal<sup>4</sup><br>
  <small>(multi-hyperscaler compute; $12B allocated)</small></td>
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

<!-- === Agentic Framework === -->

<tr>
  <td><b>Agentic Framework</b></td>
  <td>⬜</td>
  <td>🟡 Ace<sup>5</sup><br>
  <small>(agentic computer use via VLA)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Models & Policies === -->

<tr>
  <td><b>Models &amp; Policies</b></td>
  <td>⬜</td>
  <td>🟡 AGE<br>
  <small>(engineering foundation model, pre-product)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td colspan="2">⬜<sup>6</sup></td>
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

<!-- === Application Libraries === -->

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
  <td>⬜</td>
</tr>

<!-- === Platform === -->

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

### OSS Foundations

| # | Product | OSS Foundation |
| --- | --- | --- |
| 1 | **AGE (training)** | No public information; "very compute-intensive" synthetic data generation for engineering/physics domains; multi-hyperscaler compute (incl. AWS) |
| 2 | **Ace (agentic)** | Built on General Agents' VLA architecture; no open-source release; pre-acquisition codebase included video-language-action model for computer use |
| 3 | **Overall** | Fully proprietary; no open-source releases, no public API, no weights. Stealth-mode operation |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **AWS** | Compute provider | Prometheus sources compute from multiple hyperscalers including AWS; Bezos floated potential Amazon partnership for data center optimization but no formal deal exists |
| **Blue Origin** | Potential customer | Bezos calls Blue Origin a "case study for a customer" — Prometheus tools would accelerate rocket/spacecraft design. No corporate ties |
| **JPMorgan, BlackRock, Goldman Sachs** | Financial investors | Led $12B Series B; institutional confidence in capital-intensive AI infrastructure play |
| **DST Global, Arch Venture Partners** | VC investors | Cross-sector AI thesis alignment; DST also backs other frontier AI companies |
| **Sovereign wealth funds** | Potential investors | Discussions with Middle East and Singapore funds for the $100B manufacturing fund |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Autodesk / Dassault / PTC / Siemens** | $18B+ funding, greenfield AI-native architecture, Transformer co-authors as advisors, ability to rethink CAD from scratch without legacy constraints | Shipping products, paying customers, decades of domain-specific IP, established enterprise sales channels, certified engineering workflows, regulatory compliance track record |
| **PhysicsX** | Far larger funding ($18B vs. $489M), Bezos brand/network, broader scope (design + manufacturing), potential captive demand via $100B fund | PhysicsX shipping "Large Physics Models" to automotive/aerospace/semiconductor customers, 2x YoY revenue, backed by Siemens + NVIDIA, integrating with Siemens Xcelerator digital twin platform |
| **AI incumbents (OpenAI, Anthropic, Google)** | Dedicated focus on physical-world engineering (not general-purpose LLMs), specialized data pipelines for manufacturing/materials, vertical integration thesis via fund | General-purpose AI capabilities, broader model ecosystems, existing enterprise relationships, developer platforms, established inference infrastructure |

---

## Coverage Summary

- **Strong**: Ambition and capital — $18B+ funding with elite AI talent (DeepMind, OpenAI, xAI recruits + Transformer co-authors). VLA-based agentic layer via General Agents acquisition
- **Absent**: Everything except models and training — no simulation engine, no inference infrastructure, no platform, no shipping products. Pre-product across the board
- **Conflicts with Red Hat**: None — Prometheus is a design-tools company with no infrastructure ambitions
- **Lock-in**: Expected high — likely managed service delivery; proprietary models with no open-source strategy. AWS relationship via Bezos creates natural cloud gravity

---

## Strategic Implications for Red Hat

1. **Adjacent, not competing**: Prometheus operates upstream of the robotics/Physical AI stack. Its outputs (CAD files, manufacturing specs, simulation results) are inputs to the manufacturing pipelines and robot controllers that Red Hat's platform targets. No platform overlap, no model-layer competition.

2. **The $100B fund is the strategic signal**: If Bezos closes the manufacturing acquisition fund, Prometheus becomes both an AI company and an industrial conglomerate. Those acquired factories become captive customers for Prometheus tools — and potential customers for the infrastructure stack (OpenShift, RHEL) that runs them. Monitor fund progress as a demand signal.

3. **Validates "Physical AI is bigger than robotics"**: Prometheus's framing — AI for the entire physical economy, not just robots — expands the addressable market for Physical AI platforms. If the thesis succeeds, platform infrastructure for engineering simulation, multi-physics training, and manufacturing data pipelines becomes a distinct opportunity beyond the robotics stack.

4. **Data flywheel creates defensibility**: The core bet is proprietary engineering data (sensor logs, materials properties, manufacturing telemetry). If Prometheus builds this dataset via acquired companies, it creates a moat that open-source alternatives cannot easily replicate. This is analogous to Tesla's driving data advantage — the model is secondary to the data.

5. **Pre-product risk is high**: $41B valuation with no product, no revenue, and no public demo. Industry analysts expect first commercial offering in 2027. The company could pivot significantly; the General Agents acquisition hints at agentic computer use beyond CAD. Worth monitoring quarterly but low-priority for near-term platform planning.

---

## Sources

- [Built In — Project Prometheus explainer](https://builtin.com/articles/what-is-project-prometheus)
- [CNBC — Bezos opens up after $12B raise (Jun 2026)](https://www.cnbc.com/2026/06/11/project-prometheus-bezos-bajaj-live-updates.html)
- [GeekWire — Bezos describes Prometheus (2026)](https://www.geekwire.com/2026/jeff-bezos-describes-his-38b-startup-prometheus-for-the-first-time-nothing-to-do-with-robotics/)
- [SiliconANGLE — General Agents acquisition](https://siliconangle.com/2025/11/26/jeff-bezos-project-prometheus-reportedly-acquires-ai-startup-general-agents/)
- [Forbes — Bezos $100B manufacturing fund](https://www.forbes.com/sites/josipamajic/2026/03/19/jeff-bezos-is-targeting-100-billion-to-acquire-and-automate-the-manufacturing-sector/)
- [Axios — Prometheus worth $41B (Jun 2026)](https://www.axios.com/2026/06/11/prometheus-bezos-industrial-ai)
- [SiliconANGLE — $12B raise (Jun 2026)](https://siliconangle.com/2026/06/11/jeff-bezos-prometheus-raises-12b-accelerate-industrial-engineering-projects/)
- [New Space Economy — Prometheus overview](https://newspaceeconomy.ca/2026/06/14/jeff-bezos-prometheus-the-ai-startup-building-an-artificial-general-engineer-to-accelerate-engineering-manufacturing-and-space-innovation/)
