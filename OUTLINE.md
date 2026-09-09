# Outline: Database Systems (511783-001)

DEU 2026-2, Mon 4-6교시 (3×50 min), 성파 702, 3rd-year. Professor:
Yushintia Pramitarini. Texts: Silberschatz; Connolly & Begg; Elmasri.

This is now a practice-heavy lab course. Every week pairs a Marp deck
(the lecture, Part A only — concept + one worked-example demo) with an
mdBook lab chapter (`book/src/labs/labNN-*.md` — the full Guided
Exercises, Challenge Problem, Practice Problems, and Submission &
Rubric). Full pedagogical rules (chain-linking, slot structure, the
"slides teach only the lab's Part A" rule) live in `SPINE.md`; this file
is the flat semester-level view.

| Wk | Topic | Lab | Deck | Format |
|---|---|---|---|---|
| 1 | Introduction | `lab01-intro-and-spreadsheet.md` | `slides/week01-introduction.md` | Orientation + hands-on spreadsheet hunt |
| 2 | Relational Model | `lab02-relational-model.md` | `slides/week02-relational-model.md` | Full |
| 3 | Data Modelling | `lab03-data-modelling.md` | `slides/week03-data-modelling.md` | Full |
| 4 | E-R Diagram | `lab04-er-diagram.md` | `slides/week04-er-diagram.md` | Full — Assignment 1 due |
| 5 | Quiz 1 (Wk 1-4) | `lab05-quiz1-review.md` | `slides/week05-quiz1-review.md` | Short review |
| 6 | Mapping Algorithm | `lab06-mapping-algorithm.md` | `slides/week06-mapping-algorithm.md` | Full |
| 7 | Normalization | `lab07-normalization.md` | `slides/week07-normalization.md` | Full |
| 8 | Midterm (Wk 1-7) | `lab08-midterm-review.md` | `slides/week08-midterm-review.md` | Short review |
| 9 | DDL | `lab09-ddl.md` | `slides/week09-ddl.md` | Full — first written SQL |
| 10 | DML | `lab10-dml.md` | `slides/week10-dml.md` | Full |
| 11 | Single-table Queries | `lab11-single-table-queries.md` | `slides/week11-single-table-queries.md` | Full |
| 12 | Multi-table Queries | `lab12-multi-table-queries.md` | `slides/week12-multi-table-queries.md` | Full — Assignment 2 due |
| 13 | Quiz 2 (Wk 9-12) | `lab13-quiz2-review.md` | `slides/week13-quiz2-review.md` | Short review |
| 14 | Case Study Presentation | `lab14-case-study-presentation.md` | `slides/week14-case-study-presentation.md` | Presentation day |
| 15 | Final Exam (Wk 1-14) | `lab15-final-review.md` | `slides/week15-final-review.md` | Short review |

## Chain (Limits → Pain), see SPINE.md for full text

1 → 2 → 3 → 4 → (5 review) → 6 → 7 → (8 review) → 9 → 10 → 11 → 12 →
(13 review) → 14 → (15 review). Weeks 2, 3, 4, 6, 7 stay conceptual in
the deck (no SQL taught as a technique yet, matching "motivation before
definition": you cannot `CREATE TABLE` a schema not yet designed) — but
their **labs** are now hands-on: students run provided, run-only seed
scripts against a real MySQL database to observe the mess before they
have the vocabulary to fix it (Lab 2's `flat_load.sql`, Lab 3's
`toy_sandbox.sql`, Lab 7's `bad_registration_seed.sql`). Students first
*write* SQL themselves in Week 9, against the registration schema
finalized in `slides/_shared/case-study.md` and republished for students
in `book/src/appendix/case-study-reference.md`.

## Running case study

University Course Registration system. Schema snapshots after Week 1
(spreadsheet), Week 4 (E-R diagram), Week 6 (mechanically mapped),
Week 7 (normalized target), Week 9 (real MySQL tables), Week 10 onward
(populated data). Parallel "Waitlist" feature threaded through Weeks
3 → 4 → 6 → 7 as a second worked example of the full design process.
Every lab-artifact seed file that materializes a snapshot is listed in
the "Lab artifact map" at the top of `slides/_shared/case-study.md`.

## Book, solutions, and site layout

- `book/` — the mdBook lab manual: `src/introduction.md`, `src/setup/`
  (MySQL & Workbench install, how a database runs), `src/labs/`
  (`lab01`..`lab15`, one per week, plus `src/labs/files/` for seed
  `.sql`/`.csv` data), `src/appendix/` (SQL style guide, grading rubric,
  troubleshooting, E-R notation reference, case-study reference,
  further reading).
- `solutions/labNN/` — `problems.md` (public restatement of that lab's
  exercises) + `answer-key/` (professor-only model answers, never built
  or published).
- `landing/index.html` — site root, links the book and every deck.

## Status

Restructured 2026-09 from a slides-only theory course into this
practice-heavy lab format, adopting the structure of the sibling course
`computer-programming1` (mdBook lab manual + per-week `solutions/` +
unified GitHub Pages deploy). All 15 weeks have a lab chapter, a
rewritten deck, and (where applicable) seed data and an answer key.
