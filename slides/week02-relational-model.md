---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 2: The Relational Model

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: Quick recap of Week 1 before diving in. Ask: who tried to sketch tables for the registration system over the week? -->

---

<!-- SLOT 2: Where we are -->

# Where We Are

<div class="roadmap">
<div class="wk"><div class="n">Wk 1</div><div class="t">Introduction</div></div>
<div class="wk now"><div class="n">Wk 2</div><div class="t">Relational Model</div></div>
<div class="wk"><div class="n">Wk 3</div><div class="t">Data Modelling</div></div>
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

- **Last week delivered:** the course contract, plus a hands-on look
  at the registration office's actual messy spreadsheet - three
  spellings of one name, a deletion that erases a whole course, two
  people's saves colliding.
- **Last week left broken:** we still don't know why a plain
  spreadsheet or file breaks, or what a database promises instead.
  What tables? What columns? What connects to what?

---

<!-- SLOT 4: The pain, zero jargon -->

# Two People, Same Data, Two Different Answers

<div class="pain">

Two students in this class, on their own time, both try to sketch
"tables" for the registration system. One writes a single big list:
student name, major, course, instructor, room, grade, all in one sheet.
The other splits it into a student list and a separate class list, but
puts the grade in the student list instead of the class list.

Both are tables. Neither is obviously wrong by the rules we have so
far, because we have not agreed on what a table is even supposed to
guarantee. Two reasonable people, same requirements, two incompatible
designs.

</div>

<!-- notes: Ask the class to vote which design is "more correct." There is no rule yet to appeal to. That is the hook. -->

---

# What Else This Actually Costs

- Without a shared definition of "table," two team members' designs cannot even be compared, let alone merged
- A design that looks fine on a whiteboard can still let the same fact be stored in two places, exactly last week's problem, unsolved
- Every real schema you will ever touch, in any job, is judged against this exact vocabulary

<div class="why">
<strong>In industry:</strong> "normalize this table" and "what's the
primary key here" are baseline vocabulary in any backend or data role.
Without it, you cannot even read a schema diagram, let alone design one.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What exactly is a table, precisely enough that two people always agree on what counts as one?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

<div class="cardlist">
<div class="card"><div class="h">Relation Basics</div><div class="d">Define a relation precisely: attributes, domains, tuples</div></div>
<div class="card"><div class="h">Keys</div><div class="d">Identify superkeys, candidate keys, and a primary key in a relation</div></div>
<div class="card"><div class="h">Integrity Constraints</div><div class="d">Explain the three integrity constraints a relation must obey</div></div>
<div class="card"><div class="h">Schema Notation</div><div class="d">Read and write a relation schema in standard notation</div></div>
</div>

---

<!-- SLOT 8: Origin -->

# Where This Vocabulary Came From

<div class="thread">This week, meet Edgar F. Codd's actual definitions.</div>

- Before 1970, "tables" in navigational databases had no shared,
  agreed-on rules; every system defined its own structure informally
- Edgar F. Codd's contribution was not the word "table." It was
  borrowing set theory's precision: a relation, defined so rigorously
  that two people can never disagree about whether something qualifies

<div class="why">
A relation in this course means exactly one thing, everywhere, by
everyone, the same way "prime number" means one thing in every math
class on Earth. That precision is the entire point.
</div>

---

<!-- SLOT 9: Core concept -->

# Relation: Definition

<div class="thread">One word, replacing "table," "sheet," and "list," precisely.</div>

> A **relation** is a set of tuples, all conforming to the same
> **relation schema**: a name, and a fixed set of attributes, each
> drawn from a **domain**.

- **Attribute:** a named column, such as `name` or `major`
- **Domain:** the set of legal values an attribute can hold, such as
  "any text up to 100 characters" or "an integer 0 through 100"
- **Tuple:** one row, one value per attribute, matching the schema

---

<!-- Act 3 / BUILD -->

# Relation Schema vs. Relation Instance

<div class="thread">The fixed shape, and the data that fills it, are two different things.</div>

**Relation schema:** the fixed shape, written `Student(student_id, name, major)`.
**Relation instance:** the actual set of tuples right now.

| student_id | name | major |
|---|---|---|
| 1 | Kim Minji | Computer Science |
| 2 | Park Jiho | Software Engineering |

The schema `Student(student_id, name, major)` never changes. This
table of two rows is one instance; add a third student, and you have a
different instance of the exact same schema.

---

# A Relation Is a Set, Not a List

<div class="thread">One consequence of borrowing set theory: two rules a spreadsheet never enforces.</div>

- **No duplicate tuples.** A set cannot contain the same element twice;
  a relation cannot contain two identical rows
- **No ordering.** A set has no first or last element; row order in a
  relation is not part of its meaning, only display order

<div class="why">
This is already stricter than a spreadsheet, where two identical rows
and any row order are both perfectly legal. That gap is not an
accident, it is the fix for redundancy from Week 1.
</div>

---

# Superkeys, Candidate Keys, and Primary Key

<div class="thread">The formal answer to "what makes a row unique."</div>

**Superkey:** any set of attributes whose values uniquely identify each
tuple in the relation.
**Candidate key:** a superkey with no unnecessary attributes, remove
any one attribute and it stops being unique.
**Primary key:** the candidate key the designer picks as the main way
to identify a tuple, underlined in schema notation.

<div class="why">
`{student_id}` uniquely identifies a student, a candidate key.
`{student_id, name}` also works, but `name` is unnecessary weight, so
it's a superkey only. `{name}` alone looks fine until "Kim Minji"
enrolls twice under two different spellings, exactly Week 1's problem
- which is why a system-assigned ID, never typed by hand, is almost
always the primary key in practice.
</div>

---

# Foreign Keys and the Three Integrity Constraints

<div class="thread">A primary key identifies rows within one relation. Four more rules connect and protect every relation.</div>

**Foreign key:** an attribute in one relation that must match the
primary key of a tuple in another relation, or be empty - the formal
version of "linked spreadsheets," now enforced.

| Constraint | Rule | The Week 1 failure it closes |
|---|---|---|
| **Domain** | every value belongs to its attribute's domain | a grade column accepting "A99" |
| **Key** | no two tuples share a primary key value | two indistinguishable "Kim Minji" rows |
| **Referential integrity** | every foreign key matches an existing primary key, or is empty | an enrollment pointing at a student who doesn't exist |

---

# Worked Example: Loading the Flat Table, and Hunting for a Key

<div class="thread">Same registration spreadsheet from Week 1, now a live table - and still no clean key in sight.</div>

`flat_load.sql` loads Week 1's 18 messy rows into one raw MySQL table,
`raw_registrations` - no primary key declared, on purpose. Four
attempts to find one, each failing for a different reason:

| Attempt | Why it fails |
|---|---|
| `student_name` | "Kim Minji" is typed 3 different ways - one person looks like three rows |
| `course_code` | repeats constantly - many students share one course |
| `{student_name, course_code}` | closer, but a retake, or two students who happen to share a name, can still collide |
| the entire row | only unique by luck on today's 18 rows, not by any real-world guarantee |

<div class="why">
The fix - a system-generated <code>student_id</code> - doesn't exist
in this raw table yet. Nothing here forces us to add one: deciding
<em>how many relations, split which way</em> is next week's job.
</div>

---

# Common Mistakes

- **Using a name as a primary key:** names repeat, get misspelled, and
  change (marriage, legal name change); an ID never should
- **Confusing a superkey with a candidate key:** every candidate key is
  a superkey, but most superkeys carry unnecessary extra attributes
- **Forgetting referential integrity:** an `Enrollment` row pointing at
  a `student_id` that does not exist in `Student` is not "a smaller
  bug," it is an undefined, meaningless row

---

# Check Yourself

1. `Instructor(instructor_id, name, office)`. Is `{instructor_id}` a
   candidate key, a superkey, both, or neither?
2. An `Enrollment` row has `student_id = 999`, but no student with ID
   999 exists in `Student`. Which integrity rule is broken?
3. A `Loan` row has `due_date = 'next Tuesday'` in a column whose
   domain is defined as calendar dates only. Which constraint catches this?

---

# Answers

1. **Both.** It uniquely identifies each instructor (superkey) and has
   no unnecessary attributes to remove (candidate key). A relation's
   primary key is always both.
2. **Referential integrity.** The foreign key `student_id` in
   `Enrollment` must match an existing primary key value in `Student`.
3. **Domain constraint.** "next Tuesday" is not a calendar date value;
   it violates the declared domain of the `due_date` attribute.

---

<!-- SLOT N+1: Limits, becomes Week 3 slot 4 -->

# What Precise Vocabulary Cannot Do

<div class="limits">
We now have a rigorous definition of what a table is, relations,
attributes, tuples, keys, and the rules they must obey. But nothing in
this vocabulary tells us <em>which</em> tables to make. Why split
Student from Enrollment, and not some other way? Knowing the rules a
table must follow is not the same as knowing which tables to build.
</div>

---

<!-- SLOT N+2: Bridge -->

# Next Week

Week 2 leaves **which tables to design, and why** unsolved. **Week 3,
Data Modelling**, addresses it: a structured design process, so the
answer stops being a guess.

---

<!-- SLOT N+3: Summary -->

# Summary

- A relation is a set of tuples conforming to a schema, attributes
  drawn from domains, no duplicate tuples, no meaningful row order.
- Superkey, candidate key, and primary key formalize what makes a row
  unique. Foreign key formalizes how relations connect.
- Three integrity constraints, domain, key, referential, close three of
  Week 1's failure categories by definition, not by discipline.
- **Lab page:** `book/src/labs/lab02-relational-model.md` - load the
  raw table yourself, and hunt for a primary key that actually holds.
- **Reading:** Silberschatz et al., 7th ed., Chapter 2
- **Prepare:** think about the registration system's Section and
  Enrollment relations. What would their primary keys be?

---

<!-- SLOT N+4: Thank You -->
<!-- _class: end -->

# Thank You
