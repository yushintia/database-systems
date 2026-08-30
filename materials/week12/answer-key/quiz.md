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
