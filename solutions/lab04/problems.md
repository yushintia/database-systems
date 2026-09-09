# Lab 04 Problems — E-R Diagrams

Public restatement of Lab 04's hands-on activity. Full lab page:
`book/src/labs/lab04-er-diagram.md`. Notation reference:
`book/src/appendix/er-notation.md`.

**Assignment 1 is due this week** — see the course handbook for its
separate submission details. The items below are this lab's own
(separate) deliverables.

## Part 1: Draw the Full Diagram

Draw the complete registration system E-R diagram, including the
Waitlist thread, showing:

- All five entities: Student, Course, Instructor, Section, Enrollment
- The Waitlist entity and its relationship to Student and Section
- Explicit cardinality on every relationship
- Which entities are weak vs. strong
- At least one underlined key attribute per strong entity

Save as `lab04_er.png` (or `.drawio`, or a clear photo).

## Part 2: Peer-Review Swap

Trade diagrams with a partner. Review theirs against this checklist,
marking each item Pass / Fail / Partial with one sentence for any
Fail/Partial:

1. Entities present?
2. Cardinality typed correctly on every relationship?
3. Weak entities marked, with clear borrowed keys?
4. Every strong entity has an identified key?
5. At least one composite attribute shown?
6. Readable without the author explaining it out loud?

## Challenge Problem

A designer promotes `Room` to its own strong entity with its own
`room_id`, even though the current requirement only mentions a room as
a label on Section. Is this a mistake given today's requirements?
Under what additional requirement would it become correct?

## Deliverable

`lab04_review.md` (peer review + Challenge). Total: 10 points.
