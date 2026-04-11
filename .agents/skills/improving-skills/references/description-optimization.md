# Description Optimization

How triggering works and how to systematically improve descriptions.

## How Triggering Works

At startup, agents load only `name` and `description` (~50-100 tokens each).
When a task matches, the agent reads the full SKILL.md. The description
carries the entire burden of triggering.

Key insight: agents only consult skills for tasks they can't easily handle
alone. Complex, multi-step, or specialized queries reliably trigger skills.

## Writing Effective Descriptions

- **Third person**: "Processes files" not "I process files"
- **Imperative framing**: "Use when..." tells the agent when to act
- **Be pushy**: explicitly list contexts, including indirect mentions
- **Under 1024 characters**: hard limit in specification
- **Focus on user intent**: what user wants to achieve, not implementation

## Avoiding Overfitting

Signs: train score improving but validation dropping, description growing
toward 1024 chars, keywords from specific test queries appearing in description.

Prevention: generalize from feedback (address the category, not specific
wording), select by validation score, keep train/validation split fixed.

## Automated Optimization

For full train/validation eval loops, use `skill-creator`'s scripts:
- `scripts/run_loop.py` — automated eval runner
- `scripts/improve_description.py` — iterative description improvement

## Before/After Example

```yaml
# Before (score: 1/5)
description: Process CSV files.

# After (score: 5/5)
description: >
  Analyze CSV and tabular data files — compute summary statistics,
  add derived columns, generate charts, and clean messy data. Use when
  the user has a CSV, TSV, or Excel file and wants to explore, transform,
  or visualize data, even if they don't explicitly mention "CSV" or "analysis."
```
