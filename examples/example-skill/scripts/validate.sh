#!/usr/bin/env bash
set -euo pipefail

# Config Validator — checks project configuration files for common issues
# Usage: validate.sh [OPTIONS] <project-path>

show_help() {
  cat <<'HELP'
Usage: validate.sh [OPTIONS] <project-path>

Validates project configuration files for common mistakes.

Options:
  --strict     Treat warnings as errors (exit 1 on warnings)
  --json       Output results as JSON (default: human-readable)
  -h, --help   Show this help message

Examples:
  validate.sh ./my-project
  validate.sh --json --strict /path/to/project
HELP
}

STRICT=false
JSON=false
PROJECT_PATH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --strict) STRICT=true; shift ;;
    --json)   JSON=true; shift ;;
    -h|--help) show_help; exit 0 ;;
    -*) echo "Error: Unknown option $1" >&2; show_help >&2; exit 2 ;;
    *)  PROJECT_PATH="$1"; shift ;;
  esac
done

if [[ -z "$PROJECT_PATH" ]]; then
  echo "Error: Project path is required." >&2
  echo "Try: validate.sh --help" >&2
  exit 2
fi

if [[ ! -d "$PROJECT_PATH" ]]; then
  echo "Error: $PROJECT_PATH is not a directory." >&2
  exit 1
fi

errors=0
warnings=0
checked=()

# Check package.json
if [[ -f "$PROJECT_PATH/package.json" ]]; then
  checked+=("package.json")
  echo "Checking package.json..." >&2
  # Add actual validation logic here
else
  warnings=$((warnings + 1))
  echo "Warning: No package.json found" >&2
fi

# Check tsconfig.json
if [[ -f "$PROJECT_PATH/tsconfig.json" ]]; then
  checked+=("tsconfig.json")
  echo "Checking tsconfig.json..." >&2
else
  echo "Info: No tsconfig.json (not a TypeScript project)" >&2
fi

if $JSON; then
  printf '{"errors": %d, "warnings": %d, "checked": [%s]}\n' \
    "$errors" "$warnings" \
    "$(printf '"%s",' "${checked[@]}" | sed 's/,$//')"
else
  echo "Results: $errors errors, $warnings warnings"
  echo "Checked: ${checked[*]}"
fi

if [[ $errors -gt 0 ]]; then
  exit 1
elif $STRICT && [[ $warnings -gt 0 ]]; then
  exit 1
fi
