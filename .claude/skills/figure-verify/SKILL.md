---
name: figure-verify
description: >-
  Verify that a figure's claims match the prose and hold internally, before the
  figure is trusted or drawn. Use when adding, editing, or checking a TikZ figure,
  when asked to "draw a net/graph/diagram that…", when a figure's counts or labels
  might not match the text, or when auditing a section's figures. Per-type checks:
  replay a Petri net's firings, check node/edge counts and degrees, recompute an
  LP optimum, validate a branch-and-bound tree. Records the check in a header
  comment. Only code-drawn figures (TikZ) are structurally verifiable.
---

# Figure verification

Check a figure against what the text claims about it, and against itself, before
trusting or drawing it. A figure that asserts a fact (a reachable marking, a
node count, an optimal vertex, a pruned branch) is verified by reproducing that
fact, not by eyeballing the picture.

The notes already do this in places: some figures open with a
`% Geometry verified: …` header (coordinates, recomputed objective, invariant
checked); where a course keeps a figures appendix, it fixes the drawing
conventions and guarantees every net was replayed. Generalize that habit.

## What is verifiable

- **Code-drawn (TikZ)**: fully verifiable. Read the figure source wherever it
  lives and find the `tikzpicture` regardless of location: it may sit in an
  `img/*.tex` file (`\input` from the section, the conforming layout per
  tex-standard) or inline in the `sec/*.tex` body. Look in both; reproduce its
  claims.
- **Raster `\includegraphics`**: NOT structurally verifiable from code. At most,
  check the caption against the prose claim and that the filename/label matches.
  Say so; don't pretend a structural check ran.

## The verification loop

1. **Restate what the figure asserts.** Read the figure and the prose that refers
   to it. List the concrete claims: counts, coordinates, labels, a marking, an
   optimum, a set of pruned nodes.
2. **Reproduce each claim** with the per-type checklist below. Recompute numbers;
   replay dynamics; count nodes and arcs.
3. **Reconcile with the prose.** Every number the figure shows must match the
   number the text states. A mismatch is a real bug (a firing-count mismatch
   caught on replay is exactly the kind of error this step exists to catch).
4. **Record the check** in a header comment on the figure, matching whichever
   form the surrounding figures use. Two forms are accepted in the collection: an
   undated `% Geometry verified: <coords>, <objective recomputed>, <invariant>`
   (geometry / LP figures) and a dated `% Verified <date>: <net restated>,
   <firing replay>, <property checked>` (nets / replay figures). For a net, note
   the replayed firing sequence.
5. **Fix or flag.** A clear mismatch (wrong count, wrong arc) → fix and leave a
   correction comment (see the notes-writing skill). A claim you can't reproduce
   or that contradicts theory → flag it, don't quietly redraw.

## Per-type checklists

**Petri / workflow nets** (places, transitions, tokens, arcs).
- Bipartite: every arc is place↔transition, never place–place or trans–trans.
- Each transition's pre-set and post-set match the drawn arcs.
- **Replay the firing sequence** from the stated initial marking, tracking token
  counts per place; the reached markings match the text.
- Claimed properties (safe / bounded / sound / live / dead transition / proper
  completion) actually hold under replay.
- WF-net: unique source `i`, unique sink `o`, every node on an `i→o` path.

**BPMN / EPC diagrams** (tasks, gateways, events, flows).
- Each split gateway has a matching join of the same type; XOR split = exactly
  one outgoing taken, AND = all.
- One start event, at least one reachable end; no dangling flow object.
- Flow labels/durations (e.g. `A(10)`) match the metrics the prose computes.

**Occurrence / reachability graphs** (nodes = markings, arcs = firings).
- Every node is a reachable marking of the source net; every arc is one enabled
  firing.
- Node and arc counts match the text; no reachable marking is missing.

**LP / polytope geometry** (feasible region, level lines, objective, optimum).
- Every drawn vertex satisfies the constraints; the objective direction is
  perpendicular to the level lines (slope $-c_1/c_2$).
- The marked $x^*$ is the true optimum: recompute $c^\top x$ at all vertices.
- A cut separates the LP optimum while keeping every integer point; a cone is the
  nonnegative combination of the active-constraint normals.

**Branch-and-bound / DP / block trees** (nodes, edges, bounds, prune reasons).
- Bound monotonicity: for a minimisation, a child bound ≥ its parent.
- Each prune label is justified (bound ≥ incumbent, infeasible, or integral).
- **Incumbent updates are temporally consistent**: an incumbent used to prune a
  node was found at an earlier node.
- Branch-edge labels partition the domain (e.g. $x_2\le 1$ / $x_2\ge 2$).

**Piecewise-linear / cutting-plane plots** (affine pieces, kinks, minimiser).
- The model is the max/min of the listed affine pieces; kink x-coordinates are
  the pairwise intersections; the marked minimiser is correct; convexity or
  monotonicity holds as claimed.

**Graphs / networks / TSP subtours** (nodes, edges, degrees, cuts).
- Node, edge, and degree counts match the text; claimed cycles are
  vertex-disjoint; a cut $S$ / complement separates the tours as labelled.

**Architecture / pipeline / neural-net block diagrams** (labelled boxes, flows).
- Box labels match the prose components; flow direction matches the described
  dataflow; NN layer sizes (input/hidden/output) and weight indexing agree with
  the neuron formula.

## Shared TikZ styles

Where a course defines figure styles, use them, don't redefine. Where a course
defines bpmn styles (`bpmn event`, `bpmn task`, `bpmn gateway`, `bpmn flow`,
typically in `src/course.tex`), reuse them for Petri elements: places = event,
transitions = task with rounded corners = 0pt, arcs = flow; do not invent a
separate place/transition style. Some courses instead declare styles locally per
figure. Never add a course-wide TikZ style from a section file (styles live in
the preamble).

## Drawing a new figure on request

For a "draw a net/graph that…" request, verify BEFORE committing the drawing:
build the object, run the per-type checklist, confirm it has the asked-for
property, then draw it and record the check in the header comment. A minimal,
hand-reproducible figure beats an elaborate unverified one.
