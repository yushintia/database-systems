# Week 5 Review Guide: Quiz 1 (Weeks 1-4)

Database Systems (511783-001) — for students to study from before Quiz
1. Same questions as the "Check Yourself" section of the Week 5 slides,
with fuller worked explanations than fit on a slide. Organized by
week. Read the matching week's slides first if a question still feels
unfamiliar.

Quiz format reminder: written, individual, closed book, covering Weeks
1 through 4. The four weeks are one continuous argument (why a DBMS
exists, what a table precisely is, how to design one, how to notate
that design), so if a question feels disconnected from the others,
find where it sits on that chain first.

---

## Week 2: The Relational Model

**Q1. A relation `Student(name, name, major)` lists the `name` attribute twice by mistake. Which rule from Week 2 does this violate, and why?**

> **Answer:** A relation schema is a **set** of attributes; a set
> cannot contain the same element twice. Listing `name` twice is not a
> minor typo, it violates the definition of a relation schema itself.

**Why:** Week 2 borrowed set theory, on purpose, so that "what counts
as a table" would never be up for debate. Two of its consequences are
usually remembered together: no duplicate *tuples* (a relation cannot
contain two identical rows) and no meaningful row *order*. This
question tests the same set-theoretic root one level up, at the
schema itself. A relation schema is a fixed set of attributes, each
drawn from a domain; a set, by definition, cannot list the same
element twice. So `Student(name, name, major)` is not "a table with a
slightly redundant column," it fails to even qualify as a valid
relation schema before a single row of data exists. Compare this with
a plain spreadsheet, where a duplicate column header is confusing but
not technically forbidden, exactly the kind of looseness Week 2 exists
to close.

**Common mistake:** treating this as a cosmetic typo to rename, rather
than recognizing it breaks the formal definition of a relation.
Students also sometimes confuse this with "no duplicate tuples" (a
rule about rows) when this question is actually about duplicate
*attributes* (a rule about columns), both come from the same
set-theoretic root but apply at different levels of the schema.

**Q2. `Instructor(instructor_id, name, office)`. A colleague proposes `{name, office}` as the primary key instead of `instructor_id`. Give one concrete reason this is a worse choice.**

> **Answer:** Two instructors could share an office temporarily, or a
> name could repeat, breaking the key constraint; `instructor_id` is
> system-generated and can never collide, exactly Week 2's warning
> against using a name as a primary key.

**Why:** For `{name, office}` to work as a candidate key, it must
uniquely identify every `Instructor` tuple, not just in today's data,
but for as long as the relation exists. Both halves of that pair can
fail: two instructors can share a name (the same "Kim Minji" problem
Week 2 raises for `Student`), and a new hire can temporarily share an
office before their own is assigned, or two instructors might
informally split one shared office. The moment either happens, the key
constraint (Week 2's Constraint 2: no two tuples may share the same
primary key value) is silently violated and two distinct instructors
become indistinguishable in the data. `instructor_id`, being
system-generated and never typed by hand, has no such failure mode,
its only job is uniqueness, which is exactly why real systems almost
never use a person's name (or any real-world, human-controlled
attribute) as a primary key.

**Common mistake:** judging a candidate key against only the current
sample data ("no two instructors share an office *right now*") instead
of against every future instance of the relation. A key constraint has
to hold forever, not just today.

---

## Week 3: Data Modelling

**Q3. Name one thing conceptual design (Week 3) and an E-R diagram (Week 4) have in common, and one thing that separates them.**

> **Answer:** **Common:** both describe the system before any relation
> exists. **Different:** conceptual design, in prose, is not
> verifiable; an E-R diagram, in Chen's notation, is, that gap is
> exactly Week 4's driving question.

**Why:** Week 3 named three design stages: conceptual (what real-world
things exist and how they relate, in plain terms), logical (a
relational schema), and physical (how it is stored). An E-R diagram
does not add new content to that picture, it lives inside the same
conceptual stage, describing the exact same "what exists" question.
What it adds is notation: labeled entities, relationship lines, and
explicit cardinality numbers, in place of a paragraph. That is why
Week 3 closed by naming its own limit ("prose is not verifiable...
nobody can check it against a rule the way a primary key can be
checked") and Week 4 opened with the same pain restated one level up:
two prose descriptions of the same registration system that quietly
disagree about where the grade lives. Conceptual design without a
diagram can still be *correct* content-wise, but two readers can
interpret the same sentence two different ways; the E-R notation
forces every relationship to state 1:1, 1:N, or M:N explicitly, which
closes exactly that gap.

**Common mistake:** treating Week 3 and Week 4 as two unrelated
topics, rather than the same design stage told twice, once informally
in prose, once formally in a checkable diagram.

**Q4. A physical-level change (new disks) should not affect the view level, according to Week 1. Which Week 2 or Week 3 idea makes that guarantee possible in practice?**

> **Answer:** **Data independence** (Week 2), enforced through the
> three abstraction levels (Week 1) and formalized as separate
> physical and logical design stages (Week 3): the application only
> ever talks to the logical level, never the physical one directly.

**Why:** This question deliberately crosses three weeks, exactly the
kind of question the Week 5 deck warns you to trace back along the
chain rather than answer in isolation. Week 1's three abstraction
levels (physical, logical, view) describe how a *running* system
presents itself, day to day: an application queries the logical level
and never has to know how bytes actually sit on disk. Week 3's three
design stages (conceptual, logical, physical) describe the *one-time
process* of building that same separation in the first place: physical
design decisions, indexes, file organization, are made in their own
stage, deliberately kept apart from the logical schema. Because the
build process keeps physical concerns walled off, swapping disks is
purely a physical-design change; it never has to ripple up into the
logical schema or the view level, which is exactly the guarantee Week
1 promised.

**Common mistake:** confusing Week 1's abstraction levels with Week
3's design stages because they share vocabulary (physical, logical).
The deck is explicit that they "rhyme on purpose": one is an ongoing
running structure, the other is a one-time building process. A quiz
question testing one is not testing the other.

---

## Week 4: E-R Diagram

**Q5. `Course(course_code, title, credits)`. A new requirement says every course must belong to exactly one department, and a department offers many courses. Draw the cardinality between Course and a new Department entity.**

> **Answer:** **N:1** from Course to Department (many courses, one
> department each); equivalently **1:N** from Department to Course.

**Why:** Cardinality is always read as a direction, so the same
relationship gets two valid labels depending on which entity you start
from. "A department offers many courses, and each course belongs to
exactly one department" means: starting from Course, many `Course`
instances all point at a single `Department` instance, that is N:1 (or
M:1). Starting from Department instead, one `Department` instance
relates to many `Course` instances, that is 1:N. Both describe the
same line on the diagram. No weak entity is needed here, unlike
Student-Section's M:N relationship, because a 1:N (or N:1)
relationship maps cleanly onto a single foreign key: `Course` would
gain a `department_code` foreign key column pointing at `Department`,
the exact same shape as `Section N:1 Instructor` in the registration
system's own diagram.

**Common mistake:** flipping which side is "N" and which is "1."
Check yourself by asking the question from each entity's side
separately: "how many Departments does one Course belong to?" (one,
so Course-to-Department is N:1); "how many Courses does one Department
have?" (many, so Department-to-Course is 1:N). Also, skipping
cardinality entirely and just drawing a bare line is the exact mistake
the deck's "Common Quiz Mistakes" slide calls out, always state 1:1,
1:N, or M:N explicitly.

**Q6. Explain, in one sentence, why `Enrollment` is a weak entity rather than a strong entity.**

> **Answer:** It has no key attribute of its own; it can only be
> identified by the combination of `student_id` and `section_id`
> borrowed from Student and Section.

**Why:** A strong entity like `Student` carries its own key attribute,
`student_id`, that identifies it independent of any other entity.
`Enrollment` is different: "enrollment #1" carries no meaning on its
own the way "student #1" does, it only becomes identifiable once you
know *which* student and *which* section it connects. That is the
formal Week 4 definition of a weak entity: no independent key
attribute, identity borrowed from the entities it connects. This
directly previews Week 6's mapping rule, a weak entity maps to a
relation whose primary key is the combination of foreign keys pointing
at the entities it depends on, exactly `{student_id, section_id}` as
`Enrollment`'s composite primary key, the same shape Week 2's worked
example already used.

**Common mistake:** giving `Enrollment` its own independent
`enrollment_id` and treating it as a strong entity. The Week 4 slides
call this out by name: it adds a key with no real-world meaning, when
`{student_id, section_id}` already uniquely identifies the row on its
own.

---

## Quick Self-Test

Before the quiz, try covering the answers above and re-deriving each
one from scratch, especially Q4 (tracing a question across three
different weeks' frameworks instead of answering it in isolation), Q5
(getting the direction of N:1 versus 1:N right), and Q6 (justifying
*why* an entity is weak, not just naming that it is). Those are the
most common sources of lost points.
