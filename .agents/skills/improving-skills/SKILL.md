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
- [ ] Optional spec fields (if present):
  - `compatibility` — 1–500 chars, platform/environment requirements
  - `allowed-tools` — space-separated pre-approved tools (Experimental)
  - `license` — reasonable format
  - `metadata` — arbitrary key-value pairs (put `version` here, not at root)
- [ ] Client-specific extensions (not in agentskills.io spec — silently ignored by other clients):
  - `argument-hint` — Claude Code: shown in skill list, helps users provide input
  - `model` — Claude Code: pin a model (`opus | sonnet | haiku | inherit`)

#### Structure validation
- [ ] SKILL.md exists at skill root
- [ ] SKILL.md body under 500 lines (~5,000 tokens)
- [ ] File references use relative paths with forward slashes
- [ ] All referenced files actually exist
- [ ] No deeply nested reference chains (A → B → C)
- [ ] Flat layout preferred — supporting files (e.g. `anti-patterns.md`)
      live next to SKILL.md by default
- [ ] `references/` subdirectory used only when there are many files OR
      a separate `scripts/` folder already justifies subdirectory structure

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
- [ ] No boilerplate code the agent can write from first principles — specify
      the *contract* (what it must do) not a 30-line implementation
- [ ] Framework-level adapters (AI SDK, LangChain, etc.) referenced before
      showing custom implementations

#### Progressive disclosure
- [ ] Core instructions in SKILL.md, detailed reference in separate files
- [ ] References clearly signposted with "when to read" guidance
- [ ] Large reference files (>100 lines) have table of contents
- [ ] Flat layout by default (sibling files next to SKILL.md); only group
      under `references/` when there are many files or scripts/ already exists

#### Specificity calibration
- [ ] High-freedom for flexible tasks (reviews, writing)
- [ ] Low-freedom for fragile operations (migrations, destructive ops)
- [ ] Reasoning explained ("Do X because Y") rather than rigid "ALWAYS/NEVER"

#### Anti-patterns (quick scan)
See [anti-patterns.md](anti-patterns.md) for full list.

- [ ] No time-sensitive information (dates, versions that go stale)
- [ ] No pinned version numbers in fast-moving domains (ML models, SDK versions,
      pricing) — use categories with "examples (may change — verify)" labels
- [ ] No operational/billing setup (payment methods, dashboard clicks, account
      creation) — link to provider docs instead
- [ ] No provider bias when multiple mainstream options exist ("best option"
      claims, asymmetric SDK depth across providers)
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
- [ ] No decorative project header or adapter boilerplate at the top — rules start on line 1
- [ ] Contains only rules agents can't infer from code
- [ ] No content that should be a skill (workflows, checklists, multi-step procedures)
- [ ] Gotchas section present (highest-value content)
- [ ] No stale information (outdated commands, removed tools)
- [ ] No rigid ALWAYS/NEVER without reasoning
- [ ] If agent ignores a rule → file is probably too long, not the rule too weak
- [ ] If agent asks questions answered in the file → phrasing may be ambiguous
- [ ] Emphasis (`IMPORTANT`, `YOU MUST`) used sparingly for critical rules

### Should include
- Bash commands the agent can't guess
- Code style rules that differ from defaults
- Testing instructions and preferred test runners
- Repo etiquette (branch naming, PR conventions)
- Architecture decisions specific to the project
- Developer environment quirks (required env vars)
- Common gotchas and non-obvious behaviors

### Should NOT include
- Anything the agent can figure out by reading code
- Standard language conventions the agent already knows
- Detailed API documentation (link to docs instead)
- Information that changes frequently
- Long explanations or tutorials
- File-by-file descriptions of the codebase
- Self-evident practices like "write clean code"

### The one-line test
For every line: *"Would removing this cause the agent to make mistakes?"* If not, cut it.
If the agent ignores a rule, the file is probably too long — not the rule too weak.
If the agent asks questions answered in the file, the phrasing is ambiguous.

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

### Platform discovery paths

The agentskills.io spec is **client-agnostic** — discovery paths are not part
of the spec. The locations below are each client's own convention.

| Platform | User scope | Repo scope |
|----------|------------|------------|
| Claude Code | `~/.claude/skills/` | `.claude/skills/` |
| OpenAI Codex | `~/.agents/skills/` | `.agents/skills/` (scanned from cwd up to repo root) |
| Gemini CLI | `~/.gemini/skills/` or `~/.agents/skills/` (alias wins) | `.gemini/skills/` or `.agents/skills/` (alias wins) |

Share one skill set across all three by keeping files in `~/.agents/skills/` — Codex and Gemini pick it up natively — and junction (Windows) or symlink (macOS/Linux) `~/.claude/skills/` → `~/.agents/skills/` so Claude Code sees the same files under its own path. A working pattern: a small Python or PowerShell script that calls `mklink /J` (Windows) or `os.symlink` (POSIX) per skill directory; run once per machine setup so new skills under `~/.agents/skills/` are picked up by Claude Code through the junction.

### Compatibility checklist
- [ ] Forward slashes in all paths
- [ ] Prerequisites stated explicitly
- [ ] MCP tools use fully qualified names (`Server:tool_name`)
- [ ] Dependency versions pinned
- [ ] No interactive prompts in scripts
- [ ] No platform-specific assumptions without `compatibility` field

## Description rewriting

The description is the routing key — agents load only `name` + `description` at startup, so fix this first when a skill under-triggers. Third person, imperative ("Use when…"), pushy about trigger contexts, under 1024 characters.

For full trigger evaluation (build a query set, grade with a validation split, iterate), use the `skill-creator` skill — that's where the benchmark tooling lives. This skill stops at identifying that a rewrite is needed.

## Gotchas

- `description` has a hard cap of 1024 characters — count characters before saving when writing long descriptions
- `name` must match the directory name exactly — uppercase letters, underscores, or spaces break discovery
- In batch audits, `~/.agents/skills/` is the user-scope default, `.agents/skills/` is repo-scope — don't mix them up
- Symlinks from `.claude/skills/` → `.agents/skills/` can cause duplicate discovery reports
- Instruction file audit (AGENTS.md/CLAUDE.md) is a separate workflow from skill audit — don't combine them into the same report
- `allowed-tools` is marked Experimental in the spec — don't add routinely, support varies across platforms
- `version` is not a root-level frontmatter field — to version a skill, place it under `metadata: { version: "1.0" }`. Free-form root-level keys may be rejected by spec validators
- `argument-hint` and `model` are Claude Code -specific extensions, not in agentskills.io spec — other clients silently ignore them. Safe to use, but don't rely on cross-client behavior
- **Root `skills/` breaks discovery**: Moving project skills from `.agents/skills/` to a root `skills/` directory breaks Claude Code `/skills` discovery and Codex auto-discovery — both scan `.agents/skills/` (repo scope) directly. Root `skills/` only works as AGENTS.md `@include` context, not as a discoverable/invokable skill. Keep skills in `.agents/skills/<name>/`. To auto-load a skill every session, add `@.agents/skills/<name>/SKILL.md` to AGENTS.md.
- **Verify behavioral claims against official docs/source before editing** — truncation behavior, deprecation status, experimental flags, and token budgets must come from specs, READMEs, or source code, not from inference or plausibility. When docs are silent on a behavior, preserve the original wording rather than invent it. A plausible-sounding claim that rots later is worse than no claim.

The goal is reliable triggering, specification compliance, and clear value without wasting context tokens.
