# Week 11 Worksheet: Querying the Registration System

Database Systems (511783-001). Work with your pair. Write short
answers — full sentences are not required, but write enough that your
partner and the instructor can follow your thinking.

**Pair names:** ___________________________ / ___________________________

---

## Part A (do this in 차시 2, about 15 minutes)

`Enrollment` has real rows in it now. Practice writing single-table
`SELECT` queries against it, using the clauses from class.

**A1.** Write a query returning the `student_id` and `grade` of every
row in `Enrollment` with a `grade` of `'B+'`.

`________________________________________________________________`

**A2.** Write a query returning every distinct `grade` value that
appears anywhere in `Enrollment`.

`________________________________________________________________`

**A3.** Write a query returning the 3 most recent enrollments, sorted
by `student_id`, highest first.

`________________________________________________________________`

**A4.** Prediction: look at this query.

```sql
SELECT * FROM Enrollment WHERE grade = NULL;
```

Some enrollments genuinely have a `NULL` grade (not graded yet). Will
this query return any rows? Circle one.

**Yes** &nbsp;&nbsp;&nbsp;&nbsp; **No** &nbsp;&nbsp;&nbsp;&nbsp; **Not sure**

**A5.** What is one thing about `WHERE` or `NULL` that you are still
not sure about?

`________________________________________________________________`

*Stop here. We compare answers together before you see Part B.*

---

## Part B (do this in 차시 3, about 15 minutes)

Your instructor will hand this out after the class discussion of Part A.
It starts with the real answer to A4, then asks you to explain it.

**The real answer to A4:** No, it returns zero rows, even for the
enrollments that really do have a missing grade. `NULL` means
"unknown," and nothing equals unknown, not even another unknown — so
`= NULL` never matches anything, no matter what.

**B1.** Was your Part A prediction (A4) correct?

`Yes  /  No  /  Partly`

**B2.** Using the words **NULL** and **IS NULL**, explain in 1-2
sentences why `WHERE grade = NULL` silently returns nothing, and what
the correct query should say instead.

`________________________________________________________________`
`________________________________________________________________`

**B3.** Write the correct query, using `IS NULL`, to list every
enrollment (`student_id`, `section_id`) that has not yet been graded.

`________________________________________________________________`

**B4.** Write a query returning the `name` of every `Student` whose
`major` is `'Computer Science'` AND whose `student_id` is greater than
`100`.

`________________________________________________________________`

**B5 (stretch, optional).** This `WHERE` clause is genuinely ambiguous
without parentheses:

```sql
WHERE major = 'Computer Science' OR major = 'Software Engineering' AND student_id > 100
```

Rewrite it using parentheses so it clearly means: "major is CS or SE,
AND, separately, `student_id` is greater than 100."

`________________________________________________________________`

---
---

# Instructor Answer Key — do not hand out this section

## Part A — what to listen for

- **A1:** `SELECT student_id, grade FROM Enrollment WHERE grade = 'B+';`
  — watch for pairs forgetting the quotes around `'B+'`, a very common
  first mistake with text literals
- **A2:** `SELECT DISTINCT grade FROM Enrollment;` — watch for pairs
  forgetting `DISTINCT` and just writing `SELECT grade FROM
  Enrollment;`, which returns one row per enrollment, not one per
  unique grade
- **A3:** `SELECT * FROM Enrollment ORDER BY student_id DESC LIMIT 3;`
  — watch for pairs leaving out `DESC` (giving the 3 *oldest* rows
  instead of most recent) or leaving out `LIMIT` entirely
- **A4:** Accept any prediction if the reasoning is coherent. Many
  pairs will guess "Yes, since some rows really do have `grade =
  NULL`" — that is the expected wrong guess, and the whole point of the
  "not sure yet" moment. Do **not** confirm or deny the answer yet
- **A5:** Good answers mention: confusion about why `= NULL` doesn't
  work, uncertainty about when quotes are needed around text, or not
  being sure `WHERE` only affects rows and not columns. Any honest gap
  is a success

## Part B — model answers

- **B1:** Depends on their A4 guess; there is no wrong answer here,
  just self-checking
- **B2 (model answer):** "`NULL` means an unknown value, not zero and
  not empty text. Because nothing equals an unknown value, not even
  another unknown, `= NULL` can never be true. The correct test is
  `WHERE grade IS NULL`, a special comparison built just for this
  case."
- **B3 (model answer):**
  ```sql
  SELECT student_id, section_id FROM Enrollment
  WHERE grade IS NULL;
  ```
- **B4 (model answer):**
  ```sql
  SELECT name FROM Student
  WHERE major = 'Computer Science' AND student_id > 100;
  ```
- **B5 (model answer):**
  ```sql
  WHERE (major = 'Computer Science' OR major = 'Software Engineering')
    AND student_id > 100
  ```
  MySQL evaluates `AND` before `OR` by default, so the original,
  unparenthesized clause actually means "CS majors (any student_id) OR
  (SE majors with student_id > 100)" — not what most people read it as
  at a glance. This is exactly why the lecture says never rely on
  memory, always add parentheses.

## Facilitation notes

- Total time: Part A ~15 min (prediction only, no reveal), short
  instructor-led discussion, Part B ~15 min (reveal + explain)
- Do not let Part A run long — the value is in predicting under
  uncertainty, not in getting the "right" answer
- If a pair finishes Part B early, point them to the handout's
  "Optional Reading" section, or have them try the `LIKE` and `IN`
  practice problems from the handout out loud with their partner
