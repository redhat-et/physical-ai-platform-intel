# Visual Language Reference

Standard visual conventions for all intelligence reports in `deliverables/intel/`.

## Coverage Indicators

Used in architecture overlay tables to signal vendor coverage of each platform block.

| Indicator | Meaning | When to use |
| --- | --- | --- |
| 🟢 | **Covered** | Vendor has a shipping product for this block |
| 🟡 | **Partial** | Cloud-only, beta, limited scope, or requires caveats |
| 🔵 | **OSS-stewarded** | Vendor stewards the OSS project but does not own it (e.g., Google → ROS 2) |
| ⬜ | **No offering** | Vendor has nothing here |
| 🔴 | **Conflict** | Vendor product competes directly with our platform component |
| 🟣 | **Hardware** | Vendor-specific silicon or hardware dependency |

Rules:

- Every cell in an architecture overlay table MUST start with one of these indicators
- The indicator reflects the vendor's offering, not the block's importance
- When a cell has both a product and a conflict, prefer 🔴 (the strategic signal matters more)
- When a product is OSS-stewarded AND covered, prefer 🔵 (highlights the governance relationship)

## Architecture Overlay Table Structure

All company overlay reports use the same HTML table structure, matching the Red Hat Physical AI Platform architecture diagram.

### Column layout

```text
| Block | Central-Lang | Central-PhysAI | Distrib-Lang | Distrib-PhysAI | Edge |
```

- **Block**: Architecture row label (e.g., "Train Workloads", "Inference Server")
- **Central-Lang / Central-PhysAI**: Central site (cloud/datacenter), split by Language AI vs Physical AI
- **Distrib-Lang / Distrib-PhysAI**: Distributed sites (factory, hospital, etc.)
- **Edge**: Edge devices (robots, drones, medical devices)

### Column headers

Use a two-row header with merged cells for tier names:

```html
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
```

### Cell merging rules

| Pattern | Meaning | HTML |
| --- | --- | --- |
| Single merged cell (`colspan="2"`) | Same product/technology covers both Language and Physical AI | `<td colspan="2">🟢 Product</td>` |
| Two separate filled cells | Analogous but different solutions for each side | Two `<td>` elements |
| One filled, one ⬜ | Product exists for only one side | Fill one, `<td>⬜</td>` for the other |

### Cell content format

```html
<td>🟢 Product Name<br>
<small>(OSS foundation or brief detail)</small></td>
```

- **Line 1**: Indicator + product/technology name
- **Line 2** (optional): `<small>` tag with parenthetical — OSS project it wraps, key caveat, or brief technical detail
- Keep cell content to 2 lines maximum; longer details belong in footnotes or the deep-dive

### Footnotes

Use `<sup>N</sup>` superscripts sparingly — only when a cell's classification is non-obvious and needs explanation (e.g., why 🟡 instead of 🟢, a scope caveat, a conflict rationale). Place a numbered footnote list directly below the table.

Do NOT use superscripts as cross-references to the OSS Foundations table — that table is keyed by product name and stands on its own.

## Architecture Block Rows

Ordered to match the Red Hat Physical AI Platform architecture diagram (deployment view first, then training/MLOps detail):

### Deployment view blocks

| Row | Description |
| --- | --- |
| **Training & Evaluation** | Training workloads, simulation, eval, data curation |
| **AI Model & Data Lifecycle** | Model registry, pipelines, CI/CD, experiment tracking, monitoring |
| **Agentic Framework** | Agent orchestration, tools/skills, guardrails, lifecycle automation |
| **Models & Policies** | Foundation models, VLAs, world models, robot policies, custom-trained models |
| **MaaS** | Model-as-a-Service API access |
| **Inference Server** | Model serving (vLLM, NIM, etc.) |
| **llm-d** | Distributed inference routing |
| **KServe** | Model routing and autoscaling |
| **Application Libs** | Math/AI libs, Media libs, Robotics libs |
| **Application Runtime** | Container platform (OpenShift, K8s, Podman, MicroShift) |
| **Drivers** | GPU/TPU drivers, GPU Operator, vision accelerators |
| **OS** | Operating system (RHEL, L4T, custom Linux) |

### Training & MLOps detail blocks

| Row | Description |
| --- | --- |
| **Train Workloads** | LLM fine-tuning (Language) / Robot policy training (Physical AI) |
| **Simulation Engine** | Physics simulation, rendering (Physical AI only) |
| **Eval** | LLM benchmarks (Language) / Policy eval (Physical AI) |
| **Data** | Data curation for both sides |
| **Train Infra** | Training frameworks, GPU scheduling |
| **Model Registry** | Model versioning and catalog |
| **Model Pipelines** | Pipeline orchestration (sim→train→eval→deploy) |
| **CI/CD & GitOps** | Continuous integration and deployment |
| **Experiment Tracking** | Training run tracking and comparison |
| **Model Monitoring** | GPU metrics, content safety, model drift |

## Document Metadata

Every report file starts with a metadata header:

```markdown
# Company Name — Report Title

**Date**: YYYY-MM-DD
**Last updated**: YYYY-MM-DD
**Classification**: Internal analysis — not for public repo
```

- **Date**: When the report was first created
- **Last updated**: When substantive content was last changed (not formatting fixes)
- **Classification**: Always include — these files are gitignored for a reason

## Cross-linking

- Link between overlay and deep-dive: `[deep-dive](company-deep-dive.md)`
- Link to architecture reference: `[visual language](../_templates/visual-language.md)`
- Link to project reports: `[project report](../projects/project-name.md)`
- Link to ecosystem.md entries: `[Company](../../../research/ecosystem.md#anchor)`

## GitHub Rendering Notes

These reports use inline HTML tables for formatting. GitHub renders:

- `<table>`, `<tr>`, `<td>`, `<th>` with `colspan`/`rowspan` — **works**
- `<br>` line breaks in cells — **works**
- `<small>` tags — **works**
- `<sup>` superscripts — **works**
- Emoji indicators (🟢🟡🔵⬜🔴🟣) — **works everywhere including mobile**

GitHub does NOT render:

- `style="background:..."` or any inline CSS — **stripped by sanitizer**
- `<style>` blocks — **stripped**
- `class="..."` attributes — **stripped**

For presentation-quality output with colored backgrounds, generate an HTML companion file separately.
