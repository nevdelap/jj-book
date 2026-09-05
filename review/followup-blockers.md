# Follow-up blockers (historical snapshot)

> FUP-B-001 below is resolved in the current 476-page build. The current
> review has zero blockers; see [`current-followup-review.md`](current-followup-review.md).

## FUP-B-001

ID: FUP-B-001  
Severity: BLOCKER  
Area: Kindle Scribe PDF / Unicode rendering  
File: `src/book.html`, `build/jj-book.pdf`, `scripts/render-pdf.py`  
Section: graph diagrams throughout the book

### Claim or issue

Box-drawing characters such as `─`, `├`, `└`, and `│` in the canonical HTML
are rendered in the PDF as black-square glyphs. The affected diagrams are a
central part of the book's graph-first teaching method.

### Evidence

The source contains 1,252 `─` characters, 28 `├` characters, 32 `└`
characters, and 43 `│` characters. The cleanly rebuilt PDF contains no
extractable box-drawing characters but contains `■` on 105 pages, with 1,461
occurrences. Representative extracted PDF text includes:

```text
before: root ■■ A ■■ B ■■ @
predecessor P■  (hidden after rewrite)
successor P■■■■■■■■■
```

The PDF's nine font resources are only standard Type 1 fonts (`Helvetica`,
`Times`, `Courier`, `Symbol`, and `ZapfDingbats`); no Unicode-capable font is
embedded. The renderer also reports that it is using xhtml2pdf's limited CSS
implementation. `scripts/validate-pdf.py` checks that font resources exist but
does not check glyph coverage or raster output, so the green validation run
does not detect this defect.

Reproduce with:

```bash
uv run --frozen python - <<'PY'
from pathlib import Path
from pypdf import PdfReader

source = Path("src/book.html").read_text()
reader = PdfReader("build/jj-book.pdf")
text = "\n".join(page.extract_text() or "" for page in reader.pages)
print({c: source.count(c) for c in "─├└│"})
print("black-square pages:", sum("■" in (p.extract_text() or "") for p in reader.pages))
print("black-square occurrences:", text.count("■"))
PY
```

### Why it matters

The graph diagrams are not decorative. They communicate parent edges,
descendant rebasing, divergence, conflicts, and ref placement. A black block
where an edge should be makes the graph ambiguous or unreadable and fails the
requirement that the PDF be practically usable on a Kindle Scribe.

### Required fix

Use a PDF-safe, Unicode-capable embedded font with verified box-drawing glyphs,
or replace the character-based diagrams with a rendering method whose output is
portable (for example, CSS/SVG/vector diagrams or ASCII restricted to a tested
character set). Do not merely make the extracted text pass while leaving the
visual glyphs broken. Preserve selectable text where practical and document
font licensing/embedding provenance.

### Suggested validation

Render representative pages containing linear, branching, merge, conflict, and
divergence diagrams with an independent PDF renderer. Check visually at the
intended reading scale and run a source/PDF glyph regression test. The test
must fail if box-drawing characters become `■`, replacement glyphs, or missing
glyphs. Repeat after `just clean && just build`.
