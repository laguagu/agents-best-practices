# Agent Skills Best Practices 🤖

> Vendor-neutral best practices for the `.agents/skills/` ecosystem — the cross-platform standard for AI agent skills.

## What is `.agents/skills/`? 📂

A directory convention where AI agent skills live as self-contained packages.

```
.agents/skills/my-skill/
├── SKILL.md          # Required: metadata + instructions
├── scripts/          # Optional: executable code
└── references/       # Optional: supplementary docs (opt-in, not default)
```

Supported by **Claude Code**, **OpenAI Codex**, **Gemini CLI**, **VS Code Copilot**, **Cursor**, and **JetBrains**.

## What's in This Repo 🗂️

### Skills

- **improving-skills** — Audits skills against the [agentskills.io](https://agentskills.io) spec: frontmatter, description quality, anti-patterns, cross-platform compatibility. Also audits AGENTS.md and CLAUDE.md for bloat.
- **skill-creator** — Creates new skills through a draft-test-iterate workflow.

### Templates

Starter files to copy into your project:
- `templates/SKILL.md` — Skill template with frontmatter and body structure
- `templates/AGENTS.md` — Project instruction template (canonical, vendor-neutral)
- `templates/CLAUDE.md` — Claude Code adapter (`@AGENTS.md` import)

## Installing Skills 🛠️

Drop a skill directory at one of these paths. Agents discover it automatically.

| Scope | Path | Platforms |
|---|---|---|
| **Repo** (team-wide, committed) | `.agents/skills/<name>/` | Claude Code, Codex, Gemini CLI |
| **User** (global, vendor-neutral) | `~/.agents/skills/<name>/` | All agentskills.io-compatible tools |
| **User** (per-platform) | `~/.claude/skills/`, `~/.gemini/skills/` | Platform-specific alternatives |

### Try this repo's skills

```bash
git clone https://github.com/laguagu/agents-best-practices.git
cp -r agents-best-practices/.agents/skills/improving-skills ~/.agents/skills/
cp -r agents-best-practices/.agents/skills/skill-creator ~/.agents/skills/
```

Then invoke in any compatible agent — e.g. `/improving-skills <skill-path>` in Claude Code, or `$improving-skills` in Codex.

## Key Principles ✨

1. **🔑 Description is the routing key** — write trigger conditions, not summaries
2. **📦 Progressive disclosure** — name + description at startup; full body on activation
3. **⚖️ Every token must justify its cost** — don't explain what agents already know
4. **🏗️ Flat by default** — `SKILL.md` + `scripts/` if needed. `references/` is opt-in
5. **🔄 Gather, Act, Verify** — read files, take action, check your work
6. **🎯 Defaults over menus** — pick one approach, mention alternatives briefly

## References 📚

- [agentskills.io](https://agentskills.io) — Specification and best practices
- [agents.md](https://agents.md) — AGENTS.md specification
- [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref) — Validation tool
- [Claude Code — skills](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) | [Codex — skills](https://developers.openai.com/codex/skills) | [Gemini CLI — skills](https://geminicli.com/docs/cli/skills/)
- [mgechev/skills-best-practices](https://github.com/mgechev/skills-best-practices) | [openai/skills](https://github.com/openai/skills)

## License

Apache-2.0 — see [LICENSE](LICENSE)
