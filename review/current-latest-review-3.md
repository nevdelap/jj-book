# Superseded historical review

> The current authoritative report is [`current-latest-review-4.md`](current-latest-review-4.md).

# Latest independent review

## Re-review — 2026-09-11

Reviewed author revision:

```text
jj change/revision: vpqzlkrsqtsxyrozxrmnpssuyotwntxk
Git commit:         76a0e2415f70d1f45b760befd951b5f39b9bc01d
Description:        Clarify revset precedence notation and language
```

This review covers the current tree and the author's changes since the
previously reviewed author commit `2ddb7adeca0f09a0a60f8ffc57db4aadef87b72d`.
The latest changes substantially expand the revset language material and add
precedence and pattern explanations. The current book is not release-ready,
however, because its reader-facing revset reference and several workflow
examples contain names or signatures that do not match jj 0.45.1.

## Verdict

**REQUIRES MAJOR REVISION**

```text
BLOCKER: 0
MAJOR:   1
MINOR:   1
NIT:     0
```

### REV45-M-001 — Reader-facing revset reference and examples contain invalid 0.45.1 functions

ID: REV45-M-001
Severity: MAJOR
Area: Revsets, command examples, reference accuracy
File: `src/book.html`
Section: Revset language, revset reference atlas, workflows, appendices

Claim or issue: The manuscript presents the following as jj 0.45.1 revset
functions or executable expressions:

```text
bookmark("...")
tag("...")
conflicted()
evolution(x)
workspaces()
file(pattern)
```

It also describes `at_operation()` as accepting an optional revset, while the
target syntax requires two arguments. These occur in the human reference and
in operational examples, not merely in research notes. Relevant locations
include `src/book.html:1045`, `2372`, `4626`, `5039`, `5978`, `6486-6488`,
`6583`, `6587`, `6601`, `6603`, `6619`, and `7746-7749`.

Evidence: The authoritative installed target is:

```text
jj 0.45.1-7c41cdeb16b6b321c64e789a966b6adf723816a5
```

Its captured official help in `research/help-revsets-0.45.1.md:453-466`
defines `conflicts()`, `working_copies()`, and `at_operation(op, x)`, and
does not define `bookmark()`, `tag()`, `evolution()`, `workspaces()`, or
`file()`. The installed parser reproduces the failures:

```text
JJ_CONFIG=/dev/null jj log -r 'bookmark("main")'
  Function `bookmark` doesn't exist
JJ_CONFIG=/dev/null jj log -r 'tag("v1")'
  Function `tag` doesn't exist
JJ_CONFIG=/dev/null jj log -r 'conflicted()'
  Function `conflicted` doesn't exist
JJ_CONFIG=/dev/null jj log -r 'evolution(@)'
  Function `evolution` doesn't exist
JJ_CONFIG=/dev/null jj log -r 'workspaces()'
  Function `workspaces` doesn't exist
JJ_CONFIG=/dev/null jj log -r 'file("README.md")'
  Function `file` doesn't exist
JJ_CONFIG=/dev/null jj log -r 'at_operation()'
  Function `at_operation`: Expected 2 arguments
```

The project-level `just review` passes because its revset checks validate
selected fixture expressions and source guards, but do not extract and parse
every reader-facing revset entry and workflow expression. A passing build
therefore does not disprove these errors.

Why it matters: An advanced reader copying these examples receives immediate
parse failures, and the reference teaches a false 0.45.1 language surface.
The invalid bookmark forms are used in publication, editing, signing, and
workspace examples, so this is also a workflow correctness problem. It
undermines the expanded reference's stated purpose as a standalone lookup
source.

Required fix: Audit every revset expression in the book against the 0.45.1
help/inventory. Replace `conflicted()` with `conflicts()`, replace or remove
the nonexistent `evolution()`, `workspaces()`, and `file()` entries, and use
the actual `working_copies()` and `files(...)` contracts. Explain evolution
through the target's supported operation/evolution facilities rather than
inventing a revset function. Replace `bookmark()`/`tag()` resolver claims and
examples with valid explicit bookmark/tag selection syntax (for example the
plural ref predicates with an exact pattern, or a correctly qualified symbol),
then verify singleton contracts for commands such as `edit`, `sign`, and
`workspace add`. Document `at_operation(op, x)` with both required arguments.

Suggested validation: Add a source-level or structured-example validator that
extracts all reader-facing revset expressions and checks them against the
0.45.1 function inventory, while permitting template methods and declared
aliases in their proper language contexts. Run the extracted examples in a
disposable 0.45.1 repository and assert both parse success and representative
results. Run `BASH_ENV=/dev/null just review` afterward.

### REV45-m-001 — Deprecated `diff_contains()` is presented without its 0.45.1 status

ID: REV45-m-001
Severity: MINOR
Area: Revset reference freshness
File: `src/book.html:6621` and `7750`
Section: Revset reference atlas; appendix reference

Claim or issue: `diff_contains(pattern)` is listed as an ordinary current
predicate, with no deprecation notice or replacement guidance.

Evidence: `JJ_CONFIG=/dev/null jj log -r 'diff_contains("x")'` succeeds only
with the target warning that `diff_contains()` is deprecated and that
`diff_lines()` should be used instead. The 0.45.1 help capture documents the
replacement at `research/help-revsets-0.45.1.md:437-450`.

Why it matters: A reference reader may build new automation on a deprecated
surface and miss the supported replacement.

Required fix: Mark `diff_contains()` as deprecated, state the warning and
replacement, and make `diff_lines()` the primary example/reference entry.

Suggested validation: Run both forms against the target binary and validate
that the reference labels the deprecated form explicitly.

## Structural and publication checks

| Area | Status |
|---|---|
| Target jj version | PASS — jj 0.45.1; 0.44.0 remains obsolete for this edition |
| HTML-first source | PASS — substantive source is `src/book.html` |
| PDF derivation | PASS — current PDF is generated from the HTML pipeline |
| Kindle Scribe geometry/layout | PASS for inspected current artefact |
| Black-block/glyph issue | PASS for inspected samples; no black blocks or missing glyphs observed |
| Contents listing | PASS — compact three-page listing, with acceptable separation before the preface |
| Licence/provenance | PASS for the reviewed records; no new issue in this delta |
| `uv` | PASS — `uv sync --locked`, `uv run`, and `uv.lock` are coherent |
| `just` | PASS — `just --list` and `BASH_ENV=/dev/null just review` work |
| Root publication symlinks | PASS — `jj-book.pdf -> build/jj-book.pdf`; `jj-book.html -> src/book.html` |
| Build/reproducibility | PASS — `BASH_ENV=/dev/null just pdf-repro` completes with byte-identical renders |
| HTML validation | PASS — 957 IDs and 88 internal links |
| CLI inventory | PASS — 121 canonical jj 0.45.1 paths validated |
| Broader structure/depth/order | No new structural defect found in this delta |

Current artefact evidence:

```text
PDF: 496 pages, 540 x 720 pt
SHA-256: 55adcfc399a0675d203b5dc305c5df1de59e24c5ea097dabd087bde1f131be29
```

The invalid revset entries must be corrected and revalidated before a PASS
recommendation.
