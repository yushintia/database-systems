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
notes: Welcome. Ask who has ever lost a file to a bad save, or fought over
a shared spreadsheet with a classmate. That show of hands is today's hook.
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

<!-- notes: Point out the arc: model, design, build, query. Fifteen weeks, one argument. -->

---

<!-- SLOT 3: What you already have -->

# What You Already Bring

- **Computer Programming**: you can write logic that manipulates data
- **Data Structures**: you know arrays, lists, trees. A database is a structure too, just one built for millions of rows and many users at once
- **Discrete Mathematics**: sets and relations. The relational model in Week 2 is built directly on set theory

We are not starting from zero. We are pointing what you know at a new problem.

---

<!-- Course logistics appendix: administrative, outside the spine, placed here so it doesn't blunt slot 4 -->

<!-- _class: section -->

# Course Logistics
<div class="driving-q">Read once now, referenced all semester.</div>

---

# Grading & Materials

| Item | Weight |
|---|---|
| Attendance | 10% |
| Midterm | 30% |
| Final | 30% |
| Assignments | 10% |
| Presentation | 10% |
| In-class items | 10% |

<!-- notes: Assignment 1 due Week 4 (E-R Diagram). Assignment 2 due Week 12 (Multi-table Queries). Quiz 1 Week 5, Quiz 2 Week 13. -->

---

# Textbook, Policy & Contact

- **Textbook:** Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th ed., McGraw-Hill, 2019
- **References:** Connolly & Begg, *Database Systems*, 6th ed.; Elmasri & Navathe, *Fundamentals of Database Systems*, 7th ed.
- **Policy:** attend and participate every class; late assignments are penalized; plagiarism and cheating lead to disciplinary action
- **Contact:** yushintia@deu.ac.kr, office hours by email appointment

---

<!-- SLOT 4: The pain (Act 1 / MOTIVATE), zero jargon -->

# Inside the Registration Office

<div class="pain">

The registration office keeps everything in one spreadsheet:
`registrations.xlsx`, 40,000 rows and growing every semester. Each
staff member keeps their own working copy, downloaded once, edited
over time, then uploaded back to the shared drive.

Today: a professor emails asking who is enrolled in her class. Two
staff both uploaded this week. Whoever saved last silently replaced
the other's edits, no warning, no merge. One student's major is spelled
three different ways in three different rows. Nobody can say, right
now, exactly who is enrolled in CSE301. Someone has to scroll and read,
by eye, 40,000 rows, hoping not to miss one.

</div>

<!-- notes: Do not use the word "database" yet. Let them feel the mess first. -->

---

# How Long Does That Actually Take?

<div class="barchart">
<div class="bar-row">
  <div class="bar-label">By eye, spreadsheet</div>
  <div class="bar-track"><div class="bar-fill long" style="width: 100%"></div></div>
  <div class="bar-value">~3 hours, one class</div>
</div>
<div class="bar-row">
  <div class="bar-label">By query, SQL (Week 11)</div>
  <div class="bar-track"><div class="bar-fill short" style="width: 3%"></div></div>
  <div class="bar-value">under 1 second, any class</div>
</div>
</div>

This is not a small inconvenience. It is the entire reason this course exists.

<!-- notes: Let the tiny second bar sit in silence for a second. That gap is the whole semester. -->

---

<!-- SLOT 5: Cost of not knowing -->

# What Else This Actually Costs

- A student's grade attaches to the wrong row: wrong transcript, and no one notices until graduation
- Two staff each upload their own copy: whoever saves last wins, the other's edits vanish with no warning
- A crash mid-save corrupts the file, with no way to know what was lost

<div class="why">
<strong>In industry:</strong> most backend and data jobs assume SQL and
relational design; "design a schema for X" is a standard interview
question. At larger scale, this exact class of mistake has caused real
multi-hour outages at major tech companies.
</div>

---

# It Gets Worse With Every Extra Person

<div class="barchart">
<div class="bar-row">
  <div class="bar-label">2 staff, dueling uploads</div>
  <div class="bar-track"><div class="bar-fill risk-low" style="width: 20%"></div></div>
  <div class="bar-value">already happened</div>
</div>
<div class="bar-row">
  <div class="bar-label">50 students, one popular class</div>
  <div class="bar-track"><div class="bar-fill risk-med" style="width: 55%"></div></div>
  <div class="bar-value">rising conflict risk</div>
</div>
<div class="bar-row">
  <div class="bar-label">3,000 students, 수강신청 rush</div>
  <div class="bar-track"><div class="bar-fill risk-high" style="width: 92%"></div></div>
  <div class="bar-value">conflict, guaranteed</div>
</div>
</div>
<div class="bar-note">illustrative, not measured data: the point is the trend, not the exact numbers</div>

You have all lived the third bar. A system with no answer for it
**will** lose someone's seat, silently.

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What must a system provide before we can trust it with data that matters?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

1. Explain why file-processing systems fail at scale
2. Describe the three levels of data abstraction and why each exists
3. Name the major data models and where each fits in this course
4. State this course's three official objectives and where each is covered

---

# This Course's Three Objectives

<div class="thread">Not just this week's goals. This is what the syllabus commits this whole course to.</div>

| # | Objective (from the syllabus) | Where |
|---|---|---|
| 1 | Understand data models, the relational model, and SQL, to define, manipulate, and retrieve data | Weeks 2, 9-12 |
| 2 | Design relational databases using the E-R approach and normalization theory | Weeks 3-7 |
| 3 | Explain data storage, query processing, transaction management, concurrency control, and recovery | Previewed today, Week 1 |

Objective 3 is why today covers the DBMS engine at a glance: it is the
only week this course states it explicitly.

---

<!-- _class: section -->

# End of 차시 1
<div class="driving-q">Short break. 차시 2 starts with: where did all this come from?</div>

---

<!-- SLOT 8: Origin -->

# This Problem Is Not New

<div class="thread">You just felt the pain. Now: who else felt it, and what did they do about it?</div>

- **1960s:** data lived in hand-written file-processing systems; every
  application wrote its own file format and its own read/write logic
- Every new application either duplicated data, or wrote brittle code to
  reach into another application's files. Sound familiar?

<div class="why">
Imagine if KakaoTalk, your banking app, and 배달의민족 each kept their
own private copy of your phone number. Change it in one, the other two
never find out. That was every app, all the time, before this course's
subject existed.
</div>

Companies spent **decades** and serious money on exactly this
problem, at a scale of millions of records, not 40,000 rows.

---

# Fifty Years of Solving Your Spreadsheet Problem

<div class="timeline">
<div class="pt"><div class="dot"></div><div class="y">1960s</div><div class="d">File-processing systems<br>every app, its own format</div></div>
<div class="pt"><div class="dot"></div><div class="y">1970</div><div class="d">Edgar F. Codd (IBM)<br>the relational model</div></div>
<div class="pt"><div class="dot"></div><div class="y">1974</div><div class="d">IBM System R<br>SQL is born</div></div>
<div class="pt"><div class="dot"></div><div class="y">Today</div><div class="d">PostgreSQL, MySQL, Oracle<br>the same ideas, still running</div></div>
</div>

The relational model won because it separated **what** you ask for from
**how** the machine gets it. That idea is this whole course.

---

<!-- SLOT 9: Core concept -->

# Database & DBMS: Definition

<div class="thread">Fifty years of engineering point at two words. Here they are, precisely.</div>

> A **database** is an organized collection of related data.
> A **database management system (DBMS)** is software that lets users
> define, create, maintain, and control access to a database.

- **Data**: raw facts, such as `"Kim Minji", "CSE301", "A0"`
- **Database**: the organized collection (the tables, not the spreadsheet)
- **DBMS**: the software layer that keeps the collection correct even
  when many people use it at once (PostgreSQL, MySQL, Oracle, and so on)

Every time you unlock your phone and your Instagram feed loads, or your
banking app shows your balance, a DBMS answered that request, correctly,
in milliseconds. That is what you are learning to build this semester.

---

<!-- Act 3 / BUILD: Why File Systems Fail, one anomaly at a time -->

# Why File Systems Fail: Seven Names for One Morning

<div class="thread">You have already lived every failure on this list. Today they get names.</div>

Textbooks (Silberschatz, Ch. 1.2) group file-processing failures into
seven categories. The next seven slides take them one at a time, each
with the exact moment from the registration office that shows it.

---

# 1. Redundancy & Inconsistency

<div class="thread">First name: the problem with typing the same fact more than once.</div>

**Redundancy:** the same fact, stored in more than one place.
**Inconsistency:** those copies disagree with each other.

<div class="pain">
Kim Minji's name is typed three times in `registrations.xlsx`: "Kim
Minji," "MinJi Kim," "김민지." Three copies of one fact, and no rule
saying which one is correct.
</div>

---

# 2. Difficulty Accessing Data

<div class="thread">Second name: the problem with 40,000 rows and no way to ask a question.</div>

A file system has no built-in way to ask a question. Every new question
means writing new code, or, for the registration office, scrolling by eye.

<div class="pain">
"Who is enrolled in CSE301?" took someone roughly three hours to answer
by eye. The same question, asked as a query in Week 11, takes under a
second.
</div>

---

# 3. Data Isolation

<div class="thread">Third name: the problem with data scattered across files that don't talk to each other.</div>

Related data, split across separate files or separate copies, with no
way for one program to read across all of them at once.

<div class="pain">
Each staff member's downloaded copy is its own island. A question like
"which students did BOTH advisors update this week?" cannot be
answered, because no single copy has both people's edits.
</div>

---

# 4. Integrity Problems

<div class="thread">Fourth name: the problem with a spreadsheet that accepts anything you type.</div>

**Integrity constraints** are rules data must obey (a grade must be a
valid grade). A spreadsheet cell has no idea what a valid grade is.

<div class="pain">
Nothing stops a staff member from typing "A99" into the Grade column,
or "-3" into an attendance count. The cell accepts it, silently.
</div>

---

# 5. Atomicity Problems

<div class="thread">Fifth name: the problem with a save that gets interrupted halfway.</div>

An operation should either fully happen or not happen at all. A file
save has no such guarantee.

<div class="pain">
A crash mid-save leaves `registrations.xlsx` half-written: some rows
updated, some not, no record of which. There is no way to know what
was lost.
</div>

---

# 6. Concurrent-Access Anomalies

<div class="thread">Sixth name: the problem with two people editing at once.</div>

When multiple people update the same data around the same time with no
coordination, one person's work can silently overwrite another's.

<div class="pain">
Two staff both uploaded `registrations.xlsx` this week. Whoever saved
last silently replaced the other's edits. No warning, no merge.
</div>

---

# 7. Security Problems

<div class="thread">Seventh and last name: the problem with everyone seeing everything.</div>

Not every user should see or change every piece of data. A shared file
has no concept of "your data" versus "everyone's data."

<div class="pain">
Anyone with `registrations.xlsx` can read and edit every student's
grade, in every class, department-wide. There is no restriction by role.
</div>

---

# Seven Failures, One Cause

<div class="thread">Same seven names, now side by side. All seven, one file, one office.</div>

| # | Failure | Registration office example |
|---|---|---|
| 1 | Redundancy & inconsistency | Kim Minji, spelled three ways |
| 2 | Difficulty accessing data | The 3-hour scroll |
| 3 | Data isolation | Copies that can't be combined |
| 4 | Integrity problems | A grade of "A99" |
| 5 | Atomicity problems | The crash mid-save |
| 6 | Concurrent-access anomalies | The dueling uploads |
| 7 | Security problems | Everyone can edit everyone's grade |

A DBMS exists to solve exactly these seven, at once, permanently.

---

# Case Study: What's Actually in That Spreadsheet

<div class="thread">Seven failures, one file. Here is that exact file, so you can see all seven in the flesh.</div>

This semester, every week's example uses the same system: **university
course registration**. A real excerpt from `registrations.xlsx`,
unedited:

| Student | Major | Course | Instructor | Grade |
|---|---|---|---|---|
| Kim Minji | Computer Sci. | CSE301 | Prof. Lee | |
| <span style="color:#C0392B;font-weight:700">MinJi Kim</span> | <span style="color:#C0392B;font-weight:700">CS</span> | CSE301 | Prof. Lee | A0 |
| <span style="color:#C0392B;font-weight:700">김민지</span> | <span style="color:#C0392B;font-weight:700">Comp. Science</span> | CSE301 | <span style="color:#C0392B;font-weight:700">(blank)</span> | |
| Park Jiho | Software Eng. | CSE305 | Prof. Han | A- |

Same student, three rows, three spellings of her name and her major.
One instructor cell just empty. This is what you were scrolling through.

---

# Case Study: How the Pieces Will Connect

<div class="thread">The mess above is one flat sheet. By Week 7 it becomes four small, connected tables. Here is the shape we are building toward.</div>

<div class="pipeline">
<div class="stage"><div class="h">Student</div><div class="s">who</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Enrollment</div><div class="s">signs up for</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Section</div><div class="s">a class, a room, a time</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Course</div><div class="s">CSE301, the subject itself</div></div>
</div>

Each Section is also taught by one **Instructor**, its own small table.
No name is ever retyped twice; every table links to the next by a
shared ID, not a shared spelling. The formal diagram for this arrives
in **Week 4**; for now, just the shape.

---

# Case Study: Meet the Registration System

<div class="thread">Five plain-language names. You will see these five words in every remaining week of this course.</div>

By **Week 7**, the messy sheet becomes five clean, related tables:

<div class="chip-row">
<span class="chip">Student</span>
<span class="chip">Course</span>
<span class="chip">Instructor</span>
<span class="chip">Section</span>
<span class="chip">Enrollment</span>
</div>

We build toward that, one concept at a time.

---

# Databases Are Already in Your Pocket

<div class="thread">You just met one running example. Here is where databases live in ones you already use every day.</div>

<div class="appgrid">
<div class="app"><div class="name">KakaoTalk</div><div class="desc">your whole chat history, searchable instantly</div></div>
<div class="app"><div class="name">Instagram</div><div class="desc">a feed built from millions of posts, live</div></div>
<div class="app"><div class="name">배달의민족</div><div class="desc">your orders, the restaurant's live menu</div></div>
<div class="app"><div class="name">Banking app</div><div class="desc">your balance, correct, every refresh</div></div>
<div class="app"><div class="name">Netflix</div><div class="desc">exactly where you paused, on any device</div></div>
</div>

None of these apps are "a database." Every one of them **runs on** one,
answering a question like this, thousands of times a second.

---

# The DBMS Landscape

<div class="thread">Same idea, now by product name, and which IT solution each one actually runs.</div>

| Product | Powers |
|---|---|
| **PostgreSQL / MySQL** | Most e-commerce and web backends: a Coupang-style storefront |
| **SQLite** | Lives inside the phone itself: local storage in almost every app |
| **Oracle / SQL Server** | Banks, airlines, large enterprise systems |
| NoSQL (mentioned, not covered) | Social feeds and chat, at massive scale |

Relational (this course) remains the default choice whenever data has
clear structure and correctness matters more than flexibility, which
describes most business, academic, and financial systems.

---

<!-- _class: section -->

# End of 차시 2
<div class="driving-q">Short break. 차시 3 starts with: how a DBMS actually solves all seven.</div>

---

<!-- Act 3 / BUILD, continued -->

# A DBMS Shows Different Faces to Different People

<div class="thread">You now know the failures, and you have met the running example. Here is the first piece of how a DBMS fixes it: it never mixes these three questions.</div>

A spreadsheet answers "what is the data, and how do I see it, and how
is it stored" all in one flat sheet. A DBMS keeps three separate
answers, called levels of abstraction. The next three slides take them
one at a time, from the bottom up.

---

# Level 1: Physical

<div class="thread">The lowest level: how bytes actually sit on disk. Nobody in the registration office ever needs to see this.</div>

**Physical level:** file layout, indexes, exactly how and where the
bytes are stored.

<div class="why">
When IT migrates the university's servers to new hardware, this level
changes completely, new disks, maybe a new data center. Nobody in the
registration office should notice, or need to care.
</div>

---

# Level 2: Logical

<div class="thread">One level up: what data exists, and how it relates. This is what this whole course actually teaches.</div>

**Logical level:** what data is stored, and how it relates:
`Student(id, name, major)`, `Course(code, title)`, and so on.

<div class="why">
This is the level a programmer, and this course, works at almost all
the time. You design at the logical level; the physical level is
someone else's problem (often the DBMS itself).
</div>

---

# Level 3: View

<div class="thread">The top level: what one specific user is allowed to see. This is the answer to last week's security problem.</div>

**View level:** what THIS user sees, which can be a small slice of the
full logical data.

<div class="why">
A professor's app shows only their own sections. A student's app shows
only their own grades. Same underlying data, different views, exactly
the fix for the security problem two slides ago.
</div>

---

# All Three, Together

<div class="thread">Same three levels, now stacked, as the picture to keep for the rest of the semester.</div>

<div class="stack">
<div class="layer view"><span class="h">View</span> <span class="s">what THIS user sees: a professor sees only their own sections</span></div>
<div class="layer logical"><span class="h">Logical</span> <span class="s">what data exists and how it relates: Student(id, name, major)</span></div>
<div class="layer physical"><span class="h">Physical</span> <span class="s">how bytes actually sit on disk: file layout, indexes</span></div>
</div>

Mixing these layers is exactly what a spreadsheet does. Separating them
is exactly what a DBMS does.

---

# Instances & Schemas

<div class="thread">Within each layer above, one thing is fixed and one thing constantly changes. Which is which?</div>

- **Schema:** the design, column names and types, unchanging day to day
  (like a variable's declared type)
- **Instance:** the actual data at this moment, changing constantly
  (like a variable's current value)

<div class="why">
No coding background needed for this one: your student ID card has a
<strong>schema</strong>, name, photo, student number, department, the
same blank fields on every card the university prints. Your own card,
filled in with your face and your number, is one <strong>instance</strong>.
</div>

**Data independence:** changing physical storage should not force you
to rewrite the application, which only talks to the logical level. This
is why the three levels exist, so the registration office's spreadsheet
chaos never happens again when the university switches disks or servers.

---

# One More Example: A Course, Over Time

<div class="thread">Same idea, one more time, with an actual table instead of an ID card.</div>

**Schema (fixed):** `Course(code, title, room)`, three columns, never
changes semester to semester.

| Semester | code | title | room |
|---|---|---|---|
| This semester | CSE301 | Databases | 성파 702 |
| Last semester | CSE301 | Databases | 성파 615 |

Same three columns both times, that is the schema. The room changed,
that is two different **instances** of the same schema.

---

# Data Models: The Logical Layer Needs a Shape

<div class="thread">The logical level from three slides ago needs an actual shape. These are the shapes a DBMS can take.</div>

A **data model** is the shape data takes at the logical level. This
course covers two of them closely, and names a third for context. One
slide each.

---

# Model 1: Relational

<div class="thread">This course's core, starting next week.</div>

**Relational:** data as tables, related to each other by shared values,
not by retyping.

<div class="why">
Your student list and your class list, as two separate sheets, linked
by student ID instead of retyping every name on both. Week 2 onward,
every table in this course is built this way.
</div>

---

# Model 2: Entity-Relationship (E-R)

<div class="thread">The step before the tables exist at all.</div>

**Entity-Relationship (E-R):** a diagram of real-world things (Student,
Course, Instructor) and how they connect, before any table is built.

<div class="why">
The mind-map sketch you draw on paper first: circle the things
(Student, Course), draw a line for how they connect (enrolls in).
Week 4 turns this into a formal diagram, then Week 6 turns it into
tables.
</div>

---

# Named for Context: Other Models

<div class="thread">Two models this course teaches. One more, so the names sound familiar later.</div>

**Object-based / Semi-structured:** objects, or flexible JSON-like
documents, used when data does not fit neatly into rows and columns.

Not covered in depth this semester, this course is relational
end to end, but the name will come up again if you work with NoSQL
systems later in your career.

---

# The Design Lifecycle: This Course's Real Spine

<div class="thread">Abstraction and data models are pieces. Here is the order you actually put them to work in.</div>

<div class="pipeline">
<div class="stage"><div class="h">Requirements</div><div class="s">what users need</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Conceptual</div><div class="s">E-R diagram<br>Week 3-4</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Logical</div><div class="s">mapping, normalization<br>Week 6-7</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Physical</div><div class="s">indexes, storage</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Implementation</div><div class="s">DDL, DML, queries<br>Week 9-12</div></div>
</div>

Every remaining week of this course is one station on this line. When a
topic feels disconnected, find it on this diagram.

---

# Inside the DBMS Engine

<div class="thread">The lifecycle above is what YOU do. This is what the DBMS does, every second, underneath you.</div>

- **Storage manager:** moves data between disk and memory
- **Query processor:** turns your `SELECT` into an efficient execution plan
- **Transaction manager:** makes sure concurrent users don't corrupt each
  other's work, and a crash mid-write never leaves half-saved data

<div class="why">
These three map directly to today's pain: storage manager prevents
corruption, transaction manager is the direct answer to the 수강신청
risk bars from earlier, query processor is the 3-hour bar shrinking to
under 1 second.
<br><br>
<strong>계좌이체, a bank transfer:</strong> money must leave your account
and arrive in your friend's, both steps, or neither. A transaction
manager is the reason your money never just vanishes between the two.
</div>

---

# Who Uses a Database System

<div class="thread">An engine needs operators. Here is everyone who touches it, and how.</div>

- **End users / application programmers:** query and update through apps
- **Sophisticated users:** write SQL directly for analysis
- **Database administrator (DBA):** owns schema, security, backups, and
  performance; the person who would have prevented this mess

---

# Check Yourself

1. Name two problems the registration office spreadsheet scenario shows, and
   match each to one of Silberschatz's file-processing failure categories.
2. Which of the three abstraction levels changes when the university
   switches disks or servers, and which one stays the same?

---

# Answers

1. Silently overwritten upload: **concurrent-access anomaly**. Misspelled
   major across rows: **data inconsistency / redundancy**.
2. **Physical** changes (a new disk, a new server). **Logical** stays
   the same, which is the entire point of data independence.

---

<!-- SLOT 14: Limits (Act 4 / CLOSE), becomes Week 2 slot 4 -->

# What Today's Big Picture Cannot Do

<div class="limits">
We now know <em>what</em> a DBMS promises: consistency, controlled
concurrency, recovery from crashes. But we still have no idea <em>how</em>
to structure the registration data: what tables, what columns, what
connects to what. Knowing the destination is not the same as knowing
the map.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 1 leaves **how to structure data as tables** unsolved. **Week 2,
The Relational Model**, addresses it: relations, attributes, and the
mathematical foundation every table in this course rests on.

---

<!-- SLOT 16: Summary -->

# Summary

- File-processing systems fail through redundancy, inconsistency,
  difficult access, poor integrity, no atomicity, concurrency anomalies,
  and weak security. A DBMS exists to solve exactly these.
- Three abstraction levels (physical, logical, view) exist so storage
  changes don't break applications.
- This course follows the real order of database work: requirements,
  modeling, mapping, normalization, SQL.
- **Reading:** Silberschatz et al., 7th ed., Chapter 1
- **Prepare:** think of one more real-world example, not registration,
  where a spreadsheet would break down. Bring it to Week 2.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
