# Review again: Part XI restructuring

## Baseline

Reviewed author revision:

```text
jj change/revision: mpsuprsnyolrwrrytkyuwtmtnyqtqywk
Git commit: 7a94474d8c0ef9fe63c3b5a36c9449ed57c651e5
Description: Restructure Part XI around operation history and change evolution
```

## Verdict

```text
REQUIRES MAJOR REVISION
```

| Severity | Count |
|---|---:|
| BLOCKER | 0 |
| MAJOR | 1 |
| MINOR | 0 |
| NIT | 0 |

The author has resolved the title problem in `XI-M-001`: Part XI and the contents now say “Operation history, change evolution, undo, and recovery.” Explicit headings for operation history, evolution log, correlation, recovery, and concurrency are also present. The build timestamp is now refreshed consistently to `2026-09-17T12:37:37Z` across the source, PDF metadata, cover, and research records.

The following structural/depth issue remains.

## Finding

### XI-M-003 — Operation-history heading does not contain the operation-history treatment

```text
ID: XI-M-003
Severity: MAJOR
Area: Book structure, ordering, operation-log depth
File: src/book.html:3244-3261, 3588-3675; research/print-acceptance.md:39-61
Section: Part XI — Operation history, change evolution, undo, and recovery
Claim or issue: The new “Operation history: repository-wide transformations” subsection is only an opening model and command list. The detailed operation-log explanation and recovery material remain later under “Concurrency, retention, and cross-machine limits,” after the evolution, recovery, and conflict material.
Evidence:
```

* `src/book.html:3246-3261` contains the operation-history heading, a two-graph diagram, a short definition, seven commands, and one compact paragraph. It then moves immediately into the long evolution-log section.
* The detailed operation-history material begins only at `src/book.html:3588`, under the differently scoped heading “Concurrency, retention, and cross-machine limits.” Its subsections include “Views and IDs,” “Undo, restore, revert, and abandon are different,” recovery exercises, concurrency/integration, retention/GC, and the recovery decision record.
* The generated contents therefore advertises an operation-history section whose substantive treatment is distributed much later and is not discoverable from the operation-history entry itself.
* The current PDFium samples show the new headings and readable layout, so this is not a rendering defect. It is a content hierarchy and ordering defect.

Why it matters:

Operation history and change evolution are the two central local-history models for the requested recovery treatment. A reader should learn the operation model coherently before being asked to correlate it with `evolog` or use it in recovery. Leaving the operation model’s detailed semantics under a later concurrency heading makes the new sibling structure mostly cosmetic and weakens the book’s graph/history progression.

Required fix:

Move or restructure the detailed operation-log material so the operation-history section itself contains, or clearly owns, the operation DAG, operation views and IDs, `op show`/`op diff`, `--at-operation`, undo/redo, restore/revert/abandon, and the relevant operation-history laboratory. Then present the evolution-log section, followed by an explicit correlation section and a recovery section. Keep concurrency, retention, and cross-machine limits as a later section that builds on the already taught operation model rather than carrying its core explanation.

Do not solve this by adding more headings alone. The reader-facing hierarchy and the actual sequence of explanation must agree, and duplicate operation material should be consolidated rather than copied.

Suggested validation:

1. Inspect the generated contents and PDF outline and confirm that the operation-history entry leads to the operation-history explanation and experiments.
2. Read Part XI linearly and verify the progression: operation history → change evolution → correlation → recovery → concurrency/retention limits.
3. Confirm that each of the two log sections has substantive model, command, graph, edge-case, and workflow treatment.
4. Run `just html-check`, `just pdf-check`, `just visual`, and `just pdf-repro` after the move.

## Checks performed

| Check | Result |
|---|---|
| HTML check | Pass: 967 IDs and 215 internal links; source order validation passes. |
| CLI check | Pass: 121 canonical jj 0.45.1 command paths. |
| PDF check | Pass: 524 pages, 540 x 720 pt, 9 fonts, 16 links, 196 outline entries. |
| PDF visual check | `just visual` passes and renders 19 current PDFium samples. Part XI operation-history, evolution-log, recovery, and concurrency samples are readable with no observed clipping or black-block glyphs. |
| PDF reproducibility | `just pdf-repro` passes with byte-identical repeated renders. |
| Evolog validation | Passes standalone under jj 0.45.1. |
| Build timestamp | Pass: `research/build-timestamp.txt`, source/cover, PDF metadata, completeness report, and print-acceptance record agree. |
| Root artefact | `jj-book.pdf` remains a symlink to `build/jj-book.pdf`; `jj-book.html` remains a symlink to `src/book.html`. |

The revised title and timestamp are accepted, but the Part XI structural/depth finding remains unresolved.
