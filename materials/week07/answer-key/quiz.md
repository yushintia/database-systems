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
