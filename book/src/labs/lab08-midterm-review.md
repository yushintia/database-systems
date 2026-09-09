# Lab 08: Midterm Review

| | |
|---|---|
| **Week** | 8 |
| **Duration** | 150 min (review, then Midterm Exam) |
| **Method** | Review — no new content |
| **Scope** | Weeks 1-7 (DBMS fundamentals through normalization — the entire design half of the course) |
| **Weight** | **30%** of the final grade |

**Why this lab matters:** Weeks 1 through 7 are the complete design
half of this course: why a DBMS exists, what a table precisely is,
how to design one, how to notate that design, how to turn it into
tables mechanically, and how to check those tables for anomalies.
Weeks 9 onward build real MySQL on top of exactly this foundation. If
any piece of it is shaky, this is the checkpoint to fix it — before
the second half of the course starts assuming it's solid.

---

## Exam Format

- **Written, individual, closed book.** Covers Weeks 1 through 7.
- **Scope reminder:** the seven weeks are one continuous argument
  (why a DBMS exists, what a table precisely is, how to design one,
  how to notate that design, then how to turn the design into tables
  and check it for redundancy). If a question feels disconnected from
  the others, find where it sits on that chain first.
- **Question style:** most questions ask you to *apply* a rule to a
  small scenario (map this relationship, normalize this table,
  justify this design choice), not just define a term.

---

## Learning Outcomes Being Assessed

This exam assesses all outcomes from Weeks 1 through 7:

1. Explain why plain files and spreadsheets fail as data grows, and
   what a database promises instead.
2. Define a relation, key, and the three integrity constraints
   precisely, and apply them to a small schema.
3. Name the three design stages and distinguish them from Week 1's
   abstraction levels.
4. Model a small requirement as an E-R diagram, with correct
   cardinality and weak entities.
5. Apply the mapping algorithm (Rules 1-4) to turn a diagram into a
   relational schema.
6. Test a relation against 1NF, 2NF, and 3NF, and normalize a
   relation that fails.

---

## What to Bring

- A pen and the reference sheet provided by the instructor, if one is
  distributed.
- No notes, no phone, no laptop — this is closed-book.

---

## Sample Practice Problems

> These are **not** the actual exam questions, but they are
> representative in scope and style. Full worked explanations for
> these and more are below, in this same review guide; your instructor
> will share a consolidated answer key after the exam.

**Practice 1 (Week 1/2).** Two of Week 1's seven failures of
file-based systems — atomicity problems and concurrent-access
anomalies — share the exact same fix. Name it, and explain why one
mechanism solves both.

**Practice 2 (Week 2).** Explain the difference between a superkey, a
candidate key, and a primary key — and how a foreign key differs from
all three.

**Practice 3 (Week 4).** What is a weak entity, and how does the
registration system's `Enrollment` resolve Student M:N Section using
one?

**Practice 4 (Week 6).** Draw, in words, the mapping for a 1:N
relationship between `Department` (1) and `Instructor` (N).

**Practice 5 (Week 7).** `Enrollment(student_id, section_id, grade,
room)`, where `room` depends only on `section_id`. Name the normal
form violated, and fix it.

**Practice 6 (Week 7).** A table `Section(section_id, course_code,
course_title, room)` is proposed, with `course_title` copied in
directly. Which Week 1 failure does this recreate, and which normal
form catches it?

---

## Exam Rubric

Unlike a graded lab (10 points, split across guided exercises), the
midterm is scored per question against a written rubric the
instructor distributes with results. As a general pattern, expect
each question to be scored on:

| Criterion | What earns full marks |
|---|---|
| **Correct rule/term identified** | The right normal form, mapping rule, or constraint is named, not just something in the neighborhood |
| **Correct application** | The rule is applied accurately to the specific scenario in the question, not just restated abstractly |
| **Justification** | Where a question asks "why" or "explain," the reasoning is stated clearly, not just the final answer |

---

## Common Midterm Mistakes to Avoid

- **Skipping the "why" behind a rule.** Questions often ask you to
  justify a design choice, not just state it — know the reasoning,
  not only the vocabulary.
- **Mixing up 2NF and 3NF.** 2NF concerns a composite key's parts;
  3NF concerns non-key attributes depending on each other.
- **Confusing Week 1's abstraction levels with Week 3's design
  stages.** They rhyme on purpose; a question testing one is not
  testing the other.
- **Forgetting cardinality on a diagram question.** Every
  relationship needs an explicit 1:1, 1:N, or M:N, every time.

---

## After the Exam

Results and feedback are returned within one week, with item-analysis
shared for weak-topic guidance (see the Introduction's Feedback
Policy). Week 9 begins the implementation half of the course: real
MySQL, starting from the exact schema this exam is built around. If
mapping or normalization still feels shaky after the exam, that is
the half of the course the rest of the semester builds directly on
top of — revisit Lab 06 and Lab 07 before Week 9.

---

## Further Reading

- Review Lab 01 through Lab 07, especially each lab's Worked Example
  and Common Pitfalls sections. This page's own worked explanations,
  above, cover every practice problem in full.
