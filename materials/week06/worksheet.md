# Week 6 Worksheet: Mapping the Registration Diagram to Tables

Database Systems (511783-001). Work with your pair. Write short
answers — full sentences are not required, but write enough that your
partner and the instructor can follow your thinking.

**Pair names:** ___________________________ / ___________________________

---

## Part A (do this in 차시 2, about 15 minutes)

You have Week 4's E-R diagram for the registration system. Practice
turning pieces of it into relations, using the rules from class.

**A1.** `Student` is a strong entity: `Student(student_id, name,
major)`. Apply Rule 1. Write the resulting relation and its primary
key.

`________________________________________________________________`

**A2.** `Instructor` (1) teaches `Section` (N). Which relation gets a
foreign key, what is it called, and which rule tells you that?

`________________________________________________________________`

**A3.** `Waitlist` is a weak entity that depends on both `Student` and
`Section`, with its own attributes `position` and `date_joined`. Apply
Rule 3. Write `Waitlist`'s primary key.

`________________________________________________________________`

**A4.** Prediction: `Waitlist` is *also* an M:N relationship between
`Student` and `Section`. Do you think applying Rule 3 (weak entity, your
A3 answer) and Rule 4 (M:N relationship) to `Waitlist` will produce the
exact same relation? Circle one.

**Yes** &nbsp;&nbsp;&nbsp;&nbsp; **No** &nbsp;&nbsp;&nbsp;&nbsp; **Not sure**

**A5.** What is one thing about mapping weak entities or M:N
relationships that you are still not sure about?

`________________________________________________________________`

*Stop here. We compare answers together before you see Part B.*

---

## Part B (do this in 차시 3, about 15 minutes)

Your instructor will hand this out after the class discussion of Part A.
It starts with the real answer to A4, then asks you to explain it.

**The real answer to A4:** Yes. Rule 3 and Rule 4, applied to
`Waitlist`, produce the identical relation:
`Waitlist(student_id, section_id, position, date_joined)`, `PRIMARY KEY
(student_id, section_id)`. This is not a coincidence — a weak entity
that depends on two other entities, and the M:N relationship between
those same two entities, describe the same real-world fact from two
angles. The two rules have to agree.

**B1.** Was your Part A prediction (A4) correct?

`Yes  /  No  /  Not sure`

**B2.** Using the words **composite key** and **foreign key**, explain
in 1-2 sentences why `Waitlist` needs `(student_id, section_id)` as its
primary key instead of a single `waitlist_id`.

`________________________________________________________________`
`________________________________________________________________`

**B3.** Write `Waitlist`'s full relation, including the `PRIMARY KEY`
declaration, exactly as it would appear in the derived schema.

`________________________________________________________________`

**B4.** A `Department` (1) offers many `Course` (N). Which relation
gets the foreign key, what is it called, and by which rule?

`________________________________________________________________`

**B5 (stretch, optional).** Suppose the registration system added a new
rule: each `Student` has exactly one, optional `Advisor`, and each
`Advisor` advises exactly one `Student`. Which rule from class would map
this relationship, and which side would most naturally hold the
foreign key? Explain your choice in one sentence.

`________________________________________________________________`

---
---

# Instructor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** `Student(student_id, name, major)`, primary key `student_id`.
  A direct copy, no design decision
- **A2:** `Section` gets the foreign key `instructor_id`, referencing
  `Instructor.instructor_id`, by Rule 2 — the "many" side always holds
  the key
- **A3:** `(student_id, section_id)` — `Waitlist`'s own attributes plus
  the primary keys of both entities it depends on
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "No, a weak entity and an M:N relationship sound
  like different things" — that is the expected wrong guess, and the
  whole point of the "not sure yet" moment. Do **not** confirm or deny
  the answer yet
- **A5:** Good answers mention: uncertainty about why two different
  rules would agree, confusion about which attributes count as the
  weak entity's "own" attributes, or uncertainty about composite keys
  in general. Any honest gap is a success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "`Waitlist` needs the composite key
  `(student_id, section_id)` because that pair is what a foreign key
  points at from both `Student` and `Section` — a single `waitlist_id`
  would not, by itself, stop the same student from appearing twice on
  the same section's waitlist."
- **B3 (model answer):** `Waitlist(student_id, section_id, position,
  date_joined)` `PRIMARY KEY (student_id, section_id)`
- **B4 (model answer):** `Course` gets the foreign key,
  `department_id`, referencing `Department.department_id`, by Rule 2 —
  the "many" side always holds the key. (Mirrors the deck's own Check
  Yourself Q1; confirm pairs reach the same answer independently.)
- **B5 (model answer):** Rule 5 (1:1 relationship). The foreign key
  would go on `Student`, the optional side, since not every student has
  an advisor yet. Accept "either side" reasoning too — the deck states
  either side is technically valid, optional side is just the usual
  convention.

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section
