# Lab 01 Answer Key — `lab01_findings.md` (Professor Only)

Not linked from any public page. Model answer for
`solutions/lab01/problems.md`, keyed to
`book/src/labs/files/lab01/registrations.csv` (rows counted with the
header as row 1, so the first data row is row 2).

## Task 1: Name Inconsistency

- **Real identity:** the same student, referred to three ways.
- **Spelling 1 — "Kim Minji":** rows 2, 11
- **Spelling 2 — "MinJi Kim":** rows 4, 13
- **Spelling 3 — "김민지":** rows 7, 19
- **What a name-only search would miss:** searching only "Kim Minji"
  finds 2 of this student's 6 enrollment rows and misses the other 4 —
  a query like "list every course this student is in" would silently
  under-report by two-thirds.

## Task 2: Deletion Anomaly

- **Row:** row 14, Oh Taeyang, CSE410 (Machine Learning) — the only
  enrollment row for CSE410 in the entire file.
- **What disappears:** not just "Oh Taeyang is enrolled in CSE410" —
  also the fact that CSE410 is called "Machine Learning," that it is
  taught by Prof. Oh, and that it meets in 성파 508. All four facts
  live only in this one row, even though only one of them (the
  enrollment) is actually about the student being deleted.
- **Why:** because the flat table never separated "facts about a
  course" from "facts about one specific enrollment." A course's
  identity has nowhere else to live except inside enrollment rows, so
  deleting the last enrollment for a course deletes the course too, by
  accident.

## Task 3: Concurrent-Edit Race

- Whichever partner saves/shares second overwrites the first save
  completely — spreadsheets and plain files have no built-in merge; a
  full-file save replaces the entire previous version.
- The partner whose change "won" typically sees only their own edit
  and has no reason to suspect anything happened; the partner whose
  change was overwritten sees the file looking untouched from their
  last save and has no signal that a conflict occurred, until they
  happen to reopen the file and compare by eye.
- Model answer accepts any writeup describing this asymmetry: the
  losing edit vanishes silently, with no error, no warning, no log.

## Reflection

"Just be more careful" does not fix any of the above because none of
these three problems were caused by carelessness — they are structural
consequences of one flat file with no rules enforcing consistency,
no separation between different kinds of facts, and no mechanism for
detecting simultaneous edits. A more careful typist still cannot fix a
deletion anomaly baked into the file's shape, nor can politeness alone
prevent two people's saves from racing.
