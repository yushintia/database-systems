# Answer Key

1. **B** — a relation is a set of tuples, all conforming to the same
   relation schema
2. **B** — a schema is the fixed shape (name and attributes); an
   instance is the actual set of tuples at a given moment
3. **B** — a candidate key is a superkey with no unnecessary
   attributes; remove any one attribute and it stops being unique
4. **B** — every foreign key value must match an existing primary key
   value in the referenced relation, or be left empty
5. **C** — "A99" is not a legal value in the declared domain "A0
   through F," so this is a domain constraint violation
6. **B** — a relation is defined as a set, and a set cannot contain
   the same element (tuple) twice
7. **Both.** `{instructor_id}` uniquely identifies each instructor (so
   it is a superkey) and has no unnecessary attributes to remove (so
   it is also a candidate key). A relation's primary key is always
   both.
8. **Model answer:** "The rules we learned this week — relation
   schema, domain, key constraint, and so on — only say what a valid
   relation must look like and obey. They never say *which* facts
   belong in which relation, so both designs can satisfy every
   constraint and still disagree about whether `grade` belongs in
   `Student`."
