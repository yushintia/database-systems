# Answer Key

1. **B** — the mapping algorithm is a deterministic set of rules that turns an E-R diagram into relations, attributes, and keys, with no guessing
2. **B** — a strong entity becomes its own relation directly, its attributes and key attribute copy across with no design decision
3. **B** — the foreign key always goes on the "many" side of a 1:N relationship, never the "one" side
4. **B** — a weak entity's primary key is its own key attributes (if any) combined with the primary key of the entity it depends on
5. **C** — an M:N relationship produces a brand-new relation, with a composite primary key made of both sides' primary keys
6. **B** — Instructor teaches Section is 1:N, and Rule 2 says the foreign key belongs on the "many" side (`Section`), never as a list-type column on the "one" side
7. `Course` gets the foreign key `department_id`, referencing `Department.department_id`, by Rule 2 (1:N: foreign key on the "many" side)
8. **Model answer:** "`Enrollment` being a weak entity and `Enrollment` resolving an M:N relationship describe the same real-world fact two ways, so the two rules must agree. Both produce the composite key `(student_id, section_id)`, because that pair is exactly what makes the resolution table's rows unique."
