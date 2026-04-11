# When to Use a Skill vs. an Instruction File

## The Decision Tree

```
Is this a persistent, broad rule that applies to every task?
├── YES → Put it in AGENTS.md (or CLAUDE.md/GEMINI.md adapter)
│         Examples: code style, test commands, PR conventions, gotchas
│
└── NO → Is this on-demand expertise, a workflow, or a checklist?
         ├── YES → Make it a skill (.agents/skills/<name>/SKILL.md)
         │         Examples: audit procedures, deployment checklists,
         │         code generation templates, API integration guides
         │
         └── NO → You probably don't need to write it down.
                   The agent can figure it out from the code.
```

## AGENTS.md is For

- **Build/test commands** the agent can't guess from reading code
- **Code style rules** that differ from language defaults
- **PR conventions** (branch naming, commit format)
- **Gotchas** — non-obvious facts that prevent recurring mistakes
- **Architecture decisions** the agent can't infer from code structure

AGENTS.md loads every session. Every line costs context tokens. Keep it under 100 lines.

## Skills Are For

- **Multi-step workflows** (deploy, migrate, audit, review)
- **Domain expertise** (API-specific knowledge, framework patterns)
- **Checklists** with verification steps
- **Templates** for output formatting
- **Procedures** that need Gather-Act-Verify loops

Skills load on-demand. They only cost tokens when activated.

## When to Migrate

**From AGENTS.md to skill:**
- AGENTS.md exceeds ~100 lines
- A section is only relevant to specific tasks
- A workflow requires multiple steps with verification
- You find yourself adding "only do this when..." qualifiers

**From skill to AGENTS.md:**
- The skill triggers on nearly every task
- The content is a single rule, not a workflow
- It's a gotcha that should be visible in every conversation

## CLAUDE.md / GEMINI.md: Adapter Rules

These files extend AGENTS.md with platform-specific conventions. They are NOT independent instruction systems.

**Put in adapter:** Platform-specific syntax (`@` imports in Claude), platform-specific features (`/skills list` in Gemini)

**Don't put in adapter:** General rules that should be the same across all agents. Those belong in AGENTS.md.

If you're adding the same instruction to both CLAUDE.md and GEMINI.md, it belongs in AGENTS.md instead.
