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

# INSERT: Naming Columns Explicitly

<div class="thread">The column list in parentheses is not decoration, it is what makes an INSERT survive schema changes.</div>

```sql
-- Fragile: relies on Student's exact declared column order
INSERT INTO Student VALUES (DEFAULT, 'Han Somin', 'Computer Science');

-- Safe: names every column, order-independent
INSERT INTO Student (name, major)
VALUES ('Han Somin', 'Computer Science');
```

If a later `ALTER TABLE` inserts a new column in the middle of
`Student`, the column-list version keeps working unchanged. The
positional version silently starts writing values into the wrong
columns, no error, just wrong data. Always name the columns.

---

# INSERT: One Statement, Many Rows, Why It's Preferred

<div class="thread">The multi-row form from the last slide, and the actual reason real systems always choose it.</div>

```sql
INSERT INTO Student (name, major) VALUES
    ('Jung Haeun', 'Data Science'),
    ('Oh Seoyeon', 'Software Engineering'),
    ('Bae Junho', 'Computer Science');
```

One statement, one round trip to the MySQL server, all three rows
written together. Three separate `INSERT` statements mean three round
trips, each one waiting on network and disk before the next can start,
slower every single time, not just under heavy load.

---

# INSERT: A Multi-Row Statement Succeeds or Fails Together

<div class="thread">The other reason multi-row INSERT is not just a speed trick.</div>

```sql
INSERT INTO Student (name, major) VALUES
    ('Yoon Areum', 'Computer Science'),
    ('Kang Doyun', 'Software Engineering'),
    (NULL, 'Data Science');
-- ERROR 1048 (23000): Column 'name' cannot be null
```

By default, if any one row in a multi-row `INSERT` violates a
constraint, MySQL rejects the entire statement, **none** of the three
rows are written, not even the first two that were valid. A multi-row
`INSERT` is all-or-nothing, not "insert what you can."

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

---

# INSERT Order Follows Week 9's Dependency Order, Continued

<div class="thread">The same failure, named as a term you will keep seeing through DELETE too.</div>

> **Orphaned row:** a row that points, by foreign key, at a value that
> does not exist in the referenced table. MySQL refuses to create one
> on `INSERT`, and refuses to create one on `DELETE` too.

---

# Illustration: INSERT's Dependency Order, As a Pipeline

<div class="thread">The dependency rule from the last slide, seen as one path instead of a paragraph.</div>

<div class="pipeline">
<div class="stage"><div class="h">Course</div><div class="s">no dependencies</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Instructor</div><div class="s">no dependencies</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Section</div><div class="s">needs both above</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Enrollment</div><div class="s">needs Student + Section</div></div>
</div>

`Student` has no foreign keys either, it can be inserted any time
before `Enrollment`. Every arrow here is a foreign key from Week 9;
`INSERT` simply cannot run right to left.

---

# Worked Example: Inserting a New Section, Start to Finish

<div class="thread">A brand-new course offering, added in the same order Week 9 always requires.</div>

```sql
INSERT INTO Course (course_code, title, credits)
VALUES ('CSE450', 'Advanced Databases', 3);

INSERT INTO Instructor (name)
VALUES ('Prof. Yeo');
-- MySQL assigns instructor_id = 14

INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE450', 14, '성파 615', '2026-1');
```

`Course` and `Instructor` have no foreign keys, either order between
them is fine. `Section` references both, so it has to come last, the
exact ordering rule from the pipeline above, applied for real.

---

# INSERT: Auto-Increment Values Are Not Reused

<div class="thread">A small but common surprise the first time a row gets deleted.</div>

```sql
INSERT INTO Instructor (name) VALUES ('Prof. Temp');
-- MySQL assigns instructor_id = 15
DELETE FROM Instructor WHERE instructor_id = 15;
INSERT INTO Instructor (name) VALUES ('Prof. Noh');
-- MySQL assigns instructor_id = 16, not 15
```

`AUTO_INCREMENT` never reuses a value once it has been handed out,
even if that row is later deleted. Gaps in `instructor_id` are normal
and expected, not a sign that something is broken.

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

# INSERT and NOT NULL: The Error You Get Instead

<div class="thread">The last slide's "cannot omit" column, seen as an actual failure.</div>

```sql
INSERT INTO Student (major) VALUES ('Computer Science');
-- ERROR 1364 (HY000): Field 'name' doesn't have a default value
```

`Student.name` is `NOT NULL` with no `DEFAULT`, Week 9 declared it that
way on purpose, a student record with no name is not meaningful data.
Compare this to `Enrollment.grade`: omitting it succeeds silently with
`NULL`, because `grade` was declared to allow exactly that.

---

# Explicit NULL vs. Omitting the Column

<div class="thread">Two ways to write the same "not yet graded" row.</div>

```sql
INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (15, 6, NULL);

INSERT INTO Enrollment (student_id, section_id)
VALUES (15, 6);
```

Both statements produce an identical row. Writing `NULL` out loud is
often clearer inside a multi-row statement where some rows already
have a grade and some do not:

```sql
INSERT INTO Enrollment (student_id, section_id, grade) VALUES
    (16, 6, 'B+'),
    (17, 6, NULL),
    (18, 6, 'A0');
```

---

# INSERT ... SELECT: Copying Rows From a Query

<div class="thread">VALUES lists rows by hand. SELECT can generate the whole list instead.</div>

> `INSERT ... SELECT` runs a `SELECT` statement first, then inserts
> **every row it returns** as a new row, in place of a `VALUES` list.

```sql
INSERT INTO Enrollment (student_id, section_id)
SELECT student_id, 8
FROM Student
WHERE major = 'Data Science';
```

Every Data Science student is enrolled into section 8, in one
statement, no `student_id` typed by hand, still single-table, no `JOIN`.

---

# Worked Example: Bulk-Enrolling a Class Roster

<div class="thread">A multi-row INSERT into Enrollment, then a COUNT to confirm it landed.</div>

```sql
INSERT INTO Enrollment (student_id, section_id) VALUES
    (21, 5), (22, 5), (23, 5), (24, 5);

SELECT COUNT(*) AS roster_size
FROM Enrollment
WHERE section_id = 5;
```

| roster_size |
|---|
| 4 |

Four students, one statement, all starting with `grade = NULL`, the
`COUNT(*)` afterward only a check, this week's "verify first" habit again.

---

# INSERT ... ON DUPLICATE KEY UPDATE: Upsert

<div class="thread">Enrollment's own composite primary key makes this pattern work without any new syntax to declare.</div>

> An **upsert** inserts a new row, or updates an existing one instead,
> if a row with the same primary (or unique) key already exists.

```sql
INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (12, 3, 'A0')
ON DUPLICATE KEY UPDATE grade = 'A0';
```

`Enrollment`'s primary key is `(student_id, section_id)`. If that pair
already exists, MySQL runs the `UPDATE` clause instead of raising a
duplicate-key error, one statement covering both "first enrollment"
and "re-enrollment" without checking which case it is first.

---

# Worked Example: Confirming an Upsert Took the UPDATE Path

<div class="thread">The upsert from the last slide, checked before and after like everything else this week.</div>

```sql
SELECT grade FROM Enrollment WHERE student_id = 12 AND section_id = 3;
-- | A0 |
INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (12, 3, 'A+')
ON DUPLICATE KEY UPDATE grade = 'A+';
-- Query OK, 2 rows affected
SELECT grade FROM Enrollment WHERE student_id = 12 AND section_id = 3;
-- | A+ |
```

No new row was created, only `grade` changed, from `'A0'` to `'A+'`,
confirmed by the identical `SELECT` run twice.

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

# UPDATE: Multiple Columns in One SET

<div class="thread">SET is not limited to one column at a time.</div>

```sql
UPDATE Section
SET room = '성파 615', semester = '2026-2'
WHERE section_id = 7;
```

Both columns change together, in one statement, on whichever rows
`WHERE` matches. There is no requirement to run one `UPDATE` per
column, every comma-separated assignment in `SET` applies at once.

---

# UPDATE: SET Can Reference the Column's Own Old Value

<div class="thread">The right-hand side of SET is not limited to a brand-new literal.</div>

```sql
UPDATE Course
SET credits = credits + 1
WHERE course_code = 'CSE301';
```

MySQL reads each row's current `credits` value first, then writes
`credits + 1` back into that same row. This is still one statement,
one pass over the matching rows, not a read followed by a separate
write your application has to coordinate.

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

# Worked Example: Reassigning a Section's Room and Semester

<div class="thread">The multi-column SET from two slides ago, run against real data, then checked.</div>

```sql
SELECT section_id, room, semester FROM Section WHERE section_id = 7;
-- | 7 | 성파 810 | 2026-1 |
UPDATE Section
SET room = '성파 615', semester = '2026-2'
WHERE section_id = 7;
SELECT section_id, room, semester FROM Section WHERE section_id = 7;
-- | 7 | 성파 615 | 2026-2 |
```

One `UPDATE`, both columns changed, confirmed with the same `SELECT`
run before and after, this week's check-first habit made concrete.

---

# Worked Example: Check First, Then UPDATE Many Rows at Once

<div class="thread">The single-row check-first habit, now applied before a WHERE that can match many rows.</div>

```sql
SELECT student_id, section_id FROM Enrollment
WHERE section_id = 5 AND grade IS NULL;
-- | 21 | 5 | NULL |   | 22 | 5 | NULL |
-- | 23 | 5 | NULL |   | 24 | 5 | NULL |

UPDATE Enrollment
SET grade = 'I'
WHERE section_id = 5 AND grade IS NULL;
```

Four rows, confirmed by the `SELECT` first, four rows changed by the
`UPDATE`, same `WHERE` clause reused exactly. A `SELECT` returning
forty rows instead of four is the moment to stop and re-check.

---

# UPDATE With a Subquery in WHERE

<div class="thread">The subquery idea, applied to UPDATE instead of the DELETE example still to come.</div>

```sql
UPDATE Enrollment
SET grade = 'W'
WHERE grade IS NULL
AND section_id IN (
    SELECT section_id FROM Section WHERE instructor_id = 9
);
```

The inner `SELECT` finds every section Prof. Kwon teaches; the outer
`UPDATE` marks only the still-ungraded enrollments inside those
sections as withdrawn. Both conditions in `WHERE` must hold, `AND`
combines the subquery test with the plain `grade IS NULL` test.

---

# UPDATE With a Literal IN-List

<div class="thread">A subquery is not the only way to name several rows at once.</div>

```sql
UPDATE Enrollment
SET grade = 'I'
WHERE section_id = 9 AND student_id IN (31, 34, 37);
```

Three specific students marked "Incomplete" in one statement, instead
of three separate `UPDATE` statements. `IN` here takes a literal list,
not a subquery, useful the moment you already know the exact IDs.

---

# UPDATE Matching Zero Rows Is Not an Error

<div class="thread">Absence of an error message is not proof an UPDATE actually did anything.</div>

```sql
UPDATE Student SET major = 'Data Science' WHERE student_id = 9999;
-- Query OK, 0 rows affected (0.01 sec)
```

`student_id = 9999` does not exist. MySQL confirms the statement's
syntax and permissions were fine, and reports **0 rows affected**, not
an error. Always read the rows-affected count, not just the absence
of red text, to know an `UPDATE` actually changed something.

---

# Worked Example: A Typo Fix, One Row Only

<div class="thread">Week 1's spreadsheet-inconsistency problem, still possible even inside real MySQL.</div>

```sql
SELECT section_id, room FROM Section WHERE room = '성파702';
-- | 9 | 성파702 |

UPDATE Section SET room = '성파 702' WHERE room = '성파702';
```

A missing space made `'성파702'` a different text value from
`'성파 702'`, not a typo MySQL can see or fix on its own. `WHERE` only
ever matches the exact stored value, character for character, exactly
Week 1's original "Kim Minji" vs. "MinJi Kim" problem, one row at a time.

---

# WHERE grade = NULL vs. IS NULL, Inside an UPDATE

<div class="thread">The same NULL trap Week 11 will name formally for SELECT, already live here in UPDATE and DELETE.</div>

```sql
UPDATE Enrollment SET grade = 'F0' WHERE grade = NULL;
-- Query OK, 0 rows affected. Matches nothing, ever.

UPDATE Enrollment SET grade = 'F0' WHERE grade IS NULL;
-- Correctly matches every still-ungraded row.
```

`NULL` means "unknown," and nothing equals unknown, not even another
unknown, so `= NULL` silently matches zero rows in an `UPDATE` or
`DELETE`, exactly as it would in a `SELECT`. `IS NULL` is the only
correct test, here or anywhere else.

---

# Rows Matched vs. Rows Changed

<div class="thread">One more number MySQL reports, easy to misread the first time you see it.</div>

```sql
UPDATE Enrollment SET grade = 'A0'
WHERE student_id = 12 AND section_id = 3 AND grade = 'A0';
-- Query OK, 0 rows affected
-- Rows matched: 1  Changed: 0
```

The row matched the `WHERE` clause, but `grade` was already `'A0'`,
so there was nothing new to write. MySQL reports "matched" and
"changed" separately: a row can match and still not change, this is
not a bug, and not an error either.

---

# What "Commits" Means, Informally

<div class="thread">This week has said "commits" and "no undo" several times. Here is what that word actually means.</div>

> By default, MySQL **commits** each `INSERT`, `UPDATE`, and `DELETE`
> statement immediately after it runs successfully, writing the change
> permanently, with no automatic way to reverse it.

This is exactly why `WHERE` has to be checked *before* running an
`UPDATE` or `DELETE`, not after. Week 14 covers grouping several
statements into one all-or-nothing transaction; until then, treat
every statement here as final the moment it runs without error.

---

# Illustration: One UPDATE, Row by Row

<div class="thread">The grade-correction UPDATE from the worked example, seen as row state instead of just two SQL lines.</div>

<div class="two-col">
<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Enrollment — Before</span><span class="tag">3 rows</span></div>
<div class="row">student_id 11, section_id 3, grade B+</div>
<div class="row" style="background:var(--cream);">student_id 12, section_id 3, grade B0</div>
<div class="row">student_id 13, section_id 3, grade A0</div>
</div>
</div>
<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Enrollment — After</span><span class="tag">3 rows</span></div>
<div class="row">student_id 11, section_id 3, grade B+</div>
<div class="row" style="background:var(--pale);">student_id 12, section_id 3, grade A0</div>
<div class="row">student_id 13, section_id 3, grade A0</div>
</div>
</div>
</div>

`UPDATE Enrollment SET grade = 'A0' WHERE student_id = 12 AND
section_id = 3;` touches exactly the highlighted row. The other two
rows satisfy neither condition in `WHERE`, so `UPDATE` never even
considers changing them, correcting one fact never risks another.

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

# DELETE and the Foreign-Key Failure, Mirrored

<div class="thread">INSERT's most common error, mirrored on the way out instead of the way in.</div>

```sql
DELETE FROM Instructor WHERE instructor_id = 1;
-- ERROR 1451 (23000): Cannot delete or update a parent row:
-- a foreign key constraint fails
```

Instructor 1 still teaches `Section` 3. MySQL refuses to leave that
`Section` row pointing at an instructor who no longer exists. The fix
is the same two-step shape as the INSERT-side failure: reassign or
delete the dependent `Section` rows first, then delete the `Instructor`.

---

# Illustration: DELETE's Order Is INSERT's Order, Reversed

<div class="thread">The same dependency pipeline from earlier, walked right to left this time.</div>

<div class="pipeline">
<div class="stage"><div class="h">Enrollment</div><div class="s">delete first</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Section</div><div class="s">then this</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Instructor / Course</div><div class="s">then these</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Student</div><div class="s">last, if at all</div></div>
</div>

`INSERT` had to start with the tables nothing depends on and finish
with `Enrollment`. `DELETE` has to run the opposite way: children
before parents, or MySQL blocks it exactly like the previous slide.

---

# Worked Example: Removing a Withdrawn Student, Fully

<div class="thread">The reversed order from the last slide, applied to a real, full account removal.</div>

```sql
DELETE FROM Enrollment WHERE student_id = 24;

DELETE FROM Student WHERE student_id = 24;
```

`Enrollment` first, `Student` second, the exact reverse of the order
those two rows were originally inserted in. Reversing the order,
deleting `Student` first, would hit the same kind of foreign-key
failure as the last two slides, `Enrollment` rows would be orphaned.

---

# Checking Scope Before an Irreversible DELETE

<div class="thread">The check-first habit, applied specifically to a DELETE with a wide WHERE clause.</div>

```sql
SELECT COUNT(*) AS about_to_delete
FROM Enrollment
WHERE section_id = 9 AND grade = 'F0';
-- | 6 |

DELETE FROM Enrollment
WHERE section_id = 9 AND grade = 'F0';
```

Six rows, confirmed before a single one is removed. There is no undo
for `DELETE`, running `COUNT(*)` with the exact same `WHERE` first
turns "how many rows am I about to lose" from a guess into a fact.

---

# DELETE With ORDER BY and LIMIT

<div class="thread">A MySQL-specific extension, useful the moment WHERE alone matches more rows than you want gone.</div>

```sql
DELETE FROM Enrollment
WHERE grade IS NULL
ORDER BY student_id ASC
LIMIT 1;
```

`WHERE` might match many ungraded rows; `ORDER BY` decides which one
comes first, `LIMIT 1` deletes only that single row, not every row
`WHERE` matched. This is MySQL's own extension to standard `DELETE`,
not every database product supports it.

---

# DELETE Matching Zero Rows Is Not an Error, Either

<div class="thread">The same zero-rows behavior from UPDATE, true of DELETE too.</div>

```sql
DELETE FROM Enrollment WHERE student_id = 9999 AND section_id = 1;
-- Query OK, 0 rows affected (0.00 sec)
```

No matching row existed, so nothing was removed, and MySQL says so
exactly the way it does for `UPDATE`. A `DELETE` that "ran
successfully" is not the same claim as "a row was actually deleted,"
always check the affected-rows count before assuming either one.

---

# Subqueries Inside DML

<div class="thread">A WHERE that compares to the result of another SELECT, instead of a literal value.</div>

> **Subquery:** a complete `SELECT` statement nested inside another
> statement's `WHERE` clause. MySQL runs the inner `SELECT` first,
> producing a list of values, then runs the outer statement's
> condition against that list.

---

# Subqueries Inside DML, Continued

<div class="thread">The definition from the last slide, now as a runnable example.</div>

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

# A Second Subquery Shape: Scalar vs. List

<div class="thread">The last slide's subquery returned a list. This one returns exactly one value.</div>

```sql
DELETE FROM Enrollment
WHERE section_id = (
    SELECT section_id FROM Section
    WHERE course_code = 'CSE410' AND semester = '2026-1'
);
```

A **scalar subquery** must return exactly one row and one column, so
it can sit next to `=` like a single literal value. If it ever
returned more than one row, MySQL raises `ERROR 1242 (21000):
Subquery returns more than 1 row`, the signal to switch to `IN`
instead of `=`.

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

---

# Worked Example: One Student's Whole Semester, Withdrawal

<div class="thread">The same student, one semester later, the fourth and final DML command.</div>

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

# Every "Save," "Edit," "Delete" Button Is DML

<div class="thread">Not an abstraction, the literal mechanism behind features used every day.</div>

<div class="appgrid">
<div class="app"><div class="name">"Save" a new post</div><div class="desc">INSERT INTO Post (...) VALUES (...)</div></div>
<div class="app"><div class="name">"Edit profile"</div><div class="desc">UPDATE User SET ... WHERE user_id = ...</div></div>
<div class="app"><div class="name">"Delete account"</div><div class="desc">DELETE FROM User WHERE user_id = ...</div></div>
</div>

Every one of these buttons runs one of this week's three statements,
somewhere behind the interface, with a `WHERE` clause scoped to
exactly one row: yours.

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

# Sample Question 1

**Question:** Write an `INSERT` statement adding a new `Student`,
"Park Jiho," major "Software Engineering."

---

# Sample Question 1: Answer

**Answer:**
```sql
INSERT INTO Student (name, major)
VALUES ('Park Jiho', 'Software Engineering');
```

---

# Sample Question 2

**Question:** What happens if you run `DELETE FROM Section;` with no
`WHERE` clause, and why is this dangerous?

---

# Sample Question 2: Answer

**Answer:** Every row in `Section` is deleted, permanently, with no
way to selectively undo it. It is dangerous because a missing `WHERE`
clause silently expands "delete one row" into "delete everything."

---

# Sample Question 3

**Question:** Why is it good practice to run a matching `SELECT`, with
the same `WHERE`, before running an `UPDATE` or `DELETE`?

---

# Sample Question 3: Answer

**Answer:** Because it lets you see exactly which rows the `WHERE`
clause matches before an `UPDATE` or `DELETE` changes them
irreversibly, a cheap way to catch a wrong `WHERE` clause before it
does any damage.

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
- **Lab page:** [Lab 10 in the online Lab Manual](../book/labs/lab10-dml.html), for the Guided Exercises,
  Challenge Problem, and rubric
- **Reading:** Silberschatz et al., 7th ed., Chapter 3-4 (SQL DML)
- **Prepare:** write, on paper, the `INSERT` statements needed to add
  yourself as a `Student` and enroll yourself in one `Section`.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
