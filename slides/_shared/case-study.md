<!--
Running case study: University Course Registration.
Grows across the semester. Update this file whenever a week changes the
schema, and copy the *current* snapshot into that week's worked-example
slide so decks stay self-contained (Marp has no live includes).
-->

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
