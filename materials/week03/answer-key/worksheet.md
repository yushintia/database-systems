# Professor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** Student, Section, Instructor
- **A2:** a Student enrolls in a Section; a Section is taught by one
  Instructor
- **A3:** Conceptual — no table names or data types appear anywhere in
  A1/A2
- **A4/A5:** Accept any prediction if reasoning is coherent. Many pairs
  will guess "No, if it follows all the rules it must be a good
  design" — that is the expected wrong guess, and the whole point of
  the "not sure yet" moment. Do **not** confirm or deny the answer yet
- **A5:** Good answers mention: not knowing how many relations to
  split into, uncertainty about which facts belong together, or
  general unease about "how many is right." Any honest gap is a
  success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "Week 2's rules only check that each relation
  is internally valid — a primary key exists, attributes are there.
  They say nothing about whether the *right* real-world requirements
  were captured, or captured in the right shape, which is exactly what
  conceptual design checks before logical design ever starts."
- **B3 (model answer):** "Minimal redundancy. A student's major gets
  copied once per enrollment row instead of being stored once, in
  Student — the same redundancy problem from Week 1's spreadsheet,
  reintroduced by a design choice this early."
- **B4 (model answer):** "New entity: Waitlist entry. Facts: a Student
  joins a Waitlist for a Section; a Waitlist entry has a position (1st,
  2nd, 3rd in line)."
- **B5 (model answer):** "Performance problems discovered after launch
  are often physical-design mistakes made, or skipped, at design time.
  Waiting until it's slow to add indexes means diagnosing and fixing
  the problem on a live system, which is far more expensive than
  planning for it up front."

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section
