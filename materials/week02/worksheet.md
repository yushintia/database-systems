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

---
---

# Instructor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** At least three things: a student (`name`, `major`), a course
  (`course_code`, `course_title`), and an enrollment fact (`grade`,
  tying a specific student to a specific course)
- **A2:** `name`, `major` only — `course_code`, `course_title`,
  `instructor`, `room`, `grade` all belong elsewhere
- **A3:** `Student(student_id, name, major)`, with `student_id` as a
  system-generated key. Accept close variants; the key point is adding
  an ID rather than using `name` alone
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "Yes, once we know the schema rules, we
  automatically know which tables to build" — that is the expected
  wrong guess, and the whole point of the "not sure yet" moment. Do
  **not** confirm or deny the answer yet
- **A5:** Good answers mention: uncertainty about where `grade`
  belongs, confusion between superkey and candidate key, or not being
  sure how foreign keys connect two relations. Any honest gap is a
  success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "A relation schema just fixes a name and a
  set of attributes with domains, and a key constraint just says
  primary key values can't repeat — neither rule says which facts
  belong in which schema. Both `grade`-in-`Student` and
  `grade`-in-its-own-relation can obey every rule we learned this
  week, so the vocabulary alone can't pick between them."
- **B3 (model answer):** `Course`: `{course_code}` is both a candidate
  key and the primary key. `Instructor`: `{instructor_id}` is both a
  candidate key and the primary key.
- **B4 (model answer):** "This breaks referential integrity. The
  foreign key `student_id` in `Enrollment` must match an existing
  primary key value in `Student`, or be left empty. A row pointing at
  `student_id = 999` with no matching student is an orphaned,
  meaningless row."
- **B5:** No single correct answer is required this week — this is
  intentionally forward-looking. Accept any reasoning. A common good
  guess: `Section` might need its own `section_id` (since the same
  course can have multiple sections), and `Enrollment` might need a
  key made of more than one attribute together (a student plus a
  section), since neither one alone is unique. Do not confirm the
  final schema — Week 4 covers this formally.

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section
