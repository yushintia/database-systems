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

# The Three Stages, As One Picture

<div class="thread">The same tiny design, carried through all three stages at once.</div>

<div class="trimodel">
<div class="panel">
<div class="hd">Conceptual</div>
<div class="bubble-row"><span class="bubble">Student</span><span class="bubble-arrow">enrolls in</span><span class="bubble">Section</span></div>
<div class="line">entities and a plain-language fact, no numbers, no columns</div>
</div>
<div class="arrow">&rarr;</div>
<div class="panel">
<div class="hd">Logical</div>
<div class="line">Student(student_id, name, major)</div>
<div class="line">Section(section_id, course_code, instructor_id)</div>
<div class="line">last week's world - Week 6's job to produce</div>
</div>
<div class="arrow">&rarr;</div>
<div class="panel">
<div class="hd">Physical</div>
<div class="line">an index on student_id</div>
<div class="line">speeds up "find this student's sections"</div>
<div class="line">much later in the course</div>
</div>
</div>

Same design, three levels of detail. This week never leaves the
leftmost panel.

---

# Worked Example: The Registration System, Stage by Stage

<div class="thread">One requirement, watched moving through all three stages.</div>

Requirement: "a student enrolls in a section."

- **Conceptual (this week):** entities `Student` and `Section`, a
  relationship "enrolls in" - no numbers, no columns
- **Logical (Week 6 preview):** becomes `Student(student_id, name,
  major)` plus an `Enrollment` relation - only named, not derived today
- **Physical (much later):** an index on `student_id` would speed up
  "find this student's sections" - a real concern, just not this week's

Naming the later stages is not the same as doing them. This slide is a
map, not a lesson in logical or physical design.

---

# What Conceptual Design Deliberately Leaves Out

<div class="thread">What's missing here is not an oversight. It's the whole point of the stage.</div>

Compare "a student enrolls in a section" (today's level of detail) to
Week 2's `Student(`**`student_id`**`, name, major)` (last week's level
of detail):

- No table name is chosen yet - just "Student," not `Student` the relation
- No attributes are listed yet - not even `name` or `major`
- No primary key is chosen yet - `student_id` doesn't exist as a concept here

Every one of those is a logical-design decision. Making them early,
before the entity list is settled, is exactly the mistake this week's
Common Mistakes slide warns about.

---

# Why the Order Never Reverses

<div class="thread">Skipping ahead to physical tuning before entities are settled wastes exactly the work it hoped to save.</div>

A team decides to add an index to speed up "find this student's
sections" before finishing conceptual design. Halfway through, the
registrar reveals the Waitlist requirement, and the entity list grows
by one. The index, tuned for the old, incomplete design, may no longer
even apply to the schema that eventually gets built.

<div class="pain">
Physical decisions are built on logical decisions, which are built on
conceptual decisions. Reordering the stages doesn't save time - it
just means redoing the early work after the late work already happened.
</div>

---

# Identifying Entities, A Method

<div class="thread">Before reading a real interview, a general rule for what even counts.</div>

A candidate noun becomes an **entity** when it is:

- **Tracked over time** - the system needs to remember it across many
  interactions, not just mention it once
- **Described by its own facts** - it has attributes worth recording
  on their own, not attributes that only make sense as part of
  something else

A noun that fails both tests (a location mentioned once, a status word)
usually is not an entity - just a detail of one.

---

# Worked Example: Entities in a Restaurant Requirement

<div class="thread">The method, applied to a brand-new domain.</div>

Requirement: *"A restaurant has a menu; each menu item has a price; a
customer places an order containing one or more menu items."*

| Candidate noun | Entity? | Why |
|---|---|---|
| menu item | Yes | tracked over time, has its own price |
| customer | Yes | tracked over time, places many orders |
| order | Yes | tracked over time, has its own contents |
| menu | No, for now | just a label for "the current set of menu items" |

---

# Worked Example: Relationships in the Restaurant Requirement

<div class="thread">Same requirement, now the facts connecting those entities.</div>

From the same sentence: *"a customer places an order containing one or
more menu items."*

- A **Customer** places an **Order** - one fact
- An **Order** contains one or more **MenuItem**s - a second, separate
  fact

No numbers are stated yet - "one or more" is the requirement's own
words, not a formal cardinality. That formal statement is Week 4's job,
not this week's.

---

# Worked Example: Entities and Relationships in a Gym Requirement

<div class="thread">A domain that mirrors the registration system's own Waitlist thread.</div>

Requirement: *"A gym member books a class. A class has a maximum
number of spots. If a class is full, a member can join a waitlist for
it."*

**Entities:** Member, Class, Waitlist. **Relationships:** a Member
books a Class; a Member joins a Waitlist for a Class.

<div class="why">
This is structurally the same shape as the registration system's own
Student-joins-Waitlist-for-Section fact - the exact same design
pattern, appearing in a second, unrelated domain.
</div>

---

# Worked Example: Entities and Relationships in a Workout-Log Requirement

<div class="thread">A third domain, the same method, applied cold.</div>

Requirement: *"Users log workouts. Each workout has exercises, and
each exercise has a number of reps and a weight."*

**Entities:** User, Workout, Exercise - each is tracked over time and
carries its own facts (`reps` and `weight` belong to Exercise, not to
Workout or User directly). **Relationships:** a User logs a Workout; a
Workout has Exercises.

---

# The Three-Pass Reading Technique

<div class="thread">A repeatable procedure, not a one-shot skill.</div>

1. **Pass 1 - circle every noun** that might be an entity, using the
   method above
2. **Pass 2 - circle every verb** connecting two of those nouns; each
   one is a candidate relationship
3. **Pass 3 - check the result against the four "good design" tests**
   before trusting it

<div class="why">
Three separate passes, on purpose. Trying to do all three at once on a
first read is exactly how a real requirement, like the waitlist rule
below, gets missed.
</div>

---

# Worked Example: A Second, Closer Read Finds a Missed Entity

<div class="thread">The same lesson the registrar interview teaches later, made explicit here first.</div>

A first read of the gym requirement stops at Member and Class. A
second, closer read of the same sentence - *"if a class is full, a
member can join a waitlist for it"* - surfaces a third entity,
Waitlist, hiding inside a conditional clause.

<div class="why">
This is not a special trick for one requirement. Any conditional
("if... then...") or passing clause is a place a first read regularly
skips - worth a deliberate second look, every time.
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

# Worked Example: Completeness, Tested

<div class="thread">The first test, run against the restaurant design.</div>

Does the restaurant model (Customer, MenuItem, Order, "places,"
"contains") capture that **one order can span several menu items**?
Yes - the relationship is stated as "an Order contains one or more
MenuItems," so an order with three items is already representable.
Completeness passes here; nothing in the requirement is left
unaccounted for.

---

# Worked Example: Correctness, Tested

<div class="thread">The second test, run against a rule the registrar stated once.</div>

The registrar's own rule: *"a student cannot be on the waitlist for a
section they're already enrolled in."* A model that has no way to
prevent that combination - a student appearing in both `Enrollment`
and `Waitlist` for the same section - has already failed Correctness,
even if every entity and relationship is otherwise present.

<div class="why">
Correctness is not about missing pieces (that's Completeness). It is
about the model permitting something the real world forbids.
</div>

---

# Worked Example: Minimal Redundancy, Tested

<div class="thread">The third test, on a library design instead of the registration system.</div>

A library design copies a book's `title` into every `Loan` row,
instead of keeping a separate `Book` entity that `Loan` simply refers
to. The book's title is now stored once per loan - update the title
after a reprint, and every past loan row still shows the old one,
disagreeing with the new `Book` entity.

<div class="pain">
This is Minimal Redundancy's failure mode exactly: the same fact,
duplicated by design, with no single place that is "the" truth.
</div>

---

# Worked Example: Understandability, Tested

<div class="thread">The fourth test, and a disagreement two designers might not even notice they have.</div>

Two designers read *"a customer places an order containing one or more
menu items"* separately. One assumes an order's quantity per item is
always 1. The other assumes a customer could order two of the same
item on one order. Nothing in the plain-English sentence settles which
reading is right - the model each of them draws will look different,
and neither would notice without comparing notes.

---

# The Four Tests, Applied to One Design at Once

<div class="thread">All four tests, run together against the gym design, as one integrated check.</div>

| Test | Gym design (Member, Class, Waitlist) | Result |
|---|---|---|
| Completeness | does it capture "a class has a maximum number of spots"? | Fails - no fact records the maximum yet |
| Correctness | does it prevent a member waitlisting for a class they're already booked into? | Needs the same rule as the registration system's Waitlist |
| Minimal redundancy | is any fact duplicated? | Passes, as drawn so far |
| Understandability | could a colleague reconstruct this from the entity/relationship list alone? | Passes, as drawn so far |

---

# Worked Example: Reading a Real Requirements Interview

<div class="thread">This week's registrar interview - the same one this week's lab works through in full.</div>

The registrar's own words, unstructured, the way real requirements
actually arrive: *"the same course code can show up more than once...
with different instructors or rooms"* → a Course and a Section are two
different things. *"the same student can enroll in several sections...
and a section obviously has many students"* → Student M:N Section.

---

# Worked Example: Reading the Interview, Continued

<div class="thread">The same interview, one requirement easy to miss on a first read.</div>

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

# Worked Example: The Interview, Continued - The Room Detail

<div class="thread">Not every noun in the interview earns entity status - even a real, physical thing.</div>

The registrar mentions a section's room only once, as a location
detail: *"...with different instructors or rooms."* Nothing in the
interview says the registrar needs to track a room's own history,
capacity, or schedule independently of the sections held in it. For
now, room stays a detail of Section, not a tracked thing of its own -
the same test from the "Identifying Entities" method, applied here.

---

# Worked Example: The Interview, Continued - A Stated Rule Easy to Miss

<div class="thread">A second sentence, easy to read past, that Correctness depends on.</div>

Later in the same interview, the registrar adds, almost in passing:
*"not for a section they're already enrolled in."* Read quickly, this
clause is easy to fold into "students join waitlists" and forget. Read
carefully, it is a Correctness rule: the model must be able to express
that a student cannot be simultaneously enrolled in, and waitlisted
for, the same section.

---

# Worked Example: Turning the Interview Into an Entity List

<div class="thread">Gathering the last three slides into one reference.</div>

**Entities:** Student, Course, Instructor, Section, Waitlist.
**Relationships:** Student enrolls in Section; Section belongs to one
Course; Section is taught by one Instructor; Student joins Waitlist
for Section. **Rule to keep, for Correctness:** a student may not be
both enrolled in, and waitlisted for, the same section.

<div class="why">
This is still prose-with-structure, not a diagram. No table names, no
keys, no cardinality numbers - Week 4's entire job, starting from
exactly this list.
</div>

---

# Worked Example: Conceptual Design for a Library System

<div class="thread">The full method, run end to end on a new domain.</div>

Requirement: *"A member borrows books; each book has a title and an
author; a librarian checks a returned book back in."*

**Pass 1 (nouns):** Member, Book, Librarian - each tracked over time,
each with its own facts. **Pass 2 (verbs):** a Member borrows a Book; a
Librarian checks a Book back in. **Pass 3 (four tests):** all four
pass, as far as this one sentence goes - no table names or keys yet.

---

# Worked Example: Conceptual Design for a Workout Log

<div class="thread">The same full method, on the workout-log domain introduced earlier.</div>

Requirement: *"Users log workouts. Each workout has exercises, and
each exercise has a number of reps and a weight."*

**Pass 1:** User, Workout, Exercise. **Pass 2:** a User logs a
Workout; a Workout has Exercises. **Pass 3:** Completeness holds - reps
and weight are both represented, as Exercise's own facts, not folded
into Workout where they'd have to repeat per exercise.

---

# Requirements Come From More Than Interviews

<div class="thread">The registrar interview is one source among several.</div>

- **Interviews**, like this week's registrar transcript - direct, but
  shaped by whatever the interviewee thinks to mention
- **Existing documents or forms** - Week 1's messy spreadsheet is
  itself a source, read for what it was already trying to track
- **Observing the current process** - watching how staff actually use
  the spreadsheet today, not just what they say they do

Different sources surface different gaps: the waitlist rule might
never appear in a spreadsheet with no waitlist column - only the
interview caught it.

---

# Worked Example: Physical Design Preview - What It Will Eventually Add

<div class="thread">Naming a much later concern, honestly, without teaching it yet.</div>

A common question on the registration system: "find every section this
student is enrolled in." Without help, a database checks every
`Enrollment` row one at a time. An **index** on `student_id` lets it
jump straight to the relevant rows instead.

<div class="why">
This is physical design - real, and covered later in the course. Today
it is only named, so "physical design" is not a mystery word the first
time it matters.
</div>

---

# The Cost of Skipping Conceptual Design, A Concrete Illustration

<div class="thread">This week's driving question, made concrete in dollars and hours.</div>

Catching "students can't waitlist for a section they're already
enrolled in" on paper, during conceptual design, costs one sentence in
a document. Catching the same missing rule after the system is live,
with real enrollment and waitlist data already contradicting each
other, costs a migration, a data-cleanup pass, and an apology to
whoever relied on the bad data in between.

---

# Worked Example: Two Designers, Two Models, One Requirement

<div class="thread">Returning to the opening pain slide - and finally resolving it.</div>

Two of the three students' designs, tested:

| Design | Complete | Correct | Redundancy | Understandable |
|---|---|---|---|---|
| Three separate tables | Pass | Pass | Pass | Pass |
| Student+Enrollment combined | Pass | Pass | **Fail** - major duplicated | Pass |

<div class="why">
The pain slide asked who was right, with no way to answer. The four
tests are that way - not opinion, a checklist both designers can run.
</div>

---

# Worked Example: Reading a Contradictory Requirement

<div class="thread">Sometimes a requirement disagrees with itself, and only a careful read catches it.</div>

Imagine a registrar's note that reads: *"every section has exactly one
instructor of record. For our new team-taught pilot sections, two
instructors co-teach and both should be listed."* The first sentence
states a 1-instructor rule; the second describes a case the first
sentence forbids.

<div class="why">
Catching this during conceptual design means asking the registrar one
clarifying question now. Catching it after `Section` is already built
with a single `instructor_id` column means redesigning the table later.
</div>

---

# Entities vs. Relationships, A Quick Sort

<div class="thread">A short drill: six words, one requirement, sorted on the spot.</div>

Requirement: *"A customer places an order; each order lists menu
items; a menu item has a price."*

| Word | Sort | Why |
|---|---|---|
| customer | Entity | tracked, has its own facts |
| places | Relationship | connects Customer and Order |
| order | Entity | tracked, has its own facts |
| lists | Relationship | connects Order and MenuItem |
| menu item | Entity | tracked, has its own facts |
| price | Neither | a fact describing MenuItem |

---

# Worked Example: Sorting the Gym Requirement's Nouns and Verbs

<div class="thread">The same sort, applied to the gym requirement from a few slides back: "a gym member books a class... a member can join a waitlist for it."</div>

| Word | Sort |
|---|---|
| member | Entity |
| books | Relationship (Member-Class) |
| class | Entity |
| maximum number of spots | Neither - a fact describing Class |
| waitlist | Entity |
| joins | Relationship (Member-Waitlist) |

---

# What Makes a Relationship, Not Just Two Entities Near Each Other

<div class="thread">Proximity in a sentence is not the same as a stated fact.</div>

"A student, a course, and a semester" mentions three nouns in one
sentence, but names no fact connecting them - it is not yet a
relationship. "A student enrolls in a section during a semester" names
an actual connecting fact. A relationship needs a verb, or an explicit
stated connection - not just co-occurrence in the same requirement.

---

# Worked Example: A Requirement With Three Entities and Two Relationships

<div class="thread">Counting carefully, on a delivery-app-shaped version of the restaurant domain.</div>

Requirement: *"A restaurant offers a menu of items. A customer places
an order, which belongs to exactly one restaurant and lists one or
more menu items."*

**Entities (3):** Restaurant, MenuItem, Order (Customer is also an
entity, but is not the focus of this count). **Relationships (2):** an
Order belongs to a Restaurant; an Order lists MenuItems.

---

# The Four Tests as a Pre-Flight Checklist

<div class="thread">Turning the four tests into a form you actually run, before calling a design done.</div>

- [ ] **Completeness** - every stated requirement is represented somewhere
- [ ] **Correctness** - no stated real-world rule is violated by the model
- [ ] **Minimal redundancy** - no fact is stored in two places by design
- [ ] **Understandability** - a colleague outside the room could
      reconstruct it unaided

A design that cannot check every box is not finished, no matter how
many Week 2 rules it satisfies.

---

# Worked Example: Running All Four Tests on the Restaurant Design

<div class="thread">The capstone check, on the design built up across this lecture.</div>

Restaurant, MenuItem, Order, Customer; an Order belongs to a
Restaurant, an Order lists MenuItems, a Customer places an Order.

| Test | Result |
|---|---|
| Completeness | Pass - "one or more menu items per order" is represented |
| Correctness | Pass, so far - no stated rule is violated |
| Minimal redundancy | Pass - menu item facts live only in MenuItem |
| Understandability | Pass - a colleague could redraw this from the list alone |

---

# Worked Example: Applying the Four Tests to the Workout Log

<div class="thread">The same capstone check, on a second design, to confirm the process transfers.</div>

User, Workout, Exercise; a User logs a Workout, a Workout has
Exercises, each Exercise records reps and weight.

| Test | Result |
|---|---|
| Completeness | Pass - reps and weight per exercise is represented |
| Correctness | Pass, so far - no stated rule is violated |
| Minimal redundancy | Passes as modeled - would fail if reps/weight lived on User instead |
| Understandability | Pass - three entities, two relationships, nothing implied |

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

# Common Mistakes, Continued

- **Skipping physical design "for now," with no plan to revisit it:**
  performance problems then surface only once the system is already
  live, far more expensive to fix than noting the concern early
- **Treating a transcript's exact wording as the final model:** an
  implied rule, stated once in passing, is easy to miss - re-read
  specifically hunting for stated rules, not just entities

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

# Check Yourself, Round Two

1. "Students must be able to enroll in at most 6 courses per
   semester." Which design stage captures this fact first?
2. Name one thing Week 2's integrity constraints and this week's four
   "good design" tests have in common, and one thing that is
   different.
3. A gym design lists Member and Class, but nothing records a class's
   maximum number of spots. Which of the four tests does this fail?

---

# Answers, Round Two

1. **Conceptual design.** It is a real-world rule the model must be
   able to express - captured as a stated fact before any table or
   constraint exists to enforce it later.
2. **In common:** both exist to catch a design mistake before it causes
   real damage. **Different:** Week 2's constraints are enforced
   automatically, by definition, once declared; the four tests require
   a person to deliberately check for them - nothing enforces them
   for you.
3. **Completeness.** The stated requirement ("a class has a maximum
   number of spots") is not represented anywhere in the model yet.

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
