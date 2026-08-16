---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 8: Midterm Exam

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: Short-review variant per SPINE.md. Covers Weeks 1-7, the entire design half of the course. -->

---

<!-- SLOT 2: Where we are -->

# Where We Are

<div class="roadmap">
<div class="wk"><div class="n">Wk 1</div><div class="t">Introduction</div></div>
<div class="wk"><div class="n">Wk 2</div><div class="t">Relational Model</div></div>
<div class="wk"><div class="n">Wk 3</div><div class="t">Data Modelling</div></div>
<div class="wk"><div class="n">Wk 4</div><div class="t">E-R Diagram</div></div>
<div class="wk review"><div class="n">Wk 5</div><div class="t">Quiz 1</div></div>
<div class="wk"><div class="n">Wk 6</div><div class="t">Mapping Algorithm</div></div>
<div class="wk"><div class="n">Wk 7</div><div class="t">Normalization</div></div>
<div class="wk review now"><div class="n">Wk 8</div><div class="t">Midterm Exam</div></div>
<div class="wk"><div class="n">Wk 9</div><div class="t">DDL</div></div>
<div class="wk"><div class="n">Wk 10</div><div class="t">DML</div></div>
<div class="wk"><div class="n">Wk 11</div><div class="t">Single-table Queries</div></div>
<div class="wk"><div class="n">Wk 12</div><div class="t">Multi-table Queries</div></div>
<div class="wk review"><div class="n">Wk 13</div><div class="t">Quiz 2</div></div>
<div class="wk"><div class="n">Wk 14</div><div class="t">Case Study Presentation</div></div>
<div class="wk review"><div class="n">Wk 15</div><div class="t">Final Exam</div></div>
</div>

---

<!-- SLOT 3: Recap -->

# Seven Weeks: The Whole Design Half of the Course

<div class="thread">Everything up to today is design. Everything after today is building. Today is the line between them.</div>

<div class="pipeline">
<div class="stage"><div class="h">Why</div><div class="s">Wk 1: why a DBMS</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Vocabulary</div><div class="s">Wk 2: what a table is</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Process</div><div class="s">Wk 3: how to design</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Notation</div><div class="s">Wk 4: E-R diagrams</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Mechanics</div><div class="s">Wk 6-7: mapping, normalizing</div></div>
</div>

---

<!-- _class: section -->

# Midterm Exam Today
<div class="driving-q">Weeks 1-7. Written, individual, closed book.</div>

---

# Review: The Seven Failures (Week 1)

| # | Failure | Fixed by |
|---|---|---|
| 1 | Redundancy & inconsistency | Relations, normalization |
| 2 | Difficulty accessing data | SQL, Weeks 9-12 |
| 3 | Data isolation | A single shared schema |
| 4 | Integrity problems | Domain, key, referential constraints |
| 5 | Atomicity problems | Transaction manager |
| 6 | Concurrent-access anomalies | Transaction manager |
| 7 | Security problems | The view level, access control |

---

# Review: The Relational Model (Week 2)

- A **relation** is a set of tuples conforming to a schema; no
  duplicates, no meaningful order
- **Superkey, candidate key, primary key, foreign key**: uniquely
  identifying attribute sets, and the mechanism connecting two relations
- **Three integrity constraints**: domain, key, referential

---

# Review: Design Process and Notation (Weeks 3-4)

- **Three design stages:** conceptual, logical, physical, not the same
  as Week 1's abstraction levels, though they rhyme
- **Entity, attribute, relationship, cardinality**: the building
  blocks of an E-R diagram, precise enough to be checked
- **Weak entity:** no independent key, identity borrowed from the
  entities it connects

---

# Review: Weeks 3-4, Worked Example

<div class="thread">The full arc from a sentence to a diagram, in one slide.</div>

"A student enrolls in one or more sections."

- **Conceptual (Wk 3):** Student and Section exist; a Student enrolls
  in a Section
- **E-R notation (Wk 4):** Student M:N Section, resolved by the weak
  entity Enrollment

---

# Review: Mapping and Normalization (Weeks 6-7)

- **Mapping algorithm:** strong entity to relation, weak entity to
  relation with composite key, 1:N to a foreign key, M:N to a new
  relation with composite key
- **Functional dependency:** A &rarr; B, one value of A always
  determines one value of B
- **1NF, 2NF, 3NF**: no repeating groups, no partial dependency on a
  composite key, no transitive dependency between non-key attributes

---

# Review: Weeks 6-7, Worked Example

<div class="thread">The same E-R fact, mapped, then checked against every normal form.</div>

Enrollment maps to `Enrollment(student_id, section_id, grade)`,
`PRIMARY KEY (student_id, section_id)` (Week 6, Rules 3 and 4 agree).

Checked against normalization: 1NF (no repeating groups), 2NF (`grade`
depends on the full composite key), 3NF (no transitive dependency,
`grade` depends on nothing but the key). Already normalized, because
Week 6 never copied an attribute across relations.

---

# Sample Question 1

**Question:** `Enrollment(student_id, section_id, grade, room)`, where
`room` depends only on `section_id`. Name the normal form violated, and
fix it.

**Answer:** **2NF**, a partial dependency (`room` depends on part of
the composite key, not the whole key). Fix: move `room` into `Section`,
where it depends on `section_id` alone, the full key of that relation.

---

# Sample Question 2

**Question:** Draw, in words, the mapping for a 1:N relationship
between Department (1) and Instructor (N).

**Answer:** No new relation is created. `Instructor` receives a foreign
key, `department_id`, referencing `Department.department_id`. The
foreign key always goes on the "many" side.

---

# Sample Question 3

**Question:** A table `Section(section_id, course_code, course_title,
room)` is proposed, with `course_title` copied in directly. Which
Week 1 failure does this recreate, and which normal form catches it?

**Answer:** **Redundancy and inconsistency** (Week 1's first failure).
**3NF** catches it: `section_id &rarr; course_code &rarr;
course_title` is a transitive dependency.

---

# Sample Question 4

**Question:** Explain why Week 1's abstraction levels and Week 3's
design stages use different words (view/logical/physical versus
conceptual/logical/physical) even though they overlap conceptually.

**Answer:** They answer different questions: abstraction levels
describe an already-running system's three faces; design stages
describe the one-time process of building it. The word "logical"
appears in both because both describe "what data exists," from two
different angles, running system versus building process.

---

# Sample Question 5

**Question:** Give one example of a functional dependency that is
**not** related to the registration system.

**Answer:** Any correct example works, for instance: a national ID
number determines exactly one legal name (`id_number &rarr; name`), or
a barcode determines exactly one product. The concept generalizes
beyond any one schema.

---

# Common Midterm Mistakes to Avoid

- **Skipping the "why" behind a rule:** questions often ask you to
  justify a design choice, not just state it, know the reasoning, not
  only the vocabulary
- **Mixing up 2NF and 3NF:** 2NF concerns a composite key's parts;
  3NF concerns non-key attributes depending on each other
- **Forgetting cardinality on a diagram question:** every relationship
  needs an explicit 1:1, 1:N, or M:N, every time

---

<!-- What to focus on next -->

# What to Focus On Next

<div class="limits">
Everything through Week 7 produces a design, on paper. Nothing so far
has created a single real table. Week 9 begins the second half of the
course: turning this design into a running MySQL database. If mapping
or normalization still feels shaky, that is the half of the course this
exam covers, and the half the rest of the semester builds directly on
top of.
</div>

---

# Next Week

Week 9, **DDL**, begins the implementation half of the course: real
MySQL commands, `CREATE TABLE` for the exact schema this exam is built
around.

---

# Summary

- The Midterm covers Weeks 1 through 7: why a DBMS exists, the
  relational model's vocabulary, the design process, E-R notation, the
  mapping algorithm, and normalization.
- This is the complete design half of the course. Weeks 9 through 12
  build on top of it, in MySQL, starting next week.
- **Prepare:** review every Worked Example slide across Weeks 1-7; the
  exam draws heavily on applying rules to the registration system.

---

<!-- _class: end -->

# Thank You
