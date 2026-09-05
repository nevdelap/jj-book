# Kindle Scribe PDF audit

## Result

**BLOCKED — no PDF is present or reproducibly generatable.**

The HTML has a deliberate-looking print profile at `src/book.html:1-25`: `@page { size: 7.5in 10in; ... }`, print margins, print font sizes, code/table rules, widow/orphan controls, and screen navigation suppression. Those are source-level intentions only. No Chromium, Firefox, wkhtmltopdf, WeasyPrint, Pandoc, or other PDF renderer was found on PATH, and the repository supplies no renderer or PDF recipe. `build/` contains only validation fixtures.

## Unverified acceptance areas

- actual page size and orientation;
- page count against the 450–600 target;
- readable body/code/diagram scale at normal Scribe reading scale;
- tables, diagrams, code wrapping, clipping, and page breaks;
- grayscale contrast and annotation whitespace;
- PDF links, outline/TOC, metadata, and font embedding;
- repeated chapter starts, widows/orphans, and long reference tables.

## Required fix

Provide a pinned HTML-to-PDF toolchain and produce a current PDF. Inspect representative pages at 100% equivalent scale, including dense CLI/reference pages, code-heavy pages, diagrams, tables, conflict/graph pages, and chapter starts. Record renderer, fonts, page count, metadata, and reproducible build commands.

