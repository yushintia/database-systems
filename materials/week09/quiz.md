# Week 9 Self-Check Quiz (Ungraded)

Database Systems (511783-001). This quiz is **ungraded** — it is only
to help you check what stuck. About 10 minutes. Do not look back at
the slides while you answer.

---

**1.** What does DDL stand for, and what does it do?

A. Data Definition Language; defines and changes structure like tables and constraints
B. Data Delivery Language; sends query results to an application
C. Database Design Layer; a diagramming tool for E-R diagrams
D. Data Duplication Log; records changes made to rows

**2.** Which of these is **NOT** part of DDL?

A. `CREATE TABLE`
B. `ALTER TABLE`
C. `SELECT`
D. `DROP TABLE`

**3.** You want `student_id` to be generated automatically by MySQL,
so no one ever types it by hand. Which keyword does this?

A. `NOT NULL`
B. `AUTO_INCREMENT`
C. `UNIQUE`
D. `DEFAULT`

**4.** You run `CREATE TABLE Section (... FOREIGN KEY (instructor_id)
REFERENCES Instructor(instructor_id));`, but `Instructor` does not
exist yet. What happens?

A. MySQL creates `Section` and silently ignores the foreign key
B. MySQL creates both `Section` and an empty `Instructor` table automatically
C. MySQL rejects the statement with an error, because the referenced table does not exist
D. MySQL creates `Section` but leaves `instructor_id` empty in every row

**5.** How do you declare a **composite** primary key on
`student_id` and `section_id` together?

A. `PRIMARY KEY (student_id) PRIMARY KEY (section_id)`
B. `PRIMARY KEY (student_id, section_id)`
C. `student_id INT PRIMARY KEY, section_id INT PRIMARY KEY`
D. `UNIQUE (student_id, section_id)`

**6.** A `Student` table was created without `NOT NULL` on the `name`
column. What is the practical risk of this mistake?

A. MySQL will refuse to create the table at all
B. MySQL silently allows a required fact, like a student's name, to be left empty
C. The column will not accept any text longer than 1 character
D. Every insert into the table will now fail

**7.** Write the `CREATE TABLE` statement for `Course(course_code,
title)`, where `course_code` is a 10-character code and the primary
key, and `title` (up to 150 characters) is required.

```
_____________________________________________________________
_____________________________________________________________
_____________________________________________________________
```

**8. (Short answer)** In 1-2 sentences, explain why `Enrollment` must
be created last among the registration system's five tables. Use at
least one key word from this week (`foreign key`, `constraint`, or
`referential integrity`).

```
_____________________________________________________________
_____________________________________________________________
```
