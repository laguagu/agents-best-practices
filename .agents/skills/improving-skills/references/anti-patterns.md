# Anti-Patterns in Agent Skills

Common issues found in skill audits, with examples and fixes.

## Contents
- Frontmatter anti-patterns
- Content anti-patterns
- Structure anti-patterns
- Script anti-patterns

## Frontmatter anti-patterns

### Vague description
**Problem:** Description is too generic for reliable triggering.
```yaml
# Bad
description: Helps with documents.
description: Processes data.
description: Does stuff with files.
```
**Fix:** Be specific about capabilities and trigger contexts:
```yaml
# Good
description: >
  Extracts text and tables from PDF files, fills PDF forms, and merges
  documents. Use when working with PDF files or when the user mentions
  PDFs, forms, or document extraction.
```

### First/second person description
**Problem:** Inconsistent point-of-view causes discovery problems.
```yaml
# Bad
description: I can help you process Excel files.
description: You can use this to analyze data.
```
**Fix:** Always use third person:
```yaml
# Good
description: Processes Excel files and generates summary reports.
```

### Name doesn't match directory
**Problem:** Specification requires name to match parent directory.
```
my-skill/
└── SKILL.md  # name: my_skill  ← wrong, uses underscore
```
**Fix:** Ensure exact match: directory `my-skill/` → `name: my-skill`

### Name uses invalid characters
**Problem:** Uppercase, underscores, spaces, or special characters.
```yaml
# Bad
name: PDF-Processing
name: my_skill
name: process pdfs
```
**Fix:** Lowercase letters, numbers, hyphens only:
```yaml
# Good
name: pdf-processing
```

### Under-triggering description
**Problem:** Description is technically correct but too narrow — misses
common ways users ask for this capability.
```yaml
# Bad — only triggers on exact terminology
description: Extracts text from PDF documents using pdfplumber.
```
**Fix:** Add explicit trigger contexts and be "pushy":
```yaml
# Good — triggers on many relevant phrasings
description: >
  Extracts text and tables from PDF files, fills forms, merges documents.
  Use when working with PDFs, when the user mentions document extraction,
  form filling, or PDF manipulation, even if they don't explicitly say "PDF".
```

### Unnecessary allowed-tools
**Problem:** Adding `allowed-tools` to every skill without need — field is Experimental.
```yaml
# Bad — no benefit, adds noise
allowed-tools: "Read Glob Grep Edit Write Bash"
```
**Fix:** Only use when a skill needs specific pre-approved tools (e.g., destructive operations):
```yaml
# Good — only when the skill genuinely needs pre-approval
allowed-tools: "Bash(git:*) Bash(npm:*)"
```

## Content anti-patterns

### Over-explaining basics
**Problem:** Wastes tokens explaining things the agent already knows.
```markdown
<!-- Bad -->
PDF (Portable Document Format) files are a common file format that
contains text, images, and other content. To extract text, you'll
need to use a library...
```
**Fix:** Jump to what the agent doesn't know:
```markdown
<!-- Good -->
Use pdfplumber for text extraction. For scanned documents, fall back
to pdf2image with pytesseract.
```

### Time-sensitive information
**Problem:** Content becomes stale, misleading future users.
```markdown
<!-- Bad -->
If you're doing this before August 2025, use the old API.
After August 2025, use the new API.
```
**Fix:** Use "old patterns" sections:
```markdown
<!-- Good -->
## Current method
Use the v2 API endpoint.

## Old patterns
<details>
<summary>Legacy v1 API (deprecated)</summary>
The v1 endpoint is no longer supported.
</details>
```

### Inconsistent terminology
**Problem:** Mixing terms for the same concept confuses the agent.
```markdown
<!-- Bad: mixing terms -->
The API endpoint returns data. Call the URL with... The route accepts...
```
**Fix:** Pick one term, use it everywhere:
```markdown
<!-- Good: consistent -->
The API endpoint returns data. Call the endpoint with...
```

### Too many options without a default
**Problem:** Agent can't choose between equal alternatives.
```markdown
<!-- Bad -->
You can use pypdf, pdfplumber, PyMuPDF, pdf2image, or tika...
```
**Fix:** Provide a clear default with an escape hatch:
```markdown
<!-- Good -->
Use pdfplumber for text extraction.
For scanned PDFs requiring OCR, use pdf2image with pytesseract instead.
```

### Rigid directives instead of reasoning
**Problem:** ALL-CAPS MUST/NEVER instructions are less effective than explanations.
```markdown
<!-- Bad -->
ALWAYS filter test accounts. NEVER skip this step.
```
**Fix:** Explain why:
```markdown
<!-- Good -->
Filter test accounts because production reports include them otherwise,
which inflates revenue metrics by ~15%.
```

### Bloated instruction files
**Problem:** AGENTS.md/CLAUDE.md grows past ~100 lines, agent starts ignoring rules.
```markdown
<!-- Bad — too much in one file -->
# Code style (20 lines)
# Testing (15 lines)
# Deployment checklist (40 lines)
# API integration guide (50 lines)
# Migration procedure (30 lines)
```
**Fix:** Keep only persistent broad rules, move workflows to skills:
```markdown
<!-- Good — lean instruction file -->
# Code style (20 lines)
# Testing (15 lines)
# Gotchas (10 lines)
<!-- Deployment, API integration, migration → .agents/skills/ -->
```

### Magic constants
**Problem:** Unexplained numbers that nobody understands.
```python
# Bad
TIMEOUT = 47  # Why 47?
RETRIES = 5   # Why 5?
```
**Fix:** Document the reasoning:
```python
# Good
# HTTP requests typically complete within 30s; longer timeout for slow connections
REQUEST_TIMEOUT = 30
# Most intermittent failures resolve by second retry
MAX_RETRIES = 3
```

## Structure anti-patterns

### SKILL.md exceeds 500 lines
**Problem:** Too much content in the main file wastes context when loaded.
**Fix:** Move detailed content to `references/` with clear pointers from SKILL.md.

### Deeply nested references
**Problem:** Agent partially reads files referenced from other references.
```markdown
<!-- Bad: SKILL.md → advanced.md → details.md → actual info -->
```
**Fix:** Keep everything one level deep from SKILL.md:
```markdown
<!-- Good: SKILL.md → each reference directly -->
See [references/advanced.md](references/advanced.md)
See [references/api.md](references/api.md)
```

### Large reference files without TOC
**Problem:** Agent can't find relevant sections in long files.
**Fix:** Add a table of contents at the top of any file >100 lines.

### Windows-style paths
**Problem:** Backslash paths break on Unix systems.
```markdown
<!-- Bad -->
Run scripts\helper.py
See reference\guide.md
```
**Fix:** Always use forward slashes:
```markdown
<!-- Good -->
Run scripts/helper.py
See references/guide.md
```

### Undiscoverable files
**Problem:** Files in the skill directory that SKILL.md never mentions.
**Fix:** Reference every file from SKILL.md with guidance on when to read it.

## Script anti-patterns

### Error punting
**Problem:** Script fails and leaves the agent to figure out what went wrong.
```python
# Bad — just crashes
def process(path):
    return open(path).read()
```
**Fix:** Handle errors with helpful messages:
```python
# Good — explicit handling
def process(path):
    try:
        return open(path).read()
    except FileNotFoundError:
        print(f"File {path} not found. Check the path and try again.")
        return ""
```

### Interactive prompts
**Problem:** Script blocks waiting for input that agents can't provide.
**Fix:** Accept all input via command-line flags, environment variables, or stdin.

### Unstructured output
**Problem:** Free-form text output is hard for agents to parse.
**Fix:** Use JSON/CSV to stdout. Send diagnostics to stderr.

### Missing --help
**Problem:** Agent doesn't know the script's interface.
**Fix:** Include usage, flags, and examples in `--help` output.

### Unversioned dependencies
**Problem:** Script behavior changes unpredictably over time.
```bash
# Bad
pip install pypdf
npx eslint .
```
**Fix:** Pin versions:
```bash
# Good
pip install pypdf==4.1.0
npx eslint@9.0.0 .
```
