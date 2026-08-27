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

# Learning Objectives

<div class="thread">The official course objectives, from the syllabus - what you'll be able to do by Week 15.</div>

By the end of this course, you can:

1. Explain why plain files fail, and what a database promises instead.
2. Model real-world requirements as an E-R diagram.
3. Design relational schemas and apply normalization.
4. Write SQL to define (DDL) and change (DML) data.
5. Write single-table and multi-table SQL queries.
6. Explain a schema's keys, constraints, and normal forms.
7. Present a small database design as a finished case study.

---

# Prerequisites

<div class="thread">What this course assumes you already have.</div>

- **Computer Programming I & II**
- **Data Structures**
- **Discrete Mathematics**

We do not start from zero. If any of these feel shaky, say so early -
it compounds fast otherwise.

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

# Weekly Schedule

<div class="thread">One line per week - the full walkthrough.</div>

| Wk | Topic | Wk | Topic |
|---|---|---|---|
| 1 | Introduction (today) | 9 | DDL |
| 2 | Relational Model | 10 | DML |
| 3 | Data Modelling | 11 | Single-table Queries |
| 4 | E-R Diagram - **Assignment 1** | 12 | Multi-table Queries - **Assignment 2** |
| 5 | **Quiz 1** | 13 | **Quiz 2** |
| 6 | Mapping Algorithm | 14 | Case Study Presentation |
| 7 | Normalization | 15 | **Final Exam** |
| 8 | **Midterm Exam** | | |

---

<!-- _class: section -->

# End of 차시 2
<div class="driving-q">Short break. Next: grading, assignments, and policy.</div>

---

# Grading & Materials

<div class="thread">Six components, 100% total.</div>

| Item | Weight |
|---|---|
| Attendance | 10% |
| Midterm | 30% |
| Final | 30% |
| Assignments | 10% |
| Presentation | 10% |
| In-class items | 10% |

<div class="why">
<strong>Grade distribution guideline:</strong> A ≤30%, B ≤40%, C-F ≤30%
of the class. This may shift after the add/drop period, based on final
enrollment.
</div>

<!-- notes: Say Assignment 1 is due Week 4. Assignment 2 is due Week 12. Quiz 1 is Week 5. Quiz 2 is Week 13. -->

---

# Assignments

<div class="thread">Two assignments, spaced across the semester.</div>

| # | Released | Due | Topic |
|---|---|---|---|
| 1 | Wk 2 | Wk 4 | E-R diagram design for a small system |
| 2 | Wk 9 | Wk 12 | SQL: schema, data, and multi-table queries |

---

# Feedback Policy

<div class="thread">From the syllabus, verbatim.</div>

> Assignments graded within one week with rubric and model answers;
> exam item-analysis shared with weak-topic guidance and individual
> review on request.

In plain terms: you will know what you got wrong, and why, quickly
enough for it to still matter for the next assignment or exam.

---

# Attendance & Late Work

<div class="thread">Concrete rules, stated once, so nobody is surprised later.</div>

- **Attendance** is 10% of your grade and is recorded every session.
- **Late arrival:** arriving within 15 minutes of the start is on-time;
  after that, you're marked late. Three lates equal one absence.
- **Can't attend?** Email the instructor *before* the session to be
  marked excused - unexcused absences aren't eligible for makeup credit.
- **Late work:** loses 10% of that assignment's grade per day late, up
  to 3 days. No credit after 3 days, unless arranged with the
  instructor in advance.

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

# Contact

<div class="thread">How to reach the instructor.</div>

- **Email:** yushintia@deu.ac.kr
- **Office hours:** by email appointment
- Email is the fastest way to reach the instructor outside of class.

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
