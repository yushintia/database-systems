# Professor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** Student, Section, Instructor are entities (each tracked over
  time, has its own attributes). `Room` is **not** an entity here — it
  is one attribute of Section, unless the system needs to track rooms
  independently
- **A2:** `student_id` = key, `name` = composite (could split into
  `first_name`/`last_name`), `major` = simple
- **A3:** **1:N** — one Instructor, many Sections; each Section, exactly
  one Instructor
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "No, you'd need two separate lines, one for each
  direction" — that is the expected wrong guess, and the whole point of
  the "not sure yet" moment. Do **not** confirm or deny the answer yet
- **A5:** Good answers mention: not knowing how to draw "both
  directions at once," confusion about foreign keys not being enough,
  or uncertainty about what M:N actually looks like on a diagram. Any
  honest gap is a success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "The cardinality between Student and Section
  is M:N, and an M:N relationship can never be captured by a single
  foreign key on either side. Enrollment exists as its own weak
  entity so the M:N relationship has somewhere to live, with its
  identity borrowed from `{student_id, section_id}` together."
- **B3 (model answer):** "Weak entity. Neither `position` nor
  `date_joined` means anything without knowing which student and which
  section — its identity is borrowed from both, the same shape as
  Enrollment."
- **B4 (model answer):** "Entities: Member, Book, Copy. Member to Copy
  is 1:N at any given moment (one member can hold several copies out
  at once; each copy is checked out to at most one member at a time),
  via a weak entity, Loan."
- **B5 (model answer):** "Weak — a Ride has no independent meaning
  without both a Driver and a Rider. Ride can't be a foreign key on
  Driver because the relationship is M:N (many drivers, many riders,
  many rides), and M:N relationships can never be captured by a single
  foreign key on either side."

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section, and remind them Assignment 1 (an E-R
  diagram for a system of their choice) is due this week
