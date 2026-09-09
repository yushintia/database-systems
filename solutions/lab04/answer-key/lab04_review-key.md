# Lab 04 Answer Key — Model E-R Diagram Description (Professor Only)

Not linked from any public page. Since a real diagram file can't be
produced here, this describes the model diagram precisely enough to
grade a student's `lab04_er.png`/`.drawio` against it, plus model
answers for the peer-review Challenge Problem.

## Model Diagram, Described Precisely

**Strong entities** (single-line boxes), each with an underlined key
attribute:

- **Student** — key: `student_id` (underlined). Other attributes:
  `name` (composite: `first_name`, `last_name`), `major` (simple).
- **Course** — key: `course_code` (underlined). Other attribute:
  `title` (simple).
- **Instructor** — key: `instructor_id` (underlined). Other
  attribute: `name` (simple or composite, either is acceptable).
- **Section** — key: `section_id` (underlined). Other attributes:
  `room` (simple), `semester` (simple).

**Weak entities** (double-line boxes), each with a dashed or otherwise
distinguished "partial key" if the notation used supports one:

- **Enrollment** — no key attribute of its own; identity borrowed from
  `{Student.student_id, Section.section_id}` together. Other
  attribute: `grade` (simple, must be allowed to be missing/NULL).
- **Waitlist** — no key attribute of its own; identity borrowed from
  the same pair, `{Student.student_id, Section.section_id}`. Other
  attributes: `position` (simple), `date_joined` (simple).

**Relationships, with cardinality:**

- **Student M:N Section**, realized via the weak entity **Enrollment**
  (identifying/double-diamond connection to both Student and Section
  in Chen notation, or an M:N diamond labeled "Enrolls" if using a
  simpler notation variant — accept either, per
  `book/src/appendix/er-notation.md`'s stated conventions).
- **Student M:N Section**, realized via the *separate* weak entity
  **Waitlist** — this must be visually distinguishable from the
  Enrollment relationship, not merged into one connection. A diagram
  that draws only one M:N line between Student and Section, and
  attaches both Enrollment's and Waitlist's attributes to it, has
  failed to represent two different real-world facts as two different
  relationships — mark "Entities present?" and "Weak entities marked?"
  as Fail or Partial in that case.
- **Section N:1 Course** — many Sections, one Course each.
- **Section N:1 Instructor** — many Sections, one Instructor of record
  each (per the interview transcript: "not currently" team-taught).

## Grading Notes for the Peer-Review Checklist

- A diagram missing Waitlist entirely: **Fail** on "Entities present?"
  — Waitlist is easy to miss on a first read of the interview
  transcript, and this is exactly the mistake the checklist exists to
  catch.
- A diagram with unlabeled relationship lines: **Fail** on
  "Cardinality typed correctly?" regardless of how correct the
  underlying design otherwise is — SPINE's discipline is that
  cardinality must be *stated*, not implied.
- A diagram giving Enrollment or Waitlist its own surrogate key (e.g.
  `enrollment_id`) in addition to the borrowed composite key: mark
  "Weak entities marked?" as **Partial** — technically still
  functional, but defeats the purpose of showing borrowed identity, and
  is exactly Lab 04's own listed Common Pitfall.

## Challenge Problem Model Answer

Promoting `Room` to its own entity is **not justified by today's
requirements** — the registrar was explicit that room is "just a label
for now." It would become the *correct* choice under an additional
requirement such as: "the registrar's office needs to track each
room's seating capacity and check for scheduling conflicts when two
sections are assigned the same room at overlapping times" — at that
point Room has its own attributes and its own real-world identity
worth tracking independently, exactly the promotion rule stated in
Lab 04's Background.
