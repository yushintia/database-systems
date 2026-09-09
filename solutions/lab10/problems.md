# Lab 10: DML — Guided Exercises and Challenge

Prompts only, adapted from the lab text. See `answer-key/` for
reference solutions.

## Guided Exercises

### Exercise 1: Populate the Independent Tables

Insert at least 3 rows into `Instructor`, 3 into `Course`, 5 into
`Student`, using at least one multi-row `INSERT`.

### Exercise 2: Populate Section

Insert at least 4 rows into `Section`, referencing only
`course_code`/`instructor_id` values already inserted.

### Exercise 3: Populate Enrollment, Including a NULL Grade

Insert at least 8 rows into `Enrollment`; at least two rows must have
`grade` omitted or explicitly `NULL`.

### Exercise 4: A Safe UPDATE

`SELECT` a target `Section` row first, then `UPDATE` its `room`.
Re-run the `SELECT` to confirm only that row changed.

### Exercise 5: A DELETE That Hits a Foreign-Key Error, on Purpose

Try to `DELETE` an `Instructor` row still referenced by a `Section`.
Record the exact error, then write the correct two-step fix.

### Exercise 6: Final Assembly

`lab10_insert_data.sql` (Exercises 1-3, valid dependency order) and
`lab10_changes.sql` (Exercises 4-5).

Files: `lab10_insert_data.sql`, `lab10_changes.sql`

## Challenge Problem

Write an `INSERT ... SELECT` copying every graded `Enrollment` row
into `Transcript(student_id, section_id, grade, archived_on)`, stamped
with `CURDATE()`. Then write an `INSERT ... ON DUPLICATE KEY UPDATE`
that re-enrolls a student without a duplicate-key error.

File: `lab10_challenge.sql`

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** Add student "Jung Haeun" (Data Science) and enroll her
in `section_id = 4`, no grade yet, using `LAST_INSERT_ID()`.

**Practice 2.** Student `student_id = 1` changes major to "Data
Science." Write the safest `UPDATE`, checking first.

**Practice 3.** `section_id = 7` moves to room "성파 615." Write the
`UPDATE`.

**Practice 4.** Student `student_id = 12` withdraws from
`section_id = 4`. Write the `DELETE`.

**Practice 5.** An `INSERT INTO Section` referencing a non-existent
`instructor_id = 9` is rejected. Explain why, and write the corrected
pair of statements in order.

**Practice 6.** Remove every `Enrollment` row belonging to students
whose `major = 'Software Engineering'`, using a subquery.

**Practice 7.** `Loan(book_isbn, member_id, due_date)`,
`PRIMARY KEY(book_isbn, member_id)`. Write one statement that inserts
a new loan, or extends the due date if that member already has that
book checked out.
