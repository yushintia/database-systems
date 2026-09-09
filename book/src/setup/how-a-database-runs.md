# How a Database Runs

This page gives you a **mental model**: a short, accurate picture of
what actually happens between typing a SQL statement and seeing a
result. You do not need to memorize this; you need to *believe it*,
because it explains a lot of things that would otherwise seem like
magic — including some of the errors in
[Appendix: Troubleshooting MySQL](../appendix/troubleshooting-mysql.md).

---

## The Big Picture: Client, Server, Storage

<svg role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 140" style="max-width:660px;display:block;margin:1.5em auto;">
  <title>Diagram showing a client, either MySQL Workbench or the mysql command-line tool, sending a SQL query over a connection to the mysqld server process, which reads and writes data files on disk, and sends a result set back to the client</title>
  <defs>
    <marker id="arr-db" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L0,6 L8,3 z" fill="#0b3d66"/>
    </marker>
    <marker id="arr-db-rev" markerWidth="8" markerHeight="8" refX="2" refY="3" orient="auto">
      <path d="M8,0 L8,6 L0,3 z" fill="#2e7d32"/>
    </marker>
  </defs>
  <!-- Client box -->
  <rect x="10" y="30" width="160" height="80" rx="8" fill="#eef4fa" stroke="#0b3d66" stroke-width="1.5"/>
  <text x="90" y="55" font-family="sans-serif" font-size="12" font-weight="bold" fill="#0b3d66" text-anchor="middle">Client</text>
  <text x="90" y="72" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">Workbench or</text>
  <text x="90" y="86" font-family="monospace" font-size="10" fill="#555" text-anchor="middle">mysql CLI</text>
  <text x="90" y="100" font-family="sans-serif" font-size="9" fill="#888" text-anchor="middle">(you type here)</text>
  <!-- arrow: query -->
  <line x1="170" y1="58" x2="248" y2="58" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-db)"/>
  <text x="209" y="48" font-family="sans-serif" font-size="9" fill="#0b3d66" text-anchor="middle">SQL query</text>
  <!-- arrow: result -->
  <line x1="248" y1="82" x2="170" y2="82" stroke="#2e7d32" stroke-width="2" marker-end="url(#arr-db-rev)"/>
  <text x="209" y="98" font-family="sans-serif" font-size="9" fill="#2e7d32" text-anchor="middle">result set</text>
  <!-- Server box -->
  <rect x="250" y="20" width="180" height="100" rx="8" fill="#fff8e6" stroke="#c07000" stroke-width="1.5"/>
  <text x="340" y="42" font-family="monospace" font-size="12" font-weight="bold" fill="#c07000" text-anchor="middle">mysqld</text>
  <text x="340" y="60" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">server process</text>
  <text x="340" y="76" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">parse → plan →</text>
  <text x="340" y="90" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">execute</text>
  <text x="340" y="106" font-family="sans-serif" font-size="9" fill="#888" text-anchor="middle">(always running)</text>
  <!-- arrow: disk read/write -->
  <line x1="430" y1="50" x2="508" y2="50" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-db)"/>
  <line x1="508" y1="90" x2="430" y2="90" stroke="#0b3d66" stroke-width="2" marker-end="url(#arr-db-rev)"/>
  <text x="469" y="40" font-family="sans-serif" font-size="9" fill="#0b3d66" text-anchor="middle">read/write</text>
  <!-- Storage box -->
  <rect x="510" y="20" width="160" height="100" rx="8" fill="#e8f5e9" stroke="#2e7d32" stroke-width="1.5"/>
  <text x="590" y="42" font-family="sans-serif" font-size="12" font-weight="bold" fill="#2e7d32" text-anchor="middle">Storage</text>
  <text x="590" y="60" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">files on disk</text>
  <text x="590" y="76" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">tables, indexes,</text>
  <text x="590" y="90" font-family="sans-serif" font-size="10" fill="#555" text-anchor="middle">logs</text>
  <text x="590" y="106" font-family="sans-serif" font-size="9" fill="#888" text-anchor="middle">(survives restarts)</text>
</svg>
<p style="text-align:center;font-size:0.9em;color:#555;margin-top:-0.6em;"><em><strong>Figure S.1.</strong> A query's round trip: client, server, and storage.</em></p>

Three parts: **client, server, storage.** You only ever touch the
client. The server does all the real work, and only the server
touches the storage files directly.

---

## The Client: What You Actually Use

The **client** is whatever program you type SQL into: MySQL Workbench
with its query editor, or the `mysql` command-line tool. The client's
job is small: take the text you typed, send it over a connection to
the server, wait, and display whatever comes back — usually a result
grid, sometimes just a success message like "3 rows affected".

The client does **not** store your data and does **not** understand
SQL by itself. Close Workbench, and your database is completely
unaffected — it is the server, not the client, that has to keep
running for your data to exist.

---

## The Server: `mysqld`

The **server** is a separate program, `mysqld` ("MySQL daemon"),
that starts when your computer boots (or when you start the MySQL
service) and keeps running quietly in the background, whether or not
Workbench is open. It listens on a network port (`3306` by default)
for connections from clients.

> **In plain words: daemon**
> A daemon is a program that runs in the background, with no window
> of its own, waiting to respond to requests. `mysqld` is a daemon:
> it just sits there listening until a client connects and sends it
> something to do.

Every client, whether it is Workbench on your laptop, the `mysql` CLI,
or (later in your career) a website's backend code, talks to the
*same* server the *same* way: open a connection, send SQL text,
receive a result. This is why the SQL you type in Workbench this
semester is exactly the same SQL a real application would send.

---

## Where Data Actually Lives

This is the part that surprises people: **SQL does not show you the
data, it shows you a result computed from the data.** The actual bytes
live in files on disk, managed entirely by the server, in a format you
are not meant to open directly.

When you run:

```sql
SELECT * FROM Student;
```

the server does not simply "open a file and show it to you." It:

1. Reads the relevant data files (and, if one exists, a faster index
   structure) from disk.
2. Reconstructs the rows you asked for, in memory.
3. Sends *that* — a temporary, in-memory answer called a **result
   set** — back to your client.

If you edited those files yourself with a text editor while the
server is running, you would almost certainly corrupt the database.
This is one reason the client/server split exists: it forces every
change to go through the server, which enforces the rules (data
types, constraints, foreign keys) you will define starting in Lab 9.

---

## What Happens When You Run a Query

Every SQL statement you send goes through the same four stages inside
`mysqld`:

1. **Parse.** The server checks that your SQL is grammatically valid.
   A missing comma or a misspelled keyword fails here, before
   anything else happens — this is the source of `ERROR 1064`, covered
   in [Troubleshooting MySQL](../appendix/troubleshooting-mysql.md).
2. **Plan.** For anything beyond the simplest statement, there is more
   than one possible way to fetch the data (e.g., scan the whole
   table, or use an index). The server's *optimizer* picks what it
   believes is the fastest plan.
3. **Execute.** The server carries out the plan: reading rows,
   filtering them, joining them, sorting them, whatever the query
   asked for.
4. **Result set.** The final rows are packaged up and sent back to the
   client, which is the point where Workbench draws your results
   grid, or the `mysql` CLI prints a text table.

> **In plain words: result set**
> A result set is the answer to one query: a temporary table of rows
> and columns that exists only for you to look at. It is not saved
> anywhere unless you explicitly save or export it. Run the same
> query again, and the server builds a fresh result set from
> whatever the current data is.

---

## Why This Matters Later

- **Lost connection errors** (see
  [Troubleshooting MySQL](../appendix/troubleshooting-mysql.md)) happen
  when the client/server link breaks — the server itself may be
  completely fine.
- **`USE database_name;`** works because a connection remembers which
  schema you are "inside", the same way a terminal remembers your
  current folder — it changes what the server assumes when you refer
  to a table without spelling out its full schema name.
- **Re-running a seed script** (the `DROP DATABASE IF EXISTS ...`
  pattern from [Setup: MySQL & Workbench](mysql-workbench.md)) works
  cleanly precisely because storage is entirely the server's
  responsibility — you never have leftover files lying around outside
  its control.

---

## Key Vocabulary

| Term | Meaning |
|---|---|
| Client | The program you type SQL into (Workbench, `mysql` CLI) |
| Server (`mysqld`) | The background process that stores data and runs queries |
| Connection | A live link between one client and the server |
| Result set | The rows and columns sent back as the answer to one query |
| Parse | Checking that SQL is grammatically valid |
| Plan | The optimizer's chosen strategy for executing a query |
| Execute | Actually reading, filtering, and combining rows |
