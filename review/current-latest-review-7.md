# Review again: current author revision

## Baseline

Reviewed author revision:

```text
jj change/revision: unnpxtyrvvvwlsvrqkorolxlkuxlkppk
Git commit: 6aaec89d822bacb0f77052b93db7dc7fd7ab96ae
Description: Reflow evolog templates for print safety
```

The previous findings `EVO45-M-002` and `EVO45-M-003` are resolved. The latest source-level `evolog` corrections also address the affected part of `EVO45-M-004`: the reviewed multi-line template examples now use valid shell continuations and the jj 0.45.1 bare change-ID-offset syntax.

## Verdict

```text
REQUIRES MAJOR REVISION
```

| Severity | Count |
|---|---:|
| BLOCKER | 0 |
| MAJOR | 1 |
| MINOR | 0 |
| NIT | 0 |

## Finding

### EVO45-M-005

```text
ID: EVO45-M-005
Severity: MAJOR
Area: Kindle Scribe PDF layout, code readability, print acceptance evidence
File: src/book.html:3366-3369, 4423, 4440, 4442, 4444; research/print-acceptance.md:44-64
Section: Evolution-history divergence; template language/reference
Claim or issue: Long executable command lines remain visibly clipped in the current PDF. The latest reflow fixes the commands it touched, but the divergence diagnostic and template-reference examples still overflow the printable text measure.
Evidence:
```

* PDF page 183 clips the long `jj log ... -T ...` diagnostic in the divergence subsection. The line extends beyond the right printable boundary, so the template cannot be read or copied reliably.
* PDF page 241 clips the one-line JSON-output template command from `src/book.html:4423`.
* PDF page 242 clips all three long commands in the “Building a daily advanced log” subsection (`src/book.html:4440`, `4442`, and `4444`).
* PDF text extraction retains the source text, but rendered PDF inspection shows that the visible code is cut off at the right edge. Text extraction therefore does not establish print usability.
* `research/print-acceptance.md:44-45` lists only selected evolution-log pages and omits page 183 and the template-reference pages. Its assertions at lines 58-64 that long executable examples are fully visible and that there is no clipping are not supported by the current PDF.

Why it matters:

The PDF is a first-class Kindle Scribe publication target. A clipped command is not merely a cosmetic layout defect: it removes syntax from a technical reference and prevents the reader from safely transcribing or adapting the example. The affected material is in both the evolution-history teaching section and the template-language reference, so this is broader than an isolated page defect. The acceptance evidence is also incomplete and currently overstates the result.

Required fix:

* Reflow every affected command so the complete executable example is visible within the printable measure at normal Scribe reading scale.
* Use tested, valid shell continuations with correctly quoted multi-line jj templates, or replace the examples with template variables/aliases or shorter commands. Do not split a `-T` argument into separate shell commands or otherwise introduce invalid syntax merely to improve pagination.
* Review adjacent code-heavy pages for the same overflow class; do not limit the fix to the three named template-reference lines.
* Update `research/print-acceptance.md` to inspect and record the affected pages, and do not claim that clipping is absent until rendered pages have been visually checked.

Suggested validation:

```bash
just pdf
just pdf-check
just pdf-repro
bash scripts/validate-evolog.sh
```

Render and inspect PDF pages 183, 241, and 242 at normal reading scale, together with the other code-heavy pages. Verify that every command line and continuation is visible, that the examples remain valid when copied into a shell, and that the updated print-acceptance record names the inspected pages. Run the standalone `evolog` validator separately from the full validation recipe because both currently use the shared `build/validation` workspace.

## Checks performed

| Check | Result |
|---|---|
| Target jj | `jj version` reports jj 0.45.1; the reviewed source uses the 0.45.1 `evolog` and divergent-change syntax. |
| Evolog validator | Passes standalone: `evolog validation passed for jj 0.45.1`. |
| Invalid split `-T` scan | No remaining source matches for the reviewed split-template pattern. |
| Invalid `change_id(...)/N` scan | No remaining source matches. |
| HTML check | `just html-check` passes. |
| CLI check | `just cli-check` passes. |
| PDF check | `just pdf-check` passes. |
| PDF reproducibility | `just pdf-repro` passes with byte-identical repeated renders. |
| Current PDF | 526 pages, 540 x 720 pt; rendered-page inspection found the clipping described above. |
| Root artefact | `jj-book.pdf` remains a symlink to `build/jj-book.pdf`; the HTML convenience path remains a symlink to `src/book.html`. |
| Black-block glyph check | No new black-block glyph issue was observed in the inspected pages. |
| Full validation | The full `just validate` run remains unable to complete at the repository's native Git fixture because this review environment disables native Git operations. This is recorded as an environmental limitation, not as evidence that the latest `evolog` validator fails. |

The review is not a PASS while `EVO45-M-005` remains unresolved.
