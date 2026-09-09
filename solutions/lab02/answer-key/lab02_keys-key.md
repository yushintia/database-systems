# Lab 02 Answer Key — `lab02_keys.md` (Professor Only)

Not linked from any public page. Model answer for
`solutions/lab02/problems.md`.

## Guided Exercise 1

1. **Real-world things in the row:** a student, a course, and an
   enrollment (at minimum three separate things — the instructor and
   room facts arguably belong to a fourth, "section").
2. **Student's own attributes only:** `name`, `major` (not
   `course_code`, not `grade` — those belong elsewhere).
3. **`Student(student_id, name, major)`** — `student_id` is a
   system-generated key added specifically to guarantee no two
   students are indistinguishable.
4. **`Course(course_code, title)`:** candidate key `{course_code}`,
   which is also the primary key (only one candidate key exists).
   **`Instructor(instructor_id, name)`:** candidate key
   `{instructor_id}`, also the primary key, for the same reason.

## Guided Exercise 2

1. **Referential integrity** is broken — the foreign key
   `student_id` in `Enrollment` must match an existing primary key
   value in `Student`, or be left empty.
2. The row is meaningless, not just incorrect, because it makes a
   claim ("student 999 is enrolled in this course") about a student
   who, as far as the database knows, does not exist. There is no
   real-world fact this row could correctly represent.

## Guided Exercise 3

1. Accept any of: `grade` currently accepts any text; its real domain
   should be a fixed small set of legal letter grades (e.g. A+, A0,
   A-, B+, ... F) or NULL for "not yet graded." `room` currently
   accepts any text; its real domain should be a fixed list of actual
   rooms that exist.
2. Any pair of rows sharing the same `student_name` but spelled
   differently (e.g. row 2 "Kim Minji" and row 4 "MinJi Kim") would
   violate a `Student` key constraint's *intent* — two rows that are
   supposed to represent one real student instead look like two
   independent, unrelated tuples with no shared key at all.

## Challenge Problem

1. `Book`: `{isbn}`. `Member`: `{member_id}`. `Loan`:
   `{isbn, member_id}` (assuming one member cannot borrow the exact
   same book twice concurrently).
2. `Loan.isbn` references `Book.isbn`; `Loan.member_id` references
   `Member.member_id`.
3. **Referential integrity** is violated — the row points at a primary
   key value (`isbn`) that no longer exists in `Book`. This constraint
   exists specifically to prevent orphaned, meaningless loan records
   from surviving after the thing they reference is removed.
