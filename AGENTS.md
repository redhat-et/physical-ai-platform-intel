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

Workflows are implemented as skills in `.claude/skills/`. See the Skills section below for the full list. Each skill file contains detailed step-by-step instructions; this file covers only cross-cutting concerns (style, quality, vocabulary).

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

**Audience**: Decades of research/engineering experience, fairly new to AI

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

Archive sources locally for long-term availability. Library structure:

```text
research/library/
  papers/          # PDF copies of papers
  screenshots/     # Screenshots of vendor product pages, dashboards
  diagrams/        # Architecture diagrams, system overviews
  videos/          # Video bookmarks (index only; large files not stored)
```

**Naming convention**: `YYYY-MM-DD-descriptive-name.ext` (e.g., `2025-03-15-v-jepa-2.pdf`)

**Size policy**: PDFs and images stored directly. Videos > 100 MB: bookmark only in `research/library/videos/index.md`.

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

## Skills

The user interacts with this repo through slash commands backed by skill files in `.claude/skills/`. Each skill contains its own detailed workflow instructions.

### Intelligence Skills

- `/company-intel` -- Profile a company
- `/company-intel-synthesis` -- Cross-company analysis
- `/project-health-eval` -- OSS project community health evaluation
- `/project-tech-eval` -- Technical architecture evaluation
- `/project-comparison` -- Side-by-side comparison with Red Hat recommendation

### Research Skills

- `/add` -- Add content from a URL (paper, project, ecosystem entry, etc.)
- `/search` -- Search for content on a topic
- `/sources` -- Check preferred sources for new content (last 30 days)
- `/synthesize` -- Review recent additions, identify patterns, organize entries

### Specialist Skills (invoked automatically by other skills)

- `oss-health` -- OSS project community health assessment
- `solution-analyzer` -- Solution competitive analysis
- `block-mapper` -- Building-block cross-reference updates

### Natural Language

1. **Providing URLs**: "Add this paper: `https://arxiv.org/abs/...`"
2. **Profiling companies**: "Profile Skild AI"
3. **Comparing solutions**: "Compare vLLM, NIM, and TensorRT-LLM for the Inference Server block"
4. **Requesting searches**: "Find startups doing sim-to-real transfer"
5. **Asking for synthesis**: "What building blocks are needed for robotic manipulation use cases?"
