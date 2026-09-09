# Lab 06: The Mapping Algorithm

| | |
|---|---|
| **Week** | 6 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Lecture & Lab |
| **Prerequisites** | Lab 04 (your own E-R diagram), Week 6 slides |

**Why this lab matters:** An E-R diagram is a design, not a database.
Every ORM you will ever use (Django's, Hibernate, Prisma) turns a
class definition into tables using the exact same handful of rules
this lab teaches you by hand. Once you can apply them yourself, on
paper, an ORM stops being a black box — it is just running your own
Rules 1 through 4, automatically, on every request.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Concept) | 50 | Lecture: the four mapping rules, worked on the registration case study |
| B (Guided practice) | 50 | Worksheet Part A/B: predict, then confirm, the Waitlist mapping |
| C (Independent and wrap) | 50 | Map your own Lab 4 diagram · self-check against `target_schema.sql` · challenge |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Map a strong entity to a relation (Rule 1).
2. Map a 1:N relationship to a foreign key on the correct side
   (Rule 2).
3. Map a weak entity to a relation with a composite primary key
   (Rule 3).
4. Map an M:N relationship to a new relation with a composite primary
   key (Rule 4), and explain why Rules 3 and 4 agree on `Enrollment`.
5. Apply all four rules, by hand, to your own E-R diagram from Lab 4.

---

## Recap

Lab 4 gave you a precise, checkable E-R diagram: entities,
attributes, relationships, cardinality, all stated explicitly, no
prose ambiguity left. But a diagram is not a database. No DBMS can
run a diagram. Everything you drew still has to become real
relations, with real primary keys and foreign keys — and nothing so
far tells you the exact mechanical steps to get there. That gap is
this lab's entire subject.

---

## Background

### The Mapping Algorithm

> **In plain words: mapping algorithm**
> A mapping algorithm is a fixed recipe: given any E-R diagram, it
> tells you exactly which tables to create and what goes in each one,
> with no guessing. Two people who apply it correctly to the same
> diagram always end up with the identical tables.

The full academic version of this algorithm (Elmasri & Navathe) has
seven steps, covering every construct an E-R diagram can contain.
This course uses the four rules that cover every construct in the
registration system's own diagram — they are the ones that matter for
every lab from here on:

| Rule | Applies to | Result |
|---|---|---|
| **Rule 1** | Strong entity | Becomes its own relation. Attributes and key copy across directly — no design decision |
| **Rule 2** | 1:N relationship | The "1" side's primary key becomes a foreign key on the "N" side. No new relation |
| **Rule 3** | Weak entity | Becomes a relation whose primary key is its own attributes (if any) plus the primary key(s) of the entity/entities it depends on |
| **Rule 4** | M:N relationship | Becomes a brand-new relation, whose primary key is the combined primary keys of both sides |

> **In plain words: deterministic**
> "Deterministic" means the same input always produces the same
> output, no matter who runs it. A recipe that says "add a pinch of
> salt" is not deterministic — two cooks measure "a pinch"
> differently. A recipe that says "add exactly 2 grams of salt" is.
> The mapping algorithm is deterministic on purpose: it removes every
> place a designer could have guessed.

### Rule 1: Strong Entities

A strong entity has its own key attribute and needs no other entity
to identify it. It maps straight across:

```
Student(student_id, name, major)   -- E-R entity
Student(student_id, name, major)   -- relation, identical, PRIMARY KEY (student_id)
```

### Rule 2: 1:N Relationships

The foreign key always goes on the "many" side, never the "one" side.
Instructor (1) teaches Section (N):

```
Section(section_id, ..., instructor_id)
```

`instructor_id` is a foreign key referencing `Instructor.instructor_id`.
A table can carry more than one such foreign key at once — `Section`
also gets `course_code` from Course (1) having Section (N), and the
two foreign keys never conflict, because each answers a different
question.

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 260" style="max-width:520px;display:block;margin:1.5em auto;">
  <title>Diagram showing Rule 2. On the left, an entity box labeled Instructor connects with a line to an entity box labeled Section, with a 1 near Instructor and an N near Section, labeled teaches. An arrow points down from this diagram to a table box labeled Section showing columns section_id as primary key, course_code, and instructor_id, with instructor_id marked as a foreign key referencing Instructor. A caption reads: the foreign key always lands on the many side.</title>
  <defs>
    <marker id="arr-l06" markerWidth="7" markerHeight="7" refX="5" refY="3" orient="auto">
      <path d="M0,0 L0,6 L7,3 z" fill="#0b3d66"/>
    </marker>
  </defs>
  <rect x="20" y="20" width="150" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="95" y="52" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Instructor</text>
  <rect x="390" y="20" width="150" height="55" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="465" y="52" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Section</text>
  <line x1="170" y1="47" x2="390" y2="47" stroke="#333" stroke-width="1.5"/>
  <text x="280" y="40" font-family="sans-serif" font-size="11" fill="#333" text-anchor="middle">teaches</text>
  <text x="180" y="65" font-family="sans-serif" font-size="12" fill="#0b3d66">1</text>
  <text x="370" y="65" font-family="sans-serif" font-size="12" fill="#0b3d66">N</text>
  <line x1="280" y1="90" x2="280" y2="120" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-l06)"/>
  <text x="290" y="110" font-family="sans-serif" font-size="11" fill="#0b3d66">maps to</text>
  <rect x="140" y="130" width="280" height="90" rx="6" fill="#fff8e6" stroke="#c07000" stroke-width="2"/>
  <text x="280" y="150" font-family="sans-serif" font-size="12" font-weight="bold" fill="#c07000" text-anchor="middle">Section (relation)</text>
  <text x="160" y="172" font-family="monospace" font-size="11" fill="#333">section_id  (PK)</text>
  <text x="160" y="190" font-family="monospace" font-size="11" fill="#333">course_code</text>
  <text x="160" y="208" font-family="monospace" font-size="11" fill="#b23b00" font-weight="bold">instructor_id  (FK &rarr; Instructor)</text>
  <text x="280" y="245" font-family="sans-serif" font-size="11" fill="#555" text-anchor="middle">The foreign key always lands on the "many" side.</text>
</svg>

### Rule 3: Weak Entities

A weak entity cannot be uniquely identified by its own attributes
alone. `Enrollment` depends on both `Student` and `Section`:

```
Enrollment(student_id, section_id, grade)
PRIMARY KEY (student_id, section_id)
```

`student_id` and `section_id` are each simultaneously part of the
composite primary key **and** a foreign key back to the entity they
came from.

### Rule 4: M:N Relationships

An M:N relationship needs a brand-new relation — a single foreign key
on either side cannot represent "many relate to many" in both
directions at once:

```
Enrollment(student_id, section_id, grade)
PRIMARY KEY (student_id, section_id)
```

> **In plain words: why Rule 3 and Rule 4 land on the same table**
> `Enrollment` is not a coincidence of two different rules agreeing.
> A weak entity that depends on two owning entities, and the M:N
> relationship between those same two entities, are two descriptions
> of one real-world fact. Whenever an M:N relationship is drawn using
> a weak entity (Week 4 always does this), Rules 3 and 4 must agree —
> if your two mappings disagree, one of them has a mistake in it.

### What the Algorithm Does Not Guarantee

Every rule above is deterministic. Applied correctly, two different
people produce the identical schema from the identical diagram — that
closes this week's pain slide by design. But a mechanically correct
schema is not automatically a *good* one. If `Section` stored
`instructor_name` directly instead of just `instructor_id`, every
rule above would still be followed correctly, and the schema would
still be "valid" by this week's standard — yet an instructor's name
change would need updating in every one of their sections. The
mapping algorithm guarantees a valid schema. It does not guarantee an
anomaly-free one. That question is Lab 07's entire subject.

---

## Worked Example: Mapping the Waitlist

The registration system is adding a `Waitlist` feature: a student can
be waitlisted for a full section. `Waitlist` is a weak entity,
depending on both `Student` and `Section`, with its own attributes
`position` and `date_joined`. It is *also* M:N between `Student` and
`Section` — a student can be waitlisted for many sections, and a
section can have many students waiting.

**Step 1: Identify the shape.** Both Rule 3 (weak entity) and Rule 4
(M:N relationship) apply, exactly the way they both applied to
`Enrollment`.

**Step 2: Apply Rule 3.** A weak entity's primary key is its own
attributes combined with the primary key of what it depends on:

```
Waitlist(student_id, section_id, position, date_joined)
```

**Step 3: Apply Rule 4, and confirm.** Rule 4 independently says: new
relation, composite key of both sides. Student M:N Section produces:

```
Waitlist(student_id, section_id, position, date_joined)
```

Identical to Step 2. Not a coincidence — see the "In plain words" box
above.

**Step 4: Declare the primary key.** Writing the relation is not
enough without stating what makes each row unique:

```sql
Waitlist(student_id, section_id, position, date_joined)
PRIMARY KEY (student_id, section_id)
```

This composite key enforces the real rule: one student can be on one
waitlist per section, never twice. Without it, nothing stops the same
`{student_id, section_id}` pair from appearing in two rows.

| Line | What it does |
|---|---|
| `student_id, section_id` | Borrowed from `Student` and `Section` — this is what makes `Waitlist` a *weak* entity: it has no identity of its own |
| `position, date_joined` | `Waitlist`'s own attributes, describing the fact itself, not either owning entity |
| `PRIMARY KEY (student_id, section_id)` | Declares the composite key. Neither column alone is unique: the same student can wait on many sections, and the same section can have many students waiting |

---

## Guided Exercises

Work through Part A and Part B in order — Part A asks you to predict
before you see the answer, matching how this ran in lecture.

### Part A: Predict (about 15 minutes)

**A1.** `Student` is a strong entity: `Student(student_id, name,
major)`. Apply Rule 1. Write the resulting relation and its primary
key.

**A2.** `Instructor` (1) teaches `Section` (N). Which relation gets a
foreign key, what is it called, and which rule tells you that?

**A3.** `Waitlist` is a weak entity that depends on both `Student` and
`Section`, with its own attributes `position` and `date_joined`.
Apply Rule 3. Write `Waitlist`'s primary key.

**A4. Prediction:** will applying Rule 3 (your A3 answer) and Rule 4
(M:N relationship) to `Waitlist` produce the exact same relation?
Write your guess and your reasoning before moving on.

**A5.** What is one thing about mapping weak entities or M:N
relationships that you are still not sure about?

### Part B: Confirm and Apply (about 15 minutes)

**B1.** Was your Part A prediction (A4) correct? (It should have
matched the Worked Example above: yes, they agree.)

**B2.** Using the words **composite key** and **foreign key**,
explain in 1-2 sentences why `Waitlist` needs `(student_id,
section_id)` as its primary key instead of a single `waitlist_id`.

**B3.** Write `Waitlist`'s full relation, including the `PRIMARY KEY`
declaration, exactly as it would appear in the derived schema.

**B4.** A `Department` (1) offers many `Course` (N). Which relation
gets the foreign key, what is it called, and by which rule?

**B5 (stretch, optional).** Suppose the registration system added:
each `Student` has exactly one, optional `Advisor`, and each
`Advisor` advises exactly one `Student`. Which rule would map this
relationship, and which side would most naturally hold the foreign
key? (This is Rule 5, 1:1 relationships — not one of the four core
rules above, since the registration system never needs it, but it's
worth reasoning through once.)

### Part C: Map Your Own Diagram (the graded deliverable)

Take your own E-R diagram from **Lab 4** (your own entities,
attributes, relationships, and cardinality — not the registration
system's). Apply Rules 1 through 4 to every entity and relationship
on it, by hand, on paper or in a text file. For each one, write:

1. The entity or relationship you are mapping.
2. Which rule applies (state the rule number).
3. The resulting relation, with its primary key (and foreign keys,
   where relevant) written out.

Then, **self-check your understanding of the rules** (not your own
diagram, which is unique to you) against
`book/src/labs/files/lab06/target_schema.sql` — the same four rules,
applied to the *registration system's* Week 4 diagram. If your own
mapping of, say, a 1:N relationship does not resemble how
`target_schema.sql` handles `Course`-`Section`, re-read Rule 2 before
submitting.

> **In plain words: why you get to see the answer for a different diagram**
> `target_schema.sql` is not your diagram's answer key — it's a
> worked reference for a *different* diagram (the registration
> system's), so you can check whether you're applying the rules
> correctly without it ever telling you what your own diagram's
> answer is. Comparing your rule *application* against a known-correct
> example is normal engineering practice, not a shortcut.

**Deliverable:** `lab06_mapping.md`, containing your Part C mapping
(every entity/relationship from your own Lab 4 diagram, the rule
applied, and the resulting relation).

---

## Challenge Problem

Your Lab 4 diagram may have included a multivalued attribute, a
composite attribute, or a specialization hierarchy (a superclass with
subclasses) — constructs beyond the four core rules. Pick **one**
such construct from your own diagram (or, if your diagram has none,
invent a small, realistic one — e.g., a `Student` with more than one
`phone_number`). Using the Week 6 slides' Rules 6-10 as reference,
map it to a relation (or new relation) and explain, in 1-2 sentences,
why the mapping algorithm forbids storing it as a single column
instead.

Add this to `lab06_mapping.md` as a final section, "Challenge:
Beyond the Four Rules."

---

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** `Course` is a strong entity: `Course(course_code,
title, credits)`. Apply Rule 1.

**Practice 2.** `Department` (1) offers many `Course` (N). Which
relation gets a foreign key, and what is it called?

**Practice 3.** A `Library` system has `Book` (strong), `Member`
(strong), and `Loan` (weak, depending on both, with attribute
`due_date`). Apply Rules 1 and 3. Write every resulting relation.

**Practice 4.** A `TA` entity can help with many `Section`s, and a
`Section` can have many `TA`s. Which rule applies, and what relation
does it produce?

**Practice 5.** A ride-hailing app has `Driver` (strong) and `Ride`
(weak, depending on both `Driver` and `Rider`). `Driver` is 1:N with
`Ride`. Which relation gets the foreign key for `driver_id`, and by
which rule?

**Practice 6.** A team maps a 1:N relationship by giving the "one"
side a list-type column of the "many" side's IDs, instead of a
foreign key on the "many" side. Which rule does this violate, and
what is the correct fix?

**Practice 7.** `Vehicle` (strong) is M:N with `Route` (strong), via a
new relationship `Assignment`, with its own attribute
`assigned_date`. Apply Rule 4. Write the resulting relation, with its
primary key.

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Adding a join table for a 1:N relationship | An extra, unnecessary relation with no attributes of its own | Only M:N relationships need a new relation; 1:N is a single foreign key, no exceptions |
| Forgetting the composite primary key on a resolved M:N relationship | The same pair (e.g. student + section) can be inserted twice with no error | Always declare `PRIMARY KEY` on **both** columns together, not on either alone |
| Putting the foreign key on the "one" side of a 1:N relationship | `Instructor` gets a `section_id` column, or a list of them | The foreign key always goes on the "many" side — re-read Rule 2 |
| Giving a weak entity its own surrogate key (e.g. `enrollment_id`) | The relation "works" but the composite key constraint is missing | A weak entity's key is borrowed from what it depends on, not invented |
| Confusing "Rules 3 and 4 agree" with "you only need to apply one of them" | Skipping a check that would have caught a mapping mistake | Apply both when they both apply — if they disagree, one has an error |

---

## Submission and Rubric

| Deliverable | Filename | Points |
|-------------|----------|--------|
| Worksheet Part A/B (in-class) | (submitted in class, not a file) | 2 |
| Own-diagram mapping (Part C) | `lab06_mapping.md` | 6 |
| Challenge: beyond the four rules | included in `lab06_mapping.md` | 2 |

**Total: 10 points**

---

## Further Reading

- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th
  ed., Ch. 7.
- [The full Week 6 lecture slides](../../slides/week06-mapping-algorithm.html) — including
  Rules 5-10 for constructs beyond this lab's four core rules.
