# Revset audit

## Evidence

The local 0.44.0 help defines `heads(x)` as commits in x that are not ancestors of other commits in x (`research/help-revsets-0.44.0.md:333-336`). It also provides the complete operator/function help capture and the project’s revset inventory.

## Findings

1. **BLOCKER B-003 — false workbook result.** At `src/book.html:845-866`, the displayed graph makes F an ancestor of merge G, but the text says `heads(B::G) = {F,G}`. The correct result is `{G}` for the shown set. This must be corrected and tested with an exact disposable graph.
2. **MAJOR M-003 — invalid pattern syntax.** `author(email:"...")` and `committer(email:"...")` fail in jj 0.44.0 with `Invalid string pattern kind email:`. Use `author_email(exact:"...")`/`committer_email(exact:"...")` or `author(exact:"...")`/`committer(exact:"...")`.
3. **Coverage remains shallow despite a good foundation.** The chapter gives algebra, precedence, functions, aliases, and a workbook, but the appendices still group function names and the report admits the final reference reconciliation remains. Every function needs domain, cardinality, errors, composition, and a fixture assertion where the book claims reference completeness.

## Positive observations

- The book correctly distinguishes revsets from filesets/templates and warns about shell quoting.
- It correctly emphasizes set semantics, explicit cardinality, remote qualification, and commit ID versus change ID.
- The stored inventory is broader and more useful than the reader-facing appendix currently is.

## Suggested validation matrix

For each operator/function, record graph, expression, expected symbolic set, actual full IDs, cardinality, version, and whether hidden/divergent/conflicted states are involved. Include merge graphs for `heads`, `roots`, `..`, `::`, `reachable`, `fork_point`, and `merge_point`; include ambiguity and invalid-pattern cases.

