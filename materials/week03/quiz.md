# Week 3 Self-Check Quiz (Ungraded)

Database Systems (511783-001). This quiz is **ungraded** — it is only
to help you check what stuck. About 10 minutes. Do not look back at the
slides while you answer.

---

**1.** What is "data modeling"?

A. Writing `CREATE TABLE` statements for every relation
B. The process of analyzing real-world requirements and expressing them as a structured description of the data, before any table is created
C. A synonym for "the relational model"
D. The step where indexes are added to speed up queries

**2.** Put the three design stages in the correct order.

A. Physical, Logical, Conceptual
B. Logical, Conceptual, Physical
C. Conceptual, Logical, Physical
D. Conceptual, Physical, Logical

**3.** What does conceptual design focus on?

A. Choosing indexes and file organization
B. Writing relations with attributes, keys, and constraints
C. Identifying the real-world things a system must track, and how they relate, with no table names yet
D. Tuning query performance on a live system

**4.** What does logical design produce, in this course's terms?

A. A prose description of real-world things and facts
B. Relations with attributes, keys, and constraints
C. A decision about which indexes to build
D. A finished, running database

**5.** Which "good design" test does this describe: "No fact is
captured in two places by design"?

A. Completeness
B. Correctness
C. Minimal redundancy
D. Understandability

**6.** How are Week 1's abstraction levels different from this week's
design stages?

A. They are exactly the same three ideas, just renamed
B. Abstraction levels describe an already-running system's ongoing structure; design stages describe the one-time process of building it
C. Abstraction levels only apply to physical storage, design stages only apply to logical schemas
D. There is no relationship between the two at all

**7.** A design combines student and enrollment data into one
relation, so a student's major is copied into every enrollment row.
Which of the four "good design" tests does this fail, and why?

`_____________________________________________________________`

**8. (Short answer)** In 1-2 sentences, explain why a design that
follows every one of Week 2's rules can still be a bad design. Use at
least one key word from this week (requirements, conceptual design, or
one of the four tests).

`_____________________________________________________________`
`_____________________________________________________________`

---
---

# Answer Key

1. **B** — data modeling is the process of analyzing real-world
   requirements and expressing them as a structured description of the
   data, before any table is created
2. **C** — Conceptual, then Logical, then Physical, in that order
3. **C** — conceptual design identifies the real-world things a system
   must track, and how they relate, with no table names or data types
   yet
4. **B** — logical design translates the conceptual model into a
   specific data model's structures: relations with attributes, keys,
   and constraints
5. **C** — minimal redundancy means no fact is captured in two places
   by design
6. **B** — abstraction levels describe an already-running system's
   ongoing structure, every day; design stages describe the one-time
   process of building that system in the first place
7. **Minimal redundancy.** Copying the student's major into every
   enrollment row stores the same fact in two places by design, exactly
   what Test 3 exists to catch
8. **Model answer:** "Week 2's rules only check that each relation is
   internally valid, not whether the design captured the right
   requirements in the right shape. A design can have a perfect
   primary key and still fail conceptual design's tests, like
   completeness or minimal redundancy."
