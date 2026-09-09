<!--
Running case study: University Course Registration.
Grows across the semester. Update this file whenever a week changes the
schema, and copy the *current* snapshot into that week's worked-example
slide so decks stay self-contained (Marp has no live includes).

Each snapshot below now also names the lab artifact that makes it real
for students to touch, not just read. Seed files live under
`book/src/labs/files/labNN/`; every seed is idempotent
(`DROP DATABASE IF EXISTS ...; CREATE DATABASE ...; USE ...;`) so it can
be re-run safely. This is the single source of truth for which seed goes
with which week — lab pages and slide decks both link back here.
-->

## Lab artifact map

| Week | Snapshot | Lab artifact |
|---|---|---|
| 1 | The spreadsheet | `book/src/labs/files/lab01/registrations.csv` |
| 2 | One raw table, run-only | `book/src/labs/files/lab02/flat_load.sql` |
| 3 | Interview + toy sandbox | `book/src/labs/files/lab03/interview_transcript.md`, `book/src/labs/files/lab03/toy_sandbox.sql` |
| 4 | E-R diagram (drawn by students) | student-produced `lab04_er.png`/`.drawio`, no seed |
| 6 | Mechanically mapped (reference) | `book/src/labs/files/lab06/target_schema.sql` |
| 7 | Denormalized teaching example | `book/src/labs/files/lab07/bad_registration_seed.sql` |
| 9 | Empty database, students write DDL | `book/src/labs/files/lab09/reset.sql` |
| 10 | Catch-up schema for failed Week 9 builds | `book/src/labs/files/lab10/catchup_schema.sql` |
| 11+ | Full populated schema (~200+ rows) | `book/src/labs/files/lab11/full_seed.sql` (Lab 12 reuses this file) |

## State after Week 1: the spreadsheet

One flat spreadsheet, `registrations.xlsx`, columns:

```
student_name | student_major | course_code | course_title | instructor | room | grade
```

Known problems (referenced by Week 1 slot 4/5, resolved gradually through
the semester):

- "Kim Minji" appears as `Kim Minji`, `MinJi Kim`, `김민지` in different rows
  → redundancy / inconsistency (fixed by relational design, Weeks 2-4)
- Deleting the last row for a course deletes the only record of who
  teaches it → deletion anomaly (fixed by normalization, Week 7)
- Two staff edit the file at once, one save silently overwrites the other
  → concurrency (previewed Week 1, fully addressed later in course)
- No way to ask "who is enrolled in CSE301?" without opening the file and
  reading every row by eye → access difficulty (fixed by SQL, Weeks 9-12)

## Target end state (by Week 7, normalized schema)

```
Student(student_id PK, name, major)
Course(course_code PK, title)
Instructor(instructor_id PK, name)
Section(section_id PK, course_code FK, instructor_id FK, room, semester)
Enrollment(student_id FK, section_id FK, grade, PRIMARY KEY(student_id, section_id))
```

Reference this target from Week 1 (slot 11, worked example) as "where
we're headed", do not derive it yet.

## State after Week 4: E-R diagram (conceptual, no tables yet)

Entities: Student, Course, Instructor, Section, Enrollment (weak).
Relationships: Student M:N Section (via weak entity Enrollment),
Section N:1 Course, Section N:1 Instructor. No relations exist yet;
this is deliberately still prose-and-diagram only, per the spine's
"motivation before definition" rule. Week 6 mechanically derives the
relations below from exactly this diagram.

## State after Week 6: mechanically mapped (pre-normalization)

Same five relations as the Week 7 target above; the mapping algorithm
(strong entity to relation, weak entity to composite-key relation, 1:N
to a foreign key, M:N to a new relation) produces this schema directly
from the Week 4 diagram, with no anomalies introduced, because the
diagram itself was already clean. Week 7 uses a deliberately
*different*, denormalized `Section` (with `course_title` and
`instructor_name` copied in) purely as a teaching example of what
mapping mistakes elsewhere can produce, then normalizes it back to
this exact schema.

## State after Week 9: real MySQL tables (empty)

The Week 7 schema, created for real via `CREATE TABLE`, in dependency
order: `Student`, `Course`, `Instructor` first (no foreign keys), then
`Section` (references `Course`, `Instructor`), then `Enrollment`
(references `Student`, `Section`). Every table exists; zero rows in
any of them until Week 10's DML.

## State from Week 10 onward: real data

`INSERT` statements populate all five tables. From here on, every
week's worked example (Weeks 11-15) queries this same populated
schema; no further structural changes occur unless a week's lecture
explicitly says so.
