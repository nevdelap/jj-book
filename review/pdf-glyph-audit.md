# PDF glyph and print audit

## Current status

The former black-square finding is resolved. The current source contains no
box-drawing diagram characters, and current PDF extraction contains zero
occurrences of the tested box-drawing characters, `■`, or the Unicode
replacement character. The historical evidence below records the defect that
was found before the repair. Current layout findings are in
[`current-followup-review.md`](current-followup-review.md).

## Historical finding (resolved)

The current PDF contains black-square substitutions for the box-drawing
characters used in graph diagrams. This is a release-blocking Kindle Scribe
defect; see `followup-blockers.md` FUP-B-001.

## Evidence snapshot

| Check | Result |
|---|---:|
| Source `─` characters | 1,252 |
| Source `├` characters | 28 |
| Source `└` characters | 32 |
| Source `│` characters | 43 |
| PDF pages containing `■` | 105 / 472 |
| PDF `■` occurrences | 1,461 |
| PDF extracted box-drawing characters | 0 |
| PDF font resources | 9 standard Type 1 resources; no embedded Unicode font |

## Representative extracted output

The source contains diagrams such as:

```text
before: root ── A ── B ── @
```

The corresponding PDF text extraction contains:

```text
before: root ■■ A ■■ B ■■ @
```

Other affected content includes branch/merge diagrams and evolution diagrams.
The extraction result is sufficient to prove that the intended characters are
not preserved in the PDF text layer; the visual report of black blocks is
consistent with that evidence.

## Print-pipeline limitation

The clean build logs that xhtml2pdf ignores `break-before`, `break-after`,
`break-inside`, `widows`, `orphans`, `max-width`, `overflow`, and several CSS
variables. The HTML declares those controls, but this renderer does not apply
them. `validate-pdf.py` checks page geometry, text presence, metadata, links,
and outline entries, but not font coverage, glyph correctness, clipping,
table/diagram splits, or annotation-scale readability.

## Required acceptance test

After repair, build from a clean tree and inspect representative pages for:

- linear, fork, merge, divergence, and conflict diagrams;
- long code blocks and tables;
- chapter starts and page breaks;
- black-and-white/grayscale contrast;
- internal links and outline destinations;
- normal Kindle Scribe reading scale and annotation margins.

The test must be independent of the source HTML alone. A PDF that merely
contains the source characters in an extraction stream is not sufficient if
the rasterised glyphs are still missing.
