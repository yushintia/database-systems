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

- **Last week delivered:** the course contract - what this course covers, how you're graded, and how the semester runs
- **Last week left broken:** we still don't know why a plain spreadsheet or file breaks, or what a database promises instead. What tables? What columns? What connects to what?

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

# A Relation Is One Sheet, Not the Whole Workbook

<div class="thread">Before the formal build begins, a picture worth keeping for the rest of the semester.</div>

<div class="why">
Open your phone's Contacts app. Every contact has the same fields,
name, number, email, that is one relation's schema. Your Photos app is
a completely different relation, different attributes entirely. A
single Excel <strong>workbook</strong> can hold many sheets; a relation
is one sheet, with one fixed shape. The registration system will turn
out to need five separate "sheets," not one.
</div>

---

<!-- Act 3 / BUILD -->

# Relation Schema vs. Relation Instance

<div class="thread">You met schema and instance last week with an ID card. Same idea, now with formal names.</div>

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

# Why a Relation Cannot Have Duplicate Rows

<div class="pain">
If two identical `Student` tuples existed, updating one "Kim Minji" row
and not the other recreates last week's redundancy and inconsistency
problem inside the relational model itself. Forbidding duplicates by
definition closes that door before it opens.
</div>

This is also exactly why we need the next idea: something that
guarantees no two tuples can ever be identical, even by accident.

---

# Superkeys and Candidate Keys

<div class="thread">The formal answer to "what makes a row unique."</div>

**Superkey:** any set of attributes whose values uniquely identify each
tuple in the relation.
**Candidate key:** a superkey with no unnecessary attributes, remove
any one attribute and it stops being unique.

<div class="why">
`{student_id}` uniquely identifies a student, it is a candidate key.
`{student_id, name}` also uniquely identifies a student, but `name` is
unnecessary weight, so it is a superkey, not a candidate key.
</div>

---

# Primary Key

<div class="thread">A relation can have several candidate keys. One gets a special job.</div>

**Primary key:** the candidate key the schema designer chooses as the
main way to identify a tuple, underlined in schema notation:
`Student(`**`student_id`**`, name, major)`.

<div class="why">
`{name}` looks like a candidate key for one student, until "Kim Minji"
enrolls twice under two different names, exactly Week 1's problem. A
system-assigned `student_id`, never typed by hand, cannot repeat that
mistake. That is why real systems almost never use a person's name as
a primary key.
</div>

---

# Foreign Key: Connecting Two Relations

<div class="thread">A primary key identifies rows within one relation. A foreign key points across two.</div>

**Foreign key:** an attribute (or set of attributes) in one relation
that must match the primary key of a tuple in another relation, or be
empty.

```
Enrollment(student_id, course_code, grade)
```

Here `student_id` is a **foreign key** referencing `Student.student_id`.
This is the formal version of the "linked spreadsheets" idea from
Week 1's case study, now with a rule enforcing the link.

---

# Three Integrity Constraints

<div class="thread">Three specific rules a relation must obey, closing three of Week 1's seven failures. One slide each.</div>

Every relation, no matter its schema, must obey three rules at once.
The next three slides take them one at a time, each with the exact
Week 1 failure it closes.

---

# Constraint 1: Domain Constraint

<div class="thread">The simplest rule: a value must be the kind of thing its column claims to be.</div>

> Every value in a tuple must belong to its attribute's declared
> **domain**.

<div class="pain">
A grade column with domain "A0 through F" should never accept "A99."
Week 1's integrity-problem anomaly, a spreadsheet cell that accepts
anything typed into it, is exactly what a domain constraint forbids by
definition, not by someone remembering to double-check.
</div>

---

# Constraint 2: Key Constraint

<div class="thread">The rule this whole lecture has been building toward.</div>

> No two tuples in a relation may share the same primary key value.

<div class="pain">
Two `Student` rows both claiming `student_id = 1` would make "which
one is the real student 1" an unanswerable question. The key
constraint makes this situation impossible to create in the first
place, not just unlikely.
</div>

---

# Constraint 3: Referential Integrity

<div class="thread">The rule connecting two relations, not just one.</div>

> Every foreign key value must match an existing primary key value in
> the referenced relation, or be left empty.

<div class="pain">
An `Enrollment` row pointing at <code>student_id = 999</code>, where no
such student exists in `Student`, is an orphaned, meaningless row.
Referential integrity is the direct fix for orphaned data exactly like
this, enforced automatically once declared.
</div>

---

# Where Keys Show Up: Every App You Use

<div class="thread">Not a registration-system-only idea. This vocabulary is everywhere.</div>

<div class="appgrid">
<div class="app"><div class="name">Instagram</div><div class="desc">every post has a post_id primary key</div></div>
<div class="app"><div class="name">Amazon</div><div class="desc">order_id ties your cart to your address</div></div>
<div class="app"><div class="name">KakaoTalk</div><div class="desc">user_id is the foreign key on every message</div></div>
<div class="app"><div class="name">Banking app</div><div class="desc">account_number is a candidate key, never the owner's name</div></div>
</div>

Every one of these apps would break in exactly Week 1's ways without
the three constraints from the last three slides.

---

# Demo, Step by Step: From Messy Row to Real Relation

<div class="thread">Not handed over finished. Week 1's actual spreadsheet mess, turned into a relation, one decision at a time.</div>

Week 1's spreadsheet had "Kim Minji, Computer Sci., CSE301, Prof. Lee,
A0" in one flat row. Four steps turn that into a real relation.

---

# Step 1: Separate the Facts

Kim Minji, Computer Sci., CSE301, Prof. Lee, A0

Five facts, tangled into one row, about at least three different real
things: a student, a course, an enrollment. This step alone is why
Week 4 exists, choosing which facts belong together is a design
decision, not a formatting one.

---

# Step 2: Pick the Attributes for One Relation

For just the student's own facts: `name`, `major`. Not `course_code`,
not `grade`, those belong to a different relation entirely (Week 4
formalizes exactly this separation).

---

# Step 3: Assign Domains

`name`: text, up to 100 characters. `major`: text, drawn from the
university's list of real majors, not any arbitrary string.

```
Student(name, major)
```

A schema now exists, but nothing yet prevents two "Kim Minji" tuples
from being indistinguishable.

---

# Step 4: Add the Key

```
Student(student_id, name, major)
```

`student_id`, system-generated, added specifically so
`{student_id}` is a candidate key. Four steps: one messy row becomes
one properly formed relation, every rule from this lecture applied in
the order a real designer actually applies them.

---

# Worked Example: The Registration System, as Relations

<div class="thread">Every rule above, applied at once, to the system you already know.</div>

```
Student(student_id, name, major)
Course(course_code, title)
Instructor(instructor_id, name)
```

- `Student.student_id`, `Course.course_code`, `Instructor.instructor_id`
  are each a primary key, underlined by convention
- Every attribute has a domain: `student_id` is an integer, `name` is
  text, `major` is text drawn from a limited list of real majors
- No table here has a duplicate primary key value, by definition

This is not yet the full schema, Section and Enrollment are still
missing. Week 4 fills in the rest, formally.

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

# Practice: A Library System

<div class="thread">Same vocabulary, a different domain, so it is clearly the vocabulary that generalizes, not the registration example.</div>

`Book(isbn, title, author)`, `Member(member_id, name)`,
`Loan(isbn, member_id, due_date)`.

**Question:** name a candidate key for `Loan`, and identify both of its
foreign keys.

**Answer:** `{isbn, member_id}` is a candidate key, one member cannot
borrow the exact same book twice at once. `isbn` and `member_id` are
each foreign keys, referencing `Book.isbn` and `Member.member_id`.

---

# Practice: An Online Store

<div class="thread">One more domain, one more rep, before moving to full-speed check yourself.</div>

`Product(sku, name, price)`, `Customer(customer_id, name)`,
`Order(order_id, customer_id, sku, quantity)`.

**Question:** `Order` has its own `order_id`. Why might a designer
choose that over a composite key of `{customer_id, sku}`?

**Answer:** A customer can order the same product twice, in two
separate orders (`quantity` two different times), so
`{customer_id, sku}` is not actually unique. A dedicated `order_id`
solves it directly, exactly why real e-commerce systems use one.

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

<!-- SLOT 14: Limits, becomes Week 3 slot 4 -->

# What Precise Vocabulary Cannot Do

<div class="limits">
We now have a rigorous definition of what a table is, relations,
attributes, tuples, keys, and the rules they must obey. But nothing in
this vocabulary tells us <em>which</em> tables to make. Why split
Student from Enrollment, and not some other way? Knowing the rules a
table must follow is not the same as knowing which tables to build.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 2 leaves **which tables to design, and why** unsolved. **Week 3,
Data Modelling**, addresses it: a structured design process, so the
answer stops being a guess.

---

<!-- SLOT 16: Summary -->

# Summary

- A relation is a set of tuples conforming to a schema, attributes
  drawn from domains, no duplicate tuples, no meaningful row order.
- Superkey, candidate key, and primary key formalize what makes a row
  unique. Foreign key formalizes how relations connect.
- Three integrity constraints, domain, key, referential, close three of
  Week 1's seven failure categories by definition, not by discipline.
- **Reading:** Silberschatz et al., 7th ed., Chapter 2
- **Prepare:** think about the registration system's Section and
  Enrollment relations. What would their primary keys be?

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
