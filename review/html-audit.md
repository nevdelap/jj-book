# HTML architecture audit

## Status

The canonical source passes the principal HTML-first requirement. `src/book.html` is a directly authored semantic HTML document with headings, sections, tables, figures-as-preformatted diagrams, code blocks, a TOC, internal IDs, and embedded print CSS. `jj-book.html` is a working-tree symlink to it. There is no Markdown-to-HTML production path.

Independent parsing found 464 headings, 192 IDs, 25 internal links, no duplicate IDs, and no broken internal fragment links. Heading levels do not skip from one level to a deeper level in the parsed sequence.

## Findings

- **B-001:** HTML is not connected to a reproducible PDF build.
- **m-001:** Most deep headings lack IDs, reducing navigation/reference usability even though current links are valid.
- The HTML includes a large number of compact command articles and tables, but this structure does not itself establish explanatory depth. Part XI is a concrete example: headings exist while prose remains approximately 171 words.
- The document embeds CSS and has screen/print media separation, but no PDF output exists to verify actual page boxes, links, font embedding, or print behavior.

## Required validation after build exists

Check semantic HTML, fragment targets, TOC coverage, code/table/figure structure, print-specific page breaks, PDF outline/bookmarks, hyperlink annotations, metadata, and screen-reader/read-order behavior. Add stable IDs to reader-facing reference headings before generating a long PDF.

