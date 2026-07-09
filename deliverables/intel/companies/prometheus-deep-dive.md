# Prometheus — Deep Dive Research

**Date**: 2026-07-09
**Last updated**: 2026-07-09
**Classification**: Internal analysis — not for public repo

Supporting research for the [Prometheus competitive profile](prometheus.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: corporate timeline, acquisitions, technical architecture, and competitive dynamics.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2025-11 | Founded by Jeff Bezos and Vik Bajaj as "Project Prometheus." Launched with $6.2B in funding (partly from Bezos). 120+ employees hired from Meta, OpenAI, xAI, DeepMind |
| 2025-11 | Acquired General Agents (Sherjil Ozair, William Guss) — agentic AI startup from former DeepMind/OpenAI researchers |
| 2025-11 | Ashish Vaswani and Jakob Uszkoreit ("Attention Is All You Need" co-authors) join as founding advisors |
| 2026-03 | Bloomberg reports Bezos exploring $100B manufacturing acquisition fund |
| 2026-04 | Closed $10B round at $38B valuation (JPMorgan, BlackRock among leads) |
| 2026-06 | Closed $12B Series B at $41B valuation. Bezos and Bajaj conduct first public interviews (CNBC). Company renamed from "Project Prometheus" to "Prometheus" |
| 2027 (est.) | Industry analysts expect first commercial product |

### Acquisitions — What Each Brought

#### General Agents (2025)

- **Price**: Undisclosed
- **Technology**: Ace — a "real-time computer pilot" using a video-language-action (VLA) model. Interprets visual inputs (screen content) and executes tasks based on natural language commands. Not a robotics VLA — operates at the software/application level
- **Team**: Sherjil Ozair (co-founder, former Google DeepMind and Tesla), William Guss (co-founder, former OpenAI). Both became Prometheus co-founders
- **Integration**: Provides the agentic execution layer above Prometheus's physical-AI foundation models. VLA approach — learning from video observations of physical processes — translates from screen-level task automation to engineering simulation workflows
- **Significance**: The acquisition closed four days after an off-the-record dinner between Bajaj and Ozair. Speed suggests strategic urgency to secure agentic capabilities before competitors. VLA architecture originally developed for robotics but Prometheus applies it to engineering tool automation

---

## 2. Product Architecture Details

### AGE (Artificial General Engineer)

| Aspect | Details |
| --- | --- |
| **Architecture** | Foundation model trained to reason about physical design: geometries, materials, tolerances, manufacturing constraints, multi-physics interactions. Output is CAD files, simulation results, or manufacturing specifications — not motor commands <!-- TODO: deep research needed --> |
| **Runtime dependencies** | "Very compute-intensive" — requires large-scale GPU clusters for both training (synthetic data generation) and inference. Sources compute from multiple hyperscalers including AWS <!-- TODO: deep research needed --> |
| **Extension model** | Unknown — no public API, SDK, or plugin system. Expected to launch as managed service <!-- TODO: deep research needed --> |
| **Key limitations** | Pre-product. No public demo, benchmark, or technical paper. Training data for engineering/manufacturing domains is scarce and proprietary, unlike internet-scale text data |

### Ace (General Agents)

| Aspect | Details |
| --- | --- |
| **Architecture** | Video-language-action (VLA) model for computer use. Observes screen content as video, accepts natural language commands, outputs mouse/keyboard actions. Real-time execution loop <!-- TODO: deep research needed --> |
| **Runtime dependencies** | Unknown post-acquisition; pre-acquisition operated as standalone agent |
| **Extension model** | Unknown |
| **Key limitations** | Pre-acquisition product; unclear how deeply integrated into Prometheus stack. Computer-use VLA is a competitive space (Anthropic Claude computer use, OpenAI Operator, Google Project Mariner) |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **AGE** | None known | N/A | Entire product is proprietary; no open-source dependencies disclosed |
| **Ace** | None known | N/A | VLA model and agentic runtime fully proprietary |

### Pattern Analysis

Prometheus operates in full stealth with no open-source strategy. Unlike Physical Intelligence (which releases weights via openpi) or NVIDIA (which stewards multiple OSS projects), Prometheus has published no code, no weights, no APIs, and no technical papers. This is consistent with Bezos's historical approach at Amazon (internal innovation, external API) and contrasts sharply with the open-weight trend in the Physical AI startup ecosystem.

The absence of open-source engagement is notable given that Prometheus's advisors (Vaswani, Uszkoreit) created the Transformer architecture — an open publication that enabled the entire modern AI field. The company's closed posture suggests a deliberate strategy to build proprietary defensibility, likely centered on training data rather than model architecture.

### Notable Dependencies

No public information on OSS dependencies. Given the team composition (DeepMind, OpenAI alumni), likely uses PyTorch or JAX for training infrastructure, but this is speculative. The $12B compute allocation suggests building proprietary data and training pipelines rather than relying on existing open-source frameworks for the core product.

---

## 4. Governance & Community Risk

Not applicable — Prometheus stewards no open-source projects and has no public community presence.

---

## 5. Hardware Platform Details

Not applicable — Prometheus is a pure software company. Compute is sourced from hyperscalers (confirmed: AWS; likely also GCP and Azure given multi-provider strategy).

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **AWS** | N/A | Compute customer | Cloud infrastructure; no product integration |
| **Blue Origin** | N/A | Potential customer (Bezos-owned) | "Case study" per Bezos; no formal deal |
| **JPMorgan / BlackRock / Goldman** | N/A | Series B investors | Financial only |

### Developer Ecosystem

No developer ecosystem exists. No public website, no documentation, no API access, no developer program. The company has given exactly one public interview (CNBC, June 2026). This is the most opaque company in the Physical AI space relative to its valuation.

---

## 7. Detailed Competitive Analysis

### vs CAD Incumbents (Autodesk, Dassault Systèmes, PTC, Siemens)

| Dimension | Prometheus | CAD Incumbents |
| --- | --- | --- |
| **Product maturity** | Pre-product; 2027 expected | Decades of shipping products |
| **Enterprise relationships** | None | Thousands of enterprise customers |
| **Regulatory compliance** | Unproven | Certified for safety-critical design (aerospace, medical) |
| **AI integration** | AI-native from scratch | Bolt-on AI features to legacy architectures |
| **Data access** | Building via $100B fund | Decades of customer engineering data (but not owned by vendor) |
| **Funding** | $18B+ | Revenue-funded; Autodesk ~$5.8B annual revenue |

The incumbents' moat is certification and regulatory compliance. Aerospace and automotive engineering tools require FAA/EASA/ISO certification. Prometheus cannot sell into these industries without years of compliance work, regardless of model quality.

### vs PhysicsX

| Dimension | Prometheus | PhysicsX |
| --- | --- | --- |
| **Funding** | $18B+ | ~$100M |
| **Product status** | Pre-product | Shipping to automotive/aerospace customers |
| **Approach** | Foundation model for all engineering | Domain-specific physics simulation AI |
| **Team** | AI generalists from DeepMind/OpenAI | Physics PhDs + engineering domain experts |
| **Validation** | None public | Customer deployments in F1, aerospace |

PhysicsX has the "boring but working" advantage: domain-specific models with validated accuracy for specific physics problems. Prometheus bets on a general-purpose approach that may take longer to reach production quality in any single domain.

### vs AI Design Startups (Cadea, Etesian, Vizcom)

| Dimension | Prometheus | AI Design Startups |
| --- | --- | --- |
| **Scale of ambition** | Full engineering workflow | Narrow slices (generative design, rendering, topology optimization) |
| **Funding** | 100x+ larger | $5M–$50M range |
| **Risk** | Massive execution risk at scale | Lower risk, narrower scope |
| **Time to market** | 2027+ | Many already shipping |

---

## Sources

- [Built In — Project Prometheus explainer](https://builtin.com/articles/what-is-project-prometheus)
- [CNBC — Bezos opens up after $12B raise (Jun 2026)](https://www.cnbc.com/2026/06/11/project-prometheus-bezos-bajaj-live-updates.html)
- [GeekWire — Bezos describes Prometheus (2026)](https://www.geekwire.com/2026/jeff-bezos-describes-his-38b-startup-prometheus-for-the-first-time-nothing-to-do-with-robotics/)
- [SiliconANGLE — General Agents acquisition](https://siliconangle.com/2025/11/26/jeff-bezos-project-prometheus-reportedly-acquires-ai-startup-general-agents/)
- [Forbes — Bezos $100B manufacturing fund](https://www.forbes.com/sites/josipamajic/2026/03/19/jeff-bezos-is-targeting-100-billion-to-acquire-and-automate-the-manufacturing-sector/)
- [Axios — Prometheus worth $41B (Jun 2026)](https://www.axios.com/2026/06/11/prometheus-bezos-industrial-ai)
- [SiliconANGLE — $12B raise (Jun 2026)](https://siliconangle.com/2026/06/11/jeff-bezos-prometheus-raises-12b-accelerate-industrial-engineering-projects/)
- [TechBuzz — General Agents acquisition details](https://www.techbuzz.ai/articles/bezos-6-2b-ai-venture-quietly-acquires-agentic-computing-startup)
- [DEVELOP3D — Prometheus question for CAD](https://develop3d.com/cad/the-prometheus-question-for-cad/)
- [New Space Economy — Prometheus overview](https://newspaceeconomy.ca/2026/06/14/jeff-bezos-prometheus-the-ai-startup-building-an-artificial-general-engineer-to-accelerate-engineering-manufacturing-and-space-innovation/)
- [StartupHub — Bezos AI portfolio 2026](https://www.startuphub.ai/ai-news/ai-figures/2026/figure-jeff-bezos-venture-portfolio-breakdown-2026-07-01)
