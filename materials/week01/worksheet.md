# Week 1 Worksheet — Introduction to Database Systems

Database Systems (511783-001). Work with your neighbor (pair work).
Write your names here:

Name 1: _______________________  Name 2: _______________________

---

## Worksheet Part A (~15 minutes)

Below is a real-style excerpt from `registrations.xlsx`, the
university's course registration file. Look at it carefully, then
answer the questions.

| Row | Student | Major | Course | Instructor | Grade |
|---|---|---|---|---|---|
| 1 | Han Sujin | Software Eng. | CSE301 | Prof. Lee | B+ |
| 2 | Han Su-jin | SW Eng. | CSE301 | Prof. Lee | B+ |
| 3 | Choi Woo | Computer Sci. | CSE305 | Prof. Han | A99 |
| 4 | Choi Woo | Computer Sci. | CSE305 | Prof. Han | A99 |
| 5 | Jung Ara | Computer Sci. | CSE301 | *(blank)* | *(blank)* |

**A1. Find the duplicate.** Which two row numbers contain the exact
same information, repeated?

Rows: _______ and _______

**A2. Find the inconsistency.** Which two row numbers describe the
*same* student, but spell her name and major differently?

Rows: _______ and _______   What is different between them?
_____________________________________________________________

**A3. Label the problem.** Row 3's Grade column says "A99." What is
wrong with this value? Which failure category from class does this
match? (Circle one)

Redundancy & inconsistency &nbsp;&nbsp;/&nbsp;&nbsp; Hard to access
&nbsp;&nbsp;/&nbsp;&nbsp; **Integrity problem** &nbsp;&nbsp;/&nbsp;&nbsp;
Atomicity problem &nbsp;&nbsp;/&nbsp;&nbsp; Concurrency

**A4. Short answer.** Row 5 has a blank Instructor and a blank Grade.
Name one real-world reason this might happen, and one problem it
could cause later.

_____________________________________________________________
_____________________________________________________________

**A5. The lost update.** Read this short story, then answer below.

> On Monday, Staff Member A opens `registrations.xlsx` and changes
> Choi Woo's room from 402 to 410. Staff Member A saves the file at
> 2:00 PM.
> On the same Monday, Staff Member B had already opened their *own*
> copy of the file that morning, before Staff Member A's change. At
> 2:15 PM, Staff Member B saves their copy — which still has the old
> room number, 402 — overwriting Staff Member A's save.

What just happened to Staff Member A's change? _________________
_____________________________________________________________

What failure category is this an example of? ___________________

---

## Worksheet Part B (~15 minutes)

Here is a second, larger excerpt from the same file. Some columns
have been added.

| Row | Student | Major | Course | Room | Grade |
|---|---|---|---|---|---|
| 1 | Bae Yuna | Business | CSE301 | 402 | A0 |
| 2 | Bae Yuna | Business Admin | CSE301 | 402 | *(blank)* |
| 3 | Song Minho | Computer Sci. | CSE305 | 210 | C |
| 4 | Song Minho | Computer Sci. | CSE305 | 210 | Z5 |
| 5 | Oh Hyewon | Computer Sci. | CSE301 | 402 | B0 |

**B1. Fill in the blank.** The table's column names — `Student`,
`Major`, `Course`, `Room`, `Grade` — are an example of the
______________ (schema / instance) of this data, because they are
the fixed design.

**B2. Fill in the blank.** The actual values in row 5 — "Oh Hyewon,
Computer Sci., CSE301, 402, B0" — are an example of one
______________ (schema / instance) of that design, because they can
change.

**B3. Label the problem.** Rows 3 and 4 both describe Song Minho in
CSE305, but list two different grades: "C" and "Z5." Besides "Z5"
being an invalid grade, what does having *two* rows for the same
enrollment suggest went wrong?

_____________________________________________________________

**B4. Short answer.** If this university switches to new servers
next year, which abstraction level changes (physical, logical, or
view)? Which level should stay exactly the same, so that nobody in
the registration office notices the switch?

Changes: _______________   Stays the same: _______________

**B5. Design it yourself.** In one sentence, describe one rule (an
integrity rule) that should have stopped row 4's grade from ever
being saved as "Z5."

_____________________________________________________________

**B6. Connect it back.** Name one app on your own phone (not from
class) that you think uses a database. What is one question it must
answer correctly, instantly, every time you open it?

App: _______________   Question it answers: _________________

---

<!-- ============================================================ -->
<!-- Instructor Answer Key — do not hand out this section -->
<!-- ============================================================ -->

## Instructor Answer Key — do not hand out this section

### Part A

- **A1.** Rows 3 and 4 (Choi Woo, exact duplicate).
- **A2.** Rows 1 and 2 (Han Sujin / Han Su-jin, Software Eng. / SW
  Eng.). Different spelling of both name and major.
- **A3.** Integrity problem — "A99" is not a valid grade value; no
  rule stopped an invalid entry from being saved.
- **A4.** Any reasonable answer is fine: e.g. the class had not
  finished, or a staff member forgot to fill it in. Problem it could
  cause: nobody can confirm the student is even enrolled, or the
  grade may never get entered at all.
- **A5.** Staff Member A's room change (402 → 410) is silently lost;
  the file reverts to showing room 402. This is a lost update, a
  concurrency (concurrent-access) problem.

### Part B

- **B1.** Schema.
- **B2.** Instance.
- **B3.** Suggests the same enrollment record was saved twice
  (redundancy), possibly by two different people or two different
  sessions, and the copies now disagree (inconsistency) — including
  one invalid grade.
- **B4.** Changes: physical. Stays the same: logical (and the view
  level, since applications and users work at the logical/view level
  and should not need to know or care about the physical change).
- **B5.** Any answer that states a valid-grade rule is acceptable,
  e.g. "A grade must be one of A0, A-, B+, B0, ... F, or blank," or
  "Reject any grade value not on the official grade list."
- **B6.** Open-ended; accept any reasonable app + question pair that
  shows the student understands "a database answers a specific
  question correctly, instantly" (e.g. banking app / "what is my
  balance," a game / "what is my current level and score").
