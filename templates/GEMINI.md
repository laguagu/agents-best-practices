# Gemini CLI Instructions

<!-- This is an ADAPTER for Gemini CLI. The canonical project instructions
     live in AGENTS.md. This file adds Gemini-specific conventions only. -->

## Shared Instructions

See AGENTS.md for project conventions (code style, testing, PRs, gotchas).

## Gemini-Specific

<!-- Gemini CLI discovery paths -->
- Skills are in `.agents/skills/` (standard) and `.gemini/skills/` (Gemini-specific)
- Use `/skills list` to see available skills
- Use `/skills enable <name>` to activate a skill for the session

<!-- Gemini-specific workflow notes -->
- Gemini CLI reads this file automatically from the project root
- For user-level instructions, place at `~/.gemini/GEMINI.md`

<!-- Override or extend AGENTS.md rules only when Gemini needs
     something different from other agents. Keep additions minimal. -->

<!-- TIP: If you're adding the same instructions to both GEMINI.md and
     CLAUDE.md, they belong in AGENTS.md instead. -->
