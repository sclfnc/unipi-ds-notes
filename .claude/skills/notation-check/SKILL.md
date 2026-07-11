---
name: notation-check
description: >-
  Check symbol and terminology consistency in a course's .tex notes against its
  NOTATION block (the terminology lock). Use when reviewing a section for
  correctness or coherence, when a symbol looks reused or drifted, when asked
  "is this symbol already defined / consistent", before finalizing an edit that
  touches notation, or when merging/moving math between sections. Verifies every
  symbol is registered, none is overloaded in one scope, and every cross-ref
  resolves. Read tex-standard for the underlying LaTeX conventions.
---

# Notation and terminology check

Verify that a section's symbols, defined terms, and cross-references are
internally consistent and agree with the course's frozen notation. This is a
correctness-and-coherence pass, deeper than a style read. Audit read-only first,
then act only on the safe, unambiguous fixes; flag the rest.

## When it applies

A course carries a **NOTATION block** (a `NOTATION.md` or an equivalent notation
section) that freezes symbols, names, and defined terms. Such a lock is rare: at
present one course carries one (`mddmm-notes/NOTATION.md`), and a course whose
`CONVENTIONS.md` is only a content map plus LaTeX conventions does not count as a
symbol lock. If the target course has no lock, check internal consistency of the
section against itself and against neighbouring sections, and flag that no lock
exists.

## The four checks, in order

Read the target section together with its NOTATION block and any ledger row that
records which section owns which concept.

1. **Symbols.** Every symbol used is registered in NOTATION. No symbol carries
   two meanings in one scope, except documented reuses. Orientation conventions
   hold (e.g. max-form LP; inner products as juxtaposition, if the course
   declares them). A drifted or unregistered symbol is reconciled and **registered
   in NOTATION in the same edit**, never left dangling. When a letter is reused,
   plain versus calligraphic (`\mathcal`) is a real disambiguator, not an accident
   (e.g. plain $B$ for a basis versus `\mathcal B` for a bundle sample): a
   plain/calligraphic swap is an overload bug, unless the lock documents the reuse
   as one variant, so verify against the lock before flagging. A section that an
   orientation convention binds may carry a header `%`-comment naming it (e.g.
   `% Convention (NOTATION.md): max-form, row representation`): check that the
   header matches the convention actually in force in the section and the lock's
   table, and flag a stale header as drift.
2. **Statements.** Definitions, theorem/lemma statements, and formulas are exact:
   hypotheses present; signs, ≤/≥, strict vs non-strict, indices, and quantifiers
   correct. Recompute every worked number to its stated result. On doubtful math,
   consolidated theory wins: flag it (§Flagging), don't rewrite the math alone.
3. **Reasoning.** Each step follows from the previous; no skipped "clearly";
   stated implications and equivalences actually hold; edge cases covered
   (degeneracy, unboundedness, infeasibility, empty sets, equality vs inequality,
   multiplier signs, relaxation direction).
4. **Coherence.** Each concept is explained once in its owner section and
   `\cref`-ed elsewhere; every `\cref`/`\eqref` resolves to the right target;
   figures match the text and the numbers they show; terminology agrees with
   neighbouring sections.

## Terminology lock

NOTATION is binding: symbols, names, and defined terms reproduce verbatim and are
never swapped for a synonym while "improving prose". The policy is asymmetric:
**freeze** the domain terms, **vary** only the connective and explanatory prose.
A genuinely ambiguous symbol is disambiguated with a qualifier ("the basis $B$
(the basic rows)"), not replaced. Register any new or drifted symbol in NOTATION
in the same edit that introduces it.

The lock covers **named results and defined terms**, not only symbols. A frozen
theorem name, lemma name, or defined term reproduces verbatim; a synonym or a
reworded named result is a lock violation, to fix and re-register, not a stylistic
choice.

## First-use mark

A key term is marked at its FIRST occurrence only; later mentions are plain. The
mark is `\emph` (the collection convention, consistent with tex-standard and
notes-writing) or `\textbf` for a term-defining first use. Flag a term marked
twice, or introduced plain and marked later.

## What to fix vs flag

- **Fix silently-safe items**: an unregistered symbol you can reconcile with
  certainty (register it), a broken `\cref` target, a first-use-mark slip, a
  drifted symbol with one obvious correct form. Leave a `%`-comment per the
  correction format (see the notes-writing skill).
- **Flag, don't fix**: doubtful math, a number that won't reproduce, a claim that
  contradicts theory, a symbol genuinely overloaded with no clear resolution, a
  structural change (section merge/split, renumber). Never edit a formula or
  number inside a touched span without an adjacent `%`-note.

## How to run it at scale

For a whole-course sweep, fan out sub-agents (~5 at a time), one per section,
each returning a typed list of issues with `file:line`: unregistered symbol,
overloaded symbol, unresolved cross-ref, non-reproducing number, first-use-mark
slip. Verify formal content adversarially: design the check, then try to refute
the section's claim. Read the workflow journal, not a truncated notification.
Report the backlog; edit only when asked.
