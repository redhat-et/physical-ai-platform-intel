#!/usr/bin/env bash
# Detects build system, containerization, and reproducibility signals.
# Usage: build-check.sh <repo-path>
# Output: JSON to stdout

set -euo pipefail

REPO_PATH="${1:?Usage: build-check.sh <repo-path>}"
cd "$REPO_PATH"

echo "Checking build system in ${REPO_PATH}..." >&2

##############################################################################
# 1. Build system detection
##############################################################################

BUILD_SYSTEM="unknown"
BUILD_FILES="[]"

declare -A BUILD_SYSTEMS=(
  [CMakeLists.txt]="cmake"
  [Makefile]="make"
  [BUILD]="bazel"
  [BUILD.bazel]="bazel"
  [WORKSPACE]="bazel"
  [WORKSPACE.bazel]="bazel"
  [meson.build]="meson"
  [setup.py]="setuptools"
  [pyproject.toml]="pyproject"
  [setup.cfg]="setuptools"
  [package.json]="npm"
  [go.mod]="go"
  [Cargo.toml]="cargo"
  [build.gradle]="gradle"
  [build.gradle.kts]="gradle"
  [pom.xml]="maven"
  [SConstruct]="scons"
  [Justfile]="just"
  [Taskfile.yml]="task"
)

FOUND_SYSTEMS=""
FOUND_FILES=""
for file in "${!BUILD_SYSTEMS[@]}"; do
  if [ -f "$file" ]; then
    sys="${BUILD_SYSTEMS[$file]}"
    if [ -n "$FOUND_SYSTEMS" ]; then
      FOUND_SYSTEMS="${FOUND_SYSTEMS},\"${sys}\""
      FOUND_FILES="${FOUND_FILES},\"${file}\""
    else
      FOUND_SYSTEMS="\"${sys}\""
      FOUND_FILES="\"${file}\""
      BUILD_SYSTEM="$sys"
    fi
  fi
done

BUILD_FILES="[${FOUND_FILES}]"
ALL_BUILD_SYSTEMS="[${FOUND_SYSTEMS}]"

##############################################################################
# 2. Container support
##############################################################################

echo "  Checking containerization..." >&2

DOCKERFILES=$(find . -maxdepth 3 \( -name "Dockerfile*" -o -name "*.dockerfile" \) \
  -not -path '*/node_modules/*' -not -path '*/vendor/*' -not -path '*/.venv/*' \
  2>/dev/null | head -10 | jq -R -s 'split("\n") | map(select(length > 0))' 2>/dev/null)
DOCKERFILES="${DOCKERFILES:-[]}"

HAS_DOCKER_COMPOSE=false
for f in docker-compose.yml docker-compose.yaml compose.yml compose.yaml; do
  if [ -f "$f" ]; then HAS_DOCKER_COMPOSE=true; break; fi
done

HAS_CONTAINERFILE=false
if [ -f "Containerfile" ]; then HAS_CONTAINERFILE=true; fi

# Check for Kubernetes manifests
K8S_MANIFESTS="[]"
K8S_YAML_FILES=$(find . -maxdepth 3 \( -name "*.yaml" -o -name "*.yml" \) \
  -not -path '*/node_modules/*' -not -path '*/vendor/*' -not -path '*/.venv/*' \
  -not -path '*/venv/*' -not -path '*/.git/*' 2>/dev/null | head -50)
if [ -n "$K8S_YAML_FILES" ]; then
  K8S_MATCHES=$(echo "$K8S_YAML_FILES" | xargs grep -l 'apiVersion:' 2>/dev/null | head -10 || true)
  if [ -n "$K8S_MATCHES" ]; then
    K8S_MANIFESTS=$(echo "$K8S_MATCHES" | jq -R -s 'split("\n") | map(select(length > 0))' 2>/dev/null || echo '[]')
  fi
fi

# Helm charts
HAS_HELM=false
if [ -f "Chart.yaml" ] || [ -d "charts" ] || \
   find . -maxdepth 3 -name "Chart.yaml" -not -path '*/.git/*' 2>/dev/null | grep -q .; then
  HAS_HELM=true
fi

# Kustomize
HAS_KUSTOMIZE=false
if find . -maxdepth 3 \( -name "kustomization.yaml" -o -name "kustomization.yml" \) \
   -not -path '*/.git/*' 2>/dev/null | grep -q .; then
  HAS_KUSTOMIZE=true
fi

##############################################################################
# 3. Reproducibility signals
##############################################################################

echo "  Checking reproducibility..." >&2

# Lockfiles
HAS_LOCKFILE=false
LOCKFILE_TYPE="none"
for f in package-lock.json yarn.lock pnpm-lock.yaml Cargo.lock go.sum Pipfile.lock poetry.lock uv.lock pdm.lock; do
  if [ -f "$f" ]; then
    HAS_LOCKFILE=true
    LOCKFILE_TYPE="$f"
    break
  fi
done

# Pinned dependencies
PINS_DEPS=false
if [ -f "requirements.txt" ]; then
  PINNED=$(grep -c '==' requirements.txt 2>/dev/null || echo 0)
  TOTAL=$(grep -cv '^\s*#\|^\s*$' requirements.txt 2>/dev/null || echo 0)
  if [ "$TOTAL" -gt 0 ] && [ "$PINNED" -eq "$TOTAL" ]; then PINS_DEPS=true; fi
fi

# Nix / Guix
HAS_NIX=false
if [ -f "flake.nix" ] || [ -f "default.nix" ] || [ -f "shell.nix" ]; then HAS_NIX=true; fi

##############################################################################
# 4. CI detection
##############################################################################

echo "  Detecting CI configuration..." >&2

CI_SYSTEMS=""

if [ -d ".github/workflows" ]; then
  CI_SYSTEMS="${CI_SYSTEMS}\"github-actions\","
fi

[ -f ".gitlab-ci.yml" ] && CI_SYSTEMS="${CI_SYSTEMS}\"gitlab-ci\"," || true
[ -f "Jenkinsfile" ] && CI_SYSTEMS="${CI_SYSTEMS}\"jenkins\"," || true
[ -f ".circleci/config.yml" ] && CI_SYSTEMS="${CI_SYSTEMS}\"circleci\"," || true
[ -f ".travis.yml" ] && CI_SYSTEMS="${CI_SYSTEMS}\"travis\"," || true
[ -f "azure-pipelines.yml" ] && CI_SYSTEMS="${CI_SYSTEMS}\"azure-pipelines\"," || true
[ -f ".buildkite/pipeline.yml" ] && CI_SYSTEMS="${CI_SYSTEMS}\"buildkite\"," || true
[ -f "cloudbuild.yaml" ] && CI_SYSTEMS="${CI_SYSTEMS}\"cloud-build\"," || true

CI_SYSTEMS="[${CI_SYSTEMS%,}]"

# Platforms tested (from CI config)
PLATFORMS_TESTED="[]"
if [ -d ".github/workflows" ]; then
  PLATFORMS_TESTED=$(grep -rh 'runs-on:\|os:\|platform:' .github/workflows/ 2>/dev/null | \
    grep -oE 'ubuntu|macos|windows|linux|arm64|aarch64' | sort -u | \
    jq -R -s 'split("\n") | map(select(length > 0))' 2>/dev/null || echo '[]')
fi

##############################################################################
# 5. GPU / accelerator support signals
##############################################################################

echo "  Checking GPU/accelerator support..." >&2

GPU_SIGNALS=""
if (grep -rl 'cuda\|CUDA\|nvidia\|NVIDIA' --include='*.py' --include='*.cmake' --include='*.toml' \
  --include='*.yaml' --include='*.yml' --include='*.cfg' . 2>/dev/null || true) | head -1 | grep -q .; then
  GPU_SIGNALS="${GPU_SIGNALS}\"cuda\","
fi
if (grep -rl 'rocm\|ROCm\|amdgpu\|hip\|HIP' --include='*.py' --include='*.cmake' --include='*.toml' \
  --include='*.yaml' --include='*.yml' . 2>/dev/null || true) | head -1 | grep -q .; then
  GPU_SIGNALS="${GPU_SIGNALS}\"rocm\","
fi
if (grep -rl 'metal\|Metal\|MPS\|mps' --include='*.py' --include='*.swift' . 2>/dev/null || true) | head -1 | grep -q .; then
  GPU_SIGNALS="${GPU_SIGNALS}\"metal\","
fi
if (grep -rl 'oneapi\|sycl\|SYCL' --include='*.py' --include='*.cmake' . 2>/dev/null || true) | head -1 | grep -q .; then
  GPU_SIGNALS="${GPU_SIGNALS}\"oneapi\","
fi
GPU_SIGNALS="[${GPU_SIGNALS%,}]"

##############################################################################
# Output
##############################################################################

jq -n \
  --arg build_system "$BUILD_SYSTEM" \
  --argjson all_build_systems "$ALL_BUILD_SYSTEMS" \
  --argjson build_files "$BUILD_FILES" \
  --argjson dockerfiles "$DOCKERFILES" \
  --argjson has_docker_compose "$HAS_DOCKER_COMPOSE" \
  --argjson has_containerfile "$HAS_CONTAINERFILE" \
  --argjson k8s_manifests "$K8S_MANIFESTS" \
  --argjson has_helm "$HAS_HELM" \
  --argjson has_kustomize "$HAS_KUSTOMIZE" \
  --argjson has_lockfile "$HAS_LOCKFILE" \
  --arg lockfile_type "$LOCKFILE_TYPE" \
  --argjson pins_deps "$PINS_DEPS" \
  --argjson has_nix "$HAS_NIX" \
  --argjson ci_systems "$CI_SYSTEMS" \
  --argjson platforms_tested "$PLATFORMS_TESTED" \
  --argjson gpu_signals "$GPU_SIGNALS" \
  '{
    status: "ok",
    build: {
      primary: $build_system,
      all_systems: $all_build_systems,
      files: $build_files
    },
    containerization: {
      dockerfiles: $dockerfiles,
      docker_compose: $has_docker_compose,
      containerfile: $has_containerfile,
      k8s_manifests: $k8s_manifests,
      helm: $has_helm,
      kustomize: $has_kustomize
    },
    reproducibility: {
      has_lockfile: $has_lockfile,
      lockfile_type: $lockfile_type,
      pins_dependencies: $pins_deps,
      nix: $has_nix
    },
    ci: {
      systems: $ci_systems,
      platforms_tested: $platforms_tested
    },
    gpu_support: $gpu_signals
  }'

echo "Done." >&2
