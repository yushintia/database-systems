# MySQL & Workbench Setup

Before you can run your first query, you need two things: a **MySQL
server** to store and manage your data, and a **client** to talk to
it. This course uses **MySQL Community Server 8.x** as the server and
**MySQL Workbench** as the primary client, with the `mysql` command-line
client as a lightweight alternative.

> **In plain words: client/server**
> The *server* (a program called `mysqld`) is the process that
> actually stores your data and answers questions about it. It keeps
> running quietly in the background. The *client* (Workbench, or the
> `mysql` command) is the program you actually look at and type into.
> When you click "Run" in Workbench, the client sends your SQL to the
> server over a connection, the server does the work, and sends the
> answer back. You never edit the data files directly; you always go
> through the server.

> **In plain words: connection**
> A connection is a live link between a client and a server, usually
> identified by a host (often `localhost`, meaning "this same
> computer"), a port (`3306` by default for MySQL), a username, and a
> password. Workbench saves connection details so you don't have to
> type them every time; think of it like a saved contact, not a new
> phone call each time.

> **In plain words: schema**
> In MySQL, "schema" and "database" mean the same thing — Workbench's
> left-hand sidebar literally calls the list of your databases
> "Schemas". A schema is a named container that holds tables, views,
> and other objects. This course's case study lives in one schema,
> and every lab's seed script starts by creating (or recreating) it.

---

## Windows

1. Go to <https://dev.mysql.com/downloads/installer/> and download
   **MySQL Installer for Windows** (the larger "bundle" file, not the
   web-installer, avoids re-downloading on a slow connection).
2. Run the installer. When asked to choose a setup type, choose
   **Developer Default** — this installs MySQL Server, MySQL
   Workbench, and MySQL Shell together.
3. Follow the prompts through the "Check Requirements" step, then
   click **Execute** to install the selected products.
4. On the **Type and Networking** step, leave the port at the default
   `3306` and leave "Config Type: Development Computer" selected.
5. On the **Authentication Method** step, choose the recommended
   option and click **Next**.
6. On the **Accounts and Roles** step, set a **root password**.
   **Write this password down somewhere safe** — you will need it
   every time you connect. This course does not require a strong,
   memorable password beyond that; just don't lose it.
7. Finish the wizard. It should also install and start MySQL as a
   Windows service automatically, so the server starts every time you
   log in.
8. Open **MySQL Workbench** from the Start menu. You should see a
   tile under "MySQL Connections" for "Local instance MySQL". Click
   it, enter the root password, and you should land on a query editor
   tab.

---

## macOS

1. Go to <https://dev.mysql.com/downloads/mysql/> and download the
   **DMG Archive** for macOS (choose the correct chip, Intel or Apple
   Silicon — check with **Apple menu → About This Mac**).
2. Open the downloaded `.dmg` and run the `.pkg` installer inside it.
   Follow the prompts.
3. Near the end, the installer shows a **temporary root password**
   in a dialog box. **Write it down immediately** — this dialog does
   not reappear. You will change this password on first connection.
4. Open **System Settings → MySQL** (the installer adds a MySQL pane)
   to confirm the server is running, or start it from there if it
   is stopped.
5. Go to <https://dev.mysql.com/downloads/workbench/> and download
   **MySQL Workbench** for macOS separately (the server installer on
   macOS does not bundle Workbench, unlike Windows). Open the `.dmg`
   and drag Workbench into **Applications**.
6. Open **MySQL Workbench**, click the "Local instance" connection
   tile, and log in with `root` and the temporary password from step
   3. Workbench will prompt you to set a new password — set one you
   will remember, and write it down.

---

## Linux (brief, for dual-boot / secondary setups)

Most students in this course use Windows or macOS as their primary
machine, so this section is intentionally short. If you dual-boot
Linux or prefer it, the general shape is the same on any distribution:
install the `mysql-server` (or `mysql-community-server`) package from
your distribution's repository or MySQL's own APT/YUM repository,
start and enable the service (commonly `sudo systemctl enable --now
mysqld` or `mysql`), run the included secure-installation script to
set a root password, and then either install MySQL Workbench from
your package manager or use the `mysql` command-line client described
below. Follow your distribution's official MySQL documentation for
exact package names, since these vary between distributions and
change over time.

---

## Verifying the Install

Whichever OS you used, confirm the server is actually running and
reachable before moving on.

**Using MySQL Workbench:**

1. Open Workbench and click your local connection.
2. In the query editor, type:
   ```sql
   SELECT 1;
   ```
3. Click the lightning-bolt **Execute** button (or press
   Ctrl+Enter / Cmd+Return).
4. You should see a small results grid appear below with one column
   and one row, showing the value `1`.

**Using the `mysql` command-line client** (installed alongside the
server on all platforms):

```bash
mysql --version
mysql -u root -p
```

The second command prompts for your root password and drops you into
a `mysql>` prompt. From there, the same `SELECT 1;` should print a
small text table with `1` in it.

---

## The Idempotent Seed-Script Pattern

Every lab in this course gives you a seed script that starts the same
way:

```sql
DROP DATABASE IF EXISTS registration_db;
CREATE DATABASE registration_db;
USE registration_db;
```

> **In plain words: idempotent**
> A script is *idempotent* if running it once, or running it ten
> times in a row, leaves you in exactly the same state. This matters
> because you will make mistakes while working through labs — typing
> the wrong `INSERT`, dropping the wrong table, testing a `DELETE`
> that goes further than you meant. Instead of trying to carefully
> undo each mistake by hand, you just re-run the seed script from the
> top and you are back to a known-good starting point.

Why it is written exactly this way, in this order:

- `DROP DATABASE IF EXISTS ...` removes any previous, possibly broken
  attempt. The `IF EXISTS` clause means this line does not error out
  the very first time you run it, when the database does not exist
  yet.
- `CREATE DATABASE ...` makes a clean, empty schema.
- `USE ...` tells the server "every statement after this line, until
  told otherwise, applies inside this schema" — without it, you would
  have to write the schema name in front of every table (e.g.
  `registration_db.Student`).

You will see this exact three-line header at the top of nearly every
`.sql` file this semester. When something goes wrong and you are not
sure what state your database is in, re-running the seed script is
almost always the right first move.

---

## Alternatives

| Tool | Best for | Notes |
|---|---|---|
| **MySQL Workbench** | This course's default | Free, official, GUI, visual schema diagrams, result grids. What labs and screenshots assume unless stated otherwise. |
| **`mysql` CLI client** | Quick checks, scripting, following along without a GUI | Installed automatically with the server on every OS. Every SQL statement in this book also works pasted directly into it. |
| **DBeaver** | Students who prefer a lighter, multi-database GUI | Free, cross-platform, works with MySQL and many other databases; not officially supported in this course but fully compatible with the SQL you will write. |
| **phpMyAdmin** | Web-based administration on a hosted server | Common on shared web hosting; not needed for this course's local setup. |

---

## Verify Checklist

Before Lab 9 (the first lab that touches real MySQL), confirm all
four items:

- [ ] `mysql --version` prints a version number in a terminal, **or**
      MySQL Workbench successfully connects to your local instance
- [ ] Running `SELECT 1;` in Workbench shows a result grid with the
      value `1`
- [ ] Running the same `SELECT 1;` in the `mysql` CLI prints a text
      table with `1`
- [ ] You know your root password and have written it down somewhere
      you will not lose

Once all four boxes are checked, you are ready for Lab 9.
