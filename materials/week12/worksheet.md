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

---
---

# Instructor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:**
  ```sql
  SELECT Student.name, Enrollment.grade
  FROM Student
  JOIN Enrollment ON Student.student_id = Enrollment.student_id;
  ```
- **A2:** 500 rows. `INNER JOIN` returns one row per matching
  `Enrollment` row; the 20 students with zero enrollments contribute
  nothing, and `Student` rows are not deduplicated down to 280 — each
  enrollment row still produces its own output row
- **A3:**
  ```sql
  SELECT Student.name, Enrollment.grade
  FROM Student
  LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id;
  ```
  Common mistake here: writing `INNER JOIN` again, or writing
  `LEFT JOIN` but starting `FROM Enrollment` instead of `FROM Student`
  (which keeps the wrong side)
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "No, a JOIN only returns rows that match" — that is
  the expected wrong guess, carried over from A1's INNER JOIN result,
  and is exactly the point of the "not sure yet" moment. Do **not**
  confirm or deny the answer yet
- **A5:** Good answers mention: confusion about which table is "kept,"
  uncertainty about what `NULL` means in a joined result, or not being
  sure when a real report needs rows to disappear vs. stay. Any honest
  gap is a success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "LEFT JOIN keeps every row from the table
  named first (Student), even when there is no matching row in
  Enrollment. For those students, the columns that would have come
  from Enrollment, like grade, are filled with NULL instead of the row
  disappearing."
- **B3 (model answer):**
  ```sql
  SELECT Section.section_id, Course.title, COUNT(Enrollment.student_id) AS enrolled
  FROM Section
  JOIN Course ON Section.course_code = Course.course_code
  LEFT JOIN Enrollment ON Section.section_id = Enrollment.section_id
  GROUP BY Section.section_id, Course.title;
  ```
  `LEFT JOIN` from `Section` to `Enrollment` is required to keep
  sections with zero enrolled students; `COUNT(Enrollment.student_id)`
  (not `COUNT(*)`) correctly counts 0, not 1, for those sections
- **B4 (model answer):** `LEFT JOIN`, from `Instructor`. An
  `INNER JOIN` would silently drop any instructor with zero sections,
  exactly the rows this question needs kept.
  ```sql
  SELECT Instructor.name, COUNT(Section.section_id) AS sections_taught
  FROM Instructor
  LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
  GROUP BY Instructor.name;
  ```
- **B5 (model answer):**
  ```sql
  SELECT student_id, COUNT(*) AS enrollments
  FROM Enrollment
  GROUP BY student_id
  HAVING COUNT(*) > 2;
  ```
  `HAVING`, not `WHERE`, because the filter is on `COUNT(*)`, an
  aggregate that does not exist until after grouping

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Watch for the two most common real mistakes while circulating:
  forgetting the `ON` condition entirely (produces a huge, meaningless
  result), and writing `WHERE COUNT(*) > ...` instead of `HAVING`
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section, or have them attempt B3/B4 with `USING`
  instead of `ON` where the column names match
