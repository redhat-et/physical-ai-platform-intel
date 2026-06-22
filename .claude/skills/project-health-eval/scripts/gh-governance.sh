#!/usr/bin/env bash
# Collects strategic governance signals from a GitHub repo.
# Usage: gh-governance.sh <owner/repo> [repo-local-path]
# Output: JSON to stdout
# Requires: gh (GitHub CLI, authenticated)

set -euo pipefail

REPO="${1:?Usage: gh-governance.sh <owner/repo> [repo-local-path]}"
LOCAL_PATH="${2:-}"
OWNER="${REPO%%/*}"
REPONAME="${REPO##*/}"

if ! command -v gh &>/dev/null; then
  echo '{"status":"skipped","reason":"gh CLI not installed"}' | jq .
  exit 0
fi

echo "Collecting governance signals for ${REPO}..." >&2

##############################################################################
# 1. Governance documents presence
##############################################################################

echo "  Checking governance documents..." >&2

check_file() {
  local path="$1"
  gh api "repos/${REPO}/contents/${path}" --jq '.name' 2>/dev/null && echo "true" || echo "false"
}

HAS_GOVERNANCE=$(check_file "GOVERNANCE.md")
HAS_CHARTER=$(check_file "CHARTER.md")
HAS_CONTRIBUTING=$(check_file "CONTRIBUTING.md")
HAS_CODEOWNERS=$(check_file "CODEOWNERS" 2>/dev/null || check_file ".github/CODEOWNERS" 2>/dev/null || echo "false")
HAS_CODE_OF_CONDUCT=$(check_file "CODE_OF_CONDUCT.md")
HAS_SECURITY=$(check_file "SECURITY.md" 2>/dev/null || check_file ".github/SECURITY.md" 2>/dev/null || echo "false")

##############################################################################
# 2. CLA / DCO detection
##############################################################################

echo "  Detecting CLA/DCO requirements..." >&2

CONTRIBUTION_MODEL="none"

# Check CONTRIBUTING.md content for CLA/DCO mentions
CONTRIBUTING_CONTENT=$(gh api "repos/${REPO}/contents/CONTRIBUTING.md" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null || echo "")

if echo "$CONTRIBUTING_CONTENT" | grep -qi "contributor license agreement\|sign.*CLA\|CLA.*sign\|individual contributor license"; then
  CONTRIBUTION_MODEL="CLA"
elif echo "$CONTRIBUTING_CONTENT" | grep -qi "developer certificate of origin\|DCO\|Signed-off-by"; then
  CONTRIBUTION_MODEL="DCO"
fi

# Check for CLA bot in recent PRs
if [ "$CONTRIBUTION_MODEL" = "none" ]; then
  CLA_BOT=$(gh api "repos/${REPO}/pulls?state=closed&per_page=5" \
    --jq '[.[].number]' 2>/dev/null || echo '[]')
  for pr_num in $(echo "$CLA_BOT" | jq -r '.[]' | head -3); do
    BOT_COMMENTS=$(gh api "repos/${REPO}/issues/${pr_num}/comments?per_page=10" \
      --jq '[.[] | select(.user.login | test("cla|clabot|linux-foundation|easycla|googlebot"; "i")) | .user.login] | unique' 2>/dev/null || echo '[]')
    if [ "$(echo "$BOT_COMMENTS" | jq 'length')" -gt 0 ]; then
      CONTRIBUTION_MODEL="CLA"
      break
    fi
    DCO_COMMENTS=$(gh api "repos/${REPO}/issues/${pr_num}/comments?per_page=10" \
      --jq '[.[] | select(.user.login | test("dco|probot"; "i")) | .user.login] | unique' 2>/dev/null || echo '[]')
    if [ "$(echo "$DCO_COMMENTS" | jq 'length')" -gt 0 ]; then
      CONTRIBUTION_MODEL="DCO"
      break
    fi
  done
fi

##############################################################################
# 3. Foundation affiliation
##############################################################################

echo "  Checking foundation affiliation..." >&2

README_CONTENT=$(gh api "repos/${REPO}/readme" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null || echo "")
FOUNDATION="none"

for f in "Linux Foundation" "CNCF" "Cloud Native Computing Foundation" "Apache Software Foundation" \
         "Eclipse Foundation" "OpenJS Foundation" "NumFOCUS" "Open Robotics" "OSRA" \
         "LF AI" "LF Edge" "Open Source Robotics Alliance"; do
  if echo "$README_CONTENT $CONTRIBUTING_CONTENT" | grep -qi "$f"; then
    FOUNDATION="$f"
    break
  fi
done

##############################################################################
# 4. CODEOWNERS analysis (who owns what)
##############################################################################

echo "  Analyzing CODEOWNERS..." >&2

CODEOWNERS_CONTENT=""
for path in "CODEOWNERS" ".github/CODEOWNERS" "docs/CODEOWNERS"; do
  CODEOWNERS_CONTENT=$(gh api "repos/${REPO}/contents/${path}" --jq '.content' 2>/dev/null | base64 -d 2>/dev/null || true)
  if [ -n "$CODEOWNERS_CONTENT" ]; then break; fi
done

CODEOWNERS_TEAMS="[]"
if [ -n "$CODEOWNERS_CONTENT" ]; then
  CODEOWNERS_TEAMS=$(echo "$CODEOWNERS_CONTENT" | grep -v '^#' | grep -v '^\s*$' | \
    awk '{for(i=2;i<=NF;i++) print $i}' | sort -u | \
    jq -R -s 'split("\n") | map(select(length > 0))')
fi

##############################################################################
# 5. Branch protection / review requirements
##############################################################################

echo "  Checking branch protection..." >&2

DEFAULT_BRANCH=$(gh api "repos/${REPO}" --jq '.default_branch' 2>/dev/null || echo "main")
BRANCH_PROTECTION=$(gh api "repos/${REPO}/branches/${DEFAULT_BRANCH}/protection" 2>/dev/null || echo '{"status":"not_configured"}')

REQUIRED_REVIEWS=$(echo "$BRANCH_PROTECTION" | jq '.required_pull_request_reviews.required_approving_review_count // 0' 2>/dev/null || echo 0)
REQUIRE_STATUS_CHECKS=$(echo "$BRANCH_PROTECTION" | jq '.required_status_checks != null' 2>/dev/null || echo "false")

##############################################################################
# 6. CI/CD detection
##############################################################################

echo "  Detecting CI configuration..." >&2

HAS_GH_ACTIONS="false"
GH_WORKFLOWS=$(gh api "repos/${REPO}/contents/.github/workflows" --jq '[.[] | .name]' 2>/dev/null || echo '[]')
if [ "$(echo "$GH_WORKFLOWS" | jq 'length')" -gt 0 ]; then
  HAS_GH_ACTIONS="true"
fi

# Check for other CI systems
HAS_JENKINS="false"
gh api "repos/${REPO}/contents/Jenkinsfile" --jq '.name' 2>/dev/null && HAS_JENKINS="true" || true

HAS_CIRCLE="false"
gh api "repos/${REPO}/contents/.circleci/config.yml" --jq '.name' 2>/dev/null && HAS_CIRCLE="true" || true

##############################################################################
# 7. OpenSSF Scorecard (if available)
##############################################################################

echo "  Checking OpenSSF Scorecard..." >&2
SCORECARD_SCORE="null"
SCORECARD_DATA=$(gh api "repos/${REPO}/contents/.github/workflows" --jq '[.[] | select(.name | test("scorecard"))] | length' 2>/dev/null || echo "0")

##############################################################################
# Output
##############################################################################

jq -n \
  --argjson has_governance "$([ "$HAS_GOVERNANCE" != "false" ] && echo true || echo false)" \
  --argjson has_charter "$([ "$HAS_CHARTER" != "false" ] && echo true || echo false)" \
  --argjson has_contributing "$([ "$HAS_CONTRIBUTING" != "false" ] && echo true || echo false)" \
  --argjson has_codeowners "$([ "$HAS_CODEOWNERS" != "false" ] && echo true || echo false)" \
  --argjson has_code_of_conduct "$([ "$HAS_CODE_OF_CONDUCT" != "false" ] && echo true || echo false)" \
  --argjson has_security "$([ "$HAS_SECURITY" != "false" ] && echo true || echo false)" \
  --arg contribution_model "$CONTRIBUTION_MODEL" \
  --arg foundation "$FOUNDATION" \
  --argjson codeowners_teams "$CODEOWNERS_TEAMS" \
  --argjson required_reviews "$REQUIRED_REVIEWS" \
  --argjson require_status_checks "$REQUIRE_STATUS_CHECKS" \
  --argjson has_gh_actions "$([ "$HAS_GH_ACTIONS" = "true" ] && echo true || echo false)" \
  --argjson has_jenkins "$([ "$HAS_JENKINS" = "true" ] && echo true || echo false)" \
  --argjson has_circle "$([ "$HAS_CIRCLE" = "true" ] && echo true || echo false)" \
  --argjson gh_workflows "$GH_WORKFLOWS" \
  '{
    status: "ok",
    governance_documents: {
      GOVERNANCE_md: $has_governance,
      CHARTER_md: $has_charter,
      CONTRIBUTING_md: $has_contributing,
      CODEOWNERS: $has_codeowners,
      CODE_OF_CONDUCT_md: $has_code_of_conduct,
      SECURITY_md: $has_security
    },
    contribution_model: $contribution_model,
    foundation: $foundation,
    codeowners_teams: $codeowners_teams,
    branch_protection: {
      required_reviews: $required_reviews,
      require_status_checks: $require_status_checks
    },
    ci: {
      github_actions: $has_gh_actions,
      jenkins: $has_jenkins,
      circleci: $has_circle,
      workflows: $gh_workflows
    }
  }'

echo "Done." >&2
