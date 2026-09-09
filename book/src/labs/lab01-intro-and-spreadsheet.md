# Lab 01: Introduction & the Spreadsheet Problem

| | |
|---|---|
| **Week** | 1 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Orientation & Lab |
| **Prerequisites** | Computer Programming I & II, Data Structures, Discrete Mathematics |

**Why this lab matters:** Before you learn a single database rule, you
need to feel the problem those rules exist to fix. Every registrar's
office, every small business, every club with a shared roster starts
the exact same way: one spreadsheet, edited by hand, by more than one
person. It works, right up until it doesn't. This lab does not teach
you the fix yet — that starts next week. It only asks you to look
closely at the mess, with your own eyes, on real (if fictional) data,
so that Week 2's fix lands on a problem you have already touched.

This week is lighter than every other week in this manual, on purpose.
Most of today's session is the course contract itself — schedule,
grading, policies — covered in
[the Introduction](../introduction.md) and the course handbook. This
lab page covers only the one hands-on activity attached to Week 1.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Course contract) | 100 | Course description, schedule, grading, policies — see the handbook and `../introduction.md` |
| B (Hands-on) | 50 | The spreadsheet problem: hunt for name inconsistency, a deletion anomaly, and a concurrent-edit race, by hand |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Explain, in plain language, why a single shared spreadsheet fails
   once more than one person depends on it.
2. Find concrete examples of name inconsistency, a deletion anomaly,
   and a "no query capability" problem inside a real (if small) messy
   dataset.
3. Describe, from direct experience, what happens when two people edit
   the same file at the same time.
4. State why "just be more careful" does not fix any of the above, no
   matter how careful any one person is.

---

## Recap

There is no "last week" — this is Week 1. By the end of this course,
in Week 15, you will have taken this same registration data all the
way from a broken spreadsheet to a real MySQL database that you built
yourself. Today you only meet the mess. `../setup/mysql-workbench.md`
and `../setup/how-a-database-runs.md` are worth skimming this week too,
so your laptop is ready before Week 2 needs it.

---

## The Spreadsheet Problem

The university's registration office keeps everything in one shared
file: a spreadsheet, edited by hand, by several different staff
members, every semester. One flat sheet, one row per enrollment,
columns like this:

```
student_name | student_major | course_code | course_title | instructor | room | grade
```

> **In plain words: flat file**
> A "flat file" just means one plain table with no connections to
> anything else — no second sheet, no linked data, nothing enforcing
> that two rows which *should* agree with each other actually do. A
> spreadsheet, by default, is a flat file. So is a `.csv`.

One flat row tangles together facts about at least three different
real things at once — a student, a course, and an enrollment — with
nothing keeping any of them consistent:

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 220" style="max-width:520px;display:block;margin:1.5em auto;">
  <title>Diagram showing one flat spreadsheet row tangling together three different real-world facts: a student fact, a course fact, and an enrollment fact, with arrows pointing from the single row to three separate boxes.</title>
  <rect x="150" y="15" width="260" height="50" rx="6" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="280" y="35" font-family="monospace" font-size="10" fill="#0b3d66" text-anchor="middle">Kim Minji, CompSci, CSE301,</text>
  <text x="280" y="50" font-family="monospace" font-size="10" fill="#0b3d66" text-anchor="middle">Database Systems, Prof. Lee, A0</text>
  <line x1="220" y1="65" x2="90" y2="130" stroke="#c07000" stroke-width="2"/>
  <line x1="280" y1="65" x2="280" y2="130" stroke="#2e7d32" stroke-width="2"/>
  <line x1="340" y1="65" x2="470" y2="130" stroke="#8e2020" stroke-width="2"/>
  <rect x="20" y="135" width="140" height="55" rx="6" fill="#fff8e6" stroke="#c07000" stroke-width="2"/>
  <text x="90" y="158" font-family="sans-serif" font-size="11" font-weight="bold" fill="#c07000" text-anchor="middle">Student fact</text>
  <text x="90" y="174" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">name, major</text>
  <rect x="210" y="135" width="140" height="55" rx="6" fill="#e8f5e9" stroke="#2e7d32" stroke-width="2"/>
  <text x="280" y="158" font-family="sans-serif" font-size="11" font-weight="bold" fill="#2e7d32" text-anchor="middle">Course fact</text>
  <text x="280" y="174" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">code, title</text>
  <rect x="400" y="135" width="140" height="55" rx="6" fill="#fbe9e7" stroke="#8e2020" stroke-width="2"/>
  <text x="470" y="158" font-family="sans-serif" font-size="11" font-weight="bold" fill="#8e2020" text-anchor="middle">Enrollment fact</text>
  <text x="470" y="174" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">instructor, room, grade</text>
</svg>
<p style="text-align:center;font-size:0.9em;color:#555;margin-top:-0.6em;"><em><strong>Figure 1.1.</strong> One row, three tangled facts, nothing keeping them consistent.</em></p>

That tangle causes four concrete problems, all present in this course's
running case study, and all still unsolved at the end of today:

| Problem | What actually happens |
|---|---|
| **Name inconsistency** | The same real student's name gets typed a different way in different rows — a typo, a reversed order, a different script entirely |
| **Deletion anomaly** | Deleting the one row that happens to be a course's only enrollment deletes every record of who teaches that course and where — not just the enrollment |
| **Concurrent-edit overwrite** | Two staff members edit the file at nearly the same moment; one save silently overwrites the other's change, with no warning to either person |
| **No query capability** | Answering "who is enrolled in CSE301?" means opening the file and reading every row by eye — there is no other way to ask |

> **In plain words: anomaly**
> An "anomaly" here just means a side effect nobody wanted, caused by
> the way data is stored, not by anyone's mistake. Deleting one
> enrollment *should* only remove that one fact. When it accidentally
> erases a completely different fact too — like who teaches a course —
> that unwanted side effect is an anomaly.

Fixing all four is the rest of this semester's job — relations
(Week 2), a real design process (Week 3), and a formal diagram
(Week 4) are the first three steps. Today, you only need to find these
problems, not fix them.

---

## Hands-On Activity: Hunt the Problems

Open `files/lab01/registrations.csv` in a spreadsheet program (Excel,
Google Sheets, LibreOffice Calc — any of them will do) or a plain text
editor. It is the same flat, one-sheet design described above: 18
enrollment rows for this course's running case study, the University
Course Registration system.

> [`registrations.csv`](files/lab01/registrations.csv)

Work through the three tasks below. Write your findings directly into
`lab01_findings.md` as you go — do not wait until the end to write
everything up from memory.

### Task 1: Find the Name Inconsistency

One real student appears in this file under **three different
spellings** of the same name. Read every row's `student_name` column
by eye (no shortcuts — this is the point) and find:

1. All three spellings used for this one student.
2. The row number (counting the header as row 1) of every row where
   each spelling appears.
3. One sentence: if this were a real system and you searched for only
   one of the three spellings, what would you miss?

### Task 2: Simulate the Deletion Anomaly

Find the **one course** in this file that has only a single enrollment
row. Now imagine that one student drops the course, and the
registrar's office simply deletes that row, the same way they would
delete any other row.

1. Which row is it (row number, student, course)?
2. After deleting it, what information about that course has
   completely disappeared from the file — not just the enrollment, but
   *everything* about the course itself?
3. One sentence: why did deleting one enrollment fact also delete
   facts that had nothing to do with that specific student?

### Task 3: Role-Play the Concurrent-Edit Race

Do this part with a partner.

1. Both of you open your own copy of the same starting file (or the
   same shared Google Sheet, if your instructor set one up).
2. At the same time — actually count down "3, 2, 1, go" — Partner A
   changes `Park Jiho`'s `student_major` to a different major, and
   Partner B changes `Park Jiho`'s `grade` to a different grade, in
   their own copy.
3. Whoever saves (or shares their copy) second overwrites whoever
   saved first. Do it, and look at the result.
4. Write down: whose change survived, whose change silently vanished,
   and — this is the important part — how would either of you have
   *known*, without comparing notes out loud right now, that this had
   happened?

---

## Deliverable: `lab01_findings.md`

Submit a short plain-text or Markdown report named `lab01_findings.md`,
using this template:

```markdown
# Lab 01 Findings

## Task 1: Name Inconsistency
- Student's real identity (your best guess):
- Spelling 1: ___ (row(s): ___)
- Spelling 2: ___ (row(s): ___)
- Spelling 3: ___ (row(s): ___)
- What would a name-only search miss?

## Task 2: Deletion Anomaly
- Row deleted (row number, student, course):
- What information disappeared besides the enrollment itself?
- Why did deleting one fact delete unrelated facts too?

## Task 3: Concurrent-Edit Race
- Whose change survived?
- Whose change vanished, with no error or warning?
- How would either partner have noticed, without today's exercise?

## Reflection
- One sentence: why doesn't "just be more careful" fix any of the above?
```

There is no Challenge Problem or Practice Problems section this week —
Week 1 is an orientation week. Real technical exercises begin with
Lab 02.

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Searching for only one spelling of the student's name | You conclude the student appears fewer times than they really do | Read every row by eye at least once; do not rely on a single search term |
| Assuming the deletion anomaly only loses the enrollment | You miss that the course's title, instructor, and room vanish too | Check *every* column of the deleted row for facts that don't belong only to that one enrollment |
| Skipping the actual role-play in Task 3 | You describe the concurrent-edit problem abstractly instead of having seen it happen | Actually do the "3, 2, 1, go" edit with a partner — this problem is much easier to dismiss until you watch your own change disappear |

---

## Submission and Rubric

| Deliverable | Filename | Points |
|-------------|----------|--------|
| Findings report (all three tasks, completed) | `lab01_findings.md` | 5 |

**Total: 5 points** (light week — most of Week 1's grade weight is
attendance, not this lab).

---

## Further Reading

- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th ed.,
  Ch. 1 "Introduction" (skim only — no exercises due)
- `../introduction.md` — how this lab manual fits with the slide decks
- `../setup/mysql-workbench.md` — set this up before Week 2
