# Lab 14: Case Study Presentation

| | |
|---|---|
| **Week** | 14 |
| **Duration** | 150 min (single continuous block) |
| **Method** | Presentations |
| **Prerequisites** | Labs 01-13 (entire course) |
| **Weight** | **10%** of final grade (this course's 발표 component — see [Grading Rubrics](../appendix/grading-rubric.md)) |

**Time allocation**

| Part | Min | Activity |
|---|---:|---|
| Setup | 10 | Roll call, confirm team order, tech/demo check |
| Presentations | 120 | Each team: 10 min (7 presenting, 3 Q&A) |
| Wrap-up | 20 | Instructor closes remaining Q&A gaps, Week 15 logistics |

This is a doing-day, not a concept day: there is no new lecture
material this week. Everything below is presentation logistics and a
short summary of what is expected — the full grading detail lives in
the [Grading Rubrics](../appendix/grading-rubric.md) appendix.

---

## What You Are Presenting

Each team carries **a system of its own choosing** — not necessarily
the University Course Registration case study used throughout this
book — through this semester's entire arc, from a real-world problem
to a running SQL query. This is the same four-part shape every week's
worked example has followed since Week 1, applied once by the team
instead of by the instructor:

1. **The pain:** a real, concrete scenario your system fixes, in the
   style of Week 1's registration-office scenario — zero jargon
2. **The design:** your E-R diagram, your normalized schema, and one
   anomaly your normalization step actually caught
3. **The build:** the `CREATE TABLE` statements for your core tables
4. **The payoff:** one real question your system can now answer,
   shown as a working SQL query, with its result

None of this starts cold today. Your E-R diagram is Assignment 1
(Week 4); the mapped relations are Lab 06 Part C; the normalized
schema and the anomaly it caught are Lab 07 Part 3; the `CREATE
TABLE` statements are Lab 09 Part D. Today is assembling and
presenting work you have already produced, not producing it for the
first time.

> **In plain words: your own system**
> "Your own choosing" means picking any small, real domain your team
> understands well enough to model honestly — a gym membership
> tracker, a small library, a food-delivery order system, a club's
> event sign-ups. It does not have to be original or complex. A
> small, complete system beats a large, half-built one.

---

## Format

- **10 minutes per team**: 7 minutes presenting, 3 minutes questions
- Slides are optional; a **live MySQL demo is strongly encouraged** —
  run the payoff query against real data if at all possible
- Every team member must speak; a silent member loses clarity points
- Bring the schema and query as a backup file (script or export), in
  case a live demo connection fails

---

## Prep Checklist

Before your slot, confirm your team has:

- [ ] A one-sentence version of the pain, rehearsed, that a listener
      with zero database background can follow
- [ ] An E-R diagram, a normalized schema, and the actual
      `CREATE TABLE` statements — all three agreeing with each other
- [ ] At least one real anomaly your normalization step caught, ready
      to point to (not just "we normalized it")
- [ ] A working demo database, loaded with enough sample data that
      the payoff query returns a real, non-empty result
- [ ] A backup script or export of the schema and data, in case the
      live demo connection fails
- [ ] Every team member assigned at least one part to present

---

## Deliverable

- **Presentation slides** (optional, but most teams find them
  helpful for the pain and design sections)
- **A working demo database**: real tables, real sample data, and the
  payoff query ready to run live

No individual `.sql` file is required from every student — this is a
team deliverable. One backup script per team, covering the schema and
the payoff query, is enough.

---

## Grading, in Brief

| Criterion | Points | What earns full marks |
|---|---:|---|
| Clarity of the pain | 25 | A beginner with zero database background understands the problem in one sentence, before any schema appears |
| Schema design accuracy | 35 | The E-R diagram, the normalized schema, and the `CREATE TABLE` statements all agree, and a real anomaly is identified and fixed |
| Use of correct vocabulary/terms | 15 | This semester's terms are used, and used correctly |
| Q&A handling | 25 | Every question gets a direct answer; uncertainty is stated honestly rather than guessed past |

This is a summary only. For the full point-band descriptions (what
separates "Excellent" from "Needs work" at each criterion) and the
common ways teams lose points, see the
[Grading Rubrics](../appendix/grading-rubric.md) appendix, section 3.

---

## Common Mistakes to Avoid

- **Skipping the pain, starting with the schema.** This course's
  whole spine says motivation comes first; a presentation that opens
  with `CREATE TABLE` loses the audience before explaining why it
  matters
- **A schema with no working query.** A design that was never tested
  against real data has not actually been finished
- **Claiming an anomaly without showing it.** "We normalized it" is a
  fact, not evidence — show the actual repeated or dependent data the
  normalization step removed
- **Over-scoping.** A small, complete system beats a large,
  half-built one, every time

---

## After Your Presentation

Keep your own team's Q&A questions. [Lab 15](lab15-final-review.md) is
a comprehensive review of Weeks 1 through 14 — the questions your
presentation could not fully answer are a good place to start
reviewing.
