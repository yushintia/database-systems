# Week 9 Handout: DDL

Database Systems (511783-001) — for students to keep and read again.
Use plain, simple English on purpose, so it is easy to read even if
English is not your first language.

---

## 1. Glossary: Key Words This Week

Read each definition once now. You do not need to memorize them today —
you will use them all semester.

| Term | Plain definition |
|---|---|
| **DDL (Data Definition Language)** | The part of SQL that defines, changes, and removes structure: tables, columns, and constraints |
| **DML (Data Manipulation Language)** | The part of SQL that manipulates data inside structure: `INSERT`, `UPDATE`, `DELETE`, `SELECT`. Not this week's topic |
| **CREATE TABLE** | The DDL command that builds a brand-new table in the database |
| **ALTER TABLE** | The DDL command that changes an existing table's structure, without deleting it |
| **DROP TABLE** | The DDL command that deletes a table and every row inside it, permanently |
| **DESCRIBE** | A MySQL command that shows a table's current structure: every column, type, and key |
| **Data type** | The kind of value a column is allowed to hold, such as a number, text, or date |
| **`INT`** | A MySQL data type for whole numbers, like `student_id` |
| **`VARCHAR(n)`** | A MySQL data type for text, up to `n` characters long |
| **`DECIMAL(p,s)`** | A MySQL data type for exact decimal numbers, used for money, never `FLOAT` |
| **`ENUM(...)`** | A MySQL data type that only accepts values from a fixed, short list you declare |
| **`NOT NULL`** | A constraint meaning this column can never be left empty |
| **`PRIMARY KEY`** | A constraint marking the column (or columns) that uniquely identify each row |
| **`FOREIGN KEY`** | A constraint that ties a column to another table's primary key, and MySQL enforces it |
| **`AUTO_INCREMENT`** | Tells MySQL to generate the next whole number automatically, so no one types a key by hand |
| **Constraint** | Any rule MySQL enforces on a column or table, like `NOT NULL`, `PRIMARY KEY`, or `UNIQUE` |
| **Composite primary key** | A primary key made of two or more columns together, not just one |
| **Schema deployment** | Turning a paper design into real, running tables in a database, using DDL |

---

## 2. The Registration Schema, Worked Out Step by Step

This is the full version of the story from class. Read it slowly if the
in-class pace felt fast.

**The situation.** Week 7 finished with a fully normalized schema for
the registration system: five relations, every foreign key justified,
every anomaly gone. It had been checked, reviewed, and approved. It
was also completely useless. Open MySQL, and there is nothing there.
No `Student` table. No `Enrollment` table. A design, however correct,
stored only in a notebook and a set of slides, cannot answer a single
real question. The only way out is to type the exact commands that
turn paper into real, running tables.

**Step 1: Create the first table, with nothing to depend on.**
`Course` has no foreign keys, so it can be created first, in an empty
database:

```sql
mysql> CREATE TABLE Course (
    ->     course_code VARCHAR(10) PRIMARY KEY,
    ->     title VARCHAR(150) NOT NULL
    -> );
Query OK, 0 rows affected (0.02 sec)
```

`PRIMARY KEY` marks the primary key, exactly Week 2's concept, now
enforced by MySQL itself. `NOT NULL` means `title` can never be left
empty.

**Step 2: Confirm the structure, not just "no error."** `DESCRIBE`
echoes back exactly what was just declared:

```sql
mysql> DESCRIBE Course;
+-------------+--------------+------+-----+
| Field       | Type         | Key  | ... |
+-------------+--------------+------+-----+
| course_code | varchar(10)  | PRI  |     |
| title       | varchar(150) |      |     |
+-------------+--------------+------+-----+
```

**Step 3: Hit a real error, on purpose.** Next, try `Section`, which
has a foreign key to `Instructor`. But `Instructor` has not been
created yet:

```sql
mysql> CREATE TABLE Section (
    ->     section_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     course_code VARCHAR(10),
    ->     instructor_id INT,
    ->     room VARCHAR(20),
    ->     semester VARCHAR(20),
    ->     FOREIGN KEY (course_code) REFERENCES Course(course_code),
    ->     FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
    -> );
ERROR 1824 (HY000): Failed to open the referenced table 'instructor'
```

This is not a syntax mistake. It is the ordering rule from class, now
as a real error message: a table cannot reference another table that
does not exist yet.

**Step 4: Fix the order.** Create `Instructor` first, since it has no
foreign keys of its own, then retry `Section`:

```sql
mysql> CREATE TABLE Instructor (
    ->     instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(100) NOT NULL
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Section ( ... );
Query OK, 0 rows affected (0.02 sec)
```

Same `Section` statement as Step 3. It succeeds this time, because its
dependency, `Instructor`, now exists.

**Step 5: Finish with `Student` and `Enrollment`.** `Student` has no
foreign keys, so it could have been created any time before `Section`:

```sql
mysql> CREATE TABLE Student (
    ->     student_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(100) NOT NULL,
    ->     major VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.01 sec)
```

`Enrollment` must come last of all five, because it has foreign keys
to both `Student` and `Section`:

```sql
mysql> CREATE TABLE Enrollment (
    ->     student_id INT,
    ->     section_id INT,
    ->     grade VARCHAR(2),
    ->     PRIMARY KEY (student_id, section_id),
    ->     FOREIGN KEY (student_id) REFERENCES Student(student_id),
    ->     FOREIGN KEY (section_id) REFERENCES Section(section_id)
    -> );
Query OK, 0 rows affected (0.02 sec)

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

`PRIMARY KEY (student_id, section_id)` on its own line declares the
composite key that Rule 4 of the mapping algorithm (Week 6) required.

**What we can, and cannot, say yet.** We *can* now say, correctly:
every table in the registration schema exists in MySQL, for real, with
every constraint from Weeks 2 through 7 enforced automatically. We
*cannot* yet say what is inside any of them. Run
`SELECT * FROM Student;` right now, and the answer is an empty result,
zero rows. The structure is perfect and completely empty. Structure
exists, but there is still no data to ask a single real question
about. That is Week 10's job.

---

## 3. Optional Reading: Extra Detail (Not Required, Not on the Quiz)

This section holds extra explanations that were trimmed from the
slides to keep class time short. Read it if you are curious or want
more examples.

**Schema migrations, in a little more detail.** Almost every real
production system keeps its `CREATE TABLE` and `ALTER TABLE`
statements in files, version-controlled just like source code. These
files are called migrations, and they are applied to the database in
order, one after another, so a team can track exactly how a schema
grew over time and roll changes back if something goes wrong. What
this week calls DDL is exactly what a migration file contains.

**Getting a data type wrong is expensive to fix later.** Once a table
already holds real rows, changing its structure with `ALTER TABLE` is
riskier and slower than getting it right the first time with
`CREATE TABLE`. A column declared too small, or with the wrong type,
can mean rewriting every existing row, or losing data outright.

**Optional tool: Visual Paradigm CE.** Some design tools can
auto-generate DDL like the statements in this handout directly from a
paper E-R diagram or relational schema. This does not remove the need
to understand the SQL it produces, you still need to read it, check
it, and fix it when it is wrong, but it is worth knowing such tools
exist.

**Money is always `DECIMAL`, never `FLOAT`.** Real schemas behind apps
like Coupang or Toss store every won or dollar amount as `DECIMAL`.
Floating-point numbers round in ways that can silently gain or lose
tiny fractions of currency, a well-known, real class of bug. This is
exactly the kind of type choice this week's data type slides prepare
you to make correctly.

**Who actually writes DDL, as a job.**

- **Backend developers** write and review `CREATE TABLE` and
  `ALTER TABLE` statements every time an application's data needs
  change.
- **Database administrators (DBAs)** review DDL before it runs against
  production data, plan safe migrations, and decide who is allowed to
  run `DROP TABLE` at all.

---

## 4. Practice Problems (With Answers)

Try each problem yourself before checking the answer underneath it.
All problems use only syntax covered in this week's lecture.

**Problem 1.** Write `CREATE TABLE` for `Book(isbn, title)`, where
`isbn` is a 13-character code, not an auto-incrementing integer.

> **Answer:**
> ```sql
> CREATE TABLE Book (
>     isbn VARCHAR(13) PRIMARY KEY,
>     title VARCHAR(200) NOT NULL
> );
> ```
> A primary key does not have to be `AUTO_INCREMENT`; a naturally
> unique value like an ISBN can serve directly, as long as it truly
> never repeats.

**Problem 2.** `Section.room` was created with no constraint. Write
the `ALTER TABLE` statement making it required (`NOT NULL`).

> **Answer:**
> ```sql
> ALTER TABLE Section MODIFY COLUMN room VARCHAR(20) NOT NULL;
> ```
> `MODIFY COLUMN` restates the full column definition; the constraint
> must be included, not just the change.

**Problem 3.** Write `CREATE TABLE` for `Department(dept_code,
dept_name)`, where `dept_code` is a short code up to 10 characters and
the primary key, and `dept_name` is required text up to 100
characters.

> **Answer:**
> ```sql
> CREATE TABLE Department (
>     dept_code VARCHAR(10) PRIMARY KEY,
>     dept_name VARCHAR(100) NOT NULL
> );
> ```

**Problem 4.** Write `CREATE TABLE` for `Payment(payment_id, amount,
method)`, where `payment_id` auto-generates, `amount` is an exact
decimal number with up to 2 digits after the decimal point, and
`method` can only ever be `'cash'` or `'card'`.

> **Answer:**
> ```sql
> CREATE TABLE Payment (
>     payment_id INT AUTO_INCREMENT PRIMARY KEY,
>     amount DECIMAL(10,2) NOT NULL,
>     method ENUM('cash','card') NOT NULL
> );
> ```
> `ENUM` spells the domain constraint directly into the type: MySQL
> rejects any value not on the list.

**Problem 5.** A course can require another course as a prerequisite.
Write `CREATE TABLE` for `Prerequisite(course_code, prereq_code)`,
where the two columns together form the primary key, and both are
foreign keys to `Course(course_code)`.

> **Answer:**
> ```sql
> CREATE TABLE Prerequisite (
>     course_code VARCHAR(10),
>     prereq_code VARCHAR(10),
>     PRIMARY KEY (course_code, prereq_code),
>     FOREIGN KEY (course_code) REFERENCES Course(course_code),
>     FOREIGN KEY (prereq_code) REFERENCES Course(course_code)
> );
> ```
> A composite primary key, written on its own line, exactly like
> `Enrollment`'s `student_id`/`section_id` pair.

**Problem 6.** `Student` was created without an email column. Write
the `ALTER TABLE` statement that adds an `email` column, up to 100
characters, that no two students may share.

> **Answer:**
> ```sql
> ALTER TABLE Student ADD COLUMN email VARCHAR(100) UNIQUE;
> ```
> `UNIQUE` enforces Week 2's key constraint on a column that is not
> the primary key.
