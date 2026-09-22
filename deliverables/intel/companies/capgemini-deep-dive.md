# Capgemini — Deep Dive Research

**Date**: 2026-09-22
**Last updated**: 2026-09-22
**Classification**: Internal analysis — not for public repo

Supporting research for the [Capgemini competitive profile](capgemini.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: Altran acquisition analysis, Hoxo robotics architecture, partnership details, and SI competitive dynamics.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 1967 | Founded in Paris by Serge Kampf as Sogeti |
| 2019-06 | Announces €3.6B bid for Altran Technologies (engineering/R&D consultancy) |
| 2020-04 | Completes Altran acquisition (98.15% of shares, ~€4.1B including debt). 47,000 engineers integrated. |
| 2021-04 | Altran rebranded as Capgemini Engineering |
| 2023-02 | Opens 5G Solutions Center in San Francisco (complements Paris, Fundão, Mumbai labs) |
| 2025-07 | Acquires WNS Global Services ($3.3B) — BPO + agentic AI operations |
| 2025-11 | Deploys Hoxo humanoid robot at Orano Melox nuclear facility (first intelligent humanoid in nuclear sector) |
| 2026-01 | Hannover Messe 2026: showcases Physical AI and embodied AI for shopfloor |
| 2026-04 | Publishes "xLab as a Service" Physical AI offering |
| 2026 | Named Red Hat Hybrid Cloud Everywhere Partner of the Year |
| 2026 | Agentic AI exceeds 11% of Q1 bookings; announces €700M restructuring plan for AI-driven talent alignment |

### Acquisitions — What Each Brought

#### Altran Technologies (2020)

- **Price**: €3.6B bid / ~€4.1B total including debt
- **Technology**: Engineering and R&D services across aerospace, automotive, life sciences, telecoms. 47,000 engineers and R&D specialists. Deep OT/industrial expertise.
- **Integration**: Rebranded as Capgemini Engineering (April 2021). Formed the backbone of the "Intelligent Industry" practice. Contributed >€3B incremental revenue.
- **Significance**: Transformed Capgemini from IT services firm to engineering + IT services firm. Critical for Physical AI credibility — engineering workforce enables sim-to-real robotics, digital twin deployment, and factory-floor integration that IT-only SIs cannot deliver.

#### WNS Global Services (2025)

- **Price**: $3.3B all-cash
- **Technology**: Business process outsourcing + AI-powered operations. Added 65,000+ employees (primarily offshore).
- **Integration**: Merged into Operations & Engineering segment. Headcount jumped to 423,400.
- **Significance**: Enables agentic AI-powered intelligent operations at scale. Less directly relevant to Physical AI but expands AI delivery capacity.

---

## 2. Product Architecture Details

### Hoxo Humanoid Robot (Orano Deployment)

| Aspect | Details |
| --- | --- |
| **Architecture** | Humanoid robot with embedded AI + advanced sensors. Training pipeline: NVIDIA Isaac Sim (photorealistic simulation) → Isaac Lab (RL training) → GR00T N VLA model (vision-language-action). Digital twin of Orano Melox facility created in Isaac Sim for sim-to-real transfer. |
| **Runtime dependencies** | NVIDIA Isaac Sim/Lab for training. NVIDIA GR00T N for inference (VLA model merging visual understanding, linguistic reasoning, motor control). On-robot compute (not disclosed). |
| **Extension model** | Task-adaptable via natural language commands ("Inspect the containment area and report anomalies" → robot translates to physical action sequence). New tasks trained in simulation without physical reprogramming. |
| **Key limitations** | Prototype stage — four-month pilot at Orano Melox training facility, not production deployment. Dependent on NVIDIA stack (Isaac Sim, GR00T N). Scaling path ("pilots to fleets") not yet demonstrated. |

<!-- TODO: deep research needed — robot hardware platform (is it an off-the-shelf humanoid like Agility Digit or custom?), on-robot compute specs, inference latency, specific tasks validated -->

### Ensconce Edge Platform

| Aspect | Details |
| --- | --- |
| **Architecture** | 5G + edge computing platform for manufacturing. Developed with Intel. Positioned as "100% pure edge platform." |
| **Runtime dependencies** | Intel hardware. 5G CBRS network connectivity. |
| **Extension model** | Supports computer vision, AMR coordination, real-time analytics at factory floor. |
| **Key limitations** | Proprietary. Limited public documentation on architecture, APIs, deployment model. |

<!-- TODO: deep research needed — Ensconce architecture details, relationship to Red Hat OpenShift at edge, Intel hardware specs, deployment customer count -->

### xLab as a Service

| Aspect | Details |
| --- | --- |
| **Architecture** | Physical AI lab-as-a-service: clients access Capgemini's robotics simulation and testing infrastructure for PoCs. Integrates AI, computer vision, autonomous navigation, digital twins. |
| **Runtime dependencies** | NVIDIA Isaac Sim, Isaac Lab, Omniverse. Capgemini AI Robotics & Experiences Lab infrastructure. |
| **Extension model** | Service engagement — Capgemini engineers work alongside client teams. Not a self-service platform. |
| **Key limitations** | Services model, not product. Scales with headcount, not software licenses. |

<!-- TODO: deep research needed — xLab locations, pricing model, specific robot platforms supported, client engagement examples beyond Orano -->

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **AI Robotics Lab** | NVIDIA Isaac Sim (open-source), Isaac Lab (open-source) | Apache 2.0 | Sim-to-real training pipeline, VLA integration, domain-specific digital twin creation |
| **Ensconce** | None disclosed | N/A | 5G + edge platform (proprietary, co-developed with Intel) |
| **SI deployments** | Red Hat OpenShift, Kubernetes, various OSS IoT stacks | Various | Integration services, deployment engineering, managed operations |

### Pattern Analysis

Capgemini is an OSS consumer, not producer. Their model: deploy open-source and partner technologies (NVIDIA Isaac, Red Hat OpenShift, Kubernetes) as the foundation, then add proprietary integration value through engineering services. This is the classic SI pattern — no OSS governance risk because they don't steward projects, but also no community influence.

The one exception is the proprietary Ensconce edge platform, which competes in a space where Red Hat also operates (edge Kubernetes). This is worth monitoring but appears to be a niche offering rather than a strategic platform play.

### Notable Dependencies

- **NVIDIA dependency for Physical AI**: Hoxo pipeline is built entirely on NVIDIA Isaac Sim/Lab + GR00T N. If NVIDIA changes licensing or pricing, Capgemini's Physical AI lab offering is directly affected.
- **Red Hat dependency for infrastructure**: OpenShift is the primary container platform Capgemini deploys for clients. Strong alignment but also dependency.

---

## 4. Governance & Community Risk

Not applicable — Capgemini does not steward any OSS projects. Pure consumer/deployer of open-source technologies.

---

## 5. Hardware Platform Details

Not applicable — Capgemini is a services company. Hardware comes from partners (Intel for edge, NVIDIA for GPU/simulation, robot OEMs for physical platforms).

---

## 6. Partnership & Ecosystem Details

| Partner | Installed Base | Deal Details | Integration Depth |
| --- | --- | --- | --- |
| **NVIDIA** | Global | Strategic technology partnership. Joint solutions: Isaac Sim/Lab for robotics, Omniverse for digital twins, Cosmos for synthetic data, GR00T N for humanoids. Joint HERO concept car with AWS. | Deep — co-developed solutions, joint client engagements, NVIDIA tech embedded in Capgemini labs |
| **Siemens** | Global | Partnership to create AI-based industrial technologies. Airbus engagement (energy digital twins). PLM integration. | Medium — joint industrial client engagements |
| **Red Hat** | Global | 2026 Hybrid Cloud Everywhere Partner of the Year. OpenShift deployments, Deutsche Telekom joint engagement. Edge computing collaborations. | Deep — Red Hat is primary container/hybrid cloud platform for Capgemini SI engagements |
| **Intel** | Global | Co-developed Ensconce edge platform. Smart Edge and IoT services foundation. | Medium — hardware + co-engineering |
| **AWS** | Global | Cloud infrastructure for SI engagements. Joint HERO concept car (Omniverse/Cosmos on AWS). | Medium — cloud deployment partner |
| **Orano** | 1 site (Melox) | Hoxo humanoid deployment in nuclear facility. Four-month pilot at training school. Plans to scale to fleet. | Deep — co-development, embedded Capgemini engineers |

### Developer Ecosystem

Capgemini has no developer ecosystem in the platform sense. Their "ecosystem" is their 423,400-person workforce — engineers are trained on partner technologies (NVIDIA, Red Hat, AWS, etc.) and deployed to client engagements. The xLab as a Service model is the closest analog to a platform, but it's a services engagement, not a self-service developer tool.

---

## 7. Detailed Competitive Analysis

### vs Accenture (SI for Physical AI)

| Dimension | Capgemini | Accenture |
| --- | --- | --- |
| **Revenue** | €22.5B (FY 2025) | $65.1B (FY 2025) |
| **Engineering DNA** | Altran acquisition (47K R&D engineers) — deep manufacturing/OT expertise | Industry X practice + acquisitions, but IT-services heritage |
| **Physical AI showcase** | Hoxo humanoid robot at Orano nuclear facility | Digital twin implementations, Industry X digital factories |
| **NVIDIA relationship** | Deep: Isaac Sim/Lab, Omniverse, GR00T N, joint labs | Also partner, but less visible Physical AI co-development |
| **Edge platform** | Ensconce (proprietary, with Intel) | Accenture Edge Platform |
| **Red Hat relationship** | 2026 Partner of the Year | Also Red Hat partner, but different positioning |

### vs Deloitte (SI for manufacturing)

| Dimension | Capgemini | Deloitte |
| --- | --- | --- |
| **Positioning** | Engineering-led ("Intelligent Industry") | Strategy/advisory-led ("Smart Factory") |
| **Physical AI depth** | Robotics lab, sim-to-real pipeline, humanoid deployment | Digital twin consulting, predictive maintenance advisory |
| **Engineering headcount** | 47K+ via Altran | Smaller engineering workforce; advisory-heavy |
| **Factory-floor credibility** | OT + IT integration via Altran engineers | Stronger C-suite advisory; less hands-on-floor |

---

## Sources

- [Capgemini FY 2025 results](https://www.capgemini.com/news/press-releases/full-year-2025-results/)
- [Capgemini Q1 2026 revenues](https://www.capgemini.com/news/press-releases/q1-2026-revenues/)
- [Capgemini upgrades 2026 outlook](https://www.capgemini.com/news/press-releases/capgemini-upgrades-its-2026-outlook/)
- [Capgemini + Orano Hoxo humanoid](https://www.capgemini.com/us-en/news/press-releases/capgemini-and-orano-deploy-the-first-intelligent-humanoid-robot-in-the-nuclear-sector/)
- [Capgemini Physical AI with NVIDIA Isaac](https://www.capgemini.com/insights/expert-perspectives/physical-ai-how-orano-and-capgemini-are-redefining-industrial-robotics-with-the-open-nvidia-isaac-platform/)
- [Capgemini xLab as a Service](https://www.capgemini.com/be-en/wp-content/uploads/sites/14/2026/04/Lab-as-a-Service_Physical-AI.pdf)
- [Capgemini NVIDIA partnership](https://www.capgemini.com/about-us/technology-partners/nvidia/)
- [Capgemini agentic AI with NVIDIA](https://www.capgemini.com/news/press-releases/capgemini-accelerates-enterprise-adoption-of-agentic-ai-for-industries-with-nvidia/)
- [Capgemini + Siemens industrial AI](https://www.computerweekly.com/news/366633912/Capgemini-and-Siemens-combine-to-make-AI-industrial-tech)
- [Capgemini Red Hat partnership](https://www.capgemini.com/us-en/about-us/technology-partners/red-hat/)
- [Capgemini Altran acquisition](https://investors.capgemini.com/en/event/capgemini-to-acquire-altran/)
- [Altran integration details](https://www.consultancy.eu/news/2909/capgemini-buys-engineering-consultancy-altran-for-36-billion)
- [Capgemini WNS acquisition](https://tbri.com/blog/capgemini-to-acquire-wns-for-3-3b-tripling-bpo-revenue-and-accelerating-ai-ambitions/)
- [Capgemini Intelligent Manufacturing Automotive](https://www.capgemini.com/us-en/solutions/intelligent-manufacturing-services-for-automotive/)
- [Capgemini Hannover Messe 2026](https://www.capgemini.com/fi-en/news/events/hannover-messe-2026/)
- [Capgemini Ensconce / 5G edge](https://www.capgemini.com/solutions/edge-ready/)
- [Capgemini Smart Edge and IoT](https://www.capgemini.com/solutions/smart-edge-and-iot-services/)
