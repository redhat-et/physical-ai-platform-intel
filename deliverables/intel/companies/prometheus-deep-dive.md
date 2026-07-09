# Prometheus — Deep Dive Research

**Date**: 2026-07-09
**Last updated**: 2026-07-09
**Classification**: Internal analysis — not for public repo

Supporting research for the [Prometheus competitive profile](prometheus.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: leadership backgrounds, acquisition mechanics, technical architecture, infrastructure strategy, competitive dynamics, and the $100B manufacturing fund thesis.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2025-11 | Founded by Jeff Bezos and Vik Bajaj as "Project Prometheus." Launched with $6.2B (partly from Bezos). 120+ employees hired from Meta, OpenAI, xAI, DeepMind |
| 2025-11 | Acquired General Agents (Sherjil Ozair, William Guss). Deal closed 4 days after initial dinner between Bajaj and Ozair |
| 2025-11 | Ashish Vaswani and Jakob Uszkoreit ("Attention Is All You Need" co-authors) join as founding advisors |
| 2025-12 | Discovered conflicting trademark application filed Nov 17 for another AI company named "Prometheus" |
| 2026-02 | Vik Bajaj steps down as CEO of Foresite Labs to focus on Prometheus full-time |
| 2026-03 | Bloomberg reports Bezos exploring $100B manufacturing acquisition fund; pitching sovereign wealth funds in Singapore and Gulf region |
| 2026-04-07 | Kyle Kosic (xAI co-founder, Colossus supercluster architect) hired to lead large-scale infrastructure |
| 2026-04 | Closed $10B round at $38B valuation (JPMorgan, BlackRock among leads) |
| 2026-06-11 | Closed $12B Series B at $41B valuation. First public interviews (CNBC). Renamed from "Project Prometheus" to "Prometheus" |
| 2027 (est.) | Industry analysts expect first commercial product — likely managed service for aerospace, automotive, or pharma |

### Leadership Deep Dive

#### Jeff Bezos — Co-founder & Co-CEO

First operational CEO role since leaving Amazon (Jul 2021). Amazon background relevant: AWS built the "internal innovation → external API" playbook that Prometheus will likely follow. Bezos's other Physical AI adjacencies: Blue Origin (rocket design — potential Prometheus customer), Amazon robotics (warehouse automation — adjacent but not overlapping), $13B Anthropic stake (frontier models via cloud partnership), Trainium (custom silicon to reduce NVIDIA dependence).

#### Vik Bajaj — Co-founder & Co-CEO

PhD physical chemistry (MIT), postdoc UC Berkeley. Career arc: Lawrence Berkeley National Lab → Google X (2013) → co-founded Google Life Sciences (→ Verily) as CSO → GRAIL (cancer detection CSO, 2016–2017; father's cancer death motivated the move) → Foresite Capital managing director (2017) → co-founded Foresite Labs (2018, biotech/AI incubation, launched Xaira Therapeutics) → Prometheus (Nov 2025, stepped down from Foresite Labs Feb 2026). Also: adjunct professor Stanford Medicine, non-executive director at Genomics England.

**Strategic implication**: Bajaj's expertise is life sciences and molecular biology, not mechanical engineering or CAD. This explains the "drug discovery" vertical in Prometheus's target markets and suggests the company may lean toward bio/pharma as a near-term beachhead where Bajaj has deep domain networks. The engineering/manufacturing vision is primarily Bezos's.

#### Kyle Kosic — Infrastructure Lead

MS computer science (Georgia Tech, ML specialization). Career: OpenAI (infrastructure, largest training runs) → xAI co-founder (2023, one of original 11 employees) → built Colossus supercluster in Memphis in 120 days → returned to OpenAI (2024) → Prometheus (Apr 2026). By Mar 2026, all 11 xAI co-founders besides Musk had left; SpaceX acquired xAI.

**Strategic implication**: Kosic's hire confirms Prometheus is building its own large-scale training infrastructure, not just renting hyperscaler GPUs. His experience standing up tens of thousands of GPUs and making them train reliably at scale is the specific capability Prometheus needs for compute-intensive physics model training.

#### Sherjil Ozair — Co-founder (via General Agents)

Former Google DeepMind and Tesla researcher. Co-founded General Agents (2024) and built Ace, the VLA-based computer agent. Became Prometheus co-founder post-acquisition.

#### William Guss — Co-founder (via General Agents)

Former OpenAI scientist. Co-founded General Agents with Ozair. Known for work on foundation agents and autonomous task execution.

### Acquisitions — What Each Brought

#### General Agents (2025)

- **Price**: Undisclosed
- **Technology**: Ace — a "real-time computer autopilot" using a video-language-action (VLA) model. Observes screen content as video, accepts natural-language commands, outputs mouse/keyboard actions at "superhuman speeds" per demos. Capable of editing videos, copying data between applications, booking accommodations. Company claimed it outperformed OpenAI's Operator agent on some tasks. Uses foundation VLA models trained on large datasets
- **Team**: Sherjil Ozair (co-founder, ex-DeepMind/Tesla), William Guss (co-founder, ex-OpenAI). Both elevated to Prometheus co-founders
- **Deal mechanics**: Ozair attended an off-the-record dinner hosted by Bajaj at a San Francisco restaurant. Corporate filings (obtained by Wired) show Bajaj formed the acquisition entity the following morning; the merger closed four days later. Speed suggests either pre-existing relationship or extreme strategic urgency
- **Integration thesis**: Prometheus views Ace not as a productivity tool but as a prototype for agentic systems that can "run manufacturing floors, simulate factory lines, optimize rocket design." The VLA architecture — learning from video observations of physical processes — bridges screen-level task automation and engineering simulation workflows. Prometheus is repurposing a computer-use agent into a physical-world engineering agent
- **Competitive context**: Computer-use VLA is a crowded space (Anthropic Claude computer use, OpenAI Operator, Google Mariner). But Prometheus's angle is different — applying VLA to engineering tool automation rather than general desktop productivity

---

## 2. Product Architecture Details

### AGE (Artificial General Engineer)

| Aspect | Details |
| --- | --- |
| **Architecture** | Foundation model trained to reason about physical design: geometries, materials, tolerances, manufacturing constraints, multi-physics interactions. Training data extends beyond text/code to include sensor telemetry, robotics trajectories, CAD geometries, simulation outputs, and experimental results from chemistry, biology, and materials science. Output: CAD files, simulation results, manufacturing specifications — not motor commands |
| **Training data strategy** | The core challenge: "plausible geometry is cheap, verified geometry is expensive." Prometheus generates specialized synthetic training data for engineering/physics domains — not scraped internet text. The $100B manufacturing fund creates a data flywheel: acquired factories produce sensor logs, materials properties, and manufacturing telemetry tied to real outcomes. Bezos: the work is "very compute-intensive" because of this data generation requirement |
| **Design-to-build vision** | Conceptualized as end-to-end: design a component → simulate failure points → generate manufacturing specifications. Cross-domain: aerospace, civil infrastructure, renewable energy, drug discovery. Autonomous design-to-build cycles without human intervention is the stated long-term goal |
| **Runtime dependencies** | Large-scale GPU clusters for both training and inference. Multi-hyperscaler compute (confirmed: AWS; likely GCP/Azure). Kyle Kosic (ex-xAI Colossus architect) hired to lead infrastructure, suggesting proprietary cluster buildout beyond pure cloud rental. Company acquiring "specialized hardware capable of running high-fidelity physics simulations in parallel with real-time data ingestion" |
| **Extension model** | No public API, SDK, or plugin system. Expected to launch as managed service (industrial-AI platform). No indication of on-premises deployment path |
| **Key limitations** | Pre-product with no public demo, benchmark, or technical paper. DEVELOP3D noted "relatively few team members seem to have any background in CAD or experience of building the physical world." Physics simulation accuracy requirements for safety-critical domains (aerospace, medical) are far more stringent than language model quality bars. Regulatory certification (FAA/EASA/ISO) required for aerospace/automotive design tools — a multi-year process regardless of model quality |

### Ace (General Agents)

| Aspect | Details |
| --- | --- |
| **Architecture** | Video-language-action (VLA) foundation model for computer use. Observes screen content as continuous video stream, accepts natural language task descriptions, outputs mouse/keyboard action sequences. Real-time execution loop — a competitor CEO noted: "What General Agents really cracked early on is speed — Ace runs on your computer at lightspeed" |
| **Capabilities demonstrated** | Video editing, cross-application data transfer, booking accommodations, procurement tasks, recruitment workflows, data entry, creative work. Claimed to outperform OpenAI Operator on some benchmarks |
| **Runtime dependencies** | Pre-acquisition: standalone agent running on user's computer. Post-acquisition integration path unclear — being repurposed from desktop productivity toward manufacturing/engineering tool automation |
| **Extension model** | No public plugin system or API |
| **Key limitations** | Competitive space: Anthropic Claude computer use, OpenAI Operator, Google Project Mariner all target the same screen-level VLA capability. Prometheus's differentiation is vertical application to engineering, not general desktop tasks |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **AGE** | Likely PyTorch or JAX (unconfirmed) | N/A | Entire product proprietary: training data pipelines, physics reasoning models, design generation, simulation integration |
| **Ace** | VLA model architecture (no known OSS base) | N/A | Foundation VLA model, real-time execution runtime, task automation framework |
| **Training infra** | Likely builds on standard GPU cluster tooling | N/A | Kyle Kosic's expertise suggests custom training orchestration (comparable to xAI Colossus stack) |

### Pattern Analysis

Prometheus operates in full stealth with no open-source strategy — the most closed company in the Physical AI space relative to its valuation. Comparison:

| Company | Valuation | OSS posture |
| --- | --- | --- |
| **Prometheus** | $41B | Zero: no code, no weights, no papers, no API |
| **Physical Intelligence** | $5.6B | Open weights (openpi, 12.5K stars), Apache 2.0 code |
| **Skild AI** | $14B | Fully proprietary but published research papers |
| **PhysicsX** | $2.4B | Proprietary but publishes technical blog posts |

This is consistent with Bezos's historical approach at Amazon: build internally, expose via API when ready, never give away competitive advantage. The absence of open-source engagement is notable given that advisors Vaswani and Uszkoreit created the Transformer — an open publication that enabled modern AI. The closed posture suggests a deliberate strategy to build defensibility via proprietary training data (engineering telemetry, materials data, manufacturing outcomes) rather than model architecture.

Given the team composition (DeepMind, OpenAI, xAI alumni), Prometheus almost certainly uses standard OSS training frameworks (PyTorch, JAX, CUDA) and cluster management tools internally. But nothing is contributed back, and no dependency information is public.

### Notable Dependencies

No confirmed OSS dependencies. The $12B compute allocation and Kosic hire suggest building proprietary training infrastructure comparable to xAI's Colossus or OpenAI's internal clusters, layered on top of standard GPU tooling.

---

## 4. Governance & Community Risk

Not applicable — Prometheus stewards no open-source projects and has no public community presence. No GitHub organization, no technical blog, no public documentation. The company discovered a conflicting trademark application in December 2025 from another AI company also named "Prometheus."

---

## 5. Hardware Platform Details

### Compute Infrastructure Strategy

Prometheus is a pure software company but its infrastructure strategy is significant:

| Dimension | Details |
| --- | --- |
| **Current compute** | Multi-hyperscaler: confirmed AWS customer; likely also GCP and Azure |
| **Infrastructure lead** | Kyle Kosic — built xAI's Colossus (100K+ GPU supercluster, assembled in 120 days) |
| **Capital allocation** | "Most of the $12B" earmarked for computing infrastructure (per reports) |
| **Specialized hardware** | Acquiring hardware for "high-fidelity physics simulations in parallel with real-time data ingestion" |
| **Bezos compute synergies** | AWS (hyperscaler), Trainium (custom AI silicon to reduce NVIDIA dependence). No formal deals but obvious Bezos portfolio alignment |

The Kosic hire signals that Prometheus is building proprietary training infrastructure — not just renting cloud GPUs. This is consistent with the xAI playbook (build your own cluster for maximum control over training) rather than the typical startup playbook (rent from hyperscalers).

### Roadmap

| Initiative | Timeline | Key Changes |
| --- | --- | --- |
| **Proprietary training cluster** | H2 2026 (est.) | Kosic building out GPU infrastructure for physics model training |
| **First commercial product** | 2027 (est.) | Managed service for aerospace, automotive, or pharma customers |
| **$100B manufacturing fund** | 2026–2027 (in talks) | Acquisition vehicle for industrial companies → data flywheel |

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **AWS** | N/A | Compute customer | Cloud infrastructure; no product integration. Bezos floated Amazon partnership for data center optimization but no formal deal |
| **Blue Origin** | N/A | Potential customer | Bezos: "case study for a customer." Rocket/spacecraft design is target use case. No corporate ties |
| **JPMorgan** | N/A | Series B lead investor | Financial; Jamie Dimon in discussions for $100B fund |
| **BlackRock** | N/A | Series B investor | Financial |
| **Goldman Sachs** | N/A | Series B investor | Financial |
| **DST Global** | N/A | Series B investor | Financial; also backs other frontier AI companies |
| **Arch Venture Partners** | N/A | Series B investor | Financial; biotech/deep-tech focus aligns with Bajaj's background |
| **Abu Dhabi Investment Authority** | N/A | In discussions | Potential investor in $100B manufacturing fund |
| **Singapore sovereign wealth** | N/A | In discussions | Potential investor in $100B manufacturing fund |

### The $100B Manufacturing Fund — Detailed Analysis

Bloomberg reported (March 2026) that Bezos was raising ~$100B for a "perpetual capital vehicle" likened to "Berkshire Hathaway for the AI age." Key details:

- **Strategy**: Acquire controlling stakes in manufacturing companies with large order backlogs but outdated infrastructure, primarily in chipmaking, defense, and aerospace. Deploy Prometheus AI to modernize operations from the inside
- **Data flywheel thesis**: Acquired factories produce terabytes of sensor data from machines — structured, high-quality engineering/manufacturing data tied to real outcomes. This is the training data that no public dataset can provide. "The bottleneck for physical AI is not compute — it is data"
- **Demand channel**: Fund-owned factories become captive customers for Prometheus's tools, creating guaranteed revenue
- **Investor pitch**: Bezos personally travelling to Singapore and Middle East, pitching sovereign wealth funds and major asset managers
- **Competitive context**: Travis Kalanick's Atoms targets smart manufacturing. Thrive Capital and General Catalyst launched vehicles to acquire legacy industrial firms. Prometheus fund would be significantly larger than all of these
- **Current status**: No public roadmap, named acquisition target, or official announcement of a closed fund. The signal is real but the timeline is uncertain

### Developer Ecosystem

No developer ecosystem exists. No public website, no documentation, no API, no developer program, no conference presence. One public interview (CNBC, June 2026). One Wikipedia page. This is the most opaque company in the Physical AI space relative to its $41B valuation.

---

## 7. Detailed Competitive Analysis

### vs CAD Incumbents (Autodesk, Dassault Systèmes, PTC, Siemens)

| Dimension | Prometheus | CAD Incumbents |
| --- | --- | --- |
| **Product maturity** | Pre-product; 2027 expected | Decades of shipping products |
| **Enterprise relationships** | None | Thousands of enterprise customers across all industrials |
| **Regulatory compliance** | Unproven | FAA/EASA/ISO certified for safety-critical design |
| **AI integration** | AI-native from scratch | Bolt-on AI features: Autodesk Fusion generative design, Dassault SOLIDWORKS 2026 AURA, PTC Creo 12 thermal GD, Siemens NX Design Copilot |
| **AI maturity** | No shipping AI features | Incumbents shipping: generative rendering, AI chatbots, topology optimization, AI-assisted assembly. DEVELOP3D notes "most AI CAD design tools in 2026 solve problems engineers don't actually have" |
| **Data access** | Building via $100B fund (future) | Decades of customer engineering data (not owned by vendor) |
| **Funding** | $18B+ | Revenue-funded; Autodesk ~$5.8B annual revenue; CAD is ~$13B category |
| **Domain expertise** | AI generalists; few CAD/manufacturing hires noted | Deep domain expertise in engineering, manufacturing, regulatory |

**Key risk for Prometheus**: The incumbents' moat is certification and regulatory compliance, not technology. Aerospace design tools require FAA/EASA certification. Automotive requires ISO 26262 tool qualification. Medical devices require FDA validation. Prometheus cannot sell into safety-critical industries without years of compliance work, regardless of model quality. This constrains the near-term addressable market to non-safety-critical applications (early-stage concept design, materials exploration, non-certified prototyping).

**Key opportunity for Prometheus**: Incumbents are bolting AI onto legacy architectures built decades ago. DEVELOP3D observed that "pure, standalone AI that performs complete workflows without any CAD software does not yet exist" — that is precisely what Prometheus aims to build. If they succeed, they leapfrog rather than compete with existing tools.

### vs PhysicsX

| Dimension | Prometheus | PhysicsX |
| --- | --- | --- |
| **Funding** | $18B+ ($41B valuation) | $489M ($2.4B valuation, Jun 2026 Series C) |
| **Product status** | Pre-product | Shipping: 2x YoY revenue, 3x booked revenue, 2x customer count |
| **Approach** | Foundation model for all engineering ("AGE") | "Large Physics Models" — domain-specific AI for physics simulation |
| **Target verticals** | Aerospace, automotive, manufacturing, drug discovery | Aerospace & defense, semiconductors, industrial machinery, automotive, energy |
| **Backers** | JPMorgan, BlackRock, Goldman Sachs, Bezos | Siemens, NVIDIA (NVentures), Applied Materials, Atomico, Temasek, General Catalyst |
| **Team** | AI generalists from DeepMind/OpenAI; few CAD/manufacturing hires | Founded by F1 engineers (Jacomo Corbo ex-QuantumBlack/McKinsey, Robin Tuluie ex-Renault Alpine F1/Bentley); physics PhDs + domain experts |
| **Key customer** | None (pre-product) | Applied Materials (validation partner), F1 teams, aerospace firms |
| **Integration** | Standalone managed service (expected) | Integrating with Siemens Xcelerator digital twin platform |
| **Offices** | SF, London, Zurich | London, New York, Bay Area, Singapore |

**Analysis**: PhysicsX is the "boring but working" competitor. Domain-specific models with validated physics accuracy, shipping customers, strategic partnerships with Siemens (distribution channel to industrial customers) and NVIDIA (hardware optimization). Prometheus has 37x the funding but zero revenue, zero product, and zero customer validation. PhysicsX predicts physics behavior "in seconds rather than hours or days" — if Prometheus's general-purpose approach achieves similar accuracy, it could subsume PhysicsX's market. If it cannot match physics fidelity in specific domains, PhysicsX's vertical focus wins.

Semiconductors are expected to be PhysicsX's largest segment in 2026. If Prometheus targets the same vertical, it faces a competitor with a 2+ year head start and Applied Materials as a validation partner.

### vs AI Design Startups

| Dimension | Prometheus | AI Design Startups |
| --- | --- | --- |
| **Scale of ambition** | Full engineering workflow | Narrow slices: Leo AI (text-to-CAD), MecAgent (CAD copilot), Neural Concept (physics-aware GD), Vizcom (rendering) |
| **Funding** | 100x+ larger | $5M–$50M range |
| **Risk** | Massive execution risk at scale | Lower risk, narrower scope |
| **Time to market** | 2027+ | Many already shipping |
| **Domain focus** | Horizontal across industries | Usually single-domain |

These startups are unlikely direct competitors — more likely acquisition targets or future ecosystem partners. Several could be absorbed by the $100B manufacturing fund or by Prometheus directly.

### vs Broader AI Labs (OpenAI, Anthropic, Google DeepMind)

| Dimension | Prometheus | General-Purpose AI Labs |
| --- | --- | --- |
| **Focus** | Physical-world engineering only | General-purpose intelligence |
| **Computer use** | Ace (via General Agents) — repurposed for engineering | Claude computer use, Operator, Mariner — general desktop productivity |
| **Physics understanding** | Core mission: models that reason about physics | Emerging but not primary: o3 on physics benchmarks, but not engineering-grade |
| **Data strategy** | Proprietary engineering data via industrial acquisitions | Internet-scale text, code, images |
| **Moat** | Domain-specific training data + vertical integration | Scale, brand, developer ecosystems |

The general-purpose labs could pivot to engineering tools — o3-level reasoning applied to physics problems is directionally similar to what Prometheus builds. But Prometheus bets that engineering-grade physics reasoning requires domain-specific training data that internet-scale models cannot provide.

---

## 8. Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |
| **No product ships by 2028** | Medium | High — $18B+ burn with no revenue | $100B fund creates alternative revenue path via industrial acquisitions |
| **Physics accuracy insufficient for safety-critical domains** | Medium-High | High — eliminates aerospace/automotive markets | May pivot to non-safety-critical applications first (concept design, materials exploration) |
| **CAD incumbents integrate competitive AI faster** | Medium | Medium — erodes greenfield advantage | Incumbents' bolt-on approach limits depth; Prometheus aims for AI-native leapfrog |
| **Key talent defection** | Medium | Medium — AI talent market is hyper-competitive | $5M+ comp packages; Bezos brand as draw |
| **$100B fund fails to close** | Medium | High — eliminates data flywheel and captive demand channel | Can still build via data partnerships rather than acquisitions |
| **Bezos distraction (Blue Origin, Amazon board, personal)** | Low | Medium — co-CEO structure with Bajaj provides redundancy | Bajaj handles day-to-day; Bezos provides strategic vision and fundraising |

---

## Sources

- [Built In — Project Prometheus explainer](https://builtin.com/articles/what-is-project-prometheus)
- [CNBC — Bezos opens up after $12B raise (Jun 2026)](https://www.cnbc.com/2026/06/11/project-prometheus-bezos-bajaj-live-updates.html)
- [GeekWire — Bezos describes Prometheus (2026)](https://www.geekwire.com/2026/jeff-bezos-describes-his-38b-startup-prometheus-for-the-first-time-nothing-to-do-with-robotics/)
- [SiliconANGLE — General Agents acquisition](https://siliconangle.com/2025/11/26/jeff-bezos-project-prometheus-reportedly-acquires-ai-startup-general-agents/)
- [Forbes — Bezos $100B manufacturing fund](https://www.forbes.com/sites/josipamajic/2026/03/19/jeff-bezos-is-targeting-100-billion-to-acquire-and-automate-the-manufacturing-sector/)
- [TechCrunch — Prometheus raises $12B (Jun 2026)](https://techcrunch.com/2026/06/11/jeff-bezoss-prometheus-raises-12b-to-build-an-artificial-general-engineer-for-the-physical-world/)
- [Axios — Prometheus worth $41B (Jun 2026)](https://www.axios.com/2026/06/11/prometheus-bezos-industrial-ai)
- [SiliconANGLE — $12B raise (Jun 2026)](https://siliconangle.com/2026/06/11/jeff-bezos-prometheus-raises-12b-accelerate-industrial-engineering-projects/)
- [FullStackEvolved — Kosic hire (Apr 2026)](https://www.fullstackevolved.com/blog/project-prometheus-kyle-kosic-xai-2026-04-08/)
- [Silicon Republic — Kosic xAI background](https://www.siliconrepublic.com/business/ft-jeff-bezos-project-prometheus-taps-xai-co-founder-kyle-kosic)
- [Storyboard18 — Vik Bajaj background](https://www.storyboard18.com/brand-makers/who-is-vik-bajaj-the-indian-origin-scientist-helping-jeff-bezos-build-prometheus-100947.htm)
- [Wikipedia — Vik Bajaj](https://en.wikipedia.org/wiki/Vik_Bajaj)
- [PYMNTS — General Agents Ace product](https://www.pymnts.com/artificial-intelligence-2/2025/jeff-bezos-ai-startup-acquires-computer-agent-maker-general-agents/)
- [PhysicsX — $300M Series C (Jun 2026)](https://www.physicsx.ai/newsroom/physicsx-announces-300m-series-c-to-accelerate-physics-ai-for-industrial-engineering)
- [DEVELOP3D — Prometheus question for CAD](https://develop3d.com/cad/the-prometheus-question-for-cad/)
- [Engineering.com — AI features coming to CAD 2026](https://www.engineering.com/3-ai-features-coming-to-every-cad-program-in-2026/)
- [ChatForest — Prometheus AGE overview](https://chatforest.com/reviews/jeff-bezos-project-prometheus-artificial-general-engineer-manufacturing-ai-2026/)
- [New Space Economy — Prometheus overview](https://newspaceeconomy.ca/2026/06/14/jeff-bezos-prometheus-the-ai-startup-building-an-artificial-general-engineer-to-accelerate-engineering-manufacturing-and-space-innovation/)
- [Metaintro — Prometheus talent hiring](https://www.metaintro.com/blog/bezos-project-prometheus-ai-talent-hiring-2026)
- [StartupHub — Bezos AI portfolio 2026](https://www.startuphub.ai/ai-news/ai-figures/2026/figure-jeff-bezos-venture-portfolio-breakdown-2026-07-01)
- [Wikipedia — Prometheus (company)](https://en.wikipedia.org/wiki/Prometheus_(company))
