# Lab 05: Quiz 1 Review

| | |
|---|---|
| **Week** | 5 |
| **Duration** | 150 min (in-class review, then Quiz 1) |
| **Method** | Review — no new content |
| **Scope** | Weeks 1-4 (DBMS fundamentals, the relational model, data modelling, E-R diagrams) |
| **Weight** | Counted under **in-class items** (10% of the final grade) |

**Why this lab matters:** Weeks 1 through 4 are one continuous
argument, not four separate topics: why a DBMS needs to exist, what a
table precisely is, how to design one, and how to notate that design
so two people can check it against each other. Quiz 1 tests whether
that argument holds together in your head, not whether you can
recite four unrelated glossaries. This page is where you check that
before the quiz does.

---

## Learning Outcomes Being Assessed

Quiz 1 assesses outcomes from Weeks 1 through 4:

1. Explain why plain files and spreadsheets fail as data grows, and
   what a database promises instead (Week 1).
2. Define a relation, schema, key, and the three integrity
   constraints precisely (Week 2).
3. Name the three design stages and what each one produces (Week 3).
4. Model a small requirement as entities, attributes, relationships,
   and cardinality on an E-R diagram (Week 4).

---

## Quiz Format

Written, individual, closed book. Covers Weeks 1 through 4. If a
question feels disconnected from the others, it probably isn't — find
where it sits on the Week 1 &rarr; 2 &rarr; 3 &rarr; 4 chain first,
the same habit the Week 5 slides walk through.

---

## Topics to Review, by Week

- **Week 1 — Introduction:** the DBMS's job, the three abstraction
  levels (physical, logical, view), schema vs. instance, Silberschatz's
  seven failures of file-based systems.
- **Week 2 — Relational Model:** relation, tuple, attribute, domain;
  superkey, candidate key, primary key, foreign key; the three
  integrity constraints (domain, key, referential).
- **Week 3 — Data Modelling:** the three design stages (conceptual,
  logical, physical) and how they differ from Week 1's abstraction
  levels; the four "good design" tests (completeness, correctness,
  minimal redundancy, understandability).
- **Week 4 — E-R Diagram:** entity, attribute, relationship,
  cardinality (1:1, 1:N, M:N); weak entity, and why `Enrollment` is one.

---

## Review Questions

These are the same questions as the Week 5 review guide
(`materials/week05/review-guide.md`)'s "Check Yourself" set, with the
full worked explanation kept alongside each answer. Cover the answer
and try to re-derive it before reading on.

### Q1 (Week 2). A relation `Student(name, name, major)` lists the `name` attribute twice by mistake. Which rule does this violate, and why?

> **Answer:** A relation schema is a **set** of attributes; a set
> cannot contain the same element twice. Listing `name` twice is not
> a minor typo, it violates the definition of a relation schema
> itself.

**Common mistake:** treating this as a cosmetic rename instead of a
broken definition, or confusing it with "no duplicate tuples" (a rule
about rows, not columns).

### Q2 (Week 2). `Instructor(instructor_id, name, office)`. A colleague proposes `{name, office}` as the primary key instead of `instructor_id`. Give one concrete reason this is worse.

> **Answer:** Two instructors could share an office temporarily, or a
> name could repeat, breaking the key constraint. `instructor_id` is
> system-generated and can never collide.

**Common mistake:** judging a candidate key against only today's data
instead of every future instance of the relation — a key constraint
has to hold forever.

### Q3 (Week 3/4). Name one thing conceptual design (Week 3) and an E-R diagram (Week 4) have in common, and one thing that separates them.

> **Answer:** **Common:** both describe the system before any relation
> exists. **Different:** conceptual design, in prose, is not
> verifiable; an E-R diagram, in Chen's notation, is.

**Common mistake:** treating Week 3 and Week 4 as unrelated topics,
rather than the same design stage told twice — once in prose, once in
a checkable diagram.

### Q4 (Weeks 1-3). A physical-level change (new disks) should not affect the view level, per Week 1. Which Week 2 or Week 3 idea makes that guarantee possible?

> **Answer:** **Data independence** (Week 2), enforced through the
> three abstraction levels (Week 1) and formalized as separate
> physical and logical design stages (Week 3).

**Common mistake:** confusing Week 1's abstraction levels (an
already-running system's ongoing structure) with Week 3's design
stages (the one-time process of building it) — they rhyme on
purpose, but a question testing one is not testing the other.

### Q5 (Week 4). `Course(course_code, title, credits)`. Every course must belong to exactly one department; a department offers many courses. Draw the cardinality between Course and Department.

> **Answer:** **N:1** from Course to Department (many courses, one
> department each); equivalently **1:N** from Department to Course.

**Common mistake:** flipping which side is "N" and which is "1," or
skipping cardinality entirely and drawing a bare line.

### Q6 (Week 4). Explain, in one sentence, why `Enrollment` is a weak entity rather than a strong entity.

> **Answer:** It has no key attribute of its own; it can only be
> identified by the combination of `student_id` and `section_id`
> borrowed from Student and Section.

**Common mistake:** giving `Enrollment` its own independent
`enrollment_id`, which adds a key with no real-world meaning when
`{student_id, section_id}` already uniquely identifies the row.

---

## Self-Test: Multiple-Choice Practice

These are the same self-check quizzes you saw at the end of Weeks 2,
3, and 4 (ungraded then, still ungraded now), collected in one place.
Try them closed-book. The full answer key is in
`solutions/lab05/answer-key/quiz1-key.md` — do not open it until
you've written down an answer for every question.

**Week 2 (Relational Model):**

1. What is a relation, formally?
2. What is the difference between a relation schema and a relation
   instance?
3. Which of these best describes a candidate key?
4. In `Enrollment(student_id, course_code, grade)`, `student_id` is a
   foreign key referencing `Student.student_id`. What must be true
   for referential integrity to hold?
5. A `grade` column's domain is "A0 through F only." A row stores
   "A99." Which constraint does this violate?
6. Why can a relation never contain two identical tuples?

**Week 3 (Data Modelling):**

1. What is "data modeling"?
2. Put the three design stages in the correct order.
3. What does conceptual design focus on?
4. What does logical design produce, in this course's terms?
5. Which "good design" test does "no fact is captured in two places
   by design" describe?
6. How are Week 1's abstraction levels different from Week 3's design
   stages?

**Week 4 (E-R Diagram):**

1. What is an "entity"?
2. `name` can be split into `first_name` and `last_name`. What kind
   of attribute is that?
3. One Instructor teaches many Sections; each Section has exactly one
   Instructor. What cardinality is that?
4. What makes `Enrollment` a weak entity?
5. Why can't an M:N relationship be represented with a single foreign
   key on either side?
6. A designer adds `Room` to the diagram as its own entity, even
   though the requirement only says a Section happens "in a specific
   room." What mistake is this?

---

## Common Quiz Mistakes to Avoid

- **Answering with a definition, not an application.** "What is a
  foreign key" wants the definition; "identify the foreign key in
  this relation" wants you to point at one. Read the question.
- **Confusing Week 1's abstraction levels with Week 3's design
  stages.** They share two of three words on purpose — that does not
  make them the same list.
- **Skipping cardinality on a relationship.** Always state 1:1, 1:N,
  or M:N explicitly, never leave it implied by a bare line.
- **Tracing a question to only one week.** Some quiz questions
  (like Q4 above) deliberately cross two or three weeks. If an answer
  feels incomplete, ask which earlier week's idea is missing.

---

## Further Reading

- Re-read the "Check Yourself" and "Summary" slides from
  `slides/week01-introduction.md` through `slides/week04-er-diagram.md`.
- [Lab 01](lab01-intro-and-spreadsheet.md) through
  [Lab 04](lab04-er-diagram.md), especially each lab's Worked Example.
