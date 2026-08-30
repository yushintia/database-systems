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
