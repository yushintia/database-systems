# Lab 03 Problems — Data Modelling

Public restatement of Lab 03's Guided Exercises and Challenge Problem.
Full lab page: `book/src/labs/lab03-data-modelling.md`. Seed files:
`book/src/labs/files/lab03/interview_transcript.md`,
`book/src/labs/files/lab03/toy_sandbox.sql`.

## Guided Exercise 1: The Registration System, Stage by Stage

Requirement: "Every student enrolls in one or more course sections,
taught by an instructor, in a specific room."

1. List the entities mentioned (no table/column names yet).
2. List the relationships connecting them, in plain language.
3. Name the design stage this is (conceptual, logical, or physical).

## Guided Exercise 2: Why Lab 02's Rules Aren't Enough

Three designers each follow every Lab 02 rule perfectly and still
disagree. Using **requirements** and **conceptual design**, explain in
1-2 sentences why Lab 02's rules alone can't guarantee a good design.

## Guided Exercise 3: Catching Redundancy Before It's Built

A designer combines `Student` and `Enrollment` into one relation,
copying the student's major into every enrollment row. Which of the
four "good design" tests does this fail, and why?

## Guided Exercise 4: The Waitlist, From Your Own Reading

From `interview_transcript.md`, name the new entity the waitlist
feature introduces, and the two facts connecting it to Student and
Section.

## Challenge Problem

1. Explain why skipping physical design "for now, add indexes later"
   is riskier than it sounds.
2. Name one requirement from the interview transcript that could pass
   all four design tests on paper and still be implemented incorrectly
   by someone who only skimmed the transcript once.

## Deliverable

`lab03_model.md`. Total: 10 points.
