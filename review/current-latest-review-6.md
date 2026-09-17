# Latest independent review

Reviewed author revision:

```text
jj change/revision: nxsuwsqlrqmzntnwrpotrzsnxsrvpqwl
Git commit:         d9cf215502e9a753b96233e8eb0af97bdf010085
Description:        Fix executable template and divergent selectors
```

The two previous findings are resolved:

* the multi-line `-T` examples were made executable as shell commands;
* the divergent selectors now use the valid bare change-ID offset form;
* the new validator checks both regressions;
* the standalone jj 0.45.1 `evolog` fixture passes.

The source-level corrections introduced a Kindle-Scribe PDF layout defect,
however. Long one-line commands now extend beyond the printable code-block
width and are visibly clipped in the rendered PDF.

## Verdict

**REQUIRES MAJOR REVISION**

```text
BLOCKER: 0
MAJOR:   1
MINOR:   0
NIT:     0
```

## EVO45-M-004 — Long executable commands are clipped in the PDF

ID: EVO45-M-004  
Severity: MAJOR  
Area: Kindle Scribe PDF layout, code readability, publication correctness  
File: `src/book.html:3294`, `3313`, `3325`, `3356`, `3402` and corresponding generated PDF pages 178, 180–182, and 185  
Section: Evolution-history laboratory and related divergence/publication examples

Claim or issue: The latest source revision correctly makes the template commands
single-line shell commands, but several of those lines are too long for the
print code-block width. The PDF does not wrap them safely; the right-hand ends
run outside the printable area and are visibly cut off.

Evidence:

```text
src/book.html:3294
jj evolog -r "$change" -G -T 'commit.commit_id() ++ ... ++ commit.description().first_line() ++ "\\n"'

src/book.html:3313
jj evolog -G -r "$change" -T 'commit.commit_id().short(12) ++ ...'

src/book.html:3325
jj evolog -G -r "$change" -T 'commit.commit_id() ++ ...'

src/book.html:3356
jj log -r 'change_id("PREFIX")' --no-graph -T 'commit_id ++ ...'

src/book.html:3402
jj evolog -G -r "$change" -T 'commit.commit_id() ++ ...'
```

Rendered inspection of the current `build/jj-book.pdf` shows the first long
command cut off at the right edge on page 178. The long template commands on
pages 180, 181, 182, and 185 show the same failure. Text extraction retains
the source line, so the ordinary PDF validator passes; the rendered page is
nevertheless not usable as a visual code reference and a reader cannot safely
recover the missing command text from the PDF.

The current PDF otherwise reports 526 pages at 540 × 720 points, and the new
evolution section is present in the contents and outline. This is therefore a
publication-layout defect, not a missing-build-artifact problem.

Why it matters: The Kindle Scribe acceptance criteria explicitly require code
to be practically usable at normal reading scale and prohibit clipped content.
These are the central machine-readable `evolog`, divergence, and publication
commands in the newly added section. A technically correct source command is
not sufficient if the distributed PDF cuts off the command users need to copy.

Required fix: Reformat the long examples so that they remain both executable
and fully visible. Suitable approaches include:

* a valid shell continuation followed by a multi-line quoted template, after
  testing that the resulting template string is accepted by jj;
* assigning the template to a shell variable or a checked-in template alias,
  then passing the shorter variable/alias to `-T`;
* splitting the workflow into shorter, individually executable commands;
* adding safe code wrapping only if the rendered result preserves every token
  and remains legible.

Do not restore the previous invalid form in which `-T` is left without an
argument on its shell line. Do not rely on source text extraction as evidence
that a visually clipped PDF is acceptable.

Suggested validation: Rebuild with `just pdf`, render all pages containing the
expanded evolution section independently with PDFium, and inspect the right
edge of every code block at normal Scribe scale. Add a print-layout check for
horizontal code overflow or maintain a reviewer-rendered sample set covering
pages 178, 180–182, and 185. Then run `just pdf-check`, `just pdf-repro`, and
the standalone `bash scripts/validate-evolog.sh`.

## Checks performed

| Area | Result |
|---|---|
| Target jj version | jj 0.45.1 installed and used |
| Previous executable-template finding | Resolved; no split `-T` examples found by the source scan |
| Previous divergent-offset finding | Resolved; no `change_id(...)/N` forms remain |
| Dedicated evolog fixture | Passes standalone, including `/0` and `/1` selectors |
| HTML validation | Passes: 970 IDs, 212 internal links |
| CLI reference validation | Passes: 121 canonical command paths |
| PDF validation | Passes: 526 pages, 540 × 720 pt |
| PDF reproducibility | Passes: byte-identical repeated renders |
| Root artefact | `jj-book.pdf` is a symlink to `build/jj-book.pdf` |
| PDF glyph/layout spot check | No black-block glyph defect; long code lines are visibly clipped |
| Full `just validate` | Could not complete because this review environment disables native Git; it stops in the pre-existing Git fixture at `git init`, not in the evolog validator |

