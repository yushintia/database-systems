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
<div class="card"><div class="h">Strong Entity Mapping</div><div class="d">Map a strong entity to a relation (Rule 1)</div></div>
<div class="card"><div class="h">1:N Mapping</div><div class="d">Map a 1:N relationship to a foreign key on the correct side (Rule 2)</div></div>
<div class="card"><div class="h">Weak Entity Mapping</div><div class="d">Map a weak entity to a relation with a composite primary key (Rule 3)</div></div>
<div class="card"><div class="h">M:N Mapping</div><div class="d">Map an M:N relationship to a new relation with a composite primary key (Rule 4)</div></div>
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

# Illustration: The Diagram Becomes the Schema

<div class="thread">All four rules, seen as one transformation, entity by entity.</div>

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

# Rule 1, Worked a Second Time: Course

<div class="thread">The simplest rule, shown once more as a diagram, not just a table row.</div>

<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Course (E-R entity)</span></div>
<div class="row">course_code (key), title</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Course</span><span class="tag">Rule 1</span></div>
<div class="row"><span class="pk">course_code</span>, title</div>
</div>
</div>

Attributes and key copy across unchanged. No foreign key, no composite
key, nothing to decide, exactly why Rule 1 is where every mapping
starts.

---

# Rule 2, Worked a Second Time: Building and Office

<div class="thread">A different 1:N pair than Instructor-Section, to show the rule generalizes.</div>

A `Building` (1) contains many `Office` (N):

```
Office(office_id, floor, building_id)
FOREIGN KEY (building_id) REFERENCES Building(building_id)
```

`office_id` is `Office`'s own primary key; `building_id` is the
foreign key Rule 2 adds. `Building` gets no new column at all, the
"one" side of a 1:N relationship never does.

---

# Rule 3, Worked a Second Time: A Library's Loan

<div class="thread">The weak-entity pattern, outside the registration system, so the shape is visibly the rule, not the specific example.</div>

`Book` and `Member` are strong entities. `Loan` is weak, depending on
both, with its own attribute `due_date`:

```
Loan(isbn, member_id, due_date)
PRIMARY KEY (isbn, member_id)
FOREIGN KEY (isbn) REFERENCES Book(isbn)
FOREIGN KEY (member_id) REFERENCES Member(member_id)
```

Exactly `Enrollment`'s shape: borrowed key attributes combined into a
composite primary key, nothing invented.

---

# Rule 4, Worked a Second Time: Textbook and Course

<div class="thread">Confirms Check Yourself's own Q3, worked out in full instead of only asked.</div>

A `Textbook` can be used in many `Course`s, and a `Course` can use many
`Textbook`s. M:N, so Rule 4 creates a new relation:

```
CourseTextbook(course_code, textbook_id)
PRIMARY KEY (course_code, textbook_id)
FOREIGN KEY (course_code) REFERENCES Course(course_code)
FOREIGN KEY (textbook_id) REFERENCES Textbook(textbook_id)
```

Same composite-key shape as `Enrollment` and `Loan` above, because
every M:N relationship resolves to this one pattern, regardless of
which two entities are involved.

---

# Rule 5: 1:1 Relationships

<div class="thread">Named for completeness. The core registration system happens not to need it.</div>

**For a 1:1 relationship, place either side's primary key as a foreign
key on the other side**, usually on whichever side is optional, if one
is, to avoid a column that is always empty on the mandatory side.

Suppose each `Student` may have exactly one, optional `Advisor`, and
each `Advisor` advises exactly one `Student`:

```
Student(student_id, name, major, advisor_id)
FOREIGN KEY (advisor_id) REFERENCES Advisor(advisor_id)
```

---

# Rule 5, Worked Example: Why the Foreign Key Goes on Student

<div class="thread">Both sides of a 1:1 relationship are legal places for the key. One is still the better choice here.</div>

The foreign key could instead go on `Advisor` (`student_id` there
instead). But not every student has an advisor yet, so `advisor_id`
on `Student` can be `NULL` for the unassigned ones, while every
`Advisor` row would need a `student_id` value the moment it exists.

<div class="why">
The rule of thumb: put the foreign key on the side whose participation
is <strong>optional</strong>, so <code>NULL</code> means "not yet
assigned" rather than forcing the mandatory side to invent a
placeholder value.
</div>

---

<!-- _class: section -->

# Beyond the Core Four

<div class="driving-q">"What deterministic rules turn any E-R diagram into the same tables, no matter who applies them?"</div>

<div class="thread">Rules 1-5 covered every entity and relationship shape in the registration system. Real diagrams also carry composite attributes, multivalued attributes, and specialization hierarchies. Three more rules close that gap.</div>

---

# Rule 6: Composite Attributes

<div class="thread">An attribute that is itself made of parts, flattened into plain columns.</div>

**A composite attribute groups several component attributes under one
conceptual name** (e.g. `office_location`, made of `building` and
`room_number`). **Each component becomes its own column. The composite
name itself never becomes a column, only its leaf components do.**

Suppose `Instructor` carried a composite `office_location` attribute:

```
Instructor(instructor_id, name, building, room_number)
```

No `office_location` column exists anywhere in the mapped table.

---

# Rule 6, Continued: Why Not One Column?

<div class="thread">The tempting shortcut, and why the mapping algorithm forbids it.</div>

<div class="pain">
A tempting shortcut: <code>Instructor(instructor_id, name,
office_location)</code>, where <code>office_location</code> holds the
full string <code>"Engineering Hall, 412"</code> in one column. Now
find every instructor in <code>"Engineering Hall"</code> — the
database has no idea that string is a building name at all, the query
must parse text meant for a human to read, not for
<code>WHERE building = 'Engineering Hall'</code>.
</div>

Flattening a composite attribute is what makes each component
independently searchable and constrained, exactly what one blob column
cannot offer.

---

# Rule 7: Multivalued Attributes

<div class="thread">An attribute that can hold more than one value needs a relation of its own.</div>

**A multivalued attribute can legitimately hold more than one value
per entity instance** (e.g. a `Student` having several
`phone_number`s). **Mapping rule: it never becomes a column on the
owning relation. It becomes a new relation, with a foreign key back to
the owner, whose primary key is that foreign key combined with the
value itself.**

```
StudentPhone(student_id, phone_number)
PRIMARY KEY (student_id, phone_number)
FOREIGN KEY (student_id) REFERENCES Student(student_id)
```

One row per phone number, per student. Zero extra columns on `Student`.

---

# Rule 7, Continued: Why This Looks Familiar

<div class="thread">The same shape this lecture has already produced twice.</div>

`StudentPhone(student_id, phone_number)` has exactly the shape Rule 3
produces for a weak entity: a foreign key to its owner, plus whatever
value it stores, combined into the key. A multivalued attribute is,
structurally, a one-attribute weak entity that never got its own name
on the E-R diagram.

<div class="why">
Compare this to storing <code>"010-1234,010-5678"</code> in one
<code>phone_number</code> column instead: unqueryable without parsing
text by hand, the same shape as the 1NF violation Week 7 names
formally, one week early.
</div>

---

# Rule 8: Specialization and Generalization

<div class="thread">A superclass/subclass hierarchy needs a mapping rule of its own.</div>

Suppose `Instructor` specializes into `FullTimeInstructor` (extra
attribute: `salary`) and `PartTimeInstructor` (extra attribute:
`hourly_rate`), because the registration office started tracking pay
differently for each. **Two standard strategies map this:**

1. **One table per subclass**, sharing the superclass's key
2. **One single table**, with an extra column marking which subclass
   each row belongs to

---

# Rule 8, Strategy 1: One Table Per Subclass

<div class="thread">Every subclass table shares the same key as the superclass. That shared key stitches them back together.</div>

```
Instructor(instructor_id, name)
FullTimeInstructor(instructor_id, salary)
PartTimeInstructor(instructor_id, hourly_rate)
```

`FullTimeInstructor.instructor_id` and
`PartTimeInstructor.instructor_id` are each simultaneously a primary
key **and** a foreign key referencing `Instructor.instructor_id`. A
row only exists in one subclass table if that instructor is that kind
of instructor.

---

# Rule 8, Strategy 2: One Shared Table

<div class="thread">The other legal choice, trading joins for empty columns.</div>

```
Instructor(instructor_id, name, employment_type,
           salary,       -- NULL unless employment_type = 'full_time'
           hourly_rate)  -- NULL unless employment_type = 'part_time'
```

One table to query, no join needed to see a full record, but every
subclass-specific column sits `NULL` for rows that do not need it.

<div class="why">
Strategy 1 avoids wasted, always-empty columns. Strategy 2 avoids a
join to see one instructor's full record. Real schemas pick based on
which trade-off matters more for that hierarchy.
</div>

---

<!-- Diagram: extended schema after Rules 6-8 -->

# Extended Schema: Rules 6-8, Applied

<div class="thread">Every new construct from this section, mapped and placed beside the original relations.</div>

<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Instructor</span><span class="tag">Rule 1 + 6</span></div>
<div class="row"><span class="pk">instructor_id</span>, name, building, room_number</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>StudentPhone</span><span class="tag">Rule 7</span></div>
<div class="row"><span class="pk fk">student_id</span>, <span class="pk">phone_number</span></div>
</div>
<div class="schema-tbl">
<div class="hd"><span>FullTimeInstructor</span><span class="tag">Rule 8, Strategy 1</span></div>
<div class="row"><span class="pk fk">instructor_id</span>, salary</div>
</div>
</div>

Nothing here replaces the original five-relation schema, these are
extensions the registration system does not currently need, mapped the
same deterministic way the core four rules were.

---

# Rule 9: Derived Attributes

<div class="thread">Some attributes should never be stored at all.</div>

**A derived attribute's value can always be computed from other data
already in the database** (e.g. a student's `total_credits_earned`,
summed from every passing `Enrollment`). **Mapping rule: derived
attributes typically get no column. They are computed on demand, by a
query, when needed.**

```
-- NOT stored:
Student(student_id, name, major, total_credits_earned)

-- Stored instead:
Student(student_id, name, major)
-- total_credits_earned computed later, e.g. by summing Section
-- credits across every passing Enrollment row
```

---

# Rule 9, Continued: Why Not Just Store It?

<div class="thread">The obvious-looking shortcut, and the anomaly it reintroduces.</div>

Storing `total_credits_earned` directly looks convenient, but every
time a grade posts, or an enrollment is added or dropped, that stored
number must be updated by hand or it silently drifts out of sync with
the truth already living in `Enrollment`. **This is exactly the update
anomaly Week 7 formalizes, one week early:** one fact, stored in two
places, that can disagree with itself.

<div class="why">
Real systems sometimes store a derived value anyway, called a cache or
a materialized column, purely for performance on a huge table, but
only with an explicit plan for keeping it in sync. That is an
optimization on top of the mapping algorithm, not part of it.
</div>

---

# Rule 10: Aggregation

<div class="thread">A relationship that itself needs to participate in another relationship.</div>

**Aggregation treats an entire relationship as if it were a single
higher-level entity**, so a *different* relationship can connect to
the relationship itself, not to either of its original entities. Week
4 modeled `Enrollment` as exactly this: the `Student`-`Section`
relationship, treated as one aggregate thing with its own attribute
(`grade`).

**Mapping rule: an aggregation maps like any other entity — its
already-mapped relation simply gains one more foreign key, for
whatever new relationship connects to the aggregate.**

---

# Rule 10, Worked Example: Who Recorded This Grade?

<div class="thread">A new relationship, attached to Enrollment itself, not to Student or Section alone.</div>

Suppose the registration system tracks **which instructor recorded
each grade** — a relationship connecting the aggregate `Enrollment` to
`Instructor`, not connecting `Student` or `Section` individually:

```
Enrollment(student_id, section_id, grade, recorded_by)
PRIMARY KEY (student_id, section_id)
FOREIGN KEY (recorded_by) REFERENCES Instructor(instructor_id)
```

`recorded_by` is a plain foreign key, added by the ordinary 1:N rule
(Rule 2). Aggregation changes how you *think* about the diagram; it
changes nothing about how the resulting table is built.

---

# Quick Check: Rules 5-10

<div class="thread">A fast sort, before the lecture's official Check Yourself.</div>

1. `Section` gains a composite `meeting_time`, made of `day` and
   `start_hour`. How does Rule 6 map it?
2. Why does a multivalued attribute never become a single column, no
   matter how few values it usually holds?
3. `Vehicle` (in a separate system) specializes into `Car` and `Truck`.
   Name one advantage Strategy 1 has over Strategy 2.

---

# Quick Check: Answers

1. `Section(section_id, ..., day, start_hour)` — the composite name
   never becomes a column, only its two flattened components do.
2. A column holds one value. Storing several values in one column
   (e.g. comma-separated) makes them unqueryable without parsing text
   by hand, exactly a 1NF violation waiting to happen.
3. Strategy 1 avoids `NULL` columns: a `Car`-only attribute like
   `trunk_capacity` never appears, even as an empty cell, on a `Truck`
   row, since `Truck` has no such column at all.

---

# Practice: A Library System, Composite Attribute

<div class="thread">Rule 6, applied to a new domain.</div>

`Member` gains a composite `name`, made of `first_name` and
`last_name`.

**Question:** map `Member(member_id, name, ...)` using Rule 6.

**Answer:**
```
Member(member_id, first_name, last_name, ...)
```
No `name` column exists, only its two flattened components do.

---

# Practice: A Ride-Hailing App, Multivalued Attribute

<div class="thread">Rule 7, one more time, in a different domain.</div>

A `Driver` may register more than one vehicle license plate.

**Question:** map this multivalued attribute using Rule 7.

**Answer:**
```
DriverPlate(driver_id, plate_number)
PRIMARY KEY (driver_id, plate_number)
FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
```
One row per plate, per driver, zero new columns on `Driver`.

---

# Practice: A Ride-Hailing App, Specialization

<div class="thread">Rule 9's shape from earlier, Strategy 1, applied to vehicles instead of people.</div>

`Vehicle` specializes into `Car` (extra attribute: `trunk_capacity`)
and `Motorcycle` (extra attribute: `has_sidecar`).

**Question:** map this using Strategy 1 (one table per subclass).

**Answer:**
```
Vehicle(vehicle_id, plate_number, driver_id)
Car(vehicle_id, trunk_capacity)
Motorcycle(vehicle_id, has_sidecar)
```

---

# Practice: A Ride-Hailing App, Aggregation

<div class="thread">Rule 10, one more time: a relationship gaining its own relationship.</div>

The `Rider`-`Ride` relationship (a completed trip) is itself rated by
the `Driver`, a relationship attached to the trip as a whole, not to
`Rider` or `Ride` alone.

**Question:** what does Rule 10 add, and to which relation?

**Answer:** a plain foreign key, `rated_by`, added to `Ride`'s
already-mapped relation, referencing `Driver`. No new relation is
created, exactly like `recorded_by` on `Enrollment` earlier.

---

# Real Tools That Automate This

<div class="thread">The "in industry" claim from this week's Cost slide, made concrete.</div>

<div class="appgrid">
<div class="app"><div class="name">Django ORM</div><div class="desc">Python classes map to tables using these exact rules</div></div>
<div class="app"><div class="name">Hibernate</div><div class="desc">Java's ORM, same 1:N and M:N mapping logic</div></div>
<div class="app"><div class="name">Prisma</div><div class="desc">a schema file, mapped to SQL automatically</div></div>
</div>

Every one of these tools implements Rules 1 through 10, in code, so a
developer never has to apply them by hand. This lecture is what they
do underneath.

---

# Rules 1-5, at a Glance

<div class="thread">A reference slide, five rules at a time, before the worked example puts them all to use one final time.</div>

| Rule | Construct | Maps to |
|---|---|---|
| 1 | Strong entity | Its own relation, key copied directly |
| 2 | 1:N relationship | Foreign key on the "many" side, no new relation |
| 3 | Weak entity | Relation with a composite key, borrowed from its owner(s) |
| 4 | M:N relationship | New relation, composite key of both sides |
| 5 | 1:1 relationship | Foreign key on either side, usually the optional one |

---

# Rules 6-10, at a Glance

<div class="thread">The other five, same reference format.</div>

| Rule | Construct | Maps to |
|---|---|---|
| 6 | Composite attribute | Flattened into individual columns |
| 7 | Multivalued attribute | New relation, key = owner's key + the value |
| 8 | Specialization | One table per subclass, or one shared table with a discriminator |
| 9 | Derived attribute | Usually no column, computed on demand |
| 10 | Aggregation | A foreign key added to the aggregate's already-mapped relation |

---

# Illustration, Extended: Two More Rules, Placed Beside the Core Schema

<div class="thread">Rule 2 and Rule 4, worked a second time earlier this lecture, shown together as one picture.</div>

<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Office</span><span class="tag">Rule 1 + 2</span></div>
<div class="row"><span class="pk">office_id</span>, floor, <span class="fk">building_id</span></div>
</div>
<div class="schema-tbl">
<div class="hd"><span>CourseTextbook</span><span class="tag">Rule 4</span></div>
<div class="row"><span class="pk fk">course_code</span>, <span class="pk fk">textbook_id</span></div>
</div>
</div>

Neither relation touches the registration system's core five, and both
were produced by rules already used there. The same handful of rules
keeps working, no matter how many new entities a diagram adds.

---

# Check Yourself: A New Scenario

<div class="thread">One scenario, several constructs at once, before this lecture's official Check Yourself.</div>

The registration system adds a `Classroom` entity: `Classroom(1)`
hosts many `Section(N)`, and each `Classroom` has a composite
`location` attribute (`building`, `floor`, `room_number`).

**Question:** which rules apply, and what does each produce?

---

# Check Yourself: A New Scenario, Answer

**Rule 2** (1:N): `Section` gains a foreign key, `classroom_id`,
referencing `Classroom.classroom_id`. `Classroom` gains no new column.

**Rule 6** (composite attribute): `location` never becomes a column.
`Classroom` gains three flattened columns instead:

```
Classroom(classroom_id, building, floor, room_number)
```

Two independent rules, applied to two independent parts of the same
new entity, exactly the way this lecture has applied them all week.

---

<!-- SLOT N-2: Worked example -->

# Worked Example: Mapping the Waitlist

<div class="thread">Week 4's Waitlist entity, mapped mechanically, rule by rule, exactly as this lecture teaches it.</div>

The registration system is adding a `Waitlist` feature: a student can
be waitlisted for a full section. `Waitlist` is a weak entity,
depending on both `Student` and `Section`, with its own attributes
`position` and `date_joined`. It is *also* M:N between `Student` and
`Section` — a student can be waitlisted for many sections, and a
section can have many students waiting.

**Step 1: Identify the shape.** Both Rule 3 (weak entity) and Rule 4
(M:N relationship) apply, exactly the way they both applied to
`Enrollment`.

---

# Worked Example, Continued: Apply Rule 3, Confirm With Rule 4

<div class="thread">Two independent rules, one identical answer.</div>

**Step 2: Apply Rule 3.** A weak entity's primary key is its own
attributes combined with the primary key of what it depends on:

```
Waitlist(student_id, section_id, position, date_joined)
```

**Step 3: Apply Rule 4, and confirm.** Rule 4 independently says: new
relation, composite key of both sides. Student M:N Section produces
the identical relation. Not a coincidence — Rules 3 and 4 describe the
same real-world fact, from two angles.

---

# Worked Example, Continued: Declare the Primary Key

<div class="thread">Writing the relation is not enough without stating what makes each row unique.</div>

```sql
Waitlist(student_id, section_id, position, date_joined)
PRIMARY KEY (student_id, section_id)
```

| Line | What it does |
|---|---|
| `student_id, section_id` | Borrowed from `Student` and `Section` — this is what makes `Waitlist` a *weak* entity |
| `position, date_joined` | `Waitlist`'s own attributes, describing the fact itself |
| `PRIMARY KEY (student_id, section_id)` | Neither column alone is unique: the same student can wait on many sections, and the same section can have many students waiting |

---

<!-- SLOT N-1: Common mistakes -->

# Common Mistakes

- **Adding a join table for a 1:N relationship:** only M:N relationships
  need a new relation; 1:N is a single foreign key, no exceptions
- **Forgetting the composite primary key on a resolved M:N relationship:**
  `Enrollment` without `PRIMARY KEY (student_id, section_id)` allows
  the same student to enroll in the same section twice, silently
- **Putting the foreign key on the wrong side of a 1:N relationship:**
  it always goes on the "many" side, never the "one" side
- **Giving a weak entity its own surrogate key (e.g. `enrollment_id`):**
  a weak entity's key is borrowed from what it depends on, not
  invented — without it, the composite key constraint that prevents
  duplicates goes missing

---

# Common Mistakes, Continued

- **Storing a composite attribute as one unparsed string:** flatten it
  into its components, or every query needing just the building has to
  parse text meant for display, not for `WHERE`
- **Adding a multivalued attribute as a comma-separated column:**
  identical mistake to a 1NF violation, give it its own relation
  instead
- **Storing a derived attribute "just in case":** it will eventually
  disagree with the data it was computed from, unless something keeps
  it in sync on every update
- **Forcing every specialization into Strategy 1 or Strategy 2 out of
  habit:** pick based on whether subclass-specific columns are rare
  (favor Strategy 2) or the hierarchy is deep and heavily queried per
  subclass (favor Strategy 1)

---

<!-- SLOT N: Check yourself -->

# Check Yourself

1. A `Building` (1) contains many `Office` (N). Which relation gets the
   foreign key, what is it called, and which rule tells you that?
2. Why does `Enrollment` need a composite primary key instead of a
   single `enrollment_id`?
3. A `Textbook` can be used in many `Course`s, and a `Course` can use
   many `Textbook`s. Which rule applies, and what relation does it
   produce?

---

# Answers

1. **Office** gets the foreign key, `building_id`, referencing
   `Building.building_id`, by **Rule 2**. The "many" side always holds
   the key.
2. Because it resolves an M:N relationship: a single `enrollment_id`
   would not, by itself, prevent the same `{student_id, section_id}`
   pair from appearing twice. The composite key is what enforces "one
   enrollment per student per section."
3. **Rule 4** (M:N). It produces a new relation,
   `CourseTextbook(course_code, textbook_id)`, with a composite primary
   key, exactly the same shape as `Enrollment`.

---

<!-- SLOT N+1: Limits, becomes Week 7 slot 4 -->

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

<!-- SLOT N+2: Bridge -->

# Next Week

Week 6 leaves **anomalies that survive correct mapping** unsolved.
**Week 7, Normalization**, addresses it: a formal test for exactly this
kind of problem, and a procedure to fix it.

---

<!-- SLOT N+3: Summary -->

# Summary

- The mapping algorithm is deterministic: strong entities become
  relations directly, weak entities inherit a composite key, 1:N
  relationships become a single foreign key, M:N relationships become
  a new relation with a composite key.
- Applied correctly, two different people produce the identical schema
  from the identical diagram, closing this week's pain slide by design.
- A mechanically correct schema is not automatically an anomaly-free
  one, next week's entire subject.
- **Lab page:** [Lab 6 in the online Lab Manual](../book/labs/lab06-mapping-algorithm.html), for the
  Guided Exercises (mapping your own Lab 4 diagram), Challenge
  Problem, and rubric.
- **Reading:** Silberschatz et al., 7th ed., Chapter 6
- **Prepare:** find one place in the derived registration schema where
  a fact could still be stored redundantly. Bring it to Week 7.

---

<!-- SLOT N+4: Thank You -->
<!-- _class: end -->

# Thank You
