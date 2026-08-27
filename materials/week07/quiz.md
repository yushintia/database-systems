# Week 7 Self-Check Quiz (Ungraded)

Database Systems (511783-001). This quiz is **ungraded** — it is only
to help you check what stuck. About 10 minutes. Do not look back at
the slides while you answer.

---

**1.** What is a functional dependency, A → B?

A. A always has more rows than B
B. For every possible instance, one value of A always determines
   exactly one value of B
C. A and B must always be the same data type
D. B must be listed before A in the relation

**2.** What does 1NF require?

A. Every non-key attribute depends on the whole primary key
B. No non-key attribute depends on another non-key attribute
C. Every attribute holds a single, atomic value — no repeating groups
D. Every relation must have a composite key

**3.** A relation has a composite primary key `{A, B}`, and a non-key
attribute `C` depends only on `A`, not on the whole key. What is this
called, and which normal form does it violate?

A. A transitive dependency; violates 3NF
B. A partial dependency; violates 2NF
C. A repeating group; violates 1NF
D. A superkey; violates BCNF

**4.** What is a transitive dependency?

A. When A depends on B, and B also depends on A
B. When a non-key attribute depends on another non-key attribute,
   instead of depending on the key directly
C. When the same value repeats across multiple rows
D. When a relation has more than one candidate key

**5.** `Section(section_id, instructor_id, instructor_name, ...)`
copies `instructor_name` into every section a professor teaches. She
changes her legal name, and every one of her sections must be updated
by hand. What is this called?

A. Deletion anomaly
B. Insertion anomaly
C. Update anomaly
D. Domain violation

**6.** Who defined the normal forms, and roughly when?

A. Edgar F. Codd, in a series of papers from 1971-1974
B. Peter Chen, in 1976
C. A committee at IBM, in the 1990s
D. Codd, in the same 1970 paper that introduced the relational model

**7.** `Loan(isbn, member_id, book_title, due_date)`, `PRIMARY KEY
(isbn, member_id)`. `book_title` depends on `isbn` alone. Which normal
form does this violate, and why?

`_____________________________________________________________`

**8. (Short answer)** In 1-2 sentences, explain why decomposition must
be **lossless**. Use at least one key word from this week (decomposition,
functional dependency, or join).

`_____________________________________________________________`
`_____________________________________________________________`

---
---

# Answer Key

1. **B** — for every possible instance, one value of A always
   determines exactly one value of B
2. **C** — 1NF requires every attribute to hold a single, atomic value,
   with no repeating groups or lists inside a cell
3. **B** — a non-key attribute depending on only part of a composite
   key is a partial dependency, and it violates 2NF
4. **B** — a transitive dependency is a non-key attribute depending on
   another non-key attribute, instead of depending on the key directly
5. **C** — an update anomaly: one real-world fact needs updating in
   many places instead of one
6. **A** — Edgar F. Codd, in a series of papers from 1971 to 1974,
   following up his 1970 relational model paper
7. **2NF violation.** `book_title` depends only on `isbn`, not on the
   full composite key `{isbn, member_id}` — a partial dependency. The
   fix is to move `book_title` into its own `Book(isbn, title)`
   relation.
8. **Model answer:** "Decomposition must be lossless because every
   original row has to be reconstructable by joining the new relations
   back together. If a split loses that ability, the database can no
   longer answer questions the original table could, which is worse
   than the anomaly the decomposition was meant to fix."
