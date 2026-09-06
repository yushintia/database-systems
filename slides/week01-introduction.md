---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 1: Introduction

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!--
notes: Welcome the class. This session is the course contract: what this
course covers, how it's graded, what's expected of you, and how the
semester runs. No database content yet - that starts next week.
-->

---

<!-- SLOT 2: Where we are -->

# Where We Are

<div class="roadmap">
<div class="wk now"><div class="n">Wk 1</div><div class="t">Introduction</div></div>
<div class="wk"><div class="n">Wk 2</div><div class="t">Relational Model</div></div>
<div class="wk"><div class="n">Wk 3</div><div class="t">Data Modelling</div></div>
<div class="wk"><div class="n">Wk 4</div><div class="t">E-R Diagram</div></div>
<div class="wk review"><div class="n">Wk 5</div><div class="t">Quiz 1</div></div>
<div class="wk"><div class="n">Wk 6</div><div class="t">Mapping Algorithm</div></div>
<div class="wk"><div class="n">Wk 7</div><div class="t">Normalization</div></div>
<div class="wk review"><div class="n">Wk 8</div><div class="t">Midterm Exam</div></div>
<div class="wk"><div class="n">Wk 9</div><div class="t">DDL</div></div>
<div class="wk"><div class="n">Wk 10</div><div class="t">DML</div></div>
<div class="wk"><div class="n">Wk 11</div><div class="t">Single-table Queries</div></div>
<div class="wk"><div class="n">Wk 12</div><div class="t">Multi-table Queries</div></div>
<div class="wk review"><div class="n">Wk 13</div><div class="t">Quiz 2</div></div>
<div class="wk"><div class="n">Wk 14</div><div class="t">Case Study Presentation</div></div>
<div class="wk review"><div class="n">Wk 15</div><div class="t">Final Exam</div></div>
</div>

<!-- notes: Point at the row. Say: "Fifteen weeks. Today's the odd one out - it's about how this course works, not a technique. Weeks 5, 8, 13, and 15 are quizzes and exams; the other eleven each add one new piece of the database story." -->

---

<!-- Course intro: why this course, briefly, before the contract -->

# Why This Course

<div class="thread">One reason, in plain terms, before the course contract.</div>

Almost every backend, data, or analytics job expects you to know SQL
and how to design a database. "Design a schema for X" is one of the
most common questions in a technical interview.

Every idea this semester - from the first messy spreadsheet to the
final SQL query - is something you will be asked to use, by name, in
a job or a later course that assumes you already know it.

---

# Where This Skill Shows Up

<div class="thread">Not just a class requirement.</div>

<div class="chip-row">
<div class="chip">Backend Developer</div>
<div class="chip">Data Analyst</div>
<div class="chip">Data Engineer</div>
<div class="chip">DevOps / SRE</div>
<div class="chip">Business Analyst</div>
<div class="chip">Product Manager</div>
</div>

Every one of these roles, at some point, expects you to read a schema,
write a query, or explain why a design choice was made.

---

<!-- Running case study tease: the premise only, no numbers, no teaching -->

# This Semester's Running Example

<div class="thread">Not a topic yet. A mess we will fix, one piece at a time, all semester.</div>

The university's registration office keeps everything in one shared
file: a spreadsheet, edited by hand, by several different staff
members, every semester.

Sometimes the same student's name gets typed two different ways.
Sometimes two people save changes at almost the same moment. Sometimes
nobody can quickly answer a simple question, like "who is in this
class?"

We will use this same messy spreadsheet, all semester, to build
something that does not have these problems.

---

# The Cast of Characters

<div class="thread">Who actually touches this messy spreadsheet, every semester.</div>

<div class="cardlist">
<div class="card"><div class="h">Registration Staff</div><div class="d">type in new enrollments by hand, semester after semester</div></div>
<div class="card"><div class="h">Students</div><div class="d">show up as rows, sometimes more than once, under slightly different names</div></div>
<div class="card"><div class="h">Instructors</div><div class="d">get listed next to every section they teach, copied in by hand each time</div></div>
<div class="card"><div class="h">You</div><div class="d">the person who, by December, has to make this system trustworthy</div></div>
</div>

---

# A Note on This Semester's Case Study

<div class="thread">One honest disclaimer before we start.</div>

The "university registration office" in these slides is not any real
office, and its spreadsheet is not a real document. It is a
deliberately realistic, deliberately broken example, built so every
week can fix one more piece of it. Any resemblance to a system you
have actually used is the point, not a coincidence.

---

<!-- Discussion prompt, not answered today; Week 2 opens with exactly this -->

# One Question to Sit With

<div class="thread">Not answered today. Week 2 starts here.</div>

Imagine two people are each asked, separately, to turn that same
messy spreadsheet into "proper tables."

- Would they draw the same tables?
- If they disagree, who is right?

<!--
notes: A discussion prompt, not a lesson - do not answer it today.
Just let the class sit with the question for a moment. Week 2 opens
with exactly this scenario and starts answering it.
-->

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Course's Question

<div class="driving-q">"What must a system do, before we can trust it with data that matters?"</div>

---

# This Course's Three Goals

<div class="thread">Not just today's goals. This is the whole course, in three lines.</div>

| # | Goal (from the syllabus) | Where |
|---|---|---|
| 1 | Learn data models, the relational model, and SQL | Weeks 2, 9-12 |
| 2 | Design databases with E-R diagrams and normalization | Weeks 3-7 |
| 3 | Understand storage, queries, transactions, and recovery | Throughout the semester |

Every one of these three goals gets built, piece by piece, using the
university's own registration data as the running illustration - not
as an abstract exercise.

---

# How the Semester Is Organized

<div class="thread">Eleven working weeks, in four movements.</div>

<div class="chip-row">
<div class="chip">Weeks 2-4: Model It</div>
<div class="chip">Weeks 6-7: Fix It</div>
<div class="chip">Weeks 9-12: Query It</div>
<div class="chip">Week 14: Present It</div>
</div>

Each movement builds directly on the one before it; nothing here is
reordered or optional.

---

# Where This Course Fits

<div class="thread">Not an island. One link in a longer chain.</div>

- **Before this course:** Programming I & II, Data Structures, and
  Discrete Mathematics gave you the raw tools
- **This course:** turns those tools toward one specific problem -
  data that must stay correct as a system grows
- **After this course:** later project courses, capstones, and most
  software jobs simply assume you already know this material

---

<!-- _class: section -->

# End of 차시 1
<div class="driving-q">Short break. Next: the course description, objectives, and how this class runs.</div>

---

# Course Description

<div class="thread">From the official syllabus.</div>

This course introduces the principles of database systems: how data
is modeled, organized, and queried, so that it stays correct,
consistent, and useful as it grows. It covers data models and the
relational model, entity-relationship design and normalization, and
SQL for defining, changing, and querying data - working throughout
from one running case study: university course registration.

---

# What This Course Is Not

<div class="thread">Set expectations early, in plain terms.</div>

- **Not** a general programming course - we assume you can already code
- **Not** SQL syntax memorization - syntax is easy to look up, design
  judgment is not
- **Not** optional background knowledge - almost every later course and
  job assumes it

---

# Learning Objectives

<div class="thread">The official course objectives, from the syllabus - what you'll be able to do by Week 15.</div>

By the end of this course, you can:

<style scoped>
.cardlist { gap: 10px; margin-top: 6px; }
.cardlist .card { padding: 8px 18px; }
.cardlist .card .h { font-size: 17px; margin-bottom: 2px; }
.cardlist .card .d { font-size: 15px; line-height: 1.25; }
</style>

<div class="cardlist">
<div class="card"><div class="h">Files vs. Databases</div><div class="d">Explain why plain files fail, and what a database promises instead.</div></div>
<div class="card"><div class="h">E-R Modeling</div><div class="d">Model real-world requirements as an E-R diagram.</div></div>
<div class="card"><div class="h">Schemas &amp; Normalization</div><div class="d">Design relational schemas and apply normalization.</div></div>
<div class="card"><div class="h">DDL &amp; DML</div><div class="d">Write SQL to define (DDL) and change (DML) data.</div></div>
<div class="card"><div class="h">SQL Queries</div><div class="d">Write single-table and multi-table SQL queries.</div></div>
<div class="card"><div class="h">Keys &amp; Constraints</div><div class="d">Explain a schema's keys, constraints, and normal forms.</div></div>
<div class="card"><div class="h">Case Study Presentation</div><div class="d">Present a small database design as a finished case study.</div></div>
</div>

---

# Learning Objectives, In Context

<div class="thread">Same seven objectives, mapped to when each one is built.</div>

| Objective | Built in |
|---|---|
| Files vs. Databases | Weeks 1-2 |
| E-R Modeling | Weeks 3-4 |
| Schemas & Normalization | Weeks 6-7 |
| DDL & DML | Weeks 9-10 |
| SQL Queries | Weeks 11-12 |
| Keys & Constraints | Weeks 2, 7 |
| Case Study Presentation | Week 14 |

---

# Prerequisites

<div class="thread">What this course assumes you already have.</div>

- **Computer Programming I & II**
- **Data Structures**
- **Discrete Mathematics**

We do not start from zero. If any of these feel shaky, say so early -
it compounds fast otherwise.

---

# Prerequisites: Why They Matter

<div class="thread">Not a checklist for its own sake.</div>

- **Programming I & II:** you will write and read structured logic
  constantly, in SQL instead of Python or Java, same habits of mind
- **Data Structures:** thinking about how information is organized and
  accessed carries over directly
- **Discrete Mathematics:** set and logic thinking - "for all," "there
  exists," "belongs to" - reappears the moment we define a table precisely

---

# Prerequisites Self-Check

<div class="thread">Ungraded. Just for you, before Week 2.</div>

- Can you explain, out loud, what a function's input and output are?
- Can you describe, in your own words, the difference between a list
  and a set?
- Do the words "unique" and "duplicate" already mean something precise
  to you?

If any answer is "not really," that is useful information now, not in
Week 5.

---

# Textbooks

<div class="thread">One primary text. Everything else is optional support.</div>

- **Primary:** Silberschatz, Korth, Sudarshan, *Database System
  Concepts*, 7th ed., McGraw-Hill, 2019
- **Secondary:** Connolly & Begg, *Database Systems*; Elmasri &
  Navathe, *Fundamentals of Database Systems* (full details in the
  syllabus)
- **Also:** these lecture slides themselves are a listed course
  reference

---

# How to Actually Use the Textbook

<div class="thread">A book on a shelf teaches nobody anything.</div>

<div class="cardlist">
<div class="card"><div class="h">Before class</div><div class="d">skim the assigned chapter, just enough to recognize terms when they're spoken</div></div>
<div class="card"><div class="h">After class</div><div class="d">re-read the same chapter closely, now that you've seen the ideas in motion</div></div>
<div class="card"><div class="h">Before a quiz/exam</div><div class="d">use the chapter to check the slides, not replace them - slides are the primary reference</div></div>
<div class="card"><div class="h">Secondary texts</div><div class="d">only when the primary text's explanation isn't clicking, a second voice, not required reading</div></div>
</div>

---

# How This Course Runs

<div class="thread">What to expect from a 3-period block, every week.</div>

Each session runs three 50-minute periods, back to back, mixing short
lectures with:

<div class="cardlist">
<div class="card"><div class="h">A warm-up</div><div class="d">a short, concrete question to start, before any jargon</div></div>
<div class="card"><div class="h">A recap</div><div class="d">what last week delivered, and what it left unsolved</div></div>
<div class="card"><div class="h">Pair activities</div><div class="d">work through a real example with a partner, answer discussed right after</div></div>
<div class="card"><div class="h">A self-check</div><div class="d">ungraded, just for you, most weeks</div></div>
</div>

You will talk in this class, not just listen.

---

# A Typical Session, Minute by Minute

<div class="thread">Three 50-minute periods, one continuous flow.</div>

<div class="timeline">
<div class="pt"><div class="dot"></div><div class="y">Period 1</div><div class="d">Warm-up and recap, then new material begins</div></div>
<div class="pt"><div class="dot"></div><div class="y">Period 2</div><div class="d">Core lecture continues, pair activity worked through together</div></div>
<div class="pt"><div class="dot"></div><div class="y">Period 3</div><div class="d">Activity answers discussed, self-check, wrap-up</div></div>
</div>

---

# Weekly Schedule: Weeks 1-8

<div class="thread">The first half of the semester.</div>

| Wk | Topic |
|---|---|
| 1 | Introduction (today) |
| 2 | Relational Model |
| 3 | Data Modelling |
| 4 | E-R Diagram - **Assignment 1** |
| 5 | **Quiz 1** |
| 6 | Mapping Algorithm |
| 7 | Normalization |
| 8 | **Midterm Exam** |

---

# Weekly Schedule: Weeks 9-15

<div class="thread">The second half of the semester.</div>

| Wk | Topic |
|---|---|
| 9 | DDL |
| 10 | DML |
| 11 | Single-table Queries |
| 12 | Multi-table Queries - **Assignment 2** |
| 13 | **Quiz 2** |
| 14 | Case Study Presentation |
| 15 | **Final Exam** |

---

# What You'll Turn In, All Semester

<div class="thread">Every graded item, in one place, well before it's due.</div>

<div class="chip-row">
<div class="chip">Assignment 1 - Wk 4</div>
<div class="chip">Quiz 1 - Wk 5</div>
<div class="chip">Midterm - Wk 8</div>
<div class="chip">Assignment 2 - Wk 12</div>
<div class="chip">Quiz 2 - Wk 13</div>
<div class="chip">Presentation - Wk 14</div>
<div class="chip">Final - Wk 15</div>
</div>

---

<!-- _class: section -->

# End of 차시 2
<div class="driving-q">Short break. Next: grading, assignments, and policy.</div>

---

# Grading Breakdown

<div class="thread">Six components, 100% total.</div>

| Item | Weight |
|---|---|
| Attendance | 10% |
| Midterm | 30% |
| Final | 30% |
| Assignments | 10% |
| Presentation | 10% |
| In-class items | 10% |

<!-- notes: Say Assignment 1 is due Week 4. Assignment 2 is due Week 12. Quiz 1 is Week 5. Quiz 2 is Week 13. -->

---

# Grade Distribution Guideline

<div class="why">
<strong>Grade distribution guideline:</strong> A ≤30%, B ≤40%, C-F ≤30%
of the class. This may shift after the add/drop period, based on final
enrollment.
</div>

This is a guideline the department uses to keep grading consistent
across sections, not a fixed quota applied rigidly to a small class.

---

# Grading: What Counts as "In-Class Items"

<div class="thread">The 10% nobody asks about until it matters.</div>

- Warm-up questions and self-checks, most sessions, counted lightly
- Not a surprise pop quiz - always the same low-stakes format you'll
  see from Week 1 onward
- Purpose: reward showing up and engaging, not memorization under
  pressure

---

# Where to Find Course Materials

<div class="thread">Everything lives in one predictable place.</div>

- **Slides:** posted after each session, not before - they are the
  primary reference for exams
- **Syllabus & handbook:** the official record of policy; these slides
  summarize it, they don't replace it
- **Assignment specs:** released the week each assignment opens, with a
  rubric attached from day one

---

# Assignments

<div class="thread">Two assignments, spaced across the semester.</div>

| # | Released | Due | Topic |
|---|---|---|---|
| 1 | Wk 2 | Wk 4 | E-R diagram design for a small system |
| 2 | Wk 9 | Wk 12 | SQL: schema, data, and multi-table queries |

---

# Assignment 1, In Detail

<div class="thread">Released Week 2, due Week 4.</div>

- Choose any small real-world system (not necessarily the registration
  system)
- Submit a diagram identifying its entities, relationships, and
  cardinalities
- Graded on completeness and clarity, not on which system you picked

---

# Assignment 2, In Detail

<div class="thread">Released Week 9, due Week 12.</div>

- Builds directly on Assignment 1's design, carried forward and refined
- Submit a working schema, sample data, and a set of queries answering
  specific questions
- Graded on whether the schema is well-formed and the queries return
  correct results

---

# Grading Rubric Philosophy

<div class="thread">The same three questions, every rubric, every assignment.</div>

- **Is it complete?** Did you address every part of the prompt?
- **Is it correct?** Does the design or answer actually satisfy the
  stated requirements?
- **Is it clear?** Could someone who wasn't in your head follow your
  reasoning?

Partial credit exists for all three, independently - a
complete-but-flawed answer is graded differently than a
correct-but-incomplete one.

---

# Feedback Policy

<div class="thread">From the syllabus, verbatim.</div>

> Assignments graded within one week with rubric and model answers;
> exam item-analysis shared with weak-topic guidance and individual
> review on request.

In plain terms: you will know what you got wrong, and why, quickly
enough for it to still matter for the next assignment or exam.

---

# What To Do With Feedback

<div class="thread">Feedback you don't act on is wasted feedback.</div>

- Read the rubric comments before your next assignment, not just the
  score
- If the same comment appears twice, that is now a pattern worth
  fixing deliberately
- Model answers are posted to compare your approach, not just your
  result

---

# If You Disagree With a Grade

<div class="thread">A real process, not a shrug.</div>

Email the instructor within one week of grades being posted, pointing
to the specific rubric item you believe was misapplied. Regrades are
reviewed against the same rubric everyone else was graded on - a
regrade can raise or lower a score.

---

# Attendance Policy

<div class="thread">Concrete rules, stated once, so nobody is surprised later.</div>

<div class="cardlist">
<div class="card"><div class="h">Attendance</div><div class="d">is 10% of your grade and is recorded every session.</div></div>
<div class="card"><div class="h">Late arrival</div><div class="d">arriving within 15 minutes of the start is on-time; after that, you're marked late. Three lates equal one absence.</div></div>
</div>

---

# Excused Absence & Late Work

<div class="cardlist">
<div class="card"><div class="h">Can't attend</div><div class="d">Email the instructor <em>before</em> the session to be marked excused - unexcused absences aren't eligible for makeup credit.</div></div>
<div class="card"><div class="h">Late work</div><div class="d">loses 10% of that assignment's grade per day late, up to 3 days. No credit after 3 days, unless arranged with the instructor in advance.</div></div>
</div>

---

# Late Work: A Worked Example

<div class="thread">The policy, in actual numbers.</div>

Assignment 2 is due Monday, worth 100 points. You submit it Wednesday,
two days late, scoring 90/100 on content. Two days late costs 10% per
day: 20% off, leaving 72/100. Submit on day 4, and the assignment
earns zero, regardless of content, unless arranged in advance.

---

<!-- _class: section -->

# End of 차시 3
<div class="driving-q">Short break. Next: academic integrity, accommodations, and how to reach the instructor.</div>

---

# Academic Integrity

<div class="thread">Same principle as attendance: stated once, plainly.</div>

- **Academic integrity:** submit your own work. Copying another
  student's work, having someone else complete it for you, or
  submitting unattributed AI-generated work as your own is a
  violation.
- **First violation:** zero credit on that assignment or exam, plus a
  formal report. **Repeat violation:** may result in failing the
  course, per university policy.
- If anything here is unclear, ask - now is the cheapest time to ask.

---

# Academic Integrity: What Counts as a Violation

<div class="thread">Concrete, not abstract.</div>

- Copying another student's assignment or exam answers, in whole or in
  part
- Letting someone else complete your assignment, or paying or asking
  someone to do it for you
- Submitting AI-generated work as entirely your own, with no
  acknowledgment

---

# Academic Integrity: What's Actually Fine

<div class="thread">Collaboration is not the same as copying.</div>

- Discussing concepts with classmates, in your own words, before each
  of you writes your own answer
- Asking the instructor, or a study partner, to explain something
  you're stuck on
- Using an AI tool to explain a concept, then writing and understanding
  your own submitted answer

---

# Academic Integrity: Using AI Tools

<div class="thread">Not banned. Not a shortcut either.</div>

AI tools may help you understand a concept or check your own
reasoning. They may not generate your submitted answer for you. If
asked, you must be able to explain, unaided, every part of what you
submitted. When in doubt about a specific use, ask before submitting,
not after.

---

# Support for Students with Disabilities

<div class="thread">From the syllabus's accommodations section.</div>

- **Hearing-impaired:** front-row seating, lecture material files
  provided where possible, urgent notices given in writing
- **Mobility-impaired:** extended exam time
- **Other documented conditions:** extended exam time, materials
  provided in advance, enlarged exam copies, or other reasonable
  accommodation based on need

Contact the instructor early, and the Disability Student Support
Center or Academic Affairs Team, so accommodations are ready before
you need them.

---

# How Accommodations Work, Step by Step

<div class="thread">A process, not a one-time form.</div>

1. Contact the instructor and the Disability Student Support Center
   early, ideally before Week 3
2. Submit any required documentation through the official university
   process
3. Accommodations are confirmed and ready to use before the first
   assessment they apply to, not arranged the week of

---

# Contact

<div class="thread">How to reach the instructor.</div>

- **Email:** yushintia@deu.ac.kr
- **Office hours:** by email appointment
- Email is the fastest way to reach the instructor outside of class.

---

# Office Hours, In Practice

<div class="thread">"By email appointment" means exactly this.</div>

- Email a specific question or topic, and two or three times that work
  for you
- Expect a reply within one to two business days
- Bring specific questions or work in progress - "I don't get it" is a
  harder starting point than "I don't understand why this step
  changed here"

---

# Classroom Expectations

<div class="thread">Small, stated once, so nobody guesses.</div>

- Laptops open for note-taking and in-class activities, not unrelated
  browsing
- Phones silent, away during lecture, fine to check during breaks
- Respectful disagreement is welcome; talking over a classmate is not

---

# Weekly Prep: What "Skim the Chapter" Means

<div class="thread">A concrete five-minute task, not a vague suggestion.</div>

- Read the chapter's headings and bolded terms only, once
- Note one term you don't recognize, and bring that question to class
- That's it - the goal is familiarity before lecture, not mastery
  before lecture

---

<!-- SLOT N+1: Limits (Act 4 / CLOSE), reused in Week 2's slot 3 recap -->

# What Today Doesn't Give You Yet

<div class="limits">
You now know how this course runs, how you are graded, and what is
expected of you. You have not yet touched a single database problem:
you don't know why a plain spreadsheet or file breaks once real data
and real people are involved, or what a database promises instead.
Knowing the rules of the course is not the same as knowing why this
subject exists.
</div>

---

<!-- SLOT N+2: Bridge -->

# Next Week

Week 1 leaves **why plain files and spreadsheets break, and what
replaces them** unsolved. **Week 2, The Relational Model**, starts
that story: the exact mess a spreadsheet makes, and the first precise
idea - a relation, a properly defined table - built to fix it.

---

<!-- SLOT N+3: Summary -->

# Summary

- This course: data models, relational design, and SQL - grounded in
  one running case study, the university's own registration system.
- Grading: Attendance 10%, Midterm 30%, Final 30%, Assignments 10%,
  Presentation 10%, In-class items 10%.
- Assignments due Weeks 4 and 12. Quizzes in Weeks 5 and 13. Graded
  within one week, with a rubric and model answers.
- Primary text: Silberschatz et al., 7th ed. Contact:
  yushintia@deu.ac.kr.
- **Prepare:** skim Chapter 1 before Week 2. No exercises due.

---

<!-- SLOT N+4: Thank You -->
<!-- _class: end -->

# Thank You
