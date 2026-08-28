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

- **Last week delivered:** a rigorous definition of a table, relations, attributes, tuples, keys, integrity constraints
- **Last week left broken:** the vocabulary tells us the rules a table must follow, not which tables to actually build

---

<!-- SLOT 4: The pain -->

# A Rulebook With No Instructions

<div class="pain">

Armed with last week's vocabulary, a team sits down to design the
registration system properly this time. Everyone agrees a relation
needs attributes, a primary key, and integrity constraints. Nobody
agrees on how many relations to make, or which real-world facts belong
together in one relation versus split across several.

One person proposes three relations. Another proposes six. A third
combines student and enrollment data into one relation "to keep it
simple." All three designs technically satisfy every rule from last
week. All three cannot be right.

</div>

<!-- notes: The rules from Week 2 are necessary but not sufficient. That gap is today's whole lecture. -->

---

# What Else This Actually Costs

- Jumping straight to tables, with no design step first, means every
  designer reinvents the process from scratch, differently, every time
- A design built without first understanding the real-world
  requirements tends to miss relationships nobody thought to ask about
  until the system is already in production
- Redesigning a live database because the original design skipped a
  requirements step is far more expensive than getting it right first

<div class="why">
<strong>In industry:</strong> "requirements gathering" and "conceptual
design" are standard phases in any software project, not database
trivia. Skipping straight to tables is a beginner mistake senior
engineers are trained to catch early.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What structured process turns real-world requirements into the right set of tables?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

<div class="cardlist">
<div class="card"><div class="h">Purpose of Modeling</div><div class="d">Explain the purpose of data modeling as a design step, not a formality</div></div>
<div class="card"><div class="h">Design Stages</div><div class="d">Name the three stages of database design and what each stage produces</div></div>
<div class="card"><div class="h">Stages vs. Abstraction</div><div class="d">Distinguish data modeling stages from Week 1's abstraction levels</div></div>
<div class="card"><div class="h">What Makes It Good</div><div class="d">Describe what makes a data model "good" before any table exists</div></div>
</div>

---

<!-- SLOT 8: Origin -->

# Why Design Became Its Own Step

<div class="thread">The relational model gave us rigor. It never promised a process.</div>

- Early relational database projects, in the 1970s and 1980s, still
  failed for a familiar reason: teams built tables straight from
  requirements documents, with no intermediate design step
- Structured design methodologies emerged specifically to catch missing
  requirements and design mistakes on paper, before a single table
  existed, when fixing a mistake costs nothing but an eraser

---

<!-- SLOT 9: Core concept -->

# Data Model: Definition

<div class="thread">Distinguish this from "a data model" the noun (Week 1's relational, E-R, object models). This week, "data modeling" is a verb.</div>

> **Data modeling** is the process of analyzing real-world requirements
> and expressing them as a structured description of the data a system
> must store, before any table is created.

The output of data modeling is a **design**. The output of Week 2's
vocabulary is a **rulebook**. This week is about the process that
connects the two.

---

# This Process Is Already Everywhere Around You

<div class="thread">Before the formal build begins, a picture worth keeping.</div>

<div class="why">
Before any real app's engineers write a single <code>CREATE TABLE</code>,
someone sketches, in plain language: "users have posts," "posts have
likes," "a like belongs to one user and one post." That sketch is
conceptual design. Every app on your phone went through this exact
process, whether or not anyone called it "data modeling" out loud.
</div>

---

<!-- Act 3 / BUILD -->

# Three Design Stages

<div class="thread">One process, three stages, each stage producing a different kind of artifact.</div>

<div class="trimodel">
<div class="panel">
<div class="hd">Conceptual (CDM)</div>
<div class="bubble-row">
<div class="bubble">Student</div>
<div class="bubble-arrow">enrolls</div>
<div class="bubble">Course</div>
</div>
</div>
<div class="arrow">&rsaquo;</div>
<div class="panel">
<div class="hd">Logical (LDM)</div>
<div class="schema-tbl">
<div class="hd"><span>Enrollment</span></div>
<div class="row"><span class="pk">student_id</span></div>
<div class="row"><span class="pk">course_code</span></div>
<div class="row">grade</div>
</div>
</div>
<div class="arrow">&rsaquo;</div>
<div class="panel">
<div class="hd">Physical (PDM)</div>
<div class="line">Index: student_id (B-tree)</div>
<div class="line">Storage: row-oriented, 4KB pages</div>
</div>
</div>

The next three slides take each stage in turn.

---

# Stage 1: Conceptual Design

<div class="thread">Start here, before a single table name is written.</div>

**Conceptual design:** identify the real-world things a system must
track, and how they relate, in a notation both technical and
non-technical people can read.

<div class="why">
For the registration system: students exist, courses exist, a student
enrolls in a course. No table names, no data types, no primary keys
yet, just the real-world facts. Week 4 gives this stage a formal
notation: the E-R diagram.
</div>

---

# Stage 2: Logical Design

<div class="thread">Take the conceptual picture, translate it into Week 2's vocabulary.</div>

**Logical design:** translate the conceptual model into a specific data
model's structures, for this course, relations with attributes, keys,
and constraints.

<div class="why">
This is where "students enroll in courses" becomes
`Enrollment(student_id, course_code, grade)`. Week 6's mapping
algorithm is the mechanical procedure for this exact translation.
</div>

---

# Stage 3: Physical Design

<div class="thread">The last stage, and the only one Week 1's abstraction levels already named.</div>

**Physical design:** decide how the logical schema is actually stored,
indexes, file organization, performance tuning.

<div class="why">
This maps directly onto Week 1's physical level of abstraction. Notice
the parallel: conceptual and logical design map onto Week 1's logical
level (what data exists), physical design maps onto Week 1's physical
level (how bytes sit on disk). Same three-way split, seen from two
different angles.
</div>

---

# Not the Same Three Levels as Week 1

<div class="thread">A deliberate name collision. Here is exactly how the two frameworks relate.</div>

Week 1's abstraction levels (physical, logical, view) describe how a
**finished** database presents itself to different users, every day,
forever. This week's design stages (conceptual, logical, physical)
describe the **one-time process** of building that database in the
first place.

| Week 1 concept | This week's concept |
|---|---|
| Three faces of a running system | Three stages of building it |
| Physical, logical, view | Conceptual, logical, physical |
| Ongoing, every query | One-time, at design time |

---

# What Makes a Design "Good": Four Tests

<div class="thread">A checklist for judging a data model, before any table exists to test it against. One test per slide.</div>

Four tests, applied to the same design, catch different kinds of
mistakes. Every one of this week's three competing pain-slide designs
fails at least one of them.

---

# Test 1: Completeness

> Every requirement is represented somewhere in the model.

<div class="pain">
A registration design that never mentions grades is incomplete, even
if every relation in it is perfectly formed. Completeness is checked
against the requirements document, not against the model itself.
</div>

---

# Test 2: Correctness

> The model matches the real-world rules, not just the stated wish list.

<div class="pain">
A design that allows a Student to enroll in a Section that does not
exist is incorrect, even if it is complete. Correctness means the
model's constraints match reality's constraints.
</div>

---

# Test 3: Minimal Redundancy

> No fact is captured in two places by design.

<div class="pain">
The pain slide's "combine student and enrollment into one relation"
design stores a student's major once per enrollment, redundantly,
exactly Week 1's problem, reintroduced by a design choice this early.
</div>

---

# Test 4: Understandability

> Someone who was not in the room can read the design and understand it.

<div class="why">
This is the test the pain slide's three designers all failed
implicitly: none of them could hand their sketch to a fourth person
and get the same interpretation back. A model only two people
understand is not yet a model, it is a private guess.
</div>

---

# Demo, Step by Step: A New Feature, Conceptually

<div class="thread">A brand new requirement, never seen before, walked through the process live. Weeks 4, 6, and 7 pick this same example up.</div>

New requirement: "If a section is full, students can join a waitlist.
When a seat opens, the first student on the waitlist is offered it."
Four steps, applying this week's process for the first time.

---

# Step 1: Read the Requirement Twice

First read: sounds like it is about `Enrollment`. Second, closer read:
a waitlisted student has **not** enrolled yet, position matters, and
"first on the list" implies an order that `Enrollment` was never
designed to track. A new concept is hiding in this sentence.

---

# Step 2: Identify What Exists

- **Things that exist:** Student, Section, and now: Waitlist entry
- **Facts connecting them:** a Student joins a Waitlist for a Section;
  a Waitlist entry has a position (1st, 2nd, 3rd in line)

---

# Step 3: Check Against the Four Tests

**Completeness:** does this capture "first on the list"? Not yet,
position is named but not yet modeled precisely, that gap carries
forward. **Correctness:** a student cannot waitlist for a section they
are already enrolled in, a real-world rule worth writing down now.

---

# Step 4: What Carries Forward

Conceptual design is not finished here, on purpose. "Student joins a
Waitlist for a Section, with a position" is exactly what Week 4 turns
into entities, attributes, and a formal relationship, next.

---

# Worked Example: Requirements to Concepts

<div class="thread">Start applying the process to the registration system, one stage at a time.</div>

Raw requirement, in plain language: "Every student enrolls in one or
more course sections, taught by an instructor, in a specific room."

Conceptual read of that sentence:

- **Things that exist:** Student, Section, Instructor
- **Facts connecting them:** a Student enrolls in a Section; a Section
  is taught by one Instructor

No tables yet. Week 4 turns exactly this into a formal E-R diagram.

---

# Common Mistakes

- **Jumping straight to logical design:** naming tables and columns
  before agreeing what real-world things exist skips the step that
  catches missing or wrong requirements
- **Treating physical design as an afterthought:** performance problems
  discovered after launch are often physical-design mistakes made, or
  skipped, at design time
- **Confusing this week's three stages with Week 1's three levels:**
  they rhyme on purpose, they are not the same thing

---

# Practice: A Fitness App

<div class="thread">The same three stages, a different domain, so the process is clearly what generalizes.</div>

Requirement: "Users log workouts. Each workout has exercises, and each
exercise has a number of reps and a weight."

**Question:** name the conceptual-stage entities, before writing a
single relation.

**Answer:** User, Workout, Exercise. "A Workout has Exercises" and "an
Exercise records reps and weight" are the relationships, stated in
plain language, exactly like this week's registration example.

---

# Practice: A Food Delivery App

<div class="thread">One more rep. Notice how little changes about the process itself.</div>

**Question:** "A restaurant has a menu; each menu item has a price; a
customer places an order containing one or more menu items." Apply the
four "good design" tests: which test would catch a design that stores
the menu item's name inside every single order line, instead of once
in a Menu Item entity?

**Answer:** **Minimal redundancy.** Storing the name repeatedly, once
per order line, is exactly the kind of redundancy Test 3 exists to catch.

---

# Check Yourself

1. "Students must be able to enroll in at most 6 courses per semester."
   Which design stage captures this fact first?
2. Name one thing Week 1's abstraction levels and this week's design
   stages have in common, and one thing that is different.
3. Which of the four "good design" tests specifically catches a model
   that two different engineers interpret two different ways?

---

# Answers

1. **Conceptual design.** It is a real-world rule about students and
   courses, captured before any table or data type exists.
2. **Common:** both split into a "what data is there" concern and a
   "how is it stored" concern. **Different:** Week 1 describes an
   already-running system's ongoing structure; this week describes a
   one-time process for building one.
3. **Understandability.** A model two engineers read two different
   ways has failed the "someone who was not in the room can read it"
   test, regardless of how complete or correct it otherwise is.

---

<!-- SLOT 14: Limits, becomes Week 4 slot 4 -->

# What a Design Process Cannot Do Alone

<div class="limits">
We now know the three stages, and conceptual design comes first. But
"identify the things that exist and how they relate," in plain
English, is still just prose. Two people writing conceptual designs in
prose will still disagree, the same problem as last week, one level up.
Prose is not verifiable. Nobody can check it against a rule the way a
primary key can be checked.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 3 leaves **conceptual design in prose, with no shared notation**
unsolved. **Week 4, E-R Diagram**, addresses it: a formal, checkable
notation for exactly the conceptual stage.

---

<!-- SLOT 16: Summary -->

# Summary

- Data modeling is the process connecting real-world requirements to
  Week 2's rulebook, three stages: conceptual, logical, physical.
- This week's design stages and Week 1's abstraction levels rhyme but
  are not the same thing: one is a one-time process, the other is an
  ongoing structure.
- A good design is complete, correct, minimally redundant, and
  understandable, testable even before a single table exists.
- **Reading:** Silberschatz et al., 7th ed., Chapter 6
- **Prepare:** write, in plain English, every real-world thing and fact
  you can think of about the registration system. Bring it to Week 4.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
