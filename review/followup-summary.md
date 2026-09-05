# Follow-up review summary (superseded)

> This is the prior follow-up snapshot. It recorded the black-block PDF defect
> before the author's ASCII diagram repair. The current status is in
> [`current-followup-review.md`](current-followup-review.md), which supersedes
> this file.

Review date: 2026-09-06  
Baseline: jj 0.44.0 (`.toolchain/bin/jj`); comparison binary jj 0.45.1  
Environment: Linux, `uv 0.12.5`, `just 1.45.0`, Git 2.53.0  
Scope: follow-up after the depth-expansion response, including the reported PDF black blocks and the usefulness of every appendix.

## Verdict

**BLOCKED**

The repository now has a reproducible HTML-to-PDF build, coherent `uv`/`just`
recipes, passing local validation, and correctly recreated root symlinks. Those
structural improvements are accepted.

The release remains blocked by one acceptance failure:

1. Box-drawing characters used by the book's graph diagrams render/extract as
   black-square glyphs in the PDF. The defect affects 105 pages and 1,461
   extracted black-square occurrences. This makes a core explanatory device
   materially unreadable.
The former 210–230k word target has been judged excessive for the observed
layout density. The reviewer now recommends 100–130k words. The current
94–95k manuscript is near that revised range, so word count is no longer a
standalone blocker. Coverage, ordering, and depth remain major review
questions.

## Status matrix

| Area | Follow-up status | Evidence |
|---|---|---|
| Target version | PASS | `jj 0.44.0`; separate 0.45.1 comparison binary and inventories |
| Canonical HTML | PASS | `src/book.html`; `jj-book.html` is a symlink |
| PDF derives from HTML | PASS | `scripts/render-pdf.py`; clean `just build` succeeds |
| PDF glyph correctness | **BLOCKER** | 1,252 source box-drawing characters become 1,461 `■` glyphs in 105 PDF pages |
| Kindle Scribe geometry | PARTIAL | 472 pages at 540 × 720 pt; visual/code/diagram correctness is not established |
| Substantive scale/depth | REVISED | about 94–95k words is near the revised 100–130k target; coverage/structure remain separate major questions |
| Appendices | **MAJOR** | B is a selected flag card, D/F are thin or structurally hidden; see `appendix-audit.md` |
| Contents listing | **MAJOR** | Printed contents spans roughly 20 pages and exposes 312 fine-grained outline destinations; see `contents-listing-audit.md` |
| Duplication/order/depth distribution | **MAJOR** | No exact paragraph duplication, but primary Parts and later fieldbooks/atlases/dossiers overlap and depth is uneven; see `structure-depth-audit.md` |
| Word-count target | REVISED | 210–230k was excessive for the observed density; reviewer recommendation is 100–130k; see `word-count-target-revision.md` |
| `uv` | PASS | locked project; `uv sync --locked`; `uv run --frozen` recipes |
| `just` | PASS | coherent task list; `just review` passes |
| Root publication links | PASS | both root artefacts are relative symlinks after clean rebuild |
| Technical validation | PASS WITH LIMITS | local validators pass; server-side GitHub/Gerrit and several interactive features remain untested |
| Provenance/licensing | PASS WITH RESERVATIONS | expanded ledger; no copied assets identified in this follow-up |

## Reproducibility record

Commands run:

```text
just review
just clean
just build
sha256sum -c build/jj-book.pdf.sha256
stat -c '%F %N' jj-book.html jj-book.pdf build/jj-book.pdf
```

Results:

```text
just review                         PASS
clean rebuild                       PASS
PDF validation                      472 pages, 540 x 720 pt, 9 font resources
checksum                            OK
jj-book.html                        symlink -> src/book.html
jj-book.pdf                         symlink -> build/jj-book.pdf
```

The build emits warnings that xhtml2pdf ignores `break-before`, `break-after`,
`break-inside`, `widows`, `orphans`, `max-width`, `overflow`, and related CSS.
That is recorded as a major print-pipeline finding even though the build exits
successfully.

## Required release actions

Resolve both blockers, then rerun the full review. In particular, the author
must repair the PDF glyph pipeline and complete the substantive expansion (or
provide a technically justified revised target accepted by the project owner).
The appendix reference material must also be consolidated and navigable before
the book can be called a serious standalone reference.
