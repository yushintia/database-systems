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

<div class="cardlist">
<div class="card"><div class="h">Strong Entity Mapping</div><div class="d">Map a strong entity to a relation</div></div>
<div class="card"><div class="h">Weak Entity Mapping</div><div class="d">Map a weak entity to a relation with a composite key</div></div>
<div class="card"><div class="h">Relationship Mapping</div><div class="d">Map 1:1, 1:N, and M:N relationships correctly, without guessing</div></div>
<div class="card"><div class="h">Full Schema Mapping</div><div class="d">Produce the registration system's full relational schema from its E-R diagram</div></div>
</div>

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

<div class="two-col">
<div class="er">
<svg viewBox="0 0 480 300" width="380" height="238">
<line class="link" x1="95" y1="60" x2="240" y2="110"/>
<line class="link" x1="240" y1="110" x2="385" y2="60"/>
<line class="link" x1="240" y1="110" x2="240" y2="200"/>
<polygon class="rel-outer" points="240,68 311,110 240,152 169,110"/>
<polygon class="rel" points="240,74 305,110 240,146 175,110"/>
<rect class="ent-outer" x="149" y="164" width="182" height="72" rx="4"/>
<rect class="ent" x="155" y="170" width="170" height="60" rx="4"/>
<rect class="ent" x="20" y="30" width="150" height="60" rx="4"/>
<rect class="ent" x="310" y="30" width="150" height="60" rx="4"/>
<text class="lbl" x="95" y="65">Student</text>
<text class="lbl" x="385" y="65">Section</text>
<text class="lbl" x="240" y="205">Enrollment</text>
<text class="lbl" x="240" y="114">enrolls</text>
<text class="card" x="60" y="105">M</text>
<text class="card" x="470" y="65">N</text>
</svg>
</div>
<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Student</span><span class="tag">Rule 1</span></div>
<div class="row"><span class="pk">student_id</span>, name, major</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Section</span><span class="tag">Rule 1 + 2</span></div>
<div class="row"><span class="pk">section_id</span>, <span class="fk">course_code</span>, <span class="fk">instructor_id</span></div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Enrollment</span><span class="tag">Rule 3 + 4</span></div>
<div class="row"><span class="pk fk">student_id</span>, <span class="pk fk">section_id</span>, grade</div>
</div>
</div>
</div>

Every box and line on Week 4's diagram maps to exactly one rule from
this lecture. Nothing on the diagram is left for a human to interpret.

---

<!-- _class: section -->

# Beyond the Five Rules

> "What deterministic rules turn any E-R diagram into the same tables, no matter who applies them?" This week's question, still.

<div class="thread">Rules 1-5 covered every entity and relationship shape. Real diagrams also carry composite attributes, multivalued attributes, derived attributes, and specialization hierarchies. Five more rules close the gap.</div>

---

# Rule 6: Composite Attributes

<div class="thread">An attribute that is itself made of parts, flattened into plain columns.</div>

**A composite attribute groups several component attributes under one
conceptual name** (e.g. `Address`, made of `street`, `city`, and
`zip_code`). **Each component becomes its own column on the owning
relation. The composite name itself never becomes a column**; only
its leaf components do.

Suppose `Student` also carried a composite `address` attribute on the
Week 4 diagram:

```
Student(student_id, name, major, street, city, zip_code)
```

No `address` column exists anywhere in the mapped table. Only its
three flattened components do.

---

# Rule 6, Continued: Why Not One `address` Column?

<div class="thread">The tempting shortcut, and why the mapping algorithm forbids it.</div>

<div class="pain">
A tempting shortcut: <code>Student(student_id, name, major, address)</code>
where <code>address</code> holds the full string
<code>"123 Hyoja-dong, Pohang, 37673"</code> in one column. Now find
every student in <code>"Pohang"</code>. The database has no idea
<code>"Pohang"</code> is the city part of that string, so the query
must guess at parsing text meant for humans, not for
<code>WHERE city = 'Pohang'</code>.
</div>

Flattening a composite attribute into separate columns is what makes
each component independently searchable, sortable, and constrained.
That is exactly what a single blob column cannot offer.

---

# Rule 7: Multivalued Attributes

<div class="thread">An attribute that can hold more than one value needs a relation of its own.</div>

**A multivalued attribute can legitimately hold more than one value
for a single entity instance** (e.g. a `Student` having several
`phone_number`s). **Mapping rule: a multivalued attribute never
becomes a column on the owning relation. It becomes a brand-new
relation, with a foreign key back to the owner, and its primary key is
that foreign key combined with the value itself.**

Suppose `Student` also carried a multivalued `phone_number` attribute:

```
StudentPhone(student_id, phone_number)
PRIMARY KEY (student_id, phone_number)
FOREIGN KEY (student_id) REFERENCES Student(student_id)
```

One row per phone number, per student. A student with three phone
numbers has three rows in `StudentPhone`, zero extra columns in
`Student`.

---

# Rule 7, Continued: Why This Looks Familiar

<div class="thread">The same shape this lecture has already produced twice.</div>

`StudentPhone(student_id, phone_number)` has exactly the shape of a
weak entity's relation from Rule 3: a foreign key to its owner, plus
whatever value it stores, combined into the key. A multivalued
attribute is, structurally, a one-attribute weak entity that never got
its own name on the E-R diagram. The mapping algorithm treats it the
same way regardless.

<div class="why">
Compare this to storing <code>"010-1234,010-5678"</code> in one
<code>phone_number</code> column instead: unqueryable without parsing a
string by hand, the exact 1NF problem Week 7 names formally.
</div>

---

# Rule 8: Derived Attributes

<div class="thread">Some attributes should never be stored at all.</div>

**A derived attribute's value can always be computed from other data
already in the database** (e.g. a student's `total_credits_earned`,
computable by summing `Section.credits` across every passing
`Enrollment`). **Mapping rule: derived attributes are typically NOT
given a column. They are computed on demand, by a query, when needed.**

```
-- NOT stored:
Student(student_id, name, major, total_credits_earned)

-- Stored instead:
Student(student_id, name, major)
-- total_credits_earned computed later, e.g.:
-- SELECT SUM(credits) FROM Enrollment JOIN Section ... WHERE grade <> 'F'
```

---

# Rule 8, Continued: Why Not Just Store It?

<div class="thread">The obvious-looking shortcut, and the anomaly it reintroduces.</div>

Storing `total_credits_earned` directly looks convenient, one column,
no computation needed at query time. But every time a grade posts, or
an enrollment is added or dropped, that stored number must be updated
by hand or it silently drifts out of sync with the truth already
living in `Enrollment`. **This is exactly the update anomaly Week 7
formalizes:** one fact, stored in two places, that can disagree with
itself.

<div class="why">
Real systems sometimes store a derived value anyway, called a cache or
a materialized column, purely for performance on a huge table, but
only with an explicit plan for keeping it in sync. That is an
optimization decision made on top of the mapping algorithm, not part
of it.
</div>

---

# Rule 9: Specialization and Generalization

<div class="thread">A superclass/subclass hierarchy needs a mapping rule of its own.</div>

Some E-R diagrams group entities into a superclass with several
subclasses: for example, a `Person` superclass with `Student` and
`Instructor` as subclasses, each sharing `person_id`, `name`, and
`email`, but each also carrying attributes the other does not (`major`
for `Student`, `office` for `Instructor`). **Two standard strategies
map this to relations:**

1. **One table per subclass**, sharing the superclass's key
2. **One single table**, with an extra column marking which subclass
   each row belongs to

This lecture works Strategy 1 in full, and describes Strategy 2 briefly.

---

# Rule 9, Strategy Chosen: One Table Per Subclass

<div class="thread">Every table shares the same key as the superclass. That shared key is what stitches them back together.</div>

```
Person(person_id, name, email)
Student(person_id, major)
Instructor(person_id, office)
```

`Student.person_id` and `Instructor.person_id` are each simultaneously
a primary key **and** a foreign key referencing `Person.person_id`. A
row only exists in `Student` if that person is a student; a person who
is both (a graduate student who also TAs) simply has a row in both
tables, sharing the same `person_id`.

<div class="why">
Our registration schema keeps <code>Student</code> and
<code>Instructor</code> as independent strong entities rather than
subclasses of <code>Person</code>, because this course never needs to
treat them as the same kind of thing. This rule exists for the
diagrams that do.
</div>

---

# Rule 9, The Other Strategy, Briefly

<div class="thread">Named for completeness, one table for everyone, not used above.</div>

**Strategy 2: a single table for the whole hierarchy, with a
type-discriminator column** naming which subclass a row belongs to,
and every subclass-specific column present but left `NULL` when it
does not apply:

```
Person(person_id, name, email, person_type,
       major,   -- NULL unless person_type = 'student'
       office)  -- NULL unless person_type = 'instructor'
```

One table to query, but every subclass-specific column is `NULL` for
rows that do not need it. Strategy 1 avoids that wasted space;
Strategy 2 avoids joining several tables to see one person's full
record. Real schemas pick based on which trade-off matters more.

---

# Rule 10: Aggregation

<div class="thread">A relationship that itself needs to participate in another relationship.</div>

**Aggregation treats an entire relationship as if it were a single
higher-level entity**, so that a *different* relationship can connect
to the relationship itself, not to either of its original entities.
Week 4 modeled `Enrollment` as exactly this: the `Student`-`Section`
relationship, treated as one aggregate thing with its own attribute
(`grade`).

**Mapping rule: an aggregation maps to a relation exactly like any
other entity: its already-mapped relation (produced by Rule 3 or
Rule 4) simply gains one more foreign key, for whatever new
relationship connects to the aggregate.**

---

# Rule 10, Worked Example: Who Recorded This Grade?

<div class="thread">A new relationship, attached to `Enrollment` itself, not to `Student` or `Section` alone.</div>

Suppose the registration system also tracks **which instructor
recorded each grade**, a relationship connecting the aggregate
`Enrollment` to `Instructor`, not connecting `Student` or `Section`
individually to `Instructor`:

```
Enrollment(student_id, section_id, grade, recorded_by)
PRIMARY KEY (student_id, section_id)
FOREIGN KEY (recorded_by) REFERENCES Instructor(instructor_id)
```

`recorded_by` is a plain foreign key on `Enrollment`'s already-mapped
relation, added by the ordinary 1:N rule (Rule 2), the same way any
other 1:N relationship would add one. Aggregation changes how you
*think* about the diagram; it changes nothing about how the resulting
table is built.

---

# Where Aggregation Shows Up in Real Systems

<div class="thread">The same "a relationship needs its own relationship" shape, in familiar apps.</div>

<div class="appgrid">
<div class="app"><div class="name">Amazon</div><div class="desc">an Order-Product line item itself gets a Return relationship</div></div>
<div class="app"><div class="name">GitHub</div><div class="desc">a Pull-Request review relationship itself gets Comments attached</div></div>
<div class="app"><div class="name">배달의민족 (Baemin)</div><div class="desc">an Order-Restaurant relationship itself gets a Rating relationship</div></div>
</div>

Every one of these is a relationship treated as a thing, so a further
relationship can attach to it, exactly the shape Rule 10 maps.

---

# Extended Schema: Five New Rules, Applied

<div class="thread">Every new construct from this section, mapped and placed beside the original five relations.</div>

<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Student</span><span class="tag">Rule 1 + 6</span></div>
<div class="row"><span class="pk">student_id</span>, name, major, street, city, zip_code</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>StudentPhone</span><span class="tag">Rule 7</span></div>
<div class="row"><span class="pk fk">student_id</span>, <span class="pk">phone_number</span></div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Enrollment</span><span class="tag">Rule 3 + 4 + 10</span></div>
<div class="row"><span class="pk fk">student_id</span>, <span class="pk fk">section_id</span>, grade, <span class="fk">recorded_by</span></div>
</div>
</div>

`total_credits_earned` (Rule 8) appears nowhere on this schema, on
purpose: it is computed, never stored. `Person`/`Student`/`Instructor`
(Rule 9) stays a "what if" for this course, since our `Student` and
`Instructor` are already independent strong entities.

---

# Demo, Step by Step: Extending the Waitlist

<div class="thread">Suppose the registration office wants a text or email alert when a waitlisted student reaches position 1. One more multivalued attribute, mapped exactly like Rule 7.</div>

`Waitlist` gains a new requirement: a student may register **more than
one** contact method for alerts. That is a multivalued attribute.

---

# Step 1: Identify the Shape

`contact_method` is multivalued: one waitlisted student may list a
phone number and an email, both, for alerts. Rule 7 applies, the same
way it applied to `Student.phone_number` earlier in this lecture.

---

# Step 2: Apply Rule 7, Produce the New Relation

```
WaitlistContact(student_id, section_id, contact_method)
PRIMARY KEY (student_id, section_id, contact_method)
FOREIGN KEY (student_id, section_id) REFERENCES Waitlist(student_id, section_id)
```

The foreign key here is itself composite, referencing `Waitlist`'s own
composite key, because the *owner* of this multivalued attribute is a
weak entity, not a simple strong entity like `Student` was.

---

# Common Mistakes, Continued

- **Storing a composite attribute as one unparsed string:** flatten it
  into its components, or every query needing just the city has to
  parse text meant for display, not for `WHERE`
- **Adding a multivalued attribute as a comma-separated column:**
  identical mistake to a 1NF violation, give it its own relation instead
- **Storing a derived attribute "just in case":** it will eventually
  disagree with the data it was computed from, unless something keeps
  it in sync on every update
- **Forcing every hierarchy into Strategy 1 or Strategy 2 out of habit:**
  pick based on whether subclass-specific columns are rare (favor
  Strategy 2) or the hierarchy is deep and heavily queried per subclass
  (favor Strategy 1)

---

# Practice: A Library System: Composite Attribute

<div class="thread">Rule 6, applied to a new domain.</div>

`Member` gains a composite `name` attribute, made of `first_name` and
`last_name`.

**Question:** map `Member(member_id, name, ...)` using Rule 6.

**Answer:**
```
Member(member_id, first_name, last_name, ...)
```
No `name` column exists. Only its two flattened components do, exactly
Rule 6's flattening pattern.

---

# Practice: A Ride-Hailing App: Multivalued Attribute

<div class="thread">Rule 7, one more time, in a different domain.</div>

A `Driver` may register more than one vehicle license plate.

**Question:** map this multivalued attribute using Rule 7.

**Answer:**
```
DriverPlate(driver_id, plate_number)
PRIMARY KEY (driver_id, plate_number)
FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
```
One row per plate, per driver, zero new columns on `Driver` itself.

---

# Practice: A Ride-Hailing App: Specialization

<div class="thread">Rule 9, Strategy 1, applied to vehicles instead of people.</div>

`Vehicle` specializes into `Car` (extra attribute: `trunk_capacity`)
and `Motorcycle` (extra attribute: `has_sidecar`).

**Question:** map this using Strategy 1 (one table per subclass).

**Answer:**
```
Vehicle(vehicle_id, plate_number, driver_id)
Car(vehicle_id, trunk_capacity)
Motorcycle(vehicle_id, has_sidecar)
```
`Car.vehicle_id` and `Motorcycle.vehicle_id` are each primary key and
foreign key to `Vehicle`, exactly like `Student.person_id` earlier.

---

# Practice: A Ride-Hailing App: Aggregation

<div class="thread">Rule 10, one more time: a relationship gaining its own relationship.</div>

The `Rider`-`Ride` relationship (a completed trip) is itself rated by
the `Driver`, a relationship attached to the trip as a whole, not to
`Rider` or `Ride` alone.

**Question:** what does Rule 10 add, and to which relation?

**Answer:** a plain foreign key, `rated_by`, added to `Ride`'s
already-mapped relation (the aggregate), referencing `Driver`. No new
relation is created, exactly like `recorded_by` on `Enrollment`.

---

# Check Yourself: Rules 6-10

1. `Instructor` gains a composite `office_location`, made of
   `building` and `room_number`. How does Rule 6 map it?
2. Why does a multivalued attribute never become a single column, no
   matter how few values it usually holds?
3. `Section` gains a derived `seats_remaining`, computable from
   `Section.capacity` minus a count of `Enrollment` rows. Should it be
   stored? Why or why not?
4. A `Vehicle` superclass has `Car` and `Truck` subclasses. Name one
   advantage Strategy 1 (one table per subclass) has over Strategy 2
   (one shared table).

---

# Answers

1. `Instructor(instructor_id, name, building, room_number)`: the
   composite name never becomes a column, only its two components do.
2. Because a column holds one value. Storing several values in one
   column (e.g. comma-separated) makes them unqueryable without parsing
   text by hand, exactly a 1NF violation waiting to happen.
3. **No.** `seats_remaining` is derived from `capacity` and a live
   count of enrollments; storing it risks drifting out of sync every
   time an enrollment is added or dropped. Compute it on demand instead.
4. Strategy 1 avoids `NULL` columns: a `Car`-only attribute like
   `trunk_capacity` never appears, even as an empty cell, on a `Truck`
   row, since `Truck` has no such column at all.

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

# A Note on Course References

This week's topics, mapping composite, multivalued, derived, and
specialization/generalization constructs, and aggregation, follow the
standard topic organization used in *Database System Concepts*, 7th
ed. (Silberschatz, Korth, Sudarshan), this course's reference text.
The wording, examples, and diagrams on these slides are original,
written for this course and this case study.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
