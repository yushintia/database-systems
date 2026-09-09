-- Lab 10: catchup_schema.sql
-- Database Systems (511783-001)
--
-- CATCH-UP FILE. If your own Lab 9 CREATE TABLE statements did not
-- work, or you are not confident they are correct, run this file
-- instead. It builds the exact same five-table registration schema
-- Lab 9 asked you to write by hand -- same table names, same column
-- names, same types, same constraints -- with ZERO rows in every
-- table, so you can move on to this week's INSERT/UPDATE/DELETE work
-- without being blocked by a broken schema.
--
-- Using this file is not a penalty. It exists so one rough week does
-- not cost you the rest of the semester. If you already have a
-- working Lab 9 schema, you do not need this file at all -- just keep
-- using your own.
--
-- This script is idempotent: run it once, or ten times in a row, and
-- you land in the exact same empty-but-structured state every time.
--
-- How to run it:
--   MySQL Workbench: File > Open SQL Script... then Execute.
--   mysql client:    mysql -u root -p < catchup_schema.sql

DROP DATABASE IF EXISTS registration_db;
CREATE DATABASE registration_db;
USE registration_db;

-- ---------------------------------------------------------------------
-- Independent tables first: no foreign keys, so no dependency order
-- constraints among these three.
-- ---------------------------------------------------------------------

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    major VARCHAR(100)
);

CREATE TABLE Course (
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(150) NOT NULL
);

CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- ---------------------------------------------------------------------
-- Section depends on Course and Instructor: both must already exist.
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
-- Enrollment depends on Student and Section, so it is created last of
-- all five. Its primary key is composite: neither student_id nor
-- section_id alone identifies one enrollment, only the pair does.
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

-- Nothing else in this file. Zero rows in every table -- this is a
-- catch-up on STRUCTURE only. Lab 10's own INSERT statements are what
-- put real data in.
