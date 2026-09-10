#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT"
tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

PYTHONHASHSEED=0 uv run --frozen python scripts/render-pdf.py
cp build/jj-book.pdf "$tmpdir/first.pdf"
PYTHONHASHSEED=0 uv run --frozen python scripts/render-pdf.py
cmp "$tmpdir/first.pdf" build/jj-book.pdf
sha256sum build/jj-book.pdf
echo "PDF reproducibility: byte-identical repeated renders"
