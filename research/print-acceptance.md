# Kindle Scribe print acceptance

Edition checked: 2026-09-06 UTC. Target page box: 7.5 × 10 inches (540 ×
720 points), portrait. The final edition is 510 pages: printed contents on
pages 1–2 and the preface beginning on page 3. Renderer: pinned xhtml2pdf
0.2.18, followed by pinned pypdf 6.1.3.

## Automated acceptance

`just pdf` and `uv run --frozen python scripts/validate-pdf.py` check the page
box on every page, selectable text, page-number footers, generated contents,
individual Appendix A–K destinations, PDF outlines, links, fonts, and common
missing-glyph substitutions. The renderer-specific `<pdf:nextpage />` tag is
used to put the preface after the printed contents, and
`-pdf-keep-with-next` is used on headings. These controls are supported by the
pinned renderer and are deliberately preferred over browser-only pagination
properties.

## Independent visual inspection

The pinned `pypdfium2==5.13.0` dependency supplies an independent PDFium
renderer. `just visual` (also included by `just review`) clears its output
directory and renders the following
representative pages at 72 DPI, corresponding to the PDF's 540 × 720 point
page box:

* both printed contents pages, the title page, and the first preface page;
* a primer and non-linear DAG/code page from Parts I–II;
* a dense revset table and a fileset/template table;
* a GitHub lifecycle page and a Gerrit stack page;
* a conflict page and an operation-recovery page;
* a configuration table and a command-reference page;
* Appendix D, E, F, H, I, J, and K landing destinations.

Inspection performed on 2026-09-06 UTC with PDFium 5.13.0: the title and both
contents pages have consistent margins; the contents ends before the preface;
the Part XII workspace start, workspace laboratory, Part XII–XIII transition,
configuration laboratory, and configuration reference all show headings with
readable following material. The locator searches for these headings after the
body boundary, so it cannot mistake a printed contents entry for the current
body page. Tables and code blocks in the sample set remain inside the page
margins; no clipping, missing glyphs, or contrast defects were observed at the
rendered page scale. The PNG samples are generated under
`build/visual-inspection/` and are intentionally ignored build artefacts.
Page numbers are edition-specific and should be refreshed after any
substantive HTML change.

PDFium is an independent renderer for acceptance, not the HTML-to-PDF build
renderer. Its wrapper and bundled engine retain their BSD/Apache and dependent
licence notices; see `research/licenses.md` and the locked `uv` environment.
