# Physicl — Deep Dive Research

**Date**: 2026-09-16
**Last updated**: 2026-09-16
**Classification**: Internal analysis — not for public repo

Supporting research for the [Physicl competitive profile](physicl.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, acquisition deep-dives, product architectures, governance risks, and technical dependency chains.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2017 | Nfinite founded by Alex de Vigan — 3D visual content platform for product marketing |
| 2022-06 | Nfinite raises $100M Series B (total $130M+ raised) |
| 2026-01 | Nfinite announces Getty Images partnership: 2D→3D transformation for spatially-aware AI training |
| 2026-03-17 | Physicl emerges from stealth at NVIDIA GTC — spinout from Nfinite, led by Alex de Vigan as CEO with 30-person team (6+ years together) |
| 2026-03 | Launch: 3,000+ assets live; targets 30K by May 1, 100K by July 1, 1M by 2027 |
| 2026 (ongoing) | Customers: Meta, DeepMind, World Labs, Getty Images, Adobe, AWS, Microsoft, Unity, OpenAI, Stanford (187+ teams total) |

**Nfinite → Physicl spinout rationale**: Nfinite built one of the largest pipelines of high-fidelity 3D digital twins for product marketing/e-commerce. Physicl applies this 3D asset expertise to Physical AI training data — different use case (robotics simulation vs product visualization) but same core competency (parametric 3D modeling at scale).

### Acquisitions — What Each Brought

<!-- TODO: deep research needed --> No acquisitions identified. Physicl is itself a spinout/new entity from Nfinite parent company.

---

## 2. Product Architecture Details

### Physicl Platform

| Aspect | Details |
| --- | --- |
| **Architecture** | Five-step pipeline: (1) Data Model (10K+ category ontology), (2) Parametric Model (structure + constraints), (3) 3D Asset (parametric parts + materials), (4) Physics Properties (mathematically deduced from known geometry/materials, not estimated), (5) Validation (RLHF with 10K+ global network of 3D specialists, physics reviewers, simulation engineers). Assets export as OpenUSD with UsdPhysics schemas or URDF for ROS integration. |
| **Runtime dependencies** | Target simulators: NVIDIA Isaac Sim, MuJoCo, Unreal Engine, Meta Habitat, NVIDIA Omniverse. Multi-simulator strategy — no single-engine lock-in. Python SDK + REST API for pipeline integration. |
| **Extension model** | API-first architecture designed for training loop integration. Ingest → normalize → augment → validate → deploy workflow. Parametric scene generation produces "infinite permutations" across lighting, layouts, materials, configurations. |
| **Key limitations** | Launch catalog (3K) smaller than competitors today (Lightwheel 2K, Imagine.io 2.5K, Palatial 10K); scaling from 3K → 1M in 18 months is ambitious. Physics derivation via parametric models (not empirical measurement like Lightwheel) — unclear which approach achieves better sim-to-real transfer at scale. |

### Asset Quality & Validation

| Aspect | Details |
| --- | --- |
| **Quality metrics** | 98% sim-ready rate, 98% QC pass rate. Three RLHF validation levels via 10K+ global network. Production capacity: 100,000 assets/month. |
| **Physics methodology** | "Physics calculated, not guessed" — parametric models where geometry and materials are fully known, physics properties (mass, inertia, friction, restitution) are mathematically deduced. Example: steel pan vs plastic pan of identical geometry behave differently based on material properties. |
| **Required asset properties** | (1) USD format with full hierarchy, material references, physics properties intact. (2) Dual-mesh: visual + clean collision geometry. (3) Mass/inertia derived from actual materials. (4) Per-surface physics material assignments. (5) Verified simulation behavior (no jitter, correct fall speed, no surface penetration). |
| **Asset categories** | Rigid (static objects), articulated (joints/moving parts), deformable (cloth/foam). Focus on articulated and deformable categories — identified as "hardest to source." |

### Domain Coverage Strategy

| Aspect | Details |
| --- | --- |
| **Target domains** | Home, commercial, industrial, healthcare environments. Positioned as complementary to NVIDIA SimReady library: "SimReady covers industrial and warehouse domains well. Physicl fills the gaps and goes further: domestic environments, commercial spaces, large-scale object variation." |
| **Differentiation** | Thousands of variations from single base model. Domain breadth (home/commercial vs competitors' kitchen/warehouse focus). Articulated and deformable asset emphasis (harder categories). |

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **Physicl Platform** | OpenUSD (format), URDF (ROS format) | Apache 2.0 (OpenUSD), BSD (URDF) | Proprietary parametric modeling engine (10K+ category ontology), physics derivation algorithms, RLHF validation network (10K+ specialists), Python SDK + REST API integration layer |

### Pattern Analysis

Physicl follows an **"open format, proprietary generation"** strategy identical to Lightwheel and Imagine.io. Assets delivered in fully open OpenUSD and URDF formats ensure portability, but the competitive moat is the parametric modeling pipeline that generates assets at scale (100K/month capacity).

**Multi-format support** (USD + URDF) is broader than pure USD-only competitors, signaling ROS ecosystem support — important for industrial robotics customers not fully committed to NVIDIA Isaac/Omniverse stack.

**API/SDK open-source status**: Unknown whether Python SDK is open-source or proprietary client library. REST API suggests standard HTTP integration regardless of client language.

### Notable Dependencies

- **OpenUSD**: Complete dependency on USD as primary asset interchange format. Assets use `UsdPhysics`, `UsdPhysicsJoint`, `UsdPreviewSurface` schemas.
- **URDF**: Support for Unified Robot Description Format signals ROS ecosystem targeting — differentiates from NVIDIA-exclusive competitors.
- **Multi-simulator validation**: Unlike NVIDIA-centric competitors, Physicl validates against Isaac Sim, MuJoCo, Unreal, Habitat. This multi-simulator testing represents significant engineering investment (different physics engines, different USD importers, different validation requirements).

### Parametric Modeling as Proprietary Moat

**10K+ category ontology**: Physicl's data model categorizes objects into 10,000+ categories with parametric constraints. This ontology is the secret sauce — it encodes how objects are structured (parts, relationships, materials) such that physics can be mathematically derived rather than approximated.

**Example workflow**:

1. Data Model: "Kitchen knife" category with parametric constraints (blade material, handle material, blade geometry type)
2. Parametric Model: Generate instance (8-inch chef's knife, stainless steel blade, wooden handle)
3. 3D Asset: Combine parametric parts (blade mesh, handle mesh) with materials
4. Physics Properties: Calculate mass/inertia from steel density × blade volume + wood density × handle volume; friction from steel/wood surface properties
5. Validation: Simulate in Isaac Sim — verify it doesn't jitter, falls at correct speed, interacts properly with cutting board surface

**Contrast with competitors**:

- **Lightwheel**: Empirical measurement in Physics Factory → ground-truth parameters
- **Physicl**: Parametric deduction from known geometry/materials → calculated parameters
- **Imagine.io/Palatial**: Unclear methodology — claim "measured" or "physics-accurate" but don't document approach

---

## 4. Governance & Community Risk

<!-- Not applicable — Physicl does not steward any OSS projects. They consume OpenUSD (AOUSD-governed) and URDF (ROS/OSRA-governed) but do not contribute to governance. -->

**No OSS contributions identified** in GitHub search. Unlike Lightwheel (259 OSS assets on GitHub), Physicl has not open-sourced sample assets or tooling for community adoption.

---

## 5. Hardware Platform Details

<!-- Not applicable — pure software/data company. -->

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **Getty Images** | N/A (content partner) | Strategic collaboration (January 2026) to transform Getty's 2D creative imagery into high-fidelity 3D scenes with physical context. Enables spatially-aware AI training from Getty's vast licensed content library. | Deep integration — Nfinite/Physicl's 2D→3D transformation pipeline applied to Getty catalog |
| **NVIDIA** | N/A (platform partner) | Assets export to Isaac Sim/Omniverse; Physicl presented at NVIDIA GTC 2026. Positioned as **complementary** to NVIDIA SimReady library ("fills gaps SimReady doesn't cover"). | API-level integration via OpenUSD; no exclusive partnership (multi-simulator strategy) |
| **Meta** | Unknown | Customer using Physicl platform for Physical AI training data | Unknown integration depth |
| **DeepMind** | Unknown | Customer using Physicl platform (likely for world model training) | Unknown integration depth |
| **World Labs** | Unknown | Customer using Physicl platform (Fei-Fei Li's world model startup) | Unknown integration depth |
| **Adobe, AWS, Microsoft, Unity, OpenAI, Stanford** | Unknown | Customers/technology partners (187+ teams total claim) | Unknown integration depth |

### Developer Ecosystem

**No public community programs** identified — no Discord, Slack, GitHub community, or open assets. Contrast with:

- Lightwheel: 259 OSS assets on GitHub
- Palatial: Natural language agent interface demo at SIGGRAPH 2026
- Imagine.io: 25-post blog educating on SimReady standards

**API/SDK self-service model** suggests low-touch sales for smaller customers, but no evidence of developer community building or ecosystem evangelism.

**Validation network**: 10K+ global network of 3D specialists, physics reviewers, simulation engineers represents significant human-in-the-loop infrastructure. This network is likely contract-based (not employee-based given 30-person team size), similar to Scale AI's annotation workforce model.

---

## 7. Detailed Competitive Analysis

### vs Lightwheel

| Dimension | Physicl | Lightwheel |
| --- | --- | --- |
| **Physics methodology** | Parametric deduction from known geometry/materials | Empirical measurement in Physics Measurement Factory |
| **Catalog size (today)** | 3,000+ at launch (Mar 2026) | 2,000+ (June 2026) |
| **Catalog ambition** | 1,000,000 by 2027 | Unknown — focus on quality over scale |
| **Production capacity** | 100,000 assets/month | Unknown |
| **Business model** | API/SDK self-service, 187+ customers | Enterprise sales, 7 named tier-1 customers |
| **Simulator support** | Isaac Sim, MuJoCo, Unreal, Habitat, Omniverse (multi-sim) | Isaac Sim, Newton (NVIDIA-centric) |
| **Evaluation platform** | None | RoboFinals for VLA/world model testing |
| **Funding** | Nfinite parent ($130M+), Physicl-specific unknown | ~$280M, unicorn valuation |
| **Founder background** | Alex de Vigan (Nfinite 3D product visualization) | Steve Xie (Cruise/NVIDIA/NIO autonomous driving simulation) |

**Assessment**: Physicl prioritizes **scale** (1M target) and **multi-simulator portability** vs Lightwheel's **measured-physics quality** and **NVIDIA ecosystem depth**. Physicl's API self-service targets broader market (smaller teams, diverse simulators) vs Lightwheel's enterprise focus (top AI labs, NVIDIA stack).

### vs Imagine.io

| Dimension | Physicl | Imagine.io |
| --- | --- | --- |
| **Catalog size (today)** | 3,000+ at launch | 2,500+ |
| **Catalog ambition** | 1,000,000 by 2027 | Incremental growth from 2,500 base |
| **Physics methodology** | Parametric deduction ("calculated not guessed") | "Measured physics" claimed, methodology undisclosed |
| **Business model** | API/SDK self-service | Custom environment building service + catalog licensing |
| **Parametric variation** | Infinite permutations via API (lighting, layouts, materials, configurations) | Parametric variation API/dashboard (materials, placements, lighting, density) |
| **Simulator support** | Isaac Sim, MuJoCo, Unreal, Habitat (multi-sim) | Isaac Sim only (NVIDIA-centric) |
| **Domain coverage** | Home, commercial, industrial, healthcare (broad) | Kitchen/home environments (focused) |
| **Funding** | Nfinite parent ($130M+) | $7.1M Series A |

**Assessment**: Physicl's 1M ambition and multi-simulator strategy target **broader market** vs Imagine.io's **focused catalog + custom services** niche. Physicl's API self-service vs Imagine.io's custom environment building represents different GTM: self-serve at scale vs white-glove for premium customers.

### vs Palatial

| Dimension | Physicl | Palatial |
| --- | --- | --- |
| **Catalog size (today)** | 3,000+ at launch (Mar 2026) | 10,000 generated (recent months) |
| **Production speed** | 100,000 assets/month capacity | Automated pipeline — generated 10K in "last couple months" (~2-5K/month implied) |
| **Automation level** | Parametric pipeline with RLHF validation | Fully automated pipeline (V1.0), agent-guided multimodal |
| **Articulation/soft-body** | Articulated + deformable (cloth/foam) focus | Only automated pipeline for articulated; supports soft-body (cables, clothing) |
| **User interface** | API/SDK (programmatic) | Natural language agent interface (SIGGRAPH 2026 announcement) |
| **Domain coverage** | Home, commercial, industrial, healthcare | Homes, warehouses, factories, construction sites |
| **Founder background** | Alex de Vigan (Nfinite 3D product visualization) | Steven Ren (ex-Tesla) |
| **Validation** | SimReady Foundation validation via NVIDIA Omniverse CAD-to-SimReady | SimReady Foundation validation |

**Assessment**: Palatial's **automated pipeline speed** (10K generated recently) vs Physicl's **manual capacity** (100K/month claim but from 30-person + 10K-contractor network) suggests different approaches: Palatial prioritizes **automation**, Physicl prioritizes **quality via human-in-the-loop**. Both target 1M+ scale, but Palatial's agent interface (natural language → asset) is more accessible than API/SDK for non-technical users.

---

## Sources

- [Physicl.ai](https://www.physicl.ai/)
- [Physicl Company page](https://www.physicl.ai/company)
- [Isaac Sim Assets Built for Physics, Not Just Rendering](https://www.physicl.ai/insights/isaac-sim-assets)
- [Physicl emerges from stealth at NVIDIA GTC](https://theaiinsider.tech/2026/03/18/physicl-emerges-from-stealth-with-data-infrastructure-layer-for-physical-ai/)
- [Physicl launches data infrastructure layer — PR Newswire](https://www.prnewswire.com/news-releases/physicl-launches-the-data-infrastructure-layer-for-physical-ai-at-nvidia-gtc-302715165.html)
- [Nfinite launches Physicl at NVIDIA GTC](https://nfinite.ai/blog/physicl-launches-at-nvidia-gtc)
- [Alex de Vigan LinkedIn](https://www.linkedin.com/in/alex-de-vigan-26388015/)
- [Quentin Verriere LinkedIn](https://www.linkedin.com/in/qntvrr/)
- [Getty Images + Nfinite partnership](https://newsroom.gettyimages.com/en/getty-images/nfiniteai-collaborates-with-getty-images-to-bring-2d-visual-content-into-the-3d-physical-ai-era)
- [Nfinite Company Profile — PitchBook](https://pitchbook.com/profiles/company/265057-93)
