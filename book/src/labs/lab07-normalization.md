# Lab 07: Normalization

| | |
|---|---|
| **Week** | 7 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Lecture & Lab |
| **Prerequisites** | Lab 06 (mapping algorithm), MySQL Workbench set up ([Setup](../setup/mysql-workbench.md)) |

**Why this lab matters:** A mechanically correct schema can still be
a bad one. This lab is the first time in the course you will *watch*
a schema corrupt itself, live, in MySQL, instead of only reading
about it. Interviewers ask "is this schema normalized, and why not"
as a standard way to check whether a candidate reasons about data
integrity, not just SQL syntax. This lab is where you learn to answer
that question by pointing at real, broken rows, not by reciting a
definition.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Concept) | 50 | Lecture: functional dependencies, 1NF/2NF/3NF, anomalies |
| B (Guided practice) | 50 | Anomaly hunt: run the seed, trigger each anomaly, observe |
| C (Independent and wrap) | 50 | Decompose to 3NF on paper · challenge · submit |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Define a functional dependency and identify one in a relation.
2. Test a relation against 1NF, 2NF, and 3NF.
3. Trigger and explain an update, deletion, and insertion anomaly
   caused by a denormalized table.
4. Decompose a denormalized relation into 3NF, without losing
   information.

---

## Recap

Lab 06 gave you a deterministic algorithm: apply Rules 1-4 correctly
and any two people produce the identical schema from the identical
diagram. But mechanically mapped tables can still carry anomalies.
The algorithm guarantees a *valid* schema. It does not guarantee a
*good* one — and this lab is where that gap stops being theoretical.

---

## Background

### Functional Dependencies

> **In plain words: functional dependency**
> A functional dependency, written A &rarr; B, means: knowing the
> value of A always tells you exactly one value of B, for every row,
> forever. A barcode determines exactly one product. A national ID
> number determines exactly one legal name. This is not
> database-specific vocabulary — it is a pattern you already reason
> about daily, made precise enough to test a schema against.

In the table below, `section_id &rarr; instructor_name`: knowing the
section tells you exactly one instructor name. That single arrow is
the root of every anomaly this lab hunts.

```
Section(section_id, course_code, course_title,
        instructor_id, instructor_name, room, semester)
```

### The Three Anomalies

| Anomaly | What happens | Example above |
|---|---|---|
| **Update anomaly** | One real-world fact needs updating in many places instead of one | Instructor changes her name; every section she teaches must be updated by hand, or the data disagrees with itself |
| **Deletion anomaly** | Deleting one fact accidentally deletes an unrelated fact as a side effect | Delete the last section for a retiring course, and `course_title` disappears with it |
| **Insertion anomaly** | A fact cannot be recorded until an unrelated fact exists first | A new instructor cannot be recorded until they are assigned to at least one section |

### 1NF, 2NF, 3NF

> **In plain words: normal form**
> A normal form is a formal test, not an opinion. "This table looks
> fine to me" is not checkable by two different people. "This table
> passes 2NF" is — you can point at exactly which rule it satisfies
> or breaks.

| Form | Rule | What it forbids |
|---|---|---|
| **1NF** | Every attribute holds a single, atomic value | Repeating groups, lists inside a cell (e.g. `"1, 2, 7, 12"`) |
| **2NF** | 1NF, and every non-key attribute depends on the **whole** primary key | A **partial dependency** — a non-key attribute depending on only part of a composite key |
| **3NF** | 2NF, and no non-key attribute depends on another non-key attribute | A **transitive dependency** — A &rarr; B &rarr; C, where C depends on A only through B |

2NF only matters for a relation with a **composite** primary key — a
single-column key automatically satisfies it, since there is no
"part of the key" for anything to depend on.

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 220" style="max-width:520px;display:block;margin:1.5em auto;">
  <title>Diagram showing a transitive dependency. A box labeled section_id has an arrow pointing right to a box labeled instructor_id, labeled determines. A second arrow points right from instructor_id to a box labeled instructor_name, also labeled determines. A dashed arrow arcs from section_id directly to instructor_name, labeled transitively, only through instructor_id. A caption below reads: 3NF forbids this chain; instructor_name must move to its own relation, keyed on instructor_id.</title>
  <defs>
    <marker id="arr-l07" markerWidth="7" markerHeight="7" refX="5" refY="3" orient="auto">
      <path d="M0,0 L0,6 L7,3 z" fill="#0b3d66"/>
    </marker>
    <marker id="arr-l07d" markerWidth="7" markerHeight="7" refX="5" refY="3" orient="auto">
      <path d="M0,0 L0,6 L7,3 z" fill="#b23b00"/>
    </marker>
  </defs>
  <rect x="10" y="30" width="150" height="50" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="85" y="60" font-family="monospace" font-size="12" fill="#0b3d66" text-anchor="middle">section_id</text>
  <rect x="205" y="30" width="150" height="50" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="280" y="60" font-family="monospace" font-size="12" fill="#0b3d66" text-anchor="middle">instructor_id</text>
  <rect x="400" y="30" width="150" height="50" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <text x="475" y="60" font-family="monospace" font-size="12" fill="#0b3d66" text-anchor="middle">instructor_name</text>
  <line x1="160" y1="55" x2="205" y2="55" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-l07)"/>
  <line x1="355" y1="55" x2="400" y2="55" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-l07)"/>
  <text x="182" y="45" font-family="sans-serif" font-size="10" fill="#0b3d66" text-anchor="middle">determines</text>
  <text x="378" y="45" font-family="sans-serif" font-size="10" fill="#0b3d66" text-anchor="middle">determines</text>
  <path d="M85,80 C 85,150 475,150 475,80" fill="none" stroke="#b23b00" stroke-width="2" stroke-dasharray="5,4" marker-end="url(#arr-l07d)"/>
  <text x="280" y="165" font-family="sans-serif" font-size="11" fill="#b23b00" text-anchor="middle">only transitively, through instructor_id</text>
  <text x="280" y="200" font-family="sans-serif" font-size="11" fill="#555" text-anchor="middle">3NF forbids this chain — move instructor_name into its own relation.</text>
</svg>

---

## Worked Example: Anomaly Hunt

This is the exact scenario from the pain slide, run for real. The
seed file creates a `Section` table that copies `course_title` and
`instructor_name` in directly — exactly the shortcut a developer
takes to avoid a join, and exactly the shortcut that reintroduces
Week 1's redundancy problem.

**Setup.** Run
`book/src/labs/files/lab07/bad_registration_seed.sql` in MySQL
Workbench. It builds `Student`, `Course`, `Instructor`, and
`Enrollment` as clean tables, and `Section` as the deliberately
denormalized one — with **no foreign key** on `course_code` or
`instructor_id`, on purpose. Nothing stops `Section` from disagreeing
with `Course` and `Instructor`, because nothing checks.

**Anomaly 1: update.** `book/src/labs/files/lab07/anomaly_triggers.sql`
runs:

```sql
UPDATE Section
SET instructor_name = 'Professor S. Lee'
WHERE section_id = 2;
```

Prof. Lee (`instructor_id` 2) teaches two sections, 2 and 3. The
update only touched section 2.

| Line | What it does |
|---|---|
| `UPDATE Section` | Targets the denormalized table directly |
| `SET instructor_name = 'Professor S. Lee'` | Changes the copied text in **one** row |
| `WHERE section_id = 2` | Leaves every other row referencing `instructor_id = 2` untouched |

The follow-up query shows the damage:

| section_id | instructor_id | instructor_name |
|---|---|---|
| 2 | 2 | Professor S. Lee |
| 3 | 2 | Prof. Lee |

One real instructor, two disagreeing names, and MySQL raised no
error — the schema never declared that both rows must agree, because
`instructor_name` was never tied to `instructor_id` by a single,
authoritative row.

**Anomaly 2: deletion.** CS330 ("Operating Systems") and instructor
"Dr. Park" exist **only** inside `section_id = 4`'s denormalized
columns — `Course` and `Instructor` have no rows for either, checked
before the delete. Running

```sql
DELETE FROM Section WHERE section_id = 4;
```

deletes the section — and, as a side effect, every trace that
"Operating Systems" or "Dr. Park" ever existed anywhere in the
database. Before the delete, both were real, nameable things you
could query. After it, they are gone: not "marked inactive," gone.

**Root cause, named formally.** `Section(section_id, course_code,
course_title, instructor_id, instructor_name, room, semester)` has a
single-column key, `section_id`, so it automatically passes 2NF.
But `section_id &rarr; instructor_id`, and `instructor_id &rarr;
instructor_name`, so `section_id &rarr; instructor_name` only
**transitively**, through `instructor_id` — a 3NF violation. The same
is true of `course_title`, transitively through `course_code`.

**Decomposition.** Remove each transitively-dependent attribute and
put it where it depends on a key directly:

```
Section(section_id, course_code, instructor_id, room, semester)
Course(course_code, title)
Instructor(instructor_id, name)
```

This is exactly `book/src/labs/files/lab06/target_schema.sql`'s
`Section`, `Course`, and `Instructor` — the same schema Lab 06's
mapping algorithm produced directly, reached this time by deliberate
mistake, then fix. Update Prof. Lee's name once, in one row, done.

---

## Guided Exercises

### Part 1: Anomaly Hunt (in-lab)

1. Run `book/src/labs/files/lab07/bad_registration_seed.sql`.
2. Open `book/src/labs/files/lab07/anomaly_triggers.sql`. Run
   **Anomaly 1**'s statements one at a time — the `UPDATE`, then the
   `SELECT`. Record the exact result table you see.
3. Run **Anomaly 2**'s statements one at a time — the two "before"
   `SELECT`s, the `DELETE`, then the three "after" `SELECT`s. Record
   what changed.
4. For each anomaly, write: (a) which functional dependency caused
   it, (b) which normal form it violates, (c) what real-world fact
   was lost or corrupted.

**Deliverable:** `lab07_anomalies.md` — your recorded results and
answers to (a)-(c) for both anomalies.

### Part 2: Decompose to 3NF (on paper)

Starting from the denormalized `Section`:

```
Section(section_id, course_code, course_title,
        instructor_id, instructor_name, room, semester)
```

1. Check 1NF. State whether it passes.
2. Check 2NF. State whether it passes, and why (hint: what shape is
   the primary key?).
3. Check 3NF. Identify every transitive dependency by name (write
   both halves of the `A &rarr; B &rarr; C` chain).
4. Decompose: write every resulting relation, with every primary key
   and foreign key declared.
5. Confirm your result matches
   `book/src/labs/files/lab06/target_schema.sql`. If it does not,
   find which step above produced the mismatch.

**Deliverable:** `lab07_normalized.md` — your answers to steps 1-4,
and a one-sentence confirmation (or explanation of the mismatch) for
step 5.

---

## Challenge Problem

The seed's `Waitlist` feature (from Lab 06) was never denormalized —
but suppose a developer built it the same "convenient" way:

```
Waitlist(student_id, section_id, student_name, course_title, position)
```

Test this relation against 1NF, 2NF, and 3NF, identify every
violation by name, and decompose it fully. Confirm your final answer
matches Lab 06's `Waitlist(student_id, section_id, position,
date_joined)` in every column except `date_joined` (which this
version of the table never had to begin with).

Add this to `lab07_normalized.md` as a final section, "Challenge:
Normalizing Waitlist."

---

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** `Loan(isbn, member_id, book_title, member_name,
due_date)`, `PRIMARY KEY (isbn, member_id)`. Identify every anomaly
and normalize the relation.

**Practice 2.** `Employee(employee_id, department_id,
department_manager)`, where knowing the department tells you its
manager. Identify the violation and fix it.

**Practice 3.** `Student(student_id, name, major,
department_office)`, where `department_office` depends on `major`,
not on `student_id`. Which normal form does this violate?

**Practice 4.** `Enrollment(student_id, section_id, grade,
course_title)`, `PRIMARY KEY (student_id, section_id)`. Identify the
violation and fix it.

**Practice 5.** `Section(section_id, course_code, course_title,
instructor_id, instructor_name, room, semester)`. Identify every
anomaly and fully normalize the relation. (This is the pain slide's
own table — solve it without looking back at the Worked Example.)

**Practice 6.** `Enrollment(student_id, section_id, grade,
attendance_percent)`, `PRIMARY KEY (student_id, section_id)`. Is this
already in 2NF? Justify your answer.

**Practice 7.** A gym membership system has
`Checkin(member_id, gym_location_id, gym_location_address,
checkin_time)`. Identify the violation and fix it.

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Confusing 2NF and 3NF | Naming the wrong normal form on a correct diagnosis | 2NF is about a composite key's *parts*; 3NF is about non-key attributes depending on *each other* — different failures, different fixes |
| Stopping at 2NF because the key is single-column | Missing a transitive dependency entirely | A single-column key passes 2NF automatically, but 3NF still applies — always check both |
| Normalizing past what the requirements need | Extra joins later for no anomaly actually removed | Normalize until the anomalies are gone, not one step further out of habit |
| Assuming a decomposition is automatically lossless | A split that cannot reconstruct the original rows | Every split in this lab keeps the key attribute in both halves — check this explicitly, don't assume it |
| Treating "passes 2NF" as "anomaly-free" | Missing the exact trap in this lab's Worked Example | `Section` above passes 2NF and still has three anomalies — 2NF is necessary, not sufficient |

---

## Submission and Rubric

| Deliverable | Filename | Points |
|-------------|----------|--------|
| Anomaly hunt results and analysis | `lab07_anomalies.md` | 4 |
| 3NF decomposition (Part 2) | `lab07_normalized.md` | 4 |
| Challenge: normalizing Waitlist | included in `lab07_normalized.md` | 2 |

**Total: 10 points**

---

## Further Reading

- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th
  ed., Ch. 8.
- `slides/week07-normalization.md` — the full lecture, including
  lossless-join and dependency-preserving decomposition, closure, and
  BCNF, beyond this lab's 1NF/2NF/3NF scope.
