# Week 4 Handout: E-R Diagram

Database Systems (511783-001) — for students to keep and read again.
Use plain, simple English on purpose, so it is easy to read even if
English is not your first language.

**Assignment 1 is due this week:** an E-R diagram for a system of your
choice, using everything in this handout. Nothing else about it is
graded content here — see the course handbook for the submission
details.

---

## 1. Glossary: Key Words This Week

Read each definition once now. You do not need to memorize them today —
you will use them all semester.

| Term | Plain definition |
|---|---|
| **Entity** | A real-world thing, distinguishable from every other thing, that a system needs to track. Example: Student, Course, Instructor, Section |
| **Attribute** | A property that describes an entity. Example: `student_id`, `name`, `major` describe Student |
| **Simple attribute** | An attribute that cannot be broken down into smaller parts, one atomic value |
| **Composite attribute** | An attribute made of smaller, meaningful parts, like `name` splitting into `first_name` and `last_name` |
| **Key attribute** | The attribute that uniquely identifies an entity. The conceptual-stage version of last week's primary key |
| **Relationship** | An association between two or more entities, drawn as a labeled connection instead of a sentence |
| **Cardinality** | States how many instances of one entity can relate to how many instances of another. Every relationship must state one of the three below, out loud, on the diagram |
| **1:1 cardinality** | One instance on one side relates to exactly one instance on the other side |
| **1:N cardinality** | One instance on one side relates to many instances on the other; each of those many relates back to exactly one |
| **M:N cardinality** | Many instances on one side relate to many instances on the other, in both directions at once |
| **Weak entity** | An entity with no key attribute of its own; it can only be uniquely identified in combination with another entity's key |
| **Strong entity** | An entity with its own key attribute, identified on its own, without borrowing identity from another entity |
| **E-R diagram (E-R model)** | Peter Chen's 1976 notation for conceptual design: entities, attributes, relationships, and cardinality, drawn so ambiguity becomes visible |
| **Conceptual design** | The design stage above the relational model, described with entities and relationships, not yet tables |
| **Notation** | An agreed set of symbols and rules for writing something down precisely, so two readers cannot disagree about what it means |

---

## 2. The Registration System's E-R Diagram, Worked Out Step by Step

This is the full version of the story from class. Read it slowly if the
in-class pace felt fast.

**The situation.** Two designers each write a conceptual description of
the registration system in plain English. One writes: "a student has
enrollments, and each enrollment has a section." The other writes: "a
section has many students, and grades belong to the student." Both
sentences sound reasonable. Read closely, they disagree about where the
grade actually lives, and neither sentence makes that disagreement
obvious. Prose hides ambiguity inside grammar — nothing forces either
designer to say how many students one section can have, or whether an
enrollment can exist without a grade yet. An E-R diagram exists to make
that kind of disagreement impossible to leave unstated.

**Step 1: Name the entities.** Start from a plain-English requirement:
"Every student enrolls in one or more course sections, taught by an
instructor, in a specific room." Circle the nouns that matter. Student,
Section, and Instructor are entities — each is tracked over time and has
its own attributes. Room, for now, is not its own entity; it is just one
attribute of Section, unless the system later needs to track rooms
independently (capacity, building, its own schedule).

**Step 2: Give each entity its attributes, and classify them.** Student
has `student_id`, `name`, and `major`. `student_id` is Student's **key
attribute** — the thing that makes each Student distinguishable, one
design stage earlier than a formal `PRIMARY KEY`. `name` is a
**composite attribute** — it could split into `first_name` and
`last_name` the moment the system needs to sort or address someone by
one part alone. `major` and `student_id` are otherwise **simple
attributes** — one atomic value each, no internal structure worth
tracking separately.

**Step 3: Draw the relationships, with cardinality stated explicitly.**
Student to Section is **M:N** — a Student takes many Sections, and a
Section holds many Students, in both directions at once. Section to
Course is **N:1** — many Sections belong to one Course. Section to
Instructor is **N:1** — many Sections are taught by one Instructor, each
Section has exactly one. Every one of these numbers is stated on the
diagram itself, exactly the discipline missing from the two designers'
prose.

**Step 4: Decide weak or strong.** An M:N relationship, like Student to
Section, cannot be represented by a single foreign key on either side —
that is exactly why an `Enrollment` entity has to exist. But
`Enrollment` is not really "a thing" the way a Student is: "this
enrollment" means nothing without a specific student and a specific
section. It has no key attribute of its own; its identity is borrowed —
`{student_id, section_id}` together, not either alone. That makes it a
**weak entity**. The same pattern repeats for a second worked example
from class, `Waitlist` (attributes `position` and `date_joined`): neither
attribute means anything without knowing which student and which
section, so `Waitlist` is weak too, identity borrowed from both sides,
same shape as `Enrollment`.

Put together, the registration system's complete conceptual design is:
**Entities** — Student, Course, Instructor, Section, Enrollment (weak).
**Relationships** — Student M:N Section (via the weak entity
Enrollment), Section N:1 Course, Section N:1 Instructor.

**What we still can't say yet.** We now have a precise, checkable
conceptual design — entities, attributes, relationships, and cardinality
all stated explicitly, not left implied in a sentence. But a diagram is
not a database. No DBMS can run a diagram. Everything drawn this week
still has to become real relations, with real primary keys and foreign
keys, and nothing so far tells us the exact mechanical steps to get
there. That is Week 6's job — a deterministic mapping algorithm from
E-R diagram to relational schema.

---

## 3. Optional Reading: Extra Detail (Not Required, Not on the Quiz)

This section holds extra explanations that were trimmed from the slides
to keep class time short. Read it if you are curious or want more
examples.

**Where this notation came from.** In 1976, Peter Chen published "The
Entity-Relationship Model," proposing a diagram notation specifically so
conceptual designs could be *checked*, not just read. The goal was
explicit: a notation simple enough for a non-programmer stakeholder to
verify, but precise enough that an engineer could translate it into
tables without guessing. Chen's answer to last week's ambiguity problem
was invented on purpose, not discovered by accident.

**What ambiguous prose actually costs.** An ambiguous conceptual design
gets built into an ambiguous logical schema, and the mistake is far more
expensive to fix once tables and data already exist. Two developers
implementing the "same" prose requirement independently will build
incompatible systems that cannot be merged later. And a stakeholder
reading a paragraph cannot verify it the way they can verify a diagram
with explicit boxes, lines, and numbers.

**Where cardinality shows up around you.** Every app on your phone made
these exact choices. On Instagram, User is M:N Post, via Like, itself a
weak entity — a like means nothing without knowing which user liked
which post. On KakaoTalk, User is M:N ChatRoom, via Membership. On
Netflix, Profile is 1:N WatchHistory entry. On 배달의민족, Restaurant is
1:N MenuItem. Every M:N relationship on that list needed its own weak
entity, exactly like Enrollment, the moment someone actually built the
app.

**In industry:** E-R diagrams (or their close cousins, UML class
diagrams) are standard artifacts in any system design review. Being
able to read and draw one is assumed on the job, not taught there.

**Who actually uses this, as a job.**

- **Database designers / data architects** turn a stakeholder's
  plain-English requirements into an E-R diagram before any table is
  created
- **Business analysts** use E-R diagrams to confirm with non-technical
  stakeholders that a system's requirements were understood correctly
- **Backend / application engineers** read an existing E-R diagram (or
  the schema it produced) to understand how data connects before adding
  a new feature
- **Database administrators (DBAs)** rely on a clear E-R diagram to
  judge whether a proposed schema change will break an existing
  relationship

---

## 4. Practice Problems (With Answers)

Try each problem yourself before checking the answer underneath it.

**Problem 1.** Requirement: "A library holds many copies of a book. A
member can borrow a copy, but only one member at a time per copy."
Identify the entities, and state the cardinality between Member and
Copy.
> **Answer:** Entities: Member, Book, Copy. Member to Copy is **1:N**
> at any given moment (one member can hold several copies out at once;
> each copy is checked out to at most one member at a time), via a weak
> entity, `Loan`.

**Problem 2.** "A Driver gives many Rides; a Rider takes many Rides;
each Ride has exactly one Driver and one Rider." Is `Ride` a strong or
a weak entity, and why?
> **Answer:** **Weak.** A Ride has no independent meaning without both
> a Driver and a Rider — its identity is borrowed from the combination,
> exactly Enrollment's relationship to Student and Section.

**Problem 3.** Is `office_number` an attribute of Instructor, or a
separate entity? Justify your answer.
> **Answer:** **Attribute**, unless the system needs to track offices
> independently of instructors (shared offices, office assignments over
> time). As stated, it is one property of one instructor.

**Problem 4.** A Section can have several TAs, and a TA can help with
several Sections. What cardinality is that?
> **Answer:** **M:N**, many-to-many, the same shape as Student to
> Section.

**Problem 5.** In the ride-hailing example, why can't `Ride` simply be
added as a foreign key on `Driver`?
> **Answer:** Because the relationship is M:N (many drivers, many
> riders, many rides), and an M:N relationship can never be captured by
> a single foreign key on either side — exactly the same reason
> Enrollment needs to be its own relation.

**Problem 6.** A designer gives `Enrollment` its own independent
`enrollment_id`, in addition to `student_id` and `section_id`. Is this
necessary? Why or why not?
> **Answer:** **No.** `{student_id, section_id}` already uniquely
> identifies an Enrollment — that combination is exactly its borrowed
> identity as a weak entity. Adding `enrollment_id` on top gives it a
> key with no real-world meaning, one of this week's common mistakes.
