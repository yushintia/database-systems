# Lab 08 Answer Key: Midterm Review Self-Test (Weeks 6-7)

Consolidated from `materials/week06/answer-key/quiz.md` and
`materials/week07/answer-key/quiz.md`, answering the multiple-choice
portion of the Week 8 review. For the six worked, open-ended sample
practice problems on `book/src/labs/lab08-midterm-review.md`, see the
full explanations in `materials/week08/review-guide.md` (that guide
already includes the answer alongside each question).

---

## Week 6: Mapping Algorithm

1. **B** — the mapping algorithm is a deterministic set of rules that
   turns an E-R diagram into relations, attributes, and keys, with no
   guessing.
2. **B** — a strong entity becomes its own relation directly; its
   attributes and key copy across with no design decision.
3. **B** — the foreign key always goes on the "many" side of a 1:N
   relationship, never the "one" side.
4. **B** — a weak entity's primary key is its own key attributes (if
   any) combined with the primary key of the entity it depends on.
5. **C** — an M:N relationship produces a brand-new relation, with a
   composite primary key made of both sides' primary keys.
6. **B** — Instructor teaches Section is 1:N, and Rule 2 says the
   foreign key belongs on the "many" side (`Section`), never as a
   list-type column on the "one" side.

## Week 7: Normalization

1. **B** — for every possible instance, one value of A always
   determines exactly one value of B.
2. **C** — 1NF requires every attribute to hold a single, atomic
   value, with no repeating groups or lists inside a cell.
3. **B** — a non-key attribute depending on only part of a composite
   key is a partial dependency, and it violates 2NF.
4. **B** — a transitive dependency is a non-key attribute depending
   on another non-key attribute, instead of depending on the key
   directly.
5. **C** — an update anomaly: one real-world fact needs updating in
   many places instead of one.
6. **A** — Edgar F. Codd, in a series of papers from 1971 to 1974,
   following up his 1970 relational model paper.

---

## Study Tip

The midterm draws on Weeks 1 through 7 as one chain, not seven
independent glossaries. If a self-test question above felt
disconnected, re-read `materials/week08/review-guide.md`'s
introduction — it names exactly which chain each week's ideas sit on,
and the six fully-worked sample questions there are the best model
for how the actual midterm phrases an "apply this rule" question.
