# Contents-listing audit

Review date: 2026-09-06  
Scope: the book's contents listings and navigation, not the level of detail in
the underlying chapters

## Verdict

The contents listing is excessively detailed for a printed Kindle Scribe PDF.
The HTML navigation is reasonably compact, but the generated printed contents
and PDF outline expose almost every `h2`/`h3` heading. The result is roughly
20 pages of contents before the book reaches its substantive opening.

This is a **MAJOR navigation/presentation issue**, not a recommendation to
shorten the technical book. The book can retain detailed chapters, exercises,
command entries, and reference sections while presenting a much more useful
contents listing.

## Evidence

| Listing | Result |
|---|---:|
| HTML navigation links | 55 total: 26 top-level and 29 selected subentries |
| Authored `h2`/`h3` headings | 313 |
| Generated PDF outline entries | 312 |
| Printed contents span | PDF pages 1–21; body begins on page 21/22 |

The printed contents includes fine-grained destinations such as individual
command entries, case-study stages, practice labs, edge-case items, dossier
sections, and appendix continuation headings. Examples visible in the PDF
contents include `jj bookmark delete`, `Lab 6: partial squash`, `Stage 4:
review feedback on the ancestor`, `Dossier: jj squash`, and `H.6 Use an
upstream repository and a fork`.

## Why it is excessive

The printed contents is meant to answer “where should I go?” It currently
duplicates the entire detailed PDF outline, including destinations that are
too granular to help a reader choose a route through the book. Twenty pages of
contents consumes meaningful Kindle reading/annotation space and makes the
main progression harder to see.

The electronic outline can legitimately be more detailed than the printed
contents. Those two navigation products are currently coupled: the same
heading collection drives the generated contents and the PDF outline.

## Recommended hierarchy

The printed contents should normally expose:

- Preface;
- Parts I–XVI;
- major numbered chapters within each Part;
- major standalone reference/workflow sections;
- Appendices A–K.

The following should normally remain available as HTML anchors or a detailed
electronic outline, but should not all appear in the printed contents:

- individual command entries;
- individual lab exercises;
- case-study stages;
- checklist items;
- edge-case catalogue entries;
- appendix continuation headings.

The PDF outline may retain more detail, but it should be intentionally
curated. A useful implementation is to mark headings explicitly for printed
contents inclusion, rather than deriving both products from every `h2`/`h3`.

## Required fix

Separate printed-contents inclusion from PDF-outline inclusion. Reduce the
printed contents to a scannable chapter/Part/reference map, while preserving
fine-grained anchors and electronic navigation where they add value. Ensure
the first contents page clearly exposes the book's learning path rather than
starting with a long undifferentiated list of subtopics.

## Suggested validation

After revision:

1. Build from a clean tree.
2. Record printed contents page count and PDF outline entry count separately.
3. Confirm the printed contents fits in a small number of pages.
4. Confirm that every Part, major chapter, and appendix is present.
5. Confirm that detailed HTML anchors and selected PDF outline destinations
   still work.

