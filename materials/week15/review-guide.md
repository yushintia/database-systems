# Week 15 Review Guide: Final Exam (Weeks 1-14)

Same questions as the "Check Yourself" section of the Week 15 slides,
with fuller worked explanations than fit on a slide. Organized by week.

The Final Exam is **written, individual, closed book**, and
**comprehensive**: Weeks 1-14, the same 30% weight as the Midterm (Week
1's grading table). It is not weighted toward any one stretch of the
semester the way the Midterm review was — the deck's own recap slides
cover Foundations (1-2), Design (3-4), Mechanics (6-7), Building It
(9-10), and Asking Questions (11-12) in equal measure, and its sample
questions are deliberately spread the same way, several of them tracing
one fact across several weeks at once rather than testing one week in
isolation. Expect questions that ask you to follow a single requirement
from a real-world sentence all the way to a working SQL query, not just
to recall one week's definition on its own.

---

## Week 1: Introduction

**Q1. A student asks: "why did we spend four weeks (2-4) on paper before writing a single line of SQL?" Answer in the spine's own terms.**

> **Answer:** Motivation and design must come before implementation —
> this course's own stated principle. Week 9's `CREATE TABLE` needs a
> normalized schema to already exist; skipping straight to SQL would
> mean building on an unverified, possibly anomaly-ridden design,
> exactly what Weeks 6 and 7 exist to prevent.

**Why:** Week 1's own three-goal table lists "design databases with
E-R diagrams and normalization" (Weeks 3-7) as its second goal,
deliberately positioned before the SQL goal even gets built out (Weeks
9-12), even though "learn... SQL" is listed first in the syllabus's own
wording. The course's driving question — "what must a system do,
before we can trust it with data that matters?" — gets answered in
stages, each one closing a gap the previous stage left open: Week 2
fixes the vocabulary problem (what is a table, precisely), Week 3 fixes
the process problem (which tables, and why), Week 4 fixes the notation
problem (a design two people can actually verify), Week 6 fixes the
translation problem (diagram to schema, mechanically, no guessing), and
Week 7 fixes the quality problem (anomaly-free, not just valid). Only
once all five of those are settled does Week 9's `CREATE TABLE` have
something worth building permanently. Writing SQL straight from a
requirements sentence just moves last week's mess into MySQL faster —
Week 7's own pain-slide table (`Section` with `course_title` and
`instructor_name` copied in) is exactly what "skip the paper stage"
produces, once nobody has checked functional dependencies first.

**Common mistake:** Treating "why paper first" as a vague process
question and answering "design is good practice" instead of naming the
*specific* later cost it prevents. A full-credit answer names the
anomaly (update/deletion, Week 7) or the ordering failure (Week 9's
`CREATE TABLE` needing a normalized schema already in hand) that
skipping the paper stage would cause.

---

## Week 2-4: Relational Model, Data Modelling & E-R Diagram

**Q2. Trace one fact, an instructor's office room, through the entire semester: where does it live at the conceptual stage, the logical stage, and finally, in SQL?**

> **Answer:**
> - **Conceptual (Week 4):** an attribute of the Instructor entity.
> - **Logical/relational (Weeks 2-3, produced mechanically by Week 6):**
>   a column, `Instructor(instructor_id, name, office)`.
> - **SQL (Weeks 9-10):**
> ```sql
> ALTER TABLE Instructor ADD COLUMN office VARCHAR(20);
> UPDATE Instructor SET office = '성파 702' WHERE instructor_id = 1;
> ```

**Why:** This question is really Week 3's three design stages
(conceptual &rarr; logical &rarr; physical) applied to one concrete
fact, with "SQL" standing in for the physical stage's real
realization. At the conceptual stage (Week 4), `office` is just a
simple attribute hanging off the Instructor entity — no data type, no
table, just a real-world fact worth tracking. Week 6's mapping
algorithm (Rule 1: every strong entity becomes its own relation, its
attributes becoming the relation's attributes) turns that into a
column on the logical `Instructor` relation, still only on paper. Only
in Week 9 does the column become real — via `CREATE TABLE` if `office`
was known from the start, or via `ALTER TABLE ADD COLUMN` if the
requirement arrived later — and only in Week 10's `UPDATE` does a
specific row's value actually get filled in. The same fact is never
reinvented; it is carried, unchanged in meaning, through four
different notations. That is the "one continuous chain, not fourteen
topics" argument the whole course makes, made concrete for a single,
traceable value.

**Common mistake:** Jumping straight to the SQL answer and skipping the
conceptual and logical stages by name — exactly the "treating each
week as an island" mistake the Week 15 deck warns against. A complete
answer names all three stages, in order, not just the final command.

---

## Week 7: Normalization

**Q3. A table `Section(section_id, course_code, course_title, instructor_id, room)` is proposed. Identify the normalization violation, name the anomaly it causes, and write the corrected schema.**

> **Answer:** `course_title` is transitively dependent on `course_code`
> (a **3NF** violation), causing an **update anomaly** if a course is
> renamed. Corrected schema:
> ```
> Course(course_code, title)
> Section(section_id, course_code, instructor_id, room)
> ```

**Why:** A relation is in 3NF if it is in 2NF and no non-key attribute
depends on another non-key attribute. Here, `section_id &rarr;
course_code` (every section belongs to exactly one course), and
`course_code &rarr; course_title` (every course code determines exactly
one title). Chaining those two arrows gives `section_id &rarr;
course_title`, but only **transitively**, through `course_code` —
`course_title` does not depend on `section_id` directly, it depends on
whichever course that section happens to belong to. This is exactly
the shape of Week 7's own pain-slide table, and exactly what Week 6's
closing warning means by "a mechanically valid schema is not
automatically a good one": every mapping rule was followed correctly,
and the anomaly is still there. The fix follows the course's standard
two-step decomposition: find the violating dependency, then split the
relation so the dependent attribute (`course_title`) lands where it
depends on a key **directly** (`Course`, via `course_code &rarr;
title`), leaving `Section` with only what still depends on its own key.

**Common mistake:** Calling this a 2NF violation instead of 3NF. 2NF
specifically concerns a *composite* primary key's parts (partial
dependency); `Section.section_id` here is a single-column key, so 2NF
is automatically satisfied. The actual violation is a transitive
dependency between two non-key attributes (`course_code` and
`course_title`) — precisely what 3NF, not 2NF, tests for.

---

## Week 9: DDL

**Q4. Which single MySQL constraint, introduced in Week 9, enforces Week 2's referential integrity automatically?**

> **Answer:** `FOREIGN KEY ... REFERENCES ...`. MySQL rejects any
> `INSERT` or `UPDATE` that would create a foreign key value with no
> matching primary key in the referenced table.
> ```sql
> CREATE TABLE Section (
>     section_id INT AUTO_INCREMENT PRIMARY KEY,
>     course_code VARCHAR(10),
>     instructor_id INT,
>     room VARCHAR(20),
>     semester VARCHAR(20),
>     FOREIGN KEY (course_code) REFERENCES Course(course_code),
>     FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
> );
> ```

**Why:** Week 2 defined referential integrity as a rule — "every
foreign key value must match an existing primary key value in the
referenced relation, or be left empty" — with no enforcement mechanism
attached; it was a promise a designer had to keep by hand. Week 9's
`FOREIGN KEY ... REFERENCES ...` clause is where that promise becomes
something MySQL itself checks, on every `INSERT` and `UPDATE`, not
just at design-review time. It is also what forces Week 9's table
creation order (`Course` and `Instructor` before `Section`, because a
`FOREIGN KEY` cannot reference a table that does not exist yet) and,
running the other direction, Week 10's delete protection (MySQL
rejects deleting an `Instructor` row still referenced by a `Section`
row). One constraint, declared once, enforced automatically in both
directions, at both DDL time and DML time.

**Common mistake:** Answering `PRIMARY KEY` instead of `FOREIGN KEY`.
`PRIMARY KEY` enforces Week 2's *key* constraint — no duplicate primary
key values within one relation — and says nothing about whether a
value in a *different* table points at something real. Referential
integrity is specifically a cross-relation rule, so it needs the
cross-relation constraint.

---

## Week 12: Multi-table Queries

**Q5. Write a single query returning each major and its average grade point, for majors with more than 10 enrolled students.**

> **Answer:**
> ```sql
> SELECT Student.major, AVG(gp.points) AS avg_gp
> FROM Student
> JOIN Enrollment ON Student.student_id = Enrollment.student_id
> JOIN GradePoints gp ON Enrollment.grade = gp.grade
> GROUP BY Student.major
> HAVING COUNT(*) > 10;
> ```

**Why:** This stacks three Week 12 ideas in the order they always
compose: (1) `JOIN` to reach across tables — `Student` alone has no
`grade`, `Enrollment` alone has no `major`, so both must be joined
before either can be filtered or aggregated together; (2) `GROUP BY
Student.major` clusters the joined rows into one bucket per major,
the same shape as Week 12's own `major, COUNT(*)` example; (3) `HAVING
COUNT(*) > 10` filters those **groups**, not individual rows —
`WHERE COUNT(*) > 10` would be invalid here, since `COUNT(*)` does not
exist until grouping has already happened. (`GradePoints(grade,
points)` is a small lookup table translating letter grades like `A0`
or `B+` into a number, e.g. `points = 4.0` for `A0`; it sits outside
the case study's core five tables, but it is exactly how a real
registration system would turn `Enrollment.grade` — stored as text —
into something `AVG()` can operate on.) `AVG(gp.points)` is Week 12's
fourth aggregate function, computing the actual grade-point average
once the join has put both `major` and `points` on the same row.

**Common mistake:** Writing `WHERE COUNT(*) > 10` instead of `HAVING
COUNT(*) > 10` — Week 12's own Check Yourself slide calls out exactly
this error. A second common mistake: skipping the join to
`GradePoints` and trying `AVG(Enrollment.grade)` directly, which fails
or produces nonsense, because `grade` is text, not a number.

---

## Quick Self-Test

Cover every answer above and re-derive it from scratch:

- **Q1:** Why paper before SQL — name the *specific* Week 7 anomaly or
  Week 9 ordering failure it prevents, not just "design is good
  practice."
- **Q2:** The office-room trace — name conceptual, logical, and SQL in
  order, for the same fact, without skipping a stage.
- **Q3:** The transitive-dependency violation — explain *why* it's 3NF
  and not 2NF, not just which one it is.
- **Q4:** The `FOREIGN KEY` constraint — and why `PRIMARY KEY` alone
  is the wrong answer.
- **Q5:** The `JOIN` + `GROUP BY` + `HAVING` query — build it from the
  one-sentence question, before looking at the SQL.

These five are exactly the questions the Week 15 deck itself uses to
represent the whole semester's argument. Losing points on the final
almost always means recalling one week's definition in isolation
instead of tracing a fact across the weeks that built it — that is the
single most common source of lost points on this exam.
