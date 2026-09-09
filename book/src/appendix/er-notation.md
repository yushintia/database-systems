# E-R Notation Reference

This course uses **crow's-foot notation** for entity-relationship
(E-R) diagrams, starting in Lab 4. This page is the single
authoritative reference for that notation — when a lab or a rubric
says "draw an E-R diagram," it means using the symbols on this page.

> **In plain words: crow's-foot notation**
> Crow's-foot notation is a way of drawing E-R diagrams where the
> *shape* drawn on each end of a connecting line tells you how many
> of that entity can be involved. A "fork" shape that looks like a
> bird's foot means "many" — hence the name. It is the most common
> notation used in industry tools (MySQL Workbench's own EER
> diagrams use a crow's-foot style), so learning it here transfers
> directly.

---

## Entity Boxes

An **entity** is a thing the database tracks (a student, a course, a
section). Draw it as a plain rectangle, with the entity's name in
the header and its attributes listed below, following the naming
convention in the [SQL Style Guide](sql-style-guide.md)
(`PascalCase`, singular: `Student`, not `students`).

```
┌───────────────┐
│    Student     │
├───────────────┤
│ student_id (PK)│
│ name           │
│ major          │
└───────────────┘
```

## Weak Entities

A **weak entity** cannot be uniquely identified by its own attributes
alone — it depends on another entity for part of its identity. Draw
it as a **double-bordered box**. In this course's running case study,
`Enrollment` (a student registered in a section, with a grade) is the
weak entity: an enrollment only makes sense tied to a specific
`Student` and a specific `Section` (see
[Case Study Reference](case-study-reference.md)).

```
╔═══════════════╗
║  Enrollment    ║
╠═══════════════╣
║ grade          ║
╚═══════════════╝
```

## Relationships

A **relationship** connects two entities with a line (not a diamond,
in crow's-foot style — the diamond shape from Chen notation is not
used in this course). Label the line with a verb phrase describing
the relationship, e.g. "registers for", "teaches".

## Cardinality Symbols (Crow's-Foot Form)

Cardinality is drawn as a small symbol at *each end* of the
relationship line, right where it touches the entity box. Each end is
read independently.

| Symbol (at one end of the line) | Meaning | Read as |
|---|---|---|
| Single tick `┤` | Exactly one | "one" |
| Circle + tick `○┤` | Zero or one | "zero-or-one" (optional) |
| Crow's foot `≺` | Many | "many" |
| Circle + crow's foot `○≺` | Zero or many | "zero-or-many" (optional, many) |
| Tick + crow's foot `┤≺` | One or many | "one-or-many" (at least one) |

## Legend

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 260" style="max-width:600px;display:block;margin:1.5em auto;">
  <title>Legend of crow's-foot cardinality symbols: a single tick mark for exactly one, a circle with a tick for zero-or-one, a crow's-foot fork for many, a circle with a crow's-foot for zero-or-many, and a tick with a crow's-foot for one-or-many</title>
  <!-- Row 1: exactly one -->
  <line x1="20" y1="30" x2="120" y2="30" stroke="#0b3d66" stroke-width="2"/>
  <line x1="100" y1="20" x2="100" y2="40" stroke="#0b3d66" stroke-width="2"/>
  <text x="140" y="35" font-family="sans-serif" font-size="13" fill="#333">Exactly one</text>
  <!-- Row 2: zero or one -->
  <line x1="20" y1="70" x2="120" y2="70" stroke="#0b3d66" stroke-width="2"/>
  <circle cx="95" cy="70" r="8" fill="#fff" stroke="#0b3d66" stroke-width="2"/>
  <line x1="112" y1="60" x2="112" y2="80" stroke="#0b3d66" stroke-width="2"/>
  <text x="140" y="75" font-family="sans-serif" font-size="13" fill="#333">Zero or one (optional)</text>
  <!-- Row 3: many -->
  <line x1="20" y1="110" x2="120" y2="110" stroke="#0b3d66" stroke-width="2"/>
  <path d="M120,110 L100,100 M120,110 L100,110 M120,110 L100,120" stroke="#0b3d66" stroke-width="2" fill="none"/>
  <text x="140" y="115" font-family="sans-serif" font-size="13" fill="#333">Many</text>
  <!-- Row 4: zero or many -->
  <line x1="20" y1="150" x2="112" y2="150" stroke="#0b3d66" stroke-width="2"/>
  <circle cx="105" cy="150" r="8" fill="#fff" stroke="#0b3d66" stroke-width="2"/>
  <path d="M120,150 L100,140 M120,150 L100,150 M120,150 L100,160" stroke="#0b3d66" stroke-width="2" fill="none"/>
  <text x="140" y="155" font-family="sans-serif" font-size="13" fill="#333">Zero or many</text>
  <!-- Row 5: one or many -->
  <line x1="20" y1="190" x2="112" y2="190" stroke="#0b3d66" stroke-width="2"/>
  <line x1="108" y1="180" x2="108" y2="200" stroke="#0b3d66" stroke-width="2"/>
  <path d="M120,190 L100,180 M120,190 L100,190 M120,190 L100,200" stroke="#0b3d66" stroke-width="2" fill="none"/>
  <text x="140" y="195" font-family="sans-serif" font-size="13" fill="#333">One or many (at least one)</text>
  <!-- Row 6: weak entity box -->
  <rect x="20" y="220" width="90" height="30" fill="#fff" stroke="#0b3d66" stroke-width="1"/>
  <rect x="24" y="224" width="82" height="22" fill="none" stroke="#0b3d66" stroke-width="1"/>
  <text x="140" y="240" font-family="sans-serif" font-size="13" fill="#333">Weak entity (double border)</text>
</svg>
<p style="text-align:center;font-size:0.9em;color:#555;margin-top:-0.6em;"><em><strong>Figure A.1.</strong> Crow's-foot cardinality symbols used throughout this course.</em></p>

## Reading a Relationship End to End

Read a relationship line by combining both ends into one sentence.
For example, in the case study: "One `Section` has many
`Enrollment`s; one `Enrollment` belongs to exactly one `Section`."
The end nearest `Section` gets the "one" symbol; the end nearest
`Enrollment` gets the "many" symbol.

## Primary and Foreign Key Annotation

- Mark the primary key attribute inside an entity box with `(PK)`
  after its name.
- Mark a foreign key attribute with `(FK)` after its name. An
  attribute that is both (a foreign key that is also part of the
  local primary key, common in weak entities) is marked `(PK, FK)`.

```
╔════════════════════╗
║    Enrollment        ║
╠════════════════════╣
║ student_id (PK, FK)  ║
║ section_id (PK, FK)  ║
║ grade                ║
╚════════════════════╝
```

This matches the target schema in
[Case Study Reference](case-study-reference.md), where
`Enrollment`'s primary key is the composite pair
`(student_id, section_id)`, and both halves are also foreign keys
into `Student` and `Section` respectively.

---

## Quick Reference Table

| Concept | Notation |
|---|---|
| Entity | Single-bordered rectangle |
| Weak entity | Double-bordered rectangle |
| Relationship | Plain line between entities, labeled with a verb phrase |
| Exactly one | Single tick mark |
| Zero or one | Circle + tick mark |
| Many | Crow's-foot fork |
| Zero or many | Circle + crow's-foot fork |
| One or many | Tick mark + crow's-foot fork |
| Primary key attribute | `(PK)` after the attribute name |
| Foreign key attribute | `(FK)` after the attribute name |
