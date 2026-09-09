# Lab 02 Problems — The Relational Model

Public restatement of Lab 02's Guided Exercises and Challenge Problem.
Full lab page: `book/src/labs/lab02-relational-model.md`. Seed file:
`book/src/labs/files/lab02/flat_load.sql`.

## Guided Exercise 1: The Registration System, One Relation at a Time

Given the flat row `Kim Minji, Computer Sci., CSE301, Prof. Lee, A0`:

1. List the real-world "things" the row's facts are actually about.
2. Pick only the attributes belonging to the student's own facts.
3. Write the full `Student` relation schema, with a working key.
4. For `Course(course_code, title)` and `Instructor(instructor_id,
   name)`, name a candidate key for each and say whether it is also
   the primary key.

## Guided Exercise 2: Referential Integrity, By Hand

`Enrollment(student_id, course_code, grade)` has an orphaned row:
`student_id = 999`, which does not exist in `Student`.

1. Which integrity rule is broken?
2. Why is that row meaningless, not just incorrect?

## Guided Exercise 3: `raw_registrations`, Classified

Using the loaded `raw_registrations` table:

1. Name one column whose real domain should be tighter than "any
   typed text," and describe the domain it should have.
2. Point to a specific pair of rows that would violate a `Student`
   relation's key constraint, if this table were already a `Student`
   table.

## Challenge Problem

Design a schema for `Book(isbn, title, author)`, `Member(member_id,
name)`, `Loan(isbn, member_id, due_date)`.

1. State a candidate key for each relation.
2. Name `Loan`'s two foreign keys and what each references.
3. A `Loan` row points at a removed book. Which constraint is
   violated, and what problem does that constraint prevent?

## Deliverable

`lab02_keys.md`. Total: 10 points.
