-- Lab 02: flat_load.sql
-- Database Systems (511783-001)
--
-- RUN-ONLY. You do not need to write or change any SQL in this file.
-- It exists so you have a real, live copy of Week 1's messy
-- spreadsheet sitting inside an actual MySQL server, to poke at with
-- your own eyes -- not just read about on a slide.
--
-- This script is idempotent: it can be re-run any number of times and
-- always produces the exact same starting state.
--
-- How to run it:
--   MySQL Workbench: File > Open SQL Script... then the lightning-bolt
--   "Execute" button (or File > Run SQL Script).
--   mysql client:    mysql -u root -p < flat_load.sql

DROP DATABASE IF EXISTS registration_db;
CREATE DATABASE registration_db;
USE registration_db;

-- ONE raw table. No primary key declared on purpose -- Lab 02 asks you
-- to try to find one by inspecting the data, and to see for yourself
-- why nothing here works cleanly yet. Every column is just "whatever
-- text was typed into that spreadsheet cell."
CREATE TABLE raw_registrations (
    student_name  VARCHAR(100),
    student_major VARCHAR(100),
    course_code   VARCHAR(10),
    course_title  VARCHAR(100),
    instructor    VARCHAR(100),
    room          VARCHAR(20),
    grade         VARCHAR(5)
);

-- Same 18 rows as book/src/labs/files/lab01/registrations.csv, typed
-- in by hand -- exactly the way the registration office actually
-- filled in this spreadsheet, spelling mistakes and all.
INSERT INTO raw_registrations
    (student_name, student_major, course_code, course_title, instructor, room, grade)
VALUES
    ('Kim Minji',     'Computer Science',      'CSE301', 'Database Systems', 'Prof. Lee', '성파 702',   'A0'),
    ('Park Jiho',     'Software Engineering',  'CSE301', 'Database Systems', 'Prof. Lee', '성파 702',   'B+'),
    ('MinJi Kim',     'Computer Science',      'CSE210', 'Data Structures',  'Prof. Han', '인지관 305', 'A-'),
    ('Lee Somin',     'Computer Science',      'CSE301', 'Database Systems', 'Prof. Lee', '성파 702',   'A0'),
    ('Choi Yuna',     'Data Science',          'CSE210', 'Data Structures',  'Prof. Han', '인지관 305', 'B0'),
    ('김민지',         'Computer Science',      'CSE150', 'Programming I',    'Prof. Kim', '인지관 101', 'A+'),
    ('Jung Hyunwoo',  'Software Engineering',  'CSE301', 'Database Systems', 'Prof. Lee', '성파 702',   'B0'),
    ('Han Seoyeon',   'Computer Science',      'CSE210', 'Data Structures',  'Prof. Han', '인지관 305', 'A0'),
    ('Song Minjun',   'Data Science',          'CSE150', 'Programming I',    'Prof. Kim', '인지관 101', 'B+'),
    ('Kim Minji',     'Computer Science',      'CSE210', 'Data Structures',  'Prof. Han', '인지관 305', 'B+'),
    ('Park Jiho',     'Software Engineering',  'CSE150', 'Programming I',    'Prof. Kim', '인지관 101', 'A-'),
    ('MinJi Kim',     'Computer Science',      'CSE301', 'Database Systems', 'Prof. Lee', '성파 702',   'B0'),
    ('Oh Taeyang',    'Computer Science',      'CSE410', 'Machine Learning', 'Prof. Oh',  '성파 508',   'A0'),
    ('Lee Somin',     'Computer Science',      'CSE150', 'Programming I',    'Prof. Kim', '인지관 101', 'B+'),
    ('Choi Yuna',     'Data Science',          'CSE301', 'Database Systems', 'Prof. Lee', '성파 702',   'A-'),
    ('Jung Hyunwoo',  'Software Engineering',  'CSE210', 'Data Structures',  'Prof. Han', '인지관 305', 'B0'),
    ('Han Seoyeon',   'Computer Science',      'CSE150', 'Programming I',    'Prof. Kim', '인지관 101', 'A0'),
    ('김민지',         'Computer Science',      'CSE301', 'Database Systems', 'Prof. Lee', '성파 702',   NULL);

-- Nothing else in this file. Do not add a PRIMARY KEY, an ALTER TABLE,
-- or any constraint here -- Lab 02's whole point is that this table,
-- exactly as it stands, resists a clean primary key. See lab02_keys.md.
