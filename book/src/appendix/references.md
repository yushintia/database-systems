# References & Further Reading

---

## Primary Textbooks

1. **Abraham Silberschatz, Henry F. Korth, S. Sudarshan**, *Database
   System Concepts*, 7th ed., McGraw-Hill Education, 2019.
   The primary textbook for this course. Comprehensive coverage of
   the relational model, SQL, normalization, and transactions, used
   for the chapter mapping below.

2. **Thomas Connolly, Carolyn Begg**, *Database Systems: A Practical
   Approach to Design, Implementation, and Management*, 6th ed.,
   Pearson, 2014.
   Strong on the practical design methodology — conceptual, logical,
   and physical database design — that this course's E-R and
   normalization weeks follow closely.

3. **Ramez Elmasri, Shamkant B. Navathe**, *Fundamentals of Database
   Systems*, 7th ed., Pearson, 2015.
   A clear, thorough alternative treatment of the same core topics;
   useful as a second explanation when the primary text's wording
   does not click.

---

## Week-by-Week Chapter Map

| Week | Topic | Silberschatz (S) | Connolly & Begg (C&B) | Elmasri & Navathe (E&N) |
|---|---|---|---|---|
| 1 | Introduction | S Ch. 1 | C&B Ch. 1 | E&N Ch. 1 |
| 2 | Relational Model | S Ch. 2 | C&B Ch. 3-4 | E&N Ch. 3 |
| 3 | Data Modelling | S Ch. 6 | C&B Ch. 11 | E&N Ch. 3 |
| 4 | E-R Diagram | S Ch. 6 | C&B Ch. 12 | E&N Ch. 3 |
| 5 | Quiz 1 | review | review | review |
| 6 | Mapping Algorithm | S Ch. 6 | C&B Ch. 17 | E&N Ch. 9 |
| 7 | Normalization | S Ch. 7 | C&B Ch. 14-15 | E&N Ch. 14-15 |
| 8 | Midterm | review | review | review |
| 9 | DDL | S Ch. 3-4 | C&B Ch. 6 | E&N Ch. 4 |
| 10 | DML | S Ch. 3-4 | C&B Ch. 6 | E&N Ch. 4 |
| 11 | Single-table Queries | S Ch. 3 | C&B Ch. 6 | E&N Ch. 5 |
| 12 | Multi-table Queries | S Ch. 3, 5 | C&B Ch. 6 | E&N Ch. 6 |
| 13 | Quiz 2 | review | review | review |
| 14 | Case Study Presentation | n/a | n/a | n/a |
| 15 | Final Exam | review | review | review |

---

## MySQL Official Documentation

| Resource | URL | Use |
|---|---|---|
| MySQL 8.0 Reference Manual | <https://dev.mysql.com/doc/refman/8.0/en/> | Authoritative reference for every SQL statement, data type, and function this course uses |
| MySQL Workbench Manual | <https://dev.mysql.com/doc/workbench/en/> | Official documentation for the client used throughout this course's setup and labs |
| MySQL Installer for Windows | <https://dev.mysql.com/doc/mysql-installer/en/> | Details for the Windows install path in [Setup: MySQL & Workbench](../setup/mysql-workbench.md) |
| MySQL 8.0 Error Reference | <https://dev.mysql.com/doc/mysql-errors/8.0/en/> | Full list of numbered error codes, including the ones in [Troubleshooting MySQL](troubleshooting-mysql.md) |

---

## SQL Style References

| Resource | URL | Use |
|---|---|---|
| SQL Style Guide (Simon Holywell) | <https://www.sqlstyle.guide/> | A widely cited, independent SQL formatting guide; broadly compatible with this course's own [SQL Style Guide](sql-style-guide.md) |
| Mozilla Developer Network: SQL basics | <https://developer.mozilla.org/en-US/docs/Glossary/SQL> | A short, plain-language refresher on core SQL vocabulary |

---

## Where to Go Next

After completing this course, you have several paths forward:

### Advanced Database Systems
**Topics you will study:** transactions and concurrency control,
recovery, indexing and query optimization internals, distributed and
NoSQL databases.
**Recommended reading:** Silberschatz Chapters 17-22.
**Connection to this course:** the client/server model in
[How a Database Runs](../setup/how-a-database-runs.md) is the
starting picture; this course stops at the SQL layer.

### Software Engineering / Backend Development
**Topics you will study:** connecting an application (web or mobile)
to a database, object-relational mapping, API design, transactions in
real systems.
**Connection to this course:** every SQL statement you write here is
the same SQL a real backend sends over the same client/server
connection model.

### Data Analytics / Data Science
**Topics you will study:** larger-scale querying, data warehousing,
`GROUP BY`-heavy analytical queries, connecting SQL results to
statistical and visualization tools.
**Connection to this course:** Weeks 11-12 (single- and multi-table
queries) are the direct foundation.
