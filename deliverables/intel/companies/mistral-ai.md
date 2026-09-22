# Mistral AI — Competitive Profile

**Date**: 2026-07-09
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

See [deep-dive](mistral-ai-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.

---

## At a Glance

Mistral AI is a Paris-based startup pursuing an **open-weight models + sovereign infrastructure** strategy, positioning itself as Europe's alternative to OpenAI and Anthropic. Founded in 2023 by former DeepMind and Meta researchers, Mistral built its base on efficient MoE language models released under Apache 2.0, then expanded into enterprise AI (Forge custom training, Le Chat/Vibe assistant) and — since May 2026 — Physical AI via the Emmi AI acquisition (physics simulation) and Robostral Navigate (embodied navigation). The company's relevance to Red Hat is twofold: Mistral's open-weight models are day-0 compatible with vLLM and Red Hat AI Inference Server, making Mistral a key model supplier; but Forge's on-prem training platform and Mistral Compute infrastructure could overlap with OpenShift AI workflows.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | ~$400M ARR (Jan 2026); ~$9.9B total raised; €21B ($24B) valuation (Sep 2026 Series D — €3B led by Samsung, largest-ever European tech equity round) |
| **Physical AI thesis** | Extend efficient open-weight models from language into embodied AI and industrial physics simulation; win European industrial customers (Airbus, BMW, EDF) via sovereignty + on-prem deployment |
| **Platform coverage** | ~20% of blocks — concentrated in models, MaaS, and emerging Physical AI (simulation, robot policies); no platform infrastructure |
| **Relationship to Red Hat** | Mixed — Complement on models (Apache 2.0 weights served via vLLM/Red Hat AI); potential overlap on training workflows (Forge vs OpenShift AI) |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Mistral Large 3** | Flagship open-weight MoE model (675B total / 41B active). Apache 2.0. 262K context. Multimodal (vision + text) |
| **Mistral Small 4** | Efficient MoE (119B total / 6B active). Unifies instruct, reasoning, vision, coding. Apache 2.0 |
| **Ministral 3** | Dense edge models at 14B, 8B, 3B parameters. 14B reasoning variant hits 85% on AIME 2025. Apache 2.0 |
| **Mistral Medium 3.5** | Mid-tier model for instruction, reasoning, coding. Powers Le Chat / Vibe. Remote coding agents |
| **Codestral / Devstral 2** | Code completion (256K window) and agentic coding (46.8% SWE-Bench). Devstral built with All Hands AI |
| **Shieldstral 1.0** | Content moderation model for safety guardrails |
| **Leanstral 1.5** | Lean 4 formal proof engineering model (retiring Sep 30, 2026) |
| **Voxtral Mini Transcribe 2** | Speech transcription model |
| **Agentic Search** | Retrieval layer for navigating, reading, and verifying complex documents with fewer turns and lower token use |
| **Voxtral TTS** | Open-weight TTS on Ministral 3B backbone. 9 languages, zero-shot voice cloning. CC BY-NC 4.0 |
| **Robostral Navigate** | 8B embodied navigation model. Single RGB camera, 76.6% on R2R-CE. Sim-trained (400K trajectories). Apache 2.0 |
| **Emmi AI (physics sim)** | Neural surrogate models for industrial simulation (airflow, heat, stress). Acquired May 2026 (~€300M) |
| **Le Chat / Vibe** | Consumer + enterprise AI assistant. Pro tier $14.99/mo. Agents, web search, code execution |
| **Agents API** | Workflow orchestration with function calling, MCP support, Document Library (RAG). Enterprise agentic platform |
| **Forge** | Custom model training platform: full pre-training + post-training + RL on enterprise data. On-prem or Mistral Compute |
| **La Plateforme** | Pay-per-token API for all Mistral models. OpenAI-compatible endpoints |
| **Mistral Compute** | Proprietary AI cloud infrastructure. 18,000 NVIDIA Blackwell GPUs, 44 MW datacenter near Paris. Regional inference endpoints (EU/US) with Priority Tier SLAs |
| **Third-party model hosting** | Hosting open-weight models from other providers (starting with Z.ai GLM-5.2) on Mistral infrastructure with same regional controls |

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
  <td>🟢 Forge<br>
  <small>(full pre-train + post-train + RL)</small></td>
  <td>🟡 Forge + Emmi AI<br>
  <small>(physics surrogate training, early)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 Emmi AI<br>
  <small>(neural surrogates, not full sim)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>🟡 La Plateforme<br>
  <small>(internal benchmarks, no public eval tool)</small></td>
  <td>🟡 Robostral eval<br>
  <small>(R2R-CE benchmark, internal)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>🟡 Forge data pipelines<br>
  <small>(enterprise data ingestion)</small></td>
  <td>🟡 Emmi training data<br>
  <small>(physics sim data, sim-generated)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">🟢 Mistral Compute<br>
  <small>(18K Blackwell GPUs, 44 MW)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === AI Model & Data Lifecycle === -->

<tr>
  <td><b>Model Registry</b></td>
  <td colspan="2">🟡 Forge model management<br>
  <small>(within Forge platform, not standalone)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Pipelines</b></td>
  <td colspan="2">🟡 Forge pipelines<br>
  <small>(pre-train → post-train → RL → deploy)</small></td>
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
  <td>🟢 Agents API + Vibe<br>
  <small>(MCP, function calling, workflows)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<!-- === Models & Policies === -->

<tr>
  <td><b>Models &amp; Policies</b></td>
  <td>🟢 Large 3, Medium 3.5, Small 4<br>
  <small>(MoE, multimodal, Apache 2.0)</small></td>
  <td>🟡 Robostral Navigate<br>
  <small>(nav-only, 8B, no manipulation)</small></td>
  <td>🟢 Small 4, Codestral</td>
  <td>🟡 Robostral Navigate</td>
  <td>🟢 Ministral 3B/8B/14B<br>
  <small>(dense, edge-optimized)</small></td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td colspan="2">🟢 La Plateforme<br>
  <small>(pay-per-token, OpenAI-compatible)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td colspan="2">⬜<br>
  <small>(relies on vLLM, TGI, NIM for self-hosted)</small></td>
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
  <td colspan="2">🟡 Voxtral TTS, Mistral OCR<br>
  <small>(TTS: CC BY-NC; OCR: API-only)</small></td>
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

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Mistral Large 3** | Apache 2.0 open weights. MoE architecture. Runs on vLLM, TGI, Ollama. No proprietary runtime required |
| **Mistral Small 4** | Apache 2.0 open weights. MoE (119B/6B active). vLLM-native |
| **Ministral 3** | Apache 2.0 open weights. Dense models (3B/8B/14B). Ollama, llama.cpp compatible |
| **Codestral** | Apache 2.0 (latest versions). Earlier versions used MNPL non-commercial license |
| **Devstral 2** | Apache 2.0. Built with All Hands AI (OpenHands). Agentic coding |
| **Robostral Navigate** | Apache 2.0 open weights. 8B model. vLLM-compatible |
| **Voxtral TTS** | CC BY-NC 4.0 (non-commercial). Ministral 3B backbone |
| **mistral-inference** | Apache 2.0 reference inference library. 11K+ GitHub stars |
| **mistral-common** | Apache 2.0 tokenizer/preprocessing library |
| **Forge** | Proprietary platform. Uses open-weight base models but adds proprietary training orchestration |
| **Emmi AI** | Unknown licensing for physics models. No open-weight release announced |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **Samsung** | Lead investor (Series D) | Led €3B Series D (Sep 2026). Signals Asian semiconductor industry interest in European AI sovereignty |
| **NVIDIA** | Compute / Co-development | Nemotron Coalition founding member. Co-developing frontier open-source models. 18K Blackwell GPUs for Mistral Compute |
| **ASML** | Strategic investor + customer | 11% shareholder (€1.3B). Using Mistral vision models for lithography defect detection. European Compute Coalition member |
| **Microsoft Azure** | Cloud distribution + infra | Multibillion-dollar agreement (Jul 2026): Microsoft uses Mistral EU compute capacity; Medium 3.5 + OCR 4 on Azure Foundry + Copilot Studio |
| **Airbus** | Industrial customer | 5-year deal covering defence, space, helicopters. Custom AI tools for aerospace |
| **BMW** | Industrial customer | Crash simulation AI using 1 PB of historical simulation data. "Large Industry Models" |
| **EDF** | Industrial customer | Launch customer for industrial engineering AI stack |
| **Accenture** | Systems integrator | Strategic partnership for enterprise AI deployment at scale |
| **SAP** | Sovereign AI | Joint sovereign AI stack for French and German government administrations |
| **European Compute Coalition** | Infrastructure | ASML, Amadeus, Capgemini, Caisse des Dépôts, CMA CGM — targeting 1 GW European compute by 2030 |
| **Mozilla** | Consumer AI | Partnership to bring open, private, multilingual AI to Firefox Smart Window |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **OpenAI / Anthropic** | Open-weight models (Apache 2.0) enabling self-hosting; EU data sovereignty; on-prem deployment via Forge; European industrial customer base (Airbus, BMW) | Scale of compute and R&D spend (~$6B raised vs $40B+); breadth of model capabilities; consumer adoption (Vibe is small vs ChatGPT); no equivalent to OpenAI's o3 reasoning depth |
| **NVIDIA** | Model-layer independence (no hardware tie-in); open weights compatible with any inference server; sovereign EU positioning | Integrated simulation platform (no Isaac Sim equivalent, Emmi is early); no hardware (pure software); no equivalent to NIM/Triton inference optimization; Robostral Navigate is nav-only vs GR00T's full-body control |
| **Meta (Llama)** | Dedicated commercial entity with enterprise support, SLAs, and Forge custom training; MoE efficiency (41B active vs Llama's dense 405B); European data residency | Llama's broader ecosystem adoption; Meta's unlimited compute budget; Llama's larger community of fine-tuners; no equivalent to Meta's data flywheel from social platforms |

---

## Coverage Summary

- **Strong**: Foundation models (Large 3, Small 4, Ministral — all Apache 2.0), MaaS API (La Plateforme), agentic framework (Agents API + Vibe), custom training (Forge), edge models (Ministral 3B/8B/14B)
- **Absent**: Inference server, container platform, OS, drivers, math/AI libs, robotics libs, CI/CD, experiment tracking, model monitoring, distributed inference, KServe
- **Conflicts with Red Hat**: Forge's on-prem training orchestration could overlap with OpenShift AI training workflows; Mistral Compute infrastructure competes with Red Hat's cloud-agnostic positioning
- **Lock-in**: Low for open-weight models (Apache 2.0, vLLM-native); medium for Forge (proprietary training platform); high for Mistral Compute and La Plateforme API

---

## Strategic Implications for Red Hat

1. **Premier open-weight model supplier**: Mistral's Apache 2.0 models (Large 3, Small 4, Ministral) are day-0 compatible with vLLM and Red Hat AI Inference Server. Red Hat already published a [guide for running Mistral Large 3 on Red Hat AI](https://developers.redhat.com/articles/2025/12/02/run-mistral-large-3-ministral-3-vllm-red-hat-ai). This makes Mistral one of the most important model suppliers for the Red Hat AI stack, alongside Meta (Llama) and IBM (Granite).

2. **Forge creates a subtle competitive tension**: Forge's full-lifecycle training platform (pre-train + post-train + RL + deploy) on enterprise data overlaps with OpenShift AI's model training and fine-tuning workflows. For European enterprises choosing between Forge's managed training and OpenShift AI + open tools, the deciding factor will be whether they want a model-vendor-managed experience or platform-team-managed infrastructure. Red Hat should position OpenShift AI as the runtime beneath Forge for on-prem deployments.

3. **Robostral Navigate opens a Physical AI entry point**: Robostral Navigate is Apache 2.0, 8B parameters, vLLM-compatible, and designed for edge deployment on wheeled/legged/flying robots. This is a complementary model for Red Hat's Physical AI platform — small enough to run on edge devices (RHEL Device Edge + MicroShift), open enough to integrate without license friction. Key question: will future Robostral models (manipulation, WMa1) maintain Apache 2.0 licensing?

4. **European sovereignty play aligns with Red Hat's enterprise customers**: Mistral's GDPR/EU AI Act compliance, on-prem deployment, and French government partnerships resonate with European enterprises that Red Hat already serves. Red Hat should ensure OpenShift AI is certified for Mistral model deployment in sovereign cloud contexts, positioning as the platform layer for Mistral-based sovereign AI stacks.

5. **Watch the Emmi AI physics simulation trajectory**: Emmi AI's neural surrogate models (compressing hours-long simulations to seconds) could become a significant Physical AI building block. If Mistral open-sources Emmi-derived models, they would complement Red Hat's simulation strategy. If they remain proprietary, Emmi becomes a competitor to open alternatives. The Airbus and BMW deployments will signal whether Emmi evolves into a platform service or stays a consulting engagement.

---

## Related Reports

- [Mistral AI — ecosystem entry](../../../research/ecosystem.md#mistral-ai)

---

## Sources

- [Mistral €3B Series D — TechCrunch](https://techcrunch.com/2026/09/08/mistral-raises-e3b-as-sovereign-ai-becomes-big-business/)
- [Samsung leads Mistral funding — CNBC](https://www.cnbc.com/2026/09/08/mistral-ai-funding-valuation-samsung.html)
- [Regional inference, open models, new compute — Mistral](https://mistral.ai/news/regional-inference-open-models-new-compute/)
- [Microsoft multibillion-dollar agreement — Mistral](https://mistral.ai/news/)
- [Mistral AI official website](https://mistral.ai/)
- [Run Mistral Large 3 on Red Hat AI — Red Hat Developer](https://developers.redhat.com/articles/2025/12/02/run-mistral-large-3-ministral-3-vllm-red-hat-ai)
