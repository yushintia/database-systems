-- Lab 03: toy_sandbox.sql
-- Database Systems (511783-001)
--
-- RUN-ONLY. You do not need to write or change any SQL in this file.
-- This is a deliberately UNDER-CONSTRAINED 2-table toy schema:
-- Course and Section, with no PRIMARY KEY and no FOREIGN KEY declared
-- anywhere. Every INSERT below is 100% legal to MySQL, because
-- nothing here tells the database any of these facts are supposed to
-- agree with each other.
--
-- After running this script, open both tables in MySQL Workbench's
-- data grid (no SELECT needed -- right-click the table > "Select Rows
-- - Limit 1000") and look for the contradictions yourself. Lab 03's
-- Guided Exercises walk you through exactly what to look for and why
-- each one is a modelling problem, not a typing mistake.
--
-- This script is idempotent: it can be re-run any number of times and
-- always produces the exact same starting state.

DROP DATABASE IF EXISTS toy_sandbox_db;
CREATE DATABASE toy_sandbox_db;
USE toy_sandbox_db;

-- No PRIMARY KEY on course_code. Nothing stops the same course_code
-- from being inserted twice, with two different titles.
CREATE TABLE Course (
    course_code VARCHAR(10),
    title       VARCHAR(100)
);

-- No PRIMARY KEY on section_id. No FOREIGN KEY tying course_code back
-- to Course.course_code. Nothing stops a Section from pointing at a
-- course that doesn't exist, or two Sections from claiming the exact
-- same section_id.
CREATE TABLE Section (
    section_id  INT,
    course_code VARCHAR(10),
    instructor  VARCHAR(100),
    room        VARCHAR(20)
);

-- ---------------------------------------------------------------
-- Baseline data: looks perfectly reasonable on its own.
-- ---------------------------------------------------------------
INSERT INTO Course (course_code, title) VALUES
    ('CSE301', 'Database Systems'),
    ('CSE210', 'Data Structures');

INSERT INTO Section (section_id, course_code, instructor, room) VALUES
    (1, 'CSE301', 'Prof. Lee', '성파 702'),
    (2, 'CSE210', 'Prof. Han', '인지관 305');

-- ---------------------------------------------------------------
-- Now the contradictions. Every statement below runs without a
-- single error or warning from MySQL -- that silence is the whole
-- lesson. A schema with no constraints cannot tell the difference
-- between real data and nonsense.
-- ---------------------------------------------------------------

-- Contradiction 1: the SAME course_code inserted again, with a
-- DIFFERENT title. Which title is correct -- "Database Systems" or
-- "Intro to Databases"? The table itself cannot answer that, and
-- happily stores both.
INSERT INTO Course (course_code, title) VALUES
    ('CSE301', 'Intro to Databases');

-- Contradiction 2: a Section that points at a course_code that does
-- not exist anywhere in Course. CSE999 was never created. Nothing
-- rejects this orphaned row.
INSERT INTO Section (section_id, course_code, instructor, room) VALUES
    (3, 'CSE999', 'Prof. Choi', '인지관 210');

-- Contradiction 3: TWO Sections claiming the exact same section_id
-- (1), with different instructors and rooms. "Section 1" now means
-- two different, disagreeing things at once.
INSERT INTO Section (section_id, course_code, instructor, room) VALUES
    (1, 'CSE210', 'Prof. Oh', '성파 508');

-- Contradiction 4: a course_code with leading/trailing spaces that
-- LOOKS different from the existing 'CSE210' to a careless reader,
-- but is really the same course, sloppily re-typed -- and, because
-- nothing enforces one canonical spelling, MySQL stores it as a
-- brand new, unrelated-looking row.
INSERT INTO Course (course_code, title) VALUES
    ('CSE210 ', 'Data Structures');

-- Nothing else in this file. Do not add PRIMARY KEY or FOREIGN KEY
-- constraints here -- Lab 03's point is to see what a schema allows
-- when nobody has stated its constraints yet. Fixing this is Week 6
-- (mapping) and Week 9 (real DDL with real constraints).
