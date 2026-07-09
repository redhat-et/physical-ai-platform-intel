---
name: company-intel
description: Create or update a competitive intelligence profile for a company in the Physical AI space
user-invocable: true
argument-hint: "<company-name> [--deep-dive] [--html]"
---

# Company Intelligence — Competitive Profile Generator

Create or update a structured intelligence report on a company's Physical AI strategy, products, platform coverage, and strategic implications for Red Hat.

## Usage

```text
/company-intel NVIDIA
/company-intel "Google Intrinsic"
/company-intel Siemens --deep-dive
/company-intel NVIDIA --html
```

## Arguments

- `<company-name>`: Company to analyze (required)
- `--deep-dive`: After creating/updating the main profile, also perform full deep-dive research (OSS foundations, acquisition details, technical architecture). Without this flag, deep-dive sections are populated with bycatch data and marked `<!-- TODO: deep research needed -->`.
- `--html`: Additionally generate a presentation-quality HTML companion with colored table backgrounds.

## Output Files

| File | Purpose |
| --- | --- |
| `deliverables/intel/companies/{company}.md` | Competitive profile (exec briefing, 1-2 pages) |
| `deliverables/intel/companies/{company}-deep-dive.md` | Analyst appendix (OSS foundations, architecture, governance) |
| `deliverables/intel/companies/{company}.html` | (optional, with `--html`) Presentation-quality visual companion |

## Process

### Step 1: Check for existing report

- Check if `deliverables/intel/companies/{company}.md` exists
- If **exists**: read the current report, note the "Last updated" date, proceed to Step 3 (update mode)
- If **new**: proceed to Step 2 (create mode)

### Step 2: Research (create mode)

Perform research using WebSearch and WebFetch. Prioritize accuracy — corroborate key facts across multiple sources. Research areas:

1. **Company identity**: Type, revenue/funding, leadership, organizational structure for Physical AI
2. **Product inventory**: All products relevant to Physical AI — name, one-line description, key differentiator
3. **Architecture mapping**: For each product, determine which platform block(s) it covers and at which tier(s)
4. **OSS foundations**: For each product, identify the underlying OSS engine (if any), license, and what the vendor adds
5. **Partnerships**: Hardware partners, ecosystem partnerships, developer community
6. **Competitive positioning**: Who they compete with, where they're strong/weak vs those competitors
7. **Strategic implications**: Opportunities, risks, and monitoring questions for Red Hat

### Step 3: Research (update mode)

- Web-search for developments since the "Last updated" date
- Check for: new product launches, acquisitions, partnerships, pricing changes, OSS releases, leadership changes
- Update affected sections; leave unchanged sections untouched
- Bump the "Last updated" date

### Step 4: Write the competitive profile

Fill the template at `deliverables/intel/_templates/company-profile.md`:

- **At a Glance**: 1-paragraph positioning + summary table
- **Key Products**: One-line per product table
- **Architecture Coverage**: HTML table with emoji indicators (see visual-language.md)
- **OSS Foundations**: Product-keyed reference table (1 line per product, no `#` column)
- **Hardware & Ecosystem Partnerships**: If applicable
- **Competitive Positioning**: Factual "they have / they lack" table
- **Coverage Summary**: Bullet list
- **Strategic Implications**: 3-5 numbered points

### Step 5: Write the deep-dive

Fill the template at `deliverables/intel/_templates/company-deep-dive.md`:

- If `--deep-dive` flag: perform thorough research on each section (OSS dependency analysis, governance review, acquisition history, architecture details)
- If no flag: populate sections with bycatch data gathered during Step 2/3, mark incomplete sections with `<!-- TODO: deep research needed -->`

### Step 6: Template compliance check

Verify both documents against their templates:

- [ ] All template sections present (even if marked TODO)
- [ ] Architecture coverage table uses correct indicators from visual-language.md
- [ ] Controlled vocabulary used for ratings (Permissive/Copyleft, High/Medium/Low, etc.)
- [ ] Cross-links between profile and deep-dive are correct
- [ ] "Last updated" date reflects today
- [ ] No marketing language — factual, measured, pattern-oriented (per CLAUDE.md style guide)
- [ ] Sources section populated with URLs for key claims

### Step 7: Update README.md

If this is a **new** company (create mode), add a row to the Company Profiles table in `README.md`. Insert alphabetically by company name. The row format is:

```markdown
| {Company} | [{slug}.md](deliverables/intel/companies/{slug}.md) | [{slug}-deep-dive.md](deliverables/intel/companies/{slug}-deep-dive.md) |
```

If the company already appears in the table (update mode), no README change is needed.

## Architecture Table Rules

Refer to `deliverables/intel/_templates/visual-language.md` for:

- Emoji indicator definitions (🟢🟡🔵⬜🔴🟣)
- Column structure (Block | Central-Lang | Central-PhysAI | Distrib-Lang | Distrib-PhysAI | Edge)
- Cell merging rules (colspan="2" when same product covers both Language and Physical AI)
- Cell content format (indicator + product name + optional `<br><small>(detail)</small>`)

## Style Rules

Follow CLAUDE.md style guide principles. In particular:

- **Sober and factual**: No hype, no superlatives without evidence
- **Concise**: Dense information, respect reader's time
- **Pattern-oriented**: Highlight connections and recurring themes across vendors
- **Controlled vocabulary**: Use defined values for structured fields
- **Competitive analysis language**: Factual feature comparisons, not marketing

## Cross-linking

When adding a new company profile:

- Check if the company already has an entry in `research/ecosystem.md` — if so, link to it
- If the company reveals new building-block requirements, note in the profile's strategic implications
- If the company stewards an OSS project we should track, note for potential `project-health-eval` follow-up
