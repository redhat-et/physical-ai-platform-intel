#!/usr/bin/env bash
# Extracts dependency tree and computes Libyears (CHAOSS metric).
# Usage: dep-tree.sh <repo-path>
# Output: JSON to stdout
# Supports: Python (pip/pyproject.toml), Node (package.json), Go (go.mod), Rust (Cargo.toml)

set -euo pipefail

REPO_PATH="${1:?Usage: dep-tree.sh <repo-path>}"
cd "$REPO_PATH"

echo "Analyzing dependencies in ${REPO_PATH}..." >&2


##############################################################################
# Python
##############################################################################

detect_python() {
  local deps_file=""
  local deps_list=""

  if [ -f "pyproject.toml" ]; then
    deps_file="pyproject.toml"
    deps_list=$(python3 -c "
import tomllib, json, sys
try:
    with open('pyproject.toml', 'rb') as f:
        d = tomllib.load(f)
    deps = d.get('project', {}).get('dependencies', [])
    # strip version specifiers for names
    names = []
    for dep in deps:
        name = dep.split('>')[0].split('<')[0].split('=')[0].split('!')[0].split('[')[0].split(';')[0].strip()
        if name: names.append(name.lower())
    print(json.dumps(names))
except Exception as e:
    print('[]', file=sys.stdout)
    print(f'Error: {e}', file=sys.stderr)
" 2>/dev/null || echo '[]')
  elif [ -f "setup.py" ]; then
    deps_file="setup.py"
    deps_list='[]'
  elif [ -f "requirements.txt" ]; then
    deps_file="requirements.txt"
    deps_list=$(grep -v '^\s*#' requirements.txt | grep -v '^\s*$' | \
      sed 's/[><=!].*//' | sed 's/\[.*//' | tr -d ' ' | \
      jq -R -s 'split("\n") | map(select(length > 0) | ascii_downcase)' 2>/dev/null || echo '[]')
  fi

  if [ -z "$deps_file" ]; then return 1; fi

  local count=$(echo "$deps_list" | jq 'length')
  echo "  Python ($deps_file): $count direct dependencies" >&2

  # Libyears: compare installed/pinned versions against PyPI latest
  local libyears_entries="[]"
  if [ "$count" -gt 0 ] && [ "$count" -lt 50 ]; then
    echo "  Computing Libyears for Python deps (sampling up to 20)..." >&2
    local entries=""
    for pkg in $(echo "$deps_list" | jq -r '.[0:20] | .[]'); do
      local pypi_info=$(curl -s "https://pypi.org/pypi/${pkg}/json" 2>/dev/null || echo '{}')
      local latest=$(echo "$pypi_info" | jq -r '.info.version // empty' 2>/dev/null || true)
      local latest_date=$(echo "$pypi_info" | jq -r '.urls[0].upload_time // empty' 2>/dev/null || true)
      if [ -n "$latest" ]; then
        if [ -n "$entries" ]; then entries="${entries},"; fi
        entries="${entries}{\"package\":\"${pkg}\",\"latest\":\"${latest}\"}"
      fi
    done
    if [ -n "$entries" ]; then
      libyears_entries="[${entries}]"
    fi
  fi

  echo "{\"ecosystem\":\"python\",\"file\":\"${deps_file}\",\"direct_count\":${count},\"deps\":${deps_list},\"libyears_data\":${libyears_entries}}"
}

##############################################################################
# Node.js
##############################################################################

detect_node() {
  if [ ! -f "package.json" ]; then return 1; fi

  local deps=$(jq '{
    dependencies: (.dependencies // {} | keys),
    devDependencies: (.devDependencies // {} | keys),
    direct_count: ((.dependencies // {} | keys | length) + (.devDependencies // {} | keys | length))
  }' package.json 2>/dev/null || echo '{}')

  local count=$(echo "$deps" | jq '.direct_count')
  echo "  Node.js (package.json): $count direct dependencies" >&2

  # Check for lockfile
  local lockfile="none"
  [ -f "package-lock.json" ] && lockfile="package-lock.json"
  [ -f "yarn.lock" ] && lockfile="yarn.lock"
  [ -f "pnpm-lock.yaml" ] && lockfile="pnpm-lock.yaml"

  # npm outdated for libyears (if npm available and node_modules exist)
  local outdated="[]"
  if command -v npm &>/dev/null && [ -f "package-lock.json" ]; then
    outdated=$(npm outdated --json 2>/dev/null | jq '[to_entries[] | {package: .key, current: .value.current, latest: .value.latest}]' 2>/dev/null || echo '[]')
  fi

  echo "{\"ecosystem\":\"node\",\"file\":\"package.json\",\"lockfile\":\"${lockfile}\",\"direct_count\":${count},\"deps\":$(echo "$deps" | jq '.dependencies'),\"outdated\":${outdated}}"
}

##############################################################################
# Go
##############################################################################

detect_go() {
  if [ ! -f "go.mod" ]; then return 1; fi

  local deps=$(grep -c '^\s' go.mod 2>/dev/null || echo 0)
  local go_version=$(head -5 go.mod | grep '^go ' | awk '{print $2}' || echo "unknown")
  echo "  Go (go.mod): ~${deps} dependencies, go ${go_version}" >&2

  local dep_list=$(grep '^\t' go.mod 2>/dev/null | grep -v '^\t//' | awk '{print $1}' | \
    jq -R -s 'split("\n") | map(select(length > 0))' 2>/dev/null || echo '[]')

  # go list -m -u all for outdated (if go is available)
  local outdated="[]"
  if command -v go &>/dev/null; then
    outdated=$(go list -m -u -json all 2>/dev/null | \
      jq -s '[.[] | select(.Update) | {module: .Path, current: .Version, latest: .Update.Version}]' 2>/dev/null || echo '[]')
  fi

  echo "{\"ecosystem\":\"go\",\"file\":\"go.mod\",\"go_version\":\"${go_version}\",\"direct_count\":$(echo "$dep_list" | jq 'length'),\"deps\":${dep_list},\"outdated\":${outdated}}"
}

##############################################################################
# Rust
##############################################################################

detect_rust() {
  if [ ! -f "Cargo.toml" ]; then return 1; fi

  local deps=$(grep -c '^\w' Cargo.toml 2>/dev/null || echo 0)
  echo "  Rust (Cargo.toml): project detected" >&2

  local dep_names='[]'
  if command -v cargo &>/dev/null; then
    dep_names=$(cargo metadata --no-deps --format-version 1 2>/dev/null | \
      jq '[.packages[0].dependencies[] | .name]' 2>/dev/null || echo '[]')
  else
    dep_names=$(grep -A 100 '^\[dependencies\]' Cargo.toml 2>/dev/null | \
      grep -v '^\[' | grep '=' | awk -F'=' '{print $1}' | tr -d ' "' | \
      jq -R -s 'split("\n") | map(select(length > 0))' 2>/dev/null || echo '[]')
  fi

  local lockfile="none"
  [ -f "Cargo.lock" ] && lockfile="Cargo.lock"

  echo "{\"ecosystem\":\"rust\",\"file\":\"Cargo.toml\",\"lockfile\":\"${lockfile}\",\"direct_count\":$(echo "$dep_names" | jq 'length'),\"deps\":${dep_names}}"
}

##############################################################################
# C++ (CMake / Bazel)
##############################################################################

detect_cpp() {
  local build_sys=""
  if [ -f "CMakeLists.txt" ]; then
    build_sys="cmake"
  elif [ -f "BUILD" ] || [ -f "BUILD.bazel" ] || [ -f "WORKSPACE" ]; then
    build_sys="bazel"
  elif [ -f "meson.build" ]; then
    build_sys="meson"
  else
    return 1
  fi

  echo "  C++ (${build_sys}): project detected" >&2

  local find_packages='[]'
  if [ "$build_sys" = "cmake" ]; then
    find_packages=$(grep -rh 'find_package\|FetchContent_Declare' CMakeLists.txt cmake/ 2>/dev/null | \
      grep -oE 'find_package\([A-Za-z0-9_]+|FetchContent_Declare\([A-Za-z0-9_]+' | sed 's/.*(//' | sort -u | \
      jq -R -s 'split("\n") | map(select(length > 0))' 2>/dev/null || echo '[]')
  fi

  echo "{\"ecosystem\":\"cpp\",\"build_system\":\"${build_sys}\",\"direct_count\":$(echo "$find_packages" | jq 'length'),\"deps\":${find_packages}}"
}

##############################################################################
# Collect all ecosystems
##############################################################################

RESULTS=""

for detector in detect_python detect_node detect_go detect_rust detect_cpp; do
  result=$($detector 2>/dev/null || true)
  if [ -n "$result" ]; then
    if [ -n "$RESULTS" ]; then RESULTS="${RESULTS},"; fi
    RESULTS="${RESULTS}${result}"
  fi
done

if [ -z "$RESULTS" ]; then
  echo '{"status":"partial","reason":"no recognized package manager found","ecosystems":[]}' | jq .
  exit 0
fi

echo "[${RESULTS}]" | jq '{
  status: "ok",
  ecosystems: .,
  summary: {
    ecosystem_count: (. | length),
    total_direct_deps: ([.[].direct_count] | add),
    ecosystems_found: [.[].ecosystem]
  }
}'

echo "Done." >&2
