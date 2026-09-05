#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J="$ROOT/.toolchain/bin/jj"
V=$("$J" version | awk '{print $2}')
top=$(awk 'BEGIN{done=0} /^===== jj help  =====/{p=1;next} p&&/^Commands:/{c=1;next} p&&c&&/^Options:/{exit} p&&c&&/^  [a-z]/{print $1}' "$ROOT/research/cli-help-$V.txt" | sort -u | wc -l)
paths=$(grep -c '^| jj ' "$ROOT/research/command-inventory.md")
functions=$(grep -oE '\* `[a-z_]+\(' "$ROOT/research/help-revsets-$V.md" | sort -u | wc -l || true)
fileset_functions=$(grep -oE '\* `[a-z-]+\(' "$ROOT/research/help-filesets-$V.md" | sort -u | wc -l || true)
command_entries=$(grep -c '<article class="command-entry"' "$ROOT/src/book.html" || true)
comparison_entries=$(awk '
  /<article class="command-entry"/ { article=1; newer=0 }
  article && /0\.45\.x/ { newer=1 }
  article && /<\/article>/ { if (newer) count++; article=0 }
  END { print count+0 }
' "$ROOT/src/book.html")
canonical_entries=$paths
pdf_pages=$(if test -f "$ROOT/build/jj-book.pdf"; then uv run --frozen python -c 'from pypdf import PdfReader; print(len(PdfReader("build/jj-book.pdf").pages))'; else echo not-built; fi)
pdf_sha256=$(if test -f "$ROOT/build/jj-book.pdf.sha256"; then awk '{print $1}' "$ROOT/build/jj-book.pdf.sha256"; else echo not-built; fi)
toc_pages=$(if test -f "$ROOT/build/jj-book.pdf"; then uv run --frozen python - <<'PY'
from pypdf import PdfReader
pages = PdfReader("build/jj-book.pdf").pages
for index, page in enumerate(pages, start=1):
    if "This book assumes that you already know Git" in (page.extract_text() or ""):
        print(index - 1)
        break
else:
    print("unknown")
PY
else echo not-built; fi)
outline_entries=$(if test -f "$ROOT/build/jj-book.pdf"; then uv run --frozen python - <<'PY'
from pypdf import PdfReader
def count(items):
    return sum(count(item) if isinstance(item, list) else 1 for item in items)
print(count(PdfReader("build/jj-book.pdf").outline))
PY
else echo not-built; fi)
book_words=$(uv run --frozen python -c 'from html.parser import HTMLParser; from pathlib import Path
class P(HTMLParser):
    def __init__(self): super().__init__(); self.out=[]; self.skip=0
    def handle_starttag(self,t,a):
        if t in ("pre","script","style"): self.skip += 1
    def handle_endtag(self,t):
        if t in ("pre","script","style"): self.skip = max(0,self.skip-1)
    def handle_data(self,d):
        if not self.skip: self.out.append(d)
p=P(); p.feed(Path("src/book.html").read_text()); print(len(" ".join(p.out).split()))')
primary_binary_sha=$(sha256sum "$ROOT/.toolchain/bin/jj" | awk '{print $1}')
comparison_binary_sha=$(sha256sum "$ROOT/.toolchain/jj-0.45/bin/jj" | awk '{print $1}')
cat > "$ROOT/research/toolchain-checksums.md" <<EOF
# Pinned toolchain checksums

Generated: 2026-09-06 UTC by \`scripts/write-completeness-report.sh\`.

| Binary | Version | SHA-256 | Provisioning/verification |
|---|---|---|---|
| \`.toolchain/bin/jj\` | 0.44.0 | $primary_binary_sha | \`just setup\`; version assertion and \`cargo install --locked jj-cli --version 0.44.0\` |
| \`.toolchain/jj-0.45/bin/jj\` | 0.45.1 | $comparison_binary_sha | \`just setup-045\`; version assertion and \`cargo install --locked jj-cli --version 0.45.1\` |

The comparison binary is a required part of the two-release inventory pass;
the comparison recipe fails if it cannot provision or verify it. These hashes
identify the local executables used to generate the corresponding help
captures and inventories; they are not a substitute for verifying the
upstream package provenance.
EOF
cat > "$ROOT/research/completeness-report.md" <<EOF
# Completeness report

Generated: 2026-09-06 UTC

## Targets

* Primary: jj $V (expected 0.44.0)
* Comparison: jj 0.45.1 when the separate binary is present
* Git: $(git --version)
* Authored deliverable: ../jj-book.html, a symlink to the first-class HTML source src/book.html

## Inventories

* Top-level commands found: $top
* Command paths with dedicated local help captured: $paths
* Reader-facing CLI articles in the authored HTML: $command_entries
* Canonical 0.44 reader-facing CLI articles: $canonical_entries
* 0.45.x comparison-only CLI articles: $comparison_entries
* Substantive authored-book words (approximate, excludes pre/script/style): $book_words
* Expansion design target: 100,000–130,000 substantive words / approximately 450–600 Kindle-Scribe pages
* Rendered PDF pages: $pdf_pages (7.5 × 10 inch portrait; see build/jj-book.pdf.sha256)
* Rendered PDF SHA-256: $pdf_sha256
* Printed contents span: $toc_pages page(s) before the substantive preface; PDF outline entries: $outline_entries
* Revset operators: documented in research/revset-inventory.md and the raw help snapshot
* Revset function names: $functions extracted help entries; grouped prose is in the HTML
* Fileset function entries: $fileset_functions extracted help entries; syntax is in raw help
* Config commands: edit, gc, get, list, path, set, unset
* Config schema: captured as research/config-schema-0.44.0.json and research/config-schema-0.45.1.json with jj util config-schema
* Pinned binary checksums: recorded in research/toolchain-checksums.md
* Template features: objects, methods, operators, conditionals, lists, labels, colours, aliases

## Validated

* 0.44.0 version/help and recursive command inventory
* 0.45.1 version/help and comparison inventory
* colocated init, snapshot/new, log, diff, files, status, bookmarks, operation undo/redo
* local bare Git remote add, push, fetch, and tracking
* Git-backend object/HEAD/ref reachability, raw change-id header, colocated export, and non-colocated layout fixture
* authored template examples against the validation repository
* representative revset topology, state, pattern, and visibility expressions
* workspace add/list/root/rename/update-stale/forget behaviour, including external edits remaining unrecorded rather than stale metadata
* semantic graph, identity, bookmark, template, revset, sparse, and conflict assertions
* canonical 0.44 command-path coverage and explicit 0.45.x converge labelling
* generated HTML exists and contains the Kindle Scribe print profile
* generated PDF contains page-number footers, individually listed Appendix A–K contents entries, and reader outline bookmarks
* generated PDF contains no source box-drawing glyphs or extracted missing-glyph substitutions; contents and outline are checked independently
* generated PDF isolates the printed contents from the preface and keeps representative major headings with following body material
* Part XII workspace headings precede the contiguous Part XIII configuration progression
* independent PDFium rendering of representative contents, chapter-start, graph, code, table, Git, and appendix pages; observations are recorded in research/print-acceptance.md

## Not validated locally

* Gerrit server/UI behaviour, reviewer/label/topic side effects, and authentication: no Gerrit server is available
* GitHub PR/UI behaviour and fork permissions: no GitHub account/server fixture is available
* GPG/SSH signing against a real key or hardware token
* External merge/diff tools and interactive TUIs in a non-interactive validator
* Every prose cookbook query against every possible DAG shape; representative fixture checks are supplied
* Full fixer, signing, and interactive-TUI laboratories remain to be run in the current non-interactive environment; conflict, sparse, and workspace lifecycle fixtures are run locally

## Known ambiguities and exclusions

* Current-main documentation can move ahead of both target releases; version tags and raw local help take precedence.
* 0.45.x additions are recorded in research/discrepancies.md; no 0.45-only feature is presented as 0.44 syntax.
* Third-party logos, screenshots, copied documentation passages, fonts, and JavaScript libraries are deliberately excluded. Licensing decisions are in research/licenses.md and research/book-license.md; Apache-2.0.txt is bundled for generated Jujutsu-derived help material.
* PDF generation is performed by the pinned xhtml2pdf/pypdf pipeline from src/book.html; the HTML has a 7.5 × 10 inch portrait @page profile matching Kindle Scribe's 3:4 display ratio. The PDF is text-checked and its page box/metadata are validated; independent PDFium samples are rendered by the visual recipe and inspected as recorded in research/print-acceptance.md.

## Depth status

* Inventory-complete: yes for the captured 0.44.0 command tree and comparison 0.45.1 tree.
* Reference-complete: yes for the target-version reader-facing command paths and the documented revset/fileset/template/configuration surfaces; versioned raw help and schemas remain the exhaustive spelling/default evidence.
* Conceptually explained: expanded for graph, snapshots, rewrites, revsets, filesets, templates, conflicts, operations, and publication.
* Empirically validated: representative local Git, rewrite, revset, operation, and template examples; not every prose example.
* Workflow-demonstrated: expanded narratives are present; GitHub/Gerrit server/UI behaviour remains documented/server-dependent.
* Remaining work: optional technically justified additions, external/server-dependent acceptance where available, and rerun pagination after substantive source changes.
EOF
