# Licence and provenance audit

## Evidence reviewed

- `research/licenses.md`
- `research/book-license.md`
- `research/sources.md`
- `LICENSES/Apache-2.0.txt`
- all external URLs in `src/book.html` and `research/`
- raw jj help snapshots and generated inventories

Authoritative sources consulted for the audit include the [Jujutsu Apache License](https://github.com/jj-vcs/jj/blob/main/LICENSE), the [Jujutsu image licence](https://github.com/jj-vcs/jj/blob/main/docs/images/LICENSE), the [Gerrit licence page](https://gerrit-review.googlesource.com/Documentation/licenses.html), [Git’s licensing overview](https://git-scm.com/about.html), and the [CC BY 4.0 legal code](https://creativecommons.org/licenses/by/4.0/legalcode).

## Status by material class

| Material | Evidence/use | Status |
|---|---|---|
| jj behavior/docs | Paraphrase and short command examples in HTML; exact release help snapshots in `research/` | Generally conservative; raw generated help needs explicit row-level provenance and notice mapping. |
| jj source/help output | Raw 0.44/0.45 captures and inventories are shipped | Apache text is bundled, but the ledger does not separately record exact generated material, source version, and redistribution notice placement. |
| jj images/logo | Ledger says not included; search found no image/font asset | No embedded asset found. |
| Git docs | Ledger says no copied text/images; book presents original explanations/links | No copied material found in this pass; exact source pages should still be recorded for substantive factual derivations. |
| GitHub/Gerrit docs | Paraphrased protocol/service behavior; no screenshots/logos found | High-level record only; exact page/version and terms/licence source are missing. |
| CSS/HTML/scripts | Claimed original and CC BY 4.0 in `research/book-license.md` | No root `LICENSE` or `THIRD_PARTY_NOTICES`; author/attribution identity and final PDF notice treatment are not explicit. |
| fonts | No bundled fonts; CSS uses system fonts | PDF embedding cannot be checked because no PDF exists. Record renderer/font behavior before release. |

## Finding

**M-008 — provenance ledger incomplete.** The project’s table is not the required source/provenance inventory. It lacks per-source author/owner, exact material, use type, licence source, attribution/modification obligations, redistribution conditions, included-in-final status, and compliance status. “Consult current documentation” is not sufficient for Gerrit or other substantial sources. This is MAJOR due unresolved provenance, not a claim that an infringement was proven.

## Required outcome

Create a row per substantive external source and per copied/generated asset or help snapshot. For each row record the exact fields in the brief and retain evidence URLs/version/date. Add a standard root `LICENSE` and/or `THIRD_PARTY_NOTICES` arrangement if the distribution consists of CC BY book material plus Apache-derived snapshots. Ensure the final HTML/PDF distribution carries the attribution needed for the declared CC BY material and any Apache-derived material.

