# Trigger Evaluation Guide

How to test and improve a skill's description for reliable triggering.

## How Triggering Works

At startup, agents load only the `name` and `description` of each skill (~50-100 tokens each). When a task matches a description, the agent reads the full SKILL.md.

The description carries the entire burden of triggering. It's the routing key.

## Writing Effective Descriptions

- **Third person**: "Processes files" not "I process files"
- **Imperative framing**: "Use when..." tells the agent when to act
- **Be pushy**: explicitly list contexts, including indirect mentions
- **Under 1024 characters**: hard limit in the specification
- **Focus on user intent**: what the user is trying to achieve, not implementation

## Designing Eval Queries

Create ~20 queries: 10 should-trigger, 10 should-not-trigger.

### Should-trigger queries

Vary along these axes:
- **Phrasing**: formal, casual, typos, abbreviations
- **Explicitness**: direct mention vs. implicit need
- **Detail level**: terse vs. context-heavy with file paths
- **Complexity**: single-step vs. multi-step

Best should-trigger queries: skill would help but the connection isn't obvious.

### Should-not-trigger queries

Focus on **near-misses** — queries that share keywords but need something different:

```json
{"query": "update the formulas in my Excel budget spreadsheet", "should_trigger": false}
```

Near-misses are more valuable than obviously irrelevant queries.

## Running Trigger Tests

Run each query 3 times (model behavior is nondeterministic).

- Should-trigger passes if trigger rate > 0.5
- Should-not-trigger passes if trigger rate < 0.5

For automated testing, see the optimization loop in the
[skill-creator](../.agents/skills/skill-creator/SKILL.md) skill.

## The Optimization Loop

1. Split queries: 60% train, 40% validation
2. Evaluate current description on both sets
3. Identify failures in train set only
4. Revise description (broaden if under-triggering, narrow if over-triggering)
5. Repeat (5 iterations is usually enough)
6. Select best by **validation** score, not train score

### Avoiding Overfitting

Signs: train score improving but validation dropping, description growing toward 1024 chars, keywords from specific test queries appearing in description.

Prevention: generalize from feedback (address the category, not specific wording), select by validation score, keep the train/validation split fixed.
