-- Course     : 511783-001 Database Systems
-- Lab        : Lab 06: The Mapping Algorithm
-- Description: Reference schema — the mechanically-mapped registration
--              system, produced by applying Rules 1-4 to the Week 4 E-R
--              diagram. This is a SELF-CHECK file: compare your own
--              hand-mapped tables against this, do not just copy it.
--              This exact schema is also Week 7's normalized target —
--              the Week 4 diagram was already clean, so mapping it
--              introduced no anomalies to normalize away.
--
-- Idempotent: safe to run from scratch, any number of times.

DROP DATABASE IF EXISTS registration_db;
CREATE DATABASE registration_db;
USE registration_db;

-- Rule 1 (strong entity -> relation): Student, Course, Instructor each
-- copy their attributes and key directly across, no design decision.

CREATE TABLE Student (
  student_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  major VARCHAR(100),
  CONSTRAINT pk_student PRIMARY KEY (student_id)
);

CREATE TABLE Course (
  course_code VARCHAR(10) NOT NULL,
  title VARCHAR(100) NOT NULL,
  CONSTRAINT pk_course PRIMARY KEY (course_code)
);

CREATE TABLE Instructor (
  instructor_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  CONSTRAINT pk_instructor PRIMARY KEY (instructor_id)
);

-- Rule 2 (1:N -> foreign key on the "many" side): Course (1) has
-- Section (N), and Instructor (1) teaches Section (N). Both foreign
-- keys land on Section, never on Course or Instructor.

CREATE TABLE Section (
  section_id    INT NOT NULL,
  course_code   VARCHAR(10) NOT NULL,
  instructor_id INT NOT NULL,
  room          VARCHAR(20),
  semester      VARCHAR(20),
  CONSTRAINT pk_section PRIMARY KEY (section_id),
  CONSTRAINT fk_section_course FOREIGN KEY (course_code)
    REFERENCES Course (course_code),
  CONSTRAINT fk_section_instructor FOREIGN KEY (instructor_id)
    REFERENCES Instructor (instructor_id)
);

-- Rule 3 (weak entity -> composite-key relation) and Rule 4 (M:N ->
-- new relation with composite key) agree on the identical result:
-- Enrollment is both Student-and-Section's weak entity AND the
-- resolution table for Student M:N Section. student_id and
-- section_id are each simultaneously part of the composite primary
-- key AND a foreign key to their owning entity.

CREATE TABLE Enrollment (
  student_id INT NOT NULL,
  section_id INT NOT NULL,
  grade      VARCHAR(2),
  CONSTRAINT pk_enrollment PRIMARY KEY (student_id, section_id),
  CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id)
    REFERENCES Student (student_id),
  CONSTRAINT fk_enrollment_section FOREIGN KEY (section_id)
    REFERENCES Section (section_id)
);
