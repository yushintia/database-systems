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

# Table Aliases: Shorter Names for Long Joins

<div class="thread">Every query from here on gets longer. Aliases keep it readable.</div>

> An **alias** is a short, temporary name given to a table, usable for
> the rest of that query. `AS` is optional; `Student s` means the
> same as `Student AS s`.

```sql
SELECT s.name, e.grade
FROM Enrollment AS e
JOIN Student AS s ON e.student_id = s.student_id;
```

`e` and `s` are shorthand for `Enrollment` and `Student`. Once a table
has an alias, every reference to its columns must use that alias.

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

# RIGHT JOIN: The Mirror Image of LEFT JOIN

<div class="thread">A third kind of join, rarely needed, worth recognizing on sight.</div>

```sql
SELECT Student.name, Enrollment.grade
FROM Enrollment
RIGHT JOIN Student ON Enrollment.student_id = Student.student_id;
```

`RIGHT JOIN` keeps **every** row from the right-named table (`Student`
here), the mirror image of `LEFT JOIN`. This query returns exactly the
same rows as `Student LEFT JOIN Enrollment` with the table order
swapped, which is why most style guides, this course included, prefer
writing every query as a `LEFT JOIN` and never using `RIGHT JOIN` at all.

---

# Illustration: INNER JOIN vs. LEFT JOIN, Same Data

<div class="thread">The exact same Student-to-Enrollment query, two ways, side by side.</div>

`student_id = 4` is "Lee Jiwoo," enrolled in nothing this semester.

<div class="two-col">
<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>INNER JOIN result</span><span class="tag">3 rows</span></div>
<div class="row">Ahn Rian &mdash; B-</div>
<div class="row">Choi Jian &mdash; B+</div>
<div class="row">Cho Yuri &mdash; F0</div>
</div>
</div>
<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>LEFT JOIN result</span><span class="tag">4 rows</span></div>
<div class="row">Ahn Rian &mdash; B-</div>
<div class="row">Choi Jian &mdash; B+</div>
<div class="row">Cho Yuri &mdash; F0</div>
<div class="row" style="background:var(--cream);">Lee Jiwoo &mdash; NULL</div>
</div>
</div>
</div>

`INNER JOIN` drops Lee Jiwoo entirely. `LEFT JOIN` keeps her, `NULL`
grade. This is exactly the row a misplaced `WHERE` condition, two
slides from now, silently throws back out.

---

# Worked Example: RIGHT JOIN Rewritten as LEFT JOIN

<div class="thread">Confirming the mirror-image claim with a real rewrite, not just an assertion.</div>

```sql
-- RIGHT JOIN: every Section kept, even with zero enrollments
SELECT Section.section_id, Enrollment.student_id
FROM Enrollment
RIGHT JOIN Section ON Enrollment.section_id = Section.section_id;

-- Identical result, written as LEFT JOIN: swap the FROM/JOIN order
SELECT Section.section_id, Enrollment.student_id
FROM Section
LEFT JOIN Enrollment ON Enrollment.section_id = Section.section_id;
```

Both return every `Section`, including any with no enrolled students
at all, `NULL` in `student_id` where none exist. Same answer, same
tables, only the order they are named in changes.

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

# Multiple Conditions Inside ON

<div class="thread">ON is not limited to one equality. Any number of conditions can live there.</div>

```sql
SELECT Section.section_id, Enrollment.student_id
FROM Section
JOIN Enrollment
  ON Section.section_id = Enrollment.section_id
 AND Section.semester = '2026-1';
```

Both conditions must hold for a row pair to match: the foreign key
still agrees, **and** the row belongs to the current semester. This is
a plain `INNER JOIN`, so the extra condition is equivalent to adding it
to `WHERE` instead, unlike the `LEFT JOIN` case two slides ago.

---

# USING: Shorthand When Column Names Match

<div class="thread">A shorter spelling of ON, for the common case where both sides share a column name.</div>

```sql
SELECT Section.room, Enrollment.grade
FROM Section
JOIN Enrollment USING (section_id);
```

`USING (section_id)` means exactly `ON Section.section_id =
Enrollment.section_id`, valid only because both tables actually name
the column `section_id`. `ON` is required whenever the matching
columns have different names on each side, for example
`Section.course_code` against `Course.course_code` still needs `ON`
spelled out if either name ever diverges.

---

# Self-JOIN: A Table Joined to Itself

<div class="thread">Nothing requires the two tables in a JOIN to be different tables.</div>

> A **self-join** joins a table to a copy of itself, using two
> aliases so SQL can tell the two roles apart.

```sql
SELECT e1.student_id, e2.student_id
FROM Enrollment e1
JOIN Enrollment e2
  ON e1.section_id = e2.section_id
 AND e1.student_id < e2.student_id;
```

`e1` and `e2` are the same `Enrollment` table, read twice.
`student_id <` keeps each pair once, not both orders, and rules out
pairing a student with themselves.

---

# Worked Example: Students Sharing a Section

<div class="thread">The self-join, applied to one real section, with real output.</div>

```sql
SELECT s1.name AS student_a, s2.name AS student_b
FROM Enrollment e1
JOIN Enrollment e2
  ON e1.section_id = e2.section_id AND e1.student_id < e2.student_id
JOIN Student s1 ON e1.student_id = s1.student_id
JOIN Student s2 ON e2.student_id = s2.student_id
WHERE e1.section_id = 3;
```

| student_a | student_b |
|---|---|
| Ahn Rian | Choi Jian |
| Ahn Rian | Cho Yuri |

---

# The Ambiguous Column Trap

<div class="thread">A real MySQL error, guaranteed to happen the first time two joined tables share a column name.</div>

```sql
SELECT name
FROM Student
JOIN Enrollment ON Student.student_id = Enrollment.student_id
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Instructor ON Section.instructor_id = Instructor.instructor_id;
-- ERROR 1052 (23000): Column 'name' in field list is ambiguous
```

Both `Student` and `Instructor` have a `name` column; MySQL has no way
to guess which one `name` alone means. The fix is to qualify it:

```sql
SELECT Student.name FROM Student ...
```

---

# A Three-Table JOIN: Section, Course, Instructor

<div class="thread">A stepping stone before the pain slide's full four-table question.</div>

```sql
SELECT Section.section_id, Course.title, Instructor.name
FROM Section
JOIN Course ON Section.course_code = Course.course_code
JOIN Instructor ON Section.instructor_id = Instructor.instructor_id;
```

| section_id | title | name |
|---|---|---|
| 3 | Database Systems | Prof. Lee |
| 5 | Data Structures | Prof. Han |
| 8 | Advanced Databases | Prof. Kwon |

No `Enrollment` needed: three tables, two joins, done.

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

# Illustration: GROUP BY Turns Rows Into Buckets

<div class="thread">The exact query on the previous slide, drawn as buckets instead of a result table.</div>

<div class="groupviz">
<div class="bucket">
<div class="label">section_id = 3</div>
<div class="rows">11, B+<br>12, A0<br>13, A0</div>
<div class="agg">COUNT(*) = 3</div>
</div>
<div class="bucket">
<div class="label">section_id = 5</div>
<div class="rows">21, B0<br>22, C+</div>
<div class="agg">COUNT(*) = 2</div>
</div>
<div class="bucket">
<div class="label">section_id = 8</div>
<div class="rows">31, A0<br>32, B+<br>33, NULL<br>34, B-</div>
<div class="agg">COUNT(*) = 4</div>
</div>
</div>

Every `Enrollment` row lands in exactly one bucket by `section_id`;
`COUNT(*)` then summarizes each bucket on its own, exactly what
`SELECT Section.section_id, COUNT(*) ... GROUP BY Section.section_id`
computes, one bucket at a time.

---

# GROUP BY on Multiple Columns

<div class="thread">A group can be defined by more than one column at once.</div>

```sql
SELECT Section.semester, Instructor.name, COUNT(*) AS sections_taught
FROM Section
JOIN Instructor ON Section.instructor_id = Instructor.instructor_id
GROUP BY Section.semester, Instructor.name;
```

Two rows with the same instructor but different semesters land in
**different** groups; a group is defined by the whole combination of
`semester` and `name` together, not either column alone.

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

# HAVING With a Different Condition: Under-enrolled Sections

<div class="thread">The same clause, the opposite direction, a genuinely different real question.</div>

```sql
SELECT Section.section_id, COUNT(*) AS enrolled
FROM Enrollment
GROUP BY Section.section_id
HAVING COUNT(*) < 3;
```

Every section at risk of being cancelled for low enrollment, three
students or fewer. `HAVING` accepts any comparison against an
aggregate, not only `>`, the condition is whatever the real question
asks.

---

# HAVING With a Range: BETWEEN on an Aggregate

<div class="thread">HAVING accepts the same comparison operators WHERE does, BETWEEN included.</div>

```sql
SELECT Section.section_id, COUNT(*) AS enrolled
FROM Enrollment
GROUP BY Section.section_id
HAVING COUNT(*) BETWEEN 3 AND 8;
```

Sections comfortably staffed, neither at risk of cancellation nor
overcrowded. `HAVING COUNT(*) BETWEEN 3 AND 8` is exact shorthand for
`HAVING COUNT(*) >= 3 AND COUNT(*) <= 8`, the same relationship Week
11's `BETWEEN` had to `WHERE`, just one level later in the query.

---

# GROUP BY, WHERE, and HAVING Together

<div class="thread">The two filter clauses this week taught separately, used together in one query.</div>

```sql
SELECT Section.section_id, COUNT(*) AS graded_count
FROM Enrollment
WHERE grade IS NOT NULL
GROUP BY Section.section_id
HAVING COUNT(*) >= 5;
```

`WHERE grade IS NOT NULL` removes ungraded rows first, **before**
grouping, so they never enter a bucket at all. `HAVING COUNT(*) >= 5`
then keeps only sections where at least 5 **graded** enrollments
remain. Swapping which clause does which job would either count
ungraded rows that should not count, or fail outright.

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

# Subquery in FROM: A Derived Table

<div class="thread">A subquery does not have to live in WHERE. It can be the table a query reads from.</div>

> A subquery used in place of a table name, in `FROM`, is called a
> **derived table**, given an alias, behaving like a real table.

```sql
SELECT counts.section_id, counts.n
FROM (
    SELECT section_id, COUNT(*) AS n
    FROM Enrollment
    GROUP BY section_id
) AS counts
WHERE counts.n > 5;
```

`counts` is not a real table, it is the inner query's result, named so
the outer query can filter it like any other table.

---

# A Correlated Scalar Subquery in SELECT

<div class="thread">A subquery that references the outer query's current row, re-run once per row.</div>

> A **correlated subquery** references a column from the outer query
> inside its own `WHERE`, re-running once per outer row instead of once total.

```sql
SELECT s.name,
    (SELECT COUNT(*) FROM Enrollment e
     WHERE e.student_id = s.student_id) AS enrollment_count
FROM Student s;
```

For every `Student` row, the inner `SELECT` counts only that
student's own enrollments; `e.student_id = s.student_id` ties it back
to the current outer row. No `GROUP BY` needed.

---

# COUNT(DISTINCT ...) After a JOIN: Avoiding a Double-Count

<div class="thread">A join can multiply rows before an aggregate ever runs. This is the fix.</div>

```sql
SELECT Course.title, COUNT(DISTINCT Enrollment.student_id) AS unique_students
FROM Course
JOIN Section ON Course.course_code = Section.course_code
JOIN Enrollment ON Section.section_id = Enrollment.section_id
GROUP BY Course.course_code, Course.title;
```

A course taught in two sections the same semester produces two joined
rows per student who is somehow in both, plain `COUNT(*)` would count
that student twice. `COUNT(DISTINCT Enrollment.student_id)` counts
each `student_id` once per course, no matter how many joined rows it
appears in.

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

# EXISTS: The Positive Case

<div class="thread">The same test, the opposite answer, using the plain form instead of NOT EXISTS.</div>

```sql
SELECT name FROM Student s
WHERE EXISTS (
    SELECT 1 FROM Enrollment e WHERE e.student_id = s.student_id
);
```

Every student with **at least one** enrollment, the exact complement
of the `NOT EXISTS` slide before this one. `SELECT 1` is a common
convention here, the inner query's actual column list never matters
to `EXISTS`, only whether any row comes back at all.

---

# NOT EXISTS vs. LEFT JOIN ... IS NULL: Confirmed Identical

<div class="thread">Two entirely different-looking queries, checked side by side, same rows back.</div>

```sql
SELECT name FROM Student s
WHERE NOT EXISTS (
    SELECT 1 FROM Enrollment e WHERE e.student_id = s.student_id
);

SELECT Student.name FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id
WHERE Enrollment.student_id IS NULL;
```

Both return "Lee Jiwoo" and nobody else, `LEFT JOIN` just builds a
`NULL` row first, where `NOT EXISTS` never does.

---

# EXISTS With an Extra Condition: A Correlated Subquery Filter

<div class="thread">EXISTS is not limited to matching a foreign key alone; its subquery can carry any WHERE.</div>

```sql
SELECT name FROM Student s
WHERE EXISTS (
    SELECT 1 FROM Enrollment e
    WHERE e.student_id = s.student_id AND e.grade = 'A0'
);
```

Every student with at least one `'A0'` grade, anywhere in their
record. The correlation (`e.student_id = s.student_id`) ties the
subquery to the right student; the extra `AND e.grade = 'A0'` narrows
which of that student's enrollments counts as a match.

---

# IN Subquery: Students in Any Section of One Course

<div class="thread">A single-table subquery whose result answers a genuinely multi-table question.</div>

```sql
SELECT name FROM Student
WHERE student_id IN (
    SELECT Enrollment.student_id
    FROM Enrollment
    JOIN Section ON Enrollment.section_id = Section.section_id
    WHERE Section.course_code = 'CSE301'
);
```

The inner query itself joins `Enrollment` to `Section` to translate
"course `CSE301`" into a list of matching `section_id` values; the
outer query then only needs `IN`, no join of its own required.

---

# Same Answer, Two Ways: IN Subquery vs. JOIN + DISTINCT

<div class="thread">Two genuinely different query shapes, the same rows back.</div>

```sql
SELECT name FROM Student
WHERE student_id IN (
    SELECT student_id FROM Enrollment WHERE section_id = 3
);

SELECT DISTINCT Student.name FROM Student
JOIN Enrollment ON Student.student_id = Enrollment.student_id
WHERE Enrollment.section_id = 3;
```

Same names back. The subquery form never risks a duplicate row,
`DISTINCT` is what makes the `JOIN` form safe from repeats instead.

---

# The NOT IN + NULL Trap

<div class="thread">A subtle, genuinely common mistake, worth seeing once on purpose.</div>

<div class="pain">

```sql
SELECT name FROM Student
WHERE student_id NOT IN (
    SELECT student_id FROM Enrollment WHERE grade IS NULL
);
```

If the inner `SELECT` can return even one `NULL` alongside its real
values, `NOT IN` silently matches **zero rows for the entire query**,
not just the `NULL` row. `student_id` cannot be `NULL` here so this
particular query is safe, but the moment a subquery's column allows
`NULL`, `NOT EXISTS` is the safer choice, it never has this failure mode.

</div>

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

# Worked Example: The Same Pattern, a Different Instructor

<div class="thread">The exact same four-JOIN shape, proving it was never a one-off trick for Prof. Lee alone.</div>

```sql
SELECT Student.name, Enrollment.grade, Course.title
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Course ON Section.course_code = Course.course_code
JOIN Instructor ON Section.instructor_id = Instructor.instructor_id
WHERE Instructor.name = 'Prof. Han';
```

| name | grade | title |
|---|---|---|
| Park Jiho | A0 | Data Structures |
| Han Somin | B+ | Data Structures |

Not one line of the query's shape changed, only the value in `WHERE`,
exactly the point: this pattern generalizes to any instructor.

---

# Worked Example: Instructors Teaching Nothing This Semester (1/2)

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

---

# Worked Example: Instructors Teaching Nothing This Semester (2/2)

<div class="thread">The result of the previous slide's query, and what it shows.</div>

| name | sections_taught |
|---|---|
| Prof. Baek | 0 |
| Prof. Nam | 0 |

An `INNER JOIN` here would make every one of these instructors vanish
from the result entirely, not an error, just a silently incomplete
answer.

---

# Worked Example: Total Students Taught, Per Instructor

<div class="thread">The same LEFT JOIN + GROUP BY shape, counting the opposite thing.</div>

```sql
SELECT Instructor.name, COUNT(Enrollment.student_id) AS students_taught
FROM Instructor
LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
LEFT JOIN Enrollment ON Section.section_id = Enrollment.section_id
GROUP BY Instructor.instructor_id, Instructor.name;
```

| name | students_taught |
|---|---|
| Prof. Lee | 47 |
| Prof. Han | 12 |
| Prof. Baek | 0 |

Three tables, two `LEFT JOIN`s, so an instructor with sections but zero
enrolled students, or no sections at all, still shows up with `0`
instead of disappearing.

---

# Worked Example: Every Section's Enrollment Count, Including Zero

<div class="thread">The same shape once more, this time keeping every Section instead of every Instructor.</div>

```sql
SELECT Section.section_id, Course.title, COUNT(Enrollment.student_id) AS enrolled
FROM Section
JOIN Course ON Section.course_code = Course.course_code
LEFT JOIN Enrollment ON Section.section_id = Enrollment.section_id
GROUP BY Section.section_id, Course.title
HAVING enrolled < 3;
```

`Section` and `Course` use a plain `JOIN`, every `Section` truly does
have a `Course`. `Enrollment` uses `LEFT JOIN`, because a brand-new
section can legitimately have zero enrollments so far, and this query
specifically wants to find those.

---

# Worked Example: Every Student's Enrollment Count, Even Zero

<div class="thread">The same LEFT JOIN + GROUP BY shape, back on the Student side where this act started.</div>

```sql
SELECT Student.name, COUNT(Enrollment.section_id) AS enrollment_count
FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id
GROUP BY Student.student_id, Student.name
HAVING enrollment_count = 0;
```

| name | enrollment_count |
|---|---|
| Lee Jiwoo | 0 |

The same student the deck's very first `LEFT JOIN` example, and the
`NOT EXISTS` slide, both found by different means. Three different
query shapes, one recurring row, confirming they all agree.

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

# Sample Question 1

**Question:** What is the difference between what `INNER JOIN` keeps
and what `LEFT JOIN` keeps?

---

# Sample Question 1: Answer

**Answer:** `INNER JOIN` keeps only rows with a match on both sides.
`LEFT JOIN` keeps every row from the left table, filling in `NULL`
for the right table's columns where no match exists.

---

# Sample Question 2

**Question:** Why is `WHERE enrolled > 8` invalid immediately after
`GROUP BY Section.section_id`, when `enrolled` is an alias for
`COUNT(*)`?

---

# Sample Question 2: Answer

**Answer:** `WHERE` filters individual rows **before** grouping
happens, so `enrolled` does not exist as a value yet at that point.
`HAVING` filters entire groups **after** grouping and aggregation,
exactly what this needs.

---

# Sample Question 3

**Question:** On a `LEFT JOIN`, why does putting a condition on the
right table in `WHERE` instead of `ON` silently turn it back into an
`INNER JOIN`?

---

# Sample Question 3: Answer

**Answer:** `WHERE` runs *after* the `LEFT JOIN` already kept the
unmatched rows with `NULL`; a `WHERE` condition on the right table's
column throws those `NULL` rows straight back out, silently
recreating an `INNER JOIN`.

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
- **Lab page:** [Lab 12 in the online Lab Manual](../book/labs/lab12-multi-table-queries.html), for the
  Guided Exercises, Challenge Problem, and rubric
- **Reading:** Silberschatz et al., 7th ed., Chapter 3, 5 (Joins, Aggregation)
- **Prepare:** Quiz 2 next week covers Weeks 9-12. Review every Sample
  Question slide across the SQL half of the course.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
