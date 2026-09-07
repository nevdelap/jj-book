# Independent release review summary

This file records the current follow-up review. Earlier compact-guide and
expansion-pass findings remain below as historical evidence. The current
authoritative report is
[`current-followup-review.md`](current-followup-review.md).

## Current verdict

**PASS WITH MINOR CHANGES**

The previous workspace ordering/duplication, stale-workspace wording, and
visual-sample coverage findings are closed. The clean 510-page PDF is rendered
from the canonical HTML, the two-page printed contents ends before the body,
the revised contents and chapter ordering are coherent, and the root PDF and
HTML convenience artefacts are real relative symlinks. The diagram-spacing
defect is closed; one generated completeness-report checksum is stale.

See the complete current findings, commands, evidence, and required fixes in
[`current-followup-review.md`](current-followup-review.md).

## Current baseline

- Normative target: jj 0.44.0; comparison target: jj 0.45.1.
- Environment: Linux; Git 2.53.0; `uv` 0.12.5; `just` 1.45.0.
- Canonical source: `src/book.html`; `jj-book.html` is a symlink to it.
- PDF: 510 pages at 540 × 720 pt; generated from the HTML by the pinned
  xhtml2pdf/pypdf pipeline.
- Substantive manuscript: approximately 102,796 words; revised design range is
  100–130k words.
- Root PDF: `jj-book.pdf` is a symlink to `build/jj-book.pdf` after clean
  rebuild.
- Contents: two printed pages; body begins on page 3; electronic outline has
  322 entries.

## Current finding counts

- BLOCKER: 0
- MAJOR: 0
- MINOR: 1

The detailed commands, evidence boundaries, and closure checks are in
[`current-followup-review.md`](current-followup-review.md).

## Reproducibility

`just clean && just review` passed. The resulting PDF checksum
(`5cf34095c2549947cb0745e8f1d90c0f9302555c78b302ea06c8a96b8092c580`)
verified, both
root convenience artefacts were recreated as relative symbolic links, and the
visual recipe produced 15 current PDFium samples including both contents pages
and the changed workspace/configuration sections.

---

## Historical first-review baseline

Review date: 2026-09-06 UTC  
Project: `Jujutsu for Git Experts: Graph-First Version Control`

## Baseline

- Normative target: jj 0.44.0.
- Comparison target: jj 0.45.1.
- Environment: Linux; Git 2.53.0; `uv` 0.12.5; `just` 1.45.0; Bash.
- Installed target binaries: `.toolchain/bin/jj` = 0.44.0 and `.toolchain/jj-0.45/bin/jj` = 0.45.1.
- Source: `src/book.html`; root `jj-book.html` is a working-tree symlink to `src/book.html`.
- Measured authored content: approximately 49,954 words excluding `pre`, `script`, and `style` content; the project’s generated report records 49,868. The stated design target is 210,000–230,000 substantive words and approximately 450–600 Kindle-Scribe pages.

## Historical acceptance status (superseded)

| Area | Status | Evidence |
|---|---|---|
| HTML-first source | PASS | `src/book.html` is maintained directly as semantic HTML; root HTML is a symlink. |
| PDF pipeline | BLOCKED | No PDF exists under `build/`; no PDF recipe or renderer is provided. The README explicitly delegates PDF generation to a reader print dialog. |
| Kindle Scribe PDF | BLOCKED | No current PDF can be rendered or inspected; PDF metadata, links, fonts, pagination, and annotation layout are therefore unverified. |
| jj version policy | PASS WITH MINOR CHANGES | 0.44.0 and 0.45.1 are explicitly separated and local help snapshots exist. |
| Technical correctness | BLOCKED | A revset workbook gives a false `heads()` result, and several executable examples fail against jj 0.44.0. |
| CLI completeness | REQUIRES MAJOR REVISION | Independent inventory has 120 canonical paths; the book has 121 articles but omits canonical `jj operation ...` headings in favour of `jj op ...` aliases and includes a 0.45-only `jj converge` entry. |
| Licence/provenance | REQUIRES MAJOR REVISION | Conservative claims and an Apache licence copy exist, but the required per-source provenance fields, exact page/source records, notices, and final-distribution mapping are incomplete. |
| `uv` | REQUIRES MAJOR REVISION | `uv` is installed and used for one report measurement, but `uv sync` fails because there is no `pyproject.toml` or `uv.lock`; Python version/dependency policy is undeclared. |
| `just` | BLOCKED | `just` exists, but there are no `build`, `pdf`, `test`, `clean`, `review`, or full validation recipes. The claimed publication cannot be built through the primary interface. |
| Root publication symlink | PASS for HTML / BLOCKED for PDF | `jj-book.html -> src/book.html` is a real symlink (`stat` reports symbolic link); no root PDF or generated PDF target exists. |
| Validation | REQUIRES MAJOR REVISION | `just validate` passes, but scripts mostly discard output and assert exit status rather than graph/ref/operation semantics; one expected stale-workspace check is explicitly ignored with `|| true`. |
| Manuscript depth | BLOCKED | The manuscript remains a compact, uneven guide. Parts VII, IX, and XI measure about 810, 838, and 171 prose words respectively; appendices are not standalone complete references. |

## Historical verdict (superseded)

**BLOCKED**

Finding counts: 4 BLOCKER, 13 MAJOR, 3 MINOR, 0 NIT.

The repository is a useful HTML-first technical skeleton with explicit version discipline and a working local jj fixture baseline, but it is not release-ready. The missing reproducible HTML-to-PDF build, absent Kindle-Scribe artefact, scale/depth shortfall, false revset worked example, and incomplete required task interface are release-blocking. Do not issue `PASS`, `PASS WITH MINOR CHANGES`, or `REQUIRES MAJOR REVISION` until the publication/build blockers are resolved and the technical re-review is repeated.

Finding details are in `blockers.md`, `majors.md`, and the area reports.
