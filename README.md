# Physical AI Platform Intelligence

Actionable intelligence for building a Physical AI platform: company competitive profiles, OSS project evaluations, building-block analysis, and cross-company synthesis. Built on a research foundation that tracks the ecosystem, publications, and architectural patterns.

AI-driven workflow: provide URLs or search terms, AI extracts and structures the information, you curate the findings.

## Intelligence Reports

### Platform Architecture

- **[Platform Architecture Design](deliverables/physical-ai-platform-architecture-design.md)** -- Red Hat Physical AI platform logical architecture (referenced by company profiles for coverage mapping)

### Competitive Analysis Reports

- **[2026-06-23 Synthesis](deliverables/intel/reports/2026-06-23-synthesis.md)** -- 9-company coverage heat map across 22 platform blocks, partnership network analysis, ecosystem dynamics, 6 trend signals, 8 Red Hat strategic implications

### Company Profiles

| Company | Profile | Deep Dive |
| --- | --- | --- |
| AMD | [amd.md](deliverables/intel/companies/amd.md) | [amd-deep-dive.md](deliverables/intel/companies/amd-deep-dive.md) |
| Figure AI | [figure-ai.md](deliverables/intel/companies/figure-ai.md) | [figure-ai-deep-dive.md](deliverables/intel/companies/figure-ai-deep-dive.md) |
| Google DeepMind | [google-deepmind.md](deliverables/intel/companies/google-deepmind.md) | [google-deepmind-deep-dive.md](deliverables/intel/companies/google-deepmind-deep-dive.md) |
| Intel | [intel.md](deliverables/intel/companies/intel.md) | [intel-deep-dive.md](deliverables/intel/companies/intel-deep-dive.md) |
| Intrinsic (Google) | [intrinsic.md](deliverables/intel/companies/intrinsic.md) | [intrinsic-deep-dive.md](deliverables/intel/companies/intrinsic-deep-dive.md) |
| NVIDIA | [nvidia.md](deliverables/intel/companies/nvidia.md) | [nvidia-deep-dive.md](deliverables/intel/companies/nvidia-deep-dive.md) |
| Physical Intelligence | [physical-intelligence.md](deliverables/intel/companies/physical-intelligence.md) | [physical-intelligence-deep-dive.md](deliverables/intel/companies/physical-intelligence-deep-dive.md) |
| Qualcomm | [qualcomm.md](deliverables/intel/companies/qualcomm.md) | [qualcomm-deep-dive.md](deliverables/intel/companies/qualcomm-deep-dive.md) |
| Skild AI | [skild-ai.md](deliverables/intel/companies/skild-ai.md) | [skild-ai-deep-dive.md](deliverables/intel/companies/skild-ai-deep-dive.md) |

### Project Comparisons

- **[Simulation Engines](deliverables/intel/project-comparisons/simulation-engines.md)** -- Feature matrix, lock-in assessment, production adoption, Red Hat platform fit, recommendation with tradeoffs

### Project Evaluations (Simulation Engines)

| Project | Report | Recommendation |
| --- | --- | --- |
| Newton (LF) | [newton.md](deliverables/intel/projects/newton.md) | Integrate (recommended pick) |
| MuJoCo (DeepMind) | [mujoco.md](deliverables/intel/projects/mujoco.md) | Integrate |
| Gazebo (OSRA) | [gazebo.md](deliverables/intel/projects/gazebo.md) | Partner (runner-up) |
| Isaac Sim (NVIDIA) | [isaac-sim.md](deliverables/intel/projects/isaac-sim.md) | Partner |
| Isaac Lab (NVIDIA) | [isaac-lab.md](deliverables/intel/projects/isaac-lab.md) | Partner |
| Genesis World | [genesis-world.md](deliverables/intel/projects/genesis-world.md) | Integrate (watch) |

### Primers

- [World Models Primer](deliverables/primers/world-models-primer.md) -- What world models are, why they matter, architectural families
- [World Model Lineage](deliverables/primers/model-lineage.md) -- Genealogy of world model evolution
- [Jetson Data Flows](deliverables/primers/jetson-dataflow.html) -- Typical data processing flows on an NVIDIA Jetson platform

## Research Notebook

Foundation research that feeds the intelligence layer.

### Platform Intelligence Layer

- **[building-blocks.md](research/building-blocks.md)** -- Platform capability map: demand matrices, solution landscapes, Build/Partner/Integrate recommendations
- **[ecosystem.md](research/ecosystem.md)** -- Big Tech, startups, OSS communities, research labs with solution-level analysis
- **[use-cases.md](research/use-cases.md)** -- Technical use cases by vertical with building-block requirements and regulatory constraints
- **[projects.md](research/projects.md)** -- OSS implementations by building block with community health and openness analysis

### Research Depth Layer

- **[publications.md](research/publications.md)** -- Papers, talks, videos on world models, embodied AI, simulation, robotics foundations
- **[concepts.md](research/concepts.md)** -- Architectural patterns: JEPA, EBMs, generative vs predictive world models, VLAs

## Using the Notebook

### Intelligence Skills

```text
/company-intel <url-or-name>          Profile a company (exec + deep-dive)
/company-intel-synthesis              Cross-company analysis
/project-health-eval <url-or-name>    OSS community health evaluation
/project-tech-eval <url-or-name>      Technical architecture evaluation
/project-comparison "A" "B" "C"       Side-by-side with recommendation
```

### Research Skills

```text
/add <url>          Add a paper, project, or ecosystem entry
/search <topic>     Find papers, projects, startups
/sources            Scan preferred sources for new content
/synthesize         Review recent additions, identify patterns
```

### Natural Language

```text
"Profile Skild AI"
"Compare vLLM, NIM, and TensorRT-LLM for the Inference Server block"
"Find recent Physical AI startups"
"What building blocks are needed for warehouse robotics?"
"Add this paper: https://arxiv.org/abs/..."
```

## Repository Structure

```text
deliverables/
  intel/
    companies/            Company profiles + deep dives
    projects/             Per-project health + tech reports
    project-comparisons/  Side-by-side comparisons per block
    reports/              Cross-company synthesis reports
    _templates/           Report templates + visual language
  primers/                Educational/reference material
  drafts/                 Work in progress (gitignored)
research/
  building-blocks.md      Platform capability map
  ecosystem.md            Competitive landscape
  use-cases.md            Use cases x verticals
  projects.md             OSS project catalog
  publications.md         Papers, talks, videos
  concepts.md             Architectural patterns
  templates/              Entry templates
.claude/
  skills/                 AI workflow skills (12 skills)
  settings.json           Tool permissions
```
