-- Lab 11: full_seed.sql
-- Database Systems (511783-001)
--
-- RUN-ONLY. You do not need to write or change any SQL in this file.
-- It builds the complete, populated five-table registration schema:
-- the same structure Lab 9 and Lab 10 built by hand, now filled with
-- enough realistic data that single-table queries (Lab 11) and
-- multi-table joins (Lab 12) produce real, non-trivial results
-- instead of one or two rows every time.
--
-- This file is used by BOTH Lab 11 and Lab 12 -- it is not duplicated
-- anywhere. Lab 12's own files/ folder has no seed of its own; it
-- links back to this exact file.
--
-- Roughly what is inside: 16 instructors, 18 courses, 26 sections
-- across two semesters, 52 students, and 175 enrollment rows with a
-- realistic spread of grades. A few things were built in on purpose,
-- so specific queries in both labs have a real, checkable answer:
--   - Prof. Han and Prof. Lee each teach more than one course.
--   - Prof. Baek, Prof. Nam, Prof. Cho, and Prof. Yang teach ZERO
--     sections this term -- the exact case a LEFT JOIN is needed to
--     keep in the result at all.
--   - Student "Lee Jiwoo" (student_id = 4) has ZERO enrollments --
--     the exact case an INNER JOIN silently drops.
--   - CSE301 (Database Systems) and CSE210 (Data Structures) each
--     have 3 sections, some taught by different instructors, so
--     "which instructor teaches the most sections" has a real answer.
--   - Grades span the full A+ through F0 scale, plus NULL for a
--     handful of enrollments still awaiting a grade.
--
-- This script is idempotent: it can be re-run any number of times and
-- always produces the exact same starting state.
--
-- How to run it:
--   MySQL Workbench: File > Open SQL Script... then Execute.
--   mysql client:    mysql -u root -p < full_seed.sql

DROP DATABASE IF EXISTS registration_db;
CREATE DATABASE registration_db;
USE registration_db;

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

-- ---------------------------------------------------------------------
-- Data: 16 instructors, 18 courses, 26 sections, 52 students, 175 rows
-- ---------------------------------------------------------------------

-- Instructor

INSERT INTO Instructor (name) VALUES
    ('Prof. Lee'),
    ('Prof. Han'),
    ('Prof. Kim'),
    ('Prof. Oh'),
    ('Prof. Song'),
    ('Prof. Jang'),
    ('Prof. Kwon'),
    ('Prof. Yoon'),
    ('Prof. Jung'),
    ('Prof. Baek'),
    ('Prof. Nam'),
    ('Prof. Seo'),
    ('Prof. Moon'),
    ('Prof. Ahn'),
    ('Prof. Cho'),
    ('Prof. Yang');


-- Course

INSERT INTO Course (course_code, title) VALUES
    ('CSE150', 'Programming I'),
    ('CSE151', 'Programming II'),
    ('CSE210', 'Data Structures'),
    ('CSE211', 'Algorithms'),
    ('CSE301', 'Database Systems'),
    ('CSE302', 'Operating Systems'),
    ('CSE305', 'Software Engineering'),
    ('CSE310', 'Computer Networks'),
    ('CSE320', 'Web Development'),
    ('CSE410', 'Machine Learning'),
    ('CSE411', 'Artificial Intelligence'),
    ('CSE420', 'Computer Graphics'),
    ('CSE430', 'Computer Vision'),
    ('CSE440', 'Cloud Computing'),
    ('CSE450', 'Distributed Systems'),
    ('CSE460', 'Cybersecurity'),
    ('CSE470', 'Mobile App Development'),
    ('CSE480', 'Human-Computer Interaction');


-- Section

INSERT INTO Section (section_id, course_code, instructor_id, room, semester) VALUES
    (1, 'CSE150', 3, '인지관 101', '2025-2'),
    (2, 'CSE150', 3, '인지관 101', '2026-1'),
    (3, 'CSE151', 3, '인지관 102', '2026-1'),
    (4, 'CSE210', 2, '인지관 305', '2025-2'),
    (5, 'CSE210', 2, '인지관 305', '2026-1'),
    (6, 'CSE210', 13, '인지관 307', '2026-1'),
    (7, 'CSE211', 2, '인지관 306', '2026-1'),
    (8, 'CSE301', 1, '성파 702', '2025-2'),
    (9, 'CSE301', 1, '성파 702', '2026-1'),
    (10, 'CSE301', 14, '성파 704', '2026-1'),
    (11, 'CSE302', 1, '성파 703', '2026-1'),
    (12, 'CSE305', 5, '성파 610', '2025-2'),
    (13, 'CSE305', 5, '성파 610', '2026-1'),
    (14, 'CSE310', 6, '성파 615', '2026-1'),
    (15, 'CSE320', 5, '성파 611', '2026-1'),
    (16, 'CSE410', 4, '성파 508', '2025-2'),
    (17, 'CSE410', 4, '성파 508', '2026-1'),
    (18, 'CSE411', 4, '성파 509', '2026-1'),
    (19, 'CSE420', 7, '성파 512', '2026-1'),
    (20, 'CSE430', 7, '성파 513', '2026-1'),
    (21, 'CSE440', 6, '성파 616', '2026-1'),
    (22, 'CSE450', 8, '성파 620', '2025-2'),
    (23, 'CSE450', 8, '성파 620', '2026-1'),
    (24, 'CSE460', 8, '성파 621', '2026-1'),
    (25, 'CSE470', 12, '성파 625', '2026-1'),
    (26, 'CSE480', 9, '성파 630', '2026-1');


-- Student

INSERT INTO Student (name, major) VALUES
    ('Kim Minji', 'Computer Science'),
    ('Park Jiho', 'Software Engineering'),
    ('Han Somin', 'Computer Science'),
    ('Lee Jiwoo', 'Data Science'),
    ('Choi Yuna', 'Data Science'),
    ('Kim Bomi', 'Computer Science'),
    ('Lee Sion', 'Software Engineering'),
    ('Park Harin', 'Data Science'),
    ('Choi Eunji', 'Information Systems'),
    ('Jung Dohyun', 'Computer Science'),
    ('Kang Haeun', 'Software Engineering'),
    ('Cho Jaeho', 'Data Science'),
    ('Yoon Nayeon', 'Information Systems'),
    ('Jang Doyoon', 'Computer Science'),
    ('Lim Hyunwoo', 'Software Engineering'),
    ('Han Miso', 'Data Science'),
    ('Oh Somin', 'Information Systems'),
    ('Seo Hyerin', 'Computer Science'),
    ('Kwon Yejun', 'Software Engineering'),
    ('Hwang Yerin', 'Data Science'),
    ('Song Daeun', 'Information Systems'),
    ('Ahn Rian', 'Computer Science'),
    ('Yoo Suji', 'Software Engineering'),
    ('Hong Woojin', 'Data Science'),
    ('Shin Seungmin', 'Information Systems'),
    ('Kim Seojun', 'Computer Science'),
    ('Lee Yoonseo', 'Software Engineering'),
    ('Park Eunwoo', 'Data Science'),
    ('Choi Jian', 'Information Systems'),
    ('Jung Minseo', 'Computer Science'),
    ('Kang Yubin', 'Software Engineering'),
    ('Cho Yuri', 'Data Science'),
    ('Yoon Jeongwoo', 'Information Systems'),
    ('Jang Minjun', 'Computer Science'),
    ('Lim Chaewon', 'Software Engineering'),
    ('Han Sua', 'Data Science'),
    ('Oh Taemin', 'Information Systems'),
    ('Seo Siwoo', 'Computer Science'),
    ('Kwon Wonjun', 'Software Engineering'),
    ('Hwang Areumi', 'Data Science'),
    ('Song Jiho', 'Information Systems'),
    ('Ahn Somang', 'Computer Science'),
    ('Yoo Sarang', 'Software Engineering'),
    ('Hong Taeyang', 'Data Science'),
    ('Shin Hajun', 'Information Systems'),
    ('Kim Areum', 'Computer Science'),
    ('Park Nari', 'Software Engineering'),
    ('Choi Junho', 'Data Science'),
    ('Jung Gyuri', 'Information Systems'),
    ('Kang Seoyeon', 'Computer Science'),
    ('Cho Yuna', 'Software Engineering'),
    ('Yoon Gunwoo', 'Data Science');


-- Enrollment

INSERT INTO Enrollment (student_id, section_id, grade) VALUES
    (1, 23, 'B0'),
    (2, 10, 'A0'),
    (3, 5, 'D0'),
    (3, 10, 'A-'),
    (3, 21, NULL),
    (3, 22, 'B+'),
    (5, 9, 'A-'),
    (5, 14, NULL),
    (5, 17, NULL),
    (5, 19, 'B+'),
    (5, 20, 'B+'),
    (6, 9, 'C+'),
    (6, 17, 'B0'),
    (6, 23, 'A-'),
    (7, 4, 'A0'),
    (7, 15, 'A0'),
    (7, 23, 'C+'),
    (8, 2, 'F0'),
    (8, 22, 'B+'),
    (9, 2, 'F0'),
    (9, 5, 'B-'),
    (9, 9, 'B-'),
    (10, 16, 'A0'),
    (10, 20, 'B-'),
    (11, 4, 'A0'),
    (11, 25, 'B0'),
    (12, 6, 'A0'),
    (12, 12, 'D0'),
    (12, 13, 'A+'),
    (12, 14, 'D0'),
    (12, 18, 'B-'),
    (13, 2, 'B-'),
    (13, 5, 'B0'),
    (13, 11, 'A-'),
    (13, 18, 'A-'),
    (13, 19, 'C0'),
    (14, 5, 'C-'),
    (14, 6, 'B+'),
    (14, 13, 'B+'),
    (14, 17, 'B-'),
    (15, 1, 'D0'),
    (15, 17, 'D0'),
    (15, 18, 'B+'),
    (15, 21, 'B+'),
    (16, 5, 'C+'),
    (16, 14, NULL),
    (16, 19, NULL),
    (16, 21, 'C+'),
    (17, 7, 'A+'),
    (17, 23, 'C+'),
    (17, 26, 'B+'),
    (18, 11, 'B-'),
    (18, 15, 'A0'),
    (18, 26, 'B+'),
    (19, 2, 'B-'),
    (19, 20, 'B+'),
    (19, 21, 'A0'),
    (20, 6, 'B0'),
    (20, 10, 'B+'),
    (20, 11, 'B0'),
    (20, 13, 'B-'),
    (20, 18, NULL),
    (20, 23, 'B+'),
    (21, 22, 'A+'),
    (21, 23, 'A0'),
    (21, 25, 'B0'),
    (22, 8, 'B-'),
    (22, 21, 'B+'),
    (23, 5, 'B+'),
    (23, 6, 'B+'),
    (24, 1, 'C+'),
    (24, 9, NULL),
    (24, 10, 'B0'),
    (24, 25, 'C-'),
    (25, 6, 'B-'),
    (25, 16, NULL),
    (25, 17, 'C-'),
    (25, 19, 'B0'),
    (25, 20, NULL),
    (25, 21, 'B0'),
    (26, 3, 'B0'),
    (26, 14, 'C+'),
    (26, 17, 'B+'),
    (26, 18, 'A0'),
    (26, 24, 'B+'),
    (27, 23, 'A-'),
    (27, 24, 'A0'),
    (28, 2, NULL),
    (28, 6, 'C0'),
    (28, 20, 'B-'),
    (28, 22, 'A0'),
    (29, 8, 'B+'),
    (29, 9, 'C0'),
    (29, 15, 'B+'),
    (29, 18, 'C+'),
    (30, 4, 'A0'),
    (30, 5, 'A-'),
    (30, 26, 'F0'),
    (31, 7, 'B-'),
    (31, 14, 'A-'),
    (31, 20, 'B+'),
    (31, 24, 'A0'),
    (32, 1, 'A-'),
    (32, 8, 'F0'),
    (32, 10, 'A-'),
    (32, 20, 'C0'),
    (33, 8, 'B+'),
    (33, 11, 'C0'),
    (33, 13, 'B0'),
    (33, 16, 'A-'),
    (34, 5, 'C0'),
    (35, 21, 'A0'),
    (35, 23, NULL),
    (36, 8, 'A0'),
    (36, 9, 'A0'),
    (37, 15, 'C+'),
    (37, 23, 'A-'),
    (38, 3, 'A+'),
    (38, 5, 'A0'),
    (38, 18, 'A0'),
    (38, 20, 'C-'),
    (39, 3, 'A0'),
    (39, 6, 'A0'),
    (39, 22, 'B-'),
    (40, 11, 'A0'),
    (40, 12, 'A-'),
    (40, 21, 'A-'),
    (41, 2, 'A0'),
    (41, 3, 'C+'),
    (42, 5, 'B+'),
    (42, 9, 'C0'),
    (42, 10, 'D0'),
    (42, 15, 'B0'),
    (42, 18, 'B-'),
    (43, 3, 'C+'),
    (43, 4, NULL),
    (43, 23, NULL),
    (43, 25, NULL),
    (44, 5, 'C-'),
    (44, 18, 'B0'),
    (44, 20, 'A+'),
    (45, 4, 'C+'),
    (45, 5, 'C+'),
    (45, 9, 'B0'),
    (45, 10, 'A0'),
    (45, 11, 'A0'),
    (45, 16, NULL),
    (45, 17, 'B0'),
    (45, 18, 'B-'),
    (46, 2, 'B+'),
    (46, 3, 'C+'),
    (46, 15, NULL),
    (46, 22, 'A0'),
    (47, 2, 'A-'),
    (47, 8, 'C-'),
    (47, 10, 'B+'),
    (47, 19, 'D0'),
    (47, 23, NULL),
    (48, 3, 'B+'),
    (48, 7, 'B0'),
    (48, 16, 'C0'),
    (48, 18, 'A-'),
    (48, 19, 'A0'),
    (48, 21, 'B0'),
    (49, 10, 'C+'),
    (49, 12, 'B0'),
    (49, 19, 'B-'),
    (49, 25, 'B0'),
    (50, 9, 'B-'),
    (50, 16, 'B+'),
    (50, 23, NULL),
    (51, 21, 'F0'),
    (52, 4, 'B0'),
    (52, 6, 'B-'),
    (52, 18, 'C0');
