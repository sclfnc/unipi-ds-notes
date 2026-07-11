# MSc Data Science lecture notes, University of Pisa

Typeset lecture notes for the **MSc in Data Science & Business Informatics**,
University of Pisa. This is the root of the collection: each course is a
self-contained LaTeX project, published as its own repository, and shares one
house style. The courses span three academic years, from 2024/25 to 2026/27, and
are at different stages of completion (see the table below).

> ⚠️ **Disclaimer.** These notes are open educational content created by a
> student. They are **not an academic source** and may contain inaccuracies. You
> may freely share, modify, and reuse this material for educational and
> non-commercial purposes with appropriate attribution. The content is a personal
> interpretation of the professors' course materials and should not replace
> official teaching resources. I assume no responsibility for any errors or
> misinterpretations.
>
> The notes were produced with an **AI-in-the-middle** workflow: a first human
> pass, then **Claude Code** to support formulation, understanding, and
> rewriting, followed by a final human review.
>
> If you find errors, have suggestions, or spot unintentionally included
> copyrighted material (which I will promptly remove on notification), contact me
> at `sclfnc@proton.me`.

## Courses

Ten courses, each a standalone LaTeX project with its own `README.md`, compilable
and clonable on its own. Status: ✅ done · 🚧 in progress · 📝 to do.

| Folder | Course | Academic year | Status |
|--------|--------|:-------------:|:------:|
| [`dm-notes`](https://github.com/sclfnc/dm-notes) | Data Mining | 2024/25 | ✅ |
| [`o4ds-notes`](https://github.com/sclfnc/o4ds-notes) | Optimization for Data Science | 2024/25 | ✅ |
| [`sds-notes`](https://github.com/sclfnc/sds-notes) | Statistics for Data Science | 2024/25 | ✅ |
| [`sna-notes`](https://github.com/sclfnc/sna-notes) | Social Network Analysis | 2024/25 | ✅ |
| [`lds-notes`](https://github.com/sclfnc/lds-notes) | Laboratory of Data Science | 2025/26 | ✅ |
| [`lids-notes`](https://github.com/sclfnc/lids-notes) | Legal Issues in Data Science | 2025/26 | ✅ |
| [`bpm-notes`](https://github.com/sclfnc/bpm-notes) | Business Process Modeling | 2025/26 | 🚧 |
| [`mddmm-notes`](https://github.com/sclfnc/mddmm-notes) | Model-Driven Decision-Making Methods | 2025/26 | 🚧 |
| [`aif-notes`](https://github.com/sclfnc/aif-notes) | Artificial Intelligence Fundamentals | 2026/27 | 📝 |
| [`alcna-notes`](https://github.com/sclfnc/alcna-notes) | Advanced Laboratory of Complex Network Analysis | 2026/27 | 📝 |

## Shared house style

Every course uses one house style. Three files are byte-identical across the
whole collection, and this root holds their canonical copy:

- `main.tex`: the entry point of a course. It only loads the shared preamble and
  the course file; it carries no content of its own.
- `src/housestyle.tex`: geometry, colors, section and ToC formatting, running
  heads, and the math environments (theorem, definition, and the like).
- `src/common-preamble.tex`: the shared package set.

Each course additionally carries its own `src/course.tex` (title metadata, math
macros, boxes, `hyperref`/`cleveref`, bibliography, and the `\input{sec/...}`
list), plus `sec/` (the body), and, where the notes have diagrams, `img/`.

The copies in the root are the source of truth. When a shared file changes, it is
edited here and propagated to the courses by hand; the copies are kept identical
(verified by comparing checksums), not linked. The root `main.tex` is a template,
not a document: it does not compile on its own, because it expects a per-course
`src/course.tex` that lives in each course, not here.

## Working notes and authoring skills

Two more things live in this root and describe *how* the notes are written, not
the notes themselves. They apply across the whole collection and are tracked only
here (each course ignores them):

- `CLAUDE.md`: the working agreement followed while authoring, in English. It
  fixes the register (a formal teaching voice for a CS reader), the priorities
  (precision, then clarity, then detail, then coherence), the build and revision
  workflow, and the layout and commit conventions the courses share. It is
  written for an AI-assisted workflow but reads as a plain style-and-process
  guide.
- `.claude/skills/`: five authoring standards, each a self-contained `SKILL.md`.
  `notes-writing` is the prose and revision standard (cadence, banned words, the
  no-em-dash rule, the `%`-comment revision method); `tex-standard` is the LaTeX
  and typography standard (math delimiters, theorem environments, tables,
  figures, cross-references); `notation-check` verifies symbols and terms against
  a course's notation lock; `figure-verify` checks a figure's claims (a net's
  firings, node and edge counts, an optimum) before it is trusted or drawn;
  `new-course` scaffolds a conformant course folder. Each states the rule
  independently of any single course.

## Build a course

Build any course from its own folder root:

```bash
cd o4ds-notes
latexmk main.tex
```

`latexmk` runs pdflatex (and Biber, where a course uses it) as many times as
needed, writes auxiliaries to `build/`, and leaves `main.pdf` in the folder root.
Each course's `README.md` gives the by-hand fallback and notes any per-course
quirk. A standard TeX Live installation is enough; alternatively, upload a course
folder to [Overleaf](https://www.overleaf.com) and set its `main.tex` as the main
document.

## Credits

Written by **Francesco Secoli**, revised with the help of
[Claude Code](https://claude.com/claude-code): the course slides and lectures
were transcribed and refined into LaTeX, then reworked into standalone notes.
Based on the MSc in Data Science & Business Informatics, University of Pisa
(a.y. 2024/25 and 2025/26, per course). Contributions welcome: open an issue or a
pull request on the relevant course repository.
