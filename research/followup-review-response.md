# Response to the follow-up review

Review inputs: `review/followup-summary.md`, `review/followup-blockers.md`,
`review/followup-majors.md`, `review/followup-minors.md`, and their glyph,
contents, appendix, and structure audits. This response records the corrective
pass after that review.

## Status

The follow-up blocker caused by missing Unicode diagram glyphs is resolved.
The former 210,000–230,000-word scale is replaced by the review-calibrated
100,000–130,000-word range; the current manuscript is 102,796 words by the
single project counting method and is within that range. The current PDF is
510 pages, including two contents pages after the contents-density correction
and the later workspace-definition expansion.

## FUP-B-001 — missing diagram glyphs

Resolved by replacing all box-drawing and other diagram-only characters that
the pinned Type 1 renderer cannot represent with an ASCII-safe diagram alphabet:
`-`, `|`, `+`, `\`, and `>`. This preserves selectable graph text and avoids a
font dependency whose licence and embedding behaviour would need a separate
distribution audit. `scripts/validate-pdf.py` now fails if the source contains
the unsafe diagram characters or if the PDF contains black-square or Unicode
replacement substitutions. The final build contains zero such substitutions.

The source print-profile note explains this choice. The rendered output has
page-number footers, generated contents, and PDF outlines; representative
graph text is extractable as the same ASCII characters used in the HTML.

## Follow-up majors

* FUP-M-001: Appendix A and G remain intentionally compact quick lookups. B
  now contains a contract-oriented option index with owner, argument, effect,
  and interaction columns. C–F have direct links from their directory cards
  to the fuller language/configuration reference material. H–K explicitly say
  that their first entry is a directory card and link to the complete
  fieldbook. The appendix audit in `research/depth-audit.md` records each
  appendix's role and remaining limitation.
* FUP-M-002: The PDF outline collector includes selected `h4` reference-card
  headings in addition to `h2`/`h3`. Validation requires the actual D, E, and
  F reference destinations to be present in the outline.
* FUP-M-003: The depth audit now labels its older per-topic entries as the
  historical pre-expansion audit and supplies a current Part/appendix matrix
  with teaching, practice, reference, workflow, and evidence status.
* FUP-M-004: Unsupported xhtml2pdf break/overflow/column/variable CSS has been
  removed from the print profile. The stylesheet is now deliberately based on
  properties the pinned renderer accepts, including the explicit
  `pdf:nextpage` contents break and `-pdf-keep-with-next`; the output validator
  checks page geometry, text, footers, contents, outlines, and missing-glyph
  regressions.
  Visual inspection at physical Scribe scale remains a human acceptance step
  because no independent raster PDF renderer is installed in this minimal
  environment.
* FUP-M-006: Printed contents and electronic outline are now separate. Only
  the selected Part/chapter/reference/appendix headings carry xhtml2pdf TOC
  flags, while the pypdf outline retains detailed electronic destinations.
  At that review stage, the printed contents was three pages after the explicit
  front-matter break,
  and Appendix A–K are individual entries pointing at substantive destinations.
* FUP-M-007: A new Part XVIII explicitly groups the post-Part-XVII material as
  practice, reference, fieldbook, and recovery modes. The current depth audit
  records the primary teaching, practice, reference, and workflow location for
  every Part and appendix. Directory cards link directly to later complete
  material rather than pretending to be independent chapters.
* FUP-M-008: The project records adopt the reviewer-recommended 100,000–130,000
  substantive-word range and retain independent depth/reference criteria. The
  word-count method is the one used by `write-completeness-report.sh`.
* FUP-M-005 and FUP-m-001: PDF validation now checks the actual failure mode
  found by review, not merely the presence of font resource names. The report
  records one word-count method, page count, contents span, and outline count.
* FUP-m-003: README and the generated toolchain checksum record state that
  normal recipes invoke and verify the pinned local jj binaries rather than an
  ambient `PATH` executable.

## Reproduction evidence

From `/workspace`:

```sh
just clean
just review
```

The final clean build uses jj 0.44.0 as the normative binary and jj 0.45.1 as
the required comparison binary. It validates the HTML, all local jj fixtures,
the separate printed-contents/outline products, ASCII glyph safety, page
geometry, metadata, text presence, links, root symlinks, and independent
PDFium sample rendering. GitHub/Gerrit server behaviour, real signing
hardware, and external interactive tools remain explicitly outside local
validation.

## Second follow-up corrections

The latest review's three major findings are addressed in the current edition:

* The contents/body boundary is forced with the pinned renderer's
  `pdf:nextpage` tag. Heading flow uses the renderer-supported
  `-pdf-keep-with-next` property, and `validate-pdf.py` checks representative
  Part, reference, and appendix headings for following body material.
* The operative scale in `research/depth-audit.md` and
  `research/expansion-plan.md` is 100,000–130,000 substantive words. Older
  larger targets remain only where a historical review record explicitly
  describes them as superseded.
* Part VII now includes a 0.44.0 object/ref experiment and the corresponding
  fixture. It distinguishes workspace-local `@`, Git `HEAD`, object
  existence, ordinary ref reachability, the Git index, the non-standard
  `change-id` header, colocation, non-colocation, import/export, and push.

Appendix D/E/F/H–K directory cards now visibly say “Directory only — continue”
and the electronic/printed destinations point to the complete material. Modes
are labelled on repeated laboratory, workflow, fieldbook, and reference
headings. Independent PDFium rendering is now pinned and run by `just visual`;
the inspected representative pages and observations are recorded in
`research/print-acceptance.md`.

## Third follow-up corrections

The subsequent release review found that the 0.44 colocation default was still
reversed in two reader-facing passages. Those passages now state that
`jj git init` and `jj git clone` are colocated by default unless
`git.colocate=false`, with `--no-colocate` as the explicit non-colocated form
and `--colocate` retained as documentary/script intent. The command entries,
clone/init table, and Git-backend validation fixture agree with the installed
0.44 help. The fixture also tests the default and `git.colocate=false`
layouts.

## Fourth follow-up correction

The latest review identified one remaining minor print-layout issue: the
third printed contents page held only five appendix entries. Print-only
contents typography was tightened within the pinned xhtml2pdf profile so that
all selected contents entries now fit on two pages. That corrected build was
503 pages total; after the later workspace-definition expansion, the current
PDF is 512 pages. In both editions, pages 1–2 are the printed contents and
page 3 begins the preface. Appendix A–K remain individual contents entries and electronic outline
destinations. PDFium samples of pages 1–4 were rendered and inspected after
the rebuild. No contents/body collision was reintroduced.

The empty `Colocated versus non-colocated` subsection heading was removed. The
Git pointer laboratory now owns its experiment, followed by a separate
`Reference: colocated versus non-colocated layout` heading for the comparison
table. The heading-flow validator and the PDFium sample inspection both cover
that transition.

Physical acceptance is no longer only a documented limitation. The locked
`pypdfium2==5.13.0` dependency and `scripts/render-visual-samples.py` provide
an independent PDFium render path; `just review` runs it. Representative
pages were inspected and the results are recorded in
`research/print-acceptance.md`. GitHub/Gerrit server behaviour and external
interactive tools remain the explicit validation boundary.

## Fifth follow-up correction

The latest review found that workspace material had been inserted again
between configuration sections. The duplicate workspace laboratory and its
stray section were removed. Part XII now owns the workspace model, the
build/review invariants, the precise 0.44 stale-workspace diagnosis, sparse
workspace materialisation, and the two-machine handoff. Part XIII is once
again a contiguous configuration progression. The printed contents already
had a deliberate `Workspace laboratory` destination under Part XII; the
structural validator now asserts that required workspace headings precede
Part XIII and that the misplaced workspace-laboratory forms cannot return.

The stale-state wording was corrected to match jj 0.44: a workspace is stale
when its recorded working-copy commit is no longer current for that workspace
because repository state changed. Ordinary external edits are unrecorded
working-copy changes, not stale metadata. Moved directories and damaged
locations are separate filesystem problems. The workspace fixture now writes
an external edit, verifies it through `jj status`, runs `jj workspace
update-stale`, asserts the “not stale” diagnostic, and verifies that the edit
survives. This makes the documented repair boundary executable rather than
just verbal.

The visual-sample recipe now clears its output directory, renders both
contents pages, and locates the current Part XII workspace and Part XIII
configuration headings only after the body boundary, avoiding false matches
in the printed contents. A clean `just review` pass produced the current
510-page PDF, 102,796-word generated substantive count, 322 PDF outline
entries, and 15 current PDFium samples. The inspected samples include pages
2, 168, 171, 176, 183, and 185; the Part XII start, workspace laboratory,
Part XII–XIII transition, configuration laboratory, and configuration
reference all have readable following material. The root HTML and PDF remain
relative symlinks.
