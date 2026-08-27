# Week 8 Review Guide: Midterm (Weeks 1-7)

Database Systems (511783-001) — for students to study from before the
Midterm. Same questions as the "Check Yourself" section of the Week 8
slides, with fuller worked explanations than fit on a slide. Organized
by week. Read the matching week's slides first if a question still
feels unfamiliar.

Midterm format reminder: written, individual, closed book, covering
Weeks 1 through 7. The seven weeks are one continuous argument (why a
DBMS exists, what a table precisely is, how to design one, how to
notate that design, then how to turn the design into tables and check
it for redundancy), so if a question feels disconnected from the
others, find where it sits on that chain first. Full policy is in
Week 1's Course Logistics.

---

## Week 2: The Relational Model

**Q1. Week 1 named seven failures of file-based systems. Two of them — atomicity problems and concurrent-access anomalies — share the exact same fix. Which fix, and why does one mechanism solve both?**

> **Answer:** The **transaction manager**. Atomicity (a multi-step
> update either fully happens or not at all) and concurrent-access
> control (two people editing at once without corrupting each other's
> work) are both about protecting an update while it is *in progress*,
> which is exactly the transaction manager's job.

**Why:** It is tempting to think every one of Week 1's seven failures
gets fixed by schema design (relations, normalization), but that is
only true of the first failure, redundancy and inconsistency. Atomicity
and concurrent-access anomalies are runtime problems — they happen
*while* data is being changed, not because the schema is shaped wrong.
A well-normalized `Enrollment` table can still end up corrupted if a
grade update is interrupted halfway through, or if two staff members
save conflicting changes to the same row at the same moment. That is
why the course table pairs both failures with the same fix: the
transaction manager wraps a group of changes so they either all commit
together (atomicity) or get properly serialized against other users'
changes (concurrency), regardless of how good the underlying schema is.

**Common mistake:** assuming normalization (Weeks 6-7) is a cure-all
for every one of Week 1's failures. Normalization only closes the
*redundancy and inconsistency* failure — a correctly normalized
schema can still suffer atomicity or concurrency problems, which is
why the course reserves a separate mechanism (and a later part of the
semester) for them.

---

**Q2. What is the difference between a superkey, a candidate key, and a primary key — and how is a foreign key different from all three?**

> **Answer:** A **superkey** is any attribute set that uniquely
> identifies each tuple, even if it carries extra, unnecessary
> attributes. A **candidate key** is a superkey with no unnecessary
> attributes — remove any one attribute and it stops being unique. A
> **primary key** is the one candidate key the schema designer chooses
> as the relation's official identifier. A **foreign key** is a
> different kind of thing entirely: it is not about identifying rows
> within one relation, it is the mechanism that connects two relations.

**Why:** `{student_id}` uniquely identifies a `Student` tuple with
nothing to spare, so it is a candidate key. `{student_id, name}` also
uniquely identifies a student, but `name` is unnecessary weight — drop
it and `{student_id}` alone still works — so `{student_id, name}` is a
superkey but *not* a candidate key. Every candidate key is a superkey,
but most superkeys are not candidate keys. Once a relation has one or
more candidate keys, the designer picks one to be the primary key,
written underlined in schema notation: `Student(`**`student_id`**`,
name, major)`. A foreign key lives in a *different* relation and
references that primary key — `Enrollment.student_id` referencing
`Student.student_id` — which is exactly how Week 2's "uniquely
identify a row" vocabulary and "connect two relations" vocabulary stay
separate ideas that work together.

**Common mistake:** treating every superkey as a candidate key, and
using a person's name as a primary key. A name is rarely a true
candidate key once you account for a semester's worth of students —
two "Kim Minji"s enrolling breaks uniqueness — which is exactly Week
1's redundancy-and-inconsistency failure resurfacing at the key level.
A system-assigned `student_id`, never typed by hand, does not have that
failure mode.

---

## Week 3: Data Modelling

**Q3. Name the three design stages introduced in Week 3, and what each one produces.**

> **Answer:** **Conceptual** design identifies the real-world entities
> and relationships in plain terms, no notation and no tables yet.
> **Logical** design translates that conceptual picture into the
> actual data model's structures — for this course, relations with
> attributes and keys. **Physical** design decides how the logical
> schema is actually stored: indexes, file organization, performance
> tuning.

**Why:** Applied to "a student enrolls in one or more sections," the
conceptual stage says only: Student and Section exist as things, and a
Student enrolls in a Section — no `PRIMARY KEY`, no columns, nothing
checkable yet. The logical stage is where that sentence becomes
`Enrollment(student_id, section_id, grade)`, and Week 6's mapping
algorithm is exactly the mechanical procedure for making that jump.
The physical stage is the one most students forget exists at all —
it is not "extra," it is the stage where a design decision that looks
fine on paper either holds up or falls over once real data volume and
real query patterns hit it.

**Common mistake:** skipping straight from conceptual language to
naming tables and columns (skipping logical design's own discipline),
or assuming physical design is an afterthought rather than its own
deliberate stage.

---

**Q4. Explain why Week 1's abstraction levels and Week 3's design stages use different words (view/logical/physical versus conceptual/logical/physical) even though they overlap conceptually.**

> **Answer:** They answer different questions. Abstraction levels
> describe an already-running system's three faces, day to day; design
> stages describe the one-time process of building it. The word
> "logical" appears in both because both describe "what data exists,"
> from two different angles — a running system versus the process that
> built it.

**Why:** It is easy to conflate these two three-part lists because two
of the three words literally repeat ("physical," "logical"). But Week
1's levels are about an already-*finished* database: an application
talks to the logical level every single query, never touching the
physical level directly, and that separation is what lets a DBA add
disks (a physical change) without breaking any application (a logical
concern). Week 3's stages, by contrast, describe the *one-time act of
building* that database in the first place — you pass through
conceptual, then logical, then physical exactly once per design, in
that order, and then the design work is done. The two lists rhyme on
purpose, not by accident: the design process (Week 3) is precisely what
produces the clean separation the running system (Week 1) later
depends on.

**Common mistake:** using "logical" or "physical" in an exam answer
without being clear whether you mean the running system's abstraction
level or the one-time design stage — grading distinguishes between
them, and conflating the two usually means the underlying concept
wasn't fully separated in your head either.

---

## Week 4: E-R Diagram

**Q5. What is a weak entity, and how does the Worked Example resolve "a Student enrolls in a Section" (an M:N relationship) using one?**

> **Answer:** A **weak entity** has no key attribute of its own — it
> can only be uniquely identified in combination with another entity's
> key. Student M:N Section is resolved by the weak entity
> `Enrollment`, whose identity is the combination `{student_id,
> section_id}` together, not either alone.

**Why:** An M:N relationship cannot be resolved with a single foreign
key on either side, because one Student can enroll in many Sections
*and* one Section can hold many Students — neither side has "exactly
one" of the other to point at. `Enrollment` is not really "a thing" the
way a Student is; "enrollment #1" means nothing on its own, it only
becomes identifiable once you know *which* student and *which*
section. That borrowed identity is the formal definition of a weak
entity, and it is exactly why Week 6's mapping algorithm gives weak
entities their own rule, distinct from strong entities.

**Common mistake:** giving `Enrollment` its own independent
`enrollment_id` and treating it as a strong entity. That adds a key
with no real-world meaning, when `{student_id, section_id}` already
uniquely identifies the row on its own.

---

**Q6. Why does every relationship on an E-R diagram need an explicit cardinality label — 1:1, 1:N, or M:N — every time, on every relationship?**

> **Answer:** Because cardinality is exactly what Week 6's mapping
> algorithm reads to decide *which* mapping rule to apply. A
> relationship line without a cardinality label is ambiguous and
> cannot be mechanically translated into tables at all.

**Why:** A bare line between Student and Section says only "these are
related" — it does not say whether one Student has one Section, many
Sections, or whether Sections likewise hold many Students. Those are
three different table designs (a shared foreign key on one side, a
foreign key on the other side, or a whole new relation), and the
mapping algorithm has no way to choose among them without the
cardinality already stated on the diagram. This is one of the most
common places students lose points on a diagram question, precisely
because the mistake is invisible on the page: the line is drawn, it
just doesn't say enough.

**Common mistake:** forgetting cardinality on a diagram question, or
labeling only one end of a relationship instead of stating both sides.

---

## Week 6: Mapping Algorithm

**Q7. Draw, in words, the mapping for a 1:N relationship between Department (1) and Instructor (N).**

> **Answer:** No new relation is created. `Instructor` receives a
> foreign key, `department_id`, referencing `Department.department_id`.
> The foreign key always goes on the "many" side.

**Why:** The rule generalizes past this one example: for *any* 1:N
relationship, the "1" side's primary key is placed as a foreign key on
the "N" side, and nothing else changes. It goes on the many side
because each row on the many side (each Instructor) needs to point at
exactly one row on the one side (their Department), while a Department
row cannot hold a single foreign key value that names all of its many
Instructors at once. This is also why a table can carry more than one
such foreign key at the same time without conflict — `Section` can
have both a `course_code` foreign key (from Course 1:N Section) and an
`instructor_id` foreign key (from Instructor 1:N Section), each
answering a different question.

**Common mistake:** putting the foreign key on the "1" side instead of
the "N" side, or creating an unnecessary new relation for a 1:N
relationship — a brand-new relation is only Rule 4's job, for M:N.

---

**Q8. The Worked Example says `Enrollment` satisfies both the weak-entity mapping rule and the M:N mapping rule at once, landing on the identical relation `Enrollment(student_id, section_id, grade)`, `PRIMARY KEY (student_id, section_id)`. Why do two different rules produce the exact same schema?**

> **Answer:** Because a weak entity and an M:N relationship are often
> two descriptions of the same real-world fact. The weak-entity rule
> builds a composite key from the owning entities' primary keys; the
> M:N rule builds a composite key from both participating entities'
> primary keys. Applied to Student-Enrollment-Section, both rules read
> off the same two attributes, `student_id` and `section_id`, so they
> agree.

**Why:** This is not a coincidence to memorize as a special case — it
is a structural fact worth recognizing on any schema. Whenever an M:N
relationship is resolved with a weak entity (as Week 4 always does),
the weak entity's identifying owners *are* the two sides of the M:N
relationship, so the weak-entity rule and the M:N rule are describing
the same composite key from two angles. Recognizing the agreement is a
useful self-check: if your weak-entity mapping and your M:N mapping for
the same relationship ever disagree, one of them has a mistake in it.

**Common mistake:** applying only one of the two rules and treating the
other as irrelevant, rather than noticing they should agree — that
agreement is exactly how to catch a mapping error before it becomes a
1NF/2NF problem in Week 7.

---

## Week 7: Normalization

**Q9. `Enrollment(student_id, section_id, grade, room)`, where `room` depends only on `section_id`. Name the normal form violated, and fix it.**

> **Answer:** **2NF**, a partial dependency (`room` depends on part of
> the composite key, not the whole key). Fix: move `room` into
> `Section`, where it depends on `section_id` alone, the full key of
> that relation.

**Why:** 2NF only matters for a relation with a *composite* primary
key — a single-column primary key automatically satisfies it, since
there is no "part of the key" for anything to depend on. `Enrollment`'s
key is `{student_id, section_id}` together. `grade` genuinely needs
both halves (a grade is specific to *this* student in *this* section),
so it is fine. `room`, though, only needs `section_id` — every student
enrolled in the same section has the same room, so storing `room` in
`Enrollment` repeats it once per student and creates exactly the kind
of update anomaly Week 1 warned about: change a section's room, and it
has to change in every enrollment row for that section. The fix is to
remove the partially-dependent attribute and place it where it depends
on the *whole* key of its own relation — `Section(section_id, ...,
room)`.

**Common mistake:** mixing up 2NF and 3NF. 2NF is specifically about a
*composite* key's parts — does a non-key attribute depend on the whole
key or just part of it. It does not apply at all to a relation with a
single-column key, which is where 3NF (below) picks up instead.

---

**Q10. A table `Section(section_id, course_code, course_title, room)` is proposed, with `course_title` copied in directly. Which Week 1 failure does this recreate, and which normal form catches it?**

> **Answer:** **Redundancy and inconsistency** (Week 1's first
> failure). **3NF** catches it: `section_id → course_code →
> course_title` is a transitive dependency.

**Why:** Unlike Q9, `Section` here has a single-column key
(`section_id`), so 2NF is automatically satisfied — there is no
composite key to have a partial dependency on. The problem is
different: `course_title` does not depend on `section_id` directly, it
depends on `course_code`, which itself depends on `section_id`. That
chain — a non-key attribute depending on another non-key attribute,
rather than on the key — is exactly a transitive dependency, and 3NF
is the normal form that forbids it. The fix mirrors Q9's fix in shape:
remove the transitively-dependent attribute and put it where it
depends on a key directly, `Course(course_code, course_title)`, reached
from `Section` only through `course_code`. Any functional dependency
works the same way outside this schema too — a national ID number
determining exactly one legal name, or a barcode determining exactly
one product, is the identical pattern.

**Common mistake:** confusing this with a 2NF violation because both
"feel like" redundancy. The test is what the dependency is *on*: 2NF
asks whether a non-key attribute depends on the whole composite key or
only part of it; 3NF asks whether a non-key attribute depends on
another non-key attribute instead of on the key at all. `room` in Q9
fails on *part of a composite key*; `course_title` here fails on
*another non-key attribute* — different failures, different fixes.

---

## Quick Self-Test

Before the exam, cover the answers above and re-derive each one from
scratch — especially Q4 (Week 1's abstraction levels versus Week 3's
design stages), Q8 (why two different mapping rules agree on
`Enrollment`), and Q9/Q10 back to back (2NF's partial dependency versus
3NF's transitive dependency). Those are the most common sources of
lost points, and in every case the deeper habit worth building is not
memorizing the answer but re-deriving the *reasoning* — the exam tends
to ask you to justify a design choice, not just name the rule.
