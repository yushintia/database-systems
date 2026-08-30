# Professor Answer Key — do not hand out this section

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
