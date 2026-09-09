---
marp: true
theme: shintia
paginate: true
footer: 'Department of Intelligent Computing'
---

<!-- SLOT 1: Title -->
<!-- _class: title -->

# Week 14: Case Study Presentation

<span class="subtitle">Database Systems (511783-001)</span>

<div class="meta">
Yushintia Pramitarini, Ph.D · Dept. of Intelligent Computing · Mon [4-6] · 성파 702
</div>

<!-- notes: Presentation-day format, not a standard spine lecture. Nominal Act 0, then presentation logistics + rubric summary only — no new lecture content. Budget most of the 150 minutes for the presentations themselves. Lab page: book/src/labs/lab14-case-study-presentation.md -->

---

<!-- SLOT 2: Where we are -->

# Where We Are

<div class="roadmap">
<div class="wk"><div class="n">Wk 1</div><div class="t">Introduction</div></div>
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
<div class="wk now"><div class="n">Wk 14</div><div class="t">Case Study Presentation</div></div>
<div class="wk review"><div class="n">Wk 15</div><div class="t">Final Exam</div></div>
</div>

---

<!-- SLOT 3: Recap + open wound -->

# Last Week, This Week

- **Last week (13) delivered:** a checkpoint review of Weeks 9-12,
  the entire build-and-ask SQL arc, and Quiz 2
- **Last week left open:** everything built and reviewed so far has
  only ever been applied to the instructor's own registration case
  study — never to a system your team chose and designed yourselves

Today closes that gap: thirteen weeks of one argument — why a DBMS
at all, design, build, ask — applied once, end to end, by you.

---

<!-- _class: section -->

# Case Study Presentations
<div class="driving-q">Your own system, your own data, this semester's entire arc, applied.</div>

---

# What to Present

<div class="cardlist">
<div class="card"><div class="h">The pain</div><div class="d">a real, concrete scenario your system fixes, in the style of Week 1's registration-office scenario, zero jargon</div></div>
<div class="card"><div class="h">The design</div><div class="d">your E-R diagram, your normalized schema, and one anomaly your normalization step actually caught</div></div>
<div class="card"><div class="h">The build</div><div class="d">your <code>CREATE TABLE</code> statements for the core tables</div></div>
<div class="card"><div class="h">The payoff</div><div class="d">one real question your system can now answer, shown as a working SQL query, with its result</div></div>
</div>

---

# Format

- **10 minutes per team**, 7 minutes presenting, 3 minutes questions
- Slides optional, a live MySQL demo is strongly encouraged
- Every team member must speak; the presentation is graded as this
  course's 발표 (presentation) component, 10% of the final grade
- Deliverable: presentation + a working demo database — no individual
  `.sql` file required from every student, one team backup script is
  enough

---

# Before You Present: Quick Checklist

- [ ] One-sentence pain, rehearsed
- [ ] E-R diagram, normalized schema, and `CREATE TABLE` statements
      all agreeing with each other
- [ ] One real anomaly your normalization step caught, ready to point to
- [ ] A working demo database with a real, non-empty payoff query result
- [ ] A backup script, in case the live demo connection fails

---

# Grading Rubric Summary

| Criterion | Points | What we are looking for |
|---|---:|---|
| Clarity of the pain | 25 | Would a beginner, zero database background, understand the problem in one sentence? |
| Schema design accuracy | 35 | Does the E-R diagram agree with the final schema, with a real anomaly caught and fixed? |
| Vocabulary/terms | 15 | Are this semester's terms used, and used correctly? |
| Q&A handling | 25 | Does every question get a direct, honest answer? |

Full point-band descriptions: **`book/src/appendix/grading-rubric.md`**
(section 3) — this slide is a summary only.

---

# Common Mistakes to Avoid

- **Skipping the pain, starting with the schema:** this course's whole
  spine says motivation comes first; a presentation that opens with
  `CREATE TABLE` loses the audience before explaining why it matters
- **A schema with no working query:** a design that was never tested
  against real data has not actually been finished
- **Over-scoping:** a small, complete system beats a large, half-built
  one, every time

---

<!-- SLOT N+1: Limits -->

# What Today Does Not Close

<div class="limits">
Students present; instructor closes remaining gaps. Ten minutes per
team, including Q&A, is not enough time to resolve every question a
presentation raises — some are answered on the spot, others are
noted and left open.
</div>

---

<!-- SLOT N+2: Bridge -->

# Next Week

Week 14 leaves **whatever each team's Q&A could not fully resolve**
open. **Week 15** addresses it: a comprehensive review of the whole
semester, Weeks 1 through 14, before the Final Exam.

---

# Summary

- Today's presentations are the entire semester's arc, applied once,
  end to end, by you: pain, design, build, and a real, working query.
- **Lab page:** `book/src/labs/lab14-case-study-presentation.md`, for
  the full prep checklist and deliverable details.
- **Prepare:** keep your own team's unanswered Q&A questions — Week
  15's review is comprehensive, Weeks 1 through 14.

---

<!-- _class: end -->

# Thank You
