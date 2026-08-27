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

---
---

# Instructor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** `INSERT INTO Student (name, major) VALUES ('Yoon Areum', 'Computer Science');`
- **A2:** `INSERT INTO Enrollment (student_id, section_id, grade) VALUES (15, 2, NULL);` — watch for pairs forgetting `NULL` and instead writing `0` or an empty string for the grade; both are wrong, `NULL` specifically means "not graded yet"
- **A3:** `SELECT * FROM Instructor WHERE instructor_id = 2;` then `UPDATE Instructor SET name = 'Prof. Han, Ph.D.' WHERE instructor_id = 2;` — watch for pairs who write the `UPDATE` with no `WHERE` clause at all, that is exactly this week's most common mistake
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many pairs will guess "Yes, it just adds a row" — that is the expected wrong guess, and the whole point of the "not sure yet" moment. Do **not** confirm or deny the answer yet
- **A5:** Good answers mention: uncertainty about when a `WHERE` clause is required, confusion about insert order across tables, or uncertainty about `NULL` vs. an empty value. Any honest gap is a success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here, just self-checking
- **B2 (model answer):** "`instructor_id` in `Section` is a foreign key, so it must already exist as a primary key value in `Instructor`. MySQL enforces insert order: the referenced row in `Instructor` must be inserted before any `Section` row that points at it."
- **B3 (model answer):**
  ```sql
  INSERT INTO Instructor (name) VALUES ('Prof. Song');
  -- MySQL assigns instructor_id = 20

  INSERT INTO Section (course_code, instructor_id, room, semester)
  VALUES ('CSE450', 20, '성파 900', '2026-2');
  ```
- **B4 (model answer):** "MySQL rejects the `DELETE`. Removing `section_id = 6` while `Enrollment` rows still reference it would leave those rows pointing at a section that no longer exists — an orphaned row. Referential integrity blocks this by default; the `Enrollment` rows must be removed or reassigned first."
- **B5 (model answer):**
  ```sql
  INSERT INTO Student (name, major) VALUES
      ('Baek Hyun', 'Software Engineering'),
      ('Cho Eunji', 'Computer Science'),
      ('Nam Taeyang', 'Data Science');
  ```

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's "Optional Reading" section
- Watch especially for two recurring mistakes during Part A: an `UPDATE`/`DELETE` written with no `WHERE` clause, and an `INSERT` written in the wrong table order relative to its foreign keys. Both are worth a quick verbal flag on the spot, without giving away A4's answer early
