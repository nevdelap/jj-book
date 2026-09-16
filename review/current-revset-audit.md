# Superseded historical revset audit

> The current authoritative audit is [`current-revset-audit-2.md`](current-revset-audit-2.md).

## Target evidence

The installed target is jj 0.45.1. Its `jj help -k revsets` defines:

```text
x::   descendants of x, including x
::x   ancestors of x, including x
```

Therefore the configured book alias:

```text
stack(x) = x:: & mutable()
```

has the standalone equivalent `x:: & mutable()`, not `::x & mutable()`.

## FUP18-B-001 — BLOCKER

The latest source change replaces many former `stack(@)` examples with
`::@ & mutable()` or `mutable() & ::@`, and adds prose claiming that this is a
mutable descendant closure. Those forms select ancestors. The issue appears
in revset teaching, Gerrit upload, conflict/recovery examples, configuration
defaults, command aliases, `absorb`, `arrange`, `fix`, `run`, `sign`, and other
workflows.

Representative source locations:

```text
src/book.html:1072       stack(x) = x:: & mutable()
src/book.html:1074       false standalone equivalence ::X & mutable()
src/book.html:415        log example
src/book.html:2568       review log example
src/book.html:2577       false descendant-closure explanation
src/book.html:3470       Gerrit upload selection
src/book.html:4235       absorb destination selection
src/book.html:4861       run selection
src/book.html:5394       fix selection
src/book.html:5524       daily workflow selection
```

Reproduction against a disposable 0.45.1 repository containing mutable
`A -> B -> C`, with `@` at `A`:

```text
@:: & mutable()  => A, B, C
::@ & mutable()  => A
```

With `@` at `C`, the result reverses in the other direction:

```text
@:: & mutable()  => C
::@ & mutable()  => C, B, A
```

The correction must be intent-sensitive. Existing `mutable() & ::@` examples
that explicitly ask for mutable ancestors are valid and must not be changed
just because they contain `::@`. Every former `stack(@)` use, however, needs
to be checked against the intended descendant set.

## FUP18-M-001 — MAJOR validation gap

`scripts/validate-revsets.sh` checks parseability/exit status for representative
expressions but does not assert the expected set for an interior workspace
commit with descendants. This is why the reversed but valid expressions pass.
Add exact symbolic-set assertions and a source audit for stack-selection
expressions. Update the completeness report so “semantic validation” does not
imply that all reader-facing graph selections have been result-tested.

## Required validation matrix

Use a fixture with a trunk, interior stack node, descendant stack node, fork,
merge, and bookmark. Record expression, expected symbolic set, actual set,
cardinality, and mutation/rewrite effect for:

```text
x:: & mutable()
::x & mutable()
heads(x:: & mutable())
roots(x:: & mutable())
base..tip
base::tip
```

Then run representative publication, conflict, fix, run, absorb, and rebase
examples with assertions about selected descriptions, commit IDs, change IDs,
bookmarks, descendants, and conflicts.
