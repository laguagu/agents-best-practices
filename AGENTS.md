# Agent Instructions

This repository contains best practices and templates for the `.agents/skills/` ecosystem.

## Structure

- `templates/` — Starter templates (AGENTS.md, CLAUDE.md, GEMINI.md, SKILL.md)
- `docs/` — Guides and reference documentation
- `examples/` — Example skills for learning and testing
- `.agents/skills/` — Working skills (improving-skills)

## Conventions

- Use forward slashes in all paths (`scripts/helper.py` not `scripts\helper.py`)
- Keep SKILL.md under 500 lines; use `references/` only when it reduces bloat
- Pin dependency versions in scripts (`npx eslint@9.0.0`, `uv run ruff@0.8.0`)
- Write descriptions in third person with explicit trigger contexts
- Every skill must pass: name matches directory, description under 1024 chars

## Gotchas

- `examples/bad-skill/` is intentionally flawed — do NOT fix it, it's test data for improving-skills audits
- This repo is a governance/best-practices resource, not a skill collection — it practices what it preaches

## When Editing Skills

1. Read the current SKILL.md before making changes
2. Run the improving-skills audit after changes
3. Verify description stays under 1024 characters
4. Test trigger accuracy with at least 3 manual prompts
5. Ensure all referenced files exist

## File Decisions

- Persistent, broad rule (style, testing, deploy) goes in AGENTS.md / CLAUDE.md
- On-demand expertise, workflow, checklist goes in a skill
- If AGENTS.md grows past 100 lines, move specialized content to skills
