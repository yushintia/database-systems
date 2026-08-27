# Week 10 Self-Check Quiz (Ungraded)

Database Systems (511783-001). This quiz is **ungraded** — it is only
to help you check what stuck. About 10 minutes. Do not look back at
the slides while you answer.

---

**1.** What does DML stand for, and what does it do?

A. Database Markup Language; it defines table structure
B. Data Manipulation Language; it inserts, changes, retrieves, and removes data
C. Data Modelling Language; it draws E-R diagrams
D. Data Migration Language; it moves tables between databases

**2.** Which statement correctly adds one new row to `Course`?

A. `UPDATE Course SET course_code = 'CSE305', title = 'Data Structures';`
B. `CREATE TABLE Course (course_code, title);`
C. `INSERT INTO Course (course_code, title) VALUES ('CSE305', 'Data Structures');`
D. `SELECT * FROM Course WHERE course_code = 'CSE305';`

**3.** Why does `UPDATE Instructor SET name = 'Lee, Married Name';`
(with no `WHERE` clause) cause a serious problem?

A. MySQL rejects it automatically, so nothing happens
B. It only changes the first row in the table
C. It changes the name of every single row in `Instructor`
D. It deletes the `Instructor` table entirely

**4.** A student tries to run
`INSERT INTO Enrollment (student_id, section_id, grade) VALUES (50, 3, NULL);`
but `student_id = 50` does not exist in `Student` yet. What happens?

A. MySQL creates a new `Student` row automatically
B. The `INSERT` fails, because the foreign key has no matching row to reference
C. The `INSERT` succeeds, and `student_id` is left blank
D. MySQL ignores the foreign key rule for `NULL` grades

**5.** By default, what happens if you run
`DELETE FROM Instructor WHERE instructor_id = 1;` while instructor 1
still teaches a `Section`?

A. MySQL deletes the instructor and leaves the `Section` row pointing at nothing
B. MySQL deletes the instructor and also deletes every `Section` they taught
C. MySQL rejects the `DELETE`, to avoid leaving an orphaned `Section` row
D. MySQL pauses and asks the user to confirm

**6.** What does a grade of `NULL` in `Enrollment` mean?

A. The student failed the course
B. The grade is zero
C. No grade has been recorded yet
D. The enrollment row was deleted

**7. (Short answer)** Write the `INSERT` statement to add a new
student, "Han Jiwoo," major "Data Science," to `Student`.

`_____________________________________________________________`

**8. (Short answer)** In 1-2 sentences, explain why `INSERT` order
matters across related tables. Use at least one key word from this
week (foreign key, insert order, or referential integrity).

`_____________________________________________________________`
`_____________________________________________________________`

---
---

# Answer Key

1. **B** — DML (Data Manipulation Language) is the part of SQL that inserts, changes, retrieves, and removes data inside a table that already exists
2. **C** — `INSERT INTO Course (course_code, title) VALUES ('CSE305', 'Data Structures');` adds exactly one new row
3. **C** — with no `WHERE` clause, `UPDATE` applies to every row in the table, changing every instructor's name to the same value at once
4. **B** — `student_id` is a foreign key in `Enrollment`, so it must already exist as a primary key value in `Student`; MySQL rejects the `INSERT` immediately if it does not
5. **C** — MySQL rejects the `DELETE` by default, because removing the instructor would leave the `Section` row pointing at an instructor who no longer exists, an orphaned row
6. **C** — `NULL` means "not graded yet," not zero and not a deleted row
7. **Model answer:**
   ```sql
   INSERT INTO Student (name, major)
   VALUES ('Han Jiwoo', 'Data Science');
   ```
8. **Model answer:** "A row can only reference, by foreign key, a row that already exists. So the referenced table's row must be inserted first — the same dependency order Week 9 used for `CREATE TABLE` — or the `INSERT` fails on the spot."
