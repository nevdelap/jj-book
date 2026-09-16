# Latest independent review

## Re-review — 2026-09-12

Reviewed author revision:

```text
jj change/revision: mtrtwszoxuyuprzowvwplqzulvwykmpo
Git commit:         f8392075f663551a90e2bdc2c09a47067cd0a44d
Description:        Document materialised multi-sided conflict formats
```

The author added a substantial conflict-marker section since the previous
review. The addition is technically sound for the documented default,
snapshot, and Git-style formats, and it renders cleanly. The previous revset
MAJOR remains unresolved in this revision.

## Verdict

**REQUIRES MAJOR REVISION**

```text
BLOCKER: 0
MAJOR:   1
MINOR:   3
NIT:     0
```

### REV45-M-001 — Invalid 0.45.1 revsets remain in the reader-facing book

ID: REV45-M-001
Severity: MAJOR
Area: Revsets, command examples, reference accuracy
File: `src/book.html`
Section: Revset language, revset reference atlas, workflows, appendices

Claim or issue: The current manuscript still presents `bookmark()`, `tag()`,
`conflicted()`, `evolution(x)`, `workspaces()`, and `file(pattern)` as jj
0.45.1 revset functions or executable expressions. It also describes
`at_operation()` as accepting an optional revset, although the target syntax
requires two arguments.

Evidence: Direct probes against the installed target still fail:

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

The target help capture `research/help-revsets-0.45.1.md:453-466` defines
`conflicts()`, `working_copies()`, `files(expression)`, and
`at_operation(op, x)`, not those false forms. Current occurrences include
`src/book.html:1045`, `2372`, `4706`, `5119`, `6058`, `6566-6568`, `6663`,
`6667`, `6681`, `6683`, `6699`, and `7826-7829`.

Why it matters: Copying these examples produces immediate parse failures and
the reference teaches a false 0.45.1 language surface. The invalid forms are
used in publication, editing, signing, and workspace examples, so this is a
workflow correctness defect, not merely a table typo. `BASH_ENV=/dev/null just
review` passes because the validator does not extract and parse all
reader-facing revset entries.

Required fix: Replace all invalid forms with target-version syntax, explain
evolution/recovery through supported facilities rather than an invented
revset function, and document the two required `at_operation(op, x)`
arguments. Add extraction/parse validation for all reader-facing revset
expressions, while distinguishing revsets from template methods and declared
aliases.

Suggested validation: Run the extracted expressions in disposable jj 0.45.1
repositories and assert expected result sets for representative examples;
then run `BASH_ENV=/dev/null just review`.

### REV45-m-001 — Deprecated `diff_contains()` lacks status

ID: REV45-m-001
Severity: MINOR
Area: Revset reference freshness
File: `src/book.html:6701` and `7829`
Section: Revset reference atlas; appendix reference

Claim or issue: `diff_contains(pattern)` remains listed as an ordinary current
predicate without its deprecation warning or replacement.

Evidence: jj 0.45.1 accepts it only with a warning: “`diff_contains()` is
deprecated; use `diff_lines()` instead.”

Required fix: Make `diff_lines()` primary and label `diff_contains()` as a
deprecated compatibility spelling.

Suggested validation: Run both forms against the target binary and assert the
reference labels the old form.

### REV45-m-002 — Experimental conflict marker value is omitted from the target schema surface

ID: REV45-m-002
Severity: MINOR
Area: Configuration/reference completeness
File: `src/book.html:3028-3043`; `research/config-schema-0.45.1.json:40-48`
Section: Materialised conflict marker formats; configuration reference

Claim or issue: The book calls the section “The three marker styles” and
implies that `diff`, `snapshot`, and `git` are the complete 0.45.1 values.

Evidence: The captured 0.45.1 config schema defines four enum values:
`diff`, `diff-experimental`, `snapshot`, and `git`. In a disposable conflict
fixture, `ui.conflict-marker-style = "diff-experimental"` is accepted and
materialises a conflict. The official stable config help documents the three
stable styles, so the omitted value is best described as experimental rather
than silently ignored.

Why it matters: A reader consulting the versioned schema may find a supported
value that the book's “three styles” wording denies, and the configuration
reference is intended to be complete enough for advanced use.

Required fix: Either document `diff-experimental` with its experimental/status
qualification and observed behavior, or explicitly scope the heading to the
three stable documented styles and point to the target schema for experimental
values.

Suggested validation: Validate the chosen scope against
`jj util config-schema` for jj 0.45.1 and a disposable materialisation test.

### REV45-m-003 — Adapted official conflict example is not recorded accurately in provenance

ID: REV45-m-003
Severity: MINOR
Area: Licence/provenance audit
File: `src/book.html:2995-3074`; `research/sources.md:24`; `research/licenses.md:38-40`
Section: Conflict marker examples; source/material register

Source material: Jujutsu official conflict-marker documentation and technical
conflict documentation.

Source licence: Jujutsu v0.45.1 repository licence, Apache-2.0; evidence is
the tagged upstream licence and the bundled `LICENSES/Apache-2.0.txt`.

Use type: Adapted example and paraphrase. The new section reuses the
distinctive apple/grape/orange scenario and the same marker-block structure,
while changing labels and adding independently written explanation.

Applicable obligation: Record adapted/reproduced material accurately in the
provenance ledger, retain applicable licence/notice information, and identify
the source and adaptation. The section does link the official conflict-marker
page and says the labels/examples are illustrative.

Compliance status: No present licence blocker established; attribution and
Apache notice are substantially present. The ledger is inaccurate because S-03
currently says documentation was only research/paraphrase and that no
documentation example was reproduced or adapted.

Why it matters: A future distributor or auditor cannot rely on the register to
know that the distinctive example was adapted from an official source.

Required fix: Add this use to `research/licenses.md` and `research/sources.md`
as an adapted example, identify the exact source section, preserve the
modification/source note, and verify the distributed Apache notice remains
appropriate. If the author wants the example classified as independently
constructed, replace the distinctive toy scenario with an independently
constructed one and record that basis.

Suggested validation: Compare the final register with every new code block and
figure, then rerun the licence validator and inspect the distributed notices.

## Build and publication checks

| Area | Status |
|---|---|
| Target jj version | PASS — jj 0.45.1; 0.44.0 obsolete |
| HTML-first source/PDF derivation | PASS |
| Kindle Scribe layout | PASS for current inspected artefact; new conflict pages 169–172 are readable and unclipped |
| Black-block/glyph issue | PASS in inspected samples |
| Contents spacing/listing | PASS — three-page contents and separated opening |
| Licence tooling | PASS mechanically; provenance finding above remains |
| `uv`/`just` | PASS |
| Root publication symlinks | PASS — relative symlinks remain intact |
| Full validation | PASS — `BASH_ENV=/dev/null just review` |
| PDF reproducibility | PASS — `BASH_ENV=/dev/null just pdf-repro` byte-identical |
| PDF | PASS — 513 pages, 540 x 720 pt, 9 fonts, 16 links, 70 outline entries |
| Structure/order/depth | No new structural defect found in this delta |

Current PDF SHA-256:

```text
6b336cdce8c7e345e4d0f2bd09dbf7c0c08415f4f6a32715ae7b6544c9525e09
```

The unresolved revset finding remains release-blocking at MAJOR severity.
