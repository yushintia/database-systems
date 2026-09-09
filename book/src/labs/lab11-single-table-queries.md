# Lab 11: Single-table Queries

| | |
|---|---|
| **Week** | 11 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Lecture & Lab |
| **Prerequisites** | Lab 09, Lab 10 (or the catch-up schema) |
| **Files provided** | [`files/lab11/full_seed.sql`](files/lab11/full_seed.sql) — full schema, ~175 enrollment rows across 52 students, 26 sections, 18 courses, 16 instructors. **This same file is reused by Lab 12** — do not expect a separate seed there. |

**Why this lab matters:** `Enrollment` now has real rows in it, thanks to Lab 10. A professor asks "which of my students got an A this semester?" The honest answer, with everything you know so far, is: run `SELECT * FROM Enrollment;` and scroll through every row by eye looking for `grade = 'A0'`. That does not scale — a table with 40 rows and a table with 40 million rows are equally unusable this way. `SELECT` is, by a wide margin, the single most frequently written SQL statement in any real job; this lab is where you learn to let the database answer directly, instead of scrolling.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Concept) | 50 | 5 recap Lab 10 · 30 SELECT/WHERE/ORDER BY/aggregates concepts · 15 live demo (Worked Examples) |
| B (Guided practice) | 50 | 40 guided queries against `full_seed.sql`, with checkpoints · 10 debrief and pitfalls |
| C (Independent and wrap) | 50 | 35 independent practice problems · 10 challenge problem · 5 submit and Week 12 preview |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Retrieve specific columns and rows with `SELECT`, `FROM`, and `WHERE`.
2. Filter with comparison operators (`=`, `<>`, `>`, `BETWEEN`, `LIKE`, `IN`, `IS NULL`) and logical operators (`AND`, `OR`, `NOT`).
3. Remove duplicates with `DISTINCT`, sort with `ORDER BY`, and limit results with `LIMIT`.
4. Compute whole-table summaries with aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`), without `GROUP BY`.

---

## Recap

Lab 10 delivered real data in every table, inserted, updated, and deleted safely, with MySQL enforcing every constraint along the way. It also left one thing unsolved: the only way to answer a question is still `SELECT *` followed by reading every row by eye — Lab 1's original spreadsheet problem, alive again, just sitting inside real MySQL now instead of a spreadsheet.

---

## Background

### SELECT-FROM-WHERE: Three Keywords, Three Questions

> `SELECT` names **which columns** to return. `FROM` names **which table**. `WHERE` names **which rows** qualify.

```sql
SELECT name, major
FROM Student
WHERE major = 'Computer Science';
```

Read it in English: "give me the name and major, from Student, where the major is Computer Science." SQL was designed to read almost like the plain-language question it answers — this is what **declarative** means: you state *what* you want, not *how* to find it.

### Comparison and Logical Operators

| Operator | Meaning | Example |
|---|---|---|
| `=` | equal to | `major = 'Computer Science'` |
| `!=` / `<>` | not equal to | `grade != 'F0'` |
| `>`, `<`, `>=`, `<=` | greater/less than | `credits >= 3` |
| `BETWEEN low AND high` | inside a range, **inclusive** of both ends | `credits BETWEEN 1 AND 4` |
| `LIKE` | text pattern match | `name LIKE 'Kim%'` |
| `IN (...)` | matches any item in a list | `major IN ('CS', 'SE')` |
| `IS NULL` | tests for a missing value | `grade IS NULL` |

> **In plain words: NULL**
> `NULL` means "unknown" — not zero, not empty text. Nothing equals unknown, not even another unknown, so `WHERE grade = NULL` **never** matches anything, even rows that genuinely have no grade yet. `IS NULL` is the only correct way to test for a missing value.

Combine conditions with `AND` (both must be true), `OR` (at least one must be true), and `NOT` (reverses a condition). MySQL evaluates `AND` before `OR`, but never rely on memory — always add parentheses when mixing them.

### LIKE: The Two Wildcards

| Wildcard | Matches |
|---|---|
| `%` | any sequence of characters, including zero |
| `_` | exactly one character |

| Pattern | Matches |
|---|---|
| `'Data%'` | starts with "Data" |
| `'%Data'` | ends with "Data" |
| `'%Data%'` | contains "Data" anywhere |

A trailing-only `%` can use an index efficiently; a leading `%` generally cannot, since MySQL must scan every row's text. Correctness is identical either way; performance is not.

### DISTINCT, ORDER BY, LIMIT

```sql
SELECT DISTINCT major FROM Student;

SELECT name, major FROM Student
ORDER BY name ASC;

SELECT name, grade FROM Enrollment
ORDER BY grade DESC
LIMIT 5;
```

Without `ORDER BY`, MySQL is free to return rows in whatever order is internally convenient — a relation has no meaningful order until you ask for one. `LIMIT` is MySQL-specific syntax, not shared by every database product.

### Arithmetic, Aliasing, and CASE

```sql
SELECT title, credits, credits * 16 AS total_class_hours
FROM Course;
```

`AS` renames a column or expression in the result set only — it never changes anything in the underlying table. A computed expression with no alias gets an unreadable column header (`credits * 16` itself), so always alias one.

```sql
SELECT student_id, section_id,
    CASE
        WHEN grade IS NULL THEN 'In Progress'
        WHEN grade = 'F0' THEN 'Failed'
        ELSE 'Completed'
    END AS status
FROM Enrollment;
```

`CASE` evaluates conditions in order and returns the value attached to the first `WHEN` that is true, or `ELSE`'s value if none are. Each row is evaluated independently.

### Whole-Table Aggregates, No GROUP BY Yet

> Called with no `GROUP BY`, an aggregate function (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) collapses the **entire** query result into a single summary row.

```sql
SELECT COUNT(*) AS all_rows,
       COUNT(grade) AS graded_rows
FROM Enrollment;
```

`COUNT(*)` counts every row, `NULL` or not. `COUNT(grade)` counts only rows where `grade` is **not** `NULL`. `SUM`, `AVG`, `MIN`, and `MAX` all silently skip `NULL` the same way — an ungraded enrollment never distorts an average grade. `GROUP BY`, next week's tool, reuses these exact same functions but produces one summary row *per category* instead of one for the whole table.

### The Order SQL Actually Evaluates a Query

A query reads top to bottom on the page, but MySQL does not run it in that order. Knowing the real order explains several rules that otherwise feel arbitrary — most importantly, why `WHERE` can never test an aggregate value.

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 200" style="max-width:600px;display:block;margin:1.5em auto;">
  <title>Logical query execution order. FROM runs first, reading the table. WHERE filters individual rows next. SELECT then picks columns and computes expressions. DISTINCT removes duplicate result rows. ORDER BY sorts what is left. LIMIT cuts the sorted result down to the requested number of rows, running last of all.</title>
  <defs>
    <marker id="arr-lab11" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L7,3 z" fill="#0b3d66"/>
    </marker>
  </defs>
  <g font-family="sans-serif" font-size="12" text-anchor="middle">
    <rect x="10" y="70" width="90" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
    <text x="55" y="102" font-weight="bold" fill="#0b3d66">FROM</text>

    <rect x="120" y="70" width="90" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
    <text x="165" y="102" font-weight="bold" fill="#0b3d66">WHERE</text>

    <rect x="230" y="70" width="90" height="55" rx="8" fill="#fff8e6" stroke="#c07000" stroke-width="2"/>
    <text x="275" y="102" font-weight="bold" fill="#c07000">SELECT</text>

    <rect x="340" y="70" width="90" height="55" rx="8" fill="#fff8e6" stroke="#c07000" stroke-width="2"/>
    <text x="385" y="96" font-weight="bold" fill="#c07000">DISTINCT</text>

    <rect x="450" y="70" width="90" height="55" rx="8" fill="#fdeaea" stroke="#a03030" stroke-width="2"/>
    <text x="495" y="96" font-weight="bold" fill="#a03030">ORDER</text>
    <text x="495" y="112" font-weight="bold" fill="#a03030">BY</text>

    <rect x="560" y="70" width="70" height="55" rx="8" fill="#fdeaea" stroke="#a03030" stroke-width="2"/>
    <text x="595" y="102" font-weight="bold" fill="#a03030">LIMIT</text>

    <line x1="100" y1="97" x2="118" y2="97" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab11)"/>
    <line x1="210" y1="97" x2="228" y2="97" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab11)"/>
    <line x1="320" y1="97" x2="338" y2="97" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab11)"/>
    <line x1="430" y1="97" x2="448" y2="97" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab11)"/>
    <line x1="540" y1="97" x2="558" y2="97" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab11)"/>
  </g>
  <text x="320" y="160" font-family="sans-serif" font-size="11" fill="#555" text-anchor="middle">written order on the page: SELECT ... FROM ... WHERE ... ORDER BY ... LIMIT ...</text>
  <text x="320" y="180" font-family="sans-serif" font-size="11" fill="#555" text-anchor="middle">actual run order: FROM, WHERE, SELECT, DISTINCT, ORDER BY, LIMIT</text>
</svg>
<p style="text-align:center;font-size:0.9em;color:#555;margin-top:-0.6em;"><em><strong>Figure 11.1.</strong> WHERE runs before SELECT even exists yet — this is exactly why WHERE cannot reference a column alias defined in SELECT, and why filtering an aggregate needs GROUP BY and HAVING (Lab 12), never WHERE.</em></p>

---

## Worked Examples

### Example: Answering "Who Got an A?", Five Steps

Built up one clause at a time, against `full_seed.sql`.

**Step 1 — start with everything:**

```sql
SELECT * FROM Enrollment;
```

Every row, every column. Too much — exactly the pain this lab opened with.

**Step 2 — add WHERE:**

```sql
SELECT * FROM Enrollment
WHERE grade = 'A0';
```

Correct, but `student_id` is not a name — not answerable by a human reading it. (Turning IDs into names needs `Student`, a second table — that is next week's `JOIN`. This week's job stops at what one table alone can answer.)

**Step 3 — DISTINCT, on a single-table question:**

```sql
SELECT DISTINCT grade FROM Enrollment
WHERE section_id = 3
ORDER BY grade ASC;
```

Expected result (against `full_seed.sql`, section 3):

| grade |
|---|
| A+ |
| A0 |
| B+ |
| B0 |
| C+ |

Each grade value appears exactly once, sorted, no matter how many rows in section 3 share it.

**Step 4 — a whole-table aggregate:**

```sql
SELECT COUNT(*) AS total,
       MIN(grade) AS lowest_alpha,
       MAX(grade) AS highest_alpha
FROM Enrollment
WHERE grade IS NOT NULL;
```

Expected result shape:

| total | lowest_alpha | highest_alpha |
|---|---|---|
| 157 | A- | F0 |

(`MIN`/`MAX` here compare grade text by MySQL's default collation, not by actual academic rank — `'A-'` sorts before `'A0'` because `-` sorts before `0`, and `'F0'` sorts last because `F` is the latest letter in use. This is exactly why `grade` being text, not a number, matters: alphabetical order and academic rank are not the same order at all.)

#### Line by line

| Line | What it does |
|------|-------------|
| `WHERE grade = 'A0'` | A yes/no test applied to every row; only rows that pass appear in the result. |
| `WHERE section_id = 3` | Narrows to one section before `DISTINCT` even runs — filtering happens before deduplication, matching Figure 11.1's real execution order. |
| `COUNT(*)` vs. the implicit `WHERE grade IS NOT NULL` | `COUNT(*)` counts rows already filtered by `WHERE`, not the whole table — `WHERE` and aggregates compose, they do not conflict. |

---

## Guided In-Lab Exercises

Run [`files/lab11/full_seed.sql`](files/lab11/full_seed.sql) once. Save every query below into **`lab11_queries.sql`**, each preceded by a comment naming which exercise it answers.

### Exercise 1: Basic SELECT-FROM-WHERE (Part B)

Write a query returning the `name` and `major` of every student majoring in "Data Science."

**Checkpoint:** confirm your result has more than zero rows, and every row's `major` is exactly `'Data Science'`.

### Exercise 2: LIKE and BETWEEN (Part B)

Write a query returning every `Course.title` containing the word "Systems" (using `LIKE`). Separately, write a query returning every `Section` whose `semester = '2026-1'`.

### Exercise 3: IS NULL and IN (Part B)

Write a query listing every `Enrollment` row that has not yet been graded, using `IS NULL`. Then write a query returning every `Student` whose `major` is either `'Computer Science'` or `'Software Engineering'`, using `IN`.

**Checkpoint — predict before you run it:** would `WHERE grade = NULL` (instead of `IS NULL`) return the same rows? Try it and confirm.

### Exercise 4: DISTINCT and ORDER BY (Part B/C)

Write a query returning every distinct `room` used by any `Section`, sorted alphabetically.

### Exercise 5: Aggregates Without GROUP BY (Part C)

Write one query returning: the total number of enrollment rows, the number of graded rows, and the number of still-ungraded rows (as three separate aliased columns in one `SELECT`).

**Checkpoint:** confirm `graded + ungraded = total`.

### Exercise 6: CASE (Part C)

Write a query returning each student's `name` alongside a `CASE`-computed column labeled `'CS'` for Computer Science majors and `'Other'` for everyone else.

---

## Challenge Problem

Write a single query against `full_seed.sql` that returns, for the whole `Enrollment` table: the highest and lowest `student_id` that has at least one graded enrollment, the total count of distinct `grade` values in use, and the count of enrollments still awaiting a grade — all in one `SELECT`, no `GROUP BY`. Then write a second query using `CASE` to bucket every `Course` into `'Intro'` (course number below 300, e.g. `CSE150`, `CSE210`) or `'Advanced'` (300 and above) — you will need a numeric comparison on part of the code, using `SUBSTRING` and `CAST` (or `+ 0` to coerce text to a number).

File: `lab11_challenge.sql`

---

## Practice Problems

These are ungraded: extra practice for the concepts in this lab. Solutions are not distributed with this page.

### Practice 1: A Library Catalog Search

Write a query returning every `Book` whose title contains "Database," sorted alphabetically.

### Practice 2: Finding Incomplete Records

Write a query listing every enrollment that has not yet been graded.

### Practice 3: Arithmetic and Aliasing

`Book` has an `acquired_on DATE` column. Write a query returning each title with an aliased column showing how many days ago it was acquired, using `DATEDIFF`.

### Practice 4: CASE on a Loan Table

`Loan` has a `due_date DATE` column. Write a query labeling each loan `'Overdue'` if `due_date` is before today, or `'On Time'` otherwise.

### Practice 5: Ends-With Matching

Write a query returning every `Course` whose `title` ends with the word "Systems," using `LIKE`.

### Practice 6: A Whole-Table Count

Write a query returning the total number of rows in `Student` — a whole-table aggregate, no `GROUP BY`.

### Practice 7: Top-N With LIMIT

Write a query returning the 3 most recently created enrollments (highest `student_id`, then highest `section_id`, as a tiebreaker), using `ORDER BY` and `LIMIT`.

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Confusing `=` with `LIKE` | `name = 'Kim'` matches only the exact text "Kim" | Use `LIKE 'Kim%'` for a prefix match; `%`/`_` are what makes `LIKE` different from `=` at all |
| Writing `WHERE grade = NULL` | Silently returns zero rows, even for genuinely ungraded rows | Always use `IS NULL` / `IS NOT NULL` for missing values |
| Assuming result order without `ORDER BY` | Row order looks consistent in testing, then changes later | Never rely on unstated order; state `ORDER BY` explicitly whenever order matters |
| Mixing an aggregate and a bare column with no `GROUP BY` | `ERROR 1140`: mixing grouped and ungrouped columns | This needs `GROUP BY` (Lab 12) — an aggregate with no `GROUP BY` summarizes the *entire* result, so it cannot sit next to a per-row column |
| Treating `BETWEEN` as exclusive | Off-by-one results at the range's edges | `BETWEEN low AND high` includes both endpoints |

---

## Submission and Rubric

| Deliverable | Filename | Points |
|-------------|----------|--------|
| Exercises 1–4 correct, run cleanly against `full_seed.sql` | `lab11_queries.sql` | 5 |
| Exercises 5–6 correct (aggregates, CASE) | `lab11_queries.sql` | 3 |
| Style: comments identifying each exercise, formatting per the [SQL Style Guide](../appendix/sql-style-guide.md) | `lab11_queries.sql` | 2 |

**Total: 10 points**

---

## Further Reading

- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th ed., Chapter 3 (SQL Queries)
- [SQL Style Guide](../appendix/sql-style-guide.md)
- [Troubleshooting MySQL](../appendix/troubleshooting-mysql.md)
