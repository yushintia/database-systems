# Week 9 Worksheet: Building the Registration Schema in MySQL

Database Systems (511783-001). Work with your pair. Write short
answers — full sentences are not required, but write enough that your
partner and the instructor can follow your thinking.

**Pair names:** ___________________________ / ___________________________

---

## Part A (do this in 차시 2, about 15 minutes)

You are turning Week 7's normalized registration schema into real
MySQL tables. Work through these in order, writing the actual SQL.

**A1.** Write the `CREATE TABLE` statement for `Instructor(instructor_id,
name)`, with `instructor_id` auto-generated and `name` required.

```
________________________________________________________________
________________________________________________________________
```

**A2.** Write the `CREATE TABLE` statement for `Course(course_code,
title)`, where `course_code` is a 10-character code and the primary
key, and `title` (up to 150 characters) is required.

```
________________________________________________________________
________________________________________________________________
```

**A3.** Now write the `CREATE TABLE` statement for `Section(section_id,
course_code, instructor_id, room, semester)`, with foreign keys to
`Course` and `Instructor`.

```
________________________________________________________________
________________________________________________________________
________________________________________________________________
```

**A4.** Prediction: suppose you ran your A3 statement *before* ever
running your A1 statement, in a completely empty database. Will the
`CREATE TABLE Section` statement run without error? Circle one.

**Yes** &nbsp;&nbsp;&nbsp;&nbsp; **No** &nbsp;&nbsp;&nbsp;&nbsp; **Not sure**

**A5.** What is one thing about `CREATE TABLE` order, or foreign keys,
that you are still not sure about?

```
________________________________________________________________
```

*Stop here. We compare answers together before you see Part B.*

---

## Part B (do this in 차시 3, about 15 minutes)

Your instructor will hand this out after the class discussion of Part
A. It starts with the real answer to A4, then asks you to explain it.

**The real answer to A4:** No. Running `CREATE TABLE Section` before
`Instructor` exists produces `ERROR 1824 (HY000): Failed to open the
referenced table 'instructor'`. A foreign key can only reference a
table that already exists.

**B1.** Was your Part A prediction (A4) correct?

`Yes  /  No  /  Partly`

**B2.** Using the words **foreign key** and **referential integrity**,
explain in 1-2 sentences why table creation order matters in MySQL.

```
________________________________________________________________
________________________________________________________________
```

**B3.** Write the `CREATE TABLE` statement for `Enrollment(student_id,
section_id, grade)`, where `student_id` and `section_id` together form
the primary key, and both are foreign keys, to `Student(student_id)`
and `Section(section_id)`.

```
________________________________________________________________
________________________________________________________________
________________________________________________________________
```

**B4.** Put all five registration tables in a valid creation order:
`Course`, `Enrollment`, `Instructor`, `Section`, `Student`. Write the
order as a numbered list (you do not need to rewrite the SQL).

```
1. ______________  2. ______________  3. ______________
4. ______________  5. ______________
```

**B5 (stretch, optional).** `Student` was created without an email
column. Write the `ALTER TABLE` statement that adds an `email` column
(up to 100 characters) that no two students may share.

```
________________________________________________________________
```

---
---

# Instructor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:**
  ```sql
  CREATE TABLE Instructor (
      instructor_id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(100) NOT NULL
  );
  ```
- **A2:**
  ```sql
  CREATE TABLE Course (
      course_code VARCHAR(10) PRIMARY KEY,
      title VARCHAR(150) NOT NULL
  );
  ```
- **A3:**
  ```sql
  CREATE TABLE Section (
      section_id INT AUTO_INCREMENT PRIMARY KEY,
      course_code VARCHAR(10),
      instructor_id INT,
      room VARCHAR(20),
      semester VARCHAR(20),
      FOREIGN KEY (course_code) REFERENCES Course(course_code),
      FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
  );
  ```
  Common mistakes to listen for: forgetting `NOT NULL` on `title` or
  `name`, forgetting `AUTO_INCREMENT` on the id columns, writing the
  `FOREIGN KEY` line with the wrong column names, or forgetting the
  parentheses around the referenced column.
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "Yes, it's just an empty table with some columns" —
  that is the expected wrong guess, and the whole point of the
  "not sure yet" moment. Do **not** confirm or deny the answer yet.
- **A5:** Good answers mention: uncertainty about whether order
  matters at all, confusion about what a foreign key actually checks,
  or not knowing what the error message would look like. Any honest
  gap is a success.

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking.
- **B2 (model answer):** "A foreign key enforces referential
  integrity: MySQL checks that the referenced table and column already
  exist before it will create the constraint. If `Instructor` does not
  exist yet, there is nothing for `Section`'s foreign key to point to,
  so the statement fails."
- **B3 (model answer):**
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
- **B4 (model answer):** 1. `Student` (or `Course` or `Instructor`, any
  order among these three) 2. `Course` 3. `Instructor` 4. `Section`
  (after `Course` and `Instructor`) 5. `Enrollment` (last, after
  `Student` and `Section`). Accept any ordering of `Student`, `Course`,
  `Instructor` in the first three slots, as long as `Section` comes
  after `Course`/`Instructor`, and `Enrollment` comes last.
- **B5 (model answer):**
  ```sql
  ALTER TABLE Student ADD COLUMN email VARCHAR(100) UNIQUE;
  ```

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain).
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting every SQL statement perfectly correct.
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section, or have them try running their B3/B4
  statements against a real MySQL instance if one is available in the
  room.
