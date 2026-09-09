# Lab 04: E-R Diagrams

| | |
|---|---|
| **Week** | 4 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Lecture & Lab |
| **Prerequisites** | Lab 03 (entities, relationships, the four design tests) |

**Assignment 1 is due this week** — see Submission and Rubric below.

**Why this lab matters:** Lab 03 gave you a list of entities and
relationships, in prose. Prose has a problem: two people can read the
exact same paragraph and draw two different, disagreeing pictures from
it, and nothing in a paragraph forces either of them to notice. This
lab gives you a fixed notation — Peter Chen's E-R diagram — precise
enough that a disagreement becomes visible on paper, not hidden inside
grammar. You will draw the registration system's full diagram
yourself, including the Waitlist feature and its weak entity, and then
have a classmate check your work against a checklist, the same way a
real design review works.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Concept) | 50 | 10 recap Lab 03 · 30 entities, attributes, cardinality, weak entities · 10 live demo |
| B (Guided practice) | 50 | 40 draw the full registration E-R diagram · 10 debrief |
| C (Independent and wrap) | 50 | 30 peer-review swap using the checklist · 10 practice problems · 10 submit and Week 6 preview |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Classify attributes as simple, composite, or key, using E-R
   notation.
2. State the cardinality (1:1, 1:N, M:N) of a relationship explicitly,
   instead of leaving it implied in a sentence.
3. Identify a weak entity, and explain why its identity is borrowed
   from another entity's key.
4. Draw a complete, checkable E-R diagram for the registration system,
   including the Waitlist feature, and review a classmate's diagram
   against a fixed checklist.

---

## Recap

Lab 03 left you with entities (Student, Course, Instructor, Section,
Waitlist) and relationships stated in plain English — enough for a
human to follow, but not yet checkable the way a formal notation is.
Two designers reading the same interview transcript could still walk
away with subtly different pictures, and nothing in prose forces
either of them to notice the disagreement. That is exactly this week's
subject.

---

## Background

This lab's diagram notation itself — the exact symbols for entities,
attributes, relationships, and cardinality — is documented in
[`../appendix/er-notation.md`](../appendix/er-notation.md). Read that
page first if you have never drawn an E-R diagram before; this section
only covers the vocabulary you need before this week's worked example,
not the symbol reference itself.

> **In plain words: entity and attribute**
> An **entity** is a real-world thing, distinguishable from every
> other thing, that a system needs to track — Student, Course,
> Instructor, Section. An **attribute** is a property describing an
> entity: `student_id`, `name`, `major` describe Student.

> **In plain words: simple vs. composite attribute**
> A **simple attribute** cannot be broken into smaller meaningful
> parts — `major` is simple. A **composite attribute** can be:
> `name` could split into `first_name` and `last_name` the moment the
> system needs to sort or address someone by one part alone.

> **In plain words: cardinality**
> **Cardinality** states how many instances of one entity can relate
> to how many instances of another, stated explicitly on the diagram
> itself: **1:1** (one to exactly one), **1:N** (one to many, each of
> the many relates back to exactly one), or **M:N** (many to many, in
> both directions at once).

> **In plain words: weak entity**
> A **weak entity** has no key attribute of its own — it can only be
> uniquely identified in combination with another entity's key. A
> **strong entity** has its own key attribute and needs no help
> identifying its instances.

---

## Worked Example: The Registration System's Full E-R Diagram

Starting from Lab 03's entity list, here is the diagram built one
decision at a time, continuing the same worked example from the
handout.

### Step 1: Name the entities

From the requirement "every student enrolls in one or more course
sections, taught by an instructor, in a specific room": **Student**,
**Section**, and **Instructor** are entities — each is tracked over
time and has its own attributes. **Room**, for now, is *not* its own
entity — it is just one attribute of Section, unless the system later
needs to track rooms independently (capacity, building, its own
schedule).

### Step 2: Classify each entity's attributes

Student has `student_id` (**key attribute** — makes each Student
distinguishable), `name` (**composite** — splits into `first_name`
and `last_name` the moment it's needed), and `major` (**simple**).

### Step 3: Draw the relationships, with cardinality stated explicitly

Student to Section is **M:N** — a Student takes many Sections, a
Section holds many Students, in both directions at once. Section to
Course is **N:1** — many Sections belong to one Course. Section to
Instructor is **N:1** — many Sections are taught by one Instructor.

### Step 4: Decide weak or strong

An M:N relationship cannot be represented by a single foreign key on
either side — that is exactly why an **Enrollment** entity has to
exist to hold it together. But "this enrollment" means nothing without
a specific student and a specific section — its identity is borrowed,
`{student_id, section_id}` together, not either alone. That makes
Enrollment a **weak entity**.

The same pattern repeats for **Waitlist** (attributes `position` and
`date_joined`, straight from Lab 03's interview transcript): neither
attribute means anything without knowing which student and which
section, so Waitlist is weak too — identity borrowed from both sides,
same shape as Enrollment, but a *separate* weak entity connecting the
exact same two strong entities in a different relationship.

### The complete diagram

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 460" style="max-width:680px;display:block;margin:1.5em auto;">
  <title>Complete E-R diagram of the university course registration system. Five entities: Student, Section, Course, and Instructor drawn as strong entities with single-line rectangles, and Enrollment and Waitlist drawn as weak entities with double-line rectangles. Student relates to Section many-to-many through the weak entity Enrollment, which holds a grade attribute. Student also relates to Section many-to-many through the separate weak entity Waitlist, which holds position and date_joined attributes. Section relates to Course many-to-one, labelled N:1. Section relates to Instructor many-to-one, labelled N:1. Student's key attribute student_id is underlined.</title>
  <!-- Student -->
  <rect x="20" y="180" width="130" height="60" rx="4" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="85" y="205" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Student</text>
  <text x="85" y="222" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle" text-decoration="underline">student_id</text>
  <text x="85" y="234" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">name, major</text>
  <!-- Enrollment (weak) -->
  <rect x="220" y="120" width="120" height="55" rx="4" fill="#fbe9e7" stroke="#8e2020" stroke-width="2"/>
  <rect x="226" y="126" width="108" height="43" rx="3" fill="none" stroke="#8e2020" stroke-width="1"/>
  <text x="280" y="145" font-family="sans-serif" font-size="12" font-weight="bold" fill="#8e2020" text-anchor="middle">Enrollment</text>
  <text x="280" y="160" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">grade (weak entity)</text>
  <!-- Waitlist (weak) -->
  <rect x="220" y="260" width="120" height="60" rx="4" fill="#fbe9e7" stroke="#8e2020" stroke-width="2"/>
  <rect x="226" y="266" width="108" height="48" rx="3" fill="none" stroke="#8e2020" stroke-width="1"/>
  <text x="280" y="286" font-family="sans-serif" font-size="12" font-weight="bold" fill="#8e2020" text-anchor="middle">Waitlist</text>
  <text x="280" y="301" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">position,</text>
  <text x="280" y="312" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">date_joined (weak)</text>
  <!-- Section -->
  <rect x="420" y="180" width="130" height="60" rx="4" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="485" y="205" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Section</text>
  <text x="485" y="222" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle" text-decoration="underline">section_id</text>
  <text x="485" y="234" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">room, semester</text>
  <!-- Course -->
  <rect x="600" y="60" width="110" height="55" rx="4" fill="#e8f5e9" stroke="#2e7d32" stroke-width="2"/>
  <text x="655" y="83" font-family="sans-serif" font-size="12" font-weight="bold" fill="#2e7d32" text-anchor="middle">Course</text>
  <text x="655" y="99" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle" text-decoration="underline">course_code</text>
  <!-- Instructor -->
  <rect x="600" y="310" width="110" height="55" rx="4" fill="#fff8e6" stroke="#c07000" stroke-width="2"/>
  <text x="655" y="333" font-family="sans-serif" font-size="12" font-weight="bold" fill="#c07000" text-anchor="middle">Instructor</text>
  <text x="655" y="349" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle" text-decoration="underline">instructor_id</text>
  <!-- lines -->
  <line x1="150" y1="200" x2="220" y2="155" stroke="#8e2020" stroke-width="1.5"/>
  <text x="175" y="165" font-family="sans-serif" font-size="9" fill="#8e2020">M</text>
  <line x1="340" y1="150" x2="420" y2="200" stroke="#8e2020" stroke-width="1.5"/>
  <text x="395" y="165" font-family="sans-serif" font-size="9" fill="#8e2020">N</text>
  <line x1="150" y1="220" x2="220" y2="285" stroke="#8e2020" stroke-width="1.5"/>
  <text x="175" y="270" font-family="sans-serif" font-size="9" fill="#8e2020">M</text>
  <line x1="340" y1="285" x2="420" y2="225" stroke="#8e2020" stroke-width="1.5"/>
  <text x="395" y="270" font-family="sans-serif" font-size="9" fill="#8e2020">N</text>
  <line x1="550" y1="195" x2="600" y2="110" stroke="#2e7d32" stroke-width="1.5"/>
  <text x="560" y="140" font-family="sans-serif" font-size="9" fill="#2e7d32">N : 1</text>
  <line x1="550" y1="225" x2="600" y2="320" stroke="#c07000" stroke-width="1.5"/>
  <text x="560" y="280" font-family="sans-serif" font-size="9" fill="#c07000">N : 1</text>
  <text x="360" y="400" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">Student M:N Section, twice over: once via Enrollment (already happened), once via Waitlist (waiting to happen).</text>
  <text x="360" y="418" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">Section N:1 Course, Section N:1 Instructor. Enrollment and Waitlist are both weak, borrowing identity from Student + Section.</text>
</svg>
<p style="text-align:center;font-size:0.9em;color:#555;margin-top:-0.6em;"><em><strong>Figure 4.1.</strong> The complete registration system E-R diagram, entities, cardinality, and both weak entities.</em></p>

**Put together:** Entities — Student, Course, Instructor, Section,
Enrollment (weak), Waitlist (weak). Relationships — Student M:N
Section via Enrollment; Student M:N Section via Waitlist (a *second*,
separate relationship between the same two strong entities); Section
N:1 Course; Section N:1 Instructor. This matches
`../../slides/_shared/case-study.md`'s Week 4 snapshot exactly — this
is the diagram Lab 06 mechanically maps into real relations.

---

## Hands-On: Draw the Full Diagram, Then Peer-Review It

### Part 1: Draw it yourself

Using everything above and `../appendix/er-notation.md`'s symbol
reference, draw the **complete** registration system E-R diagram,
including the Waitlist thread, from scratch — on paper, or in a tool
like [draw.io](https://app.diagrams.net/). Both are acceptable; a
clear phone photo of a paper diagram counts exactly the same as a
`.drawio` export.

Your diagram must show, at minimum:

- All five entities: Student, Course, Instructor, Section, and
  Enrollment
- The Waitlist entity and its relationship to Student and Section
- Every relationship's cardinality, stated explicitly (not implied)
- Which entities are weak (double-bordered) and which are strong
- At least one key attribute per strong entity, underlined

Save your result as `lab04_er.png` (or `.drawio`, or a clear photo —
any of these is fine).

### Part 2: Peer-review swap

Trade your diagram with a partner. Using the checklist below, review
**their** diagram, not your own — a second pair of eyes catches
exactly the kind of disagreement a single author never notices in
their own work.

**Peer-review checklist:**

1. **Entities present?** Are Student, Course, Instructor, Section,
   Enrollment, and Waitlist all drawn?
2. **Cardinality typed correctly?** Is every relationship explicitly
   labeled 1:1, 1:N, or M:N — not left blank or ambiguous?
3. **Weak entities marked?** Are Enrollment and Waitlist both drawn
   with a double border (or your notation's equivalent), and is it
   clear whose keys they borrow?
4. **Keys identified?** Does every strong entity have at least one
   underlined key attribute?
5. **Attributes classified?** Is at least one composite attribute
   (like `name`) shown split, or clearly marked composite?
6. **Readable without you in the room?** Could you, a stranger to this
   specific diagram, reconstruct the five entities and four
   relationships from the drawing alone, with no verbal explanation?

Write up your review of your partner's diagram as `lab04_review.md`:
for each of the 6 checklist items, note **Pass**, **Fail**, or
**Partial**, with one sentence explaining any Fail or Partial.

---

## Challenge Problem

A designer adds `Room` to the E-R diagram as its own strong entity,
with its own `room_id`, even though the current requirement only says
a Section happens "in a specific room." In 2-3 sentences: is this a
mistake given today's requirements? Under what *additional*
requirement (name one concretely) would promoting Room to its own
entity become the *correct* choice instead? Write your answer into
`lab04_review.md` under a "Challenge" heading.

---

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** Requirement: "A library holds many copies of a book. A
member can borrow a copy, but only one member at a time per copy."
Identify the entities, and state the cardinality between Member and
Copy.

**Practice 2.** "A Driver gives many Rides; a Rider takes many Rides;
each Ride has exactly one Driver and one Rider." Is `Ride` a strong or
a weak entity, and why?

**Practice 3.** Is `office_number` an attribute of Instructor, or a
separate entity? Justify your answer.

**Practice 4.** A Section can have several TAs, and a TA can help with
several Sections. What cardinality is that?

**Practice 5.** In the ride-hailing example, why can't `Ride` simply be
added as a foreign key on `Driver`?

**Practice 6.** A designer gives `Enrollment` its own independent
`enrollment_id`, in addition to `student_id` and `section_id`. Is this
necessary? Why or why not?

**Practice 7.** A food delivery app has `Restaurant`, `MenuItem`, and
`Order`. A customer's order can contain several menu items, from only
one restaurant. Identify the weak entity this requirement implies, and
state its borrowed key.

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Making everything an entity | `Room` drawn as its own entity when the requirement only mentions it as a label | Ask whether the "thing" needs to be tracked independently, with its own attributes and history, or whether it's just a property of something else |
| Leaving cardinality implied | A relationship line with no 1:1/1:N/M:N label | State cardinality explicitly on every relationship, every time — that is the entire point of the notation |
| Giving a weak entity its own surrogate key | Adding `enrollment_id` next to `{student_id, section_id}` | If the combination of borrowed keys is already unique, an extra key adds nothing but false independence |
| Confusing two separate M:N relationships between the same entities | Drawing Enrollment and Waitlist as if they were the same connection | Student-Section-via-Enrollment and Student-Section-via-Waitlist are two different real-world facts; keep them as two separate weak entities |

---

## Submission and Rubric

**Assignment 1 is due this week** (released Week 2): an E-R diagram
design for a small system of your choice, graded on completeness and
clarity — see the course handbook for full submission details. This
lab's deliverables below are separate, ungraded-toward-Assignment-1
practice using the registration system specifically.

| Deliverable | Filename | Points |
|-------------|----------|--------|
| Complete registration E-R diagram (paper photo, `.drawio`, or `.png`) | `lab04_er.png` (or `.drawio`) | 6 |
| Peer-review writeup (6-item checklist + Challenge) | `lab04_review.md` | 4 |

**Total: 10 points**

---

## Further Reading

- Peter Chen, "The Entity-Relationship Model — Toward a Unified View
  of Data" (1976)
- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th ed.,
  Ch. 6 "Database Design Using the E-R Model"
- `../appendix/er-notation.md` — full symbol reference
- `../../slides/_shared/case-study.md` — this diagram's snapshot, and
  where it goes next (Week 6's mapping algorithm)
