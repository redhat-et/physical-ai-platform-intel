---
name: project-tech-eval
description: Evaluate technical architecture, code quality, dependencies, and platform fit of an OSS project
user-invocable: true
argument-hint: "<github-url | project-url | project-name>"
---

# Project Technical Evaluator

Evaluate the technical architecture, code quality, dependency health, security posture, and Red Hat platform fit of an open-source project. Assesses opportunities and risks for potential contribution, integration, or downstreaming.

## Usage

```text
/project-tech-eval https://github.com/newton-physics/newton
/project-tech-eval https://ros.org
/project-tech-eval "Isaac Lab"
```

## Input

Same input types and `--single-repo` flag as `project-health-eval`. See that skill for full details on repo discovery and classification (Core / Ecosystem / Peripheral / Upstream-downstream).

If `project-health-eval` has already run, reuse its repo scoping from the existing report rather than rediscovering. If running standalone, perform the same discovery process.

## Output

Populates **Part B (Technical Analysis)** of the project report at `deliverables/intel/projects/{project}.md`. If a report already exists (from `project-health-eval`), updates Part B in place. If no report exists, creates one with Part B filled and Part A marked `<!-- TODO: run project-health-eval -->`.

Also populates the **Red Hat Platform Fit Assessment** section and **Executive Summary** (since the summary requires both Part A and Part B — updates it if Part A is already present).

## Report Organization

- **One report per project** in `deliverables/intel/projects/`, flat folder (no subfolders by block)
- **Multi-block projects** (e.g., Genesis World = Simulation Engines + Synthetic Data Generation): one report, list all building blocks in Project Identity
- **Cross-project dependencies**: fill `Depends on` and `Depended on by` in Project Identity when a project requires or is required by another evaluated project. Format: `[Project Name](sibling-report.md) — role description`
- **Separate layered projects**: if a project is really two distinct tools at different layers (e.g., Isaac Lab is a learning framework on top of Isaac Sim the simulator), write separate reports. Each gets its own building block, competitor set, and dependency cross-link

## Shared Workspace

Both `project-health-eval` and `project-tech-eval` use a shared workspace for cloned repos:

```text
deliverables/intel/.workspace/repos/{project-name}/
```

- This directory is gitignored (under `deliverables/intel/`)
- On first run: `git clone` (shallow for large repos, full for small ones)
- On subsequent runs: `git pull` to pick up changes since last evaluation
- Repos persist between runs — no re-cloning on every invocation
- For multi-repo projects, each repo gets its own subdirectory:
  `deliverables/intel/.workspace/repos/{project-name}/{repo-name}/`

## Process

### Step 1: Resolve repos and clone/update

- If a project report already exists at `deliverables/intel/projects/{project}.md`, read its **Repos analyzed** field to reuse the scoping from `project-health-eval`
- Otherwise, perform the same discovery process as `project-health-eval` Step 1 (scope and discover)
- Check if `deliverables/intel/.workspace/repos/{project}/` exists
- If exists: `git pull` and note what changed since last eval
- If new: `git clone --depth=100` (enough history for churn analysis)

### Step 2: Run analysis scripts

Execute scripts from `.claude/skills/project-tech-eval/scripts/` against the cloned repo. Each script outputs structured JSON or markdown fragments.

| Script | What it produces |
| --- | --- |
| `dep-tree.sh` | Dependency tree (pip/npm/go/cargo), transitive dep count, **Libyears** (CHAOSS metric) |
| `license-scan.sh` | Licenses of all direct and key transitive dependencies, copyleft/unknown risk flags |
| `security-scan.sh` | Known CVEs via osv-scanner, grype, or ecosystem tools (pip-audit, npm audit, govulncheck) |
| `code-metrics.sh` | LOC by language, TODO/FIXME density, churn hotspots, lint/format config, code review signal |
| `build-check.sh` | Build system detection, containerization (Dockerfile, Helm, Kustomize), reproducibility, GPU support signals |
| `test-check.sh` | Test framework detection, coverage config, CI test matrix, property testing, benchmarks |

Scripts are best-effort — they handle missing tools gracefully and report what they could and couldn't analyze.

### Step 3: Architecture analysis

Read the codebase structure and documentation to understand:

- **Major subsystems**: What are the top-level modules/packages? What does each do?
- **Data flow**: How do components communicate? (APIs, message passing, shared state)
- **Extension model**: How do users extend the project? (plugin API, SDK, configuration, forking)
- **Key dependencies**: Which large external projects does it depend on? (PyTorch, K8s, ROS 2, etc.)
- **Runtime requirements**: What must be present? (specific GPUs, cloud services, proprietary runtimes)

### Step 3b: Capabilities & positioning assessment

Assess the project's functional capabilities, lock-in risk, and production adoption:

- **Capabilities**: Extract key functional capabilities from documentation, README, feature lists, and architecture analysis. Focus on what distinguishes this project from competitors in the same building block. List as a table of capability + detail.
- **Lock-in**: Assess on 3 dimensions, each rated Low / Medium / High:
  - **Hardware**: GPU/accelerator dependency (e.g., "CUDA-only" vs "CUDA + ROCm + Metal")
  - **Vendor**: Who controls critical code paths, forks, or compiler dependencies?
  - **Ecosystem**: Data format lock-in, platform gravity, migration cost (e.g., "MJCF is open XML, widely supported" or "58K datasets on HF Hub create switching cost")
- **Production adoption**: WebSearch for "who uses {project}", case studies, conference talks, production deployment blog posts. List notable companies and how they use it.

### Step 4: Evaluate dimensions

Rate each dimension using controlled vocabulary:

| Dimension | Ratings | How to assess |
| --- | --- | --- |
| **Architecture clarity** | Clear / Adequate / Tangled | Modular boundaries, documented interfaces, separation of concerns |
| **Tech stack alignment** | Aligned / Neutral / Misaligned | vs Red Hat choices: K8s-native, PyTorch-based, container-friendly, Linux-first |
| **Dependency health** | Healthy / Watch / Risky | Transitive dep count, single-maintainer deps, abandoned deps, CVEs |
| **Test coverage** | Strong / Adequate / Weak | Coverage %, CI setup, test types (unit/integration/e2e) |
| **Security posture** | Strong / Adequate / Weak | OpenSSF score, CVE history, security policy, SBOM, signed releases |
| **Code quality signals** | Strong / Adequate / Weak | Churn hotspots, TODO density, lint/format enforcement, code review practice |
| **Extensibility** | Plugin API / SDK / Forkable / Monolithic | How users add functionality |
| **Hardware portability** | Portable / Limited / Locked | Multi-GPU-vendor? Multi-platform? CUDA-only? |

### Step 5: Platform fit assessment

Assess alignment with Red Hat's technology stack and contribution model:

**Alignment signals** — things that make adoption easy:

- License compatible with downstream redistribution (Apache 2.0, BSD, MIT)
- K8s-native deployment, runs on OpenShift without modification
- PyTorch-based (aligns with RHOAI training stack)
- Container-friendly build and deployment
- No CLA or a DCO-only contribution model
- Active, diverse maintainer community

**Risk signals** — things that make adoption problematic:

- CUDA-only GPU backend (no ROCm, no CPU fallback)
- CLA required (limits Red Hat contribution)
- Core maintainers employed by a single competitor
- Proprietary runtime dependency (e.g., Omniverse Kit SDK)
- Unstable API, frequent breaking changes
- Supply chain risks (single-maintainer transitive deps, known CVEs, license conflicts)

**Supply chain assessment** — from script outputs:

- License conflicts in transitive dependency tree
- Known CVEs and their severity
- Single-maintainer critical dependencies

### Step 6: Write report

Fill Part B of the project report template (including Capabilities & Positioning, Lock-in Assessment, and Production Adoption sections), plus Red Hat Platform Fit Assessment.

**Executive Summary fields this skill fills:**

- **What it is**: 1-sentence description (if not already filled by project-health-eval)
- **Technical verdict**: Strong / Adequate / Concerning + rationale
- **Red Hat fit**: Align / Neutral / Misalign + rationale

**Executive Summary fields this skill must NOT fill:**

- **Health verdict**: owned by project-health-eval
- **Recommendation**: owned by project-comparison or manual assessment. Leave as template placeholder.

**Naming rules**: same as project-health-eval — use "Product (Vendor)" format for all entity references.

### Step 7: Validation

- [ ] All scorecard dimensions rated using controlled vocabulary
- [ ] Architecture overview captures major subsystems and key dependencies
- [ ] Script outputs referenced (not just LLM impression)
- [ ] Red Hat fit assessment addresses both alignment and risk signals
- [ ] Supply chain assessment includes license, CVE, and bus-factor findings
- [ ] **No ambiguous names**: every entity uses "Product (Vendor)" format
- [ ] **Field ownership respected**: Recommendation field not filled; Health verdict not filled
- [ ] Cross-links to company profiles where the project is a product of a tracked company

## Scripts

Scripts live in `.claude/skills/project-tech-eval/scripts/`. They are shell scripts that:

- Accept a repo path as the first argument
- Output structured data (JSON preferred, markdown fallback)
- Handle missing tools gracefully (e.g., if `osv-scanner` isn't installed, report that and skip)
- Run without network access except for CVE database lookups
- Are idempotent and fast

### Script development guidelines

- Keep scripts simple — they extract data, not analyze it. Analysis is the LLM's job.
- Support common ecosystems: Python (pip/pyproject.toml), Node (package.json), Go (go.mod), Rust (Cargo.toml), C++ (CMakeLists.txt/Bazel)
- Output a `"status": "ok" | "partial" | "skipped"` field so the LLM knows what succeeded
