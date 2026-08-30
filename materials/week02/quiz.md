# Week 2 Self-Check Quiz (Ungraded)

Database Systems (511783-001). This quiz is **ungraded** — it is only
to help you check what stuck. About 10 minutes. Do not look back at
the slides while you answer.

---

**1.** What is a relation, formally?

A. A named group of related files
B. A set of tuples, all conforming to the same relation schema
C. Any spreadsheet with rows and columns
D. A list of related keys

**2.** What is the difference between a relation schema and a relation
instance?

A. A schema is the data; an instance is the structure
B. A schema is the fixed shape (name and attributes); an instance is
   the actual set of tuples right now
C. They are the same thing, just different words
D. An instance defines the domains; a schema defines the rows

**3.** Which of these best describes a **candidate key**?

A. Any set of attributes that uniquely identifies each tuple, even
   with extra unnecessary attributes
B. A superkey with no unnecessary attributes — remove any one
   attribute and it stops being unique
C. The specific candidate key the designer chooses as the main
   identifier
D. An attribute that must match the primary key of another relation

**4.** In `Enrollment(student_id, course_code, grade)`, `student_id` is
a foreign key referencing `Student.student_id`. What must be true for
referential integrity to hold?

A. `student_id` must be unique within `Enrollment`
B. Every `student_id` value in `Enrollment` must match an existing
   `student_id` in `Student`, or be left empty
C. `student_id` values must be listed in alphabetical order
D. `grade` must never be empty

**5.** A `grade` column's domain is defined as "A0 through F only." A
row stores the value "A99." Which constraint does this violate?

A. Key constraint
B. Referential integrity constraint
C. Domain constraint
D. Superkey constraint

**6.** Why can a relation never contain two identical tuples?

A. Spreadsheets do not allow it either
B. A relation is defined as a set, and a set cannot contain the same
   element twice
C. It would violate the domain constraint
D. Primary keys are always text, and text cannot repeat

**7.** `Instructor(instructor_id, name, office)`. Is `{instructor_id}`
a candidate key, a superkey, both, or neither? Explain in one
sentence.

`_____________________________________________________________`

**8. (Short answer)** Two designers each independently sketch a
`Student` table for the registration system. One puts `grade` in it;
the other does not. Both designs follow every rule from this week
perfectly. In 1-2 sentences, using at least one key word from this
week (relation, relation schema, primary key, or constraint), explain
why the rules alone cannot tell us which design is correct.

`_____________________________________________________________`
`_____________________________________________________________`
