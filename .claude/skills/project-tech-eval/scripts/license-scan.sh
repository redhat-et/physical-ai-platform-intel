#!/usr/bin/env bash
# Scans project and dependency licenses.
# Usage: license-scan.sh <repo-path>
# Output: JSON to stdout
# Supports: Python, Node, Go, Rust; falls back to file-based detection

set -euo pipefail

REPO_PATH="${1:?Usage: license-scan.sh <repo-path>}"
cd "$REPO_PATH"

echo "Scanning licenses in ${REPO_PATH}..." >&2

##############################################################################
# 1. Project license
##############################################################################

PROJECT_LICENSE="unknown"
LICENSE_FILE=""

for f in LICENSE LICENSE.md LICENSE.txt LICENCE LICENCE.md COPYING COPYING.md; do
  if [ -f "$f" ]; then
    LICENSE_FILE="$f"
    break
  fi
done

if [ -n "$LICENSE_FILE" ]; then
  CONTENT=$(head -20 "$LICENSE_FILE")
  if echo "$CONTENT" | grep -qi "Apache License.*2\.0\|Apache-2\.0"; then
    PROJECT_LICENSE="Apache-2.0"
  elif echo "$CONTENT" | grep -qi "MIT License\|Permission is hereby granted"; then
    PROJECT_LICENSE="MIT"
  elif echo "$CONTENT" | grep -qi "BSD 3-Clause\|Redistribution and use"; then
    PROJECT_LICENSE="BSD-3-Clause"
  elif echo "$CONTENT" | grep -qi "BSD 2-Clause"; then
    PROJECT_LICENSE="BSD-2-Clause"
  elif echo "$CONTENT" | grep -qi "GNU General Public License.*version 3\|GPLv3"; then
    PROJECT_LICENSE="GPL-3.0"
  elif echo "$CONTENT" | grep -qi "GNU General Public License.*version 2\|GPLv2"; then
    PROJECT_LICENSE="GPL-2.0"
  elif echo "$CONTENT" | grep -qi "GNU Lesser General Public\|LGPL"; then
    PROJECT_LICENSE="LGPL-2.1"
  elif echo "$CONTENT" | grep -qi "Mozilla Public License.*2\.0\|MPL-2\.0"; then
    PROJECT_LICENSE="MPL-2.0"
  elif echo "$CONTENT" | grep -qi "GNU Affero General Public\|AGPL"; then
    PROJECT_LICENSE="AGPL-3.0"
  elif echo "$CONTENT" | grep -qi "Elastic License\|SSPL\|Business Source License\|BSL"; then
    PROJECT_LICENSE="Source-available"
  fi
fi

# Also check pyproject.toml / package.json / Cargo.toml for declared license
DECLARED_LICENSE=""
if [ -f "pyproject.toml" ]; then
  DECLARED_LICENSE=$(python3 -c "
import tomllib, sys
with open('pyproject.toml','rb') as f: d=tomllib.load(f)
print(d.get('project',{}).get('license',{}).get('text','') or d.get('project',{}).get('license',''))
" 2>/dev/null || true)
elif [ -f "package.json" ]; then
  DECLARED_LICENSE=$(jq -r '.license // ""' package.json 2>/dev/null || true)
elif [ -f "Cargo.toml" ]; then
  DECLARED_LICENSE=$(grep '^license' Cargo.toml | head -1 | sed 's/.*=\s*"//' | sed 's/".*//' || true)
fi

##############################################################################
# 2. Dependency licenses (ecosystem-specific)
##############################################################################

echo "  Scanning dependency licenses..." >&2

DEP_LICENSES="[]"

# Python: pip-licenses if available
if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ] || [ -f "setup.py" ]; then
  if command -v pip-licenses &>/dev/null; then
    DEP_LICENSES=$(pip-licenses --format=json 2>/dev/null | \
      jq '[.[] | {name: .Name, version: .Version, license: .License}]' 2>/dev/null || echo '[]')
    echo "  Python: $(echo "$DEP_LICENSES" | jq 'length') dependency licenses found via pip-licenses" >&2
  else
    echo "  Python: pip-licenses not installed, skipping dep license scan" >&2
  fi
fi

# Node: license-checker if available, or parse package.json
if [ -f "package.json" ] && [ -d "node_modules" ]; then
  if command -v license-checker &>/dev/null; then
    DEP_LICENSES=$(license-checker --json 2>/dev/null | \
      jq '[to_entries[] | {name: .key, license: .value.licenses}]' 2>/dev/null || echo '[]')
    echo "  Node: $(echo "$DEP_LICENSES" | jq 'length') dependency licenses found" >&2
  fi
fi

# Go: go-licenses or manual scan
if [ -f "go.mod" ]; then
  if command -v go-licenses &>/dev/null; then
    DEP_LICENSES=$(go-licenses csv . 2>/dev/null | \
      awk -F',' '{print "{\"name\":\""$1"\",\"license\":\""$2"\"}"}' | \
      jq -s '.' 2>/dev/null || echo '[]')
  elif command -v go &>/dev/null; then
    DEP_LICENSES=$(go list -m -json all 2>/dev/null | \
      jq -s '[.[] | select(.Dir) | {name: .Path, version: .Version}]' 2>/dev/null || echo '[]')
    echo "  Go: $(echo "$DEP_LICENSES" | jq 'length') dependencies found (license types require go-licenses)" >&2
  fi
fi

##############################################################################
# 3. License risk analysis
##############################################################################

COPYLEFT_DEPS=$(echo "$DEP_LICENSES" | jq '[.[] | select(.license | test("GPL|AGPL|LGPL|SSPL|OSL|EUPL|CPL|EPL"; "i"))]' 2>/dev/null || echo '[]')
COPYLEFT_COUNT=$(echo "$COPYLEFT_DEPS" | jq 'length')

UNKNOWN_LICENSE_DEPS=$(echo "$DEP_LICENSES" | jq '[.[] | select(.license == null or .license == "" or (.license | test("UNKNOWN|CUSTOM"; "i")))]' 2>/dev/null || echo '[]')
UNKNOWN_COUNT=$(echo "$UNKNOWN_LICENSE_DEPS" | jq 'length')

# Classify project license
LICENSE_CLASS="unknown"
case "$PROJECT_LICENSE" in
  Apache-2.0|MIT|BSD-*|ISC|Unlicense) LICENSE_CLASS="permissive" ;;
  GPL-*|AGPL-*|LGPL-*|MPL-*) LICENSE_CLASS="copyleft" ;;
  Source-available) LICENSE_CLASS="source-available" ;;
esac

##############################################################################
# Output
##############################################################################

jq -n \
  --arg project_license "$PROJECT_LICENSE" \
  --arg declared_license "${DECLARED_LICENSE:-}" \
  --arg license_file "${LICENSE_FILE:-none}" \
  --arg license_class "$LICENSE_CLASS" \
  --argjson dep_licenses "$DEP_LICENSES" \
  --argjson copyleft_deps "$COPYLEFT_DEPS" \
  --argjson copyleft_count "$COPYLEFT_COUNT" \
  --argjson unknown_count "$UNKNOWN_COUNT" \
  '{
    status: "ok",
    project: {
      license_spdx: $project_license,
      declared_license: $declared_license,
      license_file: $license_file,
      license_class: $license_class
    },
    dependencies: {
      total_scanned: ($dep_licenses | length),
      licenses: $dep_licenses
    },
    risk_signals: {
      copyleft_count: $copyleft_count,
      copyleft_deps: $copyleft_deps,
      unknown_license_count: $unknown_count
    }
  }'

echo "Done." >&2
