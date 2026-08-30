# Professor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** `INSERT INTO Student (name, major) VALUES ('Yoon Areum', 'Computer Science');`
- **A2:** `INSERT INTO Enrollment (student_id, section_id, grade) VALUES (15, 2, NULL);` — watch for pairs forgetting `NULL` and instead writing `0` or an empty string for the grade; both are wrong, `NULL` specifically means "not graded yet"
- **A3:** `SELECT * FROM Instructor WHERE instructor_id = 2;` then `UPDATE Instructor SET name = 'Prof. Han, Ph.D.' WHERE instructor_id = 2;` — watch for pairs who write the `UPDATE` with no `WHERE` clause at all, that is exactly this week's most common mistake
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many pairs will guess "Yes, it just adds a row" — that is the expected wrong guess, and the whole point of the "not sure yet" moment. Do **not** confirm or deny the answer yet
- **A5:** Good answers mention: uncertainty about when a `WHERE` clause is required, confusion about insert order across tables, or uncertainty about `NULL` vs. an empty value. Any honest gap is a success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here, just self-checking
- **B2 (model answer):** "`instructor_id` in `Section` is a foreign key, so it must already exist as a primary key value in `Instructor`. MySQL enforces insert order: the referenced row in `Instructor` must be inserted before any `Section` row that points at it."
- **B3 (model answer):**
  ```sql
  INSERT INTO Instructor (name) VALUES ('Prof. Song');
  -- MySQL assigns instructor_id = 20

  INSERT INTO Section (course_code, instructor_id, room, semester)
  VALUES ('CSE450', 20, '성파 900', '2026-2');
  ```
- **B4 (model answer):** "MySQL rejects the `DELETE`. Removing `section_id = 6` while `Enrollment` rows still reference it would leave those rows pointing at a section that no longer exists — an orphaned row. Referential integrity blocks this by default; the `Enrollment` rows must be removed or reassigned first."
- **B5 (model answer):**
  ```sql
  INSERT INTO Student (name, major) VALUES
      ('Baek Hyun', 'Software Engineering'),
      ('Cho Eunji', 'Computer Science'),
      ('Nam Taeyang', 'Data Science');
  ```

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's "Optional Reading" section
- Watch especially for two recurring mistakes during Part A: an `UPDATE`/`DELETE` written with no `WHERE` clause, and an `INSERT` written in the wrong table order relative to its foreign keys. Both are worth a quick verbal flag on the spot, without giving away A4's answer early
