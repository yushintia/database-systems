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

<div class="cardlist">
<div class="card"><div class="h">Entities &amp; Attributes</div><div class="d">Identify entities and attributes from a plain-English requirement</div></div>
<div class="card"><div class="h">Relationships &amp; Cardinality</div><div class="d">Draw relationships between entities with correct cardinality</div></div>
<div class="card"><div class="h">Weak vs. Strong Entities</div><div class="d">Distinguish a weak entity from a strong entity</div></div>
<div class="card"><div class="h">Full E-R Diagram</div><div class="d">Produce a complete E-R diagram for a small real-world system</div></div>
</div>

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

<div class="er">
<svg viewBox="0 0 1050 360" width="700" height="240">
<line class="link" x1="115" y1="65" x2="280" y2="140"/>
<line class="link" x1="280" y1="140" x2="525" y2="185"/>
<line class="link" x1="525" y1="185" x2="770" y2="140"/>
<line class="link" x1="770" y1="140" x2="935" y2="65"/>
<line class="link" x1="525" y1="185" x2="525" y2="235"/>
<line class="link" x1="525" y1="235" x2="525" y2="315"/>
<polygon class="rel" points="280,95 355,140 280,185 205,140"/>
<polygon class="rel" points="770,95 845,140 770,185 695,140"/>
<polygon class="rel" points="525,195 600,235 525,275 450,235"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="850" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="440" y="150" width="170" height="70" rx="4"/>
<rect class="ent" x="440" y="280" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Student</text>
<text class="lbl" x="935" y="70">Course</text>
<text class="lbl" x="525" y="190">Section</text>
<text class="lbl" x="525" y="320">Instructor</text>
<text class="lbl" x="280" y="144">enrolls</text>
<text class="lbl" x="770" y="144">belongs to</text>
<text class="lbl" x="525" y="239">taught by</text>
<text class="card" x="70" y="120">M</text>
<text class="card" x="395" y="168">N</text>
<text class="card" x="630" y="168">N</text>
<text class="card" x="860" y="120">1</text>
<text class="card" x="630" y="210">N</text>
<text class="card" x="630" y="300">1</text>
</svg>
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

<div class="er">
<svg viewBox="0 0 900 420" width="560" height="261">
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="700" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="365" y="175" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Student</text>
<text class="lbl" x="785" y="70">Section</text>
<text class="lbl" x="450" y="215">Waitlist</text>
</svg>
</div>

---

# Step 2: Give Waitlist Its Attributes

`Waitlist`: `position` (1st, 2nd, 3rd in line), `date_joined`. Neither
attribute means anything without knowing which student and which
section, a signal worth remembering for the next step.

<div class="er">
<svg viewBox="0 0 900 420" width="560" height="261">
<line class="link" x1="400" y1="245" x2="300" y2="292"/>
<line class="link" x1="500" y1="245" x2="600" y2="292"/>
<ellipse class="attr" cx="300" cy="320" rx="70" ry="30"/>
<ellipse class="attr" cx="600" cy="320" rx="70" ry="30"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="700" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="365" y="175" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Student</text>
<text class="lbl" x="785" y="70">Section</text>
<text class="lbl" x="450" y="215">Waitlist</text>
<text x="300" y="325">date_joined</text>
<text x="600" y="325">position</text>
</svg>
</div>

---

# Step 3: Draw the Relationship, With Cardinality

Student M:N Section, via joining a Waitlist, same shape as
`Enrollment`. Cardinality stated explicitly, exactly this lecture's
rule: never leave it implied.

<div class="er">
<svg viewBox="0 0 900 420" width="560" height="261">
<line class="link" x1="115" y1="65" x2="450" y2="80"/>
<line class="link" x1="450" y1="80" x2="785" y2="65"/>
<line class="link" x1="450" y1="120" x2="450" y2="175"/>
<line class="link" x1="400" y1="245" x2="300" y2="292"/>
<line class="link" x1="500" y1="245" x2="600" y2="292"/>
<ellipse class="attr" cx="300" cy="320" rx="70" ry="30"/>
<ellipse class="attr" cx="600" cy="320" rx="70" ry="30"/>
<polygon class="rel" points="450,40 525,80 450,120 375,80"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="700" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="365" y="175" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Student</text>
<text class="lbl" x="785" y="70">Section</text>
<text class="lbl" x="450" y="215">Waitlist</text>
<text class="lbl" x="450" y="84">joins</text>
<text x="300" y="325">date_joined</text>
<text x="600" y="325">position</text>
<text class="card" x="70" y="120">M</text>
<text class="card" x="740" y="120">N</text>
</svg>
</div>

---

# Step 4: Weak or Strong?

`Waitlist` has no meaning on its own, "position 2" means nothing
without a specific student and a specific section. **Weak entity**,
identity borrowed from both, exactly like `Enrollment`. Week 6 picks
this up next, mapping it to a real relation.

<div class="er">
<svg viewBox="0 0 900 420" width="560" height="261">
<line class="link" x1="115" y1="65" x2="450" y2="80"/>
<line class="link" x1="450" y1="80" x2="785" y2="65"/>
<line class="link" x1="450" y1="120" x2="450" y2="175"/>
<line class="link" x1="400" y1="245" x2="300" y2="292"/>
<line class="link" x1="500" y1="245" x2="600" y2="292"/>
<ellipse class="attr" cx="300" cy="320" rx="70" ry="30"/>
<ellipse class="attr" cx="600" cy="320" rx="70" ry="30"/>
<polygon class="rel-outer" points="450,34 531,80 450,126 369,80"/>
<polygon class="rel" points="450,40 525,80 450,120 375,80"/>
<rect class="ent-outer" x="359" y="169" width="182" height="82" rx="4"/>
<rect class="ent" x="365" y="175" width="170" height="70" rx="4"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="700" y="30" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Student</text>
<text class="lbl" x="785" y="70">Section</text>
<text class="lbl" x="450" y="215">Waitlist</text>
<text class="lbl" x="450" y="84">joins</text>
<text x="300" y="325">date_joined</text>
<text x="600" y="325">position</text>
<text class="card" x="70" y="120">M</text>
<text class="card" x="740" y="120">N</text>
</svg>
</div>

---

# Worked Example: The Full E-R Diagram

<div class="thread">Every piece from this lecture, assembled into the registration system's actual design.</div>

<div class="er">
<svg viewBox="0 0 1050 470" width="660" height="295">
<line class="link" x1="120" y1="70" x2="300" y2="120"/>
<line class="link" x1="300" y1="120" x2="275" y2="225"/>
<line class="link" x1="300" y1="120" x2="525" y2="230"/>
<line class="link" x1="525" y1="230" x2="770" y2="120"/>
<line class="link" x1="770" y1="120" x2="930" y2="70"/>
<line class="link" x1="525" y1="230" x2="525" y2="308"/>
<line class="link" x1="525" y1="308" x2="525" y2="396"/>
<polygon class="rel-outer" points="300,72 381,120 300,168 219,120"/>
<polygon class="rel" points="300,78 375,120 300,162 225,120"/>
<polygon class="rel" points="770,78 845,120 770,162 695,120"/>
<polygon class="rel" points="525,270 600,308 525,346 450,308"/>
<rect class="ent-outer" x="184" y="184" width="182" height="82" rx="4"/>
<rect class="ent" x="190" y="190" width="170" height="70" rx="4"/>
<rect class="ent" x="30" y="30" width="180" height="80" rx="4"/>
<rect class="ent" x="840" y="30" width="180" height="80" rx="4"/>
<rect class="ent" x="435" y="190" width="180" height="80" rx="4"/>
<rect class="ent" x="435" y="356" width="180" height="80" rx="4"/>
<text class="lbl" x="120" y="75">Student</text>
<text class="lbl" x="930" y="75">Course</text>
<text class="lbl" x="525" y="235">Section</text>
<text class="lbl" x="525" y="401">Instructor</text>
<text class="lbl" x="275" y="229">Enrollment</text>
<text class="lbl" x="300" y="124">enrolls</text>
<text class="lbl" x="770" y="124">belongs to</text>
<text class="lbl" x="525" y="312">taught by</text>
<text class="keytxt" x="120" y="126">student_id</text>
<text class="keytxt" x="930" y="126">course_code</text>
<text class="keytxt" x="525" y="182">section_id</text>
<text class="keytxt" x="525" y="452">instructor_id</text>
<text class="keytxt" x="275" y="278">student_id, section_id</text>
<text class="card" x="70" y="130">M</text>
<text class="card" x="395" y="225">N</text>
<text class="card" x="655" y="225">N</text>
<text class="card" x="860" y="130">1</text>
<text class="card" x="655" y="270">N</text>
<text class="card" x="655" y="375">1</text>
</svg>
</div>

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

# Participation Constraints: Definition

<div class="thread">Cardinality says how many. Participation says whether every instance is required to show up at all.</div>

> **Total participation:** every instance of the entity set must
> participate in the relationship. **Partial participation:** some
> instances may participate in zero relationships.

Chen notation draws total participation as a **double line** from
entity to diamond, and partial participation as a **single line**,
independent of whether the cardinality on that line is 1 or N.

---

# Participation Constraints: Worked Example

<div class="thread">The registration system's own "taught by" relationship, both constraints at once.</div>

<div class="er">
<svg viewBox="0 0 900 300" width="640" height="213">
<line class="link" x1="200" y1="130" x2="375" y2="135"/>
<line class="link" x1="200" y1="140" x2="375" y2="145"/>
<line class="link" x1="525" y1="135" x2="700" y2="135"/>
<polygon class="rel" points="450,95 525,135 450,175 375,135"/>
<rect class="ent" x="30" y="100" width="170" height="70" rx="4"/>
<rect class="ent" x="700" y="100" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="140">Section</text>
<text class="lbl" x="785" y="140">Instructor</text>
<text class="lbl" x="450" y="139">taught by</text>
<text class="card" x="230" y="115">N</text>
<text class="card" x="570" y="115">1</text>
</svg>
</div>

Section's **double line**: total participation, every Section must be
taught by some Instructor. Instructor's **single line**: partial
participation, an Instructor on research leave may teach no Section
this term.

---

# Cardinality Notation: (min, max)

<div class="thread">A second notation, seen in many textbooks and tools, that folds cardinality and participation into one pair of numbers.</div>

> **(min, max)** on an entity's edge states the least and most times
> one instance of it can appear in the relationship. **min = 0** means
> partial participation; **min ≥ 1** means total.

| Side | 1:N-style label | (min, max) | Reading |
|---|---|---|---|
| Section | N | (1, 1) | each Section has exactly one Instructor |
| Instructor | 1 | (0, N) | each Instructor teaches zero to many Sections |

---

# (min, max) Worked Example: Enrolls

<div class="thread">Applied to last week's M:N relationship, both sides partial this time.</div>

| Side | Ratio notation | (min, max) | Reading |
|---|---|---|---|
| Student | M | (0, N) | a student may enroll in zero to many Sections |
| Section | N | (0, N) | a Section may have zero to many enrolled students |

Both sides read `(0, N)` here: a brand-new student who has not
registered yet, and a brand-new section with no enrollments yet, are
both real, valid states.

---

# Why (min, max) Subsumes Both Ideas

<div class="why">
The old 1:1 / 1:N / M:N labels only ever stated the <strong>max</strong>.
Writing the <strong>min</strong> explicitly folds in exactly what the
last two slides called "total" (min = 1) or "partial" (min = 0) - one
notation, instead of two separate ideas stated on two separate slides.
</div>

---

# Specialization: Definition

<div class="thread">Not every instance of an entity set is the same kind of thing.</div>

> **Specialization** splits an entity set into subclasses, each
> holding additional attributes only its own instances have, while
> still inheriting every attribute of the entity set it came from.

`Instructor` is not one uniform kind of person: an adjunct instructor
is paid by the course, a full-time instructor holds an office and a
tenure track. Specialization gives each distinction its own place in
the design, without duplicating the attributes they share.

---

# Specialization: Worked Example - Instructor

<div class="thread">One superclass, two subclasses, drawn with the ISA triangle.</div>

<div class="er">
<svg viewBox="0 0 900 540" width="567" height="340">
<line class="link" x1="330" y1="80" x2="420" y2="140"/>
<line class="link" x1="570" y1="80" x2="480" y2="140"/>
<ellipse class="attr" cx="330" cy="60" rx="75" ry="28"/>
<ellipse class="attr" cx="570" cy="60" rx="75" ry="28"/>
<rect class="ent" x="365" y="140" width="170" height="70" rx="4"/>
<line class="link" x1="450" y1="210" x2="450" y2="250"/>
<polygon class="rel" points="450,250 500,295 400,295"/>
<line class="link" x1="410" y1="295" x2="250" y2="360"/>
<line class="link" x1="490" y1="295" x2="650" y2="360"/>
<rect class="ent" x="165" y="360" width="170" height="70" rx="4"/>
<rect class="ent" x="565" y="360" width="170" height="70" rx="4"/>
<line class="link" x1="250" y1="430" x2="250" y2="470"/>
<line class="link" x1="650" y1="430" x2="650" y2="470"/>
<ellipse class="attr" cx="250" cy="490" rx="80" ry="28"/>
<ellipse class="attr" cx="650" cy="490" rx="80" ry="28"/>
<text class="lbl" x="450" y="180">Instructor</text>
<text class="lbl" x="250" y="400">Adjunct</text>
<text class="lbl" x="650" y="400">Full-time</text>
<text class="lbl" x="450" y="278">ISA</text>
<text x="330" y="65">instructor_id</text>
<text x="570" y="65">name</text>
<text x="250" y="495">hourly_rate</text>
<text x="650" y="495">office</text>
</svg>
</div>

---

# Specialization: Attribute Inheritance, Explicitly

<div class="thread">The rule the diagram draws, spelled out in words.</div>

- **`Adjunct` has:** `instructor_id`, `name` (inherited), plus its own
  `hourly_rate`
- **`Full-time` has:** `instructor_id`, `name` (inherited), plus its
  own `office`
- Neither subclass redeclares `instructor_id` or `name`, inheritance
  means every subclass gets them automatically, exactly like a subclass
  in object-oriented code inherits its parent class's fields

---

# Generalization: The Inverse Direction

<div class="thread">Same picture, opposite starting point.</div>

> **Generalization** starts from several entity sets that share
> attributes and factors the shared attributes out into one new
> superclass.

If `Adjunct` and `Full-time` had been designed first, as two unrelated
entity sets, a designer would notice both already have an
`instructor_id` and a `name`, and factor those two attributes out into
a new `Instructor` superclass - the same diagram as the previous slide,
just discovered in the opposite direction.

---

# Constraints on Specialization

<div class="thread">Two independent questions, asked about any ISA split.</div>

| Constraint | Meaning | Registration example |
|---|---|---|
| Disjoint | an instance belongs to at most one subclass | An Instructor is Adjunct or Full-time, never both |
| Overlapping | an instance can belong to more than one subclass | A Student could be both an Athlete and a Scholarship Recipient |
| Total | every instance of the superclass belongs to some subclass | Every Instructor is Adjunct or Full-time, no third kind exists |
| Partial | some instances belong to no subclass at all | Not every Student is an Athlete or a Scholarship Recipient |

The Instructor split from two slides ago is **disjoint and total**: no
overlap, and no instructor escapes both categories.

---

# Aggregation: Definition

<div class="thread">One gap ER notation, as covered so far, cannot express.</div>

> **Aggregation** treats an entire relationship set, together with the
> entity sets it connects, as a single higher-level entity, so that it
> can itself participate in a further relationship.

Without aggregation, a relationship set has no way to connect onward to
a third entity set. Aggregation gives a relationship set exactly that
ability, by wrapping it as one unit.

---

# Aggregation: Worked Example

<div class="thread">A new requirement `Enrolls` was never built to answer on its own.</div>

New requirement: "record which academic advisor approved each
enrollment." Approval is not a fact about a Student alone, or a Section
alone, it is a fact about one specific enrollment. Aggregation treats
`Enrolls` (Student-Section) as one entity, so a new relationship,
`Approved By`, can connect it to `Advisor`.

<div class="er">
<svg viewBox="0 0 900 480" width="620" height="331">
<rect x="10" y="90" width="780" height="160" rx="6" fill="none" stroke="var(--navy)" stroke-width="2" stroke-dasharray="8,5"/>
<line class="link" x1="200" y1="175" x2="320" y2="175"/>
<line class="link" x1="460" y1="175" x2="560" y2="175"/>
<polygon class="rel" points="390,135 460,175 390,215 320,175"/>
<rect class="ent" x="30" y="140" width="170" height="70" rx="4"/>
<rect class="ent" x="560" y="140" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="180">Student</text>
<text class="lbl" x="645" y="180">Section</text>
<text class="lbl" x="390" y="179">Enrolls</text>
<text class="card" x="235" y="165">M</text>
<text class="card" x="500" y="165">N</text>
<line class="link" x1="400" y1="250" x2="400" y2="290"/>
<polygon class="rel" points="400,290 470,325 400,360 330,325"/>
<line class="link" x1="400" y1="360" x2="400" y2="400"/>
<rect class="ent" x="315" y="400" width="170" height="70" rx="4"/>
<text class="lbl" x="400" y="330">Approved By</text>
<text class="lbl" x="400" y="440">Advisor</text>
<text class="card" x="415" y="380">N</text>
<text class="card" x="415" y="410">1</text>
</svg>
</div>

The dashed boundary is the aggregated entity: `Enrolls` itself, now
able to connect onward to `Advisor`, exactly what a plain relationship
set could never do.

---

# Aggregation vs. a Plain Ternary Relationship

<div class="thread">Easy to confuse with Week 3's ternary example. Here is the actual difference.</div>

A ternary relationship (`Offers`: Instructor, Course, Semester) connects
**three entity sets that all exist independently, at the same level**.
Aggregation instead takes a relationship that already exists between
two entity sets and treats **that relationship itself** as the thing
connecting onward to a third. The registration system needs both:
`Offers` is a genuine three-way fact; "who approved this enrollment" is
a fact about the enrollment relationship, not a fourth independent
entity set.

---

# Common Mistakes: Advanced ER Concepts

- **Drawing every line the same weight:** skipping the single-vs-double
  line distinction quietly turns partial participation into total, or
  the reverse, without anyone deciding to
- **Making specialization overlapping by default:** most real subclass
  splits are disjoint; overlapping should be a deliberate design
  decision, not an oversight
- **Adding a fourth entity instead of aggregating:** the approval
  example above does not need a new `EnrollmentApproval` entity with
  its own copy of student and section, aggregation already says
  exactly what is meant

---

# Practice: A Library System - Participation Constraint

Requirement: "every copy of a book must currently be shelved in
exactly one library branch; a branch may exist with no copies yet
(newly opened)."

**Question:** which side is total, which is partial?

**Answer:** **Copy is total** (every copy must be at some branch,
min = 1). **Branch is partial** (a branch can have zero copies,
min = 0).

---

# Practice: A Fitness App - Specialization

Requirement: "a workout plan is either a strength plan, tracking sets
and reps, or a cardio plan, tracking distance and duration."

**Question:** is this specialization disjoint or overlapping, total or
partial?

**Answer:** **Disjoint and total.** Every plan is exactly one of the
two kinds, and neither kind can also be the other.

---

# Practice: A Ride-Hailing App - Aggregation

Requirement: "record which promo code, if any, was applied to a given
ride."

**Question:** does this call for aggregation, and if so, around what?

**Answer:** **Yes**, around the `Ride` relationship (Driver-Rider).
"Applied a promo code" is a fact about one specific ride, so `Ride`
must be treated as an entity in its own right before it can connect
onward to `PromoCode`.

---

# Check Yourself: Advanced ER Concepts

1. A `Section` can exist with zero students enrolled; every `Student`
   must eventually enroll in at least one Section to remain active.
   Write both sides using (min, max) notation.
2. `Vehicle` specializes into `Car` and `Motorcycle`. Is this
   specialization more likely disjoint or overlapping? Why?
3. Why can't a plain relationship set connect directly to a third
   entity set without aggregation?

---

# Answers

1. **Section: (0, N).** **Student: (1, N).**
2. **Disjoint.** A single vehicle is built as one kind or the other,
   never both at once, unlike the Athlete/Scholarship Recipient
   overlapping example.
3. A relationship set is a connection between existing entities, not
   an entity itself; without aggregation there is no "thing" for a
   third relationship to attach to, only two entities and a diamond
   between them.

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

# A Note on Sources

<div class="thread">One line of attribution, stated once.</div>

This week's coverage of participation constraints, (min, max)
notation, specialization, generalization, and aggregation follows the
standard chapter organization of Silberschatz, Korth, and Sudarshan's
*Database System Concepts*, 7th ed., this course's primary reference
text. Every diagram, example, and explanation on these slides is
original, built around this course's own registration case study.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
