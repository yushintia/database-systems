# SQL Style Guide

Consistent SQL style makes your work easier to read, debug, and grade.
Follow these conventions in every `.sql` file you submit this
semester.

---

## Keyword Casing

Write all SQL keywords in **UPPERCASE**. Write everything else
(identifiers, values) in lowercase.

```sql
-- Good
SELECT student_id, name
FROM Student
WHERE major = 'Computer Science'
ORDER BY name;

-- Bad: inconsistent casing
select student_id, name from Student where major = 'Computer Science' order by name;
```

Keywords include `SELECT`, `FROM`, `WHERE`, `JOIN`, `ON`, `GROUP BY`,
`ORDER BY`, `INSERT INTO`, `VALUES`, `CREATE TABLE`, `PRIMARY KEY`,
`FOREIGN KEY`, `NOT NULL`, and so on.

---

## Identifier Naming

- **Tables:** `PascalCase`, **singular** — `Student`, not `student` or
  `students`. This matches the running case study throughout this
  book and the slide decks (`Student`, `Course`, `Instructor`,
  `Section`, `Enrollment`); use singular table names in every lab and
  assignment unless a lab explicitly tells you otherwise.
- **Columns:** `snake_case`, singular — `student_id`, `course_code`,
  `instructor_id`, `enrollment_date`.
- **Primary keys:** name them `<table>_id` where the table has a
  simple surrogate key, e.g. `student_id` in `Student`,
  `section_id` in `Section`. A table whose key is a real-world code
  (like `Course.course_code`) may use that code as its primary key
  instead of inventing a surrogate one — only do this when the lab's
  own schema does.
- **Foreign keys:** always named exactly like the column they
  reference, e.g. `Section.course_code` references
  `Course.course_code`; `Enrollment.student_id` references
  `Student.student_id`.

| Element | Style | Example |
|---|---|---|
| Table | `PascalCase`, singular | `Student`, `Section`, `Enrollment` |
| Column | `snake_case`, singular | `student_id`, `course_code`, `grade` |
| Constraint | `snake_case`, descriptive | `fk_section_course`, `pk_enrollment` |

---

## Indentation for Multi-line Statements

- Use **2 spaces** per indentation level.
- Put each major clause (`SELECT`, `FROM`, `WHERE`, `JOIN`,
  `GROUP BY`, `ORDER BY`) on its own line once a statement no longer
  fits comfortably on one line.
- Align selected columns one per line once there are more than two or
  three of them.

```sql
-- Good
SELECT
  s.name,
  c.title,
  e.grade
FROM Enrollment AS e
JOIN Student AS s ON e.student_id = s.student_id
JOIN Section AS sec ON e.section_id = sec.section_id
JOIN Course AS c ON sec.course_code = c.course_code
WHERE c.title = 'Database Systems'
ORDER BY s.name;

-- Bad: everything on one line, hard to review or debug
SELECT s.name, c.title, e.grade FROM Enrollment AS e JOIN Student AS s ON e.student_id = s.student_id JOIN Section AS sec ON e.section_id = sec.section_id JOIN Course AS c ON sec.course_code = c.course_code WHERE c.title = 'Database Systems' ORDER BY s.name;
```

---

## Always Name Your Constraints

Do not let MySQL invent a constraint name for you. Name every
`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, and `CHECK` constraint
explicitly, so that error messages and later `ALTER TABLE` statements
refer to something readable.

```sql
-- Good
CREATE TABLE Section (
  section_id   INT NOT NULL,
  course_code  VARCHAR(10) NOT NULL,
  instructor_id INT NOT NULL,
  room         VARCHAR(20),
  semester     VARCHAR(20),
  CONSTRAINT pk_section PRIMARY KEY (section_id),
  CONSTRAINT fk_section_course FOREIGN KEY (course_code)
    REFERENCES Course (course_code),
  CONSTRAINT fk_section_instructor FOREIGN KEY (instructor_id)
    REFERENCES Instructor (instructor_id)
);

-- Bad: unnamed constraints, MySQL picks an unreadable name for you
CREATE TABLE Section (
  section_id   INT NOT NULL,
  course_code  VARCHAR(10) NOT NULL,
  instructor_id INT NOT NULL,
  PRIMARY KEY (section_id),
  FOREIGN KEY (course_code) REFERENCES Course (course_code)
);
```

---

## Always Terminate Statements

Every SQL statement ends with a semicolon `;`, even the last one in a
file. MySQL Workbench and the `mysql` CLI can both misbehave on a
missing trailing semicolon when running a whole script.

---

## Header Comment for Submitted `.sql` Files

Every `.sql` file you submit must begin with a comment block:

```sql
-- Course     : 511783-001 Database Systems
-- Name       : [Your Name]
-- Student ID : [Your ID]
-- Lab        : [Lab 0X: Topic Name]
-- Date       : [YYYY-MM-DD]
-- Description: [one sentence about what this script does]
```

---

## Idempotent Seed Scripts

Any `.sql` file meant to be run from scratch should start with the
pattern introduced in
[Setup: MySQL & Workbench](../setup/mysql-workbench.md):

```sql
DROP DATABASE IF EXISTS registration_db;
CREATE DATABASE registration_db;
USE registration_db;
```

This makes the script safe to re-run at any time without manual
cleanup first.

---

## Must Run Cleanly

**Every submitted `.sql` file must run from top to bottom against
MySQL 8.x with no errors.** Before submitting:

- Open a fresh connection (or re-run your seed script) and run the
  entire file, start to finish, in one go.
- Fix every error MySQL reports — do not submit a file you only
  tested by running individual lines out of order.
- If your script depends on another file running first (for example,
  a lab's provided seed script), say so at the top in your header
  comment.

---

## Quick Checklist Before Submission

- [ ] Header comment block present and filled in
- [ ] SQL keywords are UPPERCASE; identifiers are lowercase (columns)
      or PascalCase (tables)
- [ ] Table names are singular and PascalCase; column names are
      singular and `snake_case`
- [ ] Every `PRIMARY KEY` / `FOREIGN KEY` / `UNIQUE` constraint is
      explicitly named
- [ ] Every statement ends with `;`
- [ ] The whole file runs cleanly against MySQL 8.x, top to bottom,
      with no errors
