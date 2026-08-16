---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 4: E-R Diagram

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: Assignment 1 is due this week. Announce deadline early, not buried at the end. -->

---

<!-- SLOT 2: Where we are -->

# Where We Are

<div class="roadmap">
<div class="wk"><div class="n">Wk 1</div><div class="t">Introduction</div></div>
<div class="wk"><div class="n">Wk 2</div><div class="t">Relational Model</div></div>
<div class="wk"><div class="n">Wk 3</div><div class="t">Data Modelling</div></div>
<div class="wk now"><div class="n">Wk 4</div><div class="t">E-R Diagram</div></div>
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

<div class="why">
<strong>Assignment 1 due this week:</strong> an E-R diagram for a
system of your choice, using everything in today's lecture.
</div>

---

<!-- SLOT 3: Recap + open wound -->

# Last Week, This Week

- **Last week delivered:** three design stages, conceptual, logical, physical, and a definition of what makes a design "good"
- **Last week left broken:** conceptual design, in plain English prose, is not verifiable. Two people still disagree, one level higher up than before

---

<!-- SLOT 4: The pain -->

# Two Sketches, Same System, Still No Agreement

<div class="pain">

Two designers each write a conceptual description of the registration
system in plain English. One writes: "a student has enrollments, and
each enrollment has a section." The other writes: "a section has many
students, and grades belong to the student." Both sound reasonable.
Read closely, they disagree about where the grade actually lives, and
neither sentence makes that disagreement obvious.

Prose hides ambiguity inside grammar. Nothing forces either designer to
be precise about how many students one section can have, or whether an
enrollment can exist without a grade yet.

</div>

<!-- notes: Read both sentences aloud, ask the class to spot the disagreement. Most will need a second read. That is the point. -->

---

# What Else This Actually Costs

- An ambiguous conceptual design gets built into an ambiguous logical
  schema, and the mistake is far more expensive to fix once tables and
  data exist
- Two developers implementing the "same" prose requirement independently
  will build incompatible systems that cannot be merged later
- A stakeholder reading a paragraph cannot verify it the way they can
  verify a diagram with explicit boxes, lines, and numbers

<div class="why">
<strong>In industry:</strong> E-R diagrams (or their close cousins, UML
class diagrams) are standard artifacts in any system design review.
Being able to read and draw one is assumed, not taught on the job.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What notation makes a conceptual design precise enough that ambiguity becomes visible?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

1. Identify entities and attributes from a plain-English requirement
2. Draw relationships between entities with correct cardinality
3. Distinguish a weak entity from a strong entity
4. Produce a complete E-R diagram for a small real-world system

---

<!-- SLOT 8: Origin -->

# Where This Notation Came From

<div class="thread">A direct answer to last week's ambiguity problem, invented on purpose.</div>

- **1976, Peter Chen** publishes "The Entity-Relationship Model,"
  proposing a diagram notation specifically so conceptual designs could
  be checked, not just read
- The goal was explicit: a notation simple enough for a
  non-programmer stakeholder to verify, but precise enough that an
  engineer could translate it into tables without guessing

---

<!-- SLOT 9: Core concept -->

# Entity & Attribute: Definition

<div class="thread">The two building blocks, formal names for ideas you already used informally in Week 3.</div>

> An **entity** is a real-world thing, distinguishable from every other
> thing, that a system needs to track. An **attribute** is a property
> that describes an entity.

- **Entity:** Student, Course, Instructor, Section
- **Attribute of Student:** `student_id`, `name`, `major`

Notice: entity and attribute do not yet say anything about tables. This
is still Week 3's conceptual stage, one level above Week 2's relations.

---

<!-- Act 3 / BUILD -->

# Identifying Entities

<div class="thread">Start here: read a requirement, circle the nouns that matter.</div>

Requirement: "Every student enrolls in one or more course sections,
taught by an instructor, in a specific room."

| Candidate noun | Entity? | Why |
|---|---|---|
| student | Yes | tracked over time, has its own attributes |
| section | Yes | tracked over time, has its own attributes |
| instructor | Yes | tracked over time, has its own attributes |
| room | No, for now | just one attribute of Section, not tracked independently |

---

# Three Kinds of Attribute

<div class="thread">Not every attribute is the same kind. One slide each, so the distinctions actually stick.</div>

Three ways to describe an entity's properties, all three used
constantly in real designs. The next three slides take them one at a
time.

---

# Simple Attribute

> Cannot be broken down into smaller parts.

`student_id`, `grade`, `room` are each simple: one atomic value, no
internal structure a design needs to care about.

---

# Composite Attribute

> Made of smaller, meaningful parts.

`name` could split into `first_name` and `last_name` the moment the
system needs to sort by last name alone, or address someone formally
by first name only. Whether to split it is a real design decision, not
automatic.

---

# Key Attribute

<div class="thread">The one distinction that connects directly back to last week.</div>

> Uniquely identifies the entity, exactly last week's primary key idea,
> one design stage earlier.

`student_id` is Student's key attribute. At the conceptual stage, this
is still just "the thing that makes each Student distinguishable," not
yet a formal `PRIMARY KEY` declaration, that arrives in Week 9.

---

# Relationships

<div class="thread">Entities alone are just a list. Relationships are where the actual design happens.</div>

> A **relationship** is an association between two or more entities.

"A student enrolls in a section" is a relationship between Student and
Section. In E-R notation, this is drawn as a labeled connection, not a
sentence, exactly so it cannot hide ambiguity the way prose does.

---

# Cardinality: How Many, Precisely

<div class="thread">The exact number Chen's notation forces you to state, that prose lets you skip.</div>

> **Cardinality** states how many instances of one entity can relate to
> how many instances of another.

Three possible answers exist. The next three slides take each one,
with the registration system's own example.

<div class="why">
This is the exact disagreement from the pain slide, made impossible to
leave unstated. Every relationship must pick one of these three,
out loud, on the diagram.
</div>

---

# Cardinality 1:1

> One instance relates to exactly one instance on the other side.

**Registration example:** a Section has exactly one primary
Instructor. (Not "at most one instructor teaching many sections,"
that direction is 1:N, covered next.)

<div class="why">
1:1 relationships are the rarest of the three in most real systems.
When you see one, double check: is it really always exactly one, or
could a future requirement make it many?
</div>

---

# Cardinality 1:N

> One instance on one side relates to many instances on the other; each
> of those many relates back to exactly one.

**Registration example:** one Instructor teaches many Sections; each
Section has exactly one Instructor. This is the most common
cardinality in real designs, and Week 6's simplest mapping rule.

---

# Cardinality M:N

> Many instances on one side relate to many instances on the other,
> in both directions at once.

**Registration example:** many Students enroll in many Sections; a
Section holds many Students, and a Student takes many Sections.

<div class="why">
M:N cannot be represented by a single foreign key on either side, that
is exactly why Week 2's Enrollment relation had to exist as its own
relation in the first place.
</div>

---

# The Registration System's Relationships

<div class="thread">Applying cardinality to every connection in the system at once.</div>

<div class="pipeline">
<div class="stage"><div class="h">Student</div><div class="s">M:N enrolls in</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Section</div><div class="s">1:N belongs to</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Course</div><div class="s">the subject itself</div></div>
</div>

<div class="pipeline">
<div class="stage"><div class="h">Section</div><div class="s">N:1 taught by</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Instructor</div><div class="s">one per section</div></div>
</div>

Student to Section is many-to-many, exactly why Week 2's Enrollment
relation exists: M:N relationships cannot be represented any other way.

---

# Weak Entities

<div class="thread">One entity in this system cannot stand on its own. Here is why that matters.</div>

> A **weak entity** has no key attribute of its own; it can only be
> uniquely identified in combination with another entity's key.

An `Enrollment` is not really "a thing" the way a Student is. It only
makes sense as "this Student, in this Section." Its identity is
borrowed: `{student_id, section_id}` together, not either alone.

<div class="why">
This is a preview of Week 6: weak entities map to relations whose
primary key includes a foreign key, exactly what Week 1 already showed
you in the Enrollment relation.
</div>

---

# Demo, Step by Step: Notating the Waitlist

<div class="thread">Week 3 left "Student joins a Waitlist for a Section" in prose. Four steps make it a real diagram.</div>

---

# Step 1: Name the Entities

`Student` and `Section` already exist on the main diagram. `Waitlist`
is new, from Week 3's conceptual pass.

---

# Step 2: Give Waitlist Its Attributes

`Waitlist`: `position` (1st, 2nd, 3rd in line), `date_joined`. Neither
attribute means anything without knowing which student and which
section, a signal worth remembering for the next step.

---

# Step 3: Draw the Relationship, With Cardinality

Student M:N Section, via joining a Waitlist, same shape as
`Enrollment`. Cardinality stated explicitly, exactly this lecture's
rule: never leave it implied.

---

# Step 4: Weak or Strong?

`Waitlist` has no meaning on its own, "position 2" means nothing
without a specific student and a specific section. **Weak entity**,
identity borrowed from both, exactly like `Enrollment`. Week 6 picks
this up next, mapping it to a real relation.

---

# Worked Example: The Full E-R Diagram

<div class="thread">Every piece from this lecture, assembled into the registration system's actual design.</div>

**Entities:** Student, Course, Instructor, Section, Enrollment (weak)

**Key attributes:** `student_id`, `course_code`, `instructor_id`,
`section_id`

**Relationships:**

- Student M:N Section, via the weak entity Enrollment
- Section N:1 Course
- Section N:1 Instructor

This is the complete conceptual design. Week 6 turns it into tables
mechanically, no guessing required.

---

# Cardinality Around You: Real Apps

<div class="thread">Not just this system. Every app on your phone made these exact choices.</div>

<div class="appgrid">
<div class="app"><div class="name">Instagram</div><div class="desc">User M:N Post, via Like (a weak entity)</div></div>
<div class="app"><div class="name">KakaoTalk</div><div class="desc">User M:N ChatRoom, via Membership</div></div>
<div class="app"><div class="name">Netflix</div><div class="desc">Profile 1:N WatchHistory entry</div></div>
<div class="app"><div class="name">배달의민족</div><div class="desc">Restaurant 1:N MenuItem</div></div>
</div>

Every M:N relationship on this slide needed its own weak entity,
exactly like Enrollment, the moment someone actually built these apps.

---

# Common Mistakes

- **Making everything an entity:** `room` is an attribute of Section
  here, not its own entity, unless the system needs to track rooms
  independently (capacity, building, schedule of its own)
- **Skipping cardinality:** drawing a line between two entities with no
  number attached recreates exactly the ambiguity this notation exists
  to remove
- **Treating a weak entity as a strong one:** giving Enrollment its own
  independent `enrollment_id` when `{student_id, section_id}` already
  uniquely identifies it adds a key with no real-world meaning

---

# Practice: A Library System

<div class="thread">Same notation, a different domain.</div>

Requirement: "A library holds many copies of a book. A member can
borrow a copy, but only one member at a time per copy."

**Question:** identify the entities and the cardinality between
Member and Copy.

**Answer:** Entities: Member, Book, Copy. Member to Copy is **1:N** at
any given moment (one member can hold several copies out at once; each
copy is checked out to at most one member at a time), via a weak
entity, `Loan`.

---

# Practice: A Ride-Hailing App

<div class="thread">One more, applying weak entities specifically.</div>

**Question:** "A Driver gives many Rides; a Rider takes many Rides;
each Ride has exactly one Driver and one Rider." Is `Ride` a strong or
a weak entity, and why?

**Answer:** **Weak.** A Ride has no independent meaning without both a
Driver and a Rider, its identity is borrowed from the combination,
exactly Enrollment's relationship to Student and Section.

---

# Check Yourself

1. Is `office_number` an attribute of Instructor, or a separate entity?
   Justify your answer.
2. A Section can have several TAs, and a TA can help with several
   Sections. What cardinality is that?
3. In the ride-hailing example, why can't `Ride` simply be a foreign
   key added to `Driver`?

---

# Answers

1. **Attribute**, unless the system needs to track offices
   independently of instructors (shared offices, office assignments
   over time). As stated, it is one property of one instructor.
2. **M:N**, many-to-many, the same shape as Student to Section.
3. Because the relationship is M:N (many drivers, many riders, many
   rides), and an M:N relationship can never be captured by a single
   foreign key on either side, exactly the same reason Enrollment
   needs to be its own relation.

---

<!-- SLOT 14: Limits, becomes Week 6 slot 4 -->

# What a Diagram Cannot Do Alone

<div class="limits">
We now have a precise, checkable conceptual design, entities,
attributes, relationships, cardinality, all stated explicitly. But a
diagram is not a database. No DBMS can run a diagram. Everything drawn
this week still has to become real relations, with real primary keys
and foreign keys, and nothing so far tells us the exact mechanical
steps to get there.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 4 leaves **turning a diagram into real tables** unsolved.
**Week 6, Mapping Algorithm**, addresses it: a deterministic, mechanical
procedure from E-R diagram to relational schema. (Week 5 is Quiz 1,
covering Weeks 1 through 4.)

---

<!-- SLOT 16: Summary -->

# Summary

- Entities, attributes, and relationships give conceptual design a
  precise, checkable notation, replacing the ambiguity of prose.
- Cardinality (1:1, 1:N, M:N) forces every relationship to state
  exactly how many instances connect, out loud, on the diagram.
- A weak entity has no independent key; it borrows identity from the
  entities it connects, a direct preview of Week 6's mapping rules.
- **Reading:** Silberschatz et al., 7th ed., Chapter 7
- **Prepare:** Quiz 1 next week covers Weeks 1 through 4. Review the
  registration system's E-R diagram until you can redraw it from memory.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
