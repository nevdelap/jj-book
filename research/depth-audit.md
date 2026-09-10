# Depth audit — jj 0.45.1 edition

Audit date: 2026-09-10 UTC. Target: jj 0.45.1 only. This is a depth and
coverage record for the current book, not a historical 0.44.0 record.

## Method

The audit was made against the HTML heading tree in `src/book.html`, the
generated command/revset/fileset/template/config inventories, the fixture
scripts, and the rendered PDF. “Mentioned” means that a term is named;
“introduced” adds a definition; “explained” gives semantics and consequences;
“demonstrated” adds a worked command or graph; “explored” adds interactions,
edge cases, or a laboratory; “reference-complete” means that the target
inventory is represented in a reader-facing reference, with raw help retained
as verification evidence. The levels are deliberately not inferred from a
heading’s existence.

The current authored book measures approximately 103,525 substantive words by
the project counting script and renders to 510 pages at 7.5 × 10 inches. The
size is evidence of a substantial manuscript, but the classifications below
are based on technical treatment, examples, and validation rather than page
count.

## Part-level audit

| Part | Current scope and treatment | Level | Graphs/examples/experiments | Required expansion status |
|---|---|---|---|---|
| I — jj primer | Establishes the minimum vocabulary assumed later: snapshot boundary, working-copy commit, `@`, change/commit identity, first graph operations, publication, conflict, and recovery. It deliberately stops short of Git basics. | explored | Linear and small forked graphs; command fixtures for snapshot and identity boundaries. | Complete for the intended advanced reader; later chapters own the detailed semantics. |
| II — mental model | Develops DAG-first reasoning, mutable/immutable commits, hidden/divergent changes, visible heads, snapshots, workspaces as a local view, and the operation DAG. | explored | Non-linear graphs, successor diagrams, identity tables, state tuples, and detached-HEAD comparisons. | Complete; cross-references lead to the dedicated rewrite, workspace, and operation chapters. |
| III — rewriting | Covers edit, describe/metaedit, diffedit, squash, split, absorb, duplicate, abandon, restore, revert, and rebase, including source/destination algebra and descendant rebasing. | explored | Before/command/after diagrams; patch ownership and rewrite laboratories; conflict and recovery exercises. | Complete; CLI dossiers add option-level detail. |
| IV — revsets | Treats revsets as a language: symbols, sets, traversal, ranges, precedence, patterns/dates, aliases, cardinality, derivation, and operational cookbook queries. | explored/reference-complete | Query-lab DAG, hand evaluation, empirical fixture checks, function-family atlas. | Complete for 0.45.1 public syntax; future additions require inventory regeneration. |
| V — filesets | Defines filesets as path sets and covers literal, glob, root/cwd forms, operators, functions, aliases, shell quoting, and command consumers. | explored/reference-complete | Real tree laboratory, four-consumer comparison, quoting failures, fileset API examples. | Complete for the captured 0.45.1 fileset surface. |
| VI — bookmarks | Explains bookmarks as publication names, tracking as a relationship, remote bookmarks, deletion/forgetting, tags, conflicts, and multi-remote publication. | explored | Bookmark-state laboratory and publication-state diagrams. | Complete; hosting parts apply the model to GitHub/Gerrit. |
| VII — Git backend | Covers Git objects versus jj metadata, colocation, import/export, remotes, fetch/push safety, private commits, native Git, `gh`, credentials, signing boundaries, and local fixtures. | explored | Colocated/non-colocated graphs, ref boundary diagrams, bare remote tests, Git interoperability lab. | Complete locally; server and credential boundaries are explicitly marked untested. |
| VIII — GitHub | Develops branchless publication, single and stacked PRs, review updates, main movement, forks, rejected pushes, `gh`, and cleanup. | explored | PR lifecycle state machine, GitHub field laboratory, multi-week case study. | Complete for local/ref mechanics; GitHub UI/server effects are marked server-dependent. |
| IX — Gerrit | Separates jj change IDs from Gerrit `Change-Id`, maps review refs, topics/options, defaults, upload, stack revision, landing, conflicts, and cleanup. | explored | Three-identity stack lifecycle and re-upload case study. | Complete for jj transport and documented protocol; no live Gerrit server is available. |
| X — conflicts | Treats conflicts as stored values, covering propagation, materialisation, markers, tools, multi-sided conflicts, merges, and resolution after rewrites. | explored | Conflict lifecycle and real conflicting fixture. | Complete; external tool behaviour remains an explicit boundary. |
| XI — operations/recovery | Explains operation views, IDs, log/show/diff/restore/abandon/integrate, undo, concurrency, and recovery as forensic work distinct from reflog. | explored | Disposable recovery laboratory, operation-DAG diagrams, undo/restore exercises. | Complete for 0.45.1 operation commands. |
| XII — workspaces/machines | Defines workspace-local `@`, shared store and operation state, build/review workspaces, sparse state, stale workspaces, independent clones, and cross-machine handoff. | explored | Workspace laboratory, stale-state tests, two-clone bare-remote scenario. | Complete; operation synchronisation beyond documented behaviour is excluded. |
| XIII — configuration | Builds a layered Linux configuration and explains scopes, commands, UI, snapshots, Git/Gerrit, aliases, safety, conditionals, and reference families. | explored/reference-complete | Progressive config laboratory, task-oriented reference, schema-backed inventory. | Complete for significant 0.45.1 keys; schema is retained for exact machine-readable detail. |
| XIV — templates | Teaches the template evaluator, values/types, methods, lists/lambdas, optionals, labels/styles, commit/operation/workspace contexts, JSON, aliases, debugging, and a daily log. | explored/reference-complete | Progressive template laboratory and stable-output exercises. | Complete for the captured public template surface. |
| XV — CLI | Presents the complete 47-command/121-path 0.45.1 inventory with reader-facing semantics, syntax, options, cardinality, mutation/ref/workspace effects, traps, and cross-links. | reference-complete | Critical command dossiers plus generated inventory and local help capture. | Complete; validator checks path coverage, order, and totals. |
| XVI — mechanics | Expands immutability, evolution, concurrency, `fix`, `run`, bisect, tags, signing, completion, maintenance, performance, debugging, and machine output. | explored | Automation/fixer/bisect/signing labs and non-interactive validation. | Complete within live-environment limits; hardware/server/TUI limits are recorded. |
| XVII — workflows | Integrates branchless work, GitHub, Gerrit, rewrites, upstream movement, two remotes, machine handoff, workspaces, recovery, native Git, and revset-driven work. | explored | Eleven end-to-end narratives with state accounting and case studies. | Complete; each narrative links back to the language and command chapters. |
| XVIII — fieldbooks | Provides practice curriculum, hosting/configuration/command references, edge cases, mechanics synthesis, and compact lookup material. | explored/reference-complete | Twenty graph-first labs and standalone appendix cards. | Complete as a consolidation section, not a replacement for the explanatory parts. |

## Appendix and reference audit

| Appendix | Current treatment | Level | Evidence |
|---|---|---|---|
| A | Complete command tree and public path inventory. | reference-complete | 121 paths, generated from recursive local help. |
| B | Global and command option index, grouped by operation and risk. | reference-complete | Local help capture and option validator. |
| C | Revset operators, functions, patterns, dates, aliases, precedence, and examples. | reference-complete | 0.45.1 help capture, prose atlas, and revset fixture. |
| D | Fileset syntax, path forms, operators, aliases, quoting, and consumers. | reference-complete | Fileset laboratory and fileset help capture. |
| E | Template types, methods, operators, formatting, labels, aliases, and contexts. | reference-complete | Template laboratory and rendered-output validation. |
| F | Configuration families, scope, task mapping, and schema pointers. | reference-complete | 0.45.1 schema plus human-readable key tables. |
| G | Git operation lookup with explicit non-equivalences. | explored | Concept mapping and caveat tables. |
| H | GitHub lifecycle recipes. | explored | Publication/ref state-machine examples. |
| I | Gerrit upload/review recipes. | explored | Stack lifecycle and server-dependent boundary notes. |
| J | Recovery recipes. | explored | Operation laboratory and recovery casebook. |
| K | Bash/Zsh/Fish, pager/editor/tool integration and completion. | explored | Linux shell fieldbook and completion commands. |

## Delegation boundaries

The book no longer delegates the requested teaching to the research directory.
Raw captures and schemas are retained for reproducibility and exact spelling;
the HTML explains the important semantics and presents reader-facing entries.
The following remain intentionally external or environment-dependent:

* GitHub web UI, fork permissions, merge queues, and server policy;
* Gerrit server-side patch-set association, submit rules, labels, and ACLs;
* real GPG/SSH hardware or agent policy;
* interactive merge/diff tools and terminal UI behaviour;
* every possible DAG shape beyond the representative fixture laboratories.

These are marked in the relevant chapters and in the completeness report; they
are not silently claimed as locally validated.

## Current conclusions

The current 0.45.1 manuscript is inventory-complete, reference-complete for
the captured public language/CLI/configuration surfaces, conceptually
explained at the explored level for the major subjects, and empirically
validated for representative local behaviour. No 0.44.0 comparison track is
maintained in this edition: the target policy was explicitly changed by the
project owner after the earlier review, and obsolete 0.44.0 records were
removed rather than mixed into the current book.
