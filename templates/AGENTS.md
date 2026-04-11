# Agent Instructions

<!-- AGENTS.md is the canonical instruction file for this project.
     CLAUDE.md and GEMINI.md are adapters that extend this — not replacements.
     Keep this concise. For each line ask: "Would removing this cause the agent
     to make mistakes?" If not, cut it. -->

## Development Environment

<!-- Commands the agent can't guess from reading code -->
```bash
# Install dependencies
# Build
# Run dev server
```

## Testing

<!-- Test runner, preferred flags, single-test patterns -->
```bash
# Run all tests
# Run a single test
# Type check
```

## Code Style

<!-- Only rules that differ from language defaults -->
- <!-- e.g., Use ES modules (import/export), not CommonJS (require) -->
- <!-- e.g., Prefer named exports over default exports -->

## Pull Requests

<!-- Branch naming, commit message format, review process -->
- <!-- e.g., Branch format: feature/short-description -->
- <!-- e.g., Squash commits before merging -->

## Gotchas

<!-- Non-obvious facts that prevent agent mistakes.
     This is the highest-value section. Add entries when an agent
     makes the same mistake twice. -->
- <!-- e.g., The /api/v2 endpoints require auth header even in dev -->
- <!-- e.g., Don't modify migration files after they've been applied -->

## Architecture Decisions

<!-- Project-specific constraints the agent can't infer from code -->
- <!-- e.g., All database access goes through the repository pattern -->
- <!-- e.g., Feature flags are managed via environment variables, not config files -->

<!-- TIP: If this file grows past ~100 lines, move specialized workflows
     into skills (.agents/skills/) instead. Skills load on-demand and
     don't bloat every conversation. -->
