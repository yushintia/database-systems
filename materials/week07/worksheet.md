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
