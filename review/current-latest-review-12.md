# Review again: Part XI operation/evolution restructuring

## Baseline

Reviewed author revision:

```text
jj change/revision: zoxxwmlwwvuosoklqksupzrxlxppuxsm
Git commit: 4fb2cfca737b7e4e24c6625d0226f921689c286c
Description: Move operation history treatment before evolution history
```

## Verdict

```text
PASS
```

| Severity | Count |
|---|---:|
| BLOCKER | 0 |
| MAJOR | 0 |
| MINOR | 0 |
| NIT | 0 |

`XI-M-003` is resolved. The operation-history section now owns the operation views/IDs and undo/restore/revert/abandon treatment. The evolution-log section follows it, with separate correlation, recovery, and concurrency/retention sections. The contents and PDF outline expose that structure.

The build timestamp also remains consistent at `2026-09-17T12:37:37Z` across the source, PDF metadata, cover, and research records.

## Checks performed

| Check | Result |
|---|---|
| Part XI source structure | Pass. Operation-history material precedes evolution history; correlation, recovery, and concurrency/retention are separate sections. |
| HTML check | Pass: 965 IDs and 215 internal links; structure and contents-order checks pass. |
| CLI check | Pass: 121 canonical jj 0.45.1 command paths. |
| PDF check | Pass: 521 pages, 540 x 720 pt, 9 fonts, 16 links, 196 outline entries. |
| Visual acceptance | `just visual` passes and renders 19 PDFium samples. Current Part XI pages show readable headings, tables, diagrams, and code with no observed clipping or black-block glyphs. |
| PDF reproducibility | `just pdf-repro` passes with byte-identical repeated renders. |
| Evolog validation | Passes standalone under jj 0.45.1. |
| Build timestamp | Pass: `research/build-timestamp.txt`, source/cover, PDF metadata, completeness report, and print-acceptance record agree. |
| PDF digest | Pass: `build/jj-book.pdf.sha256`, the acceptance record, and the generated PDF agree on `7374ce4c3da6579a16bfdf2dde536e712ab2c6e6ac723927d0913e8d6da7b061`. |
| Root artefact | `jj-book.pdf` remains a symlink to `build/jj-book.pdf`; `jj-book.html` remains a symlink to `src/book.html`. |

No unresolved findings remain from the Part XI structure review.
