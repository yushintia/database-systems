# Professor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** `Student(student_id, name, major)`, primary key `student_id`.
  A direct copy, no design decision
- **A2:** `Section` gets the foreign key `instructor_id`, referencing
  `Instructor.instructor_id`, by Rule 2 — the "many" side always holds
  the key
- **A3:** `(student_id, section_id)` — `Waitlist`'s own attributes plus
  the primary keys of both entities it depends on
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "No, a weak entity and an M:N relationship sound
  like different things" — that is the expected wrong guess, and the
  whole point of the "not sure yet" moment. Do **not** confirm or deny
  the answer yet
- **A5:** Good answers mention: uncertainty about why two different
  rules would agree, confusion about which attributes count as the
  weak entity's "own" attributes, or uncertainty about composite keys
  in general. Any honest gap is a success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "`Waitlist` needs the composite key
  `(student_id, section_id)` because that pair is what a foreign key
  points at from both `Student` and `Section` — a single `waitlist_id`
  would not, by itself, stop the same student from appearing twice on
  the same section's waitlist."
- **B3 (model answer):** `Waitlist(student_id, section_id, position,
  date_joined)` `PRIMARY KEY (student_id, section_id)`
- **B4 (model answer):** `Course` gets the foreign key,
  `department_id`, referencing `Department.department_id`, by Rule 2 —
  the "many" side always holds the key. (Mirrors the deck's own Check
  Yourself Q1; confirm pairs reach the same answer independently.)
- **B5 (model answer):** Rule 5 (1:1 relationship). The foreign key
  would go on `Student`, the optional side, since not every student has
  an advisor yet. Accept "either side" reasoning too — the deck states
  either side is technically valid, optional side is just the usual
  convention.

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section
