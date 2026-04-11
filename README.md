# `.agents`-First Best Practices 🤖

> Vendor-neutral best practices for the `.agents/skills/` ecosystem — the cross-platform standard for AI agent skills.

## What is `.agents/skills/`? 📂

A directory convention where AI agent skills live as self-contained packages. Each skill is a folder with a `SKILL.md` file containing YAML metadata and instructions.

```
.agents/
  skills/
    my-skill/
      SKILL.md          # Required: metadata + instructions
      scripts/           # Optional: executable code
      references/        # Optional: supplementary docs (opt-in, not default)
```

## Platform Support 🌐

| Platform | Repo scope | User scope | Status |
|----------|-----------|------------|--------|
| **Claude Code** | `.agents/skills/` | `~/.agents/skills/`, `~/.claude/skills/` | Supported |
| **OpenAI Codex** | `.agents/skills/` | `~/.agents/skills/` | Supported |
| **Gemini CLI** | `.agents/skills/` | `~/.agents/skills/`, `~/.gemini/skills/` | Supported |
| **VS Code Copilot** | `.agents/skills/` | Per config | Agent mode |
| **Cursor** | `.agents/skills/` | Per config | Supported |
| **JetBrains** | `.agents/skills/` | Per IDE config | Supported |

## The Instruction File Hierarchy 📋

| File | Role | When to use |
|------|------|-------------|
| **AGENTS.md** | Canonical project instructions | Persistent, broad rules (style, testing, deployment) |
| **Skills** | On-demand specialized workflows | Complex procedures, checklists, domain expertise |
| **CLAUDE.md** | Claude Code adapter | Claude-specific additions (imports with `@`) |
| **GEMINI.md** | Gemini CLI adapter | Gemini-specific additions |

> **Key principle:** AGENTS.md is the canonical source. CLAUDE.md and GEMINI.md are adapters that extend it — not independent instruction systems.

## What's in This Repo 🗂️

```
.agents/skills/
  improving-skills/    Audits skills and instruction files against the spec
  skill-creator/       Creates new skills through a draft-test-iterate loop
templates/             Starter templates for AGENTS.md, CLAUDE.md, GEMINI.md, SKILL.md
```

### Skills

**improving-skills** — Audit existing skills against [agentskills.io](https://agentskills.io) specification. Checks frontmatter compliance, description quality, content anti-patterns, and cross-platform compatibility. Also audits AGENTS.md, CLAUDE.md, and GEMINI.md for bloat.

**skill-creator** — Create new `.agents/skills/` skills through a structured workflow: capture intent, write SKILL.md, test with real prompts, iterate until satisfied.

### Templates

Starter files you can copy into your project:
- `templates/SKILL.md` — Full skill template with frontmatter and body structure
- `templates/AGENTS.md` — Project instruction template
- `templates/CLAUDE.md` — Claude Code adapter template
- `templates/GEMINI.md` — Gemini CLI adapter template

## Key Principles ✨

1. **🔑 Description is the routing key** — agents read it to decide what gets loaded. Write trigger conditions, not summaries
2. **📦 Progressive disclosure** — name + description load at startup; full body on activation; references on demand
3. **⚖️ Every token must justify its cost** — don't explain what agents already know
4. **🏗️ Flat by default** — `SKILL.md` + `scripts/` if needed. `references/` is opt-in
5. **🔄 Gather, Act, Verify** — read files, take action, check your work. Every time
6. **🎯 Defaults over menus** — pick one tool/approach, mention alternatives briefly

## References 📚

### Specifications
- [agentskills.io](https://agentskills.io) — Agent Skills specification and best practices
- [agents.md](https://agents.md) — AGENTS.md specification
- [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref) — Official validation tool

### Platform Documentation
- [Claude Code — skill best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
- [Claude Code — CLAUDE.md best practices](https://code.claude.com/docs/en/best-practices)
- [OpenAI Codex — skills](https://developers.openai.com/codex/skills)
- [Gemini CLI — skills](https://geminicli.com/docs/cli/skills/)

### Community
- [mgechev/skills-best-practices](https://github.com/mgechev/skills-best-practices) — Skill development guide
- [openai/skills](https://github.com/openai/skills) — Curated Codex skills

## License

Apache-2.0 — see [LICENSE](LICENSE)
