# Historical first-review MAJOR findings

> These findings describe the pre-expansion baseline. The current follow-up
> findings supersede their status and are in `followup-majors.md`.

## M-001

ID: M-001  
Severity: MAJOR  
Area: `uv` tooling  
File: repository root; `justfile:1-30`; `scripts/write-completeness-report.sh:11-22`  
Section: Python dependency/execution policy  
Claim or issue: The project has no `pyproject.toml`, no `uv.lock`, no declared Python version, and no `uv sync` setup.  
Evidence: `uv sync` fails with `No pyproject.toml found`; `find` found no `pyproject.toml` or `uv.lock`. The only Python execution is `uv run --no-project python` inside the report script.  
Why it matters: The requirement explicitly mandates uv-managed Python execution and expects reproducible setup/lockfile patterns. The current ad hoc no-project invocation does not define a reproducible project environment.  
Required fix: Either remove Python from normal project operations entirely or add a minimal declared uv project with supported Python version, dependencies, lockfile, and `uv sync`/`uv run` recipes. Do not add pip/venv alternatives.  
Suggested validation: `uv sync --frozen` from a clean checkout, then run every Python-backed just recipe with `uv run`; inspect the repository for forbidden parallel setup instructions.

## M-002

ID: M-002  
Severity: MAJOR  
Area: CLI completeness  
File: `src/book.html:2680-3610`, `research/command-inventory.md`  
Section: Exhaustive CLI reference  
Claim or issue: The completeness report overstates canonical command coverage.  
Evidence: Independent inventory from the installed 0.44.0 CLI captured 120 paths. Comparing canonical paths to `<article class="command-entry">` headings found these inventory paths missing: `jj operation abandon`, `diff`, `integrate`, `log`, `restore`, `revert`, and `show`. The book instead has `jj op ...` alias headings. It also contains a `jj converge` article, which is 0.45.1-only and not a 0.44 canonical path.  
Why it matters: The section calls itself exhaustive and the acceptance criterion requires every public command/subcommand. Aliases are useful, but they do not prove canonical discoverability or cover every option/semantic contract.  
Required fix: Add canonical `operation` paths or explicitly map aliases to canonical paths in the reference and inventory checker. Mark every 0.45-only entry as comparison-only and make the completeness report distinguish canonical commands, aliases, and version additions.  
Suggested validation: Regenerate the 0.44 command tree, normalize aliases only in a separately labelled column, and assert exact set equality for canonical reader entries.

## M-003

ID: M-003  
Severity: MAJOR  
Area: Revsets / executable examples  
File: `src/book.html:521-527`, `src/book.html:803-810`  
Section: Metadata predicates and pattern arguments  
Claim or issue: `author(email:"...")` and `committer(email:"...")` are presented as 0.44 revsets, but `email:` is not a valid jj string-pattern kind.  
Evidence: Running jj 0.44.0 against `author(email:"dev@example.org")` fails: `Invalid string pattern kind email:` and suggests `exact`, `glob`, `regex`, or `substring`. The local help exposes `author_email(pattern)` and `committer_email(pattern)`.  
Why it matters: These are copyable examples in a language chapter. They fail before selecting any revision and teach the reader an invalid grammar.  
Required fix: Replace with forms such as `author_email(exact:"...")` or `author(exact:"...")`, then execute every language example against the target binary.  
Suggested validation: Extract all revset code examples, run valid examples in disposable 0.44 repositories, and maintain expected-output assertions for representative queries.

## M-004

ID: M-004  
Severity: MAJOR  
Area: Workspaces / sparse working copies  
File: `src/book.html:2170-2175`, `src/book.html:3364-3388`  
Section: Sparse commands  
Claim or issue: The book repeatedly gives `jj sparse edit 'root-glob:tests/**'` as if `sparse edit` accepts fileset arguments.  
Evidence: jj 0.44.0 help says `Usage: jj sparse edit [OPTIONS]` and describes opening an editor; executing it with that argument returns `unexpected argument 'root-glob:tests/**'`. `sparse set` is the pattern-taking command.  
Why it matters: This is a direct command failure in the fileset/workspace material and can mislead readers into believing a path selection was applied when no command can parse it.  
Required fix: Separate `sparse edit` (interactive config editor) from `sparse set`/`reset` pattern operations, and validate all sparse examples against 0.44.0.  
Suggested validation: Run every sparse command in a disposable repository and assert the resulting materialized path set, not only exit status.

## M-005

ID: M-005  
Severity: MAJOR  
Area: Workspaces / CLI reference  
File: `src/book.html:1981`, `src/book.html:3564-3568`  
Section: Workspace rename  
Claim or issue: The example `jj workspace rename build ci` uses two positional arguments, but 0.44 accepts only the new name for the current workspace.  
Evidence: jj 0.44.0 reports `Usage: jj workspace rename [OPTIONS] <NEW_WORKSPACE_NAME>` and executing the book’s two-argument form returns `unexpected argument 'ci' found`.  
Why it matters: This is an executable reference error in a section intended to be exhaustive and in a workflow that readers may copy.  
Required fix: Use `jj workspace rename ci` while operating in the workspace being renamed, or document the supported repository/name selection mechanism if one is needed.  
Suggested validation: Execute the corrected command in the workspace fixture and assert the old symbol disappears and the new symbol resolves.

## M-006

ID: M-006  
Severity: MAJOR  
Area: Configuration  
File: `src/book.html:2102-2107`  
Section: Immutable heads and repository policy  
Claim or issue: The example uses `[revsets] immutable_heads = '...'` as the immutable-head configuration.  
Evidence: jj 0.44 help documents the setting as `revset-aliases."immutable_heads()"`; the book’s key is accepted as an arbitrary unknown config key but has no effect. With `--config 'revsets.immutable_heads="none()"'`, `immutable_heads()` still returns the default set; the correctly named alias changes the result.  
Why it matters: This example presents a safety policy that silently fails to protect the intended revisions. A user may believe trunk/tags are immutable while jj continues using the default or a different policy.  
Required fix: Replace the example with the target-version `revset-aliases."immutable_heads()"` form, explain the default alias, and show an assertion that the protected set changes.  
Suggested validation: Load the example as a 0.44 config, query `immutable_heads()`, attempt a protected rewrite, and assert both protection and expected error output.

## M-007

ID: M-007  
Severity: MAJOR  
Area: Validation quality  
File: `scripts/validate-examples.sh`, `scripts/validate-revsets.sh`, `scripts/validate-templates.sh`, `scripts/validate-workspaces.sh`  
Section: Semantic validation  
Claim or issue: The project’s validation report claims semantic checks, but the validators generally check only that commands exit successfully.  
Evidence: Revset and template outputs are redirected to `/dev/null`; there are no assertions on selected IDs, graph topology, bookmark targets, or rendered fields. `validate-examples.sh` runs `git status`/`show-ref` without checking expected values, and uses `|| run squash --into @` fallback. `validate-workspaces.sh` explicitly ignores `workspace update-stale` failure with `|| true`.  
Why it matters: Exit-status-only checks can pass while selecting the wrong revision, producing the wrong bookmark, rendering the wrong template, or failing to exercise a lifecycle. This is exactly the class of error found in the revset workbook and invalid examples.  
Required fix: Add machine-readable assertions for graph edges, IDs/change IDs, bookmark/remote targets, conflict predicates, operation transitions, sparse paths, and expected template output. Remove failure-masking fallbacks except where the expected alternative is explicitly asserted.  
Suggested validation: Run `just test`/`just validate` in isolated configs and have each fixture emit and compare stable symbolic state rather than only command exit status.

## M-008

ID: M-008  
Severity: MAJOR  
Area: Provenance/licensing records  
File: `research/licenses.md`, `research/sources.md`, `research/book-license.md`  
Section: Licence/provenance inventory  
Claim or issue: The ledger is a high-level policy note, not the required per-source provenance inventory.  
Evidence: The table does not provide, for each substantive source, the required URL/repository, author/owner, material used, use type, licence source, attribution obligation, modification notice, redistribution conditions, final-book inclusion, and compliance status. Gerrit is recorded as “consult the current documentation” rather than as exact pages/versioned sources. Raw generated jj help snapshots are distributed but are not separately itemized as reproduced/generated material with an exact source/version and notice mapping.  
Why it matters: A conservative assertion that the book contains no copied passages is not evidence for every incorporated research output, generated help file, code example, configuration example, or future expansion. Significant unresolved provenance is a release risk.  
Required fix: Create a row-level provenance inventory covering every external source and every shipped generated/copy-like material. Record authoritative licence URLs, exact source versions/pages, use type, obligations, and compliance status. Add a distribution notice file or a clearly designated equivalent and name the attribution required for CC BY material.  
Suggested validation: Review every external URL and every non-original file/asset against its authoritative licence; verify that final HTML/PDF and repository distributions carry the required notices.

## M-009

ID: M-009  
Severity: MAJOR  
Area: GitHub workflow depth  
File: `src/book.html:1378-1502`  
Section: Part VII  
Claim or issue: GitHub is presented as a lifecycle chapter but contains roughly 810 prose words and cannot substantiate the requested single-PR, stacked-PR, fork/upstream, review-iteration, merge, rejection, and `gh` interaction coverage.  
Evidence: The independent Part VII word count is approximately 810. The text states server/UI behaviour is not locally validated, but provides no substantial before/after repository states for several lifecycle branches and no evidence-backed `gh`/Git state experiments.  
Why it matters: The intended advanced reader uses GitHub for publication; a short recipe does not explain how local mutable graph state and GitHub refs diverge over a PR lifecycle.  
Required fix: Expand the chapter with reusable fixture graphs, local transport experiments, explicit server-dependent boundaries, review feedback, early-stack rewrites, main movement, rejected pushes, merge/close/replace cleanup, and fork/upstream topology.  
Suggested validation: Run a local bare-remote lifecycle fixture and separately cite official GitHub documentation for server/UI claims; assert each bookmark and remote-bookmark transition.

## M-010

ID: M-010  
Severity: MAJOR  
Area: Gerrit workflow depth  
File: `src/book.html:1505-1688`  
Section: Part VIII  
Claim or issue: Gerrit treatment is still a compact narrative rather than the requested multi-change, multi-review lifecycle.  
Evidence: The section is approximately 1,672 words and repeatedly defers exact behavior to server setup. It does not provide a runnable local fixture for footer preservation/re-upload semantics or a sufficiently detailed evidence matrix separating local Git transport from Gerrit server behavior.  
Why it matters: Gerrit identity and patch-set association are high-risk areas; the reader needs exact commit/change/Gerrit identity transitions, re-upload, partial landing, trunk movement, conflict, and abandonment/replacement scenarios.  
Required fix: Build the three-change/two-review narrative described in the expansion plan, preserve and inspect footers, and mark every server-dependent claim with authoritative documentation evidence.  
Suggested validation: Use local Git fixtures to validate commit messages/ref mechanics and document server-side patch-set behavior as documentation-verified unless a safe Gerrit fixture is available.

## M-011

ID: M-011  
Severity: MAJOR  
Area: Conflicts, operation log, workspaces  
File: `src/book.html:1658-2178`  
Section: Parts IX–XI  
Claim or issue: These subjects remain materially underdeveloped relative to the required lifecycle laboratories.  
Evidence: Part IX is approximately 838 words, Part X approximately 1,869, and Part XI approximately 171 prose words. The completeness report admits that full conflict, sparse, fixer, signing, and interactive laboratories remain unrun.  
Why it matters: Stored conflicts, operation-DAG recovery, workspace-local `@`, and multi-machine handoff are core differentiators from Git and are safety-sensitive. Compact descriptions cannot establish propagation, recovery granularity, or what transfers across clones.  
Required fix: Add disposable conflict/recovery/workspace scenarios with before/after commit and operation graphs, exact commands, expected state, failure branches, and verified limits.  
Suggested validation: Add semantic fixture assertions for conflict predicates and resolution, `op show/diff/restore/revert/abandon`, stale workspaces, sparse paths, and cross-clone bookmark transport.

## M-012

ID: M-012  
Severity: MAJOR  
Area: Reader-facing references  
File: `src/book.html:4390-4709`  
Section: Appendices B–F and CLI/language references  
Claim or issue: The promised option, revset, fileset, template, and configuration references are not reference-complete.  
Evidence: The reference appendices contain compact tables and generic guidance, while the report itself says “a final pass must reconcile the remaining grouped appendix rows”. Fileset exact syntax is explicitly delegated to installed help at `src/book.html:934-935`; the global option section says raw help is the option authority at `src/book.html:3607`; the configuration section calls the schema the exhaustive inventory at `src/book.html:2029`.  
Why it matters: The acceptance criteria require the book itself to function as a serious reference; research captures may substantiate it but cannot replace it.  
Required fix: Add reader-facing signatures, accepted cardinality, option interactions/defaults, state effects, version notes, and cross-links for all important target-version surfaces. Keep raw captures as evidence, not as the only source of detail.  
Suggested validation: Cross-check every reference row against the 0.44 help/schema and mark each item inventory-complete, reference-complete, explained, or empirically validated.

## M-013

ID: M-013  
Severity: MAJOR  
Area: Version reproducibility  
File: `justfile:17-18`, `research/completeness-report.md:28-35`  
Section: 0.45.1 comparison track  
Claim or issue: The repository has a 0.45.1 binary in this checkout, but the comparison recipe is allowed to succeed while the binary is absent and the report does not prove that the comparison snapshot was generated by the current clean build.  
Evidence: `compare-045` has an `else` branch that prints a warning and exits successfully. The report states 0.45.1 inventory/help was validated, but normal setup only installs 0.44.0 and there is no recipe to install or verify the pinned 0.45.1 comparison binary.  
Why it matters: A release comparison that silently degrades to “not installed” can leave version labels stale while the build remains green.  
Required fix: Pin and provision the comparison toolchain or make the comparison recipe fail when the declared comparison track is required; record binary checksums/version and generation commands.  
Suggested validation: Run the full clean setup in an environment without `.toolchain/jj-0.45` and ensure the declared policy either provisions it or fails clearly.
