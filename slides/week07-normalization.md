---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 7: Normalization

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: Heaviest conceptual week so far. Budget extra time for 2NF and 3NF, they are where students usually stall. -->

---

<!-- SLOT 2: Where we are -->

# Where We Are

<div class="roadmap">
<div class="wk"><div class="n">Wk 1</div><div class="t">Introduction</div></div>
<div class="wk"><div class="n">Wk 2</div><div class="t">Relational Model</div></div>
<div class="wk"><div class="n">Wk 3</div><div class="t">Data Modelling</div></div>
<div class="wk"><div class="n">Wk 4</div><div class="t">E-R Diagram</div></div>
<div class="wk review"><div class="n">Wk 5</div><div class="t">Quiz 1</div></div>
<div class="wk"><div class="n">Wk 6</div><div class="t">Mapping Algorithm</div></div>
<div class="wk now"><div class="n">Wk 7</div><div class="t">Normalization</div></div>
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

- **Last week delivered:** a deterministic algorithm mapping any E-R diagram to a valid relational schema
- **Last week left broken:** a mechanically valid schema can still carry anomalies. The algorithm guarantees correctness, not quality

---

<!-- SLOT 4: The pain -->

# A "Convenient" Table That Isn't

<div class="pain">

A well-meaning developer, trying to avoid extra joins, builds `Section`
with the instructor's and course's details copied directly inside it:

```
Section(section_id, course_code, course_title,
        instructor_id, instructor_name, room, semester)
```

Now Professor Lee gets married and changes her legal name. Every single
section she has ever taught needs its `instructor_name` updated, by
hand, or the data disagrees with itself. Delete the last section for a
retiring course, and `course_title` disappears with it, even though the
course itself should still be a known course. This table followed
every mapping rule from last week. It still has a real problem.

</div>

---

# What Else This Actually Costs

- **Update anomaly:** one real-world fact (an instructor's name) now
  needs updating in many places instead of one, exactly Week 1's
  redundancy problem, reintroduced after Week 6's clean derivation
- **Deletion anomaly:** deleting one fact (a section) accidentally
  deletes an unrelated fact (a course's existence) as a side effect
- **Insertion anomaly:** a new instructor cannot be recorded until they
  are assigned to at least one section, because instructor data only
  exists inside section rows

<div class="why">
<strong>In industry:</strong> "is this table normalized" is a standard
schema-review question. Un-normalized production tables are a common,
expensive source of data-integrity bugs discovered only after launch.
</div>

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What formal test catches these anomalies before a schema ever goes into production?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

1. Define a functional dependency and identify one in a relation
2. Test a relation against 1NF, 2NF, and 3NF
3. Decompose a relation that fails a normal form, without losing information
4. Explain why the registration schema from Week 6 was already normalized

---

<!-- SLOT 8: Origin -->

# Where Normalization Came From

<div class="thread">The same person from Week 1's history slide, one paper later.</div>

- **1971-1974, Edgar F. Codd** followed up his 1970 relational paper
  with a series of papers defining normal forms, formal tests a
  relation could be checked against, the same way a proof can be
  checked
- The goal was explicit: replace "this table looks fine to me" with a
  test two different people would always agree on

---

<!-- SLOT 9: Core concept -->

# Functional Dependency: Definition

<div class="thread">One idea underlies every normal form this week. Get this right first.</div>

> Attribute set **B** is **functionally dependent** on attribute set
> **A** (written A &rarr; B) if, for every possible instance, one value
> of A always determines exactly one value of B.

`section_id &rarr; instructor_name` in the pain slide's table: knowing
the section tells you exactly one instructor name. That single arrow is
the root of every anomaly on the pain slide.

---

# Functional Dependencies Are Everywhere, Not Just in Databases

<div class="thread">Before the formal build begins, a picture worth keeping.</div>

<div class="why">
A barcode determines exactly one product, that is a functional
dependency you rely on at every convenience store checkout. A phone
number determines exactly one KakaoTalk account. Functional dependency
is not database-specific vocabulary, it is a name for a pattern you
already reason about daily, made precise enough to test a schema
against.
</div>

---

<!-- Act 3 / BUILD -->

# First Normal Form (1NF)

<div class="thread">The baseline. Every relation in this course has satisfied this since Week 2, by definition.</div>

> A relation is in **1NF** if every attribute holds a single, atomic
> value, no repeating groups, no lists inside a cell.

<div class="pain">
A tempting shortcut: <code>Section(section_id, ..., student_ids)</code>
where <code>student_ids</code> holds <code>"1, 2, 7, 12"</code> in one
cell. This is not 1NF. You cannot query "which sections include student
7" without parsing text inside a cell by hand, exactly Week 1's
difficulty-accessing-data problem, reintroduced.
</div>

**Fix:** this is precisely why `Enrollment` exists as its own relation.

---

# Second Normal Form (2NF)

<div class="thread">1NF alone does not catch the pain slide's anomaly. 2NF is the first form that does.</div>

> A relation is in **2NF** if it is in 1NF, and every non-key attribute
> depends on the **whole** primary key, not just part of it.

2NF only matters for relations with a **composite** primary key. A
single-column primary key automatically satisfies 2NF.

---

# 2NF: A Concrete Violation

<div class="thread">Applied to a relation that looks reasonable at first glance.</div>

```
Enrollment(student_id, section_id, grade, course_title)
PRIMARY KEY (student_id, section_id)
```

`course_title` depends only on `section_id` (via Section, via Course),
not on the full key `{student_id, section_id}`. That is a **partial
dependency**, and it violates 2NF.

<div class="pain">
Every student enrolled in the same section repeats that section's
course title. Change the course's title, and it must change in every
enrollment row for that section, one more update anomaly.
</div>

---

# 2NF: The Fix

<div class="thread">Remove the attribute that does not depend on the whole key. It belongs elsewhere.</div>

`course_title` does not belong in `Enrollment` at all, it belongs where
`section_id &rarr; course_title` can be captured once:

```
Enrollment(student_id, section_id, grade)
PRIMARY KEY (student_id, section_id)
```

`course_title` already lives in `Course`, reachable through
`Section.course_code`. This is exactly why Week 6's `Enrollment` never
had `course_title` in the first place, it was already in 2NF.

---

# Third Normal Form (3NF)

<div class="thread">2NF catches partial dependencies. 3NF catches a different, sneakier kind.</div>

> A relation is in **3NF** if it is in 2NF, and no non-key attribute
> depends on another non-key attribute (no **transitive** dependency).

A transitive dependency: A &rarr; B, and B &rarr; C, but C does not
depend on A directly, it depends on A only through B.

---

# 3NF: A Concrete Violation

<div class="thread">The exact anomaly from the pain slide, now with a formal name.</div>

```
Section(section_id, course_code, instructor_id,
        instructor_name, room, semester)
```

`section_id &rarr; instructor_id`, and `instructor_id &rarr;
instructor_name`. So `section_id &rarr; instructor_name`, but only
**transitively**, through `instructor_id`. That is a 3NF violation, and
it is exactly today's pain slide's update anomaly.

---

# 3NF: The Fix

<div class="thread">Remove the transitively dependent attribute, put it where it depends on a key directly.</div>

```
Section(section_id, course_code, instructor_id, room, semester)
Instructor(instructor_id, name)
```

`instructor_name` now lives in `Instructor`, where `instructor_id
&rarr; name` is a direct dependency, not a transitive one. Update
Professor Lee's name once, in one row, done. This is exactly Week 6's
derived `Instructor` and `Section` relations.

---

# The Decomposition Process

<div class="thread">Every fix above followed the same two-step pattern. Here it is, generalized.</div>

1. **Find the violating dependency**, the attribute that does not
   depend on the whole key (2NF) or depends only transitively (3NF)
2. **Split the relation in two**: one relation keeping the dependent
   attribute with whatever it actually depends on, one relation keeping
   the original key with everything that still depends on it directly

<div class="why">
Decomposition must never lose information: every original row must be
reconstructable by joining the new relations back together. Week 12's
JOIN is the exact operation that undoes this split, on purpose.
</div>

---

# Demo, Step by Step: Normalizing the Waitlist

<div class="thread">Week 6's clean Waitlist relation, deliberately broken, then fixed, one normal form at a time.</div>

A well-meaning developer adds convenience columns:
`Waitlist(student_id, section_id, student_name, course_title,
position)`.

---

# Step 1: Check 1NF

No repeating groups, no lists inside a cell. **Passes.** Every
attribute holds one atomic value.

---

# Step 2: Check 2NF

`{student_id, section_id}` is the key. Does `student_name` depend on
the whole key, or just part of it? Just `student_id`. **Fails 2NF**, a
partial dependency, the exact violation from earlier in this lecture.

---

# Step 3: Fix 2NF, Then Check 3NF

Remove `student_name` (it belongs in `Student`, reachable through
`student_id`) and `course_title` (it belongs in `Course`, reachable
through `Section`). What remains:

```
Waitlist(student_id, section_id, position)
```

No non-key attribute depends on another non-key attribute. **Passes
3NF**, because nothing was ever copied across relations to begin with.

---

# Step 4: Compare to Week 6's Original

```
Waitlist(student_id, section_id, position, date_joined)
PRIMARY KEY (student_id, section_id)
```

Identical to what the mapping algorithm produced directly, two
different paths, deliberate mistake then fix, versus correct
derivation from the start, arriving at the same clean relation. That
convergence is exactly the point of both lectures.

---

# Worked Example: Normalizing the Pain Slide's Table

<div class="thread">The whole procedure, start to finish, on the exact table this lecture opened with.</div>

Start: `Section(section_id, course_code, course_title, instructor_id,
instructor_name, room, semester)`

1. `course_title` depends on `course_code`, not on `section_id`, a
   transitive dependency, split it into `Course`
2. `instructor_name` depends on `instructor_id`, not on `section_id`,
   another transitive dependency, split it into `Instructor`

Result: exactly Week 6's five-relation schema. The anomalies are gone
because the dependencies that caused them no longer cross relations.

---

# Beyond 3NF: BCNF, Briefly

<div class="thread">Named for completeness. Most real schemas, including this one, never need it.</div>

> **Boyce-Codd Normal Form (BCNF)** is a stricter version of 3NF: for
> every functional dependency A &rarr; B, A must be a superkey, no
> exceptions, even for dependencies 3NF quietly allows through.

3NF has one narrow edge case BCNF closes, involving overlapping
candidate keys. It is rare enough in practice that this course tests
1NF, 2NF, and 3NF; BCNF is here so the name is not a surprise later.

---

# Practice: Normalizing a Library Table

<div class="thread">The full decomposition process, one more time, start to finish.</div>

`Loan(isbn, member_id, book_title, member_name, due_date)`.

**Question:** identify every violation and fix it.

**Answer:** `book_title` depends on `isbn` alone (partial dependency,
2NF violation); `member_name` depends on `member_id` alone (also
partial). Fix: `Loan(isbn, member_id, due_date)`, with `book_title` in
`Book(isbn, title)` and `member_name` in `Member(member_id, name)`.

---

# Practice: Spotting a Transitive Dependency

<div class="thread">One more rep, focused specifically on 3NF, the form students find trickiest.</div>

`Employee(employee_id, department_id, department_manager)`, where
knowing the department tells you its manager.

**Question:** name the violation and the fix.

**Answer:** **3NF violation.** `employee_id &rarr; department_id
&rarr; department_manager` is transitive. Fix: move
`department_manager` into its own `Department(department_id, manager)`
relation.

---

# Common Mistakes

- **Normalizing past what the requirements need:** every extra split
  costs a join later (Week 12); normalize until anomalies are gone,
  not one step further out of habit
- **Confusing 2NF and 3NF:** 2NF is about a composite key's parts,
  3NF is about non-key attributes depending on each other, they catch
  different problems
- **Forgetting that decomposition must be lossless:** splitting a
  relation incorrectly can make some original rows unreconstructable,
  which is worse than the anomaly it was meant to fix

---

# Check Yourself

1. `Student(student_id, name, major, department_office)`, where
   `department_office` depends on `major`, not on `student_id`. Which
   normal form does this violate?
2. Why was Week 6's derived registration schema already fully
   normalized, with no extra work needed this week?
3. `Enrollment(student_id, section_id, grade, attendance_percent)`.
   Is this in 2NF? Justify your answer.

---

# Answers

1. **3NF.** `student_id &rarr; major &rarr; department_office` is a
   transitive dependency; `department_office` should live in a
   separate `Major` or `Department` relation.
2. Because Week 6's mapping algorithm never copied an attribute across
   relations in the first place, each fact was stored exactly once,
   directly dependent on its own relation's key, from the start.
3. **Yes.** Both `grade` and `attendance_percent` depend on the full
   composite key `{student_id, section_id}` together, this particular
   student's attendance in this particular section, not on either
   attribute alone. No partial dependency exists.

---

<!-- SLOT 14: Limits, becomes Week 9 slot 4 -->

# What a Normalized Schema Cannot Do Alone

<div class="limits">
We now have a schema, fully normalized, provably free of the anomalies
that started this week. It exists on paper, in this lecture's slides
and your own notes. No database anywhere actually has these tables.
There is still no way to create them, or put a single row of data in.
A clean design is not the same as a running system.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 7 leaves **an unbuilt schema, on paper only** unsolved. **Week 9,
DDL**, addresses it: the real MySQL commands that turn this design into
actual tables. (Week 8 is the Midterm Exam, covering Weeks 1 through 7.)

---

<!-- SLOT 16: Summary -->

# Summary

- A functional dependency, A &rarr; B, means one value of A always
  determines exactly one value of B, the root idea behind every normal
  form.
- 1NF forbids repeating groups. 2NF forbids partial dependency on a
  composite key. 3NF forbids transitive dependency between non-key
  attributes.
- Decomposition fixes a violation by splitting a relation so each fact
  depends directly, and only, on its own relation's key.
- **Reading:** Silberschatz et al., 7th ed., Chapter 8
- **Prepare:** the Midterm Exam next week covers Weeks 1 through 7.
  Review every Check Yourself and Summary slide across those weeks.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
