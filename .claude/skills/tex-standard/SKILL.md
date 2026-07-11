---
name: tex-standard
description: >-
  LaTeX and typography standard for the lecture-notes collection. Use whenever
  typesetting or editing the .tex of a course's notes: theorem-like
  environments, box-free callouts,
  display math with labels and \cref, figures in img/, booktabs tables,
  \emph emphasis, vector/operator notation, and footnote-based citations. States
  the target convention where courses have drifted. Pair with notes-writing for
  the prose.
---

# LaTeX and typography standard

The typesetting standard for the lecture notes; prose and revision are a separate
concern (see the `notes-writing` skill). Styles load through a chain: `main.tex`
inputs `src/housestyle.tex` (layout and the house math environments), then
`src/common-preamble.tex` (the package set), then `src/course.tex` (per-course
macros).

**Section files under `sec/` are body-only: never add packages, environments,
colors, or TikZ styles in a section file.** Layout is uniform across courses:
`main.tex` in the root, preamble in `src/`, sections in `sec/`. Build from the
folder root with `latexmk`: `.latexmkrc` sets `$out_dir='.'` so the PDF and all
auxiliaries land in the root (git-ignored), and `$jobname` names the PDF
`<folder>.pdf` (e.g. `o4ds-notes.pdf`). Unless a course reserves compiling for
the user.

Courses have drifted on several axes. Each rule states the **target** convention:
what to write new content in and migrate toward. Where the target marks existing
files as non-conforming, that is expected: flag them, migrate when asked, never
silently rewrite a whole section for style. A course `CONVENTIONS.md` overrides
this skill where it speaks.

## 1. Theorem-like environments

The house `definition`, `theorem`, `example`, `remark`, `lemma`, `proposition`,
`corollary` are **not** amsthm environments: they are the custom box-free run-in
environments defined in `src/housestyle.tex` on one shared `housethm` counter.
amsthm is loaded only for `proof`.

- **One counter, one cref name.** Every house theorem-like environment
  (definition, theorem, example, remark, ...) shares the single `housethm`
  counter and one shared cref name: `\cref` prints "Result N" for all of them,
  whatever the label prefix. The `def:`/`thm:`/... prefixes organize labels; they
  do not change the printed word.

- **Full names, never abbreviations**: `definition`, `theorem`, `example`,
  `remark`, `proof`, `corollary`. (`thm`/`lem`/`defn` short forms only where a
  course preamble defines them; don't introduce them elsewhere.)
- **Title via the optional argument** when the object has a name:
  `\begin{definition}[Workflow net]`.
- State a theorem in ≤2 lines; prove it as running prose, each step justified
  inline ("because $y\ge0$ and $Ax\le b$"). No bare "clearly". Close on an
  explicit clause, not a dangling equation.

## 2. Callouts (box-free)

The **box-free run-in headings** `definitionbox`, `examplebox`, `notebox` are
defined **per course** (e.g. o4ds's `course.tex` shows the pattern), not in the shared
preamble: `common-preamble.tex` deliberately leaves `notebox`/`examplebox` out
because they differ per course. The user dislikes boxes. Form:
`\begin{definitionbox}{Title}` (title mandatory). Use whichever callouts the
course's `course.tex` defines.

## 3. Math delimiters and display math

- **Inline math: `$...$` only.** Never `\(...\)`.
- **Anonymous (unnumbered) display: `\[...\]`.** Never `$$...$$`: it is plain-TeX,
  deprecated in LaTeX, and breaks the vertical spacing (`\abovedisplayskip` and
  the house `\parskip`/`\linespread` are ignored). Use `\[...\]`, its LaTeX-safe
  equivalent.
- **Numbered display: `equation`** (single) or `align`/`align*` (multi-line).
  Reach for a numbered environment whenever the formula is referenced or worth
  referencing; use `\[...\]` only for a genuinely throwaway display.
- **Label every non-trivial display** `\label{eq:slug}`; reference with `\cref`
  (or `\eqref` only where the bare number is wanted). Where a course has drifted
  from this, migrate it.
- Weave a display into its sentence as a grammatical object, not a detached
  formula the prose ignores.

## 4. Cross-references

- **`\cref` only. Never manual `\ref`**, and never hardcode the word: writing
  `Figure \ref{...}` (worse, bolded) is banned; `\cref{fig:...}` prints the word.
- **Label scheme `prefix:slug`**, prefix from `sec: ssec: eq: fig: tab: thm:
  def: alg:`. Consistent, lowercase slugs.

## 5. Figures

- **TikZ always lives in `img/fig_slug.tex`, never inline in a section body.** A
  TikZ figure is rendered as an image and belongs out of the main text flow: put
  the diagram in its own file under `img/` and `\input{img/fig_slug.tex}` from the
  section. No `tikzpicture` in a `sec/*.tex`. Where a course has inline TikZ, it
  is non-conforming: migrate it, don't rewrite in bulk for style.
- Each `img/fig_slug.tex` is a full `figure` float (float, `\caption`,
  `\label{fig:...}`) with its geometry verified in a header comment (see the
  figure-verify skill).
- Reference-style raster images: `\includegraphics[width=\linewidth]{img/...}`
  inside a `figure` float, scaled as `0.85\linewidth` when narrower. `\figwidth`
  is **not** a shared-preamble macro: use it only in a course whose own
  `course.tex` defines it, never as if it were collection-wide.
- The caption reads as a sentence.

## 6. Tables

Clean and minimal. The look is `booktabs` with horizontal rules only.

- **Three rules: `\toprule`, one `\midrule` under the header, `\bottomrule`.
  Nothing else.** Never `\hline`, never `\cline`, never a vertical rule (`|` in
  the column spec). Where a course still uses `\hline` or vertical rules, migrate
  it.
- **No row shading.** No `rowgray`/`rowcolors`/`\rowcolor` zebra striping (the
  old house habit, dropped). Header cells are bold; that is the only emphasis.
- Separate row groups with `\addlinespace`, not a rule.
- **Tighten the rows**: the collection default is `\arraystretch` 1.2
  (common-preamble). Override it to 1.08 with `\renewcommand{\arraystretch}{1.08}`
  inside the `table`/`tabular` scope of a section (the 1.2 default is too airy for
  a dense table); never inflate it to 1.5. Scoped to the table, this is a table
  setting, not a preamble change: expected and allowed.
- Wide tables use `tabularx` with the preamble's `L/C/R` column types (`X` for
  the flexible column). Every table has a `\caption` (a sentence) and a
  `\label{tab:...}`.
- **`\multicolumn` yes, `\multirow` never.** `\multirow` is banned: a vertically
  centred label drifts out of line when rows have unequal height (which they do
  once a cell wraps). `\multicolumn` is the normal tool for both spanning cases:
  - **Row group**: give the group a bold full-width heading row,
    `\multicolumn{k}{@{}l}{\textbf{Group}} \\`, then its rows below. If a column
    existed only to hold the group label, drop it: the heading row carries the
    name. **Close each group with a faint separator rule**, not just blank
    space: a thin light-gray full-width rule,
    `\arrayrulecolor{rulegray}\midrule[\lightrulewidth]\arrayrulecolor{black}`
    (needs `colortbl`, already in every course preamble). It delimits groups
    without the weight of an `\hline`. `\addlinespace` alone is fine only for a
    two-group table where the split is already obvious.
  - **Stacked header**: span a header cell with `\multicolumn{k}{c}{Group}` and
    group its sub-columns with `\cmidrule(lr){i-j}` underneath.
- `\cmidrule(lr)`/`(l)`/`(r)` under a stacked header is **the only allowed
  partial rule**; never a full `\hline` or a `\cline`.

## 7. Algorithms (pseudocode, not code)

The house standard is the `algorithmicx` family, loaded collection-wide
(`algorithm` + `algpseudocode`). For the layout, e.g. o4ds shows the pattern.

- Wrap `\begin{algorithmic}[1]` (the `[1]` numbers the lines) in an `algorithm`
  float. `\caption{Name (ABBR)}` then `\label{alg:Name}` right after it.
- **I/O via `\Require` / `\Ensure`**, never "Input:/Output:" text.
- Keyword macros: `\State`, `\For`/`\EndFor`, `\While`/`\EndWhile`,
  `\If`/`\Else`/`\EndIf`, `\Procedure`/`\EndProcedure`, `\Return`. Comments via
  `\Comment{...}`.
- **Label every algorithm** `\label{alg:...}` after the caption (many current
  ones lack it: add on touch) and reference with `\cref`.
- Not `algorithm2e`, not a plain enumerate "step 1 / step 2" list.

## 8. Code (runnable snippets)

Rare, and **course-specific, not a collection standard**: real code lives almost
only in a course or two (e.g. SQL, Python, XML, bash). Follow that course's model
when a course has code.

- `listings`, block `lstlisting`, with an explicit `language=` per block. No
  `minted`. No inline `\lstinline` for multi-line code.
- **A house `\lstset` already lives in `common-preamble`** (`frame=none`, rowgray
  background, `\ttfamily\footnotesize`). A course with real code overrides it in
  its own `course.tex`, after common-preamble, to set the fuller style
  (font, `frame`, colored `keywordstyle`/`stringstyle`/`commentstyle`). **Never
  re-declare listing style in a section file**, and don't repeat `basicstyle=` on
  every block: it belongs in the one course-level `\lstset`.
- A bare `lstlisting`/`verbatim` with no `language=` is off-standard.

## 9. Emphasis and quotes

- **`\emph` for semantic emphasis and for a key term's first-use mark.**
- **`\textbf` for the term-defining first use only**, not for scattering
  emphasis through a paragraph. Over-marking with `\textbf`+`\textit` while using
  zero `\emph` is the anti-pattern to avoid.
- **Quotes: LaTeX `` ``...'' ``, never straight `"..."` or pasted curly
  `“...”`/`”`.** Straight and curly quotes render wrong; where a course has them,
  fix on touch. Use quotes only for a real quotation or a scare-quoted term;
  prefer `\emph` for stress.

## 10. Escaping and special characters

Mechanical, and the source of live compile defects. Check these on every edit.

- **Escaping/quoting is the highest-value check on every edit.** Because
  `.latexmkrc` sets `$force_mode=1`, a bare `%` (or other content error) does
  **not** stop the build: the text is dropped silently and the PDF still
  compiles. A clean compile does not mean the source is clean, so these lints
  catch what the build won't.
- **Escape `\%`, `\&`, `\_`, `\#` in prose.** A bare `%` comments out the rest of
  the line and silently drops text: a real bug found in the wild (`100%`, `95%`).
- **No pasted ligature glyphs.** Copy-paste from a PDF drops `ﬁ`/`ﬂ`/`ﬃ`
  (U+FB0x) into the source; they read as `fi`/`fl` but are single corrupt
  characters. Replace with plain ASCII letters.
- **Accents.** UTF-8 accented letters are fine (`inputenc`/`utf8` is loaded);
  don't leave a name unaccented in a heading (`Barabasi` should be `Barabási`).
  An en-dash between two names is `--` (LaTeX), not the Unicode `–`.
- **`e.g.`/`i.e.`** take a following comma (`e.g.,` / `i.e.,`). Avoid informal
  abbreviations in formal notes: write "with respect to", "such that", "average"
  in prose, keep `w.r.t.`/`s.t.`/`avg` for tight math context only.

## 11. Cross-references and labels

- **`\cref`/`\Cref` only** (start of sentence: `\Cref`). Never bare `\ref`,
  `\autoref`, or a hardcoded "Figure 3". Where a course uses `\ref` or nothing,
  migrate it.
- **One label-prefix table**, lowercase `prefix:slug`:

  | Target | Prefix |
  |---|---|
  | section | `sec:` |
  | subsection | `sec:` (not `subsec:`/`ssec:`/`sssec:`) |
  | equation | `eq:` |
  | figure | `fig:` |
  | table | `tab:` |
  | theorem / lemma / … | `thm:` |
  | definition | `def:` (not `defn:`) |
  | algorithm | `alg:` |

  Where a course mixes `subsec:`/`ssec:`/`sssec:` or `def:`/`defn:`, converge on
  the table above. Note that for the house theorem-like environments the prefix
  is only a label-organizing convention: `def:` and `thm:` both resolve through
  the shared `housethm` counter, so `\cref` prints "Result N" either way (see
  §1). Pick the prefix that names the object; it will not change the printed word.

## 12. Numbers, units, and complexity

- **Percent is `\%`** (see §10). No `siunitx` in the collection; write a unit in
  prose with a normal space, no special macro.
- **Big-O: one form per course, `\mathcal{O}(\cdot)`** is the target. Where a
  course writes plain `O(`, migrate it. Defining a `\bigO` macro is a preamble
  (`src/`) change: propose it, don't add it silently.
- Don't invent digits; "about/roughly" when unsure (this is the prose rule, it
  applies to numbers in tables and captions too).

## 13. Build hygiene

After a substantive edit, recompile from the folder root (`latexmk`; `.latexmkrc`
sets `$out_dir='.'`, so the PDF `<folder>.pdf` and all auxiliaries land in the
root, git-ignored) unless the course reserves compiling for the user. Check for
*new* errors and warnings, and inspect the changed pages before reporting done.
Never leave `main.tex` broken.
