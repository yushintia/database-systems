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

- **Last week delivered:** three design stages, conceptual, logical,
  physical, and a definition of what makes a design "good"
- **Last week left broken:** conceptual design, in plain English
  prose, is not verifiable. Two people still disagree, one level
  higher up than before

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

# Worked Example: Entities in a Library System

<div class="thread">The same test, applied outside the registration system.</div>

Requirement: "A library holds many copies of a book. A member can
borrow a copy, but only one member at a time per copy."

| Candidate noun | Entity? | Why |
|---|---|---|
| book | Yes | tracked over time, has its own title and author |
| copy | Yes | a specific physical item, distinguishable from other copies of the same book |
| member | Yes | tracked over time, has borrowing history |

`copy` is the interesting case: it is not the same thing as `book`, a
single title can have many physical copies, and only one of them can
be lent out to a given member at a time.

---

# Worked Example: Entities in a Food Delivery App

<div class="thread">A third system, the same discipline every time.</div>

Requirement: "A food delivery app has restaurants, menu items, and
orders. A customer's order can contain several menu items, from only
one restaurant."

| Candidate noun | Entity? | Why |
|---|---|---|
| restaurant | Yes | tracked over time, has its own menu |
| menu item | Yes | tracked over time, has its own name and price |
| order | Yes | a specific event, distinguishable from every other order |
| customer | Yes | tracked over time, places many orders |

---

# When a Noun Is NOT an Entity, More Examples

<div class="thread">The negative case matters as much as the positive one.</div>

| Candidate noun | Entity? | Why |
|---|---|---|
| grade | No | one property of one `Enrollment`, not tracked on its own |
| semester | No | one property of one `Section`, not a thing with its own history |
| room (from the opening slide) | No, for now | just an attribute of Section |

<div class="why">
The test never changes: does this noun need to be tracked
independently, with its own attributes and its own history, or does it
only ever describe something else?
</div>

---

# Three Kinds of Attribute

<div class="thread">Not every attribute is the same kind.</div>

- **Simple:** cannot be broken into smaller parts - `student_id`,
  `grade`, `room`, one atomic value each
- **Composite:** made of smaller, meaningful parts - `name` could
  split into `first_name` and `last_name` the moment the system needs
  to sort by last name alone
- **Key:** uniquely identifies the entity, exactly last week's primary
  key idea, one design stage earlier - `student_id` is Student's key
  attribute, not yet a formal `PRIMARY KEY` (that's Week 9)

---

# Worked Example: Simple vs. Composite, Drawn

<div class="thread">The same split from the previous slide, as an actual diagram.</div>

<div class="er">
<svg viewBox="0 0 700 350" width="520" height="260">
<title>Diagram showing a Student entity's composite attribute name splitting, via two link lines, into two simple attributes: first_name and last_name.</title>
<line class="link" x1="350" y1="100" x2="350" y2="148"/>
<line class="link" x1="330" y1="208" x2="230" y2="258"/>
<line class="link" x1="370" y1="208" x2="470" y2="258"/>
<ellipse class="attr" cx="350" cy="178" rx="95" ry="30"/>
<ellipse class="attr" cx="230" cy="288" rx="80" ry="30"/>
<ellipse class="attr" cx="470" cy="288" rx="80" ry="30"/>
<rect class="ent" x="265" y="30" width="170" height="70" rx="4"/>
<text class="lbl" x="350" y="70">Student</text>
<text x="350" y="182">name</text>
<text x="230" y="292">first_name</text>
<text x="470" y="292">last_name</text>
</svg>
</div>

`name` stays a single composite attribute until the system actually
needs `first_name` and `last_name` separately - drawing the split is
optional, and only done when it matters.

---

# Worked Example: Classifying Every Attribute of Section

<div class="thread">Applying the three kinds to one entity, completely.</div>

| Attribute | Kind | Why |
|---|---|---|
| section_id | Key | uniquely identifies this Section |
| room | Simple | one atomic value, no meaningful smaller parts |
| semester | Simple | one atomic value (e.g. `2026-2`) |

Every attribute of `Section` classified, no attribute left unlabeled -
exactly the discipline this notation demands.

---

# Worked Example: Classifying Every Attribute of Instructor

<div class="thread">The same discipline, on an entity with a genuine judgment call.</div>

| Attribute | Kind | Why |
|---|---|---|
| instructor_id | Key | uniquely identifies this Instructor |
| name | Simple, *or* composite | simple if never split; composite the moment the system needs `first_name`/`last_name` separately |
| office_number | Simple | one atomic value, no meaningful smaller parts |

<div class="why">
Simple vs. composite is not a fixed property of a word like "name" -
it depends on whether <em>this system</em> ever needs the parts
separately. Two different systems can classify the same attribute two
different ways, correctly.
</div>

---

# Worked Example: Classifying Every Attribute of Course

<div class="thread">A short one - not every entity needs a long table.</div>

| Attribute | Kind | Why |
|---|---|---|
| course_code | Key | uniquely identifies this Course |
| title | Simple | one atomic value, no meaningful smaller parts |

Two attributes, both classified. A small entity is not an excuse to
skip the classification step.

---

# Key Attributes Across the Whole Diagram

<div class="thread">Every key attribute from this lecture's main example, in one place.</div>

| Entity | Key attribute(s) |
|---|---|
| Student | student_id |
| Course | course_code |
| Instructor | instructor_id |
| Section | section_id |
| Enrollment (weak) | borrowed: {student_id, section_id} |

Four strong entities, each with its own key attribute. One weak
entity, with no key attribute of its own - the next section explains
exactly why.

---

# Relationships and Cardinality

<div class="thread">Entities alone are just a list. Relationships, precisely stated, are where the actual design happens.</div>

> A **relationship** is an association between two or more entities.
> **Cardinality** states how many instances of one entity can relate
> to how many instances of another - stated explicitly, out loud, on
> the diagram, exactly the discipline missing from the pain slide's
> two sentences.

| Cardinality | Meaning | Registration example |
|---|---|---|
| **1:1** | one instance relates to exactly one | (rare in this system) |
| **1:N** | one relates to many; each of the many relates back to one | one Instructor teaches many Sections |
| **M:N** | many relate to many, both directions at once | Students enroll in many Sections; Sections hold many Students |

<div class="why">
M:N cannot be represented by a single foreign key on either side -
exactly why Week 2's Enrollment relation had to exist in the first place.
</div>

---

# Worked Example: 1:1 Cardinality, A Concrete Case

<div class="thread">The rare case, made concrete instead of left as "(rare in this system)."</div>

A small department rule: one Student is assigned exactly one Advisor,
and one Advisor advises exactly one Student. Neither side can relate
to more than one instance of the other.

<div class="why">
This is illustrative only, not part of the registration system's
actual schema - the real system's Instructor-Section relationship is
1:N, one instructor teaches many sections. 1:1 exists in the notation,
even when this particular system rarely needs it.
</div>

---

# Worked Example: 1:1 Cardinality, Diagrammed

<div class="thread">The advising rule from the previous slide, drawn.</div>

<div class="er">
<svg viewBox="0 0 700 200" width="520" height="149">
<title>Diagram of a one-to-one relationship: one Student has exactly one assigned Advisor, and one Advisor advises exactly one Student. Illustrative only, not part of the registration system's actual schema.</title>
<line class="link" x1="115" y1="65" x2="350" y2="80"/>
<line class="link" x1="350" y1="80" x2="585" y2="65"/>
<polygon class="rel" points="350,40 425,80 350,120 275,80"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="500" y="30" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Student</text>
<text class="lbl" x="585" y="70">Advisor</text>
<text class="lbl" x="350" y="84">advised by</text>
<text class="card" x="220" y="65">1</text>
<text class="card" x="480" y="65">1</text>
</svg>
</div>

A 1 on both ends: exactly one Advisor per Student, exactly one Student
per Advisor.

---

# Worked Example: 1:N Cardinality, Isolated

<div class="thread">One relationship pulled out of the full diagram, so the reasoning is easier to see.</div>

<div class="er">
<svg viewBox="0 0 700 260" width="520" height="193">
<title>Diagram of the one-to-many relationship between Course and Section: Course relates to Section as 1 to N, with the relationship diamond labeled belongs to.</title>
<line class="link" x1="115" y1="65" x2="350" y2="120"/>
<line class="link" x1="350" y1="120" x2="585" y2="65"/>
<polygon class="rel" points="350,80 425,120 350,160 275,120"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="500" y="30" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Course</text>
<text class="lbl" x="585" y="70">Section</text>
<text class="lbl" x="350" y="124">belongs to</text>
<text class="card" x="220" y="105">1</text>
<text class="card" x="480" y="105">N</text>
</svg>
</div>

One Course can have many Sections (CSE301's Monday section and its
Wednesday section are both "CSE301"). Each Section belongs to exactly
one Course - the "N" always sits on the side that can repeat.

---

# Worked Example: M:N Cardinality, A Second Case

<div class="thread">The same shape as Student-Section, in a different system.</div>

<div class="er">
<svg viewBox="0 0 700 260" width="520" height="193">
<title>Diagram of the many-to-many relationship between Order and MenuItem in a food delivery app: an Order can contain several menu items, and a MenuItem can appear on several orders, cardinality M to N.</title>
<line class="link" x1="115" y1="65" x2="350" y2="120"/>
<line class="link" x1="350" y1="120" x2="585" y2="65"/>
<polygon class="rel" points="350,80 425,120 350,160 275,120"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="500" y="30" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Order</text>
<text class="lbl" x="585" y="70">MenuItem</text>
<text class="lbl" x="350" y="124">contains</text>
<text class="card" x="220" y="105">M</text>
<text class="card" x="480" y="105">N</text>
</svg>
</div>

An Order can contain several menu items; a MenuItem (say, "Kimchi
Fried Rice") can appear on many different orders. Both directions
repeat, exactly the definition of M:N.

---

# Why Cardinality Must Be Stated on Both Sides

<div class="thread">A one-directional habit that quietly recreates last week's ambiguity.</div>

Look back at the registration diagram's Section-Instructor
relationship: **N** on the Section end, **1** on the Instructor end.
Stating only "many Sections per Instructor" and leaving the other end
implied is exactly the kind of gap this notation exists to close -
read from the Instructor's side, the same relationship must also say
"exactly one Instructor per Section," out loud, every time.

<div class="why">
Cardinality is a property of the <em>relationship</em>, not of either
entity alone - it has to be readable correctly starting from either
end.
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

# Worked Example: A Ride-Hailing App's Relationships

<div class="thread">The Sample Question at the end of this lecture, answered here first, as a real diagram.</div>

<div class="er">
<svg viewBox="0 0 1050 300" width="700" height="200">
<title>Diagram of a ride-hailing app's relationships: a Driver gives many Rides, a one-to-many relationship, and a Rider takes many Rides, a separate one-to-many relationship. Each Ride connects to exactly one Driver and one Rider.</title>
<line class="link" x1="115" y1="65" x2="280" y2="140"/>
<line class="link" x1="280" y1="140" x2="525" y2="150"/>
<line class="link" x1="525" y1="150" x2="770" y2="140"/>
<line class="link" x1="770" y1="140" x2="935" y2="65"/>
<polygon class="rel" points="280,95 355,140 280,185 205,140"/>
<polygon class="rel" points="770,95 845,140 770,185 695,140"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="850" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="440" y="120" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Driver</text>
<text class="lbl" x="935" y="70">Rider</text>
<text class="lbl" x="525" y="160">Ride</text>
<text class="lbl" x="280" y="144">gives</text>
<text class="lbl" x="770" y="144">taken by</text>
<text class="card" x="70" y="120">1</text>
<text class="card" x="395" y="168">N</text>
<text class="card" x="655" y="168">N</text>
<text class="card" x="860" y="120">1</text>
</svg>
</div>

Two separate 1:N relationships meeting at `Ride`, not one M:N
relationship - each Ride still has exactly one Driver and one Rider.

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
primary key includes a foreign key, exactly what Week 2 already showed
you in the Enrollment relation.
</div>

---

# Worked Example: Is This Entity Weak? A Test

<div class="thread">One question, asked of every entity: "can I identify one instance using only its own attributes?"</div>

**Section:** can `section_id` alone identify one instance, with no
help from another entity? Yes. **Strong.**

**Enrollment:** can any attribute of Enrollment alone identify one
instance? No - `student_id` alone names a student, not one enrollment;
`grade` alone names nothing. Identity requires help from both `Student`
and `Section`. **Weak.**

<div class="why">
This test is the entire definition, applied mechanically: no borrowed
help needed, strong; borrowed help required, weak.
</div>

---

# Worked Example: A Second Weak Entity, OrderLine

<div class="thread">The exact same shape as Enrollment, in the food delivery domain.</div>

<div class="er">
<svg viewBox="0 0 900 300" width="620" height="207">
<title>Diagram of the weak entity OrderLine in a food delivery app, connecting Order and MenuItem in a many-to-many relationship. OrderLine is drawn with a double border to mark it as a weak entity, borrowing its identity from both Order and MenuItem.</title>
<line class="link" x1="115" y1="65" x2="450" y2="80"/>
<line class="link" x1="450" y1="80" x2="785" y2="65"/>
<line class="link" x1="450" y1="120" x2="450" y2="175"/>
<polygon class="rel-outer" points="450,34 531,80 450,126 369,80"/>
<polygon class="rel" points="450,40 525,80 450,120 375,80"/>
<rect class="ent-outer" x="359" y="169" width="182" height="82" rx="4"/>
<rect class="ent" x="365" y="175" width="170" height="70" rx="4"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="700" y="30" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Order</text>
<text class="lbl" x="785" y="70">MenuItem</text>
<text class="lbl" x="450" y="215">OrderLine</text>
<text class="lbl" x="450" y="84">contains</text>
<text class="card" x="70" y="120">M</text>
<text class="card" x="740" y="120">N</text>
</svg>
</div>

`OrderLine` resolves Order M:N MenuItem, identity borrowed as
`{order_id, menu_item_id}` - not a coincidence that this is the exact
same shape as `Enrollment` and `Waitlist`.

---

# Worked Example: A Weak Entity Practice Drill

<div class="thread">Three quick scenarios, weak or strong, decided fast.</div>

| Scenario | Weak or strong? | Why |
|---|---|---|
| A library `Loan` record | Weak | needs both `Book` and `Member` to mean anything |
| A standalone `Payment` record with its own `payment_id` | Strong | `payment_id` alone identifies it, no borrowing needed |
| `OrderLine` (previous slide) | Weak | needs both `Order` and `MenuItem` |

---

# Worked Example: The Library's Copy Entity, Weak or Strong?

<div class="thread">A genuine judgment call, not a formula to memorize.</div>

Does `Copy` get its own `copy_id`, tracked independently (strong)? Or
is a copy identified only as "this Book, copy number 3" - borrowed from
`Book` (weak)? Both are defensible designs:

- **Strong**, if the library needs to track one specific physical
  copy's full history (repairs, condition) across its lifetime
- **Weak**, if a copy only ever needs to be told apart from the
  library's *other* copies of the *same* book

<div class="why">
The E-R notation does not hand you this answer - it forces you to
state your choice explicitly, on the diagram, instead of leaving it
implied.
</div>

---

# Worked Example: The Library System's Relationships, Diagrammed

<div class="thread">Taking the "strong Copy" choice from the previous slide, and drawing what follows from it.</div>

<div class="er">
<svg viewBox="0 0 700 200" width="520" height="149">
<title>Diagram of a one-to-many relationship between Book and Copy: one Book title has many physical Copies, and each Copy belongs to exactly one Book.</title>
<line class="link" x1="115" y1="65" x2="350" y2="80"/>
<line class="link" x1="350" y1="80" x2="585" y2="65"/>
<polygon class="rel" points="350,40 425,80 350,120 275,80"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="500" y="30" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Book</text>
<text class="lbl" x="585" y="70">Copy</text>
<text class="lbl" x="350" y="84">has</text>
<text class="card" x="220" y="65">1</text>
<text class="card" x="480" y="65">N</text>
</svg>
</div>

One Book has many Copies; each Copy belongs to exactly one Book -
1:N, the same shape as Course to Section.

---

# Worked Example: Attributes of the Library System, Classified

<div class="thread">One last pass, closing out the library example started earlier this lecture.</div>

| Entity | Attribute | Kind |
|---|---|---|
| Book | isbn | Key |
| Book | title | Simple |
| Book | author | Simple |
| Member | member_id | Key |
| Member | name | Simple, or composite |

Every entity from the library example now has entities, a
relationship with cardinality, and classified attributes - the same
three steps this lecture applies to the registration system.

---

# Worked Example: Notating the Waitlist, Step by Step

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

This is the complete conceptual design: Student, Course, Instructor,
Section, Enrollment (weak) and, from the four steps above, Waitlist
(weak) alongside it. Week 6 turns it into tables mechanically, no
guessing required.

---

# Worked Example: Reading the Full Diagram Backward

<div class="thread">Reverse-engineering the diagram: given the picture, recover the sentence that produced it.</div>

| Relationship on the diagram | Plain-English requirement it came from |
|---|---|
| Student M:N Section (via Enrollment) | "Students enroll in many sections; a section holds many students" |
| Section N:1 Course | "The same course code can show up in more than one section" |
| Section N:1 Instructor | "Every section has exactly one instructor of record" |
| Student M:N Section (via Waitlist) | "A student can join a waitlist for a full section" |

If you can state the sentence behind every box and line, you have
actually read the diagram, not just recognized its shapes.

---

# Worked Example: Attributes of the Waitlist Entity, Classified

<div class="thread">Closing the loop on the four-step Waitlist example with the classification this lecture teaches.</div>

| Attribute | Kind | Why |
|---|---|---|
| position | Simple | one atomic value (1st, 2nd, 3rd in line) |
| date_joined | Simple | one atomic value |

Neither attribute is a key attribute - `Waitlist`'s identity is
borrowed entirely from `Student` and `Section`, exactly what makes it
weak in the first place.

---

# Worked Example: A Second M:N Case, Fully Diagrammed

<div class="thread">The TA question from this lecture's Sample Questions, drawn out in full before you're asked to answer it.</div>

<div class="er">
<svg viewBox="0 0 700 260" width="520" height="193">
<title>Diagram of the many-to-many relationship between Section and TA: a Section can have several teaching assistants, and a TA can help with several sections, cardinality M to N.</title>
<line class="link" x1="115" y1="65" x2="350" y2="120"/>
<line class="link" x1="350" y1="120" x2="585" y2="65"/>
<polygon class="rel" points="350,80 425,120 350,160 275,120"/>
<rect class="ent" x="30" y="30" width="170" height="70" rx="4"/>
<rect class="ent" x="500" y="30" width="170" height="70" rx="4"/>
<text class="lbl" x="115" y="70">Section</text>
<text class="lbl" x="585" y="70">TA</text>
<text class="lbl" x="350" y="124">helped by</text>
<text class="card" x="220" y="105">M</text>
<text class="card" x="480" y="105">N</text>
</svg>
</div>

A Section can have several TAs; a TA can help with several Sections -
both directions repeat, M:N, the same shape as Student-Section.

---

# Weak Entity or Just a Relationship With Attributes?

<div class="thread">A confusion worth naming directly before it happens.</div>

`Enrollment.grade` lives inside the `Enrollment` relationship - it
does not make `grade` its own entity, and it does not, on its own,
make `Enrollment` weak. `Enrollment` is weak because it has **no key
attribute of its own**, not merely because it has attributes at all.

<div class="why">
Every weak entity carries attributes describing the relationship it
represents. Not every relationship's attribute turns that relationship
into a weak entity - only the missing independent key does that.
</div>

---

# Worked Example: Is Ride Weak or Strong?

<div class="thread">A trap worth walking through once, explicitly.</div>

`Ride` (from the ride-hailing example) has foreign keys to both
`Driver` and `Rider` - but it also has its own `ride_id`, assigned the
moment the ride is requested. `ride_id` alone identifies one Ride, no
borrowing required. **Strong**, despite depending on two other
entities for its foreign keys.

<div class="why">
Having foreign keys does not make an entity weak. Only the <em>absence
of an independent key attribute</em> does - `Section` also has two
foreign keys (`course_code`, `instructor_id`) and is strong for the
exact same reason `Ride` is.
</div>

---

# The Full Diagram, Annotated Checklist

<div class="thread">The same checklist a classmate will use to review your diagram.</div>

<div class="cardlist">
<div class="card"><div class="h">Entities present?</div><div class="d">every entity the requirements mention, drawn</div></div>
<div class="card"><div class="h">Cardinality typed?</div><div class="d">every relationship labeled 1:1, 1:N, or M:N, never left blank</div></div>
<div class="card"><div class="h">Weak entities marked?</div><div class="d">double border, and it's clear whose keys are borrowed</div></div>
<div class="card"><div class="h">Keys identified?</div><div class="d">every strong entity has at least one underlined key attribute</div></div>
<div class="card"><div class="h">Attributes classified?</div><div class="d">at least one composite attribute shown, or marked</div></div>
<div class="card"><div class="h">Readable alone?</div><div class="d">a stranger could reconstruct it with no verbal explanation</div></div>
</div>

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

# Common Mistakes, Continued

- **Confusing two separate M:N relationships between the same
  entities:** `Enrollment` and `Waitlist` both connect Student and
  Section, but they are two different real-world facts (already
  happened vs. waiting to happen) and must be drawn as two separate
  weak entities, never merged into one
- **Leaving a relationship's own attributes unattached:** `grade`
  belongs to the Student-Section relationship, not floating free or
  attached to the wrong entity

---

# Sample Question 1

**Question:** Is `office_number` an attribute of Instructor, or a
separate entity? Justify your answer.

**Answer:** **Attribute**, unless the system needs to track offices
independently of instructors (shared offices, office assignments over
time). As stated, it is one property of one instructor.

---

# Sample Question 2

**Question:** A Section can have several TAs, and a TA can help with
several Sections. What cardinality is that?

**Answer:** **M:N**, many-to-many, the same shape as Student to
Section.

---

# Sample Question 3

**Question:** In a ride-hailing app, "a Driver gives many Rides; a
Rider takes many Rides; each Ride has exactly one Driver and one
Rider," why can't `Ride` simply be a foreign key added to `Driver`?

**Answer:** Because the relationship is M:N (many drivers, many
riders, many rides), and an M:N relationship can never be captured by
a single foreign key on either side, exactly the same reason
Enrollment needs to be its own relation.

---

# Sample Question 4

**Question:** A designer gives `Enrollment` its own independent
`enrollment_id`, in addition to `student_id` and `section_id`. Is
this necessary? Why or why not?

**Answer:** **Not necessary.** `{student_id, section_id}` already
uniquely identifies every enrollment; adding `enrollment_id` gives
the weak entity a surrogate key it does not need, exactly the pitfall
this lecture's Common Mistakes slide names.

---

# Sample Question 5

**Question:** In the library system, is `Copy` weak or strong if it is
identified only as "this Book, copy number 3," with no `copy_id` of
its own?

**Answer:** **Weak.** Without its own `copy_id`, a copy can only be
told apart using "this Book" plus "copy number 3" together, borrowed
identity, the definition of a weak entity.

---

# Sample Question 6

**Question:** A food delivery app's `OrderLine` has attributes
`quantity` and `special_instructions`. Do either of these attributes
make `OrderLine` a strong entity? Why or why not?

**Answer:** **No.** `quantity` and `special_instructions` describe the
OrderLine relationship itself; they do not give it an independent
key. `OrderLine` stays weak, identified only as `{order_id,
menu_item_id}`.

---

<!-- SLOT N+1: Limits, becomes Week 6 slot 4 -->

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

<!-- SLOT N+2: Bridge -->

# Next Week

Week 4 leaves **turning a diagram into real tables** unsolved.
**Week 6, Mapping Algorithm**, addresses it: a deterministic, mechanical
procedure from E-R diagram to relational schema. (Week 5 is Quiz 1,
covering Weeks 1 through 4.)

---

<!-- SLOT N+3: Summary -->

# Summary

- Entities, attributes, and relationships give conceptual design a
  precise, checkable notation, replacing the ambiguity of prose.
- Cardinality (1:1, 1:N, M:N) forces every relationship to state
  exactly how many instances connect, out loud, on the diagram.
- A weak entity has no independent key; it borrows identity from the
  entities it connects, a direct preview of Week 6's mapping rules.
- **Lab page:** [Lab 4 in the online Lab Manual](../book/labs/lab04-er-diagram.html) - draw the full
  registration diagram yourself, including Waitlist, then peer-review
  a classmate's against a fixed checklist. **Assignment 1 due this
  week.**
- **Reading:** Silberschatz et al., 7th ed., Chapter 6
- **Prepare:** Quiz 1 next week covers Weeks 1 through 4. Review the
  registration system's E-R diagram until you can redraw it from memory.

---

<!-- SLOT N+4: Thank You -->
<!-- _class: end -->

# Thank You
