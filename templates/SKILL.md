---
name: skill-name
# 1-64 chars, lowercase a-z/0-9/hyphens, must match parent directory name
# No leading/trailing/consecutive hyphens

argument-hint: "[what to pass as argument]"
# Shown to user when they type /skill-name — helps them provide the right input

description: >
  What this skill does in specific terms. Use when [trigger context 1],
  [trigger context 2], or [trigger context 3]. Activates on: "keyword1",
  "keyword2", "keyword3", even if the user does not explicitly mention
  "[non-obvious trigger]".
# 1-1024 chars. Third person. Imperative. Be pushy — list multiple use cases.
# This is the routing key: agents read it to decide what gets loaded.

# Optional fields:
# compatibility: "Claude Code, Codex, Gemini CLI"
# license: MIT
# allowed-tools: "Bash Read Edit Grep Glob"
# metadata:
#   author: "your-name"
#   version: "1.0.0"
---

# Skill Name

One-line summary of what this skill does.

## Quick Start

1. First step — the most common use case
2. Second step
3. Third step

## Detailed Workflow

### Step 1: Gather

Read the relevant files and understand the current state.

### Step 2: Act

Make changes based on what you found.

### Step 3: Verify

Check your work:
- [ ] Verification check 1
- [ ] Verification check 2

## Gotchas

<!-- Highest-value section. Non-obvious facts that prevent mistakes.
     Add entries when the agent makes the same mistake twice. -->

- Non-obvious fact 1 because [reason]
- Non-obvious fact 2 because [reason]

## References

<!-- Only add references/ when SKILL.md would exceed ~300 lines without them.
     references/ is opt-in, not default. Keep the skill flat. -->

- See [references/detail.md](references/detail.md) when you need [specific guidance]
