# Superseded historical review

> The current authoritative report is [`current-latest-review.md`](current-latest-review.md).
> This file is retained as the prior accepted snapshot.

## Re-review — 2026-09-11

This review covers the author revision:

```text
jj change/revision: pmqmqkzvmxlkmknpkysrqmoxzxluzyzs
Git commit:          e1268065080a760eca906b4078a21d9dc5641fbc
Description:         Align UTC publication dates
```

There are no authored source or build-system changes after that revision.
The remaining working-copy changes are reviewer reports.

## Verdict

**PASS**

The previous minor inconsistency in UTC-labelled publication records is
closed. `research/completeness-report.md`, `research/print-acceptance.md`,
and `research/version-matrix.md` now consistently use `2026-09-10 UTC`.
Their PDF hash agrees with `build/jj-book.pdf.sha256` and the generated PDF.

## Baseline and executed checks

Environment:

```text
Linux; jj 0.45.1-7c41cdeb16b6b321c64e789a966b6adf723816a5
Git 2.53.0; uv 0.12.10; just 1.45.0
```

Executed successfully:

```text
just --list
just pdf-repro
just review
uv run --frozen python scripts/validate-pdf.py
uv run --frozen python scripts/render-visual-samples.py
```

The full review run passed the jj 0.45.1 technical fixtures, licence
validation, HTML/structure/TOC validation, CLI inventory/reference checks,
PDF validation, visual sample generation, and symlink checks. The dedicated
reproducibility recipe compared complete repeated PDF bytes successfully.

The final PDF is 496 pages at 540 × 720 points, with 9 fonts, 15 links, and
70 outline entries. The contents listing occupies pages 2–3 and the preface
starts on page 4. Current PDFium samples show no black blocks, missing
glyphs, clipping, table collision, or material spacing defect. The root
publication paths remain relative symlinks:

```text
jj-book.html -> src/book.html
jj-book.pdf  -> build/jj-book.pdf
```

Current PDF and checksum:

```text
76f78e269446d74417d6e49dddbd1a86cd9145a08b929281ebd2e05bd68084e0
```

## Content and compliance assessment

No new structure, ordering, duplication, depth, breadth, or consistency issue
was introduced by this revision. The prior content assessment remains valid:
the book is approximately 100,734 substantive words and 496 pages; the
contents listing is appropriately compact; the major jj model, revset,
fileset, template, configuration, bookmark, Git/GitHub/Gerrit, conflict,
operation-log, workspace, and advanced-mechanics areas are developed beyond
mere inventories; and no repeated substantive paragraph groups were found at
the tested threshold.

The canonical source remains first-class semantic HTML. Python operations use
the locked `uv` environment, normal project operations use `just`, and the
root HTML/PDF convenience artefacts are symlinks. Source and package licence
inventories, notices, and asset provenance records pass validation, with no
unresolved incorporated asset or copied-material issue found in the review.

The prior Gerrit identity correction remains accurate for jj 0.45.1: jj
change IDs, Gerrit `Change-Id` trailers, and server review records are
distinct, and upload-generated footer behaviour is explained. The prior PDF
reproducibility finding is also closed: `PYTHONHASHSEED=0` is enforced by the
normal PDF recipe and `just pdf-repro` verifies byte identity.

## Acceptance status

| Area | Status | Evidence |
|---|---|---|
| Target version | PASS | jj 0.45.1 is the sole normative release; 0.44.0 is obsolete. |
| HTML-first source | PASS | `src/book.html` is canonical; root HTML is a symlink. |
| Kindle Scribe PDF | PASS | 496-page 540 × 720 pt PDF; visual samples show no reported layout or glyph defect. |
| Licence/provenance | PASS | Current inventories, notices, and asset records pass validation. |
| `uv` | PASS | Locked environment and `uv run --frozen` execution pass. |
| `just` | PASS | Normal setup, build, validation, review, PDF, reproducibility, visual, and clean recipes are exposed. |
| Root publication symlink | PASS | `jj-book.pdf` and `jj-book.html` are relative symbolic links. |
| PDF reproducibility | PASS | `just pdf-repro` compares complete repeated PDF bytes successfully. |
| Structure/content/depth/breadth | PASS | Prior findings remain closed; this delta adds no content defect. |
| Publication records | PASS | UTC dates and PDF hashes are consistent. |

## Current count

```text
BLOCKER: 0
MAJOR: 0
MINOR: 0
NIT: 0
```

No release-blocking issue remains in the reviewed scope.
