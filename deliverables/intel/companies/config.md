# Config — Competitive Profile

**Date**: 2026-09-16
**Last updated**: 2026-09-16
**Classification**: Internal analysis — not for public repo

See [deep-dive](config-deep-dive.md) for OSS foundations, acquisition details, and technical architecture.

---

## At a Glance

Config is positioning as the "TSMC of robot data" — Seoul/San Jose dual headquarters with backing from all four Korean manufacturing giants (Samsung, Hyundai, LG, SK). Raised $27M seed (May 2026) led by Samsung Venture Investment at $200M+ valuation, with strategic investors Hyundai ZER01NE, LG Tech Ventures, SKT America. Focus: data infrastructure for general-purpose bimanual robotics. 100K+ hours of human motion data (30x larger than AgiBot World's 3K hours). Operations in Seoul + Hanoi with ~300 data production workforce. Targets 1M hours data + $10M ARR by end-2026. Angel investor: Pieter Abbeel (UC Berkeley, Covariant AI).

| | |
| --- | --- |
| **Type** | Startup |
| **Revenue / Funding** | $27M seed at $200M+ valuation; targets $10M ARR end-2026 |
| **Physical AI thesis** | Bimanual manipulation data at scale (1M hours target) enables general-purpose robot foundation models; Korean manufacturing partnerships provide deployment validation + customer pipeline |
| **Platform coverage** | ~5% of blocks — Data (bimanual robot training data) |
| **Relationship to Red Hat** | Complement — provides bimanual manipulation data; no platform conflict |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Bimanual Data Infrastructure** | Data layer for general-purpose bimanual robotics. 100K+ hours of human motion data (30x AgiBot World). Operations in Seoul + Hanoi (~300 person data production workforce). |
| **Enterprise Platform** | B2B data platform for robot foundation model training. Target $10M ARR end-2026. |
| **RaaS Product (Planned)** | Cloud-based robot-as-a-service letting companies run Config's foundation model without onboard hardware. Launch timing not disclosed. |

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
  <td>🟢 Bimanual Data<br><small>(100K+ hours, Seoul/Hanoi ops)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr><td colspan="6"><em>(Other rows omitted — Config only covers Data block)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **Bimanual Data Infrastructure** | Proprietary data collection pipeline. No OSS components identified. |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **XDOF** | Korean manufacturing partnerships (Samsung/Hyundai/LG/SK), Asia-Pacific presence (Seoul/Hanoi), 100K hours dataset (vs ABC-130K's 130K episodes different metric), planned RaaS product | Larger funding ($27M vs $70M), open dataset release, UC Berkeley academic pedigree, $1.2B valuation trajectory |
| **Mecka** | 100K hours public claim, Korean manufacturing validation pipeline, dual Seoul/San Jose presence | Larger funding ($27M vs $68M), higher valuation (~$200M vs ~$500M), revenue trajectory ($10M target vs $100M projected) |

---

## Strategic Implications for Red Hat

1. **Korean manufacturing validation pipeline**: Samsung/Hyundai/LG/SK backing provides access to real manufacturing deployment environments — validates data quality via industrial use cases. Red Hat should monitor whether Korean partnerships translate to enterprise adoption vs just strategic investment.

2. **Asia-Pacific market positioning**: Seoul/Hanoi operations + Korean investor base targets different geography than U.S.-focused XDOF/Mecka. Red Hat's Asia-Pacific Physical AI strategy should consider Config as regional partner/customer.

3. **Bimanual specialization**: Focused on general-purpose bimanual (vs XDOF's broader manipulation categories) suggests deep expertise in two-arm coordination tasks. Monitor whether bimanual becomes dominant paradigm for humanoid robotics.

---

## Sources

- [Config raises $27M seed — TechCrunch](https://techcrunch.com/2026/05/11/koreas-biggest-manufacturers-back-config-the-tsmc-of-robot-data/)
- [Config funding details — Six Degrees Of Robotics](https://sixdegreesofrobotics.com/robot-news/samsung-backed-config-raises-27m-to-become-the-tsmc-of-robot-data/)
- [Robot Training Data Companies: 2026 Landscape — DreamVu](https://www.dreamvu.ai/blog/robot-training-data-companies-2026)
