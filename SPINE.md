# The Spine: Standard Structure for Every Lecture Week

Database Systems (511783-001), 2026-2. This document is the standard. Every
week's deck (`slides/weekNN-*.md`) must follow it. If a deck and this
document disagree, fix the deck.

## Slides teach the lab's Part A, nothing more

This course now runs as a practice-heavy lab course (see `book/`, the
mdBook lab manual). Every week's deck is the **lecture version of that
week's lab's Part A** (`book/src/labs/labNN-*.md`) — the concept intro
and one worked-example demo, ~50 minutes. The lab page owns everything
else: Guided In-Lab Exercises (Parts B/C), the Challenge Problem, the
Practice Problems, and the Submission & Rubric. A deck must never
introduce content the matching lab page doesn't have; if a deck needs a
new example or explanation, add it to the lab page first, then bring it
into the deck. Concretely, per slot:

- Slot 4 (Pain) = the lab's own hook / "Why this lab matters" framing.
- Slot 7 (Learning outcomes) = the lab's own Learning Outcomes.
- Slot N-2 (Worked example) = one of the lab's own Worked Examples,
  walked the same way (line by line where the lab does).
- Slot N-1 (Common mistakes) = a subset of the lab's Common Pitfalls table.
- Slot N+3 (Summary) names the lab page path so students know where the
  exercises live.

## Principle

**Motivation always precedes definition.** A student should never meet a
term before meeting the concrete problem that forced someone to invent it.
Every week opens with a broken scenario in plain language, not a formal
statement.

**Weeks chain.** The "Limits" slide that closes week N is, almost verbatim,
the "Pain" slide that opens week N+1. The semester should read as one
argument, not fourteen independent talks.

## The 17 slots

Acts 0, 1, 2, 4 are **mandatory and fixed**: same slot numbers, same order,
every full-spine week. Act 3 (Build) expands or contracts to fit the topic.

### Act 0: LOCATE

| # | Slide | Rule |
|---|---|---|
| 1 | Title | Week #, topic, course code, instructor, date |
| 2 | Where we are | Shared roadmap graphic (`_shared/roadmap.md`), current week highlighted |
| 3 | Recap + open wound | One sentence on what last week delivered, one sentence on what it left broken |

### Act 1: MOTIVATE

| # | Slide | Rule |
|---|---|---|
| 4 | The pain | Concrete broken scenario in the running case study. **Zero jargon.** If a technical term appears here, the slide is wrong |
| 5 | Cost of not knowing | What breaks downstream (wrong data, lost work, slow systems) *and* where this bites in industry (interviews, real outages, job requirements) |
| 6 | Driving question | One sentence the week must answer. Repeat it verbatim on any section-divider slide inside Act 3 |
| 7 | Learning outcomes | 3–4 verbs, each traceable to a syllabus objective |

**Hard rule:** no formal definition before slot 8. If you need one earlier,
the pain slide (4) is too abstract, so fix it instead of breaking the rule.

### Act 2: GROUND

| # | Slide | Rule |
|---|---|---|
| 8 | Origin | Who, when, what forced it. Ideas are answers to historical pain, not arbitrary convention |
| 9..9+k | Core concept(s) | The week's formal definitions, grouped by real conceptual closeness (closely related terms may share a slide, they don't need to be split apart one-per-slide). Hard rule: no formal claim may sit further than one slide away from a concrete instantiation of it. A short definition gets a compact inline example on the same bullet; a definition needing real elaboration gets its own dedicated example slide immediately after it |

### Act 3: BUILD (flexible)

| # | Slide | Rule |
|---|---|---|
| 9+k+1..N-3 | Mechanics | Stepwise, as many slides as the topic needs |
| N-2 | Worked example | Same University Course Registration case study, continued from prior weeks; see `_shared/case-study.md` |
| N-1 | Common mistakes | Anti-patterns and why each is tempting |
| N..N+j | Sample question(s) | 2-3 worked questions, the same reasoning shape a real quiz question takes, each titled `Sample Question <n>` with its answer shown on the *same* slide, taught through rather than quizzed |

### Act 4: CLOSE

| # | Slide | Rule |
|---|---|---|
| N+j+1 | Limits | What this week's technique cannot do. **This text becomes next week's slot 4** |
| N+j+2 | Bridge | "Week N leaves X unsolved → Week N+1 addresses it." Explicit, one sentence |
| N+j+3 | Summary | Takeaways + reading assignment + what to prepare |
| N+j+4 | Thank You | Template end slide |

## The semester chain

| Wk | Topic | Limit (leads to next pain) |
|---|---|---|
| 1 | Introduction | **Orientation variant** (contract-only: course policy, grading, schedule; no worksheet, no quiz; handout only). We don't yet know why plain files or spreadsheets break, or what a database promises instead → **W2** |
| 2 | Relational Model | Tables are the target; nothing says *which* tables → **W3** |
| 3 | Data Modelling | Conceptual model is prose, not executable, not verifiable → **W4** |
| 4 | E-R Diagram | A diagram is not a database; no DBMS runs a diagram → **W6** |
| 5 | Quiz 1 | review only, no chain link |
| 6 | Mapping Algorithm | Mechanically mapped tables still carry update/insert/delete anomalies → **W7** |
| 7 | Normalization | Clean schema on paper, no way to create it or load data → **W9** |
| 8 | Midterm | review only, no chain link |
| 9 | DDL | Structure exists, but it's empty → **W10** |
| 10 | DML | Data is in, but no way to ask questions of it → **W11** |
| 11 | Single-table Queries | Real questions span multiple tables → **W12** |
| 12 | Multi-table Queries | Correct answers, but nothing about failure, concurrency, or scale → **W14** |
| 13 | Quiz 2 | review only, no chain link |
| 14 | Case Study Presentation | Students present; instructor closes remaining gaps → **W15** |
| 15 | Final Exam | review only, no chain link |

Weeks 5, 8, 13, 15 use the **short review variant**: Act 0 (slots 1-3) +
Act 3 slot "Sample question(s)" (expanded into a full set of review
questions) + Act 4 (slots N+j+1..N+j+4, "Limits" replaced by "What to
focus on next"). No Pain or Ground acts: there is no new concept to
motivate.

Week 1 uses the **orientation variant**: a pure course-contract session
(department standard, matching the sibling courses). It is course
description, objectives, prerequisites, textbook, schedule, grading,
assignments, and policy - near-zero technical content, a light
non-technical tease of the running case study, and a discussion-prompt
slide (not answered) that Week 2 opens by answering. It closes with the
standard Limits → Next Week → Summary → Thank You, same as every other
week, so the chain into Week 2 still holds. It has no Pain/Cost/Origin/
Build/Worked-example/Common-mistakes/Sample-question acts in the deck. It
still gets one hands-on tie-in in the book: `book/src/labs/
lab01-intro-and-spreadsheet.md` has students hunt for the spreadsheet's
own problems (inconsistent names, a deletion anomaly, a concurrent-edit
overwrite) by hand, no SQL yet. `book/src/introduction.md` carries the
course handbook content (schedule, grading, policy) that used to live in
a standalone Week 1 handout.

## Enforcement

- Copy `slides/_template/week-XX.md` for every new week. It carries all 17
  slots as HTML comments; fill them in, don't renumber them.
- `slides/_shared/roadmap.md`: single source for the Act 0 roadmap graphic.
- `slides/_shared/case-study.md`: the registration-system schema as it stands
  after each week; update it when a week changes the schema (E-R, Mapping,
  Normalization, DDL weeks).
- Course logistics (grading, textbook, policies) are the entire content of
  Week 1 (the orientation variant above). For every other week, they must
  never appear at all - administrative content lives only in Week 1.
