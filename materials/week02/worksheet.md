# Week 2 Worksheet: The Registration System, One Relation at a Time

Database Systems (511783-001). Work with your pair. Write short
answers — full sentences are not required, but write enough that your
partner and the instructor can follow your thinking.

**Pair names:** ___________________________ / ___________________________

---

## Part A (do this in 차시 2, about 15 minutes)

Week 1's registration spreadsheet had one flat row like this:

```
Kim Minji, Computer Sci., CSE301, Prof. Lee, A0
```

Use this week's steps to turn it into a real relation.

**A1.** How many different real-world "things" (a student? a course?
an enrollment? something else?) are the facts in that one row actually
about? List them.

`________________________________________________________________`

**A2.** Pick only the attributes that belong to the *student's own*
facts (not the course, not the grade). List them.

`________________________________________________________________`

**A3.** Write the full `Student` relation schema, including a key that
guarantees no two students are indistinguishable.

`________________________________________________________________`

**A4.** Prediction: now that we have formal rules for a relation
(schema, domains, keys, and the three integrity constraints), does
that tell us *which* tables to design — for example, whether `grade`
belongs in the `Student` table or in a separate table? Circle one.

**Yes** &nbsp;&nbsp;&nbsp;&nbsp; **No** &nbsp;&nbsp;&nbsp;&nbsp; **Not sure**

**A5.** What is one thing about relations that you are still not sure
about?

`________________________________________________________________`

*Stop here. We compare answers together before you see Part B.*

---

## Part B (do this in 차시 3, about 15 minutes)

Your instructor will hand this out after the class discussion of Part
A. It starts with the real answer to A4, then asks you to explain it.

**The real answer to A4:** No. We now have a rigorous definition of
what a table is — relations, attributes, tuples, keys, and the rules
they must obey. But nothing in that vocabulary tells us *which* tables
to make. Two designers can both follow every rule perfectly and still
disagree about whether `grade` belongs in `Student` or in its own
relation.

**B1.** Was your Part A prediction (A4) correct?

`Yes  /  No  /  Partly`

**B2.** Using the words **relation schema** and **key constraint**,
explain in 1-2 sentences why the rules you learned this week cannot,
by themselves, settle whether `grade` belongs in `Student` or in a
separate table.

`________________________________________________________________`
`________________________________________________________________`

**B3.** From this week's worked example: `Course(course_code, title)`
and `Instructor(instructor_id, name)`. For each relation, name a
candidate key and say whether it is also the primary key.

`Course: __________________________________________________________`
`Instructor: ______________________________________________________`

**B4.** `Enrollment(student_id, course_code, grade)`. `student_id` is a
foreign key referencing `Student.student_id`. Suppose an `Enrollment`
row has `student_id = 999`, but no student with ID 999 exists in
`Student`. Which integrity rule does this break, and why is that row a
problem?

`________________________________________________________________`
`________________________________________________________________`

**B5 (stretch, optional).** The full registration system will also
need a `Section` relation (one specific offering of a course, with a
room and semester) and the `Enrollment` relation links a student to a
section. Just as a guess, for now: what do you think the primary key
of `Section` should be? What about `Enrollment`?

`________________________________________________________________`
