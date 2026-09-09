-- Course     : 511783-001 Database Systems
-- Lab        : Lab 07: Normalization
-- Description: Anomaly-triggering statements for the denormalized
--              Section table created by bad_registration_seed.sql.
--
-- Run bad_registration_seed.sql FIRST. Then run the statements below
-- ONE AT A TIME, in order, reading the comment above each block before
-- you run it. After each numbered anomaly, run its "Observe" query and
-- record what you see in lab07_anomalies.md. Do not run the whole file
-- at once — the point is to watch each anomaly happen, one at a time.

USE registration_db;

-- =======================================================================
-- ANOMALY 1: UPDATE anomaly
-- =======================================================================
-- Prof. Lee (instructor_id 2) gets married and changes her name. A staff
-- member updates the section they happen to have open on screen —
-- section_id 2 — and forgets that Prof. Lee also teaches section_id 3.

UPDATE Section
SET instructor_name = 'Professor S. Lee'
WHERE section_id = 2;

-- Observe: the same instructor now has two different names on file,
-- depending on which Section row you look at.
SELECT section_id, instructor_id, instructor_name
FROM Section
WHERE instructor_id = 2;

-- Expected (before you run the fix in Lab 07's normalized design):
-- | section_id | instructor_id | instructor_name    |
-- |------------|---------------|---------------------|
-- | 2          | 2             | Professor S. Lee    |
-- | 3          | 2             | Prof. Lee            |
-- One real instructor, two disagreeing rows. Nothing in the schema
-- caught this, because instructor_name was never tied to instructor_id
-- by a single, authoritative row.

-- =======================================================================
-- ANOMALY 2: DELETE anomaly
-- =======================================================================
-- CS330 ("Operating Systems") and Dr. Park (instructor_id 3) exist
-- ONLY inside section_id 4's denormalized columns — check first.

SELECT * FROM Course WHERE course_code = 'CS330';       -- already 0 rows
SELECT * FROM Instructor WHERE instructor_id = 3;        -- already 0 rows

-- CS330 is being retired and its last section for the term is closed out.

DELETE FROM Section WHERE section_id = 4;

-- Observe: every trace of "Operating Systems" and "Dr. Park" is now
-- gone from the ENTIRE database, not just from Section.
SELECT * FROM Section WHERE course_code = 'CS330';       -- 0 rows
SELECT * FROM Course WHERE course_code = 'CS330';        -- 0 rows
SELECT * FROM Instructor WHERE instructor_id = 3;         -- 0 rows

-- Before the DELETE, "Operating Systems" and "Dr. Park" were still
-- real, nameable things, you could ask about them. After it, the
-- database has no record either one ever existed. Deleting one
-- section deleted two unrelated facts as a side effect.

-- =======================================================================
-- NOTE: the insertion anomaly (not run here)
-- =======================================================================
-- A third anomaly needs no UPDATE or DELETE to demonstrate: try to
-- record a brand-new adjunct instructor, "Dr. Choi", who has been hired
-- but has not been assigned a section yet. There is no row to put her
-- name in — Instructor has no independent existence in this design,
-- it only shows up copied inside a Section row. You cannot insert
-- Dr. Choi's name at all until she is assigned a section, which is
-- backwards: a real instructor should be recordable before their
-- teaching schedule is.
