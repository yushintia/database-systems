# Lab 02: The Relational Model

| | |
|---|---|
| **Week** | 2 |
| **Duration** | 3 × 50 min (150 min) |
| **Method** | Lecture & Lab |
| **Prerequisites** | Lab 01 (the spreadsheet problem) |

**Why this lab matters:** Last week you found real problems in a real
messy spreadsheet, by hand. This week gives you the first precise
vocabulary for fixing them — not the fix itself yet, just the exact
words engineers use so that two people never disagree about what a
"table" is supposed to guarantee. Every schema you touch for the rest
of your career, in any job, gets judged against exactly this
vocabulary: relation, tuple, attribute, domain, key. This lab does not
ask you to write a single line of SQL yet — you don't have a design to
build one against. You only run a script someone else wrote, look at
the result with your own eyes, and try (and fail) to find a clean
primary key in it. The failure is the point.

**Time allocation**

| Part | Min | Activity |
|--------|-----|----------|
| A (Concept) | 50 | 10 recap Lab 01 · 30 relations, attributes, domains, tuples, keys · 10 live demo |
| B (Guided practice) | 50 | 40 load the raw table, hunt for a primary key, guided analysis exercises · 10 debrief |
| C (Independent and wrap) | 50 | 35 independent practice problems · 10 challenge · 5 submit and Week 3 preview |

---

## Learning Outcomes

By the end of this lab, you will be able to:

1. Define a relation precisely: attributes, domains, tuples, and a
   relation schema versus a relation instance.
2. Identify a superkey, a candidate key, and a primary key in a given
   relation, and explain the difference between all three.
3. Explain the three integrity constraints (domain, key, referential)
   and recognize a real row that violates each one.
4. Explain, using a live table of real (if messy) data, why nothing in
   this week's vocabulary yet tells us *which* tables to build.

---

## Recap

Lab 01 left you holding a genuinely broken spreadsheet: the same
student spelled three different ways, a deletion that erased a
course's entire identity along with one enrollment, and a race
condition between two staff members editing at once. None of that is
fixed yet. This week gives you the first tool for fixing part of it —
a precise definition of what a table is even supposed to guarantee —
but not yet the design process that decides *which* tables to build.
That gap is intentional; Lab 03 is where it closes.

---

## Background

### What Is a Relation?

> **In plain words: relation**
> A relation is the formal word for "table." Not any table — a table
> that follows exact rules: every row has the same columns, every
> column only holds values of one declared kind, and no two rows are
> ever allowed to be perfectly identical. A relation is a **set** of
> rows (called tuples), which is exactly why duplicates and row order
> are both forbidden — a mathematical set can't contain the same
> element twice, and has no first or last element.

A relation has two parts that change at very different speeds:

> **In plain words: relation schema vs. relation instance**
> The **relation schema** is the fixed shape: a name and a fixed list
> of attributes, written like `Student(student_id, name, major)`. It
> almost never changes.
> The **relation instance** is the actual set of rows in the relation
> *right now*. It changes every time a row is added, deleted, or
> edited. The schema `Student(student_id, name, major)` stays the same
> whether the instance has 3 rows or 30,000.

### Attributes, Domains, and Tuples

> **In plain words: attribute and domain**
> An **attribute** is a named column, like `name` or `major`. Its
> **domain** is the set of legal values it is allowed to hold — "any
> text up to 100 characters," or "an integer from 0 to 100." A value
> that isn't in its attribute's domain should be impossible to store,
> by definition, not just discouraged.

> **In plain words: tuple**
> A **tuple** is one row: one value per attribute, matching the
> schema exactly. `(1, 'Kim Minji', 'Computer Science')` is one tuple
> of `Student(student_id, name, major)`.

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 230" style="max-width:480px;display:block;margin:1.5em auto;">
  <title>Diagram of a relation's anatomy. The relation name Student labels the whole box. Across the top, three attribute headers: student_id, name, major, each with its domain noted underneath. Below, two rows are marked as tuples, each holding one value per attribute.</title>
  <text x="260" y="20" font-family="sans-serif" font-size="13" font-weight="bold" fill="#0b3d66" text-anchor="middle">Relation: Student(student_id, name, major)</text>
  <rect x="30" y="35" width="460" height="185" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="2"/>
  <rect x="45" y="48" width="140" height="40" rx="4" fill="#ddeeff" stroke="#0b3d66"/>
  <text x="115" y="65" font-family="monospace" font-size="11" fill="#0b3d66" text-anchor="middle">student_id</text>
  <text x="115" y="80" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">domain: integer</text>
  <rect x="195" y="48" width="140" height="40" rx="4" fill="#ddeeff" stroke="#0b3d66"/>
  <text x="265" y="65" font-family="monospace" font-size="11" fill="#0b3d66" text-anchor="middle">name</text>
  <text x="265" y="80" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">domain: text ≤100 chars</text>
  <rect x="345" y="48" width="130" height="40" rx="4" fill="#ddeeff" stroke="#0b3d66"/>
  <text x="410" y="65" font-family="monospace" font-size="11" fill="#0b3d66" text-anchor="middle">major</text>
  <text x="410" y="80" font-family="sans-serif" font-size="9" fill="#555" text-anchor="middle">domain: text, fixed list</text>
  <rect x="45" y="110" width="430" height="30" rx="4" fill="#fff8e6" stroke="#c07000"/>
  <text x="60" y="130" font-family="monospace" font-size="11" fill="#c07000">1, Kim Minji, Computer Science</text>
  <text x="500" y="130" font-family="sans-serif" font-size="10" fill="#c07000" text-anchor="end">tuple 1</text>
  <rect x="45" y="150" width="430" height="30" rx="4" fill="#fff8e6" stroke="#c07000"/>
  <text x="60" y="170" font-family="monospace" font-size="11" fill="#c07000">2, Park Jiho, Software Engineering</text>
  <text x="500" y="170" font-family="sans-serif" font-size="10" fill="#c07000" text-anchor="end">tuple 2</text>
  <text x="260" y="205" font-family="sans-serif" font-size="10" fill="#8e2020" text-anchor="middle">A relation is a SET of tuples: no two identical rows, no meaningful order.</text>
</svg>
<p style="text-align:center;font-size:0.9em;color:#555;margin-top:-0.6em;"><em><strong>Figure 2.1.</strong> A relation's anatomy: schema across the top, tuples below.</em></p>

### Superkeys, Candidate Keys, and Primary Keys

> **In plain words: superkey and candidate key**
> A **superkey** is any set of attributes whose values uniquely
> identify every tuple in the relation — even if it carries extra,
> unnecessary attributes along with it. A **candidate key** is a
> superkey with nothing extra: remove any single attribute from it,
> and it stops being unique. `{student_id}` is a candidate key.
> `{student_id, name}` is a superkey, but not a candidate key, because
> `name` was never needed for uniqueness in the first place.

> **In plain words: primary key**
> The **primary key** is the one candidate key the schema's designer
> picks as the main way to identify a tuple. By convention it is
> underlined in schema notation: `Student(`**`student_id`**`, name,
> major)`. A relation can have several candidate keys but only one
> primary key.

### Foreign Keys and the Three Integrity Constraints

> **In plain words: foreign key**
> A **foreign key** is an attribute (or set of attributes) in one
> relation that must match the primary key of some tuple in another
> relation — or be left empty. This is the formal mechanism that
> connects two relations together, the "linking" Lab 01's spreadsheet
> never had any rule for.

Every relation, no matter its schema, must obey three rules at once:

| Constraint | Rule | The Lab 01 failure it closes |
|---|---|---|
| **Domain constraint** | Every value must belong to its attribute's declared domain | A grade column that quietly accepts any typed text at all |
| **Key constraint** | No two tuples may share the same primary key value | Two "Kim Minji" rows that are impossible to tell apart |
| **Referential integrity** | Every foreign key value must match an existing primary key value, or be empty | An enrollment pointing at a student who doesn't exist anywhere |

None of these three rules were enforced by Lab 01's spreadsheet. A
spreadsheet cell will happily accept "A99" in a column meant to hold
only letter grades. This week's constraints exist specifically so that
kind of mistake becomes *impossible to create*, not just unlikely.

---

## Worked Example: Loading the Flat Table, and Trying to Find a Key

`files/lab02/flat_load.sql` is a run-only script — you execute it
exactly as given, you don't write or edit any of it. Open it in MySQL
Workbench (**File > Open SQL Script...**, then the lightning-bolt
**Execute** button) or run it from the command line:

```
mysql -u root -p < flat_load.sql
```

> [`flat_load.sql`](files/lab02/flat_load.sql)

### Line by line: what the script actually does

| Line(s) | What it does |
|---|---|
| `DROP DATABASE IF EXISTS registration_db;` | Removes any old copy first, so re-running this script always starts from the exact same clean state |
| `CREATE DATABASE registration_db; USE registration_db;` | Creates a fresh database and switches into it, so every statement after this runs against it |
| `CREATE TABLE raw_registrations (...)` | Declares ONE flat table with seven columns — no primary key, no foreign key, no constraint declared anywhere, on purpose |
| `INSERT INTO raw_registrations ... VALUES (...)` | Loads the same 18 rows from Lab 01's `registrations.xlsx`, exactly as messy as the original spreadsheet |

### Now look at what loaded

Open the table in Workbench's data grid (right-click
`raw_registrations` → **Select Rows - Limit 1000**), or run the one
line below exactly as written:

```sql
SELECT * FROM raw_registrations LIMIT 5;
```

This is a query, the skill you learn for real starting Week 11. Today
it is only a window for looking at what loaded:

| Piece | What it does |
|---|---|
| `SELECT *` | "Show me every column" |
| `FROM raw_registrations` | "...from this table" |
| `LIMIT 5` | "...but only the first 5 rows" (the table has 18; this keeps the output short) |

```
+---------------+-------------------+-------------+-------------------+-----------+----------+-------+
| student_name  | student_major     | course_code | course_title      | instructor| room     | grade |
+---------------+-------------------+-------------+-------------------+-----------+----------+-------+
| Kim Minji     | Computer Science  | CSE301      | Database Systems  | Prof. Lee | 성파 702 | A0    |
| Park Jiho     | Software Engineer.| CSE301      | Database Systems  | Prof. Lee | 성파 702 | B+    |
| MinJi Kim     | Computer Science  | CSE210      | Data Structures   | Prof. Han | 인지관305| A-    |
| Lee Somin     | Computer Science  | CSE301      | Database Systems  | Prof. Lee | 성파 702 | A0    |
| Choi Yuna     | Data Science      | CSE210      | Data Structures   | Prof. Han | 인지관305| B0    |
+---------------+-------------------+-------------+-------------------+-----------+----------+-------+
```

This is now a real relation *instance*, sitting inside a real MySQL
server — the exact same messy data from Lab 01, no longer a
spreadsheet, but not yet fixed either. `raw_registrations` has a
relation schema (seven named attributes, each with an implied domain)
and 18 tuples. That much of this week's vocabulary already applies to
it. What doesn't yet apply is a working primary key — watch:

### Attempt 1: `student_name` as the primary key

Fails immediately. `Kim Minji` appears as three different spellings of
one real person (Lab 01, Task 1) — the same real-world entity looks
like three different tuples. Worse, in a large enough real system, two
*different* real students could share an identical legal name.

### Attempt 2: `course_code` as the primary key

Fails immediately, differently. `CSE301` appears in seven different
rows. A candidate key must be unique per tuple; `course_code` repeats
constantly here, because this raw table hasn't yet separated "facts
about a course" from "facts about one specific enrollment" — that
separation is next week's job (Lab 03), not this week's.

### Attempt 3: `{student_name, course_code}` together

Closer, but still fails. Nothing stops the exact same student from
enrolling in the exact same course twice in different terms (this raw
table has no `semester` column to tell those apart), and the
name-inconsistency problem from Attempt 1 hasn't gone away — `Kim
Minji` and `MinJi Kim` in the same course still look like two
different "people" to this pair.

### Attempt 4: the entire row, all seven columns together

Still fails, for a different reason: it is technically almost unique
here, but it is not a *real* candidate key — it only works by
accident, because this particular 18-row sample happens not to contain
an exact duplicate row. A slightly different, equally realistic sample
could easily contain two genuinely identical rows (same student,
retaking an identical grade in a retake). A key that only holds by
luck on today's data is not a key.

**What actually fixes this:** a system-generated `student_id`, never
typed by a human, added specifically so `{student_id}` becomes a
candidate key that cannot repeat this failure — exactly the fourth
step in this week's Background, and exactly what `raw_registrations`
is missing. Nothing forces us yet to add it here, though — that
decision belongs to a real design process, which is Lab 03's job, not
this week's.

---

## Worked Example: Constructing a Relation, Start to Finish

Finding a key on a broken table only shows what fails. Building a
relation the right way, on purpose, is a different skill: four
questions, asked in order, every time. Here it is done once, on
**Course**, so Exercise 1 still asks you to do it yourself on
`Student`.

### Step 1: Isolate the facts about one real-world thing

Start from the same flat row Lab 01 used: `Kim Minji, Computer
Science, CSE301, Database Systems, Prof. Lee, 성파 702, A0`. Ask of
every single value: is this a fact about the course itself, or about
something else? `CSE301` and `Database Systems` survive: a course code
and a course title are true of the course no matter who teaches it,
where, or which students ever enroll. `Prof. Lee` and `성파 702` are
facts about one specific *offering* of the course, not the course
itself (a later term could offer CSE301 with a different instructor,
in a different room, and it would still be the same course). `Kim
Minji` and `A0` are facts about one student's one enrollment. Only the
first two values belong in `Course`.

### Step 2: Name the attributes and their domains

Two attributes survived Step 1, so `Course` gets exactly two:
`course_code` (a fixed-format code, letters followed by digits, such
as `CSE301`) and `title` (free text, up to some reasonable length).
Naming the domain now, even loosely, is what will later let a
database reject `course_code = 'nine'` instead of quietly storing it.

### Step 3: List every candidate key honestly

Check each plausible attribute set against the same standard Attempts
1-4 above used: does it stay unique for every real course, not just
today's sample?

| Candidate | Verdict | Why |
|---|---|---|
| `{course_code}` | Candidate key | The university's own catalog guarantees no two courses share a code |
| `{title}` | Fails | Two different courses can legitimately share a title, such as two different "Special Topics" offerings |
| `{course_code, title}` | Superkey only | Unique, but `title` adds nothing once `course_code` alone already works |

### Step 4: Choose the primary key and write the schema

Only one real candidate key exists, so it is also the primary key:

```
Course(course_code, title)
```

with `course_code` underlined by convention. Notice this works as a
*natural* key, built from a value the real world already guarantees is
unique (the catalog), unlike `student_name` in Attempt 1 above. That
is exactly why `Student` cannot reuse this same trick: no attribute a
human types for a student is guaranteed unique by anything in the real
world, which is why `Student` needs a *system-generated*
`student_id` instead. Deciding that, for `Student`, is Exercise 1.

> **In plain words: the four questions, every time**
> 1. What real-world thing are these facts actually about?
> 2. What are its attributes, and what is each one's domain?
> 3. What are every candidate key, checked honestly, not just today?
> 4. Which candidate key becomes the primary key?

---

## Guided In-Lab Exercises

These are paper/analysis exercises. Answer them directly inside
`lab02_keys.md` — there is no SQL to write this week.

### Exercise 1: The Registration System, One Relation at a Time (Part B)

Use the same four questions the Worked Example just walked through on
`Course`, this time on `Student`.

Lab 01's spreadsheet had one flat row like this:

```
Kim Minji, Computer Sci., CSE301, Prof. Lee, A0
```

1. List the different real-world "things" (a student? a course? an
   enrollment? something else?) the facts in that one row are actually
   about.
2. Pick only the attributes that belong to the *student's own* facts
   (not the course, not the grade).
3. Write the full `Student` relation schema, including a key that
   guarantees no two students are indistinguishable.
4. `Course(course_code, title)` and `Instructor(instructor_id, name)`
   are this week's other two relations. For each, name a candidate key
   and say whether it is also the primary key.

### Exercise 2: Referential Integrity, By Hand

`Enrollment(student_id, course_code, grade)` has `student_id` as a
foreign key referencing `Student.student_id`. Suppose a row has
`student_id = 999`, but no student with ID 999 exists in `Student`.

1. Which integrity rule does this break?
2. In your own words, why is that row meaningless, not just incorrect?

### Exercise 3: `raw_registrations`, Classified

Using the live table you loaded above, answer:

1. Name one column whose current domain is "whatever text was typed,"
   and describe the domain it *should* have (be specific: what values
   should be legal, what should not be).
2. Point to one specific pair of rows in `raw_registrations` that
   violates what a `Student` relation's key constraint would require,
   if `raw_registrations` were a real `Student` table.

---

## Challenge Problem

Design, on paper, a relation schema for a **library membership
system**: `Book(isbn, title, author)`, `Member(member_id, name)`,
`Loan(isbn, member_id, due_date)`.

1. State a candidate key for each of the three relations.
2. `Loan` has two foreign keys. Name both, and say exactly which
   relation and attribute each one references.
3. A `Loan` row appears with `isbn` pointing at a book that was
   removed from `Book` last year. Which constraint does this violate,
   and what real-world problem does that constraint prevent?

Write your answer directly into `lab02_keys.md` under a "Challenge"
heading.

---

## Practice Problems

These are ungraded: extra practice for the concepts in this lab.
Solutions are not distributed with this page.

**Practice 1.** A library system uses `Book(isbn, title, author)`,
`Member(member_id, name)`, `Loan(isbn, member_id, due_date)`. Name a
candidate key for `Loan`, and identify both of its foreign keys.

**Practice 2.** An online store uses `Product(sku, name, price)`,
`Customer(customer_id, name)`, `Order(order_id, customer_id, sku,
quantity)`. `Order` has its own `order_id`. Why might a designer
choose that over a composite key of `{customer_id, sku}`?

**Practice 3.** `Instructor(instructor_id, name, office)`. Is
`{instructor_id}` a candidate key, a superkey, both, or neither?

**Practice 4.** An `Enrollment` row has `student_id = 999`, but no
student with ID 999 exists in `Student`. Which integrity rule is
broken?

**Practice 5.** A `Loan` row has `due_date = 'next Tuesday'` in a
column whose domain is defined as calendar dates only. Which
constraint catches this?

**Practice 6.** A movie streaming service uses `Member(member_id,
name)`, `Movie(movie_id, title)`, `Watch(member_id, movie_id,
watched_date)`. Name a candidate key for `Watch`, and identify both of
its foreign keys.

**Practice 7.** A gym uses `Member(member_id, name)`,
`Class(class_id, name, day_of_week)`, `Checkin(member_id, class_id,
checkin_time)`. A member can attend the same weekly class more than
once, on different weeks. Name a candidate key for `Checkin` that
actually works given that fact, and explain why `{member_id,
class_id}` alone is not enough.

---

## Common Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Using a person's name as a primary key | Same real person looks like several different rows, or two different real people collide | Use a system-generated ID, never typed by hand |
| Confusing a superkey with a candidate key | Calling `{student_id, name}` a candidate key | Check whether every attribute is *necessary* for uniqueness — if not, it's a superkey only |
| Trusting a key that "happens" to be unique on today's sample data | A key that breaks the moment realistic new data arrives | Ask whether the uniqueness is guaranteed by the real-world meaning of the attribute, not just true by luck on 18 rows |
| Treating `raw_registrations` as if it were already a good design | Trying to force a primary key onto a table that hasn't been split into Student/Course/Enrollment yet | Recognize that *no* clean key exists yet — that gap is this week's actual lesson, and Lab 03 is what fixes it |

---

## Submission and Rubric

| Deliverable | Filename | Points |
|-------------|----------|--------|
| Guided Exercises 1-3 (relation vocabulary + referential integrity + `raw_registrations` analysis) | `lab02_keys.md` | 5 |
| Key-hunting writeup (why Attempts 1-4 each fail, in your own words) | `lab02_keys.md` | 3 |
| Challenge Problem (library schema) | `lab02_keys.md` | 2 |

**Total: 10 points**

---

## Further Reading

- Silberschatz, Korth, Sudarshan, *Database System Concepts*, 7th ed.,
  Ch. 2 "Introduction to the Relational Model"
- [SQL Style Guide](../appendix/sql-style-guide.md) — you'll need this starting Week 9
- Think ahead to next week: the registration system will also need a
  `Section` and an `Enrollment` relation. What do you think each one's
  primary key should be?
