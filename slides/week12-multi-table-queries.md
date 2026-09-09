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

# HAVING: Filtering Groups, Not Rows

<div class="thread">A second filter clause, easy to confuse with WHERE. Here is exactly how they differ.</div>

```sql
SELECT Section.section_id, COUNT(*) AS enrolled
FROM Enrollment
GROUP BY Section.section_id
HAVING COUNT(*) > 8;
```

`WHERE` filters individual rows, **before** grouping happens.
`HAVING` filters entire groups, **after** grouping and aggregation.
`WHERE enrolled > 8` is invalid here, `enrolled` does not exist until
grouping has already happened.

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

# EXISTS and NOT EXISTS: Testing Whether Any Row Matches

<div class="thread">A different question than IN: not "is this value on the list," but "does any matching row exist at all."</div>

> `EXISTS (subquery)` is `TRUE` if the subquery returns **at least one
> row**, `FALSE` if it returns none, the actual row values never
> matter, only whether any exist. `NOT EXISTS` is its negation.

```sql
SELECT name FROM Student s
WHERE NOT EXISTS (
    SELECT 1 FROM Enrollment e WHERE e.student_id = s.student_id
);
```

Every student with **zero** enrollments, the same students a `LEFT
JOIN ... WHERE Enrollment.student_id IS NULL` would find. `NOT
EXISTS` is often the more direct way to ask "which rows have no
counterpart," without writing an outer join at all.

---

# Demo, Step by Step: Joining Four Tables

<div class="thread">The pain slide's actual question, built one JOIN at a time, not handed over finished. The lab's first Worked Example.</div>

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

# Worked Example: Instructors Teaching Nothing This Semester

<div class="thread">The lab's second Worked Example: LEFT JOIN, GROUP BY, and HAVING, together.</div>

`full_seed.sql` deliberately includes instructors with zero sections,
so this exact case has a real, checkable answer.

```sql
SELECT Instructor.name, COUNT(Section.section_id) AS sections_taught
FROM Instructor
LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
GROUP BY Instructor.instructor_id, Instructor.name
HAVING sections_taught = 0;
```

| name | sections_taught |
|---|---|
| Prof. Baek | 0 |
| Prof. Nam | 0 |

An `INNER JOIN` here would make every one of these instructors vanish
from the result entirely, not an error, just a silently incomplete
answer.

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
  value (`COUNT(*) > 8`) always requires `HAVING`, never `WHERE`
- **Choosing INNER JOIN when rows need to be kept anyway:** if the
  question is "which instructors have no sections," `INNER JOIN`
  silently makes those exact instructors disappear
- **Putting an outer-join condition in `WHERE` instead of `ON`:** it
  silently cancels the outer join's entire purpose, turning it back
  into an `INNER JOIN` in practice

---

# Check Yourself

1. What is the difference between what `INNER JOIN` keeps and what
   `LEFT JOIN` keeps?
2. Why is `WHERE enrolled > 8` invalid immediately after
   `GROUP BY Section.section_id`, when `enrolled` is an alias for
   `COUNT(*)`?
3. On a `LEFT JOIN`, why does putting a condition on the right table
   in `WHERE` instead of `ON` silently turn it back into an
   `INNER JOIN`?

---

# Answers

1. `INNER JOIN` keeps only rows with a match on both sides. `LEFT
   JOIN` keeps every row from the left table, filling in `NULL` for
   the right table's columns where no match exists.
2. `WHERE` filters individual rows **before** grouping happens, so
   `enrolled` does not exist as a value yet at that point. `HAVING`
   filters entire groups **after** grouping and aggregation, exactly
   what this needs.
3. `WHERE` runs *after* the `LEFT JOIN` already kept the unmatched
   rows with `NULL`; a `WHERE` condition on the right table's column
   throws those `NULL` rows straight back out, silently recreating an
   `INNER JOIN`.

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
- **Lab page:** `book/src/labs/lab12-multi-table-queries.md`, for the
  Guided Exercises, Challenge Problem, and rubric
- **Reading:** Silberschatz et al., 7th ed., Chapter 3 (Joins, Aggregation)
- **Prepare:** Quiz 2 next week covers Weeks 9-12. Review every Check
  Yourself slide across the SQL half of the course.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
