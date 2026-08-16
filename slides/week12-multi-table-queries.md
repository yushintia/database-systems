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

1. Write an `INNER JOIN` and a `LEFT JOIN`, and explain the difference
2. Join more than two tables in a single query
3. Group rows with `GROUP BY` and summarize them with aggregate functions
4. Filter grouped results with `HAVING`, as distinct from `WHERE`

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

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
