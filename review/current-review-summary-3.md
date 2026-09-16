# Superseded historical review summary

> The current authoritative summary is [`current-review-summary-4.md`](current-review-summary-4.md).

# Independent release review summary

## Verdict

**REQUIRES MAJOR REVISION**

The current 0.45.1 manuscript has one release-significant technical finding:
the reader-facing revset atlas and several workflow examples name nonexistent
functions (`bookmark()`, `tag()`, `conflicted()`, `evolution()`,
`workspaces()`, and `file()`) and describe `at_operation()` with an incomplete
signature. It also presents deprecated `diff_contains()` without warning.

## Baseline

- Reviewed author revision: `vpqzlkrsqtsxyrozxrmnpssuyotwntxk`.
- Reviewed author commit: `76a0e2415f70d1f45b760befd951b5f39b9bc01d`.
- Normative target: jj 0.45.1; 0.44.0 is obsolete.
- Environment: Linux; jj 0.45.1; Git 2.53.0; uv 0.12.10; just 1.45.0.
- PDF: 496 pages, 540 x 720 pt; SHA-256
  `55adcfc399a0675d203b5dc305c5df1de59e24c5ea097dabd087bde1f131be29`.
- Root PDF: `jj-book.pdf` is a relative symlink to `build/jj-book.pdf`.

## Status

| Area | Status |
|---|---|
| Revset correctness/reference | MAJOR — invalid names and signature in current book |
| HTML/PDF architecture | PASS |
| Kindle Scribe layout/glyphs | PASS for inspected artefact |
| `uv`/`just` tooling | PASS |
| Licensing/provenance | PASS for reviewed records |
| Structure/content/depth/breadth | No new issue in this delta |
| Reproducible PDF build | PASS |

```text
BLOCKER: 0
MAJOR:   1
MINOR:   1
NIT:     0
```

See [`current-latest-review-3.md`](current-latest-review-3.md) and
[`current-revset-audit-3.md`](current-revset-audit-3.md) for the full evidence
and required validation.
