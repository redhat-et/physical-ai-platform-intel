# Sunday Robotics — Competitive Profile

**Date**: 2026-09-16
**Last updated**: 2026-09-16
**Classification**: Internal analysis — not for public repo

See [deep-dive](sunday-robotics-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.

---

## At a Glance

Sunday Robotics achieved unicorn status ($165M Series B at $1.15B valuation, March 2026, Coatue-led) based on its data engine: co-founder Cheng Chi's (UMI paper first author) Skill Capture Glove ($200 vs ~$20K teleoperation rig) collected 10M demonstration episodes from 500+ wearers with zero robots in loop. Unlike pure data providers (XDOF/Mecka/Config), Sunday is building consumer robot "Memo" (wheeled, household chores) shipping to beta by Thanksgiving 2026. Data engine strategy: collect massive human demonstration data cheaply, train foundation model, deploy in consumer robots. Investors: Coatue, Bain Capital Ventures, Fidelity, Tiger Global, Benchmark, Conviction, Xtal Ventures.

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | $165M Series B at $1.15B valuation (March 2026) |
| **Physical AI thesis** | Low-cost data capture at massive scale (10M episodes from $200 glove) enables consumer robot deployment; data engine creates defensible moat for robot product |
| **Platform coverage** | ~5% of blocks — Data (egocentric via Skill Capture Glove) + consumer robot product (out of scope for platform intelligence) |
| **Relationship to Red Hat** | Complement — data collection methodology relevant but consumer robot focus outside Red Hat's enterprise/edge scope |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Skill Capture Glove** | Low-cost wearable ($200 to produce vs ~$20K teleoperation rig). Collected 10M demonstration episodes from 500+ wearers. Zero robots in loop — pure human task demonstration in real environments. Co-founder Cheng Chi (UMI paper first author) invention. |
| **Data Engine** | 10M episodes data pipeline. Raised $165M at $1.15B largely on data engine strength. Trains foundation model for Memo robot deployment. |
| **Memo Robot** | Wheeled consumer robot for household chores. Beta shipping by Thanksgiving 2026. Transition from demos to real-world deployment. B2C product (not B2B data service). |

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

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 Skill Capture Glove Data<br><small>(10M episodes, egocentric, $200 hardware)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr><td colspan="6"><em>(Other rows omitted — Sunday's consumer robot product out of scope for enterprise platform coverage analysis)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Skill Capture Glove / Data Engine** | Proprietary wearable hardware, proprietary data pipeline. UMI research paper (Cheng Chi) as academic foundation. |
| **Memo Robot** | Proprietary consumer robot product. |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **XDOF/Mecka/Config** | Unicorn valuation ($1.15B vs $1.2B talks/$500M talks/$200M), consumer robot product (vertical integration), lowest cost data capture ($200 glove vs $300-20K rigs), largest episode count (10M vs 130K-100K hours) | Pure data business model (Sunday is vertically integrated into robot product), B2B revenue stream, open dataset release |

---

## Strategic Implications for Red Hat

1. **Data engine as product moat**: Sunday's $1.15B valuation based on data engine (not robot hardware) validates that data collection methodology is core IP. The $200 Skill Capture Glove vs $300-20K teleoperation rigs represents 15-100x cost reduction — could democratize data contribution if licensing model emerges.

2. **Vertical integration risk/opportunity**: Unlike pure data providers, Sunday keeps data proprietary for its Memo robot. This vertical integration limits data-as-a-service opportunity but validates that proprietary datasets create competitive moat. Red Hat should monitor whether Sunday licenses data/models to enterprise customers (unlikely given consumer focus).

3. **UMI research lineage**: Cheng Chi's UMI (Universal Manipulation Interface) paper provides academic credibility. Red Hat should track UMI descendants and whether open-source UMI-based data collection tools emerge for enterprise adoption.

4. **Consumer vs enterprise divergence**: Sunday's consumer robot focus (household chores, B2C) diverges from enterprise/industrial Physical AI (manufacturing, warehousing, B2B). Data collection methodology (Skill Capture Glove) transferable but deployment context differs. Limited Red Hat partnership opportunity given consumer focus.

---

## Sources

- [Sunday raises $165M at $1.15B — Yahoo Finance](https://finance.yahoo.com/news/sunday-raises-165m-launch-first-150000078.html)
- [Sunday unicorn status — TechFundingNews](https://techfundingnews.com/sunday-165m-series-b-1-15b-valuation-home-robots/)
- [Sunday Robotics funding — Humanoids Daily](https://www.humanoidsdaily.com/news/sunday-robotics-raises-165m-to-transition-from-demos-to-real-world-deployment)
- [Robot Training Data Companies: 2026 Landscape — DreamVu](https://www.dreamvu.ai/blog/robot-training-data-companies-2026)
