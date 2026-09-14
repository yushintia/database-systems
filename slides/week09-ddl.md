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

# Creation Order, as a Pipeline

<div class="thread">The same dependency rule from the last slide, read left to right instead of top to bottom.</div>

<div class="pipeline">
<div class="stage"><div class="h">Student, Course, Instructor</div><div class="s">no foreign keys, any order</div></div>
<div class="arrow">&rarr;</div>
<div class="stage"><div class="h">Section</div><div class="s">references Course, Instructor</div></div>
<div class="arrow">&rarr;</div>
<div class="stage"><div class="h">Enrollment</div><div class="s">references Student, Section</div></div>
</div>

Three tables have nothing to wait for. `Section` waits for two of
them. `Enrollment` waits for `Section`, which already waited for two
others, making it last of all five, no exceptions.

---

<!-- _class: section -->

# Constraints Beyond What We've Built

<div class="driving-q">"What exact commands turn a schema on paper into real, running tables?"</div>

<div class="thread">NOT NULL, DEFAULT, and UNIQUE cover three constraints. A few more make the registration schema enforce its own rules, not just its shape.</div>

---

# CHECK: Enforcing a Value Range

<div class="thread">Not just "is a value present," but "is this value actually valid."</div>

```sql
CREATE TABLE Course (
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    credit_hours INT CHECK (credit_hours BETWEEN 1 AND 6)
);
```

`CHECK` rejects any row where the condition evaluates false. Insert a
course with `credit_hours = 12`, and MySQL refuses it before the row
ever exists, a domain constraint from Week 2, now enforced by the
database itself instead of trusted to application code.

---

# CHECK: A MySQL Version Caveat

<div class="thread">A real-world gotcha this course's practice environment will not hide from you.</div>

<div class="pain">
Before MySQL 8.0.16, <code>CHECK</code> was accepted by the syntax
parser but silently <strong>never enforced</strong> — a table could be
created with a <code>CHECK</code> clause, and MySQL would happily
insert rows that violated it anyway. Always confirm the MySQL version
in a real deployment before relying on <code>CHECK</code> to actually
reject bad data; this course's practice environment enforces it
correctly.
</div>

---

# Naming a Constraint Explicitly

<div class="thread">An unnamed constraint still works. It just becomes unreadable the moment something needs to reference it.</div>

```sql
CREATE TABLE Section (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) NOT NULL,
    instructor_id INT,
    CONSTRAINT fk_section_course
        FOREIGN KEY (course_code) REFERENCES Course(course_code),
    CONSTRAINT fk_section_instructor
        FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);
```

Leave a constraint unnamed, and MySQL invents a name like `section_ibfk_1`.
A named constraint (`fk_section_course`) can be dropped or modified
later by that exact name, without guessing what MySQL called it.

---

# ON DELETE and ON UPDATE: What Happens When a Referenced Row Changes

<div class="thread">A foreign key says a value must exist elsewhere. It says nothing yet about what to do when that "elsewhere" row disappears or changes.</div>

Every foreign key can declare a **referential action**, telling MySQL
exactly what to do to dependent rows when the referenced row is
deleted or updated:

```sql
FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
    ON DELETE ... ON UPDATE ...
```

Four standard actions exist: `CASCADE`, `SET NULL`, `RESTRICT`, and
`NO ACTION`. Each fits a different real requirement.

---

# ON DELETE CASCADE: Worked Example

<div class="thread">Delete the parent, and its dependents disappear with it, on purpose.</div>

```sql
FOREIGN KEY (section_id) REFERENCES Section(section_id)
    ON DELETE CASCADE
```

Applied to `Enrollment.section_id`: if a `Section` is cancelled and
deleted, every `Enrollment` row for that section is deleted
automatically. This is the right choice here, an enrollment in a
section that no longer exists is not useful data to keep around.

---

# ON DELETE SET NULL: Worked Example

<div class="thread">Delete the parent, keep the dependent, just mark the link as unknown.</div>

```sql
instructor_id INT,
FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
    ON DELETE SET NULL
```

Applied to `Section.instructor_id` (requires the column to allow
`NULL`): if an `Instructor` leaves and their row is deleted, every
`Section` they taught keeps existing, only its `instructor_id` becomes
`NULL`, ready for reassignment.

---

# ON DELETE RESTRICT / NO ACTION: Worked Example

<div class="thread">The safest default: refuse the delete outright.</div>

```sql
FOREIGN KEY (course_code) REFERENCES Course(course_code)
    ON DELETE RESTRICT
```

Applied to `Section.course_code`: attempting to delete a `Course` that
still has `Section` rows referencing it is **rejected outright**, with
an error, until every dependent `Section` is removed or reassigned
first. `RESTRICT` and `NO ACTION` behave the same way in MySQL, and
`RESTRICT` is also the default when no action is specified at all.

---

# ON UPDATE CASCADE: Worked Example

<div class="thread">The same four choices apply when a key's value changes, not just when a row is deleted.</div>

```sql
FOREIGN KEY (student_id) REFERENCES Student(student_id)
    ON UPDATE CASCADE
```

Applied to `Enrollment.student_id`: if a `Student`'s `student_id` ever
had to change, every `Enrollment` row referencing that student updates
automatically, staying consistent without a separate manual `UPDATE`
statement.

---

# Choosing the Right Referential Action

<div class="thread">Applying all four actions to the registration schema's actual foreign keys, in one place.</div>

| Foreign key | Action on delete | Why |
|---|---|---|
| `Enrollment.section_id &rarr; Section` | `CASCADE` | an enrollment in a deleted section is meaningless |
| `Enrollment.student_id &rarr; Student` | `RESTRICT` | never silently erase enrollment history by deleting a student |
| `Section.instructor_id &rarr; Instructor` | `SET NULL` | keep the section, clear the assignment |
| `Section.course_code &rarr; Course` | `RESTRICT` | a course with active sections should not vanish |

There is no single "correct" action for every foreign key, each one
answers a different real question about what the data should mean.

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

Each of these is still DDL, structure is changing, not data. Adding a
new nullable column is always safe to run against a live table;
dropping or renaming one that existing code still reads is not.

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
real, well-known class of bug, exactly the kind of type choice this
lecture's data type slides prepare you to make correctly.
</div>

---

# Schema Evolution and Naming Conventions

<div class="thread">Practical habits that matter the moment a schema goes from a class exercise to a real, changing system.</div>

- **Name tables and columns consistently:** singular nouns
  (`Student`, not `Students`), `snake_case` for multi-word columns
  (`student_id`, not `StudentID`), pick one convention and never mix
  it within a schema
- **Name every foreign key column after what it references:**
  `instructor_id` referencing `Instructor.instructor_id`, not a vague
  `owner` or `ref1`
- **Prefer additive changes in production:** adding a new nullable
  column is safe to run any time; renaming or dropping a column that
  existing code still reads from is not
- **Keep every DDL change in a version-controlled migration file:** a
  running system's true schema history should be reconstructable from
  those files alone, not from memory of who ran what

---

# Worked Example: Course and Instructor

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
```

`Course`'s primary key is a natural key, a real code, not a generated
number, fine as long as course codes truly never repeat.

---

# Worked Example: Student, the Third Independent Table

<div class="thread">Same rule as Course and Instructor: no foreign keys, so no dependency to wait for.</div>

```sql
CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    major VARCHAR(100)
);
```

`major` has no `NOT NULL` on purpose: unlike a name, a student's
major is allowed to be unrecorded, a student who has not yet declared
one is still a valid row.

---

# Worked Example: Section, With Its Two Foreign Keys

<div class="thread">Section depends on the three independent tables above, both at once.</div>

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
```

`instructor_id` allows `NULL` on purpose: a section can briefly exist
with no instructor assigned yet. Both `Course` and `Instructor` must
already exist before this statement can succeed.

---

# Worked Example: Enrollment, the Composite Key, Created Last

<div class="thread">Enrollment depends on Section — so it comes last of all five.</div>

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

Both `Student` and `Section` must already exist before `Enrollment`
can be created, and `Section` itself already needed `Course` and
`Instructor` — making `Enrollment` last of all five, no exceptions.

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

# Demo, Continued: Adding a Constraint to a Live Schema

<div class="thread">The five tables already exist. One more command makes Course enforce a rule, not just hold data.</div>

```
mysql> ALTER TABLE Course
    -> ADD COLUMN credit_hours INT CHECK (credit_hours BETWEEN 1 AND 6);
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO Course VALUES ('CS999', 'Overloaded', 12);
ERROR 3819 (HY000): Check constraint 'course_chk_1' is violated.
```

The `CHECK` clause did exactly what the earlier slide claimed: reject
the invalid row before it was ever stored.

---

# Demo, Continued: A Named Referential Action After the Fact

<div class="thread">The same live schema, one column's behavior changed without touching its type or its data.</div>

```
mysql> ALTER TABLE Section
    -> ADD CONSTRAINT fk_section_instructor
    -> FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
    -> ON DELETE SET NULL;
Query OK, 5 rows affected (0.04 sec)
```

A named constraint (`fk_section_instructor`) makes it possible to
`DROP` or modify just this one referential action later, without
touching the rest of `Section`'s definition.

---

# Composite UNIQUE: One More Constraint Shape

<div class="thread">UNIQUE is not limited to a single column, the same way PRIMARY KEY is not.</div>

```sql
CREATE TABLE Section (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    room VARCHAR(20) NOT NULL,
    semester VARCHAR(20) NOT NULL,
    meeting_time VARCHAR(20) NOT NULL,
    UNIQUE (room, semester, meeting_time)
);
```

This rejects two different sections sharing the exact same room, at
the exact same time and semester, a real scheduling conflict, without
touching `section_id` at all. `UNIQUE` on a group of columns checks
the *combination*, the same way a composite primary key does.

---

# Practice: A Self-Referencing Foreign Key

<div class="thread">A foreign key does not have to point at a different table. It can point back at its own.</div>

A course can require another course as a prerequisite.

**Question:** write `CREATE TABLE Prerequisite(course_code,
prereq_code)`, where both columns together form the primary key, and
both are foreign keys to `Course(course_code)`.

**Answer:**
```sql
CREATE TABLE Prerequisite (
    course_code VARCHAR(10),
    prereq_code VARCHAR(10),
    PRIMARY KEY (course_code, prereq_code),
    FOREIGN KEY (course_code) REFERENCES Course(course_code),
    FOREIGN KEY (prereq_code) REFERENCES Course(course_code)
);
```

Both foreign keys reference the same table, `Course`, they simply
answer two different questions about the same pair of rows.

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
value like an ISBN can serve directly, as long as it truly never
repeats.

---

# Practice: Adding a Constraint After the Fact

<div class="thread">ALTER TABLE, applied to a real requirement change.</div>

**Question:** `Section.room` was created with no constraint. Write the
`ALTER TABLE` statement making it required (`NOT NULL`).

**Answer:**
```sql
ALTER TABLE Section MODIFY COLUMN room VARCHAR(20) NOT NULL;
```
`MODIFY COLUMN` restates the full column definition, the constraint
must be included, not just the change.

---

# Practice: ON DELETE Behavior for a Ride-Hailing App

<div class="thread">Choosing among the four referential actions for a new schema, not the registration one.</div>

**Question:** `Ride.driver_id` references `Driver.driver_id`. A driver
account can be deactivated and removed. Should the foreign key use
`CASCADE`, `SET NULL`, or `RESTRICT`? Justify your choice.

**Answer:** **`SET NULL`.** Deleting a driver's account should not
erase the historical record that a ride happened (`CASCADE` would
destroy trip and billing history), but the ride row still needs to
exist even once the driver reference is cleared, the same reasoning as
`Section.instructor_id` earlier.

---

# Practice: CHECK Constraint in a Library System

<div class="thread">The same CHECK pattern from Course.credit_hours, in a new domain.</div>

**Question:** `Book.copies_available` should never go negative. Write
the column definition enforcing that.

**Answer:**
```sql
copies_available INT NOT NULL CHECK (copies_available >= 0)
```
`NOT NULL` and `CHECK` are not competitors here, they enforce two
different rules: one that a value must exist, one that whatever value
exists must be valid.

---

# Choosing a Primary Key: Natural vs. Surrogate

<div class="thread">Two real choices already made earlier in this lecture, named explicitly.</div>

| | Natural key | Surrogate key |
|---|---|---|
| Example | `Course.course_code` | `Student.student_id` |
| Where it comes from | Already meaningful in the real world | Generated by MySQL, means nothing outside the database |
| Declared with | `PRIMARY KEY` directly | `AUTO_INCREMENT PRIMARY KEY` |
| Risk | Only safe if it truly never repeats or changes | Never repeats by construction, but carries no real-world meaning alone |

`Course` uses a natural key because course codes are institutionally
unique. `Student` uses a surrogate key because two students can share
a name, Week 2's original warning against a person as a key.

---

# TIMESTAMP With a Generated Default

<div class="thread">A DEFAULT value that is not a fixed constant.</div>

```sql
CREATE TABLE Enrollment (
    student_id INT,
    section_id INT,
    grade VARCHAR(2),
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id, section_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (section_id) REFERENCES Section(section_id)
);
```

`DEFAULT CURRENT_TIMESTAMP` fills `enrolled_at` with the exact moment
the row was inserted, no application code has to compute or pass that
value itself, and it can never be forgotten.

---

# Multiple Constraints, One Table: a Full Reference

<div class="thread">Every constraint from this lecture, in one realistic table, as a single slide to return to before the exam.</div>

```sql
CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    office_building VARCHAR(50),
    salary DECIMAL(10,2) CHECK (salary > 0),
    hired_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

`AUTO_INCREMENT`, `NOT NULL`, `UNIQUE`, `CHECK`, and `DEFAULT`: five
constraints, one table, working together, not against each other.

---

# Demo, Continued: Confirming What Was Built

<div class="thread">Not just "no error." A structural echo of exactly what was declared.</div>

```
mysql> SHOW CREATE TABLE Section;
Section: CREATE TABLE `Section` (
  `section_id` int NOT NULL AUTO_INCREMENT, ...
  CONSTRAINT `fk_section_instructor`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `Instructor` (`instructor_id`)
    ON DELETE SET NULL)
```

`SHOW CREATE TABLE` prints the exact statement MySQL believes defines
this table right now, constraints included.

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

# Common Mistakes, Continued

- **Leaving every foreign key at MySQL's default (`RESTRICT`) without
  thinking:** it is often the safest choice, but not always correct;
  `Section.instructor_id` needed `SET NULL` instead
- **Assuming `CHECK` works identically on every MySQL version:**
  confirm 8.0.16 or later before relying on it in a real deployment
- **Leaving every constraint unnamed:** an error message referencing
  `section_ibfk_1` is much harder to act on than one referencing
  `fk_section_instructor`
- **Renaming a live column instead of adding a new one and migrating
  gradually:** a rename breaks every piece of application code still
  written against the old name, all at once

---

# Sample Question 1

**Question:** Write the `CREATE TABLE` statement for
`Instructor(instructor_id, name)`, with `instructor_id`
auto-generated.

**Answer:**
```sql
CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
```

---

# Sample Question 2

**Question:** Why must `Course` be created before `Section`, but
`Enrollment` must be created last of all five?

**Answer:** `Section` has a foreign key to `Course`, so `Course` must
exist first. `Enrollment` has foreign keys to both `Student` and
`Section`, so both of those, and everything they depend on, must
already exist.

---

# Sample Question 3

**Question:** Why should a `grade` column use `ENUM` or `VARCHAR`,
never `DECIMAL`?

**Answer:** Grades like "A0" and "B+" are not numbers, they are values
from a fixed, known list, exactly what `ENUM` (or `VARCHAR`, if the
list might grow) represents. `DECIMAL` would reject "A0" outright.

---

# Sample Question 4

**Question:** Write the column definition for `Enrollment.grade` so it
can never be left empty.

**Answer:**
```sql
grade VARCHAR(2) NOT NULL
```

---

# Sample Question 5

**Question:** `Section.room` should never be reused by two different
sections at the same time and semester. Is this a job for `CHECK`,
`UNIQUE`, or `NOT NULL`? Which columns would it involve?

**Answer:** **`UNIQUE`**, on the combination `(room, semester,
meeting_time)` together, a composite `UNIQUE` constraint. This is
about preventing a duplicate combination, not about validating one
column's range (`CHECK`) or requiring a value be present (`NOT NULL`).

---

# Sample Question 6

**Question:** A `Course` is deleted. Its `Section` rows should be
**prevented** from being silently orphaned or deleted. Which
referential action belongs on `Section.course_code`?

**Answer:** **`RESTRICT`** (or `NO ACTION`, MySQL's default): deleting
a `Course` that still has `Section` rows referencing it should fail
outright, forcing those sections to be reassigned or removed first,
exactly like the choice already made for `Section.course_code`
earlier in this lecture.

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
- **Lab page:** [Lab 9 in the online Lab Manual](../book/labs/lab09-ddl.html), for the Guided Exercises,
  Challenge Problem, and rubric
- **Reading:** Silberschatz et al., 7th ed., Chapter 3-4 (SQL DDL)
- **Prepare:** write out, on paper, the `CREATE TABLE` statement for
  `Enrollment` from memory before Week 10.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
