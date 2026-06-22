# {BUILDING BLOCK} — Solution Comparison

**Date**: {YYYY-MM-DD}
**Last updated**: {YYYY-MM-DD}
**Building block**: {name from building-blocks.md}
**Classification**: Internal analysis — not for public repo

Compares solutions for the **{building block}** platform capability to inform Red Hat's build/partner/integrate decision.

**Solutions compared**: {Solution A (Vendor)} | {Solution B (Vendor)} | {Solution C (Vendor)} | ...

---

## Decision Summary

<!-- The "bottom line up front" — what should Red Hat do? -->
<!-- filled by: project-comparison skill -->

**Recommended pick**: **{Solution (Vendor)}** — {1-2 sentence rationale covering community fit, technical fit, and strategic fit.}

**Runner-up**: **{Solution (Vendor)}** — {why it's second and when it might be preferred.}

---

## Feature Comparison

<!-- Feature dimensions identified from building-blocks.md description + project capabilities sections. -->
<!-- Use ✅ / ⚠️ / ❌ for boolean features; comma-separated lists for multi-valued features (e.g., supported backends). -->

| Feature | {Solution A (Vendor)} | {Solution B (Vendor)} | {Solution C (Vendor)} |
| --- | --- | --- | --- |
| **{Feature 1}** | {✅ / ⚠️ / ❌ + detail} | {detail} | {detail} |
| **{Feature 2}** | {value list, e.g., "CUDA, ROCm, Metal"} | {value list} | {value list} |

---

## Lock-in Comparison

<!-- Summarized from project report Lock-in Assessment sections. -->

| Dimension | {Solution A (Vendor)} | {Solution B (Vendor)} | {Solution C (Vendor)} |
| --- | --- | --- | --- |
| **Hardware lock-in** | {Low/Med/High} — {detail} | {detail} | {detail} |
| **Vendor lock-in** | {Low/Med/High} — {detail} | {detail} | {detail} |
| **Ecosystem lock-in** | {Low/Med/High} — {detail} | {detail} | {detail} |

---

## Production Adoption

<!-- Who uses each solution in production? Summarized from project report Production Adoption sections. -->

| Solution | Notable Users |
| --- | --- |
| **{Solution A (Vendor)}** | {Company 1 (use case), Company 2 (use case), ...} |
| **{Solution B (Vendor)}** | {Company 1 (use case), ...} |
| **{Solution C (Vendor)}** | {Company 1 (use case), ...} |

---

## Red Hat Platform Fit

<!-- How does each solution fit into the Red Hat Physical AI Platform? -->

| Dimension | {Solution A (Vendor)} | {Solution B (Vendor)} | {Solution C (Vendor)} |
| --- | --- | --- | --- |
| **Runs on OpenShift** | {Yes / With effort / No} | {ditto} | {ditto} |
| **RHEL compatible** | {Yes / Partial / No} | {ditto} | {ditto} |
| **License compatible** | {Yes / Caution / No} | {ditto} | {ditto} |
| **Contribution model** | {Open / CLA / Closed} | {ditto} | {ditto} |
| **Vendor relationship** | {Partner / Neutral / Competitor} | {ditto} | {ditto} |
| **Platform fit** | {Build / Partner / Integrate} | {ditto} | {ditto} |

---

## Health & Risk Comparison

<!-- Summarized from project-health-eval and project-tech-eval reports. -->
<!-- Link to full reports: [full report](../projects/{project}.md) -->

| Dimension | {Solution A (Vendor)} | {Solution B (Vendor)} | {Solution C (Vendor)} |
| --- | --- | --- | --- |
| **License** | {SPDX} | {SPDX} | {SPDX / Proprietary} |
| **Governance** | {type} | {type} | {type} |
| **Contributor diversity** | {High/Med/Low} | {High/Med/Low} | {n/a if proprietary} |
| **Corporate control risk** | {Low/Med/High} | {Low/Med/High} | {n/a} |
| **Community health** | {Active/Maintained/...} | {Active/...} | {n/a} |
| **Tech stack alignment** | {Aligned/Neutral/Misaligned} | {ditto} | {ditto} |
| **Hardware portability** | {Portable/Limited/Locked} | {ditto} | {ditto} |
| **Dependency health** | {Healthy/Watch/Risky} | {ditto} | {ditto} |
| **Security posture** | {Strong/Adequate/Weak} | {ditto} | {ditto} |

---

## Architecture Comparison

<!-- How do the solutions differ architecturally? -->
<!-- Focus on: design philosophy, extension model, runtime requirements, scalability -->

| Aspect | {Solution A (Vendor)} | {Solution B (Vendor)} | {Solution C (Vendor)} |
| --- | --- | --- | --- |
| **Design philosophy** | {e.g., "modular plugin"} | {e.g., "monolithic"} | {e.g., "cloud API"} |
| **Runtime requirements** | {e.g., "CUDA GPU"} | {e.g., "CPU or GPU"} | {e.g., "cloud only"} |
| **Extension model** | {plugin / SDK / fork} | {ditto} | {ditto} |
| **Data format** | {USD / URDF / custom} | {ditto} | {ditto} |
| **Key dependencies** | {major deps} | {major deps} | {major deps} |

---

## Recommendation Rationale

<!-- Detailed justification for the recommended pick. -->
<!-- Address: Why this one? What are we giving up? What are the conditions? -->

### Why {Recommended Solution (Vendor)}

<!-- 3-5 bullets: strongest arguments -->

- {argument 1}
- {argument 2}

### What we give up

<!-- Tradeoffs vs the runner-up -->

- {tradeoff 1}
- {tradeoff 2}

### Conditions / Watch items

<!-- Under what circumstances would the recommendation change? -->

- {condition 1}
- {condition 2}

---

## Full Reports

<!-- Links to the detailed project reports that feed this comparison -->

| Solution | Report |
| --- | --- |
| {Solution A (Vendor)} | [project report](../projects/{solution-a}.md) |
| {Solution B (Vendor)} | [project report](../projects/{solution-b}.md) |
| {Solution C (Vendor)} | {proprietary — no project report} |

---

## Sources

- [{Source}]({URL})
