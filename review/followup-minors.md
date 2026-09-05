# Follow-up minor findings

## FUP-m-001

ID: FUP-m-001  
Severity: MINOR  
Area: measurement reproducibility  
File: `research/depth-audit.md`, `research/completeness-report.md`

Section: substantive word-count measurement  
Claim or issue: The project reports three slightly different current word counts.  
Evidence: `94307`, `94402`, and an independent `94849` count under closely related exclusions.  
Why it matters: A single reproducible measure is needed to track the expansion target.  
Required fix: Define one counting method and use it consistently.  
Suggested validation: Regenerate both reports and compare the same script output.

The reported current word counts differ (`94307` versus `94402`), and an
independent non-`pre`/`script`/`style` count gives `94849`. The difference is
small compared with the unresolved scale blocker, but the project should use
one named counting method and report its exclusions consistently.

## FUP-m-002

ID: FUP-m-002  
Severity: MINOR  
Area: appendix presentation  
File: `src/book.html`

Section: Appendices H–K  
Claim or issue: Each has a short summary card followed by a longer fieldbook section.  
Evidence: Duplicate appendix headings occur at the initial appendix block and later fieldbook block.  
Why it matters: The first occurrence can look complete when it is only a pointer.  
Required fix: Consolidate or label the first occurrence as a contents card.  
Suggested validation: Open each appendix from the printed contents and confirm the complete material is reached.

Appendix H–K each have a very short summary card followed by a much longer
fieldbook section later in the PDF. The material is useful overall, but the
duplicate headings make the first occurrence look like the complete appendix.
Consolidate or explicitly label the first occurrence as a contents card.

## FUP-m-003

ID: FUP-m-003  
Severity: MINOR  
Area: environment documentation  
File: `README.md`, `research/version-matrix.md`

Section: pinned jj execution  
Claim or issue: The project relies on local `.toolchain` binaries rather than an unqualified `jj` on `PATH`.  
Evidence: The review environment has no ambient `jj`; recipes invoke `.toolchain/bin/jj`.  
Why it matters: Readers could accidentally validate against a different jj release.  
Required fix: State the pinned-binary behavior and PATH expectation explicitly.  
Suggested validation: Run setup from a clean environment and print the binary path and version.

The project uses local `.toolchain` binaries rather than an unqualified `jj`
on `PATH`. This is reproducible and not a defect, but the README should state
that the normal project interface invokes the pinned local binary and that
users should not infer the target from their ambient `PATH`.
