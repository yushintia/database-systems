# Lab 07 Answer Key: Anomaly Hunt (Part 1)

Instructor/grader reference. Do not distribute before grading.

## Anomaly 1: Update

**Statement run:**

```sql
UPDATE Section SET instructor_name = 'Professor S. Lee' WHERE section_id = 2;
```

**Expected observed result:**

| section_id | instructor_id | instructor_name |
|---|---|---|
| 2 | 2 | Professor S. Lee |
| 3 | 2 | Prof. Lee |

**(a) Functional dependency:** `instructor_id -> instructor_name`
holds conceptually, but `instructor_name` was stored per-`section_id`
instead of per-`instructor_id`, so the dependency is not enforced by
the schema at all — nothing stops two rows sharing the same
`instructor_id` from disagreeing on `instructor_name`.

**(b) Normal form violated:** 3NF. `section_id -> instructor_id ->
instructor_name` is a transitive dependency; `instructor_name`
should live in its own relation keyed on `instructor_id`, not
repeated inside `Section`.

**(c) Real-world fact lost/corrupted:** Prof. Lee's name is now
inconsistent across her own two sections — the database cannot say
which name is authoritative without a human resolving the conflict
by hand.

## Anomaly 2: Deletion

**Statements run:** `SELECT` checks (both empty before deletion),
then `DELETE FROM Section WHERE section_id = 4;`, then the three
follow-up `SELECT`s (all empty after deletion).

**Expected observed result:** all three post-delete queries return 0
rows. "Operating Systems" (CS330) and "Dr. Park" (instructor_id 3)
existed only inside `section_id = 4`'s denormalized columns; deleting
that row deletes both facts entirely, from every table in the
database.

**(a) Functional dependency:** the same transitive chain as Anomaly
1 (`section_id -> course_code -> course_title`, and `section_id ->
instructor_id -> instructor_name`), compounded by the fact that
neither `Course` nor `Instructor` ever received a corresponding row —
an **insertion anomaly** that set up this deletion anomaly in
advance: CS330 and Dr. Park were never properly recorded anywhere
else, so nothing survives their only referencing row being removed.

**(b) Normal form violated:** 3NF (the same transitive dependencies
as Anomaly 1), plus the missing foreign key constraints that would
normally have forced `Course`/`Instructor` rows to exist before
`Section` could reference them.

**(c) Real-world fact lost/corrupted:** the course "Operating
Systems" and the instructor "Dr. Park" both cease to exist anywhere
in the database, even though deleting one closed section should not,
by itself, un-teach a course or un-hire an instructor.

## Grading Notes

- Full credit requires (a), (b), and (c) stated correctly for
  **both** anomalies, plus the exact observed result table/rows.
- Accept "transitive dependency" phrased either direction
  (`section_id -> instructor_id -> instructor_name` or the reverse
  description), as long as the chain is correctly identified.
- A common partial-credit answer: naming the anomaly type (update /
  deletion) correctly but missing the underlying normal form (3NF) —
  award (c) and partial (b), prompt for the specific rule name.
