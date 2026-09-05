# Appendix value audit

Review date: 2026-09-06  
Source: `src/book.html`; PDF: `build/jj-book.pdf`

## Method

I measured authored appendix material, not the raw research inventories. The
counts are approximate because tables, commands, and headings carry more value
than their word count alone. I also inspected the generated PDF outline. The
PDF outline generator currently includes only `h2` and `h3` headings.

## Appendix-by-appendix assessment

| Appendix | What is present | Value verdict | Required treatment |
|---|---|---|---|
| A — Complete command tree | A compact 0.44 command/subcommand tree and one provenance sentence. | **Useful as a quick lookup**, not as command documentation. | Keep compact, but add stable links/anchors to every command entry and a clearly marked 0.45 delta. |
| B — Option index | 11 common/global option rows and a pointer to raw help. | **Insufficient / major**. It is a selected flag card, not an option index. | Index important global and command-specific options with ownership, argument type, defaults, interactions, and command links. |
| C — Revset reference | Quick card plus continuation/function tables; roughly 85 rows and 1.6k words of associated material. | **Potentially useful**, but split and not as easy to navigate as a language reference should be. | Consolidate; include signatures, cardinality, patterns, version notes, and examples for the important surface. |
| D — Fileset reference | A 45-word opening paragraph, a later 13-row continuation, and richer grammar/consumer material under `Standalone reference cards`. | **Insufficient as presented / major**. The useful material is structurally detached from Appendix D. | Make the grammar, scope prefixes, operators, quoting, aliases, and consumer matrix one navigable Appendix D. |
| E — Template reference | Quick card plus type/method and operator/formatting tables; roughly 1.6k words and 84 rows of associated material. | **Useful after navigation repair**. | Consolidate the reference and expose all important cards in the PDF outline. |
| F — Configuration reference | A 44-word opening paragraph, a task-oriented table under a later card section, and a 17-row family table. | **Insufficient as presented / major**. It still directs readers to schema/inventory for the full surface. | Provide a human reference for significant keys: type, scope, default/absence, interactions, security/performance, and version notes. |
| G — Git-to-jj lookup | 13-row intention/non-equivalence table. | **Useful compact lookup**. | Keep; add links to the detailed conceptual and workflow sections. |
| H — GitHub recipes | A 30-word quick recipe plus a roughly 1.1k-word fieldbook with nine code blocks and lifecycle subsections. | **Useful overall**, but the two fragments should be presented as one appendix. | Consolidate summary and fieldbook; retain local/server boundary and failure branches. |
| I — Gerrit recipes | A 29-word quick recipe plus roughly 780 words and five code blocks of lifecycle material. | **Useful overall**, provided server-dependent behaviour stays labelled. | Consolidate and add direct links to the identity and patch-set explanations. |
| J — Recovery recipes | A 33-word card plus roughly 590 words, four code blocks, and a recovery table. | **Useful starting fieldbook**, but still benefits from an incident decision tree. | Add “symptom → inspect → choose recovery” flow and explicit limitations of local recovery versus server state. |
| K — Linux shell integration | A 63-word card plus roughly 670 words of fieldbook material, code, table, and list. | **Useful overall**, not merely a short appendix. | Consolidate; ensure completion, pager/editor, quoting, prompt, scripting, `uv`, and `just` procedures are easy to find. |

## Structural problem

The richer D/E/F cards are authored as `h4` headings beneath the generic
`Standalone reference cards` section. `scripts/render-pdf.py` only collects
`h2` and `h3`, so the generated outline exposes the generic section but not the
actual D/E/F card headings. H–K have the same summary/fieldbook duplication in
a later `Appendices H–K` section.

This is not merely cosmetic. A reader opening Appendix D or F from the printed
contents lands on a short paragraph and has no direct PDF-outline destination
to the material that makes the reference useful.

## Overall appendix verdict

The appendices are not uniformly useless: A, C, E, G, and the H–K fieldbook
material have real value. However, B, D, and F do not yet satisfy their
promised standalone-reference roles, and the split hierarchy makes the useful
material harder to discover. The appendices should be consolidated before a
release verdict can move beyond BLOCKED/MAJOR revision.

