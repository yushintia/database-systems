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

# Why These Design Issues Matter

<div class="pain">
Even after agreeing to write "things that exist" and "facts connecting
them" in plain English, two designers on the same requirement still
disagree on basic questions: is a property like "major" its own
concept, or just a field? Is "who is TA-ing which section" a
relationship, or does it deserve to be tracked on its own? These are
not typos, they are recurring design forks that come up in almost
every real system, and the four tests above do not resolve them by
themselves.
</div>

This section gives each fork a name and a way to reason through it,
before Week 4 turns any of it into a diagram.

---

# Relationship Sets, Formally

<div class="thread">"A student enrolls in a section" names one fact. This slide names the whole category of facts like it.</div>

> A **relationship set** is a named association among instances of one
> or more of the things a design tracks. One **relationship** is a
> single instance of that association.

"Kim Minji enrolls in CSE301" is one relationship. Every such pairing,
for every student and every section, together forms the relationship
set `Enrolls`. This week's "facts connecting them" language now has a
formal name.

---

# Degree of a Relationship: Definition

<div class="thread">Not every relationship connects exactly two things.</div>

> The **degree** of a relationship set is the number of entities
> participating in it.

Most relationships connect exactly two things, a **binary**
relationship, degree 2. Some connect one thing to itself, or three or
more things at once. The next three slides take each case.

---

# Higher-Degree: A Ternary Example

<div class="thread">Three things, one relationship set, not three separate binary ones.</div>

The registration system needs to know which instructor taught which
course in which semester, because the same instructor might teach the
same course in a different semester with a different outcome.
`Offers`, a single relationship set of degree 3, connects Instructor,
Course, and Semester at once.

<div class="why">
Splitting this into three binary relationships (Instructor-Course,
Course-Semester, Instructor-Semester) loses information: it can no
longer say which specific combination actually happened together. A
true ternary relationship set is sometimes the only accurate model.
</div>

---

# Unary (Recursive) Relationships

<div class="thread">Degree 1: something related to another instance of its own kind.</div>

> A **unary**, or **recursive**, relationship connects instances of the
> same entity set to each other.

`Prerequisite`, connecting Course to Course ("CSE301 is a prerequisite
of CSE401"), is unary: both roles in the relationship are filled by
the same kind of thing, just different instances of it.

---

# Degree, at a Glance

| Degree | Name | Registration example |
|---|---|---|
| 1 | Unary (recursive) | Course is a prerequisite of Course |
| 2 | Binary | Student enrolls in Section |
| 3 | Ternary | Instructor offers Course in Semester |

Binary is by far the most common case in practice; unary and ternary
exist specifically for the facts a binary relationship cannot state
accurately.

---

# Degree Matters: A Mapping Preview

<div class="why">
Week 6's mapping algorithm treats a binary, unary, and ternary
relationship set with three different rules. Misreading a ternary fact
as two binary ones here, in Week 3, produces a design that Week 6
cannot correctly map back, a mistake far cheaper to catch now, on
paper, than after tables exist.
</div>

---

# Design Issue: Entity or Attribute?

<div class="thread">The first of two design forks that plain-English requirements hide.</div>

Some real-world things are properties of exactly one other thing, and
some deserve to be tracked in their own right. Getting this wrong
either buries information inside a single field, or manufactures a
whole tracked thing for something that never needed one.

> Ask: does this thing have properties of its own that the system must
> track independently of whatever it is currently attached to?

---

# Entity or Attribute - Worked Example: Major

Requirement: "each student has a major." Two designs:

- **As a property:** `Student(student_id, name, major)`, major is just
  a text field
- **As its own tracked thing:** a `Major` concept, with its own
  department, required credit count, and advisor, connected to Student
  by a relationship

If the registration system only ever prints a student's major name,
the property design is complete. The moment the university needs to
ask "which majors require 130 credits," major's own properties are
being tracked, and it has become an entity in every way that matters.

---

# Design Issue: Entity or Relationship?

<div class="thread">The second fork: sometimes a connection between two things needs to be tracked like a thing itself.</div>

> Ask: does this connection need properties of its own, or does it
> need to connect onward to still other things? If either is true,
> model it as its own tracked thing, not a plain relationship.

---

# Entity or Relationship - Worked Example: TA Assignment

Requirement: "a teaching assistant helps with a section, a fixed
number of hours per week." As a plain relationship, "Assists" between
Student and Section, carrying an `hours` property, works fine, until
the university also needs to record which assistance was paid through
which payroll batch. The moment a fact needs to attach to the
assignment itself, not to the student or the section alone, "Assists"
has outgrown being just a relationship.

---

# Keys at the Conceptual Level

<div class="thread">Before Week 2's candidate key and primary key, this same idea already existed, just not yet formal.</div>

> At the conceptual level, a **key** is whatever combination of
> properties the real world already guarantees will distinguish one
> instance from every other, whether or not any rule enforces it yet.

The university's own numbering policy guarantees no two students ever
share a `student_id`; that real-world guarantee is what makes it a key
here, a full week before Week 2 calls it a candidate key or a primary
key by name.

---

# Entity vs. Attribute vs. Relationship: A Checklist

<div class="thread">Three questions, in order, for anything a requirement mentions.</div>

- Does it have properties of its own the system must track? If yes, it
  may deserve to be its own entity.
- Does it just describe one other thing, with no life of its own? It
  is an attribute.
- Does it exist only to connect two or more other things? It is a
  relationship - unless it needs its own properties or further
  connections, in which case treat it as an entity instead.

---

# Common Mistakes: Conceptual Design Vocabulary

- **Modeling every noun as its own entity:** "grade" is a property of
  an enrollment, not its own tracked thing, unless grades themselves
  need independent history
- **Flattening a ternary relationship into two binaries:** loses
  exactly which three things occurred together
- **Treating any attribute on a relationship as proof it must become
  an entity:** a relationship can carry a simple property (like
  `hours`) without needing to become one

---

# Practice: A Library System - Relationship Degree

Requirement: "a librarian checks out a copy to a member."

**Question:** is this relationship binary or ternary, and why?

**Answer:** **Ternary.** Librarian, Copy, and Member all participate in
the same single event; splitting it into Librarian-Copy and
Copy-Member loses which librarian handled which member's checkout.

---

# Practice: A Fitness App - Entity or Attribute?

Requirement: "each workout belongs to a category, like cardio or
strength."

**Question:** attribute or entity?

**Answer:** **Attribute**, if the app only ever labels a workout with a
category name. **Entity**, the moment the app needs to track a
category's own data: a recommended weekly frequency, an icon, a
difficulty rating.

---

# Practice: A Ride-Hailing App - Entity or Relationship?

Requirement: "a ride is rated by the rider after it ends."

**Question:** should the rating stay a property of the ride, or does it
deserve to be its own tracked thing?

**Answer:** A simple 1-5 star value can stay a property of the ride. If
the app later needs a written review, a timestamp, and a moderation
status independent of the ride itself, the rating has earned its own
entity, exactly the same fork as the TA Assignment example.

---

# Practice: The Registration System Itself

Requirement: "each section meets in a room; the facilities office is
adding a system to flag room double-bookings across every department,
not just this one."

**Question:** should `Room` stay a property of Section, or become its
own entity?

**Answer:** **Its own entity.** The moment room conflicts must be
checked across departments, independent of any one Section, Room has
properties (capacity, building, a schedule of its own) that the
system must track on its own terms, the same fork as the Major example.

---

# Check Yourself: Conceptual Design Vocabulary

1. A relationship connects Student, Course, and Semester all at once.
   What is its degree, and what is that degree called?
2. "Room number" is currently a property of Section. Name one new
   requirement that would justify making Room its own tracked entity.
3. "Advises," between Student and Instructor, gains a new requirement:
   track which faculty committee approved each advising assignment.
   What should happen to "Advises"?

---

# Answers

1. **Degree 3, ternary.**
2. Any requirement needing Room's own independent data would justify
   it: capacity, building, a maintenance schedule, availability across
   multiple sections.
3. "Advises" should become its own entity: the new fact (committee
   approval) attaches to the advising relationship itself, not to the
   Student or Instructor alone, exactly the entity-or-relationship
   fork.

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

# A Note on Sources

<div class="thread">One line of attribution, stated once.</div>

This week's coverage of relationship degree, the entity-vs-attribute
and entity-vs-relationship design issues, and conceptual-level keys
follows the standard chapter organization of Silberschatz, Korth, and
Sudarshan's *Database System Concepts*, 7th ed., this course's primary
reference text. Every example and explanation on these slides is
original, built around this course's own registration case study.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
