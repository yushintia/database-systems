# Database Systems (511783-001)

Lab manual and lecture slides for Database Systems, DEU 2026-2, Dept.
of Intelligent Computing. Deployed via GitHub Pages, see
`.github/workflows/deploy.yml`.

Read `SPINE.md` first: it defines the pedagogical structure every
lecture deck follows (motivation before definition, weeks chained via
a Limits-to-Pain handoff, and the rule that every deck teaches only its
matching lab's Part A). `OUTLINE.md` has the full 15-week plan and
chain table.

## Layout

```
SPINE.md                  standard lecture structure, read this first
OUTLINE.md                 15-week plan + Limits-to-Pain chain
themes/shintia.css          Marp theme, shared with the sibling courses
assets/deu-logo.png          university logo
book/                       mdBook lab manual - full guided labs, rubrics
  book.toml
  src/
    introduction.md
    labs/                    lab01 ... lab15 (one per week)
      files/                  seed .sql/.xlsx data for each lab
    setup/                   MySQL & Workbench install + how a database runs
    appendix/                 style guide, rubrics, troubleshooting,
                               E-R notation, case-study reference, references
slides/
  _template/week-XX.md      copy this to start a new week deck
  _shared/roadmap.md         Act-0 roadmap graphic, paste into slot 2
  _shared/case-study.md      running University Course Registration case
  week01-introduction.md ... week15-final-review.md   17-slot lecture decks
solutions/                  professor answer keys (problems.md is public,
                             answer-key/ is not built/published)
landing/index.html           site root - links the book and every deck
```

## Setup

Requires Node.js (already installed: v24) and `mdbook` (v0.5.2). First
marp-cli run installs it into `node_modules` via `npx`. No separate
`npm install` step needed.

```bash
npx @marp-team/marp-cli --version   # confirms marp-cli resolves
mdbook --version                     # confirms mdbook resolves
```

## Preview slides in a browser (live reload)

```bash
npx @marp-team/marp-cli -s slides --theme-set themes/shintia.css
```

Opens a local server (default http://localhost:8080) listing every
`.md` file in `slides/`; click `week01-introduction.md`.

## Zero-install alternative: VS Code

Install the **Marp for VS Code** extension, open any `slides/*.md` file,
and use the built-in preview pane. To pick up the custom theme, add to
VS Code settings:

```json
"markdown.marp.themes": ["./themes/shintia.css"]
```

## Build the book

```bash
mdbook build book   # -> book/book/, open book/book/index.html
```

## Release the book as per-chapter PDFs

```bash
npm run build:book-pdfs   # -> book/pdf/*.pdf, one per SUMMARY.md chapter, + book/pdf/index.html
```

Renders each already-built chapter page to its own PDF via headless
Chrome/Chromium (`scripts/build-book-pdfs.js`). Needs a `google-chrome`
or `chromium` binary on PATH (or `$CHROME_PATH`) — GitHub Actions'
`ubuntu-latest` runners ship Chrome preinstalled, so CI needs no extra
install step. Wired into `.github/workflows/deploy.yml`, published at
`/book/pdf/` on the live site.

## Export the slides

```bash
npm run build:html   # -> dist/slides/*.html, self-contained
npm run build:pdf     # -> dist/slides/*.pdf
npm run build:pptx    # -> dist/slides/*.pptx, for LMS upload
```

## Adding a new week

1. Copy `slides/_template/week-XX.md` → `slides/weekNN-topic.md`, fill
   in all 17 spine slots (see `SPINE.md`). Every slot should trace back
   to that week's lab page — never invent content the lab doesn't have.
2. Write (or update) `book/src/labs/labNN-topic.md` first — Learning
   Outcomes, Background, Worked Examples, Guided Exercises, Challenge
   Problem, Practice Problems, Common Pitfalls, Submission & Rubric.
3. Paste the roadmap `<div>` from `slides/_shared/roadmap.md` into
   slot 2, mark the new current week's `.wk` div `class="wk now"`.
4. If the week changes the running schema (E-R, Mapping, Normalization,
   DDL), update `slides/_shared/case-study.md`'s snapshot and lab
   artifact map, and add/update the matching seed file under
   `book/src/labs/files/labNN/`.
5. Add the public exercise restatement to `solutions/labNN/problems.md`
   and a model answer under `solutions/labNN/answer-key/` (never linked
   from public docs).
6. Preview, check against `SPINE.md`'s hard rule: no formal definition
   before slot 8. Add the deck to `landing/index.html`'s deck list.

## Status

All 15 weeks now have a lab chapter (`book/src/labs/`), a matching
rewritten deck (`slides/`), and — where the week has a graded exercise —
seed data and an answer key (`solutions/`). Restructured 2026-09 from a
slides-only theory course into this practice-heavy lab format, adopting
the structure of the sibling course `computer-programming1`: real
MySQL work starts in Lab 9, but every earlier modeling week (2, 3, 6, 7)
already has students running provided seed data against a live
database, not just reading slides.
