---
name: skill-finder
argument-hint: "[capability or task]"
description: >
  Finds existing agent skills before creating a new one. Searches a curated
  list of 1184+ official skills from Anthropic, Vercel, Stripe, Supabase,
  Cloudflare, Sentry, MongoDB, Figma, and 40+ other teams. Use when the user
  asks "find me a skill for X", "is there an existing skill for Y", "how do
  I do Z", or expresses a capability gap — even if they do not explicitly
  mention "skill". Run BEFORE skill-creator to avoid duplicating work.
license: Apache-2.0
---

# Skill Finder

Discover existing official skills before creating a new one.

## Quick start

1. **Capture intent** — domain (PDF, auth, PostgreSQL) + task (extract, validate, migrate)
2. **Search** `references/official-skills.md` using grep-style keyword lookup
3. **Rank** matches by publisher reputation and relevance
4. **Present** 3-5 candidates with owner/name + one-line description + link
5. **Fallback** to skills.sh / `npx skills find` / skill-creator if nothing fits

## Workflow

### Step 1: Understand intent

Extract two dimensions from the user's request:

- **Domain** — the subject area (e.g., `PDF`, `auth`, `postgres`, `stripe`, `react`)
- **Task** — the action verb (e.g., `extract`, `validate`, `migrate`, `test`, `deploy`)

If the user is vague ("help me with auth stuff"), ask one clarifying question
before searching. A narrower query returns better matches.

### Step 2: Search the local list

Grep `references/official-skills.md` with the domain keyword first, then
refine with task keywords if too many hits.

```bash
grep -i "pdf" .agents/skills/skill-finder/references/official-skills.md
grep -i "auth\|oauth\|jwt" .agents/skills/skill-finder/references/official-skills.md
```

Expand queries for common synonyms:
- `database` → also match `postgres`, `sql`, `mongo`, `mysql`
- `auth` → also match `oauth`, `jwt`, `session`, `login`
- `UI` → also match `frontend`, `react`, `design`, `component`

### Step 3: Rank matches

When multiple candidates surface, prefer publishers in this order:

1. **Official publishers** — `anthropics/`, `vercel-labs/`, `stripe/`, `supabase/`,
   `microsoft/`, `google-gemini/`, `cloudflare/`, `openai/`
2. **Well-known teams** — `huggingface/`, `sentry/`, `mongodb/`, `auth0/`,
   `figma/`, `notion/`, `datadog/`
3. **Community** — any remaining matches

Within a single publisher, prefer the skill whose name most directly matches
the user's task verb.

### Step 4: Present candidates

Format each recommendation as:

```
owner/skill-name — one-line description
https://officialskills.sh/owner/skills/skill-name
```

Present 3-5 candidates. Lead with the single best match; list alternatives
under a "See also" line if useful.

### Step 5: Fallback when nothing matches

If no skill fits the query:

1. Point to [skills.sh](https://skills.sh/) — browse the leaderboard by
   install count
2. Suggest `npx skills find <query>` — Vercel Labs' CLI search
3. As a last resort, invoke `skill-creator` to build one from scratch

Never invent a skill name. If it's not in `references/official-skills.md`
and not on skills.sh, the user needs to create one.

## Gotchas

- `references/official-skills.md` is a static snapshot — regenerate it when
  the upstream source changes significantly. The header records the last
  update date.
- Trust the publisher prefix. `anthropics/` ≠ `anthropic-community/` — the
  former is the official Anthropic repo, the latter is community-maintained.
- The list contains both **skills** and **reference implementations**. If a
  match looks like a template or tutorial rather than a working skill,
  flag that to the user.
- Do not recommend a skill based solely on name match. Verify the
  description aligns with the user's actual task.

## Refresh

`references/official-skills.md` is a static snapshot. To refresh, replace
its content with an updated curated list from a source of your choice,
then update the header (date, skill count).
