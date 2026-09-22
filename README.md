# Physical AI Platform Intelligence

Actionable intelligence for building a Physical AI platform: company competitive profiles, OSS project evaluations, building-block analysis, and cross-company synthesis. Built on a research foundation that tracks the ecosystem, publications, and architectural patterns.

AI-driven workflow: provide URLs or search terms, AI extracts and structures the information, you curate the findings.

## Intelligence Reports

### Platform Architecture

- **[Platform Architecture Design](deliverables/physical-ai-platform-architecture-design.md)** -- Red Hat Physical AI platform logical architecture (referenced by company profiles for coverage mapping)

### Competitive Analysis Reports

- **[2026-09-22 Synthesis](deliverables/intel/reports/2026-09-22-synthesis.md)** -- 45-company coverage heat map across 22 platform blocks, partnership networks, alliance blocs, 8 trend signals, 8 Red Hat strategic implications
- **[2026-06-23 Synthesis](deliverables/intel/reports/2026-06-23-synthesis.md)** -- 9-company baseline synthesis

### Company Profiles

| Category | Companies |
| --- | --- |
| **Silicon & Accelerators** | [AMD](deliverables/intel/companies/amd.md), [Intel](deliverables/intel/companies/intel.md), [NVIDIA](deliverables/intel/companies/nvidia.md), [Qualcomm](deliverables/intel/companies/qualcomm.md) |
| **Foundation Models & AI Research** | [Archetype AI](deliverables/intel/companies/archetype-ai.md), [Google DeepMind](deliverables/intel/companies/google-deepmind.md), [Mistral AI](deliverables/intel/companies/mistral-ai.md), [Physical Intelligence](deliverables/intel/companies/physical-intelligence.md), [Skild AI](deliverables/intel/companies/skild-ai.md) |
| **Training Data & Simulation** | **Simulation Assets:** [Imagine.io](deliverables/intel/companies/imagine-io.md), [Lightwheel](deliverables/intel/companies/lightwheel.md), [Palatial](deliverables/intel/companies/palatial.md), [Physicl](deliverables/intel/companies/physicl.md), [Scale AI](deliverables/intel/companies/scale-ai.md) • **Physical Data:** [Config](deliverables/intel/companies/config.md), [Mecka](deliverables/intel/companies/mecka.md), [Sunday Robotics](deliverables/intel/companies/sunday-robotics.md), [XDOF](deliverables/intel/companies/xdof.md) |
| **Developer Tools & Observability** | [Foxglove](deliverables/intel/companies/foxglove.md), [Rerun](deliverables/intel/companies/rerun.md) |
| **Robotics Software Platforms** | [Intrinsic](deliverables/intel/companies/intrinsic.md), [Staer AI](deliverables/intel/companies/staer-ai.md) |
| **Cloud & Infrastructure Providers** | [Nebius](deliverables/intel/companies/nebius.md) |
| **Vertical Solution Providers** | [ABB](deliverables/intel/companies/abb.md), [Dassault Systèmes](deliverables/intel/companies/dassault-systemes.md), [PTC](deliverables/intel/companies/ptc.md), [Rockwell Automation](deliverables/intel/companies/rockwell-automation.md), [Siemens](deliverables/intel/companies/siemens.md), [SteerAI](deliverables/intel/companies/steerai.md), [Tesla](deliverables/intel/companies/tesla.md), [Waymo](deliverables/intel/companies/waymo.md) |
| **System Integrators** | [Accenture](deliverables/intel/companies/accenture.md), [Capgemini](deliverables/intel/companies/capgemini.md), [Deloitte](deliverables/intel/companies/deloitte.md), [Dematic](deliverables/intel/companies/dematic.md), [Toyota Automated Logistics](deliverables/intel/companies/toyota-automated-logistics.md) (merging [Bastian](deliverables/intel/companies/bastian-solutions.md) and [Vanderlande](deliverables/intel/companies/vanderlande.md)) |
| **Robotics OEMs — Humanoid** | [Agility Robotics](deliverables/intel/companies/agility-robotics.md), [Figure AI](deliverables/intel/companies/figure-ai.md), [NEURA Robotics](deliverables/intel/companies/neura-robotics.md), [Prometheus](deliverables/intel/companies/prometheus.md) |
| **Robotics OEMs — Industrial** | [FANUC](deliverables/intel/companies/fanuc.md), [KUKA](deliverables/intel/companies/kuka.md), [Universal Robots](deliverables/intel/companies/universal-robots.md) |

### OSS Project Evaluations

| Building Block / Function | Projects | |
| --- | --- | --- |
| **Robotics Frameworks** | [ROS 2](deliverables/intel/projects/ros2.md) (OSRA), [Isaac ROS](deliverables/intel/projects/isaac-ros.md) (NVIDIA), [Intrinsic Core](deliverables/intel/projects/intrinsic-core.md) (Google) | [compare](deliverables/intel/project-comparisons/robot-middleware.md) |
| **Agent Runtimes** | [OpenShell](deliverables/intel/projects/openshell.md) (NVIDIA) | compare |
| **Data Infrastructure** | [MCAP](deliverables/intel/projects/mcap.md) (Foxglove), [Rerun](deliverables/intel/projects/rerun.md) (Rerun Technologies) | compare |
| **Simulation Engines** | [Newton](deliverables/intel/projects/newton.md) (LF), [MuJoCo](deliverables/intel/projects/mujoco.md) (DeepMind), [Gazebo](deliverables/intel/projects/gazebo.md) (OSRA), [Isaac Sim](deliverables/intel/projects/isaac-sim.md) (NVIDIA), [Isaac Lab](deliverables/intel/projects/isaac-lab.md) (NVIDIA), [Genesis World](deliverables/intel/projects/genesis-world.md), [O3DE](deliverables/intel/projects/o3de.md) (O3DF/LF) | [compare](deliverables/intel/project-comparisons/simulation-engines.md) |

### Primers

- [World Models Primer](deliverables/primers/world-models-primer.md) -- What world models are, why they matter, architectural families
- [World Model Lineage](deliverables/primers/model-lineage.md) -- Genealogy of world model evolution
- [Model Weight Licensing](deliverables/primers/licensing.md) -- Gemma ToU vs Apache 2.0: revocation risk, viral derivatives, Red Hat/OSS impact
- [Robot Policy Serving](deliverables/primers/robot-policy-serving.md) -- LeRobot vs OpenPI protocols, data formats, ecosystem convergence, security risks
- [Physical AI Data Pipelines & Workflows](deliverables/primers/physical-ai-workflows-synthesis.md) -- Canonical workflow patterns, cross-workflow analysis, Red Hat platform mapping
- [Jetson Data Flows](deliverables/primers/jetson-dataflow.html) -- Typical data processing flows on an NVIDIA Jetson platform

### References

- [NVIDIA Jetson Thor Family](deliverables/references/nvidia-jetson-family.md) -- Thor T2000–T5000 specs, Orin comparison, Cosmos 3 Edge, Jetson Agent Skills

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
