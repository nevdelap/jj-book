# Version matrix

Build date: 2026-09-10 (UTC)

## Targets

| Track | Version | Role | Evidence |
|---|---:|---|---|
| installed/book target | 0.45.1 | sole normative release surface | `jj version`, recursive local help, fixture validation |
| official main/prerelease | current at research time | notes only; never normative | official docs/release pages, where identifiable |

The project provisions jj 0.45.1 under `.toolchain/bin/jj`. Historical captures from earlier review rounds may remain in the research directory as provenance, but they are not an active compatibility track.

## Backend/tooling

* Git: `git version 2.53.0`.
* OS: Linux; shell: Bash.
* Book source/rendering: first-class semantic HTML with embedded CSS; PDF is rendered by xhtml2pdf 0.2.18 and normalised/checked by pypdf 6.1.3 under the locked uv project. Independent acceptance samples use pypdfium2 5.13.0.
* Current rendered artefact: `build/jj-book.pdf`, 510 pages, 540 × 720 pt; checksum is recorded in `build/jj-book.pdf.sha256`.

## Version discipline

The prose and examples describe jj 0.45.1. Current-main documentation can move ahead of the target release; it is useful for finding future direction, but it is not evidence that a 0.45.1 command accepts a newer option. Future features are mentioned only when clearly marked as forward-looking notes.

## Detecting drift

Run:

```sh
jj version
jj help
just setup
just inventory
```

Then review the regenerated `research/command-inventory.md`, versioned help captures, schema, and `research/completeness-report.md`. The validation scripts intentionally fail closed when a required target command or option disappears.
