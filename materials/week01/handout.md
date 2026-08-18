# Week 1 Handout — Introduction to Database Systems

Database Systems (511783-001). Keep this handout. It has the full
glossary, the worked example explained step by step, extra reading,
and practice problems with answers.

---

## Part 1: Glossary (all key terms, in plain words)

| Term | Plain definition |
|---|---|
| **Data** | Raw facts, like a name, a course code, or a grade. |
| **Row** | One record. One line of data about one thing (one student). |
| **Column** | One kind of fact, repeated for every row (name, grade, room). |
| **Duplicate** | The exact same row, typed more than once. |
| **Inconsistent** | Two rows about the same thing that do not agree with each other. |
| **Redundancy** | The same fact stored in more than one place. |
| **Database** | An organized collection of related data. |
| **DBMS** (database management system) | Software that lets people create, use, and control access to a database. |
| **Integrity rule** (integrity constraint) | A rule that data must follow. Example: a grade must be a real grade, not "A99." |
| **Atomicity** | An operation either fully happens, or it does not happen at all. No half-finished saves. |
| **Concurrency** | Many people using the same data at the same time. |
| **Lost update** | When two people edit the same data at once, and one person's change silently disappears. |
| **Data isolation** | Related data split across separate files that cannot be read together. |
| **Security problem** | A system that cannot tell "your data" apart from "everyone's data." |
| **Schema** | The design: column names and their types. Rarely changes. |
| **Instance** | The actual data right now, at this moment. Always changing. |
| **Data independence** | Changing how data is stored should not force you to rewrite the application. |
| **Abstraction level** | One of three separate views of the same data: physical, logical, or view. |
| **Physical level** | How bytes actually sit on disk: file layout, indexes. |
| **Logical level** | What data exists and how it relates, e.g. `Student(id, name, major)`. |
| **View level** | What one specific user is allowed to see. |
| **Data model** | The shape data takes at the logical level (tables, diagrams, documents). |
| **Relational model** | Data stored as tables, linked by shared IDs instead of retyping. |
| **Entity-Relationship (E-R) model** | A diagram of real-world things and how they connect, before any table exists. |
| **DBA** (database administrator) | The person who owns a database's schema, security, backups, and performance. |

---

## Part 2: The Worked Example, Step by Step

This is the exact spreadsheet from the slides: `registrations.xlsx`,
the university's running case study.

| Row | Student | Major | Course | Instructor | Grade |
|---|---|---|---|---|---|
| 1 | Kim Minji | Computer Sci. | CSE301 | Prof. Lee | *(blank)* |
| 2 | MinJi Kim | CS | CSE301 | Prof. Lee | A0 |
| 3 | 김민지 | Comp. Science | CSE301 | *(blank)* | *(blank)* |
| 4 | Park Jiho | Software Eng. | CSE305 | Prof. Han | A- |

Let's read it row by row, like the registration staff would:

1. **Row 1** says Kim Minji is in CSE301, majoring in Computer
   Science, taught by Prof. Lee. No grade yet — the class may still
   be in progress, or the grade was never entered.
2. **Row 2** looks like the *same* student. The name is spelled
   "MinJi Kim" instead of "Kim Minji," and the major is shortened to
   "CS." This time a grade, A0, is recorded.
3. **Row 3** is very likely the *same* student again, this time in
   Korean: "김민지." The major is written differently once more
   ("Comp. Science"), and both instructor and grade are blank.
4. **Row 4** is a different student, Park Jiho, and looks fully
   filled in — no obvious problem here.

**What is going wrong?** Rows 1-3 almost certainly describe *one*
student, Kim Minji, but a computer reading this file has no way to
know that. To software, "Kim Minji," "MinJi Kim," and "김민지" are
three completely different names. This is **redundancy** (the same
fact, her enrollment in CSE301, stored three times) combined with
**inconsistency** (the three copies disagree on her name and major).

**Why does this matter?** If a professor asks "what grade did Kim
Minji get in CSE301?", the honest answer is: *it depends which row
you look at.* Row 1 has no grade. Row 2 says A0. Row 3 has no grade.
There is no single correct answer, because the same fact was allowed
to be typed three different ways.

A DBMS prevents this by storing each student **once**, with a unique
ID, and linking every enrollment record back to that one ID — instead
of retyping the student's name every time. You will see exactly how
in Week 2 onward.

---

## Part 3: Optional Reading — What We Trimmed From the Slides

### The full seven failures (slides covered five; here are all seven)

1. **Redundancy & inconsistency** — the same fact stored more than
   once, and the copies disagree. *Example: Kim Minji, spelled three
   ways.*
2. **Difficulty accessing data** — no built-in way to ask a question;
   every new question means new code, or scrolling by eye. *Example:
   the 3-hour scroll to find who is in CSE301.*
3. **Data isolation** — related data is split across separate files
   or separate copies, with no way to read across all of them at
   once. *Example: each staff member's downloaded copy is its own
   island. A question like "which students did BOTH advisors update
   this week?" cannot be answered, because no single copy has both
   people's edits.*
4. **Integrity problems** — a spreadsheet cell accepts anything typed
   into it, with no rule about what counts as valid. *Example: a
   grade of "A99," or "-3" typed into an attendance count.*
5. **Atomicity problems** — an operation should either fully happen
   or not happen at all; a plain file save has no such guarantee.
   *Example: a crash mid-save leaves the file half-written, with no
   record of what was lost.*
6. **Concurrent-access anomalies** — when multiple people update data
   around the same time with no coordination, one person's work can
   silently overwrite another's. *Example: the dueling uploads.*
7. **Security problems** — a shared file has no concept of "your
   data" versus "everyone's data." *Example: anyone with
   `registrations.xlsx` can read and edit every student's grade in
   every class, department-wide. There is no restriction by role.*

### The DBMS landscape (product names and what they run)

| Product | Powers |
|---|---|
| **PostgreSQL / MySQL** | Most e-commerce and web backends, like a Coupang-style storefront |
| **SQLite** | Lives inside a phone itself: local storage in almost every app |
| **Oracle / SQL Server** | Banks, airlines, large enterprise systems |
| NoSQL (mentioned, not covered this semester) | Social feeds and chat, at massive scale |

The relational model (this course) stays the default choice whenever
data has clear structure and correctness matters more than
flexibility — which describes most business, academic, and financial
systems.

### More on data models

Besides the relational model (tables) and the E-R model (diagrams),
you will hear the term **object-based / semi-structured** models
later in your career. These store data as objects or flexible,
JSON-like documents, used when data does not fit neatly into rows and
columns. This course is relational end to end, so we only name it
here for context — it will come up again if you work with NoSQL
systems later.

---

## Part 4: Practice Problems (with answers)

Try each problem yourself before checking the answer.

**1.** A spreadsheet has the same customer's phone number typed
differently in three separate rows. What failure is this?

> **Answer:** Redundancy & inconsistency — the same fact (the phone
> number) is stored more than once, and the copies disagree.

**2.** Two employees both edit the same shared file at 9:00 AM. One
saves at 9:05, the other saves at 9:06 without seeing the first
save. What happens, and what is this called?

> **Answer:** The 9:06 save silently overwrites the 9:05 save. This
> is a lost update, caused by a concurrency problem.

**3.** A form lets a user type "999" into an "Age" field, and the
system accepts it without complaint. What failure is this?

> **Answer:** An integrity problem — there is no rule enforcing what
> counts as a valid age.

**4.** The power goes out while a file is being saved. When the
computer restarts, half the records are updated and half are not,
with no way to tell which is which. What failure is this?

> **Answer:** An atomicity problem — the save did not either fully
> finish or fully fail; it did something in between.

**5.** True or false: the physical level is what changes when a
university moves its servers to new hardware, while the logical
level stays the same.

> **Answer:** True. This separation is exactly what data independence
> means: application code, working at the logical level, does not
> need to change.

**6.** Which of these is the schema, and which is the instance? "A
`Course` table always has columns `code`, `title`, `room`." versus
"Right now, CSE301's room is 성파 702."

> **Answer:** The first sentence describes the schema (fixed column
> design). The second describes an instance (the actual data right
> now, which can change).
