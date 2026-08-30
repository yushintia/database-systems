# Week 10 Worksheet: The Registration Database, Row by Row

Database Systems (511783-001). Work with your pair. Write short
answers — full sentences are not required, but write enough that your
partner and the instructor can follow your thinking.

**Pair names:** ___________________________ / ___________________________

---

## Part A (do this in 차시 2, about 15 minutes)

The registration schema from Week 9 is live in MySQL, and completely
empty. Use the tables below and write the SQL each question asks for.

```
Student(student_id PK, name, major)
Course(course_code PK, title)
Instructor(instructor_id PK, name)
Section(section_id PK, course_code FK, instructor_id FK, room, semester)
Enrollment(student_id FK, section_id FK, grade, PRIMARY KEY(student_id, section_id))
```

**A1.** Write the `INSERT` statement to add a new student, "Yoon
Areum," major "Computer Science," to `Student`.

`________________________________________________________________`

`________________________________________________________________`

**A2.** Student `student_id = 15` already exists. Write the `INSERT`
statement to enroll her in `section_id = 2`, with no grade yet.

`________________________________________________________________`

`________________________________________________________________`

**A3.** Instructor `instructor_id = 2`'s name needs to change to
"Prof. Han, Ph.D." Write the safest possible `UPDATE`, checking the
target row first.

`________________________________________________________________`

`________________________________________________________________`

**A4.** Prediction: your classmate writes this statement, and there is
no `instructor_id = 20` anywhere in `Instructor` yet:

```sql
INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE450', 20, '성파 900', '2026-2');
```

Will this `INSERT` succeed? Circle one.

**Yes** &nbsp;&nbsp;&nbsp;&nbsp; **No** &nbsp;&nbsp;&nbsp;&nbsp; **Not sure**

**A5.** What is one thing about writing `INSERT`, `UPDATE`, or `DELETE`
statements that you are still not sure about?

`________________________________________________________________`

*Stop here. We compare answers together before you see Part B.*

---

## Part B (do this in 차시 3, about 15 minutes)

Your instructor will hand this out after the class discussion of Part
A. It starts with the real answer to A4, then asks you to explain it.

**The real answer to A4:** No, it fails. `Section.instructor_id` is a
foreign key referencing `Instructor.instructor_id`. MySQL checks this
immediately, and rejects any row pointing at an instructor who does
not exist yet.

**B1.** Was your Part A prediction (A4) correct?

`Yes  /  No  /  Partly`

**B2.** Using the words **foreign key** and **insert order**, explain
in 1-2 sentences why the statement in A4 fails.

`________________________________________________________________`
`________________________________________________________________`

**B3.** Write the two `INSERT` statements needed to actually get that
`CSE450` section created, using `instructor_id = 20` for a new
instructor named "Prof. Song," in the correct order.

`________________________________________________________________`

`________________________________________________________________`

`________________________________________________________________`

**B4.** `section_id = 6` still has rows in `Enrollment` pointing at
it. Someone runs `DELETE FROM Section WHERE section_id = 6;`. What
happens, and why?

`________________________________________________________________`
`________________________________________________________________`

**B5 (stretch, optional).** Write one multi-row `INSERT` statement
that adds three new students to `Student` in a single statement:
"Baek Hyun" (Software Engineering), "Cho Eunji" (Computer Science),
and "Nam Taeyang" (Data Science).

`________________________________________________________________`

`________________________________________________________________`
