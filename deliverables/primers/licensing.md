# Gemma Terms of Use: Licensing Risk for Physical AI Model Weights

## Why This Matters

The most prominent open-weight robotics policy today — Physical Intelligence's π0 family — uses Google's PaliGemma 3B as its vision-language backbone. The π0 weights are released under the **Gemma Terms of Use** (ToU), not Apache 2.0. This distinction has concrete consequences for anyone building products, platforms, or open-source projects on top of these models.

This primer explains what the Gemma ToU requires, how it differs from Apache 2.0, where it creates friction for Red Hat and the broader OSS ecosystem, and which models in the Physical AI stack are affected.

## Gemma Terms of Use at a Glance

The Gemma ToU ([ai.google.dev/gemma/terms](https://ai.google.dev/gemma/terms)) governs Google's Gemma model family (Gemma 1–3, PaliGemma, ShieldGemma, CodeGemma, and variants). **Gemma 4 moved to Apache 2.0** — only earlier generations remain under the ToU.

| Provision | Apache 2.0 | Gemma ToU |
| --- | --- | --- |
| **Revocability** | Irrevocable, perpetual | Google may terminate unilaterally on breach (§4.5) |
| **Remote enforcement** | None | Google reserves right to restrict usage remotely (§4.5) |
| **Use restrictions** | None — any purpose | Prohibited Use Policy incorporated by reference (§3.2) |
| **Redistribution** | Standard attribution | Must pass through ToU as enforceable provision to all downstream users (§3.1) |
| **Derivative scope** | Standard copyright derivative works | Includes distillation, synthetic-data training, weight transfer (§1.1(e)) |
| **OSI-approved** | Yes | No |
| **Compatibility with Linux distro policies** | Yes | No (Fedora, Debian, RHEL) |

### The Revocation Clause

The most significant difference. Apache 2.0 §2 grants rights that are *"perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable."* Once granted, the licensor cannot take them back.

Under Gemma ToU §4.5, Google can terminate the agreement if it determines you are in breach of *any* term. Upon termination, you must *"delete and cease use and Distribution of all copies of Gemma and Model Derivatives."* Google also reserves the right to *"restrict (remotely or otherwise) usage"* it believes violates the terms.

For a factory running fine-tuned π0 policies on physical robots, this means continued operation depends on ongoing Google licensing goodwill. A good-faith dispute about compliance could — legally — require shutting down the deployed system.

### The Prohibited Use Policy

The Gemma Prohibited Use Policy ([ai.google.dev/gemma/prohibited_use_policy](https://ai.google.dev/gemma/prohibited_use_policy)) is incorporated by reference into the ToU (§3.2). Violations trigger the termination clause.

Prohibited categories:

| Category | Prohibitions |
| --- | --- |
| **Illegal activities** | CSAM, illegal substances/goods, facilitating crime, violent extremism |
| **Unlicensed professional practice** | Legal, medical, accounting, or other regulated services without proper licensure |
| **Service abuse** | Spam, fraud, phishing, malware generation |
| **Safety circumvention** | Overriding safety filters, driving model to act contrary to policy |
| **Harm to individuals** | Hate speech, harassment, violence promotion, self-harm, PII exposure, surveillance without consent |
| **Misinformation** | False provenance claims, impersonation, misleading expertise, automated decisions in rights-affecting domains |
| **Sexually explicit content** | Pornography/sexual gratification (exception: scientific, educational, documentary, artistic) |
| **IP violations** | Generating content that infringes or misappropriates rights |

Most of these are unobjectionable — they parallel responsible-use norms across the industry. The risk is not the prohibitions themselves but the **enforcement mechanism**: any alleged violation triggers the revocation clause, and Google is the sole arbiter.

The "automated decisions in domains that affect material or individual rights or well-being" prohibition is particularly broad. A robotics policy making real-time grasping decisions in a warehouse could arguably fall under this, depending on interpretation.

### Viral Pass-Through and Derivative Scope

Two provisions compound the revocation risk:

**Pass-through obligation (§3.1)**: Anyone redistributing Gemma or Model Derivatives must include the use restrictions as an *"enforceable provision"* in downstream agreements and provide all recipients a copy of the full ToU. Additional terms you add *"must not conflict"* with Google's. This makes it structurally incompatible with permissive open-source distribution — you cannot ship Gemma-derived weights under MIT, BSD, or Apache 2.0 alone.

**Broad derivative definition (§1.1(e))**: "Model Derivatives" includes not just direct modifications but any model created by *"transfer of patterns of the weights, parameters, operations, or Output"* — explicitly covering **distillation** and **training on synthetic data generated by the model**. If you fine-tune π0 on your robot data, distill it into a smaller model, or generate synthetic demonstrations from π0 to train a different architecture, the result is a Model Derivative subject to all ToU provisions including revocation.

## Which Models Are Affected

### Gemma ToU (restricted)

| Model | Gemma Component | Affected By |
| --- | --- | --- |
| **PaliGemma / PaliGemma 2** | Native Gemma model | Gemma ToU directly |
| **Gemma 1, 2, 3, 3n** | Native Gemma models | Gemma ToU directly |
| **π0 / π0-FAST / π0.5 / π0.7** | PaliGemma 3B VLM backbone | Gemma ToU via derivative |
| **openpi weights** | π0 family weights | Gemma ToU via derivative |
| **ShieldGemma, CodeGemma** | Native Gemma variants | Gemma ToU directly |

### Apache 2.0 (clean)

| Model/Software | License | Notes |
| --- | --- | --- |
| **Gemma 4** | Apache 2.0 | Google moved Gemma 4 to Apache 2.0 in 2025 |
| **openpi code** (server, client, fine-tuning framework) | Apache 2.0 | Software is clean; weights are not |
| **vLLM / vLLM-Omni** | Apache 2.0 | Serving infrastructure; does not bundle weights |
| **LeRobot** | Apache 2.0 | Framework code is clean |

### Key distinction: software vs. weights

The serving infrastructure (vLLM, vLLM-Omni, openpi server) is Apache 2.0 and shippable. The Gemma ToU applies to whoever **distributes or deploys the weights**, not to the inference engine. A Red Hat customer using vLLM-Omni to serve π0 weights would need to independently accept the Gemma ToU for those weights.

## vLLM-Omni and Gemma Exposure

vLLM already supports serving Gemma 1/2/3/3n/4 and PaliGemma models in production. vLLM-Omni's [RFC #1987](https://github.com/vllm-project/vllm-omni/issues/1987) targets π0 at P2 priority for VLA serving support.

**Red Hat's exposure is indirect, not direct:**

| Layer | License | Red Hat ships? | Risk |
| --- | --- | --- | --- |
| **vLLM / vLLM-Omni** (engine) | Apache 2.0 | Yes (RHOAI) | None — engine is license-clean |
| **Gemma 4 weights** | Apache 2.0 | Could distribute | None |
| **Gemma 3 / PaliGemma weights** | Gemma ToU | No | Customer's responsibility |
| **π0 weights** | Gemma ToU | No | Customer's responsibility |
| **Fine-tuned π0 derivatives** | Gemma ToU (viral) | No | Customer's responsibility, but must be flagged in documentation |

The risk is not that Red Hat violates the ToU — it is that customers deploy Gemma-derived weights through Red Hat's serving infrastructure without understanding they are accepting Google's revocable terms. Platform documentation and model registry metadata should surface this distinction.

## Practical Impact

### For open-source projects

- **Cannot redistribute** Gemma-derived weights under a permissive OSS license — must contractually bind downstream users to Google's ToU
- **Incompatible with Fedora/Debian/RHEL packaging policies** which require OSI-approved licenses
- **Model hubs** (HuggingFace, etc.) can host the weights, but each downloader must accept the ToU individually

### For commercial products

- **Fine-tuned derivatives** remain under Gemma ToU — the viral scope covers the full model, not just the Gemma component
- **Distilled or synthetic-data-trained models** are also Model Derivatives — there is no "clean room" escape via knowledge distillation
- **Defense, weapons, and sanctioned-jurisdiction use** may violate the Prohibited Use Policy, triggering revocation
- **Automated decision-making** in rights-affecting domains is prohibited — robotics in safety-critical settings could be argued to fall under this

### For Red Hat specifically

- **RHEL AI / RHOAI**: Cannot ship Gemma ToU weights. Can ship the serving engine (vLLM, vLLM-Omni) and Gemma 4 weights (Apache 2.0)
- **Model registry**: Should tag model license metadata to surface Gemma ToU vs. Apache 2.0 distinction to operators
- **Customer guidance**: Customers fine-tuning π0 on their data must understand the derivative remains under Gemma ToU
- **Alternative models**: Prefer Apache 2.0 / MIT-licensed VLA alternatives where available (SmolVLA, OpenVLA, GR00T N1.5 weights under NVIDIA's terms)

## What to Watch

1. **Will PI rebase on Gemma 4?** Gemma 4 is Apache 2.0. If PI's next model generation uses Gemma 4 instead of PaliGemma 3B, the entire licensing picture changes. This is the single most impactful signal to monitor.

2. **Gemma ToU enforcement precedent**: No known termination actions to date. A first enforcement action — or a clarifying FAQ from Google — would materially change risk assessments.

3. **Alternative VLA backbones**: Models using Llama (Meta Community License), Qwen (Apache 2.0), or fully custom backbones avoid Google's terms entirely. The VLA landscape is evolving fast enough that Gemma dependency may become optional.

4. **vLLM-Omni model support matrix**: As vLLM-Omni adds VLA serving support, its documentation should indicate per-model license requirements. This is a community contribution opportunity.
