---
name: project-comparison
description: Compare OSS projects and proprietary solutions for a building block, with Red Hat pick recommendation
user-invocable: true
argument-hint: "<solution1> <solution2> [solution3...] [--block <building-block>]"
---

# Project & Solution Comparison

Compare a set of OSS projects and/or proprietary solutions that address the same platform building block. Synthesizes existing project reports (from `project-health-eval` and `project-tech-eval`) and company profiles (from `company-intel`) into a side-by-side comparison with a Red Hat recommendation.

## Usage

```text
/project-comparison "MuJoCo" "Newton" "Isaac Sim" "Genesis World"
/project-comparison "vLLM" "NIM" "TensorRT-LLM" --block "Inference Server"
/project-comparison "KAI Scheduler" "Kueue" "Volcano"
```

## Arguments

- `<solution1> <solution2> ...`: Two or more solutions to compare (required). Can be OSS project names, proprietary product names, or GitHub URLs.
- `--block <building-block>`: Specify the platform building block these solutions address. If omitted, the skill infers it from the solutions.

## Output

Creates a comparison report at `deliverables/intel/project-comparisons/{building-block}.md` using the template at `deliverables/intel/_templates/project-comparison.md`.

Also back-writes the Recommendation to each project's individual report (see Step 4b).

## Report Organization

- **Comparisons are per-building-block** in `deliverables/intel/project-comparisons/`
- **A project can appear in multiple comparisons** if it spans multiple building blocks (its report lists all blocks in Project Identity)
- **Pull data from per-project reports** at `deliverables/intel/projects/`. Each project report feeds into whichever comparison covers its building block(s)

## Process

### Step 1: Gather existing reports

For each solution:

- **OSS project**: Check if `deliverables/intel/projects/{project}.md` exists. If yes, pull scorecard data from it. If no, flag as `[no report — run project-health-eval and project-tech-eval first]`.
- **Proprietary product**: Check if the vendor has a company profile in `deliverables/intel/companies/`. If yes, pull product details from it. Proprietary solutions don't get health/tech scorecards — they get feature descriptions from the company profile.

If key reports are missing, inform the user which evaluations should be run first, but proceed with available data rather than blocking.

### Step 2: Feature dimension discovery & research

Identify the ~8-15 feature dimensions that matter for comparing solutions in this building block:

1. Read the building block description from `research/building-blocks.md` — its "Key trade-offs" and "Solution landscape" notes hint at the dimensions that matter
2. Read each project's **Capabilities & Positioning** section from their reports at `deliverables/intel/projects/`
3. Check `deliverables/oss-landscape-deep-dive.md` for pre-existing analysis to reconcile
4. WebSearch for feature comparison blog posts, benchmark results, migration guides
5. Select feature dimensions that are **discriminating** (not all projects equal) and **important** to the platform decision
6. For multi-valued features (e.g., supported GPU backends, physics types, scene formats), use comma-separated value lists rather than one row per option with ✅/⚠️/❌

Use ✅/⚠️/❌ for boolean capabilities. Use value lists for multi-valued features. Aim for a compact table that fits on one screen.

### Step 3: Build comparison matrices

Fill the comparison template sections in order:

1. **Feature Comparison**: Functional capabilities using dimensions from Step 2 (✅/⚠️/❌ for booleans, value lists for multi-valued)
2. **Lock-in Comparison**: Hardware / Vendor / Ecosystem lock-in per solution — pull from each project's Lock-in Assessment section
3. **Production Adoption**: Notable users per solution — pull from each project's Production Adoption section, supplement with WebSearch
4. **Red Hat Platform Fit**: OpenShift compatibility, RHEL compatibility, license compatibility, contribution model, vendor relationship, platform fit recommendation (Build / Partner / Integrate)
5. **Health & Risk Comparison**: Summarized scorecards from project reports (controlled vocabulary ratings)
6. **Architecture Comparison**: Design philosophy, runtime requirements, extension model, data formats, key dependencies

### Step 4: Formulate recommendation

Answer the question: **"If Red Hat had to pick one of these to contribute to, integrate, and downstream into products, which one would it be?"**

Structure the recommendation as:

- **Recommended pick**: Name + 1-2 sentence rationale covering community fit, technical fit, and strategic fit
- **Runner-up**: Name + why it's second and when it might be preferred
- **Why the recommended solution**: 3-5 strongest arguments
- **What we give up**: Tradeoffs vs. the runner-up
- **Conditions / Watch items**: Under what circumstances would the recommendation change?

### Step 4b: Back-write Recommendation to project reports

For each OSS project with a report at `deliverables/intel/projects/{project}.md`, fill the Recommendation field in the Executive Summary:

```markdown
- **Recommendation**: {Build / Partner / Integrate} — {1-sentence rationale, see [comparison](../project-comparisons/{block}.md)}
```

This closes the loop: the comparison skill owns the Recommendation field that health-eval and tech-eval leave blank.

### Step 5: Validation

- [ ] All solutions compared on the same dimensions (no dimension appears for some but not others)
- [ ] Health/risk ratings use controlled vocabulary from project report templates
- [ ] Feature comparison uses ✅/⚠️/❌ for booleans, value lists for multi-valued features
- [ ] Platform fit uses controlled vocabulary: Build / Partner / Integrate
- [ ] Recommendation includes explicit tradeoffs, not just the winner
- [ ] Links to full project reports and company profiles included
- [ ] Proprietary solutions clearly marked as such (no health scorecard for closed-source)
- [ ] **Naming convention**: all entity references use "Product (Vendor)" format
- [ ] **Back-write confirmed**: Recommendation field updated in each project report
- [ ] **Feature dimensions**: all selected dimensions present for all solutions (no partial rows)

## Style Rules

- Factual feature comparisons, not marketing language
- State what each solution does and doesn't do — don't rank subjectively without evidence
- When benchmark data exists, cite it; when it doesn't, say so
- The recommendation is an informed opinion, clearly marked as such, with conditions that would change it
- **Naming convention**: use "Product (Vendor)" format for all entity references throughout — e.g., "MuJoCo (Google DeepMind)", "Isaac Sim (NVIDIA)", "Genesis World (Genesis Embodied AI)". Consistent with project-health-eval and project-tech-eval naming rules.
