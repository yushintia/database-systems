# Lab 07: Normalization — Guided Exercises and Challenge

Prompts only, adapted from the lab text. See `answer-key/` for
reference solutions.

## Guided Exercises

### Part 1: Anomaly Hunt (in-lab)

1. Run `book/src/labs/files/lab07/bad_registration_seed.sql`.
2. Run Anomaly 1's statements (`anomaly_triggers.sql`) one at a time.
   Record the exact result table you see.
3. Run Anomaly 2's statements one at a time. Record what changed.
4. For each anomaly, write: (a) which functional dependency caused
   it, (b) which normal form it violates, (c) what real-world fact
   was lost or corrupted.

File: `lab07_anomalies.md`

### Part 2: Decompose to 3NF (on paper)

Starting from `Section(section_id, course_code, course_title,
instructor_id, instructor_name, room, semester)`:

1. Check 1NF.
2. Check 2NF, and explain why.
3. Check 3NF; name every transitive dependency.
4. Decompose: write every resulting relation with keys declared.
5. Confirm your result matches
   `book/src/labs/files/lab06/target_schema.sql`.

File: `lab07_normalized.md`

## Challenge Problem

Normalize `Waitlist(student_id, section_id, student_name,
course_title, position)`: test against 1NF/2NF/3NF, name every
violation, decompose fully, and confirm the result matches Lab 06's
`Waitlist` (minus `date_joined`).

Included in: `lab07_normalized.md`, as a final section.

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** `Loan(isbn, member_id, book_title, member_name,
due_date)`, `PRIMARY KEY (isbn, member_id)`. Identify every anomaly
and normalize the relation.

**Practice 2.** `Employee(employee_id, department_id,
department_manager)`, where knowing the department tells you its
manager. Identify the violation and fix it.

**Practice 3.** `Student(student_id, name, major,
department_office)`, where `department_office` depends on `major`,
not on `student_id`. Which normal form does this violate?

**Practice 4.** `Enrollment(student_id, section_id, grade,
course_title)`, `PRIMARY KEY (student_id, section_id)`. Identify the
violation and fix it.

**Practice 5.** `Section(section_id, course_code, course_title,
instructor_id, instructor_name, room, semester)`. Identify every
anomaly and fully normalize the relation.

**Practice 6.** `Enrollment(student_id, section_id, grade,
attendance_percent)`, `PRIMARY KEY (student_id, section_id)`. Is this
already in 2NF? Justify your answer.

**Practice 7.** A gym membership system has
`Checkin(member_id, gym_location_id, gym_location_address,
checkin_time)`. Identify the violation and fix it.
