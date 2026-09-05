# Tooling audit

## Commands run

```text
uv --version                         -> uv 0.12.5
just --version                       -> just 1.45.0
just --list                          -> all, compare-045, default, html, inventory, report, setup, validate
uv sync                              -> fails: No pyproject.toml found
just build                           -> fails: recipe absent
just pdf                             -> fails: recipe absent
just test                            -> fails: recipe absent
just clean                           -> fails: recipe absent
just review                          -> fails: recipe absent
BASH_ENV=/dev/null just validate    -> passes
```

## Findings

- **B-001/B-004:** No HTML-to-PDF build or required just interface exists.
- **M-001:** No uv project/lockfile or declared Python version exists. The only Python call is `uv run --no-project python` in the report script.
- The justfile uses repository-relative `justfile_directory()` paths, has fail-fast Bash settings, and successfully runs the local 0.44 validation suite when the inherited environment does not make Bash startup fail.
- `compare-045` has a successful warning path when the comparison binary is missing; a declared comparison track should either be provisioned or fail closed. See M-013.
- `just html` uses `ln -sfn src/book.html jj-book.html`, which preserves/recreates the working-tree HTML symlink. It does not generate an HTML artefact or PDF.

## Required outcome

Define the project’s actual dependency model. If no Python package is needed, make that explicit and remove the pseudo-project measurement dependency; if Python remains, use a committed uv project/lockfile. Add build, PDF, test, clean, validate, completeness, and review recipes with deterministic outputs and no silent success paths.

