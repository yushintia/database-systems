# Week 3 Worksheet: Designing the Registration System, Stage by Stage

Database Systems (511783-001). Work with your pair. Write short
answers — full sentences are not required, but write enough that your
partner and the instructor can follow your thinking.

**Pair names:** ___________________________ / ___________________________

---

## Part A (do this in 차시 2, about 15 minutes)

Requirement, in plain language: "Every student enrolls in one or more
course sections, taught by an instructor, in a specific room."

**A1.** List the real-world things (entities) this sentence mentions.
Do not write any table names or column names yet.

`________________________________________________________________`

**A2.** Now list the facts (relationships) connecting them, in plain
language — for example, "a Student ___ a Section."

`________________________________________________________________`
`________________________________________________________________`

**A3.** Which design stage were you just doing in A1 and A2? Circle
one.

**Conceptual** &nbsp;&nbsp;&nbsp;&nbsp; **Logical** &nbsp;&nbsp;&nbsp;&nbsp; **Physical**

**A4.** Prediction: three designers each build a registration design
that correctly follows every rule from Week 2 — every relation has a
primary key, attributes, and integrity constraints. Can a design that
follows all of Week 2's rules still be a *bad* design? Circle one.

**Yes** &nbsp;&nbsp;&nbsp;&nbsp; **No** &nbsp;&nbsp;&nbsp;&nbsp; **Not sure**

**A5.** What is one thing about deciding "how many relations, split
which way" that you are still not sure about?

`________________________________________________________________`

*Stop here. We compare answers together before you see Part B.*

---

## Part B (do this in 차시 3, about 15 minutes)

Your instructor will hand this out after the class discussion of Part A.
It starts with the real answer to A4, then asks you to explain it.

**The real answer to A4:** Yes. All three competing registration
designs from class technically satisfy every Week 2 rule, but they
cannot all be right — a design can be perfectly valid by last week's
rulebook and still fail this week's four "good design" tests
(completeness, correctness, minimal redundancy, understandability).

**B1.** Was your Part A prediction (A4) correct?

`Yes  /  No  /  Partly`

**B2.** Using the words **requirements** and **conceptual design**,
explain in 1-2 sentences why following Week 2's rules is not enough by
itself to guarantee a good design.

`________________________________________________________________`
`________________________________________________________________`

**B3.** One designer proposes combining `Student` and `Enrollment`
into a single relation, so a student's major is copied into every
enrollment row. Which of the four "good design" tests does this fail,
and why?

`________________________________________________________________`

**B4.** The registration system needs a new waitlist feature (see the
class demo): "If a section is full, students can join a waitlist. When
a seat opens, the first student on the waitlist is offered it." Name
the one new entity this requirement introduces, and the two facts
connecting it to Student and Section.

`________________________________________________________________`
`________________________________________________________________`

**B5 (stretch, optional).** A team decides to skip physical design
entirely, planning to "add indexes later if it's slow." Using the
Common Mistakes idea from class, explain in 1-2 sentences why this is
risky.

`________________________________________________________________`

---
---

# Instructor Answer Key — do not hand out this section

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
