---
name: project-health-eval
description: Evaluate community health, governance, and sustainability of an OSS project
user-invocable: true
argument-hint: "<github-url | project-url | project-name>"
---

# Project Health Evaluator

Evaluate the community health, governance, contributor diversity, funding sustainability, and corporate control risk of an open-source project. Supersedes the `oss-health` skill with deeper analysis.

## Usage

```text
/project-health-eval "MuJoCo"
/project-health-eval https://github.com/newton-physics/newton
/project-health-eval https://ros.org
/project-health-eval https://github.com/google-deepmind/mujoco_warp --single-repo
```

## Input

Accepts any of:

- **Project name**: skill searches with Physical AI context to find the canonical repo; if multiple plausible matches, presents a numbered list and asks the user to pick. Triggers full repo discovery across the org.
- **GitHub URL**: treats that repo as primary. Still discovers related repos but only reports them (does not fully analyze). The report notes what was found and suggests running with the project name for full scope.
- **Project website URL**: skill extracts the GitHub/GitLab link from it, then behaves like GitHub URL.
- **`--single-repo` flag**: skip discovery entirely, analyze exactly the given URL. Use when you intentionally want a single-repo view.

## Output

Populates **Part A (Community & Project Health)** of the project report template at `deliverables/intel/_templates/project-report.md`. If a report already exists at `deliverables/intel/projects/{project}.md`, updates Part A in place. If no report exists, creates one with Part A filled and Part B marked `<!-- TODO: run project-tech-eval -->`.

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

### Step 1: Scope and discover repos

**1a. Resolve primary repo**

- **GitHub URL**: use directly as primary repo.
- **Project website**: extract GitHub/GitLab link from the site.
- **Project name**: resolve via search with disambiguation:
  1. WebSearch for `"{project name}" site:github.com physical AI OR robotics OR simulation` (add domain context to reduce false matches)
  2. Also search `"{project name}" open source` without domain qualifier to catch projects outside the Physical AI space that share the name
  3. If exactly one strong match: use it
  4. If multiple plausible matches: present the user with a numbered list (max 5) showing repo URL, org, stars, and 1-line description. Ask the user to pick or provide a more specific input (URL). Do NOT guess.
  5. If no match: ask the user for a URL or more specific name

**1b. Discover related repos** (skip if `--single-repo`)

Run discovery even when a GitHub URL was provided — related repos affect the health assessment. The discovery scope depends on the input type:

| Input type | Discovery scope | What to do with findings |
| --- | --- | --- |
| **Project name** | Full: scan org, search web, read README | Classify and analyze all Core repos; note Ecosystem repos |
| **GitHub URL** | Full: same discovery | Classify and analyze primary only; report others as "Related repos found: ..." with a note to run with project name for full scope |
| **`--single-repo`** | None | Analyze exactly the given URL |

**Discovery method:**

1. **Scan the GitHub org** (`gh api orgs/{org}/repos`) for repos matching the project name as prefix or substring
2. **Read the primary repo's README** for links to sibling repos, companion projects, umbrella projects
3. **WebSearch** for "{project name} related repos", "{project name} ecosystem", "{project name} GitHub organization"
4. **Check for cross-org relationships**: projects under different orgs that wrap, extend, or fork this one (e.g., MuJoCo → Newton under `newton-physics` org)

**Classify each discovered repo:**

| Category | Criteria | Action |
| --- | --- | --- |
| **Core** | Same codebase, port, or required runtime component (e.g., `mujoco`, `mujoco_warp`) | Analyze fully; aggregate CHAOSS metrics across core repos |
| **Ecosystem** | Built on top, extends, but independently viable (e.g., `mujoco_playground`, `dm_control`) | Note in report; check for contributor/governance overlap |
| **Peripheral** | Docs, website, examples, archived forks, CI tooling | Exclude |
| **Upstream/downstream** | Different project under different governance that wraps or is wrapped by this one (e.g., Newton wraps MuJoCo Warp) | Note relationship and governance difference; link to its own report if one exists |

**1c. Clone/update repos**

- Clone core repos (and primary if URL-invoked) to the shared workspace at `deliverables/intel/.workspace/repos/{project}/`
- For multi-repo projects, each repo gets its own subdirectory

### Step 2: Run analysis scripts and gather data

**Run scripts** from `.claude/skills/project-health-eval/scripts/` against the repo:

| Script | What it produces |
| --- | --- |
| `gh-community-stats.sh` | CHAOSS metrics: Elephant Factor, Contributor Absence Factor, CR Closure Ratio, Time to First Response, Release Frequency, org breakdown |
| `gh-governance.sh` | Strategic metrics: governance docs, CLA/DCO detection, foundation affiliation, CODEOWNERS, branch protection, CI detection |

**From web research** (supplements script output):

- Foundation membership (Linux Foundation, Apache, CNCF, OSRA, etc.)
- Corporate sponsorship and funding sources
- Key maintainer employer affiliations (verify GitHub profiles, LinkedIn, conference talks)
- Community concerns or controversies (GitHub discussions, blog posts, conference talks)
- Downstream adoption (who uses it at scale?)

### Step 3: Evaluate dimensions

Rate **CHAOSS Metrics** (from script output) using quantitative thresholds:

| CHAOSS Metric | Ratings | Thresholds |
| --- | --- | --- |
| **Elephant Factor** | High ≥4 / Medium 2-3 / Low 1 | Minimum orgs for 50% of commits |
| **Contributor Absence Factor** | Healthy ≥5 / Watch 3-4 / Risk 1-2 | Minimum people for 50% of commits |
| **CR Closure Ratio** | Healthy ≥0.8 / Watch 0.5-0.8 / Backlog <0.5 | Closed÷opened in 6mo |
| **Time to First Response** | Fast <24h / OK <7d / Slow >7d | Median hours for PRs and issues |
| **Release Frequency** | Active ≥4/yr / Adequate 1-3/yr / Stale 0 in 12mo | Releases in analysis period |
| **Contribution Trend** | Broadening / Stable / Narrowing | Compare 12mo Elephant Factor + CAF to all-time values. Broadening = new orgs contributing or dominant org share declining. Narrowing = dominant org share growing or key contributors departing without replacement. Flag specific departures (e.g., "top all-time contributor left for Company X") and new entrants (e.g., "RAI Institute began contributing in 2025") |
| **Libyears** | Current <1 / Watch 1-3 / Stale >3 | Dependency staleness (from project-tech-eval) |

Rate **Strategic Metrics** (from script + web research) using controlled vocabulary:

| Dimension | Ratings | How to assess |
| --- | --- | --- |
| **License** | Permissive / Copyleft / Source-available / Proprietary | Check LICENSE file, SPDX, patent grants |
| **Governance model** | Foundation / Multi-vendor / Single-vendor / BDFL | Governance docs, foundation affiliation, steering committee |
| **Contribution model** | DCO / CLA / None | CONTRIBUTING.md, bot detection on PRs |
| **Corporate control risk** | Low / Medium / High | CLA + commit dominance + roadmap control + trademark |
| **Community health** | Active / Maintained / Declining / Archived | Commit cadence trend, qualitative signals |
| **Ecosystem breadth** | Wide / Moderate / Narrow | Downstream dependents, integrations, plugins |

### Step 4: Governance deep-dive

For projects where governance matters strategically (e.g., ROS 2 under Google, KAI Scheduler under NVIDIA):

- Map key maintainers to their employers
- Assess what would happen if the primary corporate sponsor withdrew
- Check for governance changes in the last 12 months
- Note any community concerns about corporate capture

### Step 5: Write report

Fill Part A of the project report template and the fields this skill owns in the Executive Summary:

**Executive Summary fields this skill fills:**

- **What it is**: 1-sentence description (if not already filled by project-tech-eval)
- **Health verdict**: Healthy / Watch / At-risk + rationale

**Executive Summary fields this skill must NOT fill:**

- **Technical verdict**: owned by project-tech-eval
- **Red Hat fit**: owned by project-tech-eval
- **Recommendation**: owned by project-comparison or manual assessment. Leave as template placeholder.

**Part A sections:**

- **CHAOSS Metrics**: metric × value × rating × detail table (quantitative, from scripts)
- **Strategic Metrics**: dimension × rating × detail table (qualitative + quantitative, from research)
- **Governance Details**: maintainer × employer × role table
- **Funding & Sustainability**: narrative assessment

**Naming rules for all fields:**

- **Competes with**: use "Product Name (Vendor)" format to avoid ambiguity — e.g., "Isaac Sim (NVIDIA)" not "Isaac Sim", "Genesis World (Genesis Embodied AI)" not "Genesis"
- **Maintainer employers**: use the company name as shown on their GitHub profile; add "(prev. X)" if they recently moved
- **Foundation names**: use full name on first mention, e.g., "Linux Foundation" not "LF"

### Step 6: Validation

- [ ] **Repo scoping documented**: GitHub org scanned for related repos; each classified as Core/Ecosystem/Peripheral/Upstream-downstream with rationale
- [ ] **README checked** for links to sibling or umbrella projects
- [ ] **Cross-org relationships identified** (e.g., "MuJoCo Warp feeds into Newton under Linux Foundation")
- [ ] **No ambiguous names**: every entity in "Competes with", maintainer tables, and narrative uses "Product (Vendor)" format; no bare product names that could refer to multiple things
- [ ] **Field ownership respected**: Recommendation field not filled; Technical verdict and Red Hat fit not filled
- [ ] All scorecard dimensions rated using controlled vocabulary
- [ ] Key claims corroborated (not single-source)
- [ ] Maintainer-employer mappings verified (GitHub profiles, not assumed)
- [ ] "Last updated" date set to today
- [ ] Cross-links to company profiles where relevant (e.g., link to NVIDIA profile from KAI Scheduler report)

## Cross-referencing

When available, check:

- **OpenSSF Scorecard** (https://scorecard.dev/) — include score if it exists
- **CHAOSS metrics** (https://chaoss.community/) — use as rubric for community dimensions
- **deps.dev** (https://deps.dev/) — for dependency and security data
