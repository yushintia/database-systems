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
