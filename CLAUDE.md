# Study notes: how we work

The user's university lecture-notes collection (MSc Data Science and Business Informatics, Università di Pisa): one folder per course, each published as its own git repository. Precedence: the global `CLAUDE.md` first, then a course's `CONVENTIONS.md` wherever it speaks about that course, then this file. Courses carry no `CLAUDE.md` of their own, and none gets created.

## Before touching a course

**Read the course `README.md` first.** Standardized and public-facing: what the course is, its layout, how to build it. The layout is shared by every course: `main.tex` in the folder root (byte-identical across courses, it loads the shared preamble and the course file and nothing else), the shared preamble in `src/` (`housestyle.tex`, `common-preamble.tex`, `course.tex`), section files in `sec/`. The README carries the by-hand build fallback and any per-course quirk.

**Then any `CONVENTIONS.md`.** A few courses have one: build owner, notes voice, terminology lock, content map, LaTeX conventions.

## Skills

The detailed standards live in `.claude/skills/`, shared across all courses, so this file stays about how we work. All auto-trigger except `new-course`, which is invoked by hand.

- **`notes-writing`**: prose and revision standard. Banned words and openers, cadence and voice, the no-em-dash rule, the `%`-comment method, how to triage what you find. Read before writing or reviewing note prose.
- **`tex-standard`**: LaTeX and typography standard. Theorem-like environments, math delimiters, display labels and `\cref`, TikZ figures in `img/`, booktabs tables, algorithms, listings, escaping, label prefixes. Read before typesetting.
- **`notation-check`**: symbols and terms against a course's NOTATION lock.
- **`figure-verify`**: a figure's claims against the prose, before it is trusted or drawn.
- **`new-course`**: scaffold a conformant course folder.

**Keep them current.** A request that diverges from a skill, or that carries a rule a skill should encode, gets named rather than silently obeyed: ask whether to update the skill. A one-off stays one-off; a durable rule belongs in the skill so it holds next time.

## Repository layout

**One monorepo, the courses as submodules.** `sclfnc/unipi-ds-notes` pins each course, and each course is a public repo under `github.com/sclfnc/...` that clones on its own; `git clone --recursive` brings the collection down together. The root also holds the canonical copies of the shared files (`main.tex`, `src/housestyle.tex`, `src/common-preamble.tex`, `.latexmkrc`, `src/gitignore-canonical`) plus `CLAUDE.md` and `.claude/skills/`, the last two root-only and git-ignored in every course. A shared file changes in the root copy and is propagated to the submodules by hand: there is no sync script, and the copies stay identical.

**Acting outward is irreversible.** Submodule wiring, creating or renaming a repo, pushing: each runs on an explicit, current go-ahead, never on the strength of this note.

**Heavy material is ignored by subfolder, never by `src/`.** A course may keep recordings or slides under its own `src/`, next to the shared preambles. Its `.gitignore` ignores those subfolders alone (`src/rec/`, `src/slides/`); one that ignores `src/` wholesale drops the tracked preambles from the repo on the next push, so fix it when you see it.

## Working

**Build after a substantive edit.** From the folder root, with `latexmk`: the PDF `<folder>.pdf` and every auxiliary land in the folder root, git-ignored, and there is no `build/` directory. Check for *new* errors and warnings, and inspect the changed pages before reporting done. A course that reserves compiling and visual inspection for the user says so in its `README` or `CONVENTIONS.md`, and that wins.

**Commits, when git is asked for at all.** Conventional Commits: `type(scope): summary`, English, imperative, at most 72 chars, no trailing period. Types are `feat`, `fix`, `docs`, `refactor`, `build`, `chore`. The scope names the area touched (`sec`, `readme`, `build`, `notation`, or a course slug like `bpm`) and is omitted when the change is collection-wide. A body only when the why is not obvious from the summary. Every commit ends with the trailer `Co-Authored-By: Claude <noreply@anthropic.com>`, model-agnostic by design. One logical change per commit.

**Big audits.** Coverage and correctness sweeps fan out to sub-agents, around five at a time, and formal content is verified adversarially: state the claim, then try to refute it. Read the workflow journal, not the truncated notification.

**Context hygiene.** Heavy reads go to a sub-agent that returns the conclusion and not the files. Cite `file:line` instead of grepping broadly, filter command output, never dump a whole file. `/clear` between unrelated tasks, `/compact` at checkpoints.

**Reporting.** Delta only: what changed, what broke, what needs deciding. Cite `file:line` instead of describing where something sits.

## Priorities

In this order, when they compete:

1. **Precision**: formulas, definitions, claims exactly right. On doubtful math, consolidated theory wins.
2. **Clarity**: the reader is preparing for an exam, or reading standalone. Untangle the dense passage, add the missing derivation step, make each example prove its point.
3. **Detail**: expand what is too thin to stand alone, without padding.
4. **Coherence**: one terminology, one notation, one figure style.

Notes, docs, and code are written in English. Never import a concept the course skipped: deepen what is there.
