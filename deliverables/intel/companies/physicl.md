# Physicl — Competitive Profile

**Date**: 2026-09-16
**Last updated**: 2026-09-16
**Classification**: Internal analysis — not for public repo

See [deep-dive](physicl-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.

---

## At a Glance

Physicl is the training data infrastructure spinout from Nfinite (raised $130M+), positioning as "the training data layer for Physical AI" with a goal of 1M physics-accurate USD assets by 2027. Founded by Alex de Vigan, the company emerged from stealth at NVIDIA GTC (March 2026) with 30-person team (6+ years together from Nfinite). Core differentiation: **"physics calculated, not guessed"** via parametric models where geometry/materials are known and physics properties are mathematically deduced. API/SDK self-service model targets robotics teams and foundation model builders (Meta, DeepMind, World Labs, Getty Images, Adobe as customers).

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | Spinout from Nfinite ($130M+ raised); Physicl-specific funding not disclosed |
| **Physical AI thesis** | Physical AI is data-limited, not model-limited; physics-accurate sim data at scale (1M assets) enables robust training for robotics and world models |
| **Platform coverage** | ~5% of blocks — Data (SimReady assets with parametric variation) |
| **Relationship to Red Hat** | Complement — provides training data assets with API/SDK integration; no platform conflict |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Physicl Platform** | Physics-accurate USD asset library (3,000+ at launch → 1M by 2027) with API/SDK access. Parametric scene generation producing infinite variations. Physics derived via parametric models (not estimated). 98% sim-ready rate, 98% QC pass rate with RLHF validation. Exports to Isaac Sim, MuJoCo, Unreal, Habitat, Omniverse. |
| **Python SDK + REST API** | API-first architecture "built for training loops" — assets drop directly into pipelines, no manual import/conversion. Commercial licensing for AI training use. |
| **Domain Coverage** | Home, commercial, industrial, healthcare environments. Rigid, articulated (joints/moving parts), and deformable (cloth/foam) asset categories. Fills gaps NVIDIA SimReady doesn't cover: domestic/commercial spaces. |

---

## Architecture Coverage

<table>
<tr>
  <th rowspan="2">Block</th>
  <th colspan="2">Central Site</th>
  <th colspan="2">Distributed Sites</th>
  <th rowspan="2">Edge</th>
</tr>
<tr>
  <th>Language</th><th>Physical AI</th>
  <th>Language</th><th>Physical AI</th>
</tr>

<!-- === Training & Evaluation === -->

<tr>
  <td><b>Train Workloads</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 Asset compatibility<br><small>(provides assets for Isaac Sim/MuJoCo/Unreal/Habitat, not the engine)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Eval</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Physicl Platform<br><small>(3K+ → 1M assets, parametric variation, API/SDK)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Train Infra</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === AI Model & Data Lifecycle === -->

<tr>
  <td><b>Model Registry</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Pipelines</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>CI/CD & GitOps</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Experiment Tracking</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Model Monitoring</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Agentic Framework === -->

<tr>
  <td><b>Agentic Framework</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<!-- === Models & Policies === -->

<tr>
  <td><b>Models & Policies</b></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<!-- === Model Serving === -->

<tr>
  <td><b>MaaS</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Inference Server</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>llm-d</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>KServe</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Application Libraries === -->

<tr>
  <td><b>App Libs (Math/AI)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Media)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<!-- === Platform === -->

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Drivers</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Physicl Platform** | OpenUSD (Apache 2.0) format; URDF support for ROS ecosystems. Proprietary parametric modeling engine and physics derivation pipeline. API/SDK integration layer is proprietary. |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **Getty Images** | Content | Strategic partnership (January 2026) transforming Getty's 2D imagery into high-fidelity 3D scenes with physical context for spatially-aware AI |
| **NVIDIA** | Platform | Assets export to Isaac Sim/Omniverse; Physicl presented at GTC 2026; positioned as complementary to NVIDIA SimReady library |
| **Meta, Adobe, Microsoft, Unity, AWS** | Customers | Technology partners/customers using Physicl platform for Physical AI training data |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Lightwheel** | 1M asset ambition (vs Lightwheel's 2,000 catalog), API/SDK self-service model, broader simulator support (MuJoCo, Unreal, Habitat beyond Isaac Sim) | Measured physics from factory (Physicl uses parametric deduction, not empirical measurement), evaluation platform (no RoboFinals equivalent), unicorn funding/customer tier (no DeepMind/Figure named) |
| **Imagine.io** | API/SDK self-service, 1M asset target (vs 2,500), broader domain coverage (home/commercial/healthcare vs kitchen focus), parametric variation at API level | Catalog size today (3K at launch vs Imagine.io's 2,500 ready), custom environment building service, established market presence |
| **Palatial** | 3K+ catalog at launch vs Palatial's recent 10K generated, API/SDK access model, 1M target scale, broader customer base (Meta/DeepMind/Adobe named) | Automated pipeline speed (Palatial generates assets faster), soft-body/articulation automation maturity, natural language agent interface |

---

## Coverage Summary

- **Strong**: Physical AI training data (USD/URDF assets with parametric physics), API/SDK integration for training loops, multi-simulator support (Isaac Sim, MuJoCo, Unreal, Habitat, Omniverse)
- **Absent**: Training infrastructure, simulation engine itself, evaluation platform, model serving, platform components — pure data provider
- **Conflicts with Red Hat**: None — complementary asset and API layer
- **Lock-in**: Multi-simulator strategy reduces lock-in vs NVIDIA-only providers; OpenUSD portability

---

## Strategic Implications for Red Hat

1. **API/SDK self-service model validation**: Physicl's API-first, "built for training loops" approach validates demand for programmatic asset access vs catalog browsing/licensing. Red Hat RHOAI should support API-driven training data ingestion (not just manual asset upload), with OpenUSD + URDF as first-class formats.

2. **Parametric physics derivation vs empirical measurement**: Physicl's "physics calculated not guessed" via parametric models differs from Lightwheel's Physics Measurement Factory empirical approach. Both claim superior sim-to-real transfer vs approximated physics. Red Hat should monitor which methodology proves more effective at scale — impacts platform validation requirements.

3. **1M asset ambition signals market expectations**: Physicl's 1M by 2027 target (vs Lightwheel's 2,000, Imagine.io's 2,500) suggests robotics teams need massive asset diversity for robust training. This validates parametric/generative approaches over manual curation. Red Hat platform should support high-throughput asset pipelines (100K assets/month per Physicl's capacity claim).

4. **Multi-simulator strategy as competitive moat**: Unlike NVIDIA-centric competitors, Physicl exports to Isaac Sim, MuJoCo, Unreal, Habitat — hedge against simulation engine lock-in. Red Hat should maintain similar simulation-engine agnosticism to serve diverse customer bases.

5. **Nfinite pedigree and Getty partnership**: Physicl's spinout from Nfinite ($130M+ raised, Getty Images collaboration) provides 3D asset generation expertise and content licensing relationships. The Getty partnership (2D→3D+physics transformation) represents a differentiated asset sourcing strategy vs purely synthetic or CAD-based approaches.

6. **Customer roster validates top-tier demand**: Meta, DeepMind, World Labs, Adobe, AWS, Microsoft, Unity, OpenAI, Stanford as customers signals broad Physical AI ecosystem adoption. These customers validate both the technical approach (parametric physics) and commercial model (API/SDK licensing).
