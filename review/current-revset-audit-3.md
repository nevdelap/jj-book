# Superseded historical revset audit

> The current authoritative audit is [`current-revset-audit-4.md`](current-revset-audit-4.md).

# Current revset audit

## Target

The installed and normative target is:

```text
jj 0.45.1-7c41cdeb16b6b321c64e789a966b6adf723816a5
```

The authoritative local help capture is
`research/help-revsets-0.45.1.md`. It defines `conflicts()`,
`working_copies()`, and `at_operation(op, x)`. It does not define
`bookmark()`, `tag()`, `conflicted()`, `evolution()`, `workspaces()`, or
`file()`.

## Finding

ID: REV45-M-001
Severity: MAJOR
Area: Revset language/reference and executable workflows
File: `src/book.html`
Section: Revset chapters, reference atlas, appendices, publication examples

Claim or issue: The current manuscript presents invalid 0.45.1 revset names and
an incomplete `at_operation()` signature as if they were supported. It uses
`bookmark()` and `tag()` to disambiguate refs, `conflicted()` for conflict
commits, `evolution(x)` for evolution history, `workspaces()` for workspace
selection, and `file(pattern)` for changed-file selection.

Evidence: Direct target-version probes with `JJ_CONFIG=/dev/null` produce:

```text
bookmark("main")  -> Function `bookmark` doesn't exist
tag("v1")          -> Function `tag` doesn't exist
conflicted()       -> Function `conflicted` doesn't exist
evolution(@)       -> Function `evolution` doesn't exist
workspaces()       -> Function `workspaces` doesn't exist
file("README.md")  -> Function `file` doesn't exist
at_operation()     -> Function `at_operation`: Expected 2 arguments
```

The target help's supported forms are `bookmarks([pattern])`,
`tags([pattern])`, `conflicts()`, `working_copies()`, `files(expression)`,
and `at_operation(op, x)`. The false forms appear in the reader-facing tables
at `src/book.html:6486-6488`, `6583`, `6587`, `6601`, `6603`, `6619`, and
`7746-7749`, and in executable examples at `1045`, `2372`, `4626`, `5039`,
`5978`, and `7455`.

Why it matters: This fails the book's promise of a serious standalone
reference and causes copy-and-paste failures in publication, editing, signing,
workspace, and graph-analysis workflows. The current `just review` suite does
not catch it because it does not extract and parse all reader-facing examples
and table entries.

Required fix: Replace every invalid form with the target-version syntax and
explain the supported evolution/recovery facilities separately from revset
functions. Make `at_operation(op, x)`'s two required arguments explicit.
Audit the complete source, not only the newly added tables.

Suggested validation: Extract all revset expressions from HTML code blocks and
reference entries, distinguish revsets from template methods and declared
aliases, run them in disposable jj 0.45.1 repositories, and assert expected
sets for representative cases. Add this check to `just review`.

## Freshness note

`diff_contains(pattern)` at `src/book.html:6621` and `7750` remains accepted by
jj 0.45.1 but emits a deprecation warning directing users to `diff_lines()`.
This is MINOR (`REV45-m-001`), not a parse blocker; the reference should label
the old name and make `diff_lines()` primary.

## What passed in this audit

The latest precedence and range explanations were checked against installed
help, including inclusive `x::` and `::x`, exclusive range boundaries, date
pattern forms, named remote arguments, and unsupported regex lookaround and
backreference errors. The project's directional revset fixture passes and
correctly asserts descendant versus ancestor selection. No new graph-direction
error was found in the latest author delta.
