# Jujutsu for Git Experts: Graph-First Version Control

This repository contains the source and rendered HTML for the book **Jujutsu for Git Experts: Graph-First Version Control**.

## Version policy

The primary validation target is **jj 0.44.0**, matching the NixOS package available to the author. The book also has a separately marked **jj 0.45.x** track. Examples and reference tables never silently combine those surfaces; each version-sensitive statement is labelled `0.44 baseline`, `0.45.x`, or `both`.

The local validation binary is installed at `.toolchain/bin/jj` by the `justfile`. The build date and Git version are recorded in `research/version-matrix.md`.

## Build and rendered output

The deliverable is `jj-book.html` at the project root, symlinked to the first-class authored HTML source `src/book.html`. It is not Markdown converted to HTML. The PDF is rendered directly from that HTML by pinned `xhtml2pdf` and normalised with pinned `pypdf`; no browser or Markdown conversion step is involved. The current output is a 7.5 × 10 inch portrait PDF, 510 pages at the current manuscript size, suitable for Kindle Scribe import and printing. It includes a generated printed contents section, page-number footer, and PDF-reader outline. `build/jj-book.pdf.sha256` records the generated checksum.

```sh
uv sync --locked     # install the pinned Python renderer/validator
just build           # provision both jj tracks, inventory, validate, render PDF
just pdf             # render src/book.html and create jj-book.pdf symlink
just visual          # render independent PDFium samples for visual acceptance
just test            # run fixture, HTML, and PDF semantic checks
just review          # full test/report pass and symlink checks
just clean           # remove generated PDFs, validation repos, and symlinks
```

The commands assume Linux, Bash, Git, Rust/Cargo, `just`, and `uv`. Network access is needed only for the initial pinned jj installations and dependency resolution. The renderer environment is declared by `pyproject.toml` and locked by `uv.lock` (Python ≥3.12, `xhtml2pdf==0.2.18`, `pypdf==6.1.3`, `pypdfium2==5.13.0`, and `tzdata==2026.3`). The primary and comparison binaries are provisioned by `just setup` and `just setup-045`, then kept at `.toolchain/bin/jj` and `.toolchain/jj-0.45/bin/jj`; both recipes assert the expected version, so the normal interface does not use an ambient `jj` from `PATH`. Their versions and SHA-256 values are recorded by `just report` in `research/toolchain-checksums.md`. `JJ_BIN=/path/to/jj just validate` can be used for a separately installed primary binary.

## Layout

* `src/book.html` — single maintained manuscript source, authored as semantic HTML; `jj-book.html` is its symlink.
* `jj-book.html` — convenience symlink to the authored HTML.
* `build/jj-book.pdf` — canonical PDF generated from `src/book.html`; `jj-book.pdf` is its relative symlink.
* `research/` — version matrix, inventories, source trail, discrepancies, and completeness report.
* `scripts/` — inventory, fixture validation, and rendering tools.
* `fixtures/` — fixture documentation and names for disposable repositories created by validation scripts (ignored outputs are kept under `build/`).

The PDF renderer intentionally uses a pure-Python path so the build is usable on a minimal Linux/NixOS installation. It embeds selectable text and preserves the authored page geometry. The print stylesheet uses only controls verified against pinned xhtml2pdf 0.2.18: the renderer-specific `<pdf:nextpage />` tag separates contents from the body and `-pdf-keep-with-next` protects heading transitions; modern browser-only `break-*` properties are not relied upon. Renderer limitations are documented by validation output rather than hidden behind a browser-specific print dialog.

The research notes are part of the book's source trail. Official documentation is cited in the manuscript and linked from `research/sources.md`; licensing and attribution decisions are in `research/licenses.md`; locally observed command syntax is explicitly marked as such. The current depth audit, expansion plan, and follow-up review response are in `research/depth-audit.md`, `research/expansion-plan.md`, and `research/followup-review-response.md`; they distinguish the existing first-pass skeleton from the expanded technical chapters and record remaining scale work honestly.
