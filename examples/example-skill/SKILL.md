---
name: example-skill
argument-hint: "[file or directory to validate]"
description: >
  Validates project configuration files for common mistakes. Checks
  package.json, tsconfig.json, and environment files for missing fields,
  version conflicts, and security issues. Use when setting up a new project,
  debugging configuration problems, or reviewing project health. Activates
  on: "validate config", "check project setup", "review configuration",
  "project health check", even if the user doesn't explicitly mention
  configuration files.
compatibility: "Claude Code, Codex, Gemini CLI — requires Node.js 18+"
---

# Config Validator

Validates project configuration files and reports issues.

## Quick Start

1. Run `scripts/validate.sh <project-path>` to check all config files
2. Review the JSON output for errors and warnings
3. Fix reported issues in priority order (errors first)

## What It Checks

- **package.json**: missing scripts, unlicensed dependencies, version conflicts
- **tsconfig.json**: strict mode disabled, missing compiler options
- **Environment files**: .env.example exists, no secrets in .env committed

## Gotchas

- The validator expects Node.js 18+ because it uses `fs.glob`
- `.env` files are checked for patterns that look like real secrets (API keys, tokens) — false positives are possible with example values
- Run from the project root, not a subdirectory

## Verification

After fixing issues, re-run the validator. A clean run produces:
```json
{"errors": 0, "warnings": 0, "checked": ["package.json", "tsconfig.json", ".env"]}
```
