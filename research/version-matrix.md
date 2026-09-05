# Version matrix

Build date: 2026-09-06 (UTC)

## Targets

| Track | Version | Role | Evidence |
|---|---:|---|---|
| NixOS/user baseline | 0.44.0 | normative installed-release surface | `cargo install --locked jj-cli --version 0.44.0`; `jj version` after installation |
| newer stable | 0.45.1 | comparison track requested by user; released two days before this work | crates.io package metadata and separately installed CLI/help snapshot |
| official main/prerelease | current at research time | notes only; never normative | official docs/release pages, where identifiable |

The host did not initially have a `jj` executable on `PATH`. For reproducibility, the project installs 0.44.0 under `.toolchain/bin/jj`; this is the binary used for the primary inventories and fixtures. A 0.45.1 binary is kept separately under `.toolchain/jj-0.45/bin/jj`.

## Backend/tooling

* Git: `git version 2.53.0`.
* OS: Linux; shell: Bash.
* Book source/rendering: first-class semantic HTML with embedded CSS; PDF is rendered by xhtml2pdf 0.2.18 and normalised/checked by pypdf 6.1.3 under the locked uv project. Independent acceptance samples use pypdfium2 5.13.0.
* Current rendered artefact: `build/jj-book.pdf`, 510 pages, 540 × 720 pt; checksum is recorded in `build/jj-book.pdf.sha256`.

## Version discipline

0.44.0 is the default in examples unless a callout says otherwise. A feature is labelled `0.45.x` only after it is present in the separately captured 0.45.x help/source/docs. If official current documentation describes a feature absent in both targets, it is placed in a clearly marked forward-looking note or omitted.

## Detecting drift

Run:

```sh
jj version
jj help
just inventory
```

Then compare `research/command-inventory.md`, `research/command-inventory-0.45.md`, and `research/discrepancies.md`. The validation scripts intentionally fail closed when a required command or option disappears.
