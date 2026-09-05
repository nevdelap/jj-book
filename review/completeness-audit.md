# Completeness audit

## Independent baseline

| Metric | Independent result |
|---|---:|
| jj 0.44.0 top-level commands | 46 |
| jj 0.44.0 canonical command paths | 120 |
| HTML command articles | 121 |
| substantive HTML words | about 49,954 |
| PDF artefacts | 0 |
| internal fragment targets missing | 0 |

## Coverage interpretation

- Inventory completeness is close but canonical `operation` paths are represented as `op` aliases, and the 0.45-only `converge` article must remain explicitly comparison-only.
- Reference completeness is not demonstrated: grouped appendices and delegation to raw help/schema remain.
- Conceptual explanation is present for many subjects but is uneven and frequently below the `explored` depth required by the brief.
- Empirical validation is representative, not semantic or exhaustive; the report itself lists major unvalidated laboratories.
- Workflow demonstration is strongest for the local Git fixture and weakest for GitHub/Gerrit, conflicts, recovery, and multi-machine scenarios.

## Part-level word counts excluding `pre`, `script`, and `style`

| Part | Approx. words |
|---|---:|
| I | 1,628 |
| II | 3,854 |
| III | 4,359 |
| IV | 2,020 |
| V | 1,609 |
| VI | 1,311 |
| VII | 810 |
| VIII | 1,672 |
| IX | 838 |
| X | 1,869 |
| XI | 171 |
| XII | 3,093 |
| XIII | 3,763 |
| XIV | 13,486 |
| XV | 2,959 |
| XVI | 1,689 |
| Appendices/reference material | about 4,138 |

These counts demonstrate that the current manuscript remains a compact guide plus a dense command section, not a 450–600-page technical book.

## Required outcome

Update the completeness report only after independently reconciling canonical paths, reader-facing reference entries, depth labels, semantic fixture results, workflow state transitions, actual PDF pagination, and provenance records. Do not treat inventory completeness as explanatory or workflow completeness.

