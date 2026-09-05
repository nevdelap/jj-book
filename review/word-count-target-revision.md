# Word-count target revision

Review date: 2026-09-06

## Revised judgement

The earlier 210,000–230,000 substantive-word target was excessive for the
agreed 450–600 Kindle-Scribe-page design. It was not calibrated against the
actual page geometry, code/table density, diagrams, or the large printed
contents section.

The revised reviewer recommendation is:

```text
100,000–130,000 substantive book words
450–600 Kindle-Scribe-optimised PDF pages, including front matter and contents
```

This is a design range, not a padding quota. A technically complete book may
fall near either edge if the page design and coverage justify it.

## Evidence and calculation

The current build has approximately 94,849 words under an independent parser
that excludes `pre`, `script`, and `style` content, and 472 PDF pages. The
printed contents occupies roughly 20 pages, leaving approximately 452 pages of
book and reference material. That is approximately 210 substantive words per
non-contents page at the current typography and density.

At that observed density:

```text
450 pages × approximately 210 words/page ≈ 95,000 words
600 pages × approximately 210 words/page ≈ 126,000 words
```

The recommended 100k–130k range allows for restructuring, targeted technical
expansion, and pagination variation without implying that a 210k-word book
should be forced into 450–600 pages. At the current density, 210k words would
likely produce roughly 1,000 pages before further layout changes.

## What this changes

The current ~95k manuscript is close to the revised lower bound. Its word count
is no longer a standalone release blocker. The remaining review question is
whether the major topics are sufficiently explained, demonstrated, validated,
and reference-complete—not whether the manuscript reaches an arbitrary large
word quota.

The book still needs targeted work where the structure is weak: coherent
bookmark/Git/GitHub/workspace coverage, consolidated appendices, clear teaching
versus laboratory versus reference roles, and removal of unnecessary
repetition. That work may naturally bring the manuscript into the revised
range, but words should be added only when they improve coverage.

## Required project-record action

This review does not silently alter the author's production records. If the
project owner adopts this revised target, update `research/expansion-plan.md`,
`research/depth-audit.md`, and `research/completeness-report.md` together, with
one reproducible counting method and an explanation of the page-density basis.

