# Historical follow-up review

> Superseded as the current authoritative review by
> [`current-structure-content-review.md`](current-structure-content-review.md),
> dated 2026-09-10. The findings below are retained as historical evidence.

Review date: 2026-09-10 UTC  
Project: `Jujutsu for Git Experts: Graph-First Version Control`  
Last reviewed authored baseline: jj revision ID
`quuzlkxpumqqvnsyulpyvoxtytooqkpy`; commit ID
`9cd34b5eb7ff2e56e338a5de53bd4164b4487e92`

The project owner has now explicitly changed the target policy: jj 0.45.1 is
the sole normative target and all 0.44.0 material is obsolete. This review
therefore evaluates the latest authored correction against jj 0.45.1 only.
Earlier review reports remain historical evidence; the current structural and
content review is in the linked report.

## Verdict

**REQUIRES MAJOR REVISION**

The version-policy blocker is resolved by the owner’s explicit target change.
The latest authored correction fixes the previously rejected 0.45.1 command
examples, restores the depth/expansion records, refreshes the PDF acceptance
record, and adds executable CLI-example validation. One MAJOR finding remains:
the replacement licensing register still does not contain all required
per-source obligation fields or authoritative evidence.

This verdict is subject to the documented evidence boundary: GitHub/Gerrit
server behaviour, real signing hardware, and external interactive tools are
documented or schema/help validated but are not live-tested in this local
review environment.

## Baseline and commands

Environment: Linux; Git 2.53.0; `uv 0.12.10`; `just 1.45.0`; jj 0.45.1 at
`.toolchain/bin/jj`.

Executed successfully:

```text
just review
./.toolchain/bin/jj version
./.toolchain/bin/jj help
./.toolchain/bin/jj help --help
uv sync --locked
just --list
```

Results from the clean review pass:

```text
jj                                   0.45.1
HTML                                 992 ids, 72 internal links
CLI                                  121 canonical 0.45.1 paths
PDF                                  510 pages, 540 x 720 pt, 9 fonts,
                                     14 URI links, 319 outline entries
printed contents                     2 pages; body begins on page 3
root HTML                            symlink -> src/book.html
root PDF                             symlink -> build/jj-book.pdf
fixture suite                        all project validation suites passed
PDFium samples                       15 current samples rendered and inspected
```

Current PDF SHA-256:
`52ec46f94a681110bde55f7286caa2a3caa2b81097f85e7bd9ed590ae7e5b05e`.

The current substantive authored count is 103,639 words by the project's
documented counting method. The PDF is 510 pages in the current 100,000–130,000
word / approximately 450–600-page design range. The contents listing is two
pages for a 510-page book; its spacing, body start on page 3, and inspected
navigation are acceptable.

## Latest authored revisions rechecked

The latest authored correction is jj revision ID
`mlnyzsxyywlzqyyrkmrlnllxzkqluskn`, commit ID
`cdeea668dc56d31792b7b36d6dc7f0ee2ea79f5a`, titled “Address latest 0.45.1
review findings”. It restores the target-version audit records, corrects the
remaining command examples and counts, updates the PDF acceptance record, and
adds a CLI-example validation recipe.

## Findings in changes since the last review

### FUP13-M-001 — licensing register still omits required per-source obligations

ID: FUP13-M-001  
Severity: MAJOR  
Area: licensing and provenance compliance  
File: `research/licenses.md:26-46`; `research/sources.md`; `THIRD_PARTY_NOTICES`  
Section: current distributed-material register

Claim or issue: the new register improves the previous high-level ledger, but
it still does not record all required fields separately for each substantive
external source/material: URL or repository, author/owner, material used, use
type, licence, licence source, attribution required, modification notice
required, redistribution conditions, included-in-final status, compliance
status, and notes.

Evidence: the current table has columns `Item`, `Source and owner`, `Use type`,
`Licence/terms source`, `Included in final deliverable`, and `Compliance
decision and notes`. It has no dedicated attribution, modification-notice, or
redistribution-condition fields. Several rows use broad statements such as
“Git project licensing applies”, “Gerrit ... repository notices”, or “package
metadata and package notices” without identifying the exact authoritative
licence file/page and applicable terms for the material actually distributed.
The current `research/sources.md` is a URL list and source trail, not a
row-level obligation record.

Source material: Jujutsu documentation/source/help captures; Git, GitHub, and
Gerrit documentation; generated help/inventory material; Python/Rust build and
inspection dependencies; and any fonts, images, diagrams, CSS, or code copied
or adapted into the deliverable.

Source licence: the current records identify Jujutsu as Apache-2.0, the book
as CC BY 4.0, and describe other sources as varying or service-dependent. The
authoritative licence source for each included item is not consistently
recorded at row level.

Use type: factual verification, paraphrase, generated/captured help,
library/dependency, and any reproduced or adapted code/assets as applicable.

Applicable obligation: determine the licence and licence source for each
material; record attribution, modification, and redistribution conditions;
preserve required notices; distinguish facts from copied/adapted text, code,
diagrams, and assets; and do not infer permission from public accessibility.

Compliance status: unresolved audit evidence. No specific infringement or
unlicensed asset was proven in this pass, and the current book claims no
third-party visual assets or long quotations. That conservative design does not
remove the need to document the obligations for the retained generated help,
research captures, dependencies, and every source actually incorporated.

Why it matters: the release still cannot demonstrate from its own records that
all distributed copy-like/generated material has a legal basis and that
required notices and attribution are satisfied. This remains a release
compliance risk even though the direct asset risk appears low.

Required fix: extend the register or provide a linked per-source inventory
with the required fields for every external source and shipped/generated
material. Use authoritative repository licence files, documentation copyright
pages, package metadata, and dependency notices. Map each row to the final
HTML/PDF/research files, record “not applicable” with a reason where a field
does not apply, and retain the Apache notice and CC BY attribution requirements.

Suggested validation: compare the register with the complete distributable
file list and dependency lock; inspect every external licence/copyright source;
search the HTML, CSS, scripts, help captures, diagrams, fonts, and images for
incorporated material; verify notices in the distributed tree; and rerun the
licence audit.

## Historical prior-review findings (superseded)

The findings below document the preceding review state. FUP12-B-001,
FUP12-M-001 through FUP12-M-006, and FUP12-m-003/m-007 were rechecked against
the latest authored correction: the version-policy item is resolved by the
owner’s explicit target change, the command/count defects are corrected, the
depth/expansion records are restored, and the PDF acceptance record is current.
Only FUP13-M-001 above remains open.

### FUP12-B-001 — mandatory normative version policy was changed without authorization

ID: FUP12-B-001  
Severity: BLOCKER  
Area: target-version policy and reproducibility  
File: `README.md:7,17,25`; `src/book.html:31,112-113`; `justfile:11-12`; `research/version-matrix.md:9-23`  
Section: version policy

Claim or issue: the project changes the accepted policy from jj 0.44.0 as
normative with jj 0.45.1 as a clearly separated comparison track to jj 0.45.1
as the sole normative release. The standing brief permits that change only if
the project requirements have changed; no such change was supplied.

Evidence: current files call 0.45.1 the “sole normative release surface” and
the only provisioned binary. The authored revisions also delete the 0.44.0
help, schema, and inventory captures. The previous reviewed baseline and the
standing acceptance brief explicitly identify 0.44.0 as normative and 0.45.1
as comparison. The 0.45.1 command surface is not identical: it adds `converge`
and changes other release-sensitive command/reference material.

Why it matters: this silently changes the declared deliverable and removes the
evidence needed to reproduce the previously agreed target. Passing validation
against 0.45.1 cannot establish compliance with a 0.44.0 normative book, and
unlabelled migration changes can make the reader’s commands depend on a
different release than the approved one.

Required fix: restore jj 0.44.0 as the normative baseline and retain jj 0.45.1
as a clearly labelled comparison track, including both binaries, help/schema
captures, inventories, fixtures, and labels in the prose. Alternatively,
obtain an explicit requirement change before adopting 0.45.1 as the sole
target; that change must then be recorded rather than inferred from the commit.

Suggested validation: provision both pinned binaries; run `jj version`, root
help, recursive inventory, schema capture, and fixture validation for each;
diff the command/options/config/revset surfaces; label every comparison-only
feature; run `just review` for the approved normative target and rebuild.

### FUP12-M-001 — repeated `jj fix` examples use rejected 0.45.1 syntax

ID: FUP12-M-001  
Severity: MAJOR  
Area: CLI examples, fixer workflows, and target-version accuracy  
File: `src/book.html:1777,5376,5467,5470,5658,8097`  
Section: filesets, advanced mechanics, fixer laboratories, configuration reference

Claim or issue: several reader-facing examples use `jj fix -r ...`, and the
configuration table presents `jj fix -r @ --dry-run` as a supported form.

Evidence: the target command reports `Usage: jj fix [OPTIONS] [FILESETS]...`
and accepts `-s/--source`, `--include-unchanged-files`, and `-a/--all-lines`;
it rejects both `jj fix -r @ --help` and `jj fix --dry-run --help` with exit 2.
The earlier command-reference entry at `src/book.html:4501-4507` correctly
uses `-s`, demonstrating an internal migration inconsistency.

Why it matters: these are executable examples in multiple teaching and
reference contexts. A reader copying them receives an option error or is led
to believe that a target-release dry-run mode exists. The error is especially
dangerous because fixer selection can rewrite a broad commit domain.

Required fix: replace every target-release `jj fix -r` with the documented
`-s/--source` form where commit selection is intended. Remove the unqualified
`--dry-run` example; explain that `jj fix` has no target-release dry-run option
and give a safe small-domain/undo inspection procedure instead. Keep any
future-release comparison explicitly labelled.

Suggested validation: search all book code blocks for `jj fix`; parse every
displayed invocation with `.toolchain/bin/jj fix ... --help` or execute it in
a configured disposable fixer fixture; verify source scope, fileset scope,
and descendant effects; rerun `just review`.

### FUP12-M-002 — repeated bisect examples use nonexistent options/subcommands

ID: FUP12-M-002  
Severity: MAJOR  
Area: CLI examples and bisection workflow  
File: `src/book.html:5664-5666,6604-6607`  
Section: advanced mechanics and bisect dossier

Claim or issue: the book shows `jj bisect --range ...`, `jj bisect run
--revision ...`, and `jj bisect log`/`jj bisect reset`.

Evidence: jj 0.45.1 rejects the parent `--range` option, rejects
`bisect run --revision`, and reports `log` and `reset` as unrecognized
subcommands. The target syntax is `jj bisect run --range REVSETS [COMMAND]
[ARGS]...`; the installed help documents `-r/--range` on `bisect run` and no
`log` or `reset` subcommands. The earlier command entries at
`src/book.html:4228-4239` use the correct `bisect run --range` form, so the
later dossiers are stale rather than an intentional alternative.

Why it matters: this makes the advanced bisection laboratory fail before it
can demonstrate the claimed graph-search workflow and sends the reader to
nonexistent lifecycle commands.

Required fix: use `jj bisect run --range ...` consistently, remove the
nonexistent `log`/`reset` commands, and explain the target release’s actual
post-run inspection/recovery boundary. Do not imply a standalone bisect state
subcommand unless it exists in the target help.

Suggested validation: run each displayed bisect command against the pinned
binary and a disposable monotonic test repository; record exit-status
semantics, the selected candidate, and the operation/working-copy state.

### FUP12-m-003 — two isolated file-command examples fail against 0.45.1

ID: FUP12-m-003  
Severity: MINOR  
Area: CLI examples  
File: `src/book.html:5595-5596`  
Section: command dossiers for `file search` and `file chmod`

Claim or issue: the examples use `jj file search -r '::@' 'root-glob:src/**'
'TODO'` and `jj file chmod +x 'root-file:scripts/check.sh'`.

Evidence: `jj help file search` requires `--pattern PATTERN` and accepts a
fileset separately; the displayed search command exits 2 because `--pattern`
is missing. `jj help file chmod` accepts modes `n`/`x` (aliases `normal` and
`executable`), and rejects `+x`. The command-reference entry at
`src/book.html:4463-4480` contains the correct option/mode model.

Why it matters: these are copyable examples in a command dossier and are
contradictory to the target-version reference immediately elsewhere.

Required fix: write the search form with `--pattern 'TODO'` and use mode `x`
for executable state. Validate the corrected forms in the fixture.

Suggested validation: run the exact corrected commands with a disposable tree,
including a path restriction and an executable-bit assertion.

### FUP12-M-004 — required depth and expansion audit records were removed

ID: FUP12-M-004  
Severity: MAJOR  
Area: completeness/depth auditability  
File: deleted `research/depth-audit.md` and `research/expansion-plan.md`;
`research/completeness-report.md`  
Section: expansion workflow and completeness evidence

Claim or issue: the corrective task required a per-Part/chapter/section depth
audit and a chapter-by-chapter expansion plan. Both records were present in the
previous authored state and are deleted by the 0.45.1 migration. The current
completeness report asserts that the book is conceptually explained and
workflow-demonstrated, but no current record preserves the requested
mentioned/introduced/explained/demonstrated/explored/reference-complete audit
or the planned examples, DAGs, experiments, dependencies, and size estimates.

Evidence: `test -e research/depth-audit.md` and `test -e
research/expansion-plan.md` fail; the prior authored revision contains both
files. The current book remains 103,525 substantive words and 510 pages, but
size alone cannot demonstrate depth or distinguish a developed chapter from a
summary/reference table.

Why it matters: this removes the independent evidence needed to verify that
the 450–600-page technical-book expansion was deliberate and complete. It also
makes the current completeness claims substantially harder to audit after the
large version migration.

Required fix: restore current, target-version-consistent depth and expansion
records, or replace them with equivalent records that cover every Part,
chapter, section, appendix, preserved material, new experiments, graph
fixtures, reference additions, and resulting size. Keep them in the repository
and make the completeness report link to them.

Suggested validation: compare the audit against the HTML heading tree; verify
each planned experiment/reference/workflow exists in the book; independently
measure substantive words and pages; rerun the completeness and PDF checks.

### FUP12-M-005 — row-level provenance evidence was deleted

ID: FUP12-M-005  
Severity: MAJOR  
Area: licensing and provenance compliance  
File: deleted `research/provenance.md`; current `research/licenses.md`,
`research/sources.md`, `THIRD_PARTY_NOTICES`  
Section: source/provenance inventory

Claim or issue: the migration deletes the prior row-level provenance inventory
and leaves a high-level licensing table. The current record does not provide,
for each substantive source/material, the required URL or repository,
author/owner, material used, use type, licence source, attribution and
modification obligations, redistribution conditions, included-in-final status,
compliance status, and notes. It also no longer contains the page-level source
map that tied chapters and generated captures to their sources.

Evidence: the current `research/licenses.md` has broad rows for jj, Git,
GitHub, Gerrit, Rust crates, and Python packages, but not the required fields
or exact incorporated-material mapping. The current notices refer readers to
that summary. The regenerated `research/command-inventory.md` also retains a
hard-coded `Generated from ... on 2026-09-06` date even though this review ran
the generator on 2026-09-10. The deleted `research/provenance.md` contained the more detailed
JJ-DOC, JJ-CLI, JJ-SOURCE, Git/GitHub/Gerrit, image, build, font, and page-map
records.

Source material: Jujutsu documentation/source/help captures; Git, GitHub, and
Gerrit documentation; generated help/inventory material; Python/Rust build and
inspection dependencies; fonts/assets if any are later included.

Source licence: current records identify Jujutsu as Apache-2.0 and the book as
CC BY 4.0, while stating that Git/GitHub/Gerrit terms vary or are service
terms. Those are the available licence assertions; the deleted row-level
record’s authoritative URLs and exact source versions must be restored or
re-established for each material actually distributed.

Use type: factual verification, paraphrase, generated/captured help,
library/dependency, and any reproduced or adapted code/assets as applicable.

Applicable obligation: determine the actual licence and licence source for each
material; preserve required notices and attribution; distinguish facts from
copied/adapted text, code, diagrams, and assets; do not infer permission from
public accessibility.

Compliance status: unresolved audit record; no specific infringement or
unlicensed asset was proven in this pass, but significant provenance cannot be
verified from the current ledger alone.

Why it matters: the release cannot demonstrate that all distributed
copy-like/generated material has a legal basis and the required notices. This
is a compliance-evidence regression even though the current conservative asset
statement reduces the apparent direct infringement risk.

Required fix: restore/rebuild the row-level ledger from authoritative licence
locations, map every included source/material to final HTML/PDF/research
outputs, preserve applicable notices, refresh generated timestamps from the
actual build date, and record explicit compliance status or uncertainty. Do
not resolve rows by asserting that material was not copied without checking the
actual generated/captured outputs.

Suggested validation: audit every external source and generated capture;
inspect repository/package metadata and licence files; search for close prose,
code, diagrams, fonts, images, CSS, and scripts; compare the ledger with the
distributed file list; rerun the licence audit before release.

### FUP12-M-006 — the reader-facing CLI reference reports stale totals

ID: FUP12-M-006  
Severity: MAJOR  
Area: CLI completeness and internal consistency  
File: `src/book.html:4141`; `research/command-inventory.md:131`;
`research/completeness-report.md:12-16`  
Section: Part XV introduction

Claim or issue: the Part XV introduction says the local binary reports 46
top-level commands and 120 public command paths, while the current 0.45.1
inventory and generated completeness report report 47 top-level commands and
121 paths.

Evidence: `./.toolchain/bin/jj version` reports 0.45.1; `just review` reports
`CLI reference valid: 121 canonical jj 0.45.1 paths`; the inventory ends with
`121 command paths (including nested paths)`. The current source’s 46/120
sentence is the old pre-migration count. `jj converge` is now in the target
inventory and reference.

Why it matters: this is an explicit numerical claim in a section titled
“Exhaustive CLI reference”. A reader cannot tell whether one path is missing,
misclassified, or merely omitted from the count, and the count conflicts with
the project’s own release evidence.

Required fix: update the sentence to the generated 0.45.1 totals and make the
validator fail if reader-facing prose contains stale totals. Reconcile the
top-level/path definition so the number can be independently reproduced.

Suggested validation: regenerate the inventory from the pinned binary; count
top-level and nested paths using the documented method; compare those values
with the book, completeness report, and command-entry headings; rerun `just
review`.

### FUP12-m-007 — print-acceptance record predates the current edition

ID: FUP12-m-007  
Severity: MINOR  
Area: PDF acceptance evidence  
File: `research/print-acceptance.md:3,16-28`  
Section: independent visual inspection

Claim or issue: the checked-in acceptance record says the edition was checked
on 2026-09-06 and records page-specific observations from the earlier edition,
but the current target migration and fileset edit produced a current PDF on
2026-09-10. The current workspace/configuration samples are at pages 169, 172,
177, 184, and 186, while the record refers to earlier page locations.

Evidence: current `just review` generated PDF SHA-256
`a56537cd1d31c342d6da82cf03377e9b834ae82922d6e17ce37b46a9d5380e72` and 15
current PDFium samples. `research/print-acceptance.md` still names the
2026-09-06 edition and does not record that checksum or the current sample
set.

Why it matters: a reader or release operator could mistake a prior visual
inspection for acceptance of the distributed PDF. The PDF currently looks
readable and has no observed black blocks, clipping, or missing-glyph defects,
but the repository record should identify the exact inspected artefact.

Required fix: regenerate/update the acceptance record after the final
target-version source is settled, including date, PDF checksum, page/sample
locations, and observations. Keep prior inspections explicitly historical.

Suggested validation: run `just review`, inspect the current 15 PDFium samples,
record the checksum and page locations, and verify the record matches the
generated artefacts.

## Historical previous findings rechecked

### FUP5-M-001 — workspace expansion ordering and duplication

**Status: CLOSED.**

The source now has one workspace laboratory under Part XII. Part XII starts
at `src/book.html:3120`, contains the workspace model, laboratory,
build/review invariants, stale-workspace, sparse, cleanup, two-machine, and
concurrency material, and closes at line 3244. Part XIII begins immediately at
line 3246 and its configuration material is contiguous through the end of the
part. No `Workspace laboratory: shared graph, independent working directories`
section remains.

`scripts/validate-structure.py` parses the heading order and fails if required
workspace headings are absent or if workspace headings reappear after Part
XIII begins. The clean run reported:

```text
structure valid: Part XII workspace material precedes contiguous Part XIII (5 workspace headings before configuration)
```

The PDF contents and outline now lead into the single Part XII treatment, and
the inspected pages show the Part XII–Part XIII transition without an
intervening workspace section.

### FUP5-m-001 — visual recipe and current contents coverage

**Status: CLOSED.**

`scripts/render-visual-samples.py` clears `build/visual-inspection` before
rendering, includes fixed pages 1–4, and locates the current Part XII,
workspace laboratory, Part XIII, configuration laboratory, and configuration
reference headings after the body boundary. The clean run generated 15 PNG
samples, including `page-002.png` for the second contents page and current
workspace/configuration samples at pages 168, 171, 176, 183, and 185.

PDFium inspection found readable margins, no clipping, no black-square or
replacement glyphs, and usable code/table presentation. The second contents
page ends before the preface; the preface begins on page 3. The revised
observations are recorded in `research/print-acceptance.md`.

### FUP5-m-002 — stale-workspace wording

**Status: CLOSED.**

The book now defines jj 0.44 stale state in terms of the recorded
working-copy commit no longer being current for that workspace after a
repository operation. It explicitly distinguishes ordinary external edits,
moved directories, missing metadata, and native Git ref changes from stale
workspace metadata, and limits `workspace update-stale` to the stale-record
case.

`scripts/validate-workspaces.sh` now creates an external edit, verifies it via
`jj status`, runs `jj workspace update-stale`, asserts the “not stale” result,
and verifies that the edit survives. This passes in the clean review run.

### FUP6-m-001 — missing whitespace in a workspace diagram

**Status: CLOSED.**

Revision `lqloztuwxnnsuywpvpupryymswppzokp`, commit
`3ea73617d8bef81772fb80d054bf62270ef62367`, changed the label to
`workspace review: review@ = A (review baseline)`. The rebuilt PDF retains 510
pages and the relevant diagrams remain readable.

### FUP7-m-001 — completeness report records an obsolete PDF hash

**Status: CLOSED.**

The clean `just clean && just review` pass regenerated the completeness report
and checksum sidecar. Both now record the current PDF hash:

```text
research/completeness-report.md: 5b30c03a4aa32a9b6f6fd1a729f24491770ac64b6871aa083a8aec1e7993b0a0
build/jj-book.pdf.sha256:        5b30c03a4aa32a9b6f6fd1a729f24491770ac64b6871aa083a8aec1e7993b0a0
sha256sum build/jj-book.pdf:    5b30c03a4aa32a9b6f6fd1a729f24491770ac64b6871aa083a8aec1e7993b0a0
```

The reproducibility-record inconsistency is resolved.

### FUP8-m-001 — humanise backend-heavy content terminology

**Status: CLOSED.**

The latest authored jj revision ID
`rwutlnlqqvyvruupsklzqwntotymptlp`, commit ID
`e7aadf8b8071ffde27754d2a023ff836d0c195a3`, updates the reader-facing
wording to use “file contents” and “individual diff hunks” in the affected
passages. The remaining uses of “tree” are generally in explicit tree-versus-
patch or tree-endpoint explanations. This finding is resolved.

### FUP9-M-001 — date literal and range syntax is delegated and one example fails

**Status: CLOSED.**

The latest authored source now documents `after:"DATE"` as inclusive,
`before:"DATE"` as exclusive, the supported absolute and relative date-string
forms, shell/TOML quoting boundaries, and bounded intervals as an intersection
of date predicates. The invalid `author_date("2026-08-01..2026-09-01")`
example has been removed. `scripts/validate-revsets.sh` exercises the displayed
date forms and bounded-interval expressions with jj 0.44.0, and the clean
`just review` run passes.

ID: FUP9-M-001  
Severity: MAJOR  
Area: revset language reference and empirical correctness  
File: `src/book.html:1051-1052, 1171-1180, 1284-1293`  
Section: Patterns, dates, and aliases; Patterns and dates; Pattern and date arguments

Claim or issue: the book tells the reader that date literals and ranges use
the syntax documented by installed help instead of documenting that syntax in
the book. It also includes an invalid jj 0.44.0 example:
`author_date("2026-08-01..2026-09-01")`.

Evidence:

```text
Date patterns accept date literals and ranges using the syntax documented by the installed help.
Date patterns are parsed dates, ranges, and relative forms according to the installed revset help.
Date patterns should likewise be explicit. Use the installed help’s supported date forms...
jj log -r 'author_date("2026-08-01..2026-09-01")'
```

The target-version help capture
`research/help-revsets-0.44.0.md`, under “Date patterns”, defines date
patterns through `after:"string"` and `before:"string"`. It lists supported
date-string forms including `2024-02-01`, ISO date-time with and without an
offset, space-separated date-time, and relative forms such as `2 days ago`,
`5 minutes ago`, `yesterday`, `yesterday 5pm`, and `yesterday 10:30`.

An independent jj 0.44.0 probe produced:

```text
PASS author_date(after:"2026-01-01")
PASS author_date(before:"2026-09-01")
FAIL author_date("2026-08-01..2026-09-01")
Error: Date pattern must specify 'after' or 'before'
PASS author_date(after:"2026-08-01") & author_date(before:"2026-09-01")
```

Why it matters: this is a reader-facing language reference for an advanced
user, and the invalid example is presented as executable syntax. Delegating
the grammar to installed help defeats the book’s stated standalone-reference
purpose and makes a date-filtering query fail when copied verbatim.

Required fix: document the date-pattern grammar directly. Explain that
`after:` is inclusive, `before:` is exclusive, and a bounded interval is
formed by intersecting predicates, for example:

```text
author_date(after:"2026-08-01") & author_date(before:"2026-09-01")
```

Document the supported absolute and relative date-string forms, quoting rules,
the author-versus-committer choice, and reproducibility implications. Replace
the invalid range example and test every displayed date expression against the
pinned jj 0.44.0 binary. If the word “range” is retained, define it as the
intersection of `after:`/`before:` date predicates rather than implying that a
revset `..` expression is accepted inside a date argument.

Suggested validation: run each documented date form and bounded interval with
`./.toolchain/bin/jj log --ignore-working-copy -r ...`; assert the expected
success or parse failure; rerun `just review`; and inspect the rendered revset
pages for complete syntax rather than a help pointer.

### FUP10-m-001 — Git-backend edge case is delegated to installed help

**Status: CLOSED.**

The latest authored source states the same-path rule, contrasts it with an
external backing repository, and provides executable examples. The Git-backend
validation script tests both layouts against jj 0.44.0, and the clean
`just review` run passes.

ID: FUP10-m-001  
Severity: MINOR  
Area: CLI reference and Git-backend model  
File: `src/book.html:2023, 4589`  
Section: Git initialisation and `jj git init` command entry

Claim or issue: the book describes `--git-repo PATH` but tells the reader to
follow local help for the same-path special case instead of stating the case
directly.

Evidence:

```text
Follow the installed help for the same-path special case.
... subject to the same-path special case described by local help.
```

The jj 0.44.0 help states that when `--git-repo` points to the same directory
as the jj repository, both `.jj` and `.git` are in that working directory and
both jj and Git commands operate on the same colocated workspace. The book
already teaches colocation elsewhere, so this is a small but real gap in the
command’s standalone edge-case reference.

Why it matters: this option is part of the boundary between jj’s repository
view and the backing Git repository. A reader copying the command entry should
not need installed help to understand when an existing Git repository produces
a colocated workspace versus a non-colocated layout.

Required fix: state the same-path rule and its consequences in the Git-init
explanation and command entry. Keep the help reference as a version-validation
note, not as the only description of the edge case. Include a short example
and contrast it with an existing Git repository at a different path.

Suggested validation: run jj 0.44.0 with `--git-repo` pointing to the same
directory and to a different existing Git directory; verify the presence and
location of `.git`, the result of `jj git root`, and whether native Git can
operate in the workspace. Rebuild the CLI-reference pages.

### FUP11-M-001 — `jj git push` documents a nonexistent 0.44 option

**Status: CLOSED.**

The latest authored source removes `--allow-new`, documents the actual 0.44
publication options, and distinguishes new-bookmark publication from the
`--allow-private` and `--allow-conflicts` eligibility switches. The validation
fixture executes `--named` against a disposable bare remote and executes
`--change` with `--dry-run`. The installed 0.44 help and the regenerated
reader-facing entry now agree.

ID: FUP11-M-001  
Severity: MAJOR  
Area: CLI reference and Git publication safety  
File: `src/book.html:4629, 6559`  
Section: `jj git push` syntax/options and push-safety discussion

Historical claim: the previous 0.44 command reference and safety discussion
named `--allow-new` as a jj git-push option. That option is not present in the
pinned jj 0.44.0 CLI.

Evidence:

```text
Local help also defines --allow-new, --allow-empty-description, --change REVSET, ...
A syntactically valid push with --allow-new or backwards permission is not proof ...
```

The installed target command, `./.toolchain/bin/jj help git push`, lists
`--allow-empty-description`, `--allow-private`, `--allow-conflicts`,
`--change`, `--named`, and `--dry-run`; it does not list `--allow-new`.
The independent current help capture is
`research/cli-help-0.44.0.txt` under `git push`.

Why it matters: this is a reader-facing exhaustive CLI reference and the
affected passage is in the publication-safety material. A reader who copies
`--allow-new` will receive an unknown-option error, while the surrounding text
may lead them to believe it is the switch that permits creating a new remote
bookmark. Incorrect push-option guidance is especially risky at a publication
boundary.

Resolution: remove `--allow-new` from the 0.44 prose and replace it with
`--named NAME=REVISION`/`--change REVSET` for new-bookmark publication and the
actual `--allow-private`/`--allow-conflicts` eligibility options. No
version-unspecified “where supported” escape remains in the normative entry.

Suggested validation: run `./.toolchain/bin/jj help git push` and compare every
option in the `jj git push` entry and publication workflows against it. Execute
the corrected option examples in a disposable local remote, including new
bookmark, private-commit, conflicted-commit, and dry-run cases where applicable.
Rerun `just review`.

## Acceptance matrix

| Area | Status | Evidence |
|---|---|---|
| HTML-first source | PASS | `src/book.html` is authored semantic HTML; `jj-book.html` is a symlink. |
| HTML-to-PDF build | PASS | `just clean && just review` renders and validates the 510-page PDF. |
| Kindle Scribe layout | PASS | 540 × 720 pt portrait, two-page contents, page 3 body start, 15 PDFium samples inspected. |
| Glyph safety | PASS | PDF validation reports no black-square or replacement-glyph substitutions. |
| `uv` | PASS | Locked dependencies and Python execution use `uv sync`/`uv run --frozen`. |
| `just` | PASS | Normal setup, build, validation, review, visual inspection, and cleanup are exposed as recipes. |
| Root publication artefacts | PASS | `stat` reports symbolic links: `jj-book.html -> src/book.html`, `jj-book.pdf -> build/jj-book.pdf`. |
| Version discipline | PASS | jj 0.44.0 is normative; 0.45.1 comparison material is labelled. |
| Technical validation | PASS | Project fixtures pass, and the corrected CLI reference agrees with installed jj 0.44.0 help. |
| Licence/provenance | PASS | Source/use records, Apache notice, and excluded third-party assets are documented; no unresolved incorporated-material issue found. |
| Contents/navigation | PASS | Printed contents spans two pages; electronic outline has 322 entries; changed sections are ordered and reachable. |
| Duplication/order/depth | PASS | Workspace duplication is removed; the current depth matrix distinguishes teaching, practice, reference, and workflow roles. |
| Appendices | PASS | Compact directory cards are labelled as such and link to the denser revset/fileset/template/configuration and H–K fieldbook material. |
| Reader-facing terminology | PASS | The latest authored terminology pass uses “file contents” and “individual diff hunks” in the affected reader-facing passages. |
| Date literals and ranges | PASS | Date grammar, supported forms, interval construction, and validation coverage are now included. |
| Git-init same-path edge case | PASS | The colocated same-path and external-backing layouts are now explained and validated. |
| Git-push option accuracy | PASS | `--allow-new` was removed; `--named`, `--change`, and the actual `--allow-*` options are documented and exercised. |

## Remaining evidence boundaries

These are documented limits, not unresolved findings:

* GitHub and Gerrit server/UI behaviour is not live-tested; the book labels
  those effects as server-dependent and uses the authoritative documentation
  plus local transport/graph tests.
* Real GPG/SSH signing hardware, external merge/diff tools, interactive TUIs,
  and every possible DAG shape are outside the non-interactive local fixture
  scope.
* `research/appendix-audit.md` and earlier review files retain superseded
  historical assessments. At the time of that review, the later matrix in
  `research/depth-audit.md` and that report recorded the current status; the
  historical files should not be read as open findings.

The findings in this section were closed in the superseded 0.44.0 follow-up
review. They are retained as historical evidence; the current 0.45.1 review
status is the findings section at the start of this report.

## Reproduction

From the repository root:

```sh
just clean
just review
stat -c '%F %N' jj-book.html jj-book.pdf build/jj-book.pdf
find build/visual-inspection -maxdepth 1 -type f -name '*.png' | sort
```

The expected final artefacts are a regular `build/jj-book.pdf` and relative
root symlinks to the canonical HTML and generated PDF. The clean build
recreates those symlinks rather than replacing them with copied files.
