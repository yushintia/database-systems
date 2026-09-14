# Lab 09: DDL — Creating the Schema

| | |
|---|---|
| **Week** | 9 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Lecture & Lab |
| **Prerequisites** | Week 7 (normalized registration schema), Midterm |
| **Files provided** | [`files/lab09/reset.sql`](files/lab09/reset.sql) — empty scaffold |

**Why this lab matters:** Every week since Week 2 has been about *designing* the registration system on paper: entities, relationships, a normalized schema with every anomaly removed. None of that work has ever touched a real database. This is the first lab where you write actual SQL that MySQL executes. Every table you will ever query for the rest of this course starts here, with the five `CREATE TABLE` statements you write in this lab. Get the schema wrong now, and every later lab inherits the mistake; get it right, and Labs 10 through 12 all build cleanly on top of it.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Concept) | 50 | 5 recap Week 7/8 · 30 DDL concepts, data types, constraints, dependency order · 15 live demo (Worked Examples) |
| B (Guided practice) | 50 | 40 guided schema build, table by table, with checkpoints · 10 debrief and pitfalls |
| C (Independent and wrap) | 50 | 35 independent practice problems · 10 challenge problem · 5 submit and Week 10 preview |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Write `CREATE TABLE` statements using correct MySQL data types (`INT`, `VARCHAR(n)`, `DECIMAL(p,s)`, `DATE`, `ENUM(...)`).
2. Declare `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, and `AUTO_INCREMENT` constraints correctly.
3. Explain, and apply, why table creation order matters when foreign keys are involved.
4. Build the complete five-table registration schema in MySQL, from an empty database, in the correct dependency order.

---

## Recap

Week 7 finished with a fully normalized schema for the registration system: five relations, every foreign key justified, every anomaly gone. It had been checked, reviewed, and approved by everyone in the room.

It was also completely useless. Open MySQL right now, and there is nothing there — no `Student` table, no `Enrollment` table, nothing to insert data into and nothing to query. A design, however correct, stored only in a notebook and a set of slides, cannot answer a single real question. This lab is the fix: the exact commands that turn paper into real, running tables.

---

## Background

### DDL vs. DML: Two Different Jobs

> **In plain words: DDL**
> **Data Definition Language (DDL)** is the part of SQL that builds, changes, and removes *structure*: tables, their columns, and their constraints. `CREATE`, `ALTER`, and `DROP` are DDL. Think of DDL as pouring the concrete foundation and walls of a house, before anyone moves any furniture in.

> **In plain words: DML**
> **Data Manipulation Language (DML)** is the part of SQL that manipulates *data* inside structure that already exists: `INSERT`, `UPDATE`, `DELETE`, and `SELECT`. DML is next week's job (Lab 10 and beyond). You cannot run DML against a table DDL has not created yet — the same way you cannot move furniture into a house whose walls do not exist.

### MySQL Data Types You Need Now

| Type | Use for | Example |
|---|---|---|
| `INT` | whole numbers | `student_id INT` |
| `VARCHAR(n)` | text, up to `n` characters | `name VARCHAR(100)` |
| `DECIMAL(p,s)` | exact decimal numbers (money, GPA) | `DECIMAL(3,2)` |
| `DATE` | calendar dates | `enrollment_date DATE` |
| `ENUM(...)` | a fixed, short list of allowed values | `ENUM('A0','B+','B0')` |
| `BOOLEAN` | true/false flags | `is_active BOOLEAN` |
| `TIMESTAMP` | date and time together | `created_at TIMESTAMP` |

`VARCHAR(100)` directly maps back to Week 2's **domain** for a text attribute: "text, up to 100 characters" is the domain, spelled in SQL. `ENUM` goes one step further — it spells a domain constraint directly into the type itself. Declare a grade column as `ENUM('A0','B+','B0','C+','F')`, and MySQL rejects `'A99'` on its own, no separate rule needed.

> **In plain words: constraint**
> A **constraint** is any rule MySQL enforces on a column or table automatically, every time a row is inserted, updated, or deleted — not a rule you have to remember to check by hand. `NOT NULL`, `PRIMARY KEY`, `FOREIGN KEY`, and `UNIQUE` are all constraints.

### Keys and Constraints

| Constraint | What it enforces |
|---|---|
| `PRIMARY KEY` | uniquely identifies each row; Week 2's key concept, now enforced by MySQL |
| `FOREIGN KEY` | ties a column to another table's primary key; Week 2's referential integrity, now active |
| `NOT NULL` | this column can never be left empty |
| `UNIQUE` | no two rows may share this column's value (but it is not the primary key) |
| `AUTO_INCREMENT` | MySQL generates the next whole number automatically — no one types a key by hand |
| `DEFAULT` | fills a value automatically when none is given |

```sql
CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    major VARCHAR(100) DEFAULT 'Undeclared',
    email VARCHAR(100) UNIQUE
);
```

`AUTO_INCREMENT` is the practical fix for Week 2's warning against using a name as a primary key: no one ever types `student_id` by hand, so it can never repeat, and it never needs to be "Kim Minji" spelled three different ways.

`NOT NULL` and `DEFAULT` solve two different problems. Use `NOT NULL` when there is no sensible default (there is no reasonable default *name*). Use `DEFAULT` when a sensible fallback exists (`major DEFAULT 'Undeclared'`). Both together — `NOT NULL DEFAULT 'Undeclared'` — mean the column can never be empty, but the caller does not have to type a value every time.

### Table Creation Order: Why It Matters

A `FOREIGN KEY` can only reference a table that **already exists**. This means tables with no foreign keys must be created before any table that references them — and a table like `Enrollment`, with foreign keys to two other tables, must be created after both.

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 320" style="max-width:560px;display:block;margin:1.5em auto;">
  <title>Dependency graph for the five registration tables. Student, Course, and Instructor have no foreign keys and must be created first, in any order. Section references Course and Instructor, so it must be created after both. Enrollment references Student and Section, so it must be created last of all five.</title>
  <defs>
    <marker id="arr-lab09" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L7,3 z" fill="#0b3d66"/>
    </marker>
  </defs>
  <!-- Row 1: independent tables -->
  <rect x="20" y="20" width="150" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="95" y="53" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Student</text>

  <rect x="235" y="20" width="150" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="310" y="53" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Course</text>

  <rect x="450" y="20" width="150" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="525" y="53" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Instructor</text>

  <text x="310" y="100" font-family="sans-serif" font-size="11" fill="#555" text-anchor="middle">no foreign keys -- create these three first, any order</text>

  <!-- Row 2: Section -->
  <rect x="235" y="140" width="150" height="55" rx="8" fill="#fff8e6" stroke="#c07000" stroke-width="2"/>
  <text x="310" y="173" font-family="sans-serif" font-size="13" font-weight="bold" fill="#c07000" text-anchor="middle">Section</text>

  <line x1="310" y1="75" x2="310" y2="138" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab09)"/>
  <line x1="500" y1="75" x2="360" y2="140" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab09)"/>

  <text x="310" y="220" font-family="sans-serif" font-size="11" fill="#555" text-anchor="middle">depends on Course and Instructor</text>

  <!-- Row 3: Enrollment -->
  <rect x="235" y="255" width="150" height="55" rx="8" fill="#fdeaea" stroke="#a03030" stroke-width="2"/>
  <text x="310" y="288" font-family="sans-serif" font-size="13" font-weight="bold" fill="#a03030" text-anchor="middle">Enrollment</text>

  <line x1="95" y1="75" x2="270" y2="257" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab09)"/>
  <line x1="310" y1="195" x2="310" y2="253" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-lab09)"/>
</svg>
<p style="text-align:center;font-size:0.9em;color:#555;margin-top:-0.6em;"><em><strong>Figure 9.1.</strong> Creation order flows top to bottom: independent tables, then Section, then Enrollment last.</em></p>

> **In plain words: composite primary key**
> A **composite primary key** is a primary key made of two or more columns together, not just one. `Enrollment`'s primary key is `(student_id, section_id)`: neither column alone identifies one enrollment (a student has many enrollments, a section has many students), but the *pair* always does.

---

## Worked Examples

### Example 1: The Three Independent Tables

`Student`, `Course`, and `Instructor` have no foreign keys, so they can be created in any order, before anything that depends on them.

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

#### Line by line

| Line | What it does |
|------|-------------|
| `course_code VARCHAR(10) PRIMARY KEY` | `Course`'s primary key is a natural key — a real-world code, not a generated number. It does not need `AUTO_INCREMENT`, as long as course codes truly never repeat. |
| `title VARCHAR(150) NOT NULL` | Every course must have a title; MySQL rejects any `INSERT` that leaves it out. |
| `instructor_id INT AUTO_INCREMENT PRIMARY KEY` | MySQL generates this value itself, starting at 1, incrementing by 1 on every insert. No one ever types it by hand. |
| `name VARCHAR(100) NOT NULL` (in both `Instructor` and `Student`) | A required text fact, up to 100 characters. |
| `major VARCHAR(100)` | No `NOT NULL` here — a student's major is allowed to be unrecorded (undeclared), unlike their name. |

### Example 2: Section — the First Table With Foreign Keys

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

#### Line by line

| Line | What it does |
|------|-------------|
| `course_code VARCHAR(10) NOT NULL` | Required — every section must belong to some course. Its type (`VARCHAR(10)`) must match `Course.course_code`'s type exactly, or the `FOREIGN KEY` clause below is invalid. |
| `instructor_id INT` | No `NOT NULL` here on purpose: a section can briefly exist with no instructor assigned yet. |
| `room VARCHAR(20) NOT NULL` | Required — every section meets somewhere. |
| `FOREIGN KEY (course_code) REFERENCES Course(course_code)` | Declares that every value in `Section.course_code` must already exist in `Course.course_code`. Try to insert a section with a course code that does not exist, and MySQL rejects it. |
| `FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)` | The same rule, for the other foreign key. Both `Course` and `Instructor` must already exist as tables before this `CREATE TABLE` statement can succeed. |

### Example 3: Enrollment — Composite Key, Created Last

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

#### Line by line

| Line | What it does |
|------|-------------|
| `grade VARCHAR(2)` | Text, not a number — grades like `'A0'` and `'B+'` are values from a fixed list, not numeric quantities you would ever average directly. No `NOT NULL`: `NULL` here means "not graded yet." |
| `PRIMARY KEY (student_id, section_id)` | The composite key, on its own line. This is exactly Rule 4 of the mapping algorithm (Week 6): a many-to-many relationship becomes a table whose primary key is the combination of both sides' keys. |
| `FOREIGN KEY (student_id) REFERENCES Student(student_id)` | Requires `Student` to already exist. |
| `FOREIGN KEY (section_id) REFERENCES Section(section_id)` | Requires `Section` to already exist — which is exactly why `Enrollment` must be the *last* of all five tables created. |

### Demo: A Mistake, on Purpose

This is exactly what happens if you get the order wrong — worth seeing once, deliberately, before it happens to you by accident.

```
mysql> CREATE TABLE Section (
    ->     section_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     course_code VARCHAR(10),
    ->     instructor_id INT,
    ->     FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
    -> );
ERROR 1824 (HY000): Failed to open the referenced table 'instructor'
```

This is not a syntax mistake — the statement is written correctly. It fails because `Instructor` does not exist yet. Create `Instructor` first, then retry the exact same `Section` statement, and it succeeds:

```
mysql> CREATE TABLE Instructor ( ... );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Section ( ... );
Query OK, 0 rows affected (0.02 sec)
```

### Demo: Confirming What You Built

`DESCRIBE` and `SHOW TABLES` are MySQL's own confirmation that a statement did what you intended — not just "no error."

```
mysql> DESCRIBE Course;
+-------------+--------------+------+-----+---------+-------+
| Field       | Type         | Null | Key | Default | Extra |
+-------------+--------------+------+-----+---------+-------+
| course_code | varchar(10)  | NO   | PRI | NULL    |       |
| title       | varchar(150) | NO   |     | NULL    |       |
+-------------+--------------+------+-----+---------+-------+

mysql> SHOW TABLES;
+-------------------------+
| Tables_in_registration_db |
+-------------------------+
| Course                  |
| Enrollment               |
| Instructor               |
| Section                  |
| Student                  |
+-------------------------+
```

Five tables, in a database that had nothing five minutes ago.

---

## Guided In-Lab Exercises

Work directly against [`files/lab09/reset.sql`](files/lab09/reset.sql). It gives you an empty `registration_db` database and nothing else — every `CREATE TABLE` statement below is yours to write. If you make a mistake partway through, re-run `reset.sql` to start clean; it is idempotent, so this is always safe.

Save every statement, in the order you run them, into one file: **`lab09_create_schema.sql`**.

### Exercise 1: The Three Independent Tables (Part B)

Write `CREATE TABLE` for `Instructor` and `Course`, matching exactly:

```
Instructor(instructor_id PK auto, name required)
Course(course_code PK, title required)
```

For `Student`, match `student_id PK auto, name required` exactly, but decide `major` yourself. The registrar wants a student's major to be allowed to go unrecorded, but never stored as an empty string. Choose either `NULL`-allowed (Worked Example 1's approach) or `major VARCHAR(100) DEFAULT 'Undeclared'` (the Background's `DEFAULT` example), and add a one-line SQL comment directly above the column stating which you picked and why.

**Checkpoint:** run `SHOW TABLES;`. You should see exactly three tables. Run `DESCRIBE Course;` and confirm `course_code` shows `PRI` under `Key`.

### Exercise 2: Section (Part B)

Write `CREATE TABLE Section`, with `section_id` auto-generated, `course_code` and `room` required, `instructor_id` and `semester` optional, and foreign keys to both `Course` and `Instructor`.

**Checkpoint — predict before you run it:** if you tried this statement *before* Exercise 1's `Instructor` table existed, what would happen? Write your prediction, then it does not matter here since you already created `Instructor` first — but keep the prediction for Guided Exercise 3.

### Exercise 3: Break It on Purpose, Then Fix It (Part B)

Run `reset.sql` again to wipe your database clean. This time, write and run your `CREATE TABLE Section` statement **before** creating `Instructor` or `Course`.

**Checkpoint:** copy the exact error message MySQL gives you. Then create `Instructor` and `Course`, and re-run the same `Section` statement — confirm it now succeeds. This is the single most common first mistake in this lab; seeing the real error once, on purpose, makes it easy to recognize later.

### Exercise 4: Enrollment (Part B/C)

Write `CREATE TABLE Enrollment`, with a composite primary key `(student_id, section_id)`, a `grade` column that allows `NULL`, and foreign keys to both `Student` and `Section`.

**Checkpoint:** run `SHOW TABLES;`. You should now see all five tables. Run `SELECT * FROM Student;` — confirm it returns an empty result (zero rows, no error). That empty result is expected: this lab only builds structure, Lab 10 fills it with data.

### Exercise 5: Final Assembly (Part C)

Combine Exercises 1–4 into one clean file, `lab09_create_schema.sql`, containing all five `CREATE TABLE` statements in valid dependency order, plus a one-line header comment (see the [SQL Style Guide](../appendix/sql-style-guide.md)). Run it start to finish against a freshly reset database to confirm it works as a single script, not just as separate lines typed in order.

### Part D: Create Your Own Schema (the graded deliverable)

Take the normalized schema you produced in **Lab 07 Part 3** (your own
system, not the registration system's). Write `CREATE TABLE` for at
least 3 of its relations: correct primary keys, correct foreign keys,
and `NOT NULL` on every attribute your own requirements call required,
in valid dependency order (independent relations before anything that
references them, exactly Figure 9.1's rule applied to your own
design).

Run it against a freshly created database of your own (`CREATE
DATABASE`, any name that isn't `registration_db`) to confirm the whole
script executes cleanly, start to finish, with zero errors.

**Deliverable:** `lab09_own_schema.sql`, containing at least 3
`CREATE TABLE` statements from your own normalized design.

---

## Challenge Problem

Add two things to your schema, using `ALTER TABLE` (not by editing your original `CREATE TABLE` statements):

1. A `credit_hours INT` column on `Course`, with a `CHECK` constraint enforcing `credit_hours BETWEEN 1 AND 6`.
2. A named `UNIQUE` constraint on `Student.email` (add the column first, `VARCHAR(100)`, then the constraint).

Confirm both work: try to insert a course with `credit_hours = 12` (should fail) and two students with the same email (should fail on the second one).

File: `lab09_challenge.sql`

---

## Practice Problems

These are ungraded: extra practice for the concepts in this lab. Solutions are not distributed with this page.

### Practice 1: Library Catalog

Write `CREATE TABLE` for `Book(isbn, title)`, where `isbn` is a 13-character code and the primary key (not an auto-incrementing integer), and `title` is required text up to 200 characters.

### Practice 2: Making a Column Required After the Fact

`Section.room` was created with no constraint. Write the `ALTER TABLE` statement making it required (`NOT NULL`).

### Practice 3: A New Table From Scratch

Write `CREATE TABLE` for `Department(dept_code, dept_name)`, where `dept_code` is a short code up to 10 characters and the primary key, and `dept_name` is required text up to 100 characters.

### Practice 4: ENUM and DECIMAL Together

Write `CREATE TABLE` for `Payment(payment_id, amount, method)`, where `payment_id` auto-generates, `amount` is an exact decimal number with up to 2 digits after the decimal point, and `method` can only ever be `'cash'` or `'card'`.

### Practice 5: A Composite Key Between Two Rows of the Same Table

A course can require another course as a prerequisite. Write `CREATE TABLE` for `Prerequisite(course_code, prereq_code)`, where the two columns together form the primary key, and both are foreign keys to `Course(course_code)`.

### Practice 6: Adding a UNIQUE Column After the Fact

`Student` was created without an email column. Write the `ALTER TABLE` statement that adds an `email` column, up to 100 characters, that no two students may share.

### Practice 7: Choosing a Referential Action

`Ride.driver_id` references `Driver.driver_id` in a ride-hailing app's schema. A driver account can be deactivated and removed. Should the foreign key use `ON DELETE CASCADE`, `SET NULL`, or `RESTRICT`? Write the full column and constraint, and justify your choice in one sentence.

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Creating tables in the wrong order | `ERROR 1824 (HY000): Failed to open the referenced table '...'` | Create every table with no foreign keys first, then tables that depend on them, following the dependency graph in Figure 9.1 |
| Forgetting `NOT NULL` on a required attribute | MySQL silently allows a required fact (like a student's name) to be left empty | Add `NOT NULL` to every column that must always have a value |
| Using `VARCHAR` for a value you will never do arithmetic on, or vice versa | Grades stored as numbers cannot hold `'A0'`; a GPA stored as text cannot be averaged | `grade VARCHAR(2)` is correct — grades are values from a list, not quantities; a GPA should be `DECIMAL`, never text or `FLOAT` |
| Leaving every `FOREIGN KEY` unnamed | Error messages and later `ALTER TABLE` statements refer to an unreadable, MySQL-generated constraint name | Name every constraint explicitly (see the [SQL Style Guide](../appendix/sql-style-guide.md)): `CONSTRAINT fk_section_course FOREIGN KEY (...) ...` |
| Assuming `CHECK` is enforced on every MySQL version | A table creates without error, but invalid rows are silently accepted anyway | Confirm MySQL 8.0.16 or later; this course's practice environment enforces `CHECK` correctly |
| Typing a database or table name with different casing than you created it | Works on Windows/macOS, fails with "doesn't exist" on Linux | Always type the exact casing you used in `CREATE TABLE` — see [Troubleshooting MySQL](../appendix/troubleshooting-mysql.md) |

---

## Submission and Rubric

| Deliverable | Filename | Points |
|-------------|----------|--------|
| All 5 tables created, correct columns and types, runs cleanly against `reset.sql` | `lab09_create_schema.sql` | 3 |
| Correct constraints: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `AUTO_INCREMENT`, composite key on `Enrollment` | `lab09_create_schema.sql` | 3 |
| Correct dependency order and style (named constraints, header comment, formatting per the [SQL Style Guide](../appendix/sql-style-guide.md)) | `lab09_create_schema.sql` | 1 |
| Create your own schema (Part D) | `lab09_own_schema.sql` | 3 |

**Total: 10 points**

See the [Grading Rubrics](../appendix/grading-rubric.md) appendix for the general scoring philosophy behind this split.

---

## Further Reading

- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th ed., Chapters 3–4 (SQL DDL)
- [SQL Style Guide](../appendix/sql-style-guide.md) — naming, formatting, and constraint-naming conventions used for grading
- [Troubleshooting MySQL](../appendix/troubleshooting-mysql.md) — the exact error messages this lab's Exercise 3 previews, and more
- [Case Study Reference](../appendix/case-study-reference.md) — the full target schema this lab builds
