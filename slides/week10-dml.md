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
<div class="card"><div class="h">INSERT</div><div class="d">Insert rows into a table with <code>INSERT INTO</code>, respecting foreign keys</div></div>
<div class="card"><div class="h">UPDATE</div><div class="d">Change existing data with <code>UPDATE</code>, safely, using <code>WHERE</code></div></div>
<div class="card"><div class="h">DELETE</div><div class="d">Remove rows with <code>DELETE</code>, safely, using <code>WHERE</code></div></div>
<div class="card"><div class="h">Insert Order</div><div class="d">Explain why <code>INSERT</code> order matters across related tables</div></div>
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

# NULL Handling on INSERT: What You Can Omit

<div class="thread">Not every column needs a value. Which ones don't, and why.</div>

```sql
INSERT INTO Enrollment (student_id, section_id)
VALUES (12, 3);
```

`grade` is left out entirely; MySQL fills it with `NULL`
automatically, "not yet graded." This only works because `grade` was
declared without `NOT NULL` back in Week 9. Try the same omission on
`Student.name`, declared `NOT NULL`, and MySQL rejects the statement
instead, a required column has no fallback value to fall back on.

- **Can omit:** any `AUTO_INCREMENT` column (Week 9's `student_id`),
  any column with a `DEFAULT`, any column that allows `NULL`
- **Cannot omit:** any column declared `NOT NULL` with no `DEFAULT`,
  MySQL has nothing to put there instead

---

# Illustration: A Row With an Omitted Column

<div class="thread">The exact row the previous slide's INSERT produces.</div>

**Before**, `Enrollment` has one row:

| student_id | section_id | grade |
|---|---|---|
| 1 | 3 | A0 |

**After** `INSERT INTO Enrollment (student_id, section_id) VALUES (12, 3);`

| student_id | section_id | grade |
|---|---|---|
| 1 | 3 | A0 |
| 12 | 3 | NULL |

The new row exists, is fully valid, and openly says "grade unknown,"
exactly the meaning Week 11 assigns to `IS NULL` later.

---

# INSERT ... SELECT: Deriving Rows From a Query

<div class="thread">Every INSERT so far spelled out literal values. This one computes them instead.</div>

> `INSERT ... SELECT` copies the rows returned by a query directly into
> a table, instead of listing values by hand with `VALUES`.

```sql
INSERT INTO target_table (col1, col2)
SELECT col_a, col_b
FROM source_table
WHERE <condition>;
```

The columns listed after `target_table` must line up, in order and in
compatible type, with the columns the `SELECT` returns. No `VALUES`
keyword appears at all, the query itself supplies every row.

---

# INSERT ... SELECT: Archiving a Semester's Grades

<div class="thread">A realistic use: deriving one table's rows from another table already in the schema.</div>

Suppose the registrar keeps a permanent `Transcript` table, structurally
similar to `Enrollment` plus an archive date:

```sql
CREATE TABLE Transcript (
    student_id INT, section_id INT, grade VARCHAR(2), archived_on DATE
);

INSERT INTO Transcript (student_id, section_id, grade, archived_on)
SELECT student_id, section_id, grade, CURDATE()
FROM Enrollment
WHERE grade IS NOT NULL;
```

One statement copies every already-graded enrollment into
`Transcript`, stamped with today's date. No `VALUES` list, no per-row
typing, the `SELECT` did the work of reading every source row.

---

# Illustration: What INSERT ... SELECT Actually Copies

<div class="thread">Two tables, one INSERT ... SELECT, made visible.</div>

**`Enrollment` (source):**

| student_id | section_id | grade |
|---|---|---|
| 1 | 3 | A0 |
| 7 | 3 | NULL |

**`Transcript` (target)** after the previous slide's statement:

| student_id | section_id | grade | archived_on |
|---|---|---|---|
| 1 | 3 | A0 | 2026-09-06 |

Only `student_id = 1` copied over: the `WHERE grade IS NOT NULL` filter
excluded the ungraded row, exactly as it would in a plain `SELECT`.

---

# INSERT ... SELECT vs. Multi-Row VALUES: Choosing Between Them

<div class="thread">Two ways to insert many rows in one statement. Different sources, same one round trip.</div>

- **Multi-row `VALUES`** (earlier this lecture): the data comes from
  outside the database, typed by hand or supplied by an application
- **`INSERT ... SELECT`:** the data already lives inside the database,
  in another table or another query's result

If the values already exist somewhere in the schema, `INSERT ...
SELECT` avoids retyping them, and avoids the risk of a typo producing
a value that does not match what `SELECT` would have read directly.

---

# INSERT ... ON DUPLICATE KEY UPDATE: The Upsert Pattern

<div class="thread">MySQL's own answer to "insert this, unless it's already there, then update it instead."</div>

> `INSERT ... ON DUPLICATE KEY UPDATE` attempts a normal `INSERT`; if it
> would violate a `PRIMARY KEY` or `UNIQUE` constraint, MySQL updates
> the existing row instead of raising an error.

```sql
INSERT INTO target_table (col1, col2, col3)
VALUES (v1, v2, v3)
ON DUPLICATE KEY UPDATE col3 = v3;
```

"Upsert" (**up**date-or-in**sert**) is the common industry name for
this exact pattern, one statement doing the job of "check if it
exists, then decide."

---

# Upsert: Re-Enrolling Without a Duplicate-Key Error

<div class="thread">Enrollment's own PRIMARY KEY(student_id, section_id) from Week 9, turned into a feature instead of an obstacle.</div>

```sql
INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (12, 3, 'A0')
ON DUPLICATE KEY UPDATE grade = 'A0';
```

If `(12, 3)` is new, this behaves exactly like a plain `INSERT`. If
`(12, 3)` already exists, the composite primary key from Week 9
collides, and instead of MySQL's usual duplicate-key error, `grade` is
updated on the existing row. Same intent as the two-step "check, then
`UPDATE`" pattern from earlier in this lecture, in one statement.

---

# Illustration: Insert vs. Upsert on the Same Key

<div class="thread">Same statement pattern, two different starting states, one consistent result.</div>

**Case A, no existing row for `(12, 3)`:** the `INSERT` branch runs,
one new row appears with `grade = 'A0'`.

**Case B, `(12, 3)` already exists with `grade = 'B+'`:**

| student_id | section_id | grade (before) | grade (after) |
|---|---|---|---|
| 12 | 3 | B+ | A0 |

Same one statement, no error either way, because the composite key
from Week 9 tells MySQL exactly which case it is in.

---

# Upsert Without a Conflict: Behaves Like Plain INSERT

<div class="thread">The clause that never fires is not wasted, it is insurance.</div>

```sql
INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (20, 4, 'B0')
ON DUPLICATE KEY UPDATE grade = 'B0';
```

If `(20, 4)` does not already exist, `ON DUPLICATE KEY UPDATE` never
triggers, the statement is a plain `INSERT`, nothing more. The clause
only changes behavior in the one case where a plain `INSERT` would
otherwise fail.

---

# Why Upsert and Derived Inserts Matter in Real Systems

<div class="why">
Real applications insert data constantly without knowing in advance
whether a row already exists, a user revisiting a form, a nightly sync
job re-running after a partial failure. Handling that with two
statements, a <code>SELECT</code> to check, then an <code>INSERT</code>
or <code>UPDATE</code>, is slower and racier: another process can
insert between the check and the write. <code>INSERT ... ON DUPLICATE
KEY UPDATE</code> and <code>INSERT ... SELECT</code> push that decision
into the database itself, inside one atomic statement.
</div>

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

# Subqueries Inside WHERE: A Query Inside a Query

<div class="thread">Every WHERE so far compared a column to a literal value. This one compares it to the result of another SELECT.</div>

> A **subquery** is a complete `SELECT` statement nested inside another
> statement's `WHERE` clause; its result feeds the outer statement's
> condition.

```sql
DELETE FROM table_name
WHERE column IN (
    SELECT column FROM other_table WHERE <condition>
);
```

MySQL runs the inner `SELECT` first, producing a list of values, then
runs the outer statement's `WHERE column IN (...)` against that list,
exactly like `IN` from Week 11, except the list comes from a query
instead of being typed out by hand.

---

# DELETE Using a Subquery: Discontinuing a Program

<div class="thread">The Software Engineering program is being discontinued; every current enrollment for its students must go.</div>

```sql
DELETE FROM Enrollment
WHERE student_id IN (
    SELECT student_id FROM Student
    WHERE major = 'Software Engineering'
);
```

The inner `SELECT` finds every Software Engineering student's
`student_id`. The outer `DELETE` removes exactly their enrollments, no
other major is touched, and `Student` rows themselves are untouched,
only `Enrollment` was named after `DELETE FROM`.

---

# UPDATE Using a Subquery: Fixing One Instructor's Sections

<div class="thread">Professor Lee mis-entered every grade this term; reset them all for a clean re-grade.</div>

```sql
UPDATE Enrollment
SET grade = NULL
WHERE section_id IN (
    SELECT section_id FROM Section
    WHERE instructor_id = 1
);
```

The inner `SELECT` finds every `section_id` Professor Lee
(`instructor_id = 1`) teaches. The outer `UPDATE` resets `grade` to
`NULL` only for enrollments in those sections; every other
instructor's grades are left exactly as they were.

---

# Subquery With NOT IN: The Opposite Selection

<div class="thread">Same mechanism, the complement of the previous two slides.</div>

```sql
DELETE FROM Enrollment
WHERE student_id NOT IN (
    SELECT student_id FROM Student
    WHERE major = 'Computer Science'
);
```

`NOT IN` keeps only the rows whose value does **not** appear in the
subquery's list, here, every enrollment belonging to a non-CS student.
`NOT IN` behaves unexpectedly if the subquery can return a `NULL`
value, always confirm the subquery's column is `NOT NULL` before
relying on `NOT IN`.

---

# Subquery Discipline: Run the Inner SELECT First

<div class="thread">The exact same caution this lecture already gave plain UPDATE and DELETE, applied one level deeper.</div>

```sql
SELECT student_id FROM Student
WHERE major = 'Software Engineering';   -- check first, alone
```

Running the subquery by itself, before wrapping it in `DELETE` or
`UPDATE`, shows exactly which rows the outer statement is about to
touch. A subquery that returns the wrong rows makes the outer
statement wrong in exactly the same silent way a bad `WHERE` clause
does; checking it alone first is cheap insurance either way.

---

# TRUNCATE TABLE vs. DELETE: What's Different

<div class="thread">Two ways to empty a table, not interchangeable.</div>

| | `DELETE FROM t;` | `TRUNCATE TABLE t;` |
|---|---|---|
| Accepts `WHERE`? | Yes, row by row | No, always the whole table |
| Resets `AUTO_INCREMENT`? | No | Yes, back to 1 |
| Logs each row removed? | Yes, row by row | No, deallocates the whole table at once |
| Blocked by a foreign key reference? | Only the referencing rows matter | Yes, any table another table references |
| Classified as | DML | DDL, technically |

`TRUNCATE` is faster on a large table precisely because it does not
examine rows individually; that same shortcut is also why it cannot
take a `WHERE` clause at all.

---

# Illustration: TRUNCATE Resets the Counter, DELETE Doesn't

<div class="thread">The one difference students most often get burned by.</div>

**After deleting every row with `DELETE FROM Student;`, then inserting
Park Jiho again:** `student_id` continues from wherever
`AUTO_INCREMENT` last left off, never reusing an old value.

**After `TRUNCATE TABLE Student;`, then inserting Park Jiho again:**
`student_id` restarts at `1`, as if the table were brand new.

Also: `TRUNCATE TABLE Instructor;` fails outright if any `Section`
still references it, exactly Week 9's foreign-key protection, this
time blocking a truncate instead of a delete.

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

# Common Mistakes, Continued: New Patterns, Same Old Traps

- **Wrapping a subquery around a `DELETE`/`UPDATE` without running it
  alone first:** the outer statement is only as correct as the row set
  the inner `SELECT` actually returns
- **Reaching for `TRUNCATE` out of habit:** it silently resets
  `AUTO_INCREMENT` and fails against any foreign-key reference,
  `DELETE FROM t;` (still with no `WHERE`, still dangerous) is the
  safer default when a full wipe is genuinely intended
- **Forgetting `ON DUPLICATE KEY UPDATE` needs a key to collide with:**
  without a `PRIMARY KEY` or `UNIQUE` constraint on the target columns,
  MySQL has no "duplicate" to detect, and the clause never triggers

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

# Practice: Upserting a Library Loan Record

<div class="thread">The library domain, one more time, with the upsert pattern from this lecture.</div>

**Question:** a `Loan(book_isbn, member_id, due_date)` table has
`PRIMARY KEY(book_isbn, member_id)`. Write one statement that inserts a
new loan, or extends the due date if that member already has that
book checked out.

**Answer:**
```sql
INSERT INTO Loan (book_isbn, member_id, due_date)
VALUES ('978-0-13-608530-0', 4, '2026-09-20')
ON DUPLICATE KEY UPDATE due_date = '2026-09-20';
```

---

# Practice: Delete-by-Subquery on the Library Domain

<div class="thread">Same subquery pattern, a different domain, same shape of question.</div>

**Question:** write a statement removing every `Loan` belonging to
members whose `membership_status = 'expired'`.

**Answer:**
```sql
DELETE FROM Loan
WHERE member_id IN (
    SELECT member_id FROM Member WHERE membership_status = 'expired'
);
```

---

# Check Yourself: New DML Patterns

1. Write an `INSERT ... SELECT` statement copying every Computer
   Science student's `name` into a table `CSMailingList(name)`.
2. What is the one difference that makes `TRUNCATE TABLE Enrollment;`
   dangerous in a way `DELETE FROM Enrollment;` is not, for a table an
   application depends on for correctly increasing IDs?
3. Why does `INSERT ... ON DUPLICATE KEY UPDATE` need a `PRIMARY KEY`
   or `UNIQUE` constraint on the table to work at all?

---

# Answers: New DML Patterns

1. ```sql
   INSERT INTO CSMailingList (name)
   SELECT name FROM Student WHERE major = 'Computer Science';
   ```
2. `TRUNCATE` resets `AUTO_INCREMENT` back to 1; any code assuming a
   newer row always has a larger ID breaks silently the next time a
   row is inserted after the truncate.
3. Without a `PRIMARY KEY` or `UNIQUE` constraint, MySQL has no
   definition of "duplicate" to detect; `ON DUPLICATE KEY UPDATE` has
   nothing to trigger it, so the statement behaves like a plain
   `INSERT` every time.

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

# A Note on This Week's Sources

Some topics in this deck (`INSERT`/`UPDATE`/`DELETE`, subqueries inside
DML statements, MySQL's upsert syntax) follow the standard SQL topic
organization used by course reference texts such as *Database System
Concepts*, 7th ed. (Silberschatz, Korth, Sudarshan). All wording,
examples, and the registration-system case study on these slides are
original.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
