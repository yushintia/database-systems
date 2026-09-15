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

**Concretely:** schema `Student(student_id, name, major)`, with one
tuple `(1, 'Kim Minji', 'Computer Science')`: one value per attribute,
matching the schema exactly.

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

# Worked Example: The Registration System's Five Relations

<div class="thread">Every relation this course builds toward, together, before we study any one of them closely.</div>

<div class="two-col">
<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Student</span></div>
<div class="row"><span class="pk">student_id</span>, name, major</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Course</span></div>
<div class="row"><span class="pk">course_code</span>, title</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Instructor</span></div>
<div class="row"><span class="pk">instructor_id</span>, name, office, email</div>
</div>
</div>
<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Section</span></div>
<div class="row"><span class="pk">section_id</span>, <span class="fk">course_code</span>, <span class="fk">instructor_id</span>, room, semester</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Enrollment</span></div>
<div class="row"><span class="pk fk">student_id</span>, <span class="pk fk">section_id</span>, grade</div>
</div>
</div>
</div>

Underlined = primary key, italic = foreign key. This is the target
schema every worked example this week draws from, the same five
relations named in the course's case-study reference.

---

# Worked Example: One Tuple, Attribute by Attribute

<div class="thread">Checking a single row against its schema, one attribute at a time.</div>

Tuple `(3, 'Lee Somin', 'Computer Science')` against
`Student(student_id, name, major)`:

| Attribute | Value | Domain | Legal? |
|---|---|---|---|
| student_id | 3 | positive integer | Yes |
| name | 'Lee Somin' | text, ≤100 characters | Yes |
| major | 'Computer Science' | one of a fixed list of majors | Yes |

Change `major` to `'Undecided XYZ123'`, not on the fixed list, and the
tuple is illegal the moment it's proposed - before keys even enter
the discussion.

---

# Worked Example: A Second Relation, Section, Attribute by Attribute

<div class="thread">The same check, on a relation with two foreign keys.</div>

Tuple `(5, 'CSE301', 2, '성파 702', '2026-2')` against
`Section(section_id, course_code, instructor_id, room, semester)`:

| Attribute | Value | Domain | Legal? |
|---|---|---|---|
| section_id | 5 | positive integer | Yes |
| course_code | 'CSE301' | must exist in `Course` | Yes (checked later) |
| instructor_id | 2 | must exist in `Instructor` | Yes (checked later) |
| room | '성파 702' | a real building/room code | Yes |
| semester | '2026-2' | pattern `YYYY-1` or `YYYY-2` | Yes |

`course_code` and `instructor_id`'s domains reach outside this one
relation entirely - that reach is exactly what a foreign key is.

---

# Worked Example: A Third Relation, Instructor, Attribute by Attribute

<div class="thread">One more relation, this time carrying two candidate keys at once - a preview of the next section.</div>

Tuple `(2, 'Prof. Han', '인지관 305', 'han@deu.ac.kr')` against
`Instructor(instructor_id, name, office, email)`:

| Attribute | Value | Domain | Legal? |
|---|---|---|---|
| instructor_id | 2 | positive integer, system-assigned | Yes |
| name | 'Prof. Han' | text, ≤100 characters | Yes |
| office | '인지관 305' | a real building/room code | Yes |
| email | 'han@deu.ac.kr' | valid email, unique per instructor | Yes |

---

# Worked Example: A Fourth Relation, Course, Attribute by Attribute

<div class="thread">The last of the four independent relations before Enrollment ties them together.</div>

Tuple `('CSE301', 'Database Systems')` against `Course(course_code,
title)`:

| Attribute | Value | Domain | Legal? |
|---|---|---|---|
| course_code | 'CSE301' | fixed department-prefix pattern | Yes |
| title | 'Database Systems' | text, ≤150 characters | Yes |

Only two attributes, but the same rule as every relation so far:
every value must belong to its attribute's domain, no exceptions for
"simple-looking" relations.

---

# Domains Are More Than "Any Text"

<div class="thread">A domain is a rule, not just a data-type label.</div>

| Attribute | Domain, in words | Legal example | Illegal example |
|---|---|---|---|
| grade | one of `{A+, A0, A-, ..., F}` | `'B0'` | `'A99'` |
| student_id | positive integer, system-assigned | `1057` | `'abc'` |
| semester | pattern `YYYY-1` or `YYYY-2` | `'2026-2'` | `'Fall'` |
| room | a real building/room code | `'성파 702'` | `''` (empty) |

---

# Domain Constraint vs. Data Type

<div class="thread">A data type is the first step. A domain is a stricter promise on top of it.</div>

A column declared `INT` in MySQL happily stores `-5`. A `room
capacity` column's real domain is "an integer, zero or greater" - the
data type alone does not say that. A column declared as text happily
stores `'Z'`; `grade`'s real domain is one specific list of letter
grades, not "any text."

<div class="why">
Declaring a data type is necessary but not sufficient. Enforcing the
exact legal set of values, sometimes automatically (a
<code>CHECK</code> constraint, Week 9), sometimes only by discipline
until then, is the domain constraint's actual job.
</div>

---

# Can an Attribute's Value Be Empty?

<div class="thread">Domain says what values are legal. A separate question: is "nothing yet" one of them?</div>

`Enrollment.grade` has no value until an instructor submits one - a
temporarily unknown value, legal as long as the schema explicitly
allows this attribute to be empty. Contrast: `Student.student_id` may
never be empty. It is the primary key, and the key constraint forbids
any tuple from lacking one.

<div class="why">
Which attributes may be empty and which absolutely cannot is a real
design decision. It becomes explicit in the mapping algorithm
(Week 6) and formal in DDL (Week 9).
</div>

---

# The Domain Constraint, Applied to All Five Relations

<div class="thread">One rule, checked once, across everything built so far.</div>

| Relation | Key attribute's domain |
|---|---|
| Student | student_id: positive integer, system-assigned |
| Course | course_code: fixed department-prefix pattern |
| Instructor | instructor_id: positive integer, system-assigned |
| Section | section_id: positive integer, system-assigned |
| Enrollment | {student_id, section_id}: each must independently satisfy its own relation's domain |

Every relation obeys the exact same constraint, even though every
attribute's actual legal values look completely different.

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

# The Key Hierarchy

<div class="thread">Superkey, candidate key, primary key are not three unrelated ideas - one nests inside the next.</div>

<div class="er">
<svg viewBox="0 0 700 400" width="620" height="354">
<title>Nested-box diagram of the key hierarchy. The outermost box, Superkey, contains example attribute sets student_id-name and student_id-name-major. Inside it, a smaller box, Candidate Key, contains student_id and email. Inside that, the smallest, filled box, Primary Key, contains the single chosen key student_id, the one candidate key the designer picked.</title>
<rect class="ent-outer" x="20" y="20" width="660" height="360" rx="14"/>
<text class="lbl" x="350" y="50">Superkey</text>
<text x="350" y="75">{student_id, name} &#183; {student_id, name, major}</text>
<rect class="ent-outer" x="100" y="110" width="500" height="270" rx="14"/>
<text class="lbl" x="350" y="140">Candidate Key</text>
<text x="350" y="165">{student_id} &#183; {email}</text>
<rect class="ent" x="220" y="235" width="260" height="120" rx="14"/>
<text class="lbl" x="350" y="275">Primary Key</text>
<text x="350" y="300">{student_id}</text>
<text x="350" y="335" font-size="12">the one candidate key chosen</text>
</svg>
</div>

Every primary key is a candidate key. Every candidate key is a
superkey. The reverse is never guaranteed.

---

# Worked Example: Every Superkey of Enrollment

<div class="thread">Applying the hierarchy diagram to one real relation, exhaustively.</div>

`Enrollment(student_id, section_id, grade)`:

| Attribute set | Superkey? | Candidate key? |
|---|---|---|
| {student_id} | No - one student has many enrollments | No |
| {section_id} | No - one section has many enrollments | No |
| {student_id, section_id} | Yes | **Yes - minimal** |
| {student_id, section_id, grade} | Yes | No - `grade` is unnecessary |

Exactly one candidate key exists here, and it becomes the primary key:
`PRIMARY KEY (student_id, section_id)`.

---

# Worked Example: Superkeys That Aren't Candidate Keys

<div class="thread">A relation where more than one attribute set turns out to work.</div>

`Section(section_id, course_code, instructor_id, room, semester)`:

| Attribute set | Superkey? | Candidate key? |
|---|---|---|
| {section_id} | Yes | **Yes - minimal** |
| {section_id, room} | Yes | No - `room` is unnecessary |
| {course_code, instructor_id, semester} | Yes, if one instructor teaches one section of one course per semester | **Yes - minimal, if that rule holds** |

Two independent candidate keys can exist in the same relation - the
next slide picks between them.

---

# Worked Example: Two Candidate Keys, One Primary Key

<div class="thread">Choosing, when a relation offers more than one legitimate option.</div>

`Instructor(instructor_id, name, office, email)` has two candidate
keys: `{instructor_id}` and `{email}` (assuming email is unique and
never reused). Only one is underlined as the primary key:

`Instructor(`**`instructor_id`**`, name, office, email)`

<div class="why">
A candidate key that exists but was <em>not</em> chosen as primary is
sometimes called an <strong>alternate key</strong>. `email` still
matters here - it can still enforce uniqueness on its own - it is
just not the relation's main identifier.
</div>

---

# Natural Key vs. Surrogate Key

<div class="thread">Choosing which candidate key becomes primary is a real design decision, not a coin flip.</div>

| | Natural key | Surrogate key |
|---|---|---|
| Drawn from | real-world data (`email`) | system-generated, meaningless outside the database (`student_id`) |
| Risk | people change email, or reuse one across accounts | essentially none - it never has a real-world reason to change |
| Registration system's choice | rarely, if ever, primary | almost always primary |

<div class="why">
This is exactly why Week 1's "Kim Minji" problem gets fixed by a
surrogate <code>student_id</code>, never by trusting a name or any
other real-world value to stay stable.
</div>

---

# Worked Example: The Key Hierarchy, Applied to the Library Schema

<div class="thread">The same three-level hierarchy, on a relation outside the registration system.</div>

`Loan(isbn, member_id, due_date)`, assuming one active loan per member
per book:

| Attribute set | Superkey? | Candidate key? |
|---|---|---|
| {isbn} | No - many members can borrow the same title over time | No |
| {member_id} | No - one member can hold several loans | No |
| {isbn, member_id} | Yes | **Yes - minimal** |

`{isbn, member_id}` sits at the innermost box of the hierarchy: it is
this relation's only candidate key, so it is also the primary key.

---

# A Note on Alternate Keys

<div class="thread">One term worth recognizing, rarely tested, common in real schemas.</div>

Any candidate key not chosen as primary is an **alternate key**. A
real database can still enforce its uniqueness with a `UNIQUE`
constraint (Week 9), even though only the primary key gets underlined
in this course's notation.

<div class="why">
`Instructor.email` from three slides ago is a textbook alternate key:
unique, reliable, but not the relation's chosen identifier.
</div>

---

# Foreign Keys and the Three Integrity Constraints

<div class="thread">A primary key identifies rows within one relation. Three more rules connect and protect every relation.</div>

**Foreign key:** an attribute in one relation that must match the
primary key of a tuple in another relation, or be empty - the formal
version of "linked spreadsheets," now enforced.

| Constraint | Rule | The Week 1 failure it closes |
|---|---|---|
| **Domain** | every value belongs to its attribute's domain | a grade column accepting "A99" |
| **Key** | no two tuples share a primary key value | two indistinguishable "Kim Minji" rows |
| **Referential integrity** | every foreign key matches an existing primary key, or is empty | an enrollment pointing at a student who doesn't exist |

---

# Domain Constraint, Worked: The Grade Column

<div class="thread">The first of the three constraints, seen as a specific attempted insert.</div>

An instructor tries to record `Enrollment.grade = 'A99'`.
`grade`'s declared domain: `{A+, A0, A-, B+, B0, B-, C+, C0, C-, D+,
D0, F}`. `'A99'` is not a member of that set, so the domain constraint
rejects the value outright - before this row is even checked against
any key.

Compare: `grade = 'B+'` passes immediately, it is a member of the
declared set.

---

# Key Constraint, Worked: Two "Kim Minji" Rows

<div class="thread">The second constraint, on the exact failure mode Week 1 opened with.</div>

Two proposed `Student` tuples:

```
(7, 'Kim Minji', 'Computer Science')
(7, 'Kim Minji', 'Computer Science')
```

Both claim `student_id = 7`. The key constraint says no two tuples may
share a primary key value - the second insert must be rejected. This
is the exact rule a spreadsheet never had, and the exact rule that
makes "the same person, typed twice" impossible by definition, not
just unlikely.

---

# Referential Integrity, Worked: The Dangling Foreign Key

<div class="thread">The third constraint, and the failure mode a spreadsheet's "linking" never actually prevented.</div>

<div class="two-col">
<div class="schema-tbl">
<div class="hd"><span>Enrollment</span></div>
<div class="row"><span class="fk">student_id</span> = 999, section_id = 5, grade = <em>null</em></div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Student</span></div>
<div class="row"><span class="pk">student_id</span> = 1, name = Kim Minji</div>
<div class="row"><span class="pk">student_id</span> = 2, name = Park Jiho</div>
</div>
</div>

<div class="pain">
No row in <code>Student</code> has <code>student_id = 999</code>.
This <code>Enrollment</code> row references nothing. Referential
integrity forbids it from ever being inserted.
</div>

---

# What Referential Integrity Prevents, a Second Case

<div class="thread">The same rule, on the other foreign key in the same relation.</div>

`Section.instructor_id` references `Instructor.instructor_id`. Suppose
`Instructor` row `instructor_id = 4` is removed while a `Section` row
still holds `instructor_id = 4`. That `Section` row now points at
nothing - a dangling foreign key, the same failure shape as the
previous slide, on a different pair of relations.

<div class="why">
A real DBMS can be told to block the deletion, or cascade it
automatically - the exact mechanism is a Week 9 DDL detail. This
week's job is only recognizing that the constraint itself must be
enforced somehow, by someone.
</div>

---

# Worked Example: The Full Foreign-Key Map

<div class="thread">Every foreign key in the schema, at once.</div>

<div class="cardlist">
<div class="card"><div class="h">Enrollment &rarr; Student</div><div class="d"><code>student_id</code> must match a real <code>Student.student_id</code></div></div>
<div class="card"><div class="h">Enrollment &rarr; Section</div><div class="d"><code>section_id</code> must match a real <code>Section.section_id</code></div></div>
<div class="card"><div class="h">Section &rarr; Course</div><div class="d"><code>course_code</code> must match a real <code>Course.course_code</code></div></div>
<div class="card"><div class="h">Section &rarr; Instructor</div><div class="d"><code>instructor_id</code> must match a real <code>Instructor.instructor_id</code></div></div>
</div>

Four foreign keys, four independent checks - every one of them a
referential integrity constraint.

---

# All Three Constraints, Applied to Enrollment at Once

<div class="thread">One relation, checked against every rule from this week simultaneously.</div>

`Enrollment(student_id, section_id, grade)` must satisfy:

- **Domain:** `grade` is either empty or one of the declared letter
  grades
- **Key:** no two tuples share the same `{student_id, section_id}`
- **Referential integrity:** `student_id` exists in `Student`, and
  `section_id` exists in `Section`

Every tuple ever inserted into `Enrollment` is checked against all
three, every time, with no exceptions.

---

# Worked Example: What Happens When You Insert a Bad Row

<div class="thread">Tracing one proposed insert through all three constraints at once.</div>

Proposed tuple: `(student_id = 999, section_id = 3, grade = 'Z')`.

| Constraint | Check | Result |
|---|---|---|
| Domain | is `'Z'` a declared grade? | **Fails** |
| Key | does `{999, 3}` already exist? | not yet checked - domain already failed |
| Referential integrity | does `student_id = 999` exist in `Student`? | **Fails** |

This single row fails two constraints at once. Any one failure is
already enough to reject it.

---

# Worked Example: Loading the Flat Table, Attempts 1 and 2

<div class="thread">Same registration spreadsheet from Week 1, now a live table - and still no clean key in sight.</div>

`raw_registrations`: Week 1's 18 messy rows, no primary key declared,
on purpose.

| student_name | student_major | course_code | course_title | instructor | room | grade |
|---|---|---|---|---|---|---|
| Kim Minji | Computer Science | CSE301 | Database Systems | Prof. Lee | 성파 702 | A0 |
| Park Jiho | Software Engineering | CSE301 | Database Systems | Prof. Lee | 성파 702 | B+ |
| MinJi Kim | Computer Science | CSE210 | Data Structures | Prof. Han | 인지관 305 | A- |
| Lee Somin | Computer Science | CSE301 | Database Systems | Prof. Lee | 성파 702 | A0 |
| Choi Yuna | Data Science | CSE210 | Data Structures | Prof. Han | 인지관 305 | B0 |

| Attempt | Why it fails |
|---|---|
| `student_name` | "Kim Minji" is typed 3 different ways - one person looks like three rows |
| `course_code` | repeats constantly - many students share one course |

Two attempts down, both fail for opposite reasons: one attribute is
too *inconsistent*, the other is too *common*.

---

# Worked Example: Loading the Flat Table, Attempts 3 and 4

<div class="thread">Two more attempts, closer, but still not a real key.</div>

| Attempt | Why it fails |
|---|---|
| `{student_name, course_code}` | closer, but a retake, or two students who happen to share a name, can still collide |
| the entire row | only unique by luck on today's 18 rows, not by any real-world guarantee |

<div class="why">
The fix - a system-generated <code>student_id</code> - doesn't exist
in this raw table yet. Nothing here forces us to add one: deciding
<em>how many relations, split which way</em> is next week's job.
</div>

---

# Reading and Writing Schema Notation

<div class="thread">One notation, used for the rest of this course.</div>

- Relation name, then parentheses, comma-separated attributes:
  `Relation(attr1, attr2, ...)`
- **Underline** the primary key: `Student(`**`student_id`**`, name, major)`
- *Italicize* (or mark `FK`) a foreign key:
  `Section(section_id, `*`course_code`*`, `*`instructor_id`*`, room, semester)`
- A composite primary key gets its own line:
  `PRIMARY KEY (student_id, section_id)`

---

# Worked Example: A Library Membership Schema

<div class="thread">Applying this week's whole vocabulary to a system outside the registration office.</div>

<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Book</span></div>
<div class="row"><span class="pk">isbn</span>, title, author</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Member</span></div>
<div class="row"><span class="pk">member_id</span>, name</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Loan</span></div>
<div class="row"><span class="pk fk">isbn</span>, <span class="pk fk">member_id</span>, due_date</div>
</div>
</div>

Three relations, the same rules apply: every attribute has a domain,
every relation has a key, every foreign key must resolve.

---

# Worked Example: Keys and Foreign Keys in the Library Schema

<div class="thread">Naming exactly what makes each row in this schema unique.</div>

| Relation | Candidate key | Foreign key(s) |
|---|---|---|
| Book | {isbn} | none |
| Member | {member_id} | none |
| Loan | {isbn, member_id} | `isbn` &rarr; `Book.isbn`; `member_id` &rarr; `Member.member_id` |

A `Loan` row with an `isbn` pointing at a book removed from `Book`
last year violates referential integrity, the exact same failure shape
as the registration system's dangling `Enrollment` row.

---

# Worked Example: An Online Store Schema

<div class="thread">A fourth domain, same vocabulary, one new wrinkle.</div>

<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Product</span></div>
<div class="row"><span class="pk">sku</span>, name, price</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Customer</span></div>
<div class="row"><span class="pk">customer_id</span>, name</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Order</span></div>
<div class="row"><span class="pk">order_id</span>, <span class="fk">customer_id</span>, <span class="fk">sku</span>, quantity</div>
</div>
</div>

`Order` has its own surrogate key, `order_id`, instead of a composite
key built from its two foreign keys.

---

# Worked Example: Why Order Gets Its Own order_id

<div class="thread">The wrinkle from the previous slide, resolved.</div>

Why not `PRIMARY KEY (customer_id, sku)`, the way `Enrollment` uses
`{student_id, section_id}`? Because a customer placing the **same
product** in two separate orders (today, then again next month) is
completely normal - `{customer_id, sku}` would forbid it outright.

<div class="why">
`order_id` as a surrogate key sidesteps the restriction entirely. This
is a real design choice, not a rule this week hands you automatically
- notice how it differs from Enrollment's composite key, and why.
</div>

---

# Worked Example: A Movie Streaming Schema

<div class="thread">One more domain, the same three-step process every time.</div>

<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Member</span></div>
<div class="row"><span class="pk">member_id</span>, name</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Movie</span></div>
<div class="row"><span class="pk">movie_id</span>, title</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Watch</span></div>
<div class="row"><span class="pk fk">member_id</span>, <span class="pk fk">movie_id</span>, watched_date</div>
</div>
</div>

Candidate key: `{member_id, movie_id}`, assuming one watch record per
member per movie. Foreign keys: `member_id` &rarr; `Member.member_id`;
`movie_id` &rarr; `Movie.movie_id`.

---

# Worked Example: Choosing Keys for the Full Schema at Once

<div class="thread">Every relation from this lecture's main example, side by side, as a single reference.</div>

| Relation | Candidate key | Primary key | Foreign key(s) |
|---|---|---|---|
| Student | {student_id} | student_id | none |
| Course | {course_code} | course_code | none |
| Instructor | {instructor_id}, {email} | instructor_id | none |
| Section | {section_id} | section_id | course_code, instructor_id |
| Enrollment | {student_id, section_id} | student_id, section_id | student_id, section_id |

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

# Common Mistakes, Continued

- **Trusting a key that "happens" to be unique on today's sample
  data:** the entire-row "key" from `raw_registrations` works only by
  luck on 18 rows, and breaks the moment realistic new data arrives
- **Assuming a data type alone enforces a domain:** an `INT` column
  still needs its own rule against negative capacities; a `TEXT`
  column still needs its own rule against `'A99'`
- **Leaving a primary key attribute empty:** the key constraint
  requires every tuple to have one, "not entered yet" is never legal
  for a primary key, even when it is legal for an ordinary attribute

---

# Sample Question 1

**Question:** `Instructor(instructor_id, name, office)`. Is
`{instructor_id}` a candidate key, a superkey, both, or neither?

---

# Sample Question 1: Answer

**Answer:** **Both.** It uniquely identifies each instructor (superkey)
and has no unnecessary attributes to remove (candidate key). A
relation's primary key is always both.

---

# Sample Question 2

**Question:** An `Enrollment` row has `student_id = 999`, but no
student with ID 999 exists in `Student`. Which integrity rule is
broken?

---

# Sample Question 2: Answer

**Answer:** **Referential integrity.** The foreign key `student_id` in
`Enrollment` must match an existing primary key value in `Student`.

---

# Sample Question 3

**Question:** A `Loan` row has `due_date = 'next Tuesday'` in a column
whose domain is defined as calendar dates only. Which constraint
catches this?

---

# Sample Question 3: Answer

**Answer:** **Domain constraint.** "next Tuesday" is not a calendar
date value; it violates the declared domain of the `due_date`
attribute.

---

# Sample Question 4

**Question:** `Member(member_id, name)`, `Class(class_id, name,
day_of_week)`, `Checkin(member_id, class_id, checkin_time)`. A member
can attend the same weekly class more than once, on different weeks.
Name a candidate key for `Checkin` that actually works, and explain
why `{member_id, class_id}` alone is not enough.

---

# Sample Question 4: Answer

**Answer:** **{member_id, class_id, checkin_time}.** The same
member-class pair legitimately repeats across different weeks, so
`checkin_time` (or a date) is required to tell those check-ins apart.

---

# Sample Question 5

**Question:** A `Section` row references `instructor_id = 12`, but
Instructor 12 was deleted last month. Which constraint is violated,
and why is the row "meaningless," not just wrong?

---

# Sample Question 5: Answer

**Answer:** **Referential integrity.** The row points at a primary key
value that no longer exists anywhere; "instructor 12" is not a stale
fact, it refers to nothing at all.

---

# Sample Question 6

**Question:** `Product(sku, name, price)` has `price = -12`, in a
column whose domain is "a non-negative amount of money." Which
constraint catches this?

---

# Sample Question 6: Answer

**Answer:** **Domain constraint.** `-12` is not a member of
"non-negative amounts of money," regardless of whether the column's
data type (a plain number) would technically allow it.

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
- **Lab page:** [Lab 2 in the online Lab Manual](../book/labs/lab02-relational-model.html) - load the
  raw table yourself, and hunt for a primary key that actually holds.
- **Reading:** Silberschatz et al., 7th ed., Chapter 2
- **Prepare:** think about the registration system's Section and
  Enrollment relations. What would their primary keys be?

---

<!-- SLOT N+4: Thank You -->
<!-- _class: end -->

# Thank You
