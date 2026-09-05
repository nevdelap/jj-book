# Depth audit of the current manuscript

Audit date: 2026-09-06  
Manuscript audited: `src/book.html` (also exposed as `jj-book.html`)  
Normative release: jj 0.44.0; comparison release: jj 0.45.1

## Measurement and method

The HTML was inspected as authored, not inferred from the table of contents. A
pre-expansion `uv run` measurement pass counted approximately **7,241
substantive words**. During the corrective expansion, the same measurement pass
reached **102,796 substantive prose words** (excluding `pre`, `script`, and
`style` content; examples add further material), with a reproducible PDF of
**510 pages** at 7.5 × 10 inches, including two generated contents pages after the pagination correction. The manuscript is
materially deeper than the reviewed 47-page compact guide: it now contains 121
reader-facing command articles, 120 canonical 0.44 paths, 0.45.x comparison
material, graph/language laboratories, and local conflict/sparse/workspace
fixtures. It now meets the lower edge of the revised 100,000–130,000-word
design range; the audit records that measurement separately from coverage and
reference status.

## Post-review expansion measurement

The following measurements are from the current authored HTML after the review
correction pass. The new material is substantive explanation, state reasoning,
reference tables, and workflows; raw help and validation output remain outside
the prose count.

| Area | Current depth | Evidence added |
|---|---|---|
| Part I / primer | explained | entry-state inspection, core cycle, vocabulary, first operations, publication, conflict and recovery orientation |
| Part II / model | explored | state tuple, snapshot machine, identity table, visibility cases |
| Part III / rewriting | explored | source/destination matrix, patch ownership, descendant cases |
| Part IV / revsets | explored; reference substantially expanded | evaluated sets, range algebra, typed patterns, function contracts |
| Part V / filesets | explored | grammar, quoting, tree evaluation, consumer matrix |
| Parts VIII–IX / hosting workflows | explored locally/server boundary explicit | PR stack, Gerrit identities, review iterations, trunk movement |
| Parts X–XII / conflicts, operations, workspaces | explored | conflict resolution, operation recovery, sparse/workspace/machine cases |
| Parts XIII–XV / config, templates, CLI | substantially expanded | typed templates, config construction, command contracts |

The HTML renderer crosses the lower 450-page design threshold and the
manuscript is within the revised 100,000–130,000-word range. Any further
expansion should add missing technical depth or reference coverage, not padding.

Depth labels used below:

* **mentioned** — named or listed, with little semantic explanation;
* **introduced** — definition and a small example;
* **explained** — semantics and at least one consequence are made clear;
* **demonstrated** — a worked command/state transition is shown;
* **explored** — interactions, edge cases, failure/recovery, and multiple
  worked states are treated;
* **reference-complete** — the reader-facing text contains the important
  target-version syntax/options/surface, rather than delegating it to raw help.

The current manuscript is technically useful as a skeleton. Its recurring
failure is that a topic reaches `introduced` or `explained`, while the request
requires `explored`; inventories reach `mentioned` but are called exhaustive.

## Front matter and cross-cutting material

### Preface and version policy (`#preface`)

* **Current scope:** Advanced-reader assumptions, 0.44.0 baseline, 0.45.x
  comparison policy, Kindle print settings, source links, and licensing note.
* **Current depth:** explained for policy; introduced for print and licensing.
* **Explains:** why detached-HEAD experience is a useful starting point; what
  the version tags mean; where research and raw captures live; the intended
  paper size and print settings.
* **Merely mentions/delegates:** exact release matrix, source provenance,
  licensing detail, and validation evidence are delegated to `research/`.
* **Examples:** print-dialog instructions; no substantive worked version
  comparison or reader-facing “how to detect drift” procedure.
* **Graphs:** none.
* **Edge cases:** stale/current-main documentation and third-party material
  are acknowledged but not worked through.
* **Workflow treatment:** none.
* **Reference completeness:** policy-complete, not technically complete.
* **Required expansion:** add edition structure, notation, evidence labels,
  reproducibility protocol, how to read version callouts, and a substantive
  version-difference matrix in the book itself.

## Part I — jj primer

### Part I overview (`#part0`)

* **Current scope/depth:** introduced to explained; it is the new prerequisite
  layer for readers who know Git but do not yet know jj.
* **Explains:** how to inspect an existing jj, Git, remote, or empty-directory
  starting state; the core snapshot/edit/describe/new/edit cycle; the everyday
  jj vocabulary; first graph operations; publication; conflicts; and basic
  operation-log recovery.
* **Examples/graphs:** existing-repository inspection, a working-copy successor,
  a child change, a squash transformation, and a publication bookmark.
* **Reference/workflow treatment:** deliberately introductory for jj, but not
  beginner Git material; detailed semantics and hosting workflows remain in
  Parts II–XVII.
* **Required expansion:** retain as the reader's orientation layer and keep it
  neutral about whether the reader begins in an existing or empty repository.

## Part II — The jj mental model

### Part II overview (`#part1`)

* **Current scope/depth:** a coherent conceptual opening, mostly explained;
  too short to support later advanced mechanics.
* **Explains:** DAG-first development, mutable/immutable/hidden/visible
  revisions, working-copy commits, snapshot timing, `@`, workspaces, and a
  Git comparison table.
* **Merely mentions:** predecessors/successors, divergent changes, visible
  heads, operation boundaries, and the exact relationship between repository
  view and filesystem view.
* **Examples/graphs:** one linear graph and one workspace sketch; the table is
  useful but there is no non-linear worked laboratory.
* **Edge cases:** `--ignore-working-copy`, `--at-operation`, root, and empty
  commits are named; stale snapshots, concurrent writers, workspace-specific
  symbols, and hidden/divergent lookup are not demonstrated.
* **Workflow treatment:** detached-HEAD analogy is stated, not followed over
  a realistic day of work.
* **Reference completeness:** not applicable; concepts are not a reference.
* **Required expansion:** separate chapters for repository views, snapshots,
  identity/evolution, mutability/visibility, and workspaces; use several
  before/after DAGs and empirical observations.

### 6. DAGs, snapshots, and identities (`#model`)

* **Current scope:** commit/change IDs, mutable and immutable commits, hidden
  and visible revisions, root, empty commits, snapshot timing, Git analogy.
* **Current depth:** explained, with one demonstration; not explored.
* **Delegation:** command-triggered snapshot details and exact terminology are
  partly delegated to help/research.
* **Examples/graphs:** one linear `main@origin`–`@` graph and one comparison
  table.
* **Missing:** commit identity consequences of every rewrite, multiple
  predecessors/successors, divergence offsets, visibility domains, immutable
  head calculation, filesystem-vs-store experiments, and operation records.
* **Required expansion:** a formal state model and a fixture-based sequence
  showing snapshots before/after read and write commands, with IDs and op IDs.

### 7. Working-copy commit, mutable history, and workspaces (`#working-copy`)

* **Current scope:** `@`, `jj new`, `jj edit`, workspace-local pointers, shared
  graph, and a small two-workspace diagram.
* **Current depth:** explained; not demonstrated through lifecycle scenarios.
* **Merely mentions:** stale workspaces, sparse materialisation, filesystem
  ownership, and workspace repair.
* **Examples/graphs:** one shared-DAG diagram and a few commands elsewhere.
* **Missing:** workspace metadata, add/forget/rename/update-stale semantics,
  concurrent edits, workspace-local symbols, build/review patterns, and the
  fact that graph rewrites are shared while checkout state is local.
* **Required expansion:** two complete workspace scenarios and a state table
  distinguishing commit store, operation store, workspace metadata, and
  filesystems.

## Part III — Rewriting history

### Part III overview (`#part2`)

* **Current depth:** introduced to explained.
* **Explains:** rewriting as source selection plus destination; automatic
  descendant rebasing; broad command names.
* **Merely mentions:** most commands in a table; interaction and recovery are
  delegated to later short sections.
* **Examples/graphs:** a linear stack, `absorb`, and `squash`; no worked
  fork/merge or multi-destination rebase laboratory.
* **Reference completeness:** explicitly not complete; the table delegates
  options to raw help.
* **Required expansion:** one chapter per family of transformations, with
  before/command/after graphs, ID/evolution tables, conflict cases, and a
  detailed command reference.

### 9. Patch-stack surgery (`#rewrites`)

* **Current scope:** edit/describe/metaedit/diffedit/squash/split/absorb/
  duplicate/abandon/restore/revert in one table; short content-movement
  example.
* **Current depth:** introduced for most commands; explained only for the
  general idea; demonstrated for two operations.
* **Merely mentions:** option interactions, exact source/destination
  cardinality, partial filesets, successor selection, merge commits, and
  recovery.
* **Examples/graphs:** linear stack before/after; no realistic patch stack.
* **Missing:** semantics of each command and distinctions among tree copy,
  inverse patch, duplicate, successor, and abandon.
* **Required expansion:** dedicated sections for each rewrite command and a
  continuous “API patch stack” fixture revisited in later chapters.

### 10. Rebase selection and destination algebra (`#rebase`)

* **Current scope:** `-s`, `-r`, `-b`; `-o`, `-A`, `-B`; repeated destinations;
  conflicts and lack of `--continue`.
* **Current depth:** explained and partly demonstrated.
* **Examples/graphs:** one linear source/destination diagram and one command
  for a merge destination.
* **Missing:** exact set semantics, holes, multiple source roots, insert-before
  and insert-after with descendants, immutable checks, bookmark motion, and
  operation/evolution consequences.
* **Required expansion:** a textbook treatment with several non-linear graphs,
  evaluated source sets, and a matrix of all source/destination modes.

## Part IV — Revsets

### Part IV overview (`#part3`)

* **Current depth:** the strongest conceptual part, but still a quick reference
  rather than a textbook language chapter.
* **Explains:** sets, symbols, cardinality, precedence, operators, functions,
  aliases, patterns, and cookbook intent.
* **Merely mentions/delegates:** exact function details and empirical evaluation
  are delegated to `research/help-revsets-*`.
* **Examples/graphs:** one operator table, a few expressions, and a cookbook;
  no annotated evaluation against a complex fixture graph.
* **Reference completeness:** inventory-complete in research, not reader
  reference-complete.
* **Required expansion:** formal grammar, semantic evaluation, topology
  laboratories, symbol-resolution experiments, function reference, error
  cases, and derived query exercises.

### 12. Revsets as a query language (`#revset-language`)

* **Current scope/depth:** introduced to explained; precedence and cardinality
  are useful but compressed.
* **Explains:** symbols, quoting, operator precedence, set values.
* **Missing:** evaluation order, domain/visibility, range algebra, ambiguous
  prefixes, aliases, pattern/date syntax, and command-specific cardinality.
* **Required expansion:** teach expressions by evaluating named sets step by
  step over several DAGs, including counterexamples to tempting Git analogies.

### 13. Revset operators and public functions (`#revset-functions`)

* **Current scope:** broad inventory table grouped by topic.
* **Current depth:** mentioned/introduced, not explored.
* **Delegation:** the local help inventory contains signatures but the book
  does not.
* **Examples/graphs:** a few isolated expressions; no one simple, compositional,
  or operational example per important function.
* **Reference completeness:** no.
* **Required expansion:** every operator and public function gets signature,
  domain/cardinality, edge cases, simple/composed/operational examples, and
  fixture verification.

### 14. Derived queries and cookbook (`#revset-cookbook`)

* **Current depth:** introduced; useful recipes but little derivation.
* **Explains:** unpublished work, mutable stacks, conflicts, emptiness, remote
  reachability, authorship, recent revisions, and review candidates.
* **Missing:** intermediate algebra, assumptions about remote/bookmark names,
  failure cases, and verification output.
* **Required expansion:** derive every recipe from primitive operators and add
  exercises for GitHub, Gerrit, release, divergence, and multi-remote graphs.

## Part V — Filesets (`#part4`)

* **Current scope:** distinguishes filesets from revsets/templates; names
  literals, globs, aliases, quoting, and several consuming commands.
* **Current depth:** introduced only (approximately one page).
* **Explains:** the three-language distinction and basic `glob:` examples.
* **Merely mentions/delegates:** actual grammar, pattern forms, operators,
  precedence, functions, alias semantics, command-specific defaults, and
  path edge cases are delegated to help/research.
* **Examples/graphs:** code examples only; no realistic repository tree or
  evaluated file selections.
* **Reference completeness:** no.
* **Required expansion:** a genuine language chapter with a tree fixture,
  shell quoting experiments, all target syntax, and per-command interaction
  sections for diff/restore/squash/split/fix/file.

## Part VI — Bookmarks and publication refs (`#part5`)

* **Current scope:** names, create/set/move/track/untrack/forget/delete, remote
  bookmarks, tracking diagram, tags, and a short push-safety paragraph.
* **Current depth:** explained for the central distinction; not explored.
* **Examples/graphs:** one local/remote relationship diagram and commands.
* **Missing:** every subcommand's options and state transitions, divergent
  bookmark targets, deletion propagation, multiple remotes, tracking ahead/
  behind/synced states, tag semantics, and publication policy.
* **Required expansion:** a ref-state laboratory and a complete two-remote
  publication lifecycle, including rejected and force-safe pushes.

## Part VII — Git backend and interoperability (`#part6`)

* **Current scope:** Git backend, `.jj`, colocation, Git commands, import/export,
  remotes, root, native Git caveats, credentials/signing, push safety.
* **Current depth:** explained; not demonstrated except via short commands.
* **Merely mentions:** actual ref import/export timing, Git object mappings,
  colocated failure modes, `gh`, hooks, credentials, private commits, and
  remote selection.
* **Examples/graphs:** command list only; no Git/jj state comparison.
* **Required expansion:** colocated fixture experiments, ref/object diagrams,
  native Git mutation scenarios, and complete clone/fetch/push workflows.

## Part VIII — GitHub (`#part7`)

* **Current scope:** branchless single PR, stacked PR bookmarks, `gh`, forks,
  rebasing, and server-side merge distinction.
* **Current depth:** introduced and lightly demonstrated.
* **Examples/graphs:** one linear graph and short stack commands.
* **Missing:** full PR lifecycle, review revisions, early-stack rewrites, main
  movement, rejected pushes, local/remote disagreement, closing/replacing a
  PR, forks, and GitHub-specific boundaries.
* **Required expansion:** a multi-stage GitHub scenario with publication state
  after every step and explicit `gh`/Git/jj interaction notes.

## Part IX — Gerrit (`#part8`)

* **Current scope:** jj change ID versus Gerrit Change-Id, `gerrit upload`,
  `refs/for`, a short patch-stack workflow, two remotes.
* **Current depth:** explained for identity; introduced for workflow.
* **Missing:** actual upload option semantics, patch-set lifecycle, early-stack
  review change, preserved footers, conflicts, landed subsets, topics/options,
  remote defaults, and server-dependent boundaries.
* **Examples/graphs:** one linear stack and commands; no evolving patch-set
  graph.
* **Required expansion:** a substantial Gerrit chapter with a realistic stack
  over time, authoritative protocol notes, and a local-vs-server validation
  boundary.

## Part X — Conflicts and merges (`#part9`)

* **Current scope:** stored conflict values, materialisation, multi-sided
  conflicts, `resolve`, merge commits, no `--continue`.
* **Current depth:** explained; not demonstrated with a real fixture.
* **Examples/graphs:** one conceptual conflict graph and commands.
* **Missing:** conflict term structure, markers, repeated resolution, conflict
  propagation through descendants, file-level partial resolution, merge versus
  conflict, and rewrite/split/restore interactions.
* **Required expansion:** a conflict lifecycle laboratory with simple and
  multi-sided cases, before/after logs, and recovery branches.

## Part XI — Operation log and recovery (`#part10`)

* **Current scope:** commit DAG versus operation DAG, operation commands, undo/
  redo, `--at-op`, a short destructive-looking sequence, clone independence.
* **Current depth:** explained but not a laboratory.
* **Examples/graphs:** one two-graph sketch; no recorded operation IDs/states.
* **Missing:** op show/diff/restore/revert/abandon/integrate distinctions,
  operation merge/concurrency, recovery after subsequent operations, evolution
  versus operation history, and practical limitations.
* **Required expansion:** several disposable recovery exercises with captured
  state, expected observations, and safe stopping procedures.

## Part XII — Workspaces and multiple machines (`#part11`)

* **Current depth:** introduced/explained.
* **Explains:** workspace commands, workspace-local `@`, shared graph, sparse
  materialisation, clone-local operation histories, temporary publication.
* **Missing:** build/review scenarios, stale repair, workspace metadata, sparse
  interactions, two-clone handoff, machine divergence, and cleanup.
* **Required expansion:** two complete workspace scenarios and one two-machine
  narrative using a local bare remote.

## Part XIII — Configuration (`#part12`)

* **Current scope:** layered TOML, Linux paths, config commands, directory
  layout, namespaces, aliases, security note, two-remote fallback.
* **Current depth:** introduced to explained; not a tutorial plus reference.
* **Delegation:** exact keys and schema are delegated to research.
* **Examples:** one directory tree and one compact TOML file.
* **Missing:** precedence experiments, every config command's options, important
  UI/Git/Gerrit/revset/template/fixer/signing/merge/workspace settings,
  conditional configuration, include/conf.d behaviour, and security model.
* **Required expansion:** build a maintainable Linux configuration in stages,
  then provide a grouped human reference validated against the schema.

## Part XIV — Template language (`#part13`)

* **Current scope:** typed rendering language, a few commit/operation values,
  conditionals, labels, aliases, compact log examples.
* **Current depth:** introduced only (approximately one page).
* **Explains:** templates are distinct from revsets/filesets and can render
  values.
* **Merely mentions/delegates:** grammar, operators, all public functions,
  types/methods, conversions, optional values, errors, signatures/timestamps,
  diffs/files, JSON, colours, label discovery, aliases, and operation objects
  are delegated to installed help.
* **Examples:** three short templates; no progressive construction.
* **Required expansion:** a full language chapter and standalone reference,
  with typed examples, debugging, machine-readable output, and a bespoke
  daily log template derived step by step.

## Part XV — CLI reference (`#part14`)

* **Current scope:** family table, grouped command/trap table, global option
  paragraph, 0.45 comparison.
* **Current depth:** inventory-level; not a reference despite the title.
* **Explains:** broad command families and a few traps.
* **Delegates:** nearly all syntax, arguments, important options, defaults,
  cardinality, mutation effects, descendant effects, bookmark/Git effects,
  examples, and version notes to raw help.
* **Reference completeness:** command inventory-complete in research only;
  reader-facing reference-incomplete.
* **Required expansion:** individual structured entries for all 46 0.44 top-
  level commands and 120 public command paths, with deeper entries for
  rewrite, refs, Git, operation, language, and workflow commands.

## Part XVI — Advanced mechanics (`#part15`)

* **Current scope:** immutability, concurrency, evolution, `fix`, `run`,
  bisect, tags, signing, completion, maintenance, performance, machine
  output.
* **Current depth:** mentioned to introduced, compressed into roughly two
  pages.
* **Examples:** a few `run`/`fix` commands and one prose list.
* **Missing:** semantics, configuration, safety boundaries, execution model,
  failure/recovery, concurrency experiments, signing setup, bisection state,
  maintenance implications, and performance measurement.
* **Required expansion:** split into focused chapters with practical scenarios
  and explicit target-version limitations.

## Part XVII — Complete workflows (`#part16`)

* **Current scope:** eleven workflows, mostly one paragraph each; a few command
  blocks for rewriting and upstream synchronisation.
* **Current depth:** checklist/recipe level; not complete workflows.
* **Examples/graphs:** isolated commands, no sustained repository state.
* **Missing:** remote starting state, review feedback, main movement, conflicts,
  recovery, final state, cleanup, and cross-references into the reference.
* **Required expansion:** retain all eleven but turn the key ones into complete
  narratives over reusable fixtures: daily work, GitHub single/stacked PRs,
  Gerrit, recovery, two remotes, machines, workspaces, and revset-driven work.

## Appendices

### Appendix A — Complete command tree

* **Current depth:** compact inventory; useful as an index.
* **Explains:** 0.44 public paths at a glance.
* **Delegates:** semantics, options, defaults, and version comparison.
* **Required expansion:** keep compact tree, add links/anchors to every
  reader-facing command entry and identify 0.45-only paths.

### Appendix B — Option index

* **Current depth:** a very small selected-flag table.
* **Missing:** command ownership, argument type, default, interactions, and
  version notes for the installed global and command options.
* **Required expansion:** a usable flag index cross-linked to command entries,
  with short/long forms and common semantic traps.

### Appendix C — Revset quick reference

* **Current depth:** compact syntax summary.
* **Missing:** full public function/signature reference and evaluated examples.
* **Required expansion:** make this a dense lookup appendix after the teaching
  chapters, not a substitute for them.

### Appendix D — Fileset reference

* **Current depth:** one paragraph; explicitly delegates actual inventory.
* **Required expansion:** complete syntax/pattern/operator/function/alias
  table, quoting rules, and consumer matrix.

### Appendix E — Template reference

* **Current depth:** one paragraph; explicitly delegates methods to help.
* **Required expansion:** grammar, precedence, functions, types, methods,
  conversions, labels, aliases, examples, and version notes.

### Appendix F — Configuration reference

* **Current depth:** namespace list and delegation to schema.
* **Required expansion:** grouped human reference of important keys with type,
  scope, default/role, interactions, and version status; retain schema as
  machine validation authority.

### Appendix G — Git-to-jj lookup

* **Current depth:** compact table with non-equivalence warnings.
* **Required expansion:** add intent-driven recipes and cross-links, while
  explicitly retaining “no one-to-one equivalent” cases such as reflog,
  stash, reset, and force-with-lease.

### Appendices H–I — GitHub and Gerrit recipes

* **Current depth:** one-paragraph summaries.
* **Required expansion:** concise operational checklists after the full
  workflows, including rejection/conflict/cleanup branches.

### Appendix J — Recovery recipes

* **Current depth:** one paragraph.
* **Required expansion:** incident-oriented decision trees and exact inspect,
  undo, restore, evolution, and cross-machine recipes.

### Appendix K — Linux shell integration

* **Current depth:** one paragraph plus a prompt example and TOML block.
* **Required expansion:** Bash/Zsh/Fish completion, pager/editor/tool setup,
  safe aliases, prompt performance, quoting, scripting, and `just`/`uv`
  validation integration.

## Overall conclusion

The manuscript is now a substantial technical book. Its terminology, version
discipline, HTML architecture, licensing note, and graph-first ordering are
preserved from the first-pass skeleton. The current operative target is
100,000–130,000 substantive words and 450–600 Kindle-Scribe pages; the final
measurement is 102,796 words and 510 pages. Earlier larger targets belong only
to the historical review record and are not expansion requirements.

## Historical versus current audit

The detailed per-topic entries above are the original pre-expansion audit and
are retained as evidence of what was shallow in the reviewed skeleton. They
must not be read as the current state. The following matrix is the current
audit of the authored HTML after the follow-up restructuring. `teaching`,
`practice`, `reference`, and `workflow` identify the reader's route through
the material; a later section is not an unlabelled competing primary chapter.

| Area | Primary teaching | Practice/laboratory | Reference | Workflow | Current status |
|---|---|---|---|---|---|
| Part I — primer | Part I | first-session and state-orientation examples | command quick starts | entry-state orientation | introduced to explained; no Git beginner material |
| Part II — mental model | Part II, chapters 6–8 | field manual state-accounting lab | Appendix G and model tables | branchless daily workflow | explored; empirically representative |
| Part III — rewriting | Part III, chapters 9–11 | rewrite laboratory and command dossiers | Part XV rewrite contracts | early-stack review rewrite | explored; core fixtures validated |
| Part IV — revsets | Part IV, chapters 12–14 | revset semantics laboratory | Appendix C and revset atlas | revset-driven automation | explored; reference substantially complete |
| Part V — filesets | Part V | fileset semantics laboratory | Appendix D grammar/consumer matrix | selective squash/split/fix | explored; local tree checks validated |
| Part VI — bookmarks | Part VI | bookmark state laboratory | CLI/bookmark entries | publication boundary workflows | explored across primary and fieldbook material |
| Part VII — Git backend | Part VII | colocation/ref experiments | Git command atlas | GitHub/Gerrit transport | explored locally; host effects documented |
| Part VIII — GitHub | Part VIII | GitHub field laboratory | Appendix H recipes | single and stacked PR lifecycles | workflow-demonstrated; server-dependent portions labelled |
| Part IX — Gerrit | Part IX | Gerrit stack lifecycle | Appendix I recipes | patch-set upload/review/landing | workflow-demonstrated; server-dependent portions labelled |
| Part X — conflicts | Part X | conflict lifecycle laboratory | resolve/merge entries | conflict through review stack | explored; real two-sided fixture validated |
| Part XI — operations | Part XI | operation/recovery laboratory | operation command entries | wrong rewrite and bad push recovery | explored; local operations validated |
| Part XII — workspaces | Part XII | workspace laboratory | workspace command entries | build/review/machine handoff | explored; workspace lifecycle validated |
| Part XIII — configuration | Part XIII | configuration laboratory | Appendix F task/family reference | GitHub/Gerrit conditional policy | explored; schema-backed, human reference present |
| Part XIV — templates | Part XIV | template language laboratory | Appendix E type/method maps | daily log and machine output | explored; representative output validated |
| Part XV — CLI | command contracts and entries | command validation protocol | Appendix A/B and command atlas | command selection in workflows | inventory-complete; complex contracts explained |
| Part XVI — mechanics | Part XVI | advanced mechanics labbook and curriculum | utility/global option entries | maintenance/debugging automation | explored broadly; external tools marked unvalidated |
| Part XVII — workflows | Part XVII | fieldbook and hosting protocol sections | recipe appendices | integrated lifecycle narratives | workflow-demonstrated |
| Part XVIII — practice/reference | explicitly labelled fieldbooks, atlases, and mechanics text | twenty graph-first labs | dense reference cards | hosting/recovery fieldbooks | deliberate second progression, not an unlabelled appendix |

### Current appendix audit

| Appendix | Role | Current navigation and coverage | Remaining limitation |
|---|---|---|---|
| A | quick lookup | command tree links to Part XV entries and release note | not a duplicate full command reference |
| B | reference-complete for important options | contract table records owner, argument, interaction, and effect | raw help remains the exhaustive spelling/default authority |
| C | reference-complete for documented language surface | algebra card, function tables, signatures, patterns, and examples | every possible DAG shape is not exhaustively fixture-tested |
| D | reference-complete | grammar, scope prefixes, quoting, operators, and consumer matrix are directly linked | external command/tool behaviour remains environment-dependent |
| E | reference-complete | type/method map, operators, formatting, labels, JSON, and aliases are directly linked and outlined | external renderer/terminal colour differences |
| F | reference-complete for significant human-facing keys | task and family tables explain type/role/scope/version interaction | machine schema remains the release-diff authority |
| G | quick lookup | Git intention/non-equivalence table links to conceptual chapters | intentionally compact |
| H | workflow-demonstrated | directory card links to complete GitHub fieldbook and lifecycle recipes | GitHub server/UI not locally exercised |
| I | workflow-demonstrated | directory card links to complete Gerrit fieldbook and identity recipes | Gerrit server/plugins not locally exercised |
| J | workflow-demonstrated | incident card links to recovery fieldbook, table, and commands | remote-server repair cannot be simulated locally |
| K | workflow-demonstrated | directory card links to shell, completion, pager, and automation fieldbook | shell/TUI differences remain platform-dependent |

### Current evidence boundary

The current single measurement method is the HTML parser used by
`scripts/write-completeness-report.sh`: it excludes only `pre`, `script`, and
`style` element content and counts rendered text nodes. It reports approximately
102,796 substantive words. The current PDF is 510 pages: two pages of generated
contents followed by the body. The revised target is 100,000–130,000 words;
the current manuscript is near its lower bound, but depth and reference status
remain independent acceptance criteria.

The print build now uses renderer-supported, explicit properties and
PDF-specific footer/outline mechanisms. Graphs use ASCII-safe diagram glyphs,
and the PDF validator rejects missing-glyph substitutions, checks page-number
footers, checks Appendix A–K contents entries, and checks the selected deep
reference outline destinations. Pinned PDFium samples are rendered and
inspected by `just visual`; the representative pages and observations are in
`research/print-acceptance.md`.
