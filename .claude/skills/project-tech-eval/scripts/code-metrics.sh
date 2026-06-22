#!/usr/bin/env bash
# Extracts code quality signals: LOC by language, TODO density, churn hotspots.
# Usage: code-metrics.sh <repo-path>
# Output: JSON to stdout
# Requires: git (for churn analysis)

set -euo pipefail

REPO_PATH="${1:?Usage: code-metrics.sh <repo-path>}"
cd "$REPO_PATH"

echo "Collecting code metrics for ${REPO_PATH}..." >&2

##############################################################################
# 1. Lines of code by language
##############################################################################

echo "  Counting lines by language..." >&2

LOC_BY_LANG="{}"
if command -v cloc &>/dev/null; then
  LOC_BY_LANG=$(cloc --json --quiet --exclude-dir=vendor,node_modules,venv,.venv,third_party,build,dist \
    . 2>/dev/null | jq 'del(.header, .SUM) | to_entries | map({
      language: .key,
      files: .value.nFiles,
      blank: .value.blank,
      comment: .value.comment,
      code: .value.code
    }) | sort_by(-.code)' 2>/dev/null || echo '[]')
elif command -v tokei &>/dev/null; then
  LOC_BY_LANG=$(tokei --output json . 2>/dev/null | jq 'to_entries | map({
    language: .key,
    files: .value.reports | length,
    code: .value.code,
    comment: .value.comments,
    blank: .value.blanks
  }) | sort_by(-.code)' 2>/dev/null || echo '[]')
else
  # Fallback: basic find + wc
  declare -A EXTS=( [py]=Python [js]=JavaScript [ts]=TypeScript [go]=Go [rs]=Rust [cpp]=C++ [c]=C [java]=Java [rb]=Ruby )
  LOC_ENTRIES=""
  for ext in "${!EXTS[@]}"; do
    COUNT=$( (find . -name "*.${ext}" \
      -not -path '*/vendor/*' -not -path '*/node_modules/*' \
      -not -path '*/.venv/*' -not -path '*/venv/*' \
      -not -path '*/build/*' -not -path '*/dist/*' \
      -exec cat {} + 2>/dev/null || true) | wc -l | tr -d ' ')
    FILES=$(find . -name "*.${ext}" \
      -not -path '*/vendor/*' -not -path '*/node_modules/*' \
      -not -path '*/.venv/*' -not -path '*/venv/*' \
      -not -path '*/build/*' -not -path '*/dist/*' 2>/dev/null | wc -l | tr -d ' ')
    if [ "$COUNT" -gt 0 ] 2>/dev/null; then
      if [ -n "$LOC_ENTRIES" ]; then LOC_ENTRIES="${LOC_ENTRIES},"; fi
      LOC_ENTRIES="${LOC_ENTRIES}{\"language\":\"${EXTS[$ext]}\",\"files\":${FILES},\"code\":${COUNT}}"
    fi
  done
  LOC_BY_LANG="[${LOC_ENTRIES}]"
fi

TOTAL_LOC=$(echo "$LOC_BY_LANG" | jq '[.[].code] | add // 0')

##############################################################################
# 2. TODO / FIXME / HACK density
##############################################################################

echo "  Scanning for TODO/FIXME/HACK markers..." >&2

TODO_COUNT=$( (grep -rn 'TODO\|FIXME\|HACK\|XXX\|WORKAROUND' \
  --include='*.py' --include='*.js' --include='*.ts' --include='*.go' \
  --include='*.rs' --include='*.cpp' --include='*.c' --include='*.java' \
  --include='*.rb' --include='*.sh' \
  --exclude-dir=node_modules --exclude-dir=vendor --exclude-dir=.venv \
  --exclude-dir=venv --exclude-dir=build --exclude-dir=dist \
  . 2>/dev/null || true) | wc -l | tr -d ' ')

TODO_SAMPLES=$( (grep -rn 'TODO\|FIXME\|HACK' \
  --include='*.py' --include='*.js' --include='*.ts' --include='*.go' \
  --include='*.rs' --include='*.cpp' --include='*.c' \
  --exclude-dir=node_modules --exclude-dir=vendor --exclude-dir=.venv \
  --exclude-dir=build --exclude-dir=dist \
  . 2>/dev/null || true) | head -10 | \
  jq -R -s 'split("\n") | map(select(length > 0))' 2>/dev/null)
TODO_SAMPLES="${TODO_SAMPLES:-[]}"

if [ "$TOTAL_LOC" -gt 0 ]; then
  TODO_PER_KLOC=$(echo "scale=1; ${TODO_COUNT} * 1000 / ${TOTAL_LOC}" | bc 2>/dev/null || echo "null")
else
  TODO_PER_KLOC="0"
fi

##############################################################################
# 3. Churn hotspots (files with most commits in last 6 months)
##############################################################################

echo "  Computing churn hotspots (last 6 months)..." >&2

CHURN_HOTSPOTS="[]"
if git rev-parse --is-inside-work-tree &>/dev/null; then
  SINCE_CHURN=$(date -v-6m +%Y-%m-%d 2>/dev/null || date -d "6 months ago" +%Y-%m-%d)
  # Subshell without pipefail to avoid SIGPIPE from head truncating sort
  CHURN_RAW=$(set +o pipefail; git log --since="$SINCE_CHURN" --name-only --pretty=format: 2>/dev/null | \
    sed '/^\s*$/d' | sort | uniq -c | sort -rn | head -20) || true
  if [ -n "$CHURN_RAW" ]; then
    CHURN_HOTSPOTS=$(echo "$CHURN_RAW" | \
      awk '{print "{\"commits\":" $1 ",\"file\":\"" $2 "\"}"}' | \
      jq -s '.' 2>/dev/null || echo '[]')
  fi
fi

##############################################################################
# 4. Lint / format enforcement
##############################################################################

echo "  Checking for lint/format configuration..." >&2

HAS_LINT=false
LINT_TOOLS=""

# Python
for f in .flake8 .pylintrc pyproject.toml setup.cfg .ruff.toml ruff.toml; do
  if [ -f "$f" ]; then
    if [ "$f" = "pyproject.toml" ]; then
      if grep -q '\[tool\.ruff\]\|\[tool\.pylint\]\|\[tool\.flake8\]\|\[tool\.mypy\]\|\[tool\.black\]' "$f" 2>/dev/null; then
        HAS_LINT=true
        LINT_TOOLS="${LINT_TOOLS}ruff/pylint/black "
      fi
    else
      HAS_LINT=true
      LINT_TOOLS="${LINT_TOOLS}${f} "
    fi
  fi
done

# JS/TS
for f in .eslintrc .eslintrc.js .eslintrc.json .eslintrc.yml eslint.config.js eslint.config.mjs .prettierrc .prettierrc.json; do
  if [ -f "$f" ]; then HAS_LINT=true; LINT_TOOLS="${LINT_TOOLS}eslint/prettier "; break; fi
done

# Go
if [ -f ".golangci.yml" ] || [ -f ".golangci.yaml" ]; then
  HAS_LINT=true; LINT_TOOLS="${LINT_TOOLS}golangci-lint "
fi

# Rust
if [ -f "rustfmt.toml" ] || [ -f ".rustfmt.toml" ] || [ -f "clippy.toml" ]; then
  HAS_LINT=true; LINT_TOOLS="${LINT_TOOLS}rustfmt/clippy "
fi

# Pre-commit
HAS_PRECOMMIT=false
if [ -f ".pre-commit-config.yaml" ]; then
  HAS_PRECOMMIT=true
fi

##############################################################################
# 5. Code review signals
##############################################################################

echo "  Checking code review practices..." >&2

# Sample recent merged PRs for review counts
REVIEW_SIGNAL="unknown"
if command -v gh &>/dev/null && gh auth status &>/dev/null 2>&1; then
  ORIGIN=$(git remote get-url origin 2>/dev/null || echo "")
  if echo "$ORIGIN" | grep -q "github.com"; then
    REPO_SLUG=$(echo "$ORIGIN" | sed 's|.*github.com[:/]||' | sed 's|\.git$||')
    REVIEW_COUNTS=$(gh api "repos/${REPO_SLUG}/pulls?state=closed&sort=updated&direction=desc&per_page=10" \
      --jq '[.[] | select(.merged_at != null) | .number]' 2>/dev/null || echo '[]')
    TOTAL_REVIEWS=0
    REVIEWED_PRS=0
    for pr in $(echo "$REVIEW_COUNTS" | jq -r '.[]' | head -5); do
      RC=$(gh api "repos/${REPO_SLUG}/pulls/${pr}/reviews" --jq 'length' 2>/dev/null || echo 0)
      TOTAL_REVIEWS=$((TOTAL_REVIEWS + RC))
      if [ "$RC" -gt 0 ]; then REVIEWED_PRS=$((REVIEWED_PRS + 1)); fi
    done
    if [ "$REVIEWED_PRS" -ge 4 ]; then REVIEW_SIGNAL="consistent"
    elif [ "$REVIEWED_PRS" -ge 2 ]; then REVIEW_SIGNAL="partial"
    else REVIEW_SIGNAL="minimal"; fi
  fi
fi

##############################################################################
# Output
##############################################################################

jq -n \
  --argjson loc_by_language "$LOC_BY_LANG" \
  --argjson total_loc "$TOTAL_LOC" \
  --argjson todo_count "$TODO_COUNT" \
  --arg todo_per_kloc "${TODO_PER_KLOC}" \
  --argjson todo_samples "$TODO_SAMPLES" \
  --argjson churn_hotspots "$CHURN_HOTSPOTS" \
  --argjson has_lint "$HAS_LINT" \
  --arg lint_tools "${LINT_TOOLS}" \
  --argjson has_precommit "$HAS_PRECOMMIT" \
  --arg review_signal "$REVIEW_SIGNAL" \
  '{
    status: "ok",
    loc: {
      total: $total_loc,
      by_language: $loc_by_language
    },
    todo_markers: {
      count: $todo_count,
      per_kloc: (if $todo_per_kloc == "null" then null else ($todo_per_kloc | tonumber) end),
      samples: $todo_samples
    },
    churn_hotspots: $churn_hotspots,
    code_quality: {
      has_linter: $has_lint,
      lint_tools: ($lint_tools | split(" ") | map(select(length > 0)) | unique),
      has_precommit: $has_precommit,
      code_review: $review_signal
    }
  }'

echo "Done." >&2
