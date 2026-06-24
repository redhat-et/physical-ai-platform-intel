# {COMPANY} — Competitive Profile

**Date**: {YYYY-MM-DD}
**Last updated**: {YYYY-MM-DD}
**Classification**: Internal analysis — not for public repo

See [deep-dive]({company}-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.
See [visual language](../_templates/visual-language.md) for coverage indicator definitions.
🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware

---

## At a Glance

<!-- One-paragraph company positioning: who they are, what their Physical AI thesis is,
     what makes them relevant to Red Hat. Think "elevator pitch about the competitor." -->

{COMPANY} is {type: $3T chipmaker / Alphabet subsidiary / VC-backed startup / ...} pursuing {their Physical AI thesis in one sentence}. {Key strategic framing, e.g., "Android for robotics" vision, "full vertical from silicon to models", etc.}

| | |
| --- | --- |
| **Type** | {Big Tech / Startup / OSS Community / Research Lab} |
| **Revenue / Funding** | {$XB revenue or $XM raised, Series X} |
| **Physical AI thesis** | {1-sentence strategic vision} |
| **Platform coverage** | ~{N}% of blocks — {where concentrated} |
| **Relationship to Red Hat** | {Complement / Competitor / Mixed — 1 sentence why} |

---

## Key Products

<!-- One-line description per product, grouped by function. -->
<!-- Only products relevant to Physical AI. Not a full product catalog. -->

| Product | What It Does |
| --- | --- |
| **{Product}** | {One-line: what it is + key differentiator} |

---

## Architecture Coverage

<!-- See visual-language.md for indicator definitions and cell format rules.
     Indicators: 🟢 covered  🟡 partial  🔵 OSS-stewarded  ⬜ gap  🔴 conflict  🟣 hardware
     Use colspan="2" to merge Language + Physical AI when same product covers both.
     Split cells when products differ between sides.
     Cell content: indicator + product name, optional <br><small>(brief detail)</small> -->

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
  <td><!-- LLM fine-tuning --></td>
  <td><!-- Robot policy training --></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td><!-- sim engine --></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td><!-- LLM benchmarks --></td>
  <td><!-- Policy eval --></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td><!-- Data curation --></td>
  <td><!-- Physical AI data --></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2"><!-- training frameworks, GPU scheduling --></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === AI Model & Data Lifecycle === -->

<tr>
  <td><b>Model Registry</b></td>
  <td colspan="2"><!-- model versioning --></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Pipelines</b></td>
  <td colspan="2"><!-- pipeline orchestration --></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>CI/CD & GitOps</b></td>
  <td colspan="2"><!-- CI/CD --></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Experiment Tracking</b></td>
  <td colspan="2"><!-- tracking --></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Monitoring</b></td>
  <td colspan="2"><!-- monitoring --></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Agentic Framework === -->

<tr>
  <td><b>Agentic Framework</b></td>
  <td><!-- Language agent orchestration --></td>
  <td><!-- Physical AI agent orchestration --></td>
  <td><!-- agent orchestration --></td>
  <td><!-- agent orchestration --></td>
  <td><!-- edge agent orchestration --></td>
</tr>

<!-- === Models & Policies === -->

<tr>
  <td><b>Models & Policies</b></td>
  <td><!-- LLMs, VLMs --></td>
  <td><!-- VLAs, world models, robot policies --></td>
  <td><!-- models --></td>
  <td><!-- models, policies --></td>
  <td><!-- on-device models, policies --></td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td colspan="2"><!-- model API --></td>
  <td colspan="2"><!-- model API --></td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td colspan="2"><!-- model serving --></td>
  <td colspan="2"><!-- model serving --></td>
  <td><!-- edge inference --></td>
</tr>

<tr>
  <td><b>llm-d</b></td>
  <td colspan="2"><!-- distributed inference --></td>
  <td colspan="2"><!-- distributed inference --></td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>KServe</b></td>
  <td colspan="2"><!-- model routing --></td>
  <td colspan="2"><!-- model routing --></td>
  <td>⬜</td>
</tr>

<!-- === Application Libraries === -->

<tr>
  <td><b>App Libs (Math/AI)</b></td>
  <td colspan="2"><!-- CUDA, ROCm, etc. --></td>
  <td colspan="2"><!-- CUDA, ROCm, etc. --></td>
  <td><!-- math libs --></td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td colspan="2"><!-- FFmpeg, GStreamer, etc. --></td>
  <td colspan="2"><!-- FFmpeg, GStreamer, etc. --></td>
  <td><!-- media libs --></td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td><!-- ROS, etc. --></td>
</tr>

<!-- === Platform === -->

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2"><!-- K8s / container platform --></td>
  <td colspan="2"><!-- K8s / container platform --></td>
  <td><!-- Podman / MicroShift --></td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2"><!-- GPU drivers, operators --></td>
  <td colspan="2"><!-- GPU drivers, operators --></td>
  <td><!-- accelerator drivers --></td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2"><!-- server OS --></td>
  <td colspan="2"><!-- server OS --></td>
  <td><!-- edge OS --></td>
</tr>
</table>

### OSS Foundations

<!-- Compact footnote table: one row per product in the coverage table above. -->
<!-- Keep to 1 line each. Full OSS analysis lives in the deep-dive. -->

| # | Product | OSS Foundation |
| --- | --- | --- |
| 1 | **{Product}** | {OSS engine + license, 1 line} |

---

## Hardware & Ecosystem Partnerships

<!-- Delete section if not applicable (e.g., pure-software startups) -->

| Partner | Type | Significance |
| --- | --- | --- |
| **{Partner}** | {Industrial / Humanoid / AV} | {1-line: installed base, nature of deal} |

---

## Competitive Positioning

<!-- 2-3 key comparisons, stated as factual contrasts, not marketing -->

| vs | They have | They lack |
| --- | --- | --- |
| **{Competitor}** | {what they do better or differently} | {where the competitor is stronger} |

---

## Coverage Summary

- **Strong**: {areas with product names}
- **Absent**: {gaps}
- **Conflicts with Red Hat**: {where products compete with our components}
- **Lock-in**: {cloud-locked / HW-locked / none}

---

## Strategic Implications for Red Hat

<!-- 3-5 numbered points. Each: bold label + 1-2 sentence explanation. -->
<!-- Mix of opportunities, risks, and questions to monitor. -->

1. **{Label}**: {explanation}
2. **{Label}**: {explanation}
3. **{Label}**: {explanation}
