# Lab 12: Multi-table Queries — Guided Exercises and Challenge

Prompts only, adapted from the lab text. See `answer-key/` for
reference solutions. This lab is also **Assignment 2**, due this week.

## Guided Exercises

### Exercise 1: A Two-Table INNER JOIN

Every student's `name` and `Enrollment.grade`, for students actually
enrolled in something.

### Exercise 2: The Same Question, With LEFT JOIN

Rewrite Exercise 1 so every student appears, even with zero
enrollments.

### Exercise 3: Four-Table JOIN

Every student enrolled in one of Professor Han's sections, with grade
and course title.

### Exercise 4: GROUP BY and HAVING

Each `Section.section_id` and enrollment count, only for sections with
more than 8 students enrolled.

### Exercise 5: Instructors Teaching Nothing

Every instructor and how many sections they teach, including
instructors teaching zero sections.

### Exercise 6: Final Assembly

All five exercises in one file, run against
`book/src/labs/files/lab11/full_seed.sql`.

File: `lab12_joins.sql`

## Challenge Problem

Every pair of distinct students enrolled in the same section together
(self-join), for one chosen section. Second query: each student's
`name` with a live count of their own enrollments, via a correlated
subquery (not a `JOIN`).

File: `lab12_challenge.sql`

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** Every Instructor and section count, including zero;
name the JOIN type and why.

**Practice 2.** Each `Member`'s name and loan count, members with at
least one loan.

**Practice 3.** `Loan(loan_id, book_isbn, member_id)`; every pair of
distinct members with the same book checked out (self-join).

**Practice 4.** Every `Member` who has never taken a `Loan`
(`NOT EXISTS`).

**Practice 5.** Every `Section` including zero-enrollment ones, using
`RIGHT JOIN`; then rewrite as an equivalent `LEFT JOIN`.

**Practice 6.** Every `Student` enrolled in any section taught by a
given `instructor_id`, using `IN` and a subquery.

**Practice 7.** `student_id` and enrollment count for students enrolled
in more than 2 sections.
