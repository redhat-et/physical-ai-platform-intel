# Robot Policy Serving: LeRobot, OpenPI, and the Emerging Protocol Landscape

## Why This Matters

Robot foundation models are following the same trajectory as LLMs: large models trained on broad data, served over a network, consumed by diverse clients. But unlike LLMs — where OpenAI's Chat Completions API became the de facto standard and projects like vLLM could build compatible serving infrastructure — robotics has no agreed-upon serving protocol. Two competing approaches have emerged: Physical Intelligence's **OpenPI** (WebSocket + msgpack) and HuggingFace's **LeRobot PolicyServer** (gRPC + protobuf). A third category — vendor-specific APIs like NVIDIA's Triton/NIM — adds further fragmentation.

This primer explains what each protocol does, how they differ, where they overlap, and what the fragmentation means for anyone building a robotics platform. It also covers the data format layer (LeRobotDataset), the bridge projects attempting to unify the landscape, and the security considerations that complicate adoption.

## The Problem: Serving Robot Policies Is Not Serving LLMs

LLM serving is stateless request-response: send a prompt, get tokens back. Robot policy serving has fundamentally different requirements:

| Dimension | LLM Serving | Robot Policy Serving |
| --- | --- | --- |
| **I/O modality** | Text in, text out | Images + proprioception in, action trajectories out |
| **Latency budget** | Seconds acceptable | 10-100ms required (real-time control loops) |
| **Session state** | Stateless (or context window) | Stateful (robot state evolves between calls) |
| **Output format** | Token sequence | Action chunk: `(horizon, action_dim)` tensor |
| **Client diversity** | Homogeneous (HTTP clients) | Heterogeneous (different robots, sensors, actuators) |
| **Failure mode** | Retry safely | Physical damage if stale actions execute |

A robot policy server receives multi-modal observations (camera images, joint positions, force/torque readings, language instructions), runs inference through a Vision-Language-Action (VLA) model or simpler policy, and returns an **action chunk** — a short trajectory of future actions the robot executes open-loop while the next inference runs. The ratio of environment step time to inference time (the "critical ratio") determines whether the system can maintain continuous, smooth control or degenerates into stop-and-wait behavior.

## OpenPI: Physical Intelligence's Serving Protocol

### What It Is

OpenPI is Physical Intelligence's open-source release of their π0 model family. The "protocol" is not a formal specification — it is the wire format implied by the `openpi-client` Python package and the `serve_policy.py` server script. There is no versioned API spec, no OpenAPI/AsyncAPI document, and no governance body. The protocol is whatever the current code does.

### Architecture

```text
┌──────────────────┐         WebSocket + msgpack         ┌──────────────────┐
│   Robot Client   │ ◄─────────────────────────────────► │  OpenPI Server   │
│                  │                                     │                  │
│  openpi-client   │    Observation dict ──────────►     │  serve_policy.py │
│  (Python pkg)    │    ◄────────── Action chunk         │  (JAX or PyTorch)│
│                  │                                     │                  │
│  Image resize    │                                     │  Normalization   │
│  State capture   │                                     │  Flow matching   │
│  Action execute  │                                     │  Action decode   │
└──────────────────┘                                     └──────────────────┘
```

### Wire Format

- **Transport**: WebSocket (default port 8000)
- **Serialization**: msgpack with numpy array support (`msgpack-numpy`)
- **Request**: Python dict serialized via msgpack, containing:
  - `observation/image` — uint8 array, resized to 224×224 with padding
  - `observation/wrist_image` — uint8 array (optional, per-robot)
  - `observation/state` — unnormalized proprioceptive state (joint positions, etc.)
  - `prompt` — natural language task instruction string
- **Response**: Dict with `actions` key containing `(action_horizon, action_dim)` numpy array — typically `(10, 7)` for a 7-DoF arm with 10-step horizon

### Model Family

| Model | Architecture | Key Innovation | Release |
| --- | --- | --- | --- |
| **π0** | PaliGemma 3B + flow-matching action expert | First flow-based VLA; 50Hz action generation | 2024-10 |
| **π0-FAST** | PaliGemma 3B + FAST tokenizer | DCT-based action tokenization: 30-60 tokens per chunk (10x compression); 5x faster training | 2025-01 |
| **π0.5** | Same + knowledge insulation | Cross-embodiment: works on unseen robots without fine-tuning | 2025-04 |
| **π0.7** | Same + steerable conditioning | Compositional generalization via multimodal prompts (language + subgoal images + task metadata) | 2026-04 |

All models are pre-trained on 10,000+ hours of robot data across 7 platforms and 68 tasks. Fine-tuning requires 1-20 hours of task-specific data. The architecture uses a Mixture-of-Transformers (MoT) design: PaliGemma handles vision-language understanding while a separate action expert generates motor commands via flow matching (continuous denoising) or FAST tokenization (discrete).

### Deployment

The native stack runs on **JAX**. A **PyTorch port** exists via LeRobot (HuggingFace maintains it), enabling the same model weights to run in PyTorch ecosystems. Server deployment:

```bash
uv run scripts/serve_policy.py --env=DROID  # or ALOHA, LIBERO
```

Fine-tuning uses LoRA by default, requiring a single GPU and 1-20 hours of demonstration data collected in LeRobot dataset format.

### Licensing

This is the critical nuance: **OpenPI code is Apache 2.0, but model weights are under Google's Gemma Terms of Use** (because π0 uses PaliGemma 3B as its backbone). The Gemma ToU is not OSI-approved, includes a unilateral revocation clause, and requires viral pass-through to all downstream users. See the [Model Weight Licensing primer](licensing.md) for the full analysis. Gemma 4 moved to Apache 2.0, but PaliGemma (used by π0) remains under the ToU.

### Adopters

- **vLLM-Omni**: Clean-room reimplementation of the OpenPI WebSocket protocol at `/v1/realtime/robot/openpi` (PRs #2162, #3673). Ships in v0.22.0 (June 2026). This is the most significant adoption signal — it means the OpenPI wire format is becoming the "Chat Completions API of robotics" via the dominant serving framework.
- **AgiBot GO-1-Air**: OpenPI-compatible serving for AgiBot's humanoid.
- **DreamZero**: NVIDIA's World Action Model targets OpenPI compatibility.
- **Trossen Robotics**: Documentation for OpenPI deployment on Trossen arms.

## LeRobot: HuggingFace's Robotics Framework

### Overview

LeRobot is a comprehensive robotics framework — not just a serving protocol. It covers the full pipeline: data collection, dataset management, training, evaluation, and deployment. The **PolicyServer/RobotClient** is its serving layer, but LeRobot's significance extends far beyond that to the dataset format and model ecosystem.

### PolicyServer/RobotClient Architecture

```text
┌──────────────────┐            gRPC (HTTP/2)            ┌──────────────────┐
│   RobotClient    │ ◄─────────────────────────────────► │  PolicyServer    │
│                  │                                     │                  │
│  On-robot process│  Observation stream ──────────►     │  GPU server      │
│  Action queue    │  ◄────────── Action chunks          │  Any policy      │
│  Async execution │                                     │  Batched infer   │
│                  │                                     │                  │
│  Cameras + state │                                     │  ACT / Diffusion │
│  Threshold check │                                     │  SmolVLA / π0    │
│  Chunk aggregate │                                     │  GR00T N1.5      │
└──────────────────┘                                     └──────────────────┘
```

### gRPC Wire Format

- **Transport**: gRPC (HTTP/2, bidirectional streaming)
- **Serialization**: Protocol Buffers (proto3) with `bytes` payload fields
- **Service definition**:

```protobuf
service AsyncInference {
  rpc SendObservations(stream Observation) returns (Empty);
  rpc GetActions(Empty) returns (Actions);
  rpc SendPolicyInstructions(PolicySetup) returns (Empty);
  rpc Ready(Empty) returns (Empty);
}

message PolicySetup { bytes data = 1; }
message Observation { TransferState transfer_state = 1; bytes data = 2; }
message Actions { bytes data = 1; }
```

- **Observation streaming**: Uses gRPC streaming (not unary RPC) because multi-camera captures at high resolution exceed gRPC's 4MB default message size
- **Payload serialization**: Currently uses Python `pickle` inside the `bytes` fields — the source of CVE-2026-25874 (see Security section)

### Async Inference Mechanism

The key innovation is **decoupling action prediction from execution**. The RobotClient maintains an action queue and uses a configurable threshold (`chunk_size_threshold`, default 0.5-0.7) to decide when to request new predictions:

- **threshold = 0**: Sequential mode — wait until queue is empty, then request (stop-and-wait)
- **threshold = 0.7**: Send new observation when 70% of current chunk remains — next chunk arrives before current one is exhausted
- **threshold = 1.0**: Send every timestep (maximum compute, minimal lag)

When new chunks arrive while old actions remain, an **aggregation function** blends overlapping predictions (weighted average or replace). Action reception and execution run in separate threads — the robot never blocks waiting for inference.

**Performance**: ~2× task completion speedup vs. sequential inference. Sub-100ms round-trip latency on local network with SmolVLA on RTX 4090.

### Supported Policies

LeRobot supports 40+ policies across categories:

| Category | Policies |
| --- | --- |
| **Imitation learning** | ACT, Diffusion Policy, VQ-BeT |
| **VLAs** | π0, π0-FAST, π0.5, GR00T N1.5, SmolVLA, XVLA, MolmoAct2 |
| **RL** | HIL-SERL, TDMPC |
| **World models** | VLA-JEPA |
| **Reward models** | SARM, TOPReward, Robometer |

All policies implement a unified `PreTrainedPolicy` interface: `policy = SmolVLAPolicy.from_pretrained("lerobot/smolvla_base")`.

### Hardware Support

LeRobot supports robots from $100 hobby arms to production humanoids:

- **Low-cost arms**: SO-100, SO-101, Koch v1.1
- **Research platforms**: ALOHA (bimanual), UR5
- **Humanoids**: Unitree G1
- **Other**: Reachy2, OpenARM, LeKiwi, EarthRover

The `Robot` class provides a hardware-agnostic interface — the same `get_observation()` / `send_action()` API works across all platforms.

### SmolVLA: The Community VLA

SmolVLA (450M parameters) is HuggingFace's own VLA, notable for two reasons:

1. **Trained on community data**: 487 datasets from LeRobot Hub contributors (~10M frames, <30K episodes) — 10× less data than comparable VLAs
2. **Runs on consumer hardware**: CPU, MacBook, or Jetson Orin NX (~2GB memory vs. π0's ~14GB)

SmolVLA achieves 78.3% success rate on SO-100 real-world tasks (vs. ACT baseline of 64.2%) and matches π0.5 on LIBERO simulation benchmarks. It demonstrates that community-contributed open-source data can produce competitive VLA models.

### Community Scale (June 2026)

- 25,200 GitHub stars (3× growth from April 2025)
- 4,900 forks, 1,508 commits
- 39 pretrained models, 181 datasets on HuggingFace Hub
- ICLR 2026 paper
- Described as "the largest open-source robotics community in 2026"

## Protocol Comparison

### Transport and Serialization

| Dimension | OpenPI | LeRobot PolicyServer |
| --- | --- | --- |
| **Transport** | WebSocket | gRPC (HTTP/2) |
| **Serialization** | msgpack-numpy | Protocol Buffers + pickle payload |
| **Streaming** | Full-duplex WebSocket | gRPC bidirectional streaming |
| **Message size** | No inherent limit | 4MB default (uses streaming to work around) |
| **Language support** | Python only (msgpack-numpy) | Any gRPC language (but pickle payload limits to Python) |
| **TLS** | Not implemented | Not implemented (insecure port) |
| **Authentication** | None | None |
| **Formal spec** | None | Proto3 file (but payload is opaque `bytes`) |

### Observation Format

| Field | OpenPI | LeRobot |
| --- | --- | --- |
| **Images** | `observation/image`, `observation/wrist_image` — uint8, 224×224 | Camera frames in pickled dict — variable resolution |
| **State** | `observation/state` — unnormalized array | Joint positions/velocities in pickled dict |
| **Language** | `prompt` — string field | Part of `PolicySetup` config |
| **Normalization** | Server-side | Server-side |
| **Image preprocessing** | Client resizes to 224×224 with padding | Client sends raw, server preprocesses |

### Action Format

| Dimension | OpenPI | LeRobot |
| --- | --- | --- |
| **Shape** | `(action_horizon, action_dim)` — e.g., `(10, 7)` | `(actions_per_chunk, action_dim)` — e.g., `(50, N)` |
| **Encoding** | numpy array via msgpack | Pickled tensor |
| **Chunk overlap** | Client manages open-loop execution | Client manages with configurable aggregation |
| **Typical horizon** | 10 steps | 50 steps (configurable) |

### Ecosystem Comparison

| Dimension | OpenPI | LeRobot |
| --- | --- | --- |
| **Scope** | Model serving only | Full pipeline (data → train → eval → deploy) |
| **Owner** | Physical Intelligence (startup) | HuggingFace (AI platform company) |
| **Governance** | Single-vendor, no community process | HuggingFace-controlled, broader contributor base |
| **Dataset format** | Consumes LeRobot format | Defines LeRobot format (v2/v3) |
| **Model hub** | Weights on HuggingFace Hub | Native Hub integration |
| **Hardware support** | ALOHA, DROID, custom | SO-100/101, Koch, ALOHA, UR5, Unitree G1, more |
| **Simulation** | LIBERO | LIBERO, Meta-World, Isaac Lab-Arena, MuJoCo |
| **Code license** | Apache 2.0 | Apache 2.0 |
| **Weight license** | Gemma ToU (restrictive) | Apache 2.0 (SmolVLA); Gemma ToU (π0 via port) |
| **GitHub stars** | ~12K | ~25K |
| **vLLM-Omni adoption** | Yes (clean-room reimpl) | Targeted for compatibility |
| **Critical CVE** | None known | CVE-2026-25874 (CVSS 9.8, unpatched) |

### When to Use Which

- **OpenPI** if: you are deploying π0 models specifically, want the lightest-weight serving layer, or need vLLM-Omni compatibility for production inference infrastructure
- **LeRobot** if: you need the full pipeline (data collection through deployment), want the broadest model and hardware coverage, or are building on community-contributed data and models
- **Both** in practice: many teams use LeRobot for data collection and training, then serve via OpenPI protocol (either natively or through vLLM-Omni) for production inference

## The Data Format Layer: LeRobotDataset

While the serving protocols are fragmented, the **data format has converged**. LeRobotDataset v2/v3 is the de facto standard for robot demonstration data. OpenPI consumes it, NVIDIA GR00T adopted it (with a `modality.json` extension), and most VLA training pipelines expect it.

### LeRobotDataset v3 Structure

```text
dataset/
├── meta/
│   ├── info.json              # Schema: features, shapes, dtypes, FPS
│   ├── stats.json             # Normalization stats (mean/std/min/max)
│   ├── tasks.jsonl            # Task descriptions → integer IDs
│   └── episodes/
│       └── chunk-0000.parquet # Episode lengths, task IDs, byte offsets
├── data/
│   └── file-0000.parquet      # State + action time series (multiple episodes)
└── videos/
    └── front/
        └── file-0000.mp4      # Camera frames (multiple episodes)
```

**Design principles**:

- **Parquet for scalars** (joint states, actions, timestamps): columnar format with fast random access and efficient compression
- **MP4 for video** (camera frames): order-of-magnitude better compression than per-frame images, organized by camera
- **Metadata in Parquet** (v3): episode boundaries resolved via relational lookup, not filenames — scales to millions of episodes

**v3 vs. v2**: The key change is packing multiple episodes per file. v2 used one Parquet file and one MP4 per episode, which hit filesystem limits at scale. v3 shards episodes across fewer, larger files with relational metadata for episode-level access.

**Hub integration**: Datasets are hosted on HuggingFace Hub (181 datasets as of June 2026). Load with `LeRobotDataset("lerobot/aloha_mobile_cabinet")` or stream without downloading via `StreamingLeRobotDataset`.

### Data Format Landscape

| Format | Owner | Used By | Notes |
| --- | --- | --- | --- |
| **LeRobotDataset v3** | HuggingFace | LeRobot, OpenPI, GR00T, most VLAs | De facto standard |
| **RLDS** | Google | RT-X, Octo | TensorFlow-native; used in Open X-Embodiment |
| **GR00T format** | NVIDIA | GR00T N1/N2 | LeRobot v2 + `modality.json` extension |
| **Custom** | Various | Research prototypes | Per-lab formats, often converted to LeRobot |

## Bridge Projects and Convergence

### Positronic: The Unified Client

[Positronic](https://github.com/Positronic-Robotics/positronic) is a community project that directly addresses protocol fragmentation. It provides:

- **Unified RemotePolicy client**: Single WebSocket-based protocol (v1) that works interchangeably with LeRobot, OpenPI, and GR00T servers
- **Dataset codecs**: Lazy transforms that convert raw data into LeRobot, GR00T, or OpenPI format without re-recording
- **Hardware drivers**: Pure Python, no ROS dependency

Positronic is in alpha (APIs may change), but its existence confirms the ecosystem recognizes fragmentation as a problem worth solving. Their [PhAIL benchmark](https://positronic.ro/introducing-phail) (March 2026) tested OpenPI, GR00T, SmolVLA, and ACT on real hardware — none reached production-grade reliability.

### vLLM-Omni: OpenPI as the Serving Standard

vLLM-Omni's adoption of the OpenPI wire format is the strongest convergence signal. As of v0.22.0 (June 2026):

- Clean-room reimplementation of the OpenPI WebSocket protocol (not a wrapper — independent code)
- Endpoint: `/v1/realtime/robot/openpi`
- Reuses vLLM-Omni's scheduler, batching, parallelism, and metrics infrastructure
- Targets π0/π0.5 VLA models as first-class citizens (Issue #4136)
- Extension point for future VLA models (SmolVLA, GR00T, LingBot-VA)

This means OpenPI's wire format — even without a formal spec — is becoming the default robotics serving interface via the dominant model serving framework. vLLM-Omni's parity tests (`test_openpi_e2e_source_parity.py`) attempt to maintain compatibility, but they are reverse-engineering a moving target, not implementing against a stable contract.

### Robot Context Protocol (RCP)

An academic proposal ([arXiv 2506.11650](https://arxiv.org/abs/2506.11650)) from the RoboStack Research Group defines an HTTP/WebSocket/SSE transport with JSON schema for `read`, `write`, `execute`, and `subscribe` operations over robot resource paths. Alibaba's [RynnRCP](https://github.com/alibaba-damo-academy/RynnRCP) is an enterprise implementation. RCP is not a ratified standard and has no formal governance body, but it represents the first attempt at a transport-agnostic robot API specification — worth monitoring as a potential convergence point.

### ROS 2 Integration

Neither OpenPI nor LeRobot PolicyServer ships official ROS 2 packages. However, several community bridges exist for LeRobot:

- **[rosetta](https://discourse.openrobotics.org/t/announcing-rosetta-a-ros-2-lerobot-bridge/50657)** — Official ROS 2 ⇄ LeRobot bridge with `EpisodeRecorderServer` (action-driven rosbag2 recording)
- **[lerobot-ros](https://github.com/ycheng517/lerobot-ros)** — Lightweight wrapper for ros2_control/MoveIt arms on ROS 2 Jazzy
- **[so101_ros2_bridge](https://so101-ros2.readthedocs.io/)** — Connects LeRobot APIs to ROS 2 topics/services, includes policy nodes for VLA models

OpenPI has no equivalent bridges — integration requires wrapping the `openpi-client` in custom ROS 2 nodes. This asymmetry favors LeRobot for ROS 2-based production deployments.

## Security Considerations

### CVE-2026-25874: LeRobot PolicyServer RCE

**Severity**: CVSS 9.8 (Critical). **Status**: Unpatched as of June 2026.

The LeRobot PolicyServer uses Python's `pickle.loads()` to deserialize observation data received over gRPC. Pickle deserialization executes arbitrary code — an attacker can send a crafted observation that runs system commands on the server. The gRPC channel uses `add_insecure_port()` with no TLS and no authentication.

**Impact**: Any network-accessible PolicyServer can be compromised with a 61-byte payload. No credentials required.

**Root cause**: The protobuf messages use opaque `bytes` fields for flexibility, then deserialize with pickle. The actual data (camera frames, joint states) could use safe formats — safetensors for tensors, JSON for metadata — but the current implementation chose pickle for convenience.

**Timeline**: Reported privately ~December 2025, acknowledged January 2026, no fix shipped. PR #3048 proposes safetensors + JSON replacement.

**Mitigation**: Restrict PolicyServer to localhost or trusted networks. Never bind to `0.0.0.0` without network isolation.

### OpenPI Security Posture

OpenPI's WebSocket server has no authentication or TLS either, but uses msgpack (not pickle) for serialization. Msgpack deserializes data, not code — it cannot execute arbitrary payloads. This makes OpenPI's wire format **inherently safer** than LeRobot's current pickle-based approach, though the lack of authentication and encryption remains a concern for production deployment.

### Implications for Platform Builders

Any production robotics serving layer must add:

1. **TLS/mTLS** for transport encryption
2. **Authentication** (API keys, tokens, or certificates)
3. **Safe serialization** (safetensors, msgpack, protobuf native types — never pickle)
4. **Input validation** (image dimensions, state vector shapes, value ranges)
5. **Rate limiting** (prevent observation flooding)

vLLM-Omni's clean-room reimplementation of OpenPI sidesteps the pickle vulnerability entirely (it uses its own serialization), which is one reason it may become the preferred serving path.

## The Convergence Picture

```text
                    ┌─────────────────────────────────────────────────┐
                    │              DATA FORMAT (converged)            │
                    │         LeRobotDataset v2/v3 (de facto)         │
                    │    Parquet (states/actions) + MP4 (video)       │
                    └─────────────────────────────────────────────────┘
                                           │
                    ┌─────────────────────────────────────────────────┐
                    │           TRAINING FRAMEWORKS                   │
                    │   LeRobot (broad)  ·  OpenPI (π0-specific)      │
                    │   NVIDIA NeMo  ·  Custom (research labs)        │
                    └─────────────────────────────────────────────────┘
                                           │
         ┌─────────────────┬───────────────┼──────────────┬──────────┐
         │                 │               │              │          │
    ┌────▼──────┐   ┌──────▼──────┐  ┌─────▼──────┐ ┌─────▼────┐     │
    │  OpenPI   │   │  LeRobot    │  │  vLLM-Omni │ │ NVIDIA   │     │
    │  Server   │   │ PolicySrvr  │  │  (OpenPI   │ │ NIM/     │     │
    │           │   │             │  │  compat)   │ │ Triton   │     │
    │ WebSocket │   │    gRPC     │  │  WebSocket │ │ REST     │     │
    │ +msgpack  │   │  +protobuf  │  │  +msgpack  │ │ +custom  │     │
    └────┬──────┘   └──────┬──────┘  └─────┬──────┘ └──────┬───┘     │
         │                 │               │               │         │
         └─────────────────┴──────┬────────┴───────────────┘         │
                                  │                                  │
                    ┌─────────────▼────────────────┐                 │
                    │     Positronic (bridge)      │◄────────────────┘
                    │  Unified RemotePolicy client │
                    └─────────────▬────────────────┘
                                  │
                    ┌─────────────▼────────────────┐
                    │         Robot Hardware       │
                    │  SO-100 · ALOHA · UR5 · G1   │
                    └──────────────────────────────┘
```

**What has converged**: Data format (LeRobotDataset), model distribution (HuggingFace Hub), training framework (PyTorch everywhere).

**What remains fragmented**: Serving protocol (three incompatible wire formats), authentication/security (none implemented), ROS 2 integration (DIY).

**Where it is heading**: vLLM-Omni's adoption of OpenPI's wire format suggests it will become the dominant serving protocol — not because Physical Intelligence governs it well (they don't), but because vLLM-Omni's infrastructure (batching, parallelism, metrics, GPU management) is what production deployments need, and they chose OpenPI as the robotics API shape. LeRobot's PolicyServer may evolve toward OpenPI compatibility or remain the preferred option for research and development workflows where the full LeRobot pipeline is in use.

## Key Risks

| Risk | Impact | Mitigation |
| --- | --- | --- |
| **No formal OpenPI spec** | vLLM-Omni reverse-engineers compatibility; PI can break it at any time | Monitor for spec publication; vLLM-Omni parity tests provide early warning |
| **π0 weight licensing** | Gemma ToU restricts redistribution and allows revocation | Use SmolVLA (Apache 2.0) or wait for models built on Gemma 4+ (Apache 2.0) |
| **CVE-2026-25874** | Any exposed LeRobot PolicyServer is trivially compromisable | Network isolation; prefer vLLM-Omni for production serving |
| **Single-vendor governance** | Both protocols controlled by their respective companies | Positronic as hedge; push for open governance or foundation stewardship |
| **No ROS 2 integration** | Gap between AI serving and robot middleware | Application-level bridging; opportunity for platform contribution |

## Glossary

| Term | Definition |
| --- | --- |
| **VLA** | Vision-Language-Action model — takes images + language, outputs robot actions |
| **Action chunk** | Sequence of future actions predicted at once; robot executes open-loop while next chunk computes |
| **Action horizon** | Number of timesteps in an action chunk (e.g., 10 steps at 50Hz = 200ms of planned motion) |
| **Flow matching** | Generative modeling technique (continuous denoising) used by π0 to produce smooth action trajectories |
| **FAST tokenizer** | Frequency-domain tokenizer that converts continuous actions to discrete tokens for autoregressive prediction |
| **Critical ratio** | `environment_dt / inference_time` — when ≥1, the server keeps up and control is smooth; when ≪1, the system degenerates to stop-and-wait |
| **MoT** | Mixture-of-Transformers — architecture where separate expert towers handle different modalities (vision, language, action) |
| **Proprioception** | Robot's internal state sensing (joint positions, velocities, forces) — analogous to human kinesthetic sense |
| **Open-loop execution** | Executing a pre-computed action sequence without real-time feedback — used between inference calls |
| **msgpack** | Binary serialization format — like JSON but binary, faster, and more compact. Cannot execute code (unlike pickle) |

## Further Reading

- [OpenPI remote inference docs](https://github.com/Physical-Intelligence/openpi/blob/main/docs/remote_inference.md)
- [LeRobot async inference blog post](https://huggingface.co/blog/async-robot-inference)
- [LeRobotDataset v3.0 specification](https://huggingface.co/docs/lerobot/en/lerobot-dataset-v3)
- [SmolVLA paper (arXiv 2506.01844)](https://arxiv.org/abs/2506.01844)
- [CVE-2026-25874 analysis](https://chocapikk.com/posts/2026/lerobot-pickle-rce/)
- [Positronic unified robotics stack](https://github.com/Positronic-Robotics/positronic)
- [vLLM-Omni world model RFC (#1987)](https://github.com/vllm-project/vllm-omni/issues/1987)
- [PhAIL real-hardware VLA benchmark](https://positronic.ro/introducing-phail)
- [Model Weight Licensing primer](licensing.md) — Gemma ToU analysis
