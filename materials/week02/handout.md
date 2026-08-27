# Week 2 Handout: Relational Model

Database Systems (511783-001) — for students to keep and read again.
Use plain, simple English on purpose, so it is easy to read even if
English is not your first language.

---

## 1. Glossary: Key Words This Week

Read each definition once now. You do not need to memorize them today —
you will use them all semester.

| Term | Plain definition |
|---|---|
| **Relation** | The formal word for "table." A set of tuples, all following the same relation schema |
| **Relation schema** | The fixed shape of a relation: a name, and a fixed set of attributes, each drawn from a domain. Written like `Student(student_id, name, major)` |
| **Relation instance** | The actual set of tuples in a relation right now. The schema never changes; the instance changes every time a row is added, removed, or edited |
| **Attribute** | A named column in a relation, such as `name` or `major` |
| **Domain** | The set of legal values an attribute can hold, such as "any text up to 100 characters" or "an integer 0 through 100" |
| **Tuple** | One row: one value per attribute, matching the schema |
| **Set** | A collection with no duplicate elements and no meaningful order. A relation is a set of tuples, so it can never contain two identical rows, and row order carries no meaning |
| **Superkey** | Any set of attributes whose values uniquely identify each tuple in the relation, even if it carries extra, unnecessary attributes |
| **Candidate key** | A superkey with no unnecessary attributes — remove any one attribute from it, and it stops being unique |
| **Primary key** | The candidate key the schema designer chooses as the main way to identify a tuple. Written underlined in schema notation |
| **Foreign key** | An attribute (or set of attributes) in one relation that must match the primary key of a tuple in another relation, or be empty. This is how two relations connect |
| **Integrity constraint** | A rule a relation's data must obey at all times, enforced automatically rather than by someone remembering to check |
| **Domain constraint** | Every value in a tuple must belong to its attribute's declared domain |
| **Key constraint** | No two tuples in a relation may share the same primary key value |
| **Referential integrity constraint** | Every foreign key value must match an existing primary key value in the referenced relation, or be left empty |

---

## 2. The Registration System, Worked Out Step by Step

This is the full version of the story from class. Read it slowly if the
in-class pace felt fast.

**The situation.** Two students in this class, on their own time, each
try to sketch "tables" for the registration system. One writes a single
big list: student name, major, course, instructor, room, grade, all in
one sheet. The other splits it into a student list and a separate class
list, but puts the grade in the student list instead of the class list.

Both are tables. Neither is obviously wrong by the rules we had before
this week, because we had not agreed on what a table is even supposed
to guarantee. Two reasonable people, same requirements, two
incompatible designs. This week fixes that: a **relation** means
exactly one thing, everywhere, the same way "prime number" means one
thing in every math class on Earth.

Week 1's actual spreadsheet had one flat row like this:

```
Kim Minji, Computer Sci., CSE301, Prof. Lee, A0
```

Here is how that messy row becomes a real relation, one decision at a
time.

**Step 1: Separate the facts.** That one row tangles together five
facts about at least three different real things: a student, a course,
and an enrollment. This step alone is why Week 3 (data modelling)
exists — choosing which facts belong together is a design decision,
not a formatting one.

**Step 2: Pick the attributes for one relation.** Take just the
student's own facts: `name`, `major`. Not `course_code`, not `grade` —
those belong to a different relation entirely.

**Step 3: Assign domains.** `name`: text, up to 100 characters.
`major`: text, drawn from the university's list of real majors, not
any arbitrary string. That gives us:

```
Student(name, major)
```

A schema now exists, but nothing yet prevents two "Kim Minji" tuples
from being indistinguishable.

**Step 4: Add the key.** Add a system-generated `student_id`,
specifically so `{student_id}` is a candidate key:

```
Student(student_id, name, major)
```

One messy row becomes one properly formed relation, every rule from
this week applied in the order a real designer actually applies it.

**Step 5: Repeat for every other relation.** The same four steps,
applied to the course facts and the instructor facts in that original
row, give us two more relations:

```
Student(student_id, name, major)
Course(course_code, title)
Instructor(instructor_id, name)
```

`Student.student_id`, `Course.course_code`, and
`Instructor.instructor_id` are each a primary key, underlined by
convention. Every attribute has a domain, and no table here can ever
hold a duplicate primary key value, by definition. This is not yet the
full schema — `Section` and `Enrollment` are still missing.

**What we still can't say yet.** We now have a rigorous definition of
what a table is: relations, attributes, tuples, keys, and the rules
they must obey. But nothing in this vocabulary tells us *which* tables
to make. Why split `Student` from `Enrollment`, and not some other way?
Knowing the rules a table must follow is not the same as knowing which
tables to build. That question is still open — Week 3, Data Modelling,
gives us a structured process to answer it, so the answer stops being
a guess.

---

## 3. Optional Reading: Extra Detail (Not Required, Not on the Quiz)

This section holds extra explanations that were trimmed from the
slides to keep class time short. Read it if you are curious or want
more examples.

**Why "two people, two answers" matters at scale.** In a classroom
example, two conflicting table sketches are just an awkward moment.
On a real engineering team, they are much more expensive. Without a
shared definition of "table," two team members' designs cannot even be
compared, let alone merged into one system. A design that looks fine
on a whiteboard can still let the same fact be stored in two places —
exactly last week's redundancy problem, unsolved, just redrawn. Every
real schema you will ever touch, in any job, gets judged against this
exact vocabulary: superkey, candidate key, primary key, foreign key,
and the three integrity constraints. "Normalize this table" and
"what's the primary key here" are baseline vocabulary in any backend
or data role — without it, you cannot even read a schema diagram, let
alone design one.

**This vocabulary is everywhere, not just in a classroom registration
system.** Every post on Instagram has a `post_id` primary key. Amazon
ties your cart to your address with an `order_id`. KakaoTalk uses a
`user_id` as the foreign key on every message. A banking app's
`account_number` is a candidate key — never the account owner's name.
Every one of these real systems would break in exactly Week 1's ways
without the three constraints you learned this week.

**Who actually designs this, as a job.**

- **Database designers** decide which relations a system needs and
  what each one's primary and foreign keys should be, before any code
  is written
- **Data modelers** turn business requirements ("track students,
  courses, and grades") into precise relations, attributes, and
  domains like the ones in this handout

---

## 4. Practice Problems (With Answers)

Try each problem yourself before checking the answer underneath it.

**Problem 1.** A library system uses `Book(isbn, title, author)`,
`Member(member_id, name)`, `Loan(isbn, member_id, due_date)`. Name a
candidate key for `Loan`, and identify both of its foreign keys.

> **Answer:** `{isbn, member_id}` is a candidate key — one member
> cannot borrow the exact same book twice at once. `isbn` and
> `member_id` are each foreign keys, referencing `Book.isbn` and
> `Member.member_id`.

**Problem 2.** An online store uses `Product(sku, name, price)`,
`Customer(customer_id, name)`, `Order(order_id, customer_id, sku,
quantity)`. `Order` has its own `order_id`. Why might a designer
choose that over a composite key of `{customer_id, sku}`?

> **Answer:** A customer can order the same product twice, in two
> separate orders (`quantity` two different times), so
> `{customer_id, sku}` is not actually unique. A dedicated `order_id`
> solves this directly — exactly why real e-commerce systems use one.

**Problem 3.** `Instructor(instructor_id, name, office)`. Is
`{instructor_id}` a candidate key, a superkey, both, or neither?

> **Answer:** Both. It uniquely identifies each instructor (so it is a
> superkey), and it has no unnecessary attributes to remove (so it is
> a candidate key too). A relation's primary key is always both.

**Problem 4.** An `Enrollment` row has `student_id = 999`, but no
student with ID 999 exists in `Student`. Which integrity rule is
broken?

> **Answer:** Referential integrity. The foreign key `student_id` in
> `Enrollment` must match an existing primary key value in `Student`,
> or be left empty. A row pointing at a student that does not exist is
> an orphaned, meaningless row.

**Problem 5.** A `Loan` row has `due_date = 'next Tuesday'` in a
column whose domain is defined as calendar dates only. Which
constraint catches this?

> **Answer:** The domain constraint. "next Tuesday" is not a calendar
> date value; it violates the declared domain of the `due_date`
> attribute.

**Problem 6.** A movie streaming service uses `Member(member_id,
name)`, `Movie(movie_id, title)`, `Watch(member_id, movie_id,
watched_date)`. Name a candidate key for `Watch`, and identify both of
its foreign keys.

> **Answer:** `{member_id, movie_id, watched_date}` is closer to a
> candidate key than `{member_id, movie_id}` alone, since a member
> could rewatch the same movie on a different date. `member_id` and
> `movie_id` are each foreign keys, referencing `Member.member_id` and
> `Movie.movie_id`.
