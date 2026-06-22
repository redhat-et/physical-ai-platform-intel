---
name: company-intel-synthesis
description: Refresh company intelligence reports and generate cross-company trend analysis
user-invocable: true
argument-hint: "[--companies <list>] [--refresh-all]"
---

# Company Intelligence Synthesis

Update existing company intelligence reports and generate a cross-company analysis identifying trends, ecosystem shifts, and strategic patterns.

## Usage

```text
/company-intel-synthesis
/company-intel-synthesis --refresh-all
/company-intel-synthesis --companies "NVIDIA, Google Intrinsic, Siemens"
```

## Arguments

- No arguments: generate synthesis from existing reports without refreshing them
- `--refresh-all`: run `company-intel` (update mode) on every company in `deliverables/intel/companies/` before synthesizing
- `--companies <list>`: refresh only the listed companies, then synthesize across all

## Process

### Step 1: Inventory existing reports

- List all `*.md` files in `deliverables/intel/companies/` (excluding `*-deep-dive.md`)
- For each, note the "Last updated" date and key coverage areas

### Step 2: Refresh (if requested)

- For each company to refresh, invoke the `company-intel` skill in update mode
- Run updates in parallel where possible (independent web searches)
- Report which companies were updated and which had no changes

### Step 3: Cross-company analysis

Read all current profiles and produce a synthesis covering:

**Coverage heat map**: Which platform blocks are covered by multiple vendors vs. uncovered?

| Block | {Company A} | {Company B} | {Company C} | Coverage Count |
| --- | --- | --- | --- | --- |
| Train Workloads | 🟢 | 🟢 | ⬜ | 2/N |

**Partnership network**: Who partners with whom? Exclusive vs. shared partners? (e.g., "FANUC partners with both NVIDIA and Google; ABB is NVIDIA-exclusive")

**Ecosystem dynamics**:

- Which companies are complementary vs. competitive?
- Where are alliances forming? Where are they fracturing?
- Which companies are expanding into new blocks?

**Trend signals**:

- Product launches, acquisitions, or pivots since last synthesis
- Shifts in open-source strategy (new projects open-sourced, projects going proprietary)
- Pricing changes or business model shifts
- Leadership or organizational changes

**Red Hat strategic implications**:

- Which gaps remain unfilled by any vendor? (partnership or build opportunities)
- Where are multiple vendors converging? (standardization signals)
- Which vendor moves create risk for Red Hat's positioning?

### Step 4: Write synthesis report

Output to `deliverables/intel/reports/YYYY-MM-DD-synthesis.md`:

```markdown
# Intelligence Synthesis — {YYYY-MM-DD}

## Companies Analyzed
- {Company} (last updated: {date})

## Coverage Heat Map
{table}

## Key Developments Since Last Synthesis
{bulleted list of significant changes}

## Ecosystem Dynamics
{partnership network, alliances, competitive shifts}

## Trend Signals
{emerging patterns}

## Strategic Implications for Red Hat
{numbered list: opportunities, risks, questions}
```

### Step 5: Flag stale reports

- Any company with "Last updated" older than 90 days gets flagged
- Output a list of stale reports with recommended action (refresh or archive)

## Style Rules

- Same style principles as `company-intel` (CLAUDE.md style guide)
- Synthesis should surface non-obvious patterns, not just summarize individual reports
- Use factual language for competitive dynamics — "X partners with Y" not "X dominates Y"
