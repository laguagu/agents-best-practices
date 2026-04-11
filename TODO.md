# TODO — agents-best-practices

## Mitä on tehty

### Repo luotu (2026-04-11)
- Vendor-neutraali `.agents`-first best practices -repo
- Johtava periaate: **AGENTS.md on kanoninen**, CLAUDE.md/GEMINI.md ovat adaptereita
- Repo: https://github.com/laguagu/agents-best-practices

### Nykyinen rakenne (17 tiedostoa, 1366 riviä)
```
agents-best-practices/
├── README.md                          # Platform-tuki, periaatteet, quick start
├── AGENTS.md                          # Repon omat agent-ohjeet
├── .agents/skills/improving-skills/   # Parannettu auditointi-skill
│   ├── SKILL.md (256 riviä)
│   └── references/
│       ├── anti-patterns.md (256 riviä)
│       └── description-optimization.md (48 riviä, tiivistetty 178→48)
├── templates/
│   ├── AGENTS.md    # Kanoninen instruction template
│   ├── CLAUDE.md    # Adapter template (johdettu AGENTS.md:stä)
│   ├── GEMINI.md    # Adapter template
│   └── SKILL.md     # Skill-pohja frontmatterilla
├── docs/
│   ├── skill-vs-instructions.md   # Päätöspuu: milloin skill, milloin AGENTS.md
│   ├── cross-platform.md          # .agents/ standardi eri alustoilla
│   ├── trigger-evaluation.md      # Trigger-kuvausten evaluointi
│   └── scripts-guide.md           # Agenttiystävälliset skriptit
└── examples/
    ├── example-skill/             # Hyvä esimerkkiskill + validate.sh skripti
    └── bad-skill/                 # Tarkoituksella huono (testaukseen)
```

### Improving-skills -parannukset (auditoinnin perusteella)
- Lisätty `argument-hint` frontmatteriin (12/22 sisarskillissä on)
- Lisätty `compatibility`-kenttä (Claude Code, Codex, Gemini CLI)
- Description laajennettu: CLAUDE.md/AGENTS.md/GEMINI.md triggerit, migraatio
- Uusi osio: instruction file audit (AGENTS.md/CLAUDE.md/GEMINI.md checklisti)
- Laajennettu cross-platform-osio: platform-taulukko, migraatio-ohje
- `allowed-tools` + `argument-hint` lisätty audit-checklistiin
- `description-optimization.md` tiivistetty 178→48 riviä (viittaa skill-creatoriin)
- Alkuperäinen skill päivitetty myös: `~/.agents/skills/improving-skills/`

## Mitä pitäisi tehdä seuraavaksi

### Korkea prioriteetti
1. **Laadun tarkistus** — käy kaikki tiedostot läpi, paranna sisältöä, varmista yhtenäisyys
2. **README.md** — onko tarpeeksi selkeä? Pitäisikö lisätä contributing-ohjeet?
3. **Templates** — ovatko tarpeeksi käytännöllisiä? Pitäisikö lisätä enemmän esimerkkejä?
4. **Docs** — ovatko kattavat? Puuttuuko jotain oleellista?
5. **Examples** — bad-skill sisältää tarkoituksella virheitä (nimi `Bad_Skill`, first person description, Windows-polut, over-explaining, ei defaultteja) — varmista että improving-skills löytää ne kaikki

### Keskipitkä prioriteetti
6. **Lisää skills** — harkitse lisää hyödyllisiä skilleja repoon (esim. skill joka auditoi CLAUDE.md:tä)
7. **Contributing guide** — miten muut voivat kontribuoida skilleja
8. **LICENSE** — lisää MIT tai muu lisenssi
9. **Vanhat projektit** — `C:\dev\agents-and-templates\` juuressa on vanhoja projekteja (claude-code-nextjs-skills, cursor-rules, nextjs16-template, claude-code-notification-windows) — päätä pidetäänkö erillään vai integroidaanko

### Matala prioriteetti
10. **Evals** — lisää `evals/` improving-skillsiin testiprompteja varten
11. **CI** — GitHub Actions joka validoi SKILL.md frontmatterit
12. **Skill installer** — skripti joka asentaa skilleja tästä reposta globaalisti

## Arkkitehtuuripäätökset (tehty)

| Päätös | Valinta | Miksi |
|--------|---------|-------|
| Kanoninen instruction file | AGENTS.md | Universaali standardi, ei vendor lock-in |
| CLAUDE.md / GEMINI.md | Adapterit | Eivät ole itsenäisiä, vaan laajentavat AGENTS.md:tä |
| `references/` | Opt-in | Ei oletusrakenne; vain kun SKILL.md paisuisi muuten |
| Skill-rakenne | Litteä oletuksena | SKILL.md + scripts/ tarvittaessa, ei turhaa monimutkaisuutta |
| improving-skills vs skill-creator | Erillään | improving-skills = auditointi, skill-creator = luonti + eval |
| Repon sijainti | `C:\dev\agents-and-templates\agents-best-practices\` | Erillään vanhoista projekteista |

## Codexin suositukset (sisällytetty suunnitelmaan)

Codex (OpenAI) auditoi saman tehtävän ja suositteli:
- AGENTS.md-first, ei kolmea erillistä totuuden lähdettä ✅ tehty
- bad-skill/ esimerkki testausta varten ✅ tehty
- Migraatio-ohje client-specific → .agents/ ✅ tehty
- Repo Contract -osio ✅ tehty (README.md)
- `references/` opt-in, ei oletus ✅ tehty
- Improving-skills laajennus: audit + governance, ei raskas luontijärjestelmä ✅ tehty

## Viitelähteet

### Spesifikaatiot
- [agentskills.io/specification](https://agentskills.io/specification)
- [agentskills.io/skill-creation/best-practices](https://agentskills.io/skill-creation/best-practices)
- [agentskills.io/skill-creation/quickstart](https://agentskills.io/skill-creation/quickstart)
- [agentskills.io/skill-creation/using-scripts](https://agentskills.io/skill-creation/using-scripts)
- [agentskills.io/skill-creation/evaluating-skills](https://agentskills.io/skill-creation/evaluating-skills)
- [agentskills.io/skill-creation/optimizing-descriptions](https://agentskills.io/skill-creation/optimizing-descriptions)
- [agentskills.io/client-implementation/adding-skills-support](https://agentskills.io/client-implementation/adding-skills-support)
- [agents.md](https://agents.md/) — AGENTS.md spesifikaatio

### Platform-dokumentaatio
- [platform.claude.com — skill best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)
- [code.claude.com — best practices](https://code.claude.com/docs/en/best-practices)
- [developers.openai.com — Codex skills](https://developers.openai.com/codex/skills)
- [geminicli.com — skills](https://geminicli.com/docs/cli/skills/)
- [developers.googleblog.com — agent skills](https://developers.googleblog.com/closing-the-knowledge-gap-with-agent-skills/)
- [antigravity.google — skills](https://antigravity.google/docs/skills)

### Viiterepot
- [mgechev/skills-best-practices](https://github.com/mgechev/skills-best-practices)
- [openai/skills](https://github.com/openai/skills) (43 curatoitua skilliä)

### Muut
- [The Complete Guide to Building Skills for Claude (PDF)](https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf)

## Globaali konteksti

Käyttäjän skills-ekosysteemi:
- Source of truth: `~/.agents/skills/` (22 skilliä)
- Synkattu: `~/.claude/skills/` (Windows junction -linkit)
- `skill-creator` omistaa luonnin (7 skriptiä, eval-looppi, sub-agentit)
- `improving-skills` omistaa auditoinnin (tämän repon versio on parannettu)
