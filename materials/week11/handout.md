# Week 11 Handout: Single-table Queries

Database Systems (511783-001) — for students to keep and read again.
Use plain, simple English on purpose, so it is easy to read even if
English is not your first language.

---

## 1. Glossary: Key Words This Week

Read each definition once now. You do not need to memorize them today —
you will use them all semester.

| Term | Plain definition |
|---|---|
| **SELECT** | The SQL keyword that names which columns you want back |
| **FROM** | The SQL keyword that names which table you are reading from |
| **WHERE** | The SQL keyword that names which rows qualify, a yes/no test applied to every row |
| **Comparison operator** | A symbol that tests one value against another, such as `=`, `!=`, `>`, `<`, `>=`, `<=` |
| **Logical operator** | `AND`, `OR`, or `NOT` — a way to combine or reverse more than one `WHERE` test |
| **BETWEEN** | A comparison operator that tests whether a value falls inside a range, such as `credits BETWEEN 1 AND 4` |
| **LIKE** | A comparison operator that tests text against a pattern instead of an exact match |
| **Wildcard (%)** | The symbol used inside a `LIKE` pattern to mean "anything, including nothing" |
| **IN** | A comparison operator that tests whether a value matches any item in a list, shorthand for a chain of `OR` conditions |
| **NULL** | A value meaning "unknown." Nothing equals unknown, not even another unknown, so `= NULL` never matches |
| **IS NULL** | The only correct way to test for a missing value, since `WHERE grade = NULL` never matches anything |
| **DISTINCT** | A keyword placed after `SELECT` that removes duplicate rows from the result, leaving each distinct value once |
| **ORDER BY** | The clause that sorts a result, using `ASC` (ascending, the default) or `DESC` (descending) |
| **LIMIT** | The clause that returns only the first N rows of a result. This is MySQL's own syntax, not shared by every database product |
| **Declarative** | A style of instruction that states *what* you want, not *how* to find it. SQL's `SELECT` was designed this way from its first prototype |

---

## 2. Answering "Who Got an A?", Worked Out Step by Step

This is the full version of the story from class. Read it slowly if the
in-class pace felt fast.

**The situation.** `Enrollment` now has thousands of real rows in it,
thanks to Week 10. A professor asks a completely reasonable question:
"which of my students got an A this semester?" The honest current
answer is: run `SELECT * FROM Enrollment;`, and scroll through
thousands of rows looking for `grade = 'A0'` by eye. The schema is
correct, the data is correct, and answering the question still takes
exactly the kind of manual scrolling this course opened by promising to
eliminate. This week gives the database itself the tools to answer
directly.

**Step 1: Start with everything.** The honest starting point:

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

**Step 2: Add WHERE to filter rows.** `WHERE` names which rows qualify,
a yes/no test applied to every row:

```sql
SELECT * FROM Enrollment
WHERE grade = 'A0';
```

| student_id | section_id | grade |
|---|---|---|
| 1 | 3 | A0 |
| 3 | 3 | A0 |

Two rows survive the filter. Correct, but `student_id` is not a name —
not yet answerable by a human reading it, since `name` lives in the
`Student` table, not `Enrollment`.

**Step 3: A quick preview of next week.** The full demo shown in class
went one step further, joining in `Student.name` so the result reads
"Kim Minji" and "Han Somin" instead of `1` and `3`:

```sql
SELECT Student.name, Enrollment.grade FROM Enrollment
JOIN Student USING (student_id)
WHERE grade = 'A0';
```

That `JOIN` is only a preview. It is formally taught next week; this
week's job is everything up to and including the `WHERE` test above.

**Step 4: DISTINCT and ORDER BY finish the job single-table style.**
Two clauses from this week, applied on their own to what a single
table can give us:

```sql
SELECT DISTINCT grade FROM Enrollment
WHERE section_id = 3
ORDER BY grade ASC;
```

`DISTINCT` guarantees each grade value appears once, no matter how many
rows share it. `ORDER BY` sorts the result — without it, MySQL is free
to return rows in whatever order is convenient internally, exactly
Week 2's "a relation has no meaningful order," now visible in query
results too.

**What we still can't say yet.** Single-table queries can filter, sort,
and deduplicate anything living inside one table. But "which students
got an A, by name" needs both `Enrollment` and `Student` at once —
`grade` lives in one table, `name` lives in another. Real questions
rarely stay inside one table. Normalization, Week 7's entire point,
means the answer is now scattered across exactly the tables it was
split into. Week 12, Multi-table Queries, is where `JOIN` becomes this
week's official tool instead of a preview.

---

## 3. Optional Reading: Extra Detail (Not Required, Not on the Quiz)

This section holds extra explanations that were trimmed from the
slides to keep class time short. Read it if you are curious or want
more examples.

**Why `SELECT` matters more than any other SQL command.** In industry,
`SELECT` is, by a wide margin, the most frequently written SQL
statement in any real job. Every dashboard, report, and search box you
have ever used is a `SELECT` statement wearing a user interface. A
table with 40 rows and a table with 40 million rows are equally
unusable by eye — the moment data gets real, `SELECT` is the only
thing that scales.

**Every search box you have used is a WHERE clause.** This is not an
abstraction, it is the literal mechanism behind features you use daily:

- **A search bar** (like Coupang's) is roughly `title LIKE
  '%keyword%'`
- **"Filter by price"** is roughly `price BETWEEN min AND max`
- **"Sort by newest"** is `ORDER BY created_at DESC`
- **A "Load more" button** is the next `LIMIT`, moved forward

**Who actually writes these queries, as a job.**

- **Data analysts** write `SELECT` statements all day, turning a raw
  question ("which customers churned last month?") directly into a
  filtered, sorted result
- **Report writers** build the queries behind recurring dashboards and
  scheduled reports, most of which are `SELECT ... WHERE ... ORDER BY`
  underneath a nicer-looking chart
- **Support engineers** run one-off `SELECT` queries to check a single
  customer's data when investigating a bug report

---

## 4. Practice Problems (With Answers)

Try each problem yourself before checking the answer underneath it.

**Problem 1.** Write a query returning the `name` and `major` of every
student majoring in "Software Engineering."

> **Answer:**
> ```sql
> SELECT name, major FROM Student
> WHERE major = 'Software Engineering';
> ```

**Problem 2.** Write a query returning every distinct `room` used by
any `Section`.

> **Answer:**
> ```sql
> SELECT DISTINCT room FROM Section;
> ```

**Problem 3.** Write a query listing every enrollment that has not yet
been graded.

> **Answer:**
> ```sql
> SELECT student_id, section_id FROM Enrollment
> WHERE grade IS NULL;
> ```
> This is the exact query a registrar would run at the end of a
> semester to find missing grades before releasing transcripts.

**Problem 4.** Write a query returning every `Course` whose `title`
contains "Data," sorted alphabetically.

> **Answer:**
> ```sql
> SELECT title FROM Course
> WHERE title LIKE '%Data%'
> ORDER BY title ASC;
> ```

**Problem 5.** Write a query returning the `name` of every student
whose `major` is either "Computer Science" or "Software Engineering,"
using `IN`.

> **Answer:**
> ```sql
> SELECT name FROM Student
> WHERE major IN ('Computer Science', 'Software Engineering');
> ```

**Problem 6.** Write a query returning the 3 most recent enrollments,
sorted by `student_id`, highest first.

> **Answer:**
> ```sql
> SELECT * FROM Enrollment
> ORDER BY student_id DESC
> LIMIT 3;
> ```
