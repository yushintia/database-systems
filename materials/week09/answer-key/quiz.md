# Answer Key

1. **A** — DDL is Data Definition Language, the part of SQL that
   defines and changes structure: tables, columns, and constraints
2. **C** — `SELECT` manipulates and reads data, it is DML, not DDL;
   `CREATE`, `ALTER`, and `DROP` are all DDL
3. **B** — `AUTO_INCREMENT` tells MySQL to generate the next whole
   number automatically on every insert
4. **C** — MySQL rejects the statement immediately; a foreign key can
   only reference a table that already exists
5. **B** — `PRIMARY KEY (student_id, section_id)`, written on its own
   line, declares one primary key made of both columns together
6. **B** — without `NOT NULL`, MySQL allows the column to be left
   empty, even for a fact that should always be required
7. ```sql
   CREATE TABLE Course (
       course_code VARCHAR(10) PRIMARY KEY,
       title VARCHAR(150) NOT NULL
   );
   ```
8. **Model answer:** "`Enrollment` has foreign keys to both `Student`
   and `Section`, and referential integrity means MySQL will not let a
   foreign key constraint point at a table that does not exist yet, so
   both of those tables, and everything they depend on, must already
   exist first."
