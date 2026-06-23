# Physical Intelligence — Deep Dive Research

**Date**: 2026-06-23
**Last updated**: 2026-06-23
**Classification**: Internal analysis — not for public repo

Supporting research for the [Physical Intelligence competitive profile](physical-intelligence.md). This document covers material that informs the profile's assessments but is too detailed for the exec-level read: model architecture evolution, OSS foundations analysis, research timeline, training infrastructure, and competitive dynamics.

---

## 1. Corporate Timeline & Acquisitions

### Timeline

| Date | Event |
| --- | --- |
| 2024-03 | Founded; emerged from stealth. Seed round ~$70M at ~$400M (Thrive Capital, OpenAI, Khosla, Sequoia, Lux) |
| 2024-10 | π0 paper (arXiv 2410.24164). First generalist VLA: 3.3B params, 7 robot configs, 68 tasks |
| 2025-01 | π0-FAST released. Autoregressive variant with DCT-based action tokenization. 5× faster training |
| 2025-02 | "Hi Robot" — open-ended instruction following with hierarchical VLAs |
| 2025-04 | π0.5 — open-world generalization via knowledge insulation |
| 2025-06 | Real-time action chunking paper (accepted NeurIPS 2025) |
| 2025-09 | openpi open-sourced with π0, π0-FAST, π0.5 weights + fine-tuning code |
| 2025-11 | Series A: $400M at $2.4B (Jeff Bezos, OpenAI, Thrive, Lux, Sequoia, Khosla) |
| 2025-11 | π\*0.6 (RECAP) — self-improvement via RL. Full-shift autonomy demos |
| 2025-11 | Series B: $600M at $5.6B (CapitalG lead, NVIDIA NVentures, Lux, Sequoia, T. Rowe Price) |
| 2025-12 | Human-to-robot transfer in VLAs |
| 2026-01 | TechCrunch profile: ~80 employees, Lachy Groom's COO role, SF Mission District HQ |
| 2026-02 | Partner blog: Weave and Ultra deployment results published |
| 2026-03 | MEM (multi-scale embodied memory) and RLT (efficient online RL) papers |
| 2026-03 | Series C reportedly in talks: ~$1B at ~$11B (Founders Fund, Lightspeed, Thrive, Lux) |
| 2026-04 | π0.7 — 5B-param model with compositional generalization and cross-embodiment transfer |
| 2026-06 | openpi at 12.5K GitHub stars; commit velocity slowing (6 commits since April) |

### Acquisitions — What Each Brought

No acquisitions to date. PI has grown organically through talent acquisition from Google DeepMind (Hausman, Vuong, Ichter, Springenberg, Driess), Stanford (Finn), UC Berkeley (Levine), and Anduril (Esmail).

### Key Team

| Name | Role | Background |
| --- | --- | --- |
| **Karol Hausman** | CEO | Ex-Google DeepMind, Stanford adj. prof. Key contributor to RT-2, SayCan. 36,900+ citations |
| **Sergey Levine** | Chief Scientist | UC Berkeley professor. Pioneer in deep RL for robotics. Co-author of SAC |
| **Chelsea Finn** | Research Lead | Stanford professor. Created MAML (meta-learning). Pioneer in sim-to-real |
| **Brian Ichter** | VP Engineering | Ex-Google Research. Optimal control, language-conditioned planning |
| **Lachy Groom** | COO | Ex-Stripe (early employee). Angel investor. Handles fundraising, partnerships, GTM |
| **Adnan Esmail** | Co-Founder | Ex-SVP Engineering at Anduril; ex-Tesla Hardware Technologies. MIT |
| **Quan Vuong** | Co-Founder | Ex-Google DeepMind. RL and cross-embodiment learning |
| **Tobi Springenberg** | Research | Ex-Google DeepMind, co-author of RoboCat. 33,800+ citations |
| **Danny Driess** | Research | Lead author of PaLM-E. Ex-Google DeepMind. 17,600+ citations |

Headcount: ~80 (Jan 2026 TechCrunch) to ~200 (Tracxn/SVRC, mid-2026). 21 open roles across AI Research, ML, Software, Hardware, and Business. All positions on-site in SF; some listings mention Fremont.

---

## 2. Product Architecture Details

### Model Evolution Summary

| Model | Date | Params | VLM Backbone | Action Method | Key Innovation |
| --- | --- | --- | --- | --- | --- |
| π0 | 2024-10 | 3.3B | PaliGemma 3B (SigLIP-So400m + Gemma 2B) | Flow matching, 10 Euler steps | First generalist VLA; Mixture-of-Transformers |
| π0-FAST | 2025-01 | 3B | PaliGemma 3B | Autoregressive (FAST tokenizer) | 5× faster training; DCT compression |
| π0.5 | 2025-04 | 3.3B | PaliGemma 3B | Flow matching + FAST (knowledge insulation) | Stop-gradient prevents VLM catastrophic forgetting |
| π\*0.6 | 2025-11 | ~5B | "Slightly larger backbone" | Flow matching + advantage conditioning | Self-improvement via offline RL (RECAP) |
| π0.7 | 2026-04 | ~4.86B | Gemma 3-4B | Flow matching, 5 Euler steps | Compositional generalization; MEM video memory |

### π0 Architecture (Foundation)

**Mixture-of-Transformers** (inspired by Transfusion): VLM backbone and action expert share a single self-attention computation but have completely separate feedforward networks. Image/language tokens route to VLM FFN; state/action tokens route to action expert FFN. Information flows between the two exclusively through shared attention keys/values.

- **VLM**: SigLIP-So400m ViT (~400M) + Gemma 2B decoder (width 2048, 18 layers, 16,384 MLP dim, 18 heads)
- **Action expert**: Gemma-style transformer with reduced dimensions (width 1024, 4096 MLP dim, 18 layers, ~300M params)
- **Block-wise causal attention**: Block 1 [images+language] bidirectional; Block 2 [proprioception] attends to Block 1; Block 3 [noisy actions] attends to all
- **Action chunk**: H=50 actions at once (1 second at 50Hz). Action dim padded to 18 (two 6-DoF arms + 2 grippers + base + torso)
- **Flow matching**: Linear-Gaussian probability path, shifted beta noise schedule `Beta(1.5, 1.0)`, 10 Euler integration steps

**Critical clarification**: The "50Hz control" is the **replay rate** — the robot executes 25 of 50 predicted actions before requesting new inference. Actual model inference frequency: ~1–2 Hz (~73ms per call on RTX 4090).

**Training data**: 10,000+ hours across 7 proprietary robot configs + 22 OXE robots (~29 embodiment types), 68 tasks. 903M timesteps from PI data (9.1% from open sources: OXE/Bridge v2/DROID). Pre-trained for 700K steps.

### π0-FAST Architecture

FAST (Frequency-space Action Sequence Tokenization) replaces flow matching with autoregressive discrete token prediction:

1. Normalize action chunk → DCT per dimension → scale-and-round quantize (γ=10) → flatten column-first → BPE compress (vocab 1024)

Compression ratios: BridgeV2 1.75×, DROID 3.6×, Table Bussing 5.0×, T-Shirt Folding 13.2× — consistently ~30 tokens per arm regardless of control frequency.

**Why 5× faster**: DCT decorrelates tokens (each carries substantial new information vs. nearly-identical consecutive raw tokens). Shorter sequences reduce quadratic attention cost.

**Trade-off**: π0-FAST does NOT use the action expert. Actions predicted by the full 2B Gemma backbone autoregressively. Inference ~750ms per chunk (~1.3 Hz) vs. ~73ms for flow matching π0 (~10 Hz).

### π0.5 Knowledge Insulation

**The problem**: Flow-matching gradients from the action expert corrupt VLM backbone representations, causing catastrophic forgetting.

**Solution**: Stop-gradient on attention K/V from backbone to action expert: `Q_a(X_a) · sg(K_b(X_b))^T`. The action expert reads backbone representations in the forward pass, but flow-matching MSE loss cannot update backbone weights. Simultaneously, FAST discrete tokens provide a cross-entropy training signal (same loss type as VLM pre-training) that preserves backbone knowledge.

Three co-training objectives in a single forward pass: (1) FAST discrete tokens via cross-entropy (backbone), (2) continuous actions via flow matching (action expert, gradient-stopped), (3) web VLM data for knowledge preservation (backbone). FAST tokens are **discarded at inference**.

Result: 7.5× fewer training steps than π0. Ablation: 96.0% on LIBERO-90 vs. 85.2% (π0) vs. 60.2% (π0-FAST).

### π\*0.6 RECAP

**Core innovation**: Advantage-conditioned offline RL that works with flow matching (which lacks tractable log-likelihoods, ruling out PPO/SAC).

- 670M parameter value function (Gemma 3 backbone, distributional output over 201 bins) predicts expected remaining steps
- All data annotated with binary improvement indicator `I_t` ("Advantage: positive"/"Advantage: negative") as text conditioning
- At inference, set `I_t = True` + classifier-free guidance (β=1.5–2.5)
- Three stages: pre-train with advantage conditioning → SFT on task demos → iterate (deploy, collect rollouts + corrections, retrain from pre-trained checkpoint)

### π0.7 Architecture

- **VLM upgrade**: Gemma 3-4B (replacing PaliGemma). 400M vision encoder + 4B language model
- **MEM video encoder**: Extends ViT without new parameters — every 4th ViT layer adds causal temporal attention across same spatial patch across timesteps. O(Kn² + nK²) factorized space-time attention. Only current-timestep tokens passed to VLA backbone
- **Long-term memory**: Natural language text summarizing semantic events (up to 15 min), generated by high-level policy, compressed by off-the-shelf LLM
- **Proprioception**: Changed from discretized text tokens to continuous linear projection
- **Denoising**: Reduced to 5 Euler steps (from 10)
- **World model**: Separate model initialized from BAGEL 14B MoT, generates visual subgoals asynchronously

**Compositional generalization**: Not a single architectural innovation but emergent from (1) diverse dataset where top 20% most task-diverse data drives disproportionate gains, (2) rich episode metadata conditioning (speed, quality 1–5, mistake boolean), (3) distilled RL specialist experience.

### Inference Performance

| Platform | Backend | Latency | Control Rate |
| --- | --- | --- | --- |
| RTX 4090 (π0) | JAX BF16 | ~73 ms on-board | ~14 Hz (model), 50 Hz (replay) |
| RTX 4090 (π0, remote) | JAX BF16 | ~86 ms | ~12 Hz |
| Jetson AGX Thor (π0.5) | TensorRT FP8+NVFP4 | ~94 ms | ~10.6 Hz |
| Jetson AGX Thor (π0.5) | PyTorch BF16 | ~163 ms | ~6 Hz |
| Jetson AGX Orin (π0) | Community-tested | ~1.2s round-trip | ~2–5 Hz |

**Edge deployment note**: FP16 is NOT supported — Gemma uses BF16 (8-bit exponent); FP16's 5-bit exponent causes overflow in attention layers. Jetson Thor requires manual HuggingFace Transformers patching for ONNX export.

### openpi Architecture (Server/Client)

openpi is **not just model weights** — it provides a WebSocket-based policy server and client SDK:

- **Server**: `src/openpi/serving/websocket_policy_server.py` — listens on port 8000, streams action chunks to robots
- **Client**: `packages/openpi-client/` — standalone pip package for lightweight robot-side integration
- **Protocol**: Custom WebSocket (NOT REST, NOT gRPC)
- **Frameworks**: JAX (primary, supports FSDP, LoRA, mixed precision) + PyTorch (secondary, supports DDP + multi-node via torchrun; lacks FAST, mixed precision, FSDP, LoRA)
- **Data format**: LeRobot (primary), RLDS (for large-scale DROID training)
- **Fine-tuning requirements**: LoRA >22.5 GB VRAM; full fine-tuning >70 GB VRAM

---

## 3. OSS Foundations Analysis

### Summary Table

| Product | Primary OSS Foundation | License | Vendor Value-Add (Proprietary) |
| --- | --- | --- | --- |
| **openpi (code)** | PyTorch, JAX, HuggingFace Transformers | Apache 2.0 | Cross-embodiment training pipeline, fine-tuning recipes, WebSocket serving |
| **openpi (weights)** | PaliGemma 3B (Google) | **Gemma Terms of Use** (not Apache 2.0) | Pre-trained weights on 10K+ hrs robot data |
| **π0-FAST** | FAST tokenizer (DCT-based) | Apache 2.0 (via openpi) | FAST+ universal tokenizer trained on 1M trajectories |
| **π0.5** | PaliGemma + knowledge insulation | Apache 2.0 code / Gemma weights | Open-world generalization methodology |
| **π\*0.6** | Builds on π0 architecture | Not released | RECAP RL pipeline, value function, deployment tooling |
| **π0.7** | Gemma 3-4B + BAGEL 14B | Not released | MEM encoder, compositional generalization, 5B weights |

### Pattern Analysis

PI follows an **"open foundation, closed frontier"** strategy — but the "open" has significant caveats:

1. **Dual licensing**: Code is Apache 2.0, but model weights carry Google's **Gemma Terms of Use** — a permissive-but-not-OSS license with use restrictions and a revocation clause. This is NOT equivalent to Apache 2.0 for the full package.
2. **Commit velocity is declining**: Only 6 commits since April 2026; 1 commit in June 2026. The project may be entering maintenance mode for open models.
3. **Feature PRs from external contributors are ignored**: Contributors with 4–5 substantive open PRs (batched inference, nonblocking WebSocket, LeRobot constraints) have zero merges. CONTRIBUTING.md warns "we may not accept all PRs."
4. **No releases, no tags, no versioning**: Users track `main` branch directly — no stability guarantees.

The strategy mirrors LLM companies (Meta Llama, Mistral), but PI faces a sharper risk: open-weight VLA alternatives (OpenVLA, MolmoAct 2, SmolVLA) are free and improving rapidly. If the gap narrows, PI's "closed frontier" loses its pricing power.

### OpenPI Protocol Adoption (Repo vs Protocol Divergence)

The openpi *repo* is declining (37% health score, ignored PRs), but the OpenPI *wire protocol* is spreading as a de facto standard for VLA model serving — a critical distinction for strategic planning.

**Protocol definition**: There is no formal spec. The protocol is defined implicitly by `packages/openpi-client/src/openpi_client/websocket_client_policy.py`: WebSocket connection → server sends msgpack-encoded `PolicyServerConfig` → client sends msgpack observation dicts (numpy arrays via `{__ndarray__: true, dtype, shape, data}` markers) → server returns msgpack action arrays. No versioning scheme.

**vLLM-Omni adoption** (v0.22.0, June 2026):

- Clean-room reimplementation at `vllm_omni.entrypoints.openpi` (vLLM copyright headers, not PI)
- Serves at `/v1/realtime/robot/openpi` (PI's original serves at `/`)
- Supports both openpi-client numpy markers AND vLLM-native markers for backward compatibility
- Parity validated via `tests/dreamzero/upstream/test_openpi_e2e_source_parity.py` — behavioral equivalence testing against PI's reference server
- PR #2162: DreamZero world model + CFG parallel + OpenPI serving
- PR #3673: Realtime OpenPI robot serving API
- In-flight VLA model ports using OpenPI: GR00T-N1.7, Alpamayo, AgiBot GO-1-Air, LingBot-VA
- Future targets: π0-FAST, SmolVLA

**Governance risk**: PI controls protocol evolution unilaterally. CONTRIBUTING.md: "We can't promise to approve every pull request." No governance body, no steering committee, no standards body involvement (no ROS REP, no Linux Foundation, no CNCF). Any protocol changes by PI could break vLLM-Omni's compatibility. The parity tests mitigate but do not eliminate this — they detect breakage after the fact, not prevent it.

**Competing serving APIs**:

| API | Wire Format | Governance | Adopters |
| --- | --- | --- | --- |
| OpenPI | WebSocket + msgpack-numpy | PI unilateral | vLLM-Omni, DreamZero, AgiBot GO-1-Air |
| LeRobot PolicyServer | gRPC + protobuf | HuggingFace-controlled | SmolVLA, GR00T N1.5 (via LeRobot) |
| Vendor-specific | Various | Vendor-controlled | GR00T native (Isaac), NIM |

[Positronic](https://github.com/Positronic-Robotics/positronic) emerged as a community bridge layer (unified RemotePolicy client across all three), confirming fragmentation is a recognized problem. LeRobot PolicyServer has an unpatched critical RCE (CVE-2026-25874 via pickle deserialization).

**Data format is settled**: LeRobot v2/v3 is the universal standard. OpenPI consumes it, GR00T adopted it (with `modality.json` extension). Not a competitive concern — the serving API is where the fragmentation risk lies.

### Notable Dependencies

- **Gemma 3-4B** (Google): VLM backbone for π0.7. Upgraded from PaliGemma 3B used in earlier models
- **SigLIP-So400m** (Google): Vision encoder for π0 through π0.5
- **BAGEL 14B** (community MoT model): Initializes π0.7's world model for visual subgoal generation
- **LeRobot** (HuggingFace): Primary data format; openpi depends on it via git submodule
- **OXE dataset** (Google-led consortium): 9.1% of π0 pre-training data. Shared resource — competitors also use it
- **WEKA filesystem**: High-performance storage for training (replaced OCI native, cut storage costs 80%)
- **Anyscale / Ray**: Distributed data processing pipeline

---

## 4. Governance & Community Risk

### openpi Governance

| Dimension | Assessment |
| --- | --- |
| **Governing body** | Single-vendor (Physical Intelligence) |
| **Core maintainer employment** | All maintainers are PI employees. 3 CODEOWNERS (kvablack, jimmyt857, Michael-Equi) control all merges |
| **CLA/DCO** | No CLA required |
| **Commit diversity** | 30 contributors total; ~18 external. External PR merge rate: **~7–8%** (20–25 of 303 merged PRs). All external merges are bug fixes, typos, and docs — zero architectural contributions |
| **Community health score** | **37%** (GitHub). No code of conduct, no issue templates, no repo description |
| **Issue backlog** | 231 open vs 255 closed. Many user support questions go unanswered |
| **Abandonment risk** | **Medium-High** — commit velocity slowing, frontier models not open-sourced, community feature PRs ignored |

### Risk Assessment

The open-source trajectory is deteriorating. Evidence:

1. Issue #789 (open-source π\*0.6): open since Nov 2025, **no PI response**
2. Issue #980 (Jun 2026, "Will new models be open-sourced?"): **no PI response**
3. Commit velocity: 6 commits since April 2026, down from 20+/month in early 2025
4. External feature PRs systematically ignored (taivu1998: 5 PRs, 0 merged; 0xadvait: 4 PRs, 0 merged)
5. Gemma Terms of Use on weights include a revocation clause — Google could theoretically restrict derivative model distribution

**For Red Hat**: The openpi repo is not becoming ecosystem infrastructure — but the OpenPI wire protocol is, via vLLM-Omni's clean-room reimplementation. Red Hat's strategic position: (1) integrate with open models today (π0, π0-FAST, π0.5) before the window closes; (2) invest in vLLM-Omni's OpenPI endpoint as the robotics serving standard; (3) monitor protocol governance — if PI does not formalize the spec, vLLM-Omni may need to own the protocol definition independently.

---

## 5. Training Infrastructure

### Confirmed Infrastructure

| Component | Provider | Details |
| --- | --- | --- |
| **GPU compute** | Oracle Cloud Infrastructure (OCI) | Multi-GPU NVIDIA clusters; specific count not disclosed |
| **Storage** | WEKA | High-performance filesystem; replaced OCI native storage (10–15% training delays → negligible). 80% cost reduction |
| **Data processing** | Anyscale (managed Ray) | Processes terabytes of multimodal robot data; used from day one |
| **Training framework** | JAX FSDP | Not DeepSpeed, not Megatron-LM. Single-node multi-GPU via `fsdp_devices` |
| **Checkpoints** | Google Cloud Storage | `gs://openpi-assets/` for model hosting |
| **Experiment tracking** | Weights & Biases | `wandb>=0.19.1` dependency |

**Software requirements**: Python ≥3.11, JAX 0.5.3 [cuda12], PyTorch 2.7.1, HuggingFace Transformers 4.53.2 (requires manual patching), numpy <2.0.

**Compute comparison**: GR00T N1.5 trained on **1,000 H100 GPUs** with batch size 16,384 for 250K steps. PI has not disclosed comparable numbers. Co-founder Groom: "There's no limit to how much money we can really put to work... There's always more compute you can throw at the problem."

### Deployment Hardware

| Platform | Config | Use Case |
| --- | --- | --- |
| ALOHA (Trossen) | Dual-arm bimanual | Dexterous manipulation, primary research platform |
| UR5e | Single/dual-arm industrial | Laundry folding (cross-embodiment transfer demo in π0.7) |
| Franka / DROID | Single-arm research | Benchmark tasks (LIBERO, DROID) |
| Mobile manipulator (Fibocom) | Base + arm | Mobile manipulation, home environments |
| Bimanual Trossen | Dual-arm | Fine manipulation |
| Off-the-shelf arms | ~$3,500 each (Levine says <$1K if manufactured in-house) | Partner deployment hardware |

---

## 6. Partnership & Ecosystem Details

### Deployment Partners

| Partner | Founded | Funding | Team | Use Case | PI Models | Status |
| --- | --- | --- | --- | --- | --- | --- |
| **Weave Robotics** | 2024 (YC S24) | ~$500K | ~15 | Laundry folding (Isaac 0 robot; $7,999 or $450/mo) | π0 → π0.5 → π0.6 | Commercial deployment in SF Bay Area; ships to new customers weekly |
| **Ultra** | 2024 (YC S24) | ~$3.75M | 8–21 | Warehouse packaging (OP1 robot; $2,500–3,000/mo) | π0 → π0.5 → π0.6 | Revenue-generating fleet across US; 96.4% autonomy over full shift |
| **Dandelion Chocolate** | — | — | — | Chocolate box assembly | π\*0.6 | Test site across the street from PI HQ; not a paying customer |

**Performance metrics context**: The "42% fewer missed grasps, 50% fewer interventions" figures compare π0.6 **with vs. without Weave pre-training data** (+WPT vs. -WPT), not π0.5 vs. π0.6. Ultra's "96.4% autonomy" is from a single demonstrated shift (PI blog, Feb 2026), not a fleet-wide SLA. Remaining 3.6% involves remote human teleoperators.

**Unnamed verticals**: Logistics and grocery mentioned in TechCrunch (Jan 2026) but no companies named. Co-founder Vuong declines to name them.

**Revenue status**: PI is **pre-revenue** ($0 confirmed per Getlatka). Groom explicitly says "I don't give investors answers on commercialization." First commercial product "could arrive as early as this year or as late as 2028."

### Developer Ecosystem

| Metric | Value |
| --- | --- |
| **openpi stars** | 12,484 |
| **openpi forks** | 2,103 |
| **Contributors** | 30 (12 PI employees, 18 external) |
| **External merge rate** | ~7–8% (all bug fixes/docs) |
| **NVIDIA relationship** | NVentures investor ($600M Series B). PI deployed models at Foxconn on NVIDIA Blackwell lines |
| **HuggingFace** | openpi uses LeRobot data format; models hosted on HuggingFace Hub |
| **Trossen Robotics** | Integrated AI arms with openpi for VLA training/inference (community, not commercial PI) |
| **NVIDIA Jetson AI Lab** | Official π0.5 deployment tutorial for Jetson Thor with TensorRT optimization |
| **Third-party reimpl** | lucidrains/pi-zero-pytorch (~stars). Community re-implementations exist but are not endorsed |

---

## 7. Detailed Competitive Analysis

### vs NVIDIA GR00T (Architecture-Level)

| Dimension | Physical Intelligence (π0 → π0.7) | NVIDIA GR00T (N1 → N1.7) |
| --- | --- | --- |
| **Total params** | 3.3B → 5B | 2.2B → ~3B |
| **VLM backbone** | PaliGemma 3B → Gemma 3-4B | Eagle-2 1.34B → Cosmos-Reason2-2B (Qwen3-VL arch) |
| **VLM-action coupling** | MoE: shared attention, separate FFN | Cross-attention (Flamingo-style), VLM frozen (top 4 layers unfrozen in N1.6+) |
| **Flow matching noise** | Beta(1.5, 1), s=0.999 | **Identical** — GR00T paper explicitly cites π0 |
| **Denoising steps** | 10 → 5 (π0.7) | 4 |
| **Action chunk** | H=50 (1s at 50Hz) | H=16 (133ms at 120Hz) |
| **Re-plan cadence** | Every ~500ms (execute 25 of 50) | Every ~133ms |
| **Target embodiment** | Multi-robot (arms, bimanual, mobile) | Humanoid-focused (expanding to industrial) |
| **Training data** | 10K+ hrs real robot (9.1% open) | Synthetic-heavy (Isaac Lab, MimicGen) + 20K hrs ego-video |
| **VLM feature layer** | Final layer | Middle layer (12th) — faster + better downstream |
| **Training scale** | Not disclosed | 1,000 H100 GPUs, batch 16,384 |

**GR00T's flow matching directly influenced by π0**: The noise schedule and action encoder timestep conditioning in GR00T N1 are cited from the π0 paper.

**Key architectural difference**: π0's MoE design enables end-to-end gradient flow through the VLM (but risks catastrophic forgetting → knowledge insulation). GR00T's cross-attention with frozen VLM preserves pre-trained knowledge and allows swapping VLM backbones independently.

### vs Skild AI (Most Direct Competitor)

| Dimension | Physical Intelligence | Skild AI |
| --- | --- | --- |
| **Founded** | 2024 | 2023 |
| **Funding** | ~$1.1B raised ($5.6B valuation) | ~$1.7B raised ($14B valuation) |
| **Revenue** | Pre-revenue ($0 confirmed) | **~$30M** (confirmed at Series C) |
| **Approach** | Real-robot data + VLM fine-tuning | Simulation-heavy (learning from videos + physics sims) |
| **Open source** | openpi (Apache 2.0 code, Gemma ToU weights) | Fully proprietary |
| **Adaptability** | Fine-tuning on 1–20 hrs data | Zero-shot adaptation to body damage, new embodiments |
| **Named customers** | Weave, Ultra | Deployments in security, logistics, manufacturing |
| **Investors** | Bezos, OpenAI, Thrive, CapitalG, NVentures | SoftBank, NVentures, Bezos, LG, Schneider, Foxconn |
| **Key differentiator** | Flow matching for continuous actions; open weights; academic pedigree | Commercialization speed; $30M revenue; simulation-first approach |

**Note**: Both are NVentures portfolio companies. NVIDIA is hedging its bets on the VLA layer.

### vs Open-Weight Alternatives

| Project | Institution | Params | Threat Level |
| --- | --- | --- | --- |
| **OpenVLA** | Stanford/UC Berkeley | 7B | High — free, competitive on many tasks |
| **MolmoAct 2** | Allen AI (Ai2) | — | High — claims 87.1% vs. π0.5's 45.2% on Franka tasks |
| **RDT-1B** | Open community | 1B | Medium — diffusion-based, competitive |
| **SmolVLA** | HuggingFace (LeRobot) | Small | Medium — growing ecosystem |

**Central strategic risk** (flagged by SVRC): "If open models reach 90% of π0's performance, the willingness to pay for a proprietary model may be limited." Unlike OpenAI, which had years before open-weight LLM competitors emerged, PI faces immediate open-weight competition.

---

## Sources

- [π0 paper (arXiv 2410.24164)](https://arxiv.org/abs/2410.24164)
- [π0-FAST paper (arXiv 2501.09747)](https://arxiv.org/abs/2501.09747)
- [Knowledge insulation research](https://www.pi.website/research/knowledge_insulation)
- [π0.5 paper (arXiv 2504.16054)](https://arxiv.org/abs/2504.16054)
- [π\*0.6 RECAP paper (arXiv 2511.14759)](https://arxiv.org/abs/2511.14759)
- [MEM paper (arXiv 2603.03596)](https://arxiv.org/abs/2603.03596)
- [π0.7 paper (arXiv 2604.15483)](https://arxiv.org/abs/2604.15483)
- [openpi GitHub](https://github.com/Physical-Intelligence/openpi)
- [PI Partner Blog (Feb 2026)](https://www.pi.website/blog/partner)
- [TechCrunch: Inside Physical Intelligence (Jan 2026)](https://techcrunch.com/2026/01/30/physical-intelligence-stripe-veteran-lachy-grooms-latest-bet-is-building-silicon-valleys-buzziest-robot-brains/)
- [Bloomberg: PI $5.6B valuation (Nov 2025)](https://www.bloomberg.com/news/articles/2025-11-20/robotics-startup-physical-intelligence-valued-at-5-6-billion-in-new-funding)
- [Bloomberg: PI in talks for $11B (Mar 2026)](https://www.bloomberg.com/news/articles/2026-03-27/ex-deepmind-staffers-robotics-startup-in-talks-for-11-billion-valuation)
- [Jetson AI Lab: π0.5 on Thor](https://www.jetson-ai-lab.com/tutorials/openpi_on_thor/)
- [WEKA case study (PI storage)](https://www.weka.io/customers/physical-intelligence/)
- [Anyscale case study (PI compute)](https://www.anyscale.com/resources/case-study/physical-intelligence)
- [GR00T N1 paper (arXiv 2503.14734)](https://arxiv.org/abs/2503.14734)
- [SVRC: Physical Intelligence profile](https://www.roboticscenter.ai/companies/physical-intelligence)
- [Grishin Robotics: PI overview](https://www.grishinrobotics.com/post/physical-intelligence-company-overview)
- [Skild AI Series C (Jan 2026)](https://news.crunchbase.com/venture/robotics-startup-skild-ai-triples-valuation/)
- [Sequoia: Hausman + Springenberg podcast](https://sequoiacap.com/podcast/training-general-robots-for-any-task-physical-intelligences-karol-hausman-and-tobi-springenberg/)
- [vLLM-Omni v0.22.0 release](https://github.com/vllm-project/vllm-omni/releases)
- [vLLM-Omni World Model Support RFC (Issue #1987)](https://github.com/vllm-project/vllm-omni/issues/1987)
- [vLLM-Omni π0/π0.5 VLA model support (Issue #4136)](https://github.com/vllm-project/vllm-omni/issues/4136)
- [Positronic — unified VLA serving bridge](https://github.com/Positronic-Robotics/positronic)
- [CVE-2026-25874: LeRobot PolicyServer RCE](https://chocapikk.com/posts/2026/lerobot-pickle-rce/)
