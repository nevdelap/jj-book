# Latest independent review

Reviewed author revision:

```text
jj change/revision: qpmvowntmvkrotnqzmlpywyklzsqwllo
Git commit:         005f255c5652c2b1d22a0cc285bac198c932ac10
Description:        Document evolog investigation and validation
```

The author has added a substantial, appropriately placed evolution-history
section, a dedicated contents entry, a 0.45.1 validation fixture, and the
requested Git/Gerrit/reflog crosswalk. The new section renders well in the PDF
and the standalone `evolog` fixture passes. Two release-blocking technical
issues remain in reader-facing command examples.

## Verdict

**REQUIRES MAJOR REVISION**

```text
BLOCKER: 0
MAJOR:   2
MINOR:   0
NIT:     0
```

## EVO45-M-002 — Multi-line template commands are not executable shell

ID: EVO45-M-002  
Severity: MAJOR  
Area: Command examples, templates, copy/paste correctness  
File: `src/book.html`  
Section: Evolution-history laboratory; divergence examples; template chapter

Claim or issue: Several shell examples put the template argument on a new line
after `-T` without a shell continuation character. In a shell, the first line
therefore invokes jj with a missing template value, and the second line is then
attempted as a separate command. This is not merely typographic wrapping: the
source newline is preserved in the `<pre>` block and the displayed example is
not runnable as shown.

Evidence:

```text
src/book.html:3295-3297
jj evolog -r "$change" -G -T
  'commit.commit_id() ++ ...'

src/book.html:3316-3320
jj evolog -G -r "$change" -T
  'commit.commit_id().short(12) ++ ...'

src/book.html:3332-3334
jj evolog -G -r "$change" -T
  'commit.commit_id() ++ ...'
```

The same pattern remains elsewhere in the book, including the earlier
divergence example at `src/book.html:573-574` and template examples around
`src/book.html:4402`, `4418`, `4441`, `4446`, and `4453`.

Against jj 0.45.1, executing the first form as displayed produces:

```text
error: a value is required for '--template <TEMPLATE>' but none was supplied
...: command not found
```

Why it matters: These are presented as advanced, machine-readable inspection
commands. A reader copying them during review or incident analysis gets an
immediate command failure, and the book's new `evolog` workflow cannot be
followed exactly as printed.

Required fix: Make every multi-line shell command valid as displayed. Either
keep the complete command on one line, add a shell continuation (`\\`) at each
continued line, or use a clearly documented shell/heredoc form. Apply the fix
to all reader-facing `<pre>` examples, not only the new `evolog` section.

Suggested validation: Extract or manually execute every multi-line command
against jj 0.45.1 with `bash -euo pipefail`; add a validation check that flags
command lines ending in `-T`, `-r`, `--from`, or `--to` when the next line is an
argument and no continuation is present. Run `just html-check`, `just validate`,
and inspect the rendered code blocks after the correction.

## EVO45-M-003 — Divergent-change offset examples use invalid revset syntax

ID: EVO45-M-003  
Severity: MAJOR  
Area: Revsets, divergent changes, evolution-history recovery  
File: `src/book.html:3369-3371`, `src/book.html:3503-3504`  
Section: Evolution-history divergence; recovery laboratory exercise 5

Claim or issue: The book presents expressions such as:

```text
jj show -r 'change_id("PREFIX")/0'
jj show -r 'change_id("PREFIX")/1'
```

Those expressions do not parse in jj 0.45.1. A change offset is appended to a
change-ID symbol or prefix, not to the result of the `change_id(...)` revset
function.

Evidence: The target help states that a change offset uses `<change ID>/<offset>`
syntax. In a disposable jj 0.45.1 divergent-change fixture:

```text
jj log -r 'change_id("FULL_CHANGE_ID")/0'
Error: Failed to parse revset: ... expected <EOI>, `-`, `+`, `::`, `..`, `|`, `&`, or `~`

jj log -r 'FULL_CHANGE_ID/0'
<selects one divergent revision>
```

The same invalid form is also present in the recovery exercise. The book's
other prose correctly shows the bare-symbol form `xyz/0`, which makes the
contradiction especially likely to confuse readers.

Why it matters: This is the prescribed way to select one side of a divergent
change before comparing, converging, abandoning, or recovering it. The printed
commands fail at precisely the point where a user needs an unambiguous single
revision. It also undermines the new `evolog` chapter's explanation of change
offsets and cardinality.

Required fix: Replace the invalid forms with target-version syntax, for example
`'FULL_CHANGE_ID/0'` and `'FULL_CHANGE_ID/1'` (or a clearly marked unique bare
prefix), and explain that `change_id("PREFIX")` selects the divergent set but
cannot be followed by `/N`. Recheck every offset example in the book and
appendices.

Suggested validation: In a disposable jj 0.45.1 repository, create two visible
successors of one change, assert that the bare-symbol `/0` and `/1` forms each
select one commit, assert that `change_id("PREFIX")` selects the set, and assert
that the old function-plus-offset forms are rejected. Run the revset surface
validator and `just html-check` after updating the examples.

## Checks performed

| Area | Result |
|---|---|
| Target jj version | jj 0.45.1 installed and used |
| Dedicated evolog fixture | Passes standalone: successive versions, descendant rewrite, ordering, limit, patch, templates, divergence |
| HTML validation | Passes: 970 IDs, 212 internal links |
| CLI reference validation | Passes: 121 canonical command paths |
| PDF build | Passes: 526 pages, 540 × 720 pt |
| PDF contents/outline | Evolution section appears in printed contents and starts on PDF page 177; 193 outline entries |
| PDF reproducibility | Passes: repeated renders byte-identical |
| Root artefact | `jj-book.pdf` is a symlink to `build/jj-book.pdf` |
| New-section visual inspection | No clipping or black-block glyph defect observed on representative pages 177, 178, and 186 |
| Full `just validate` | Could not complete because this review environment disables native Git; it stopped in the pre-existing Git fixture at `git init`, not in the new evolog validator |

