# Week 12 Self-Check Quiz (Ungraded)

Database Systems (511783-001). This quiz is **ungraded** — it is only
to help you check what stuck. About 10 minutes. Do not look back at the
slides while you answer.

---

**1.** What does `INNER JOIN` return?

A. Every row from both tables, matched or not
B. Only rows where a match exists on both sides
C. Only rows from the left table
D. Only rows where no match exists

**2.** What does `LEFT JOIN` do differently from `INNER JOIN`?

A. It keeps every row from the left table, even without a match, filling missing columns with `NULL`
B. It only returns rows from the right table
C. It removes duplicate rows automatically
D. It sorts the result before returning it

**3.** What is the purpose of the `ON` clause in a JOIN?

A. It names the columns to display in the result
B. It states the condition used to match rows between the two tables
C. It sorts the joined result
D. It limits how many rows come back

**4.** What happens if you write a `JOIN` with no matching condition at all?

A. MySQL raises an error and refuses to run the query
B. It automatically adds a matching condition based on foreign keys
C. It returns every possible pairing of rows from both tables, an enormous, meaningless result
D. It silently returns zero rows

**5.** What does `GROUP BY` do?

A. Sorts rows in ascending order
B. Removes rows that do not match a condition
C. Clusters rows sharing the same value in one or more columns, so an aggregate function can summarize each group separately
D. Combines two tables into one

**6.** Which clause filters entire groups, after aggregation has already
happened?

A. `WHERE`
B. `ON`
C. `HAVING`
D. `USING`

**7.** Write a query listing every `Instructor`'s name and the number of
`Section`s they teach, including instructors teaching zero sections
this semester. (Schema: `Instructor(instructor_id PK, name)`,
`Section(section_id PK, course_code FK, instructor_id FK, room, semester)`.)

`_____________________________________________________________`

`_____________________________________________________________`

`_____________________________________________________________`

**8. (Short answer)** In 1-2 sentences, explain why
`SELECT major, COUNT(*) FROM Student WHERE COUNT(*) > 5;` is invalid.
Use the key word **HAVING** in your answer.

`_____________________________________________________________`

`_____________________________________________________________`

---
---

# Answer Key

1. **B** — `INNER JOIN` returns only rows where a match exists on both sides; a row with no match on the other side disappears entirely
2. **A** — `LEFT JOIN` keeps every row from the left table, even without a match, filling the missing columns with `NULL`
3. **B** — `ON` states the matching condition, usually a foreign key matching a primary key
4. **C** — with no `ON` condition, a `JOIN` returns every possible pairing of rows from both tables, an enormous, meaningless result
5. **C** — `GROUP BY` clusters rows sharing the same value into groups, so an aggregate function can summarize each group separately
6. **C** — `HAVING` filters entire groups after grouping and aggregation; `WHERE` filters individual rows before grouping happens

7. **Model answer:**
   ```sql
   SELECT Instructor.name, COUNT(Section.section_id) AS sections_taught
   FROM Instructor
   LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
   GROUP BY Instructor.name;
   ```
   `LEFT JOIN` from `Instructor` is required — an `INNER JOIN` would
   silently drop any instructor with zero sections, exactly the rows
   this question needs kept.

8. **Model answer:** "`COUNT(*)` is an aggregate value that does not
   exist until after grouping happens, so it cannot be used inside
   `WHERE`. Filtering on an aggregate value like `COUNT(*) > 5`
   requires `HAVING` instead, after a `GROUP BY major` clause."
