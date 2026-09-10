# Introduction

**Course:** 511783-001 Database Systems
**Professor:** Yushintia Pramitarini
**Year / Semester:** 2026 · Semester 2
**Format:** 15 meetings × 3 × 50 min · System: MySQL 8.x

---

## How This Book Fits With the Slide Decks

This course has two halves, and they are deliberately not the same
document.

- **The slide decks** are Part A: the lecture. Each deck opens with a
  concrete pain point in the running case study, motivates one idea,
  defines it, and walks a worked example. Decks are what happens in
  the room during lecture time.
- **This lab manual** is Part B and beyond: the full guided exercises,
  challenge problems, worked solutions, and grading rubrics. **The
  decks do not repeat this content, and this book does not repeat the
  decks.** If you only read the slides, you have seen the idea once.
  You learn it by working through the lab that goes with it.

Put plainly: **the deck teaches the concept, the lab is where you
build it.** Every week of this course pairs one slide deck with one
lab chapter in this book. Come to lecture having skimmed the previous
lab's "Further reading"; leave lecture and do the current week's lab
before the next session.

> **In plain words: lab manual**
> A lab manual is a workbook. Instead of just describing what a
> database is, it gives you exercises to actually build one, one
> small piece at a time, so the ideas stick.

---

## Who This Manual Is For

This manual assumes you have already taken Computer Programming I &
II, Data Structures, and Discrete Mathematics. It does not teach you
to program from zero. It does assume you have written a working
program before and can read simple pseudocode.

What it does *not* assume is any prior database experience. If the
word "schema" or "normalization" means nothing to you yet, that is
completely normal in week 1. By week 9 you will be writing real SQL
against a real MySQL server, and by week 14 you will be presenting a
small database design of your own.

---

## Course Description

This course introduces the principles of database systems: how data
is modeled, organized, and queried, so that it stays correct,
consistent, and useful as it grows. It covers data models and the
relational model, entity-relationship design and normalization, and
SQL for defining, changing, and querying data — working throughout
from one running case study: **university course registration**.

### Learning Objectives

By the end of this course, you can:

1. Explain why plain files and spreadsheets fail as data grows, and
   what a database promises instead.
2. Model real-world requirements as an entity-relationship (E-R)
   diagram.
3. Design relational schemas and apply normalization to remove
   anomalies.
4. Write SQL to define (DDL) and change (DML) data.
5. Write single-table and multi-table SQL queries to answer real
   questions.
6. Read and explain a relational schema using precise vocabulary:
   keys, constraints, and normal forms.
7. Present a small database design as a finished case study.

### Textbooks

- **Primary:** Silberschatz, Korth, Sudarshan, *Database System
  Concepts*, 7th ed., McGraw-Hill, 2019
- **Secondary:** Connolly & Begg, *Database Systems*; Elmasri &
  Navathe, *Fundamentals of Database Systems*
- **Also:** the lecture slides themselves are a listed course
  reference

Full citations and chapter mappings are in
[Appendix: References](appendix/references.md).

---

## The Running Case Study

Nearly every lab in this book works on the same fictional problem: a
university's course registration system, starting life as a single
messy spreadsheet and ending the semester as a real MySQL database
with populated tables and working queries. You will meet:

- **Student**, **Course**, **Instructor**, **Section**, and a weak
  entity, **Enrollment** (a student registered in a section, with a
  grade)
- A recurring secondary example, a **Waitlist** feature, threaded
  through weeks 3, 4, 6, and 7 as a second, smaller worked example of
  the same design process

The schema evolves on purpose: it starts as a flat spreadsheet
(week 1), becomes a hand-drawn E-R diagram (week 4), gets mechanically
mapped into tables (week 6), gets normalized to remove anomalies
(week 7), and finally becomes real, running MySQL (starting week 9).

**Real MySQL work — actually typing SQL against a running server —
starts in Lab 9.** Weeks 1 through 8 are deliberately conceptual: you
cannot `CREATE TABLE` a schema you have not designed yet. See
[Appendix: Case Study Reference](appendix/case-study-reference.md)
for the full schema snapshots, and
[Appendix: E-R Notation](appendix/er-notation.md) for the diagram
notation used from Lab 4 onward.

---

## Weekly Schedule

| Wk | Topic | Wk | Topic |
|---|---|---|---|
| 1 | Introduction | 9 | DDL — first real MySQL |
| 2 | Relational Model | 10 | DML |
| 3 | Data Modelling | 11 | Single-table Queries |
| 4 | E-R Diagram — **Assignment 1 due** | 12 | Multi-table Queries — **Assignment 2 due** |
| 5 | **Quiz 1** | 13 | **Quiz 2** |
| 6 | Mapping Algorithm | 14 | Case Study Presentation |
| 7 | Normalization | 15 | **Final Exam** |
| 8 | **Midterm Exam** | | |

Weeks 2, 3, 4, 6, and 7 stay conceptual, with no SQL: you design and
reason about the schema on paper before you ever run a query against
it. This matches the course's guiding rule, *motivation before
definition* — you meet the problem before you meet the tool that
solves it.

---

## How to Use a Lab

Each lab page in this book follows a consistent template so you always
know what to expect:

1. **Header:** week, topic, duration, prerequisites
2. **Learning outcomes:** what you will be able to do by the end
3. **Recap:** one paragraph connecting to the prior week
4. **Background:** concise theory, with `> **In plain words: X**`
   boxes for any new term
5. **Worked example:** the running case study, continued from the
   prior week
6. **Guided exercises:** the graded deliverable for the week
7. **Challenge problems:** optional, harder tasks
8. **Common mistakes:** the errors almost everyone makes on this topic
9. **Submission and rubric:** what to submit and how it is scored
10. **Further reading:** mapped textbook sections

> **In plain words: guided exercise**
> A guided exercise is a task with clear step-by-step instructions
> that still asks you to produce something yourself — a diagram, a
> query, a table definition. It is not a lecture demo you just watch;
> it is a graded deliverable you build.

---

## Grading

| Item | Weight |
|---|---|
| Attendance | 10% |
| Midterm | 30% |
| Final | 30% |
| Assignments | 10% |
| Presentation | 10% |
| In-class items | 10% |

**Grade distribution guideline:** A ≤30%, B ≤40%, C-F ≤30% of the
class. This may shift after the add/drop period, based on final
enrollment.

Full rubrics — the general per-lab point split, the week 14
presentation rubric, and the grading philosophy behind both — are in
[Appendix: Grading Rubrics](appendix/grading-rubric.md).

### Assignments

| # | Released | Due | Topic |
|---|---|---|---|
| 1 | Wk 2 | Wk 4 | E-R diagram design for a small system |
| 2 | Wk 9 | Wk 12 | SQL: schema, data, and multi-table queries |

### Feedback Policy

Assignments are graded within one week with a rubric and model
answers. Exam item-analysis is shared with weak-topic guidance, and
individual review is available on request. In plain terms: you will
know what you got wrong, and why, quickly enough for it to still
matter for the next assignment or exam.

---

## Attendance & Late Work

- **Attendance** is 10% of your grade and is recorded every session.
- **Late arrival:** arriving within 15 minutes of the start is
  on-time; after that, you're marked late. Three lates equal one
  absence.
- **Can't attend?** Email the instructor *before* the session to be
  marked excused — unexcused absences aren't eligible for makeup
  credit.
- **Late work:** loses 10% of that assignment's grade per day late,
  up to 3 days. No credit after 3 days, unless arranged with the
  instructor in advance.

---

## Academic Integrity

- Submit your own work. Copying another student's work, having
  someone else complete it for you, or submitting unattributed
  AI-generated work as your own is a violation.
- **First violation:** zero credit on that assignment or exam, plus a
  formal report. **Repeat violation:** may result in failing the
  course, per university policy.
- If anything here is unclear, ask — now is the cheapest time to ask.

---

## Support for Students with Disabilities

- **Hearing-impaired:** front-row seating, lecture material files
  provided where possible, urgent notices given in writing
- **Mobility-impaired:** extended exam time
- **Other documented conditions:** extended exam time, materials
  provided in advance, enlarged exam copies, or other reasonable
  accommodation based on need

Contact the instructor early, and the Disability Student Support
Center or Academic Affairs Team, so accommodations are ready before
you need them.

---

## Contact

- **Email:** yushintia@deu.ac.kr
- **Office hours:** by email appointment
- Email is the fastest way to reach the instructor outside of class.

---

## Before Lab 1

You do not need MySQL installed yet — real MySQL work does not start
until Lab 9. But it is worth setting it up early so it is one less
thing to worry about later. See
[Setup: MySQL & Workbench](setup/mysql-workbench.md) when you are
ready, and [Setup: How a Database Runs](setup/how-a-database-runs.md)
for the mental model behind what you are installing.
