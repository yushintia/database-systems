---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 6: Mapping Algorithm

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
<div class="wk"><div class="n">Wk 3</div><div class="t">Data Modelling</div></div>
<div class="wk"><div class="n">Wk 4</div><div class="t">E-R Diagram</div></div>
<div class="wk review"><div class="n">Wk 5</div><div class="t">Quiz 1</div></div>
<div class="wk now"><div class="n">Wk 6</div><div class="t">Mapping Algorithm</div></div>
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

- **Last week delivered:** Quiz 1, and a complete E-R diagram for the registration system: entities, attributes, relationships, cardinality
- **Last week left broken:** a diagram is not a database. Nothing so far turns entities and relationships into real relations with real keys

---

<!-- SLOT 4: The pain -->

# Same Diagram, Three Different Tables

<div class="pain">

Three teams are handed the exact same E-R diagram from Week 4 and asked
to produce relational tables. All three correctly understand the
diagram. All three produce different tables.

One team gives `Section` a foreign key to `Instructor`. Another gives
`Instructor` a list-type column of section IDs, because their tool
allows it. A third invents a separate join table for Section and
Instructor, even though that relationship is 1:N, not M:N, so it did
not need one.

The diagram was unambiguous. The translation into tables was not,
because nobody wrote down the rules for doing it.

</div>

<!-- notes: Ask why a 1:N relationship does not need a join table, before the answer arrives later in the lecture. Let them sit with the question. -->

---

# What Else This Actually Costs

- Three different, equally "valid" translations of one diagram means
  the diagram was never really the source of truth, whoever mapped it
  was
- Inconsistent translation choices across a team compound: schemas
  that should be reusable design patterns become one-off guesses
- A junior engineer who has to guess how to translate a diagram will
  guess wrong on the cases that matter most, the M:N relationships

<div class="why">
<strong>In industry:</strong> this exact translation, from a design
diagram to a schema, is often automated by real tools (ORMs, schema
generators). Those tools implement precisely the algorithm this lecture
teaches by hand, once, so you understand what the tool is actually doing.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What deterministic rules turn any E-R diagram into the same tables, no matter who applies them?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

1. Map a strong entity to a relation
2. Map a weak entity to a relation with a composite key
3. Map 1:1, 1:N, and M:N relationships correctly, without guessing
4. Produce the registration system's full relational schema from its E-R diagram

---

<!-- SLOT 8: Origin -->

# Where This Procedure Came From

<div class="thread">Not a new idea this week, a formalization of what Codd's relational model always implied.</div>

- Once E-R diagrams became standard (Week 4's 1976 paper), it took
  little time for database theorists to notice the translation to
  relations followed the same handful of patterns every time
- What started as "the way experienced designers naturally did it" was
  formalized into an explicit, teachable algorithm, exactly so a
  beginner and an expert produce the same schema from the same diagram

---

<!-- SLOT 9: Core concept -->

# Mapping Algorithm: Definition

<div class="thread">One procedure, applied entity by entity, then relationship by relationship.</div>

> The **mapping algorithm** is a deterministic set of rules that
> converts every entity and relationship in an E-R diagram into
> relations, attributes, and keys, with no design decisions left to
> guesswork.

Two people applying these rules correctly to the same diagram will
always produce the same schema. That is the entire point.

---

<!-- Act 3 / BUILD -->

# Rule 1: Strong Entities

<div class="thread">The simplest rule. Start here.</div>

**Every strong entity becomes its own relation.** Its attributes become
the relation's attributes. Its key attribute becomes the relation's
primary key.

| Entity | Relation |
|---|---|
| Student(student_id, name, major) | `Student(student_id, name, major)` |
| Course(course_code, title) | `Course(course_code, title)` |
| Instructor(instructor_id, name) | `Instructor(instructor_id, name)` |

No decisions to make here, only a direct copy.

---

# Rule 2: 1:N Relationships

<div class="thread">The relationship type that answers last week's pain slide directly.</div>

**For a 1:N relationship, place the primary key of the "1" side as a
foreign key on the "N" side.** No new relation is created.

Instructor (1) teaches Section (N):

```
Section(section_id, ..., instructor_id)
```

`instructor_id` is a foreign key referencing `Instructor.instructor_id`.
This is exactly why the team that gave `Instructor` a list-type column
was wrong: the foreign key always goes on the "many" side.

---

# Rule 2, Continued: Section's Other 1:N Relationship

<div class="thread">The same rule, applied a second time, to the same relation.</div>

Course (1) has Section (N):

```
Section(section_id, course_code, instructor_id, room, semester)
```

Two separate 1:N relationships (Course to Section, Instructor to
Section) can add two separate foreign keys to the same relation. There
is no conflict, each foreign key answers a different question.

---

# Rule 3: Weak Entities

<div class="thread">Week 4 promised weak entities would map cleanly. Here is exactly how.</div>

**A weak entity becomes a relation whose primary key is its own key
attributes (if any) combined with the primary key of the entity it
depends on.**

`Enrollment` is weak, depending on both Student and Section:

```
Enrollment(student_id, section_id, grade)
PRIMARY KEY (student_id, section_id)
```

`student_id` and `section_id` are each also foreign keys, to `Student`
and `Section` respectively.

---

# Rule 4: M:N Relationships

<div class="thread">The rule the third team skipped entirely, and the one this lecture opened by asking about.</div>

**For an M:N relationship, create a new relation containing the
primary keys of both sides as a composite key.**

Student M:N Section, via enrolling, produces exactly:

```
Enrollment(student_id, section_id, grade)
PRIMARY KEY (student_id, section_id)
```

<div class="why">
Notice this is the identical relation Rule 3 produced. Enrollment is
both a weak entity <em>and</em> the resolution of an M:N relationship,
because those two ideas describe the same real-world fact from two
angles. The rules agree, on purpose.
</div>

---

# Rule 5: 1:1 Relationships

<div class="thread">Named for completeness. The registration system happens not to need it.</div>

**For a 1:1 relationship, place either side's primary key as a foreign
key on the other side**, usually on whichever side is optional, if one
is.

The registration system has no 1:1 relationships, every connection is
either 1:N or M:N. This rule exists for systems that do, for example,
a Student having exactly one optional Advisor relationship.

---

# Illustration: The Diagram Becomes the Schema

<div class="thread">All five rules, seen as one transformation, entity by entity.</div>

<div class="pipeline">
<div class="stage"><div class="h">E-R Diagram</div><div class="s">Week 4, entities + relationships</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Apply Rules 1-5</div><div class="s">no guessing, one rule per shape</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Relational Schema</div><div class="s">real relations, real keys</div></div>
</div>

Every box and line on Week 4's diagram maps to exactly one rule from
this lecture. Nothing on the diagram is left for a human to interpret.

---

# Real Tools That Automate This

<div class="thread">The "in industry" claim from earlier, made concrete.</div>

<div class="appgrid">
<div class="app"><div class="name">Django ORM</div><div class="desc">Python classes map to tables using these exact rules</div></div>
<div class="app"><div class="name">Hibernate</div><div class="desc">Java's ORM, same 1:N and M:N mapping logic</div></div>
<div class="app"><div class="name">Prisma</div><div class="desc">a schema file, mapped to SQL automatically</div></div>
</div>

Every one of these tools implements Rules 1 through 5, in code, so a
developer never has to apply them by hand. You are learning what they
do underneath.

---

# Demo, Step by Step: Mapping the Waitlist

<div class="thread">Week 4's Waitlist entity, mapped mechanically, rule by rule, exactly as this lecture teaches it.</div>

---

# Step 1: Identify the Shape

`Waitlist` is a weak entity, M:N between Student and Section (Week 4).
Rules 3 and 4 both apply, exactly like `Enrollment` did earlier in
this lecture.

---

# Step 2: Apply Rule 3 (Weak Entity)

Composite key: the weak entity's own attributes plus the primary keys
of what it depends on.

```
Waitlist(student_id, section_id, position, date_joined)
```

---

# Step 3: Apply Rule 4 (M:N Relationship), Confirm

Rule 4 independently says: new relation, composite key of both sides.
Same result as Step 2, the two rules agreeing is not a coincidence,
it is the same real-world fact, described two ways.

---

# Step 4: Add the Primary Key Declaration

```
Waitlist(student_id, section_id, position, date_joined)
PRIMARY KEY (student_id, section_id)
```

One student can be on one waitlist per section, never twice, exactly
what this composite key enforces. Week 9 turns this into a real
`CREATE TABLE` statement.

---

# Worked Example: The Full Schema, Derived

<div class="thread">Every rule, applied once, to the entire Week 4 diagram, producing the schema Week 1 already promised.</div>

```
Student(student_id, name, major)
Course(course_code, title)
Instructor(instructor_id, name)
Section(section_id, course_code, instructor_id, room, semester)
Enrollment(student_id, section_id, grade)
  PRIMARY KEY (student_id, section_id)
```

Five relations. Every foreign key traceable to one relationship on the
Week 4 diagram. Nothing here was a guess.

---

# Common Mistakes

- **Adding a join table for a 1:N relationship:** only M:N relationships
  need a new relation; 1:N is a single foreign key, no exceptions
- **Forgetting the composite primary key on a resolved M:N relationship:**
  `Enrollment` without `PRIMARY KEY (student_id, section_id)` allows
  the same student to enroll in the same section twice, silently
- **Putting the foreign key on the wrong side of a 1:N relationship:**
  it always goes on the "many" side, never the "one" side

---

# Practice: A Library System

<div class="thread">Every rule from this lecture, applied to Week 4's own library example.</div>

Entities: `Book` (strong), `Member` (strong), `Loan` (weak, depends on
Book and Member). Relationship: Member M:N Book, via Loan.

**Question:** apply Rules 1, 3, and 4. What is `Loan`'s relation?

**Answer:**
```
Loan(isbn, member_id, due_date)
PRIMARY KEY (isbn, member_id)
```
Rule 3 (weak entity) and Rule 4 (M:N relationship) agree, exactly like
Enrollment did.

---

# Practice: A Ride-Hailing App

<div class="thread">One more, this time a 1:N relationship, to keep both rules fresh.</div>

Entities: `Driver` (strong), `Ride` (weak, depends on Driver and
Rider). `Driver` 1:N `Ride`.

**Question:** which relation gets the foreign key for `driver_id`, and
by which rule?

**Answer:** `Ride` gets `driver_id` as a foreign key, by **Rule 2**
(1:N: foreign key goes on the "many" side). `Driver` never gets a
column pointing at its rides.

---

# Check Yourself

1. A Department (1) offers many Course (N). Which relation gets the
   foreign key, and what is it called?
2. Why does `Enrollment` need a composite primary key instead of a
   single `enrollment_id`?
3. A `TA` entity can help with many `Section`s, and a `Section` can
   have many `TA`s. Which rule applies, and what does it produce?

---

# Answers

1. **Course** gets the foreign key, `department_id`, referencing
   `Department.department_id`. The "many" side always holds the key.
2. Because it resolves an M:N relationship: a single `enrollment_id`
   would not, by itself, prevent the same `{student_id, section_id}`
   pair from appearing twice. The composite key is what enforces "one
   enrollment per student per section."
3. **Rule 4** (M:N). It produces a new relation,
   `TA_Section(ta_id, section_id)`, with a composite primary key,
   exactly the same shape as `Enrollment`.

---

<!-- SLOT 14: Limits, becomes Week 7 slot 4 -->

# What a Mechanical Mapping Cannot Guarantee

<div class="limits">
Every rule this week is deterministic, no guessing, no disagreement
between two people applying them correctly. But mechanically mapped
tables can still carry anomalies. If <code>Section</code> stored
<code>instructor_name</code> directly instead of just
<code>instructor_id</code>, correctly following every rule above, an
instructor's name change would still need updating in every one of
their sections. The algorithm guarantees a valid schema. It does not
guarantee a <em>good</em> one.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 6 leaves **anomalies that survive correct mapping** unsolved.
**Week 7, Normalization**, addresses it: a formal test for exactly this
kind of problem, and a procedure to fix it.

---

<!-- SLOT 16: Summary -->

# Summary

- The mapping algorithm is deterministic: strong entities become
  relations directly, weak entities inherit a composite key, 1:N
  relationships become a single foreign key, M:N relationships become
  a new relation with a composite key.
- Applied correctly, two different people produce the identical schema
  from the identical diagram, closing this week's pain slide by design.
- A mechanically correct schema is not automatically an anomaly-free
  one, next week's entire subject.
- **Reading:** Silberschatz et al., 7th ed., Chapter 7
- **Prepare:** find one place in the derived registration schema where
  a fact could still be stored redundantly. Bring it to Week 7.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
