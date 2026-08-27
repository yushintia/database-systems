# Week 12 Handout: Multi-table Queries

Database Systems (511783-001) — for students to keep and read again.
Use plain, simple English on purpose, so it is easy to read even if
English is not your first language.

**Assignment 2 is due this week.** It asks you to write multi-table
queries and aggregation against the registration schema — everything
in this handout is exactly the material you need for it.

---

## 1. Glossary: Key Words This Week

Read each definition once now. You do not need to memorize them today —
you will use them all semester.

| Term | Plain definition |
|---|---|
| **JOIN** | A single operation that combines rows from two tables into one result, based on a matching condition, usually a foreign key matching a primary key |
| **INNER JOIN** | The default kind of JOIN. Returns only rows where a match exists on **both** sides. A row with no match on the other side disappears entirely |
| **LEFT JOIN** | A JOIN that keeps **every** row from the left (first-named) table, even when no match exists on the other side, filling the missing columns with `NULL` |
| **ON clause** | The part of a JOIN that states the matching condition, for example `ON Student.student_id = Enrollment.student_id` |
| **USING clause** | A shorter way to write `ON`, only valid when the matching column has the exact same name on both sides, e.g. `USING (student_id)` |
| **Foreign key** | A column in one table that refers to the primary key of another table. This is what a JOIN's `ON` condition usually matches on |
| **NULL** | The placeholder value that appears in a `LEFT JOIN` result when a row on the right side has no match |
| **GROUP BY** | Clusters rows that share the same value in one or more columns into groups, so an aggregate function can summarize each group separately |
| **Aggregate function** | A function that takes many rows in and returns one number out, per group. `COUNT`, `SUM`, `AVG`, `MAX`, `MIN` are the five covered this week |
| **COUNT(\*)** | An aggregate function that returns the number of rows in a group |
| **SUM(col)** | An aggregate function that returns the total of a numeric column, added up across a group |
| **AVG(col)** | An aggregate function that returns the average of a numeric column, across a group |
| **HAVING** | Filters entire groups, **after** grouping and aggregation have already happened. Needed whenever the filter condition uses an aggregate, like `COUNT(*) > 30` |
| **WHERE** | Filters individual rows, **before** any grouping happens. Cannot filter on an aggregate value — that is what `HAVING` is for |
| **Column alias (AS)** | A temporary name given to a computed column in the result, for example `COUNT(*) AS enrolled` |
| **Normalization** | Week 7's technique of splitting data into separate tables to remove redundancy. It is the direct reason JOINs are necessary now: no single table has the whole picture anymore |

---

## 2. University Course Registration System, Worked Out Step by Step

This is the full version of the story from class. Read it slowly if the
in-class pace felt fast.

**The situation.** The registrar sends an email: "list every student in
Professor Lee's sections, with their grade, and the course title."
Simple to ask. But `Enrollment` has the grade and the student ID.
`Section` has the room and the instructor ID. `Instructor` has the
name. `Course` has the title. Not one of these four tables, alone, has
enough information to answer the question. Normalization, Week 7's
entire achievement, put each fact exactly once — which also means no
single table has the whole picture anymore. The fix for redundancy is
exactly what makes JOINs necessary at all.

The schema, as a reminder, from `_shared/case-study.md`:

```
Student(student_id PK, name, major)
Course(course_code PK, title)
Instructor(instructor_id PK, name)
Section(section_id PK, course_code FK, instructor_id FK, room, semester)
Enrollment(student_id FK, section_id FK, grade, PRIMARY KEY(student_id, section_id))
```

We build the answer one `JOIN` at a time, not handed over finished.

**Step 1: Start at Enrollment.**

```sql
SELECT * FROM Enrollment;
```

This gives `student_id`, `section_id`, `grade`. Everything the question
needs is one hop away from here, but there are no names and no titles
yet — just IDs.

**Step 2: Add Student.**

```sql
SELECT Student.name, Enrollment.grade
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id;
```

A name appears. `grade` was already here; `Student.name` just arrived
through the first foreign key, matched by the `ON` condition.

**Step 3: Add Section, then Course.**

```sql
SELECT Student.name, Enrollment.grade, Course.title
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Course ON Section.course_code = Course.course_code;
```

Two more joins, chained: `Enrollment` to `Section`, then `Section` to
`Course`. `Course.title` was never reachable directly from
`Enrollment` — only through `Section` in between.

**Step 4: Add Instructor, then WHERE.**

```sql
SELECT Student.name, Enrollment.grade, Course.title
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Course ON Section.course_code = Course.course_code
JOIN Instructor ON Section.instructor_id = Instructor.instructor_id
WHERE Instructor.name = 'Prof. Lee';
```

Four `JOIN` clauses, one per foreign key relationship, then a `WHERE`
narrowing the result to one instructor. Every step was one small,
checkable addition. The finished query is just all four steps,
stacked.

**One more decision worth naming: INNER JOIN or LEFT JOIN?** The query
above uses plain `JOIN`, which means `INNER JOIN`: only rows where a
match exists on both sides survive. That is correct here, because the
registrar only wants students who are actually enrolled in one of
Professor Lee's sections. If the question had instead been "list every
student, and their grade if they have one," the query would need
`LEFT JOIN FROM Student`, so that students with zero enrollments still
appear, with `NULL` in place of a grade.

**What we still can't say yet.** Every query in this handout returns
the right answer, joined correctly, grouped correctly. But nothing
covered so far says what happens if two people run conflicting updates
on `Enrollment` at the same instant, or a query runs against a table
with ten million rows instead of a few hundred, or the server crashes
mid-query. Correct answers, on a small, quiet, single-user system, are
not the same problem as correct answers at real scale, under real
concurrency, with real failures. That gap stays open until later in
the course.

---

## 3. Optional Reading: Extra Detail (Not Required, Not on the Quiz)

This section holds extra explanations that were trimmed from the slides
to keep class time short. Read it if you are curious or want more
examples.

**Where JOIN actually came from.** It is not a workaround bolted onto
SQL later. Codd's original 1970 relational model already included an
operation for combining two relations based on matching values, as
part of what he called relational algebra. SQL's `JOIN` keyword is
that operation, made writable. It exists because normalization was
always meant to be paired with a way to reassemble the pieces, not
just split them apart.

**Why this matters in industry.** `JOIN` and `GROUP BY` are the two SQL
features that separate "can write a simple query" from "can build a
real report." Nearly every analytics dashboard is a `JOIN` plus a
`GROUP BY` underneath its charts. A few concrete examples:

- **"Top sellers this month"** on a store dashboard: `JOIN Order` to
  `Product`, `GROUP BY product`, `ORDER BY SUM(quantity)`
- **Netflix "Continue Watching" row:** `JOIN Profile` to
  `WatchHistory`, `WHERE progress < 100%`
- **Bank statement summary:** `GROUP BY category`, `SUM(amount)` per
  category

**Who actually writes this, as a job.**

- **Backend engineers** write JOIN and GROUP BY queries constantly, any
  time an API endpoint needs data assembled from more than one table
- **Data analysts and BI developers** build entire dashboards out of
  queries that are, underneath, a JOIN plus a GROUP BY
- **Database administrators (DBAs)** watch for JOINs with a missing or
  wrong `ON` condition, because those are a common cause of a database
  server suddenly running slow
- **Data engineers** build the pipelines that pre-join and pre-aggregate
  huge tables overnight, so a dashboard's live query stays fast

---

## 4. Practice Problems (With Answers)

Try each problem yourself before checking the answer underneath it. All
problems use the registration schema from Section 2 unless stated
otherwise.

**Problem 1.** Write a query listing every student's name and their
enrollment grade, for students who are actually enrolled in something.

> **Answer:**
> ```sql
> SELECT Student.name, Enrollment.grade
> FROM Student
> JOIN Enrollment ON Student.student_id = Enrollment.student_id;
> ```
> Plain `JOIN` (the same as `INNER JOIN`) is correct here, since the
> question only asks about students who are enrolled.

**Problem 2.** Write a query listing every student's name and their
enrollment grade, including students with zero enrollments.

> **Answer:**
> ```sql
> SELECT Student.name, Enrollment.grade
> FROM Student
> LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id;
> ```
> `LEFT JOIN` from `Student` keeps every student row, filling `grade`
> with `NULL` where no matching enrollment exists.

**Problem 3.** Write a query listing every student in Professor Kim's
sections, with their grade and the course title. (Same shape as the
worked example in Section 2, different instructor.)

> **Answer:**
> ```sql
> SELECT Student.name, Enrollment.grade, Course.title
> FROM Enrollment
> JOIN Student ON Enrollment.student_id = Student.student_id
> JOIN Section ON Enrollment.section_id = Section.section_id
> JOIN Course ON Section.course_code = Course.course_code
> JOIN Instructor ON Section.instructor_id = Instructor.instructor_id
> WHERE Instructor.name = 'Prof. Kim';
> ```

**Problem 4.** Write a query showing how many students are enrolled in
each major.

> **Answer:**
> ```sql
> SELECT major, COUNT(*) AS student_count
> FROM Student
> GROUP BY major;
> ```
> One row per distinct `major`, each with a count, instead of one row
> per student.

**Problem 5.** Write a query showing each `Section`'s `section_id` and
how many students are enrolled, but only for sections with more than
30 students enrolled.

> **Answer:**
> ```sql
> SELECT Section.section_id, COUNT(*) AS enrolled
> FROM Enrollment
> GROUP BY Section.section_id
> HAVING COUNT(*) > 30;
> ```
> `WHERE enrolled > 30` would be invalid here — `enrolled` does not
> exist as a value until grouping and aggregation have already
> happened, so the filter must be `HAVING`.

**Problem 6.** (From the library example in class.) Write a query
showing each `Member`'s name and how many books they currently have on
loan, for members with at least one loan.

> **Answer:**
> ```sql
> SELECT Member.name, COUNT(*) AS books_out
> FROM Member
> JOIN Loan USING (member_id)
> GROUP BY Member.name;
> ```
> `INNER JOIN` (the default) already excludes members with zero loans,
> so no `HAVING` clause is needed for "at least one."
