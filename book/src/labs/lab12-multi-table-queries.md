# Lab 12: Multi-table Queries

| | |
|---|---|
| **Week** | 12 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Lecture & Lab |
| **Prerequisites** | Lab 09, Lab 10, Lab 11 |
| **Files provided** | none new — this lab reuses [Lab 11's `full_seed.sql`](lab11-single-table-queries.md) directly: [`../files/lab11/full_seed.sql`](files/lab11/full_seed.sql). Run it once if you have not already; do not expect a separate seed file in this lab's own `files/` folder. |

**Assignment 2 is due this week.** It asks you to write multi-table queries and aggregation against the registration schema — everything in this lab is exactly the material you need for it. See [Grading Rubrics](../appendix/grading-rubric.md) for the assignment schedule.

**Why this lab matters:** the registrar sends an email: "list every student in Professor Lee's sections, with their grade, and the course title." `Enrollment` has the grade and the student ID. `Section` has the room and the instructor ID. `Instructor` has the name. `Course` has the title. Not one of these four tables, alone, has enough information to answer the question. Normalization (Week 7) put each fact exactly once — which also means no single table has the whole picture anymore. The fix for redundancy is exactly what makes `JOIN` necessary at all.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Concept) | 50 | 5 recap Lab 11 · 30 JOIN types, GROUP BY/HAVING, subqueries · 15 live demo (Worked Examples) |
| B (Guided practice) | 50 | 40 guided multi-table queries against `full_seed.sql`, with checkpoints · 10 debrief and pitfalls |
| C (Independent and wrap) | 50 | 35 independent practice problems · 10 challenge problem · 5 submit Assignment 2 |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Write an `INNER JOIN` and a `LEFT JOIN`, and explain the difference in which rows survive.
2. Join more than two tables in a single query, following the foreign-key path between them.
3. Group rows with `GROUP BY` and summarize each group with aggregate functions.
4. Filter grouped results with `HAVING`, as distinct from filtering rows with `WHERE`.

---

## Recap

Lab 11 delivered `SELECT`, `WHERE`, `DISTINCT`, `ORDER BY`, and `LIMIT` — finally answering questions inside one table in under a second. It also left one thing unsolved: normalization split the registration data across five tables, so any question that needs more than one fact at once (a name *and* a grade *and* a course title) now needs more than one table at once.

---

## Background

### JOIN: Reassembling What Normalization Split Apart

> A **JOIN** combines rows from two tables into one result, based on a matching condition, usually a foreign key matching a primary key.

```sql
SELECT Student.name, Enrollment.grade
FROM Student
JOIN Enrollment ON Student.student_id = Enrollment.student_id;
```

`ON` states the condition: rows are matched wherever `student_id` agrees on both sides. `JOIN` alone means `INNER JOIN` — MySQL's default.

### INNER JOIN vs. LEFT JOIN: Which Rows Survive

| | Keeps |
|---|---|
| `INNER JOIN` (or plain `JOIN`) | only rows where a match exists on **both** sides |
| `LEFT JOIN` | **every** row from the left (first-named) table, filling missing columns with `NULL` where no match exists |
| `RIGHT JOIN` | **every** row from the right-named table — the mirror image of `LEFT JOIN`, rarely needed since you can always rewrite it as a `LEFT JOIN` by swapping table order |

```sql
-- Drops any student with zero enrollments entirely
SELECT Student.name, Enrollment.grade
FROM Student
INNER JOIN Enrollment ON Student.student_id = Enrollment.student_id;

-- Keeps every student, NULL grade if they have none
SELECT Student.name, Enrollment.grade
FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id;
```

> **In plain words: which JOIN do I need?**
> Ask: "should a row with no match on the other side disappear, or stay with a `NULL`?" If it should disappear (only students who are actually enrolled), use `INNER JOIN`. If it should stay (every student, enrolled or not), use `LEFT JOIN`. The choice changes which rows vanish from your result — get it wrong, and the query runs with no error at all, it is just silently wrong.

### The Join Path: Walking Foreign Keys

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 660 220" style="max-width:600px;display:block;margin:1.5em auto;">
  <title>The join path from Enrollment to Instructor, needed to answer "list students in Professor Lee's sections, with grade and course title." Enrollment joins to Student for the student name. Enrollment also joins to Section by section_id. Section joins to Course by course_code for the title, and Section joins to Instructor by instructor_id for the instructor name.</title>
  <defs>
    <marker id="arr-lab12" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L7,3 z" fill="#0b3d66"/>
    </marker>
  </defs>
  <g font-family="sans-serif" font-size="12" text-anchor="middle">
    <rect x="20" y="85" width="120" height="50" rx="8" fill="#fdeaea" stroke="#a03030" stroke-width="2"/>
    <text x="80" y="115" font-weight="bold" fill="#a03030">Enrollment</text>

    <rect x="220" y="20" width="120" height="50" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
    <text x="280" y="50" font-weight="bold" fill="#0b3d66">Student</text>

    <rect x="220" y="150" width="120" height="50" rx="8" fill="#fff8e6" stroke="#c07000" stroke-width="2"/>
    <text x="280" y="180" font-weight="bold" fill="#c07000">Section</text>

    <rect x="440" y="90" width="120" height="50" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
    <text x="500" y="112" font-weight="bold" fill="#0b3d66">Course</text>
    <text x="500" y="128" font-size="10" fill="#0b3d66">(title)</text>

    <rect x="440" y="160" width="120" height="50" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
    <text x="500" y="182" font-weight="bold" fill="#0b3d66">Instructor</text>
    <text x="500" y="198" font-size="10" fill="#0b3d66">(name)</text>

    <line x1="90" y1="85" x2="240" y2="55" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab12)"/>
    <line x1="130" y1="120" x2="230" y2="165" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab12)"/>
    <line x1="340" y1="170" x2="440" y2="130" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab12)"/>
    <line x1="340" y1="180" x2="440" y2="185" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab12)"/>
  </g>
</svg>
<p style="text-align:center;font-size:0.9em;color:#555;margin-top:-0.6em;"><em><strong>Figure 12.1.</strong> Every arrow is one JOIN ... ON, one foreign-key relationship, walked in the direction the question needs.</em></p>

### GROUP BY and HAVING

> `GROUP BY` clusters rows sharing the same value in one or more columns into groups, so an aggregate function can summarize each group separately.

```sql
SELECT major, COUNT(*) AS student_count
FROM Student
GROUP BY major;
```

```sql
SELECT Section.section_id, COUNT(*) AS enrolled
FROM Enrollment
GROUP BY Section.section_id
HAVING COUNT(*) > 8;
```

`WHERE` filters individual rows, **before** grouping happens. `HAVING` filters entire groups, **after** grouping and aggregation. `WHERE enrolled > 8` is invalid — `enrolled` does not exist as a value until grouping has already happened.

### ON vs. WHERE on an OUTER JOIN: Not Interchangeable

```sql
-- Keeps every student; NULL grade if their enrollment wasn't an A0
SELECT Student.name, Enrollment.grade
FROM Student
LEFT JOIN Enrollment
  ON Student.student_id = Enrollment.student_id
 AND Enrollment.grade = 'A0';

-- Silently behaves like an INNER JOIN instead
SELECT Student.name, Enrollment.grade
FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id
WHERE Enrollment.grade = 'A0';
```

On an `INNER JOIN`, `ON` and `WHERE` give identical results. On an `OUTER JOIN`, they do not: a condition in `WHERE` runs *after* the `LEFT JOIN` already kept the unmatched rows, throwing them straight back out. Always ask which clause a condition belongs in.

### Subqueries in Multi-Table Questions

```sql
SELECT name FROM Student
WHERE student_id IN (
    SELECT student_id FROM Enrollment WHERE section_id = 3
);
```

```sql
SELECT name FROM Student s
WHERE NOT EXISTS (
    SELECT 1 FROM Enrollment e WHERE e.student_id = s.student_id
);
```

`NOT EXISTS` finds every row with no counterpart at all — the same students a `LEFT JOIN ... WHERE Enrollment.student_id IS NULL` would find, often the more direct way to ask the question.

---

## Worked Examples

### Example: Joining Four Tables, One Step at a Time

The pain slide's actual question, built up one `JOIN` at a time, against `full_seed.sql`.

**Step 1 — start at Enrollment:**

```sql
SELECT * FROM Enrollment;
```

**Step 2 — add Student:**

```sql
SELECT Student.name, Enrollment.grade
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id;
```

**Step 3 — add Section, then Course:**

```sql
SELECT Student.name, Enrollment.grade, Course.title
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Course ON Section.course_code = Course.course_code;
```

**Step 4 — add Instructor, then WHERE:**

```sql
SELECT Student.name, Enrollment.grade, Course.title
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Course ON Section.course_code = Course.course_code
JOIN Instructor ON Section.instructor_id = Instructor.instructor_id
WHERE Instructor.name = 'Prof. Lee';
```

Expected result shape against `full_seed.sql` (Prof. Lee teaches `CSE301` and `CSE302`):

| name | grade | title |
|---|---|---|
| Ahn Rian | B- | Database Systems |
| Choi Jian | B+ | Database Systems |
| Cho Yuri | F0 | Database Systems |
| ... | ... | ... |

(This table shows the shape of the result, a few sample rows — run the query yourself to see all of them.)

#### Line by line

| Line | What it does |
|------|-------------|
| `JOIN Student ON Enrollment.student_id = Student.student_id` | The first hop: turns an anonymous `student_id` into a readable `name`. |
| `JOIN Section ON Enrollment.section_id = Section.section_id` | `Course.title` is never reachable directly from `Enrollment` — only through `Section` in between. This is the "extra hop" a normalized schema always costs. |
| `JOIN Course ON Section.course_code = Course.course_code` | Completes the title lookup, one foreign key later. |
| `JOIN Instructor ON Section.instructor_id = Instructor.instructor_id` | The fourth table, needed only because the question asks about one specific instructor by name, not by ID. |
| `WHERE Instructor.name = 'Prof. Lee'` | Narrows the fully-joined result to one instructor, after every table needed is already present. |

### Example: Instructors Teaching Nothing This Semester

`full_seed.sql` deliberately includes instructors with zero sections, so this exact case has a real, checkable answer.

```sql
SELECT Instructor.name, COUNT(Section.section_id) AS sections_taught
FROM Instructor
LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
GROUP BY Instructor.instructor_id, Instructor.name
HAVING sections_taught = 0;
```

Expected result against `full_seed.sql`:

| name | sections_taught |
|---|---|
| Prof. Baek | 0 |
| Prof. Nam | 0 |
| Prof. Cho | 0 |
| Prof. Yang | 0 |

An `INNER JOIN` here would make all four of these instructors vanish from the result entirely — not an error, just a silently incomplete answer.

---

## Guided In-Lab Exercises

Run [`../files/lab11/full_seed.sql`](files/lab11/full_seed.sql) once (skip this if you already ran it for Lab 11 and have not reset your database since). Save every query below into **`lab12_joins.sql`**, each preceded by a comment naming which exercise it answers.

### Exercise 1: A Two-Table INNER JOIN (Part B)

Write a query listing every student's `name` and their `Enrollment.grade`, for students who are actually enrolled in something.

**Checkpoint:** confirm student `student_id = 4` ("Lee Jiwoo," enrolled in nothing) does **not** appear in this result.

### Exercise 2: The Same Question, With LEFT JOIN (Part B)

Rewrite Exercise 1 so that every student appears, even those with zero enrollments.

**Checkpoint:** confirm "Lee Jiwoo" now appears, with `grade` shown as `NULL`.

### Exercise 3: Four-Table JOIN (Part B/C)

Write a query listing every student enrolled in one of Professor Han's sections, with their grade and the course title — the same shape as this lab's four-table Worked Example, a different instructor.

### Exercise 4: GROUP BY and HAVING (Part C)

Write a query showing each `Section.section_id` and how many students are enrolled, but only for sections with more than 8 students enrolled.

**Checkpoint — predict before you run it:** would `WHERE COUNT(*) > 8` work in place of `HAVING`? Try it, read the error, and explain why in one sentence.

### Exercise 5: Instructors Teaching Nothing (Part C)

Write the query from this lab's second Worked Example yourself, from scratch, without copying it: every instructor and how many sections they teach, including instructors teaching zero sections this semester.

### Exercise 6: Final Assembly (Part C)

Combine Exercises 1–5 into one file, `lab12_joins.sql`, with a header comment per the [SQL Style Guide](../appendix/sql-style-guide.md). Run it start to finish against a freshly loaded `full_seed.sql` to confirm every query still runs cleanly.

---

## Challenge Problem

Write a query listing every pair of distinct students who are enrolled in the same section together (a self-join on `Enrollment`, joined to `Student` twice for both names), for exactly one section of your choosing. Then write a second query, using a correlated subquery (not a `JOIN`), that lists every student's `name` alongside a live count of their own enrollments.

File: `lab12_challenge.sql`

---

## Practice Problems

These are ungraded: extra practice for the concepts in this lab. Solutions are not distributed with this page.

### Practice 1: Choosing the Right JOIN

"List every Instructor, and the number of Sections they teach, including instructors teaching nothing this semester." Which JOIN type, and why?

### Practice 2: A Library Report

Write a query showing each `Member`'s name and how many books they currently have on loan, for members with at least one loan.

### Practice 3: A Self-Join on the Library Domain

`Loan(loan_id, book_isbn, member_id)` records one row per active loan. Write a query finding every pair of distinct members who currently have the same book (`book_isbn`) checked out.

### Practice 4: EXISTS on the Library Domain

Write a query listing every `Member` who has never taken out a `Loan`, using `NOT EXISTS`.

### Practice 5: RIGHT JOIN, Rewritten

Write a query using `RIGHT JOIN` to list every `Section`, including one with no enrolled students at all. Then rewrite it as an equivalent `LEFT JOIN` by swapping the table order.

### Practice 6: Subquery Filtering

Write a query using `IN` and a subquery to list every `Student` enrolled in any section taught by a specific `instructor_id`.

### Practice 7: More Than Two Enrollments

Write a query listing the `student_id` and enrollment count for every student enrolled in **more than 2** sections this semester. (This needs `GROUP BY` and a filter on an aggregate — which filter clause does that require?)

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Forgetting the `ON` condition | Every possible pairing of rows from both tables, an enormous, meaningless result | Always pair `JOIN` with `ON` (or `USING`) |
| Using `WHERE` when `HAVING` is needed | `ERROR`: invalid use of an aggregate in `WHERE`, or a confusing wrong result | Filtering an aggregate value (`COUNT(*) > 8`) always requires `HAVING`, never `WHERE` |
| Choosing `INNER JOIN` when unmatched rows need to be kept | Rows silently disappear, no error at all | If the question is "which have none," it needs `LEFT JOIN` |
| Putting an outer-join condition in `WHERE` instead of `ON` | Silently cancels the outer join's entire purpose | A condition on the *joined* table belongs in `ON`; a condition that should still exclude unmatched rows belongs in `WHERE`, deliberately |
| Expecting a scalar subquery to return more than one row | `ERROR`: Subquery returns more than 1 row | Use `IN` or `EXISTS` when more than one matching row is possible |

---

## Submission and Rubric

| Deliverable | Filename | Points |
|-------------|----------|--------|
| Exercises 1–3 correct (INNER/LEFT JOIN, multi-table) | `lab12_joins.sql` | 4 |
| Exercises 4–5 correct (GROUP BY, HAVING) | `lab12_joins.sql` | 4 |
| Style: comments per exercise, formatting per the [SQL Style Guide](../appendix/sql-style-guide.md) | `lab12_joins.sql` | 2 |

**Total: 10 points.** This lab's deliverable is also the foundation of **Assignment 2**, due this week — see [Grading Rubrics](../appendix/grading-rubric.md).

---

## Further Reading

- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th ed., Chapter 3, 5 (Joins, Aggregation)
- [SQL Style Guide](../appendix/sql-style-guide.md)
- [Case Study Reference](../appendix/case-study-reference.md)
