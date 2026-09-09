# Lab 03 Answer Key — `lab03_model.md` (Professor Only)

Not linked from any public page. Model answer for
`solutions/lab03/problems.md`.

## Guided Exercise 1

1. **Entities:** Student, Section, Instructor. (Course is implied by
   "course sections" but easy to miss on a first pass — accept either
   answer, and use it as a teaching moment if a student names Section
   but not Course, or vice versa.)
2. **Relationships:** "a Student enrolls in a Section"; "a Section is
   taught by an Instructor"; "a Section is offered in a room" (room
   treated as attribute-level for now, not yet a relationship).
3. **Design stage: Conceptual.** No table names, column names, or keys
   have been written yet — only real-world things and facts.

## Guided Exercise 2

Model answer: "Lab 02's rules guarantee that any *individual* relation
is well-formed — it has a valid schema, attributes with domains, and a
key. They say nothing about how many relations a system needs, or
which facts belong in which one. A **conceptual design**, checked
against real **requirements**, is the only thing that can settle that
— and three technically-valid designs can still disagree about it."

## Guided Exercise 3

**Fails Minimal Redundancy.** Copying the student's major into every
enrollment row stores the same fact (this student's major) in as many
places as they have enrollments. Update one enrollment's major and not
the others, and the data disagrees with itself — exactly Lab 01's
redundancy problem, recreated one level up.

## Guided Exercise 4

**New entity: Waitlist.** Connecting facts: "a Student joins a
Waitlist for a Section" (Student-Waitlist) and "a Waitlist entry is
for one specific Section" (Waitlist-Section). Waitlist carries
`position` and `date_joined`, neither of which means anything without
knowing which student and which section.

## Challenge Problem

1. Model answer: "Add it later" sounds free but isn't, because
   physical-design decisions (indexes, storage layout) are often much
   cheaper to get right while a system is small and empty than to
   retrofit once it holds real data and real traffic — adding an index
   to a live, large table can require downtime or a lengthy rebuild,
   and diagnosing *which* index is missing is much harder under
   production load than during design.
2. Accept any answer identifying a *rule*, not just an entity, stated
   only once in passing — the strongest model answer is: "a student
   cannot be on the waitlist for a section they're already enrolled
   in." A model that lists Waitlist as an entity and Student-Waitlist
   as a relationship can pass all four tests on paper while an
   implementer who skimmed the transcript once still allows a student
   to be simultaneously enrolled in and waitlisted for the same
   section, because that specific constraint is easy to miss on a
   single read.
