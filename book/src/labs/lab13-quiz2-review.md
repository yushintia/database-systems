# Lab 13: Quiz 2 Review

| | |
|---|---|
| **Week** | 13 |
| **Duration** | 150 min (single continuous block) |
| **Method** | Review — no new content |
| **Scope** | Weeks 9-12 (DDL, DML, Single-table Queries, Multi-table Queries) |
| **Weight** | Quiz 2 is graded as part of the 10% in-class items grade (see [Grading Rubrics](../appendix/grading-rubric.md)) |

**Time allocation**

| Phase | Min | Activity |
|---|---:|---|
| Review | 40 | Recap Weeks 9-12, self-check questions, common mistakes |
| Quiz 2 | 90 | Written, individual, closed book |
| Buffer | 20 | Collect papers, logistics questions, wrap-up |

---

## Quiz 2 Format

Quiz 2 is **written, individual, closed book**, covering Weeks 9-12 —
the entire MySQL/SQL half of the course. Unlike Quiz 1, there is no
separate open-book or reference-sheet allowance this time: know the
syntax, not just the concept.

This page has no Guided Exercises, Challenge Problem, or graded
rubric of its own — it is a review of material already graded in
Weeks 9-12's own labs. Everything below is ungraded self-check, with
answers shown immediately.

---

## What to Review, Week by Week

### Week 9: DDL

- `CREATE TABLE` defines structure: columns, data types, `PRIMARY KEY`,
  `FOREIGN KEY`, `NOT NULL`, `AUTO_INCREMENT`
- `ALTER TABLE` changes existing structure; `DROP TABLE` removes it
  entirely, along with all its data
- Table creation order follows dependency order: a table cannot
  reference one that does not exist yet

**Self-check (from the Week 9 self-check quiz):**

**Q.** You run `CREATE TABLE Section (... FOREIGN KEY (instructor_id)
REFERENCES Instructor(instructor_id));`, but `Instructor` does not
exist yet. What happens?

> **Answer:** MySQL rejects the statement with an error — a foreign
> key can only reference a table that already exists.

**Q.** Write the `CREATE TABLE` statement for `Course(course_code,
title)`, where `course_code` is a 10-character code and the primary
key, and `title` (up to 150 characters) is required.

> **Answer:**
> ```sql
> CREATE TABLE Course (
>     course_code VARCHAR(10) PRIMARY KEY,
>     title VARCHAR(150) NOT NULL
> );
> ```

---

### Week 10: DML

- `INSERT INTO ... VALUES` adds rows; foreign-key targets must already
  exist
- `UPDATE ... SET ... WHERE` changes rows; without `WHERE`, every row
  in the table changes
- `DELETE FROM ... WHERE` removes rows; MySQL blocks deletions that
  would orphan a foreign-key reference

**Self-check (from the Week 10 self-check quiz):**

**Q.** Why does `UPDATE Instructor SET name = 'Lee, Married Name';`
(with no `WHERE` clause) cause a serious problem?

> **Answer:** It changes the name of every single row in
> `Instructor`, not just the intended one — a missing `WHERE` applies
> to the whole table.

**Q.** Write the `INSERT` statement to add a new student, "Han Jiwoo,"
major "Data Science," to `Student`.

> **Answer:**
> ```sql
> INSERT INTO Student (name, major)
> VALUES ('Han Jiwoo', 'Data Science');
> ```

---

### Week 11: Single-table Queries

- `SELECT` columns, `FROM` a table, `WHERE` rows match a condition
- Comparison operators (`=`, `>`, `LIKE`, `BETWEEN`) and logical
  operators (`AND`, `OR`, `NOT`) build precise filters
- `DISTINCT` removes duplicate results; `ORDER BY` sorts; `LIMIT`
  caps how many rows return

**Self-check (from the Week 11 self-check quiz):**

**Q.** Which query correctly finds every enrollment with no grade
recorded yet?

> **Answer:** `SELECT * FROM Enrollment WHERE grade IS NULL;` —
> `NULL` means "unknown," and nothing equals unknown, not even
> another unknown, so `= NULL` never matches.

**Q.** Write a query that returns the `name` of every `Student` whose
`major` is either `'Computer Science'` or `'Software Engineering'`,
using `IN`.

> **Answer:**
> ```sql
> SELECT name FROM Student
> WHERE major IN ('Computer Science', 'Software Engineering');
> ```

---

### Week 12: Multi-table Queries

- `JOIN ... ON` combines rows from related tables by matching keys
- `INNER JOIN` keeps only matched rows; `LEFT JOIN` keeps every row
  from the left table even without a match
- `GROUP BY` clusters rows; `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`
  summarize each cluster; `HAVING` filters groups, `WHERE` filters rows

**Self-check (from the Week 12 self-check quiz):**

**Q.** What happens if you write a `JOIN` with no matching condition
at all?

> **Answer:** It returns every possible pairing of rows from both
> tables — an enormous, meaningless result.

**Q.** Write a query listing every `Instructor`'s name and the number
of `Section`s they teach, including instructors teaching zero
sections this semester.

> **Answer:**
> ```sql
> SELECT Instructor.name, COUNT(Section.section_id) AS sections_taught
> FROM Instructor
> LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
> GROUP BY Instructor.name;
> ```
> `LEFT JOIN` is required — an `INNER JOIN` would silently drop any
> instructor with zero sections.

---

## In-Depth Review Questions

These go further than the self-check questions above, with the fuller
worked explanation each one needs. Read the matching week's lab page
first if a question still feels unfamiliar.

### DDL (Week 9): Referential Integrity

**Q1.** `INSERT INTO Section (course_code, instructor_id) VALUES
('CSE999', 1);` fails because `CSE999` does not exist in `Course`.
Which Week 9 constraint caused the failure, and is that a problem or
a feature?

> **Answer:** **Referential integrity**, enforced by a `FOREIGN KEY`
> constraint. It is a feature, not a bug: it caught an error, an
> orphaned reference to a course that does not exist, before it could
> ever be written to the database.

**Common mistake:** Assuming a failed `INSERT` means something is
wrong with the database, rather than checking whether the referenced
row (here, the `Course` row for `CSE999`) actually exists yet. Always
create and populate the "one" side of a relationship (`Course`)
before inserting into the "many" side (`Section`).

### DML (Week 10): Check Before You Write

**Q2.** `UPDATE Section SET room = '성파 615' WHERE instructor_id = 1;`
is run without checking how many rows match first. What could go
wrong, and how would you check safely beforehand?

> **Answer:** Every section taught by instructor 1 changes room at
> once, which may be more sections than intended. Run
> `SELECT * FROM Section WHERE instructor_id = 1;` first, to see
> exactly which rows the `UPDATE` will affect, before running it.

**Common mistake:** Trusting a `WHERE` clause to be "obviously"
correct without running it as a `SELECT` first. This is the single
most common, and most damaging, DML mistake covered this semester.

**Q3.** What is the difference between `DELETE FROM Enrollment;` and
`DELETE FROM Enrollment WHERE student_id = 1;`?

> **Answer:** The first deletes **every** row in `Enrollment`,
> permanently. The second deletes only rows matching
> `student_id = 1`. A missing `WHERE` is not treated as an error —
> MySQL takes it as a deliberate instruction to clear the entire
> table.

### Single-table Queries (Week 11): WHERE vs. Aggregates

**Q4.** In the query below, what does `WHERE` filter, and why can't
an aggregate like `COUNT(*)` be tested in a `WHERE` clause?

```sql
SELECT major, COUNT(*) FROM Student
WHERE major IS NOT NULL
GROUP BY major
HAVING COUNT(*) > 5;
```

> **Answer:** `WHERE` filters raw, individual rows of `Student`
> before any grouping happens. `COUNT(*)` cannot appear in `WHERE`
> because aggregate values do not exist yet at that point in the
> query; they are only computed after `GROUP BY` runs.

**Common mistake:** Writing `WHERE COUNT(*) > 5` (or any aggregate
condition) directly in `WHERE`. Any condition on an aggregate function
belongs in `HAVING`, never `WHERE` — this is described as the single
most-missed distinction on Quiz 2, in past semesters and this one.

### Multi-table Queries (Week 12): LEFT JOIN and Chained Joins

**Q5.** Write a query returning each instructor's name and how many
sections they teach, including instructors currently teaching zero
sections.

> **Answer:** See the Week 12 self-check answer above — the same
> query, `LEFT JOIN` required.

**Common mistake:** Choosing `INNER JOIN` (or plain `JOIN`) whenever a
question says "including those with none" or "including zero." That
phrase is always a signal that rows without a match must be kept, so
`LEFT JOIN` is required, not decoration.

**Q6.** Write a query listing every course title and the average
grade point of students enrolled in it, for courses with more than 5
enrollments. (Assume a `GradePoints(grade, points)` lookup table.)

> **Answer:**
> ```sql
> SELECT Course.title, AVG(gp.points) AS avg_gp
> FROM Course
> JOIN Section ON Course.course_code = Section.course_code
> JOIN Enrollment ON Section.section_id = Enrollment.section_id
> JOIN GradePoints gp ON Enrollment.grade = gp.grade
> GROUP BY Course.title
> HAVING COUNT(*) > 5;
> ```

**Common mistake:** Forgetting the `ON` condition on any one of the
joins. A `JOIN` with no matching condition returns every possible
pairing of rows from both tables, and it will also silently break the
`AVG` and `HAVING COUNT(*)` numbers in this query, since every
enrollment would be duplicated against every unrelated grade-point
row.

---

## Quick Self-Test

Before Quiz 2, try covering the answers above and re-deriving each
one from scratch, especially Q4 (the `WHERE`/`GROUP BY`/`HAVING`
execution order) and Q5 (when `LEFT JOIN` is required instead of the
default `INNER JOIN`). Those are the most common sources of lost
points, in past semesters and this one.

---

## What Comes Next

Weeks 9 through 12 cover everything needed to build, fill, and query
the registration database correctly. [Lab 14](lab14-case-study-presentation.md)
asks you to apply all of it, design through query, to a system of
your own choosing.
