#!/usr/bin/env node
// Converts materials/<week>/*.md (handout/worksheet/quiz) into standalone
// HTML pages under <outDir>/materials/<week>/, styled to match index.html,
// with a link back to that week's slide deck and to the course homepage.
// Usage: node scripts/build-materials.js [outDir]   (default: dist)
'use strict';

const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');

const COURSE_NAME = 'Database Systems (511783-001)';

const repoRoot = path.join(__dirname, '..');
const outDir = path.join(repoRoot, process.argv[2] || 'dist');
const materialsDir = path.join(repoRoot, 'materials');
const slidesDir = path.join(repoRoot, 'slides');

function weekLabel(week) {
  const m = week.match(/week(\d+)/i);
  return m ? `Week ${parseInt(m[1], 10)}` : week;
}

// The slide deck's filename is a topic slug (e.g. week02-performance-and-cost.md),
// not just "<week>-introduction.md" -- that pattern only happens to hold for Week 1.
// Find the actual deck file for this week instead of assuming the name.
function slideDeckHtmlName(week) {
  const files = fs.existsSync(slidesDir) ? fs.readdirSync(slidesDir) : [];
  const match = files.find((f) => f.startsWith(`${week}-`) && f.endsWith('.md'));
  return match ? match.replace(/\.md$/, '.html') : `${week}-introduction.html`;
}

function escapeHtml(s) {
  return String(s).replace(/[&<>"']/g, (c) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
  }[c]));
}

function renderPage({ title, week, body }) {
  const slideHref = `../../${slideDeckHtmlName(week)}`;
  return `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${escapeHtml(title)} — ${escapeHtml(COURSE_NAME)}</title>
<style>
  :root{ --navy:#242852; --brand:#4A66AC; --pale:#DCEAF0; --ink:#1A1A1A; }
  *{box-sizing:border-box;}
  body{margin:0;font-family:'Aptos','Calibri',system-ui,-apple-system,'Malgun Gothic',sans-serif;color:var(--ink);background:#F6F8FA;}
  header{background:var(--navy);color:#fff;padding:2rem 1.5rem;}
  header h1{margin:0 0 .3rem;font-family:Cambria,Georgia,'Noto Serif KR',serif;font-size:1.5rem;}
  header p{margin:0;opacity:.85;font-size:.9rem;}
  nav{max-width:820px;margin:0 auto;padding:.8rem 1.5rem 0;font-size:.85rem;}
  nav a{color:var(--brand);text-decoration:none;margin-right:1.2rem;}
  nav a:hover{text-decoration:underline;}
  main{max-width:820px;margin:1.5rem auto;padding:1.5rem 2rem 3rem;background:#fff;border:1px solid #D7E1E8;border-radius:8px;}
  main h1{font-family:Cambria,Georgia,'Noto Serif KR',serif;color:var(--navy);font-size:1.7rem;}
  main h2{font-family:Cambria,Georgia,'Noto Serif KR',serif;color:var(--brand);font-size:1.3rem;margin-top:2rem;}
  main h3{color:var(--navy);font-size:1.1rem;}
  main table{border-collapse:collapse;width:100%;margin:1rem 0;}
  main th,main td{border:1px solid var(--pale);padding:.5rem .7rem;text-align:left;}
  main th{background:var(--pale);}
  main pre{background:#F4F7FB;border-left:4px solid var(--brand);padding:.8rem 1rem;overflow-x:auto;border-radius:4px;}
  main code{background:var(--pale);padding:.1rem .3rem;border-radius:3px;}
  main pre code{background:none;padding:0;}
  main blockquote{border-left:4px solid #D98E3B;background:#FFF6E8;margin:1rem 0;padding:.6rem 1rem;color:#0B3954;}
  main hr{border:none;border-top:1px solid var(--pale);margin:2rem 0;}
  footer{max-width:820px;margin:0 auto;padding:0 1.5rem 3rem;color:#5B6B78;font-size:.8rem;}
</style>
</head>
<body>
<header>
  <h1>${escapeHtml(title)}</h1>
  <p>${escapeHtml(COURSE_NAME)}</p>
</header>
<nav>
  <a href="${slideHref}">&larr; Back to ${weekLabel(week)} slides</a>
  <a href="../../index.html">Home</a>
</nav>
<main>
${body}
</main>
<footer>Built from <code>materials/${week}/</code>.</footer>
</body>
</html>
`;
}

function main() {
  if (!fs.existsSync(materialsDir)) {
    console.log('No materials/ directory, nothing to build.');
    return;
  }

  const weeks = fs.readdirSync(materialsDir).filter((w) =>
    fs.statSync(path.join(materialsDir, w)).isDirectory());

  let count = 0;
  for (const week of weeks) {
    const weekDir = path.join(materialsDir, week);
    const files = fs.readdirSync(weekDir).filter((f) => f.endsWith('.md'));
    const destDir = path.join(outDir, 'materials', week);
    fs.mkdirSync(destDir, { recursive: true });

    for (const file of files) {
      const srcPath = path.join(weekDir, file);
      const md = fs.readFileSync(srcPath, 'utf8');
      const titleMatch = md.match(/^#\s+(.+)$/m);
      const title = titleMatch ? titleMatch[1].trim() : file;
      // Drop the leading H1 from the body: the page header already shows it.
      const bodyMd = titleMatch ? md.replace(titleMatch[0], '') : md;

      const html = execFileSync(
        'npx',
        ['--yes', 'marked', '--gfm'],
        { encoding: 'utf8', maxBuffer: 10 * 1024 * 1024, input: bodyMd },
      );

      const destPath = path.join(destDir, file.replace(/\.md$/, '.html'));
      fs.writeFileSync(destPath, renderPage({ title, week, body: html }));
      console.log(`Built ${path.relative(repoRoot, destPath)}`);
      count += 1;
    }
  }
  console.log(`Done: ${count} materials page(s) built to ${path.relative(repoRoot, outDir)}/materials/`);
}

main();
