-- Course     : 511783-001 Database Systems
-- Lab        : Lab 10: DML -- Populating and Changing Data
-- Description: Instructor/grader reference answer key (INSERT half).
--              Do not distribute before grading. Must run cleanly
--              against the schema from lab09_create_schema-key.sql,
--              or book/src/labs/files/lab10/catchup_schema.sql.
--
--   mysql -u root -p < book/src/labs/files/lab10/catchup_schema.sql
--   mysql -u root -p registration_db < lab10_insert_data-key.sql

-- ---------------------------------------------------------------------
-- Exercise 1: independent tables first -- Instructor, Course, Student.
-- Multi-row INSERT used for Student, as the exercise requires.
-- ---------------------------------------------------------------------

INSERT INTO Instructor (name) VALUES
    ('Prof. Lee'),
    ('Prof. Han'),
    ('Prof. Kim');

INSERT INTO Course (course_code, title) VALUES
    ('CSE301', 'Database Systems'),
    ('CSE210', 'Data Structures'),
    ('CSE150', 'Programming I');

INSERT INTO Student (name, major) VALUES
    ('Kim Minji', 'Computer Science'),
    ('Park Jiho', 'Software Engineering'),
    ('Han Somin', 'Computer Science'),
    ('Lee Jiwoo', 'Data Science'),
    ('Choi Yuna', 'Data Science');

-- ---------------------------------------------------------------------
-- Exercise 2: Section -- references only course_code/instructor_id
-- values already inserted above (instructor_id 1=Lee, 2=Han, 3=Kim).
-- ---------------------------------------------------------------------

INSERT INTO Section (course_code, instructor_id, room, semester) VALUES
    ('CSE301', 1, '성파 702', '2026-1'),
    ('CSE210', 2, '인지관 305', '2026-1'),
    ('CSE150', 3, '인지관 101', '2026-1'),
    ('CSE301', 1, '성파 703', '2025-2');

-- ---------------------------------------------------------------------
-- Exercise 3: Enrollment -- at least 8 rows, at least 2 with grade
-- omitted (NULL = "not graded yet"). student_id 1=Kim Minji,
-- 2=Park Jiho, 3=Han Somin, 4=Lee Jiwoo, 5=Choi Yuna.
-- section_id 1=CSE301/Lee/2026-1, 2=CSE210, 3=CSE150, 4=CSE301/2025-2.
-- ---------------------------------------------------------------------

INSERT INTO Enrollment (student_id, section_id, grade) VALUES
    (1, 1, 'A0'),
    (2, 1, 'B+'),
    (3, 2, 'A0'),
    (4, 2, 'B0'),
    (5, 3, 'A-'),
    (1, 3, 'B+'),
    (2, 2, NULL),      -- not graded yet
    (3, 1, NULL);       -- not graded yet

-- Verification queries (not part of the deliverable, for self-check):
-- SELECT COUNT(*) FROM Student;      -- expect 5
-- SELECT COUNT(*) FROM Enrollment WHERE grade IS NULL;  -- expect 2
