# Interview Transcript: Registrar's Office

Database Systems (511783-001), Lab 03 artifact.

**How to use this:** this is a lightly-edited transcript of a
conversation between a data modeler (the interviewer, "you") and the
head of the university's registrar's office. It is not organized for
you. Real requirements never arrive organized. Your job in the
Guided Exercises is to read it, then pull the entities, attributes,
and relationships out of it yourself, the same way you would on a
real job.

Read it once straight through. Then read it a second time with a
pencil, underlining every noun that might be an entity and every verb
that connects two of them.

---

**You:** Thanks for taking the time. Just to start broad — what does
your office actually need to keep track of?

**Registrar:** Everything about who's taking what, basically. We need
to know which students are enrolled in which classes, who's teaching
each class, what room it's in, and eventually, what grade each student
got.

**You:** Okay. When you say "class," do you mean the course, like
"CSE301, Database Systems," or do you mean a specific offering of it
this semester?

**Registrar:** Both, and that's actually where we get into trouble.
"CSE301" itself doesn't change — the course description, the code, the
title, that's fixed, it's in the catalog. But *this semester's*
CSE301 is taught by Professor Lee, in 성파 702, Monday afternoons.
Next semester it might be a completely different instructor, a
different room, maybe even a different time. We need to track both:
the course as a catalog entry, and each specific offering of it.

**You:** So the same course code can show up more than once, once per
semester, with different instructors or rooms attached?

**Registrar:** Exactly. And actually, sometimes the same course is
offered *twice in the same semester* — a morning section and an
afternoon section, different instructors, different rooms, same
course. We call those "sections." One course, many sections.

**You:** Got it — that's an important distinction. Let's talk about
instructors. What do you need to know about them?

**Registrar:** Name, mostly, for our purposes — an ID number
internally, and their name, so we can put it on the schedule. One
instructor can teach more than one section, sometimes more than one
course entirely, in the same semester. Professor Lee, for example,
teaches both CSE301 and a graduate seminar.

**You:** And can one section have more than one instructor — like a
team-taught class?

**Registrar:** Not currently. Every section has exactly one instructor
of record. I know some universities do team-teaching, we don't, at
least not yet. Please don't design something that *can't* handle it
later, but don't build it for a case that doesn't exist today either.

**You:** Understood — I'll keep it simple for now and just make a
note. Now, students. What do you track about them?

**Registrar:** Student ID, name, and major. And — this is the part
that actually gets me in trouble — the same student can enroll in
several sections in the same semester, and a section obviously has
many students. It's not one-to-one in either direction.

**You:** Right, so student and section are many-to-many. And that's
where a grade shows up — is the grade attached to the student, or to
the section, or to something else?

**Registrar:** Neither, really — it's attached to *this specific
student's enrollment in this specific section*. Kim Minji's grade in
CSE301, section 1, this semester, is a completely different fact from
Kim Minji's grade in some other section. It only makes sense once you
already know both the student and the section. On its own it's not
really "a thing."

**You:** That's a useful way to put it. So enrollment itself has its
own fact — the grade — that doesn't belong to student alone or section
alone.

**Registrar:** Right. And actually there's a wrinkle there too — a
student can be enrolled in a section with no grade yet, if the
semester isn't over. So the grade has to be allowed to be missing, at
least temporarily.

**You:** Okay, one more thing I want to ask about, because I heard you
mention it before we started recording — the waitlist?

**Registrar:** Oh, right, yes — that's the thing I actually came here
to ask about, the enrollment stuff you already mostly understand from
last semester's spreadsheet. Here's the new feature: sections have a
maximum capacity. Once a section is full, a student can ask to be put
on a waitlist for it instead. When a spot opens up — someone drops —
the *first* student on that section's waitlist gets offered the seat.

**You:** So the waitlist needs to track order — who's first, who's
second?

**Registrar:** Yes, that's the whole point of it. If we can't tell who
was waiting longest, students complain, loudly, and honestly they're
right to. We had one department try to run this by hand last year with
a shared spreadsheet and it was a disaster — two staff members
offered the same open seat to two different students on the same
afternoon, because neither could see what the other had just typed.

**You:** That's a great, concrete example, thank you — it's basically
last semester's whole spreadsheet problem happening again, one level
up. Can a student be on the waitlist for a section they're already
enrolled in?

**Registrar:** No — that wouldn't make sense. And actually, can a
student be on the waitlist for more than one section at once? Yes,
that's fine and normal. Just not for a section they're already sitting
in.

**You:** Understood. Is there a limit on waitlist size?

**Registrar:** Not that we enforce today, no. Some sections have a
long waitlist, some have none.

**You:** Last question — rooms. Do you need to track a room as its own
thing — capacity, building, equipment — or is it just a label on a
section for now?

**Registrar:** Just a label for now, honestly. "성파 702." We don't
currently need to know the room's capacity or what building it's in as
a separate concern — although if you ask me again next year I might
have a different answer, once we start double-booking rooms by
accident.

**You:** That's really helpful — I think I have what I need to start
sketching this out. Thank you.

**Registrar:** Thank you — just, please, don't let two people overwrite
each other's waitlist entries again. That's the whole ask.

---

**A note for Lab 03:** this transcript deliberately does not use the
words "entity," "attribute," "relationship," or "cardinality" anywhere
above — that is your job to add, in `lab03_model.md`. Real
stakeholders describe their world in plain language, not in the
vocabulary you're about to apply to it.
