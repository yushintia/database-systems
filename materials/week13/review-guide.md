# Week 13 Review Guide: Quiz 2 (Weeks 9-12)

Same questions as the "Check Yourself" section of the Week 13 slides,
with fuller worked explanations than fit on a slide. Organized by week.
Read the matching week's slides first if a question still feels
unfamiliar.

Quiz 2 format reminder: written, individual, closed book, covering
Weeks 9-12, the entire MySQL/SQL half of the course, in one sitting.
There is no separate open-book or reference-sheet allowance this time —
know the syntax, not just the concept.

---

## Week 9: DDL

**Q1. `INSERT INTO Section (course_code, instructor_id) VALUES ('CSE999', 1);` fails because `CSE999` does not exist in `Course`. Which Week 9 constraint caused the failure, and is that a problem or a feature?**

> **Answer:** **Referential integrity**, enforced by a `FOREIGN KEY`
> constraint. It is a feature, not a bug: it caught an error, an
> orphaned reference to a course that does not exist, before it could
> ever be written to the database.

**Why:** A `FOREIGN KEY` on `Section.course_code` tells MySQL that
every value in that column must already exist as a `course_code` in
`Course`. This is exactly why table creation order matters: `Course`
must exist before `Section` can declare a foreign key pointing at it,
and now, at insert time, every row must respect that same rule. Without
the constraint, `'CSE999'` would insert silently, and any later query
joining `Section` to `Course` would just quietly drop that row or
return `NULL`, a much harder bug to track down than an insert that
fails loudly and immediately.

**Common mistake:** Assuming a failed `INSERT` means something is
wrong with the database, rather than checking whether the referenced
row (here, the `Course` row for `CSE999`) actually exists yet. Always
create and populate the "one" side of a relationship (`Course`) before
inserting into the "many" side (`Section`).

---

## Week 10: DML

**Q2. `UPDATE Section SET room = '성파 615' WHERE instructor_id = 1;` is run without checking how many rows match first. What could go wrong, and how would you check safely beforehand?**

> **Answer:** Every section taught by instructor 1 changes room at
> once, which may be more sections than intended. Run
> ```sql
> SELECT * FROM Section WHERE instructor_id = 1;
> ```
> first, to see exactly which rows the `UPDATE` will affect, before
> running it.

**Why:** `WHERE instructor_id = 1` matches *every* row where that
condition is true, not just the one the writer had in mind. If
instructor 1 teaches three sections, all three move to the new room,
which is correct only if that was actually the intent. Running the
exact same `WHERE` clause as a `SELECT` first turns an irreversible
write into a two-step, inspectable operation: see the rows, confirm
they're the right ones, then run the `UPDATE`. This costs nothing and
catches a wrong or too-broad `WHERE` clause before it does any damage.

**Common mistake:** Trusting a `WHERE` clause to be "obviously" correct
without running it as a `SELECT` first. This is the single most
common, and most damaging, DML mistake covered this semester.

**Q3. What is the difference between `DELETE FROM Enrollment;` and `DELETE FROM Enrollment WHERE student_id = 1;`?**

> **Answer:** The first deletes **every** row in `Enrollment`,
> permanently. The second deletes only rows matching
> `student_id = 1`.

**Why:** `DELETE` without a `WHERE` clause does not mean "delete
nothing" or "ask for confirmation" — it means "delete every row in the
table," with no way to selectively undo it afterward. MySQL treats a
missing `WHERE` as a valid, deliberate instruction to clear the entire
table, not as an error. The fix is the same discipline as Q2: write
and check the `WHERE` clause (ideally as a `SELECT` first) before
running any `DELETE` or `UPDATE`.

**Common mistake:** Forgetting the `WHERE` clause entirely, especially
when copy-pasting or editing a previous statement. A missing `WHERE`
silently expands "remove one row" into "remove everything" — always
double-check for it before executing.

---

## Week 11: Single-table Queries

**Q4. In the query below, what does `WHERE` filter, and why can't an aggregate like `COUNT(*)` be tested in a `WHERE` clause?**

```sql
SELECT major, COUNT(*) FROM Student
WHERE major IS NOT NULL
GROUP BY major
HAVING COUNT(*) > 5;
```

> **Answer:** `WHERE` filters raw, individual rows of `Student` before
> any grouping happens — here, it removes rows with no major recorded.
> `COUNT(*)` cannot appear in `WHERE` because aggregate values do not
> exist yet at that point in the query; they are only computed after
> `GROUP BY` runs.

**Why:** A query executes in a fixed order: `WHERE` runs first, on the
raw table, row by row, exactly like a single-table query from this
week with no grouping involved at all. `GROUP BY` runs next, clustering
the surviving rows. Only then does `HAVING` run, filtering the grouped,
aggregated result. This is why the same-looking condition
(`COUNT(*) > 5`) is illegal in `WHERE` but required in `HAVING`: at the
`WHERE` stage, there is no such thing as a per-group count yet, only
individual rows. This is described as the single most-missed
distinction on Quiz 2, in past semesters and this one.

**Common mistake:** Writing `WHERE COUNT(*) > 5` (or any aggregate
condition) directly in `WHERE`. Any condition on an aggregate function
belongs in `HAVING`, never `WHERE` — this becomes the full Week 12
topic, but the underlying reason traces back to how `WHERE` itself
works on raw rows in Week 11.

---

## Week 12: Multi-table Queries

**Q5. Write a query returning each instructor's name and how many sections they teach, including instructors currently teaching zero sections.**

> **Answer:**
> ```sql
> SELECT Instructor.name, COUNT(Section.section_id) AS section_count
> FROM Instructor
> LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
> GROUP BY Instructor.name;
> ```
> `LEFT JOIN` is required to keep instructors with zero matching
> sections.

**Why:** An `INNER JOIN` (the default `JOIN`) only keeps rows that
find a match on both sides. An instructor teaching zero sections has
no matching row in `Section` at all, so an `INNER JOIN` would silently
drop that instructor from the result entirely. `LEFT JOIN Instructor
... Section` keeps every row from `Instructor` (the "left" table)
regardless of whether a match exists, filling in `NULL` for the
unmatched side. `COUNT(Section.section_id)` then correctly counts 0 for
those instructors, because `COUNT` on a column ignores `NULL` values,
unlike `COUNT(*)`, which would count 1 even for an unmatched row.

**Common mistake:** Choosing `INNER JOIN` (or plain `JOIN`) whenever a
question says "including those with none" or "including zero." That
phrase is always a signal that rows without a match must be kept, so
`LEFT JOIN` is required, not decoration.

**Q6. Write a query listing every course title and the average grade point of students enrolled in it, for courses with more than 5 enrollments. (Assume a `GradePoints(grade, points)` lookup table.)**

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

**Why:** This question chains three `JOIN`s to connect `Course` to the
individual `Enrollment` rows that determine its average grade point:
`Course` to `Section` (which course each section belongs to),
`Section` to `Enrollment` (which students are in that section), and
`Enrollment` to `GradePoints` (translating a letter grade into a
numeric point value that `AVG` can operate on). `GROUP BY Course.title`
clusters all those enrollment rows by course, and `HAVING COUNT(*) > 5`
filters out courses with 5 or fewer enrollments only *after* the
grouping and counting happen, exactly the `WHERE`-then-`GROUP
BY`-then-`HAVING` order from Q4.

**Common mistake:** Forgetting the `ON` condition on any one of the
joins. A `JOIN` with no matching condition returns every possible
pairing of rows from both tables, an enormous and meaningless result,
and it will also silently break the `AVG` and `HAVING COUNT(*)`
numbers in this query since every enrollment would be duplicated
against every unrelated grade-point row.

---

## Quick Self-Test

Before Quiz 2, try covering the answers above and re-deriving each one
from scratch, especially Q4 (the `WHERE`/`GROUP BY`/`HAVING` execution
order) and Q5 (when `LEFT JOIN` is required instead of the default
`INNER JOIN`). Those are the most common sources of lost points, in
past semesters and this one.
