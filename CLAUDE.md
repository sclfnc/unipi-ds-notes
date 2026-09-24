# Study notes: how we work

The user's university lecture-notes collection (MSc Data Science and Business Informatics, Università di Pisa): one folder per course, each published as its own git repository. Precedence: the global `CLAUDE.md` first, then a course's `CONVENTIONS.md` wherever it speaks about that course, then this file. Courses carry no `CLAUDE.md` of their own, and none gets created. The one exception is `mddmm-notes/CLAUDE.md`, git-ignored and kept on purpose for opening that folder alone: leave it.

## Before touching a course

**Read the course `README.md` first.** Standardized and public-facing: what the course is, its layout, how to build it. The layout is shared by every course: `main.tex` in the folder root (byte-identical across courses, it loads the shared preamble and the course file and nothing else), the shared preamble in `src/` (`housestyle.tex`, `common-preamble.tex`, `course.tex`), section files in `sec/`. The README carries the by-hand build fallback and any per-course quirk.

**Then any `CONVENTIONS.md`.** None exists today; a course may add one for build owner, notes voice, terminology lock, content map, LaTeX conventions.

**Course status.** `aif-notes` (a.y. 2026/27, in progress): the optional project is on hold until the lecturer's dedicated project lecture, so for now the exam is the oral alone and the notes cover every topic at exam depth; project material stays out of `sec/`. Ask whether the decision stands after that lecture. Its `MAP.md` tracks sections, drafts, and the audit of the third-party notes in `extra/`.

## Skills

Three skills, one home per rule. `academic-writing` (user-level, `~/.claude/skills/`) owns the exposition: the reader, the order of a concept's introduction, results and arguments, formulas in sentences, notation, examples, what earns its place. `global-english` (user-level) owns the language: word, sentence, paragraph, emphasis, punctuation, filler, em-dashes. `tex-standard` (`.claude/skills/`) owns the typesetting: theorem-like environments, math delimiters, display labels and `\cref`, TikZ figures in `img/`, booktabs tables, algorithms, listings, escaping, label prefixes. Read the relevant ones before writing or reviewing, in that order.

One rule the skills leave to this repo: **`%`-comments carry the audit trail.** A span header gives provenance (`% ── slides L3 p.12–18 ──`); a fixed clear error gets `% Fixed YYYY-MM-DD: <old> → <new>`; a doubtful claim is flagged in a comment and raised, never rewritten alone.

**Typesetting decisions of 2026-09-24**, now in `tex-standard`: `\cref` prints each environment's own name through per-environment aliases in `course.tex` (never "Result N"); emphasis has two channels, `\textbf` for a term's first appearance and `\emph` for contrast; the label prefixes are `def:`, `ex:`, `rem:`, `asm:`, `thm:`, `alg:`, `tab:`, `fig:`, `eq:`, `sec:`, and every theorem-like environment and float is labelled, displays only when cited; proofs use amsthm's `proof` environment. Finished courses keep their documented conventions (`mddmm-notes`).

**Keep them current.** A request that diverges from a skill, or that carries a rule a skill should encode, gets named rather than silently obeyed: ask whether to update the skill. A one-off stays one-off; a durable rule belongs in the skill so it holds next time.

## Repository layout

**One monorepo, the courses as submodules.** `sclfnc/unipi-ds-notes` pins each course, and each course is a public repo under `github.com/sclfnc/...` that clones on its own; `git clone --recursive` brings the collection down together. The root also holds the canonical copies of the shared files (`main.tex`, `src/housestyle.tex`, `src/common-preamble.tex`, `.latexmkrc`, `src/gitignore-canonical`) plus `CLAUDE.md` and `.claude/skills/`, the last two root-only and git-ignored in every course. A shared file changes in the root copy and is propagated to the submodules by hand: there is no sync script, and the copies stay identical, except the `$jobname` line each course adds to its `.latexmkrc` and the course's own lines at the end of its `.gitignore`.

**Acting outward is irreversible.** Submodule wiring, creating or renaming a repo, pushing: each runs on an explicit, current go-ahead, never on the strength of this note.

**Heavy material is ignored by subfolder, never by `src/`.** A course may keep recordings or slides under its own `src/`, next to the shared preambles. Its `.gitignore` ignores those subfolders alone (`src/rec/`, `src/slides/`); one that ignores `src/` wholesale drops the tracked preambles from the repo on the next push, so fix it when you see it.

## Working

**Build after a substantive edit.** From the folder root, with `latexmk`: the PDF `<folder>.pdf` (tracked) and every auxiliary (git-ignored) land in the folder root, and there is no `build/` directory. Check for *new* errors and warnings, and inspect the changed pages before reporting done. A course that reserves compiling and visual inspection for the user says so in its `README` or `CONVENTIONS.md`, and that wins.

**Commits, when git is asked for at all.** Conventional Commits: `type(scope): summary`, English, imperative, at most 72 chars, no trailing period. Types are `feat`, `fix`, `docs`, `refactor`, `build`, `chore`. The scope names the area touched (`sec`, `readme`, `build`, `notation`, or a course slug like `bpm`) and is omitted when the change is collection-wide. A body only when the why is not obvious from the summary. Every commit ends with the trailer `Co-Authored-By: Claude <noreply@anthropic.com>`, model-agnostic by design. One logical change per commit.

**Keep the course map current.** A course may keep a `MAP.md` in its root, git-ignored: the plan with the status of each section, the notation lock, and one entry per section (what it defines, its labels, what it omits on purpose, what is open). Read it before planning or reorganizing, instead of the `.tex` files; an edit to a section is done only when its entry is updated in the same step.

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
