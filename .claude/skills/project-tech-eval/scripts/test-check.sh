#!/usr/bin/env bash
# Detects test framework, coverage config, and CI test matrix.
# Usage: test-check.sh <repo-path>
# Output: JSON to stdout

set -euo pipefail

REPO_PATH="${1:?Usage: test-check.sh <repo-path>}"
cd "$REPO_PATH"

echo "Checking test infrastructure in ${REPO_PATH}..." >&2

##############################################################################
# 1. Test framework detection
##############################################################################

echo "  Detecting test frameworks..." >&2

FRAMEWORKS=""

# Python
if find . -maxdepth 4 \( -name "test_*.py" -o -name "*_test.py" \) 2>/dev/null | grep -q .; then
  FRAMEWORKS="${FRAMEWORKS}\"pytest\","
fi
if [ -f "tox.ini" ]; then FRAMEWORKS="${FRAMEWORKS}\"tox\","; fi
if [ -f "noxfile.py" ]; then FRAMEWORKS="${FRAMEWORKS}\"nox\","; fi

# JavaScript / TypeScript
if [ -f "jest.config.js" ] || [ -f "jest.config.ts" ] || [ -f "jest.config.json" ] || \
   ([ -f "package.json" ] && (grep -q '"jest"' package.json 2>/dev/null || true)); then
  FRAMEWORKS="${FRAMEWORKS}\"jest\","
fi
if [ -f "vitest.config.ts" ] || [ -f "vitest.config.js" ]; then
  FRAMEWORKS="${FRAMEWORKS}\"vitest\","
fi
if [ -f ".mocharc.yml" ] || [ -f ".mocharc.json" ]; then
  FRAMEWORKS="${FRAMEWORKS}\"mocha\","
fi
if [ -f "cypress.config.js" ] || [ -f "cypress.config.ts" ] || [ -d "cypress" ]; then
  FRAMEWORKS="${FRAMEWORKS}\"cypress\","
fi
if [ -f "playwright.config.ts" ] || [ -f "playwright.config.js" ]; then
  FRAMEWORKS="${FRAMEWORKS}\"playwright\","
fi

# Go
if find . -maxdepth 4 -name "*_test.go" 2>/dev/null | grep -q .; then
  FRAMEWORKS="${FRAMEWORKS}\"go-test\","
fi

# Rust
if [ -f "Cargo.toml" ]; then
  RS_FILES=$(find . -name "*.rs" -maxdepth 4 2>/dev/null | head -20)
  if [ -n "$RS_FILES" ] && echo "$RS_FILES" | xargs grep -q '#\[cfg(test)\]\|#\[test\]' 2>/dev/null; then
    FRAMEWORKS="${FRAMEWORKS}\"cargo-test\","
  fi
fi

# C++ / C
if find . -maxdepth 4 -name "*test*" -name "CMakeLists.txt" 2>/dev/null | grep -q .; then
  FRAMEWORKS="${FRAMEWORKS}\"ctest\","
fi
if (grep -rq 'gtest\|gmock\|google.*test' --include='*.cmake' --include='CMakeLists.txt' . 2>/dev/null || true) && \
   (grep -rl 'gtest\|gmock\|google.*test' --include='*.cmake' --include='CMakeLists.txt' . 2>/dev/null | grep -q . || false); then
  FRAMEWORKS="${FRAMEWORKS}\"googletest\","
fi
if (grep -rl 'catch2\|Catch2' --include='*.cmake' --include='CMakeLists.txt' --include='*.cpp' . 2>/dev/null || true) | grep -q .; then
  FRAMEWORKS="${FRAMEWORKS}\"catch2\","
fi

# Robot Framework
if find . -maxdepth 4 -name "*.robot" 2>/dev/null | grep -q .; then
  FRAMEWORKS="${FRAMEWORKS}\"robot-framework\","
fi

FRAMEWORKS="[${FRAMEWORKS%,}]"

##############################################################################
# 2. Test file count and types
##############################################################################

echo "  Counting test files..." >&2

UNIT_TESTS=$(find . -maxdepth 6 \( -name "test_*.py" -o -name "*_test.py" -o -name "*_test.go" \
  -o -name "*.test.ts" -o -name "*.test.js" -o -name "*.spec.ts" -o -name "*.spec.js" \
  -o -name "*Test.java" -o -name "*_test.rs" \) \
  -not -path '*/node_modules/*' -not -path '*/vendor/*' -not -path '*/.venv/*' \
  2>/dev/null | wc -l | tr -d ' ')

INTEGRATION_TESTS=$(find . -maxdepth 6 \( -path '*/integration/*' -o -path '*/e2e/*' -o -path '*/acceptance/*' \) \
  \( -name "*.py" -o -name "*.go" -o -name "*.ts" -o -name "*.js" -o -name "*.java" \) \
  -not -path '*/node_modules/*' -not -path '*/vendor/*' \
  2>/dev/null | wc -l | tr -d ' ')

# Test directory structure
TEST_DIRS=$(find . -maxdepth 4 -type d \( -name "test" -o -name "tests" -o -name "__tests__" \
  -o -name "test_*" -o -name "*_test" -o -name "e2e" -o -name "integration" \
  -o -name "fixtures" -o -name "testdata" \) \
  -not -path '*/node_modules/*' -not -path '*/vendor/*' \
  2>/dev/null | head -20 | jq -R -s 'split("\n") | map(select(length > 0))' 2>/dev/null || echo '[]')

##############################################################################
# 3. Coverage configuration
##############################################################################

echo "  Checking coverage configuration..." >&2

HAS_COVERAGE_CONFIG=false
COVERAGE_TOOL="none"

# Python
if [ -f ".coveragerc" ]; then
  HAS_COVERAGE_CONFIG=true
  COVERAGE_TOOL="coverage.py"
elif [ -f "pyproject.toml" ] && (grep -q '\[tool\.coverage\]\|\[tool\.pytest\.ini_options\]' pyproject.toml 2>/dev/null || false); then
  HAS_COVERAGE_CONFIG=true
  COVERAGE_TOOL="coverage.py"
fi

# Node
if [ -f ".nycrc" ] || [ -f ".nycrc.json" ] || [ -f ".c8rc" ]; then
  HAS_COVERAGE_CONFIG=true
  COVERAGE_TOOL="nyc/c8"
elif [ -f "package.json" ] && (grep -q '"c8"\|"nyc"\|"istanbul"\|--coverage' package.json 2>/dev/null || false); then
  HAS_COVERAGE_CONFIG=true
  COVERAGE_TOOL="nyc/c8"
fi

# Go
if [ -d ".github/workflows" ] && (grep -rq 'cover\|coverage' .github/workflows/ 2>/dev/null || false); then
  HAS_COVERAGE_CONFIG=true
  COVERAGE_TOOL="go-cover"
fi

# Codecov / Coveralls integration
HAS_CODECOV=false
if [ -f "codecov.yml" ] || [ -f ".codecov.yml" ]; then
  HAS_CODECOV=true
elif [ -d ".github/workflows" ] && (grep -rq 'codecov\|coveralls' .github/workflows/ 2>/dev/null || false); then
  HAS_CODECOV=true
fi

##############################################################################
# 4. CI test matrix
##############################################################################

echo "  Analyzing CI test matrix..." >&2

CI_TEST_MATRIX="[]"
TESTS_IN_CI=0
if [ -d ".github/workflows" ]; then
  CI_TEST_MATRIX=$( (grep -A 20 'strategy:' .github/workflows/*.yml .github/workflows/*.yaml 2>/dev/null || true) | \
    (grep -oE '(python|node|go)-version:.*' || true) | \
    head -5 | jq -R -s 'split("\n") | map(select(length > 0))' 2>/dev/null || echo '[]')

  TESTS_IN_CI=$( (grep -rl 'pytest\|npm test\|go test\|cargo test\|jest\|vitest\|ctest' \
    .github/workflows/ 2>/dev/null || true) | wc -l | tr -d ' ')
fi

##############################################################################
# 5. Test quality signals
##############################################################################

# Fixtures / test data
HAS_FIXTURES=$(find . -maxdepth 4 -type d \( -name "fixtures" -o -name "testdata" -o -name "test_data" \
  -o -name "__fixtures__" -o -name "mocks" \) \
  -not -path '*/node_modules/*' -not -path '*/vendor/*' \
  2>/dev/null | wc -l | tr -d ' ')

# Property-based testing
HAS_PROPERTY_TESTS=false
if (grep -rl 'hypothesis\|quickcheck\|proptest\|fast-check\|jsverify' \
  --include='*.py' --include='*.rs' --include='*.js' --include='*.ts' \
  -not -path '*/node_modules/*' -not -path '*/vendor/*' . 2>/dev/null || true) | grep -q .; then
  HAS_PROPERTY_TESTS=true
fi

# Benchmark tests
HAS_BENCHMARKS=false
if find . -maxdepth 4 \( -name "*bench*" -o -name "*benchmark*" \) \
  \( -name "*.py" -o -name "*.go" -o -name "*.rs" -o -name "*.js" -o -name "*.ts" \) \
  -not -path '*/node_modules/*' 2>/dev/null | grep -q .; then
  HAS_BENCHMARKS=true
fi

##############################################################################
# Output
##############################################################################

jq -n \
  --argjson frameworks "$FRAMEWORKS" \
  --argjson unit_test_files "$UNIT_TESTS" \
  --argjson integration_test_files "$INTEGRATION_TESTS" \
  --argjson test_dirs "$TEST_DIRS" \
  --argjson has_coverage_config "$HAS_COVERAGE_CONFIG" \
  --arg coverage_tool "$COVERAGE_TOOL" \
  --argjson has_codecov "$HAS_CODECOV" \
  --argjson ci_test_matrix "$CI_TEST_MATRIX" \
  --argjson tests_in_ci "${TESTS_IN_CI}" \
  --argjson has_fixtures "$HAS_FIXTURES" \
  --argjson has_property_tests "$HAS_PROPERTY_TESTS" \
  --argjson has_benchmarks "$HAS_BENCHMARKS" \
  '{
    status: "ok",
    frameworks: $frameworks,
    test_files: {
      unit: $unit_test_files,
      integration: $integration_test_files,
      total: ($unit_test_files + $integration_test_files)
    },
    test_dirs: $test_dirs,
    coverage: {
      configured: $has_coverage_config,
      tool: $coverage_tool,
      reporting_service: $has_codecov
    },
    ci_integration: {
      tests_in_ci: $tests_in_ci,
      matrix: $ci_test_matrix
    },
    quality_signals: {
      fixture_dirs: $has_fixtures,
      property_based_testing: $has_property_tests,
      benchmarks: $has_benchmarks
    }
  }'

echo "Done." >&2
