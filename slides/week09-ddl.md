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

The registration system's schema is done. Five relations, every
foreign key justified, every anomaly from Week 7 eliminated. It has
been checked, reviewed, and approved.

It is completely useless right now. Open MySQL, and there is nothing
there. No `Student` table. No `Enrollment` table. Nothing to insert
data into, nothing to query. A design, however correct, stored only in
a notebook and a set of slides, cannot answer a single real question.

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
<div class="card"><div class="h">Keys &amp; Constraints</div><div class="d">Declare primary keys, foreign keys, and <code>NOT NULL</code> constraints</div></div>
<div class="card"><div class="h">ALTER TABLE</div><div class="d">Use <code>ALTER TABLE</code> to change an existing table's structure</div></div>
<div class="card"><div class="h">Full Schema in MySQL</div><div class="d">Create the registration system's full schema in MySQL</div></div>
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

# MySQL Data Types, the Ones You Need Now

<div class="thread">Every attribute from Week 2 needs a concrete type before it can become a real column.</div>

| Type | Use for | Example |
|---|---|---|
| `INT` | whole numbers | `student_id` |
| `VARCHAR(n)` | text, up to n characters | `name VARCHAR(100)` |
| `DECIMAL(p,s)` | exact decimal numbers | prices, GPAs |
| `DATE` | calendar dates | enrollment date |

`VARCHAR(100)` directly maps back to Week 2's **domain** for a text
attribute: "text, up to 100 characters" is the domain, spelled in SQL.

---

# More MySQL Data Types

<div class="thread">The four from the last slide cover most of the registration schema. A few more you will meet soon.</div>

| Type | Use for | Example |
|---|---|---|
| `BOOLEAN` | true/false flags | `is_active` |
| `ENUM(...)` | a fixed, short list of values | `ENUM('A0','B+','B0','C+')` |
| `TEXT` | long, unbounded text | an essay-length comment |
| `TIMESTAMP` | date and time together | when a row was created |

<div class="why">
`ENUM` is a domain constraint spelled directly into the type itself:
declare a grade column as <code>ENUM('A0','B+','B0','C+','F')</code>,
and MySQL rejects "A99" without a separate rule, the constraint and
the type are the same statement.
</div>

---

# DEFAULT and UNIQUE

<div class="thread">Two more constraints, common enough to know before the first CREATE TABLE example.</div>

```sql
CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    major VARCHAR(100) DEFAULT 'Undeclared',
    email VARCHAR(100) UNIQUE
);
```

`DEFAULT` fills a value automatically when none is given. `UNIQUE`
enforces Week 2's key constraint on a column that is not the primary
key, no two students can share one email address.

---

# CREATE TABLE: Basic Syntax

<div class="thread">The one command that turns a relation schema into a real table.</div>

```sql
CREATE TABLE Course (
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(150) NOT NULL
);
```

`PRIMARY KEY` marks the primary key, exactly Week 2's concept, now
enforced by MySQL itself. `NOT NULL` means this column can never be
left empty, one more of Week 2's integrity constraints, made real.

---

# AUTO_INCREMENT: Keys MySQL Generates for You

<div class="thread">Week 2 already warned against using a name as a primary key. Here is the practical fix.</div>

```sql
CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    major VARCHAR(100)
);
```

`AUTO_INCREMENT` tells MySQL to generate the next integer automatically
on every insert. No one ever types a `student_id` by hand, which is
exactly why it can never repeat, and never needs to be "Kim Minji"
spelled three different ways.

---

# FOREIGN KEY: Enforcing Week 2's Referential Integrity

<div class="thread">Not just documentation. MySQL actively enforces this rule once declared.</div>

```sql
CREATE TABLE Section (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10),
    instructor_id INT,
    room VARCHAR(20),
    semester VARCHAR(20),
    FOREIGN KEY (course_code) REFERENCES Course(course_code),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);
```

Try to insert a `Section` with a `course_code` that does not exist in
`Course`, and MySQL rejects it. This is Week 2's referential integrity,
no longer a rule you have to remember to follow by hand.

---

# Composite Primary Key: Enrollment in Real MySQL

<div class="thread">Week 6 and Week 7's most important relation, finally created for real.</div>

```sql
CREATE TABLE Enrollment (
    student_id INT,
    section_id INT,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, section_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (section_id) REFERENCES Section(section_id)
);
```

`PRIMARY KEY (student_id, section_id)` on its own line declares the
composite key, exactly what Rule 4 of the mapping algorithm required.

---

# The Full Registration Schema: Independent Tables First

<div class="thread">Student and Course, already shown in full above. Instructor is the last of the three tables with no foreign keys.</div>

```sql
CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
```

<div class="why">
`Student`, `Course`, and `Instructor` all have no foreign keys, so they
can be created in any order, before anything that depends on them. All
three are shown in full across this lecture's earlier slides.
</div>

---

# The Full Registration Schema: Dependent Tables Last

<div class="thread">Section and Enrollment, already shown individually, now placed in the order they must actually run.</div>

`Section` depends on `Course` and `Instructor`, already created.
`Enrollment` depends on `Student` and `Section`. Both were written out
in full two slides ago; here is the order that makes them valid:

1. `Student`, `Course`, `Instructor` (no dependencies)
2. `Section` (depends on `Course`, `Instructor`)
3. `Enrollment` (depends on `Student`, `Section`)

Run all five in this order, and the complete registration schema
exists in MySQL, exactly as designed in Week 7.

---

# ALTER TABLE: Changing an Existing Table

<div class="thread">Requirements change after launch. ALTER is how the schema keeps up without starting over.</div>

```sql
-- add a new column
ALTER TABLE Student ADD COLUMN email VARCHAR(100);

-- change a column's type or constraint
ALTER TABLE Student MODIFY COLUMN major VARCHAR(150);

-- remove a column entirely
ALTER TABLE Student DROP COLUMN email;
```

Each of these is still DDL, structure is changing, not data.

---

# DROP TABLE: Removing Structure Entirely

<div class="thread">The most dangerous DDL command in this lecture. Handle with care.</div>

```sql
DROP TABLE Enrollment;
```

This deletes the table **and every row of data inside it**,
permanently. In a real system, this command is almost never run
directly against production data without a backup, and often requires
explicit sign-off. Today, only run it against a practice database.

---

# Demo, Step by Step: Building the Schema Live

<div class="thread">What actually happens in MySQL, one CREATE TABLE at a time, mistakes included.</div>

Five steps, watching `SHOW TABLES` grow, one mistake deliberately
included, exactly the kind Week 9's dependency-order rule prevents.

---

# Step 1: Nothing Yet

```
mysql> SHOW TABLES;
Empty set (0.00 sec)
```

The starting point of this lecture's very first pain slide, now on a
real terminal.

---

# Step 2: Create and Confirm

```
mysql> CREATE TABLE Course (
    ->     course_code VARCHAR(10) PRIMARY KEY,
    ->     title VARCHAR(150) NOT NULL
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> DESCRIBE Course;
+-------------+--------------+------+-----+
| Field       | Type         | Key  | ... |
+-------------+--------------+------+-----+
| course_code | varchar(10)  | PRI  |     |
| title       | varchar(150) |      |     |
+-------------+--------------+------+-----+
```

`DESCRIBE` is MySQL's own confirmation, not just "no error," the exact
structure just declared, echoed back.

---

# Step 3: A Mistake, on Purpose

```
mysql> CREATE TABLE Section (
    ->     section_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     course_code VARCHAR(10),
    ->     instructor_id INT,
    ->     FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
    -> );
ERROR 1824 (HY000): Failed to open the referenced table 'instructor'
```

Exactly the ordering rule from earlier in this lecture, now as a real
error message. `Instructor` does not exist yet.

---

# Step 4: Fix the Order

```
mysql> CREATE TABLE Instructor (
    ->     instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(100) NOT NULL
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Section ( ... );
Query OK, 0 rows affected (0.02 sec)
```

Same `Section` statement as Step 3, now succeeds, once its
dependency, `Instructor`, exists first.

---

# Step 5: The Finished Schema

```
mysql> SHOW TABLES;
+----------------------------+
| Tables_in_registration     |
+----------------------------+
| Course                     |
| Enrollment                 |
| Instructor                 |
| Section                    |
| Student                    |
+----------------------------+
```

Five tables, in a database that had nothing five steps ago. Every one
of them exists because of a `CREATE TABLE` statement from this lecture.

<div class="why">
<strong>Optional tool:</strong> Visual Paradigm CE can auto-generate
DDL like this from a paper design.
</div>

---

# DDL in the Wild

<div class="thread">This exact syntax family, running behind apps you already use.</div>

<div class="appgrid">
<div class="app"><div class="name">Coupang</div><div class="desc">a Products table, ENUM for order status</div></div>
<div class="app"><div class="name">토스 (Toss)</div><div class="desc">DECIMAL for every won amount, never FLOAT</div></div>
<div class="app"><div class="name">인스타그램</div><div class="desc">TIMESTAMP on every post, UNIQUE on username</div></div>
</div>

<div class="why">
Money is always <code>DECIMAL</code> in a real schema, never
<code>FLOAT</code>: floating-point rounding errors on currency are a
real, well-known class of bug. This is exactly the kind of type choice
this lecture's data type slides prepare you to make correctly.
</div>

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

# Practice: A Library System in MySQL

<div class="thread">Week 6 and 7's library example, finally as real DDL.</div>

**Question:** write `CREATE TABLE` for `Book(isbn, title)`, where
`isbn` is a 13-character code, not an auto-incrementing integer.

**Answer:**
```sql
CREATE TABLE Book (
    isbn VARCHAR(13) PRIMARY KEY,
    title VARCHAR(200) NOT NULL
);
```
A primary key does not have to be `AUTO_INCREMENT`; a naturally unique
value like an ISBN can serve directly, as long as it truly never repeats.

---

# Practice: Adding a Constraint After the Fact

<div class="thread">ALTER TABLE, applied to a real requirement change.</div>

**Question:** `Section.room` was created with no constraint. Write the
`ALTER TABLE` statement making it required (`NOT NULL`).

**Answer:**
```sql
ALTER TABLE Section MODIFY COLUMN room VARCHAR(20) NOT NULL;
```
`MODIFY COLUMN` restates the full column definition; the constraint
must be included, not just the change.

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

- DDL defines structure: `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`,
  as opposed to DML, which manipulates data inside that structure.
- `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, and `AUTO_INCREMENT` are
  MySQL's concrete enforcement of Week 2's integrity constraints.
- Table creation order matters: a table cannot reference another table
  that does not exist yet.
- **Reading:** Silberschatz et al., 7th ed., Chapter 3-4 (SQL DDL)
- **Prepare:** write out, on paper, the `CREATE TABLE` statement for
  `Enrollment` from memory before Week 10.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
