# Agent Instructions

This repository contains best practices for the `.agents/skills/` ecosystem.

## Structure

- `.agents/skills/` — Working skills (improving-skills, skill-creator, skill-finder)

## Conventions

- Use forward slashes in all paths (`scripts/helper.py` not `scripts\helper.py`)
- Keep SKILL.md under 500 lines; use `references/` only when it reduces bloat
- Pin dependency versions in scripts (`npx eslint@9.0.0`, `uv run ruff@0.8.0`)
- Write descriptions in third person with explicit trigger contexts
- Every skill must pass: name matches directory, description under 1024 chars

## Gotchas

- This repo is a governance/best-practices resource — it practices what it preaches
- Skills must be self-contained — no references to files outside the skill directory

## When Editing Skills

1. Read the current SKILL.md before making changes
2. Run the improving-skills audit after changes
3. Verify description stays under 1024 characters
4. Test trigger accuracy with at least 3 manual prompts
5. Ensure all referenced files exist
