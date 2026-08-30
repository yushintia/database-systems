# Professor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** `student_id → student_name` and `section_id → course_title`
- **A2:** Yes. No repeating groups, no lists inside a cell — every
  attribute holds one atomic value
- **A3:** `student_name` depends only on `student_id`, not on the whole
  key `{student_id, section_id}` — a **partial dependency**, a 2NF
  violation
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "Yes, we already fixed the key problem" — that is
  the expected wrong guess, and the whole point of the "not sure yet"
  moment. Do **not** confirm or deny the answer yet
- **A5:** Good answers mention: confusing which attributes count as
  "the whole key" vs. "another non-key attribute," or uncertainty about
  why a single-column key always passes 2NF automatically. Any honest
  gap is a success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "`instructor_name` depends on `instructor_id`,
  not directly on `section_id`, so it is a transitive dependency —
  `section_id → instructor_id → instructor_name`. That violates 3NF
  even though `Section`'s single-column key means 2NF was never at
  risk, which is why passing 2NF alone is not enough."
- **B3 (model answer):** `Waitlist(student_id, section_id, position)`;
  `student_name` moves to `Student(student_id, name, major)`;
  `course_title` moves to `Course(course_code, title)`, reachable
  through `Section`. `PRIMARY KEY (student_id, section_id)` on
  `Waitlist`.
- **B4 (model answer):** `Section(section_id, course_code,
  instructor_id, room, semester)`, `PRIMARY KEY (section_id)`;
  `Course(course_code, title)`, `PRIMARY KEY (course_code)`;
  `Instructor(instructor_id, name)`, `PRIMARY KEY (instructor_id)`.
  Both `course_title` and `instructor_name` were removed as transitive
  dependencies (3NF violations) on `section_id`.
- **B5 (model answer):** `employee_id → department_id →
  department_manager` is transitive — a **3NF violation**. Fix: move
  `department_manager` into its own `Department(department_id,
  manager)` relation.

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- The A4 trap is deliberate: students often think "fixing 2NF" means
  the relation is done. Use the discussion between Part A and Part B to
  surface this before revealing the answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section
