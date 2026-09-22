# Dassault Systèmes — Competitive Profile

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

See [deep-dive](dassault-systemes-deep-dive.md) for corporate timeline, product architecture, and NVIDIA partnership details.

---

## At a Glance

Dassault Systèmes is a French PLM/simulation company ($7.1B revenue, ~25,700 employees, 390,000 customers) whose Physical AI relevance centers on its Virtual Twin strategy: combining physics-accurate simulation (SIMULIA), manufacturing/robotics digital twins (DELMIA), and 3D design (CATIA) on the 3DEXPERIENCE platform. In February 2026, announced a long-term strategic partnership with NVIDIA to build "Industry World Models" — integrating NVIDIA Omniverse physical AI libraries into DELMIA for autonomous, software-defined production systems. Operates OUTSCALE sovereign cloud for data-residency-sensitive deployments. CEO Pascal Daloz (promoted to Chairman & CEO Feb 2026 after Bernard Charlès stepped down). Three AI "Virtual Companions" launched: Aura (knowledge orchestration), Leo (engineering), Marie (scientific discovery).

| | |
| --- | --- |
| **Type** | Big Tech |
| **Revenue / Funding** | $7.1B revenue (FY2025); 32% non-IFRS operating margin; €2.4B net cash |
| **Physical AI thesis** | Virtual Twins as "knowledge factories" — physics-grounded simulation of products, factories, and processes; NVIDIA partnership adds physical AI for autonomous production systems and industry world models |
| **Platform coverage** | ~25% of blocks — Simulation, Data, Digital Twin, AI-driven design, robotics simulation, sovereign cloud |
| **Relationship to Red Hat** | Mixed — OUTSCALE sovereign cloud has Red Hat OpenShift partnership; OUTSCALE's own OKS Kubernetes service competes; 3DEXPERIENCE Server runs on RHEL 9 |

---

## Key Products

| Product | What It Does |
| --- | --- |
| **3DEXPERIENCE Platform** | Unified cloud/on-prem platform connecting CATIA, SIMULIA, DELMIA, ENOVIA, BIOVIA, and Medidata. 390,000 customers across 12 industries. |
| **CATIA** | 3D design and engineering — parametric modeling, generative design, systems engineering. Now integrated with NVIDIA AI physics. |
| **SIMULIA** | Multi-physics simulation (structural, fluids, electromagnetics). AI-based Virtual Twin Physics Behavior using NVIDIA CUDA-X. Abaqus finite element solver. |
| **DELMIA** | Manufacturing operations and robotics simulation — 1,500+ robot types, virtual commissioning, AMR fleet planning. Now integrating NVIDIA Omniverse physical AI for autonomous factories. |
| **ENOVIA** | Product lifecycle management — requirements, configuration, change management. |
| **BIOVIA** | Molecular modeling, materials science simulation, lab informatics. |
| **Medidata** | Clinical trial platform — virtual twins for patient-centric drug development. $5.8B acquisition (2019). |
| **OUTSCALE** | Sovereign cloud (SecNumCloud 3.2 certified) — hosts 3DEXPERIENCE, offers OKS (Kubernetes as a Service), deploying NVIDIA AI factories on 3 continents. |
| **Virtual Companions** | Agentic AI assistants (Aura, Leo, Marie) on 3DEXPERIENCE — powered by NVIDIA Nemotron + Dassault industry world models. |

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
  <td>🟢 SIMULIA + DELMIA<br><small>(multi-physics sim, robotics, factory digital twin)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Data</b></td>
  <td>⬜</td>
  <td>🟢 3DEXPERIENCE<br><small>(product/process/manufacturing data lifecycle)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Models & Policies</b></td>
  <td>🟡 Virtual Companions<br><small>(Aura/Leo/Marie agentic AI, NVIDIA Nemotron)</small></td>
  <td>🟡 Industry World Models<br><small>(physics-grounded AI, NVIDIA partnership)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Agentic Framework</b></td>
  <td>🟡 Virtual Companions<br><small>(domain-specific agents, not general framework)</small></td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>Application Runtime</b></td>
  <td colspan="2">🟡 OUTSCALE<br><small>(sovereign cloud, OKS Kubernetes, SecNumCloud)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr>
  <td><b>OS</b></td>
  <td colspan="2">🟡 OUTSCALE<br><small>(cloud OS layer; 3DEXPERIENCE Server on RHEL 9)</small></td>
  <td colspan="2">⬜</td>
  <td>⬜</td>
</tr>

<tr><td colspan="6"><em>(Other rows omitted — Dassault covers simulation, data, models, agentic, and cloud infra)</em></td></tr>
</table>

🟢 Covered  🟡 Partial  🔵 OSS-stewarded  ⬜ No offering  🔴 Conflict  🟣 Hardware — See [visual language](../_templates/visual-language.md) for coverage indicator definitions.

### OSS Foundations

| Product | OSS Foundation |
| --- | --- |
| **3DEXPERIENCE** | Proprietary platform. 3DEXPERIENCE Server supports RHEL 9. |
| **SIMULIA** | Proprietary (Abaqus solver). NVIDIA CUDA-X integration for AI physics. |
| **DELMIA** | Proprietary. Integrating NVIDIA Omniverse (USD-based) physical AI libraries. |
| **OUTSCALE** | Proprietary sovereign cloud. OKS built on Kubernetes (CNCF). Red Hat OpenShift available on OUTSCALE marketplace. |
| **Virtual Companions** | Built on NVIDIA Nemotron open models + proprietary industry world models. |

---

## Hardware & Ecosystem Partnerships

| Partner | Type | Significance |
| --- | --- | --- |
| **NVIDIA** | Strategic (long-term) | Industry World Models, Omniverse integration into DELMIA, CUDA-X for SIMULIA, Nemotron for Virtual Companions. NVIDIA adopts Dassault MBSE for AI factory design. |
| **KUKA** | Industrial robotics | Joined KUKA mosaixx digital ecosystem (2025); DELMIA supports KUKA robot simulation |
| **Omron** | Manufacturing | Integrating NVIDIA physical AI + Dassault Virtual Twin for autonomous production |
| **Lucid Motors** | Automotive | Using SIMULIA + AI physics for EV powertrain engineering |
| **Red Hat** | Infrastructure | OpenShift on OUTSCALE marketplace; 3DEXPERIENCE Server on RHEL 9 |
| **Westwood Robotics** | Humanoid | THEMIS humanoid robot demo linked to 3DEXPERIENCE at MWC 2026 |

---

## Competitive Positioning

| vs | They have | They lack |
| --- | --- | --- |
| **Siemens (Xcelerator)** | Deeper multi-physics simulation (SIMULIA), stronger life sciences vertical (Medidata/BIOVIA), sovereign cloud (OUTSCALE), NVIDIA Industry World Models partnership | Industrial automation hardware, factory-floor edge presence (no equivalent to Siemens PLCs/drives), MindSphere IoT installed base |
| **PTC (Creo/Windchill)** | Broader platform (12 brands vs PTC's focused portfolio), richer simulation, life sciences coverage | IoT/AR integration (ThingWorx/Vuforia), simpler SaaS transition story, ServiceMax field service |
| **NVIDIA (Omniverse)** | 40+ years of industrial domain models, 390K customer relationships, certified physics solvers, regulatory-grade simulation | GPU hardware ecosystem, real-time ray tracing, robotics foundation models (GR00T), edge inference runtime |

---

## Coverage Summary

- **Strong**: Physics simulation (SIMULIA), manufacturing/robotics digital twin (DELMIA), product lifecycle data (3DEXPERIENCE), sovereign cloud (OUTSCALE)
- **Absent**: Edge inference, robot foundation models (depends on NVIDIA), training infrastructure, model serving, robot middleware
- **Conflicts with Red Hat**: OUTSCALE OKS competes with OpenShift; partially mitigated by OpenShift-on-OUTSCALE marketplace listing
- **Lock-in**: 3DEXPERIENCE platform lock-in (proprietary data formats, integrated workflow); OUTSCALE sovereign cloud (French data residency)

---

## Strategic Implications for Red Hat

1. **NVIDIA partnership creates indirect connection**: Dassault's deep NVIDIA integration (Omniverse, CUDA-X, Nemotron) means Red Hat's NVIDIA platform relationship extends into Dassault's 390K customer base. DELMIA + Omniverse autonomous factory deployments will need GPU infrastructure that Red Hat platforms can serve.

2. **OUTSCALE: cooperation and competition**: OUTSCALE's OKS competes with OpenShift, but OpenShift is already on the OUTSCALE marketplace. The sovereign cloud angle (SecNumCloud, French/EU data residency) may drive customers to OUTSCALE where Red Hat could be the container platform underneath. Monitor whether OKS grows or OpenShift remains the preferred option.

3. **3DEXPERIENCE Server on RHEL 9**: Direct platform dependency — Dassault's on-prem deployments run on Red Hat. This is a sustaining relationship to maintain as 3DEXPERIENCE shifts toward cloud.

4. **Factory digital twin → edge platform opportunity**: As DELMIA Virtual Twins extend from design-time simulation to runtime autonomous factory control (the NVIDIA partnership direction), they'll need edge infrastructure at the factory floor. MicroShift or RHEL for Edge could serve this emerging need.

5. **Industry World Models as building block**: Dassault + NVIDIA's "Industry World Models" concept — physics-grounded AI validated against industrial simulation — could become a standard pattern. Red Hat should track whether these models deploy on open infrastructure or remain locked to OUTSCALE/NVIDIA cloud.

---

## Sources

- [Dassault Systèmes + NVIDIA partnership announcement](https://nvidianews.nvidia.com/news/dassault-systemes-nvidia-industrial-ai)
- [Jensen Huang at 3DEXPERIENCE World 2026](https://blogs.nvidia.com/blog/huang-3dexperience-2026/)
- [DELMIA & NVIDIA autonomous factories](https://www.roboticstomorrow.com/story/2026/02/delmia-nvidia-hardcoding-the-future-of-autonomous-factories/26164/)
- [Dassault Systèmes FY2025 results](https://www.3ds.com/newsroom/press-releases/dassault-systemes-q4-revenue-growth-1-solid-operating-margin-and-eps-expansion-initiating-2026-revenue-guidance-3-5-growth)
- [Dassault Systèmes Q1 2026 results](https://investor.3ds.com/news-releases/news-release-details/dassault-systemes-reports-first-quarter-2026-results-line)
- [OUTSCALE Kubernetes as a Service](https://www.3ds.com/newsroom/press-releases/outscale-enhances-outscale-kubernetes-service-support-and-accelerate-sovereign-ai-initiatives)
- [3DEXPERIENCE Server on RHEL 9](https://www.3ds.com/support/hardware-and-software/3dexperience-server-support-red-hat-enterprise-linux-9)
- [Hannover Messe 2026 — mobile robots, AI, virtual twins](https://www.3ds.com/newsroom/media-alerts/mobile-robots-industrial-ai-and-virtual-twins-dassault-systemes-builds-factory-future-hannover-messe)
- [Dassault industrial AI + virtual twins blog](https://blog.3ds.com/topics/company-news/industrial-ai-with-virtual-twins/)
- [Dassault Systèmes acquisitions history](https://www.3ds.com/about/company/acquisitions)
