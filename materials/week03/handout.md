# Week 3 Handout: Data Modelling

Database Systems (511783-001) — for students to keep and read again.
Use plain, simple English on purpose, so it is easy to read even if
English is not your first language.

---

## 1. Glossary: Key Words This Week

Read each definition once now. You do not need to memorize them today —
you will use them all semester.

| Term | Plain definition |
|---|---|
| **Data modeling** | The process of studying real-world requirements and writing them down as a structured description of the data a system must store, before any table is created |
| **Data model** | A noun, not this week's verb: a specific way of structuring data, such as the relational model, the E-R model, or an object model |
| **Requirements** | The real-world facts and rules a system must support, gathered before any design begins |
| **Conceptual design** | The first design stage: identify the real-world things a system must track, and how they relate, in a notation both technical and non-technical people can read |
| **Logical design** | The second design stage: translate the conceptual model into a specific data model's structures — for this course, relations with attributes, keys, and constraints |
| **Physical design** | The third design stage: decide how the logical schema is actually stored — indexes, file organization, performance tuning |
| **Entity** | A real-world thing a design tracks, such as Student, Course, or Instructor, named during conceptual design |
| **Relationship** | A real-world fact connecting two or more entities, such as "a Student enrolls in a Section," named during conceptual design |
| **Schema** | The structured description a design stage produces — a logical schema is the set of relations, attributes, and keys that come out of logical design |
| **E-R diagram** | The formal notation for the conceptual stage, introduced next week (Week 4), that fixes conceptual design's biggest weakness: prose alone is not checkable |
| **Completeness** (Test 1) | A design test: every requirement is represented somewhere in the model |
| **Correctness** (Test 2) | A design test: the model matches the real-world rules, not just the stated wish list |
| **Minimal redundancy** (Test 3) | A design test: no fact is captured in two places by design |
| **Understandability** (Test 4) | A design test: someone who was not in the room can read the design and understand it |
| **Design stage** | One of three one-time steps (conceptual, logical, physical) in the process of building a database |
| **Abstraction level** | Week 1's term for one of three ongoing "faces" (physical, logical, view) that an already-running database presents to different users, every day — not the same idea as this week's design stages, even though the names rhyme |

---

## 2. The Registration System's Waitlist, Worked Out Step by Step

This is the full version of the story from class. Read it slowly if the
in-class pace felt fast.

**The situation.** Armed with last week's vocabulary — relations,
attributes, primary keys, integrity constraints — a team sits down to
design the registration system properly. Everyone agrees a relation
needs a primary key and constraints. Nobody agrees on how many
relations to make, or which real-world facts belong together. One
person proposes three relations, another proposes six, a third
combines student and enrollment data into one relation "to keep it
simple." All three designs technically satisfy every rule from Week 2.
All three cannot be right. The rules tell you what a valid table looks
like; they never told anyone which tables to build in the first place.

That gap is exactly what a new, never-seen-before requirement exposes.
Here is the process, walked through live: "If a section is full,
students can join a waitlist. When a seat opens, the first student on
the waitlist is offered it."

**Step 1: Read the requirement twice.** First read: this sounds like
it is about `Enrollment` — a student and a section, same as always.
Second, closer read: a waitlisted student has **not** enrolled yet,
position in line matters, and "first on the list" implies an order
that `Enrollment` was never designed to track. A new concept is hiding
in this sentence, and only a second read caught it.

**Step 2: Identify what exists.** Write down, in plain language, the
real-world things and the facts connecting them — no table names, no
data types, no primary keys yet:

- **Things that exist:** Student, Section, and now: Waitlist entry
- **Facts connecting them:** a Student joins a Waitlist for a Section;
  a Waitlist entry has a position (1st, 2nd, 3rd in line)

**Step 3: Check against the four tests.** Completeness: does this
capture "first on the list"? Not yet — position is named but not yet
modeled precisely, and that gap carries forward on purpose.
Correctness: a student cannot waitlist for a section they are already
enrolled in, a real-world rule worth writing down now, while it is
still cheap to notice.

**Step 4: State clearly what carries forward, and what does not.**
Conceptual design is not finished here, on purpose. "Student joins a
Waitlist for a Section, with a position" is exactly what Week 4 turns
into entities, attributes, and a formal relationship next. We *can*
now say, correctly, what real-world things and facts a waitlist
feature needs. We *cannot* yet say exactly how "position" should be
represented, or write a single relation for it — prose is not
verifiable the way a primary key is checkable, and two people writing
conceptual designs in prose can still disagree, the same problem as
last week, one level up. That is Week 4's job: a formal, checkable
notation for exactly this stage.

---

## 3. Optional Reading: Extra Detail (Not Required, Not on the Quiz)

This section holds extra explanations that were trimmed from the slides
to keep class time short. Read it if you are curious or want more
examples.

**What skipping this step actually costs.** Jumping straight to tables,
with no design step first, means every designer reinvents the process
from scratch, differently, every time. A design built without first
understanding the real-world requirements tends to miss relationships
nobody thought to ask about — until the system is already in
production. Redesigning a live database because the original design
skipped a requirements step is far more expensive than getting it
right the first time. In industry, "requirements gathering" and
"conceptual design" are standard phases in any software project, not
database trivia — skipping straight to tables is a beginner mistake
that senior engineers are trained to catch early.

**Why design became its own step.** The relational model gave the
field rigor, but it never promised a process. Early relational database
projects, in the 1970s and 1980s, still failed for a familiar reason:
teams built tables straight from requirements documents, with no
intermediate design step. Structured design methodologies emerged
specifically to catch missing requirements and design mistakes on
paper, before a single table existed — when fixing a mistake costs
nothing but an eraser.

**This process is already everywhere around you.** Before any real
app's engineers write a single `CREATE TABLE`, someone sketches, in
plain language: "users have posts," "posts have likes," "a like
belongs to one user and one post." That sketch is conceptual design.
Every app on your phone went through this exact process, whether or
not anyone called it "data modeling" out loud.

**Who actually does this, as a job.**

- **Data architects** own the conceptual and logical design of an
  organization's data, before any single application team starts
  building
- **Business analysts** sit between real-world requirements and
  technical teams, writing down what a system must track in language
  both sides can read
- **Database designers / DBAs** carry a logical design the rest of the
  way into physical design — indexes, storage, performance
- **Systems analysts** run the requirements-gathering step this
  handout describes, on new projects before any design begins

---

## 4. Practice Problems (With Answers)

Try each problem yourself before checking the answer underneath it.

**Problem 1.** Requirement: "Users log workouts. Each workout has
exercises, and each exercise has a number of reps and a weight." Name
the conceptual-stage entities, before writing a single relation.
> **Answer:** User, Workout, Exercise. "A Workout has Exercises" and
> "an Exercise records reps and weight" are the relationships, stated
> in plain language.

**Problem 2.** Requirement: "A restaurant has a menu; each menu item
has a price; a customer places an order containing one or more menu
items." Which of the four "good design" tests would catch a design
that stores the menu item's name inside every single order line,
instead of once in a Menu Item entity?
> **Answer:** **Minimal redundancy.** Storing the name repeatedly, once
> per order line, is exactly the kind of redundancy Test 3 exists to
> catch.

**Problem 3.** "Students must be able to enroll in at most 6 courses
per semester." Which design stage captures this fact first?
> **Answer:** **Conceptual design.** It is a real-world rule about
> students and courses, captured before any table or data type exists.

**Problem 4.** Name one thing Week 1's abstraction levels and this
week's design stages have in common, and one thing that is different.
> **Answer:** **Common:** both split into a "what data is there"
> concern and a "how is it stored" concern. **Different:** Week 1
> describes an already-running system's ongoing structure; this week
> describes a one-time process for building one.

**Problem 5.** Which of the four "good design" tests specifically
catches a model that two different engineers interpret two different
ways?
> **Answer:** **Understandability.** A model two engineers read two
> different ways has failed the "someone who was not in the room can
> read it" test, regardless of how complete or correct it otherwise is.

**Problem 6.** Requirement: "A member borrows books; each book has a
title and an author; a librarian checks a returned book back in." Name
the conceptual-stage entities and the facts (relationships) connecting
them.
> **Answer:** **Entities:** Member, Book, Librarian. **Relationships:**
> a Member borrows a Book; a Librarian checks a Book back in. No table
> names or keys yet — that is Week 4 and Week 6's job.
