# Lab 15: Final Review

| | |
|---|---|
| **Week** | 15 |
| **Duration** | 150 min (single continuous block) |
| **Method** | Examination (written) |
| **Scope** | Weeks 1-14, comprehensive |
| **Weight** | **30%** of final grade (same weight as the Midterm — see [Grading Rubrics](../appendix/grading-rubric.md)) |

**Time allocation**

| Phase | Min | Activity |
|---|---:|---|
| Review | 30 | Recap by unit, sample questions, common mistakes |
| Final Exam | 110 | Written, individual, closed book |
| Buffer | 10 | Collect papers, wrap-up |

---

## What This Exam Is

The Final Exam is **written, individual, closed book**, and
**comprehensive**: Weeks 1-14, the same 30% weight as the Midterm. It
is not weighted toward any one stretch of the semester the way the
Midterm review was — Foundations (1-2), Design (3-4), Mechanics
(6-7), Building It (9-10), and Asking Questions (11-12) are covered
in roughly equal measure, and several sample questions deliberately
trace one fact across several weeks at once rather than testing one
week in isolation.

Expect questions that ask you to follow a single requirement from a
real-world sentence all the way to a working SQL query, not just to
recall one week's definition on its own. There is no separate
live-coding or presentation component this week — Week 14 was that
application, applied once, by you.

This page has no Guided Exercises, Challenge Problem, or graded
rubric of its own. Everything below is ungraded self-check, with
answers shown immediately.

---

## What to Review, By Unit

### Foundations (Weeks 1-2)

- A DBMS solves seven specific failures of file-processing systems:
  redundancy, difficulty accessing data, isolation, integrity,
  atomicity, concurrency, security
- Three abstraction levels: physical, logical, view
- A **relation**: a set of tuples, no duplicates, no meaningful
  order, with superkeys, candidate keys, a primary key, and foreign
  keys

### Design (Weeks 3-4)

- Three design stages: **conceptual, logical, physical**
- **E-R diagrams**: entities, attributes, relationships, and explicit
  cardinality (1:1, 1:N, M:N)
- **Weak entities** borrow identity from the entities they depend on

### Mechanics (Weeks 6-7)

- The **mapping algorithm**: strong entity to relation, weak entity
  to relation with a composite key, 1:N to a foreign key, M:N to a
  new relation with a composite key
- **Functional dependency**, A &rarr; B: one value of A always
  determines one value of B
- **1NF, 2NF, 3NF**: no repeating groups, no partial dependency, no
  transitive dependency

### Building It (Weeks 9-10)

- **DDL**: `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`; `PRIMARY KEY`,
  `FOREIGN KEY`, `NOT NULL`, `AUTO_INCREMENT` enforce Week 2's
  constraints for real
- **DML**: `INSERT`, `UPDATE`, `DELETE`; `WHERE` is required in
  practice on `UPDATE` and `DELETE`

### Asking It Questions (Weeks 11-12)

- **Single-table queries**: `SELECT`, `FROM`, `WHERE`, `DISTINCT`,
  `ORDER BY`, `LIMIT`
- **Multi-table queries**: `INNER JOIN` keeps matched rows only,
  `LEFT JOIN` keeps every row from one side
- **Aggregation**: `GROUP BY` clusters rows, `COUNT`/`SUM`/`AVG`/
  `MAX`/`MIN` summarize each cluster, `HAVING` filters groups

### Week 14

Week 14 introduced no new testable material — it was the semester's
design-through-query arc, applied once by you to a system of your own
choosing. Nothing from Week 14 itself is a separate exam topic; it is
practice for exactly the kind of multi-step tracing question below.

---

## Practice Questions

Same questions as the Sample Question section of the Week 15 slides,
with fuller worked explanations than fit on a slide. Read the
matching week's lab page first if a question still feels unfamiliar.

### Week 1: Introduction

**Q1.** A student asks: "why did we spend four weeks (2-4) on paper
before writing a single line of SQL?"

> **Answer:** Motivation and design must come before implementation
> — this course's own stated principle. Week 9's `CREATE TABLE`
> needs a normalized schema to already exist; skipping straight to
> SQL would mean building on an unverified, possibly anomaly-ridden
> design, exactly what Weeks 6 and 7 exist to prevent.

**Common mistake:** Answering "design is good practice" instead of
naming the *specific* later cost it prevents. A full-credit answer
names the anomaly (update/deletion, Week 7) or the ordering failure
(Week 9's `CREATE TABLE` needing a normalized schema already in hand)
that skipping the paper stage would cause.

### Weeks 2-4: Relational Model, Data Modelling & E-R Diagram

**Q2.** Trace one fact, an instructor's office room, through the
entire semester: where does it live at the conceptual stage, the
logical stage, and finally, in SQL?

> **Answer:**
> - **Conceptual (Week 4):** an attribute of the Instructor entity
> - **Logical/relational (Weeks 2-3):** a column,
>   `Instructor(instructor_id, name, office)`
> - **SQL (Weeks 9-10):**
>   ```sql
>   ALTER TABLE Instructor ADD COLUMN office VARCHAR(20);
>   UPDATE Instructor SET office = '성파 702' WHERE instructor_id = 1;
>   ```

**Common mistake:** Jumping straight to the SQL answer and skipping
the conceptual and logical stages by name. A complete answer names
all three stages, in order, not just the final command.

### Week 7: Normalization

**Q3.** A table `Section(section_id, course_code, course_title,
instructor_id, room)` is proposed. Identify the normalization
violation, name the anomaly it causes, and write the corrected
schema.

> **Answer:** `course_title` is transitively dependent on
> `course_code` (a **3NF** violation), causing an **update anomaly**
> if a course is renamed. Corrected schema:
> ```
> Course(course_code, title)
> Section(section_id, course_code, instructor_id, room)
> ```

**Common mistake:** Calling this a 2NF violation instead of 3NF. 2NF
concerns a *composite* primary key's parts; `Section.section_id` here
is a single-column key, so 2NF is automatically satisfied. The actual
violation is a transitive dependency between two non-key attributes —
precisely what 3NF tests for.

### Week 9: DDL

**Q4.** Which single MySQL constraint, introduced in Week 9, enforces
Week 2's referential integrity automatically?

> **Answer:** `FOREIGN KEY ... REFERENCES ...`. MySQL rejects any
> `INSERT` or `UPDATE` that would create a foreign key value with no
> matching primary key in the referenced table.

**Common mistake:** Answering `PRIMARY KEY` instead of `FOREIGN KEY`.
`PRIMARY KEY` enforces the *key* constraint within one relation and
says nothing about whether a value in a *different* table points at
something real. Referential integrity is specifically a
cross-relation rule.

### Week 12: Multi-table Queries

**Q5.** Write a single query returning each major and its average
grade point, for majors with more than 10 enrolled students.

> **Answer:**
> ```sql
> SELECT Student.major, AVG(gp.points) AS avg_gp
> FROM Student
> JOIN Enrollment ON Student.student_id = Enrollment.student_id
> JOIN GradePoints gp ON Enrollment.grade = gp.grade
> GROUP BY Student.major
> HAVING COUNT(*) > 10;
> ```

**Common mistake:** Writing `WHERE COUNT(*) > 10` instead of `HAVING
COUNT(*) > 10`. A second common mistake: skipping the join to
`GradePoints` and trying `AVG(Enrollment.grade)` directly, which fails
or produces nonsense, because `grade` is text, not a number.

---

## Quick Self-Test

Cover every answer above and re-derive it from scratch:

- **Q1:** Why paper before SQL — name the *specific* Week 7 anomaly
  or Week 9 ordering failure it prevents, not just "design is good
  practice"
- **Q2:** The office-room trace — name conceptual, logical, and SQL
  in order, for the same fact, without skipping a stage
- **Q3:** The transitive-dependency violation — explain *why* it's
  3NF and not 2NF, not just which one it is
- **Q4:** The `FOREIGN KEY` constraint — and why `PRIMARY KEY` alone
  is the wrong answer
- **Q5:** The `JOIN` + `GROUP BY` + `HAVING` query — build it from the
  one-sentence question, before looking at the SQL

Losing points on the final almost always means recalling one week's
definition in isolation instead of tracing a fact across the weeks
that built it — that is the single most common source of lost points
on this exam.

---

## After the Exam

This is the last graded activity of the semester. You have completed
**Database Systems**: you can now explain why a DBMS exists, design a
schema with E-R diagrams and normalization, and build and query that
schema for real, in MySQL.

**Where this leads next:** database administration, data warehousing
and analytics, and NoSQL/distributed data stores each build directly
on the relational foundations from this course. The
[References & Further Reading](../appendix/references.md) appendix
lists recommended resources if you want to keep going.
