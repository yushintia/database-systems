# Week 11 Self-Check Quiz (Ungraded)

Database Systems (511783-001). This quiz is **ungraded** — it is only
to help you check what stuck. About 10 minutes. Do not look back at
the slides while you answer.

---

**1.** In `SELECT name FROM Student WHERE major = 'CS';`, what job does
`WHERE` actually do?

A. It picks which columns to return
B. It picks which rows qualify, a yes/no test applied to every row
C. It sorts the result
D. It removes duplicate rows

**2.** Which query correctly finds every enrollment with no grade
recorded yet?

A. `SELECT * FROM Enrollment WHERE grade = NULL;`
B. `SELECT * FROM Enrollment WHERE grade = '';`
C. `SELECT * FROM Enrollment WHERE grade IS NULL;`
D. `SELECT * FROM Enrollment WHERE grade != NULL;`

**3.** What is the difference between `name = 'Kim'` and `name LIKE
'Kim%'`?

A. They always return the exact same rows
B. `=` matches only the exact text "Kim"; `LIKE 'Kim%'` also matches
   text starting with "Kim," like "Kim Minji"
C. `LIKE` only works on numbers, never on text
D. `=` is MySQL-specific syntax; `LIKE` is not

**4.** Without an `ORDER BY` clause, what order does MySQL return rows
in?

A. Always alphabetical by the first column
B. Always the order rows were inserted
C. Whatever order is convenient internally — never guaranteed
D. Always sorted by the primary key

**5.** What does `SELECT DISTINCT major FROM Student;` do that
`SELECT major FROM Student;` does not?

A. It sorts the majors alphabetically
B. It returns each different major value only once, instead of once
   per student
C. It only returns majors with more than one student
D. It removes any student with a `NULL` major

**6.** `LIMIT 5` is added to a query. What does it do?

A. Returns only the first 5 rows of the result
B. Returns every 5th row
C. Returns rows where some column equals 5
D. Limits the query to running for 5 seconds

**7. (Short answer)** Write a query that returns the `name` of every
`Student` whose `major` is either `'Computer Science'` or `'Software
Engineering'`, using `IN`.

`_____________________________________________________________`

**8. (Short answer)** In 1-2 sentences, explain why `SELECT * FROM
Enrollment;` alone does not answer a real question like "who got an
A?" Use at least one key word from this week (`WHERE`, `DISTINCT`,
`ORDER BY`, or `LIMIT`).

`_____________________________________________________________`
`_____________________________________________________________`
