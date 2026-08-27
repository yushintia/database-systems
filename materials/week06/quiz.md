# Week 6 Self-Check Quiz (Ungraded)

Database Systems (511783-001). This quiz is **ungraded** — it is only
to help you check what stuck. About 10 minutes. Do not look back at the
slides while you answer.

---

**1.** What does the mapping algorithm do?

A. It converts SQL queries into E-R diagrams
B. It is a deterministic set of rules that turns an E-R diagram into relations, attributes, and keys
C. It normalizes a relational schema to remove redundancy
D. It generates random test data for a database

**2.** Under Rule 1, what happens to a strong entity?

A. It is dropped, only its relationships matter
B. It becomes its own relation; its attributes and key copy directly across
C. It becomes a foreign key on another relation
D. It is combined with every entity it relates to into one big table

**3.** For a 1:N relationship, where does Rule 2 say the foreign key goes?

A. On the "one" side
B. On the "many" side
C. On whichever side is alphabetically first
D. On both sides at once

**4.** What does Rule 3 say a weak entity's primary key should be?

A. Just a new, auto-generated ID
B. The weak entity's own key attributes combined with the primary key of the entity it depends on
C. Always exactly one attribute, never a composite
D. The same primary key as the strong entity closest to it in the diagram

**5.** For an M:N relationship, what does Rule 4 produce?

A. A single foreign key added to one of the two entities
B. Nothing — M:N relationships require no additional relation
C. A new relation containing the primary keys of both sides as a composite key
D. Two separate one-to-many relations

**6.** Why is giving `Instructor` a list-type column of section IDs, instead of a foreign key on `Section`, considered a mistake?

A. List-type columns are always slower than foreign keys
B. Instructor teaches Section is 1:N, and Rule 2 always puts the foreign key on the "many" side
C. `Instructor` should never have any columns besides its key
D. It is not a mistake — either approach is equally correct

**7.** `Department` (1) offers many `Course` (N). Which relation gets a foreign key, what is it called, and which rule applies?

`_____________________________________________________________`

**8. (Short answer)** In 1-2 sentences, explain why `Enrollment`'s
relation, resolving Student M:N Section, comes out identical whether
you apply Rule 3 (treating `Enrollment` as a weak entity) or Rule 4
(treating it as an M:N relationship). Use at least one key word from
this week (weak entity, composite key, or resolution table).

`_____________________________________________________________`
`_____________________________________________________________`

---
---

# Answer Key

1. **B** — the mapping algorithm is a deterministic set of rules that turns an E-R diagram into relations, attributes, and keys, with no guessing
2. **B** — a strong entity becomes its own relation directly, its attributes and key attribute copy across with no design decision
3. **B** — the foreign key always goes on the "many" side of a 1:N relationship, never the "one" side
4. **B** — a weak entity's primary key is its own key attributes (if any) combined with the primary key of the entity it depends on
5. **C** — an M:N relationship produces a brand-new relation, with a composite primary key made of both sides' primary keys
6. **B** — Instructor teaches Section is 1:N, and Rule 2 says the foreign key belongs on the "many" side (`Section`), never as a list-type column on the "one" side
7. `Course` gets the foreign key `department_id`, referencing `Department.department_id`, by Rule 2 (1:N: foreign key on the "many" side)
8. **Model answer:** "`Enrollment` being a weak entity and `Enrollment` resolving an M:N relationship describe the same real-world fact two ways, so the two rules must agree. Both produce the composite key `(student_id, section_id)`, because that pair is exactly what makes the resolution table's rows unique."
