-- Course     : 511783-001 Database Systems
-- Lab        : Lab 10: DML -- Populating and Changing Data
-- Description: Instructor/grader reference answer key (UPDATE/DELETE
--              half). Do not distribute before grading. Run AFTER
--              lab10_insert_data-key.sql, against the same database.

-- ---------------------------------------------------------------------
-- Exercise 4: a safe UPDATE -- SELECT the target row first, then
-- UPDATE with the exact same WHERE, then re-verify.
-- ---------------------------------------------------------------------

SELECT * FROM Section WHERE section_id = 2;   -- check first

UPDATE Section
SET room = '인지관 307'
WHERE section_id = 2;

SELECT * FROM Section WHERE section_id = 2;   -- confirm only this row changed

-- ---------------------------------------------------------------------
-- Exercise 5: a DELETE that hits a foreign-key error, on purpose, then
-- the correct fix.
-- ---------------------------------------------------------------------

-- This statement is EXPECTED TO FAIL -- instructor_id = 1 (Prof. Lee)
-- still teaches Section rows (section_id 1 and 4):
--
--   DELETE FROM Instructor WHERE instructor_id = 1;
--   ERROR 1451 (23000): Cannot delete or update a parent row: a
--   foreign key constraint fails
--
-- Grading note: full credit requires the student's submission to show
-- they actually ran this and captured the real error text (in a
-- comment, or their worksheet), not merely that they avoided it.

-- The correct fix: reassign (or remove) the dependent Section rows
-- first, THEN delete the Instructor row.
UPDATE Section SET instructor_id = 2 WHERE instructor_id = 1;

DELETE FROM Instructor WHERE instructor_id = 1;

-- Verification:
-- SELECT * FROM Section WHERE instructor_id = 1;  -- expect 0 rows
-- SELECT * FROM Instructor WHERE instructor_id = 1;  -- expect 0 rows

-- ===================================================================
-- CHALLENGE PROBLEM -- reference answer
-- ===================================================================

CREATE TABLE Transcript (
    student_id INT,
    section_id INT,
    grade VARCHAR(2),
    archived_on DATE
);

INSERT INTO Transcript (student_id, section_id, grade, archived_on)
SELECT student_id, section_id, grade, CURDATE()
FROM Enrollment
WHERE grade IS NOT NULL;

-- Upsert: re-enroll student 1 in section 1 without a duplicate-key
-- error, updating the grade instead (PRIMARY KEY (student_id, section_id)
-- already exists for this pair from lab10_insert_data-key.sql).
INSERT INTO Enrollment (student_id, section_id, grade)
VALUES (1, 1, 'A+')
ON DUPLICATE KEY UPDATE grade = 'A+';

-- ===================================================================
-- PRACTICE PROBLEMS -- reference answers (not distributed to students)
-- ===================================================================

-- Practice 1: add + enroll using LAST_INSERT_ID().
-- INSERT INTO Student (name, major) VALUES ('Jung Haeun', 'Data Science');
-- INSERT INTO Enrollment (student_id, section_id, grade)
--   VALUES (LAST_INSERT_ID(), 4, NULL);

-- Practice 2: safe UPDATE, checked first.
-- SELECT * FROM Student WHERE student_id = 1;
-- UPDATE Student SET major = 'Data Science' WHERE student_id = 1;

-- Practice 3: room change.
-- UPDATE Section SET room = '성파 615' WHERE section_id = 7;

-- Practice 4: precise withdrawal.
-- DELETE FROM Enrollment WHERE student_id = 12 AND section_id = 4;

-- Practice 5: diagnosing a rejected INSERT.
-- Fails because Section.instructor_id is a foreign key referencing
-- Instructor.instructor_id, and instructor_id = 9 does not exist yet.
-- INSERT INTO Instructor (name) VALUES ('Prof. Kwon');  -- gets id 9
-- INSERT INTO Section (course_code, instructor_id, room, semester)
--   VALUES ('CSE410', 9, '성파 810', '2026-1');

-- Practice 6: delete by subquery.
-- DELETE FROM Enrollment
-- WHERE student_id IN (
--     SELECT student_id FROM Student WHERE major = 'Software Engineering'
-- );

-- Practice 7: upsert a loan record.
-- INSERT INTO Loan (book_isbn, member_id, due_date)
--   VALUES ('978-0-13-608530-0', 4, '2026-09-20')
--   ON DUPLICATE KEY UPDATE due_date = '2026-09-20';

-- ===================================================================
-- FACILITATION NOTES
-- ===================================================================
-- - Exercise 5's foreign-key error is this lab's version of Lab 9's
--   Exercise 3: the point is reproducing the real error, not avoiding
--   it. Check for evidence they actually hit ERROR 1451.
-- - Common near-miss: students who DELETE the dependent Section rows
--   instead of reassigning them -- both are valid fixes; either earns
--   credit as long as the reasoning is stated.
-- - Common near-miss: forgetting the second verification query after
--   the safe UPDATE (Exercise 4) -- Completion credit expects the
--   "check before and after" pattern shown here, not just the UPDATE
--   itself.
