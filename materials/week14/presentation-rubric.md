# Week 14 Presentation Rubric

Database Systems (511783-001). This is the full grading rubric for the
Week 14 case study presentation, this course's 발표 (presentation)
component, 10% of the final grade (see the Week 14 slides). The slide
deck shows a summary; this document is the complete version, for
students to check before and after presenting.

---

## 1. What You Are Presenting

Each team carries **a system of its own choosing** through this
semester's entire arc, from a real-world problem to a running SQL
query, and covers:

1. **The pain:** a real, concrete scenario the system fixes, in the
   style of Week 1's registration-office scenario, zero jargon
2. **The design:** the team's E-R diagram, its normalized schema, and
   one anomaly the normalization step actually caught
3. **The build:** the `CREATE TABLE` statements for the core tables
4. **The payoff:** one real question the system can now answer, shown
   as a working SQL query, with its result

This closes the exact loop the Week 14 deck opens with: thirteen
weeks of one argument, why a DBMS at all, design, build, ask, applied
once, end to end, by the team, instead of by the instructor.

---

## 2. Point Breakdown (100 points total)

| Criterion | Points | What earns full marks |
|---|---|---|
| Clarity of the pain | 25 | A beginner with zero database background understands the problem in one sentence, before any schema appears |
| Schema design accuracy | 35 | The E-R diagram, the normalized schema, and the `CREATE TABLE` statements all agree with each other, and at least one real anomaly is identified and fixed |
| Use of correct vocabulary/terms | 15 | This semester's terms (entity, relationship, normal form, primary key, foreign key, join, etc.) are used, and used correctly, not just dropped in |
| Q&A handling | 25 | Every question gets a direct answer; if the team does not know, they say so instead of guessing confidently |

---

## 3. Criterion Detail

### Clarity of the pain (25 points)

| Band | Points | Description |
|---|---|---|
| Excellent | 22-25 | The pain is obvious before any schema appears; a first-time listener can restate the problem in one sentence, unprompted |
| Good | 16-21 | Mostly clear, one follow-up question is needed to pin down the scenario |
| Needs work | 8-15 | The audience follows the slides but cannot say why the system matters |
| Weak | 0-7 | The presentation opens with `CREATE TABLE` or a diagram, with no pain established at all |

### Schema design accuracy (35 points)

| Band | Points | Description |
|---|---|---|
| Excellent | 30-35 | The E-R diagram, the normalized schema, and the actual tables all match; a real anomaly is named and the fix is explained correctly |
| Good | 21-29 | The design is mostly consistent, with a small mismatch between diagram and tables that does not change the conclusion |
| Needs work | 11-20 | The E-R diagram and the final schema disagree, or the claimed anomaly is not a real one |
| Weak | 0-10 | No working schema is shown, or the design contradicts itself |

### Use of correct vocabulary/terms (15 points)

| Band | Points | Description |
|---|---|---|
| Excellent | 13-15 | Terms from this semester are used precisely and where they actually apply |
| Good | 9-12 | Terms are used correctly most of the time, with one or two loose uses |
| Needs work | 4-8 | Terms are used but noticeably imprecise, e.g. "key" and "index" swapped |
| Weak | 0-3 | Little or no use of this semester's vocabulary |

### Q&A handling (25 points)

| Band | Points | Description |
|---|---|---|
| Excellent | 22-25 | Every question gets a direct, on-topic answer; uncertainty is stated honestly rather than guessed past |
| Good | 16-21 | Most questions are answered well, one answer drifts off-topic |
| Needs work | 8-15 | Answers are vague, or the team repeats the presentation instead of answering |
| Weak | 0-7 | Questions go unanswered, or answers are confidently wrong |

---

## 4. Format Reminders

- **10 minutes per team**: 7 minutes presenting, 3 minutes questions
- Slides are optional; a live MySQL demo is strongly encouraged, run
  the payoff query against real data if at all possible
- Every team member must speak; a silent member loses clarity points
- Bring the schema and query as a backup file (script or export), in
  case a live demo connection fails

---

## 5. Common Ways Teams Lose Points

- **Skipping the pain, starting with the schema.** This course's whole
  spine says motivation comes first; a presentation that opens with
  `CREATE TABLE` loses the audience before explaining why it matters
- **A schema with no working query.** A design that was never tested
  against real data has not actually been finished
- **Claiming an anomaly without showing it.** "We normalized it" is a
  fact, not evidence; show the actual repeated or dependent data the
  normalization step removed
- **Guessing instead of admitting uncertainty in Q&A.** A confident
  wrong answer scores lower than an honest "we are not sure, but here
  is our best reasoning"
- **Over-scoping.** A small, complete system beats a large, half-built
  one, every time

---

## 6. After Your Presentation

Keep your own team's Q&A questions. Week 15 is a short review week
covering Weeks 1 through 14; the questions your presentation could not
fully answer are a good place to start reviewing.
