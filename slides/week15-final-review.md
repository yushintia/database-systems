---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 15: Final Exam

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: Short-review variant. Covers the entire semester, Weeks 1-14. -->

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
<div class="wk"><div class="n">Wk 11</div><div class="t">Single-table Queries</div></div>
<div class="wk"><div class="n">Wk 12</div><div class="t">Multi-table Queries</div></div>
<div class="wk review"><div class="n">Wk 13</div><div class="t">Quiz 2</div></div>
<div class="wk"><div class="n">Wk 14</div><div class="t">Case Study Presentation</div></div>
<div class="wk review now"><div class="n">Wk 15</div><div class="t">Final Exam</div></div>
</div>

---

<!-- SLOT 3: Recap -->

# The Whole Semester, One Argument

<div class="thread">Fourteen weeks, not fourteen topics. One continuous chain, start to finish.</div>

<div class="pipeline">
<div class="stage"><div class="h">Why</div><div class="s">Wk 1</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Vocabulary</div><div class="s">Wk 2</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Design</div><div class="s">Wk 3-4</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Mechanics</div><div class="s">Wk 6-7</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Build & Ask</div><div class="s">Wk 9-12</div></div>
</div>

---

<!-- _class: section -->

# Final Exam Today
<div class="driving-q">Weeks 1-14. Written, individual, closed book. Comprehensive.</div>

---

# Review: Foundations (Weeks 1-2)

- A DBMS solves seven specific failures of file-processing systems:
  redundancy, difficulty accessing data, isolation, integrity,
  atomicity, concurrency, security
- Three abstraction levels: physical, logical, view
- A **relation**: a set of tuples, no duplicates, no meaningful order,
  with superkeys, candidate keys, a primary key, and foreign keys

---

# Review: Design (Weeks 3-4)

- Three design stages: **conceptual, logical, physical**, distinct
  from Week 1's abstraction levels though they rhyme
- **E-R diagrams**: entities, attributes, relationships, and explicit
  cardinality (1:1, 1:N, M:N)
- **Weak entities** borrow identity from the entities they depend on

---

# Review: Mechanics (Weeks 6-7)

- The **mapping algorithm**: strong entity to relation, weak entity to
  relation with a composite key, 1:N to a foreign key, M:N to a new
  relation with a composite key
- **Functional dependency**, A &rarr; B: one value of A always
  determines one value of B
- **1NF, 2NF, 3NF**: no repeating groups, no partial dependency, no
  transitive dependency

---

# Review: Building It (Weeks 9-10)

- **DDL**: `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`, defines
  structure; `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `AUTO_INCREMENT`
  enforce Week 2's constraints for real
- **DML**: `INSERT`, `UPDATE`, `DELETE` manipulate data inside that
  structure; `WHERE` is required in practice on `UPDATE` and `DELETE`

---

# Review: Building It, Worked Example

<div class="thread">DDL then DML, in the order they must actually run.</div>

```sql
CREATE TABLE Course (
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(150) NOT NULL
);

INSERT INTO Course VALUES ('CSE301', 'Databases');
```

Structure first, always. `INSERT` against a table that does not exist
yet fails immediately, exactly Week 9's ordering rule, still true here.

---

# Review: Asking It Questions (Weeks 11-12)

- **Single-table queries**: `SELECT`, `FROM`, `WHERE`, `DISTINCT`,
  `ORDER BY`, `LIMIT`
- **Multi-table queries**: `INNER JOIN` keeps matched rows only,
  `LEFT JOIN` keeps every row from one side
- **Aggregation**: `GROUP BY` clusters rows, `COUNT`/`SUM`/`AVG`/`MAX`/
  `MIN` summarize each cluster, `HAVING` filters groups

---

# Review: Asking It Questions, Worked Example

<div class="thread">Every clause from Weeks 11 and 12, in one query.</div>

```sql
SELECT Instructor.name, COUNT(*) AS taught
FROM Instructor
JOIN Section ON Instructor.instructor_id = Section.instructor_id
GROUP BY Instructor.name
HAVING COUNT(*) > 1
ORDER BY taught DESC;
```

`JOIN` (Week 12), `GROUP BY` and `HAVING` (Week 12), `ORDER BY`
(Week 11), five weeks of syntax, one readable question: "which
instructors teach more than one section, busiest first?"

---

# Review: Closing the Loop (Week 14)

- A **transaction**: a sequence of operations that either fully
  completes or has no effect at all
- **ACID**: atomicity, consistency, isolation, durability, the four
  guarantees a transaction manager provides
- **Concurrency control** (locks) and **recovery** (logs) are the
  mechanisms behind isolation and durability

---

# Sample Question 1

**Question:** Trace one fact, an instructor's office room, through the
entire semester: where does it live at the conceptual stage, the
logical stage, and finally, in SQL?

**Answer:** Conceptual: an attribute of the Instructor entity.
Logical/relational: a column, `Instructor(instructor_id, name,
office)`. SQL: `ALTER TABLE Instructor ADD COLUMN office VARCHAR(20);`
followed by `UPDATE Instructor SET office = ... WHERE instructor_id =
...;`.

---

# Sample Question 2

**Question:** A table `Section(section_id, course_code, course_title,
instructor_id, room)` is proposed. Identify the normalization
violation, name the anomaly it causes, and write the corrected schema.

**Answer:** `course_title` is transitively dependent on `course_code`
(a 3NF violation), causing an update anomaly if a course is renamed.
Corrected: move `course_title` into `Course(course_code, title)`,
leaving `Section(section_id, course_code, instructor_id, room)`.

---

# Sample Question 3

**Question:** Write a single query returning each major and its
average grade point, for majors with more than 10 enrolled students.

**Answer:**

```sql
SELECT Student.major, AVG(gp.points) AS avg_gp
FROM Student
JOIN Enrollment ON Student.student_id = Enrollment.student_id
JOIN GradePoints gp ON Enrollment.grade = gp.grade
GROUP BY Student.major
HAVING COUNT(*) > 10;
```

---

# Sample Question 4

**Question:** A student asks: "why did we spend four weeks (2-4) on
paper before writing a single line of SQL?" Answer in the spine's own
terms.

**Answer:** Motivation and design must come before implementation
(this course's own stated principle). Week 9's `CREATE TABLE` needs a
normalized schema to already exist; skipping straight to SQL would
mean building on an unverified, possibly anomaly-ridden design,
exactly what Weeks 6 and 7 exist to prevent.

---

# Sample Question 5

**Question:** Which single MySQL constraint, introduced in Week 9,
enforces Week 2's referential integrity automatically?

**Answer:** `FOREIGN KEY ... REFERENCES ...`. MySQL rejects any
`INSERT` or `UPDATE` that would create a foreign key value with no
matching primary key in the referenced table.

---

# Sample Question 6

**Question:** Explain, using Week 14's vocabulary, why a `수강신청`
system needs a transaction manager and not just correct DML syntax.

**Answer:** Correct `INSERT`/`UPDATE` syntax (Weeks 9-10) says
**what** change to make; it says nothing about **isolation**, two
students racing for the last seat at the same instant. A transaction
manager's locking (Week 14) is what prevents both from succeeding.

---

# Common Final Exam Mistakes to Avoid

- **Treating each week as an island:** the exam rewards tracing one
  fact across multiple weeks (see Sample Question 1), not recalling
  isolated definitions
- **Skipping the "why" for the "what":** know why DDL precedes DML,
  why normalization precedes DDL, not only the commands themselves
- **Running out of time on early, easy recall questions:** budget time
  toward the multi-step tracing questions, they carry the most signal
  about whether the whole argument, not just one week, was understood

---

<!-- What to focus on next -->

# What to Focus On Next

<div class="limits">
This exam is comprehensive by design, the same way the semester was
one argument, not fourteen. The strongest preparation is not
memorizing definitions in isolation, it is being able to trace one
requirement, like the sample questions on the last three slides, all
the way from a real-world sentence to a working SQL query.
</div>

---

# Summary

- The Final Exam covers the entire semester: why databases exist, the
  relational model, design and notation, mapping and normalization,
  DDL, DML, queries, and a brief closing look at transactions.
- Every week's Limits slide became the next week's Pain slide; the
  whole course is one traceable argument, not independent topics.
- **Prepare:** work through the registration system one more time,
  start to finish, from Week 1's pain slide to Week 12's final query.

---

<!-- _class: end -->

# Thank You
