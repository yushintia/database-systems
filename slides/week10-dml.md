---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 10: DML

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

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
<div class="wk now"><div class="n">Wk 10</div><div class="t">DML</div></div>
<div class="wk"><div class="n">Wk 11</div><div class="t">Single-table Queries</div></div>
<div class="wk"><div class="n">Wk 12</div><div class="t">Multi-table Queries</div></div>
<div class="wk review"><div class="n">Wk 13</div><div class="t">Quiz 2</div></div>
<div class="wk"><div class="n">Wk 14</div><div class="t">Case Study Presentation</div></div>
<div class="wk review"><div class="n">Wk 15</div><div class="t">Final Exam</div></div>
</div>

---

<!-- SLOT 3: Recap + open wound -->

# Last Week, This Week

- **Last week delivered:** the entire registration schema, created for real in MySQL, every constraint from Weeks 2-7 enforced automatically
- **Last week left broken:** every table is perfectly structured and completely empty. `SELECT * FROM Student` returns zero rows

---

<!-- SLOT 4: The pain -->

# A Database With Nothing In It

<div class="pain">

The registration schema is live in MySQL. Every table exists exactly
as designed. A professor logs in and asks a simple question: "who is
enrolled in my section?"

`SELECT * FROM Enrollment;` runs instantly, correctly, and returns
nothing. Not because anything is broken, the query is fine, the schema
is fine, there is simply no data yet. A perfect empty room answers
every question the same way: silence.

</div>

<!-- notes: Ask the class what the single next command has to be, before anything else is possible. Let them arrive at INSERT. -->

---

# What Else This Actually Costs

- A correct schema with no data cannot demonstrate anything, cannot be
  tested, cannot be shown to a stakeholder as "working"
- Getting `INSERT` statements wrong, in the wrong order, violating a
  foreign key, is the most common way beginners hit their first real
  MySQL error message
- A system with no way to safely update or remove data is stuck the
  moment reality changes, a student switches majors, a class is dropped

<div class="why">
<strong>In industry:</strong> `INSERT`, `UPDATE`, and `DELETE` are the
three operations behind every "save," "edit," and "delete" button in
every application you have ever used. They are DML by another name.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What commands put data in, change it safely, and remove it without breaking anything else?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

<div class="cardlist">
<div class="card"><div class="h">INSERT</div><div class="d">Insert one or more rows into a table with <code>INSERT INTO ... VALUES</code>, respecting foreign-key order</div></div>
<div class="card"><div class="h">UPDATE</div><div class="d">Change existing data safely with <code>UPDATE ... SET ... WHERE</code></div></div>
<div class="card"><div class="h">DELETE</div><div class="d">Remove rows safely with <code>DELETE FROM ... WHERE</code>, and explain what MySQL protects against</div></div>
<div class="card"><div class="h">Referential-Integrity Errors</div><div class="d">Read and react correctly to an error caused by inserting or deleting in the wrong order</div></div>
</div>

---

<!-- SLOT 8: Origin -->

# Where DML Came From

<div class="thread">The second of SQL's two families, promised back in Week 9.</div>

- SQL's designers split commands into DDL (structure) and **Data
  Manipulation Language (DML)** (data) from the very first version,
  because the two are genuinely different operations with different
  risks: getting `DROP TABLE` wrong loses structure, getting `DELETE`
  wrong loses data
- DML's four core commands, `SELECT`, `INSERT`, `UPDATE`, `DELETE`, have
  barely changed since System R. This week covers three of the four;
  `SELECT` gets its own two weeks starting Week 11

---

<!-- SLOT 9: Core concept -->

# DML: Definition

<div class="thread">Structure was last week's job. Data is this week's.</div>

> **Data Manipulation Language (DML)** is the subset of SQL used to
> insert, change, retrieve, and remove data inside an existing table
> structure.

`INSERT`, `UPDATE`, `DELETE`, and `SELECT` are DML. Everything from
Week 9, `CREATE`, `ALTER`, `DROP`, is DDL. You cannot run DML against a
table that DDL has not created first, exactly last week's ordering rule.

---

<!-- Act 3 / BUILD -->

# INSERT: Adding Rows

<div class="thread">The single command that ends this week's pain slide.</div>

```sql
INSERT INTO Student (name, major)
VALUES ('Kim Minji', 'Computer Science');
```

`student_id` is not listed, `AUTO_INCREMENT` from Week 9 generates it.
A single statement can also insert several rows at once, which real
systems always prefer over many separate statements:

```sql
INSERT INTO Student (name, major) VALUES
    ('Kim Minji', 'Computer Science'),
    ('Park Jiho', 'Software Engineering'),
    ('Han Somin', 'Computer Science');
```

---

# INSERT Order Follows Week 9's Dependency Order

<div class="thread">Week 9's foreign keys are not just declared, MySQL actively checks them here.</div>

```sql
INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE301', 1, '성파 702', '2026-1');
```

This fails immediately if `course_code = 'CSE301'` does not already
exist in `Course`, or `instructor_id = 1` does not exist in
`Instructor`. The referenced rows must be inserted **first**, the exact
same dependency order Week 9 used for `CREATE TABLE`.

> **Orphaned row:** a row that points, by foreign key, at a value that
> does not exist in the referenced table. MySQL refuses to create one
> on `INSERT`, and refuses to create one on `DELETE` too.

---

# NULL Handling on INSERT: What You Can Omit

<div class="thread">Not every column needs a value. Which ones don't, and why.</div>

```sql
INSERT INTO Enrollment (student_id, section_id)
VALUES (12, 3);
```

`grade` is left out entirely; MySQL fills it with `NULL`
automatically, "not yet graded." This only works because `grade` was
declared without `NOT NULL` back in Week 9.

- **Can omit:** any `AUTO_INCREMENT` column, any column with a
  `DEFAULT`, any column that allows `NULL`
- **Cannot omit:** any column declared `NOT NULL` with no `DEFAULT`,
  MySQL has nothing to put there instead

---

# UPDATE: Changing Existing Data

<div class="thread">Week 7's exact update-anomaly scenario, now the actual fix.</div>

```sql
UPDATE Instructor
SET name = 'Lee, Married Name'
WHERE instructor_id = 1;
```

Because `Instructor.name` lives in exactly one row (Week 7's 3NF fix),
this single `UPDATE` is the entire fix. No other table needs touching,
exactly why a normalized schema turns every update into one statement,
not a search-and-replace across many rows.

---

# UPDATE: The WHERE Clause Is Not Optional

<div class="pain">
Run <code>UPDATE Instructor SET name = 'Lee, Married Name';</code>
without a <code>WHERE</code> clause, and MySQL updates <strong>every
row in the table</strong>, every instructor, to the exact same name.
There is no undo button once this commits. Always write the
<code>WHERE</code> clause first, mentally, before the <code>SET</code>.
</div>

---

# DELETE: Removing Rows, and What MySQL Protects

<div class="thread">Week 2's referential integrity, enforced again, in the opposite direction from INSERT.</div>

```sql
DELETE FROM Enrollment
WHERE student_id = 7 AND section_id = 3;
```

Like `UPDATE`, `DELETE` with no `WHERE` clause removes **every row in
the table**, silently. And exactly like `INSERT`, `DELETE` is checked
against foreign keys, in the opposite direction:

```sql
DELETE FROM Instructor WHERE instructor_id = 1;
```

If instructor 1 still teaches any `Section`, MySQL rejects this by
default, the sections must be reassigned or removed first.

---

# Subqueries Inside DML

<div class="thread">A WHERE that compares to the result of another SELECT, instead of a literal value.</div>

> **Subquery:** a complete `SELECT` statement nested inside another
> statement's `WHERE` clause. MySQL runs the inner `SELECT` first,
> producing a list of values, then runs the outer statement's
> condition against that list.

```sql
DELETE FROM Enrollment
WHERE student_id IN (
    SELECT student_id FROM Student
    WHERE major = 'Software Engineering'
);
```

A good habit: run the inner `SELECT` alone first, and look at what it
actually returns, before wrapping it in a `DELETE` or `UPDATE`.

---

# Worked Example: One Student's Whole Semester (1/2)

<div class="thread">One student, from enrollment to a verified state, every DML command used in the order a real semester happens.</div>

**Step 1 — Enroll:**

```sql
INSERT INTO Student (name, major)
VALUES ('Park Jiho', 'Software Engineering');
-- MySQL assigns student_id = 12

INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (12, 3, NULL);
```

**Step 2 — Verify before changing anything:**

```sql
SELECT * FROM Enrollment WHERE student_id = 12;
-- | 12 | 3 | NULL |
```

---

# Worked Example: One Student's Whole Semester (2/2)

<div class="thread">The same student, a grade correction, then a withdrawal.</div>

**Step 3 — Grade posted, then corrected:**

```sql
UPDATE Enrollment SET grade = 'B0'
WHERE student_id = 12 AND section_id = 3;
-- a data-entry mistake noticed later

UPDATE Enrollment SET grade = 'A0'
WHERE student_id = 12 AND section_id = 3;
```

**Step 4 — Withdrawal:**

```sql
DELETE FROM Enrollment
WHERE student_id = 12 AND section_id = 3;
```

The second `UPDATE` is not a workaround, correcting one fact without
touching any other row is exactly what `UPDATE` is for. `Student` is
untouched by the `DELETE`, only this one enrollment record is gone.

---

# Worked Example: A Foreign-Key Failure, Fixed

<div class="thread">The most common first real MySQL error, and the two-line fix.</div>

```sql
INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE410', 9, '성파 810', '2026-1');
-- ERROR 1452 (23000): Cannot add or update a child row:
-- a foreign key constraint fails
```

`instructor_id = 9` does not exist yet in `Instructor`. The fix is to
insert the referenced row first:

```sql
INSERT INTO Instructor (name) VALUES ('Prof. Kwon');
-- MySQL assigns instructor_id = 9

INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE410', 9, '성파 810', '2026-1');
```

---

# Common Mistakes

- **Running `UPDATE` or `DELETE` without `WHERE`:** the single most
  common, and most damaging, DML mistake. Always write and check the
  `WHERE` clause before running the statement
- **Inserting into a table before its foreign-key targets exist:**
  respect Week 9's creation order for `INSERT` too
- **Assuming `DELETE` cascades automatically:** by default it does
  not; MySQL blocks deletions that would orphan foreign-key references
- **Wrapping a subquery in `DELETE`/`UPDATE` without checking it
  alone first:** the outer statement is only as correct as the row set
  the inner `SELECT` actually returns

---

# Check Yourself

1. Write an `INSERT` statement adding a new `Student`, "Park Jiho,"
   major "Software Engineering."
2. What happens if you run `DELETE FROM Section;` with no `WHERE`
   clause, and why is this dangerous?
3. Why is it good practice to run a matching `SELECT`, with the same
   `WHERE`, before running an `UPDATE` or `DELETE`?

---

# Answers

1. ```sql
   INSERT INTO Student (name, major)
   VALUES ('Park Jiho', 'Software Engineering');
   ```
2. Every row in `Section` is deleted, permanently, with no way to
   selectively undo it. It is dangerous because a missing `WHERE`
   clause silently expands "delete one row" into "delete everything."
3. Because it lets you see exactly which rows the `WHERE` clause
   matches before an `UPDATE` or `DELETE` changes them irreversibly, a
   cheap way to catch a wrong `WHERE` clause before it does any damage.

---

<!-- SLOT 14: Limits, becomes Week 11 slot 4 -->

# What Data Alone Cannot Do

<div class="limits">
The registration schema now has real data in it, inserted, updated,
and deleted safely. But answering "who is enrolled in CSE301?" still
means running <code>SELECT * FROM Enrollment;</code> and reading every
row by eye to find the ones that match, exactly Week 1's original
40,000-row problem, just with real data underneath it now instead of a
spreadsheet. Data is in. There is still no way to actually ask it a
question.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 10 leaves **no way to ask a real question of the data** unsolved.
**Week 11, Single-table Queries**, addresses it: `SELECT`, `WHERE`,
`DISTINCT`, and `ORDER BY`, the commands that finally answer "who is
enrolled in CSE301?" directly.

---

<!-- SLOT 16: Summary -->

# Summary

- DML manipulates data inside existing structure: `INSERT` adds rows,
  `UPDATE` changes them, `DELETE` removes them.
- `INSERT` order across related tables, and `DELETE`'s protection
  against orphaned foreign keys, both follow Week 9's dependency order.
- `WHERE` is not optional on `UPDATE` or `DELETE` in practice: without
  it, the statement silently applies to every row in the table.
- **Lab page:** `book/src/labs/lab10-dml.md`, for the Guided Exercises,
  Challenge Problem, and rubric
- **Reading:** Silberschatz et al., 7th ed., Chapter 3 (SQL DML)
- **Prepare:** write, on paper, the `INSERT` statements needed to add
  yourself as a `Student` and enroll yourself in one `Section`.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
