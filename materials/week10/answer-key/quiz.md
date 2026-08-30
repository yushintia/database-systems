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
