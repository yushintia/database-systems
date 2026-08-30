# Week 12 Worksheet: Rebuilding the Registrar's Report

Database Systems (511783-001). Work with your pair. Write short
answers — full sentences are not required, but write enough that your
partner and the instructor can follow your thinking.

**Pair names:** ___________________________ / ___________________________

---

## Part A (do this in 차시 2, about 15 minutes)

The registration schema:

```
Student(student_id PK, name, major)
Course(course_code PK, title)
Instructor(instructor_id PK, name)
Section(section_id PK, course_code FK, instructor_id FK, room, semester)
Enrollment(student_id FK, section_id FK, grade, PRIMARY KEY(student_id, section_id))
```

**A1.** Write a query listing every student's `name` and their
`Enrollment.grade`, using `INNER JOIN` (or plain `JOIN`).

`________________________________________________________________`

`________________________________________________________________`

**A2.** `Student` has 300 rows. `Enrollment` has 500 rows, but only 280
of the 300 students have at least one enrollment row. How many rows
does the query from A1 return?

`________________________________________________________________`

**A3.** Now rewrite the same query so that it keeps **every** student,
even the 20 with zero enrollments.

`________________________________________________________________`

`________________________________________________________________`

**A4.** Prediction: for a student with zero enrollments, will that
student's row appear in the result of your A3 query at all, with
`grade` shown as `NULL`? Circle one.

**Yes** &nbsp;&nbsp;&nbsp;&nbsp; **No** &nbsp;&nbsp;&nbsp;&nbsp; **Not sure**

**A5.** What is one thing about choosing `INNER JOIN` vs. `LEFT JOIN`
that you are still not sure about?

`________________________________________________________________`

*Stop here. We compare answers together before you see Part B.*

---

## Part B (do this in 차시 3, about 15 minutes)

Your instructor will hand this out after the class discussion of Part A.
It starts with the real answer to A4, then asks you to explain it.

**The real answer to A4:** Yes. `LEFT JOIN` keeps every row from the
left table (`Student`), even when no match exists in `Enrollment`,
filling `grade` with `NULL` where no match exists. The student does
not disappear just because they have not enrolled in anything yet.

**B1.** Was your Part A prediction (A4) correct?

`Yes  /  No  /  Partly`

**B2.** Using the words **LEFT JOIN** and **NULL**, explain in 1-2
sentences why a student with zero enrollments still appears in the A3
result.

`________________________________________________________________`
`________________________________________________________________`

**B3.** The registrar now wants: "list every `Section`, its
`Course.title`, and how many students are enrolled in it, including
sections with zero students enrolled." Write the full query, using
`Section`, `Course`, and `Enrollment`.

`________________________________________________________________`
`________________________________________________________________`
`________________________________________________________________`

**B4.** The registrar also wants: "list every `Instructor`'s name and
the number of `Section`s they teach, including instructors teaching
nothing this semester." Which JOIN type do you need, and why? Then
write the query.

`________________________________________________________________`
`________________________________________________________________`
`________________________________________________________________`

**B5 (stretch, optional).** Write a query listing the `student_id` and
enrollment count for every student who is enrolled in **more than 2**
sections this semester. (Hint: this needs `GROUP BY` and a filter on
an aggregate — which filter clause does that require?)

`________________________________________________________________`
`________________________________________________________________`
