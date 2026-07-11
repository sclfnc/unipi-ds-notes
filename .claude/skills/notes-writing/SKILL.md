---
name: notes-writing
description: >-
  Prose and revision standard for the lecture-notes collection. Use whenever
  writing, rewriting, tightening, or reviewing the English prose of a course's
  .tex notes: how to open a concept,
  cadence and voice, banned words and openers, the no-em-dash rule, and the
  %-comment revision method (correction comments, flag-don't-fix, provenance).
  Read this before editing note prose; pair it with tex-standard for the LaTeX.
---

# Notes writing and revision

The prose and revision standard for the lecture notes. LaTeX typesetting is a
separate concern: see the `tex-standard` skill. Notes are written in English for
a CS student with no prior background in the course topic. Formal definition
first, intuition after. Define notation on first use.

Some sections already follow these rules in full; they are the target every
draft is held to. Where a draft has drifted, bring it up to the standard, don't
lower the standard to it.

Course-specific rules live in a course's `CONVENTIONS.md` and override this skill
where they speak (voice, terminology lock, citation form). Where a course is
silent, this skill governs. On a real conflict, flag it, don't pick silently.

## 1. Hard rules (banned lists)

- **No em-dashes**, in either form: the LaTeX `---` and the literal Unicode `—`
  (U+2014). Replace with `:`, `;`, parentheses, or a comma per sense: closer to
  Italian usage. Never a spurious space before `:`/`;`. Exceptions (content, not
  prose, so they stay): a lone `---`/`—` as a table-cell "not applicable"
  placeholder, inside code/verbatim, or inside a `%`-comment (a correction,
  provenance, or header comment is not prose).
- **Banned openers**: "Notably / Importantly / Interestingly / It is worth
  noting / This section presents…". Open on the subject.
- **Banned filler**: *delve, leverage, crucial, pivotal, realm, tapestry,
  testament, seamless, comprehensive, underscore, showcase, foster, garner,
  myriad, plethora, robust*. The ban is on the vague-emphasis sense only: a word
  in its genuine technical sense is fine (*robust* statistics, a high-*leverage*
  point in regression diagnostics, a *pivotal* quantity in the bootstrap). Ban
  the word when it means nothing but emphasis; keep it when it names a defined
  object.
- **Never invent** numbers, citations, or quotes. "about/roughly" when unsure;
  flag hypotheticals.

## 2. Cadence and voice

- Verbs, not nominalizations. Active voice.
- Mix short sentences (5–10 words) with long ones (25–35); never three alike in
  a row. A deliberate short fragment lands a point ("Cost: nearly nothing.").
- A content word 3× in one paragraph: rewrite one occurrence.
- **The last sentence of a paragraph must advance, never restate**: end on the
  consequence, the payoff, or the next hook. Good: "reconnecting the two is
  exactly the job of process mining."
- "Furthermore/Moreover" only on a real logical link; transition on an actual
  turn ("Historically, however…"), not on a connective as filler. At most one
  causal connective per sentence: never stack "so… hence… because".
- **Voice is set per course, not here.** A course may be fully impersonal ("the
  relaxation gives a bound") or didactic yet near impersonal. Hold whatever the
  course picks: **one voice per document.** Don't mix "we", "you", "Let's" in one
  course.
- **Authorial "we" versus reader-addressing.** An authorial or mathematical
  "we" is allowed, especially in proofs ("we exhibit a path", "we are done"). The
  reader-addressing "you" and "Let's" stay out of formal notes unless a
  `CONVENTIONS.md` allows them. A course may go further and avoid even the
  authorial "we" (fully impersonal); hold whichever its `CONVENTIONS.md` sets.

## 3. Introducing a concept (the DO patterns)

Lifted from the strongest sections. Follow them.

- **Term as grammatical subject of its defining sentence, bold on first use.**
  "A **business process** is any set of steps…". Never open with "This/We will".
- **Formal object first, then a plain-English gloss after a colon.**
  "$\alpha\in(0,1)$: it lies inside no segment of $P$". Never symbols-only.
- **One physical or spatial analogy per concept, after the definition.** A Petri
  token is "the 'you are here' marker". One analogy, not three.
- **Bound an abstract term with a low/high example pair**: "from mundane
  administrative tasks… to complex operational flows".
- **You may open a structural section by naming how many parts follow**, then
  enumerate: "Four artefacts and their connections frame every process-mining
  technique."

## 4. Notation and terminology

- Introduce a symbol **inline at first use**, bound to its meaning right there
  ("$\bar y_j$ is the **shadow price** of resource $j$"). No front-loaded table.
- Expand an acronym in parentheses **once**, at first mention.
- **Bold (or `\emph`) the key term at its FIRST occurrence only**; plain
  thereafter. Italics stay for semantic emphasis (*best*), not for re-marking a
  term already introduced.
- Freeze domain terms; vary only connective and explanatory prose. A term in a
  course's terminology lock reproduces verbatim, never swapped for a synonym.
  Disambiguate an overloaded symbol with a qualifier ("the basis $B$ (the basic
  rows)"), don't rename it.

## 5. Lists versus prose

- **Parallel peers → `itemize`** with a bold lead-in and a colon.
- **Sequential or causal reasoning → prose.** Merge steps into a flowing
  paragraph. Don't fragment a process into `\paragraph{}` stubs or
  `\\`-separated one-liners.
- Merge over fragment: dissolve a short bullet list into prose when it reads
  better; merge paragraphs that restart on the same topic.

## 6. Revision method

Triage every issue you find: **fix / flag / name.**
- **Clear error** (wrong sign, mismatched symbol, broken step) → fix it, leave a
  correction comment (§6.1).
- **Substantive doubt** (the math may be wrong, a number won't reproduce, a
  claim contradicts theory) → flag it, raise it (§6.2). Don't rewrite math alone.
- **Scope/structure** (missing prerequisite, a concept the course skipped, a
  section that should split) → name it, don't act.

Never import concepts the course skipped. Deepen what is there.

### 6.1 Correction comments

When you fix a clear error, leave an auditable `%`-comment:

```
% Fixed YYYY-MM-DD: <what was wrong, quoting the old value> → <what you changed>.
% <what stayed untouched>.
```

- Use the **"X, not Y"** shape for value fixes: "the cycle has six states, not
  eight"; "corrected from 'two orders of magnitude': the factor is exactly $|J|$".
- **Cite the source** when the error is external: "suspected typo on the
  official slide"; "van der Aalst, Table 7.1".
- **Name what you preserved**: "Labels and topology unchanged."

### 6.2 Flag, don't fix

- **Doubtful math is flagged, never silently rewritten.** Leave a hedged
  `%`-comment ("suspected off-by-one, exam-relevant") and raise it. Never edit a
  formula or number inside a touched span without an adjacent note saying so.
- Reserve a bare `% TODO` for drafts. In a published section a flag is a hedged
  prose comment, not a raw TODO.

### 6.3 Provenance and structural moves

- **Provenance** as an inline span header `% ── slides p.X–p.Y ──`, or a
  file-header block (`% Provenance (historical): lectures 9.1, 9.2`). Keep it
  accurate; don't let it constrain prose; remove only when asked.
- **Justify a structural or terminology move inline**: `% Removed duplicate
  \label{...}`; `% renamed nodes to match visible labels`; `% Added: <why>`.
- Keep provenance correct when a block moves. Recheck every `\cref`/`\eqref`
  after a move.

### 6.4 What an edit must preserve

Smallest change that fixes the problem. Keep every concept, formula, example,
solver number, and reference: lose no content. Match surrounding style, symbols,
and the course's notation. Don't pad clear text; don't rewrite a paragraph when
two sentences do.
