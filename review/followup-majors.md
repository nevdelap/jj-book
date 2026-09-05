# Follow-up major findings

## FUP-M-001

ID: FUP-M-001  
Severity: MAJOR  
Area: appendices / reference value  
File: `src/book.html`  
Section: Appendices A–K

### Claim or issue

The appendices do not have uniform standalone reference value. Several are
still compact navigation cards or delegated pointers rather than the usable
references promised by their titles.

### Evidence

Measured from the authored HTML appendix material:

| Appendix | Direct/associated content | Assessment |
|---|---:|---|
| A — Complete command tree | 141 words, one command-tree block | Useful as a compact tree; not a command reference by itself. |
| B — Option index | 100 words, 11 option rows | Not an index of the command options; it explicitly sends the reader to raw help. |
| C — Revset reference | about 1,600 words, 85 table rows across continuation material | Potentially useful, though split between a quick card and continuation sections. |
| D — Fileset reference | 45-word opening card plus later material in a separate card section | The opening appendix is too short and the richer material is not cleanly attached to it. |
| E — Template reference | about 1,650 words, 84 rows plus formatting material | Substantive enough to retain, but navigation/hierarchy needs consolidation. |
| F — Configuration reference | 44-word opening card plus task/family tables elsewhere | Too thin as presented and still partly delegates to schema/inventory. |
| G — Git-to-jj lookup | 162 words, 13 rows | Useful compact lookup with appropriate non-equivalence warnings. |
| H — GitHub recipes | about 1,100 words plus 9 code blocks | Useful fieldbook material; consolidate duplicate summary and fieldbook headings. |
| I — Gerrit recipes | about 780 words plus 5 code blocks | Useful but must retain explicit server-dependent boundaries. |
| J — Recovery recipes | about 590 words, 4 code blocks and a table | Useful starting field card; a decision tree would improve incident use. |
| K — Linux shell integration | about 670 words, 3 code blocks, table and list | Useful fieldbook material; keep it operational rather than a one-paragraph card. |

The short first cards for C–F and H–K are followed later by “continued”,
“standalone reference cards”, or “fieldbook” sections. That makes the reader
work out which fragments together form the actual appendix.

### Why it matters

The requested book must stand on its own without repeatedly consulting raw
help, inventories, or installed commands. A heading plus a short pointer is
not a reference. A reader using Appendix B, D, or F at the terminal will not
find the promised option, fileset, or configuration information in the first
appendix section.

### Required fix

Consolidate each appendix into one clearly navigable unit. Keep A and G compact
if their purpose is explicitly a quick lookup. Expand B into a real option
index with command ownership, argument type, defaults/interaction, and links to
the command entries. Make D and F complete human references rather than
delegations to help/schema. Give C/E their complete function/method surfaces,
signatures, version notes, and useful examples in the appendix itself.

### Suggested validation

For each appendix, record in the completeness report whether it is:

```text
quick lookup
reference-complete
workflow-demonstrated
standalone and navigable
```

Open the generated PDF outline and printed contents, jump to each appendix,
and verify that the title leads to the complete material without requiring a
search for a later “continued” section.

## FUP-M-002

ID: FUP-M-002  
Severity: MAJOR  
Area: PDF navigation / HTML heading architecture  
File: `src/book.html`, `scripts/render-pdf.py`, `build/jj-book.pdf`  
Section: reference appendices and command entries

### Claim or issue

Important reference sections are authored as `h4` headings, but the PDF
outline generator only collects `h2` and `h3`. As a result, the richer fileset,
template, and configuration reference cards are not independently navigable in
the PDF outline.

### Evidence

`render-pdf.py` documents and implements `if tag in {"h2", "h3"}`. The source
places important sections such as `Appendix D — Fileset grammar and consumer
matrix`, `Appendix E — Template type and method map`, and
`Appendix F — Configuration reference by task` under the `Standalone reference
cards` section as `h4` elements. The generated outline contains
`Standalone reference cards` but does not contain those three appendix-card
headings. The outline does contain only the earlier short Appendix D/E/F
headings and their later `continued` headings.

### Why it matters

The PDF is the primary publication artefact. A serious reference book must let
the reader navigate directly to the actual reference, especially when the
content is intentionally split into teaching chapters and lookup material.
The current hierarchy makes the reference look shorter than it is and hides
the most useful portion from the PDF outline.

### Required fix

Give each appendix one semantic section with consistent heading levels and
make the PDF outline include the heading level needed for reference navigation
(or restructure the sections so h2/h3 are sufficient). Ensure printed contents,
HTML anchors, and PDF outline titles agree.

### Suggested validation

Add a validation assertion that the PDF outline includes the final navigable
heading for every appendix and every reference card. Test links from the HTML
contents and outline destinations after a clean build.

## FUP-M-003

ID: FUP-M-003  
Severity: MAJOR  
Area: depth audit / project evidence  
File: `research/depth-audit.md`  
Section: per-Part and per-appendix audit entries

### Claim or issue

The depth audit is not consistently an audit of the current manuscript. Its
opening measurement describes the expanded 472-page/94k-word state, but many
per-section entries still describe the pre-expansion 47-page manuscript.

### Evidence

The file says the current Part IV fileset section is “introduced only
(approximately one page)”, the template treatment is “introduced only
(approximately one page)”, the CLI reference is “inventory-level”, workflows
are “checklist/recipe level”, and the appendices are “one paragraph”. Those
statements are not reconciled with the current HTML's later laboratories,
command dossiers, fieldbooks, and reference-card sections. The file also
continues to list those expansions as required work without a current status
column.

### Why it matters

The depth audit was required to measure the actual manuscript and drive the
expansion plan. A mixed pre-expansion/current document prevents the author and
reviewer from knowing which shallow findings remain and makes the completeness
report difficult to trust.

### Required fix

Retain the historical baseline if useful, but label it explicitly as
pre-expansion. Add a current audit for every Part, chapter, appendix, and
reference section with current depth, evidence, remaining gaps, and status.
Reconcile it with `research/completeness-report.md` and the expansion plan.

### Suggested validation

Have the audit table drive a checkable status summary. Each major subject must
state independently whether it is mentioned, explained, demonstrated,
explored, reference-complete, and empirically validated.

## FUP-M-004

ID: FUP-M-004  
Severity: MAJOR  
Area: print CSS / Kindle Scribe layout  
File: `src/book.html`, `scripts/render-pdf.py`  
Section: print stylesheet and PDF rendering

### Claim or issue

The print stylesheet declares deliberate page-break, widows/orphans, table,
and overflow controls, but the selected PDF renderer explicitly ignores many
of them.

### Evidence

Every clean `just build` emits warnings that xhtml2pdf does not implement
`break-after`, `break-before`, `break-inside`, `widows`, `orphans`, `max-width`,
`overflow`, `columns`, and related properties. It also cannot evaluate several
CSS `var(...)` colour declarations. The stylesheet and README nevertheless
describe these controls as part of the Kindle Scribe print profile.

### Why it matters

The book contains long code blocks, dense tables, graph diagrams, and chapter
starts. Ignored controls can split or clip exactly the material the print
profile is supposed to protect. A successful PDF parse does not establish
usable pagination.

### Required fix

Either use a renderer that supports the required print controls, or redesign
the print stylesheet around the renderer's actual supported feature set and
prove the resulting pagination. Do not claim that ignored controls are active.

### Suggested validation

Add a clean-build PDF inspection covering chapter starts, code blocks, tables,
diagrams, widows/orphans, links, grayscale contrast, and annotation margins.
Record representative page numbers and inspect them with an independent PDF
renderer at normal Scribe scale.

## FUP-M-006

ID: FUP-M-006  
Severity: MAJOR  
Area: contents design / navigation  
File: `src/book.html`, `scripts/render-pdf.py`, `build/jj-book.pdf`  
Section: printed contents and PDF outline

### Claim or issue

The contents listing is excessively granular. The printed contents exposes
almost every `h2`/`h3` destination, including command entries, lab exercises,
case-study stages, and appendix continuations.

### Evidence

The HTML navigation has 55 deliberately selected links, but the authored HTML
contains 313 `h2`/`h3` headings and the generated PDF outline contains 312
entries. The printed contents occupies approximately PDF pages 1–21 before
the substantive body begins. The contents includes entries such as `jj
bookmark delete`, `Lab 6: partial squash`, `Stage 4: review feedback on the
ancestor`, `Dossier: jj squash`, and `H.6 Use an upstream repository and a
fork`.

### Why it matters

An advanced reader needs depth, but the contents listing should reveal the
learning path and reference map. A roughly 20-page contents section is hard to
scan on a Kindle Scribe and consumes useful reading/annotation space. The
printed contents and electronic outline are currently coupled even though they
need different levels of detail.

### Required fix

Separate printed-contents inclusion from PDF-outline inclusion. Keep Parts,
major chapters, major reference sections, and Appendices A–K in the printed
contents. Keep fine-grained anchors and selected electronic destinations
available without printing every command, lab, checklist, and case-study
stage.

### Suggested validation

Build from a clean tree and report printed contents page count separately from
PDF outline entry count. Confirm all Parts, major chapters, and appendices are
listed, while detailed HTML anchors and selected PDF outline destinations still
work.

## FUP-M-007

ID: FUP-M-007  
Severity: MAJOR  
Area: duplication, ordering, and depth distribution  
File: `src/book.html`, `research/depth-audit.md`, `research/completeness-report.md`  
Section: Parts I–XVI and post-Part-XVI supplemental sections

### Claim or issue

The underlying content is not excessive in total, but its structure is
fragmented. Important subjects are taught in a short primary Part and then
revisited in later fieldbooks, atlases, dossiers, labbooks, and appendices.
The later material is not consistently labelled as practice or reference, so
the book has an unclear second progression after Part XVI.

### Evidence

An exact authored-paragraph comparison found no repeated prose paragraphs,
which argues against wholesale literal duplication. However, the source has
primary and later layers for the same subject: revsets in Part III, the
language fieldbook, the revset atlas, and Appendix C; CLI material in Part XIV,
command dossiers, a command atlas, and Appendix A/B; and workflows in Part
XVI, the hosting fieldbook, and the book-wide lifecycle analysis.

The primary Parts are uneven: Part VI Git backend is about 1.5k words, Part XI
workspaces about 1.2k, Part V bookmarks about 2.0k, and Part VII GitHub about
2.2k, while Part XIV CLI reference is about 17.5k. Later supplements partly
compensate for the shorter operational Parts.

### Why it matters

The advanced reader needs a coherent route through difficult material. A
reader should not have to discover a later fieldbook to obtain the depth that
the primary chapter appears to promise, nor read several similarly positioned
sections to determine which explanation is authoritative.

### Required fix

Keep the substantive material, but establish one primary teaching location per
major concept, place practice near that teaching, and label/reference-link the
lookup material separately. Reorder or explicitly group the post-Part-XVI
sections as a reference/practice part. Strengthen thin primary operational
Parts only where their later supplements currently supply missing explanation.

### Suggested validation

For every major subject, record a primary teaching, practice, reference, and
workflow location. Confirm that the main sequence is usable without reading a
later fieldbook first and that no later section repeats a definition without a
clear new purpose.

## FUP-M-008

ID: FUP-M-008  
Severity: MAJOR  
Area: substantive scale/depth target  
File: `research/expansion-plan.md`, `research/depth-audit.md`, `research/completeness-report.md`  
Section: manuscript size and completion measure

### Claim or issue

The former 210,000–230,000-word target was excessive for the agreed
450–600-page Kindle-Scribe design and the observed page density. The target
should be revised, but substantive coverage must still be judged independently
of word count.

### Evidence

The current manuscript is approximately 94–95k substantive words and 472 PDF
pages, including roughly 20 pages of printed contents. This is about 210 words
per non-contents page. At that density, 450–600 pages corresponds roughly to
95–126k words. The reviewer therefore recommends a 100,000–130,000-word range;
the calculation and caveats are in `word-count-target-revision.md`.

### Why it matters

The old target could encourage padding or produce a book near 1,000 pages at
the current layout density. Conversely, adopting a lower target must not be
used to excuse shallow treatment of high-risk subjects. The project needs one
calibrated size measure and separate depth/coverage acceptance criteria.

### Required fix

If adopted by the project owner, update the expansion plan, depth audit, and
completeness report together to state the 100,000–130,000-word recommendation,
the page-density basis, and the independent depth criteria. Add words only for
missing explanations, demonstrations, workflows, or reference value.

### Suggested validation

Use one reproducible substantive-word-count script, report counts by Part, and
verify that every required area is explained, demonstrated, explored, or
reference-complete as appropriate. Rebuild the PDF after structural
consolidation and record both page and word counts.

## FUP-M-005

ID: FUP-M-005  
Severity: MAJOR  
Area: PDF validation quality  
File: `scripts/validate-pdf.py`  
Section: font and visual validation

### Claim or issue

The PDF validator's message says the PDF contains “embedded/selectable font
resources”, but its check only verifies that page resource dictionaries contain
font names. It does not verify embedding, Unicode coverage, missing-glyph
substitution, or visual rendering.

### Evidence

The validator passes the current PDF with nine standard Type 1 font resources,
while the same PDF demonstrably contains black-square replacements for source
box-drawing characters. No `/FontFile`, `/FontFile2`, or `/FontFile3` embedding
stream is checked, and no glyph regression or independent raster inspection is
performed.

### Why it matters

This validation gap allowed the reported PDF defect to pass `just review`. A
green build currently means “text objects and font resource names exist”, not
“the reader sees the intended glyphs”.

### Required fix

Make the validator's claims precise and add glyph/visual checks appropriate to
the selected renderer. If standard built-in fonts are intentional, test every
non-ASCII character used by the source and state the portability limitation.
If embedding is required, assert actual embedded font streams and licensing
provenance.

### Suggested validation

Use a disposable glyph fixture containing all diagram characters and compare
source characters with extracted text and an independent raster render. Make
the validation fail on black-square, replacement, or missing-glyph output.
