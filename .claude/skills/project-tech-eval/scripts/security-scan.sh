#!/usr/bin/env bash
# Scans for known CVEs in project dependencies.
# Usage: security-scan.sh <repo-path>
# Output: JSON to stdout
# Tools: osv-scanner (preferred), grype, or npm audit / pip-audit

set -euo pipefail

REPO_PATH="${1:?Usage: security-scan.sh <repo-path>}"
cd "$REPO_PATH"

echo "Scanning for security vulnerabilities in ${REPO_PATH}..." >&2

SCANNER="none"
SCAN_RESULT="[]"
SCAN_STATUS="skipped"
SCAN_REASON=""

##############################################################################
# 1. Try osv-scanner (Google's OSV database — best coverage)
##############################################################################

if command -v osv-scanner &>/dev/null; then
  SCANNER="osv-scanner"
  echo "  Using osv-scanner..." >&2
  RAW=$(osv-scanner --json -r "$REPO_PATH" 2>/dev/null || true)
  if [ -n "$RAW" ]; then
    SCAN_RESULT=$(echo "$RAW" | jq '[.results[]?.packages[]? | {
      package: .package.name,
      version: .package.version,
      ecosystem: .package.ecosystem,
      vulnerabilities: [.vulnerabilities[]? | {
        id: .id,
        summary: .summary,
        severity: (.database_specific.severity // .severity // "UNKNOWN"),
        aliases: [.aliases[]?]
      }]
    }] | map(select(.vulnerabilities | length > 0))' 2>/dev/null || echo '[]')
    SCAN_STATUS="ok"
  else
    SCAN_STATUS="ok"
    SCAN_RESULT="[]"
  fi

##############################################################################
# 2. Try grype
##############################################################################

elif command -v grype &>/dev/null; then
  SCANNER="grype"
  echo "  Using grype..." >&2
  RAW=$(grype dir:"$REPO_PATH" -o json 2>/dev/null || true)
  if [ -n "$RAW" ]; then
    SCAN_RESULT=$(echo "$RAW" | jq '[.matches[]? | {
      package: .artifact.name,
      version: .artifact.version,
      ecosystem: .artifact.type,
      vulnerabilities: [{
        id: .vulnerability.id,
        summary: .vulnerability.description,
        severity: .vulnerability.severity,
        fix_version: .vulnerability.fix.versions[0]?
      }]
    }]' 2>/dev/null || echo '[]')
    SCAN_STATUS="ok"
  fi

##############################################################################
# 3. Ecosystem-specific fallbacks
##############################################################################

else
  # Python: pip-audit
  if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
    if command -v pip-audit &>/dev/null; then
      SCANNER="pip-audit"
      echo "  Using pip-audit..." >&2
      RAW=$(pip-audit --format=json 2>/dev/null || true)
      if [ -n "$RAW" ]; then
        SCAN_RESULT=$(echo "$RAW" | jq '[.dependencies[]? | select(.vulns | length > 0) | {
          package: .name,
          version: .version,
          ecosystem: "PyPI",
          vulnerabilities: [.vulns[]? | {id: .id, summary: .description, severity: "UNKNOWN"}]
        }]' 2>/dev/null || echo '[]')
        SCAN_STATUS="ok"
      fi
    fi
  fi

  # Node: npm audit
  if [ -f "package-lock.json" ] && command -v npm &>/dev/null; then
    SCANNER="npm-audit"
    echo "  Using npm audit..." >&2
    RAW=$(npm audit --json 2>/dev/null || true)
    if [ -n "$RAW" ]; then
      SCAN_RESULT=$(echo "$RAW" | jq '[.vulnerabilities // {} | to_entries[] | {
        package: .key,
        version: .value.range,
        ecosystem: "npm",
        vulnerabilities: [{
          id: (.value.via[0].url // .key),
          summary: (.value.via[0].title // ""),
          severity: .value.severity
        }]
      }]' 2>/dev/null || echo '[]')
      SCAN_STATUS="ok"
    fi
  fi

  # Go: govulncheck
  if [ -f "go.mod" ] && command -v govulncheck &>/dev/null; then
    SCANNER="govulncheck"
    echo "  Using govulncheck..." >&2
    RAW=$(govulncheck -json ./... 2>/dev/null || true)
    if [ -n "$RAW" ]; then
      SCAN_RESULT=$(echo "$RAW" | jq -s '[.[] | select(.osv) | {
        package: .osv.affected[0].package.name,
        version: "",
        ecosystem: "Go",
        vulnerabilities: [{id: .osv.id, summary: .osv.summary, severity: "UNKNOWN"}]
      }]' 2>/dev/null || echo '[]')
      SCAN_STATUS="ok"
    fi
  fi

  if [ "$SCANNER" = "none" ]; then
    SCAN_REASON="no scanner installed (tried: osv-scanner, grype, pip-audit, npm audit, govulncheck)"
  fi
fi

##############################################################################
# 4. Security policy check
##############################################################################

HAS_SECURITY_POLICY=false
for f in SECURITY.md .github/SECURITY.md security.md; do
  if [ -f "$f" ]; then
    HAS_SECURITY_POLICY=true
    break
  fi
done

##############################################################################
# 5. Summarize
##############################################################################

VULN_COUNT=$(echo "$SCAN_RESULT" | jq 'length')
CRITICAL=$(echo "$SCAN_RESULT" | jq '[.[].vulnerabilities[] | select(.severity | test("CRITICAL|critical"; "i"))] | length' 2>/dev/null || echo 0)
HIGH=$(echo "$SCAN_RESULT" | jq '[.[].vulnerabilities[] | select(.severity | test("HIGH|high"; "i"))] | length' 2>/dev/null || echo 0)
MEDIUM=$(echo "$SCAN_RESULT" | jq '[.[].vulnerabilities[] | select(.severity | test("MEDIUM|moderate|medium"; "i"))] | length' 2>/dev/null || echo 0)

##############################################################################
# Output
##############################################################################

jq -n \
  --arg scanner "$SCANNER" \
  --arg scan_status "$SCAN_STATUS" \
  --arg scan_reason "${SCAN_REASON:-}" \
  --argjson vulnerabilities "$SCAN_RESULT" \
  --argjson vuln_count "$VULN_COUNT" \
  --argjson critical "$CRITICAL" \
  --argjson high "$HIGH" \
  --argjson medium "$MEDIUM" \
  --argjson has_security_policy "$HAS_SECURITY_POLICY" \
  '{
    status: $scan_status,
    reason: (if $scan_reason != "" then $scan_reason else null end),
    scanner: $scanner,
    summary: {
      total_vulnerable_packages: $vuln_count,
      critical: $critical,
      high: $high,
      medium: $medium
    },
    has_security_policy: $has_security_policy,
    vulnerabilities: $vulnerabilities
  }'

echo "Done." >&2
