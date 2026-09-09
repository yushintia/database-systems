# Lab 11: Single-table Queries — Guided Exercises and Challenge

Prompts only, adapted from the lab text. See `answer-key/` for
reference solutions.

## Guided Exercises

### Exercise 1: Basic SELECT-FROM-WHERE

`name` and `major` of every student majoring in "Data Science."

### Exercise 2: LIKE and BETWEEN

Every `Course.title` containing "Systems" (`LIKE`). Every `Section`
with `semester = '2026-1'`.

### Exercise 3: IS NULL and IN

Every ungraded `Enrollment` row (`IS NULL`). Every `Student` whose
`major` is `'Computer Science'` or `'Software Engineering'` (`IN`).

### Exercise 4: DISTINCT and ORDER BY

Every distinct `room` used by any `Section`, sorted alphabetically.

### Exercise 5: Aggregates Without GROUP BY

One query: total enrollment rows, graded rows, ungraded rows, as three
aliased columns.

### Exercise 6: CASE

Each student's `name` with a `CASE` column: `'CS'` for Computer
Science majors, `'Other'` otherwise.

File: `lab11_queries.sql` (all six exercises, one file, run against
`book/src/labs/files/lab11/full_seed.sql`)

## Challenge Problem

One query: highest/lowest `student_id` with at least one graded
enrollment, count of distinct grades in use, count of ungraded
enrollments — no `GROUP BY`. Second query: bucket every `Course` into
`'Intro'` or `'Advanced'` using `CASE`.

File: `lab11_challenge.sql`

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** Every `Book` whose title contains "Database," sorted
alphabetically.

**Practice 2.** Every enrollment not yet graded.

**Practice 3.** `Book.acquired_on DATE`; each title with days-owned via
`DATEDIFF`.

**Practice 4.** `Loan.due_date DATE`; label each loan `'Overdue'` or
`'On Time'` with `CASE`.

**Practice 5.** Every `Course` whose title ends with "Systems"
(`LIKE`).

**Practice 6.** Total row count in `Student` (whole-table aggregate).

**Practice 7.** The 3 most recent enrollments by `student_id` then
`section_id`, using `ORDER BY` and `LIMIT`.
