-- Course     : 511783-001 Database Systems
-- Lab        : Lab 12: Multi-table Queries (Assignment 2)
-- Description: Instructor/grader reference answer key. Do not
--              distribute before grading. Must run cleanly against
--              book/src/labs/files/lab11/full_seed.sql (Lab 12 reuses
--              Lab 11's seed -- there is no separate Lab 12 seed).
--
--   mysql -u root -p < book/src/labs/files/lab11/full_seed.sql
--   mysql -u root -p registration_db < lab12_joins-key.sql

-- ---------------------------------------------------------------------
-- Exercise 1: two-table INNER JOIN -- student_id 4 (Lee Jiwoo, zero
-- enrollments) must NOT appear in this result.
-- ---------------------------------------------------------------------

SELECT Student.name, Enrollment.grade
FROM Student
JOIN Enrollment ON Student.student_id = Enrollment.student_id;

-- ---------------------------------------------------------------------
-- Exercise 2: the same question, with LEFT JOIN -- Lee Jiwoo now
-- appears, with grade = NULL.
-- ---------------------------------------------------------------------

SELECT Student.name, Enrollment.grade
FROM Student
LEFT JOIN Enrollment ON Student.student_id = Enrollment.student_id;

-- ---------------------------------------------------------------------
-- Exercise 3: four-table JOIN, one specific instructor
-- ---------------------------------------------------------------------

SELECT Student.name, Enrollment.grade, Course.title
FROM Enrollment
JOIN Student ON Enrollment.student_id = Student.student_id
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Course ON Section.course_code = Course.course_code
JOIN Instructor ON Section.instructor_id = Instructor.instructor_id
WHERE Instructor.name = 'Prof. Han';

-- ---------------------------------------------------------------------
-- Exercise 4: GROUP BY and HAVING -- course-level total, not
-- section-level, so it requires the extra JOIN through Section that
-- the Background's own Section-level example did not need.
-- ---------------------------------------------------------------------

SELECT Course.course_code, COUNT(*) AS enrolled
FROM Enrollment
JOIN Section ON Enrollment.section_id = Section.section_id
JOIN Course ON Section.course_code = Course.course_code
GROUP BY Course.course_code
HAVING COUNT(*) > 5;

-- Expected against full_seed.sql: 13 of the 18 courses qualify
-- (CSE210=26 down to CSE302=6); CSE310, CSE470 (5 each), CSE211,
-- CSE480, CSE460 (3 each) are correctly excluded.

-- Grading note: WHERE COUNT(*) > 5 in place of HAVING raises
--   ERROR 1054 (42S22): Unknown column 'COUNT(*)' in 'where clause'
-- (MySQL) or an equivalent aggregate-in-WHERE error -- aggregates do
-- not exist as values until grouping has already happened. Full
-- credit for the "predict" checkpoint requires the student to state
-- this reason, not just "it doesn't work."

-- ---------------------------------------------------------------------
-- Exercise 5: instructors teaching nothing this semester
-- ---------------------------------------------------------------------

SELECT Instructor.name, COUNT(Section.section_id) AS sections_taught
FROM Instructor
LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
GROUP BY Instructor.instructor_id, Instructor.name
HAVING sections_taught = 0;

-- Expected against full_seed.sql: Prof. Baek, Prof. Nam, Prof. Cho,
-- Prof. Yang -- exactly the four instructors the seed file's own
-- header comment names as teaching zero sections this term.

-- ===================================================================
-- CHALLENGE PROBLEM -- reference answer
-- ===================================================================

-- Self-join: every pair of distinct students sharing section_id = 1.
SELECT s1.name AS student_a, s2.name AS student_b, e1.section_id
FROM Enrollment e1
JOIN Enrollment e2
  ON e1.section_id = e2.section_id
 AND e1.student_id < e2.student_id
JOIN Student s1 ON e1.student_id = s1.student_id
JOIN Student s2 ON e2.student_id = s2.student_id
WHERE e1.section_id = 1;

-- Correlated scalar subquery: each student's own enrollment count.
SELECT s.name,
       (SELECT COUNT(*) FROM Enrollment e
        WHERE e.student_id = s.student_id) AS enrollment_count
FROM Student s
ORDER BY enrollment_count DESC
LIMIT 10;

-- ===================================================================
-- PRACTICE PROBLEMS -- reference answers (not distributed to students)
-- ===================================================================

-- Practice 1: LEFT JOIN from Instructor -- INNER JOIN would silently
-- drop instructors with zero sections, exactly the rows this question
-- needs kept.
--   SELECT Instructor.name, COUNT(Section.section_id) AS sections
--   FROM Instructor
--   LEFT JOIN Section ON Instructor.instructor_id = Section.instructor_id
--   GROUP BY Instructor.instructor_id, Instructor.name;

-- Practice 2:
--   SELECT Member.name, COUNT(*) AS books_out
--   FROM Member JOIN Loan USING (member_id)
--   GROUP BY Member.name;

-- Practice 3:
--   SELECT l1.member_id AS member_a, l2.member_id AS member_b, l1.book_isbn
--   FROM Loan l1
--   JOIN Loan l2 ON l1.book_isbn = l2.book_isbn AND l1.member_id < l2.member_id;

-- Practice 4:
--   SELECT name FROM Member m
--   WHERE NOT EXISTS (SELECT 1 FROM Loan l WHERE l.member_id = m.member_id);

-- Practice 5:
--   SELECT Section.section_id, COUNT(Enrollment.student_id) AS enrolled
--   FROM Enrollment
--   RIGHT JOIN Section ON Enrollment.section_id = Section.section_id
--   GROUP BY Section.section_id;
--   -- equivalent LEFT JOIN:
--   SELECT Section.section_id, COUNT(Enrollment.student_id) AS enrolled
--   FROM Section
--   LEFT JOIN Enrollment ON Section.section_id = Enrollment.section_id
--   GROUP BY Section.section_id;

-- Practice 6:
--   SELECT name FROM Student
--   WHERE student_id IN (
--       SELECT student_id FROM Enrollment
--       WHERE section_id IN (
--           SELECT section_id FROM Section WHERE instructor_id = 1
--       )
--   );

-- Practice 7:
--   SELECT student_id, COUNT(*) AS enrollment_count
--   FROM Enrollment
--   GROUP BY student_id
--   HAVING COUNT(*) > 2;

-- ===================================================================
-- FACILITATION NOTES
-- ===================================================================
-- - Exercises 1/2 are this lab's core misconception check: a student
--   who cannot explain why Lee Jiwoo disappears from Exercise 1 but
--   not Exercise 2 has not understood INNER vs. LEFT JOIN yet, even if
--   both queries run without error.
-- - This lab doubles as Assignment 2 -- consider grading the
--   Assignment 2 submission directly against this key's Exercises
--   1-5 plus the Challenge, rather than requiring a separate
--   assignment-specific rubric.
-- - Common near-miss on Exercise 4: putting the HAVING condition in
--   WHERE and being confused why MySQL rejects it -- see the grading
--   note inline above.
-- - Common near-miss on Exercise 5: using INNER JOIN out of habit,
--   which silently drops all four zero-section instructors with no
--   error at all -- check the actual row count (16 instructors should
--   all appear), not just "the query ran."
