# Current follow-up review

Review date: 2026-09-07 UTC  
Project: `Jujutsu for Git Experts: Graph-First Version Control`  
Normative target: jj 0.44.0; comparison target: jj 0.45.1

This review rechecks the corrections made after the previous follow-up
review. It covers the workspace/configuration ordering and duplication issue,
stale-workspace semantics, the visual-sample recipe, the revised contents and
layout, and the resulting clean artefacts. Earlier review reports remain
historical evidence; this file is the current authoritative follow-up report.

## Verdict

**PASS WITH MINOR CHANGES**

No BLOCKER or MAJOR findings remain from the previous follow-up. One new MINOR
presentation finding is recorded below.
The clean build and validation pass, the canonical HTML remains first-class,
the PDF is regenerated from it, the root publication artefacts are real
relative symlinks, and the previously reported workspace duplication/order,
stale-state wording, and visual-sample coverage defects are corrected.

This verdict is subject to the documented evidence boundary: GitHub/Gerrit
server behaviour, real signing hardware, and external interactive tools are
documented or schema/help validated but are not live-tested in this local
review environment.

## Baseline and commands

Environment: Linux; Git 2.53.0; `uv 0.12.5`; `just 1.45.0`; jj 0.44.0 and
0.45.1 pinned under `.toolchain/`.

Executed successfully:

```text
just clean && just review
./.toolchain/bin/jj version
./.toolchain/bin/jj help
./.toolchain/bin/jj help --help
uv sync --locked
just --list
```

Results from the clean review pass:

```text
jj                                   0.44.0
HTML                                 995 ids, 72 internal links
CLI                                  120 canonical 0.44 paths; 0.45-only converge labelled
PDF                                  510 pages, 540 x 720 pt, 9 fonts,
                                     14 URI links, 322 outline entries
printed contents                     2 pages; body begins on page 3
root HTML                            symlink -> src/book.html
root PDF                             symlink -> build/jj-book.pdf
workspace fixture                    external edits remain unrecorded, not stale metadata
PDFium samples                       15 current samples rendered and inspected
```

Current PDF SHA-256:
`805dddba5c6f7341dffd2074e41c2a8dd745de49e492145c076cfc1be77de42f`.

The current substantive authored count is 102,796 words by the project's
documented counting method. The current PDF is 510 pages in the revised
100,000–130,000-word / approximately 450–600-page design range.

## Previous findings rechecked

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

ID: FUP6-m-001  
Severity: MINOR  
Area: diagram readability and notation  
File: `src/book.html:5793`  
Section: Multiple workspaces in one repository

Claim or issue: the diagram label is written as `workspace review:review@ = A`
without a space after the colon. The surrounding labels use `workspace dev:
dev@` and `workspace build: build@`, so this appears to be a formatting typo
rather than intentional notation.

Evidence: the source line is exactly:

```text
workspace review:review@ = A (review baseline)
```

The corrected `review@` workspace notation is otherwise technically
appropriate: the jj 0.44 revset help defines `<workspace name>@` for another
workspace's working-copy commit. The clean build and visual inspection pass;
this finding concerns only the missing diagram whitespace.

Why it matters: a graph-first book relies on diagrams being quickly legible.
The run-together label can make the workspace name and the symbol look like one
token and weakens consistency in a section explicitly teaching notation.

Required fix: change the label to `workspace review: review@ = A (review
baseline)` and retain the same workspace-qualified symbol.

Suggested validation: search the workspace diagrams for the pattern
`workspace <name>:` and inspect the generated page after rebuilding; all such
labels should have a separating space before the workspace-qualified symbol.

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
| Technical validation | PASS | Local graph, revset, template, conflict, workspace, sparse, operation, Git-backend, and CLI checks pass. |
| Licence/provenance | PASS | Source/use records, Apache notice, and excluded third-party assets are documented; no unresolved incorporated-material issue found. |
| Contents/navigation | PASS | Printed contents spans two pages; electronic outline has 322 entries; changed sections are ordered and reachable. |
| Duplication/order/depth | PASS | Workspace duplication is removed; the current depth matrix distinguishes teaching, practice, reference, and workflow roles. |
| Appendices | PASS | Compact directory cards are labelled as such and link to the denser revset/fileset/template/configuration and H–K fieldbook material. |

## Remaining evidence boundaries

These are documented limits, not unresolved findings:

* GitHub and Gerrit server/UI behaviour is not live-tested; the book labels
  those effects as server-dependent and uses the authoritative documentation
  plus local transport/graph tests.
* Real GPG/SSH signing hardware, external merge/diff tools, interactive TUIs,
  and every possible DAG shape are outside the non-interactive local fixture
  scope.
* `research/appendix-audit.md` and earlier review files retain superseded
  historical assessments. The current status is the later matrix in
  `research/depth-audit.md` and this report; the historical files should not
  be read as open findings.

The sole open issue is FUP6-m-001, an isolated diagram-spacing correction.

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
