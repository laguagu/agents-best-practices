# Claude Code Instructions

<!-- This is an ADAPTER for Claude Code. The canonical project instructions
     live in AGENTS.md. This file adds Claude-specific conventions only.
     Import the shared instructions: -->

See @AGENTS.md for project conventions.

## Claude-Specific

<!-- @-imports for context files Claude should always see -->
See @README.md for project overview.
See @package.json for available commands.

<!-- Claude-specific workflow rules -->
- Run `/init` to generate a starter CLAUDE.md from your project
- Use skills (`.agents/skills/`) for domain knowledge, not this file
- Use `/clear` between unrelated tasks to manage context

<!-- Override or extend AGENTS.md rules only when Claude needs
     something different from other agents. Keep additions minimal. -->

<!-- TIP: CLAUDE.md is loaded every session. Every line costs context tokens.
     If you find yourself adding specialized workflows here, create a skill instead.
     Skills load on-demand without bloating every conversation. -->
