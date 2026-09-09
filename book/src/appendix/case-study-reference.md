# Case Study Reference: University Course Registration

This page is the clean, student-facing version of the running case
study used throughout this course: a university's course
registration system. It follows the same schema shown in lecture, and
is the reference every lab points back to. (The authoring notes
behind this case study, including which lab seed file goes with which
week, live in the instructor-facing `slides/_shared/case-study.md` —
this page is the version meant for you to read and use.)

---

## The Starting Problem: One Spreadsheet

Before there was any database, the registration office kept a single
flat spreadsheet, `registrations.xlsx`, with one row per enrollment
and these columns:

```
student_name | student_major | course_code | course_title | instructor | room | grade
```

This spreadsheet has real, recurring problems:

- **Inconsistent data.** The same student appears as `Kim Minji`,
  `MinJi Kim`, and `김민지` in different rows — the spreadsheet has no
  way to enforce that these are the same person.
- **Deletion anomalies.** Deleting the last row for a course also
  deletes the only record of who teaches it. There is nowhere else
  that fact is stored.
- **Concurrency problems.** Two staff members edit the file at the
  same time; whoever saves second silently overwrites the other
  person's changes, with no warning.
- **No real way to ask questions.** Answering "who is enrolled in
  CSE301?" means opening the file and reading every row by eye.

Every one of these problems gets fixed by a specific idea you learn
later in the course: consistency by relational design (Weeks 2-4),
deletion anomalies by normalization (Week 7), and query difficulty by
SQL (Weeks 9-12).

---

## Target Schema (Reference This Early)

This is where the case study is headed, revealed now on purpose —
you are not expected to derive this yet. Treat it as the destination,
and each later lab as one step closer to actually building it:

```
Student(student_id PK, name, major)
Course(course_code PK, title)
Instructor(instructor_id PK, name)
Section(section_id PK, course_code FK, instructor_id FK, room, semester)
Enrollment(student_id FK, section_id FK, grade, PRIMARY KEY(student_id, section_id))
```

Five tables. `Student`, `Course`, and `Instructor` are simple:
straightforward entities with a single primary key. `Section`
represents one offering of a course (a specific room, instructor, and
semester) and carries two foreign keys. `Enrollment` is a **weak
entity**: a student registered in a section, with a grade — its
primary key is the *combination* of `student_id` and `section_id`,
because neither one alone identifies a specific enrollment. See
[E-R Notation Reference](er-notation.md) for how this weak entity is
drawn.

---

## How the Schema Evolves, Week by Week

Each lab's own chapter carries its own snapshot of this same schema;
this section is a summary of the arc.

| Week | State | What changed |
|---|---|---|
| 1 | The spreadsheet | The starting problem above; nothing normalized yet |
| 4 | E-R diagram | Entities and relationships drawn (crow's-foot notation), no tables exist yet — conceptual only |
| 6 | Mechanically mapped | The mapping algorithm turns the Week 4 diagram directly into the five relations above, with no anomalies introduced, because the diagram itself was already clean |
| 7 | Normalized (target) | A deliberately *different*, denormalized teaching example (extra copied-in columns on `Section`) is normalized back to exactly the schema above, to show what mapping mistakes elsewhere can produce and how normalization removes them |
| 9 | Real MySQL tables | The Week 7 schema is created for real with `CREATE TABLE`, in dependency order: `Student`, `Course`, `Instructor` first, then `Section`, then `Enrollment` — every table exists, zero rows in any of them |
| 10+ | Populated data | `INSERT` statements populate all five tables; every later week's worked examples (Weeks 11-15) query this same populated schema |

---

## The Waitlist Thread

Alongside the main registration schema, a second, smaller worked
example runs through the same design process: a **Waitlist** feature
for students who want into a full section. It is threaded through:

- **Week 3** (Data Modelling) — the waitlist appears as a prose
  requirement
- **Week 4** (E-R Diagram) — the waitlist is drawn into the diagram
- **Week 6** (Mapping Algorithm) — the waitlist entity is mechanically
  mapped into a relation
- **Week 7** (Normalization) — the waitlist relation is checked and
  fixed for anomalies alongside the main schema

The point of the Waitlist thread is repetition: seeing the exact same
design process (model → diagram → map → normalize) applied a second
time, on a smaller, less familiar example, so the process itself — not
just the registration schema's specific answer — is what you take
away.

---

## Where to Look Next

- [E-R Notation Reference](er-notation.md) — the diagram symbols used
  from Lab 4 onward
- [SQL Style Guide](sql-style-guide.md) — naming and formatting rules
  that this schema already follows
- Lab 9 onward — where this schema stops being paper and diagram, and
  becomes a real, running MySQL database
