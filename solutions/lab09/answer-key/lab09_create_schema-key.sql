-- Course     : 511783-001 Database Systems
-- Lab        : Lab 09: DDL -- Creating the Schema
-- Description: Instructor/grader reference answer key. Do not
--              distribute before grading. Must run cleanly, top to
--              bottom, against book/src/labs/files/lab09/reset.sql.
--
-- Run reset.sql first:
--   mysql -u root -p < book/src/labs/files/lab09/reset.sql
--   mysql -u root -p registration_db < lab09_create_schema-key.sql

-- ---------------------------------------------------------------------
-- Exercise 1: the three independent tables -- no foreign keys, so any
-- creation order among these three is valid.
-- ---------------------------------------------------------------------

CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Course (
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(150) NOT NULL
);

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    major VARCHAR(100)
);

-- ---------------------------------------------------------------------
-- Exercise 2: Section -- depends on Course and Instructor, both of
-- which must already exist as tables (Exercise 3 below is the
-- deliberate failure that happens if this rule is broken).
-- ---------------------------------------------------------------------

CREATE TABLE Section (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) NOT NULL,
    instructor_id INT,
    room VARCHAR(20) NOT NULL,
    semester VARCHAR(20),
    CONSTRAINT fk_section_course
        FOREIGN KEY (course_code) REFERENCES Course (course_code),
    CONSTRAINT fk_section_instructor
        FOREIGN KEY (instructor_id) REFERENCES Instructor (instructor_id)
        ON DELETE SET NULL
);

-- ---------------------------------------------------------------------
-- Exercise 3 (grading note, not a runnable statement): the deliberate
-- failure. Running the Section statement above BEFORE Instructor and
-- Course exist produces:
--
--   ERROR 1824 (HY000): Failed to open the referenced table
--   'instructor' (or 'course', whichever is missing first)
--
-- Full credit for this exercise requires the student's own submission
-- to show they reproduced this exact error and then fixed the order,
-- not just that their final file happens to run. Check their
-- worksheet or comments for evidence of the deliberate break.
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Exercise 4: Enrollment -- depends on Student and Section, so it is
-- created last of all five. Composite primary key: neither column
-- alone identifies one enrollment, only the pair does.
-- ---------------------------------------------------------------------

CREATE TABLE Enrollment (
    student_id INT NOT NULL,
    section_id INT NOT NULL,
    grade VARCHAR(2),
    CONSTRAINT pk_enrollment PRIMARY KEY (student_id, section_id),
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id) REFERENCES Student (student_id),
    CONSTRAINT fk_enrollment_section
        FOREIGN KEY (section_id) REFERENCES Section (section_id)
        ON DELETE CASCADE
);

-- ===================================================================
-- GRADING CHECKLIST (Exercise 5 / final submission)
-- ===================================================================
-- [ ] All 5 tables present, in valid dependency order (independent
--     tables, then Section, then Enrollment)
-- [ ] student_id / instructor_id AUTO_INCREMENT PRIMARY KEY
-- [ ] course_code is a natural-key PRIMARY KEY, VARCHAR(10)
-- [ ] Enrollment's PRIMARY KEY is the composite (student_id, section_id)
-- [ ] Every FOREIGN KEY correctly references the target table/column
-- [ ] NOT NULL present on every column described as "required" in the
--     lab text (name, title, course_code, room)
-- [ ] File runs with zero errors against a freshly reset database
-- [ ] Header comment block present (SQL Style Guide)
-- Style deduction, not correctness deduction, if constraints are not
-- individually named -- full correctness credit does not require the
-- CONSTRAINT ... names shown above, only that PRIMARY KEY/FOREIGN KEY
-- exist and are correct. Full STYLE credit does require named
-- constraints, per the SQL Style Guide.

-- ===================================================================
-- CHALLENGE PROBLEM -- reference answer
-- ===================================================================

ALTER TABLE Course
    ADD COLUMN credit_hours INT,
    ADD CONSTRAINT chk_course_credit_hours
        CHECK (credit_hours BETWEEN 1 AND 6);

ALTER TABLE Student
    ADD COLUMN email VARCHAR(100),
    ADD CONSTRAINT uq_student_email UNIQUE (email);

-- Verification (should fail):
-- INSERT INTO Course (course_code, title, credit_hours)
--   VALUES ('CS999', 'Overloaded', 12);
-- INSERT INTO Student (name, email) VALUES ('A', 'dup@x.com');
-- INSERT INTO Student (name, email) VALUES ('B', 'dup@x.com');  -- fails

-- ===================================================================
-- PRACTICE PROBLEMS -- reference answers (not distributed to students)
-- ===================================================================

-- Practice 1: Book, natural-key primary key, not auto-incrementing.
-- CREATE TABLE Book (
--     isbn VARCHAR(13) PRIMARY KEY,
--     title VARCHAR(200) NOT NULL
-- );

-- Practice 2: make Section.room required after the fact.
-- ALTER TABLE Section MODIFY COLUMN room VARCHAR(20) NOT NULL;

-- Practice 3: Department, simple two-column table.
-- CREATE TABLE Department (
--     dept_code VARCHAR(10) PRIMARY KEY,
--     dept_name VARCHAR(100) NOT NULL
-- );

-- Practice 4: Payment, DECIMAL for money, ENUM for a fixed list.
-- CREATE TABLE Payment (
--     payment_id INT AUTO_INCREMENT PRIMARY KEY,
--     amount DECIMAL(10,2) NOT NULL,
--     method ENUM('cash','card') NOT NULL
-- );

-- Practice 5: Prerequisite, composite key, both columns FK to the
-- same table (Course) -- a self-referencing pair of foreign keys.
-- CREATE TABLE Prerequisite (
--     course_code VARCHAR(10),
--     prereq_code VARCHAR(10),
--     PRIMARY KEY (course_code, prereq_code),
--     FOREIGN KEY (course_code) REFERENCES Course(course_code),
--     FOREIGN KEY (prereq_code) REFERENCES Course(course_code)
-- );

-- Practice 6: add a UNIQUE email column after the fact.
-- ALTER TABLE Student ADD COLUMN email VARCHAR(100) UNIQUE;

-- Practice 7: ride-hailing referential action.
-- Answer: SET NULL. Deleting a driver's account should not erase the
-- historical record that a ride happened (CASCADE would destroy trip
-- history and billing records), but the ride row must still exist
-- once the driver reference is cleared -- the same reasoning as
-- Section.instructor_id in this lab's own schema.
-- FOREIGN KEY (driver_id) REFERENCES Driver(driver_id) ON DELETE SET NULL

-- ===================================================================
-- FACILITATION NOTES
-- ===================================================================
-- - Exercise 3's deliberate failure is the single most important
--   moment in this lab. If a student's file runs clean but they never
--   describe hitting ERROR 1824, ask them to reproduce it live before
--   awarding full Completion credit -- the point is recognizing the
--   error, not avoiding it.
-- - Common near-miss: students who put Enrollment before Section (both
--   are "the complicated ones") -- check dependency order carefully,
--   not just "does it eventually run."
-- - Common near-miss: VARCHAR(2) on grade being "too small" -- this is
--   correct and intentional (2-character grades like 'A0', 'B+', 'F0');
--   do not deduct for this.
