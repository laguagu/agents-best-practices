# Agent-Friendly Scripts Guide

How to write scripts that agents can run reliably.

## When to Bundle a Script

Bundle a script when:
- The agent independently reinvents the same logic across runs
- A task requires deterministic behavior (not LLM judgment)
- External tools need specific flags or configuration
- You want structured, parseable output

Don't bundle when:
- A one-liner command suffices (`npx eslint@9.0.0 .`)
- The logic is simple enough to describe in SKILL.md instructions

## Script Requirements

### Non-interactive (hard requirement)

Agents can't respond to TTY prompts. Accept all input via:
- Command-line flags
- Environment variables
- Stdin (piped data)

```python
# Bad — blocks waiting for input
answer = input("Continue? (y/n): ")

# Good — flag-based
parser.add_argument("--yes", action="store_true", help="Skip confirmation")
```

### Include --help

The primary way agents learn a script's interface:

```
Usage: validate.sh [OPTIONS] <skill-path>

Validates a skill against the agentskills.io specification.

Options:
  --strict     Treat warnings as errors
  --json       Output results as JSON
  -h, --help   Show this help message
```

### Structured Output

- Data to stdout (JSON, CSV, TSV)
- Diagnostics to stderr
- Meaningful exit codes (0 = success, 1 = validation failure, 2 = usage error)

```python
# Good — structured output
import json, sys

results = {"passed": 5, "failed": 1, "warnings": 2}
json.dump(results, sys.stdout, indent=2)

# Diagnostics go to stderr
print("Processing 6 checks...", file=sys.stderr)
```

### Pin Dependencies

```bash
# Bad — behavior changes over time
pip install pypdf
npx eslint .

# Good — reproducible
pip install pypdf==4.1.0
npx eslint@9.0.0 .
uv run ruff@0.8.0 check .
```

### Error Messages

Tell the agent what went wrong, what was expected, and what to try:

```python
# Bad
raise FileNotFoundError()

# Good
print(f"Error: {path} not found. Expected a SKILL.md file.", file=sys.stderr)
print(f"Try: ls {path.parent} to check available files", file=sys.stderr)
sys.exit(1)
```

## One-off Commands (No Bundling)

For commands you run once, prefer package runners:

| Language | Runner | Example |
|----------|--------|---------|
| Python | `uv run` / `pipx run` | `uv run ruff@0.8.0 check .` |
| JavaScript | `npx` | `npx eslint@9.0.0 .` |
| Deno | `deno run` | `deno run npm:prettier@3.0.0 .` |
| Go | `go run` | `go run golang.org/x/tools/cmd/goimports@latest .` |

State prerequisites in SKILL.md and the `compatibility` frontmatter field.

## Idempotency

Scripts should be safe to run multiple times:

```python
# Bad — fails on second run
os.mkdir(output_dir)

# Good — idempotent
os.makedirs(output_dir, exist_ok=True)
```

## Dry-Run Support

For destructive operations, add a `--dry-run` flag:

```bash
# Show what would change without making changes
./scripts/migrate.sh --dry-run

# Actually make changes
./scripts/migrate.sh --execute
```
