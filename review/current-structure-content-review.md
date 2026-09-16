# Current structure, content, consistency, depth, and breadth review

> Superseded as the current authoritative review by
> [`latest-review.md`](latest-review.md), dated 2026-09-11. This report is
> retained as the previous review baseline.

Review date: 2026-09-10 UTC  
Project: `Jujutsu for Git Experts: Graph-First Version Control`  
Normative target: jj 0.45.1 only

## Scope and method

This is the current review of the authored book, not a review of the older
compact-guide baseline. It compares the actual canonical HTML
(`src/book.html`) with the declared scope and the current depth/expansion and
completeness records. It also checks the generated PDF and the validation
interface. The review distinguishes literal duplication from repeated subject
coverage, and inventory breadth from reader-facing explanatory depth.

Commands and checks used include:

```text
just validate
just review
just pdf
uv run --frozen python scripts/validate-html.py
uv run --frozen python scripts/validate-structure.py
uv run --frozen python scripts/validate-toc-order.py
uv run --frozen python scripts/validate-pdf.py
uv run --frozen python scripts/render-visual-samples.py
```

The current HTML has 735 h2–h4 headings, 121 command-entry articles, 948
HTML IDs, and 76 internal links. An exact comparison of 1,391 substantive
paragraphs found no duplicate paragraph groups. That is good evidence against
literal copy-and-paste duplication, but it does not establish that repeated
topics have distinct teaching, laboratory, reference, and workflow roles.

The current PDF is 489 pages at 540 × 720 pt, with 70 outline entries. The
printed contents occupies two pages (PDF pages 2–3), with the preface starting
on page 4, and the current visual samples show no black-block glyph defect,
clipping, or missing-glyph defect. The contents listing is now reasonably
curated; the main issue in this
review is the organisation and depth of the book behind it.

## Overall verdict

**REQUIRES MAJOR REVISION**

The book has broad subject coverage and a substantial page count. Its strongest
areas are the graph model, rewriting, revsets, filesets, templates, and the
large 0.45.1 command inventory. It is not failing because it is too long, and
there is no evidence of widespread literal duplication.

It is not yet a well-shaped, consistently deep technical book. The current
structure presents a primary teaching sequence followed by a second sequence
of fieldbooks, atlases, textbooks, laboratories, and appendices that revisit
the same subjects. Several primary parts are thin while later material supplies
the missing depth, and the first “complete real workflows” list contains
summary cards rather than complete workflows. The result is broad and
substantive in aggregate, but fragmented for a reader and uneven against the
promises made by chapter titles and the depth audit.

## Current structure and ordering assessment

The first route through Parts I–XVII is broadly sensible for the target reader:

1. jj vocabulary and invariants;
2. graph and identity model;
3. rewrites;
4. revsets and filesets;
5. bookmarks and Git boundaries;
6. GitHub and Gerrit;
7. conflicts, operations, and workspaces;
8. configuration and templates;
9. CLI reference;
10. advanced mechanics;
11. integrated workflows.

The problem begins after that route. Part XVIII introduces “Practice,
reference, and fieldbooks”, followed by `Advanced field manual`, `Book-wide
analysis`, `Language fieldbook`, `Revset reference atlas`, `Configuration and
template reference`, `Standalone references`, `Command reference atlas`,
`Mechanics textbook`, `Advanced mechanics labbook`, `Practice curriculum`, and
`Hosting protocol fieldbook`, before the appendices. The HTML explicitly calls
this an “intentional second mode of use”, which is honest, but it remains a
second book-like sequence rather than a clean continuation or clearly separated
back matter.

The same topic consequently has several possible homes. For example, revsets
are taught in Part IV, revisited in the language fieldbook and reference atlas,
and indexed again in Appendix C; commands are taught in earlier parts,
catalogued in Part XV, revisited in the command atlas, and indexed in
Appendices A/B; workflows appear in Part XVII, the later casebook, the
hosting fieldbook, and recovery/edge-case material. This can be valid only if
the roles are explicit and non-competing. At present the reader must infer
which occurrence is the authoritative explanation, which is practice, and
which is lookup.

### Required structural outcome

Retain the technical substance, but give every major subject one clearly
authoritative teaching location. Place its laboratory or worked case close to
that teaching location where practical. Put compact lookup material in a
clearly labelled reference/back-matter route. If a later section intentionally
revisits a topic, label the distinct role and link back to the primary
explanation. The main contents route should let a reader learn the model and
complete representative work without hunting through the second sequence.

## Depth and breadth assessment

The book is broad: the target-version inventory, revsets, filesets, templates,
configuration, bookmarks, Git backend, GitHub, Gerrit, conflicts, operations,
workspaces, advanced mechanics, and workflows all have named treatment. Local
fixtures also validate representative graph, revset, conflict, workspace,
Git-backend, operation, and template behaviour.

Aggregate breadth should not be mistaken for balanced depth. Approximate prose
counts by current main h2 section show the following thin primary areas:

| Area | Approx. words in primary section | Assessment |
|---|---:|---|
| Bookmarks/publication | 1,697 | Too compressed for the publication/tracking scope; later hosting material supplies the missing lifecycle. |
| Git backend | 2,189 | Useful boundary explanation, but important colocation/import/export and transport detail is distributed elsewhere. |
| GitHub | 1,490 | Correct local philosophy, but too short as the primary lifecycle chapter. |
| Conflicts | 1,845 | The model is present; the lifecycle and descendant consequences are mostly deferred to later labs/cases. |
| Workspaces | 1,618 | Important facts are present, but scenarios and multi-machine consequences are split into later material. |
| Complete workflows | 2,581 including later subsections | The opening eleven items are checklist-sized; the fuller cases are later and fragmented. |

The stronger language chapters do not remove this imbalance: Part IV revsets
is about 6,729 words, Part V filesets about 3,699, and Part XIV templates
about 5,071, while the CLI surface is wide but many individual entries remain
short. This is an ordering and depth problem, not a request to pad the book
or to add beginner material.

## Finding FUP14-M-002 — duplicated subject routes are not sufficiently role-labelled

ID: FUP14-M-002  
Severity: MAJOR  
Area: structure, ordering, duplication, reader navigation  
File: `src/book.html:87-100, 5899-5901, 6082, 6185, 6348, 6451, 6568, 6767, 6845, 7102, 7196, 7279`; `research/depth-audit.md`  
Section: Part XVIII and later fieldbooks/reference sections

Claim or issue: the manuscript presents a second book-like sequence after the
main teaching route and repeatedly revisits the same subjects without a
consistently explicit primary-teaching / practice / reference / workflow
division.

Evidence: Part XVIII is followed by field manuals, language/reference atlases,
a command reference atlas, mechanics textbook, labbook, curriculum, hosting
fieldbook, and dense appendices. The source itself says Part XVIII is a second
mode of use. The topic map shows revsets, commands, configuration/templates,
mechanics, and workflows in both the primary route and later sections. Literal
paragraph duplication is not the issue: the exact substantive-paragraph check
found zero duplicate groups. The issue is conceptual and navigational overlap.

Why it matters: an advanced reader cannot reliably tell where a concept is
first established, where it is tested, and which later table or section is the
canonical reference. This weakens progression, increases the chance of
inconsistent terminology or examples, and makes the book feel like a sequence
of appended research products rather than one coherent technical work.

Required fix: retain useful material but reorganise or relabel the later route.
For each major subject, identify one authoritative teaching section, one
nearby laboratory/case location, one reference location, and any workflow
application. Add explicit role labels and cross-references; remove only
genuinely redundant material after that mapping. Make the primary route
complete without requiring the reader to discover a later fieldbook.

Suggested validation: produce a topic-to-location map; for revsets, filesets,
templates, configuration, CLI, conflicts, operations, GitHub, Gerrit, and
workspaces verify that the teaching, practice, reference, and workflow links
are unambiguous. Read the contents route in order and record whether each
major concept is introduced before use and whether later repetitions add a
distinct purpose.

## Finding FUP14-M-003 — “complete real workflows” is initially a checklist, not a complete workflow treatment

ID: FUP14-M-003  
Severity: MAJOR  
Area: workflows, depth, graph-first demonstration  
File: `src/book.html:5507-5530`; fuller material begins at `src/book.html:5531` and later sections  
Section: Part XVII — Complete real workflows

Claim or issue: the first eleven items under the part titled “Complete real
workflows” are summary cards of roughly 16–39 words each, and several merely
name a sequence or point to a later narrative. They do not themselves show the
repository state over time required by the book brief.

Evidence: examples include “Branchless daily development” as a one-sentence
summary, “Two remotes” as a short instruction to fetch and qualify symbols,
and “Recovery” as a short list of inspection commands. The later
`workflows-deep`, casebook, hosting fieldbook, and recovery sections contain
more useful narratives, but those are separated from the named workflow list.
The current depth audit calls the eleven items “end-to-end narratives”, which
does not match their actual size and treatment.

Why it matters: the reader is promised complete workflows but is first given a
recipe index. Critical interactions—before/after graphs, remote state,
rewrites, review feedback, upstream movement, conflicts, recovery, final
state, and cleanup—are not consistently visible in one navigable workflow.
This is especially important for GitHub, Gerrit, multi-machine, and recovery
scenarios where state transitions are the subject of the book.

Required fix: either rename the opening list to a workflow map and make the
later narratives the clearly linked authoritative workflows, or expand the
named workflows in place. At least the principal GitHub, Gerrit, upstream
conflict, recovery, workspace, and multi-machine workflows should each show a
meaningful starting graph, commands and state transitions, publication/review
events where applicable, resulting graph/ref state, and recovery or cleanup.
Do not inflate every workflow artificially; make the important ones complete.

Suggested validation: select the principal workflows and check each against a
state ledger containing initial local/remote graph, command, resulting graph,
commit/change-ID consequences, bookmark/remote consequences, conflict state,
operation-log consequence, and final state. Verify that the workflow can be
read without searching unrelated later sections for essential steps.

## Finding FUP14-M-004 — CLI breadth is complete, but the promised reader-facing reference remains uneven

ID: FUP14-M-004  
Severity: MAJOR  
Area: CLI reference depth and consistency  
File: `src/book.html:4154-4215` and `src/book.html:4217-5460`; `scripts/validate-cli-reference.py`  
Section: Part XV — Exhaustive CLI reference for jj 0.45.1

Claim or issue: the book has excellent inventory breadth—47 top-level commands,
121 public paths, and 121 command articles—but many entries do not meet the
structured reference contract promised by the section. Critical detail is
scattered through other parts rather than being consistently discoverable from
the command entry.

Evidence: article extraction shows 121 entries totalling about 10,031 words;
16 entries are under 40 words, 53 under 60, and 88 under 100. Examples include
`jj gerrit upload` at about 65 words, `jj bisect run` at about 71, `jj run` at
about 61, and several operation/workspace/bookmark subcommands in the 40–97
word range. The section promises syntax, options, cardinality, state effects,
and traps, while the requested reference contract also calls for option
interactions, filesets, descendant effects, refs/backend effects, edge cases,
related commands, and version notes where applicable. Those fields are not
consistently present in the individual entries.

The independent path/count check also exposes a tooling defect: the prose says
“contains 47 top-level commands and 121 public command paths”, but
`validate-cli-reference.py:10-16` searches only for the wording
“reports ... top-level commands and ... public command paths”. Consequently
`just review` fails at `cli-check` even though the inventory numbers themselves
are correct.

Why it matters: inventory completeness is not reference completeness. A reader
looking up a high-risk command such as `gerrit upload`, `run`, operation
recovery, or workspace state still has to hunt through teaching chapters or
raw help. The stale validator also makes the primary review interface fail on
the current authored wording.

Required fix: make the reference entries for high-risk and interaction-heavy
commands self-contained enough to cover their important syntax, options and
state consequences, with a consistent compact schema. It is acceptable for
trivial inspection commands to remain short. Either make the prose/count
parser robust to the intended wording or change the documented sentence and
add a test that validates semantic numbers rather than one exact phrase. The
normal `just review` recipe must pass.

Suggested validation: compare each 0.45.1 path with the local help capture;
sample all mutation, transport, recovery, workspace, conflict, fileset, and
configuration commands against the reference schema; verify links to the
primary explanation; run `just review` from a clean tree and confirm the
reader-facing count and path checks pass.

## Finding FUP14-M-005 — current manuscript size records are inconsistent

ID: FUP14-M-005  
Severity: MAJOR  
Area: completeness evidence, expansion accounting, release consistency  
File: `research/depth-audit.md:18-19`; `research/expansion-plan.md:13`; `README.md:13`; `research/completeness-report.md:17-19`; `research/print-acceptance.md:6`; `research/version-matrix.md:27`  
Section: current size and completion records

Claim or issue: current project records disagree about the size and current
artefact. The completeness and print-acceptance records report approximately
98,534 words and 489 pages, while the depth audit, expansion plan, README,
version matrix, and stale reviewer summary still report approximately
103,525–103,639 words and 510 pages.

Evidence: the current serial PDF is 489 pages with SHA-256
`500e27d64f8c23cca821b5955161eb7d3a7c2215dba7d54af329665962b7bae3`; the
current completeness report and print-acceptance record contain those values.
The other listed files retain the older values. The current 98,534-word count
is also below the lower bound of the stated 100,000–130,000 substantive-word
design range, although the page count remains within the 450–600-page target.

Why it matters: the depth and expansion records are used to support the claim
that the corrective expansion is complete. Stale larger figures can conceal a
reduction in substantive content and make it impossible to tell which report
describes the artefact being released. The numeric word target and page target
also need an explicit relationship rather than contradictory completion claims.

Required fix: regenerate or reconcile all current size and artefact records
from the same clean build and counting method. State whether the revised word
target is a hard acceptance threshold or a design range, explain why the
current page target is met if the word count is below the lower range, and
remove stale figures from README/research/current reports. Update the depth
audit’s per-section classifications to match the actual structural/depth
assessment; it should not mark thin primary workflow or command treatment as
complete merely because later material exists.

Suggested validation: run the canonical counting script and serial
`just pdf`; compare page count, hash, word count, printed contents, and outline
against every current record; then rerun `just validate` and `just review`.

## Finding FUP14-M-006 — embedded cover assets are absent from the current asset provenance record

ID: FUP14-M-006  
Severity: MAJOR  
Area: licensing/provenance and distributed assets  
File: `src/book.html:34`; `assets/cover.png`; `assets/cover-dag.png`; `research/licenses.md:80`; `research/book-license.md`; `THIRD_PARTY_NOTICES`  
Section: cover and visual assets

Claim or issue: `assets/cover.png` is embedded in the canonical HTML/PDF, and
`assets/cover-dag.png` is a repository asset, but neither file has a dedicated
per-asset provenance/licence record. The current licence text says there are
no third-party images and the register says no third-party visual assets are
used, but it does not establish the origin, ownership, generation terms, or
distribution basis for the actual cover files.

Evidence: `src/book.html` references `../assets/cover.png`. Both assets are
regular PNG files; their hashes are:

```text
80b52af2c30c6e935e425cd0b1bd91d5c585ff42f308ca86a3c8a040809d0605  assets/cover.png
26c966a86f055127201976755f6370f1ed2e6c2ef80a74f557f758e5d6917a7c  assets/cover-dag.png
```

The embedded PNG metadata identifies OpenAI Media Service API and generated
image provenance. That metadata is useful evidence of origin but is not by
itself a complete statement of the applicable service terms, ownership, or
redistribution permission. `cover-dag.png` is not referenced by the current
HTML and appears stale or unused.

Why it matters: an embedded image is distributed material. The absence of an
asset-level provenance and permission decision leaves a release compliance
question unresolved, even if no infringement is currently proven. The
unreferenced second asset also creates ambiguity about which visual files are
part of the release.

Required fix: record each asset, hash, inclusion status, creator/source or
generation method, applicable authoritative terms, attribution and
modification obligations, and permission to distribute. If the assets were
supplied by the project owner, record that provenance and permission. If they
were generated by a service, retain the applicable terms/evidence. Mark
`cover-dag.png` as intentionally shipped or remove it in an author-controlled
change; reconcile the “no third-party images/assets” statements with the
actual facts. Do not alter the ledger merely to make the finding disappear.

Suggested validation: inspect the final distributable file list; hash and
match every image/font/icon; verify the authoritative terms; inspect the PDF
for embedded assets; and rerun the licence/provenance audit.

## Passing areas and non-findings

- The target-version policy is coherent: jj 0.45.1 is the sole normative
  target, and 0.44.0 is not treated as current book content.
- Canonical source is first-class HTML and the PDF is generated from it.
- The root HTML and PDF convenience artefacts are real relative symlinks.
- Serial `just pdf` and `just validate` succeed; the current PDF is valid and
  visually usable in the inspected samples.
- The printed contents is now compact enough to be useful, and its spacing at
  the body transition is acceptable. This review does not reopen the former
  contents-listing finding.
- No exact substantive paragraph duplication was found. The required work is
  role separation and navigational consolidation, not indiscriminate deletion.
- Breadth is strong at the inventory level. The findings concern the uneven
  reader-facing depth and placement of that breadth.

## Current finding count

```text
BLOCKER: 0
MAJOR: 5
MINOR: 0
```

The verdict remains `REQUIRES MAJOR REVISION` because the structure/depth,
workflow, reference-depth, consistency, and asset-provenance findings remain
release-significant. No blocker was identified in this pass.

## Reproduction and handoff

From `/workspace`:

```sh
just validate
just pdf
just pdf-check
just review       # currently fails at cli-check because of the wording parser
stat -c '%F %N' jj-book.html jj-book.pdf build/jj-book.pdf
```

Current authored parent:

```text
jj revision ID (jj change ID): kutrrxmounltwlzlonrqzxmlqttoswrm
commit ID: c0a9aac9d7499b148908a5568eb9b30d4d3ae5ba
```
