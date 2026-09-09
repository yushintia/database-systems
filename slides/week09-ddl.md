---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 9: DDL

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: First real MySQL of the semester. Consider a live terminal alongside the slides if the room allows it. -->

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
<div class="wk now"><div class="n">Wk 9</div><div class="t">DDL</div></div>
<div class="wk"><div class="n">Wk 10</div><div class="t">DML</div></div>
<div class="wk"><div class="n">Wk 11</div><div class="t">Single-table Queries</div></div>
<div class="wk"><div class="n">Wk 12</div><div class="t">Multi-table Queries</div></div>
<div class="wk review"><div class="n">Wk 13</div><div class="t">Quiz 2</div></div>
<div class="wk"><div class="n">Wk 14</div><div class="t">Case Study Presentation</div></div>
<div class="wk review"><div class="n">Wk 15</div><div class="t">Final Exam</div></div>
</div>

---

<!-- SLOT 3: Recap + open wound -->

# Last Week, This Week

- **Last week delivered:** a fully normalized schema for the registration system, five relations, provably free of Week 7's anomalies
- **Last week left broken:** the schema exists only on paper. No database anywhere has these tables. There is nowhere to put a single row of data

---

<!-- SLOT 4: The pain -->

# A Perfect Design, Sitting in a Notebook

<div class="pain">

We now have a schema, fully normalized, provably free of the
anomalies that started last week. It exists on paper, in last week's
slides and your own notes. No database anywhere actually has these
tables. There is still no way to create them, or put a single row of
data in. A clean design is not the same as a running system.

</div>

<!-- notes: Ask the class: what is the very first command needed before anything else works? Let them arrive at CREATE TABLE themselves. -->

---

# What Else This Actually Costs

- A team can spend weeks perfecting a design and deliver nothing
  runnable, if nobody translates it into an actual database
- Every day a real system runs on an informal, undocumented structure
  instead of an explicit schema is a day closer to Week 1's chaos
  quietly creeping back in
- Getting `CREATE TABLE` statements wrong, wrong data types, missing
  constraints, is expensive to fix once real data already exists

<div class="why">
<strong>In industry:</strong> writing correct DDL, and reading someone
else's, is a daily task for backend and data engineers. Database
migration files, which almost every production system has, are just
DDL, version-controlled and applied over time.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What exact commands turn a schema on paper into real, running tables?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

<div class="cardlist">
<div class="card"><div class="h">CREATE TABLE</div><div class="d">Write <code>CREATE TABLE</code> statements with correct MySQL data types</div></div>
<div class="card"><div class="h">Keys &amp; Constraints</div><div class="d">Declare <code>PRIMARY KEY</code>, <code>FOREIGN KEY</code>, <code>NOT NULL</code>, <code>UNIQUE</code>, and <code>AUTO_INCREMENT</code> correctly</div></div>
<div class="card"><div class="h">Creation Order</div><div class="d">Explain, and apply, why table creation order matters when foreign keys are involved</div></div>
<div class="card"><div class="h">Full Schema in MySQL</div><div class="d">Build the complete five-table registration schema, in the correct dependency order</div></div>
</div>

---

<!-- SLOT 8: Origin -->

# Where DDL Came From

<div class="thread">Same 1974 moment from Week 1's timeline, one detail deeper.</div>

- SQL, born from IBM's System R project (Week 1), split its commands
  into two families from the start: commands that define structure, and
  commands that manipulate data inside that structure
- **Data Definition Language (DDL)** is the first family. It exists
  because Week 6 and Week 7's paper schema needs *some* concrete syntax
  a real system can execute, and SQL's designers standardized one

---

<!-- SLOT 9: Core concept -->

# DDL: Definition

<div class="thread">One term, covering every command that shapes structure rather than data.</div>

> **Data Definition Language (DDL)** is the subset of SQL used to
> define, alter, and remove the structure of database objects: tables,
> their columns, and their constraints.

`CREATE`, `ALTER`, and `DROP` are DDL. `INSERT`, `UPDATE`, `DELETE`, and
`SELECT` are not, they are next week's subject, DML.

---

<!-- Act 3 / BUILD -->

# MySQL Data Types You Need Now

<div class="thread">Every attribute from Week 2 needs a concrete type before it can become a real column.</div>

| Type | Use for | Example |
|---|---|---|
| `INT` | whole numbers | `student_id INT` |
| `VARCHAR(n)` | text, up to `n` characters | `name VARCHAR(100)` |
| `DECIMAL(p,s)` | exact decimal numbers (money, GPA) | `DECIMAL(3,2)` |
| `DATE` | calendar dates | `enrollment_date DATE` |
| `ENUM(...)` | a fixed, short list of allowed values | `ENUM('A0','B+','B0')` |
| `BOOLEAN` | true/false flags | `is_active BOOLEAN` |
| `TIMESTAMP` | date and time together | `created_at TIMESTAMP` |

<div class="why">
<code>VARCHAR(100)</code> is Week 2's <strong>domain</strong> for a text
attribute, spelled in SQL. <code>ENUM</code> goes one step further:
declare a grade column as <code>ENUM('A0','B+','B0','C+','F')</code>,
and MySQL rejects <code>'A99'</code> on its own, no separate rule needed.
</div>

---

# Keys and Constraints

<div class="thread">A constraint is a rule MySQL enforces automatically, not a rule you have to remember to check by hand.</div>

> **Constraint:** any rule MySQL enforces on a column or table
> automatically, every time a row is inserted, updated, or deleted.

| Constraint | What it enforces |
|---|---|
| `PRIMARY KEY` | uniquely identifies each row; Week 2's key concept, now enforced |
| `FOREIGN KEY` | ties a column to another table's primary key; Week 2's referential integrity, now active |
| `NOT NULL` | this column can never be left empty |
| `UNIQUE` | no two rows may share this column's value (but it is not the primary key) |
| `AUTO_INCREMENT` | MySQL generates the next whole number automatically |
| `DEFAULT` | fills a value automatically when none is given |

---

# CREATE TABLE: Putting the Pieces Together

<div class="thread">Five of the six constraints from the last slide, in one real table.</div>

```sql
CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    major VARCHAR(100) DEFAULT 'Undeclared',
    email VARCHAR(100) UNIQUE
);
```

`AUTO_INCREMENT` is the practical fix for Week 2's warning against
using a name as a primary key: no one ever types `student_id` by hand,
so it can never repeat. `DEFAULT 'Undeclared'` fills `major`
automatically when it's left out; `UNIQUE` means no two students can
share an email address.

---

# NOT NULL vs DEFAULT: When to Use Which

<div class="thread">Two constraints that look similar and solve different problems.</div>

- **`NOT NULL`** says: this fact must be provided, with no fallback.
  Use it when there is no sensible default (`Student.name`: there is
  no reasonable default name)
- **`DEFAULT`** says: if no value is given, use this one instead of
  leaving it empty. Use it when a sensible default exists
  (`Student.major DEFAULT 'Undeclared'`)
- **Both together** are common: `NOT NULL DEFAULT 'Undeclared'` means
  the column can never be empty, but the caller does not have to type
  a value every time

---

# Table Creation Order: Why It Matters

<div class="thread">A FOREIGN KEY can only reference a table that already exists.</div>

Tables with no foreign keys must be created before any table that
references them. A table like `Enrollment`, with foreign keys to two
other tables, must be created after both.

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 320" style="max-width:460px;display:block;margin:0.8em auto;">
  <title>Dependency graph for the five registration tables. Student, Course, and Instructor have no foreign keys and must be created first, in any order. Section references Course and Instructor, so it must be created after both. Enrollment references Student and Section, so it must be created last of all five.</title>
  <defs>
    <marker id="arr-lab09" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L7,3 z" fill="#0b3d66"/>
    </marker>
  </defs>
  <rect x="20" y="20" width="150" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="95" y="53" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Student</text>
  <rect x="235" y="20" width="150" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="310" y="53" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Course</text>
  <rect x="450" y="20" width="150" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="525" y="53" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Instructor</text>
  <text x="310" y="100" font-family="sans-serif" font-size="11" fill="#555" text-anchor="middle">no foreign keys -- create these three first, any order</text>
  <rect x="235" y="140" width="150" height="55" rx="8" fill="#fff8e6" stroke="#c07000" stroke-width="2"/>
  <text x="310" y="173" font-family="sans-serif" font-size="13" font-weight="bold" fill="#c07000" text-anchor="middle">Section</text>
  <line x1="310" y1="75" x2="310" y2="138" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab09)"/>
  <line x1="500" y1="75" x2="360" y2="140" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab09)"/>
  <text x="310" y="220" font-family="sans-serif" font-size="11" fill="#555" text-anchor="middle">depends on Course and Instructor</text>
  <rect x="235" y="255" width="150" height="55" rx="8" fill="#fdeaea" stroke="#a03030" stroke-width="2"/>
  <text x="310" y="288" font-family="sans-serif" font-size="13" font-weight="bold" fill="#a03030" text-anchor="middle">Enrollment</text>
  <line x1="95" y1="75" x2="270" y2="257" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab09)"/>
  <line x1="310" y1="195" x2="310" y2="253" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab09)"/>
</svg>

---

# Composite Primary Key

<div class="thread">Enrollment's key needs two columns, not one.</div>

> **Composite primary key:** a primary key made of two or more columns
> together, not just one.

`Enrollment`'s primary key is `(student_id, section_id)`: neither
column alone identifies one enrollment (a student has many
enrollments, a section has many students), but the *pair* always does.
This is exactly Rule 4 of the mapping algorithm from Week 6.

---

# Worked Example: The Three Independent Tables

<div class="thread">Student, Course, and Instructor have no foreign keys — create them first, in any order.</div>

```sql
CREATE TABLE Course (
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(150) NOT NULL
);

CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    major VARCHAR(100)
);
```

`Course`'s primary key is a natural key, a real code, not a generated
number, fine as long as course codes truly never repeat. `major` has
no `NOT NULL` on purpose: unlike a name, a student's major is allowed
to be unrecorded.

---

# Worked Example: Foreign Keys, Then the Composite Key

<div class="thread">Section depends on the three tables above. Enrollment depends on Section — so it comes last of all five.</div>

```sql
CREATE TABLE Section (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) NOT NULL,
    instructor_id INT,
    room VARCHAR(20) NOT NULL,
    semester VARCHAR(20),
    FOREIGN KEY (course_code) REFERENCES Course(course_code),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

CREATE TABLE Enrollment (
    student_id INT,
    section_id INT,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, section_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (section_id) REFERENCES Section(section_id)
);
```

`instructor_id` allows `NULL` on purpose: a section can briefly exist
with no instructor assigned yet. Both `Course` and `Instructor` must
already exist before `Section` can be created; both `Student` and
`Section` must already exist before `Enrollment` can.

---

# Demo: A Mistake, on Purpose

<div class="thread">Worth seeing once, deliberately, before it happens to you by accident.</div>

```
mysql> CREATE TABLE Section (
    ->     section_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     instructor_id INT,
    ->     FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
    -> );
ERROR 1824 (HY000): Failed to open the referenced table 'instructor'
```

Not a syntax mistake, the statement is written correctly. It fails
because `Instructor` does not exist yet. Create `Instructor` first, and
the exact same `Section` statement succeeds. `DESCRIBE Course;` and
`SHOW TABLES;` afterward are MySQL's own confirmation that a statement
did what you intended, not just "no error."

---

# Common Mistakes

- **Creating tables in the wrong order:** a `FOREIGN KEY` referencing a
  table that does not exist yet fails immediately
- **Forgetting `NOT NULL` on required attributes:** without it, MySQL
  silently allows a required fact, like a student's name, to be empty
- **Using `VARCHAR` for numbers you will do math on:** `grade
  VARCHAR(2)` is correct here because grades like "A0" are not numeric;
  a GPA average should be `DECIMAL`, not text

---

# Check Yourself

1. Write the `CREATE TABLE` statement for `Instructor(instructor_id,
   name)`, with `instructor_id` auto-generated.
2. Why must `Course` be created before `Section`, but `Enrollment`
   must be created last of all five?
3. Why should a `grade` column use `ENUM` or `VARCHAR`, never `DECIMAL`?

---

# Answers

1. ```sql
   CREATE TABLE Instructor (
       instructor_id INT AUTO_INCREMENT PRIMARY KEY,
       name VARCHAR(100) NOT NULL
   );
   ```
2. `Section` has a foreign key to `Course`, so `Course` must exist
   first. `Enrollment` has foreign keys to both `Student` and
   `Section`, so both of those, and everything they depend on, must
   already exist.
3. Grades like "A0" and "B+" are not numbers, they are values from a
   fixed, known list, exactly what `ENUM` (or `VARCHAR`, if the list
   might grow) represents. `DECIMAL` would reject "A0" outright.

---

<!-- SLOT 14: Limits, becomes Week 10 slot 4 -->

# What Structure Alone Cannot Do

<div class="limits">
Every table in the registration schema now exists in MySQL, for real,
with every constraint from Weeks 2 through 7 enforced automatically.
Run <code>SELECT * FROM Student;</code> right now, and the answer is
an empty result. Zero rows. The structure is perfect and completely
empty. Structure exists, but there is still no data to ask a single
real question about.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 9 leaves **tables with no data in them** unsolved. **Week 10,
DML**, addresses it: `INSERT`, `UPDATE`, and `DELETE`, the commands
that actually put data in, change it, and remove it.

---

<!-- SLOT 16: Summary -->

# Summary

- DDL defines structure: `CREATE`, `ALTER`, and `DROP` all belong to
  this family, as opposed to DML, which manipulates data inside that
  structure (next week).
- `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, `AUTO_INCREMENT`,
  and `DEFAULT` are MySQL's concrete enforcement of Week 2's integrity
  constraints.
- Table creation order matters: independent tables first, then
  `Section`, then `Enrollment` last of all five.
- **Lab page:** `book/src/labs/lab09-ddl.md`, for the Guided Exercises,
  Challenge Problem, and rubric
- **Reading:** Silberschatz et al., 7th ed., Chapter 3-4 (SQL DDL)
- **Prepare:** write out, on paper, the `CREATE TABLE` statement for
  `Enrollment` from memory before Week 10.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
