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

<div class="cardlist">
<div class="card"><div class="h">Functional Dependencies</div><div class="d">Define a functional dependency and identify one in a relation</div></div>
<div class="card"><div class="h">Normal Form Testing</div><div class="d">Test a relation against 1NF, 2NF, and 3NF</div></div>
<div class="card"><div class="h">Anomaly Hunting</div><div class="d">Trigger and explain an update, deletion, and insertion anomaly caused by a denormalized table</div></div>
<div class="card"><div class="h">3NF Decomposition</div><div class="d">Decompose a denormalized relation into 3NF, without losing information</div></div>
</div>

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

> **In plain words: functional dependency**
> Knowing the value of A always tells you exactly one value of B, for
> every row, forever. A barcode determines exactly one product. A
> national ID number determines exactly one legal name. This is not
> database-specific vocabulary, it is a pattern you already reason
> about daily, made precise enough to test a schema against.

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

# 1NF, A Second Violation: Repeating Meeting Days

<div class="thread">The comma-list trap does not only happen with student rosters.</div>

```
Section(section_id, course_code, instructor_id,
        room, semester, meeting_days)
```

A well-meaning shortcut: `meeting_days` holds `"Mon,Wed,Fri"` in one
cell, instead of one row per meeting day. Same failure as before: no
way to ask "which sections meet on Monday" without parsing text by
hand.

**Fix:** a separate `SectionMeeting(section_id, day)` relation, one row
per section per day, `PRIMARY KEY (section_id, day)`. Atomic values in
every cell, restored.

---

# Visualizing a Transitive Dependency

<div class="thread">The exact chain behind every 3NF violation this lecture has shown, drawn once, in general form.</div>

<div class="er" style="margin:6px 0 2px 0;">
<svg viewBox="0 0 640 210" width="620" height="203">
<title>Functional dependency chain diagram. A box labeled student_id has an arrow to a box labeled major, and a second arrow from major to a box labeled advisor_office. A dashed arrow arcs below, directly from student_id to advisor_office, labeled "only transitively, through major". This is the shape 3NF forbids.</title>
<defs>
<marker id="fdA" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
<path d="M0,0 L0,6 L7,3 z" fill="var(--navy)"/>
</marker>
<marker id="fdB" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
<path d="M0,0 L0,6 L7,3 z" fill="var(--gold)"/>
</marker>
</defs>
<rect class="ent" x="15" y="20" width="160" height="60" rx="6"/>
<rect class="ent" x="240" y="20" width="140" height="60" rx="6"/>
<rect class="ent" x="440" y="20" width="185" height="60" rx="6"/>
<text class="lbl" x="95" y="55">student_id</text>
<text class="lbl" x="310" y="55">major</text>
<text class="lbl" x="532" y="55">advisor_office</text>
<line class="link" x1="175" y1="50" x2="240" y2="50" marker-end="url(#fdA)"/>
<line class="link" x1="380" y1="50" x2="440" y2="50" marker-end="url(#fdA)"/>
<text x="207" y="40" text-anchor="middle" font-size="13" fill="var(--deep)">determines</text>
<text x="410" y="40" text-anchor="middle" font-size="13" fill="var(--deep)">determines</text>
<path d="M95,82 C95,150 532,150 532,82" fill="none" stroke="var(--gold)" stroke-width="2" stroke-dasharray="6,4" marker-end="url(#fdB)"/>
<text class="card" x="313" y="180" text-anchor="middle">only transitively, through major</text>
</svg>
</div>

`student_id &rarr; major &rarr; advisor_office`, but `advisor_office`
never depends on `student_id` directly. 3NF forbids exactly this
shape: `advisor_office` belongs in its own relation, keyed on `major`.

---

# Decomposition, Visualized: Before and After

<div class="thread">The pain slide's own table, split, drawn as schema cards instead of only as code.</div>

<div class="two-col">
<div>
<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Section</span><span class="tag">3NF violation</span></div>
<div class="row"><span class="pk">section_id</span>, course_code, course_title, instructor_id, instructor_name, room, semester</div>
</div>
</div>
</div>
<div>
<div class="schema-stack">
<div class="schema-tbl">
<div class="hd"><span>Section</span><span class="tag">3NF</span></div>
<div class="row"><span class="pk">section_id</span>, <span class="fk">course_code</span>, <span class="fk">instructor_id</span>, room, semester</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Course</span><span class="tag">3NF</span></div>
<div class="row"><span class="pk">course_code</span>, title</div>
</div>
<div class="schema-tbl">
<div class="hd"><span>Instructor</span><span class="tag">3NF</span></div>
<div class="row"><span class="pk">instructor_id</span>, name</div>
</div>
</div>
</div>
</div>

One denormalized relation, two transitive dependencies, becomes three
relations, each with every non-key attribute depending directly on its
own key. This is the entire chapter, in one picture.

---

<!-- _class: section -->

# Keeping a Decomposition Honest

<div class="driving-q">"What formal test catches these anomalies before a schema ever goes into production?"</div>

<div class="thread">Splitting a relation fixes an anomaly. A careless split can create a worse one: losing information the original table held.</div>

---

# A Decomposition Must Stay Lossless

<div class="thread">Not a nice-to-have. If this fails, the split was wrong, no matter how clean it looks.</div>

> A decomposition is **lossless** if joining the resulting relations
> back together, on the columns they share, reconstructs **exactly**
> the original rows, no rows lost, and no extra, invented rows gained.

Every decomposition on these slides keeps a real key column in both
halves on purpose, precisely so this property holds. It is not an
accident of which columns happened to get split where.

---

# Lossless: What a Bad Split Looks Like

<div class="thread">A split that looks reasonable, and silently invents data.</div>

Start from `Section(section_id, course_code, room)` with two real rows:

| section_id | course_code | room |
|---|---|---|
| S1 | CS101 | R101 |
| S2 | CS101 | R102 |

Split on `course_code` instead of `section_id`: `R1(section_id,
course_code)`, `R2(course_code, room)`. Joining `R1` and `R2` back on
`course_code` produces **four** rows, including `(S1, CS101, R102)` and
`(S2, CS101, R101)` — two rows that never existed.

---

# Lossless: The Fix

<div class="thread">Split on the actual key, and the invented rows disappear.</div>

Split on `section_id` instead: `R1(section_id, course_code)`,
`R2(section_id, room)`. `section_id` is `Section`'s own primary key, so
it appears in both halves. Joining `R1` and `R2` back on `section_id`
reconstructs exactly the original two rows, nothing more.

<div class="why">
Every decomposition earlier in this lecture, `Section` into `Section` +
`Course` + `Instructor`, kept a real key (<code>course_code</code>,
<code>instructor_id</code>) in both halves for exactly this reason.
</div>

---

# Demo, Step by Step: Normalizing the Waitlist

<div class="thread">Week 6's clean Waitlist relation, deliberately broken, then fixed, one normal form at a time.</div>

A well-meaning developer adds convenience columns for a report:

```
Waitlist(student_id, section_id, student_name, course_title, position)
```

---

# Waitlist, Step 1: Check 1NF

No repeating groups, no lists inside a cell. Every attribute holds one
atomic value. **Passes.**

---

# Waitlist, Step 2: Check 2NF

`{student_id, section_id}` is the key. Does `student_name` depend on
the whole key, or only part of it? Only `student_id`. **Fails 2NF** — a
partial dependency, the same violation shown earlier this lecture.
`course_title` fails the same check, depending only on `section_id`.

---

# Waitlist, Step 3: Fix 2NF, Then Confirm 3NF

Remove `student_name` (it belongs in `Student`, reachable through
`student_id`) and `course_title` (it belongs in `Course`, reachable
through `Section`). What remains:

```
Waitlist(student_id, section_id, position)
```

No non-key attribute depends on another non-key attribute. **Passes
3NF**, because nothing was ever copied across relations to begin with.

---

# Waitlist, Step 4: Compare to Week 6's Original

```
Waitlist(student_id, section_id, position, date_joined)
PRIMARY KEY (student_id, section_id)
```

Identical shape to what the mapping algorithm produced directly. Two
different paths, deliberate mistake then fix versus correct derivation
from the start, arriving at the same clean relation. That convergence
is the entire point of both lectures.

---

# Anomaly Hunt: the Insertion Anomaly, by Inspection

<div class="thread">The third anomaly from the Cost slide, not triggered live, but just as real.</div>

The seed's denormalized `Section` has no row anywhere that can hold an
instructor who is not yet teaching a section, because `instructor_id`
and `instructor_name` only exist as columns *inside* `Section` rows.

<div class="pain">
A newly hired instructor, not yet assigned to any section, cannot be
recorded at all: there is no <code>Section</code> row to attach their
name to, and no separate <code>Instructor</code> table in this
deliberately broken design. The fact "this person is now an
instructor" has nowhere to live until an unrelated fact, a section
assignment, exists first.
</div>

---

# Capstone Worked Example: A Relation With Both Violations

<div class="thread">One relation, both failures at once, decomposed fully, start to finish.</div>

```
Enrollment(student_id, section_id, grade,
           course_title, room, room_capacity)
```

`PRIMARY KEY (student_id, section_id)`. This relation records a grade,
but also carries the section's course title, room, and that room's
seating capacity, copied in for a report that needed them "close by."

---

# Capstone: Check 1NF and 2NF

**1NF:** every attribute holds one atomic value. **Passes.**

**2NF:** does every non-key attribute depend on the *whole* key
`{student_id, section_id}`? `course_title`, `room`, and `room_capacity`
all depend only on `section_id`, not on `student_id`. **Fails 2NF** —
three partial dependencies at once.

---

# Capstone: Check 3NF

Even after removing the three partial dependencies above, one more
problem hides inside them: `room_capacity` depends on `room`, and
`room` would have depended on `section_id`, not directly on
`section_id` itself. **A transitive dependency inside the very columns
2NF just flagged.** Both checks catch real, separate problems here.

---

# Capstone: The Full Decomposition

```
Enrollment(student_id, section_id, grade)
PRIMARY KEY (student_id, section_id)

Section(section_id, course_code, room)
Course(course_code, title)
Room(room, capacity)
```

Every partial dependency (2NF) and every transitive dependency (3NF)
is gone: each attribute now lives in exactly the relation whose key
determines it directly, and only there.

---

# Practice: Identifying Functional Dependencies

<div class="thread">Before decomposing anything, the first skill is reading dependencies out of real rows.</div>

```
section_id | instructor_id | room
S1         | I2            | R101
S2         | I2            | R101
S3         | I5            | R203
```

**Question:** from this sample, does `section_id &rarr; instructor_id`
appear to hold? Does `room &rarr; instructor_id` appear to hold? Does
`instructor_id &rarr; section_id` appear to hold?

---

# Practice: Identifying Functional Dependencies, Answer

- `section_id &rarr; instructor_id`: **holds**, in this sample, every
  section_id maps to exactly one instructor_id
- `room &rarr; instructor_id`: **appears to hold** here (`R101` always
  pairs with `I2`), but three rows are never enough to *prove* a
  functional dependency, only to falsify one
- `instructor_id &rarr; section_id`: **does not hold** — `I2` appears
  with both `S1` and `S2`, two different section_ids for the same
  instructor

<div class="why">
A functional dependency is a promise about <em>every possible row</em>,
forever, not just the rows currently in the table — sample data can
disprove a claimed FD, but it can never fully prove one.
</div>

---

# Sample Question 1

<div class="thread">A fast sort: name the one normal form each violates first.</div>

**Question:** `Course(course_code, title, prerequisite_codes)` where
`prerequisite_codes` holds `"CS101,CS102"` in one cell. Which normal
form does this violate first?

---

# Sample Question 1: Answer

**Answer:** **1NF.** `prerequisite_codes` is a repeating group inside
one cell, not yet atomic.

---

# Sample Question 2

**Question:** `Enrollment(student_id, section_id, grade, room)`,
`PRIMARY KEY(student_id, section_id)`, where `room` depends only on
`section_id`. Which normal form does this violate first?

---

# Sample Question 2: Answer

**Answer:** **2NF.** `room` depends on only part of the composite key
`{student_id, section_id}`, a partial dependency.

---

# Sample Question 3

**Question:** `Section(section_id, instructor_id, instructor_office)`,
single-key, where `instructor_office` depends on `instructor_id`.
Which normal form does this violate first?

---

# Sample Question 3: Answer

**Answer:** **3NF.** `section_id` is a single-column key (2NF passes
automatically), but `instructor_office` depends on `instructor_id`, a
non-key attribute, not on `section_id` directly: transitive.

---

# Why Normalize at All? The Trade-Off

<div class="thread">Normalization is not free. It is worth its cost, but the cost is real.</div>

Every split this lecture has shown removes an anomaly, and also adds a
**join** the moment someone needs both halves of the split data back
together (Week 12's subject). A fully normalized schema is not
automatically "the best" schema, it is the schema with the fewest
places a single fact can silently disagree with itself.

<div class="why">
This is exactly why the last Common Mistake below exists: normalize
until the anomalies this lecture defines are gone, then stop. Extra
splits past that point trade a real, felt cost, more joins, for no
anomaly actually removed.
</div>

---

# Practice: Normalizing a Library Table

<div class="thread">The full decomposition process, one more time, in a different domain.</div>

`Loan(isbn, member_id, book_title, member_name, due_date)`,
`PRIMARY KEY(isbn, member_id)`.

**Question:** identify every violation and fix it.

---

# Practice: Normalizing a Library Table (Answer)

**Answer:** `book_title` depends on `isbn` alone (partial, 2NF);
`member_name` depends on `member_id` alone (also partial). Fix:
`Loan(isbn, member_id, due_date)`, with `book_title` moved to
`Book(isbn, title)` and `member_name` moved to `Member(member_id,
name)`.

---

# Practice: Spotting a Transitive Dependency

<div class="thread">One more rep, focused specifically on 3NF, the form students find trickiest.</div>

`Employee(employee_id, department_id, department_manager)`, where
knowing the department tells you its manager.

**Question:** name the violation and the fix.

---

# Practice: Spotting a Transitive Dependency (Answer)

**Answer:** **3NF violation.** `employee_id &rarr; department_id &rarr;
department_manager` is transitive. Fix: move `department_manager` into
its own `Department(department_id, manager)` relation.

---

# Practice: A Gym Membership System

<div class="thread">The same shape, one more domain, before this lecture's own case study takes over again.</div>

`Checkin(member_id, gym_location_id, gym_location_address,
checkin_time)`.

**Question:** identify the violation and fix it.

---

# Practice: A Gym Membership System (Answer)

**Answer:** `gym_location_address` depends on `gym_location_id`, a
non-key attribute, not on `member_id` or the natural key of a checkin
event directly: **3NF violation**. Fix: move `gym_location_address`
into its own `GymLocation(gym_location_id, address)` relation.

---

<!-- SLOT N-2: Worked example -->

# Worked Example: Anomaly Hunt

<div class="thread">The exact scenario from the pain slide, run for real, in MySQL.</div>

**Setup.** `book/src/labs/files/lab07/bad_registration_seed.sql` builds
`Student`, `Course`, `Instructor`, and `Enrollment` as clean tables, and
`Section` as the deliberately denormalized one — with **no foreign
key** on `course_code` or `instructor_id`, on purpose. Nothing stops
`Section` from disagreeing with `Course` and `Instructor`, because
nothing checks.

---

# Anomaly Hunt: Triggering an Update Anomaly

<div class="thread">Prof. Lee teaches two sections. The update only reaches one of them.</div>

`book/src/labs/files/lab07/anomaly_triggers.sql` runs:

```sql
UPDATE Section
SET instructor_name = 'Professor S. Lee'
WHERE section_id = 2;
```

| section_id | instructor_id | instructor_name |
|---|---|---|
| 2 | 2 | Professor S. Lee |
| 3 | 2 | Prof. Lee |

One real instructor, two disagreeing names, and MySQL raised no error —
nothing ever tied `instructor_name` to `instructor_id` by a single,
authoritative row.

---

# Anomaly Hunt: Triggering a Deletion Anomaly

<div class="thread">A fact, deleted as a side effect of deleting an unrelated fact.</div>

CS330 ("Operating Systems") and instructor "Dr. Park" exist **only**
inside `section_id = 4`'s denormalized columns — `Course` and
`Instructor` have no rows for either. Running

```sql
DELETE FROM Section WHERE section_id = 4;
```

deletes the section — and, as a side effect, every trace that
"Operating Systems" or "Dr. Park" ever existed anywhere in the
database. Before the delete, both were real, queryable things. After
it, they are gone.

---

# Anomaly Hunt: Root Cause, Named Formally

<div class="thread">The two anomalies above, traced back to a single violation.</div>

`Section(section_id, course_code, course_title, instructor_id,
instructor_name, room, semester)` has a single-column key,
`section_id`, so it automatically passes 2NF. But `section_id &rarr;
instructor_id`, and `instructor_id &rarr; instructor_name`, so
`section_id &rarr; instructor_name` only **transitively** — a 3NF
violation. The same is true of `course_title`, transitively through
`course_code`.

---

# Anomaly Hunt: Decomposition

<div class="thread">Remove each transitively-dependent attribute, put it where it depends on a key directly.</div>

```
Section(section_id, course_code, instructor_id, room, semester)
Course(course_code, title)
Instructor(instructor_id, name)
```

This is exactly `book/src/labs/files/lab06/target_schema.sql`'s
`Section`, `Course`, and `Instructor` — the same schema Week 6's
mapping algorithm produced directly, reached this time by deliberate
mistake, then fix. Update Prof. Lee's name once, in one row, done.

---

<!-- SLOT N-1: Common mistakes -->

# Common Mistakes

- **Confusing 2NF and 3NF:** 2NF is about a composite key's *parts*;
  3NF is about non-key attributes depending on *each other* —
  different failures, different fixes
- **Stopping at 2NF because the key is single-column:** a single-column
  key passes 2NF automatically, but 3NF still applies — always check
  both
- **Treating "passes 2NF" as "anomaly-free":** `Section` above passes
  2NF and still has three anomalies — 2NF is necessary, not sufficient
- **Normalizing past what the requirements need:** every extra split
  costs a join later (Week 12); normalize until anomalies are gone,
  not one step further out of habit

---

# Common Mistakes, Continued

- **Splitting on the wrong column:** a decomposition is only lossless
  if the shared column is a real key of at least one side, splitting
  on any other shared column can invent rows on the join back
- **Overlooking the insertion anomaly:** update and deletion anomalies
  are easy to demonstrate live; insertion anomalies show up as "there
  is nowhere to even put this fact yet," easy to miss without asking
- **Trusting a small sample to prove a functional dependency:** three
  rows that happen to agree do not prove `A &rarr; B` holds for every
  row that will ever exist, only failing to find a counterexample yet

---

<!-- SLOT N..N+j: Sample question(s) -->

# Sample Question 4

**Question:** `Student(student_id, name, major, department_office)`,
where `department_office` depends on `major`, not on `student_id`.
Which normal form does this violate?

---

# Sample Question 4: Answer

**Answer:** **3NF.** `student_id &rarr; major &rarr; department_office`
is a transitive dependency; `department_office` should live in a
separate `Major` or `Department` relation.

---

# Sample Question 5

**Question:** Why was Week 6's derived registration schema already
fully normalized, with no extra work needed this week?

---

# Sample Question 5: Answer

**Answer:** Because Week 6's mapping algorithm never copied an
attribute across relations in the first place, each fact was stored
exactly once, directly dependent on its own relation's key, from the
start.

---

# Sample Question 6

**Question:** `Enrollment(student_id, section_id, grade,
attendance_percent)`. Is this in 2NF? Justify your answer.

---

# Sample Question 6: Answer

**Answer:** **Yes.** Both `grade` and `attendance_percent` depend on
the full composite key `{student_id, section_id}` together, not on
either attribute alone. No partial dependency exists.

---

<!-- SLOT N+1: Limits, becomes Week 9 slot 4 -->

# What a Normalized Schema Cannot Do Alone

<div class="limits">
We now have a schema, fully normalized, provably free of the anomalies
that started this week. It exists on paper, in this lecture's slides
and your own notes. No database anywhere actually has these tables.
There is still no way to create them, or put a single row of data in.
A clean design is not the same as a running system.
</div>

---

<!-- SLOT N+2: Bridge -->

# Next Week

Week 7 leaves **an unbuilt schema, on paper only** unsolved. **Week 9,
DDL**, addresses it: the real MySQL commands that turn this design into
actual tables. (Week 8 is the Midterm Exam, covering Weeks 1 through 7.)

---

<!-- SLOT N+3: Summary -->

# Summary

- A functional dependency, A &rarr; B, means one value of A always
  determines exactly one value of B, the root idea behind every normal
  form.
- 1NF forbids repeating groups. 2NF forbids partial dependency on a
  composite key. 3NF forbids transitive dependency between non-key
  attributes.
- Decomposition fixes a violation by splitting a relation so each fact
  depends directly, and only, on its own relation's key.
- **Lab page:** [Lab 7 in the online Lab Manual](../book/labs/lab07-normalization.html), for the live
  Anomaly Hunt (run `bad_registration_seed.sql`, trigger each
  anomaly), the 3NF decomposition exercise, and rubric.
- **Reading:** Silberschatz et al., 7th ed., Chapter 7
- **Prepare:** the Midterm Exam next week covers Weeks 1 through 7.
  Review every Sample Question and Summary slide across those weeks.

---

<!-- SLOT N+4: Thank You -->
<!-- _class: end -->

# Thank You
