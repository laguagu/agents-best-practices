# Cross-Platform Skill Compatibility

## The `.agents/skills/` Standard

`.agents/skills/` is the universal convention for AI agent skills. All major platforms support it.

### Discovery Paths

| Platform | Repo scope | User scope | Extra paths |
|----------|-----------|------------|-------------|
| **Claude Code** | `.agents/skills/` | `~/.agents/skills/`, `~/.claude/skills/` | |
| **OpenAI Codex** | `.agents/skills/` | `~/.agents/skills/` | `~/.codex/skills/.system/` |
| **Gemini CLI** | `.agents/skills/` | `~/.agents/skills/`, `~/.gemini/skills/` | |
| **VS Code Copilot** | `.agents/skills/` | Per config | Agent mode required |
| **Cursor** | `.agents/skills/` | Per config | |
| **JetBrains** | `.agents/skills/` | Per IDE config | |

### Precedence

Repo-scope skills override user-scope skills with the same name.

### Recommended Setup

Keep source of truth at `~/.agents/skills/`. Sync to platform-specific paths via:
- **Windows**: Directory junctions (`mklink /J target source`)
- **macOS/Linux**: Symlinks (`ln -s source target`)
- **Cross-platform**: Git + sync script

## Universal Compatibility Rules

1. **Forward slashes** in all paths: `scripts/helper.py` not `scripts\helper.py`
2. **State prerequisites** explicitly: `pip install pypdf==4.1.0` not "use the pdf library"
3. **Qualified MCP names**: `BigQuery:bigquery_schema` not just `bigquery_schema`
4. **Pin dependency versions**: `npx eslint@9.0.0`, `uv run ruff@0.8.0`
5. **No interactive prompts**: agents use non-interactive shells
6. **Structured output**: JSON/CSV to stdout, diagnostics to stderr

## Platform-Specific Notes

### Claude Code
- Reads SKILL.md body and references via file tools
- Supports `allowed-tools` frontmatter field
- Skills activate via description matching or `/skill-name` command
- `argument-hint` field shown in skill list

### OpenAI Codex
- Three tiers: `.system` (auto), `.curated` (manual), `.experimental`
- Install curated skills: `$skill-installer skill-name`
- Activate explicitly: `$skill-name` or implicitly via description matching
- Optional `agents/openai.yaml` for Codex-specific config

### Gemini CLI
- Three scopes: workspace, user, extension
- Interactive management: `/skills list`, `/skills enable`, `/skills link`
- Terminal commands: `gemini skills install/uninstall`
- Requests user approval before activating skills

## Migration Guide

### From client-specific to `.agents/`

If you have skills in `~/.claude/skills/` or `~/.codex/skills/`:

1. Move skill directories to `~/.agents/skills/`
2. Create symlinks/junctions from old locations:
   ```bash
   # macOS/Linux
   ln -s ~/.agents/skills/my-skill ~/.claude/skills/my-skill

   # Windows (run as admin or with developer mode)
   cmd /c 'mklink /J "%USERPROFILE%\.claude\skills\my-skill" "%USERPROFILE%\.agents\skills\my-skill"'
   ```
3. Verify skills load on each platform
4. Remove old copies once symlinks confirmed working

### From AGENTS.md to skills

If your AGENTS.md has grown too large:

1. Identify sections that are workflows, not rules
2. Create `.agents/skills/<name>/SKILL.md` for each workflow
3. Remove the section from AGENTS.md
4. Add a one-line note: "For [topic], the agent will load the [name] skill"
