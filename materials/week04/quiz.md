# Week 4 Self-Check Quiz (Ungraded)

Database Systems (511783-001). This quiz is **ungraded** — it is only
to help you check what stuck. About 10 minutes. Do not look back at the
slides while you answer.

---

**1.** What is an "entity"?

A. A property that describes something else
B. A real-world thing, distinguishable from every other thing, that a system needs to track
C. A number stating how many rows can relate to how many others
D. A column that has already been declared a `PRIMARY KEY`

**2.** `name` can be split into `first_name` and `last_name` the moment
the system needs to sort by last name alone. What kind of attribute is
that?

A. Key attribute
B. Simple attribute
C. Composite attribute
D. Weak attribute

**3.** One Instructor teaches many Sections; each Section has exactly
one Instructor. What cardinality is that?

A. 1:1
B. 1:N
C. M:N
D. Not stated

**4.** What makes `Enrollment` a weak entity?

A. It has too many attributes to fit on the diagram
B. It has no key attribute of its own; its identity is borrowed from `{student_id, section_id}` together
C. It was added after the rest of the diagram was finished
D. It only appears in Week 6, not Week 4

**5.** Why can't an M:N relationship, like Student to Section, be
represented with a single foreign key on either side?

A. Foreign keys are only allowed on weak entities
B. A single foreign key column can only point to one row, not many, on the other side, in both directions
C. M:N relationships are not allowed in E-R diagrams
D. Cardinality only applies to 1:N relationships

**6.** A designer adds `Room` to the E-R diagram as its own entity,
even though the requirement only says a Section happens "in a specific
room." What is the mistake being made here?

A. Skipping cardinality
B. Treating a weak entity as a strong one
C. Making everything an entity, when `room` is really just an attribute of Section
D. Forgetting to give Room a key attribute

**7.** A Section can have several TAs, and a TA can help with several
Sections. What cardinality is that between Section and TA? In 1
sentence, say what entity would need to exist to represent this
relationship.

`_____________________________________________________________`

**8. (Short answer)** In 1-2 sentences, explain why two designers can
each write a "reasonable" plain-English sentence about the registration
system and still disagree about where the grade lives. Use at least one
key word from this week (entity, attribute, relationship, cardinality,
or weak entity).

`_____________________________________________________________`
`_____________________________________________________________`

---
---

# Answer Key

1. **B** — an entity is a real-world thing, distinguishable from every
   other thing, that a system needs to track
2. **C** — a composite attribute is made of smaller, meaningful parts,
   like `name` splitting into `first_name` and `last_name`
3. **B** — 1:N; one Instructor relates to many Sections, and each of
   those many Sections relates back to exactly one Instructor
4. **B** — a weak entity has no key attribute of its own; Enrollment's
   identity is borrowed from `{student_id, section_id}` together
5. **B** — a single foreign key column can only point to one row on the
   other side, so it cannot represent "many relate to many" in both
   directions at once
6. **C** — this is "making everything an entity": `room` should stay an
   attribute of Section unless the system needs to track rooms
   independently (capacity, building, its own schedule)
7. **Model answer:** "M:N. A weak entity (for example, `Assignment` or
   `TA_Section`) would need to exist to hold the relationship, the same
   way Enrollment holds Student to Section, because M:N cannot be
   represented by a single foreign key on either side."
8. **Model answer:** "Prose hides ambiguity inside grammar — nothing in
   a sentence forces a designer to state the exact cardinality of a
   relationship or say precisely which entity an attribute like grade
   belongs to. An E-R diagram forces both designers to state cardinality
   and attribute ownership explicitly, so the disagreement becomes
   visible instead of hidden."
