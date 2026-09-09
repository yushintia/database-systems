# Troubleshooting MySQL

This appendix is your reference for the errors and surprises you are
most likely to hit while working through this course's labs. Each row
is one **Mistake** (what you probably did), its **Symptom** (what
MySQL shows you), and the **Fix**.

See [How a Database Runs](../setup/how-a-database-runs.md) for the
client/server mental model behind several of these.

---

## Connection and Access Errors

| Mistake | Symptom | Fix |
|---|---|---|
| Wrong password, or typed the username/password in the wrong order | `ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: YES)` | Re-check your password (case-sensitive). In the `mysql` CLI, the syntax is `mysql -u <username> -p`, then it prompts you separately — do not put the password directly after `-p` with a space. |
| Tried to connect before the server finished starting, or the MySQL service is stopped | Connection refused, or Workbench cannot reach `localhost:3306` | Confirm the MySQL service/daemon is running (Windows: Services app; macOS: System Settings → MySQL pane; Linux: `systemctl status mysqld`). Start it if stopped, then retry. |
| Long-running query, laptop went to sleep, or the server timed out an idle connection | Workbench shows **"Lost connection to MySQL server"** mid-query, or your next statement fails | This does not mean your data is gone — it means the *link* dropped, not the server. Click Workbench's reconnect option (or close and reopen the connection tab), then re-run your last statement. If you were mid-transaction, assume it did not commit and check your data before repeating any `INSERT`/`UPDATE`. |

---

## Database and Table Errors

| Mistake | Symptom | Fix |
|---|---|---|
| Ran a query before selecting a schema | `ERROR 1046 (3D000): No database selected` | Run `USE registration_db;` (or whatever your lab's schema is named) before anything else. This is the single most common first mistake every week — get in the habit of running the seed script's `USE ...;` line first thing in every session. |
| Typo'd the database name, or the seed script was never run | `ERROR 1049 (42000): Unknown database 'course_registraton'` | Check spelling carefully, and confirm you actually ran the lab's seed script (`DROP DATABASE IF EXISTS ...; CREATE DATABASE ...;`) in this MySQL instance first. |
| Typo'd a table name, queried a table before creating it, or ran `DROP TABLE` earlier in the session and forgot | `ERROR 1146 (42S02): Table 'registration_db.Studnet' doesn't exist` | Check spelling and casing (see the case-sensitivity row below). Run `SHOW TABLES;` to see what actually exists in the current schema right now. |
| Forgot `USE database_name;` first, ran a query, then it partially worked because you had used a *different* schema in an earlier session | Query runs but returns unexpected/empty results, or fails with the "doesn't exist" error above against a table you know you created | Run `SELECT DATABASE();` to see which schema you are currently inside. Re-run `USE ...;` for the correct one. |

---

## Syntax and Constraint Errors

| Mistake | Symptom | Fix |
|---|---|---|
| Missing comma, stray keyword, missing closing parenthesis, or using a reserved word as an identifier | `ERROR 1064 (42000): You have an error in your SQL syntax; check the manual ... near '...' at line N` | MySQL points at *roughly* where it got confused, which is sometimes one token *after* the real mistake. Read the line number, check the statement just before it for a missing `,` or `)`. If you used a word like `order` or `key` as a column name, wrap it in backticks: `` `order` ``. |
| Tried to `INSERT` a row whose foreign key value does not exist in the parent table yet (e.g., inserting an `Enrollment` row for a `student_id` that isn't in `Student`) | `ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails` | Insert parent rows first, in dependency order: `Student`/`Course`/`Instructor` before `Section`, and `Section` before `Enrollment`. Double-check the value you're referencing actually exists with a quick `SELECT`. |
| Tried to `DELETE` a row that other rows still reference (e.g., deleting a `Course` row while `Section` rows still point at it) | `ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails` | Delete child rows first (e.g., delete the `Section`/`Enrollment` rows that reference this course before deleting the `Course` row itself), or reconsider whether you actually meant to delete the parent at all. |

---

## Case-Sensitivity Surprises

| Mistake | Symptom | Fix |
|---|---|---|
| Wrote a table name with different casing than you created it with, and moved between operating systems (or a shared server) | Query fails with "doesn't exist" on one machine but works fine on another | On **Linux**, MySQL table names are usually **case-sensitive** at the file-system level (table names map to files on disk). On **Windows and macOS**, they are usually **case-insensitive** by default. This means `Student` and `student` can be two different tables on Linux but the same table on Windows/macOS. **Always type table and column names with the exact casing you created them with** ([SQL Style Guide](sql-style-guide.md): `PascalCase` tables, `snake_case` columns), so your scripts behave identically everywhere. |

---

## General First-Response Checklist

When something goes wrong and you are not sure why:

- [ ] Run `SELECT DATABASE();` — are you even in the schema you think you are?
- [ ] Run `SHOW TABLES;` — does the table you're querying actually exist, with that exact name?
- [ ] Read the error's line number and text carefully — MySQL usually tells you almost exactly where it got confused
- [ ] If in doubt about your data's current state, re-run the lab's seed script from the top (see [Setup: MySQL & Workbench](../setup/mysql-workbench.md)) — it is idempotent by design, so this is always safe
- [ ] For a foreign key error, check insertion/deletion order against the schema's dependency order in [Case Study Reference](case-study-reference.md)
