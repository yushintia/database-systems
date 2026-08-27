# Week 7 Handout: Normalization

Database Systems (511783-001) — for students to keep and read again.
Use plain, simple English on purpose, so it is easy to read even if
English is not your first language.

---

## 1. Glossary: Key Words This Week

Read each definition once now. You do not need to memorize them today —
you will use them all semester.

| Term | Plain definition |
|---|---|
| **Functional dependency (FD)** | A rule, written A → B, meaning one value of A always determines exactly one value of B, for every possible row |
| **1NF (First Normal Form)** | A relation where every attribute holds a single, atomic value — no repeating groups, no lists inside a cell |
| **2NF (Second Normal Form)** | A relation that is in 1NF, and where every non-key attribute depends on the *whole* primary key, not just part of it |
| **3NF (Third Normal Form)** | A relation that is in 2NF, and where no non-key attribute depends on another non-key attribute |
| **Decomposition** | Splitting one relation into two (or more), so each fact depends directly, and only, on its own relation's key |
| **Update anomaly** | One real-world fact needs updating in many places instead of one, because it was copied into many rows |
| **Deletion anomaly** | Deleting one fact by accident deletes an unrelated fact too, as a side effect |
| **Insertion anomaly** | A fact cannot be recorded at all until an unrelated fact exists first |
| **Partial dependency** | A non-key attribute that depends on only *part* of a composite primary key, not the whole key. This is what 2NF forbids |
| **Transitive dependency** | A non-key attribute that depends on another non-key attribute, instead of depending on the key directly. This is what 3NF forbids |
| **Composite primary key** | A primary key made of two or more attributes together. 2NF only matters when the key is composite |
| **Repeating group** | A list of values stored inside one cell, like `"1, 2, 7, 12"`. This is what 1NF forbids |
| **Atomic value** | A single value that cannot be usefully split further inside one cell |
| **Lossless decomposition** | A split that never loses information — every original row can always be reconstructed by joining the new relations back together |
| **BCNF (Boyce-Codd Normal Form)** | A stricter version of 3NF: for every functional dependency A → B, A must be a superkey, with no exceptions |

---

## 2. Professor Lee's Table, Worked Out Step by Step

This is the full version of the story from class. Read it slowly if the
in-class pace felt fast.

**The situation.** A well-meaning developer, trying to avoid extra
joins, builds `Section` with the instructor's and course's details
copied directly inside it:

```
Section(section_id, course_code, course_title,
        instructor_id, instructor_name, room, semester)
```

This table followed every mapping rule from Week 6. It still has a real
problem. Professor Lee gets married and changes her legal name. Every
single section she has ever taught needs its `instructor_name` updated
by hand, or the data disagrees with itself — an **update anomaly**.
Delete the last section for a retiring course, and `course_title`
disappears with it, even though the course itself should still be a
known course — a **deletion anomaly**. And a new instructor cannot be
recorded until they are assigned to at least one section, because
instructor data only exists inside section rows — an **insertion
anomaly**.

**What formal test catches this?** The root cause is a functional
dependency: `section_id → instructor_name`. Knowing the section tells
you exactly one instructor name, so that name got copied everywhere the
section appears. To see the formal test in action, apply it to another
relation from the case study: `Waitlist`, deliberately broken with the
same kind of convenience columns: `Waitlist(student_id, section_id,
student_name, course_title, position)`.

**Step 1: Check 1NF.** No repeating groups, no lists inside a cell.
Every attribute holds one atomic value. **Passes.**

**Step 2: Check 2NF.** The key is `{student_id, section_id}`. Does
`student_name` depend on the whole key, or just part of it? Just
`student_id` — the student's name does not change depending on which
section they are waitlisted for. That is a **partial dependency**, so
`Waitlist` **fails 2NF**, the exact same violation as Professor Lee's
table, one level removed.

**Step 3: Fix 2NF, then check 3NF.** Remove `student_name` (it belongs
in `Student`, reachable through `student_id`) and `course_title` (it
belongs in `Course`, reachable through `Section`). What remains:

```
Waitlist(student_id, section_id, position)
```

No non-key attribute depends on another non-key attribute. **Passes
3NF**, because nothing was ever copied across relations to begin with.

**Step 4: Compare to Week 6's original.** Week 6's mapping algorithm
produced `Waitlist(student_id, section_id, position, date_joined)`,
`PRIMARY KEY (student_id, section_id)`, directly from the E-R diagram —
almost the identical relation, reached by two different paths: deliberate
mistake then fix, versus correct derivation from the start. That
convergence is the whole point of both lectures.

The same two-step process fixes Professor Lee's original table:
`course_title` depends on `course_code`, not on `section_id` — a
transitive dependency, so it splits into `Course`. `instructor_name`
depends on `instructor_id`, not on `section_id` — another transitive
dependency, so it splits into `Instructor`. The result is exactly
Week 6's five-relation schema, and the anomalies are gone because the
dependencies that caused them no longer cross relations. Update
Professor Lee's name once, in one row, done.

**What we still can't say yet.** We now have a schema, fully
normalized, provably free of the anomalies that started this week. It
exists on paper, in this lecture's slides and your own notes. No
database anywhere actually has these tables. There is still no way to
create them, or put a single row of data in. A clean design is not the
same as a running system — that is Week 9's job.

---

## 3. Optional Reading: Extra Detail (Not Required, Not on the Quiz)

This section holds extra explanations that were trimmed from the slides
to keep class time short. Read it if you are curious or want more
examples.

**Where normalization came from.** Between 1971 and 1974, Edgar F.
Codd — the same person from Week 1's history slide, one paper later —
followed up his 1970 relational paper with a series of papers defining
normal forms: formal tests a relation could be checked against, the
same way a mathematical proof can be checked. The goal was explicit:
replace "this table looks fine to me" with a test two different people
would always agree on.

**Functional dependencies are everywhere, not just in databases.** A
barcode determines exactly one product — that is a functional
dependency you rely on at every convenience store checkout. A phone
number determines exactly one KakaoTalk account. Functional dependency
is not database-specific vocabulary; it is a name for a pattern you
already reason about daily, made precise enough to test a schema
against.

**"Is this table normalized" as a real job task.** In industry, this
exact question is a standard schema-review question, in interviews and
in real design reviews before a schema ships. Un-normalized production
tables are a common, expensive source of data-integrity bugs, usually
discovered only after launch, when fixing them means migrating live
data instead of just editing a diagram.

**BCNF exists, and you probably will not need it.** Boyce-Codd Normal
Form is a stricter version of 3NF: for every functional dependency
A → B, A must be a superkey, no exceptions, even for dependencies 3NF
quietly allows through. 3NF has one narrow edge case BCNF closes,
involving overlapping candidate keys. It is rare enough in practice
that this course tests 1NF, 2NF, and 3NF only; BCNF is here so the name
is not a surprise if you meet it later.

**Who uses this as a job.**

- **Database engineers and architects** run normalization checks as
  part of every schema review, before a design is approved for
  production
- **Backend developers** hit these anomalies directly when a "simple"
  bug report — "the instructor's name is wrong on some old sections but
  not others" — turns out to be an un-normalized table, not a typo
- **Data engineers** normalize source tables during pipeline design, so
  downstream reports do not silently disagree with each other
- **Interviewers** use "is this schema normalized, and why not" as a
  standard, quick way to check whether a candidate can reason about
  data integrity, not just write SQL syntax

---

## 4. Practice Problems (With Answers)

Try each problem yourself before checking the answer underneath it.

**Problem 1.** `Loan(isbn, member_id, book_title, member_name,
due_date)`. Identify every anomaly and normalize the relation.
> **Answer:** `book_title` depends on `isbn` alone, and `member_name`
> depends on `member_id` alone — both are partial dependencies (2NF
> violations), since the key is `{isbn, member_id}`. Update anomaly:
> changing a book's title means updating it in every loan row for that
> book. Fix: `Loan(isbn, member_id, due_date)`, with `book_title` moved
> to `Book(isbn, title)` and `member_name` moved to `Member(member_id,
> name)`.

**Problem 2.** `Employee(employee_id, department_id,
department_manager)`, where knowing the department tells you its
manager. Identify the violation and fix it.
> **Answer:** **3NF violation.** `employee_id → department_id →
> department_manager` is transitive — the manager depends on the
> department, not directly on the employee. Deletion anomaly: firing
> the last employee in a department could delete the only record of who
> manages it. Fix: move `department_manager` into its own
> `Department(department_id, manager)` relation.

**Problem 3.** `Student(student_id, name, major,
department_office)`, where `department_office` depends on `major`, not
on `student_id`. Which normal form does this violate, and what is the
fix?
> **Answer:** **3NF.** `student_id → major → department_office` is a
> transitive dependency. Update anomaly: a department's office
> location must be updated in every row of every student with that
> major. Fix: move `department_office` into a separate `Major` or
> `Department` relation, keyed on `major`.

**Problem 4.** `Enrollment(student_id, section_id, grade,
course_title)`, `PRIMARY KEY (student_id, section_id)`. Identify the
violation and fix it.
> **Answer:** **2NF violation.** `course_title` depends only on
> `section_id` (via `Section`, via `Course`), not on the full composite
> key `{student_id, section_id}` — a partial dependency. Every student
> enrolled in the same section repeats that section's course title, so
> changing the title means updating every matching enrollment row. Fix:
> `Enrollment(student_id, section_id, grade)`; `course_title` already
> lives in `Course`, reachable through `Section.course_code`.

**Problem 5.** `Section(section_id, course_code, course_title,
instructor_id, instructor_name, room, semester)`. Identify every
anomaly and fully normalize the relation.
> **Answer:** Update anomaly (an instructor's name change needs
> updating in every one of their sections), deletion anomaly (deleting
> a retiring course's last section loses `course_title`), and insertion
> anomaly (a new instructor cannot be recorded without a section). Both
> `course_title → course_code` and `instructor_name → instructor_id`
> are transitive dependencies on `section_id` — **3NF violations**. Fix:
> `Section(section_id, course_code, instructor_id, room, semester)`,
> `Course(course_code, title)`, `Instructor(instructor_id, name)` —
> exactly Week 6's five-relation schema.

**Problem 6.** `Enrollment(student_id, section_id, grade,
attendance_percent)`, `PRIMARY KEY (student_id, section_id)`. Is this
already in 2NF? Justify your answer.
> **Answer:** **Yes.** Both `grade` and `attendance_percent` depend on
> the full composite key `{student_id, section_id}` together — this
> particular student's grade and attendance in this particular section
> — not on either attribute of the key alone. No partial dependency
> exists, so no anomaly and no fix is needed here.
