---
name: sources
description: Check preferred sources for new Physical AI content in last 30 days
user-invocable: true
---

# Check Preferred Sources

Monitor preferred sources for new Physical AI content.

## Usage

```text
/sources
```

## Instructions

When this command is invoked:

1. **Read preferred sources** from `research/tools/preferred-sources.md`
2. **Check each source category** (in priority order):

   **Preprint Searches — Architectures & Methods** (Priority 1):
   - Search arXiv and TechRxiv for architecture/method queries (JEPA, EBM, world models, robot foundation models)
   - Filter to last 30 days only
   - Identify papers not yet in publications.md

   **Preprint Searches — Physical AI Platform & Infrastructure** (Priority 2):
   - Search for platform/infrastructure queries (Physical AI deployment, ROS2, digital twins, sim-to-real)
   - Filter to last 30 days

   **GitHub Organizations** (Priority 3):
   - Check listed GitHub orgs for new repos and releases
   - Include: facebookresearch, google-deepmind, nvidia-cosmos, Physical-Intelligence, ros2, Genesis-Embodied-AI, huggingface/lerobot
   - Filter to last 30 days

   **Company Blogs — Big Tech & Research Labs** (Priority 4):
   - Meta AI, Google DeepMind, NVIDIA, Siemens, Schneider Electric
   - Look for Physical AI announcements, product launches, research releases

   **Company Blogs — Startups & Emerging Players** (Priority 5):
   - Figure AI, Agility, 1X, Unitree, Physical Intelligence (pi.website/blog, pi.website/research), Covariant, Skild, Intrinsic
   - Foxglove, Formant, MathWorks
   - Look for funding, product launches, technical posts

   **Industry News & Startup Tracking** (Priority 6):
   - The Robot Report, TechCrunch Robotics/AI, IEEE Spectrum Robotics
   - Crunchbase (via WebSearch) for funding signals
   - ROS Discourse for community developments

   **Simulation & Digital Twin Ecosystem** (Priority 7):
   - NVIDIA Omniverse / Isaac Sim release notes
   - Open Robotics blog, Gazebo Community
   - Eclipse Foundation (Ditto releases)

   **Standards & Governance** (Priority 8):
   - ROS Enhancement Proposals (REPs)
   - CHAOSS, OpenSSF Scorecard updates
   - OSRA announcements

   **Researcher Pages** (Priority 9):
   - Check Google Scholar pages for new publications
   - Check personal websites/blogs for new content

3. **Rank findings**:
   - Relevance to Physical AI platform intelligence
   - Recency
   - Source credibility
   - Potential impact (citations, engagement, funding amount)

4. **Present top findings**:
   - Group by category (Papers, Projects, Ecosystem, Solutions, Industry News)
   - Show top 3-5 from each category
   - Include: title, source, date, 1-sentence description

5. **Ask which to add**: "Which would you like me to add? (e.g., 'P1, P3, E1' for Papers 1,3 and Ecosystem 1)"

6. **Add selected items** using `/add` workflow

## Output Format

```text
Checked preferred sources (last 30 days):

PAPERS (arXiv)
P1. [2026-06-10] "V-JEPA 2.1: Temporal Coherence in Latent Space"
    Authors: Bardes et al. (AMI Labs)
    Extends V-JEPA with improved temporal prediction, 12% better on downstream robotics tasks

P2. [2026-06-05] "Physics-Aware World Models for Industrial Digital Twins"
    Authors: Chen et al. (Siemens Research)
    Combines PhysicsNeMo surrogates with world models for factory optimization

PROJECTS (GitHub)
G1. [2026-06-08] Genesis-Embodied-AI/genesis-world v0.8
    New release with ROCm support and improved physics fidelity (29K stars)

ECOSYSTEM
E1. [2026-06-12] Skild AI announces $300M Series A
    Building general-purpose robot foundation model, CMU spinout
    Source: TechCrunch

SOLUTIONS
S1. [2026-06-01] NVIDIA Isaac ROS 4.0 released
    Adds support for GR00T N1.7 inference, new perception pipeline
    Source: NVIDIA Developer Blog

INDUSTRY NEWS
N1. [2026-06-07] OSRA announces ROS2 LTS support policy
    5-year LTS for Iron Irwini, enterprise certification program
    Source: Open Robotics Blog

Which would you like me to add? (e.g., 'P1, G1, E1')
```

## Avoiding Duplicates

Before presenting results:

- Check if paper title/URL already exists in publications.md
- Check if project already exists in projects.md
- Check if player already exists in ecosystem.md
- Only show genuinely new content

## Error Handling

- If a source is unavailable, skip and note it
- If no new content found, inform user: "No new content in preferred sources (last 30 days)"
- If many results (>15), present top-ranked only
