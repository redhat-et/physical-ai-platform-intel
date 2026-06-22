# {COMPANY} — Deep Dive Research

**Date**: {YYYY-MM-DD}
**Last updated**: {YYYY-MM-DD}
**Classification**: Internal analysis — not for public repo

Supporting research for the [{COMPANY} competitive profile]({company}.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: OSS foundations analysis, acquisition deep-dives, product architectures, governance risks, and technical dependency chains.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

<!-- Key events: founding, pivots, acquisitions, product launches, partnerships. -->
<!-- Use absolute dates. Focus on events that shaped the Physical AI strategy. -->

| Date | Event |
| --- | --- |
| {YYYY-MM} | {event} |

### Acquisitions — What Each Brought

<!-- Only acquisitions relevant to Physical AI. For each: technology, team, how integrated. -->

#### {Target} ({YYYY})

- **Price**: {$XM/B or undisclosed}
- **Technology**: {what they built, key IP}
- **Integration**: {where it ended up — which product, which team}
- **Significance**: {why it matters for competitive analysis}

---

## 2. Product Architecture Details

<!-- Drill into the architecture of key products listed in the main profile. -->
<!-- For each: internal components, data flow, extension points, runtime dependencies. -->
<!-- Mark sections needing deeper research: <!-- TODO: deep research needed --> -->

### {Product Name}

| Aspect | Details |
| --- | --- |
| **Architecture** | {Component breakdown, data flow} |
| **Runtime dependencies** | {What must be present: specific GPUs, cloud services, proprietary runtimes} |
| **Extension model** | {Plugin API, SDK, or closed} |
| **Key limitations** | {Scalability, hardware lock-in, missing features} |

---

## 3. OSS Foundations Analysis

<!-- The core value of the deep-dive: what open-source software underpins each product? -->
<!-- For each product: which OSS engine, what license, what the vendor adds on top. -->
<!-- This section can be extensive — it supports the main profile's footnote table. -->

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **{Product}** | {OSS project} | {Apache 2.0 / BSD / etc.} | {What vendor adds} |

### Pattern Analysis

<!-- 2-3 paragraphs: what's the overall OSS strategy? -->
<!-- Common patterns: "open engine + proprietary packaging", "OSS wrappers over proprietary core", -->
<!-- "fully proprietary", "genuinely open with foundation governance" -->

### Notable Dependencies

<!-- Highlight surprising or strategically significant OSS dependencies. -->
<!-- e.g., "NIM 2.0 uses vLLM as its sole backend" or "Cosmos 3 initializes from Qwen3-VL" -->

---

## 4. Governance & Community Risk

<!-- For companies that steward OSS projects: analyze the governance health. -->
<!-- Maintainer employment, CLA requirements, commit concentration, foundation affiliation. -->
<!-- Delete section if not applicable (purely proprietary companies). -->

### {OSS Project} Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | {Foundation / multi-vendor / single-vendor} |
| **Core maintainer employment** | {Who employs the maintainers? Concentration risk?} |
| **CLA/DCO** | {CLA required? What kind?} |
| **Commit diversity** | {Top employer %, number of contributing orgs} |
| **Abandonment risk** | {Low / Medium / High — with rationale} |

---

## 5. Hardware Platform Details

<!-- Only for companies with hardware. Technical specs, accelerator details, roadmap. -->
<!-- Delete section if not applicable. -->

### Current Hardware

<!-- Specs tables, accelerator inventories, data flow diagrams as needed. -->

### Roadmap

| Product | Timeline | Key Changes |
| --- | --- | --- |
| **{Next product}** | {H2 2026 / 2027} | {What's new} |

### Pricing

<!-- Pricing model and known price points. -->

---

## 6. Partnership & Ecosystem Details

<!-- Detailed partner analysis beyond what's in the main profile. -->
<!-- Installed base numbers, deal terms, integration depth, exclusivity. -->

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **{Partner}** | {N units} | {JV / integration / reseller} | {API-level / embedded / co-developed} |

### Developer Ecosystem

<!-- Community size, programs, conferences, open-source contributions. -->

---

## 7. Detailed Competitive Analysis

<!-- Deeper comparisons than the main profile's summary table. -->
<!-- Use when there's a complex competitive dynamic worth documenting. -->

### vs {Competitor}

| Dimension | {COMPANY} | {Competitor} |
| --- | --- | --- |
| **{Dimension}** | {factual detail} | {factual detail} |

---

## Sources

<!-- All URLs referenced in this document. -->

- [{Source title}]({URL})
