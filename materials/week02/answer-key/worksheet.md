# Professor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** At least three things: a student (`name`, `major`), a course
  (`course_code`, `course_title`), and an enrollment fact (`grade`,
  tying a specific student to a specific course)
- **A2:** `name`, `major` only — `course_code`, `course_title`,
  `instructor`, `room`, `grade` all belong elsewhere
- **A3:** `Student(student_id, name, major)`, with `student_id` as a
  system-generated key. Accept close variants; the key point is adding
  an ID rather than using `name` alone
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "Yes, once we know the schema rules, we
  automatically know which tables to build" — that is the expected
  wrong guess, and the whole point of the "not sure yet" moment. Do
  **not** confirm or deny the answer yet
- **A5:** Good answers mention: uncertainty about where `grade`
  belongs, confusion between superkey and candidate key, or not being
  sure how foreign keys connect two relations. Any honest gap is a
  success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "A relation schema just fixes a name and a
  set of attributes with domains, and a key constraint just says
  primary key values can't repeat — neither rule says which facts
  belong in which schema. Both `grade`-in-`Student` and
  `grade`-in-its-own-relation can obey every rule we learned this
  week, so the vocabulary alone can't pick between them."
- **B3 (model answer):** `Course`: `{course_code}` is both a candidate
  key and the primary key. `Instructor`: `{instructor_id}` is both a
  candidate key and the primary key.
- **B4 (model answer):** "This breaks referential integrity. The
  foreign key `student_id` in `Enrollment` must match an existing
  primary key value in `Student`, or be left empty. A row pointing at
  `student_id = 999` with no matching student is an orphaned,
  meaningless row."
- **B5:** No single correct answer is required this week — this is
  intentionally forward-looking. Accept any reasoning. A common good
  guess: `Section` might need its own `section_id` (since the same
  course can have multiple sections), and `Enrollment` might need a
  key made of more than one attribute together (a student plus a
  section), since neither one alone is unique. Do not confirm the
  final schema — Week 4 covers this formally.

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section
