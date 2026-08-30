# Answer Key

1. **B** — `WHERE` is a yes/no test applied to every row; it narrows
   rows, not columns. That job belongs to `SELECT`
2. **C** — `NULL` means "unknown," and nothing equals unknown, not even
   another unknown, so `= NULL` never matches; `IS NULL` is the only
   correct test
3. **B** — `=` requires an exact match; `LIKE` matches a pattern, with
   `%` standing in for "anything, including nothing"
4. **C** — a relation has no meaningful order by definition; without
   `ORDER BY`, MySQL is free to return rows in whatever order is
   convenient internally
5. **B** — `DISTINCT` removes duplicate rows from the result, so each
   different value appears exactly once
6. **A** — `LIMIT 5` returns only the first 5 rows of the (possibly
   sorted) result; it is MySQL's own syntax, not shared by every
   database product
7. **Model answer:**
   ```sql
   SELECT name FROM Student
   WHERE major IN ('Computer Science', 'Software Engineering');
   ```
8. **Model answer:** "`SELECT * FROM Enrollment;` returns every row and
   every column with no filtering, so a person still has to scroll
   through all of it by eye. Adding `WHERE grade = 'A0'` makes the
   database do the filtering directly, instead of a person doing it
   manually."
