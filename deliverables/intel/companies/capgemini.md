# Capgemini — Competitive Profile

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

See [deep-dive](capgemini-deep-dive.md) for corporate timeline, Altran acquisition analysis, Hoxo robotics architecture, and partnership details.

---

## At a Glance

Capgemini is a €22.5B (FY 2025) global consulting and technology services firm (423,400 employees) positioning as the lead system integrator for "Intelligent Industry" — digitizing manufacturing, engineering, and operations through AI, digital twins, robotics, and edge computing. Acquired Altran (€3.6B, 2020) to add 47,000 engineering/R&D specialists and rebranded as Capgemini Engineering. Physical AI flagship: the Hoxo humanoid robot deployed at Orano's nuclear facility, trained via NVIDIA Isaac Sim/Lab with VLA models and GR00T N. Operates AI Robotics & Experiences Labs and offers "xLab as a Service" for Physical AI prototyping. Key technology partnerships: NVIDIA (simulation, Isaac, Omniverse), Siemens (industrial AI), Red Hat (hybrid cloud, OpenShift — 2026 Hybrid Cloud Everywhere Partner of the Year). Expanding into agentic AI (>11% of Q1 2026 bookings).

| | |
| --- | --- |
| **Type** | Big Tech |
| **Revenue / Funding** | €22.5B revenue (FY 2025); ~€24B projected FY 2026 |
| **Physical AI thesis** | "Intelligent Industry" — converge digital twins, Physical AI, and autonomous systems to build hyper-adaptive factories; SI expertise bridges lab-to-production gap |
| **Platform coverage** | ~15% of blocks — concentrated in simulation/digital twin consulting, edge deployment, robotics integration |
| **Relationship to Red Hat** | Complement — Red Hat's 2026 Hybrid Cloud Everywhere Partner of the Year; joint OpenShift/edge deployments |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **Intelligent Industry Practice** | Consulting + implementation for manufacturing digital transformation: digital twins, smart factories, autonomous supply chains. Built on Altran engineering acquisition. |
| **AI Robotics & Experiences Lab** | Physical AI R&D lab: sim-to-real robot training via NVIDIA Isaac Sim/Lab, VLA models. Produced Hoxo humanoid for Orano nuclear deployment. |
| **xLab as a Service** | Lab-as-a-service model for Physical AI prototyping — clients access Capgemini's robotics and simulation infrastructure for PoCs without building their own lab. |
| **Ensconce** | Proprietary 5G + edge computing platform for manufacturing (developed with Intel). Enables on-floor AI inference, AMR coordination, real-time analytics. |
| **Smart Edge & IoT Services** | End-to-end IoT platform integration: sensor-to-cloud data pipelines, edge analytics, predictive maintenance, fleet management for industrial clients. |
| **Intelligent Manufacturing for Automotive** | Automotive-specific SI offering: edge AI for existing robot cells, digital twin validation of production lines, hybrid edge-to-cloud platforms. |

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
  <td><b>Simulation Engine</b></td>
  <td>⬜</td>
  <td>🟡 SI services<br><small>(deploys NVIDIA Isaac Sim/Omniverse for clients)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Models & Policies</b></td>
  <td>⬜</td>
  <td>🟡 Hoxo VLA pipeline<br><small>(integrates GR00T N, Isaac Lab for sim-to-real)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>🟡 Edge AI<br><small>(deploys inference at factory floor)</small></td>
</tr>

<tr>
  <td><b>Agentic Framework</b></td>
  <td>🟡 Agentic AI services<br><small>(>11% of bookings, consulting-led)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>App Libs (Robotics)</b></td>
  <td colspan="2">⬜</td>
  <td colspan="2">⬜</td>
  <td>🟡 Robotics integration<br><small>(SI for cobots, AGVs, humanoids)</small></td>
</tr>

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">🟡 SI services<br><small>(deploys OpenShift for clients)</small></td>
  <td colspan="2">🟡 SI services<br><small>(deploys OpenShift for clients)</small></td>
  <td>🟡 Ensconce<br><small>(5G + edge platform with Intel)</small></td>
</tr>

<tr><td colspan="6"><em>(Other rows omitted — Capgemini is an SI, not a product vendor; coverage is deployment/consulting of partner technologies)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **AI Robotics Lab** | Deploys NVIDIA Isaac Sim (open-source), Isaac Lab (open-source), GR00T N for client engagements. No proprietary robotics framework. |
| **Ensconce** | Proprietary edge platform. Developed with Intel. No disclosed OSS foundation. |
| **SI deployments** | Deploys Red Hat OpenShift, Kubernetes, open-source IoT stacks for clients. Consumer, not producer, of OSS. |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **NVIDIA** | Technology | Primary simulation/robotics technology partner. Deploys Isaac Sim, Omniverse, GR00T N, Cosmos. Joint automotive ADAS demos with AWS. |
| **Siemens** | Industrial software | Joint AI-based industrial technologies. Airbus energy digital twin. PLM integration. |
| **Red Hat** | Infrastructure | 2026 Hybrid Cloud Everywhere Partner of the Year. OpenShift deployments, edge computing, Deutsche Telekom joint engagement. |
| **Intel** | Edge hardware | Co-developed Ensconce edge platform. Smart Edge and IoT services. |
| **Orano** | Client / showcase | Hoxo humanoid robot deployment in nuclear facility — flagship Physical AI reference. |
| **AWS** | Cloud | Joint HERO concept car with NVIDIA Omniverse/Cosmos on AWS. Cloud infrastructure for SI engagements. |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Accenture** | Deeper engineering DNA (Altran's 47K R&D specialists), physical robotics deployment track record (Hoxo), stronger NVIDIA simulation partnership | Accenture's broader industry consulting reach, larger digital twin installed base, SynOps AI platform maturity |
| **Deloitte** | Hands-on manufacturing engineering capability, proprietary edge platform (Ensconce), robotics lab infrastructure | Deloitte's strategy consulting brand, broader C-suite advisory relationships, government/defense practice depth |
| **Siemens (as SI competitor)** | Technology-agnostic integration (not locked to own stack), broader multi-vendor deployment capability | Siemens' own industrial software suite (Xcelerator), direct OT/PLC integration, manufacturing installed base |

---

## Coverage Summary

- **Strong**: Physical AI consulting (robotics, sim-to-real, digital twins), edge/IoT deployment services, NVIDIA ecosystem integration, automotive manufacturing AI
- **Absent**: Own simulation engine, own inference server, own model registry, own robot hardware — SI model means deploying partner technologies
- **Conflicts with Red Hat**: None — Capgemini is Red Hat's 2026 Hybrid Cloud Partner of the Year; deploys OpenShift
- **Lock-in**: Engagement-level (consulting contracts), not product-level; multi-vendor by design

---

## Strategic Implications for Red Hat

1. **Premier SI channel for Physical AI platform**: Capgemini's Intelligent Industry practice + Altran engineering workforce is the natural SI partner for deploying Red Hat's Physical AI platform into manufacturing enterprises. The 2026 Partner of the Year relationship provides a foundation.

2. **NVIDIA co-deployment opportunity**: Capgemini deeply integrates NVIDIA Isaac/Omniverse for clients. Red Hat platform (OpenShift, RHEL) as the infrastructure layer underneath NVIDIA simulation + Capgemini SI = three-party solution stack for smart factories.

3. **Edge platform convergence**: Capgemini's Ensconce (5G + edge with Intel) and Red Hat's MicroShift/RHEL for Edge target the same factory-floor tier. Opportunity to integrate rather than compete — Capgemini as SI deploying Red Hat edge infrastructure.

4. **Hoxo as reference architecture**: The Orano nuclear humanoid deployment demonstrates a full sim-to-real pipeline (Isaac Sim → Isaac Lab → GR00T N → physical robot). Red Hat should position platform components (RHEL, OpenShift, edge inference) as the production runtime underneath this pipeline.

5. **Agentic AI expansion**: >11% of Q1 2026 bookings in agentic AI signals rapid enterprise demand. Capgemini will need runtime infrastructure for agent deployment — maps to Red Hat's agentic framework layer (Kagenti, OpenShell).

---

## Sources

- [Capgemini FY 2025 results](https://www.capgemini.com/news/press-releases/full-year-2025-results/)
- [Capgemini Q1 2026 revenues](https://www.capgemini.com/news/press-releases/q1-2026-revenues/)
- [Capgemini upgrades 2026 outlook](https://www.capgemini.com/news/press-releases/capgemini-upgrades-its-2026-outlook/)
- [Capgemini + Orano Hoxo humanoid deployment](https://www.capgemini.com/us-en/news/press-releases/capgemini-and-orano-deploy-the-first-intelligent-humanoid-robot-in-the-nuclear-sector/)
- [Capgemini Physical AI with NVIDIA Isaac — Orano case](https://www.capgemini.com/insights/expert-perspectives/physical-ai-how-orano-and-capgemini-are-redefining-industrial-robotics-with-the-open-nvidia-isaac-platform/)
- [Capgemini xLab as a Service (PDF)](https://www.capgemini.com/be-en/wp-content/uploads/sites/14/2026/04/Lab-as-a-Service_Physical-AI.pdf)
- [Capgemini NVIDIA partnership](https://www.capgemini.com/about-us/technology-partners/nvidia/)
- [Capgemini accelerates agentic AI with NVIDIA](https://www.capgemini.com/news/press-releases/capgemini-accelerates-enterprise-adoption-of-agentic-ai-for-industries-with-nvidia/)
- [Capgemini + Siemens industrial AI partnership](https://www.computerweekly.com/news/366633912/Capgemini-and-Siemens-combine-to-make-AI-industrial-tech)
- [Capgemini Red Hat partnership](https://www.capgemini.com/us-en/about-us/technology-partners/red-hat/)
- [Capgemini Altran acquisition](https://investors.capgemini.com/en/event/capgemini-to-acquire-altran/)
- [Capgemini Intelligent Manufacturing for Automotive](https://www.capgemini.com/us-en/solutions/intelligent-manufacturing-services-for-automotive/)
- [Capgemini Ensconce / 5G edge](https://www.capgemini.com/solutions/edge-ready/)
