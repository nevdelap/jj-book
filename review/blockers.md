# Historical first-review BLOCKER findings

> These findings describe the pre-expansion baseline. The current follow-up
> findings supersede their status and are in `followup-blockers.md`.

## B-001

ID: B-001  
Severity: BLOCKER  
Area: PDF build and publication  
File: `README.md:11-22`, `justfile:7-30`, `research/completeness-report.md:46-60`, `build/`  
Section: Build / Kindle Scribe target  
Claim or issue: The project does not provide the required reproducible pipeline from canonical HTML to PDF.  
Evidence: `find build -type f -name '*.pdf'` found no PDF. `just --list` exposes only `all`, `compare-045`, `default`, `html`, `inventory`, `report`, `setup`, and `validate`; `just pdf` and `just build` fail with “Justfile does not contain recipe”. The README says PDF generation is delegated to the reader’s print dialog.  
Why it matters: The PDF is a first-class deliverable and must be generated from canonical HTML, deliberately optimised for Kindle Scribe, and reproducibly inspected. A browser print instruction is not a project build pipeline and cannot establish stable page count, metadata, links, fonts, or layout.  
Required fix: Add a documented, deterministic HTML-to-PDF renderer and `just build`/`just pdf` recipes. Generate the PDF from `src/book.html`, place the canonical generated output under `build/`, expose any root convenience PDF as a relative symlink, and document renderer/version/font prerequisites.  
Suggested validation: From a clean checkout run `uv sync` if Python tooling is used, then `just build`, `just pdf`, and `just validate`; verify the PDF’s page count, metadata, links, fonts, dimensions, and checksums, and repeat after relocation to another checkout path.

## B-002

ID: B-002  
Severity: BLOCKER  
Area: Manuscript scope and depth  
File: `src/book.html`, `research/completeness-report.md:17-18`, `research/depth-audit.md:9-18`  
Section: Whole book  
Claim or issue: The corrective expansion has not produced the requested substantial technical book.  
Evidence: Independent HTML measurement is approximately 49,954 substantive words, while the project’s own target is 210,000–230,000 words / approximately 450–600 Kindle-Scribe pages. Section measurements are highly uneven: GitHub about 810 words, conflicts about 838, workspaces about 171, Git backend about 1,311, and appendices about 4,138 combined. The depth audit itself records that the target remains unfinished.  
Why it matters: The stated scope requires explored concepts, graph laboratories, lifecycle workflows, and usable reference chapters. The current manuscript still delegates key detail to raw help/research and cannot serve the reader as a deep learning/reference book.  
Required fix: Continue the author’s expansion plan until major subjects reach the documented depth goals; include substantive graph/state reasoning, failure/recovery, workflows, and reader-facing reference material. Report actual substantive word count and actual PDF pages after the PDF build exists.  
Suggested validation: Re-run an independent word-count script excluding research ledgers/raw help, build the PDF, inspect pagination, and compare every Part against `research/depth-audit.md` using the labels mentioned/introduced/explained/demonstrated/explored/reference-complete.

## B-003

ID: B-003  
Severity: BLOCKER  
Area: Revsets  
File: `src/book.html:845-866`  
Section: Revset workbook  
Claim or issue: The worked result `heads(B::G) = {F,G}` is false for the graph drawn immediately above it.  
Evidence: The diagram has `F` as an ancestor/parent-side predecessor of merge `G`; `B::G` includes B, C, D, E, F, and G. jj 0.44 help defines `heads(x)` as commits in x that are not ancestors of other commits in x (`research/help-revsets-0.44.0.md:333-336`). Therefore G is the only head; F is an ancestor of G.  
Why it matters: This is a textbook-level algebra error in the central graph-first teaching instrument. A reader applying the stated rule to a non-linear graph will derive and automate the wrong publication/query set.  
Required fix: Correct the graph/result pair and audit every worked revset set calculation, especially merge, range, roots/heads, reachability, and fork examples. State the exact parent edges and show the evaluated command output.  
Suggested validation: Create the exact graph in a disposable jj 0.44.0 repository, run `jj log -r 'B::G'`, `jj log -r 'heads(B::G)'`, and assert that only G is returned by the latter.

## B-004

ID: B-004  
Severity: BLOCKER  
Area: Required developer interface  
File: `justfile`, `README.md:11-22`  
Section: Tooling/build architecture  
Claim or issue: `just` is present but is not the primary interface for the required normal operations and cannot build the claimed publication.  
Evidence: `just --list` has no `build`, `pdf`, `test`, `clean`, or `review` recipe. Each of `just build`, `just pdf`, `just test`, `just clean`, and `just review` fails with “Justfile does not contain recipe”. `just all` only runs setup, inventories, validation, symlink creation, and the completeness report; it never produces a PDF.  
Why it matters: The non-negotiable requirement is a coherent `just` interface, not merely a task runner containing a few research scripts. Without it, a clean documented release build is impossible and users must remember implementation-specific commands or an external print dialog.  
Required fix: Make the justfile the primary interface for setup/sync, HTML validation, technical tests, book build, PDF build, full validation, clean, completeness audit, and review. Recipes must fail closed and use repository-relative paths.  
Suggested validation: Run `just --list`, then from a clean checkout run the documented setup/build/validate/review sequence; verify each recipe’s exit status and outputs, including clean/rebuild symlink preservation.
