-- Course     : 511783-001 Database Systems
-- Lab        : Lab 11: Single-table Queries
-- Description: Instructor/grader reference answer key. Do not
--              distribute before grading. Must run cleanly against
--              book/src/labs/files/lab11/full_seed.sql.
--
--   mysql -u root -p < book/src/labs/files/lab11/full_seed.sql
--   mysql -u root -p registration_db < lab11_queries-key.sql

-- ---------------------------------------------------------------------
-- Exercise 1: basic SELECT-FROM-WHERE
-- ---------------------------------------------------------------------

SELECT name, major
FROM Student
WHERE major = 'Data Science';

-- ---------------------------------------------------------------------
-- Exercise 2: LIKE and range filtering
-- ---------------------------------------------------------------------

SELECT title FROM Course
WHERE title LIKE '%Systems%';

SELECT * FROM Section
WHERE semester = '2026-1';

-- ---------------------------------------------------------------------
-- Exercise 3: IS NULL and IN
-- ---------------------------------------------------------------------

SELECT student_id, section_id FROM Enrollment
WHERE grade IS NULL;

SELECT name FROM Student
WHERE major IN ('Computer Science', 'Software Engineering');

-- ---------------------------------------------------------------------
-- Exercise 4: DISTINCT and ORDER BY
-- ---------------------------------------------------------------------

SELECT DISTINCT room FROM Section
ORDER BY room ASC;

-- ---------------------------------------------------------------------
-- Exercise 5: whole-table aggregates, no GROUP BY
-- ---------------------------------------------------------------------

SELECT COUNT(*) AS total_enrollments,
       COUNT(grade) AS graded,
       COUNT(*) - COUNT(grade) AS still_pending
FROM Enrollment;

-- ---------------------------------------------------------------------
-- Exercise 6: CASE
-- ---------------------------------------------------------------------

SELECT name,
    CASE
        WHEN major = 'Computer Science' THEN 'CS'
        ELSE 'Other'
    END AS major_label
FROM Student;

-- ===================================================================
-- CHALLENGE PROBLEM -- reference answer
-- ===================================================================

SELECT
    MAX(student_id) AS highest_graded_student,
    MIN(student_id) AS lowest_graded_student,
    (SELECT COUNT(DISTINCT grade) FROM Enrollment WHERE grade IS NOT NULL) AS distinct_grades_in_use,
    (SELECT COUNT(*) FROM Enrollment WHERE grade IS NULL) AS ungraded_count
FROM Enrollment
WHERE grade IS NOT NULL;

SELECT course_code, title,
    CASE
        WHEN CAST(SUBSTRING(course_code, 4) AS UNSIGNED) < 300 THEN 'Intro'
        ELSE 'Advanced'
    END AS level
FROM Course;

-- ===================================================================
-- PRACTICE PROBLEMS -- reference answers (not distributed to students)
-- ===================================================================

-- Practice 1: SELECT title FROM Book WHERE title LIKE '%Database%' ORDER BY title ASC;
-- Practice 2: SELECT student_id, section_id FROM Enrollment WHERE grade IS NULL;
-- Practice 3: SELECT title, DATEDIFF(CURDATE(), acquired_on) AS days_owned FROM Book;
-- Practice 4:
--   SELECT loan_id,
--       CASE WHEN due_date < CURDATE() THEN 'Overdue' ELSE 'On Time' END AS status
--   FROM Loan;
-- Practice 5: SELECT title FROM Course WHERE title LIKE '%Systems';
-- Practice 6: SELECT COUNT(*) AS total_students FROM Student;
-- Practice 7:
--   SELECT * FROM Enrollment
--   ORDER BY student_id DESC, section_id DESC
--   LIMIT 3;

-- ===================================================================
-- FACILITATION NOTES
-- ===================================================================
-- - Exercise 3's A4-style prediction ("does WHERE grade = NULL work?")
--   is this lab's key misconception check -- confirm students can
--   state, not just demonstrate, why it silently returns nothing.
-- - Exact row counts from full_seed.sql will vary slightly if a
--   student's own INSERT/UPDATE work from Lab 10 altered their data;
--   full_seed.sql is a fresh, independent seed, so results here should
--   match this key's structure even if a student's Lab 10 database
--   differs.
-- - Grade text sorts alphabetically, not by academic rank (see the
--   lab's own Worked Example) -- do not deduct if a student is
--   confused by MIN/MAX(grade) and asks about it; that confusion is
--   the intended teaching moment, not a mistake.
