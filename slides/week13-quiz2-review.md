---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 13: Quiz 2

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: Short-review variant. Covers Weeks 9-12, the entire MySQL/SQL half of the course. -->

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
<div class="wk"><div class="n">Wk 12</div><div class="t">Multi-table Queries</div></div>
<div class="wk review now"><div class="n">Wk 13</div><div class="t">Quiz 2</div></div>
<div class="wk"><div class="n">Wk 14</div><div class="t">Case Study Presentation</div></div>
<div class="wk review"><div class="n">Wk 15</div><div class="t">Final Exam</div></div>
</div>

---

<!-- SLOT 3: Recap -->

# Four Weeks, From Empty Tables to Real Answers

<div class="thread">The complete SQL arc, one line each.</div>

<div class="pipeline">
<div class="stage"><div class="h">DDL</div><div class="s">Wk 9: build structure</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">DML</div><div class="s">Wk 10: fill it in</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Queries</div><div class="s">Wk 11: ask one table</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Joins</div><div class="s">Wk 12: ask several</div></div>
</div>

---

<!-- _class: section -->

# Quiz 2 Today
<div class="driving-q">Weeks 9-12. Written, individual, closed book.</div>

---

# Review: DDL (Week 9)

- `CREATE TABLE` defines structure: columns, data types, `PRIMARY KEY`,
  `FOREIGN KEY`, `NOT NULL`, `AUTO_INCREMENT`
- `ALTER TABLE` changes existing structure; `DROP TABLE` removes it
  entirely, along with all its data
- Table creation order follows dependency order: a table cannot
  reference one that does not exist yet

---

# Review: DDL and DML, Side by Side

<div class="thread">The distinction quiz questions test most often.</div>

| | DDL (Week 9) | DML (Week 10) |
|---|---|---|
| Changes | structure | data |
| Commands | `CREATE`, `ALTER`, `DROP` | `INSERT`, `UPDATE`, `DELETE` |
| Ordering rule | tables in dependency order | rows in dependency order |
| Undo risk | `DROP TABLE` loses structure + data | `DELETE` without `WHERE` loses all rows |

---

# Review: DML (Week 10)

- `INSERT INTO ... VALUES` adds rows; foreign-key targets must already
  exist
- `UPDATE ... SET ... WHERE` changes rows; without `WHERE`, every row
  in the table changes
- `DELETE FROM ... WHERE` removes rows; MySQL blocks deletions that
  would orphan a foreign-key reference

---

# Review: Single-table Queries (Week 11)

- `SELECT` columns, `FROM` a table, `WHERE` rows match a condition
- Comparison operators (`=`, `>`, `LIKE`, `BETWEEN`) and logical
  operators (`AND`, `OR`, `NOT`) build precise filters
- `DISTINCT` removes duplicate results; `ORDER BY` sorts; `LIMIT`
  caps how many rows return

---

# Review: Multi-table Queries (Week 12)

- `JOIN ... ON` combines rows from related tables by matching keys
- `INNER JOIN` keeps only matched rows; `LEFT JOIN` keeps every row
  from the left table even without a match
- `GROUP BY` clusters rows; `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`
  summarize each cluster; `HAVING` filters groups, `WHERE` filters rows

---

# Review: WHERE vs. HAVING, One More Time

<div class="thread">The single most-missed distinction on Quiz 2, in past semesters and this one.</div>

```sql
SELECT major, COUNT(*) FROM Student
WHERE major IS NOT NULL
GROUP BY major
HAVING COUNT(*) > 5;
```

`WHERE` runs first, on raw rows. `GROUP BY` runs next. `HAVING` runs
last, on the grouped, aggregated result. All three can appear in one
query, in exactly this order.

---

# Sample Question 1

**Question:** `UPDATE Section SET room = '성파 615' WHERE
instructor_id = 1;` is run without checking how many rows match first.
What could go wrong, and how would you check safely beforehand?

**Answer:** Every section taught by instructor 1 changes room at once,
which may be more sections than intended. Run
`SELECT * FROM Section WHERE instructor_id = 1;` first, to see exactly
which rows the `UPDATE` will affect, before running it.

---

# Sample Question 2

**Question:** Write a query returning each instructor's name and how
many sections they teach, including instructors currently teaching
zero sections.

**Answer:**

```sql
SELECT Instructor.name, COUNT(Section.section_id) AS section_count
FROM Instructor
LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
GROUP BY Instructor.name;
```

`LEFT JOIN` is required to keep instructors with zero matching sections.

---

# Sample Question 3

**Question:** `INSERT INTO Section (course_code, instructor_id) VALUES
('CSE999', 1);` fails. `CSE999` does not exist in `Course`. Which
Week 9 constraint caused the failure, and is that a problem or a feature?

**Answer:** **Referential integrity** (a `FOREIGN KEY` constraint,
Week 9). It is a feature: it caught an error, an orphaned reference,
before it could ever be written to the database.

---

# Sample Question 4

**Question:** Write a query listing every course title and the average
grade point of students enrolled in it, for courses with more than 5
enrollments. (Assume a `GradePoints(grade, points)` lookup table.)

**Answer:**
```sql
SELECT Course.title, AVG(gp.points) AS avg_gp
FROM Course
JOIN Section ON Course.course_code = Section.course_code
JOIN Enrollment ON Section.section_id = Enrollment.section_id
JOIN GradePoints gp ON Enrollment.grade = gp.grade
GROUP BY Course.title
HAVING COUNT(*) > 5;
```

---

# Sample Question 5

**Question:** What is the difference between `DELETE FROM Enrollment;`
and `DELETE FROM Enrollment WHERE student_id = 1;`?

**Answer:** The first deletes **every** row in `Enrollment`,
permanently. The second deletes only rows matching `student_id = 1`.
The missing `WHERE` clause is the single most damaging DML mistake
covered this semester.

---

# Common Quiz 2 Mistakes to Avoid

- **Writing DML syntax where DDL is asked, or vice versa:** know which
  family a question is testing before answering
- **Forgetting `LEFT JOIN` when a question says "including those with
  none":** that phrase is always a signal, not decoration
- **Placing `HAVING` conditions in `WHERE`:** any condition on an
  aggregate function belongs in `HAVING`, never `WHERE`

---

<!-- What to focus on next -->

# What to Focus On Next

<div class="limits">
Weeks 9 through 12 cover everything needed to build, fill, and query
the registration database correctly. Week 14's case study presentation
asks you to apply all of it, design through query, to a system of your
own choosing. If JOIN types or the WHERE-versus-HAVING distinction
still feel shaky, that is exactly what your own presentation will need
solid.
</div>

---

# Next Week

Week 14, **Case Study Presentation**, is your own system, designed and
queried with everything from this entire semester.

---

# Summary

- Quiz 2 covers Weeks 9 through 12: DDL, DML, single-table queries,
  and multi-table queries, the complete SQL half of the course.
- Together, these four weeks turn a normalized paper schema into a
  real, running, queryable MySQL database.
- **Prepare:** review every Worked Example and Check Yourself slide
  across Weeks 9-12; the quiz draws directly on the registration schema.

---

<!-- _class: end -->

# Thank You
