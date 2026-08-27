---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 5: Quiz 1

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: Short-review variant per SPINE.md: Act 0, expanded review, Act 4. No new pain/ground content, nothing new is being taught today. -->

---

<!-- SLOT 2: Where we are -->

# Where We Are

<div class="roadmap">
<div class="wk"><div class="n">Wk 1</div><div class="t">Introduction</div></div>
<div class="wk"><div class="n">Wk 2</div><div class="t">Relational Model</div></div>
<div class="wk"><div class="n">Wk 3</div><div class="t">Data Modelling</div></div>
<div class="wk"><div class="n">Wk 4</div><div class="t">E-R Diagram</div></div>
<div class="wk review now"><div class="n">Wk 5</div><div class="t">Quiz 1</div></div>
<div class="wk"><div class="n">Wk 6</div><div class="t">Mapping Algorithm</div></div>
<div class="wk"><div class="n">Wk 7</div><div class="t">Normalization</div></div>
<div class="wk review"><div class="n">Wk 8</div><div class="t">Midterm Exam</div></div>
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

# Four Weeks, One Argument

<div class="thread">Not four separate topics. One continuous argument, restated in one line each.</div>

| Wk | Question it answered |
|---|---|
| 1 | Why does a DBMS need to exist at all? |
| 2 | What exactly is a table, precisely? |
| 3 | What process turns requirements into a design? |
| 4 | What notation makes that design checkable? |

---

# The Same Argument, as a Chain

<div class="thread">Each week's limit became the next week's pain. Here is the visual version.</div>

<div class="pipeline">
<div class="stage"><div class="h">Wk 1</div><div class="s">why a DBMS at all</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Wk 2</div><div class="s">what a table precisely is</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Wk 3</div><div class="s">how to design one</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Wk 4</div><div class="s">how to notate that design</div></div>
</div>

If a quiz question feels disconnected from the others, it is not,
find where it sits on this chain first.

---

<!-- _class: section -->

# Quiz 1 Today
<div class="driving-q">Weeks 1-4. Written, individual, closed book.</div>

---

# Review: Week 1 Core Terms

<div class="cardlist">
<div class="card"><div class="h">DBMS</div><div class="d">software that lets users define, create, maintain, and control access to a database, correctly, even with many users at once</div></div>
<div class="card"><div class="h">Three abstraction levels</div><div class="d">physical (bytes on disk), logical (what data exists), view (what one user sees)</div></div>
<div class="card"><div class="h">Schema vs. instance</div><div class="d">schema is the fixed design, instance is the data at a given moment</div></div>
<div class="card"><div class="h">Silberschatz's seven failures</div><div class="d">redundancy and inconsistency, difficulty accessing data, data isolation, integrity problems, atomicity problems, concurrent-access anomalies, security problems</div></div>
</div>

---

# Review: Week 2 Core Terms

<div class="cardlist">
<div class="card"><div class="h">Relation</div><div class="d">a set of tuples conforming to a schema, no duplicate tuples, no meaningful row order</div></div>
<div class="card"><div class="h">Attribute, domain, tuple</div><div class="d">a named column, its set of legal values, and one row</div></div>
<div class="card"><div class="h">Superkey, candidate key, primary key</div><div class="d">a uniquely-identifying attribute set, its minimal form, and the one chosen as the main identifier</div></div>
<div class="card"><div class="h">Foreign key</div><div class="d">an attribute referencing another relation's primary key</div></div>
<div class="card"><div class="h">Three integrity constraints</div><div class="d">domain, key, referential</div></div>
</div>

---

# Review: Week 2, Worked Example

<div class="thread">The terms above, applied in one breath, the way a quiz question will ask.</div>

`Enrollment(student_id, section_id, grade)`, `PRIMARY KEY
(student_id, section_id)`.

- `{student_id, section_id}` is the **candidate key** (and primary key)
- `student_id` alone is a **foreign key** to `Student`
- `section_id` alone is a **foreign key** to `Section`
- `grade IN ('A0','B+','B0','C+','F')` is a **domain constraint**

---

# Review: Week 3 Core Terms

- **Data modeling:** the process of turning real-world requirements
  into a structured description of data, before any table exists
- **Three design stages:** conceptual (what exists), logical (a
  relational schema), physical (how it is stored)
- Not the same three as Week 1's abstraction levels: one is a one-time
  building process, the other is an ongoing running structure

---

# Review: Week 4 Core Terms

- **Entity, attribute, relationship:** a tracked real-world thing, a
  property of it, and an association between entities
- **Cardinality:** 1:1, 1:N, or M:N, stated explicitly on every
  relationship
- **Weak entity:** has no independent key, borrows identity from the
  entities it connects (Enrollment, from Student and Section)

---

# Review: Week 4, Worked Example

<div class="thread">Cardinality and weak entities, in the exact shape a quiz question takes.</div>

"A TA can help with many Sections; a Section can have many TAs."

- Entities: `TA`, `Section`
- Cardinality: **M:N**
- Resolution: a weak entity, `TA_Section(ta_id, section_id)`, the
  same shape as `Enrollment`

---

# Sample Question 1

**Question:** `Course(course_code, title, credits)`. A new requirement
says every course must belong to exactly one department, and a
department offers many courses. Draw the cardinality between Course
and a new Department entity.

**Answer:** **N:1** from Course to Department (many courses, one
department each); equivalently **1:N** from Department to Course.

---

# Sample Question 2

**Question:** Explain, in one sentence, why `Enrollment` is a weak
entity rather than a strong entity.

**Answer:** It has no key attribute of its own; it can only be
identified by the combination of `student_id` and `section_id`
borrowed from Student and Section.

---

# Sample Question 3

**Question:** A relation `Student(student_id, name, name)` lists the
`name` attribute twice by mistake. Which rule from Week 2 does this
violate, and why?

**Answer:** A relation schema is a **set** of attributes; a set cannot
contain the same element twice. Listing `name` twice is not a minor
typo, it violates the definition of a relation schema itself.

---

# Sample Question 4

**Question:** Name one thing conceptual design (Week 3) and an E-R
diagram (Week 4) have in common, and one thing that separates them.

**Answer:** **Common:** both describe the system before any relation
exists. **Different:** conceptual design, in prose, is not verifiable;
an E-R diagram, in Chen's notation, is, that gap is exactly Week 4's
driving question.

---

# Sample Question 5

**Question:** `Instructor(instructor_id, name, office)`. A colleague
proposes `{name, office}` as the primary key instead of
`instructor_id`. Give one concrete reason this is a worse choice.

**Answer:** Two instructors could share an office temporarily, or a
name could repeat, breaking the key constraint; `instructor_id` is
system-generated and can never collide, exactly Week 2's warning
against using a name as a primary key.

---

# Sample Question 6

**Question:** A physical-level change (new disks) should not affect
the view level, according to Week 1. Which Week 2 or Week 3 idea makes
that guarantee possible in practice?

**Answer:** **Data independence** (Week 2), enforced through the three
abstraction levels (Week 1) and formalized as separate physical and
logical design stages (Week 3): the application only ever talks to the
logical level, never the physical one directly.

---

# Common Quiz Mistakes to Avoid

- **Answering with a definition, not an application:** "what is a
  foreign key" wants the definition; "identify the foreign key in this
  relation" wants you to point at one, read the question carefully
- **Confusing Week 1's abstraction levels with Week 3's design stages:**
  they rhyme on purpose, a quiz question testing one is not testing
  the other
- **Skipping cardinality on a relationship:** if a question asks you to
  draw or describe a relationship, always state 1:1, 1:N, or M:N
  explicitly, never leave it implied

---

<!-- SLOT 14 equivalent: What to focus on next, replaces Limits for review weeks -->

# What to Focus On Next

<div class="limits">
Weeks 1 through 4 built the vocabulary and the design process. Week 6
starts turning today's E-R diagrams into real tables, mechanically. If
any term on this review felt shaky, especially cardinality or weak
entities, revisit it before Week 6: the mapping algorithm assumes all
of it is already solid.
</div>

---

# Next Week

Week 6, **Mapping Algorithm**, takes the E-R diagram from Week 4 and
turns it into a relational schema, one deterministic rule at a time.

---

# Summary

- Quiz 1 covers Weeks 1 through 4: DBMS fundamentals, the relational
  model's vocabulary, the data modeling process, and E-R diagrams.
- The four weeks are one argument: why a DBMS exists, what a table
  precisely is, how to design one, and how to notate that design.
- **Prepare:** review all four weeks' Check Yourself slides before the
  quiz; they are representative of today's sample questions.

---

<!-- _class: end -->

# Thank You
