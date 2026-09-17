# Completeness report

Generated: 2026-09-17

## Targets

* Target: jj 0.45.1 (expected 0.45.1)
* Git: unavailable (native Git commands are disabled in this validation environment)
* Authored deliverable: ../jj-book.html, a symlink to the first-class HTML source src/book.html

## Inventories

* Top-level commands found: 47
* Command paths with dedicated local help captured: 121
* Reader-facing CLI articles in the authored HTML: 121
* Reader-facing CLI articles covering the target command paths: 121
* Substantive authored-book words (approximate, excludes pre/script/style): 107416
* Expansion design target: 100,000–130,000 substantive words / approximately 450–600 Kindle-Scribe pages
* Rendered PDF pages: 521 (7.5 × 10 inch portrait; see build/jj-book.pdf.sha256)
* Rendered PDF SHA-256: 7374ce4c3da6579a16bfdf2dde536e712ab2c6e6ac723927d0913e8d6da7b061
* PDF build timestamp: 2026-09-17T12:37:37Z (embedded in PDF metadata and the printed cover)
* Printed contents span: 5 page(s) before the substantive preface; PDF outline entries: 196
* Revset operators: documented in research/revset-inventory.md and the raw help snapshot
* Revset function names: 63 extracted help entries; grouped prose is in the HTML
* Fileset function entries: 3 extracted help entries; syntax is in raw help
* Config commands: edit, gc, get, list, path, set, unset
* Config schema: captured as research/config-schema-0.45.1.json with jj util config-schema
* Pinned binary checksums: recorded in research/toolchain-checksums.md
* Depth audit: recorded in research/depth-audit.md
* Expansion plan and completion record: recorded in research/expansion-plan.md
* Current licensing/distribution register: recorded in research/licenses.md
* Raster asset provenance and inclusion status: recorded in research/assets.md
* Frozen build-environment package licence inventory: recorded in research/license-package-inventory.md
* Template features: objects, methods, operators, conditionals, lists, labels, colours, aliases

## Validated

* jj 0.45.1 version/help and recursive command inventory
* colocated init, snapshot/new, log, diff, files, status, bookmarks, operation undo/redo
* local bare Git remote add, push, fetch, and tracking
* Git-backend object/HEAD/ref reachability, raw change-id header, colocated export, and non-colocated layout fixture
* authored template examples against the validation repository
* dedicated evolog fixture: successive versions, descendant rebasing, ordering/limit modes, the inter-diff option, template identity export, and divergent successors
* representative revset topology, state, pattern, and visibility expressions parse and execute
* directional revset result assertions on an interior mutable stack: <code>A:: &amp; mutable()</code> = A/B/C/D, <code>::A &amp; mutable()</code> = A, with roots/heads assertions
* source-level audit rejects standalone <code>stack(@)</code>, the invalid <code>::X &amp; mutable()</code> spelling, and descendant-closure prose using the ancestor operator
* workspace add/list/root/rename/update-stale/forget behaviour, including external edits remaining unrecorded rather than stale metadata
* semantic graph, identity, bookmark, template, revset, sparse, and conflict assertions; revset validation distinguishes parse checks from exact result-set checks
* canonical jj 0.45.1 command-path coverage, including converge
* generated HTML exists and contains the Kindle Scribe print profile
* generated PDF contains page-number footers, individually listed Appendix A–K contents entries, and reader outline bookmarks
* PDF build timestamp matches research/build-timestamp.txt and is present in the printed cover and metadata
* generated PDF contains no source box-drawing glyphs or extracted missing-glyph substitutions; contents and outline are checked independently
* deterministic PDF rendering: the just pdf-repro recipe produced byte-identical repeated renders under the locked environment
* generated PDF isolates the printed contents from the preface and keeps representative major headings with following body material
* Part XII workspace headings precede the contiguous Part XIII configuration progression
* independent PDFium rendering of representative contents, chapter-start, graph, code, table, Git, and appendix pages; observations are recorded in research/print-acceptance.md

## Not validated locally

* Gerrit server/UI behaviour, reviewer/label/topic side effects, and authentication: no Gerrit server is available
* GitHub PR/UI behaviour and fork permissions: no GitHub account/server fixture is available
* GPG/SSH signing against a real key or hardware token
* External merge/diff tools and interactive TUIs in a non-interactive validator
* Every prose cookbook query against every possible DAG shape; representative fixture checks are supplied
* Full fixer, signing, and interactive-TUI laboratories remain to be run in the current non-interactive environment; conflict, sparse, and workspace lifecycle fixtures are run locally

## Known ambiguities and exclusions

* Current-main documentation can move ahead of the target release; local jj 0.45.1 help takes precedence.
* This edition intentionally targets jj 0.45.1 as its sole normative release, following the project owner's current requirement. Obsolete pre-0.45.1 records are not mixed into the release.
* Future-release features are not silently treated as jj 0.45.1 behaviour; rerun the inventory after upgrades.
* Third-party logos, screenshots, copied documentation passages, fonts, and JavaScript libraries are deliberately excluded. Licensing decisions are in research/licenses.md and research/book-license.md; Apache-2.0.txt is bundled for generated Jujutsu-derived help material.
* PDF generation is performed by the pinned xhtml2pdf/pypdf pipeline from src/book.html; the HTML has a 7.5 × 10 inch portrait @page profile matching Kindle Scribe's 3:4 display ratio. The just pdf recipe pins PYTHONHASHSEED=0 because xhtml2pdf uses salted hashes for in-memory image resource names; the just pdf-repro recipe checks complete byte identity across two renders. The PDF is text-checked and its page box/metadata are validated; independent PDFium samples are rendered by the visual recipe and inspected as recorded in research/print-acceptance.md.

## Depth status

* Inventory-complete: yes for the captured jj 0.45.1 command tree.
* Reference-complete: yes for the target-version reader-facing command paths and the documented revset/fileset/template/configuration surfaces; versioned raw help and schemas remain the exhaustive spelling/default evidence.
* Conceptually explained: expanded for graph, snapshots, rewrites, revsets, filesets, templates, conflicts, operations, and publication.
* Empirically validated: representative local Git, rewrite, revset, operation, and template examples; not every prose example.
* Workflow-demonstrated: expanded narratives are present; GitHub/Gerrit server/UI behaviour remains documented/server-dependent.
* Remaining work: optional technically justified additions, external/server-dependent acceptance where available, and rerun pagination after substantive source changes.
