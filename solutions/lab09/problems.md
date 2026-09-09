# Lab 09: DDL — Guided Exercises and Challenge

Prompts only, adapted from the lab text. See `answer-key/` for
reference solutions.

## Guided Exercises

### Exercise 1: The Three Independent Tables

Write `CREATE TABLE` for `Instructor(instructor_id PK auto, name required)`,
`Course(course_code PK, title required)`, and `Student(student_id PK auto,
name required, major optional)`.

### Exercise 2: Section

Write `CREATE TABLE Section`, with `section_id` auto-generated,
`course_code` and `room` required, `instructor_id` and `semester`
optional, and foreign keys to both `Course` and `Instructor`.

### Exercise 3: Break It on Purpose, Then Fix It

Run `CREATE TABLE Section` before `Instructor` or `Course` exist.
Record the exact error. Then create them in the correct order and
confirm `Section` now succeeds.

### Exercise 4: Enrollment

Write `CREATE TABLE Enrollment`, composite primary key
`(student_id, section_id)`, `grade` allows `NULL`, foreign keys to
both `Student` and `Section`.

### Exercise 5: Final Assembly

Combine Exercises 1-4 into one file, `lab09_create_schema.sql`, with a
header comment, in valid dependency order. Must run cleanly against
`book/src/labs/files/lab09/reset.sql`.

File: `lab09_create_schema.sql`

## Challenge Problem

Using `ALTER TABLE` (not the original `CREATE TABLE` statements): add
`Course.credit_hours INT` with `CHECK (credit_hours BETWEEN 1 AND 6)`,
and add a named `UNIQUE` constraint on `Student.email`.

File: `lab09_challenge.sql`

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** `CREATE TABLE` for `Book(isbn, title)`, `isbn` a
13-character primary key, not auto-incrementing.

**Practice 2.** `ALTER TABLE` making `Section.room` `NOT NULL`.

**Practice 3.** `CREATE TABLE` for `Department(dept_code, dept_name)`,
`dept_code` up to 10 characters and the primary key, `dept_name`
required up to 100 characters.

**Practice 4.** `CREATE TABLE` for `Payment(payment_id, amount,
method)`: `payment_id` auto-generates, `amount` is `DECIMAL(p,2)`,
`method` is `'cash'` or `'card'` only.

**Practice 5.** `CREATE TABLE` for `Prerequisite(course_code,
prereq_code)`, composite primary key, both columns foreign keys to
`Course(course_code)`.

**Practice 6.** `ALTER TABLE` adding a `UNIQUE` `email` column
(`VARCHAR(100)`) to `Student`.

**Practice 7.** `Ride.driver_id` references `Driver.driver_id`; a
driver account can be deactivated and removed. Choose and justify
`CASCADE`, `SET NULL`, or `RESTRICT`.
