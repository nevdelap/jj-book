# Superseded historical review summary

> The current authoritative summary is [`current-review-summary-2.md`](current-review-summary-2.md).

## Verdict

**REQUIRES MAJOR REVISION**

The current author change introduces a release-blocking revset-direction
error: several expressions intended to select mutable descendants use the
ancestor operator `::@`. See [`current-latest-review.md`](current-latest-review.md),
finding FUP18-B-001.

## Baseline

- Previous accepted author commit: `e1268065080a760eca906b4078a21d9dc5641fbc`.
- Current author revision: `slonszvunvqqlyzskqkxklonrovozqmy`.
- Current author commit: `bfeee69b26335be9f627a4e7f1ead1b462a601f0`.
- Normative target: jj 0.45.1; 0.44.0 is obsolete.
- Current PDF: 496 pages, 540 × 720 pt; SHA-256
  `458b5c5a331c901bd88a722607d8254a10994054085385a9091f287f08c88d5f`.
- Substantive manuscript reported by the project: approximately 101,280 words.
- Root PDF: `jj-book.pdf` is a relative symlink to `build/jj-book.pdf`.

## Status

| Area | Status |
|---|---|
| HTML-first source and PDF derivation | PASS |
| Kindle Scribe geometry/layout and black-block check | PASS for inspected artefact |
| Licence/provenance | No new issue found |
| `uv` | PASS |
| `just` | PASS |
| Root publication symlink | PASS |
| Build and representative validation | PASS, but semantic reachability coverage is insufficient |
| Revset correctness | BLOCKER |
| Structure, ordering, duplication, depth, and breadth | No new issue in this delta |

## Findings

```text
BLOCKER: FUP18-B-001 — stack(@) replacements reverse descendants and ancestors
MAJOR:   FUP18-M-001 — validation does not assert the changed result sets
MINOR:   0
NIT:     0
```

The reviewer changed only files under `review/`. The next author turn should
correct the source expressions and strengthen the focused semantic fixture;
the next review should report the resulting jj revision/change ID and Git
commit ID.
