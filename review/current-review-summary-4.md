# Independent release review summary

## Verdict

**REQUIRES MAJOR REVISION**

The author’s new conflict-marker section is technically accurate and renders
well, but the prior MAJOR revset-reference finding remains unresolved. Three
MINOR findings concern deprecated `diff_contains()`, the omitted experimental
conflict-marker value, and incomplete provenance classification for adapted
official conflict examples.

## Baseline

- Reviewed author revision: `mtrtwszoxuyuprzowvwplqzulvwykmpo`.
- Reviewed author commit: `f8392075f663551a90e2bdc2c09a47067cd0a44d`.
- Normative target: jj 0.45.1; 0.44.0 is obsolete.
- Environment: Linux; jj 0.45.1; Git 2.53.0; uv 0.12.10; just 1.45.0.
- PDF: 513 pages, 540 x 720 pt; SHA-256
  `6b336cdce8c7e345e4d0f2bd09dbf7c0c08415f4f6a32715ae7b6544c9525e09`.
- Root PDF: `jj-book.pdf` remains a relative symlink to `build/jj-book.pdf`.

## Status

| Area | Status |
|---|---|
| Revset correctness/reference | MAJOR — invalid names/signature remain |
| New conflict-marker material | PASS technically; provenance/config notes required |
| HTML/PDF architecture | PASS |
| Kindle Scribe layout/glyphs | PASS for inspected artefact |
| `uv`/`just` tooling | PASS |
| Licensing/provenance | MINOR finding for adapted example register |
| Structure/content/depth/breadth | No new structural issue in this delta |
| Reproducible PDF build | PASS |

```text
BLOCKER: 0
MAJOR:   1
MINOR:   3
NIT:     0
```

See [`current-latest-review-4.md`](current-latest-review-4.md) and
[`current-revset-audit-4.md`](current-revset-audit-4.md) for evidence and
required validation.
