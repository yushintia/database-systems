# Outline: Database Systems (511783-001)

DEU 2026-2, Mon 4-6교시 (3×50 min), 성파 702, 3rd-year. Professor:
Yushintia Pramitarini. Texts: Silberschatz; Connolly &amp; Begg; Elmasri.

Full pedagogical rules (chain-linking, slot structure) live in
`SPINE.md`; this file is the flat semester-level view.

| Wk | Topic | Deck | Format |
|---|---|---|---|
| 1 | Introduction | `slides/week01-introduction.md` | Full |
| 2 | Relational Model | `slides/week02-relational-model.md` | Full |
| 3 | Data Modelling | `slides/week03-data-modelling.md` | Full |
| 4 | E-R Diagram | `slides/week04-er-diagram.md` | Full — Assignment 1 due |
| 5 | Quiz 1 (Wk 1-4) | `slides/week05-quiz1-review.md` | Short review |
| 6 | Mapping Algorithm | `slides/week06-mapping-algorithm.md` | Full |
| 7 | Normalization | `slides/week07-normalization.md` | Full |
| 8 | Midterm (Wk 1-7) | `slides/week08-midterm-review.md` | Short review |
| 9 | DDL | `slides/week09-ddl.md` | Full — first real MySQL |
| 10 | DML | `slides/week10-dml.md` | Full |
| 11 | Single-table Queries | `slides/week11-single-table-queries.md` | Full |
| 12 | Multi-table Queries | `slides/week12-multi-table-queries.md` | Full — Assignment 2 due |
| 13 | Quiz 2 (Wk 9-12) | `slides/week13-quiz2-review.md` | Short review |
| 14 | Case Study Presentation | `slides/week14-case-study-presentation.md` | Presentation day |
| 15 | Final Exam (Wk 1-14) | `slides/week15-final-review.md` | Short review |

## Chain (Limits → Pain), see SPINE.md for full text

1 → 2 → 3 → 4 → (5 review) → 6 → 7 → (8 review) → 9 → 10 → 11 → 12 →
(13 review) → 14 → (15 review). Weeks 2, 3, 4, 6, 7 stay conceptual, no
SQL, matching "motivation before definition": you cannot `CREATE TABLE`
a schema not yet designed. Real MySQL starts Week 9 against the
registration schema finalized in `slides/_shared/case-study.md`.

## Running case study

University Course Registration system. Schema snapshots after Week 1
(spreadsheet), Week 4 (E-R diagram), Week 6 (mechanically mapped),
Week 7 (normalized target), Week 9 (real MySQL tables), Week 10 onward
(populated data). Parallel "Waitlist" feature threaded through Weeks
3 → 4 → 6 → 7 as a second worked example of the full design process.

## Status

All 15 weeks drafted, built, and timed. See build history: Week 1 is
the depth reference (~116 min of the 150-min block); Weeks 2-4/6/7/9-12
run 70-82 min after two expansion passes (content depth, then
step-by-step demos); review weeks (5/8/13/15) run 39-45 min by design,
leaving room for the actual quiz/exam inside the block.
