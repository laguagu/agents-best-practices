---
name: improving-skills
argument-hint: "[skill-path or skill-name]"
description: >
  Audit and improve existing agent skills against the agentskills.io specification
  and current best practices. Also audits CLAUDE.md, GEMINI.md, and AGENTS.md for
  bloat and configuration issues. Guides migration from client-specific folders to
  .agents/skills/ structure. Use when reviewing skill quality, checking specification
  compliance, optimizing descriptions for better triggering, identifying anti-patterns,
  upgrading skills to follow latest standards, or auditing agent instruction files.
  Activates on: "audit skills", "review my skill", "improve skill", "check skill
  quality", "skill audit", "fix skill description", "skill compliance", "check
  CLAUDE.md", "audit AGENTS.md", even if the user does not explicitly mention
  "audit" or "best practices".
---

# Improving Skills — Audit & Optimization Guide

Structured workflow for auditing and improving agent skills, instruction files
(AGENTS.md, CLAUDE.md, GEMINI.md), and cross-platform compatibility.

## Quick audit (5 minutes)

1. **Read** the skill's SKILL.md and list all files in the directory
2. **Check frontmatter** against the specification (Step 2 below)
   Automated: run `skills-ref validate <skill-path>` if installed (reference
   implementation for demonstration — [agentskills/skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref)).
3. **Evaluate description** quality (trigger coverage, third person, specificity)
4. **Scan content** for anti-patterns (see [anti-patterns.md](anti-patterns.md))
5. **Generate** a prioritized improvement report (Step 5 template)

## Full audit workflow

### Step 1: Inventory the skill

Read the complete skill directory structure and all files.

Record:
- Total files and directories
- SKILL.md line count
- Number of reference files and scripts
- Any unusual files or structures

### Step 2: Specification compliance

If `skills-ref` is installed, run `skills-ref validate <skill-path>` first to catch
mechanical violations automatically. Focus manual review on description quality and content.

#### Frontmatter validation
- [ ] `name` field:
  - 1–64 characters, lowercase a-z/0-9/hyphens
  - No leading/trailing/consecutive hyphens
  - Matches parent directory name exactly
- [ ] `description` field:
  - 1–1024 characters, non-empty
  - Third person, imperative framing
  - Describes what the skill does AND when to use it
  - Includes trigger keywords and non-obvious activation contexts
- [ ] Optional fields (if present):
  - `argument-hint` — shown in skill list, helps users provide input
  - `compatibility` — 1–500 chars, platform/environment requirements
  - `allowed-tools` — space-separated pre-approved tools
  - `license` — reasonable format
  - `metadata` — string key-value pairs

#### Structure validation
- [ ] SKILL.md exists at skill root
- [ ] SKILL.md body under 500 lines (~5,000 tokens)
- [ ] File references use relative paths with forward slashes
- [ ] All referenced files actually exist
- [ ] No deeply nested reference chains (A → B → C)
- [ ] `references/` is opt-in (not empty placeholder directories)

### Step 3: Description quality assessment

The description is the routing key — it determines whether the skill triggers.

#### Trigger coverage
- [ ] Specific keywords users would say
- [ ] Non-obvious trigger contexts ("even if they don't mention X")
- [ ] Concrete use cases, not abstract capabilities
- [ ] Distinguishes this skill from adjacent/similar skills

#### Writing quality
- [ ] Third person only ("Processes files" not "I process files")
- [ ] Imperative framing ("Use when...")
- [ ] Focused on user intent, not implementation details
- [ ] "Pushy" enough — agents tend to under-trigger

#### Common description problems

| Problem | Example | Fix |
|---------|---------|-----|
| Too vague | "Helps with documents" | "Extracts text from PDFs, fills forms. Use when..." |
| First person | "I can help you..." | "Processes files and generates..." |
| No trigger context | "PDF text extraction" | Add "Use when... even if they don't mention..." |
| Too broad | "Handles all data tasks" | Narrow to specific capabilities |
| Missing keywords | Only mentions "CSV" | Add "tabular data", "spreadsheet", "Excel", "TSV" |

#### Scoring (1–5)
- **5**: Specific, pushy, great keyword coverage, clear trigger contexts
- **4**: Good but missing one or two trigger contexts
- **3**: Adequate but could be more specific or pushy
- **2**: Vague or missing trigger contexts
- **1**: Too generic, wrong person, or misleading

### Step 4: Content quality review

#### Conciseness
- [ ] No explanations of things the agent already knows
- [ ] No redundant general concepts (what PDFs are, how HTTP works)
- [ ] Every piece of content justifies its token cost
- [ ] Instructions in imperative form ("Run X", "Check Y")

#### Progressive disclosure
- [ ] Core instructions in SKILL.md, detailed reference in separate files
- [ ] References clearly signposted with "when to read" guidance
- [ ] Large reference files (>100 lines) have table of contents
- [ ] `references/` used only when it genuinely reduces SKILL.md bloat

#### Specificity calibration
- [ ] High-freedom for flexible tasks (reviews, writing)
- [ ] Low-freedom for fragile operations (migrations, destructive ops)
- [ ] Reasoning explained ("Do X because Y") rather than rigid "ALWAYS/NEVER"

#### Anti-patterns (quick scan)
See [anti-patterns.md](anti-patterns.md) for full list.

- [ ] No time-sensitive information (dates, versions that go stale)
- [ ] Consistent terminology throughout
- [ ] No Windows-style backslash paths
- [ ] No unexplained magic constants
- [ ] Defaults provided (not menus of equal options)
- [ ] If skill has scripts: errors handled explicitly, not punted to agent
- [ ] Validation loops present for critical operations

### Step 5: Generate improvement report

```markdown
# Skill Audit Report: [skill-name]

## Summary
- Specification compliance: [PASS/FAIL with count]
- Description quality: [score/5]
- Content quality: [HIGH/MEDIUM/LOW]
- Cross-platform: [status]
- Overall: [number] issues found

## Critical issues (fix immediately)
1. [Issue]: [What's wrong] → [How to fix]

## Recommended improvements
1. [Issue]: [What's wrong] → [How to fix]

## Minor suggestions
1. [Suggestion]

## Description recommendation
Current:
> [current description]

Suggested:
> [improved description]
```

## Batch audit

Default target: `~/.agents/skills/` (user-scope global skills).
For repo-scope: `.agents/skills/` relative to project root.

1. List all skill directories in the target path
2. Run Quick Audit (Steps 1–5) for each skill
3. Compile summary table:

```markdown
| Skill | Spec | Description | Content | Issues |
|-------|------|-------------|---------|--------|
| skill-a | PASS | 4/5 | HIGH | 1 |
| skill-b | FAIL | 2/5 | LOW | 5 |
```

4. Prioritize fixes across all skills by impact

## Instruction file audit

Audit agent instruction files (AGENTS.md, CLAUDE.md, GEMINI.md, CODEX.md, etc.)
for quality and consistency. These rules apply universally — every instruction file
follows the same principles regardless of platform.

### Universal checklist
- [ ] Exists and is not empty
- [ ] Under ~100 lines (move specialized content to skills if longer)
- [ ] Concise — every line must pass: "Would removing this cause mistakes?" If not, cut it
- [ ] Contains only rules agents can't infer from code
- [ ] No content that should be a skill (workflows, checklists, multi-step procedures)
- [ ] Gotchas section present (highest-value content)
- [ ] No stale information (outdated commands, removed tools)
- [ ] No rigid ALWAYS/NEVER without reasoning
- [ ] If agent ignores a rule → file is probably too long, not the rule too weak
- [ ] If agent asks questions answered in the file → phrasing may be ambiguous
- [ ] Emphasis (`IMPORTANT`, `YOU MUST`) used sparingly for critical rules

### Should include
- Shell commands the agent can't guess
- Code style rules that differ from defaults
- Testing instructions and preferred runners
- Repo etiquette (branch naming, PR conventions)
- Architecture decisions specific to the project
- Dev environment quirks (required env vars)
- Common gotchas and non-obvious behaviors

### Should NOT include
- Anything the agent can figure out by reading code
- Standard language conventions the agent already knows
- Detailed API documentation (link to docs instead)
- Information that changes frequently
- Long explanations or tutorials
- File-by-file descriptions of the codebase
- Self-evident practices like "write clean code"

### Platform-specific adapters
- [ ] AGENTS.md is the canonical, vendor-neutral instruction file
- [ ] Adapters (CLAUDE.md, GEMINI.md, etc.) import shared instructions
      via `@`-imports (e.g., `@AGENTS.md`) and add only platform-specific rules
- [ ] No duplicated content across files — shared rules belong in AGENTS.md

### Skills vs. instruction files
Instruction files load every session. Skills load on demand.
- Persistent broad rule (style, testing, deploy) → instruction file
- On-demand expertise, workflow, checklist → skill
- Content only relevant sometimes → skill (not instruction file)
- If instruction file grows past ~100 lines → migrate workflows to skills

## Cross-agent compatibility review

### Platform support (`~/.agents/skills/` standard)

| Platform | Repo scope | User scope |
|----------|-----------|------------|
| Claude Code | `.agents/skills/` | `~/.agents/skills/`, `~/.claude/skills/` |
| OpenAI Codex | `.agents/skills/` | `~/.agents/skills/` |
| Gemini CLI | `.agents/skills/` | `~/.agents/skills/`, `~/.gemini/skills/` |
| VS Code Copilot | `.agents/skills/` | Per config |
| Cursor | `.agents/skills/` | Per config |
| JetBrains | `.agents/skills/` | Per IDE config |

### Compatibility checklist
- [ ] Forward slashes in all paths
- [ ] Prerequisites stated explicitly
- [ ] MCP tools use fully qualified names (`Server:tool_name`)
- [ ] Dependency versions pinned
- [ ] No interactive prompts in scripts
- [ ] No platform-specific assumptions without `compatibility` field

### Migration: client-specific → `.agents/`
If skills exist in legacy client-specific paths (`~/.claude/skills/`, `~/.gemini/skills/`):
1. Move to `~/.agents/skills/`
2. Create symlinks/junctions from old locations if needed
3. Verify skills load on each target platform

## Description optimization

The description is the routing key. At startup agents load only `name` + `description`
(~50-100 tokens each). Write in third person, imperative framing ("Use when..."),
be pushy about trigger contexts, stay under 1024 characters.

For descriptions scoring < 4/5, run an optimization loop:
1. Create 20 eval queries (10 should-trigger, 10 should-not-trigger)
2. Split 60% train / 40% validation — run each query 3 times (nondeterministic)
3. Iterate on train set failures, revise description (up to 5 iterations)
4. Select best by **validation** score to avoid overfitting

Watch for overfitting: train improving but validation dropping, description
growing toward 1024 chars, specific test keywords leaking into description.

## Gotchas

- `description` has a hard cap of 1024 characters — count characters before saving when writing long descriptions
- `name` must match the directory name exactly — uppercase letters, underscores, or spaces break discovery
- In batch audits, `~/.agents/skills/` is the user-scope default, `.agents/skills/` is repo-scope — don't mix them up
- Symlinks from `.claude/skills/` → `.agents/skills/` can cause duplicate discovery reports
- Instruction file audit (AGENTS.md/CLAUDE.md) is a separate workflow from skill audit — don't combine them into the same report
- `allowed-tools` is marked Experimental in the spec — don't add routinely, support varies across platforms
- **Root `skills/` breaks discovery**: Moving project skills from `.agents/skills/` to a root `skills/` directory breaks Claude Code `/skills` discovery and Codex auto-discovery — both scan `.agents/skills/` (repo scope) directly. Root `skills/` only works as AGENTS.md `@include` context, not as a discoverable/invokable skill. Keep skills in `.agents/skills/<name>/`. To auto-load a skill every session, add `@.agents/skills/<name>/SKILL.md` to AGENTS.md.
- **Verify behavioral claims against official docs/source before editing** — truncation behavior, deprecation status, experimental flags, and token budgets must come from specs, READMEs, or source code, not from inference or plausibility. When docs are silent on a behavior, preserve the original wording rather than invent it. A plausible-sounding claim that rots later is worse than no claim.

## Iterating after audit

1. Fix **critical issues** first (specification violations, broken triggers)
2. Rewrite description if score < 4/5
3. Address **recommended improvements** (anti-patterns, content quality)
4. Re-run quick audit to verify fixes
5. If description was rewritten, run trigger eval to confirm improvement

The goal is reliable triggering, specification compliance, and clear value
without wasting context tokens.
