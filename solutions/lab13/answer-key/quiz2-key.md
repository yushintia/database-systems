# Quiz 2 Answer Key: Weeks 9-12 Self-Check Quizzes

Consolidated from `materials/week09/quiz.md` through
`materials/week12/quiz.md` and their matching `answer-key/quiz.md`
files. Instructor reference only — students see the ungraded
self-check version, with a subset of these questions and answers, on
the [Lab 13](../../../book/src/labs/lab13-quiz2-review.md) page.

---

## Week 9: DDL

**1.** What does DDL stand for, and what does it do?

A. Data Definition Language; defines and changes structure like tables and constraints
B. Data Delivery Language; sends query results to an application
C. Database Design Layer; a diagramming tool for E-R diagrams
D. Data Duplication Log; records changes made to rows

**Answer: A** — DDL is Data Definition Language, the part of SQL that
defines and changes structure: tables, columns, and constraints.

**2.** Which of these is **NOT** part of DDL?

A. `CREATE TABLE`  B. `ALTER TABLE`  C. `SELECT`  D. `DROP TABLE`

**Answer: C** — `SELECT` manipulates and reads data, it is DML, not
DDL; `CREATE`, `ALTER`, and `DROP` are all DDL.

**3.** You want `student_id` to be generated automatically by MySQL,
so no one ever types it by hand. Which keyword does this?

A. `NOT NULL`  B. `AUTO_INCREMENT`  C. `UNIQUE`  D. `DEFAULT`

**Answer: B** — `AUTO_INCREMENT` tells MySQL to generate the next
whole number automatically on every insert.

**4.** You run `CREATE TABLE Section (... FOREIGN KEY (instructor_id)
REFERENCES Instructor(instructor_id));`, but `Instructor` does not
exist yet. What happens?

A. MySQL creates `Section` and silently ignores the foreign key
B. MySQL creates both `Section` and an empty `Instructor` table automatically
C. MySQL rejects the statement with an error, because the referenced table does not exist
D. MySQL creates `Section` but leaves `instructor_id` empty in every row

**Answer: C** — MySQL rejects the statement immediately; a foreign
key can only reference a table that already exists.

**5.** How do you declare a **composite** primary key on
`student_id` and `section_id` together?

A. `PRIMARY KEY (student_id) PRIMARY KEY (section_id)`
B. `PRIMARY KEY (student_id, section_id)`
C. `student_id INT PRIMARY KEY, section_id INT PRIMARY KEY`
D. `UNIQUE (student_id, section_id)`

**Answer: B** — `PRIMARY KEY (student_id, section_id)`, written on
its own line, declares one primary key made of both columns together.

**6.** A `Student` table was created without `NOT NULL` on the `name`
column. What is the practical risk of this mistake?

A. MySQL will refuse to create the table at all
B. MySQL silently allows a required fact, like a student's name, to be left empty
C. The column will not accept any text longer than 1 character
D. Every insert into the table will now fail

**Answer: B** — without `NOT NULL`, MySQL allows the column to be
left empty, even for a fact that should always be required.

**7.** Write the `CREATE TABLE` statement for `Course(course_code,
title)`, where `course_code` is a 10-character code and the primary
key, and `title` (up to 150 characters) is required.

**Answer:**
```sql
CREATE TABLE Course (
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(150) NOT NULL
);
```

**8.** Explain why `Enrollment` must be created last among the
registration system's five tables.

**Model answer:** "`Enrollment` has foreign keys to both `Student`
and `Section`, and referential integrity means MySQL will not let a
foreign key constraint point at a table that does not exist yet, so
both of those tables, and everything they depend on, must already
exist first."

---

## Week 10: DML

**1.** What does DML stand for, and what does it do?

A. Database Markup Language; it defines table structure
B. Data Manipulation Language; it inserts, changes, retrieves, and removes data
C. Data Modelling Language; it draws E-R diagrams
D. Data Migration Language; it moves tables between databases

**Answer: B** — DML (Data Manipulation Language) is the part of SQL
that inserts, changes, retrieves, and removes data inside a table
that already exists.

**2.** Which statement correctly adds one new row to `Course`?

A. `UPDATE Course SET course_code = 'CSE305', title = 'Data Structures';`
B. `CREATE TABLE Course (course_code, title);`
C. `INSERT INTO Course (course_code, title) VALUES ('CSE305', 'Data Structures');`
D. `SELECT * FROM Course WHERE course_code = 'CSE305';`

**Answer: C**.

**3.** Why does `UPDATE Instructor SET name = 'Lee, Married Name';`
(with no `WHERE` clause) cause a serious problem?

A. MySQL rejects it automatically, so nothing happens
B. It only changes the first row in the table
C. It changes the name of every single row in `Instructor`
D. It deletes the `Instructor` table entirely

**Answer: C** — with no `WHERE` clause, `UPDATE` applies to every row
in the table, changing every instructor's name to the same value at
once.

**4.** A student tries to run
`INSERT INTO Enrollment (student_id, section_id, grade) VALUES (50, 3, NULL);`
but `student_id = 50` does not exist in `Student` yet. What happens?

A. MySQL creates a new `Student` row automatically
B. The `INSERT` fails, because the foreign key has no matching row to reference
C. The `INSERT` succeeds, and `student_id` is left blank
D. MySQL ignores the foreign key rule for `NULL` grades

**Answer: B**.

**5.** By default, what happens if you run
`DELETE FROM Instructor WHERE instructor_id = 1;` while instructor 1
still teaches a `Section`?

A. MySQL deletes the instructor and leaves the `Section` row pointing at nothing
B. MySQL deletes the instructor and also deletes every `Section` they taught
C. MySQL rejects the `DELETE`, to avoid leaving an orphaned `Section` row
D. MySQL pauses and asks the user to confirm

**Answer: C** — MySQL rejects the `DELETE` by default, because
removing the instructor would leave the `Section` row pointing at an
instructor who no longer exists, an orphaned row.

**6.** What does a grade of `NULL` in `Enrollment` mean?

A. The student failed the course  B. The grade is zero
C. No grade has been recorded yet  D. The enrollment row was deleted

**Answer: C** — `NULL` means "not graded yet," not zero and not a
deleted row.

**7.** Write the `INSERT` statement to add a new student, "Han
Jiwoo," major "Data Science," to `Student`.

**Answer:**
```sql
INSERT INTO Student (name, major)
VALUES ('Han Jiwoo', 'Data Science');
```

**8.** Explain why `INSERT` order matters across related tables.

**Model answer:** "A row can only reference, by foreign key, a row
that already exists. So the referenced table's row must be inserted
first — the same dependency order Week 9 used for `CREATE TABLE` —
or the `INSERT` fails on the spot."

---

## Week 11: Single-table Queries

**1.** In `SELECT name FROM Student WHERE major = 'CS';`, what job
does `WHERE` actually do?

A. It picks which columns to return
B. It picks which rows qualify, a yes/no test applied to every row
C. It sorts the result
D. It removes duplicate rows

**Answer: B**.

**2.** Which query correctly finds every enrollment with no grade
recorded yet?

A. `SELECT * FROM Enrollment WHERE grade = NULL;`
B. `SELECT * FROM Enrollment WHERE grade = '';`
C. `SELECT * FROM Enrollment WHERE grade IS NULL;`
D. `SELECT * FROM Enrollment WHERE grade != NULL;`

**Answer: C** — `NULL` means "unknown," and nothing equals unknown,
not even another unknown, so `= NULL` never matches; `IS NULL` is the
only correct test.

**3.** What is the difference between `name = 'Kim'` and `name LIKE
'Kim%'`?

A. They always return the exact same rows
B. `=` matches only the exact text "Kim"; `LIKE 'Kim%'` also matches text starting with "Kim," like "Kim Minji"
C. `LIKE` only works on numbers, never on text
D. `=` is MySQL-specific syntax; `LIKE` is not

**Answer: B**.

**4.** Without an `ORDER BY` clause, what order does MySQL return
rows in?

A. Always alphabetical by the first column
B. Always the order rows were inserted
C. Whatever order is convenient internally — never guaranteed
D. Always sorted by the primary key

**Answer: C** — a relation has no meaningful order by definition;
without `ORDER BY`, MySQL is free to return rows in whatever order is
convenient internally.

**5.** What does `SELECT DISTINCT major FROM Student;` do that
`SELECT major FROM Student;` does not?

A. It sorts the majors alphabetically
B. It returns each different major value only once, instead of once per student
C. It only returns majors with more than one student
D. It removes any student with a `NULL` major

**Answer: B**.

**6.** `LIMIT 5` is added to a query. What does it do?

A. Returns only the first 5 rows of the result
B. Returns every 5th row
C. Returns rows where some column equals 5
D. Limits the query to running for 5 seconds

**Answer: A** — `LIMIT 5` returns only the first 5 rows of the
(possibly sorted) result; it is MySQL's own syntax, not shared by
every database product.

**7.** Write a query that returns the `name` of every `Student` whose
`major` is either `'Computer Science'` or `'Software Engineering'`,
using `IN`.

**Answer:**
```sql
SELECT name FROM Student
WHERE major IN ('Computer Science', 'Software Engineering');
```

**8.** Explain why `SELECT * FROM Enrollment;` alone does not answer
a real question like "who got an A?"

**Model answer:** "`SELECT * FROM Enrollment;` returns every row and
every column with no filtering, so a person still has to scroll
through all of it by eye. Adding `WHERE grade = 'A0'` makes the
database do the filtering directly, instead of a person doing it
manually."

---

## Week 12: Multi-table Queries

**1.** What does `INNER JOIN` return?

A. Every row from both tables, matched or not
B. Only rows where a match exists on both sides
C. Only rows from the left table
D. Only rows where no match exists

**Answer: B**.

**2.** What does `LEFT JOIN` do differently from `INNER JOIN`?

A. It keeps every row from the left table, even without a match, filling missing columns with `NULL`
B. It only returns rows from the right table
C. It removes duplicate rows automatically
D. It sorts the result before returning it

**Answer: A**.

**3.** What is the purpose of the `ON` clause in a JOIN?

A. It names the columns to display in the result
B. It states the condition used to match rows between the two tables
C. It sorts the joined result
D. It limits how many rows come back

**Answer: B** — `ON` states the matching condition, usually a
foreign key matching a primary key.

**4.** What happens if you write a `JOIN` with no matching condition
at all?

A. MySQL raises an error and refuses to run the query
B. It automatically adds a matching condition based on foreign keys
C. It returns every possible pairing of rows from both tables, an enormous, meaningless result
D. It silently returns zero rows

**Answer: C**.

**5.** What does `GROUP BY` do?

A. Sorts rows in ascending order
B. Removes rows that do not match a condition
C. Clusters rows sharing the same value in one or more columns, so an aggregate function can summarize each group separately
D. Combines two tables into one

**Answer: C**.

**6.** Which clause filters entire groups, after aggregation has
already happened?

A. `WHERE`  B. `ON`  C. `HAVING`  D. `USING`

**Answer: C** — `HAVING` filters entire groups after grouping and
aggregation; `WHERE` filters individual rows before grouping happens.

**7.** Write a query listing every `Instructor`'s name and the number
of `Section`s they teach, including instructors teaching zero
sections this semester.

**Answer:**
```sql
SELECT Instructor.name, COUNT(Section.section_id) AS sections_taught
FROM Instructor
LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
GROUP BY Instructor.name;
```
`LEFT JOIN` from `Instructor` is required — an `INNER JOIN` would
silently drop any instructor with zero sections, exactly the rows
this question needs kept.

**8.** Explain why `SELECT major, COUNT(*) FROM Student WHERE
COUNT(*) > 5;` is invalid.

**Model answer:** "`COUNT(*)` is an aggregate value that does not
exist until after grouping happens, so it cannot be used inside
`WHERE`. Filtering on an aggregate value like `COUNT(*) > 5` requires
`HAVING` instead, after a `GROUP BY major` clause."
