# Lab 03: Data Modelling

| | |
|---|---|
| **Week** | 3 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Lecture & Lab |
| **Prerequisites** | Lab 02 (relations, keys, integrity constraints) |

**Why this lab matters:** Last week gave you a rigorous definition of
what a table has to look like. It never told you *which* tables to
build, or why. Three designers can each follow every one of last
week's rules perfectly and still produce three incompatible schemas.
This lab gives you the process that closes that gap: read real
requirements, pull out the real-world things and facts they describe,
and check the result against four concrete tests — before a single
table exists. You will do this twice: once on a realistic interview
transcript, and once by watching an under-constrained toy schema
accept data it should have rejected.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Concept) | 50 | 10 recap Lab 02 · 30 entities, relationships, design stages, the four tests · 10 live demo |
| B (Guided practice) | 50 | 40 extract entities from the interview transcript, break the toy sandbox · 10 debrief |
| C (Independent and wrap) | 50 | 35 independent practice problems · 10 challenge · 5 submit and Week 4 preview |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Name the three data-modelling design stages (conceptual, logical,
   physical) and state what each one produces.
2. Extract entities and relationships from an unstructured, real-world
   description of requirements, with no table names or keys yet.
3. Apply the four "good design" tests (completeness, correctness,
   minimal redundancy, understandability) to catch a bad design before
   any table is built.
4. Explain, using a live example, what happens when a schema has no
   modelling constraints behind it at all.

---

## Recap

Lab 02 gave you `raw_registrations`: one flat table, live inside
MySQL, that resisted every attempt to find a clean primary key.
Every rule from last week held — domains, keys, integrity
constraints — but none of those rules told us how many relations this
system actually needs, or which facts belong in which one. That gap
is this week's whole subject.

---

## Background

### Data Modelling and the Three Design Stages

> **In plain words: data modeling**
> "Data modeling" is the process of studying real-world requirements
> and writing them down as a structured description of the data a
> system must store — *before* any table is created. It is a verb:
> something you do. A "data model" (the relational model, the E-R
> model) is a noun: one specific way of structuring the result.

Real design work happens in three stages, in order:

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 160" style="max-width:520px;display:block;margin:1.5em auto;">
  <title>Diagram of the three data-modelling design stages in sequence: conceptual design, producing entities and relationships in plain language; logical design, producing relations with attributes and keys; and physical design, producing indexes and storage decisions. Arrows connect each stage to the next.</title>
  <rect x="15" y="40" width="150" height="80" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="90" y="65" font-family="sans-serif" font-size="12" font-weight="bold" fill="#0b3d66" text-anchor="middle">Conceptual</text>
  <text x="90" y="82" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">entities &amp;</text>
  <text x="90" y="94" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">relationships</text>
  <text x="90" y="108" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">(no tables yet)</text>
  <line x1="167" y1="80" x2="203" y2="80" stroke="#0b3d66" stroke-width="2" marker-end="url(#a1)"/>
  <rect x="205" y="40" width="150" height="80" rx="8" fill="#fff8e6" stroke="#c07000" stroke-width="2"/>
  <text x="280" y="65" font-family="sans-serif" font-size="12" font-weight="bold" fill="#c07000" text-anchor="middle">Logical</text>
  <text x="280" y="82" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">relations, attributes,</text>
  <text x="280" y="94" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">keys (Lab 02's world)</text>
  <line x1="357" y1="80" x2="393" y2="80" stroke="#0b3d66" stroke-width="2" marker-end="url(#a1)"/>
  <rect x="395" y="40" width="150" height="80" rx="8" fill="#e8f5e9" stroke="#2e7d32" stroke-width="2"/>
  <text x="470" y="65" font-family="sans-serif" font-size="12" font-weight="bold" fill="#2e7d32" text-anchor="middle">Physical</text>
  <text x="470" y="82" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">indexes, storage,</text>
  <text x="470" y="94" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">performance tuning</text>
  <defs>
    <marker id="a1" markerWidth="7" markerHeight="7" refX="5" refY="3" orient="auto">
      <path d="M0,0 L0,6 L7,3 z" fill="#0b3d66"/>
    </marker>
  </defs>
  <text x="280" y="145" font-family="sans-serif" font-size="10" fill="#8e2020" text-anchor="middle">This lab lives entirely in the first stage. Logical design is Lab 06; physical design is later still.</text>
</svg>
<p style="text-align:center;font-size:0.9em;color:#555;margin-top:-0.6em;"><em><strong>Figure 3.1.</strong> The three design stages, always in this order.</em></p>

> **In plain words: conceptual design**
> Conceptual design identifies the real-world things a system must
> track (**entities**) and how they relate (**relationships**), in a
> notation both technical and non-technical people can read. No table
> names, no data types, no primary keys yet — that is next week's job.

> **In plain words: entity and relationship**
> An **entity** is a real-world thing a design tracks, such as
> Student, Course, or Instructor. A **relationship** is a real-world
> fact connecting two or more entities, such as "a Student enrolls in
> a Section."

### The Four "Good Design" Tests

A design can follow every one of Lab 02's rules — every relation has a
key, every attribute has a domain — and still be a *bad* design. These
four tests catch what Lab 02's rules cannot:

| Test | Question it asks |
|---|---|
| **Completeness** | Does the model represent every stated requirement, somewhere? |
| **Correctness** | Does the model match the real-world rules, not just the wish list? |
| **Minimal redundancy** | Is any single fact captured in more than one place, by design? |
| **Understandability** | Can someone who wasn't in the room read this and understand it? |

> **In plain words: minimal redundancy**
> "Redundancy" here means storing the same fact twice on purpose (not
> by accident, like Lab 01's spelling mistakes). Copying a student's
> major into every one of their enrollment rows is redundant — the
> major belongs to the student, once, not to each enrollment.

---

## Worked Example: Extracting Entities from a Real Interview

[The interview transcript](files/lab03/interview_transcript.md) is a
realistic (if invented) conversation between a data modeler and the
university's registrar. It is deliberately *not* organized for you —
real requirements never arrive pre-sorted into "entities" and
"relationships." Here is how to pull them out, one pass at a time.

> [Read the full interview transcript](files/lab03/interview_transcript.md)

### Pass 1: circle every noun that might be an entity

Reading the transcript once, these nouns keep reappearing as things
the registrar tracks over time, each with its own facts: **Student**,
**Course**, **Section**, **Instructor**. A fifth candidate,
**Waitlist**, appears only in the second half of the interview — easy
to miss on a first read, exactly why real interviews get read more
than once.

### Pass 2: circle every verb connecting two of those nouns

- "A Section belongs to one Course" — the registrar's own words: *"the
  same course code can show up more than once... with different
  instructors or rooms"* → Section N:1 Course.
- "An Instructor teaches a Section" — *"one instructor can teach more
  than one section"*, but *"every section has exactly one instructor
  of record"* → Section N:1 Instructor.
- "A Student enrolls in a Section" — *"the same student can enroll in
  several sections... and a section obviously has many students"* →
  Student M:N Section.
- "A Student joins a Waitlist for a Section" — the new feature,
  explicitly ordered: *"if we can't tell who was waiting longest,
  students complain"*.

### Pass 3: check against the four tests

- **Completeness:** does this capture "first on the list"? Not fully
  yet — the registrar's requirement that waitlist order matters is
  *named* here, but nothing in a plain-English relationship states
  *how* order will be represented. That gap carries forward on
  purpose; it is Week 4's job, not this week's.
- **Correctness:** the registrar stated a real-world rule worth
  writing down now, while it's still cheap to notice: *"can a student
  be on the waitlist for a section they're already enrolled in? No."*
  A model that allows that combination has already failed Correctness.
- **Minimal redundancy:** the registrar was explicit that a course's
  catalog facts (code, title) should not be re-typed onto every
  section — that is exactly what having a separate Course entity, N:1
  from Section, prevents.
- **Understandability:** could a colleague who never sat in on this
  interview read your entity list and relationship list and reach the
  same five entities? If not, the model has failed this test,
  regardless of whether it happens to be complete and correct.

### What this pass produces, and what it does not

**Entities (so far):** Student, Course, Instructor, Section, Waitlist.
**Relationships (so far):** Student enrolls in Section; Section
belongs to one Course; Section is taught by one Instructor; Student
joins Waitlist for Section.

This is *not* yet a relational schema — no attributes are classified,
no keys are chosen, no cardinality number (1:1, 1:N, M:N) has been
formally stated on a diagram. That precision is Lab 04's entire job.
Conceptual design's output is prose-with-structure, still readable by
the registrar herself; it is deliberately not yet checkable the way a
diagram will be.

---

## Worked Example: Breaking the Toy Sandbox

`files/lab03/toy_sandbox.sql` is a run-only script that builds two
tables, `Course` and `Section`, with **no primary key and no foreign
key declared anywhere**. It then inserts several rows that
contradict each other. Nothing in the script produces an error —
that silence is the entire lesson.

> [`toy_sandbox.sql`](files/lab03/toy_sandbox.sql)

### Line by line: what the script actually does

| Statement(s) | What it does |
|---|---|
| `CREATE TABLE Course (course_code VARCHAR(10), title VARCHAR(100));` | Declares a two-column table, no primary key on `course_code`, on purpose |
| `CREATE TABLE Section (section_id INT, course_code VARCHAR(10), instructor VARCHAR(100), room VARCHAR(20));` | Declares a four-column table, no primary key on `section_id`, no foreign key tying `course_code` back to `Course`, on purpose |
| The first two `INSERT` blocks | Load two believable rows into each table, nothing wrong yet |
| The four `INSERT`s after "Now the contradictions" | Each one inserts a row that should be impossible in a well-designed schema (a repeated `course_code` with a different title, a `Section` pointing at a course that doesn't exist, a repeated `section_id`, and a sloppily-retyped `course_code`), and MySQL accepts every single one without an error, because nothing in the schema forbids any of it |

Run it (Workbench: **File > Open SQL Script...** then **Execute**, or
`mysql -u root -p < toy_sandbox.sql`), then open both tables in
Workbench's data grid and find:

`SELECT * FROM Course;` means "show every column, every row, of
`Course`," a Week 11 skill, used today only to look at what actually
loaded:

```sql
SELECT * FROM Course;
```

```
+-------------+---------------------+
| course_code | title               |
+-------------+---------------------+
| CSE301      | Database Systems    |
| CSE210      | Data Structures     |
| CSE301      | Intro to Databases  |
| CSE210      | Data Structures     |
+-------------+---------------------+
```

`CSE301` now has **two different titles**, stored side by side, both
"true" as far as MySQL is concerned. `CSE210` appears to have been
inserted twice more — the fourth row is `'CSE210 '`, with a trailing
space nobody would notice by eye, and it is silently a completely
different, unrelated row to this table.

```sql
SELECT * FROM Section;
```

```
+------------+-------------+------------+----------+
| section_id | course_code | instructor | room     |
+------------+-------------+------------+----------+
| 1          | CSE301      | Prof. Lee  | 성파 702  |
| 2          | CSE210      | Prof. Han  | 인지관305 |
| 3          | CSE999      | Prof. Choi | 인지관210 |
| 1          | CSE210      | Prof. Oh   | 성파 508  |
+------------+-------------+------------+----------+
```

Section `3` references `CSE999`, which does not exist anywhere in
`Course` — an orphaned row. Two rows both claim `section_id = 1`, with
different instructors and rooms — "Section 1" now means two
disagreeing things at once. None of this required a mistake by MySQL;
it required a schema with **no constraints at all** behind it. Lab 06
(mechanically mapping this exact kind of schema from a diagram) and
Week 9's real `CREATE TABLE ... PRIMARY KEY ... FOREIGN KEY` are what
eventually make all four of these rows impossible to insert in the
first place.

---

## Guided In-Lab Exercises

Answer these directly inside `lab03_model.md`.

### Exercise 1: The Registration System, Stage by Stage (Part A)

Requirement, in plain language: *"Every student enrolls in one or more
course sections, taught by an instructor, in a specific room."*

1. List the entities this sentence mentions. Do not write table names
   or column names yet.
2. List the facts (relationships) connecting them, in plain language —
   for example, "a Student ___ a Section."
3. Which design stage were you just doing? (Conceptual, logical, or
   physical?)

### Exercise 2: Why Week 2's Rules Aren't Enough (Part B)

Three designers each build a registration design that correctly
follows every rule from Lab 02 — every relation has a primary key,
attributes, and integrity constraints. Using the words **requirements**
and **conceptual design**, explain in 1-2 sentences why a design that
follows all of Lab 02's rules can still be a *bad* design.

### Exercise 3: Catching Redundancy Before It's Built

One designer proposes combining `Student` and `Enrollment` into a
single relation, so a student's major is copied into every enrollment
row. Which of the four "good design" tests does this fail, and why?

### Exercise 4: The Waitlist, From Your Own Reading

Without re-reading the model answer above: from
[the interview transcript](files/lab03/interview_transcript.md), name the one new entity the waitlist
feature introduces, and the two facts connecting it to Student and
Section. Then check your answer against the Worked Example section
above.

---

## Challenge Problem

A team decides to skip physical design entirely, planning to "add
indexes later if it's slow." Using the Common Pitfalls table below,
write 2-3 sentences explaining why this is riskier than it sounds —
specifically, why "add it later" is not free the way it might sound in
a team meeting. Then, separately: name one requirement from
[the interview transcript](files/lab03/interview_transcript.md) that a design could satisfy on paper (pass
all four tests) and still implement *incorrectly* in practice, if the
implementer only skimmed the transcript instead of reading it twice.

Write your answer directly into `lab03_model.md` under a "Challenge"
heading.

---

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** Requirement: "Users log workouts. Each workout has
exercises, and each exercise has a number of reps and a weight." Name
the conceptual-stage entities, before writing a single relation.

**Practice 2.** Requirement: "A restaurant has a menu; each menu item
has a price; a customer places an order containing one or more menu
items." Which of the four "good design" tests would catch a design
that stores the menu item's name inside every single order line,
instead of once in a Menu Item entity?

**Practice 3.** "Students must be able to enroll in at most 6 courses
per semester." Which design stage captures this fact first?

**Practice 4.** Name one thing Lab 02's integrity constraints and this
week's four "good design" tests have in common, and one thing that is
different.

**Practice 5.** Which of the four "good design" tests specifically
catches a model that two different engineers interpret two different
ways?

**Practice 6.** Requirement: "A member borrows books; each book has a
title and an author; a librarian checks a returned book back in." Name
the conceptual-stage entities and the facts (relationships) connecting
them.

**Practice 7.** Requirement: "A gym member books a class. A class has
a maximum number of spots. If a class is full, a member can join a
waitlist for it." Name the entities, and identify which relationship
in this requirement is structurally the same shape as the registration
system's Student-Waitlist-Section relationship.

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Jumping straight from requirements to table names | Missing entities that don't announce themselves as nouns (like Waitlist, easy to miss on a first read) | Read requirements at least twice; a second, closer read regularly finds something the first read missed |
| Assuming Lab 02's rules already guarantee a good design | A schema with valid keys and constraints that still duplicates the same fact in two places | Run the four tests explicitly — passing Lab 02's rules says nothing about redundancy or completeness |
| Skipping physical design "for now," with no plan to revisit it | Performance problems discovered only once the system is already live, expensive to fix | Note physical-design concerns explicitly during conceptual/logical design, even if you don't solve them yet |
| Treating a transcript's exact wording as the final model | Missing an implied rule the interviewee stated once, in passing (like "not for a section they're already enrolled in") | Re-read specifically for stated *rules*, not just entities and relationships |

---

## Submission and Rubric

| Deliverable | Filename | Points |
|-------------|----------|--------|
| Guided Exercises 1-4 (entities, relationships, four-tests analysis, waitlist) | `lab03_model.md` | 6 |
| Challenge Problem (physical-design risk + implementation-correctness gap) | `lab03_model.md` | 4 |

**Total: 10 points**

---

## Further Reading

- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th ed.,
  Ch. 6 "Database Design Using the E-R Model" (skim the conceptual
  design sections; the E-R notation itself is next week)
- Peter Chen, "The Entity-Relationship Model" (1976) — the paper Lab
  04 builds on directly
- Think ahead: from your entity list above, which relationships are
  1:1, which are 1:N, and which are M:N? Lab 04 asks you to state that
  formally, on a diagram.
