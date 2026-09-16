# Superseded historical review

> The current authoritative report is [`current-latest-review-2.md`](current-latest-review-2.md).

## Re-review — 2026-09-11

This review covers all authored changes after the previously accepted author
revision:

```text
previous accepted author commit: e1268065080a760eca906b4078a21d9dc5641fbc
current author revision:          slonszvunvqqlyzskqkxklonrovozqmy
current author commit:            bfeee69b26335be9f627a4e7f1ead1b462a601f0
current author changes:           Broaden Git workflow framing;
                                  Clarify verified jj 0.45.1 capabilities;
                                  Use valid standalone revset expressions
```

Reviewer reports are the only working-copy changes. No production source or
build-system file was changed by this review.

## Verdict

**REQUIRES MAJOR REVISION**

The current build, HTML-first architecture, `uv`/`just` interface, root
symlinks, target-version records, PDF layout, black-block repair, and
provenance records remain in good condition. The latest author change intended
to replace an unavailable `stack(@)` alias with standalone expressions has,
however, reversed the graph direction in many places. This is a release-
blocking revset error because the affected expressions select ancestors where
the surrounding text and former alias select descendants.

## Baseline and executed checks

Environment:

```text
Linux; jj 0.45.1-7c41cdeb16b6b321c64e789a966b6adf723816a5
Git 2.53.0; uv 0.12.10; just 1.45.0
```

Executed successfully:

```text
jj help -k revsets
just --list
BASH_ENV=/dev/null just validate
uv lock --check
uv run --frozen python scripts/validate-pdf.py
```

The current artefact is 496 pages at 540 × 720 points. Its current SHA-256 is
`458b5c5a331c901bd88a722607d8254a10994054085385a9091f287f08c88d5f` and its
metadata reports the current build timestamp. The PDFium samples inspected for
contents pages, the opening section, reference tables, and late appendices show
no black blocks, missing glyphs, clipping, or material layout defect. The
contents listing remains a compact three-page listing for a 496-page book, and
the preface begins on page 4 with acceptable separation from the contents.

The root publication artefacts remain relative symbolic links:

```text
jj-book.html -> src/book.html
jj-book.pdf  -> build/jj-book.pdf
```

The project reports approximately 101,280 substantive words, within its
revised 100,000–130,000-word design range. The previous structure, ordering,
duplication, breadth, and depth review remains accepted for this delta; the
new Git framing is useful and no new prose-architecture defect was found
apart from the revset substitutions below.

## Findings

### FUP18-B-001 — standalone stack substitutions reverse reachability

ID: FUP18-B-001  
Severity: BLOCKER  
Area: Revsets, graph selection, workflows, configuration, and CLI examples  
File: `src/book.html:1072-1074`, `src/book.html:415`, `src/book.html:2443`, `src/book.html:2568-2577`, `src/book.html:2825-2826`, `src/book.html:3347-3370`, `src/book.html:3470`, `src/book.html:4226-4245`, `src/book.html:4861`, `src/book.html:5298`, and many other occurrences listed by the search below  
Section: Revset language, GitHub/Gerrit workflows, configuration, command reference, and advanced mechanics

Claim or issue: The book defines `stack(x)` as `x:: & mutable()`, which is a
mutable descendant closure including `x`, but replaces many former
`stack(@)` examples with `::@ & mutable()`. The latter is the mutable ancestor
closure of `@`, not the equivalent standalone expression. The prose explicitly
states the false equivalence and later calls the same expression a descendant
closure.

Evidence:

* `src/book.html:1072` defines `stack(x) = 'x:: & mutable()'`.
* `src/book.html:1074` says the standalone equivalent is `::X & mutable()`.
  The equivalent is `X:: & mutable()`.
* `src/book.html:2577` says `::@ & mutable()` selects the mutable descendant
  closure of the current workspace commit, which is false.
* Installed jj 0.45.1 help says `x::` means descendants of `x`, including `x`,
  while `::x` means ancestors of `x`, including `x`.
* In a disposable jj 0.45.1 repository with a linear mutable `A -> B -> C`
  graph, with `@` moved to `A`, the intended expression
  `@:: & mutable()` returns `A`, `B`, and `C`; the book's replacement
  `::@ & mutable()` returns only `A` (plus the immutable/root boundary where
  applicable). With `@` at `C`, the replacement returns `C`, `B`, and `A`,
  while the descendant expression returns only `C`.

Reproduction:

```bash
JJ_CONFIG=/dev/null jj help -k revsets
jj log -r 'x:: & mutable()'       # descendants, including x
jj log -r '::x & mutable()'       # ancestors, including x
```

The affected-expression inventory can be regenerated with:

```bash
rg -n "::@|::X|mutable\(\) &amp; ::@" src/book.html
```

Why it matters: This is not a notation preference. It changes the selected
revision set in logs, format/fix/run/sign configuration, absorb/arrange
examples, publication commands, conflict queries, recovery exercises, and
GitHub/Gerrit workflows. It can omit the very descendants the reader intends
to review or publish, include mutable ancestors outside the intended topic,
and make a mutation or automation command operate on the wrong graph region.
The error is especially serious in a graph-first book because it teaches the
central reachability algebra incorrectly.

Required fix: Audit every new explicit expression against the surrounding
intent and replace only the mistaken substitutions with the correct direction.
Where the old example meant `stack(@)`, use `@:: & mutable()` (or a clearly
named, configured alias). Preserve `::@` only where the example intentionally
means the ancestor closure. Correct the explanatory prose and all configuration
snippets, then recheck each affected command's cardinality and mutation domain.
Do not perform an unreviewed global replacement: some existing `mutable() &
::@` queries intentionally ask for mutable ancestors.

Suggested validation: Create a disposable 0.45.1 graph with a trunk, a
three-change stack, a fork, and a merge. Assert the symbolic result of every
stack-selection example and compare the configured alias with its standalone
form. For mutation examples, assert the selected descriptions before running
the operation, then assert descendant commit IDs, change IDs, bookmarks, and
conflicts afterward. Run `just validate`, `just review`, and the full
reader-facing example scan after the correction.

### FUP18-M-001 — semantic validation does not test the changed reachability

ID: FUP18-M-001  
Severity: MAJOR  
Area: Validation quality  
File: `scripts/validate-revsets.sh`, `scripts/validate-cli-examples.sh`,
`research/completeness-report.md:40-42`  
Section: Revset and example validation

Claim or issue: The project reports semantic revset validation, but the
current revset validator checks that representative expressions parse and run;
it does not assert that a descendant selection equals the intended symbolic
set. The new invalid-direction substitutions therefore pass the green
validation suite.

Evidence: `scripts/validate-revsets.sh` runs expressions such as `::@`,
`ancestors(@) & mutable()`, `heads(::@)`, and `roots(::@)` with output sent to
`/dev/null`. It does not construct a stack with `@` below descendants and
compare the results of `x::` and `::x`. `scripts/validate-cli-examples.sh`
checks syntax and selected command output for a small subset, but does not
scan or semantically evaluate the book's broad `::@` replacement set. Yet the
completeness report says semantic graph/revset assertions are validated.

Why it matters: Exit status and parseability cannot detect a valid revset that
answers the wrong graph question. This gap allowed a release-blocking
regression into dozens of reader-facing examples and policy snippets.

Required fix: Add a focused semantic fixture that places `@` at an interior
stack node and asserts exact symbolic descriptions for `x::`, `::x`, and the
book's stack policy. Add a source-level audit or generated check for every
reader-facing stack-selection expression, while allowing intentionally bounded
ancestor queries. Update the completeness record to distinguish parse-tested
from result-asserted examples.

Suggested validation: Make the fixture fail if the two directions are swapped;
run it under the pinned 0.45.1 binary through `just validate` and include its
expected set in the validation output. Re-run the source-expression audit and
the complete review recipe.

## Areas rechecked with no new finding

* Target policy is consistently jj 0.45.1; 0.44.0 is treated as obsolete.
* Canonical source remains first-class semantic HTML and the PDF is derived
  from it.
* `uv sync`/locked execution and the `just` task interface remain coherent.
* Root HTML/PDF links are actual relative symlinks and the generated target
  exists.
* The previous black-block PDF defect remains resolved; sampled diagrams and
  text show no replacement glyphs.
* Contents listing, opening-section spacing, page geometry, and sampled tables
  and code remain acceptable.
* No new licensing/provenance defect was found in these source-only changes;
  the existing records and notices remain the evidence for the retained
  material.

## Current count

```text
BLOCKER: 1
MAJOR: 1
MINOR: 0
NIT: 0
```

The release cannot receive PASS until FUP18-B-001 is corrected and the
semantic validation gap is addressed or explicitly justified with equivalent
result assertions.
