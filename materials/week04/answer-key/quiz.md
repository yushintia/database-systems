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
