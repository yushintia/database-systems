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

<!-- notes: This week is not a standard spine lecture. Short closing-the-loop content, then presentations. Budget most of the 150 minutes for the presentations themselves. -->

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

<!-- Recap of whole semester arc -->

# Thirteen Weeks, One Argument

<div class="thread">Every week's Limits slide became the next week's Pain slide. Here is the whole chain, at once.</div>

<div class="pipeline">
<div class="stage"><div class="h">Why</div><div class="s">a DBMS at all</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Design</div><div class="s">model, diagram, map, normalize</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Build</div><div class="s">DDL, DML</div></div>
<div class="arrow">&rsaquo;</div>
<div class="stage"><div class="h">Ask</div><div class="s">single and multi-table queries</div></div>
</div>

Today, you present a system of your own, carried through that exact
same arc, from a real-world problem to running SQL.

---

<!-- Closing the loop on Week 1's third objective -->

<!-- _class: section -->

# Before Presentations: Closing a Promise From Week 1
<div class="driving-q">Objective 3: transaction management, concurrency control, recovery.</div>

---

# The Gap Week 12 Left Open

<div class="thread">Week 12's own Limits slide named this exactly. Time to close it, briefly, before you present.</div>

<div class="limits">
Every query since Week 9 has assumed a quiet system: one user, no
crashes, small data. Week 1 previewed three DBMS-engine components,
storage manager, query processor, transaction manager, but only ever
demonstrated the first two. The transaction manager, and the 수강신청
concurrency risk from Week 1's own bar chart, were promised, not shown.
</div>

---

# Transaction: Definition

<div class="thread">One word, for an idea you have already seen twice: Week 1's bank transfer, and Week 10's UPDATE warnings.</div>

> A **transaction** is a sequence of database operations treated as a
> single unit: it either completes entirely, or has no effect at all.

```sql
START TRANSACTION;
UPDATE Account SET balance = balance - 50000 WHERE account_id = 1;
UPDATE Account SET balance = balance + 50000 WHERE account_id = 2;
COMMIT;
```

This is Week 1's 계좌이체 example, in actual SQL, for the first time.

---

# ACID, in One Slide Each: Atomicity & Consistency

<div class="thread">Four properties every transaction manager guarantees. Two now, two next slide.</div>

- **Atomicity:** both `UPDATE` statements above happen, or neither does.
  A crash between them leaves the database as if neither ran, exactly
  Week 1's atomicity-problem anomaly, permanently fixed
- **Consistency:** a transaction takes the database from one valid
  state to another, never violating Week 2's integrity constraints
  mid-transaction

---

# ACID, Continued: Isolation & Durability

<div class="thread">The two properties that answer Week 1's concurrency bar chart directly.</div>

- **Isolation:** concurrent transactions do not see each other's
  incomplete work; two people booking the last 수강신청 seat cannot
  both succeed, one transaction's changes stay invisible to the other
  until it commits
- **Durability:** once a transaction commits, it survives even a crash
  immediately afterward, stored permanently before the system reports
  success

---

# Concurrency Control, in Brief

<div class="thread">How isolation is actually enforced, not just promised.</div>

A **lock** prevents two transactions from modifying the same row at
once; a second transaction requesting the last 수강신청 seat waits
until the first transaction commits or rolls back, then sees the
correct, final state, never a half-finished one.

<div class="why">
This is the literal mechanism behind Week 1's concurrency risk bars:
the "guaranteed conflict" bar exists specifically because, without
locks, two transactions can both read "1 seat left" before either
writes, and both believe they succeeded.
</div>

---

# Recovery, in Brief

<div class="thread">Durability's partner: what happens after a crash, not just during normal operation.</div>

A DBMS keeps a **log** of every change before applying it. After a
crash, recovery replays committed transactions from the log and undoes
anything left incomplete, restoring exactly the last consistent state,
Week 1's "no half-saved data" promise, made concrete.

---

# Why This Stayed Brief

<div class="why">
Transaction management, concurrency control, and recovery are each
full courses on their own at the graduate level. This course's promise,
stated honestly back in Week 1, was to explain <em>why</em> they exist
and preview <em>what</em> they guarantee, not to implement them by
hand. That promise is now kept.
</div>

---

<!-- Presentation logistics -->

<!-- _class: section -->

# Case Study Presentations
<div class="driving-q">Your own system, your own data, this semester's entire arc, applied.</div>

---

# What to Present

1. **The pain:** a real, concrete scenario your system fixes, in the
   style of Week 1's registration-office scenario, zero jargon
2. **The design:** your E-R diagram, your normalized schema, and one
   anomaly your normalization step actually caught
3. **The build:** your `CREATE TABLE` statements for the core tables
4. **The payoff:** one real question your system can now answer, shown
   as a working SQL query, with its result

---

# Format

- **10 minutes per team**, 7 minutes presenting, 3 minutes questions
- Slides optional, a live MySQL demo is strongly encouraged
- Every team member must speak; the presentation is graded as this
  course's 발표 (presentation) component, 10% of the final grade

---

# Grading Rubric

| Criterion | What we are looking for |
|---|---|
| Clarity of the pain | Would a beginner, with zero database background, understand the problem in one sentence? |
| Design correctness | Is the E-R diagram consistent with the final schema? |
| Normalization | Is at least one real anomaly identified and fixed? |
| Working SQL | Does the query actually run, against real data, and answer the stated question? |

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

# Summary

- Transactions, ACID, concurrency control, and recovery close the
  third objective this course stated back in Week 1, briefly, as
  promised, not as a substitute for a full course on the subject.
- Today's presentations are the entire semester's arc, applied once,
  end to end, by you: pain, design, build, and a real, working query.
- **Prepare:** Week 15's Final Exam covers the whole semester, Weeks 1
  through 14. Review every week's Summary slide as a starting outline.

---

<!-- _class: end -->

# Thank You
