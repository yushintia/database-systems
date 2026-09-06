---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 12: Multi-table Queries

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: Assignment 2 due this week. Announce early. Heaviest SQL week, budget extra time for JOIN and GROUP BY. -->

---

<!-- SLOT 2: Where we are -->

# Where We Are

<div class="roadmap">
<div class="wk"><div class="n">Wk 1</div><div class="t">Introduction</div></div>
<div class="wk"><div class="n">Wk 2</div><div class="t">Relational Model</div></div>
<div class="wk"><div class="n">Wk 3</div><div class="t">Data Modelling</div></div>
<div class="wk"><div class="n">Wk 4</div><div class="t">E-R Diagram</div></div>
<div class="wk review"><div class="n">Wk 5</div><div class="t">Quiz 1</div></div>
<div class="wk"><div class="n">Wk 6</div><div class="t">Mapping Algorithm</div></div>
<div class="wk"><div class="n">Wk 7</div><div class="t">Normalization</div></div>
<div class="wk review"><div class="n">Wk 8</div><div class="t">Midterm Exam</div></div>
<div class="wk"><div class="n">Wk 9</div><div class="t">DDL</div></div>
<div class="wk"><div class="n">Wk 10</div><div class="t">DML</div></div>
<div class="wk"><div class="n">Wk 11</div><div class="t">Single-table Queries</div></div>
<div class="wk now"><div class="n">Wk 12</div><div class="t">Multi-table Queries</div></div>
<div class="wk review"><div class="n">Wk 13</div><div class="t">Quiz 2</div></div>
<div class="wk"><div class="n">Wk 14</div><div class="t">Case Study Presentation</div></div>
<div class="wk review"><div class="n">Wk 15</div><div class="t">Final Exam</div></div>
</div>

<div class="why">
<strong>Assignment 2 due this week:</strong> multi-table queries and
aggregation against the registration schema.
</div>

---

<!-- SLOT 3: Recap + open wound -->

# Last Week, This Week

- **Last week delivered:** `SELECT`, `WHERE`, `DISTINCT`, `ORDER BY`, `LIMIT`, finally answering questions inside one table in under a second
- **Last week left broken:** normalization split the registration data across five tables. Any real question now needs more than one of them at once

---

<!-- SLOT 4: The pain -->

# One Table Cannot Answer This

<div class="pain">

The registrar asks: "list every student in Professor Lee's sections,
with their grade, and the course title."

`Enrollment` has the grade and the student ID. `Section` has the room
and the instructor ID. `Instructor` has the name. `Course` has the
title. Not one of these four tables, alone, has enough information to
answer the question. Normalization, Week 7's entire achievement, put
each fact exactly once, which also means no single table has the
whole picture anymore.

</div>

<!-- notes: This is the direct cost of normalization, worth saying out loud: the fix for redundancy is what makes joins necessary at all. -->

---

# What Else This Actually Costs

- Every genuinely useful business question ("total revenue by month,"
  "average grade by department") spans multiple related tables by
  nature, not by accident
- Without joins, a normalized database is strictly less useful than the
  original flat spreadsheet for answering real questions, even though
  it is far more correct
- Getting a join condition wrong silently produces a wrong, or
  enormous, result instead of an obvious error

<div class="why">
<strong>In industry:</strong> `JOIN` and `GROUP BY` are the two SQL
features that separate "can write a simple query" from "can build a
real report." Nearly every analytics dashboard is a `JOIN` plus a
`GROUP BY` underneath its charts.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"How do you ask one question that spans several related tables at once?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

<div class="cardlist">
<div class="card"><div class="h">INNER vs. LEFT JOIN</div><div class="d">Write an <code>INNER JOIN</code> and a <code>LEFT JOIN</code>, and explain the difference</div></div>
<div class="card"><div class="h">Multi-table Joins</div><div class="d">Join more than two tables in a single query</div></div>
<div class="card"><div class="h">GROUP BY &amp; Aggregates</div><div class="d">Group rows with <code>GROUP BY</code> and summarize them with aggregate functions</div></div>
<div class="card"><div class="h">HAVING vs. WHERE</div><div class="d">Filter grouped results with <code>HAVING</code>, as distinct from <code>WHERE</code></div></div>
</div>

---

<!-- SLOT 8: Origin -->

# Where JOIN Came From

<div class="thread">Not a workaround. A direct consequence of Codd's own 1970 relational algebra.</div>

- Codd's original relational model included, from the start, an
  operation for combining two relations based on matching values, part
  of what he called relational algebra
- SQL's `JOIN` keyword is that operation, made writable. It exists
  because normalization was always meant to be paired with a way to
  reassemble the pieces, not just split them apart

---

<!-- SLOT 9: Core concept -->

# JOIN: Definition

<div class="thread">The single operation that undoes Week 7's decomposition, on demand, per query.</div>

> A **JOIN** combines rows from two tables into one result, based on a
> matching condition, usually a foreign key matching a primary key.

```sql
SELECT Student.name, Enrollment.grade
FROM Student
JOIN Enrollment ON Student.student_id = Enrollment.student_id;
```

`ON` states the condition: rows are matched wherever `student_id`
agrees on both sides.

---

<!-- Act 3 / BUILD -->

# Illustration: The Join Path

<div class="thread">The pain slide's question needs four tables. Here is the path between them.</div>

<div class="pipeline">
<div class="stage"><div class="h">Enrollment</div><div class="s">grade</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Student</div><div class="s">name</div></div>
</div>

<div class="pipeline">
<div class="stage"><div class="h">Enrollment</div><div class="s">section_id</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Section</div><div class="s">course_code, instructor_id</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Instructor</div><div class="s">name</div></div>
</div>

Every arrow is one `JOIN ... ON`, one foreign key relationship from
Week 6, walked in the direction the question needs.

---

# INNER JOIN: Matching Rows Only

<div class="thread">The default kind of join. Understand this one completely before the next.</div>

```sql
SELECT Student.name, Enrollment.grade
FROM Student
INNER JOIN Enrollment ON Student.student_id = Enrollment.student_id;
```

`INNER JOIN` (the same as plain `JOIN`) returns only rows where a match
exists on **both** sides. A student with zero enrollments does not
appear in this result at all, not even with an empty grade.

---

# LEFT JOIN: Keeping Every Row From One Side

<div class="thread">The fix for exactly the gap INNER JOIN just left.</div>

```sql
SELECT Student.name, Enrollment.grade
FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id;
```

`LEFT JOIN` keeps **every** row from `Student` (the left table), even
students with zero enrollments, filling `Enrollment.grade` with `NULL`
where no match exists.

<div class="why">
"List every student, and their grade if they have one" needs
<code>LEFT JOIN</code>. "List only students who are actually enrolled
in something" needs <code>INNER JOIN</code>. The choice changes which
students disappear from the result.
</div>

---

# RIGHT JOIN: Keeping Every Row From the Other Side

<div class="thread">LEFT JOIN's exact mirror image, same idea, other direction.</div>

```sql
SELECT Student.name, Enrollment.grade
FROM Enrollment
RIGHT JOIN Student ON Enrollment.student_id = Student.student_id;
```

`RIGHT JOIN` keeps **every** row from the table named on the right of
the keyword (`Student` here), even students with zero enrollments,
exactly `LEFT JOIN`'s guarantee, just applied to the other side of the
statement. `FROM Enrollment RIGHT JOIN Student` and `FROM Student LEFT
JOIN Enrollment` return the identical result, only the table order
changed.

---

# Illustration: RIGHT JOIN Keeps a Student With No Enrollment

<div class="thread">The exact row LEFT JOIN would keep too, if the tables were written the other way around.</div>

**`Student`:** includes `Lee Jiwoo`, who has never enrolled in anything.

**`FROM Enrollment RIGHT JOIN Student ON ...`:**

| name | grade |
|---|---|
| Kim Minji | A0 |
| Lee Jiwoo | NULL |

`Lee Jiwoo` appears with `grade = NULL`; an `INNER JOIN` here would
drop that row entirely. `RIGHT JOIN` is what keeps it, because
`Student` is named on the right.

---

# FULL OUTER JOIN: Keeping Every Row From Both Sides

<div class="thread">One direction was LEFT, the other RIGHT. This asks for both at once.</div>

> A **FULL OUTER JOIN** keeps every row from both tables, matched where
> possible, filled with `NULL` on whichever side has no match.

MySQL has **no native `FULL OUTER JOIN` keyword**, unlike some other
database products. The standard workaround: combine a `LEFT JOIN` and
a `RIGHT JOIN` of the same two tables with `UNION`.

---

# FULL OUTER JOIN Workaround: LEFT JOIN UNION RIGHT JOIN

<div class="thread">The exact statement MySQL requires in place of FULL OUTER JOIN.</div>

```sql
SELECT Student.name, Enrollment.grade
FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id
UNION
SELECT Student.name, Enrollment.grade
FROM Student
RIGHT JOIN Enrollment ON Student.student_id = Enrollment.student_id;
```

The `LEFT JOIN` half keeps every student, matched or not. The `RIGHT
JOIN` half keeps every enrollment, matched or not. `UNION` merges the
two result sets and removes any row that happens to appear in both.

---

# Illustration: What the UNION Actually Assembles

<div class="thread">Two partial results, one combined answer, nothing missing from either side.</div>

The `LEFT JOIN` half keeps `Lee Jiwoo` (no enrollment, `grade = NULL`).
The `RIGHT JOIN` half keeps every enrollment row, even one whose
`student_id` no longer matches any `Student` (`grade` present,
`name = NULL`), a case a plain `LEFT JOIN` alone would have missed
entirely.

`UNION` puts both kinds of "orphan" row in the same final result, the
closest MySQL gets to a true `FULL OUTER JOIN` without the keyword.

---

# UNION: Stacking Two Queries' Results

<div class="thread">A different way to combine queries: not side-by-side (JOIN), but one on top of the other.</div>

> `UNION` combines the result rows of two `SELECT` statements into one
> result set, removing duplicate rows, provided both statements return
> the same number of columns, in compatible types.

```sql
SELECT name FROM Student WHERE major = 'Computer Science'
UNION
SELECT name FROM Instructor WHERE department = 'Computer Science';
```

One combined list of names, students and instructors together, no
name appears twice even if a name happened to match in both source
queries.

---

# UNION ALL: The Same Idea, Duplicates Kept

<div class="thread">One keyword added, one behavior changed, worth knowing before it surprises you.</div>

```sql
SELECT name FROM Student WHERE major = 'Computer Science'
UNION ALL
SELECT name FROM Instructor WHERE department = 'Computer Science';
```

`UNION ALL` keeps every row from both queries, duplicates included,
and skips the work of checking for them. If "Kim Minji" happens to
appear in both source tables, plain `UNION` shows one row, `UNION ALL`
shows two, use `UNION ALL` whenever duplicates are already known to be
impossible, or simply do not matter.

---

# Illustration: UNION vs. UNION ALL, Side by Side

<div class="thread">Same two source queries, two different result row counts.</div>

**Query A** returns `Kim Minji`, `Park Jiho`.
**Query B** returns `Kim Minji`, `Han Somin`.

**`UNION`:** `Kim Minji`, `Park Jiho`, `Han Somin` (3 rows, the
duplicate collapsed).
**`UNION ALL`:** `Kim Minji`, `Park Jiho`, `Kim Minji`, `Han Somin`
(4 rows, nothing removed).

---

# INTERSECT and EXCEPT: The Other Set Operations

<div class="thread">UNION is not the only way to combine two queries as sets.</div>

Standard SQL defines three set operations on two same-shaped queries:

| Operation | Keeps |
|---|---|
| `UNION` | rows in either query |
| `INTERSECT` | rows in **both** queries |
| `EXCEPT` | rows in the first query but **not** the second |

MySQL added native `INTERSECT` and `EXCEPT` support in version 8.0.31;
earlier MySQL versions have no equivalent keyword for either.

```sql
SELECT student_id FROM Enrollment WHERE section_id = 3
INTERSECT
SELECT student_id FROM Enrollment WHERE section_id = 5;
```

Returns only students enrolled in **both** section 3 and section 5.

---

# Self-Join: A Table Joined to Itself

<div class="thread">Every JOIN so far combined two different tables. Nothing stops both sides from being the same one.</div>

> A **self-join** joins a table to a copy of itself, using two
> different aliases so SQL can tell "this row" from "that row" of the
> same table.

```sql
SELECT a.name, b.name
FROM Student a, Student b
WHERE a.major = b.major AND a.student_id < b.student_id;
```

`Student` is named twice, as `a` and `b`, so the query can compare one
student's row against another's; `a.student_id < b.student_id` exists
purely to avoid listing the same pair twice, in both orders.

---

# Worked Example: Students Sharing a Section

<div class="thread">The self-join pattern applied to the case study's own tables.</div>

```sql
SELECT s1.student_id AS student_a, s2.student_id AS student_b,
       e1.section_id
FROM Enrollment e1
JOIN Enrollment e2
  ON e1.section_id = e2.section_id
 AND e1.student_id < e2.student_id
JOIN Student s1 ON e1.student_id = s1.student_id
JOIN Student s2 ON e2.student_id = s2.student_id;
```

`Enrollment` joined to itself finds every pair of distinct students
sharing a `section_id`. `e1.student_id < e2.student_id` again exists
only to keep each pair once, without it, every pair would appear
twice, swapped.

---

# Illustration: What the Self-Join Pairs Up

<div class="thread">The actual rows the previous slide's condition selects.</div>

**`Enrollment` for `section_id = 3`:** students `1`, `3`, `7`.

**Result:**

| student_a | student_b | section_id |
|---|---|---|
| 1 | 3 | 3 |
| 1 | 7 | 3 |
| 3 | 7 | 3 |

Three students produce exactly three pairs, never a student paired
with themselves (`e1.student_id < e2.student_id` rules that out), and
never a pair listed twice.

---

# ON vs. WHERE: Where a Condition Lives Changes the Answer

<div class="thread">Two clauses that look interchangeable on an INNER JOIN, and are not on an OUTER JOIN.</div>

```sql
-- Condition inside ON: filters before keeping unmatched rows
SELECT Student.name, Enrollment.grade
FROM Student
LEFT JOIN Enrollment
  ON Student.student_id = Enrollment.student_id
 AND Enrollment.grade = 'A0';

-- Condition inside WHERE: filters after the LEFT JOIN already ran
SELECT Student.name, Enrollment.grade
FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id
WHERE Enrollment.grade = 'A0';
```

The first keeps every student, `NULL` grade if their enrollment wasn't
an `A0`. The second's `WHERE` runs after the join, throwing away every
`NULL` row the `LEFT JOIN` just went to the trouble of keeping, it
quietly behaves like an `INNER JOIN` instead.

---

# Illustration: The Same LEFT JOIN, Two Different Answers

<div class="thread">The exact result each version of the previous slide's query actually returns.</div>

**Condition in `ON`:**

| name | grade |
|---|---|
| Kim Minji | A0 |
| Lee Jiwoo | NULL |

**Condition in `WHERE`:**

| name | grade |
|---|---|
| Kim Minji | A0 |

`Lee Jiwoo` (no `A0`, or no enrollment at all) survives the `ON`
version, `LEFT JOIN`'s entire purpose, and is silently dropped by the
`WHERE` version. On an `INNER JOIN`, `ON` and `WHERE` give identical
results; on an `OUTER JOIN`, they do not, always ask which clause a
condition belongs in.

---

# Demo, Step by Step: Joining Four Tables

<div class="thread">The pain slide's actual question, built one JOIN at a time, not handed over finished.</div>

"List every student in Professor Lee's sections, with grade and course
title." Four tables needed, four steps, one `JOIN` added per step.

---

# Step 1: Start at Enrollment

```sql
SELECT * FROM Enrollment;
```

`student_id`, `section_id`, `grade`. Everything the question needs is
one hop away from here, but no names, no titles, yet.

---

# Step 2: Add Student

```sql
SELECT Student.name, Enrollment.grade
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id;
```

A name appears. `grade` was already here; `Student.name` just arrived
through the first foreign key.

---

# Step 3: Add Section, Then Course

```sql
SELECT Student.name, Enrollment.grade, Course.title
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Course ON Section.course_code = Course.course_code;
```

Two more joins, chained: `Enrollment` to `Section`, then `Section` to
`Course`. `Course.title` was never reachable directly from
`Enrollment`, only through `Section` in between.

---

# Step 4: Add Instructor, Then WHERE

```sql
SELECT Student.name, Enrollment.grade, Course.title
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Course ON Section.course_code = Course.course_code
JOIN Instructor ON Section.instructor_id = Instructor.instructor_id
WHERE Instructor.name = 'Prof. Lee';
```

Four `JOIN` clauses, one per foreign key relationship, then a `WHERE`
narrowing to one instructor. Every step was one small, checkable
addition; the finished query is just all four steps, stacked.

---

# USING: A Shorter ON, When Names Match

<div class="thread">A small syntax shortcut, worth knowing once ON is solid.</div>

```sql
SELECT Student.name, Enrollment.grade
FROM Student
JOIN Enrollment USING (student_id);
```

`USING (student_id)` is shorthand for `ON Student.student_id =
Enrollment.student_id`, only valid when the column name is identical
on both sides. `ON` always works; `USING` is a convenience for the
common case.

---

# GROUP BY: Clustering Rows

<div class="thread">A different kind of question: not "which rows," but "how many, per category."</div>

> `GROUP BY` clusters rows sharing the same value in one or more
> columns into groups, so an aggregate function can summarize each
> group separately.

```sql
SELECT major, COUNT(*) AS student_count
FROM Student
GROUP BY major;
```

One row per distinct `major`, each with a count, instead of one row
per student.

---

# Illustration: Rows Clustering Into Groups

<div class="thread">What GROUP BY actually does to the underlying rows, made visible.</div>

<div class="groupviz">
<div class="bucket">
<div class="label">Computer Science</div>
<div class="rows">Kim Minji<br>Park Jiho<br>Han Somin</div>
<div class="agg">COUNT(*) = 3</div>
</div>
<div class="bucket">
<div class="label">Software Engineering</div>
<div class="rows">Lee Jiwoo<br>Choi Yuna</div>
<div class="agg">COUNT(*) = 2</div>
</div>
</div>

Five students, two majors, `GROUP BY major` sorts them into exactly
two buckets before `COUNT(*)` summarizes each one.

---

# Aggregate Functions

<div class="thread">COUNT is one of five. All five follow the same pattern: many rows in, one number out, per group.</div>

| Function | Returns |
|---|---|
| `COUNT(*)` | number of rows in the group |
| `SUM(col)` | total of a numeric column |
| `AVG(col)` | average of a numeric column |
| `MAX(col)` | largest value in the group |
| `MIN(col)` | smallest value in the group |

```sql
SELECT Section.section_id, COUNT(*) AS enrolled
FROM Enrollment
GROUP BY Section.section_id;
```

---

# HAVING: Filtering Groups, Not Rows

<div class="thread">A second filter clause, easy to confuse with WHERE. Here is exactly how they differ.</div>

```sql
SELECT Section.section_id, COUNT(*) AS enrolled
FROM Enrollment
GROUP BY Section.section_id
HAVING COUNT(*) > 30;
```

`WHERE` filters individual rows, **before** grouping happens.
`HAVING` filters entire groups, **after** grouping and aggregation.
`WHERE enrolled > 30` is invalid here, `enrolled` does not exist until
grouping has already happened.

---

# Multiple Aggregates, One Query

<div class="thread">Real reports rarely need just one number per group.</div>

```sql
SELECT Student.major,
       COUNT(*) AS enrollments,
       AVG(CASE WHEN grade = 'A0' THEN 1 ELSE 0 END) AS a_rate
FROM Student
JOIN Enrollment USING (student_id)
GROUP BY Student.major;
```

One query, two aggregates per group. Real dashboards routinely combine
`COUNT`, `SUM`, and `AVG` in a single `GROUP BY`, exactly the shape
behind most analytics reports.

---

# Nested Subqueries: A SELECT Inside Another Query

<div class="thread">Week 10 used a subquery inside DELETE and UPDATE. The same idea nests inside SELECT too.</div>

> A **subquery** is a complete `SELECT` statement nested inside another
> query; its result feeds the outer query's `WHERE`, `FROM`, or
> `SELECT` clause.

```sql
SELECT name FROM Student
WHERE student_id IN (
    SELECT student_id FROM Enrollment WHERE section_id = 3
);
```

The inner `SELECT` runs first, producing a list of `student_id`
values; the outer `SELECT` then finds every `Student` whose ID is on
that list, the exact same `IN (subquery)` shape Week 10 used for
`DELETE`.

---

# WHERE ... IN (subquery): Filtering by Another Table's Result

<div class="thread">A second worked example, since this exact pattern shows up constantly in real reports.</div>

```sql
SELECT name FROM Instructor
WHERE instructor_id IN (
    SELECT instructor_id FROM Section WHERE semester = '2026-2'
);
```

Every instructor teaching at least one section this semester, found
without a single `JOIN`: the inner query supplies the list, the outer
query filters `Instructor` against it directly.

---

# EXISTS: Testing Only Whether Any Row Matches

<div class="thread">A different question than IN: not "is this value on the list," but "does any matching row exist at all."</div>

> `EXISTS (subquery)` is `TRUE` if the subquery returns **at least one
> row**, and `FALSE` if it returns none; the actual row values never
> matter, only whether any exist.

```sql
SELECT name FROM Student s
WHERE EXISTS (
    SELECT 1 FROM Enrollment e WHERE e.student_id = s.student_id
);
```

`SELECT 1` is a common convention, `EXISTS` never looks at what the
subquery returns, only whether it returns anything, so the column
listed inside it is arbitrary.

---

# NOT EXISTS: Finding Rows With No Match at All

<div class="thread">The negation, and a genuinely common real question: "which rows have nothing on the other side."</div>

```sql
SELECT name FROM Student s
WHERE NOT EXISTS (
    SELECT 1 FROM Enrollment e WHERE e.student_id = s.student_id
);
```

Every student with **zero** enrollments, the same students a `LEFT
JOIN ... WHERE Enrollment.student_id IS NULL` would find. `NOT EXISTS`
is often the more direct way to ask "which rows have no counterpart,"
without writing an outer join at all.

---

# Correlated Subqueries: The Inner Query Depends on the Outer Row

<div class="thread">Every subquery so far ran once, on its own. A correlated subquery reruns for every outer row.</div>

> A **correlated subquery** references a column from the outer query,
> so it must be re-evaluated once per outer row, instead of once for
> the whole statement.

The `EXISTS` and `NOT EXISTS` slides just now were already correlated:
`e.student_id = s.student_id` reaches out to `s`, the outer query's
alias. A **non**-correlated subquery, like the earlier `IN` examples,
runs exactly once and produces one fixed list.

---

# Worked Example: Students Enrolled in More Than One Section

<div class="thread">A correlated subquery written explicitly as its own condition, not hidden inside EXISTS.</div>

```sql
SELECT s.name FROM Student s
WHERE (
    SELECT COUNT(*) FROM Enrollment e
    WHERE e.student_id = s.student_id
) > 1;
```

For every candidate row in `Student s`, the inner `COUNT(*)` is
recomputed with that row's own `student_id` plugged in, one full
subquery execution per student, not one for the entire table.

---

# Scalar Subquery in SELECT: One Value, Per Row

<div class="thread">A subquery does not have to live in WHERE. It can be a column of its own.</div>

> A **scalar subquery** is a subquery placed directly in the `SELECT`
> list; it must return exactly one column and at most one row, per
> outer row, or MySQL raises an error.

```sql
SELECT s.name,
       (SELECT COUNT(*) FROM Enrollment e
        WHERE e.student_id = s.student_id) AS enrollment_count
FROM Student s;
```

Every student's name, next to a live count of their own enrollments,
computed by a correlated scalar subquery instead of a `JOIN` plus
`GROUP BY`.

---

# Scalar Subquery Gotcha: It Must Return One Value

<div class="thread">The one way this pattern breaks, worth seeing once before it happens by accident.</div>

```sql
SELECT s.name,
       (SELECT grade FROM Enrollment e
        WHERE e.student_id = s.student_id) AS a_grade
FROM Student s;
```

If any student has **more than one** enrollment, this subquery
returns more than one row for that student, and MySQL raises a
`Subquery returns more than 1 row` error. The earlier `COUNT(*)`
example was safe because `COUNT` always returns exactly one number, a
raw column like `grade` is not.

---

# JOIN and GROUP BY Behind Every Dashboard

<div class="thread">Not abstract SQL. The literal query behind features you have seen.</div>

<div class="appgrid">
<div class="app"><div class="name">"Top sellers this month"</div><div class="desc">JOIN Order to Product, GROUP BY product, ORDER BY SUM(quantity)</div></div>
<div class="app"><div class="name">Netflix "Continue Watching"</div><div class="desc">JOIN Profile to WatchHistory, WHERE progress &lt; 100%</div></div>
<div class="app"><div class="name">Bank statement summary</div><div class="desc">GROUP BY category, SUM(amount) per category</div></div>
</div>

---

# Common Mistakes

- **Forgetting the `ON` condition:** a `JOIN` with no matching
  condition returns every possible pairing of rows from both tables,
  an enormous, meaningless result
- **Using `WHERE` when `HAVING` is needed:** filtering an aggregate
  value (`COUNT(*) > 30`) always requires `HAVING`, never `WHERE`
- **Choosing INNER JOIN when rows need to be kept anyway:** if the
  question is "which students have no enrollments," `INNER JOIN`
  silently makes those exact students disappear

---

# Common Mistakes, Continued

- **Writing `FULL OUTER JOIN` directly in MySQL:** it is not supported;
  use the `LEFT JOIN UNION RIGHT JOIN` pattern instead
- **Using `UNION` when duplicates should be kept:** `UNION` always
  removes them, `UNION ALL` is required whenever every source row,
  duplicate or not, should appear in the result
- **Putting an outer-join condition in `WHERE` instead of `ON`:** it
  silently cancels the outer join's entire purpose, turning it back
  into an `INNER JOIN` in practice
- **Expecting a scalar subquery to work when the inner query can
  return more than one row:** MySQL raises an error the moment it
  does; `EXISTS` or `IN` are the correct choice when more than one
  matching row is possible

---

# Practice: A Library Report

<div class="thread">The library example, one more time, with a full JOIN plus GROUP BY.</div>

**Question:** write a query showing each member's name and how many
books they currently have on loan, for members with at least one loan.

**Answer:**
```sql
SELECT Member.name, COUNT(*) AS books_out
FROM Member
JOIN Loan USING (member_id)
GROUP BY Member.name;
```
`INNER JOIN` (the default) already excludes members with zero loans,
so no `HAVING` clause is needed for "at least one."

---

# Practice: Choosing the Right JOIN

<div class="thread">The single most common real-world JOIN decision.</div>

**Question:** "List every Instructor, and the number of Sections they
teach, including instructors teaching nothing this semester." Which
JOIN type, and why?

**Answer:** **LEFT JOIN**, from `Instructor`. An `INNER JOIN` would
silently drop any instructor with zero sections, exactly the rows this
question needs kept.

---

# Practice: A Self-Join on the Library Domain

<div class="thread">The self-join pattern, one more time, in a different domain.</div>

**Question:** `Loan(loan_id, book_isbn, member_id)` records one row
per active loan. Write a query finding every pair of distinct members
who currently have the same book (`book_isbn`) checked out.

**Answer:**
```sql
SELECT l1.member_id AS member_a, l2.member_id AS member_b, l1.book_isbn
FROM Loan l1
JOIN Loan l2
  ON l1.book_isbn = l2.book_isbn
 AND l1.member_id < l2.member_id;
```

---

# Practice: EXISTS on the Library Domain

<div class="thread">The same "does any matching row exist" question, applied elsewhere.</div>

**Question:** write a query listing every `Member` who has never taken
out a `Loan`.

**Answer:**
```sql
SELECT name FROM Member m
WHERE NOT EXISTS (
    SELECT 1 FROM Loan l WHERE l.member_id = m.member_id
);
```

---

# Check Yourself: New Multi-Table Patterns

1. Write a query using `RIGHT JOIN` to list every `Section`, including
   one with no enrolled students at all.
2. Write a query using `IN` and a subquery to list every `Student`
   enrolled in any section taught by `instructor_id = 1`.
3. What is the difference between `UNION` and `UNION ALL`, and which
   one is faster when duplicates are already known to be impossible?

---

# Answers: New Multi-Table Patterns

1. ```sql
   SELECT Section.section_id, COUNT(Enrollment.student_id) AS enrolled
   FROM Enrollment
   RIGHT JOIN Section ON Enrollment.section_id = Section.section_id
   GROUP BY Section.section_id;
   ```
2. ```sql
   SELECT name FROM Student
   WHERE student_id IN (
       SELECT student_id FROM Enrollment
       WHERE section_id IN (
           SELECT section_id FROM Section WHERE instructor_id = 1
       )
   );
   ```
3. `UNION` removes duplicate rows across the two result sets; `UNION
   ALL` keeps every row from both. `UNION ALL` is faster, it skips the
   work of checking for and removing duplicates, safe whenever
   duplicates cannot occur or simply do not matter.

---

# Check Yourself

1. Write a query listing every `Section` and how many students are
   enrolled in it, including sections with zero students.
2. What is wrong with
   `SELECT major, COUNT(*) FROM Student WHERE COUNT(*) > 5;`?
3. Rewrite the previous question's query correctly.

---

# Answers

1. ```sql
   SELECT Section.section_id, COUNT(Enrollment.student_id) AS enrolled
   FROM Section
   LEFT JOIN Enrollment ON Section.section_id = Enrollment.section_id
   GROUP BY Section.section_id;
   ```
   `LEFT JOIN` from `Section` keeps sections with zero matching
   enrollment rows.
2. `COUNT(*)` cannot be used in `WHERE`, aggregates do not exist until
   after grouping. It also needs `GROUP BY major` and should use
   `HAVING COUNT(*) > 5` instead.
3. ```sql
   SELECT major, COUNT(*) FROM Student
   GROUP BY major
   HAVING COUNT(*) > 5;
   ```

---

<!-- SLOT 14: Limits, becomes Week 14 slot 4 -->

# What Correct Queries Still Don't Guarantee

<div class="limits">
Every query this week returns the right answer, joined correctly,
grouped correctly. But nothing covered so far says what happens if two
people run conflicting updates at the same instant, or a query runs
against a table with ten million rows instead of a few hundred, or the
server crashes mid-query. Correct answers, on a small, quiet, single-user
system, are not the same problem as correct answers at real scale,
under real concurrency, with real failures.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 12 leaves **failure, concurrency, and scale** unsolved. Quiz 2
next week covers Weeks 9 through 12. **Week 14, Case Study
Presentation**, is where you apply everything from the entire semester
to a system of your own design, and where the instructor closes the
remaining gaps this course previewed back in Week 1: transactions,
concurrency control, and recovery.

---

<!-- SLOT 16: Summary -->

# Summary

- `JOIN` reassembles normalized tables on demand; `INNER JOIN` keeps
  only matched rows, `LEFT JOIN` keeps every row from one side.
- `GROUP BY` clusters rows sharing a value; aggregate functions
  (`COUNT`, `SUM`, `AVG`, `MAX`, `MIN`) summarize each cluster.
- `HAVING` filters groups after aggregation; `WHERE` filters rows
  before it, they are never interchangeable.
- **Reading:** Silberschatz et al., 7th ed., Chapter 3 (Joins, Aggregation)
- **Prepare:** Quiz 2 next week covers Weeks 9-12. Review every Check
  Yourself slide across the SQL half of the course.

---

# A Note on This Week's Sources

Some topics in this deck (`RIGHT`/`FULL OUTER JOIN`, `UNION` and the
other set operations, self-joins, nested and correlated subqueries)
follow the standard SQL topic organization used by course reference
texts such as *Database System Concepts*, 7th ed. (Silberschatz,
Korth, Sudarshan). All wording, examples, and the registration-system
case study on these slides are original.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
