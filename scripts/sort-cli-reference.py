#!/usr/bin/env python3
"""Keep the reader-facing Part XV command entries alphabetically ordered."""

from __future__ import annotations

import html
import re
from pathlib import Path


BOOK = Path("src/book.html")


def command_key(block: str) -> str:
    heading = re.search(r"<h4[^>]*>(.*?)</h4>", block, re.S)
    if heading is None:
        raise SystemExit("command entry has no h4 heading")
    code = re.search(r"<code>(.*?)</code>", heading.group(1), re.S)
    if code is None:
        raise SystemExit("command entry heading has no code element")
    return html.unescape(re.sub(r"<[^>]+>", "", code.group(1))).casefold()


text = BOOK.read_text()
part = text.index('<section id="part14">')
start = text.index('<article class="command-entry"', part)
detail_start = text.index('<h3 id="cli-global-detail">', start)
global_options = text.index('<h3 id="global-options">', detail_start)
region = text[start:detail_start]
detail_region = text[detail_start:global_options]
entries = re.findall(r'<article class="command-entry".*?</article>', region, re.S)
late_entries = re.findall(r'<article class="command-entry".*?</article>', detail_region, re.S)

if len(entries) != 120 or len(late_entries) != 1:
    raise SystemExit(
        f"expected 120 primary and 1 late Part XV command entries, "
        f"found {len(entries)} and {len(late_entries)}"
    )

entries.extend(late_entries)
detail_region = detail_region.replace(late_entries[0], "", 1)

keys = [command_key(entry) for entry in entries]
if len(keys) != len(set(keys)):
    raise SystemExit("duplicate command-entry sort keys")

entries.sort(key=command_key)
replacement = (
    '<h3 id="cli-command-reference-alphabetical">'
    "Alphabetical command reference entries</h3>\n"
    "<p>These reader-facing entries are ordered by canonical command path. "
    "The order is deliberately independent of the conceptual grouping used in "
    "the teaching chapters; use the browser's find function or the printed "
    "contents to reach a command, then follow the related-command links for "
    "semantics and workflows.</p>\n\n"
    + "\n\n".join(entries)
    + "\n\n"
)
BOOK.write_text(text[:start] + replacement + detail_region + text[global_options:])
