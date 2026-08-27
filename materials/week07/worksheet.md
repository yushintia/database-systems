# Week 7 Worksheet: Normalizing the Waitlist, One Form at a Time

Database Systems (511783-001). Work with your pair. Write short
answers — full sentences are not required, but write enough that your
partner and the instructor can follow your thinking.

**Pair names:** ___________________________ / ___________________________

---

## Part A (do this in 차시 2, about 15 minutes)

A developer built `Waitlist` with convenience columns copied in:
`Waitlist(student_id, section_id, student_name, course_title,
position)`. Practice testing it against the normal forms from class.

**A1.** Write the functional dependency that causes the problem: does
`student_id` determine `student_name`, and does `section_id` determine
`course_title`? Write both as A → B.

`________________________________________________________________`

**A2.** Check 1NF: does every attribute in `Waitlist` hold a single,
atomic value? Yes or no, and why?

`________________________________________________________________`

**A3.** The key is `{student_id, section_id}`. Check 2NF: does
`student_name` depend on the whole key, or just part of it? Name the
violation if there is one.

`________________________________________________________________`

**A4.** Prediction: after you remove `student_name` and `course_title`
from `Enrollment(student_id, section_id, grade, course_title)` to fix
its 2NF violation, is the resulting `Section(section_id, course_code,
instructor_id, instructor_name, room, semester)` already free of every
anomaly? Circle one.

**Yes** &nbsp;&nbsp;&nbsp;&nbsp; **No** &nbsp;&nbsp;&nbsp;&nbsp; **Not sure**

**A5.** What is one thing about telling 2NF and 3NF apart that you are
still not sure about?

`________________________________________________________________`

*Stop here. We compare answers together before you see Part B.*

---

## Part B (do this in 차시 3, about 15 minutes)

Your instructor will hand this out after the class discussion of Part A.
It starts with the real answer to A4, then asks you to explain it.

**The real answer to A4:** No. `Section` has a single-column primary
key (`section_id`), so it automatically satisfies 2NF — 2NF only ever
matters for a composite key. But `Section` still fails **3NF**:
`section_id → instructor_id`, and `instructor_id → instructor_name`, so
`section_id → instructor_name` only transitively, through
`instructor_id`. Passing 2NF is not the same as being anomaly-free.

**B1.** Was your Part A prediction (A4) correct?

`Yes  /  No  /  Not sure`

**B2.** Using the words **transitive dependency** and **3NF**, explain
in 1-2 sentences why `Section(section_id, course_code, instructor_id,
instructor_name, room, semester)` still has an update anomaly even
though it already passes 2NF.

`________________________________________________________________`
`________________________________________________________________`

**B3.** Fully normalize `Waitlist(student_id, section_id, student_name,
course_title, position)` from Part A. Write every resulting relation,
including primary keys.

`________________________________________________________________`
`________________________________________________________________`

**B4.** Fully normalize `Section(section_id, course_code, course_title,
instructor_id, instructor_name, room, semester)` — the table from this
week's pain slide. Write every resulting relation, including primary
keys, and name each violation you removed.

`________________________________________________________________`
`________________________________________________________________`

**B5 (stretch, optional).** `Employee(employee_id, department_id,
department_manager)`, where the department determines its manager.
Name the violation, the missing normal form, and the fix, in one or two
sentences.

`________________________________________________________________`

---
---

# Instructor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** `student_id → student_name` and `section_id → course_title`
- **A2:** Yes. No repeating groups, no lists inside a cell — every
  attribute holds one atomic value
- **A3:** `student_name` depends only on `student_id`, not on the whole
  key `{student_id, section_id}` — a **partial dependency**, a 2NF
  violation
- **A4/A5:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "Yes, we already fixed the key problem" — that is
  the expected wrong guess, and the whole point of the "not sure yet"
  moment. Do **not** confirm or deny the answer yet
- **A5:** Good answers mention: confusing which attributes count as
  "the whole key" vs. "another non-key attribute," or uncertainty about
  why a single-column key always passes 2NF automatically. Any honest
  gap is a success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "`instructor_name` depends on `instructor_id`,
  not directly on `section_id`, so it is a transitive dependency —
  `section_id → instructor_id → instructor_name`. That violates 3NF
  even though `Section`'s single-column key means 2NF was never at
  risk, which is why passing 2NF alone is not enough."
- **B3 (model answer):** `Waitlist(student_id, section_id, position)`;
  `student_name` moves to `Student(student_id, name, major)`;
  `course_title` moves to `Course(course_code, title)`, reachable
  through `Section`. `PRIMARY KEY (student_id, section_id)` on
  `Waitlist`.
- **B4 (model answer):** `Section(section_id, course_code,
  instructor_id, room, semester)`, `PRIMARY KEY (section_id)`;
  `Course(course_code, title)`, `PRIMARY KEY (course_code)`;
  `Instructor(instructor_id, name)`, `PRIMARY KEY (instructor_id)`.
  Both `course_title` and `instructor_name` were removed as transitive
  dependencies (3NF violations) on `section_id`.
- **B5 (model answer):** `employee_id → department_id →
  department_manager` is transitive — a **3NF violation**. Fix: move
  `department_manager` into its own `Department(department_id,
  manager)` relation.

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- The A4 trap is deliberate: students often think "fixing 2NF" means
  the relation is done. Use the discussion between Part A and Part B to
  surface this before revealing the answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section
