# Lab 07 Answer Key: 3NF Decomposition (Part 2) and Challenge

Instructor/grader reference. Do not distribute before grading.

## Part 2: Decomposing `Section`

Starting relation: `Section(section_id, course_code, course_title,
instructor_id, instructor_name, room, semester)`.

1. **1NF:** Passes. Every attribute holds a single, atomic value; no
   repeating groups.
2. **2NF:** Passes automatically. The primary key, `section_id`, is a
   single column — there is no "part of the key" for anything to
   depend on, so 2NF cannot be violated here.
3. **3NF:** Fails, twice.
   - `section_id -> course_code -> course_title`: `course_title`
     depends on `course_code`, not directly on `section_id`.
   - `section_id -> instructor_id -> instructor_name`:
     `instructor_name` depends on `instructor_id`, not directly on
     `section_id`.
4. **Decomposition:**

   ```
   Section(section_id, course_code, instructor_id, room, semester)
     PRIMARY KEY (section_id)
     FOREIGN KEY (course_code) REFERENCES Course(course_code)
     FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)

   Course(course_code, title)
     PRIMARY KEY (course_code)

   Instructor(instructor_id, name)
     PRIMARY KEY (instructor_id)
   ```

5. **Confirmation:** matches `book/src/labs/files/lab06/target_schema.sql`'s
   `Section`, `Course`, and `Instructor` relations exactly (column
   names `title` and `name` in the target schema correspond to
   `course_title`/`instructor_name` here, minus the redundant
   copies).

## Challenge: Normalizing `Waitlist`

Starting relation: `Waitlist(student_id, section_id, student_name,
course_title, position)`.

1. **1NF:** Passes. No repeating groups, every attribute atomic.
2. **2NF:** The key is `{student_id, section_id}` (composite).
   `student_name` depends only on `student_id`; `course_title`
   depends only on `section_id` (via `Section`, via `Course`). Both
   are **partial dependencies** — **fails 2NF**.
3. **3NF:** Cannot be meaningfully checked until 2NF is fixed, since
   2NF violations must be resolved first.
4. **Decomposition:**

   ```
   Waitlist(student_id, section_id, position)
     PRIMARY KEY (student_id, section_id)

   -- student_name already belongs in Student(student_id, name, major)
   -- course_title already belongs in Course(course_code, title),
   --   reachable through Section.course_code
   ```

5. **Confirmation:** matches Lab 06's `Waitlist(student_id,
   section_id, position, date_joined)` in every column except
   `date_joined`, which this denormalized version of the table never
   collected to begin with — expected, not an error, since the two
   versions started from different attribute lists.

## Grading Notes

- Full credit for Part 2 requires all three normal-form checks
  stated with correct pass/fail and correct justification, plus a
  fully-declared decomposition (every `PRIMARY KEY`, every relevant
  `FOREIGN KEY`).
- A common mistake to watch for: students sometimes claim `Section`
  fails 2NF because "it has a lot of columns." Confirm they can state
  *why* a single-column key passes 2NF automatically — if they can't,
  they have not actually understood 2NF, even if they got this
  particular answer right by guessing.
- For the Challenge, accept minor rewording of the 2NF violation
  explanation, but require both partial dependencies to be named
  separately (`student_name` on `student_id`; `course_title` on
  `section_id`) — a single vague "some columns are redundant" does
  not earn full credit.
