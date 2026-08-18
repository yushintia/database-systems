# Week 1 Self-Check Quiz — Introduction to Database Systems

Database Systems (511783-001). This quiz is **ungraded**. It is only
to help you see what you remember. Answer alone, about 10 minutes.
Check your answers at the end.

Name: _______________________

---

**1.** A database management system (DBMS) is best described as:

A. A single spreadsheet file
B. Software that lets people create, use, and control access to a database
C. A backup copy of your data
D. A programming language

**2.** The same customer's address is typed differently in three
different rows of a file. This is an example of:

A. Atomicity problem
B. Security problem
C. Redundancy and inconsistency
D. Data isolation

**3.** Two staff members save the same file at almost the same time.
The second save silently erases the first person's changes. This is
called:

A. A lost update
B. An integrity rule
C. A schema
D. A data model

**4.** Which of these correctly matches "always happens fully, or not
at all" to its name?

A. Concurrency
B. Atomicity
C. Redundancy
D. Data independence

**5.** In the three levels of abstraction, which level describes
"what data exists and how it relates," such as `Student(id, name,
major)`?

A. Physical level
B. View level
C. Logical level
D. Instance level

**6.** A `Course` table's columns (`code`, `title`, `room`) never
change from semester to semester. This fixed design is called the:

A. Instance
B. Schema
C. Query
D. Transaction

**7.** True or False: If a university switches to new servers, the
logical level should change, while the physical level should stay
the same.

A. True
B. False

**8. Short answer.** In your own words, describe one problem that a
plain spreadsheet has, which a DBMS is built to solve. Give one
short, real example (from class or your own life).

_____________________________________________________________
_____________________________________________________________
_____________________________________________________________

---

<!-- ============================================================ -->
<!-- Answer Key -->
<!-- ============================================================ -->

## Answer Key

1. **B** — A DBMS is software that lets people create, use, and
   control access to a database.
2. **C** — Redundancy (the same fact stored more than once) and
   inconsistency (the copies disagree).
3. **A** — A lost update: one person's change silently disappears.
4. **B** — Atomicity: an operation either fully happens, or it does
   not happen at all.
5. **C** — The logical level: what data exists, and how it relates.
6. **B** — The schema: the fixed design, not the changing data.
7. **B — False.** It is the opposite: the *physical* level changes
   (new hardware), while the *logical* level stays the same. This is
   the whole point of data independence.
8. Open-ended. Accept any answer that correctly names a real failure
   (redundancy, inconsistency, hard access, integrity, atomicity,
   concurrency, isolation, or security) **and** pairs it with a
   believable example, in the student's own words.
