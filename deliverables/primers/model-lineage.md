# Model Lineage: VLMs, VLAs, and World Models

How vision-language models, vision-language-action models, and world models relate to each other — what builds on what, which components are shared, and how the field's architecture has evolved from 2022 to mid-2026.

## Table of Contents

- [Architectural Paradigms](#architectural-paradigms)
- [Vision-Language Models (VLM Backbones)](#vision-language-models-vlm-backbones)
- [Vision-Language-Action Models (VLAs)](#vision-language-action-models-vlas)
- [World Models](#world-models)
- [Action Generation Methods](#action-generation-methods)
- [Family Trees](#family-trees)

---

## Architectural Paradigms

Three dominant VLA design patterns have emerged:

| Paradigm | How it works | Examples | Trade-off |
| ---------- | ------------- | ---------- | ----------- |
| **Monolithic VLA** | VLM directly outputs action tokens alongside language tokens | RT-2, OpenVLA, Gemini Robotics | Simple; but slow inference and lossy action discretization |
| **Dual-system VLA** | VLM (System 2) handles perception/reasoning; separate action expert (System 1) generates motor commands | pi0, GR00T N1, CogACT, SmolVLA | Fast high-freq control; VLM can run at lower freq |
| **Non-VLM policy** | Custom transformer or diffusion architecture; no pre-trained VLM | Octo, HPT, RDT-1B | Smaller and faster; less semantic understanding |

Dual-system fusion mechanisms vary:

- **MoE-like shared attention** — pi0: VLM and action expert share self-attention layers
- **Cross-attention** — GR00T N1: DiT attends to VLM embeddings via cross-attention
- **VLM output conditioning** — CogACT, HiRT: action head is conditioned on VLM latent features

---

## Vision-Language Models (VLM Backbones)

These are the vision-language models that serve as foundational components within VLAs.

### Vision Encoders Used Across the Ecosystem

| Encoder | Type | Used By |
| --------- | ------ | --------- |
| **SigLIP** / **SigLIP-2** | Sigmoid-loss contrastive ViT | PaLI-Gemma, Prismatic/OpenVLA, Eagle 2, Qwen3-VL, SmolVLM2, RDT-1B, GR00T N1 |
| **CLIP ViT** / **EVA-CLIP** | Contrastive ViT (OpenAI / EVA variant) | LLaVA, CogVLM, CogVLM2 |
| **DINOv2** | Self-supervised ViT (spatial reasoning) | Prismatic/OpenVLA (paired with SigLIP), CogACT |
| **ViT-22B** | Google's scaled ViT | PaLM-E, PaLI-X |
| **ConvNeXt** | CNN backbone | Eagle 2 (9B+ variants, alongside SigLIP) |
| **NFNet-F6** | Normalizer-Free ResNet | Flamingo |

### VLM Reference Table

| VLM | Vision Encoder | LLM Backbone | Params | Key Notes |
| ----- | --------------- | ------------- | -------- | ----------- |
| **PaLM-E** (Google, 2023) | ViT-4B / ViT-22B | PaLM 540B | up to 562B | Injects continuous sensor data into LLM embedding space |
| **PaLI-X** (Google, 2023) | ViT-22B | UL2 32B (enc-dec) | ~55B | Multi-image; OCR-tuned ViT |
| **PaLI-Gemma** (Google, 2024) | SigLIP-So400m | Gemma-2B (decoder) | ~3B | Linear projector; prefix-LM masking; successor to PaLI-3 |
| **PaLI-Gemma 2** (Google, 2024) | SigLIP-So400m | Gemma 2 (2B/9B/27B) | 3–28B | Multiple size variants |
| **Prismatic-7B** (Stanford, 2024) | SigLIP-So400m + DINOv2 (fused) | Llama 2 7B | ~7B | Dual vision encoder; 2-layer MLP projector |
| **Flamingo** (DeepMind, 2022) | NFNet-F6 | Chinchilla 70B | ~80B | Perceiver Resampler + gated cross-attention; frozen vision+LLM |
| **OpenFlamingo** (open-source) | OpenCLIP ViT | Pythia / MPT / LLaMA | various | Open-source Flamingo recreation |
| **LLaVA** (2023) | CLIP ViT-L/14 | Vicuna 7B/13B | 7–13B | MLP projector; 2-stage training |
| **InternVL 2/2.5** (OpenGVLab) | InternViT-300M | InternLM2.5 / Qwen2.5 | 1–78B | Dynamic resolution tiling; pixel shuffle |
| **Qwen-VL** (Alibaba, 2023) | OpenCLIP ViT-bigG | Qwen-7B | ~7B | Cross-attention VL-Adapter |
| **Qwen2-VL** (2024) | Custom ViT (native dynamic res) | Qwen2 | 3–72B | M-RoPE; 3D convolutions for video |
| **Qwen2.5-VL** (2024) | Redesigned ViT (window attn) | Qwen2.5 | 3–72B | MLP merger; up to 4K resolution |
| **Qwen3-VL** (2025) | SigLIP2-SO-400M (7B+) | Qwen3 | 2–72B | DeepStack multi-level ViT features |
| **CogVLM** (Tsinghua, 2023) | EVA-CLIP ViT | LLaMA 2 | ~17B | Visual expert module (separate QKV+MLP per layer) |
| **CogVLM2** (2024) | EVA-CLIP ViT (2×2 downsample) | LLaMA 3-8B | ~10B | Updated LLM backbone |
| **Eagle 2** (NVIDIA) | SigLIP + ConvNeXt (9B+); SigLIP (1–2B) | Qwen2.5-Instruct | 1–34B | MoVE (mixture of vision encoders); pixel shuffle |
| **Eagle 2** (GR00T variant) | SigLIP-2 | SmolLM2-1.7B | ~2B | Lightweight variant for robotics |
| **Eagle 2.5** (NVIDIA, 2025) | SigLIP (improved) | SmolLM2 variant | ~2B | Improved grounding; used frozen in GR00T N1.5 |
| **Cosmos-Reason2-2B** (NVIDIA, 2026) | Qwen3-VL ViT | Qwen3-VL-2B-Instruct | 2B | Post-trained for physical reasoning; replaces Eagle in GR00T N1.7 |
| **SmolVLM2** (HuggingFace) | SigLIP | SmolLM2 | <0.5B | Optimized for multi-image/video; used in SmolVLA |

---

## Vision-Language-Action Models (VLAs)

| VLA | VLM Backbone | Vision Encoder | LLM | Action Head | Params | Key Relationship |
| ----- | ------------- | --------------- | ----- | ------------ | -------- | ----------------- |
| **RT-1** (Google, 2022) | — (custom) | EfficientNet-B3 (FiLM) | — (19M Transformer) | Autoregressive discrete tokens | 35M | Foundation of RT family |
| **RT-2-PaLI-X** (Google, 2023) | PaLI-X | ViT-22B | UL2 32B | Autoregressive action tokens | 55B | Fine-tuned PaLI-X; coined "VLA" |
| **RT-2-PaLM-E** (Google, 2023) | PaLM-E | ViT-4B | PaLM 12B | Autoregressive action tokens | 12B | Fine-tuned PaLM-E variant |
| **RT-2-X** (Google, 2023) | PaLI-X | ViT-22B | UL2 32B | Autoregressive action tokens | 55B | RT-2 + Open X-Embodiment data (22 embodiments) |
| **Octo** (Berkeley, 2024) | — (custom) | Lightweight CNN patch encoder | T5-Base (lang only) | Diffusion action head | 27–93M | Not VLM-based; custom transformer policy |
| **OpenVLA** (Stanford, 2024) | Prismatic-7B | SigLIP + DINOv2 | Llama 2 7B | Autoregressive discrete tokens | 7B | Fine-tuned Prismatic; outperforms RT-2-X at 7× fewer params |
| **OpenVLA-OFT** (Stanford, 2025) | Prismatic-7B | SigLIP + DINOv2 | Llama 2 7B | Parallel MLP (continuous L1) | 7B | OpenVLA + parallel decoding; 26× speedup (109 Hz) |
| **pi0** (Phys. Intelligence, 2024) | PaLI-Gemma | SigLIP-So400m | Gemma-2B | Flow matching (~300M action expert) | ~3.3B | VLM + action expert share attention (Transfusion) |
| **pi0.5** (Phys. Intelligence, 2025) | PaLI-Gemma | SigLIP-So400m | Gemma-2B | FAST tokenizer + flow matching | ~3.3B | Hierarchical: subtask text → low-level actions |
| **GR00T N1** (NVIDIA, Mar 2025) | Eagle 2 (SmolLM variant) | SigLIP-2 | SmolLM2-1.7B | DiT flow matching (cross-attn) | 2.2B | Dual-system: Eagle VLM + DiT |
| **GR00T N1.5** (NVIDIA, Jun 2025) | Eagle 2.5 (frozen) | SigLIP (improved) | SmolLM2 | DiT flow matching | ~2B | Frozen VLM; 38% vs 13% N1 success rate |
| **GR00T N1.7** (NVIDIA, 2026) | Cosmos-Reason2-2B | Qwen3-VL ViT | Qwen3-VL-2B | DiT flow matching (Action Cascade) | 3B | Replaced Eagle with Cosmos-Reason2; EgoScale pre-training |
| **Gemini Robotics** (Google, 2025) | Gemini 2.0 | Internal ViT | Gemini 2.0 LLM | Learned action tokens (monolithic) | undisclosed | Single model: think-then-act; 2× prior VLAs |
| **CogACT** (Microsoft, 2024) | Prismatic-7B | SigLIP + DINOv2 | LLaMA 7B | DiT (up to 300M) | 7B+ | VLM cognition + DiT action; +35% over OpenVLA |
| **HPT** (MIT/Meta, 2024) | — (custom stems) | Flexible (via attention tokenizer) | — (shared trunk) | Task-specific heads | 1B+ | Embodiment-agnostic trunk; 50+ datasets |
| **RDT-1B** (Tsinghua, 2024) | — (not VLM-based) | SigLIP-So400m | — (DiT backbone) | Diffusion Transformer | 1.2B | Pure diffusion policy; 64-step action chunks |
| **SpatialVLA** (Shanghai AI Lab, 2025) | PaLI-Gemma 2 | SigLIP | Gemma 2 | Autoregressive (adaptive grids) | ~4B | Ego3D position encoding; 1.1M real episodes |
| **3D-VLA** (UMass, 2024) | 3D-LLM (BLIP-2 based) | Multi-view encoder | FlanT5 | Diffusion (image + point) | — | Generates future 3D goal states |
| **HiRT** (Tsinghua, 2024) | InstructBLIP 7B | ViT (InstructBLIP) | Vicuna-7B | Lightweight policy on VLM latents | 7B | Hierarchical: VLM low-freq, action high-freq |
| **DeeR-VLA** (2024) | OpenFlamingo 3B/9B | ViT + Perceiver Resampler | Pythia | LSTM + MLP | 3–9B | Dynamic early-exit: 5–6× compute reduction |
| **TinyVLA** (2024) | Custom (LLaVA-style) | Small ViT variants | Pythia 70M–1.4B | Diffusion policy | 70M–1.4B | Frozen + LoRA; +25.7% over OpenVLA at 5.5× fewer params |
| **RoboMM** (Meituan, 2024) | OpenFlamingo-based | Multi-view ViT + 3D adapter | OpenFlamingo LLM | MLP + CNN + occupancy decoder | — | Modality-Isolation-Mask for fusion |
| **SmolVLA** (HuggingFace, 2025) | SmolVLM2 | SigLIP | SmolLM2 | Flow-matching (~100M action expert) | <0.5B | Discards final VLM layers; LeRobot community data |

---

## World Models

| Model | Architecture | Components | Action Conditioning | Generation | Params |
| ------- | ------------- | ----------- | -------------------- | -----------: | -------- |
| **Cosmos** (NVIDIA, 2024–25) | Transformer (AR + diffusion) | 3D RoPE, text cross-attn | Text, camera controls | AR tokens or diffusion | Nano/Super/Ultra |
| **Cosmos 3** (NVIDIA, Jun 2026) | Two-tower MoT | Reasoner (AR, from Qwen3-VL) + Generator (diffusion) | Text, video, audio, action | Dual: AR reasoning + diffusion gen | 16B / 64B |
| **GAIA-1** (Wayve, 2023) | AR transformer | VQ-VAE image tokenizer, T5-large text, 3D U-Net decoder | Video + text + driving actions | Next-token prediction | 9B |
| **GAIA-2** (Wayve, 2024) | Improved AR | — | Driving actions | — | — |
| **GAIA-3** (Wayve, Dec 2025) | — | Shifted focus to evaluation | — | — | 15B |
| **Genie** (DeepMind, Feb 2024) | Transformer | MagViT2 tokenizer + LAM + MaskGIT dynamics | Latent actions (unsupervised) | Masked token prediction | 11B |
| **Genie 2** (DeepMind, Dec 2024) | AR transformer + diffusion | Video autoencoder + AR transformer + diffusion sampler | Keyboard/mouse actions | AR + diffusion frame-by-frame | undisclosed |
| **UniSim** (Google, 2023) | Video U-Net | Temporal+spatial attn U-Net; T5 text embeddings | Text instructions + motor + camera | Video diffusion | 5.6B |
| **DreamerV3** (Hafner, 2023) | RSSM | GRU + encoder + dynamics + decoder + reward predictor | Agent actions (continuous/discrete) | Latent imagination | scalable |
| **TD-MPC2** (Hansen, 2024) | Implicit (MLP) | Encoder + latent dynamics + reward + Q + policy | Continuous actions | Latent trajectory optimization | 1M–317M |
| **DIAMOND** (2024) | Diffusion | Frame-stacking + adaptive group norm | Discrete actions (Atari) | Diffusion denoising | 4.4M–381M |
| **GameNGen** (Google, 2024) | Modified SD v1.4 | U-Net (Stable Diffusion) | Player inputs | Diffusion next-frame | ~1B |
| **Oasis** (Decart/Etched, 2024) | ViT autoencoder + DiT | Spatial autoencoder + DiT backbone | Keyboard/mouse | AR frame gen via Diffusion Forcing | 500M |
| **DreamZero** (NVIDIA, 2026) | World Action Model | 14B params; planned backbone for GR00T N2 | Actions | — | 14B |

### JEPA Family (Meta FAIR)

Latent-space predictive models — predict in representation space rather than pixel space:

```text
I-JEPA (images) → MC-JEPA (multimodal contrastive)
                 → V-JEPA (video) → V-JEPA 2 → V-JEPA 2.1 (improved dense features)
                                              → VLA-JEPA (V-JEPA2 encoder + Qwen3-VL-2B)
                                              → ThinkJEPA (V-JEPA 2 predictor + Qwen3-VL Thinking)
                                              → Demo-JEPA
```

### Dreamer Family

```text
PlaNet (RSSM foundation) → Dreamer → DreamerV2 (discrete latents) → DreamerV3 (categorical, multi-domain)
```

---

## Action Generation Methods

| Method | Models | Characteristics |
| -------- | -------- | ----------------- |
| **Autoregressive discrete tokens** | RT-1, RT-2, OpenVLA, SpatialVLA | Actions discretized into bins, predicted as language tokens; simple but lossy |
| **Flow matching** | pi0, pi0.5, GR00T N1/N1.5/N1.7, SmolVLA | Continuous; maps noise → action; fast (single or few passes) |
| **Diffusion (denoising)** | Octo, CogACT, RDT-1B, TinyVLA, 3D-VLA | Iterative denoising; expressive multimodal distributions; slower |
| **Parallel continuous regression** | OpenVLA-OFT | MLP head with L1 loss; bidirectional attention; fastest (109 Hz) |
| **Learned action tokens (monolithic)** | Gemini Robotics | Single model: reasoning chain then actions |
| **Latent imagination** | DreamerV3, TD-MPC2 | Actions optimized in latent space; no pixel generation |
| **Video diffusion** | UniSim, GameNGen, DIAMOND | Predicts next video frames; actions conditioned |
| **AR video tokens** | GAIA-1, Genie, Oasis | Predicts next video tokens; interactive environments |

---

## Family Trees

### Google / DeepMind

```text
ViT + PaLM ──→ PaLM-E (2023) ──→ RT-2-PaLM-E (2023)
ViT-22B + UL2 ──→ PaLI-X (2023) ──→ RT-2-PaLI-X (2023) ──→ RT-2-X (+ OXE data)
EfficientNet + Transformer ──→ RT-1 (2022)
Gemini 2.0 ──→ Gemini Robotics (2025)
MagViT2 + Transformer ──→ Genie (2024) ──→ Genie 2 (2024)
```

### Physical Intelligence (pi)

```text
SigLIP + Gemma-2B ──→ PaLI-Gemma (2024)
PaLI-Gemma + flow-matching Action Expert ──→ pi0 (2024)
pi0 + FAST tokenizer + hierarchical planning ──→ pi0.5 (2025)
```

### Stanford / Prismatic

```text
SigLIP + DINOv2 + Llama 2 ──→ Prismatic-7B (2024)
Prismatic-7B + robot fine-tuning (OXE) ──→ OpenVLA (2024)
OpenVLA + parallel decoding + continuous ──→ OpenVLA-OFT (2025)
Prismatic-7B + DiT action head ──→ CogACT (Microsoft, 2024)
```

### NVIDIA GR00T

```text
SigLIP-2 + SmolLM2 ──→ Eagle 2 (GR00T variant)
Eagle 2 + DiT flow matching ──→ GR00T N1 (Mar 2025)
Eagle 2.5 (frozen) + DiT ──→ GR00T N1.5 (Jun 2025)
Cosmos-Reason2-2B (= post-trained Qwen3-VL) + DiT ──→ GR00T N1.7 (2026)
DreamZero (14B World Action Model) ──→ GR00T N2 (planned end 2026)
```

### NVIDIA Cosmos

```text
Transformer (AR + diffusion) ──→ Cosmos (2024–25)
Qwen3-VL + physical reasoning post-training ──→ Cosmos-Reason2 (2026)
Qwen3-VL (dual-tower MoT init) ──→ Cosmos 3 (Jun 2026)
```

### Alibaba Qwen-VL

```text
OpenCLIP ViT-bigG + Qwen-7B ──→ Qwen-VL (2023)
Custom ViT + Qwen2 ──→ Qwen2-VL (2024)
Redesigned ViT + Qwen2.5 ──→ Qwen2.5-VL (2024)
SigLIP2 + Qwen3 ──→ Qwen3-VL (2025)
     ├──→ Cosmos-Reason2 (NVIDIA post-training, 2026)
     ├──→ Cosmos 3 (NVIDIA dual-tower init, 2026)
     └──→ VLA-JEPA (backbone, 2026)
```

### Flamingo Derivatives

```text
NFNet-F6 + Chinchilla ──→ Flamingo (DeepMind, 2022)
OpenCLIP + Pythia/MPT/LLaMA ──→ OpenFlamingo (open-source)
OpenFlamingo ──→ DeeR-VLA (dynamic early-exit, 2024)
OpenFlamingo ──→ RoboMM (3D perception, 2024)
```

### Wayve GAIA

```text
VQ-VAE + T5 + AR transformer ──→ GAIA-1 (2023) ──→ GAIA-2 (2024) ──→ GAIA-3 (Dec 2025, 15B)
```

---

## How VLM Backbones Are Used: Frozen vs Fine-tuned vs Modified

A critical design axis: does the VLA freeze its VLM backbone, fine-tune it, or structurally modify it? The answer shapes what the model can learn, how expensive it is to train, and how well it generalizes.

### Training Strategy Summary

| Model | Vision Encoder | LLM Backbone | Action Head | Key Strategy |
| ----- | -------------- | ------------ | ----------- | ------------ |
| **GR00T N1** | Fine-tuned | Frozen | DiT (trained from scratch) | Mid-layer (12th) LLM features used, not final layer |
| **GR00T N1.5** | Frozen | Frozen | DiT (trained) | Entire VLM frozen — key change from N1 |
| **GR00T N1.7** | Frozen | Frozen | DiT (trained) | Swapped Eagle for Cosmos-Reason2 but same freeze pattern as N1.5 |
| **pi0** | Fine-tuned | Fine-tuned | 300M action expert (flow matching, from scratch) | MoE-like shared attention; full VLM fine-tuning |
| **pi0.5** | Fine-tuned | Fine-tuned (insulated) | 300M action expert (flow matching) | AdaRMS blocks action-expert gradients from reaching VLM |
| **OpenVLA** | Fine-tuned | Fine-tuned | LLM itself (discrete tokens) | Full end-to-end; freezing vision encoder "significantly worse" |
| **OpenVLA-OFT** | LoRA | LoRA | Parallel continuous MLP | LoRA fine-tuning; changed output head to continuous regression |
| **CogACT** | Fine-tuned | Fine-tuned | DiT (up to 300M, jointly trained) | Single-stage joint training; full FT > LoRA |
| **SmolVLA** | Frozen | Frozen (top half discarded) | 100M expert (flow matching) | Keeps only first 16 of 32 LLM layers; outperforms using natively smaller VLM |
| **SpatialVLA** | Fine-tuned | Fine-tuned (text embeds frozen) | Adaptive action grid tokens | Freezes text token embeddings to preserve world knowledge |
| **VLA-JEPA** | Fine-tuned | Fine-tuned | Action head from special tokens | V-JEPA2 frozen as target encoder; Qwen3-VL fully trained |

### Detailed Notes

**GR00T N1 → N1.5 → N1.7: Progressive freezing.** N1 fine-tuned the vision encoder while freezing the LLM. N1.5 froze the entire VLM (both vision encoder and LLM), which improved language following and generalization. N1.7 kept the same full-freeze pattern but swapped Eagle for Cosmos-Reason2-2B, which arrives pre-specialized for physical reasoning via SFT+RL on Qwen3-VL — so the VLM is already adapted before being frozen into the VLA.

**pi0 → pi0.5: Knowledge insulation.** pi0 fine-tunes the full PaLI-Gemma VLM jointly with the action expert. pi0.5 introduces AdaRMS (Adaptive RMSNorm) which modulates layer normalization based on diffusion timestep — this lets the action expert train without destructive gradient flow back into the VLM. During RL fine-tuning, the VLM is fully frozen and only the 300M action expert is updated.

**OpenVLA: Freezing hurts.** The OpenVLA paper explicitly tested freezing the vision encoder and found it "significantly worse" for robotic control. Full end-to-end fine-tuning was essential. However, LoRA (rank=32, 1.4% of parameters) nearly matched full fine-tuning performance.

**SmolVLA: Layer truncation.** Rather than using a smaller VLM, SmolVLA takes SmolVLM2 and permanently discards the top half of LLM layers (keeping 16 of 32). This outperformed both a natively smaller VLM and skip-every-other-layer strategies. The rationale: intermediate layers often provide better representations for downstream tasks than final layers — consistent with GR00T N1 extracting mid-layer features.

**VLA-JEPA: Dual-encoder asymmetry.** Qwen3-VL-2B is fully fine-tuned but V-JEPA2 is frozen with stop-gradient. V-JEPA2 serves only as a supervision target — it encodes future video frames into latent states that the Qwen3-VL backbone learns to predict. At inference, the world model is dropped entirely; only the Qwen backbone + action head remain.

**SpatialVLA: Selective freezing.** Fine-tunes vision encoder and LLM weights but freezes text token embeddings specifically to preserve instruction-following ability and general world knowledge from pre-training.

### How Cosmos-Reason2-2B Was Derived from Qwen3-VL

Cosmos-Reason2-2B is architecturally identical to Qwen3-VL-2B-Instruct — no layers added or removed. NVIDIA applied SFT + reinforcement learning on physical AI reasoning datasets (EgoExo4D, PerceptionTest, Language Table, IntPhys, CLEVRER, VideoPhy2, Hyperism, EgoExOR, plus NVIDIA AV/Metropolis data). This added spatial-temporal reasoning, physics understanding, 2D/3D point localization, and bounding box detection with reasoning traces. Pure weight-level specialization.

### How Cosmos 3 Uses Qwen3-VL

Cosmos 3 goes beyond weight initialization — it is an architectural modification. Both the Reasoner tower (autoregressive) and Generator tower (diffusion) are initialized from Qwen3-VL weights, roughly doubling parameters (Nano 16B from 2× Qwen3-VL-8B; Super 64B from 2× Qwen3-VL-32B). The Generator tower adds diffusion-based generation; information flows one-way from Reasoner → Generator. Shared 3D multimodal RoPE across both towers. The ViT encoder for understanding is jointly trained with the backbone; audio/video VAEs for generation are frozen. Exception: Cosmos3-Edge (~4B) is trained from scratch.

### Emerging Patterns

1. **Trend toward freezing VLMs** — Earlier models (OpenVLA, pi0, CogACT) fine-tuned everything. Later models (GR00T N1.5+, SmolVLA) freeze the VLM and train only the action head. The rationale: preserve VLM generalization, reduce training cost, enable modular upgrades.

2. **Pre-specialization before freezing** — When freezing a VLM backbone, it helps to pre-specialize it first. Cosmos-Reason2-2B is post-trained on physical reasoning before being frozen into GR00T N1.7. This is more effective than freezing a general-purpose VLM.

3. **Intermediate layers > final layers** — Multiple models (GR00T N1 mid-layer extraction, SmolVLA layer truncation) find that intermediate representations outperform final-layer outputs for action generation.

4. **Gradient isolation techniques** — pi0.5's AdaRMS and VLA-JEPA's stop-gradient on V-JEPA2 both solve the same problem: preventing the action learning signal from corrupting pre-trained representations. This is subtler than binary freeze/unfreeze.

---

*Last updated: 2026-06-09*
