# Week 10 Handout: DML

Database Systems (511783-001) — for students to keep and read again.
Use plain, simple English on purpose, so it is easy to read even if
English is not your first language.

---

## 1. Glossary: Key Words This Week

Read each definition once now. You do not need to memorize them today —
you will use them all semester.

| Term | Plain definition |
|---|---|
| **DML (Data Manipulation Language)** | The part of SQL used to insert, change, retrieve, and remove data inside a table structure that already exists |
| **DDL (recap)** | Last week's part of SQL: `CREATE`, `ALTER`, `DROP`. DDL builds structure; DML fills and changes what is inside it. You cannot run DML against a table DDL has not created yet |
| **INSERT** | The DML command that adds one or more new rows to a table |
| **UPDATE** | The DML command that changes the values in existing rows |
| **DELETE** | The DML command that removes existing rows from a table |
| **WHERE clause** | The part of `UPDATE` or `DELETE` that limits the change to specific rows. Without it, the statement applies to every row in the table |
| **AUTO_INCREMENT (recap)** | A Week 9 column setting where MySQL assigns the next whole number automatically. This is why `INSERT` does not need to list `student_id` by hand |
| **LAST_INSERT_ID()** | A MySQL function that returns the auto-generated key value from the row you just inserted, so a second `INSERT` can reuse it as a foreign key |
| **NULL** | A special marker meaning "no value recorded yet," such as a grade that has not been posted. It does not mean zero or empty text |
| **Insert order** | Rows must be inserted into a table only after any row they reference by foreign key already exists. This follows the exact dependency order Week 9 used for `CREATE TABLE` |
| **Referential integrity (recap)** | The rule that every foreign key value must match an existing primary key value in the referenced table. MySQL enforces this on `INSERT` and, in the opposite direction, on `DELETE` |
| **Orphaned row** | A row that would be left pointing at a foreign key value that no longer exists. MySQL blocks any `DELETE` that would create one |
| **Multi-row INSERT** | One `INSERT` statement that adds several rows at once, using one `VALUES` list with multiple entries, separated by commas |
| **System R** | The 1970s research database where `SELECT`, `INSERT`, `UPDATE`, and `DELETE` were first implemented together, essentially unchanged since |
| **SELECT (recap)** | The DML command that reads data back out. Used this week only to check a row before or after changing it; its full syntax is Week 11's job |

---

## 2. One Student's Whole Semester, Worked Out Step by Step

This is the full version of the story from class. Read it slowly if the
in-class pace felt fast.

**The situation.** The registration schema from Week 9 is live in
MySQL. Every table exists exactly as designed: `Student`, `Course`,
`Instructor`, `Section`, `Enrollment`, every constraint from Weeks 2-7
enforced automatically. A professor logs in and asks a simple
question: "who is enrolled in my section?"

`SELECT * FROM Enrollment;` runs instantly, correctly, and returns
nothing. Not because anything is broken — the query is fine, the
schema is fine — there is simply no data yet. A perfectly empty room
answers every question the same way: silence. The only command that
can end this silence is `INSERT`.

Here is that fix, followed end to end, for one real student, Park
Jiho, from enrollment to a grade correction to withdrawal. Four steps,
each building on the last, using all three commands from this week in
the order a real semester actually happens.

**Step 1: Enroll.** First the student has to exist, then the
enrollment can point at them.

```sql
INSERT INTO Student (name, major)
VALUES ('Park Jiho', 'Software Engineering');
-- MySQL assigns student_id = 12

INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (12, 3, NULL);
```

`student_id` is never typed by hand — `AUTO_INCREMENT` from Week 9
generates it. `grade` is `NULL` on purpose: `NULL` means "not graded
yet," not "zero." Note the order: `Student` first, `Enrollment`
second, because `Enrollment.student_id` is a foreign key. Inserting it
first would fail immediately, the same dependency order Week 9 used
for `CREATE TABLE`.

**Step 2: Verify.** Before changing anything, check the actual current
state.

```sql
SELECT * FROM Enrollment WHERE student_id = 12;
```

| student_id | section_id | grade |
|---|---|---|
| 12 | 3 | NULL |

This is the same discipline this week's safe-`UPDATE` practice slide
teaches: check first, with the exact `WHERE` you are about to use,
before trusting your assumption about what the table currently holds.

**Step 3: Grade posted, then corrected.** A grade gets entered, and
later someone notices a data-entry mistake.

```sql
UPDATE Enrollment SET grade = 'B0'
WHERE student_id = 12 AND section_id = 3;
-- a data-entry mistake noticed later

UPDATE Enrollment SET grade = 'A0'
WHERE student_id = 12 AND section_id = 3;
```

Two `UPDATE` statements, same row, same precise `WHERE` both times.
The second one is not a workaround — it is exactly what `UPDATE` is
for: correcting one specific fact without touching any other row or
any other table.

**Step 4: Withdrawal.** The student drops the section.

```sql
DELETE FROM Enrollment
WHERE student_id = 12 AND section_id = 3;
```

The enrollment row is gone. Park Jiho still exists in `Student` —
only this one enrollment record was removed. That precision is what
`WHERE` makes possible on `DELETE`, exactly as it does on `UPDATE`.

**What we still can't say yet.** The registration schema now has real
data in it: inserted, updated, and deleted safely. But answering "who
is enrolled in CSE301?" still means running
`SELECT * FROM Enrollment;` and reading every row by eye to find the
ones that match — exactly Week 1's original 40,000-row problem, just
with real data underneath it now instead of a spreadsheet. Data is in.
There is still no way to actually ask it a question. That is Week 11's
job: `SELECT`, `WHERE`, `DISTINCT`, and `ORDER BY`.

---

## 3. Optional Reading: Extra Detail (Not Required, Not on the Quiz)

This section holds extra explanations that were trimmed from the
slides to keep class time short. Read it if you are curious or want
more examples.

**DML is behind every button you have ever clicked.** `INSERT`,
`UPDATE`, and `DELETE` are not abstract classroom commands — they are
the literal mechanism behind every "save," "edit," and "delete" button
in every app you use.

- **"Save" in any app** is an `INSERT` (a new row) or an `UPDATE` (an
  existing row), depending on whether the row already exists
- **"Delete post"** is a `DELETE`, scoped by something like
  `WHERE post_id = ...`
- **"Edit profile"** is an `UPDATE`, scoped by
  `WHERE user_id = <the logged-in user>` — never anyone else's

That last one is worth pausing on. Every app that lets you edit your
own profile but never someone else's is relying on a correct `WHERE`
clause. A missing or wrong one there is a real security bug, not just
a data bug — an `UPDATE` or `DELETE` with the wrong `WHERE` can change
or erase another user's row instead of your own.

**Why real systems prefer multi-row `INSERT`.** Loading an entire
class roster as one hundred separate `INSERT` statements works, but it
is one hundred round trips to the database. A single multi-row
`INSERT`, one statement, many rows in one `VALUES` list, is the
pattern real systems use for batch loading, because it is both faster
and easier to run as a single all-or-nothing operation.

**Why `DELETE` blocking an orphaned row matters beyond this course.**
The same referential integrity rule that stops
`DELETE FROM Instructor WHERE instructor_id = 1;` while that instructor
still teaches a `Section` is what stops a real system from ever
showing a class with no instructor, or an order with no customer. The
rule feels like a classroom inconvenience here; in production it is
the thing that keeps the data trustworthy.

**Who actually works with this, as a job.**

- **Backend engineers** write the `INSERT`, `UPDATE`, and `DELETE`
  statements (often generated by a framework, but built on exactly
  this syntax) behind every form and button in an application
- **Database administrators** watch for `UPDATE` or `DELETE`
  statements running without a `WHERE` clause in production, because
  that mistake is one of the most common causes of real data-loss
  incidents
- **Data engineers** write batch `INSERT` jobs that load large amounts
  of data into a warehouse on a schedule, using exactly the multi-row
  pattern from this week

---

## 4. Practice Problems (With Answers)

Try each problem yourself before checking the answer underneath it.

**Problem 1.** Write the `INSERT` statement to add a new student,
"Jung Haeun," major "Data Science," to `Student`.

> **Answer:**
> ```sql
> INSERT INTO Student (name, major)
> VALUES ('Jung Haeun', 'Data Science');
> ```

**Problem 2.** Add a new student, "Oh Seungmin," major "Computer
Science," and enroll him in `section_id = 4`, in the correct order.

> **Answer:**
> ```sql
> INSERT INTO Student (name, major)
> VALUES ('Oh Seungmin', 'Computer Science');
>
> INSERT INTO Enrollment (student_id, section_id, grade)
> VALUES (LAST_INSERT_ID(), 4, NULL);
> ```
> `LAST_INSERT_ID()` retrieves the `student_id` MySQL just generated
> for "Oh Seungmin," exactly the value the second statement's foreign
> key needs.

**Problem 3.** Student `student_id = 1` changes major from "Computer
Science" to "Data Science." Write the safest possible `UPDATE`,
checking the target row first.

> **Answer:**
> ```sql
> SELECT * FROM Student WHERE student_id = 1;  -- check first
> UPDATE Student SET major = 'Data Science' WHERE student_id = 1;
> ```

**Problem 4.** `section_id = 7` moves to a new room, "성파 615." Write
the `UPDATE` statement.

> **Answer:**
> ```sql
> UPDATE Section SET room = '성파 615' WHERE section_id = 7;
> ```
> `WHERE section_id = 7` is required — leaving it off would change the
> room for every section in the table.

**Problem 5.** Student `student_id = 12` withdraws from
`section_id = 4`. Write the `DELETE` statement.

> **Answer:**
> ```sql
> DELETE FROM Enrollment
> WHERE student_id = 12 AND section_id = 4;
> ```
> Only this one enrollment row is removed; `Student` and every other
> table stay untouched.

**Problem 6.** A teaching assistant runs this statement, and MySQL
rejects it:

```sql
INSERT INTO Section (course_code, instructor_id, room, semester)
VALUES ('CSE410', 9, '성파 810', '2026-2');
```

`instructor_id = 9` does not exist yet in `Instructor`. Explain why
this fails, and write the corrected pair of statements in the right
order.

> **Answer:** `Section.instructor_id` is a foreign key referencing
> `Instructor.instructor_id`. MySQL checks this immediately and
> rejects any row that points at an instructor who does not exist yet
> — the same dependency order Week 9 used for `CREATE TABLE`. The
> referenced row must be inserted first:
> ```sql
> INSERT INTO Instructor (name) VALUES ('Prof. Kwon');
> -- MySQL assigns instructor_id = 9
>
> INSERT INTO Section (course_code, instructor_id, room, semester)
> VALUES ('CSE410', 9, '성파 810', '2026-2');
> ```
