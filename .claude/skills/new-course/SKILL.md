---
name: new-course
description: >-
  Scaffold a new course folder in the lecture-notes collection, conforming to the
  shared layout. Use when the user asks to start/create/bootstrap a new course,
  set up a new course repo, or fill an empty course folder (e.g. aif-notes).
  Copies the byte-identical main.tex and the shared src/ preamble from the
  collection root, writes a course.tex from the contract, and creates the
  empty sec/ scaffolding. Invoke explicitly (/new-course); it does not
  auto-trigger.
---

# Scaffold a new course

Create a new course folder that matches the collection's uniform layout so it
builds with `latexmk main.tex` out of the box. This is an explicit action: run it
when asked, not on your own inference that a course is "new".

## The target layout

Every course has the same shape:

```
<course>-notes/
  main.tex          byte-identical across all courses (do not diverge)
  .latexmkrc        latexmk config (copy, then edit its $jobname line)
  .gitignore        canonical (copy; ignores the root auxiliaries, .claude/, CLAUDE.md, *.md except README.md)
  README.md         standardized, public-facing (write per course)
  <course>-notes.pdf  compiled output (named via $jobname), in the folder root
  src/
    housestyle.tex     shared: geometry, colors, sections, ToC, math envs
    common-preamble.tex shared package set (identical across the collection)
    course.tex         course-specific: metadata, macros, boxes, tikz, bib
  sec/                section files, body-only (\input from course.tex)
  img/                figures (create when the first figure needs it)
```

latexmk writes the PDF and every auxiliary to the folder root (git-ignored via
the course `.gitignore`); there is no `build/` dir.

`main.tex`, `housestyle.tex`, `common-preamble.tex` are **copied unchanged** from
the collection root, which holds the canonical copies (with `.latexmkrc` and
`src/gitignore-canonical`); these three are the byte-identical trio. `.latexmkrc`
is copied then edited: the canonical copy carries no `$jobname`, and the new
course adds `$jobname = '<folder>'`. Only `course.tex`, `README.md`, and the
`sec/` files are course-specific.

**For anything not canonical, read the most recently scaffolded course, not the
oldest.** The newest scaffold carries the current conventions (lowercase `references.bib`,
`sec/_NN_slug.tex` naming with a leading underscore, the standard
callout/cleveref block). An older course may predate a convention; do not copy it
for that part. Where a course has drifted from a current convention, migrate it to
the convention rather than propagate the drift.

## The course.tex contract

`main.tex` `\input`s `src/course.tex` last, before `\begin{document}`. `course.tex`
MUST define, in the preamble:

- `\coursetitle`: full course name (title block and running use)
- `\coursesubtitle`: one-line topic list under the title
- `\courseyear`: e.g. `2025/2026`
- `\coursebody`: a macro expanding to the `\input{sec/...}` list (plus any
  `\part` / `\section` / `\appendix` / `\printbibliography`)

It MAY define course-specific packages, macros, boxes, tikz styles, `lstset`, its
own `\hypersetup` (with `pdftitle`), and a bibliography resource. `hyperref` and
`cleveref`, if used, load inside `course.tex` (it is read last).

## Steps

1. **Confirm the folder name and title** with the user (e.g. `aif-notes`,
   "Artificial Intelligence Fundamentals"). Don't guess the official course name.
2. **Copy the invariant files from the collection root**: `main.tex`,
   `src/housestyle.tex`, `src/common-preamble.tex`, unchanged. Verify `main.tex`
   is byte-identical afterward (its md5 must match the root's). Then copy
   `.latexmkrc` and add `$jobname = '<folder>-notes';`. Copy the canonical
   `.gitignore` from `src/gitignore-canonical`: it git-ignores the root-level
   auxiliaries, `.claude/`, `CLAUDE.md`, and `*.md` except `README.md`.
3. **Write `src/course.tex`**: define the four required macros; `\coursebody`
   starts empty or with a first `\input{sec/_01_...}`. Add `cleveref`/`hyperref`
   here if the course will use `\cref`. Where the real subtitle/topic list or
   academic year is unknown, write a plausible value and mark it with a
   `% PLACEHOLDER ...` comment for the user to confirm; never invent a value
   silently.
4. **Create `sec/`** with a first stub section file (body-only, no preamble),
   named `_NN_slug.tex` with the leading underscore.
5. **Write `README.md`** following the standardized public-facing form of the
   other courses: what the course is, the layout, and how to build
   (`latexmk main.tex` from the folder root, with the by-hand fallback). State
   that the folder is freshly scaffolded and fills in lecture by lecture, so a
   reader knows the notes are incomplete by design.
6. **Build once** (`latexmk main.tex` from the folder root) to confirm it
   compiles: title block, disclaimer, empty ToC, the stub section. It produces
   `<folder>-notes.pdf` (and the auxiliaries) in the folder root. Zero errors.

## Do not

- Do not diverge `main.tex` or the shared `src/` preambles from the collection.
- Do not create a GitHub repo, `git init`, run submodule wiring, or push: those
  are outward and irreversible, see `CLAUDE.md`.
- When seeding from a course that keeps recordings or slides under its own `src/`
  (e.g. `bpm-notes`, ~919 MB), copy the preamble trio alone: never that material,
  never its subfolder-specific ignore lines.
