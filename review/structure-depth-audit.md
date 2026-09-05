# Structure, duplication, ordering, and depth audit

Review date: 2026-09-06  
Source: `src/book.html`  
Scope: whether the material is duplicated, ordered coherently, and deep enough
for the stated advanced-reader brief

## Overall judgement

The underlying book content is **not excessive in total** relative to the
agreed 450–600-page technical-book ambition. At approximately 94–95k
substantive words, it is near the revised reviewer recommendation of
100–130k words. It should not be shortened merely because the contents
listing is too long.

The material does have a structural problem: it is fragmented into a primary
Part sequence followed by several supplementary books-within-the-book. There
is no evidence of widespread literal copy duplication—an exact paragraph check
found no repeated prose paragraphs—but there is substantial conceptual and
navigational overlap. The result is uneven depth: some important subjects are
short in their primary Part and are expanded later, while some later reference
and lab sections revisit earlier teaching without a sufficiently explicit
division of roles.

## Duplication check

### Literal duplication

An exact comparison of authored paragraphs found 1,407 substantive paragraphs
and no exact duplicate paragraph groups. This is evidence against a simple
copy-and-paste duplication problem.

### Structural/conceptual overlap

The following subjects occur in both a primary Part and later supplemental
sections:

| Subject | Primary location | Later overlap |
|---|---|---|
| Graph model and rewriting | Parts I–II | Advanced field manual; command dossiers; mechanics textbook |
| Revsets | Part III | Language fieldbook; revset reference atlas; Appendix C |
| Filesets | Part IV | Language fieldbook; Appendix D cards |
| Configuration/templates | Parts XII–XIII | Configuration/template reference; Appendix E/F |
| CLI commands | Part XIV | Command dossiers; command reference atlas; Appendix A/B |
| Advanced mechanics | Part XV | Advanced mechanics labbook; practice curriculum |
| Workflows | Part XVI | Hosting fieldbook; book-wide lifecycle analysis; recovery/edge-case sections |

This overlap can be justified if the first occurrence teaches, the second
provides practice, and the third is a lookup reference. The current headings
do not consistently state those roles, so readers may experience the later
sections as repetition rather than deliberate progression.

## Ordering check

### What works

The first sequence is broadly appropriate:

1. model and identities;
2. rewriting;
3. revsets and filesets;
4. bookmarks and Git interoperability;
5. GitHub/Gerrit;
6. conflicts, operations, and workspaces;
7. configuration and templates;
8. CLI reference;
9. advanced mechanics;
10. integrated workflows.

That sequence supports an advanced Git reader moving from jj invariants to
language surfaces, publication, recovery, and reference use.

### What does not work as well

After Part XVI, the book begins another substantial sequence:

```text
advanced field manual
language fieldbook
command dossiers
revset reference atlas
configuration/template reference
command reference atlas
advanced mechanics labbook
practice curriculum
hosting protocol fieldbook
standalone references
book-wide analysis
edge-case catalogue
mechanics textbook
appendices
```

This is not a natural next chapter after “Complete real workflows”. It reads
as a second reference/course book appended to the main book. Some of this
material belongs immediately after the relevant teaching Part; the rest should
be explicitly grouped as `Practice`, `Reference`, or `Fieldbook` material.

The appendices then repeat the split again with short cards followed by
continuation/reference/fieldbook sections. The problem is primarily ordering
and signposting, not the existence of the material.

## Depth distribution

Approximate authored words by primary Part, including that Part's direct
subsections:

| Part | Words | Depth judgement |
|---|---:|---|
| I — mental model | 4.3k | Good foundation, but later model material is separated from it. |
| II — rewriting | 5.8k | Appropriate core depth; later dossiers/labs repeat the same command family. |
| III — revsets | 7.6k | Strongest language treatment; reference material is scattered later. |
| IV — filesets | 4.1k | Reasonable overall, though the reference is split from the teaching. |
| V — bookmarks | 2.0k | Thin as a primary Part; later Git/publication material supplies some depth. |
| VI — Git backend | 1.5k | Thin as a primary Part; important transport material is deferred. |
| VII — GitHub | 2.2k | Short primary treatment; later fieldbook/case material is needed to make it useful. |
| VIII — Gerrit | 3.6k | Better developed, but identity/workflow material is distributed. |
| IX — conflicts | 2.2k | Short primary treatment; lifecycle material is split into later labs. |
| X — operations/recovery | 3.5k | Reasonable foundation; recovery depth is distributed across several sections. |
| XI — workspaces | 1.2k | Thin primary treatment; later workspace material is necessary. |
| XII — configuration | 5.1k | Substantive, with reference content deferred. |
| XIII — templates | 6.1k | Substantive language chapter; later reference material is appropriate if clearly labelled. |
| XIV — CLI reference | 17.5k | Very large and reference-heavy; should not dominate the learning contents. |
| XV — advanced mechanics | 4.6k | Broad but uneven; some topics remain compressed. |
| XVI — workflows | 4.0k | Initial recipes are short; later narratives supply the real depth. |

The pattern is not “too much content everywhere”. It is “thin primary
chapters plus later compensating supplements” for bookmarks, Git, GitHub,
conflicts, and workspaces, alongside a very large CLI/reference area.

## Required editorial outcome

- Keep the technical substance needed to reach the agreed book scale.
- Establish one primary teaching location for each major concept.
- Put its laboratory immediately after the teaching location where practical.
- Put lookup tables in a clearly labelled reference section rather than
  repeating them as new chapter-level material.
- Move or relabel the post-Part-XVI material as a deliberate reference and
  practice section, rather than leaving it to appear as a second main book.
- Expand thin high-risk primary areas only where the later material currently
  compensates for missing explanation; do not add volume to already adequate
  reference surfaces merely to make the contents longer.

## Validation after restructuring

For each major topic, record:

```text
primary teaching location:
practice/laboratory location:
reference location:
workflow location:
cross-references:
```

Then verify that a reader can follow the main sequence without reading a later
fieldbook first, and can reach the detailed reference without encountering a
second competing explanation of the same concept.
