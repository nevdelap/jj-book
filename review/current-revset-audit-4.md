# Current revset audit

## Target and result

Target: jj 0.45.1 (`7c41cdeb16b6b321c64e789a966b6adf723816a5`).

The previous MAJOR finding remains open in author revision
`mtrtwszoxuyuprzowvwplqzulvwykmpo` / commit
`f8392075f663551a90e2bdc2c09a47067cd0a44d`. The current manuscript still
contains the invalid forms `bookmark()`, `tag()`, `conflicted()`,
`evolution(x)`, `workspaces()`, and `file(pattern)`, plus an incomplete
`at_operation()` entry. Direct target probes continue to produce parse errors;
the supported forms are `bookmarks()`, `tags()`, `conflicts()`,
`working_copies()`, `files(...)`, and `at_operation(op, x)`.

`BASH_ENV=/dev/null just review` passes, but its validators do not parse every
reader-facing revset table/example. That validation gap is part of the required
fix, not evidence that the finding is closed.

## Additional current notes

`diff_contains()` remains accepted but deprecated in favour of `diff_lines()`.
The new conflict-marker section otherwise agrees with the target docs for the
default diff, snapshot, and Git styles, including multi-sided fallback and
long/missing-newline marker behavior. The target schema also contains the
experimental `diff-experimental` marker value, which should be explicitly
scoped or documented in the configuration/reference material.

The new conflict examples closely adapt the official apple/grape/orange
marker example. The source link and Apache notice are present, but the
provenance ledger currently classifies the use as paraphrase-only. See
`current-latest-review-4.md` finding `REV45-m-003`.
