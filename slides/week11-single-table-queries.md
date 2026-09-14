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

# NOT LIKE: Excluding a Pattern

<div class="thread">Three placements for %, now negated the same way any test can be.</div>

> `NOT LIKE` matches every row a `LIKE` pattern would exclude, and
> excludes every row `LIKE` would match. Same wildcards, opposite result.

```sql
SELECT title FROM Course
WHERE title NOT LIKE '%Lab%';
```

Returns every course title that does **not** contain "Lab" anywhere,
"Database Systems" and "Data Structures" both qualify; "Systems Lab"
does not. `NOT LIKE` is not a separate feature, it is `LIKE` with the
match logic flipped.

---

# Worked Example: Finding Students by Partial Name

<div class="thread">A directly answerable question, start to finish, using only what this slide's LIKE slides just covered.</div>

"Which students have a family name starting with 'Kim'?"

```sql
SELECT student_id, name FROM Student
WHERE name LIKE 'Kim%';
```

| student_id | name |
|---|---|
| 3 | Kim Minji |
| 27 | Kim Doyun |

Two matches out of 52 students. `'Kim%'` matches only names that
*start* with "Kim," not every name containing it anywhere, the
placement rule from the previous slide.

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

# BETWEEN With NOT: Excluding a Range

<div class="thread">Same range test as before, negated the same way LIKE and IN get negated.</div>

```sql
SELECT title, credits FROM Course
WHERE credits NOT BETWEEN 3 AND 4;
```

Returns every course **outside** the closed range `[3, 4]`: credits of
2 or lower, or 5 or higher. `NOT BETWEEN` is shorthand for
`credits < 3 OR credits > 4`, the same inclusive-boundary rule still
applies, just to what falls outside instead of inside.

---

# Worked Example: BETWEEN Combined With ORDER BY

<div class="thread">Two clauses from this lecture, composed into one real answer.</div>

"List every 3-4 credit course, alphabetically by title."

```sql
SELECT title, credits FROM Course
WHERE credits BETWEEN 3 AND 4
ORDER BY title ASC;
```

| title | credits |
|---|---|
| Data Structures | 3 |
| Database Systems | 3 |
| Software Engineering | 4 |

`WHERE` narrows the rows first, `ORDER BY` then sorts only what
survived the filter, not the whole `Course` table.

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

# Worked Example: Parentheses Change the Answer

<div class="thread">The previous slide's warning, made concrete with two different results from the same words.</div>

```sql
-- No parentheses: AND binds first, so this reads as
-- "CS" OR ("SE" AND student_id > 100)
SELECT name FROM Student
WHERE major = 'Computer Science' OR major = 'Software Engineering'
  AND student_id > 100;

-- Parentheses force the intended grouping
SELECT name FROM Student
WHERE (major = 'Computer Science' OR major = 'Software Engineering')
  AND student_id > 100;
```

The first version returns **every** Computer Science student,
regardless of `student_id`, plus only the Software Engineering
students above 100. The second returns only students of either major
whose `student_id` is above 100, a materially smaller result. Same
words, different parentheses, different answer.

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

# NOT IN: Excluding a List

<div class="thread">IN's mirror image, for the same reason NOT LIKE mirrors LIKE.</div>

```sql
SELECT name FROM Student
WHERE major NOT IN ('Computer Science', 'Software Engineering');
```

Returns every student whose major is neither of the two listed,
`'Data Science'` and any other major in the table. `NOT IN` is
shorthand for a chain of `AND ... != ...` conditions, the negated
counterpart of `IN`'s chain of `OR ... = ...`.

---

# IS NOT NULL Combined With Another Filter

<div class="thread">IS NULL's opposite, doing real work alongside a second condition.</div>

```sql
SELECT student_id, grade FROM Enrollment
WHERE section_id = 3 AND grade IS NOT NULL;
```

Two conditions, both must hold: the row belongs to section 3, **and**
a grade has actually been posted. `IS NOT NULL` is required here too,
`grade != NULL` is exactly as broken as `grade = NULL`, neither ever
matches anything.

---

# Worked Example: Ungraded Enrollments in One Section

<div class="thread">IS NULL, narrowed to a specific section instead of the whole table.</div>

```sql
SELECT student_id FROM Enrollment
WHERE section_id = 5 AND grade IS NULL;
```

| student_id |
|---|
| 19 |
| 24 |

Two students in section 5 have not yet been graded. Swapping `IS NULL`
for `= NULL` here would silently return zero rows, even though these
two rows plainly exist, the exact trap `IS NULL` exists to avoid.

---

# Worked Example: A Compound WHERE Clause, Start to Finish

<div class="thread">Every operator from this slide's neighbors, stacked into one real question.</div>

"Which Software Engineering students, with `student_id` over 30, are
on record, sorted by name?"

```sql
SELECT student_id, name FROM Student
WHERE major = 'Software Engineering' AND student_id > 30
ORDER BY name ASC;
```

| student_id | name |
|---|---|
| 33 | Han Yerin |
| 47 | Jang Hyeri |

`major`, `student_id`, and a sort order, three conditions worth of
filtering, in one statement that returns exactly the rows the question
asked for.

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

# Worked Example: Every Distinct Room in Use

<div class="thread">The same DISTINCT idea, a second column, a genuinely useful question.</div>

"What rooms does the registration system actually use?"

```sql
SELECT DISTINCT room FROM Section
ORDER BY room ASC;
```

| room |
|---|
| 성파 615 |
| 성파 702 |

Without `DISTINCT`, this returns one row per `Section`, 26 rows, most
of them repeating the same handful of rooms.

---

# ORDER BY: Sorting Results

<div class="thread">SQL results have no guaranteed order unless you ask for one.</div>

```sql
SELECT name, major FROM Student
ORDER BY name ASC;

SELECT student_id, grade FROM Enrollment
ORDER BY grade DESC;
```

`ASC` (ascending, the default) and `DESC` (descending). Without
`ORDER BY`, MySQL is free to return rows in whatever order is
convenient internally, exactly Week 2's "a relation has no meaningful
order," now visible in query results too.

---

# ORDER BY Multiple Columns: Breaking Ties

<div class="thread">One sort key is not always enough to produce a stable, readable order.</div>

```sql
SELECT name, major FROM Student
ORDER BY major ASC, name ASC;
```

Rows sort by `major` first; whenever two students share a major, the
second key, `name`, decides the order between them. Without the
second key, MySQL is free to place same-major rows in any order at
all, exactly the "no guaranteed order" rule from the previous slide,
now applied inside a tie instead of across the whole result.

---

# LIMIT: Fewer Rows Back

<div class="thread">One more clause, useful the moment a table gets large.</div>

```sql
SELECT student_id, grade FROM Enrollment
ORDER BY grade DESC
LIMIT 5;
```

Returns only the first 5 rows of the sorted result, "top 5" queries in
one clause. `LIMIT` is MySQL-specific syntax; other database products
spell this differently, one of the few places MySQL's own dialect
shows.

---

# Worked Example: Highest-Credit Courses

<div class="thread">The same ORDER BY + LIMIT pattern, a different column, a different question.</div>

```sql
SELECT title, credits FROM Course
ORDER BY credits DESC
LIMIT 3;
```

| title | credits |
|---|---|
| Software Engineering | 4 |
| Database Systems | 3 |
| Data Structures | 3 |

Sort first, by the column that defines "top," then cut the result down
to size, `ORDER BY` and `LIMIT` always work together in that order,
never the reverse.

---

# LIMIT With OFFSET: Paging Through Results

<div class="thread">LIMIT alone always returns the same first rows. OFFSET moves the window.</div>

> `LIMIT n OFFSET m` skips the first `m` rows of the sorted result,
> then returns the next `n`. This is the literal mechanism behind
> every "page 2" and "load more" button.

```sql
SELECT student_id, section_id FROM Enrollment
ORDER BY student_id ASC
LIMIT 10 OFFSET 10;
```

Skips the first 10 rows, then returns the next 10, rows 11 through 20
of the sorted result, exactly "page 2" if the page size is 10.

---

# Worked Example: Paging With OFFSET

<div class="thread">The previous slide's clause, run against real data, with real output.</div>

```sql
SELECT student_id, section_id, grade FROM Enrollment
ORDER BY student_id ASC
LIMIT 2 OFFSET 5;
```

| student_id | section_id | grade |
|---|---|---|
| 6 | 3 | B0 |
| 6 | 8 | A0 |

Page 1 (`OFFSET 0`) shows the first rows in `student_id` order; this
is the next page of that same sorted sequence, nothing more.

---

# Arithmetic Expressions and Aliasing With AS

<div class="thread">SELECT can return a computed value, not only a stored column, and AS gives that value a readable name.</div>

> `SELECT` can list an arithmetic expression, built from columns,
> numbers, and operators (`+ - * /`), anywhere it could list a column
> name. `AS` renames a column or expression in the result set only; it
> never changes anything in the underlying table.

```sql
SELECT title, credits, credits * 16 AS total_class_hours
FROM Course;
```

`credits * 16` is computed fresh for every row as the query runs, it
is not stored anywhere in `Course`. Without `AS`, its column header
would be the expression itself, `credits * 16`, unreadable in a
report, `AS` gives it a name a person can actually use.

---

# ORDER BY an Aliased Expression

<div class="thread">The value the previous slide computed can drive the sort order too.</div>

```sql
SELECT title, credits, credits * 16 AS total_class_hours
FROM Course
ORDER BY total_class_hours DESC;
```

`ORDER BY` can reference `total_class_hours`, the alias just defined
in `SELECT`, even though `total_class_hours` is not a stored column
anywhere in `Course`. MySQL computes the expression once per row, then
sorts by the computed value, not the raw column.

---

# CASE: Conditional Values Inside SELECT

<div class="thread">A different kind of column: one whose value depends on a condition, row by row.</div>

> `CASE` evaluates conditions in order and returns the value attached
> to the first one that is true, or `ELSE`'s value if none are.

```sql
SELECT student_id, section_id,
    CASE
        WHEN grade IS NULL THEN 'In Progress'
        WHEN grade = 'F0' THEN 'Failed'
        ELSE 'Completed'
    END AS status
FROM Enrollment;
```

Every row gets exactly one output value, chosen by whichever `WHEN`
matched first, `ELSE` is the fallback when nothing else did. Each row
is evaluated independently, `CASE` never compares one row to another.

---

# CASE, the Simple Form: Matching One Column Directly

<div class="thread">The previous slide showed the searched form. Here is CASE's other, shorter shape.</div>

```sql
SELECT name,
    CASE major
        WHEN 'Computer Science' THEN 'CS'
        WHEN 'Software Engineering' THEN 'SE'
        ELSE 'Other'
    END AS major_code
FROM Student;
```

This "simple" form names one column once, right after `CASE`, then
compares it to each `WHEN` value directly. It reads shorter than the
searched form's repeated `WHEN major = ...`, but only works when every
branch tests the *same* column for equality, the searched form is
still required the moment a branch needs `IS NULL` or a range.

---

# Worked Example: A Status Report Built With CASE

<div class="thread">CASE and arithmetic aliasing, combined into one readable report column.</div>

```sql
SELECT title, credits,
    CASE
        WHEN credits >= 4 THEN 'Heavy Load'
        WHEN credits = 3 THEN 'Standard Load'
        ELSE 'Light Load'
    END AS load_label
FROM Course
ORDER BY credits DESC;
```

| title | credits | load_label |
|---|---|---|
| Software Engineering | 4 | Heavy Load |
| Database Systems | 3 | Standard Load |
| Introduction to Programming | 2 | Light Load |

One query, no second table, turns a raw number into a label a
non-technical reader can actually use.

---

# Whole-Table Aggregates Without GROUP BY

<div class="thread">A lighter first taste of aggregation, before next week's GROUP BY groups it by category.</div>

> Called with no `GROUP BY`, an aggregate function (`COUNT`, `SUM`,
> `AVG`, `MIN`, `MAX`) collapses the **entire** query result into a
> single summary row.

```sql
SELECT COUNT(*) AS all_rows,
       COUNT(grade) AS graded_rows
FROM Enrollment;
```

`COUNT(*)` counts every row, `NULL` or not. `COUNT(grade)` counts only
rows where `grade` is **not** `NULL`, `SUM`, `AVG`, `MIN`, and `MAX`
all silently skip `NULL` the same way, an ungraded enrollment never
distorts an average grade. Next week's `GROUP BY` reuses these exact
same functions, producing one summary row **per category** instead of
one for the whole table.

---

# SUM and AVG: Summarizing Course Load

<div class="thread">Two more aggregate functions, on a column where they actually make sense.</div>

```sql
SELECT SUM(credits) AS total_credits_offered,
       AVG(credits) AS avg_credits_per_course
FROM Course;
```

| total_credits_offered | avg_credits_per_course |
|---|---|
| 56 | 3.1111 |

`SUM` adds `credits` across all 18 courses; `AVG` divides that same
total by the number of non-`NULL` rows. Both collapse the entire
`Course` table into a single summary row, the same "no `GROUP BY`"
rule as `COUNT`.

---

# COUNT(DISTINCT ...): Counting Unique Values

<div class="thread">DISTINCT and an aggregate, combined into a single number instead of a list.</div>

```sql
SELECT COUNT(DISTINCT major) AS distinct_majors
FROM Student;
```

| distinct_majors |
|---|
| 3 |

`COUNT(major)` alone would count every non-`NULL` row, 52 of them.
`COUNT(DISTINCT major)` counts only how many *different* values
appear, exactly the number of rows the earlier `SELECT DISTINCT
major` slide would return, condensed into one number.

---

# MIN and MAX on a Real Number, Not Text

<div class="thread">The upcoming Demo sequence warns about grade text; here is the same pair of functions, done properly.</div>

```sql
SELECT MIN(credits) AS lightest, MAX(credits) AS heaviest
FROM Course;
```

| lightest | heaviest |
|---|---|
| 2 | 4 |

On a genuinely numeric column, `MIN`/`MAX` compare by actual
magnitude, 2 really is smaller than 4. Contrast this with
`MIN(grade)`/`MAX(grade)` two slides ahead, where the same functions
compare *text* alphabetically, `'A-'` before `'A0'`, because `grade`
is stored as a string, not a number.

---

# Aggregates Compose With WHERE, a Second Example

<div class="thread">Filtering before summarizing, on a different column and a different condition.</div>

```sql
SELECT AVG(credits) AS avg_credits_of_larger_courses
FROM Course
WHERE credits >= 3;
```

| avg_credits_of_larger_courses |
|---|
| 3.3125 |

`WHERE` removes the lighter courses first; `AVG` then averages only
what is left. Compare this to the earlier `AVG(credits)` slide's
`3.1111`: filtering out the 2-credit courses pulls the average up,
exactly what "compose" means here, two clauses applied in sequence.

---

# CASE Inside COUNT: Conditional Counting

<div class="thread">A preview of Week 12's GROUP BY, one bucket at a time, without GROUP BY itself.</div>

```sql
SELECT COUNT(*) AS total_rows,
       COUNT(CASE WHEN grade = 'A0' THEN 1 END) AS a_count
FROM Enrollment;
```

| total_rows | a_count |
|---|---|
| 175 | 22 |

`CASE` returns `1` for a matching row and `NULL` (the implicit `ELSE`)
otherwise; `COUNT` then ignores every `NULL`, exactly like
`COUNT(grade)` does, counting only rows that actually matched. One
pass over the table, no `GROUP BY` required.

---

# Illustration: The Order SQL Actually Runs a Query

<div class="thread">A query reads top to bottom on the page. MySQL does not run it in that order.</div>

<div class="pipeline">
<div class="stage"><div class="h">FROM</div><div class="s">read the table</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">WHERE</div><div class="s">filter rows</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">SELECT</div><div class="s">pick columns</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">ORDER BY</div><div class="s">sort what's left</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">LIMIT</div><div class="s">cut it down</div></div>
</div>

Written order: `SELECT ... FROM ... WHERE ... ORDER BY ... LIMIT ...`.
Actual run order: `FROM`, `WHERE`, `SELECT`, `ORDER BY`, `LIMIT`. This
is exactly why `WHERE` can test `grade` but never a `SELECT` alias
defined in the same query, `WHERE` runs before `SELECT` has computed
anything yet.

---

# Demo, Step by Step: Answering the Pain Slide's Question

<div class="thread">This lab's own Worked Example, built up one clause at a time, live, not handed over finished.</div>

"Which of my students got an A this semester?" Every step below adds
exactly one clause from today's lecture, run in order.

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
not yet answerable by a human reading it, turning an ID into a name
needs `Student`, a second table, next week's `JOIN`.

---

# Step 3: DISTINCT on a Single-Table Question

```sql
SELECT DISTINCT grade FROM Enrollment
WHERE section_id = 3
ORDER BY grade ASC;
```

| grade |
|---|
| A+ |
| A0 |
| B+ |
| B0 |
| C+ |

`WHERE` narrows to one section before `DISTINCT` even runs, filtering
happens before deduplication. Each grade value appears exactly once,
sorted, no matter how many rows in section 3 share it.

---

# Step 4: A Whole-Table Aggregate

```sql
SELECT COUNT(*) AS total,
       MIN(grade) AS lowest_alpha,
       MAX(grade) AS highest_alpha
FROM Enrollment
WHERE grade IS NOT NULL;
```

| total | lowest_alpha | highest_alpha |
|---|---|---|
| 157 | A- | F0 |

`COUNT(*)` counts rows already filtered by `WHERE`, not the whole
table, `WHERE` and aggregates compose, they do not conflict. `MIN`/
`MAX` compare grade text alphabetically, not academic rank, `'A-'`
sorts before `'A0'` because `-` sorts before `0`.

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

- **Confusing `=` with `LIKE`:** `name = 'Kim'` matches only the exact
  text "Kim"; `LIKE 'Kim%'` is what makes a prefix match possible
- **Writing `WHERE grade = NULL`:** silently returns zero rows, even
  for genuinely ungraded rows; always use `IS NULL` / `IS NOT NULL`
- **Assuming result order without `ORDER BY`:** never rely on rows
  "usually" coming back in a certain order; state it explicitly
- **Treating `BETWEEN` as exclusive:** `credits BETWEEN 3 AND 4`
  includes both `3` and `4`, not just the values strictly between them

---

# Sample Question 1

**Question:** What does `WHERE grade = NULL` actually return, and why
does `IS NULL` behave differently?

**Answer:** `NULL` means "unknown"; nothing equals unknown, not even
another unknown, so `= NULL` never matches anything. `IS NULL` is the
only correct test for a missing value.

---

# Sample Question 2

**Question:** Write a query returning every distinct `major` in
`Student`, sorted alphabetically.

**Answer:**
```sql
SELECT DISTINCT major FROM Student
ORDER BY major ASC;
```

---

# Sample Question 3

**Question:** In `SELECT COUNT(*) AS all_rows, COUNT(grade) AS
graded_rows FROM Enrollment;`, why can the two counts differ?

**Answer:** `COUNT(*)` counts every row, `NULL` or not. `COUNT(grade)`
counts only rows where `grade` is not `NULL`, so the two counts differ
by exactly the number of still-ungraded rows.

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
- **Lab page:** [Lab 11 in the online Lab Manual](../book/labs/lab11-single-table-queries.html), for the
  Guided Exercises, Challenge Problem, and rubric
- **Reading:** Silberschatz et al., 7th ed., Chapter 3 (SQL Queries)
- **Prepare:** write, on paper, a query answering "which sections meet
  in room 성파 702?" before Week 12.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
