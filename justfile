set shell := ["env", "BASH_ENV=/dev/null", "bash", "-euc"]

root := justfile_directory()
jj044 := root / ".toolchain/bin/jj"
jj045 := root / ".toolchain/jj-0.45/bin/jj"

default: all

all: build test review

setup:
    test -x "{{jj044}}" || cargo install --locked jj-cli --version 0.44.0 --root "{{root}}/.toolchain"
    test "$("{{jj044}}" version)" = "jj 0.44.0"

setup-045:
    test -x "{{jj045}}" || cargo install --locked jj-cli --version 0.45.1 --root "{{root}}/.toolchain/jj-0.45"
    test "$("{{jj045}}" version)" = "jj 0.45.1"

inventory: setup
    JJ_BIN="{{jj044}}" bash scripts/inventory-cli.sh research/command-inventory.md

compare-045: setup-045
    JJ_BIN="{{jj045}}" bash scripts/inventory-cli.sh research/command-inventory-0.45.md

sync:
    uv sync --locked

html:
    ln -sfn src/book.html jj-book.html
    uv run --frozen python scripts/validate-html.py
    uv run --frozen python scripts/validate-structure.py

pdf: sync html
    uv run --frozen python scripts/render-pdf.py
    uv run --frozen python scripts/validate-pdf.py
    sha256sum build/jj-book.pdf > build/jj-book.pdf.sha256
    ln -sfn build/jj-book.pdf jj-book.pdf

pdf-check: sync
    test -f build/jj-book.pdf
    uv run --frozen python scripts/validate-pdf.py
    test -s build/jj-book.pdf.sha256

visual: pdf
    uv run --frozen python scripts/render-visual-samples.py

build: setup inventory compare-045 pdf

html-check: html

cli-check:
    uv run --frozen python scripts/validate-cli-reference.py

test: setup sync validate html-check cli-check pdf

review: test report visual
    test -L jj-book.html
    test -L jj-book.pdf

clean:
    rm -rf build
    rm -f jj-book.pdf jj-book.html

validate: setup
    JJ_BIN="{{jj044}}" bash scripts/validate-examples.sh
    JJ_BIN="{{jj044}}" bash scripts/validate-templates.sh
    JJ_BIN="{{jj044}}" bash scripts/validate-revsets.sh
    JJ_BIN="{{jj044}}" bash scripts/validate-workspaces.sh
    JJ_BIN="{{jj044}}" bash scripts/validate-semantics.sh
    JJ_BIN="{{jj044}}" bash scripts/validate-sparse.sh
    JJ_BIN="{{jj044}}" bash scripts/validate-conflicts.sh
    JJ_BIN="{{jj044}}" bash scripts/validate-git-backend.sh

report: inventory compare-045
    bash scripts/write-completeness-report.sh
