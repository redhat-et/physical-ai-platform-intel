#!/usr/bin/env bash
# Collects CHAOSS-aligned community metrics from GitHub API.
# Usage: gh-community-stats.sh <owner/repo> [--months 12]
# Output: JSON to stdout
# Requires: gh (GitHub CLI, authenticated)

set -euo pipefail

REPO="${1:?Usage: gh-community-stats.sh <owner/repo> [--months N]}"
MONTHS="${3:-12}"
OWNER="${REPO%%/*}"
REPONAME="${REPO##*/}"

if ! command -v gh &>/dev/null; then
  echo '{"status":"skipped","reason":"gh CLI not installed"}' | jq .
  exit 0
fi

if ! gh auth status &>/dev/null 2>&1; then
  echo '{"status":"skipped","reason":"gh CLI not authenticated"}' | jq .
  exit 0
fi

SINCE=$(date -v-${MONTHS}m +%Y-%m-%dT00:00:00Z 2>/dev/null || date -d "${MONTHS} months ago" +%Y-%m-%dT00:00:00Z)

echo "Collecting community stats for ${REPO} (since ${SINCE})..." >&2

##############################################################################
# 1. Contributor data — for Elephant Factor and Contributor Absence Factor
##############################################################################

echo "  Fetching contributor commit counts..." >&2
# Paginate without --jq to avoid per-page array wrapping bug, then merge with jq
CONTRIBUTORS_RAW=$(gh api "repos/${REPO}/contributors?per_page=100&anon=false" \
  --paginate 2>/dev/null || echo '[]')
CONTRIBUTORS_JSON=$(echo "$CONTRIBUTORS_RAW" | jq -s '[.[][] | {login: .login, commits: .contributions}]' 2>/dev/null || echo '[]')

TOTAL_COMMITS=$(echo "$CONTRIBUTORS_JSON" | jq '[.[].commits] | add // 0')
CONTRIBUTOR_COUNT=$(echo "$CONTRIBUTORS_JSON" | jq 'length')

# Contributor Absence Factor: smallest N people for 50% of commits
CAF=$(echo "$CONTRIBUTORS_JSON" | jq --argjson total "$TOTAL_COMMITS" '
  sort_by(-.commits) |
  reduce .[] as $c ({i: 0, cumulative: 0, result: null};
    if .result then . else
      .i += 1 | .cumulative += $c.commits |
      if .cumulative >= ($total * 0.5) then .result = .i else . end
    end
  ) | .result // 1
')

# Top contributors with org info (best-effort: profile company field)
echo "  Fetching contributor org affiliations (top 20)..." >&2
TOP_CONTRIBUTORS=$(echo "$CONTRIBUTORS_JSON" | jq -r '.[0:20] | .[].login')
CONTRIBUTOR_ORGS="[]"
if [ -n "$TOP_CONTRIBUTORS" ]; then
  ORG_ENTRIES=""
  for login in $TOP_CONTRIBUTORS; do
    COMPANY=$(gh api "users/${login}" --jq '.company // ""' 2>/dev/null || echo "")
    COMPANY=$(echo "$COMPANY" | sed 's/^@//')
    COMMITS=$(echo "$CONTRIBUTORS_JSON" | jq -r --arg l "$login" '.[] | select(.login == $l) | .commits')
    if [ -n "$ORG_ENTRIES" ]; then ORG_ENTRIES="${ORG_ENTRIES},"; fi
    ORG_ENTRIES="${ORG_ENTRIES}{\"login\":\"${login}\",\"company\":\"${COMPANY}\",\"commits\":${COMMITS}}"
  done
  CONTRIBUTOR_ORGS="[${ORG_ENTRIES}]"
fi

# Elephant Factor: group by company, find minimum N orgs for 50%
ELEPHANT_FACTOR=$(echo "$CONTRIBUTOR_ORGS" | jq --argjson total "$TOTAL_COMMITS" '
  group_by(.company) |
  map({company: .[0].company, commits: ([.[].commits] | add)}) |
  sort_by(-.commits) |
  reduce .[] as $org ([]; . + [$org + {cumulative: ((if length > 0 then .[-1].cumulative else 0 end) + $org.commits)}]) |
  [.[] | select(.cumulative >= ($total * 0.5))] | .[0] |
  if . then (.cumulative / $total * 100 | floor) else null end
' 2>/dev/null || echo 'null')

ELEPHANT_N=$(echo "$CONTRIBUTOR_ORGS" | jq --argjson total "$TOTAL_COMMITS" '
  group_by(.company) |
  map({company: .[0].company, commits: ([.[].commits] | add)}) |
  sort_by(-.commits) |
  reduce .[] as $org ([]; . + [$org + {cumulative: ((if length > 0 then .[-1].cumulative else 0 end) + $org.commits)}]) |
  [to_entries[] | select(.value.cumulative >= ($total * 0.5))] | .[0].key + 1 // null
' 2>/dev/null || echo 'null')

ORG_BREAKDOWN=$(echo "$CONTRIBUTOR_ORGS" | jq --argjson total "$TOTAL_COMMITS" '
  group_by(.company) |
  map({company: (.[0].company | if . == "" then "(unknown)" else . end),
       commits: ([.[].commits] | add),
       pct: (([.[].commits] | add) / $total * 100 | round)}) |
  sort_by(-.commits) | .[0:10]
')

##############################################################################
# 2. Change Request Closure Ratio (PRs opened vs closed in period)
##############################################################################

echo "  Fetching PR stats..." >&2
PRS_OPENED=$(gh api "search/issues?q=repo:${REPO}+is:pr+created:>=${SINCE}" --jq '.total_count' 2>/dev/null || echo 0)
PRS_CLOSED=$(gh api "search/issues?q=repo:${REPO}+is:pr+is:closed+closed:>=${SINCE}" --jq '.total_count' 2>/dev/null || echo 0)
PRS_MERGED=$(gh api "search/issues?q=repo:${REPO}+is:pr+is:merged+closed:>=${SINCE}" --jq '.total_count' 2>/dev/null || echo 0)

if [ "$PRS_OPENED" -gt 0 ] 2>/dev/null; then
  CR_RATIO=$(echo "scale=2; ${PRS_CLOSED} / ${PRS_OPENED}" | bc 2>/dev/null || echo "null")
else
  CR_RATIO="null"
fi

##############################################################################
# 3. Time to First Response (sample recent PRs and issues)
##############################################################################

echo "  Sampling time-to-first-response..." >&2
TTFR_HOURS="null"
PR_SAMPLE_RAW=$(gh api "repos/${REPO}/pulls?state=closed&sort=updated&direction=desc&per_page=20" 2>/dev/null || echo '[]')
PR_SAMPLE=$(echo "$PR_SAMPLE_RAW" | jq '[.[] | {number: .number, created: .created_at}]' 2>/dev/null || echo '[]')

if [ "$(echo "$PR_SAMPLE" | jq 'length')" -gt 0 ]; then
  RESPONSE_HOURS=""
  for number in $(echo "$PR_SAMPLE" | jq -r '.[0:10] | .[].number'); do
    FIRST_COMMENT=$(gh api "repos/${REPO}/pulls/${number}/comments?per_page=1&sort=created&direction=asc" \
      --jq '.[0].created_at // empty' 2>/dev/null || true)
    if [ -z "$FIRST_COMMENT" ]; then
      FIRST_COMMENT=$(gh api "repos/${REPO}/issues/${number}/comments?per_page=1&sort=created&direction=asc" \
        --jq '.[0].created_at // empty' 2>/dev/null || true)
    fi
    if [ -z "$FIRST_COMMENT" ]; then
      FIRST_REVIEW=$(gh api "repos/${REPO}/pulls/${number}/reviews?per_page=1" \
        --jq '.[0].submitted_at // empty' 2>/dev/null || true)
      FIRST_COMMENT="$FIRST_REVIEW"
    fi
    if [ -n "$FIRST_COMMENT" ]; then
      CREATED=$(echo "$PR_SAMPLE" | jq -r --argjson n "$number" '.[] | select(.number == $n) | .created')
      if [ -n "$CREATED" ]; then
        CREATED_TS=$(date -jf "%Y-%m-%dT%H:%M:%SZ" "$CREATED" +%s 2>/dev/null || date -d "$CREATED" +%s 2>/dev/null || echo "")
        RESPONSE_TS=$(date -jf "%Y-%m-%dT%H:%M:%SZ" "$FIRST_COMMENT" +%s 2>/dev/null || date -d "$FIRST_COMMENT" +%s 2>/dev/null || echo "")
        if [ -n "$CREATED_TS" ] && [ -n "$RESPONSE_TS" ]; then
          DIFF_H=$(( (RESPONSE_TS - CREATED_TS) / 3600 ))
          if [ -n "$RESPONSE_HOURS" ]; then RESPONSE_HOURS="${RESPONSE_HOURS},"; fi
          RESPONSE_HOURS="${RESPONSE_HOURS}${DIFF_H}"
        fi
      fi
    fi
  done
  if [ -n "$RESPONSE_HOURS" ]; then
    TTFR_HOURS=$(echo "[${RESPONSE_HOURS}]" | jq 'sort | .[length/2 | floor]')
  fi
fi

##############################################################################
# 4. Release Frequency
##############################################################################

echo "  Fetching releases..." >&2
RELEASES_RAW=$(gh api "repos/${REPO}/releases?per_page=100" 2>/dev/null || echo '[]')
RELEASES=$(echo "$RELEASES_RAW" | jq '[.[] | {tag: .tag_name, date: .published_at, prerelease: .prerelease}]' 2>/dev/null || echo '[]')

RELEASE_COUNT=$(echo "$RELEASES" | jq 'length')
LATEST_RELEASE=$(echo "$RELEASES" | jq -r '.[0].date // "none"')
LATEST_TAG=$(echo "$RELEASES" | jq -r '.[0].tag // "none"')

# Releases in the analysis period
RELEASES_IN_PERIOD=$(echo "$RELEASES" | jq --arg since "$SINCE" '[.[] | select(.date >= $since)] | length')

# If no releases via API, check tags
if [ "$RELEASE_COUNT" -eq 0 ]; then
  echo "  No releases found, checking tags..." >&2
  TAGS=$(gh api "repos/${REPO}/tags?per_page=20" --jq '[.[] | .name]' 2>/dev/null || echo '[]')
  TAG_COUNT=$(echo "$TAGS" | jq 'length')
  LATEST_TAG=$(echo "$TAGS" | jq -r '.[0] // "none"')
fi

##############################################################################
# 5. Basic repo stats
##############################################################################

echo "  Fetching repo metadata..." >&2
REPO_META=$(gh api "repos/${REPO}" --jq '{
  stars: .stargazers_count,
  forks: .forks_count,
  open_issues: .open_issues_count,
  watchers: .subscribers_count,
  created: .created_at,
  updated: .pushed_at,
  language: .language,
  license: .license.spdx_id,
  archived: .archived,
  default_branch: .default_branch
}' 2>/dev/null || echo '{}')

##############################################################################
# Output
##############################################################################

jq -n \
  --argjson total_commits "$TOTAL_COMMITS" \
  --argjson contributor_count "$CONTRIBUTOR_COUNT" \
  --argjson caf "${CAF:-null}" \
  --argjson elephant_n "${ELEPHANT_N:-null}" \
  --argjson org_breakdown "$ORG_BREAKDOWN" \
  --argjson contributor_orgs "$CONTRIBUTOR_ORGS" \
  --argjson prs_opened "$PRS_OPENED" \
  --argjson prs_closed "$PRS_CLOSED" \
  --argjson prs_merged "$PRS_MERGED" \
  --arg cr_ratio "${CR_RATIO}" \
  --argjson ttfr_hours "${TTFR_HOURS:-null}" \
  --argjson release_count "$RELEASE_COUNT" \
  --argjson releases_in_period "$RELEASES_IN_PERIOD" \
  --arg latest_release "$LATEST_RELEASE" \
  --arg latest_tag "$LATEST_TAG" \
  --argjson repo_meta "$REPO_META" \
  '{
    status: "ok",
    repo: $repo_meta,
    chaoss_metrics: {
      elephant_factor: {
        value: $elephant_n,
        org_breakdown: $org_breakdown
      },
      contributor_absence_factor: {
        value: $caf,
        total_contributors: $contributor_count,
        total_commits: $total_commits
      },
      change_request_closure_ratio: {
        opened: $prs_opened,
        closed: $prs_closed,
        merged: $prs_merged,
        ratio: (if $cr_ratio == "null" then null else ($cr_ratio | tonumber) end)
      },
      time_to_first_response: {
        median_hours: $ttfr_hours,
        sample_size: 10
      },
      release_frequency: {
        total_releases: $release_count,
        releases_in_period: $releases_in_period,
        latest_release: $latest_release,
        latest_tag: $latest_tag
      }
    },
    top_contributors: $contributor_orgs
  }'

echo "Done." >&2
