# `.agents`-First Best Practices

Vendor-neutral best practices for the `.agents/skills/` ecosystem — the cross-platform standard for AI agent skills.

## What is `.agents/skills/`?

A directory convention where AI agent skills live as self-contained packages. Each skill is a folder with a `SKILL.md` file containing YAML metadata and instructions.

```
.agents/
  skills/
    my-skill/
      SKILL.md          # Required: metadata + instructions
      scripts/           # Optional: executable code
      references/        # Optional: supplementary docs (opt-in, not default)
```

## Platform Support

| Platform | Repo scope | User scope | Status |
|----------|-----------|------------|--------|
| **Claude Code** | `.agents/skills/` | `~/.agents/skills/`, `~/.claude/skills/` | Supported |
| **OpenAI Codex** | `.agents/skills/` | `~/.agents/skills/` | Supported |
| **Gemini CLI** | `.agents/skills/` | `~/.agents/skills/`, `~/.gemini/skills/` | Supported |
| **VS Code Copilot** | `.agents/skills/` | Per config | Agent mode |
| **Cursor** | `.agents/skills/` | Per config | Supported |
| **JetBrains** | `.agents/skills/` | Per IDE config | Supported |

## The Instruction File Hierarchy

| File | Role | When to use |
|------|------|-------------|
| **AGENTS.md** | Canonical project instructions | Persistent, broad rules (style, testing, deployment) |
| **Skills** | On-demand specialized workflows | Complex procedures, checklists, domain expertise |
| **CLAUDE.md** | Claude Code adapter | Claude-specific additions (imports with `@`, skill conventions) |
| **GEMINI.md** | Gemini CLI adapter | Gemini-specific additions |

AGENTS.md is the canonical source. CLAUDE.md and GEMINI.md are adapters that extend it — not independent instruction systems. See [docs/skill-vs-instructions.md](docs/skill-vs-instructions.md) for the decision tree.

## Quick Start: Your First Skill

```yaml
---
name: my-skill
description: >
  What this skill does. Use when [specific trigger contexts].
  Activates on: "keyword1", "keyword2".
---

# My Skill

## Instructions
1. Do this first
2. Then do this

## Gotchas
- Non-obvious fact that prevents mistakes
```

Save as `.agents/skills/my-skill/SKILL.md`. See [templates/SKILL.md](templates/SKILL.md) for the full template.

## What's in This Repo

```
templates/     Starter templates for AGENTS.md, CLAUDE.md, GEMINI.md, SKILL.md
docs/          Guides on cross-platform support, trigger evaluation, scripts
examples/      Example skills (good and intentionally bad for testing)
.agents/       A working skill: improving-skills (audits other skills)
```

## Key Principles

1. **Description is the routing key** — agents read it to decide what gets loaded. Write trigger conditions, not summaries
2. **Progressive disclosure** — name + description load at startup; full body on activation; references on demand
3. **Every token must justify its cost** — don't explain what agents already know
4. **Flat by default** — `SKILL.md` + `scripts/` if needed. `references/` is opt-in
5. **Gather, Act, Verify** — read files, take action, check your work. Every time
6. **Defaults over menus** — pick one tool/approach, mention alternatives briefly

## References

- [agentskills.io](https://agentskills.io) — specification and best practices
- [agents.md](https://agents.md) — AGENTS.md specification
- [Claude skill best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
- [Codex skills](https://developers.openai.com/codex/skills)
- [Gemini CLI skills](https://geminicli.com/docs/cli/skills/)
- [mgechev/skills-best-practices](https://github.com/mgechev/skills-best-practices)
- [openai/skills](https://github.com/openai/skills)

## License

MIT
