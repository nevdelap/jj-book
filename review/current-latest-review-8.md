# Review again: current author revision

## Baseline

Reviewed author revision:

```text
jj change/revision: wvqumopnxrmovouszzumxuqlmsvopzyl
Git commit: c9afc0c1be7a0f624c41579b443139397f001b2c
Description: Complete print-safe template reflow
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

The previous clipping finding `EVO45-M-005` is resolved. The corrected examples now fit within the printable measure on pages 183, 241, and 242, and the relevant template forms execute under jj 0.45.1. One release-record finding remains.

## Finding

### EVO45-M-006

```text
ID: EVO45-M-006
Severity: MAJOR
Area: Kindle Scribe PDF acceptance evidence and generated-artefact provenance
File: research/print-acceptance.md:3-4; build/jj-book.pdf.sha256; build/jj-book.pdf
Section: Kindle Scribe print acceptance
Claim or issue: The print-acceptance record identifies a superseded PDF hash while claiming to describe the 2026-09-17 edition.
Evidence:
```

* The current generated PDF is 526 pages and has SHA-256:

  ```text
  f7f19f2e671c922b8c350513a1061b30e85267fa70398ccbe8509a5001290ddc
  ```

* `build/jj-book.pdf.sha256` records that same `f7f19f2e...` hash.
* `research/print-acceptance.md:3-4` still records:

  ```text
  00bd9610c1b76c9f1270031d52128de50b7453b85d93940838b5da1a2ae6f61e
  ```

  which is the hash from the pre-reflow PDF.
* The same acceptance record says that the listed rendered pages and the reproducibility run apply to the edition checked on 2026-09-17. The hash does not identify the current edition, so the record cannot prove that its visual observations belong to the artefact being released.
* The current PDF was independently rendered and inspected during this review. The page-183 divergence example and page-241/page-242 template examples are now readable, but that new evidence is not represented by the committed hash in the acceptance record.

Why it matters:

The PDF is a release artefact and the acceptance record is its provenance link. A stale digest makes the record internally inconsistent and leaves a reviewer or downstream recipient unable to determine which exact bytes were visually accepted. This is especially important here because the PDF changed specifically in response to a layout defect.

Required fix:

Update `research/print-acceptance.md` to the hash of the current generated PDF, and ensure the acceptance date and page observations refer to that exact file. Re-run the final PDF and visual acceptance after any further source change; update both the committed checksum and the acceptance record together. Do not hand-edit the digest: generate it with the documented build recipe.

Suggested validation:

```bash
just pdf
just pdf-check
just pdf-repro
just visual
sha256sum build/jj-book.pdf
sed -n '1,8p' research/print-acceptance.md
```

Verify that the digest in `research/print-acceptance.md` equals both the digest in `build/jj-book.pdf.sha256` and the freshly computed digest, then inspect the listed PDFium samples. Also confirm that `jj-book.pdf` remains a symlink to `build/jj-book.pdf` after the rebuild.

## Checks performed

| Check | Result |
|---|---|
| Target jj | jj 0.45.1. The corrected `current_working_copy` and `working_copies.map` template forms execute under the installed binary. |
| Evolog validator | Passes standalone: `evolog validation passed for jj 0.45.1`. |
| HTML check | `just html-check` passes: 970 IDs and 212 internal links. |
| CLI check | `just cli-check` passes: 121 canonical command paths. |
| PDF check | `just pdf-check` passes: 526 pages, 540 x 720 pt, 9 fonts, 16 links, 193 outline entries. |
| PDF reproducibility | `just pdf-repro` passes with byte-identical repeated renders. |
| Visual recipe | `just visual` passes and renders 15 independent PDFium samples. The previously clipped pages were additionally inspected and are now readable. |
| Root artefact | `jj-book.pdf` remains a symlink to `build/jj-book.pdf`; `jj-book.html` remains a symlink to `src/book.html`. |
| Black-block glyph check | No black-block glyph issue was observed in the inspected current pages. |
| Full validation | The full `just validate` recipe remains limited by disabled native Git operations in this review environment; this does not indicate a failure in the corrected template or PDF checks. |

The review is not a PASS until the acceptance-record digest is synchronized with the current PDF.
