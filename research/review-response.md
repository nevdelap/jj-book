# Response to the independent review

> Historical response. The current follow-up status is recorded in
> `research/followup-review-response.md` and the generated completeness report.

Review scope: `review/review-summary.md`, `review/blockers.md`,
`review/majors.md`, and the associated audit files. This response records the
state after the corrective expansion and clean rebuild on 2026-09-06.

## Blockers

| Finding | Response | Evidence/status |
|---|---|---|
| B-001 — no reproducible HTML-to-PDF pipeline or PDF artefact | Implemented a first-class HTML-to-PDF path using the locked `uv` environment, `xhtml2pdf`, and `pypdf`; added `just pdf`, `just build`, `just test`, `just review`, `just clean`, and PDF validation. | Resolved. `build/jj-book.pdf` is generated from `src/book.html`; root `jj-book.pdf` is a symlink; 472 pages, 540 × 720 pt, selectable text, metadata, links, fonts, page-number footers, printed contents, and PDF outlines validated. |
| B-002 — manuscript far below the requested 210–230k words | Added substantial technical chapters, experiments, language workbenches, command dossiers, hosting/recovery recipes, and standalone appendices. | Partially resolved, not hidden: current substantive count is approximately 94,307 words. The book now renders to 472 pages, but it remains below the requested manuscript scale. Further expansion is still required for this finding to be fully closed. |
| B-003 — incorrect `heads()` worked example | Replaced the incorrect merge result and added an executable merge fixture asserting the expected head and parent set. | Resolved. `just validate` runs `scripts/validate-revsets.sh` and `scripts/validate-semantics.sh`. |
| B-004 — missing required `just` interface | Added and documented the required build, PDF, test, clean, review, inventory, comparison, and validation recipes. | Resolved. `just --list` and the clean `just review` run are the interface checks. |

## Major findings

The following corrective changes are included in the current tree:

* The build is a locked `uv` project and does not depend on an undeclared
  system Python package.
* The 0.44.0 command tree has 120 canonical reader-facing command entries;
  the 0.45.1-only `converge` entry is explicitly labelled as comparison
  material. `scripts/validate-cli-reference.py` checks this relationship.
* Invalid examples identified by the review—author/committer predicates,
  sparse selection syntax, workspace rename syntax, and the immutable-head
  configuration trap—are corrected or deliberately presented only as
  negative examples.
* Validators now assert repository semantics, not merely command exit status:
  merge heads and parent counts, change-ID stability versus commit-ID change,
  bookmark targets, real sparse files, conflicts before/after resolution,
  template output, revset results, workspace state, and local Git remote refs.
* The source trail now includes URL/title/version/topic records, a provenance
  map for chapter material, licence decisions, an Apache-2.0 notice for
  generated Jujutsu-derived help material, and a CC BY 4.0 statement for
  original book prose.
* GitHub and Gerrit are treated as protocol-specific workflows with local
  mechanics separated from server/UI behaviour. The new hosting fieldbook and
  appendices develop PR stacks, review iterations, Gerrit patch sets, trunk
  movement, partial landing, remote selection, recovery, and cleanup.
* Conflicts, operation recovery, workspaces, sparse trees, templates,
  revsets, filesets, configuration, and command behaviour now have lifecycle
  chapters, worked state transitions, or reader-facing reference tables; raw
  research files remain evidence rather than the only documentation.
* Stable IDs were added throughout the authored HTML, and the root HTML/PDF
  symlink requirements are checked after a clean build.

## Minor findings

Stable section IDs, the clean `just` shell environment, and the root symlink
layout are implemented. The symlink layout is represented by filesystem
symlinks in the working tree; it is not silently replaced with copied output.

## Current quality boundary

The current result is materially beyond the original 47-page compact guide and
crosses the lower 450-page print-design threshold. It is not yet a 210–230k
word book. The completeness report therefore distinguishes inventory
coverage, reader-facing reference coverage, conceptual explanation,
empirical validation, and workflow demonstration instead of declaring the
project complete from a passing build alone.

## Reproduction

From `/workspace`:

```sh
uv sync --locked
just clean
just review
```

The final run used jj 0.44.0 as the normative binary and jj 0.45.1 as the
comparison binary. Server-side GitHub/Gerrit behaviour, real signing hardware,
and external interactive tools remain correctly marked as not locally
validated.
