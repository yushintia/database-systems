---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 11: Single-table Queries

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
<div class="wk"><div class="n">Wk 10</div><div class="t">DML</div></div>
<div class="wk now"><div class="n">Wk 11</div><div class="t">Single-table Queries</div></div>
<div class="wk"><div class="n">Wk 12</div><div class="t">Multi-table Queries</div></div>
<div class="wk review"><div class="n">Wk 13</div><div class="t">Quiz 2</div></div>
<div class="wk"><div class="n">Wk 14</div><div class="t">Case Study Presentation</div></div>
<div class="wk review"><div class="n">Wk 15</div><div class="t">Final Exam</div></div>
</div>

---

<!-- SLOT 3: Recap + open wound -->

# Last Week, This Week

- **Last week delivered:** real data in every table, inserted, updated, and deleted safely with MySQL enforcing every constraint
- **Last week left broken:** the only way to answer a question is still `SELECT *` and reading every row by eye, Week 1's original problem, alive again inside real MySQL

---

<!-- SLOT 4: The pain -->

# Real Data, Same Old Scrolling

<div class="pain">

`Enrollment` now has thousands of real rows in it. A professor asks
"which of my students got an A this semester?" The honest current
answer is: run `SELECT * FROM Enrollment;`, and scroll through
thousands of rows looking for `grade = 'A0'` by eye.

The schema is correct. The data is correct. The question is completely
reasonable. And answering it still takes exactly the kind of manual
scrolling this entire course opened by promising to eliminate.

</div>

<!-- notes: Callback directly to Week 1's 3-hour bar chart. The promise was made in Week 1; this week is where it gets paid off. -->

---

# What Else This Actually Costs

- Every question anyone might ask about the data currently requires a
  person, not the database, to do the filtering, by eye, every time
- Scrolling by eye does not scale, a table with 40 rows and a table
  with 40 million rows are equally unusable this way
- A stakeholder who has to wait for someone to manually scan a table
  gets an answer in hours, not the milliseconds Week 1 promised

<div class="why">
<strong>In industry:</strong> `SELECT` is, by a wide margin, the most
frequently written SQL statement in any real job. Every dashboard,
report, and search box you have ever used is a `SELECT` statement
wearing a user interface.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What commands let the database answer a question directly, instead of a person scrolling by eye?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

<div class="cardlist">
<div class="card"><div class="h">SELECT / FROM / WHERE</div><div class="d">Retrieve specific columns and rows with <code>SELECT</code>, <code>FROM</code>, <code>WHERE</code></div></div>
<div class="card"><div class="h">Filtering &amp; DISTINCT</div><div class="d">Filter with comparison and logical operators, and remove duplicates with <code>DISTINCT</code></div></div>
<div class="card"><div class="h">ORDER BY &amp; Limits</div><div class="d">Sort results with <code>ORDER BY</code>, and limit how many rows come back</div></div>
<div class="card"><div class="h">Real Questions in SQL</div><div class="d">Answer real questions about the registration system directly in SQL</div></div>
</div>

---

<!-- SLOT 8: Origin -->

# Where SELECT Came From

<div class="thread">The fourth DML command, saved for its own two weeks because of how much it can do.</div>

- `SELECT` was part of SQL (then SEQUEL) from the very first System R
  prototype, Week 1's 1974 timeline, designed specifically so a
  non-programmer could describe **what** they wanted without writing a
  procedure for **how** to find it
- That distinction, declarative versus procedural, is exactly Week 1's
  claim about why the relational model won at all

---

<!-- SLOT 9: Core concept -->

# SELECT-FROM-WHERE: Definition

<div class="thread">Three keywords, answering three separate questions, always in the same order.</div>

> `SELECT` names **which columns** to return. `FROM` names **which
> table**. `WHERE` names **which rows** qualify.

```sql
SELECT name, major
FROM Student
WHERE major = 'Computer Science';
```

Read it in English: "give me the name and major, from Student, where
the major is Computer Science." SQL's syntax was designed to read
almost like the plain-language question it answers.

---

<!-- Act 3 / BUILD -->

# Illustration: A Query and Its Match

<div class="thread">The exact mechanic behind WHERE, made visible.</div>

```sql
SELECT name, grade FROM Enrollment
JOIN Student USING (student_id)
WHERE grade = 'A0';
```

| name | grade |
|---|---|
| <span style="color:#C0392B;font-weight:700">Kim Minji</span> | <span style="color:#C0392B;font-weight:700">A0</span> |
| Park Jiho | B+ |
| <span style="color:#C0392B;font-weight:700">Han Somin</span> | <span style="color:#C0392B;font-weight:700">A0</span> |

`WHERE grade = 'A0'` is a yes/no test applied to every row; only the
rows that pass appear in the result. (This example previews a join,
formally taught next week; today, focus on the `WHERE` test itself.)

---

# Comparison Operators

<div class="thread">WHERE needs a test. These are the tests available.</div>

| Operator | Meaning | Example |
|---|---|---|
| `=` | equal to | `major = 'Computer Science'` |
| `!=` or `<>` | not equal to | `grade != 'F'` |
| `>`, `<`, `>=`, `<=` | greater/less than | `credits >= 3` |
| `BETWEEN` | within a range | `credits BETWEEN 1 AND 4` |
| `LIKE` | text pattern match | `name LIKE 'Kim%'` |

`LIKE 'Kim%'` matches any name starting with "Kim," the `%` standing
in for "anything, including nothing."

---

# LIKE Pattern Matching: The % Wildcard

<div class="thread">The comparison-operators table teased this. Here is the full pattern.</div>

> `LIKE` tests a text column against a **pattern**, not an exact value.
> `%` inside the pattern matches any sequence of characters, including
> zero characters.

```sql
SELECT title FROM Course
WHERE title LIKE '%Data%';
```

Matches "Database Systems," "Data Structures," and "Big Data
Analytics," any title containing "Data" anywhere, because `%` on both
sides means "anything can come before, anything can come after."

---

# Illustration: A Course Search and Its Matches

<div class="thread">The exact rows the previous slide's query returns.</div>

**`Course`:**

| course_code | title |
|---|---|
| CSE301 | Databases |
| CSE305 | Data Structures |
| CSE210 | Operating Systems |

**`WHERE title LIKE '%Data%'`** matches `Databases` and `Data
Structures`, `Operating Systems` does not contain "Data" anywhere and
is correctly excluded.

---

# LIKE Pattern Matching: The _ Wildcard

<div class="thread">A second wildcard, for exactly one character instead of any number.</div>

> `_` inside a `LIKE` pattern matches **exactly one** character, no
> more, no fewer.

```sql
SELECT course_code FROM Course
WHERE course_code LIKE 'CSE3__';
```

`CSE3__` matches any six-character code starting with `CSE3`, `CSE301`
and `CSE305` both match; `CSE21` (five characters) and `CSE3010` (seven
characters) do not, `_` is strict about position count in a way `%`
is not.

---

# LIKE: Where the Wildcard Goes Changes the Meaning

<div class="thread">Same operator, three placements, three different questions.</div>

| Pattern | Matches |
|---|---|
| `'Data%'` | starts with "Data" |
| `'%Data'` | ends with "Data" |
| `'%Data%'` | contains "Data" anywhere |

A trailing-only `%` (`'Data%'`) can use an index efficiently; a leading
`%` (`'%Data'` or `'%Data%'`) generally cannot, MySQL must scan every
row's text since the match could start anywhere. Correctness is
identical either way; performance is not, a distinction that matters
once a table has millions of rows.

---

# BETWEEN: Testing a Range

<div class="thread">The comparison-operators table's other preview, now given its own worked example.</div>

> `BETWEEN low AND high` tests whether a value falls inside a range,
> **inclusive** of both endpoints.

```sql
SELECT course_code, title FROM Course
WHERE credits BETWEEN 3 AND 4;
```

Returns every course worth 3 or 4 credits. `BETWEEN 3 AND 4` is exact
shorthand for `credits >= 3 AND credits <= 4`, either form works,
`BETWEEN` just reads more directly as "in this range."

---

# Illustration: BETWEEN's Inclusive Boundaries

<div class="thread">The word most students misread: BETWEEN includes both edges.</div>

**`Course`:**

| course_code | credits |
|---|---|
| CSE301 | 3 |
| CSE305 | 4 |
| CSE410 | 2 |

**`WHERE credits BETWEEN 3 AND 4`** matches `CSE301` and `CSE305`; a
row with exactly `credits = 3` or `credits = 4` is included, not
excluded, "between" here means the closed range `[3, 4]`, not the
open range `(3, 4)`.

---

# NOT LIKE and NOT BETWEEN: Negating a Match

<div class="thread">Every positive test from this section has a negated counterpart.</div>

```sql
SELECT title FROM Course
WHERE title NOT LIKE '%Lab%';

SELECT course_code FROM Course
WHERE credits NOT BETWEEN 3 AND 4;
```

`NOT LIKE` keeps rows that fail the pattern; `NOT BETWEEN` keeps rows
strictly outside the range, so `credits NOT BETWEEN 3 AND 4` excludes
exactly the `3` and `4` rows the previous slide included, the boundary
values flip sides along with everything else.

---

# Logical Operators: Combining Conditions

<div class="thread">One WHERE test is rarely enough. Combine them.</div>

```sql
SELECT name FROM Student
WHERE major = 'Computer Science' AND student_id > 100;
```

- `AND`: both conditions must be true
- `OR`: at least one condition must be true
- `NOT`: reverses a condition

<div class="pain">
<code>WHERE major = 'CS' OR major = 'SE' AND student_id > 100</code>
is genuinely ambiguous without parentheses: does <code>AND</code> bind
first? MySQL follows a fixed rule (<code>AND</code> before
<code>OR</code>), but never rely on memory, always add parentheses.
</div>

---

# IN and IS NULL

<div class="thread">Two more tests, common enough to need their own slide.</div>

```sql
SELECT name FROM Student
WHERE major IN ('Computer Science', 'Software Engineering');

SELECT student_id FROM Enrollment
WHERE grade IS NULL;
```

`IN` is shorthand for a chain of `OR` conditions on the same column.
`IS NULL` is required for missing values, `WHERE grade = NULL` never
matches anything, `NULL` means "unknown," and nothing equals unknown,
not even another unknown.

---

# DISTINCT: Removing Duplicate Results

<div class="thread">A direct answer to a question the raw data cannot answer on its own.</div>

```sql
SELECT DISTINCT major FROM Student;
```

Without `DISTINCT`, this returns "Computer Science" once for every
student majoring in it, hundreds of duplicate rows. With `DISTINCT`,
each distinct value appears exactly once, a direct question ("what
majors exist?") getting a direct answer.

---

# ORDER BY: Sorting Results

<div class="thread">SQL results have no guaranteed order unless you ask for one.</div>

```sql
SELECT name, major FROM Student
ORDER BY name ASC;

SELECT name, grade FROM Enrollment
JOIN Student USING (student_id)
ORDER BY grade DESC;
```

`ASC` (ascending, the default) and `DESC` (descending). Without
`ORDER BY`, MySQL is free to return rows in whatever order is
convenient internally, exactly Week 2's "a relation has no meaningful
order," now visible in query results too.

---

# LIMIT: Fewer Rows Back

<div class="thread">One more clause, useful the moment a table gets large.</div>

```sql
SELECT name, grade FROM Enrollment
JOIN Student USING (student_id)
ORDER BY grade DESC
LIMIT 5;
```

Returns only the first 5 rows of the sorted result, "top 5" queries in
one clause. `LIMIT` is MySQL-specific syntax; other database products
spell this differently, one of the few places MySQL's own dialect
shows.

---

# Arithmetic Expressions in SELECT

<div class="thread">SELECT can return a computed value, not only a stored column.</div>

> `SELECT` can list an arithmetic expression, built from columns,
> numbers, and operators (`+ - * /`), anywhere it could list a column
> name.

```sql
SELECT title, credits, credits * 16 AS total_class_hours
FROM Course;
```

`credits * 16` is computed fresh for every row as the query runs, it
is not stored anywhere in `Course`, `SELECT` is free to compute new
values, not just fetch existing ones.

---

# Column Aliasing With AS

<div class="thread">The previous slide's computed column needed a name. AS is how you give it one.</div>

> `AS` renames a column or expression in the result set only; it never
> changes anything in the underlying table.

```sql
SELECT name AS student_name, major AS program
FROM Student;
```

Without `AS`, a computed expression's column header is the expression
itself, `credits * 16`, unreadable in a report. `AS` gives it a name a
person, or a spreadsheet import, can actually use.

---

# Worked Example: Days Until a Deadline

<div class="thread">A concrete use for both of the last two slides at once.</div>

Suppose `Section` gains a `withdraw_deadline DATE` column:

```sql
SELECT course_code, withdraw_deadline,
       DATEDIFF(withdraw_deadline, CURDATE()) AS days_left
FROM Section;
```

`DATEDIFF` subtracts one date from another, returning a number of
days. Aliased as `days_left`, this single expression turns a raw date
into exactly the number a student actually wants to see.

---

# Illustration: Raw Columns vs. a Computed Column

<div class="thread">What the previous slide's query actually adds to the result.</div>

**`Section` (stored):**

| course_code | withdraw_deadline |
|---|---|
| CSE301 | 2026-09-20 |

**Result of the previous query**, run on 2026-09-06:

| course_code | withdraw_deadline | days_left |
|---|---|---|
| CSE301 | 2026-09-20 | 14 |

`days_left` exists only in the result, computed the moment the query
ran; run it again tomorrow and `14` becomes `13`, nothing in `Section`
itself changed.

---

# CASE: Conditional Values Inside SELECT

<div class="thread">A different kind of column: one whose value depends on a condition, row by row.</div>

> `CASE` evaluates conditions in order and returns the value attached
> to the first one that is true, or `ELSE`'s value if none are.

```sql
SELECT name,
    CASE
        WHEN major = 'Computer Science' THEN 'CS'
        WHEN major = 'Software Engineering' THEN 'SE'
        ELSE 'Other'
    END AS major_code
FROM Student;
```

Every row gets exactly one output value, chosen by whichever `WHEN`
matched first, `ELSE` is the fallback when nothing else did.

---

# Worked Example: Classifying Enrollment Status

<div class="thread">CASE, applied directly to the running case study.</div>

```sql
SELECT student_id, section_id,
    CASE
        WHEN grade IS NULL THEN 'In Progress'
        WHEN grade IN ('F') THEN 'Failed'
        ELSE 'Completed'
    END AS status
FROM Enrollment;
```

One column, three possible outputs, computed from the same `grade`
column Week 11's `IS NULL` slide already introduced, `CASE` just adds
a label a human reads more easily than a raw grade value.

---

# Illustration: What CASE Actually Produces

<div class="thread">Three rows, three different WHEN branches, one column of labels.</div>

| student_id | section_id | grade | status |
|---|---|---|---|
| 1 | 3 | A0 | Completed |
| 7 | 3 | NULL | In Progress |
| 9 | 3 | F | Failed |

Each row is evaluated independently: `CASE` never compares one row to
another, only one row's own columns against its own `WHEN` conditions.

---

# CASE With Multiple WHEN Branches

<div class="thread">Nothing limits CASE to two or three branches, or to equality tests.</div>

```sql
SELECT name, credits,
    CASE
        WHEN credits >= 4 THEN 'Heavy Load'
        WHEN credits = 3 THEN 'Standard Load'
        WHEN credits <= 2 THEN 'Light Load'
        ELSE 'Unspecified'
    END AS load_category
FROM Course;
```

Each `WHEN` can test a different condition, not just a different value
of the same column, `CASE` is a full conditional, not merely a
lookup table.

---

# Whole-Table Aggregates Without GROUP BY

<div class="thread">A lighter first taste of aggregation, before next week's GROUP BY groups it by category.</div>

> Called with no `GROUP BY`, an aggregate function (`COUNT`, `SUM`,
> `AVG`, `MIN`, `MAX`) collapses the **entire** query result into a
> single summary row.

```sql
SELECT COUNT(*) AS total_enrollments
FROM Enrollment;
```

One row back, one number, the count of every row `Enrollment` has.
Next week's `GROUP BY` reuses these exact same functions, but produces
one summary row **per category** instead of one for the whole table.

---

# Worked Example: Summarizing All of Enrollment

<div class="thread">All five aggregate functions, over the whole table at once.</div>

```sql
SELECT COUNT(*) AS total,
       MIN(grade) AS lowest_alpha,
       MAX(grade) AS highest_alpha
FROM Enrollment
WHERE grade IS NOT NULL;
```

`COUNT(*)` counts every graded row, `MIN` and `MAX` find the
alphabetically lowest and highest grade text. Three numbers, one row,
a summary a registrar could read in one glance instead of scrolling
the whole table.

---

# Illustration: One Row Summarizing Every Row

<div class="thread">Many rows go in, exactly one row comes back.</div>

**`Enrollment`** (4 graded rows, one ungraded row omitted by `WHERE`):

| student_id | grade |
|---|---|
| 1 | A0 |
| 2 | B+ |
| 3 | A0 |
| 4 | C+ |

**Result:**

| total | lowest_alpha | highest_alpha |
|---|---|---|
| 4 | C+ | A0 |

Four input rows collapse into one output row, exactly what "no
`GROUP BY`" means: the whole table is treated as a single group.

---

# Aggregates and NULL: What COUNT(*) vs. COUNT(column) Actually Count

<div class="thread">The one distinction that trips up every aggregate function eventually.</div>

```sql
SELECT COUNT(*) AS all_rows,
       COUNT(grade) AS graded_rows
FROM Enrollment;
```

`COUNT(*)` counts every row, `NULL` or not. `COUNT(grade)` counts only
rows where `grade` is **not** `NULL`, `AVG`, `SUM`, `MIN`, and `MAX`
all silently skip `NULL` values the same way `COUNT(column)` does,
an ungraded enrollment never distorts an average grade.

---

# Multiple Aggregates, One Query, No GROUP BY Yet

<div class="thread">Real reports combine several of these at once, even before grouping enters the picture.</div>

```sql
SELECT COUNT(*) AS enrollments,
       COUNT(grade) AS graded,
       COUNT(*) - COUNT(grade) AS still_pending
FROM Enrollment;
```

Three related numbers from one table scan, no `WHERE`, no `GROUP BY`,
just the whole table summarized three different ways in one
statement. Next week, `GROUP BY major` turns this exact query into one
row per major instead of one row overall.

---

# Demo, Step by Step: Answering the Pain Slide's Question

<div class="thread">Every clause from this lecture, built up one at a time, live, not handed over finished.</div>

"Which of my students got an A this semester?" Five steps, each one
adding exactly one clause from today's lecture, run in order.

---

# Step 1: Start With Everything

```sql
SELECT * FROM Enrollment;
```

| student_id | section_id | grade |
|---|---|---|
| 1 | 3 | A0 |
| 2 | 3 | B+ |
| 3 | 3 | A0 |
| 4 | 5 | C+ |

Every row, every column. Too much. Exactly the pain slide's scrolling
problem, still unsolved at this step.

---

# Step 2: Add WHERE

```sql
SELECT * FROM Enrollment
WHERE grade = 'A0';
```

| student_id | section_id | grade |
|---|---|---|
| 1 | 3 | A0 |
| 3 | 3 | A0 |

Two rows survive the filter. Correct, but `student_id` is not a name,
not yet answerable by a human reading it.

---

# Step 3: Add JOIN

```sql
SELECT Student.name, Enrollment.grade FROM Enrollment
JOIN Student USING (student_id)
WHERE grade = 'A0';
```

| name | grade |
|---|---|
| Kim Minji | A0 |
| Han Somin | A0 |

Names now, not IDs. This is already a real, readable answer, but the
next two steps make it robust.

---

# Step 4: Add DISTINCT

```sql
SELECT DISTINCT Student.name FROM Enrollment
JOIN Student USING (student_id)
WHERE grade = 'A0';
```

If a student earned an A0 in two different sections, the previous
step would list them twice. `DISTINCT` guarantees one line per
student, no matter how many A0 grades they have.

---

# Step 5: Add ORDER BY, Done

```sql
SELECT DISTINCT Student.name FROM Enrollment
JOIN Student USING (student_id)
WHERE grade = 'A0'
ORDER BY Student.name ASC;
```

| name |
|---|
| Han Somin |
| Kim Minji |

Five steps, five clauses from this lecture, one final answer, sorted,
deduplicated, readable, in under a second. Exactly Week 1's 3-hour bar
shrinking to the tiny one, now actually true, not just promised.

---

# Every Search Box Is a WHERE Clause

<div class="thread">Not an abstraction. The literal mechanism behind features you use daily.</div>

<div class="appgrid">
<div class="app"><div class="name">Coupang search bar</div><div class="desc">title LIKE '%keyword%'</div></div>
<div class="app"><div class="name">Filter by price</div><div class="desc">price BETWEEN min AND max</div></div>
<div class="app"><div class="name">"Sort by newest"</div><div class="desc">ORDER BY created_at DESC</div></div>
<div class="app"><div class="name">"Load more" button</div><div class="desc">the next LIMIT, offset forward</div></div>
</div>

Every one of these UI features is a thin layer over exactly the
clauses from this lecture.

---

# Common Mistakes

- **Forgetting `WHERE` narrows rows, not columns:** `SELECT name FROM
  Student WHERE major = 'CS'` still returns every matching row, just
  with one column, `WHERE` and `SELECT` do different jobs
- **Assuming result order without `ORDER BY`:** never rely on rows
  "usually" coming back in a certain order; state it explicitly
- **Confusing `=` with `LIKE`:** `name = 'Kim'` matches only the exact
  text "Kim"; `name LIKE 'Kim%'` matches "Kim Minji," "Kim," and more

---

# Common Mistakes, Continued

- **Leaving a wildcard out of a LIKE pattern entirely:** `title LIKE
  'Data'` behaves exactly like `title = 'Data'`, the `%` or `_` is
  what makes `LIKE` different from `=` in the first place
- **Treating `BETWEEN` as exclusive:** `credits BETWEEN 3 AND 4`
  includes both `3` and `4`; a range that should exclude an endpoint
  needs `>` or `<` written out instead
- **Mixing an aggregate and a bare column with no `GROUP BY`:**
  `SELECT major, COUNT(*) FROM Student;` is invalid without
  `GROUP BY major`, MySQL cannot show one row per student's `major`
  next to one number for the whole table at the same time

---

# Practice: A Library Catalog Search

<div class="thread">Same clauses, a different domain, the library example from Weeks 4, 6, and 7, finally queried.</div>

**Question:** write a query returning every `Book` whose title
contains "Database," sorted alphabetically.

**Answer:**
```sql
SELECT title FROM Book
WHERE title LIKE '%Database%'
ORDER BY title ASC;
```

---

# Practice: Finding Incomplete Records

<div class="thread">IS NULL, applied to a genuinely useful real question.</div>

**Question:** write a query listing every enrollment that has not yet
been graded.

**Answer:**
```sql
SELECT student_id, section_id FROM Enrollment
WHERE grade IS NULL;
```
This is the exact query a registrar would run at the end of a
semester to find missing grades before releasing transcripts.

---

# Practice: Arithmetic and Aliasing on the Library Domain

<div class="thread">The same computed-column pattern, a different table.</div>

**Question:** `Book` has an `acquired_on DATE` column. Write a query
returning each title with an aliased column showing how many days ago
it was acquired.

**Answer:**
```sql
SELECT title, DATEDIFF(CURDATE(), acquired_on) AS days_owned
FROM Book;
```

---

# Practice: CASE on the Library Domain

<div class="thread">The same conditional-labeling pattern, applied to a loan record.</div>

**Question:** `Loan` has a `due_date DATE` column. Write a query
labeling each loan `'Overdue'` if `due_date` is before today, or
`'On Time'` otherwise.

**Answer:**
```sql
SELECT loan_id,
    CASE
        WHEN due_date < CURDATE() THEN 'Overdue'
        ELSE 'On Time'
    END AS status
FROM Loan;
```

---

# Check Yourself: New Query Patterns

1. Write a query returning every `Course` whose `title` ends with the
   word "Systems," using `LIKE`.
2. Write a query returning the total number of rows in `Student`
   (a whole-table aggregate, no `GROUP BY`).
3. Write a query returning each student's `name` alongside a `CASE`
   column labeled `'CS'` for Computer Science majors and `'Other'`
   for everyone else.

---

# Answers: New Query Patterns

1. ```sql
   SELECT title FROM Course
   WHERE title LIKE '%Systems';
   ```
2. ```sql
   SELECT COUNT(*) AS total_students FROM Student;
   ```
3. ```sql
   SELECT name,
       CASE WHEN major = 'Computer Science' THEN 'CS'
            ELSE 'Other'
       END AS major_label
   FROM Student;
   ```

---

# Check Yourself

1. Write a query returning every distinct `room` used by any `Section`.
2. Write a query returning the 3 most recent enrollments by
   `student_id`, highest first.
3. Write a query returning every student whose major is either
   "Computer Science" or "Software Engineering," using `IN`.

---

# Answers

1. ```sql
   SELECT DISTINCT room FROM Section;
   ```
2. ```sql
   SELECT * FROM Enrollment
   ORDER BY student_id DESC
   LIMIT 3;
   ```
3. ```sql
   SELECT name FROM Student
   WHERE major IN ('Computer Science', 'Software Engineering');
   ```

---

<!-- SLOT 14: Limits, becomes Week 12 slot 4 -->

# What One Table Cannot Answer

<div class="limits">
Single-table queries can filter, sort, and deduplicate anything living
inside one table. But "which students are in Professor Lee's
sections, with their grades" needs <code>Student</code>,
<code>Enrollment</code>, <code>Section</code>, and
<code>Instructor</code> all at once. Real questions rarely stay inside
one table. Normalization, Week 7's entire point, means the answer is
now scattered across exactly the tables it was split into.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 11 leaves **questions that span more than one table** unsolved.
**Week 12, Multi-table Queries**, addresses it: `JOIN`, and
aggregation, the commands that pull related tables back together.

---

<!-- SLOT 16: Summary -->

# Summary

- `SELECT`, `FROM`, `WHERE` retrieve specific columns and rows,
  declaratively: state what you want, not how to find it.
- Comparison and logical operators build precise filters; `DISTINCT`
  removes duplicates; `ORDER BY` and `LIMIT` control result order and size.
- A single-table query finally pays off Week 1's promise: the
  3-hour manual scroll, replaced by one statement, in under a second.
- **Reading:** Silberschatz et al., 7th ed., Chapter 3 (SQL Queries)
- **Prepare:** write, on paper, a query answering "which sections meet
  in room 성파 702?" before Week 12.

---

# A Note on This Week's Sources

Some topics in this deck (`LIKE`/`BETWEEN` pattern and range matching,
computed columns and aliasing, `CASE` expressions, whole-table
aggregate functions) follow the standard SQL topic organization used
by course reference texts such as *Database System Concepts*, 7th ed.
(Silberschatz, Korth, Sudarshan). All wording, examples, and the
registration-system case study on these slides are original.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
