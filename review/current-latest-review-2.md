# Superseded historical review

> The current authoritative report is [`current-latest-review-3.md`](current-latest-review-3.md).

# Latest independent review

## Re-review — 2026-09-11

Reviewed author revision:

```text
jj change/revision: xmnlpsusmvzmkxyzopwmmvouxwktosvy
Git commit:         2ddb7adeca0f09a0a60f8ffc57db4aadef87b72d
Description:        Correct stack reachability and assert revset results
```

This revision follows the previous finding that `::@ & mutable()` had been
used where the book meant the mutable descendant closure `@:: & mutable()`.

## Verdict

**PASS**

The previous BLOCKER and MAJOR are closed. The author corrected the affected
reader-facing expressions, corrected the explanatory prose and configuration
examples, added exact directional revset assertions, and added source-level
guardrails. No new issue was found in the reviewed delta.

## Evidence and checks

Target and environment:

```text
Linux; jj 0.45.1-7c41cdeb16b6b321c64e789a966b6adf723816a5
Git 2.53.0; uv 0.12.10; just 1.45.0
```

The installed jj 0.45.1 help confirms:

```text
x::  descendants of x, including x
::x  ancestors of x, including x
```

The book now defines `stack(x) = x:: & mutable()` and uses `X:: & mutable()`
as its standalone equivalent. A disposable 0.45.1 fixture with mutable
`A -> B -> C`, with `@` at `A`, returns `A,B,C` for `@:: & mutable()` and only
`A` for `::@ & mutable()`, matching the book's corrected explanation.

The new `scripts/validate-revsets.sh` fixture independently asserts:

```text
A:: & mutable()        => A B C D
::A & mutable()        => A
heads(A:: & mutable()) => D
roots(A:: & mutable()) => A
```

It also rejects the invalid standalone spelling, stale `stack(@)` examples,
and the known descendant-closure wording error. Both the direct validator and
the complete `BASH_ENV=/dev/null just review` run pass. The dedicated
`BASH_ENV=/dev/null just pdf-repro` run produces byte-identical repeated PDF
renders.

Current publication artefact:

```text
PDF: 496 pages, 540 × 720 pt
SHA-256: 19db906339fd980280921bf15e136fcebb94a5ad6f04ffad7e082af805144106
jj-book.html -> src/book.html
jj-book.pdf  -> build/jj-book.pdf
```

The sampled PDF pages show no black blocks, missing glyphs, clipping, table
collision, or material layout defect. The contents listing remains a compact
three-page listing, and the preface begins on page 4 with acceptable spacing.
The current target remains jj 0.45.1; 0.44.0 is obsolete for this edition.

## Rechecked acceptance areas

| Area | Status |
|---|---|
| Revset direction and stack examples | PASS; blocker closed |
| Semantic revset validation | PASS; exact directional assertions added |
| HTML-first source and PDF derivation | PASS |
| Kindle Scribe geometry and glyph rendering | PASS for inspected artefact |
| `uv` and locked Python execution | PASS |
| `just` interface and full review recipe | PASS |
| Root publication symlinks | PASS |
| Licence/provenance | No new issue found |
| Structure, ordering, duplication, depth, and breadth | No new issue in this delta |

## Current count

```text
BLOCKER: 0
MAJOR: 0
MINOR: 0
NIT: 0
```

No unresolved release issue was found in this re-review.
