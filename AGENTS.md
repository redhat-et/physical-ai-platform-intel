# Physical AI Platform Intelligence

## Project Purpose

This repo produces **actionable intelligence for building a Physical AI platform and partner ecosystem** -- company competitive profiles, OSS project evaluations, building-block analysis, and cross-company synthesis. Built on a research foundation that tracks the ecosystem, publications, and architectural patterns.

The repo is organized in three layers:

**Intelligence Reports** (`deliverables/intel/`) -- the primary output:

- **`companies/`** -- Competitive profiles (exec summary + analyst deep-dive) for tracked companies
- **`projects/`** -- Per-project health and technical evaluations (CHAOSS metrics, architecture analysis, Red Hat platform fit)
- **`project-comparisons/`** -- Side-by-side comparisons per building block with Red Hat pick recommendation
- **`reports/`** -- Cross-company synthesis reports (coverage heat maps, partnership networks, trend signals, strategic implications)

**Platform Intelligence Layer** (`research/`) -- structured research that feeds the intelligence:

- **`building-blocks.md`** -- Platform capability map: building blocks with demand matrices, solution landscapes, platform fit assessments
- **`ecosystem.md`** -- Competitive landscape: Big Tech, startups, OSS communities, research labs with solution-level analysis
- **`use-cases.md`** -- Technical use cases as primary hierarchy with vertical tags, building-block mappings, regulatory requirements
- **`projects.md`** -- Open-source and proprietary implementations organized by building block with openness assessments

**Research Depth Layer** (`research/`) -- foundational understanding that informs platform decisions:

- **`publications.md`** -- Papers, talks, videos, blog posts across Physical AI scope (world models, embodied AI, simulation, robotics foundations)
- **`concepts.md`** -- Key concepts, architectural patterns, and theoretical foundations

**Scope** includes (examples, not exhaustive):

- **Predictive / latent-space models** -- JEPA, Dreamer, Energy-Based Models
- **Generative / pixel-space models** -- Cosmos, Genie, GAIA, Sora
- **Model-based RL** -- DreamerV3, TD-MPC, MBPO
- **Foundation models for Physical AI** -- GR00T, pi0, world foundation models for robotics
- **Biologically-inspired architectures** -- BDH, Active Inference, spiking networks
- **Simulation & digital twins** -- Isaac Sim, Habitat, synthetic data generation
- **Robotics stacks** -- ROS 2, manipulation frameworks, nav stacks
- **MLOps / training infrastructure** -- distributed training, data pipelines, model registries

### Goals

1. Track players AND startups building Physical AI solutions, understanding competitive dynamics
2. Understand use cases and derive building-block requirements for an enterprise platform
3. Assess the open-source landscape for each building block (community health, licensing, vendor control)
4. Maintain research depth on world model architectures, embodied AI, and simulation
5. Support synthesis and analysis of research trends and market developments

### Workflow Philosophy

This notebook is **AI-driven**: the user provides URLs or search terms, and AI assistants extract information, fill templates, and update documents. The goal is minimal manual intervention while maintaining high quality and consistency.

## AI Workflow for Adding Content

### Adding a Publication

When the user provides a publication URL (paper, blog post, video, etc.):

1. **Fetch Content**: Use WebFetch tool to retrieve the content
2. **Extract Information**:
   - Title
   - Authors/Presenter
   - Publication date (YYYY-MM format)
   - URL
   - Type (Paper | Talk | Blog Post | Video)
   - Duration (for videos, format: MM:SS or HH:MM:SS)
   - 2-3 sentence summary (following style guide)
   - 3-5 key points (technical contributions, methods, results, key insights)
   - Relevance to Physical AI and platform strategy
3. **For YouTube Videos**:
   - Only include videos from well-known players/institutions
   - Types: talks, interviews, news about key players, tutorials
   - Include key timestamps if valuable sections are identified
4. **Fill Template**: Use `research/templates/publication-entry.md` as structure
   - Add a 32x32 icon behind the title that links to the source. Pick the icon from `research/templates/icons/` depending on the source type.
5. **Add to publications.md**: Insert under appropriate section (see Content Organization below)
6. **Cross-link**:
   - If paper mentions new researchers/institutions/companies with significant contributions, add to ecosystem.md
   - If paper describes new use cases, add to use-cases.md
   - If paper presents new concept, note in concepts.md
   - If paper reveals a new building-block requirement, note in building-blocks.md
   - If any authors/presenters already exist in ecosystem.md, link their names: `[Name](ecosystem.md#anchor)`
7. **Archive Source**: Save PDF to `research/library/papers/` (see Source Archiving section)

### Adding an Ecosystem Entry

Add organizations and key researchers that are **significant players** in the Physical AI ecosystem. This includes Big Tech divisions, funded startups, active OSS communities, and leading research labs. Do not add authors merely because they co-authored a tracked paper.

When extracting ecosystem information:

1. **Assess Inclusion**: Only add if the person/organization meets at least one criterion:
   - Originated or significantly advanced a key concept or architecture
   - Leads a major research group, company, or product in the field
   - Has a body of highly-cited, influential work in the area
   - Is a funded startup building Physical AI products
   - Maintains a significant open-source project in scope
2. **Extract Information**: Follow fields in `research/templates/ecosystem-entry.md` and `research/templates/solution-entry.md`
3. **Fill Template**: Use `research/templates/ecosystem-entry.md` for the organization; add `research/templates/solution-entry.md` sub-entries for each notable product/solution
4. **Add to ecosystem.md**: Insert under appropriate section (Big Tech | Startups | OSS Communities | Research Labs)
5. **Avoid Duplicates**: Check if entry already exists before adding

### Adding a Project

When the user provides a GitHub URL or project website:

1. **Fetch Information**: Use WebFetch or Bash to get repo/project details
2. **Extract Information**:
   - Project name
   - URL (GitHub or website)
   - Description (what it does, 1-2 sentences)
   - Building block(s) it maps to
   - Tech Stack (which technologies does it use or depend on)
   - Key features (what makes it notable)
   - Category: `OSS (community-driven)` | `OSS (single-vendor)` | `Source-available` | `Proprietary`
   - Status (Active | Maintained | Archived) -- check last commit/release date
   - Stats (stars, forks, number of recent contributors, key contributing companies -- to understand community health and controlling companies)
   - Last updated date
3. **Fill Template**: Use `research/templates/project-entry.md`
4. **Add to projects.md**: Insert under appropriate building-block category
5. **OSS Health Assessment**: For GitHub projects, invoke the `oss-health` specialist skill to generate a detailed community health report

### Adding a Use Case

When identifying an application or industry use of Physical AI:

1. **Structure Information**:
   - Use case name
   - Vertical tags (Manufacturing, Transport&Logistics, Energy&Utilities, Healthcare, Telecommunications, Retail, FSI, etc.)
   - Description
   - Technical requirements (functionality it requires, quantitative performance objectives or constraints, etc.)
   - Building-block mapping (which building blocks from building-blocks.md are required, with demand level)
   - Regulatory requirements (safety certifications, data residency, compliance frameworks)
   - Current solutions (companies/projects working on this)
   - Research gaps (what's missing or needs improvement)
2. **Fill Template**: Use `research/templates/use-case-entry.md`
3. **Add to use-cases.md**: Insert under appropriate use-case section
4. **Cross-reference**: Update building-blocks.md demand matrices if the use case reveals new requirements

### Adding a Building Block

Building blocks represent platform capabilities that multiple use cases require. Only add a new building block when a capability pattern emerges that does not fit existing blocks.

1. **Assess Need**: A new building block is warranted when:
   - Multiple use cases require the same underlying capability
   - No existing block covers the functionality
   - The capability is platform-level (not application-specific)
2. **Structure Information**:
   - Block name and description
   - Demand matrix (which use cases need it, at what level)
   - Solution landscape (existing tools/frameworks/services that provide it)
   - Maturity assessment using controlled vocabulary
   - Platform fit recommendation (`Build` | `Partner` | `Integrate`)
3. **Fill Template**: Use `research/templates/building-block-entry.md`
4. **Add to building-blocks.md**: Insert in appropriate position
5. **Back-link**: Update use-cases.md entries that map to this block

## Search Strategy

When the user asks to find content on a topic (e.g., "find recent papers on JEPA" or "find startups doing sim-to-real"):

1. **Use WebSearch** for:
   - Recent papers and preprints
   - Blog posts and articles
   - News and announcements
   - Industry developments
   - Startup funding rounds and product launches

2. **Search GitHub** (via WebSearch or direct queries) for:
   - Open-source implementations
   - Research code releases
   - Popular frameworks

3. **Search arXiv** specifically:
   - Use search terms like: `"joint embedding predictive architecture"`, `"energy based models"`, `"world models"`, `"physical AI"`, `"embodied AI"`
   - Filter by recent submissions (last 3-6 months)
   - Look for papers from key researchers

4. **Present Findings**: Show user a list of top 5-10 results with titles and brief descriptions, ask which to add

## Content Organization

### building-blocks.md Structure

Platform capability map organized by functional area:

```markdown
# Building Blocks

## Simulation & Synthetic Data
[Physics engines, renderers, scene generators, domain randomization]

## World Model Architectures
[JEPA, generative models, model-based RL, latent dynamics]

## Training Infrastructure
[Distributed training, data pipelines, experiment tracking]

## Data Management
[Datasets, data formats, annotation tools, data versioning]

## Deployment & Inference
[Model serving, edge deployment, real-time inference]

## Evaluation & Benchmarking
[Benchmarks, metrics, evaluation frameworks]

## Safety & Alignment
[Safety verification, sim-to-real validation, uncertainty quantification]
```

Each block includes a demand matrix (use-case requirements), solution landscape, maturity assessment, and platform fit recommendation.

### ecosystem.md Structure

Organized by **player type** with solution-level competitive analysis:

```markdown
# Ecosystem

## Big Tech
[Established tech companies with Physical AI initiatives -- with solution sub-entries]

## Startups
[Venture-backed companies building Physical AI products]

## OSS Communities
[Open-source communities and foundations]

## Research Labs
[Universities and research institutions -- with key researchers grouped under their labs]
```

Each entry includes solutions/products with competitive positioning, not just organizational profiles.

### use-cases.md Structure

Organized by **technical use case** (primary hierarchy) with vertical tags:

```markdown
# Use Cases

## Robotic Manipulation
[Pick-and-place, assembly, dexterous manipulation -- tagged: Manufacturing, Logistics]

## Autonomous Navigation
[Mobile robots, AGVs, drones -- tagged: Logistics, Agriculture, Mining]

## Autonomous Vehicles
[Self-driving, path planning, sim-to-real -- tagged: Transport]

## Predictive Maintenance
[Anomaly detection, remaining useful life, condition monitoring -- tagged: Manufacturing, Energy]

## Digital Twins
[Process simulation, facility modeling, what-if analysis -- tagged: Manufacturing, Energy, Telecom]

## Medical Imaging & Diagnostics
[Diagnostics, clinical decision support, surgical planning -- tagged: Healthcare]

## Network Optimization
[Wireless channel modeling, beam prediction, RAN optimization -- tagged: Telecommunications]

## Scientific Simulation
[Physics simulation, molecular modeling, materials design -- tagged: Research, Pharma]

## Agentic AI
[Autonomous agents, web agents, tool use, planning with world models -- tagged: Cross-vertical]
```

Each use case maps to required building blocks and lists regulatory requirements.

### projects.md Structure

Organized by **building block**:

```markdown
# Projects

## Simulation & Synthetic Data
[Isaac Sim, Habitat, MuJoCo, etc.]

## World Model Implementations
[JEPA implementations, DreamerV3, etc.]

## Training Frameworks
[Distributed training tools, data loaders]

## Datasets & Benchmarks
[Relevant datasets and evaluation suites]

## Robotics Frameworks
[ROS 2, manipulation libraries, planning tools]

## Utilities & Tools
[Supporting tools, visualization, debugging]
```

Each project includes openness assessment (category, license, governance model).

### publications.md Structure

Organize by **topic**, not chronologically:

```markdown
# Publications: Papers, Talks, Videos, and Blog Posts

## JEPA (Joint-Embedding Predictive Architecture)
[Papers, talks, videos related to JEPA]

## Energy-Based Models
[Papers, talks, videos on EBMs]

## World Models & Model-Based RL
[Papers on world models, DreamerV3, etc.]

## Simulation & Synthetic Data
[Papers on sim-to-real, synthetic data generation, domain randomization]

## Robotics & Embodied AI
[Papers on robot learning, manipulation, navigation]

## Physical AI Platforms & Infrastructure
[Papers on training infrastructure, deployment, MLOps for Physical AI]

## Foundational / Theory
[Theoretical foundations, surveys, position papers]

## Recent Additions
[Last 30 days - move to topic sections after monthly review]
```

**Video Guidelines**:

- Only include videos from well-known researchers, institutions, or reputable channels
- Types: conference talks, interviews, news coverage, technical tutorials
- Include duration and key timestamps if applicable

### concepts.md Structure

Key concepts and architectural patterns across Physical AI scope, not limited to world models.

## Style Guide

All content must follow these principles:

### 1. Sober and Factual

**Do**: State facts, cite specific results, use measured language
**Don't**: Use hype, marketing language, superlatives without evidence

- Bad: "This groundbreaking paper revolutionizes AI..."
- Good: "Introduces variance-invariance-covariance regularization, achieving 72.3% on ImageNet without labels"

### 2. Concise

**Do**: Dense information, respect reader's time
**Don't**: Verbose explanations, unnecessary background

- Bad: "The paper explores various approaches and after extensive experimentation, the authors found that..."
- Good: "Compares contrastive, predictive, and masked approaches; finds joint-embedding + variance regularization most effective"

### 3. Pattern-Oriented

**Do**: Highlight connections, relationships, recurring themes
**Don't**: Treat each paper/project in isolation

- Bad: "This paper uses a transformer architecture"
- Good: "Extends V-JEPA's masking strategy to text-image pairs, similar to CLIP but with predictive rather than contrastive loss"

### 4. Assume Experience

**Audience**: Decades of research/engineering experience, new to AI

**Do explain**:

- AI-specific terminology (embeddings, attention, latent space)
- Why an approach differs from alternatives
- Architectural innovations

**Don't explain**:

- Basic programming concepts
- General research methodology
- Standard math/statistics

### 5. Technical Precision

**Do**: Use precise technical terms, cite specific architectures, include key equations
**Don't**: Vague descriptions, hand-waving

- Bad: "Uses a clever trick to prevent mode collapse"
- Good: "Prevents collapse via VICReg regularization: variance preservation (hinge loss), invariance to augmentations (MSE), and covariance decorrelation"

### 6. Actionable

**Do**: Include enough detail for reader to dive deeper or implement
**Don't**: Surface-level summaries without substance

**Good summary includes**:

- Specific method names/architectures
- Key hyperparameters or design choices
- Links to code if available
- Performance metrics with dataset context

### 7. Markdown Formatting

Follow standard markdown linting rules (markdownlint). In particular:

- Blank lines before and after headings, fenced code blocks, and lists
- Language specifier on all fenced code blocks (e.g. ` ```python `, ` ```markdown `, ` ```text `)
- No trailing whitespace or multiple consecutive blank lines

**After making changes to Markdown files**: Run `npx markdownlint-cli "**/*.md" --ignore node_modules` to check for linting issues. Fix all errors before committing.

### 8. Competitive Analysis Language

When describing solutions, use factual feature comparisons, not marketing language. State what competes with what and on which dimensions.

- Bad: "NVIDIA dominates the simulation market with their industry-leading platform"
- Good: "Isaac Sim competes with MuJoCo and PyBullet on physics fidelity, GPU acceleration, and sensor simulation; differentiates on photorealistic rendering via RTX"

Use controlled vocabulary for structured fields (see principle 9).

### 9. Controlled Vocabulary Discipline

All fields that may appear in visualizations or comparison tables must use defined controlled values. The vocabularies are:

| Field | Allowed Values |
| --- | --- |
| Demand | `required` \| `important` \| `optional` \| `not needed` |
| Maturity | `Research` \| `Early OSS` \| `Production-ready` \| `Industry standard` |
| Platform fit | `Build` \| `Partner` \| `Integrate` |
| Category | `OSS (community-driven)` \| `OSS (single-vendor)` \| `Source-available` \| `Proprietary` |
| Openness | `OSS-community` \| `OSS-single-vendor` \| `Source-available` \| `Proprietary` |
| Type (ecosystem) | `Big Tech` \| `Startup` \| `OSS Community` \| `Research Lab` |

Free text for context; structured values for data extraction.

## Quality Standards

Before adding content, verify:

- [ ] **Accurate extraction**: Information matches source material
- [ ] **Concise summary**: 2-3 sentences, no fluff
- [ ] **Clear relevance**: Obvious connection to Physical AI or platform strategy
- [ ] **Proper linking**: Cross-references to related entries
- [ ] **Building-block cross-references**: Use cases map to building blocks; projects map to building blocks
- [ ] **Controlled vocabulary compliance**: All structured fields use values from the controlled vocabulary table
- [ ] **Source archiving**: URL recorded and local copy saved where possible (see Source Archiving)
- [ ] **Style guide adherence**: Follows all 9 principles above
- [ ] **No duplicates**: Entry doesn't already exist

## Source Archiving

To ensure long-term availability of referenced materials, archive sources locally.

### Library Structure

```text
research/library/
  papers/          # PDF copies of papers
  screenshots/     # Screenshots of vendor product pages, dashboards
  diagrams/        # Architecture diagrams, system overviews
  videos/          # Video bookmarks (index only; large files not stored)
```

### Naming Convention

Use the format: `YYYY-MM-DD-descriptive-name.ext`

Examples:

- `2025-03-15-v-jepa-2.pdf`
- `2026-01-10-nvidia-isaac-sim-pricing-page.png`
- `2025-11-20-dreamerv3-architecture.svg`

### Size Policy

- **PDFs and images**: Store directly in the appropriate directory
- **Videos > 100 MB**: Do not store the file; instead add a bookmark entry to `research/library/videos/index.md` with URL, title, date, and duration

### When to Archive

- PDF of every tracked paper (when freely available)
- Screenshots of vendor product pages that inform competitive analysis
- Architecture diagrams referenced in building-blocks.md or concepts.md
- Key figures or tables from papers that are frequently referenced

## When to Update vs. Add

### Add New Entry When

- First time encountering a paper, project, or ecosystem player
- Genuinely new use case or application
- New development from existing player (e.g., new paper, product launch)
- New building block emerges from use-case analysis

### Update Existing Entry When

- Project status changes (Active to Archived)
- Player changes affiliation or focus
- Use case evolves or new solutions emerge
- Building-block maturity or platform fit assessment changes
- Correcting errors or adding missing information

## Maintenance Tasks

### Weekly (If Active)

- Review recent additions for quality
- Move items from "Recent Additions" to topic sections
- Check for broken links

### Monthly

- Synthesize new insights into concepts.md
- Update ecosystem affiliations and recent work
- Archive or update stale use cases
- Review building-block demand matrices for accuracy

### As Needed

- Reorganize sections if structure becomes unwieldy
- Add new categories as research expands

## Skills

The user interacts with this repo through slash commands backed by skill files in `.claude/skills/`.

### Intelligence Skills

- **`/company-intel <url-or-name>`** -- Profile a company (exec summary + analyst deep-dive)
- **`/company-intel-synthesis`** -- Cross-company analysis (coverage heat map, partnership network, trend signals)
- **`/project-health-eval <url-or-name>`** -- OSS project community health evaluation (CHAOSS metrics, governance, funding)
- **`/project-tech-eval <url-or-name>`** -- Technical architecture evaluation (dependencies, security, platform fit)
- **`/project-comparison "A" "B" "C"`** -- Side-by-side comparison per building block with Red Hat recommendation

### Research Skills

- **`/add <url>`** -- Add a paper, project, ecosystem entry, or other content from a URL
- **`/search <topic>`** -- Search for papers, projects, startups, or OSS tools on a topic; present results; ask which to add
- **`/sources`** -- Check preferred sources (arXiv, GitHub, blogs, VC trackers) for new content in last 30 days
- **`/synthesize`** -- Review recent additions, identify patterns, update concepts.md, organize entries

### Specialist Skills (invoked automatically or on request)

- **`oss-health`** -- Assess open-source project community health (contributors, governance, bus factor)
- **`solution-analyzer`** -- Compare solutions within a building block on feature dimensions
- **`block-mapper`** -- Derive building-block requirements from a set of use cases

### Natural Language

1. **Providing URLs**: "Add this paper: `https://arxiv.org/abs/...`"
2. **Profiling companies**: "Profile Skild AI"
3. **Comparing solutions**: "Compare vLLM, NIM, and TensorRT-LLM for the Inference Server block"
4. **Requesting searches**: "Find startups doing sim-to-real transfer"
5. **Asking for synthesis**: "What building blocks are needed for robotic manipulation use cases?"

## AI Assistant Role

As AI assistant, your role is to:

- Fetch and extract information accurately
- Apply templates consistently
- Maintain style guide standards (including controlled vocabulary)
- Cross-link related content across all three layers (intelligence reports, platform intelligence, research depth)
- Keep documents organized and scannable
- Flag when new building blocks or ecosystem entries may be warranted

When using slash commands, follow the detailed instructions in the skill files (`.claude/skills/`).
