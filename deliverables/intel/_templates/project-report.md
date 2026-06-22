# {PROJECT} — Project Intelligence Report

**Date**: {YYYY-MM-DD}
**Last updated**: {YYYY-MM-DD}
**Classification**: Internal analysis — not for public repo

## Project Identity

| | |
| --- | --- |
| **Project** | {Project name} |
| **Website** | {project website URL, if different from repo} |
| **Building block** | {which platform building block(s) this maps to} |
| **Competes with** | {other projects/products — use format: "Product Name (Vendor)" to disambiguate, e.g. "Isaac Sim (NVIDIA)", "Genesis World (Genesis Embodied AI)"} |
| **Depends on** | {projects this depends on — format: "[Project](file.md) — role". Use "—" if none} |
| **Depended on by** | {projects that depend on this — format: "[Project](file.md) — role". Use "—" if none} |

### Repo Scope

<!-- Produced by Step 1 discovery. Document what was found and why each was included/excluded. -->

| Repo | Category | Action | Rationale |
| --- | --- | --- | --- |
| {owner/repo} | Core | Analyzed | {Primary repo / GPU port / required component} |
| {owner/repo} | Ecosystem | Noted | {Built on top, independent} |
| {owner/repo} | Peripheral | Excluded | {Docs only / examples / archived} |
| {owner/repo} | Upstream/downstream | Linked | {Different governance, wraps this project — see report if available} |

---

## Executive Summary

<!-- A PM reads this and decides whether to read further. -->
<!-- Each field is owned by a specific skill — only fill what your skill owns. -->

- **What it is**: {1-sentence description + key differentiator} <!-- filled by: whichever skill runs first -->
- **Health verdict**: {Healthy / Watch / At-risk} — {1-sentence rationale} <!-- filled by: project-health-eval -->
- **Technical verdict**: {Strong / Adequate / Concerning} — {1-sentence rationale} <!-- filled by: project-tech-eval -->
- **Red Hat fit**: {Align / Neutral / Misalign} — {1-sentence on tech stack compatibility} <!-- filled by: project-tech-eval -->
- **Recommendation**: <!-- filled by: project-comparison, or manual assessment after both evals complete. Do NOT fill from a single eval. -->

---

## Part A: Community & Project Health

<!-- Produced by project-health-eval skill. Extends the oss-health skill's analysis. -->

### CHAOSS Metrics

<!-- Industry-standard community health metrics aligned with CHAOSS (https://chaoss.community) -->

| Metric | Value | Rating | Detail |
| --- | --- | --- | --- |
| **Elephant Factor** | {N orgs for 50% of commits} | {High ≥4 / Medium 2-3 / Low 1} | {top org %, breakdown} |
| **Contributor Absence Factor** | {N people for 50% of commits} | {Healthy ≥5 / Watch 3-4 / Risk 1-2} | {implies resilience level} |
| **Change Request Closure Ratio** | {opened vs closed in 6mo} | {Healthy / Watch / Backlog} | {trend direction} |
| **Time to First Response** | {median hours/days} | {Fast <24h / OK <7d / Slow >7d} | {PRs and issues separately if different} |
| **Release Frequency** | {releases in 12mo} | {Active / Adequate / Stale} | {last release date, semver adherence} |
| **Contribution Trend** | {12mo vs all-time} | {Broadening / Stable / Narrowing} | {Compare 12mo Elephant Factor + CAF to all-time; flag key departures or new entrants} |
| **Libyears** | {N.N years behind} | {Current <1 / Watch 1-3 / Stale >3} | {worst offenders if stale} |

### Strategic Metrics

<!-- Red Hat-specific assessment dimensions beyond CHAOSS -->

| Dimension | Rating | Detail |
| --- | --- | --- |
| **License** | {Permissive / Copyleft / Source-available / Proprietary} | {SPDX identifier, patent grants, unusual terms} |
| **Governance model** | {Foundation / Multi-vendor / Single-vendor / BDFL} | {Governing body, charter, who controls roadmap} |
| **Contribution model** | {DCO / CLA / None} | {CLA terms if applicable, contribution friction} |
| **Corporate control risk** | {Low / Medium / High} | {commit dominance + roadmap control + trademark ownership} |
| **Community health** | {Active / Maintained / Declining / Archived} | {commit cadence trend, qualitative signals} |
| **Ecosystem breadth** | {Wide / Moderate / Narrow} | {downstream dependents, integrations, plugins} |

### Governance Details

<!-- Who controls the project? Where are the maintainers employed? -->
<!-- This is where we surface findings like "Google employs most ROS maintainers" -->

| Maintainer / Key Contributor | Employer | Role |
| --- | --- | --- |
| **{name}** | {company} | {core maintainer / committer / PMC member} |

### Funding & Sustainability

<!-- How is the project funded? Foundation grants, corporate sponsorship, volunteer? -->
<!-- Is the funding sustainable? What happens if the primary sponsor leaves? -->

---

## Part B: Technical Analysis

<!-- Produced by project-tech-eval skill. Assesses architecture, quality, and risk. -->

### Technical Scorecard

| Dimension | Rating | Detail |
| --- | --- | --- |
| **Architecture clarity** | {Clear / Adequate / Tangled} | {Modular? Clear boundaries? Documented?} |
| **Tech stack alignment** | {Aligned / Neutral / Misaligned} | {vs Red Hat choices: K8s-native? PyTorch? container-friendly?} |
| **Dependency health** | {Healthy / Watch / Risky} | {Transitive dep count, any single-maintainer deps, CVEs} |
| **Test coverage** | {Strong / Adequate / Weak} | {Coverage %, CI setup, test types} |
| **Security posture** | {Strong / Adequate / Weak} | {[OpenSSF Scorecard](https://scorecard.dev/) score, CVE history, security policy, SBOM} |
| **Code quality signals** | {Strong / Adequate / Weak} | {Churn hotspots, TODO density, lint/format enforcement} |
| **Extensibility** | {Plugin API / SDK / Forkable / Monolithic} | {How do users extend it?} |
| **Hardware portability** | {Portable / Limited / Locked} | {CUDA-only? Platform-specific? Multi-backend?} |

### Architecture Overview

<!-- High-level component diagram (described in text/table form). -->
<!-- What are the major subsystems? How do they communicate? -->

| Component | Purpose | Key Dependency |
| --- | --- | --- |
| **{Component}** | {What it does} | {Depends on: X} |

### Dependency Analysis

<!-- Major upstream dependencies — focus on large projects and risk signals. -->
<!-- Script output: dep-tree.sh, license-scan.sh, security-scan.sh -->

| Dependency | Version | License | Risk Signal |
| --- | --- | --- | --- |
| **{dep}** | {version} | {license} | {single-maintainer / CVE / abandoned / none} |

### Capabilities & Positioning

<!-- Key functional capabilities — what this project does well. -->
<!-- These feed into the Feature Comparison table in project-comparison reports. -->
<!-- filled by: project-tech-eval -->

| Capability | Detail |
| --- | --- |
| **{capability}** | {what it does, key metrics if available} |

### Lock-in Assessment

<!-- filled by: project-tech-eval -->

| Dimension | Risk | Detail |
| --- | --- | --- |
| **Hardware** | {Low / Medium / High} | {e.g., "CUDA-only" or "CUDA + ROCm + Metal via JAX"} |
| **Vendor** | {Low / Medium / High} | {e.g., "single maintainer controls critical compiler fork"} |
| **Ecosystem** | {Low / Medium / High} | {e.g., "58K datasets on HF Hub create migration cost"} |

### Production Adoption

<!-- Notable companies/institutions using this in production or at scale. -->
<!-- filled by: project-tech-eval (WebSearch for users/case studies) -->

| User | Use Case |
| --- | --- |
| **{company}** | {how they use it} |

### Build & CI

<!-- How is it built? Is the build reproducible? What CI runs? -->

| Aspect | Details |
| --- | --- |
| **Build system** | {Bazel / CMake / pip / Cargo / etc.} |
| **CI** | {GitHub Actions / Jenkins / etc.} |
| **Reproducibility** | {Lockfile? Pinned deps? Container build?} |
| **Platforms tested** | {Linux / macOS / Windows / ARM / GPU} |

### Backlog Health

<!-- Are issues triaged? Are PRs reviewed? Is the project responsive? -->

| Metric | Value |
| --- | --- |
| **Open issues** | {N} |
| **Open PRs** | {N} |
| **Median issue response time** | {hours / days} |
| **Median PR merge time** | {hours / days} |
| **Stale issues (>90 days)** | {N / %} |

---

## Red Hat Platform Fit Assessment

<!-- How well does this project align with Red Hat's technology choices and strategy? -->

### Alignment Signals

<!-- What makes this a good fit? -->

- {e.g., "Apache 2.0 license, compatible with downstream redistribution"}
- {e.g., "K8s-native deployment model, runs on OpenShift without modification"}
- {e.g., "PyTorch-based, aligns with RHOAI training stack"}

### Risk Signals

<!-- What could make adoption problematic? -->

- {e.g., "CUDA-only GPU backend, no ROCm support"}
- {e.g., "CLA required, limits Red Hat contribution model"}
- {e.g., "3 of 5 core maintainers work for a single competitor"}

### Supply Chain Assessment

<!-- Transitive dependency risks, licensing conflicts, known vulnerabilities -->
<!-- Script output: license-scan.sh, security-scan.sh -->

- **License conflicts**: {any GPL/AGPL in transitive deps that conflict with Apache 2.0?}
- **Known CVEs**: {N open CVEs in dependency tree, severity}
- **Single-maintainer risks**: {any critical deps maintained by 1 person?}

---

## Sources

- [{Source}]({URL})
