# Expansion plan: from compact guide to full technical book

Planning date: 2026-09-06  
Source baseline: existing `src/book.html`, audited in
`depth-audit.md`  
Normative release: jj 0.44.0; comparison release: jj 0.45.1

## Size model

The pre-expansion manuscript was approximately 7,241 substantive words and
was independently rendered at 47 pages. The current manuscript is measured by
the project's single HTMLParser method (excluding `pre`, `script`, and
`style`) and is 102,796 substantive words; it has rendered to 510 pages,
including two contents pages after the pagination correction. The revised design target adopted
after the follow-up review is **100,000–130,000 substantive words** and
**450–600 Kindle-Scribe-sized PDF pages**, including front matter and contents.
The range is calibrated from the observed page density rather than treated as
a quota.

This is a substance target, not a padding target. The added words will be
spent on semantic explanations, graph evaluations, state transitions, option
interactions, fixture observations, failure cases, recovery, and reference
information. Raw help captures, inventories, scripts, licence ledgers, and
validation output do not count towards the target.

At the current density, the contents and diagram/table-heavy layout produce
roughly 210 substantive words per non-contents page. The final build reports
the exact count produced by the named method, the PDF page count, the contents
span, and the outline count. If pagination falls outside the range, the report
explains the typography/engine cause rather than padding or deleting technical
material.

## Reusable fixtures and continuity

The book will use named scenarios repeatedly instead of resetting to anonymous
linear examples:

1. **`rewrite-lab`** — an API patch stack with an early change, dependent
   changes, a fork, a merge, an empty change, and a deliberately conflicted
   successor. Used by Parts I–IV, IX, X, and XVI.
2. **`query-lab`** — a non-linear graph with bookmarks, remote bookmarks,
   tags, divergent change IDs, immutable heads, author metadata, and multiple
   heads. Used for every revset operator/function and template examples.
3. **`fileset-lab`** — a realistic source tree containing generated files,
   tests, documentation, symlinks, an executable, and nested directories. Used
   to evaluate filesets against actual command output.
4. **`github-lab`** — a bare remote plus two clones modelling fork/upstream
   and one-change and stacked-PR publication. Server/UI portions are marked
   server-dependent.
5. **`gerrit-lab`** — local Git transport fixtures for ref mechanics, plus
   documented server-dependent `refs/for`/review behaviour. It carries
   explicit jj and Gerrit identities through several patch sets.
6. **`recovery-lab`** — disposable repositories for wrong rewrite, abandon,
   bookmark movement, subsequent operations, evolution divergence, and
   operation inspection/recovery.
7. **`workspace-lab`** — development, build, review, and sparse workspaces,
   plus two independent clones for machine handoff.

Each fixture chapter will record the starting graph, exact commands, relevant
output/IDs, resulting graph, and whether the observation was verified in
0.44.0, 0.45.1, or is server-dependent.

## Part-by-Part expansion map

### Front matter and method — 3,000 words

Preserve the advanced-reader assumptions, version policy, print profile,
licensing discipline, and source ledger links. Add notation for
commit/change/bookmark/tag/workspace/operation IDs; evidence labels
(`verified`, `documented`, `server-dependent`); how to read a graph
transformation; how to read version callouts; reproducibility and output
conventions; and a map explaining teaching chapters versus lookup references.
Include one page of notation and one substantive 0.44/0.45 comparison.

### Part I — jj primer — approximately 3,000 words

The primer is now the first substantive part of the book. It assumes Git
expertise but no jj knowledge and no particular starting repository state. It
covers inspection of existing jj/Git/remote repositories, optional setup,
snapshotting, the everyday vocabulary, the first graph operations,
publication, conflicts, and basic operation-log recovery. Its purpose is to
make the later conceptual material readable without turning the book into a
beginner Git tutorial.

### Part II — The mental model — 10,000 words

Preserve detached-HEAD framing, commit/change IDs, mutable/immutable/
hidden/visible terminology, snapshot warning, `@`, and the comparison table.
Add chapters on repository state as a tuple; commit DAG and tree identity;
working-copy snapshot lifecycle; change evolution and divergence; visibility,
immutability, roots/heads; workspaces as local graph views; operation
boundaries; and Git analogy boundary tests.

Add non-linear graphs: a fork, merge, ancestor rewrite, divergent successors,
bookmarks into a stack, same-name remote bookmarks, and two workspaces sharing
commits but not `@`. Run experiments that edit files, compare normal versus
`--ignore-working-copy`, record IDs before/after rewrites, inspect `evolog`,
and compare operation entries. Depth goal: **explored**.

### Part III — Rewriting history — 14,000 words

Preserve source/destination framing, automatic descendant rebasing, and the
existing command distinctions. Add chapters on graph-preserving versus
graph-changing rewrites; edit/describe/metaedit/diffedit; squash and split;
absorb and duplicate; abandon, restore, and revert; rebase source selectors;
rebase destinations; patch-stack surgery; identity/evolution consequences; and
rewrite conflicts.

Show every rebase mode (`-r`, `-s`, `-b`), holes in selected sets,
insert-before/after, repeated destinations/merge, partial squash, split with a
descendant, ancestor rewrite with bookmark targets, and abandoned ancestor
reconnection. Run every major command in `rewrite-lab`, capturing `jj log`,
`jj evolog`, `jj op show`, and bookmark state. Depth goal: **explored**;
`rebase`, `squash`, `split`, `absorb`, `restore`, and `abandon`
receive substantially longer treatment.

### Part IV — Revsets — 25,000 words

Preserve values, symbols, cardinality, precedence, operators, function
inventory, aliases, patterns, and cookbook seeds. Add a formal lexical/
syntactic model; symbol resolution and quoting; precedence and parentheses;
set algebra; ancestry/descendant closures; range algebra; roots/heads/
reachability; refs and remote state; identity/metadata predicates; conflict/
mutability/visibility predicates; file predicates; aliases; command contracts;
algebraic derivation exercises; troubleshooting; and performance.

Every important public function receives a signature, argument type, result and
domain semantics, empty/multi-result behaviour, a simple example, a composed
example, an operational example, and a fixture check. Evaluate named sets
line by line for unions, intersections, difference, complement, `::`, `..`,
`x::y`, parents/children, roots/heads, `reachable`, `fork_point`,
`merge_point`, refs, divergence, conflicts, immutable/mutable, and file
predicates. Include ambiguous prefixes, zero/multiple revision errors,
precedence surprises, hidden lookup, remote ambiguity, invalid pattern/date,
alias recursion, and shell expansion. Depth goal: **explored** in the Part
and **reference-complete** in Appendix C.

### Part V — Filesets — 8,000 words

Preserve the three-language distinction, basic forms, quoting warning, and
consumer list. Add repository-relative paths; `cwd:`, `root:`, `file:`,
glob and prefix-glob forms; recursive matching; supported operators/functions;
fileset aliases; parser and quoting rules; path errors; and command contracts.

Evaluate every target syntax form against `fileset-lab`. Compare shell glob
expansion with jj parsing and show selections for diff, restore, squash, split,
fix, annotate/chmod/list/search/show/track/untrack. Depth goal: **explored**
and reference-complete in Appendix D.

### Part VI — Bookmarks and publication refs — 8,000 words

Preserve the publication model, tracking diagram, remote qualification, tag
distinction, and push-safety warning. Add each bookmark subcommand; local
versus remote state; tracking ahead/behind/synced; create/set/move/advance;
delete versus forget; rename; divergent bookmark targets; multiple remotes;
tags and tag tracking; and publication/force policy.

Use a bare remote to create, move, fetch, track, untrack, delete, forget,
exercise same-name remotes, observe rejected non-fast-forward, and perform an
intentional safe update. Depth goal: **explored**.

### Part VII — Git backend and interoperability — 10,000 words

Preserve `.jj`/Git object distinction, colocation benefits and hazards,
import/export, remotes, Git root, and credentials/signing caveats. Add backend
layout; colocated/non-colocated state; object/ref mapping; import/export
timing; clone/init/fetch/push; remote commands; native Git safety boundary;
`gh`; Git directories; private commits; credentials, SSH, signing, hooks,
and automation.

Run Git and jj against a colocated fixture, modify refs with Git then import,
compare Git and jj logs, and test local bare fetch/push/tracking/force safety.
Mark hosting behaviour that cannot be tested without a server. Depth goal:
**explored** for local mechanics.

### Part VIII — GitHub lifecycle — 8,000 words

Preserve branchless local development and publication bookmarks. Add one-change
PR lifecycle; stacked PRs; review iteration; early-stack rewrites; main
movement; push rejection and safe update; GitHub merge/fetch; closing/
replacing PRs; fork/upstream topology; `gh` in a colocated repository; and
cleanup.

Use graphs showing an unnamed stack, a bookmark boundary, two stacked
boundaries, an early revision rewrite, and merged remote main. Keep local
mechanics separate from GitHub UI/server claims. Depth goal: **explored**.

### Part IX — Gerrit lifecycle — 11,000 words

Preserve jj change ID versus Gerrit `Change-Id`, `refs/for`, and remote
setup. Add identity model; `gerrit upload` semantics/options; creating and
uploading a stack; review feedback on an early change; preserving footers;
descendant rebasing; re-upload/new patch sets; topics/options; landed subsets
and trunk movement; conflicts; abandonment/replacement; and Gerrit defaults.

Show a three-change stack through two review iterations, early rewrite with new
commit IDs, a landed first change, remaining stack rebased, and server/local
ref state. Validate local jj/Git transport and footer mechanics; mark server
protocol/UI behaviour as server-dependent. Depth goal: **explored**.

### Part X — Conflicts and merges — 8,000 words

Preserve first-class stored conflict values, materialisation, multi-sided
warning, `resolve`, merge/conflict distinction, and no-`--continue`
framing. Add conflict terms; creation by rebase/merge/squash; marker styles;
propagation; work while conflicted; resolve-tool lifecycle; multi-sided cases;
partial file resolution; rewrite/split/restore interactions; intentional merge
commits; and verification.

Construct two-way and multi-way conflicts in disposable repositories, inspect
graph/templates/files, resolve with a tool or manual edit, and follow
descendants. Depth goal: **explored**.

### Part XI — Operation log and recovery — 8,000 words

Preserve the two-DAG distinction, operation commands, undo/redo, `--at-op`,
and clone-locality principle. Add operation records and repository views;
op log/show/diff; undo versus restore/revert/abandon/integrate; evolution
versus operations; concurrency/merging; recovery discipline; and limitations.

Create exercises for wrong ancestor rewrite, useful abandon, incorrect
bookmark movement, subsequent operations, historical inspection, and
divergent/concurrent state where practical. Record expected and actual state.
Depth goal: **explored**.

### Part XII — Workspaces and machines — 6,000 words

Preserve workspace-local `@`, shared graph, sparse distinction, independent
operation histories, and temporary publication handoff. Add dev/build/test,
dev/review, stale repair after rewrite, sparse build, two-clone unfinished
handoff, machine divergence, and cleanup scenarios. Test all 0.44 workspace
and sparse subcommands against `workspace-lab`. Depth goal: **explored**.

### Part XIII — Configuration tutorial and reference — 14,000 words

Preserve Linux/XDG framing, layered TOML, directory layout, command families,
security warning, and dual-remote principle. Build a progressive tutorial:
effective config; user/repository/workspace scopes; command-line overrides;
editor/pager/colour; log/revset/template aliases; Git remotes/push policy;
Gerrit defaults; merge/diff tools; fixers; signing; immutable heads;
snapshot/workspace behaviour; includes/conf.d; conditional policy; and safe
repository configuration.

Add grouped human reference tables for `user.*`, `ui.*`, `git.*`,
`gerrit.*`, `revsets.*`, aliases, templates, merge tools, fix tools,
signing, sparse/snapshot/workspace, and command aliases. Each entry gets type,
scope, role, default or release caveat, and interaction. Compare 0.44 and
0.45.1 schemas experimentally. Depth goal: **explored** plus significant-key
**reference-complete**.

### Part XIV — Template language — 18,000 words

Preserve the typed-language premise, basic examples, labels, aliases, and
compact-log goal. Add chapters on literals; expression grammar and precedence;
types and conversions; method dispatch; booleans/options; strings and byte
strings; lists/lambdas; commit and reference objects; signatures and IDs;
timestamps/ranges; diffs/files/tree entries; operations/workspaces; global
functions; formatting/padding/truncation; `if`/`try`/`coalesce`; JSON;
labels/colour/hyperlinks; aliases and documentation; diagnostics/performance;
and version notes.

Build progressively: stable IDs; descriptions/metadata; bookmark/tracking
indicators; conflict/empty/mutable markers; diff stats and changed files;
operation output; JSONL; and a bespoke daily template. The reader-facing
reference covers every target-version global function and important method
from local help with signatures, result types, edge cases, and examples.
Depth goal: **explored** and **reference-complete**. This directly replaces the
previous one-page treatment.

### Part XV — Reader-facing CLI reference — 28,000 words

Preserve command tree, version comparison, and global-option concepts. Add one
anchored entry for every 46 top-level 0.44 commands and all 120 public command
paths. Each entry contains purpose, semantic model, syntax, positional
arguments, important options, revset/fileset cardinality, snapshot/working-
copy effects, descendant/rewrite effects, bookmark/Git effects, examples,
traps, related commands, and 0.45 notes.

Long entries cover `rebase`, `split`, `squash`, `absorb`, `restore`,
`run`, `bookmark`, `git`, `gerrit upload`, `operation`, `config`,
`resolve`, `fix`, `workspace`, `log`, and language-consuming commands.
Short inspection commands still get syntax, options, output contract, and
automation notes. A 0.45-only `converge` entry is clearly marked. This is
**reference-complete**, not merely inventory-complete.

### Part XVI — Advanced mechanics — 10,000 words

Preserve the topic list and machine-output principle. Add chapters on
immutable heads and rewrite protection; hidden/divergent changes and
evolution; concurrent operations; `fix` and fixer configuration; `run`
execution and private working copies; bisect state and script exit codes;
tags; signing and verification; completion; GC/maintenance; large-repository
performance; debugging/environment; and machine-readable interfaces.

Run safe read automation, `run` over a set, fixer failure, bisect scripts,
signature presence versus verification, completion, and maintenance boundary
experiments. Move the 0.45 `converge` explanation here as well as into the
version track.

### Part XVII — Complete real workflows — 12,000 words

Retain all eleven requested topics but turn the major ones into narratives
with starting remote state, local graph, commands, intermediate log/ref state,
review/upstream events, conflict or rejection branches, final state, cleanup,
and links to teaching/reference chapters.

Long workflows: branchless daily work; GitHub single/stacked PR; Gerrit stack;
early-patch rewrite; upstream synchronisation; recovery; two remotes; and
multi-machine handoff. Shorter complete workflows: multiple workspaces,
native Git in colocation, and revset-driven automation. Depth goal:
**workflow-demonstrated** and coherent with the fixtures.

## Appendix expansion — 25,000 words total

* **A, command tree:** retain the compact tree, add anchors and 0.45 delta.
* **B, option index:** command ownership, short/long spelling, argument type,
  default/interaction, and cross-links for global and important flags.
* **C, revsets:** syntax, precedence, operators, functions, signatures,
  patterns, aliases, examples, and version tags.
* **D, filesets:** forms, patterns, operators/functions, aliases, quoting, and
  consumer matrix.
* **E, templates:** grammar, operators, global functions, types/methods,
  labels, aliases, and progressive examples.
* **F, configuration:** grouped significant-key reference validated from the
  0.44 schema, with 0.45 additions.
* **G, Git-to-jj:** intent-driven mappings with non-equivalence explanations.
* **H/I, GitHub/Gerrit:** lifecycle recipes and failure branches.
* **J, recovery:** decision tree and incident recipes.
* **K, Linux:** Bash/Zsh/Fish completion, pager/editor/tool configuration,
  shell quoting, prompts, aliases, scripting, `just`, and `uv` checks.

## Implementation sequence

1. Complete audit and plan (this phase).
2. Add fixture definitions and validation-output conventions without changing
   existing prose.
3. Expand Parts I–II; run fixture validation and HTML checks.
4. Expand revsets and filesets with query/fileset laboratories and scripts.
5. Expand templates and verify them against fixture commits.
6. Expand bookmarks, Git, GitHub, Gerrit, conflicts, operations, workspaces,
   and configuration one Part at a time.
7. Build the reader-facing per-command reference from verified inventories,
   then write appendices as usable references rather than delegated pointers.
8. Expand integrated workflows and add cross-references.
9. Run all validation, rebuild HTML/PDF where tooling permits, inspect print
   pagination, run link/anchor checks, and update completeness reporting.
10. Proofread for terminology, version labels, repeated definitions, and
    source/licence attribution.

After each Part, record substantive word count, validated examples, new
citations, and 0.44/0.45 discrepancies. A Part is not complete because it has
headings; it is complete when it meets its depth goal.

## Acceptance criteria

The expanded book is ready only when:

* substantive prose is approximately 100,000–130,000 words, or a documented
  technical reason explains a material deviation; this is separate from the
  depth and reference-completeness criteria;
* the HTML remains first-class authored HTML and `jj-book.html` remains a
  symlink to `src/book.html`;
* all 0.44.0 public command paths have reader-facing entries, with 0.45.1
  additions clearly marked;
* revsets, filesets, templates, and significant configuration are taught and
  reference-documented in the book;
* reusable fixtures support the graph, language, conflict, ref, workspace,
  Git, and recovery examples claimed by the text;
* local examples are validated with target binaries where practical;
* GitHub/Gerrit server-dependent claims are separated from local verification;
* the Kindle print stylesheet handles code, tables, diagrams, headings,
  margins, and page breaks well;
* licensing/provenance covers every newly added external asset or quotation;
* the completeness report distinguishes inventory-complete,
  reference-complete, conceptually explained, empirically validated, and
  workflow-demonstrated.
