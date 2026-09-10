# Expansion plan and completion record — jj 0.45.1

This document records the expansion plan used for the current edition and its
completion state. It is deliberately target-version-only: obsolete 0.44.0
planning and release comparisons are not part of this book.

## Baseline and design constraints

The compact first pass was retained as the navigational skeleton. Expansion
was planned around technical depth rather than repeated definitions: every
major operation receives a graph transformation, every language chapter has a
laboratory, and every reference has a human-readable contract in the HTML.
The current result is approximately 103,525 substantive words and 510 PDF
pages at the 7.5 × 10 inch Kindle-Scribe print profile. The book uses
first-class HTML as its source, a pinned `uv` PDF renderer, `just` recipes, and
root symlinks for the deliverables.

## Part-by-Part plan and result

| Part | Material preserved | Expansion added | Graphs/experiments | Dependencies | Result |
|---|---|---|---|---|---|
| I | Advanced-reader framing and detached-HEAD comparison. | A non-zero-assumption primer covering snapshots, `@`, identity, publication, conflict, and recovery. | Snapshot and first-graph fixtures. | None; establishes vocabulary. | Complete. |
| II | DAG/change/commit model. | Successor/predecessor semantics, hidden/divergent state, immutable heads, operation DAG, and state-tuple reasoning. | Forks, merges, rewritten ancestors, workspaces. | Primer. | Complete. |
| III | Rewrite command inventory. | Source/destination algebra, patch ownership, descendant rebasing, identity consequences, conflicts, and recovery. | Before/after diagrams and rewrite laboratory. | Parts I–II. | Complete. |
| IV | Revset tables and cookbook. | Formal set algebra, precedence, cardinality, hand evaluation, patterns/dates, aliases, errors, and empirical comparison. | Query-lab DAG and validator expressions. | DAG model; command consumers. | Complete/reference-complete. |
| V | Fileset overview. | Full path-language treatment, shell/TOML quoting, root/cwd forms, operators, aliases, and command interactions. | Real tree and four-consumer laboratory. | Revset/fileset distinction. | Complete/reference-complete. |
| VI | Bookmark publication model. | Tracking, remote names, deletion/forgetting, tags, conflicts, and multi-remote safety. | Bookmark-state laboratory. | DAG and Git backend. | Complete. |
| VII | Git interoperability summary. | Object/ref boundary, colocation, import/export, push leases, private commits, native Git, credentials, signing, and fixtures. | Bare remote and colocated/non-colocated repositories. | Bookmarks and config. | Complete locally; external services marked. |
| VIII | Branchless GitHub recipes. | Full PR lifecycle, stacks, review revisions, main movement, forks, rejection, `gh`, and cleanup. | PR state machine and case study. | Publication refs and Git backend. | Complete locally; UI marked. |
| IX | Gerrit upload scenario. | Three identities, review refs, footers, topics/options, early-stack revision, patch sets, landing, and server boundaries. | Three-identity stack case study. | Git backend, rewrites, conflicts. | Complete for documented local/protocol behaviour. |
| X | Conflict definition. | Stored conflict lifecycle, propagation, materialisation, tools, multi-sided values, and resolution after rewrites. | Real conflicting repository. | Rewrites and merges. | Complete locally; external tools marked. |
| XI | Operation command list. | Operation DAG, views, undo versus restore, concurrency, integrated operations, and forensic recovery. | Disposable recovery laboratory. | All mutation chapters. | Complete. |
| XII | Workspace facts and machine handoff. | Workspace-local `@`, build/review uses, sparse state, stale records, independent clones, and cross-machine transfer. | Workspace lifecycle and two-clone fixture. | DAG, Git backend, sparse. | Complete within documented limits. |
| XIII | Configuration layers and key list. | Progressive Linux design, scope interactions, GitHub/Gerrit safety, aliases, conditionals, and task/reference tables. | Configuration laboratory and schema comparison. | All policy-bearing features. | Complete/reference-complete. |
| XIV | Template summary. | Evaluation model, types, methods, lists, optionals, labels, JSON, aliases, debugging, and daily log construction. | Template laboratory and stable-output checks. | CLI output and revsets. | Complete/reference-complete. |
| XV | Command inventory. | Reader-facing contract for all 47 top-level/121 public paths, option interactions, cardinality, side effects, traps, and dossiers. | Local help inventory and option validator. | All preceding semantics. | Complete/reference-complete. |
| XVI | Compressed advanced mechanics. | Dedicated treatments of `run`, fixers, bisect, signing, concurrency, maintenance, performance, completion, and machine output. | Automation, fixer, bisect, signing, and output labs. | CLI, templates, operations. | Complete within environment limits. |
| XVII | Workflow checklist. | Eleven stateful end-to-end narratives with publication, review, upstream movement, conflict, recovery, and cleanup. | Reusable GitHub/Gerrit/workspace scenarios. | All explanatory chapters. | Complete. |
| XVIII | Compact fieldbooks and appendices. | Practice curriculum, edge cases, synthesis, and standalone references. | Twenty graph-first labs. | Whole book. | Complete/reference-complete. |

## Expansion acceptance criteria

The plan was considered complete only when all of the following held:

1. every major Part reached at least “explored” in `research/depth-audit.md`;
2. CLI, revset, fileset, template, and configuration references were checked
   against the jj 0.45.1 local inventory rather than memory;
3. representative graph transformations had before/after states and a
   validation path;
4. workflows showed state over time rather than isolated command recipes;
5. external-server and hardware boundaries were labelled rather than implied
   to be tested;
6. the HTML, PDF, contents, outline, symlinks, and validation scripts passed
   the `just review` interface.

## Remaining optional work

Further expansion is possible, but the remaining work is not an unrecorded
requirement of this edition. It consists of testing against a real Gerrit
server, a real GitHub account, hardware-backed signing, and additional
interactive tools. Those require external state or credentials and are
therefore not fabricated in the local build.
