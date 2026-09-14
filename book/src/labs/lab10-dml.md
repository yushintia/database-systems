# Lab 10: DML — Populating and Changing Data

| | |
|---|---|
| **Week** | 10 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Lecture & Lab |
| **Prerequisites** | Lab 09 (your own registration schema, or the catch-up file below) |
| **Files provided** | [`files/lab10/catchup_schema.sql`](files/lab10/catchup_schema.sql) — full schema, zero rows |

**Why this lab matters:** Lab 9 gave you five perfectly structured, perfectly empty tables. A schema with no data cannot demonstrate anything, cannot be tested, and cannot answer a single real question. This lab is where the registration system stops being an empty shell and starts holding real facts: real students, real enrollments, real grades. `INSERT`, `UPDATE`, and `DELETE` are also the literal mechanism behind every "save," "edit," and "delete" button you have ever clicked in any app — this lab is where you write that mechanism yourself, by hand.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Concept) | 50 | 5 recap Lab 9 · 30 INSERT/UPDATE/DELETE, NULL, subqueries in DML · 15 live demo (Worked Examples) |
| B (Guided practice) | 50 | 40 guided data population and mutation, with checkpoints · 10 debrief and pitfalls |
| C (Independent and wrap) | 50 | 35 independent practice problems · 10 challenge problem · 5 submit and Week 11 preview |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Insert one or more rows into a table with `INSERT INTO ... VALUES`, respecting foreign-key order.
2. Change existing data safely with `UPDATE ... SET ... WHERE`.
3. Remove rows safely with `DELETE FROM ... WHERE`, and explain what MySQL protects against.
4. Read and react correctly to a referential-integrity error caused by inserting or deleting in the wrong order.

---

## Recap

Lab 9 delivered the entire registration schema, created for real in MySQL, every constraint enforced automatically. It also left every table perfectly empty: `SELECT * FROM Student;` returns zero rows, not because anything is broken, but because nothing has been put in yet. A perfect empty room answers every question the same way — silence. The only command that ends this silence is `INSERT`.

**If your Lab 9 schema did not work, or you are not confident it is correct:** run [`files/lab10/catchup_schema.sql`](files/lab10/catchup_schema.sql) instead. It builds the exact same five tables — same names, same columns, same constraints — with zero rows, so you can do this lab's work without being blocked by a broken schema from last week. Using it is not a penalty; one rough week should not cost you the rest of the semester.

---

## Background

### DML: The Second of SQL's Two Families

> **In plain words: DML**
> **Data Manipulation Language (DML)** is the part of SQL used to insert, change, retrieve, and remove data *inside* a table structure that already exists. `INSERT`, `UPDATE`, `DELETE`, and `SELECT` are all DML. You cannot run DML against a table that DDL (Lab 9) has not created first.

### INSERT: Adding Rows

```sql
INSERT INTO Student (name, major)
VALUES ('Kim Minji', 'Computer Science');
```

`student_id` is not listed — `AUTO_INCREMENT` from Lab 9 generates it automatically. A single statement can also insert several rows at once, which real systems always prefer over many separate statements:

```sql
INSERT INTO Student (name, major) VALUES
    ('Kim Minji', 'Computer Science'),
    ('Park Jiho', 'Software Engineering'),
    ('Han Somin', 'Computer Science');
```

### Insert Order Follows Lab 9's Dependency Order

`INSERT` checks foreign keys exactly as strictly as `CREATE TABLE` checked table dependencies:

```sql
INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE301', 1, '성파 702', '2026-1');
```

This fails immediately if `course_code = 'CSE301'` does not already exist in `Course`, or `instructor_id = 1` does not exist in `Instructor`. The referenced rows must be inserted **first** — the exact same dependency order Lab 9 used for `CREATE TABLE`.

> **In plain words: orphaned row**
> An **orphaned row** is a row that points, by foreign key, at a value that does not exist in the referenced table. MySQL refuses to create one on `INSERT`, and refuses to create one on `DELETE` too (see below) — a foreign key is a promise the database keeps in both directions.

### NULL: What You Can and Cannot Omit

```sql
INSERT INTO Enrollment (student_id, section_id)
VALUES (12, 3);
```

`grade` is left out entirely; MySQL fills it with `NULL`, meaning "not yet graded" — not zero, not empty text, but *unknown*. This only works because `grade` was declared without `NOT NULL` in Lab 9.

- **Can omit:** any `AUTO_INCREMENT` column, any column with a `DEFAULT`, any column that allows `NULL`.
- **Cannot omit:** any column declared `NOT NULL` with no `DEFAULT` — MySQL has nothing to put there instead, and rejects the statement.

### UPDATE: Changing Existing Data

```sql
UPDATE Instructor
SET name = 'Lee, Married Name'
WHERE instructor_id = 1;
```

> **In plain words: the WHERE clause is not optional**
> Run `UPDATE Instructor SET name = 'Lee, Married Name';` with no `WHERE` at all, and MySQL updates **every row in the table** to the exact same name. There is no undo button once this commits. Always write the `WHERE` clause mentally, before the `SET`, not after.

### DELETE: Removing Rows, and What MySQL Protects

```sql
DELETE FROM Enrollment
WHERE student_id = 7 AND section_id = 3;
```

Like `UPDATE`, `DELETE` with no `WHERE` clause removes every row in the table, silently, all at once. And exactly like `INSERT`, `DELETE` is checked against foreign keys — in the opposite direction:

```sql
DELETE FROM Instructor WHERE instructor_id = 1;
```

If instructor 1 still teaches any `Section`, MySQL rejects this by default. Referential integrity forbids leaving a `Section` pointing at an instructor who no longer exists — the sections must be reassigned or removed first. See [Troubleshooting MySQL](../appendix/troubleshooting-mysql.md) for the exact error messages both directions of this rule produce.

### Subqueries Inside DML

> **In plain words: subquery**
> A **subquery** is a complete `SELECT` statement nested inside another statement's `WHERE` clause. MySQL runs the inner `SELECT` first, producing a list of values, then runs the outer statement's condition against that list.

```sql
DELETE FROM Enrollment
WHERE student_id IN (
    SELECT student_id FROM Student
    WHERE major = 'Software Engineering'
);
```

The inner `SELECT` finds every Software Engineering student's `student_id`; the outer `DELETE` removes exactly their enrollments. A good habit: run the inner `SELECT` by itself first, and look at what it actually returns, before wrapping it in a `DELETE` or `UPDATE` you cannot easily undo.

---

## Worked Examples

### Example 1: One Student's Whole Semester

Four steps, one student, from enrollment to a grade correction to withdrawal — every DML command in this lab, used in the order a real semester actually happens.

**Step 1 — Enroll:**

```sql
INSERT INTO Student (name, major)
VALUES ('Park Jiho', 'Software Engineering');
-- MySQL assigns student_id = 12

INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (12, 3, NULL);
```

**Step 2 — Verify before changing anything:**

```sql
SELECT * FROM Enrollment WHERE student_id = 12;
```

| student_id | section_id | grade |
|---|---|---|
| 12 | 3 | NULL |

**Step 3 — Grade posted, then corrected:**

```sql
UPDATE Enrollment SET grade = 'B0'
WHERE student_id = 12 AND section_id = 3;
-- a data-entry mistake noticed later

UPDATE Enrollment SET grade = 'A0'
WHERE student_id = 12 AND section_id = 3;
```

**Step 4 — Withdrawal:**

```sql
DELETE FROM Enrollment
WHERE student_id = 12 AND section_id = 3;
```

#### Line by line

| Line | What it does |
|------|-------------|
| `VALUES (12, 3, NULL)` | `grade` is explicitly `NULL` — "not graded yet." The enrollment is fully valid without a grade. |
| `SELECT * FROM Enrollment WHERE student_id = 12;` | Checking actual state before trusting an assumption — the same discipline used before every `UPDATE` or `DELETE` in this lab. |
| Two `UPDATE` statements, same `WHERE` | The second `UPDATE` is not a workaround. Correcting one fact without touching any other row is exactly what `UPDATE` is for. |
| `DELETE FROM Enrollment WHERE student_id = 12 AND section_id = 3;` | Removes exactly one row. `Student` is untouched — Park Jiho still exists, only this one enrollment record is gone. |

### Example 2: A Foreign-Key Failure, Fixed

```sql
INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE410', 9, '성파 810', '2026-1');
-- ERROR 1452 (23000): Cannot add or update a child row:
-- a foreign key constraint fails
```

`instructor_id = 9` does not exist yet in `Instructor`. The fix is to insert the referenced row first:

```sql
INSERT INTO Instructor (name) VALUES ('Prof. Kwon');
-- MySQL assigns instructor_id = 9

INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE410', 9, '성파 810', '2026-1');
```

---

## Guided In-Lab Exercises

Work against your own Lab 9 schema, or [`files/lab10/catchup_schema.sql`](files/lab10/catchup_schema.sql) if you are catching up. Save your `INSERT` statements into **`lab10_insert_data.sql`**, and your `UPDATE`/`DELETE` statements into a separate file, **`lab10_changes.sql`**.

### Exercise 1: Populate the Independent Tables (Part B)

Insert at least 3 rows into `Instructor`, 3 rows into `Course`, and 5 rows into `Student`, using at least one multi-row `INSERT` statement.

**Checkpoint:** run `SELECT COUNT(*) FROM Student;` — confirm it matches how many rows you inserted.

### Exercise 2: Populate Section (Part B)

Insert at least 4 rows into `Section`, referencing only `course_code` and `instructor_id` values you already inserted in Exercise 1.

**Checkpoint — predict before you run it:** what error would you get if you tried to insert a `Section` row referencing `instructor_id = 999`? Try it, confirm your prediction, then remove that row.

### Exercise 3: Populate Enrollment, Including a NULL Grade (Part B)

Insert at least 8 rows into `Enrollment`. At least two rows must have `grade` omitted (or explicitly `NULL`), representing enrollments not yet graded.

**Checkpoint:** run `SELECT * FROM Enrollment WHERE grade IS NULL;` — confirm it returns exactly the rows you expect.

### Exercise 4: A Safe UPDATE (Part B/C)

Pick one `Section` row. First run a `SELECT` with the exact `WHERE` you are about to use, to confirm which row you are about to change. Then run the matching `UPDATE`, changing its `room`.

**Checkpoint:** run the same `SELECT` again — confirm only that one row changed.

### Exercise 5: A DELETE That Hits a Foreign-Key Error, on Purpose (Part C)

Try to `DELETE` an `Instructor` row that still has a `Section` referencing it. Copy the exact error message. Then write the correct two-step fix (reassign or delete the dependent `Section` row first, then delete the `Instructor`), and confirm it works. See [Troubleshooting MySQL](../appendix/troubleshooting-mysql.md) if the message is unclear.

### Exercise 6: Final Assembly (Part C)

Combine your work into the two required files:

- `lab10_insert_data.sql` — every `INSERT` statement from Exercises 1–3, in valid dependency order.
- `lab10_changes.sql` — the `UPDATE` and `DELETE` statements from Exercises 4–5 (including the deliberate foreign-key failure and its fix, commented out or clearly marked so the file still runs cleanly top to bottom).

---

## Challenge Problem

Write one `INSERT ... SELECT` statement that copies every `Enrollment` row with a non-`NULL` grade into a new table `Transcript(student_id, section_id, grade, archived_on)`, stamped with today's date using `CURDATE()`. Then write one `INSERT ... ON DUPLICATE KEY UPDATE` statement ("upsert") that re-enrolls a student already in `Enrollment` without raising a duplicate-key error, updating their grade instead.

File: `lab10_challenge.sql`

---

## Practice Problems

These are ungraded: extra practice for the concepts in this lab. Solutions are not distributed with this page.

### Practice 1: Add and Enroll, in Order

Write the `INSERT` statements to add a new student, "Jung Haeun," major "Data Science," and enroll her in `section_id = 4` with no grade yet, using `LAST_INSERT_ID()` for the foreign key.

### Practice 2: A Safe UPDATE, Checked First

Student `student_id = 1` changes major from "Computer Science" to "Data Science." Write the safest possible `UPDATE`, checking the target row first.

### Practice 3: A Room Change

`section_id = 7` moves to a new room, "성파 615." Write the `UPDATE` statement.

### Practice 4: A Precise Withdrawal

Student `student_id = 12` withdraws from `section_id = 4`. Write the `DELETE` statement.

### Practice 5: Diagnosing a Rejected INSERT

A teaching assistant runs an `INSERT INTO Section` statement referencing `instructor_id = 9`, which does not exist yet. Explain why MySQL rejects it, and write the corrected pair of statements in the right order.

### Practice 6: Deleting by Subquery

Write a statement removing every `Enrollment` row belonging to students whose `major = 'Software Engineering'`.

### Practice 7: Upserting a Loan Record

A `Loan(book_isbn, member_id, due_date)` table has `PRIMARY KEY(book_isbn, member_id)`. Write one statement that inserts a new loan, or extends the due date if that member already has that book checked out.

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Running `UPDATE` or `DELETE` with no `WHERE` clause | Every row in the table changes or disappears, silently | Always write and check the `WHERE` clause before running the statement — see [Troubleshooting MySQL](../appendix/troubleshooting-mysql.md) |
| Inserting into a table before its foreign-key targets exist | `ERROR 1452 (23000): Cannot add or update a child row` | Respect Lab 9's dependency order for `INSERT` too: parents before children |
| Deleting a row other rows still reference | `ERROR 1451 (23000): Cannot delete or update a parent row` | Delete or reassign the dependent rows first, or reconsider whether the parent should really be deleted |
| Wrapping a subquery in `DELETE`/`UPDATE` without checking it alone first | The outer statement silently touches the wrong rows | Run the inner `SELECT` by itself, confirm the rows it returns, before wrapping it |
| Assuming `DELETE` cascades automatically | A blocked `DELETE`, not a cascading one | By default it does not cascade; only a `FOREIGN KEY ... ON DELETE CASCADE` clause makes it cascade |

---

## Submission and Rubric

| Deliverable | Filename | Points |
|-------------|----------|--------|
| All required rows inserted, correct order, runs cleanly | `lab10_insert_data.sql` | 4 |
| `UPDATE`/`DELETE` correct and safe (`WHERE` present, checked first) | `lab10_changes.sql` | 4 |
| Style: header comment, named files, formatting per the [SQL Style Guide](../appendix/sql-style-guide.md) | both files | 2 |

**Total: 10 points**

---

## Further Reading

- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th ed., Chapter 3-4 (SQL DML)
- [SQL Style Guide](../appendix/sql-style-guide.md)
- [Troubleshooting MySQL](../appendix/troubleshooting-mysql.md) — foreign-key error messages in both directions
