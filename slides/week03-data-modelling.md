---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 3: Data Modelling

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

---

<!-- SLOT 2: Where we are -->

# Where We Are

<div class="roadmap">
<div class="wk"><div class="n">Wk 1</div><div class="t">Introduction</div></div>
<div class="wk"><div class="n">Wk 2</div><div class="t">Relational Model</div></div>
<div class="wk now"><div class="n">Wk 3</div><div class="t">Data Modelling</div></div>
<div class="wk"><div class="n">Wk 4</div><div class="t">E-R Diagram</div></div>
<div class="wk review"><div class="n">Wk 5</div><div class="t">Quiz 1</div></div>
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

<!-- SLOT 3: Recap + open wound -->

# Last Week, This Week

- **Last week delivered:** a rigorous definition of what a table has
  to be - relations, attributes, tuples, keys, and the three integrity
  constraints, all enforced by definition, not by discipline.
- **Last week left broken:** tables are the target, but nothing so far
  says *which* tables. We loaded Week 1's messy spreadsheet into one
  raw table and still couldn't find a clean primary key in it.

---

<!-- SLOT 4: The pain, zero jargon -->

# Three People, Three Designs, All "Correct"

<div class="pain">

Three students each sit down separately and sketch a set of tables for
the registration system. Every one of them checks their own work
against last week's rules: does every table have a primary key? Yes.
Does every column have a clear set of allowed values? Yes.

One student makes three tables. Another makes six. A third combines
the student list and the enrollment list into one table, to "keep it
simple." All three pass every rule from last week. All three cannot be
right at once - and last week gave nobody a way to say which one is
better, or why.

</div>

---

# What This Actually Costs

- Two engineers on the same team can each build a technically valid
  design that quietly disagrees with the other's, and nobody notices
  until the two systems have to talk to each other
- A design that skips this step tends to miss a real-world requirement
  nobody thought to ask about - until the system is already live
- Redesigning a live database because a requirement was missed at the
  start costs far more than getting it right on paper first

<div class="why">
<strong>In industry:</strong> "requirements gathering" and "conceptual
design" are standard phases in any software project, not database
trivia. Skipping straight to tables is a mistake senior engineers are
trained to catch early.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"How do we decide which tables to build - in a way any two designers would agree on, before a single table exists?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

<div class="cardlist">
<div class="card"><div class="h">Design Stages</div><div class="d">Name the three stages: conceptual, logical, physical, and what each produces</div></div>
<div class="card"><div class="h">Entities & Relationships</div><div class="d">Pull entities and relationships out of unstructured, real-world requirements</div></div>
<div class="card"><div class="h">The Four Tests</div><div class="d">Apply completeness, correctness, minimal redundancy, and understandability to catch a bad design early</div></div>
<div class="card"><div class="h">Why Rules Aren't Enough</div><div class="d">Explain why a technically valid schema can still be a bad design</div></div>
</div>

---

<!-- SLOT 8: Origin -->

# Where This Process Came From

<div class="thread">The relational model gave the field rigor. It never promised a process.</div>

- Early relational database projects, in the 1970s and 1980s, still
  failed for a familiar reason: teams built tables straight from
  requirements documents, with no design step in between
- Structured design methodologies emerged specifically to catch
  missing requirements and design mistakes on paper - before a single
  table existed, when fixing a mistake still costs nothing but an eraser

<div class="why">
Every app on your phone went through some version of this process
before its first <code>CREATE TABLE</code>, whether or not anyone
called it "data modeling" out loud.
</div>

---

<!-- SLOT 9: Core concept -->

# Data Modelling: Definition

<div class="thread">A verb this week, not a noun.</div>

> **Data modeling** is the process of studying real-world requirements
> and writing them down as a structured description of the data a
> system must store, before any table is created.

- **Entity:** a real-world thing a design tracks - Student, Course, Instructor
- **Relationship:** a real-world fact connecting two or more entities -
  "a Student enrolls in a Section"
- **Conceptual design:** the first stage - name entities and
  relationships, no table names, no keys yet

---

<!-- Act 3 / BUILD -->

# Three Design Stages, In Order

<div class="thread">Conceptual, then logical, then physical - never any other order.</div>

| Stage | Produces |
|---|---|
| **Conceptual** | entities and relationships, in plain language, no table names yet |
| **Logical** | relations with attributes, keys, constraints - last week's world |
| **Physical** | indexes, storage layout, performance tuning |

<div class="why">
This week lives entirely in the conceptual stage. Logical design comes
back in Week 6, once a checkable diagram exists to map from.
</div>

---

# The Four "Good Design" Tests

<div class="thread">A design can pass every rule from Week 2 and still fail all four of these.</div>

| Test | Question it asks |
|---|---|
| **Completeness** | Is every requirement represented somewhere? |
| **Correctness** | Does the model match the real-world rules, not just the wish list? |
| **Minimal redundancy** | Is any fact stored in two places, by design? |
| **Understandability** | Can someone who wasn't in the room read it and understand it? |

<div class="pain">
The three students' designs from the opening pain slide: all pass
every Week 2 rule. Run the four tests, and the "combine student and
enrollment into one table" design immediately fails minimal redundancy
- a student's major gets copied into every enrollment row.
</div>

---

# Worked Example: Reading a Real Requirements Interview

<div class="thread">This week's registrar interview - the same one this week's lab works through in full.</div>

The registrar's own words, unstructured, the way real requirements
actually arrive: *"the same course code can show up more than once...
with different instructors or rooms"* → a Course and a Section are two
different things. *"the same student can enroll in several sections...
and a section obviously has many students"* → Student M:N Section.

A new requirement, easy to miss on a first read: *"if a section is
full, a student can join a waitlist... the first student on the list
gets offered it."* Second read: a waitlisted student has **not**
enrolled, and "first in line" implies an order nothing mentioned so
far was built to track. A new entity, **Waitlist**, is hiding in one
sentence - found only by reading it twice.

<div class="why">
<strong>Entities so far:</strong> Student, Course, Instructor, Section,
Waitlist. <strong>Relationships so far:</strong> enrolls in, belongs to,
taught by, joins waitlist for. No table names, no keys - Week 4's job.
</div>

---

# Common Mistakes

- **Jumping straight to table names:** skips the step that catches a
  missing requirement while it's still cheap to fix
- **Trusting Week 2's rules alone:** a schema with valid keys and
  constraints can still duplicate the same fact in two places
- **Reading a requirement only once:** a stated rule, mentioned only in
  passing ("not for a section they're already enrolled in"), is easy
  to miss on a first pass

---

# Check Yourself

1. Requirement: "A member borrows books; each book has a title and an
   author; a librarian checks a returned book back in." Name the
   conceptual-stage entities.
2. Which of the four tests catches a model that two engineers read two
   different ways?
3. A design combines student and enrollment data into one table, so a
   student's major is copied into every enrollment row. Which test
   does this fail?

---

# Answers

1. **Member, Book, Librarian.** Relationships: a Member borrows a Book;
   a Librarian checks a Book back in. No table names or keys yet.
2. **Understandability.** A model two engineers read two different ways
   has failed this test, regardless of how complete or correct it
   otherwise is.
3. **Minimal redundancy.** Storing the same fact (the student's major)
   in every enrollment row is exactly what this test exists to catch.

---

<!-- SLOT N+1: Limits, becomes Week 4 slot 4 -->

# What a Conceptual Model Still Cannot Do

<div class="limits">
We can now pull entities and relationships out of real requirements,
and check the result against four concrete tests. But the result is
still prose - written in careful English, not a formal notation. A
conceptual model described in prose is not executable, and it is not
verifiable: two people can still read the same paragraph and draw two
different pictures from it, and nothing forces either of them to
notice the disagreement.
</div>

---

<!-- SLOT N+2: Bridge -->

# Next Week

Week 3 leaves **a conceptual model that is prose, not executable, not
verifiable** unsolved. **Week 4, E-R Diagrams**, addresses it: a fixed
notation precise enough that a disagreement becomes visible on paper.

---

<!-- SLOT N+3: Summary -->

# Summary

- Data modelling happens in three ordered stages: conceptual, logical,
  physical. This week lives entirely in the first.
- Entities and relationships come from real, often unstructured
  requirements - a second, closer read regularly finds something the
  first read missed.
- The four "good design" tests catch problems Week 2's rules cannot:
  completeness, correctness, minimal redundancy, understandability.
- **Lab page:** `book/src/labs/lab03-data-modelling.md` - extract
  entities from a full registrar interview transcript, and watch an
  unconstrained toy schema accept contradictory data.
- **Reading:** Silberschatz et al., 7th ed., Ch. 6 (conceptual design
  sections only)
- **Prepare:** from your entity list, which relationships are 1:1,
  1:N, or M:N? Week 4 asks you to state that formally.

---

<!-- SLOT N+4: Thank You -->
<!-- _class: end -->

# Thank You
