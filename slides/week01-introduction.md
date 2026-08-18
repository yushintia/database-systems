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
notes: Welcome the class.
Ask: "Has your file ever been lost or overwritten?"
Ask: "Have you shared one file with a group and had a conflict?"
Let a few students answer with a show of hands. That is today's hook.
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

<!-- notes: Point at the row. Say: "Fifteen weeks. One story. We build a database, step by step." -->

---

<!-- NEW: warm-up, placed right after the roadmap (slot 2) per course design -->

# Before We Start: Read a Spreadsheet

<div class="thread">A quick warm-up. No coding needed yet.</div>

| Student | Class | Grade | Room |
|---|---|---|---|
| Lee Jun | CSE201 | B+ | 402 |
| Park Somi | CSE201 | A0 | 402 |
| Lee Jun | CSE201 | B+ | 402 |
| Kim Tae | CSE305 | A- | 210 |

- Each **row** is one record: one line about one student.
- Each **column** is one kind of fact: name, class, grade, room.
- Look closely. Do two rows look exactly the same?

<!--
notes: Give students 1 minute to look, alone, before asking anything.
Ask aloud: "How many rows are there?" (4)
Ask aloud: "How many different students?" (3, Lee Jun repeats)
Ask aloud: "What is strange about row 1 and row 3?" (identical, a duplicate)
-->

---

<!-- SLOT 3: What you already have -->

# What You Already Bring

- **Programming:** you already write logic that changes data.
- **Data Structures:** you know arrays, lists, and trees. A database is
  a structure too, just built for millions of rows and many users.
- **Discrete Math:** you know sets. Week 2's relational model is built
  directly on sets.

We do not start from zero. We point what you know at a new problem.

---

<!-- Course logistics appendix: administrative, outside the spine, placed here so it doesn't blunt slot 4 -->

<!-- _class: section -->

# Course Logistics
<div class="driving-q">Read once now. Use it all semester.</div>

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

<!-- notes: Say Assignment 1 is due Week 4. Assignment 2 is due Week 12. Quiz 1 is Week 5. Quiz 2 is Week 13. -->

---

# Textbook, Policy & Contact

- **Textbook:** Silberschatz, Korth, Sudarshan, *Database System
  Concepts*, 7th ed., McGraw-Hill, 2019
- **Other references:** Connolly & Begg; Elmasri & Navathe (full
  details in the syllabus)
- **Policy:** come to every class; late work loses points; copying
  others' work is not allowed
- **Contact:** yushintia@deu.ac.kr — email to book office hours

---

<!-- NEW: Key Words Today, session 1 -->

# Key Words Today

- **Row:** one record. One line of data about one thing (one student).
- **Column:** one kind of fact, repeated for every row.
- **Duplicate:** the exact same row, typed more than once.
- **Inconsistent:** two rows about the same thing that do not agree.
- **Lost update:** one person's change disappears when someone else saves.

<!-- notes: Read each term aloud once. Point back at the warm-up table for "row," "column," and "duplicate." -->

---

<!-- SLOT 4: The pain (Act 1 / MOTIVATE), zero jargon -->

# Inside the Registration Office

<div class="pain">

The registration office keeps everything in one file: `registrations.xlsx`.
It has 40,000 rows, and it grows every semester. Each staff member
keeps their own copy. They edit it, then upload it back later.

Today, a professor asks: "Who is in my class?" Two staff both
uploaded this week. The second save silently erased the first save's
changes. One student's major is spelled three different ways, in
three different rows. Nobody can say, right now, who is really
enrolled in CSE301. Someone must scroll through all 40,000 rows by
eye, hoping not to miss one.

</div>

<!-- notes: Do not say the word "database" yet. Let the class feel the mess first. -->

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
<div class="bar-note">Illustrative, not measured data: the point is the gap, not the exact minutes.</div>

This gap is not a small annoyance. It is the reason this course exists.

<!-- notes: Pause after showing the second bar. Let the silence make the point. -->

---

<!-- SLOT 5: Cost of not knowing -->

# What Else This Actually Costs

- A grade attaches to the wrong student. Nobody notices until graduation.
- Two staff save at the same time. One person's work just disappears.
- A crash during a save can corrupt the file, with no way to know
  what was lost.

<div class="why">
<strong>In industry:</strong> most backend and data jobs expect SQL
and database design skills. "Design a schema for X" is a common
interview question. Mistakes like these have caused real outages at
major tech companies.
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
<div class="bar-note">Illustrative, not measured data: the point is the trend.</div>

You have all lived the third bar. A system with no plan for this
**will** lose someone's seat, silently.

---

<!-- SLOT 6: Driving question -->

<!-- _class: section -->

# This Week's Question

<div class="driving-q">"What must a system do, before we can trust it with data that matters?"</div>

---

<!-- SLOT 7: Learning outcomes -->

# By the End of This Week, You Can

1. Explain why plain files fail as data grows.
2. Describe three levels of data abstraction, and why each exists.
3. Name the main data models, and where each fits in this course.
4. State this course's three goals, and where each is taught.

---

# This Course's Three Goals

<div class="thread">Not just this week's goals. This is the whole course, in three lines.</div>

| # | Goal (from the syllabus) | Where |
|---|---|---|
| 1 | Learn data models, the relational model, and SQL | Weeks 2, 9-12 |
| 2 | Design databases with E-R diagrams and normalization | Weeks 3-7 |
| 3 | Understand storage, queries, transactions, and recovery | Previewed today |

Goal 3 is why today also shows the DBMS engine. It is the only week
that names it directly.

---

<!-- NEW: session-1 close, previews Worksheet Part A -->

# Coming Up: Worksheet Part A

<div class="thread">Next in this class: less listening, more doing.</div>

Later today, you and a partner will look at a real, messy class list.
You will find the same problems you just read about.

That is **Worksheet Part A**. Keep a pen ready.

---

<!-- _class: section -->

# End of 차시 1
<div class="driving-q">Short break. Next: where did this problem come from?</div>

---

<!-- SLOT 8: Origin -->

# This Problem Is Not New

<div class="thread">You just felt the pain. Now: who else felt it, and what did they do?</div>

- In the 1960s, data lived in files. Every program wrote its own file
  format, and its own code to read and write it.
- Every new program either copied data again, or wrote fragile code to
  reach into another program's files. Sound familiar?

<div class="why">
Imagine if KakaoTalk, your bank app, and 배달의민족 each kept a private
copy of your phone number. Change it in one, the others never know.
That was every app, all the time, before this course's subject existed.
</div>

Companies spent **decades** and real money solving this exact
problem, at a scale of millions of records, not 40,000 rows.

---

# Fifty Years of Solving Your Spreadsheet Problem

<div class="timeline">
<div class="pt"><div class="dot"></div><div class="y">1960s</div><div class="d">File-processing systems<br>every app, its own format</div></div>
<div class="pt"><div class="dot"></div><div class="y">1970</div><div class="d">Edgar F. Codd (IBM)<br>the relational model</div></div>
<div class="pt"><div class="dot"></div><div class="y">1974</div><div class="d">IBM System R<br>SQL is born</div></div>
<div class="pt"><div class="dot"></div><div class="y">Today</div><div class="d">PostgreSQL, MySQL, Oracle<br>the same ideas, still running</div></div>
</div>

The relational model won because it split **what** you ask for from
**how** the machine finds it. That idea is this whole course.

---

<!-- SLOT 9: Core concept -->

# Database & DBMS: Definition

<div class="thread">Fifty years of work point at two words. Here they are, precisely.</div>

> A **database** is an organized collection of related data.
> A **database management system (DBMS)** is software that lets
> people create, use, and control access to a database.

- **Data:** raw facts, such as `"Kim Minji", "CSE301", "A0"`
- **Database:** the organized collection (tables, not a spreadsheet)
- **DBMS:** the software that keeps the collection correct, even with
  many users (examples: PostgreSQL, MySQL, Oracle)

Every time your banking app shows your balance, a DBMS answered that
request correctly, in milliseconds. That is what you build this term.

---

<!-- NEW: Key Words Today, session 2 -->

# Key Words Today

- **Redundancy:** the same fact stored in more than one place.
- **Integrity rule:** a rule data must follow (a grade must be real).
- **Atomicity:** a save either fully happens, or it does not happen.
- **Concurrency:** many people using the same data at the same time.
- **DBMS:** software that keeps shared data correct and safe.

<!-- notes: Read each term aloud. Say these five words label the five problems coming next. -->

---

<!-- Act 3 / BUILD: Why File Systems Fail, trimmed to the essentials -->

# Why File Systems Fail

<div class="thread">You already lived these. Today they get names.</div>

Textbooks group file-processing problems into named categories. We
cover the five biggest ones now. Two more are in your
[handout](materials/week01/handout.html).

---

# Copies That Disagree, Facts You Can't Find

<div class="thread">Problem 1 and 2: typing a fact twice, and no way to ask a question.</div>

**Redundancy & inconsistency:** the same fact stored more than once,
and the copies disagree.

**Hard to access:** a file has no built-in way to ask a question.
Every new question means new code, or scrolling by eye.

<div class="pain">
Kim Minji's name is typed three ways: "Kim Minji," "MinJi Kim,"
"김민지." "Who is in CSE301?" takes about three hours to answer by eye.
</div>

---

# No Rules, No Safety Net

<div class="thread">Problem 3 and 4: a file that accepts anything, and a save with no guarantee.</div>

**Integrity problems:** a spreadsheet cell has no idea what a valid
value is.

**Atomicity problems:** a save should fully finish, or not happen at
all. A file has no such promise.

<div class="pain">
Nothing stops someone typing "A99" into the Grade column. A crash
mid-save can leave the file half-written, with no record of what was
lost.
</div>

---

# Two People, One File

<div class="thread">Problem 5: the one you already guessed at the warm-up.</div>

When two people edit the same data at the same time, one person's
work can silently disappear. This is called a **lost update**.

<div class="pain">
Two staff both uploaded `registrations.xlsx` this week. Whoever
saved last replaced the other's edits. No warning. No merge.
</div>

---

# Five Failures, One Cause

<div class="thread">Same five names, side by side. Two more failures: see the
<a href="materials/week01/handout.html">handout</a>.</div>

| # | Failure | Registration office example |
|---|---|---|
| 1 | Redundancy & inconsistency | Kim Minji, spelled three ways |
| 2 | Hard to access | The 3-hour scroll |
| 3 | Integrity problems | A grade of "A99" |
| 4 | Atomicity problems | The crash mid-save |
| 5 | Concurrency (lost update) | The dueling uploads |

A DBMS exists to fix exactly these, all at once, for good.

---

# Worked Example: Inside `registrations.xlsx`

<div class="thread">Five failures, one file. Here is that exact file.</div>

This semester's running example is **university course registration**.
A real excerpt, unedited:

| Student | Major | Course | Instructor | Grade |
|---|---|---|---|---|
| Kim Minji | Computer Sci. | CSE301 | Prof. Lee | |
| <span style="color:#C0392B;font-weight:700">MinJi Kim</span> | <span style="color:#C0392B;font-weight:700">CS</span> | CSE301 | Prof. Lee | A0 |
| <span style="color:#C0392B;font-weight:700">김민지</span> | <span style="color:#C0392B;font-weight:700">Comp. Science</span> | CSE301 | <span style="color:#C0392B;font-weight:700">(blank)</span> | |
| Park Jiho | Software Eng. | CSE305 | Prof. Han | A- |

One student, three rows, three spellings. One blank instructor. This
is what you were scrolling through.

---

# Where This Is Heading

<div class="thread">The mess above becomes five small, linked tables by Week 7.</div>

<div class="pipeline">
<div class="stage"><div class="h">Student</div><div class="s">who</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Enrollment</div><div class="s">signs up for</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Section</div><div class="s">class, room, time</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Course</div><div class="s">the subject itself</div></div>
</div>

No name is ever retyped. Every table links to the next by a shared
ID, not a shared spelling. Week 4 shows the full diagram.

---

<!-- NEW: Try-It hand-off, session 2 -->

# Now: Worksheet Part A

<div class="thread">Time to practice. Find these problems yourself.</div>

Work with your neighbor. Open
**[Worksheet Part A](materials/week01/worksheet.html)**. Find the
duplicates, the inconsistency, and the lost update in the sample
class list.

**~15 minutes.** Raise your hand if you get stuck.

<!--
notes: Hand out or project Worksheet Part A. Walk the room while pairs work.
After 15 minutes, ask 2 pairs to share one problem they found.
-->

---

<!-- _class: section -->

# End of 차시 2
<div class="driving-q">Short break. Next: how a DBMS actually fixes all this.</div>

---

<!-- NEW: Key Words Today, session 3 -->

# Key Words Today

- **Schema:** the design. Fixed column names and types.
- **Instance:** the actual data right now. Always changing.
- **Abstraction level:** one of three separate views of the same data.
- **Data model:** the shape data takes (tables, diagrams, documents).
- **Data independence:** storage can change without breaking your app.

<!-- notes: Read each term aloud. Say: "You will hear these five words for the rest of the semester." -->

---

<!-- Act 3 / BUILD, continued -->

# Databases Are Already in Your Pocket

<div class="thread">You just met one example. Here are three more you already use.</div>

<div class="appgrid">
<div class="app"><div class="name">KakaoTalk</div><div class="desc">your chat history, searchable instantly</div></div>
<div class="app"><div class="name">Banking app</div><div class="desc">your balance, correct, every time</div></div>
<div class="app"><div class="name">Netflix</div><div class="desc">exactly where you paused, on any device</div></div>
</div>

None of these apps "is" a database. Each one **runs on** one,
answering questions like this thousands of times a second.

---

# Three Levels: What a DBMS Separates

<div class="thread">A spreadsheet mixes these three questions. A DBMS keeps them apart.</div>

<div class="stack">
<div class="layer view"><span class="h">View</span> <span class="s">what THIS user sees: a professor sees only their own classes</span></div>
<div class="layer logical"><span class="h">Logical</span> <span class="s">what data exists, and how it relates: Student(id, name, major)</span></div>
<div class="layer physical"><span class="h">Physical</span> <span class="s">how bytes sit on disk: files, indexes</span></div>
</div>

<!--
notes: Explain bottom-up, out loud, do not just read the slide.
Physical: disks and files. Nobody in the office ever sees this.
Logical: what data exists. This is what this whole course teaches.
View: what one user is allowed to see. This fixes the security problem in the handout.
-->

---

# Schema & Instance

<div class="thread">In every level above, one thing is fixed. One thing keeps changing.</div>

- **Schema:** the design. Column names and types. Rarely changes.
- **Instance:** the actual data right now. Changes all the time.

| Semester | code | title | room |
|---|---|---|---|
| This semester | CSE301 | Databases | 성파 702 |
| Last semester | CSE301 | Databases | 성파 615 |

Same three columns both times: that is the **schema**. The room
changed: that is two different **instances** of it.

**Data independence:** changing physical storage should never force
you to rewrite the application. The app only talks to the logical
level.

---

# Data Models: Two We Use, One We Name

<div class="thread">The logical level needs a shape. These are the shapes it can take.</div>

- **Relational (this course):** data as tables, linked by shared IDs,
  not by retyping. Week 2 onward, every table works this way.
- **Entity-Relationship (E-R):** a diagram of real things (Student,
  Course) and how they connect, before any table exists. Week 4.
- **Object / semi-structured:** flexible data that does not fit rows
  and columns, like JSON. Named here for later, not covered deeply.

---

# The Design Lifecycle: This Course's Real Spine

<div class="thread">Here is the order we actually build in.</div>

<div class="pipeline">
<div class="stage"><div class="h">Requirements</div><div class="s">what users need</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Conceptual</div><div class="s">E-R diagram<br>Week 3-4</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Logical</div><div class="s">tables, normal form<br>Week 6-7</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Physical</div><div class="s">storage, indexes</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Build</div><div class="s">SQL<br>Week 9-12</div></div>
</div>

Every later week of this course is one stop on this line.

---

# Inside the Engine, a Quick Look

<div class="thread">This is what a DBMS does underneath you, every second.</div>

- **Storage manager:** moves data between disk and memory.
- **Query processor:** turns your question into a fast search plan.
- **Transaction manager:** keeps users from corrupting each other's work.

<div class="why">
<strong>계좌이체, a bank transfer:</strong> money must leave one
account and arrive in another, both steps, or neither. The
transaction manager is why your money never just vanishes.
</div>

Who uses all this? App users, analysts who write SQL directly, and a
**DBA** (database administrator) who owns security and backups.

---

<!-- NEW: Try-It hand-off, session 3 -->

# Now: Worksheet Part B

<div class="thread">One more round. Harder problems, same messy world.</div>

Work with your neighbor. Open
**[Worksheet Part B](materials/week01/worksheet.html)**. Find the lost
update, label the schema, and spot one more integrity problem.

**~15 minutes.** We check answers together right after.

<!--
notes: Hand out or project Worksheet Part B. Walk the room while pairs work.
Bring the class back together after about 15 minutes.
-->

---

# Worksheet Part B — Let's Check Together

1. Which failure caused the lost room-edit? **Concurrency (lost update).**
2. What made the grade cell wrong? **Integrity problem.**
3. Which part of the sheet is the schema? **The column names: student, course, grade.**

<!-- notes: Ask 2-3 pairs for their answers before you reveal these. Accept any answer that names the right idea, even in different words. -->

---

<!-- NEW: quiz hand-off -->

# Now: Quick Self-Check Quiz

<div class="thread">Ungraded. Just for you, to see what stuck.</div>

Open the **[Week 1 Quiz](materials/week01/quiz.html)**. Answer on your own, about 10 minutes.
Check your own answers at the end. Ask if anything surprises you.

<!--
notes: Distribute or project the quiz. After about 10 minutes, reveal the
answer key and discuss as a group any question most of the class missed.
-->

---

<!-- SLOT 14: Limits (Act 4 / CLOSE), becomes Week 2 slot 4 -->

# What Today's Big Picture Cannot Do

<div class="limits">
We now know <em>what</em> a DBMS promises: correct data, safe
sharing, recovery from crashes. We still do not know <em>how</em> to
structure the registration data: what tables, what columns, what
connects to what. Knowing the goal is not the same as knowing the
plan.
</div>

---

<!-- SLOT 15: Bridge -->

# Next Week

Week 1 leaves **how to structure data as tables** unsolved. **Week 2,
The Relational Model**, answers it: relations, attributes, and the
math every table in this course rests on.

---

<!-- SLOT 16: Summary -->

# Summary

- Plain files fail in five main ways: redundancy, hard access, weak
  rules, no atomicity, and unsafe sharing. A DBMS fixes all five.
- Three levels (physical, logical, view) exist so storage changes
  never break your app.
- This course follows the real order of database work: requirements,
  design, tables, then SQL.
- **Reading:** Silberschatz et al., 7th ed., Chapter 1
- **Prepare:** think of one more everyday example where a spreadsheet
  would break down. Bring it to Week 2.

---

<!-- SLOT 17: Thank You -->
<!-- _class: end -->

# Thank You
