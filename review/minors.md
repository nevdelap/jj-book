# Historical first-review MINOR findings

> These findings describe the pre-expansion baseline. The current follow-up
> findings supersede their status and are in `followup-minors.md`.

## m-001

ID: m-001  
Severity: MINOR  
Area: HTML navigation  
File: `src/book.html`  
Section: Headings/anchors  
Claim or issue: The source has 464 headings but only 192 IDs and a compact 25-link TOC.  
Evidence: Independent HTML parsing found no broken internal links or duplicate IDs, but most `h3`/`h4` reference sections have no anchor ID.  
Why it matters: The HTML is structurally valid, but deep Kindle/PDF navigation and cross-reference usability are weaker than the long reference book requires.  
Required fix: Add stable IDs to all reader-facing chapter/reference headings and link important cross-references from the TOC and indexes.  
Suggested validation: Run an anchor checker and verify PDF bookmarks/outlines once a renderer exists.

## m-002

ID: m-002  
Severity: MINOR  
Area: Environment robustness  
File: `justfile:1`, environment interaction  
Section: Just shell setup  
Claim or issue: In this environment, invoking the normal `just` recipe with inherited `BASH_ENV=/home/agentbox/.bashrc` initially failed with `color_prompt: unbound variable` because the recipe uses `bash -euc`.  
Evidence: Plain `just setup` failed before cargo execution; `BASH_ENV=/dev/null just setup` succeeded.  
Why it matters: The recipe is sensitive to caller shell initialization and can fail for reasons unrelated to the project.  
Required fix: Make recipes independent of caller `BASH_ENV`/interactive shell state, or document and enforce the supported invocation environment.  
Suggested validation: Run all recipes from a clean non-interactive shell with common `BASH_ENV`, `SHELLOPTS`, and PATH variations.

## m-003

ID: m-003  
Severity: MINOR  
Area: Repository metadata  
File: root Git index  
Section: Symlink verification  
Claim or issue: The working-tree HTML symlink is correct, but this checkout has no commits and `git ls-files --stage jj-book.html` reports an intent-to-add 100644 placeholder, so committed symlink mode cannot be verified from repository metadata.  
Evidence: `ls -l` and `stat` show `jj-book.html` is a symbolic link to `src/book.html`; `git status` reports an uncommitted tree with no commits and the index entry is not a committed 120000 symlink.  
Why it matters: The requirement explicitly asks that Git record the symlink correctly.  
Required fix: Verify in the project’s real committed tree that the link has mode 120000 and that clean/rebuild does not replace it with a regular file.  
Suggested validation: Inspect `git ls-tree HEAD jj-book.html`, `git cat-file -p`, `readlink`, and the post-clean/post-build filesystem type.
