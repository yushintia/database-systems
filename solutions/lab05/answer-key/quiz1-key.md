# Lab 05 Answer Key: Multiple-Choice Self-Test (Weeks 2-4)

Consolidated from `materials/week02/answer-key/quiz.md`,
`materials/week03/answer-key/quiz.md`, and
`materials/week04/answer-key/quiz.md`. These quizzes are ungraded
self-checks; this key answers the "Self-Test: Multiple-Choice
Practice" section of `book/src/labs/lab05-quiz1-review.md`.

---

## Week 2: The Relational Model

1. **B** — a relation is a set of tuples, all conforming to the same
   relation schema.
2. **B** — a schema is the fixed shape (name and attributes); an
   instance is the actual set of tuples at a given moment.
3. **B** — a candidate key is a superkey with no unnecessary
   attributes; remove any one attribute and it stops being unique.
4. **B** — every foreign key value must match an existing primary key
   value in the referenced relation, or be left empty.
5. **C** — "A99" is not a legal value in the declared domain "A0
   through F," so this is a domain constraint violation.
6. **B** — a relation is defined as a set, and a set cannot contain
   the same element (tuple) twice.

---

## Week 3: Data Modelling

1. **B** — data modeling is the process of analyzing real-world
   requirements and expressing them as a structured description of
   the data, before any table is created.
2. **C** — Conceptual, then Logical, then Physical, in that order.
3. **C** — conceptual design identifies the real-world things a
   system must track, and how they relate, with no table names or
   data types yet.
4. **B** — logical design translates the conceptual model into a
   specific data model's structures: relations with attributes, keys,
   and constraints.
5. **C** — minimal redundancy means no fact is captured in two places
   by design.
6. **B** — abstraction levels describe an already-running system's
   ongoing structure, every day; design stages describe the one-time
   process of building that system in the first place.

---

## Week 4: E-R Diagram

1. **B** — an entity is a real-world thing, distinguishable from
   every other thing, that a system needs to track.
2. **C** — a composite attribute is made of smaller, meaningful
   parts, like `name` splitting into `first_name` and `last_name`.
3. **B** — 1:N; one Instructor relates to many Sections, and each of
   those many Sections relates back to exactly one Instructor.
4. **B** — a weak entity has no key attribute of its own; Enrollment's
   identity is borrowed from `{student_id, section_id}` together.
5. **B** — a single foreign key column can only point to one row on
   the other side, so it cannot represent "many relate to many" in
   both directions at once.
6. **C** — this is "making everything an entity": `room` should stay
   an attribute of Section unless the system needs to track rooms
   independently (capacity, building, its own schedule).

---

## Study Tip

If you missed a question, don't just memorize the letter — re-read
that week's "Why" explanation in `materials/weekNN/answer-key/quiz.md`
(the full versions of the answers above include reasoning, not just
the letter) and confirm you can re-derive the answer from the week's
core definition, not just recognize it.
