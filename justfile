set shell := ["env", "BASH_ENV=/dev/null", "bash", "-euc"]

root := justfile_directory()
jj := root / ".toolchain/bin/jj"

default: all

all: build test review

setup:
    if ! test -x "{{jj}}" || ! test "$("{{jj}}" version)" = "jj 0.45.1"; then cargo install --locked jj-cli --version 0.45.1 --root "{{root}}/.toolchain"; fi
    test "$("{{jj}}" version)" = "jj 0.45.1"

inventory: setup
    JJ_BIN="{{jj}}" bash scripts/inventory-cli.sh research/command-inventory.md

license-inventory: sync
    uv run --frozen python scripts/inventory-licenses.py

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

build: setup inventory pdf

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
    JJ_BIN="{{jj}}" bash scripts/validate-examples.sh
    JJ_BIN="{{jj}}" bash scripts/validate-cli-examples.sh
    uv run --frozen python scripts/validate-licenses.py
    JJ_BIN="{{jj}}" bash scripts/validate-templates.sh
    JJ_BIN="{{jj}}" bash scripts/validate-revsets.sh
    JJ_BIN="{{jj}}" bash scripts/validate-workspaces.sh
    JJ_BIN="{{jj}}" bash scripts/validate-semantics.sh
    JJ_BIN="{{jj}}" bash scripts/validate-sparse.sh
    JJ_BIN="{{jj}}" bash scripts/validate-conflicts.sh
    JJ_BIN="{{jj}}" bash scripts/validate-git-backend.sh

report: inventory license-inventory
    bash scripts/write-completeness-report.sh
