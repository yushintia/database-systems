# Week 4 Worksheet: Diagramming the Registration System (and the Waitlist)

Database Systems (511783-001). Work with your pair. Write short
answers — full sentences are not required, but write enough that your
partner and the instructor can follow your thinking.

**Pair names:** ___________________________ / ___________________________

---

## Part A (do this in 차시 2, about 15 minutes)

The registration system requirement is: "Every student enrolls in one
or more course sections, taught by an instructor, in a specific room."
Practice naming entities, classifying attributes, and stating
cardinality, using the steps from class.

**A1.** From the requirement above, list the entities. For each one,
say briefly why it counts as an entity (or why `room` does not, for
now).

`________________________________________________________________`

**A2.** Student has the attributes `student_id`, `name`, and `major`.
Classify each one: simple, composite, or key.

`student_id`: ______________ `name`: ______________ `major`: ______________

**A3.** One Instructor teaches many Sections; each Section has exactly
one Instructor. What cardinality is that?

`________________________________________________________________`

**A4.** Prediction: a Student takes many Sections, AND a Section holds
many Students, both directions at once. Can this relationship still be
drawn as ONE line with a single cardinality label? Circle one.

**Yes** &nbsp;&nbsp;&nbsp;&nbsp; **No** &nbsp;&nbsp;&nbsp;&nbsp; **Not sure**

**A5.** What is one thing about drawing this Student-Section
relationship that you are still not sure about?

`________________________________________________________________`

*Stop here. We compare answers together before you see Part B.*

---

## Part B (do this in 차시 3, about 15 minutes)

Your instructor will hand this out after the class discussion of Part A.
It starts with the real answer to A4, then asks you to explain it.

**The real answer to A4:** Yes, one line, labeled **M:N** — many
instances on one side relate to many instances on the other, in both
directions at once. But M:N cannot be represented by a single foreign
key on either side, which is exactly why the case study needs its own
`Enrollment` entity to hold the relationship together.

**B1.** Was your Part A prediction (A4) correct?

`Yes  /  No  /  Partly`

**B2.** Using the words **cardinality** and **weak entity**, explain in
1-2 sentences why `Enrollment` has to exist as its own entity, instead
of just being a column added to Student or Section.

`________________________________________________________________`
`________________________________________________________________`

**B3.** A second requirement from class: "Student joins a Waitlist for
a Section." `Waitlist` has attributes `position` and `date_joined`.
Is `Waitlist` a weak entity or a strong entity? Justify your answer
using its attributes.

`________________________________________________________________`

**B4.** Requirement: "A library holds many copies of a book. A member
can borrow a copy, but only one member at a time per copy." List the
entities, and state the cardinality between Member and Copy.

`________________________________________________________________`

**B5 (stretch, optional).** "A Driver gives many Rides; a Rider takes
many Rides; each Ride has exactly one Driver and one Rider." Is `Ride`
a weak or a strong entity? Why can't `Ride` simply be added as a
foreign key on `Driver`?

`________________________________________________________________`
