# Lab 06 Answer Key: The Mapping Algorithm

Instructor/grader reference. Do not distribute before grading.

## Part A — model answers (predict, no reveal)

- **A1:** `Student(student_id, name, major)`, primary key
  `student_id`. A direct copy, no design decision.
- **A2:** `Section` gets the foreign key `instructor_id`, referencing
  `Instructor.instructor_id`, by Rule 2 — the "many" side always
  holds the key.
- **A3:** `(student_id, section_id)` — `Waitlist`'s own attributes
  plus the primary keys of both entities it depends on.
- **A4/A5:** Accept any prediction if the reasoning is coherent. The
  expected wrong guess is "No, a weak entity and an M:N relationship
  sound like different things" — do not confirm or deny until Part B.

## Part B — model answers

- **B1:** Depends on their A4 guess; no wrong answer, just
  self-checking.
- **B2 (model answer):** "`Waitlist` needs the composite key
  `(student_id, section_id)` because that pair is what a foreign key
  points at from both `Student` and `Section` — a single
  `waitlist_id` would not, by itself, stop the same student from
  appearing twice on the same section's waitlist."
- **B3 (model answer):** `Waitlist(student_id, section_id, position,
  date_joined)` `PRIMARY KEY (student_id, section_id)`.
- **B4 (model answer):** `Course` gets the foreign key,
  `department_id`, referencing `Department.department_id`, by Rule 2.
- **B5 (model answer):** Rule 5 (1:1 relationship, not one of the
  four core rules but covered briefly in lecture). The foreign key
  would go on `Student`, the optional side. Accept "either side"
  reasoning too — either side is technically valid; optional side is
  just the usual convention.

## Part C — grading the student's own diagram

Every student's Lab 4 diagram is different, so there is no single
key for Part C. Grade against the **process**, using the registration
system's own diagram as the model to compare their reasoning against
(this is exactly what `target_schema.sql` is for):

| Check | What to look for |
|---|---|
| Every strong entity mapped (Rule 1) | Attributes and key copied directly, no invented columns |
| Every 1:N relationship mapped (Rule 2) | Foreign key on the "many" side only, never the "one" side, never a new relation |
| Every weak entity mapped (Rule 3) | Composite primary key = weak entity's own attributes + owning entity's key(s) |
| Every M:N relationship mapped (Rule 4) | New relation, composite key of both sides; if it also involves a weak entity, Rule 3 and Rule 4's results must agree |
| Explicit `PRIMARY KEY` declarations | Every relation states its key; composite keys are written as a single `PRIMARY KEY (a, b)`, not two separate single-column keys |

**Full worked model, using the registration system as the reference
diagram** (a stand-in for whatever diagram the student submits):

```
Student(student_id, name, major)                                    -- Rule 1
Course(course_code, title)                                          -- Rule 1
Instructor(instructor_id, name)                                     -- Rule 1
Section(section_id, course_code, instructor_id, room, semester)     -- Rule 1 + Rule 2 (x2)
Enrollment(student_id, section_id, grade)                            -- Rule 3 + Rule 4
  PRIMARY KEY (student_id, section_id)
```

This matches `book/src/labs/files/lab06/target_schema.sql` exactly.
A student's own submission should show the same *shape* of reasoning
(rule cited, relation written, key declared) applied to their own
entities — it will not match this schema's actual table names, and
should not.

## Challenge — grading notes

Accept any of Rules 6-10 correctly applied to a real construct from
the student's own diagram (or a reasonable invented one). The
required explanation must name the specific anomaly or query
difficulty a single-column shortcut would cause — for example:

- **Composite attribute stored as one string:** unqueryable by any
  one component (e.g. `WHERE city = 'Pohang'` becomes impossible
  without parsing).
- **Multivalued attribute stored as a comma-separated column:** a
  direct 1NF violation, unqueryable without parsing text.
- **Derived attribute stored directly:** an update anomaly waiting to
  happen — it silently drifts out of sync with the data it was
  computed from.

## Practice Problems — answers

1. `Course(course_code, title, credits)`, primary key `course_code`.
2. `Course` gets the foreign key `department_id`, referencing
   `Department.department_id`, by Rule 2.
3. `Book(isbn, title)`; `Member(member_id, name)`;
   `Loan(isbn, member_id, due_date)`, `PRIMARY KEY (isbn, member_id)`.
   Rule 1 (twice) and Rule 3.
4. **Rule 4** (M:N). Produces `TA_Section(ta_id, section_id)`,
   `PRIMARY KEY (ta_id, section_id)`.
5. `Ride` gets `driver_id` as a foreign key, by **Rule 2** — the
   "many" side always holds the key, never a list-column on `Driver`.
6. Violates **Rule 2**: the foreign key belongs on the "many" side,
   as a single column, not as a list-type column on the "one" side.
7. `Assignment(vehicle_id, route_id, assigned_date)`,
   `PRIMARY KEY (vehicle_id, route_id)`, by Rule 4.

## Facilitation Notes

- Part A/B total time: ~15 min prediction (no reveal), short
  instructor-led discussion, ~15 min reveal + explain.
- The A4 "not sure" moment is deliberate — do not confirm or deny the
  answer before the class discussion.
- Part C is the graded deliverable; grade the *process*, not whether
  their diagram happens to resemble the registration system's.
