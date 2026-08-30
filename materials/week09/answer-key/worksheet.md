# Professor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:**
  ```sql
  CREATE TABLE Instructor (
      instructor_id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(100) NOT NULL
  );
  ```
- **A2:**
  ```sql
  CREATE TABLE Course (
      course_code VARCHAR(10) PRIMARY KEY,
      title VARCHAR(150) NOT NULL
  );
  ```
- **A3:**
  ```sql
  CREATE TABLE Section (
      section_id INT AUTO_INCREMENT PRIMARY KEY,
      course_code VARCHAR(10),
      instructor_id INT,
      room VARCHAR(20),
      semester VARCHAR(20),
      FOREIGN KEY (course_code) REFERENCES Course(course_code),
      FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
  );
  ```
  Common mistakes to listen for: forgetting `NOT NULL` on `title` or
  `name`, forgetting `AUTO_INCREMENT` on the id columns, writing the
  `FOREIGN KEY` line with the wrong column names, or forgetting the
  parentheses around the referenced column.
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "Yes, it's just an empty table with some columns" —
  that is the expected wrong guess, and the whole point of the
  "not sure yet" moment. Do **not** confirm or deny the answer yet.
- **A5:** Good answers mention: uncertainty about whether order
  matters at all, confusion about what a foreign key actually checks,
  or not knowing what the error message would look like. Any honest
  gap is a success.

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking.
- **B2 (model answer):** "A foreign key enforces referential
  integrity: MySQL checks that the referenced table and column already
  exist before it will create the constraint. If `Instructor` does not
  exist yet, there is nothing for `Section`'s foreign key to point to,
  so the statement fails."
- **B3 (model answer):**
  ```sql
  CREATE TABLE Enrollment (
      student_id INT,
      section_id INT,
      grade VARCHAR(2),
      PRIMARY KEY (student_id, section_id),
      FOREIGN KEY (student_id) REFERENCES Student(student_id),
      FOREIGN KEY (section_id) REFERENCES Section(section_id)
  );
  ```
- **B4 (model answer):** 1. `Student` (or `Course` or `Instructor`, any
  order among these three) 2. `Course` 3. `Instructor` 4. `Section`
  (after `Course` and `Instructor`) 5. `Enrollment` (last, after
  `Student` and `Section`). Accept any ordering of `Student`, `Course`,
  `Instructor` in the first three slots, as long as `Section` comes
  after `Course`/`Instructor`, and `Enrollment` comes last.
- **B5 (model answer):**
  ```sql
  ALTER TABLE Student ADD COLUMN email VARCHAR(100) UNIQUE;
  ```

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain).
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting every SQL statement perfectly correct.
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section, or have them try running their B3/B4
  statements against a real MySQL instance if one is available in the
  room.
