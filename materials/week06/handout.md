# Week 6 Handout: Mapping Algorithm

Database Systems (511783-001) — for students to keep and read again.
Use plain, simple English on purpose, so it is easy to read even if
English is not your first language.

---

## 1. Glossary: Key Words This Week

Read each definition once now. You do not need to memorize them today —
you will use them all semester.

| Term | Plain definition |
|---|---|
| **Mapping algorithm** | A deterministic set of rules that turns every entity and relationship on an E-R diagram into relations, attributes, and keys, with no design decisions left to guesswork |
| **Deterministic** | Always producing the same result, no matter who applies the rule. Two people following it correctly get identical output |
| **Relation** | The formal name for a table: rows and columns with a name and a set of attributes |
| **Strong entity** | An entity that can stand on its own, with its own key attribute. Maps directly to a relation (Rule 1) |
| **Weak entity** | An entity that cannot be uniquely identified by its own attributes alone; it depends on another entity for part of its identity |
| **Primary key** | The attribute, or set of attributes, that uniquely identifies each row in a relation |
| **Composite key** | A primary key made of two or more attributes together, not just one |
| **Foreign key** | An attribute in one relation that refers to the primary key of another relation, linking the two |
| **1:1 relationship** | A relationship where one instance of an entity connects to exactly one instance of another (Rule 5) |
| **1:N relationship** | A relationship where one instance of an entity connects to many instances of another. Mapped with a single foreign key on the "many" side (Rule 2) |
| **M:N relationship** | A relationship where many instances of one entity connect to many instances of another. Mapped with a brand-new relation (Rule 4) |
| **Resolution table** | The new relation created to resolve an M:N relationship. Its primary key is the combined primary keys of both sides |
| **Cardinality** | The label on a relationship (1:1, 1:N, or M:N) that says how many instances on each side can connect |
| **ORM (Object-Relational Mapper)** | A real tool (Django ORM, Hibernate, Prisma) that automates this week's mapping rules in code, so a developer rarely applies them by hand |
| **Schema** | The complete set of relations, attributes, and keys that describes a database's structure |

---

## 2. University Course Registration System, Worked Out Step by Step

This is the full version of the story from class. Read it slowly if the
in-class pace felt fast.

**The situation.** Three teams are handed the exact same E-R diagram
from Week 4, the registration system, and asked to produce relational
tables. All three teams understand the diagram correctly. All three
produce different tables anyway. One team gives `Section` a foreign key
to `Instructor`. Another gives `Instructor` a list-type column of
section IDs, because their tool allows it. A third invents a separate
join table for `Section` and `Instructor`, even though that
relationship is 1:N, not M:N, so it never needed one. The diagram was
unambiguous. The translation into tables was not, because nobody wrote
down the rules for doing it. This week writes those rules down, and
applies them to `Waitlist`, the entity Week 4 introduced but never
mapped.

**Step 1: Identify the shape.** `Waitlist` is a weak entity, and it is
also M:N between `Student` and `Section` — a student can be waitlisted
for many sections, and a section can have many students waiting. Both
Rule 3 (weak entity) and Rule 4 (M:N relationship) apply here, exactly
the way they both applied to `Enrollment` earlier in the lecture.

**Step 2: Apply Rule 3, the weak-entity rule.** A weak entity becomes a
relation whose primary key is its own key attributes, if it has any,
combined with the primary key of the entity or entities it depends on.
`Waitlist` depends on both `Student` and `Section`, so it inherits both
of their primary keys, plus its own attributes:

```
Waitlist(student_id, section_id, position, date_joined)
```

**Step 3: Apply Rule 4, the M:N rule, and confirm.** Separately, Rule 4
says: for an M:N relationship, create a new relation containing the
primary keys of both sides as a composite key. Applied to Student M:N
Section, the result is the identical relation Step 2 already produced.
This is not a coincidence — `Waitlist` being a weak entity and
`Waitlist` being the resolution of an M:N relationship describe the
exact same real-world fact from two different angles. The two rules
have to agree, because they are describing one thing.

**Step 4: Declare the primary key.** Writing the relation is not enough
without stating what makes each row unique:

```
Waitlist(student_id, section_id, position, date_joined)
PRIMARY KEY (student_id, section_id)
```

This composite key enforces the real rule: one student can be on one
waitlist per section, never twice. Without it, nothing would stop the
same `{student_id, section_id}` pair from appearing in two rows.

**What we still can't say yet.** Every rule this week is deterministic
— applied correctly, two different people produce the identical schema
from the identical diagram, which is exactly the pain slide's problem,
closed by design. But a mechanically correct schema is not automatically
a *good* one. If `Section` stored `instructor_name` directly instead of
just `instructor_id`, every rule above would still be followed
correctly, and the schema would still be "valid" by this week's
standard — yet an instructor's name change would need updating in every
one of their sections. The mapping algorithm guarantees a valid schema.
It does not guarantee an anomaly-free one. That question, and a formal
way to test for it, is Week 7's entire subject.

---

## 3. Optional Reading: Extra Detail (Not Required, Not on the Quiz)

This section holds extra explanations that were trimmed from the slides
to keep class time short. Read it if you are curious or want more
examples.

**Why this got formalized at all.** Once E-R diagrams became standard
(Week 4's 1976 paper), database theorists noticed that experienced
designers were already translating diagrams to relations the same
handful of ways, every time, without writing it down anywhere. What had
been "the way experienced designers naturally did it" got turned into
an explicit, teachable algorithm, exactly so a beginner and an expert
would produce the same schema from the same diagram — not just usually,
but always.

**Why the diagram alone was never really "the source of truth."**
Three different, equally "valid-looking" translations of one diagram
means whoever did the mapping was the real source of truth, not the
diagram itself. That is a problem on a team: inconsistent translation
choices compound over time, so schemas that should be reusable design
patterns become one-off guesses instead. It shows up worst on M:N
relationships specifically — a junior engineer who has to guess how to
translate a diagram will guess wrong on exactly the cases that matter
most.

**Real tools that automate this today.** Django ORM maps Python classes
to tables using these exact rules. Hibernate, Java's ORM, uses the same
1:N and M:N mapping logic. Prisma maps a schema file to SQL
automatically, the same way. Every one of these tools implements Rules
1 through 5 in code, so a developer almost never has to apply them by
hand — this lecture teaches you what they are doing underneath, once,
by hand, so the automation stops being a black box.

**Who uses this as a job.**

- **Backend / application developers** rely on an ORM to apply these
  rules every day without thinking about them directly, but debugging a
  wrong schema means understanding the rules underneath
- **Database engineers and architects** apply this mapping by hand when
  designing schemas an ORM will not touch, or when reviewing whether an
  ORM's automatic mapping is actually correct for a given system
- **ORM and schema-tool maintainers** are the people who write the code
  implementing Rules 1 through 5 for everyone else to use
- **Data modelers** work one level up, on the E-R diagram itself, but
  need to know how their diagram will be mapped so they do not design
  something ambiguous

---

## 4. Practice Problems (With Answers)

Try each problem yourself before checking the answer underneath it.

**Problem 1.** `Instructor` is a strong entity: `Instructor(instructor_id,
name)`. Apply Rule 1. What is the resulting relation?
> **Answer:** `Instructor(instructor_id, name)`, with `instructor_id`
> as the primary key. A strong entity's attributes and key copy
> directly across; there is no design decision to make.

**Problem 2.** `Course` (1) has `Section` (N). Which relation gets a
foreign key, what is it called, and by which rule?
> **Answer:** `Section` gets the foreign key, `course_code`,
> referencing `Course.course_code`, by **Rule 2**. The foreign key
> always goes on the "many" side, never the "one" side.

**Problem 3.** `Enrollment` is weak, depending on both `Student` and
`Section`, with its own attribute `grade`. Apply Rule 3. What is
`Enrollment`'s primary key?
> **Answer:** The composite key `(student_id, section_id)` — the
> primary keys of both entities it depends on. `Enrollment(student_id,
> section_id, grade)`, `PRIMARY KEY (student_id, section_id)`.

**Problem 4.** Student is M:N with Section, resolved through
`Enrollment`. Apply Rule 4. How does the result compare to Problem 3?
> **Answer:** Rule 4 independently produces the same relation:
> `Enrollment(student_id, section_id, grade)`, composite key of both
> sides. It matches Problem 3 exactly, because a weak entity and the
> relation that resolves its M:N relationship are two descriptions of
> the same real-world fact.

**Problem 5.** A `TA` entity can help with many `Section`s, and a
`Section` can have many `TA`s. Which rule applies, and what relation
does it produce?
> **Answer:** **Rule 4** (M:N). It produces a new relation,
> `TA_Section(ta_id, section_id)`, with `PRIMARY KEY (ta_id,
> section_id)` — the same shape as `Enrollment` and `Waitlist`.

**Problem 6.** A team gives `Instructor` a list-type column holding all
of that instructor's section IDs, instead of putting a foreign key on
`Section`. What is wrong with this, and what is the correct fix?
> **Answer:** Instructor teaches Section is a 1:N relationship, and
> Rule 2 says the foreign key always goes on the "many" side —
> `Section`, not `Instructor`. The correct fix is a single
> `instructor_id` column on `Section`, referencing
> `Instructor.instructor_id`. A list-type column on the "one" side
> is exactly the mistake the Week 6 pain slide describes.
