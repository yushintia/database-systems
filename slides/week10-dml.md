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

1. Insert rows into a table with `INSERT INTO`, respecting foreign keys
2. Change existing data with `UPDATE`, safely, using `WHERE`
3. Remove rows with `DELETE`, safely, using `WHERE`
4. Explain why `INSERT` order matters across related tables

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

# INSERT: Adding a Row

<div class="thread">The single command that ends this week's pain slide.</div>

```sql
INSERT INTO Student (name, major)
VALUES ('Kim Minji', 'Computer Science');
```

`student_id` is not listed, `AUTO_INCREMENT` from Week 9 generates it.
MySQL assigns the next available integer automatically, exactly the
mechanism that keeps two different "Kim Minji" rows from ever
colliding on their key.

---

# INSERT: Respecting Foreign Keys

<div class="thread">Week 9's foreign keys are not just declared, MySQL actively checks them here.</div>

```sql
INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE301', 1, '성파 702', '2026-2');
```

This fails immediately if `course_code = 'CSE301'` does not already
exist in `Course`, or `instructor_id = 1` does not exist in
`Instructor`. The referenced rows must be inserted **first**. Insert
order across tables follows the exact same dependency order as Week
9's `CREATE TABLE` order.

---

# INSERT: Multiple Rows at Once

<div class="thread">One statement, several rows, a common real-world shortcut.</div>

```sql
INSERT INTO Student (name, major) VALUES
    ('Kim Minji', 'Computer Science'),
    ('Park Jiho', 'Software Engineering'),
    ('Han Somin', 'Computer Science');
```

Three rows, one statement, one round trip to the database. Real
systems loading a batch of records, an entire class roster, for
example, always prefer this to three separate `INSERT` statements.

---

# Illustration: A Table, Before and After INSERT

<div class="thread">What one INSERT statement actually changes.</div>

**Before**, `Course` has one row:

| course_code | title |
|---|---|
| CSE301 | Databases |

**After** `INSERT INTO Course VALUES ('CSE305', 'Data Structures');`:

| course_code | title |
|---|---|
| CSE301 | Databases |
| CSE305 | Data Structures |

One new row, appended. Nothing else in the table changed.

---

# UPDATE: Changing Existing Data

<div class="thread">Week 7's exact update-anomaly scenario, now the actual fix.</div>

```sql
UPDATE Instructor
SET name = 'Lee, Married Name'
WHERE instructor_id = 1;
```

Because `Instructor.name` lives in exactly one row (Week 7's 3NF fix),
this single `UPDATE` is the entire fix. No other table needs touching.
This is precisely why the pain slide from Week 7 mattered: a normalized
schema turns every update into one statement, not a search-and-replace
across many rows.

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

# Illustration: A Table, Before and After UPDATE

<div class="thread">What one UPDATE statement actually changes, and what it deliberately leaves alone.</div>

**Before:**

| instructor_id | name |
|---|---|
| 1 | Prof. Lee |
| 2 | Prof. Han |

**After** `UPDATE Instructor SET name = 'Lee, M.' WHERE instructor_id = 1;`

| instructor_id | name |
|---|---|
| 1 | Lee, M. |
| 2 | Prof. Han |

Only the matched row changed. `WHERE` is what makes that precision possible.

---

# DELETE: Removing Rows

<div class="thread">The most consequential of the three, and the one Week 9's DROP TABLE warning applies to just as much.</div>

```sql
DELETE FROM Enrollment
WHERE student_id = 7 AND section_id = 3;
```

Removes exactly one enrollment row. Like `UPDATE`, `DELETE` without a
`WHERE` clause removes **every row in the table**, silently, all at
once.

---

# DELETE and Foreign Keys: What MySQL Protects

<div class="thread">Week 2's referential integrity, enforced again, in the opposite direction from INSERT.</div>

```sql
DELETE FROM Instructor WHERE instructor_id = 1;
```

If Instructor 1 still teaches any `Section`, MySQL rejects this by
default, referential integrity forbids leaving a `Section` pointing at
an instructor who no longer exists. The sections must be reassigned or
removed first. This is the DELETE-side mirror of INSERT's ordering rule.

---

# Illustration: A Table, Before and After DELETE

<div class="thread">The last of the three, same pattern, opposite direction.</div>

**Before:**

| student_id | section_id | grade |
|---|---|---|
| 1 | 3 | A0 |
| 7 | 3 | B+ |

**After** `DELETE FROM Enrollment WHERE student_id = 7 AND section_id = 3;`

| student_id | section_id | grade |
|---|---|---|
| 1 | 3 | A0 |

One row removed. The other row, and every other table, untouched.

---

# Demo, Step by Step: One Student's Whole Semester

<div class="thread">All three commands from this lecture, chained into one realistic story, not three isolated examples.</div>

One student, Park Jiho, from enrollment to a grade correction to
withdrawal, four steps, each building on the last.

---

# Step 1: Enroll

```sql
INSERT INTO Student (name, major)
VALUES ('Park Jiho', 'Software Engineering');
-- MySQL assigns student_id = 12

INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (12, 3, NULL);
```

A student exists, and is enrolled, with no grade yet, `NULL` means
"not graded," not "zero."

---

# Step 2: Verify

```sql
SELECT * FROM Enrollment WHERE student_id = 12;
```

| student_id | section_id | grade |
|---|---|---|
| 12 | 3 | NULL |

Checking the actual state before the next change, the same discipline
from this lecture's "safe UPDATE" practice slide.

---

# Step 3: Grade Posted, Then Corrected

```sql
UPDATE Enrollment SET grade = 'B0'
WHERE student_id = 12 AND section_id = 3;
-- a data-entry mistake noticed later

UPDATE Enrollment SET grade = 'A0'
WHERE student_id = 12 AND section_id = 3;
```

Two updates, same row, same precise `WHERE`. The second one is not
"a workaround," it is exactly what `UPDATE` is for, correcting one
specific fact without touching anything else.

---

# Step 4: Withdrawal

```sql
DELETE FROM Enrollment
WHERE student_id = 12 AND section_id = 3;
```

The enrollment is gone. `Park Jiho` still exists in `Student`, only
this one enrollment record was removed, exactly the precision `WHERE`
makes possible, four steps, one coherent story, every DML command from
this lecture used correctly, in the order a real semester actually
happens.

---

# DML Behind Every Button You Click

<div class="thread">Not abstract commands. The literal mechanism behind everyday app interactions.</div>

<div class="appgrid">
<div class="app"><div class="name">"Save" in any app</div><div class="desc">an INSERT or UPDATE, depending on whether the row exists yet</div></div>
<div class="app"><div class="name">"Delete post"</div><div class="desc">a DELETE, scoped by WHERE post_id = ...</div></div>
<div class="app"><div class="name">"Edit profile"</div><div class="desc">an UPDATE, WHERE user_id = the logged-in user, never anyone else's</div></div>
</div>

<div class="why">
That last row is worth pausing on: every app that lets you edit your
own profile, but never someone else's, is relying on a correct
<code>WHERE</code> clause. A missing or wrong one there is a real
security bug, not just a data bug.
</div>

---

# Common Mistakes

- **Running `UPDATE` or `DELETE` without `WHERE`:** the single most
  common, and most damaging, DML mistake. Always write and check the
  `WHERE` clause before running the statement
- **Inserting into a table before its foreign-key targets exist:**
  respect Week 9's creation order for `INSERT` too
- **Assuming `DELETE` cascades automatically:** by default it does
  not; MySQL blocks deletions that would orphan foreign-key references

---

# Practice: Enrolling a New Student

<div class="thread">Two related INSERT statements, in the correct order, applied end to end.</div>

**Question:** write the two `INSERT` statements needed to add a new
student, "Choi Yuna," Computer Science, and enroll her in
`section_id = 3`, in the correct order.

**Answer:**
```sql
INSERT INTO Student (name, major)
VALUES ('Choi Yuna', 'Computer Science');

INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (LAST_INSERT_ID(), 3, NULL);
```
`LAST_INSERT_ID()` retrieves the `student_id` MySQL just generated,
exactly the value needed for the second statement's foreign key.

---

# Practice: A Safe UPDATE

<div class="thread">The WHERE-clause discipline from this lecture, applied under pressure.</div>

**Question:** a section's room changed from "성파 702" to "성파 615."
Write the safest possible `UPDATE`, checking your target first.

**Answer:**
```sql
SELECT * FROM Section WHERE section_id = 5;  -- check first
UPDATE Section SET room = '성파 615' WHERE section_id = 5;
```
Running the matching `SELECT` first, with the exact same `WHERE`
clause, confirms exactly which row will change before it does.

---

# Check Yourself

1. Write an `INSERT` statement adding a new `Student`, "Park Jiho,"
   major "Software Engineering."
2. What happens if you run `DELETE FROM Section;` with no `WHERE`
   clause, and why is this dangerous?
3. Why does the practice slide's `UPDATE` recommend running a matching
   `SELECT` first?

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
- **Reading:** Silberschatz et al., 7th ed., Chapter 3 (SQL DML)
- **Prepare:** write, on paper, the `INSERT` statements needed to add
  yourself as a `Student` and enroll yourself in one `Section`.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
