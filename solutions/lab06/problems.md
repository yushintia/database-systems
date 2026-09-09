# Lab 06: The Mapping Algorithm — Guided Exercises and Challenge

Prompts only, adapted from the lab text. See `answer-key/` for
reference solutions.

## Guided Exercises

### Part A: Predict

**A1.** `Student` is a strong entity: `Student(student_id, name,
major)`. Apply Rule 1. Write the resulting relation and its primary
key.

**A2.** `Instructor` (1) teaches `Section` (N). Which relation gets a
foreign key, what is it called, and which rule tells you that?

**A3.** `Waitlist` is a weak entity that depends on both `Student` and
`Section`, with its own attributes `position` and `date_joined`.
Apply Rule 3. Write `Waitlist`'s primary key.

**A4. Prediction:** will applying Rule 3 (your A3 answer) and Rule 4
(M:N relationship) to `Waitlist` produce the exact same relation?
Write your guess and your reasoning before moving on.

**A5.** What is one thing about mapping weak entities or M:N
relationships that you are still not sure about?

### Part B: Confirm and Apply

**B1.** Was your Part A prediction (A4) correct?

**B2.** Using the words **composite key** and **foreign key**,
explain in 1-2 sentences why `Waitlist` needs `(student_id,
section_id)` as its primary key instead of a single `waitlist_id`.

**B3.** Write `Waitlist`'s full relation, including the `PRIMARY KEY`
declaration.

**B4.** A `Department` (1) offers many `Course` (N). Which relation
gets the foreign key, what is it called, and by which rule?

**B5 (stretch, optional).** Each `Student` has exactly one, optional
`Advisor`, and each `Advisor` advises exactly one `Student`. Which
rule maps this, and which side would most naturally hold the foreign
key?

### Part C: Map Your Own Diagram (graded deliverable)

Apply Rules 1 through 4 to every entity and relationship on your own
Lab 4 E-R diagram. For each: name the entity/relationship, the rule
applied, and the resulting relation (with primary/foreign keys).
Self-check against `book/src/labs/files/lab06/target_schema.sql`.

File: `lab06_mapping.md`

## Challenge Problem

Pick one construct from your own Lab 4 diagram beyond the four core
rules (a multivalued attribute, a composite attribute, or a
specialization hierarchy) — or invent a small, realistic one. Map it
using the Week 6 slides' Rules 6-10, and explain in 1-2 sentences why
the mapping algorithm forbids storing it as a single column instead.

Included in: `lab06_mapping.md`, as a final section.

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** `Course` is a strong entity: `Course(course_code,
title, credits)`. Apply Rule 1.

**Practice 2.** `Department` (1) offers many `Course` (N). Which
relation gets a foreign key, and what is it called?

**Practice 3.** A library system has `Book` (strong), `Member`
(strong), and `Loan` (weak, depending on both, with attribute
`due_date`). Apply Rules 1 and 3. Write every resulting relation.

**Practice 4.** A `TA` entity can help with many `Section`s, and a
`Section` can have many `TA`s. Which rule applies, and what relation
does it produce?

**Practice 5.** A ride-hailing app has `Driver` (strong) and `Ride`
(weak, depending on both `Driver` and `Rider`). `Driver` is 1:N with
`Ride`. Which relation gets the foreign key for `driver_id`, and by
which rule?

**Practice 6.** A team maps a 1:N relationship by giving the "one"
side a list-type column of the "many" side's IDs, instead of a
foreign key on the "many" side. Which rule does this violate, and
what is the correct fix?

**Practice 7.** `Vehicle` (strong) is M:N with `Route` (strong), via a
new relationship `Assignment`, with its own attribute
`assigned_date`. Apply Rule 4. Write the resulting relation, with its
primary key.
