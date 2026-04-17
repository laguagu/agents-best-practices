---
name: skill-creator
argument-hint: "[skill-name or description of what the skill should do]"
description: >
  Creates new agent skills and iteratively improves existing ones following
  the .agents/skills/ specification. Guides through intent capture, SKILL.md
  writing, testing, and description optimization. Use when creating a skill
  from scratch, turning a workflow into a reusable skill, improving an existing
  skill's content or triggering, or when the user says "make this a skill",
  "create a skill for X", "turn this into a skill", even if they don't
  explicitly mention "skill" but describe a repeatable workflow they want
  to automate.
compatibility: "Claude Code, Codex, Gemini CLI — any agentskills.io-compatible platform"
---

# Skill Creator

Create, test, and improve `.agents/skills/` skills through a structured
draft-test-iterate loop.

## Quick start

1. **Capture intent** — what should the skill do and when should it trigger?
2. **Write SKILL.md** — frontmatter + instructions following the spec
3. **Test** — run 2-3 realistic prompts, observe behavior
4. **Iterate** — improve based on results, repeat until satisfied

## Workflow

### Step 1: Capture intent

Understand what the user wants before writing anything.

1. What should this skill enable the agent to do?
2. When should it trigger? (user phrases, contexts)
3. What's the expected output format?
4. Are there edge cases or constraints?

If the current conversation already contains a workflow the user wants to
capture ("turn this into a skill"), extract answers from conversation history:
tools used, sequence of steps, corrections made, input/output formats.

### Step 2: Write the SKILL.md

#### Directory structure

```
.agents/skills/<skill-name>/
├── SKILL.md          # Required: frontmatter + instructions
├── scripts/          # Optional: executable code
└── references/       # Optional: supplementary docs (only when SKILL.md would exceed ~300 lines)
```

Place in `.agents/skills/` for repo-scope or `~/.agents/skills/` for user-scope.

#### Frontmatter (required fields)

```yaml
---
name: my-skill
description: >
  What this skill does. Use when [specific trigger contexts].
  Activates on: "keyword1", "keyword2", even if the user
  does not explicitly mention [topic].
---
```

**name rules:**
- 1–64 characters, lowercase `a-z`, digits `0-9`, hyphens `-` only
- No leading/trailing/consecutive hyphens
- Must match parent directory name exactly

**description rules:**
- 1–1024 characters
- Third person only: "Processes files" not "I process files"
- Imperative framing: "Use when..." tells the agent when to act
- Be **pushy** — agents under-trigger by default. Explicitly list contexts,
  including non-obvious ones ("even if they don't mention X")
- Focus on user intent, not implementation details

#### Optional frontmatter fields

- `argument-hint` — shown in skill list (e.g., `"[file or directory]"`)
- `compatibility` — platform/environment requirements (1–500 chars)
- `allowed-tools` — space-separated pre-approved tools (experimental, use sparingly)
- `license` — license name or reference
- `metadata` — string key-value pairs (author, version, etc.)

#### Body structure

```markdown
# Skill Name

One-line summary of what this skill does.

## Quick start
1. Most common use case in 3 steps
2. Step two
3. Step three

## Detailed workflow

### Gather
Read relevant files, understand current state.

### Act
Make changes, run scripts, generate output.

### Verify
Check results, validate output, confirm correctness.

## Gotchas
- Non-obvious fact that prevents mistakes
- Environment quirk the agent can't infer from code
```

#### Content guidelines

**Add only what the agent lacks.** For every piece of content, ask:
"Would the agent get this wrong without this?" If not, cut it.

- No explanations of general concepts (what PDFs are, how HTTP works)
- Every token must justify its cost — the context window is shared
- Instructions in imperative form ("Run X", "Check Y")
- Explain the **why**: "Filter test accounts because production reports
  include them otherwise" beats "ALWAYS filter test accounts"

**Match specificity to fragility:**
- High freedom for flexible tasks (reviews, writing) — general guidelines
- Low freedom for fragile operations (migrations, destructive ops) — exact scripts

**Progressive disclosure:**
- Core instructions in SKILL.md (under 500 lines)
- Detailed reference in separate files, clearly signposted with "when to read" guidance
- References one level deep from SKILL.md (no A → B → C chains)
- Table of contents in reference files over 100 lines

### Step 3: Test with real usage

Create 2-3 realistic test prompts to smoke-test the workflow end-to-end.
(Separate from Step 5's 20 eval queries, which test description triggering.)
Share them with the user for review before running.

Run the skill against each prompt and observe:
- Does the skill trigger when it should?
- Does the agent follow the instructions correctly?
- Is the output what the user expects?
- Does the agent waste time on unproductive steps?

### Step 4: Iterate

Based on test results:

1. **Generalize from feedback** — don't overfit to specific test cases.
   The skill will be used across many prompts. Fiddly, overfitty changes
   for one test case hurt all others.
2. **Keep it lean** — remove instructions that aren't pulling their weight.
   Read transcripts, not just outputs. If the agent wastes time on something,
   cut the instruction causing it.
3. **Explain the why** — reasoning-based instructions outperform rigid directives.
   If you find yourself writing ALWAYS/NEVER in caps, reframe and explain
   the reasoning instead.
4. **Look for repeated work** — if the agent independently writes the same
   helper script across test runs, bundle it in `scripts/`.

Repeat test-iterate until the user is satisfied.

### Step 5: Optimize description (if needed)

If the skill doesn't trigger reliably:

1. Create 20 eval queries (10 should-trigger, 10 should-not-trigger)
   - Should-trigger: vary phrasing, explicitness, detail level
   - Should-not-trigger: focus on **near-misses** (share keywords but need different skill)
2. Split 60% train / 40% validation
3. Run each query 3 times (model behavior is nondeterministic)
4. Iterate: identify failures in train set → revise description → test (up to 5 iterations)
5. Select best by **validation** score to avoid overfitting

Watch for overfitting: train improving but validation dropping, description
growing toward 1024 chars, specific test keywords leaking into description.

## Anti-patterns to avoid

| Anti-pattern | Fix |
|-------------|-----|
| Vague description | Be specific, include trigger contexts |
| First person ("I can help") | Third person ("Processes files") |
| Over-explaining basics | Trust agent's knowledge, add only what it lacks |
| SKILL.md > 500 lines | Split into references |
| Deeply nested refs (A→B→C) | One level deep only |
| Windows paths (`\`) | Always use `/` |
| Time-sensitive information | Use "old patterns" section or avoid |
| Too many options without default | Provide default + escape hatch |
| Magic constants | Document every value |
| Rigid ALWAYS/NEVER | Explain the reasoning instead |

## Pre-publish checklist

- [ ] `name` matches directory, lowercase+hyphens, 1–64 chars
- [ ] `description`: specific, third person, includes triggers, < 1024 chars
- [ ] SKILL.md body under 500 lines
- [ ] No time-sensitive information
- [ ] Consistent terminology throughout
- [ ] Forward slashes in all paths
- [ ] All referenced files exist and are reachable from SKILL.md
- [ ] 2-3 test prompts run and results verified
- [ ] Description triggers correctly (not too narrow or too broad)
- [ ] `compatibility` field set if the skill targets multiple platforms

## Gotchas

- Description is the routing key — spend more time on it than on the body content
- Agents under-trigger by default; err on the side of pushy descriptions
- `~/.agents/skills/` is user-scope (global), `.agents/skills/` is repo-scope — choose based on whether the skill is project-specific or general
- `references/` is opt-in — don't create empty placeholder directories
- Keep SKILL.md flat by default: SKILL.md + scripts/ if needed, references/ only when SKILL.md would exceed ~300 lines
- On Windows, use directory junctions (`mklink /J`) to sync between `~/.agents/skills/` and platform-specific paths like `~/.claude/skills/`

## Cross-platform compatibility

When creating skills for multiple platforms:
- Forward slashes in all file paths
- State prerequisites explicitly (don't assume tools are available)
- Use fully qualified MCP tool names (`Server:tool_name`)
- Pin dependency versions (`npx eslint@9.0.0`, `uv run ruff@0.8.0`)
- No interactive prompts in scripts — agents use non-interactive shells
- Structured output (JSON/CSV to stdout, diagnostics to stderr)
