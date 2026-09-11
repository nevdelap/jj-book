#!/usr/bin/env python3
"""Check reader-facing revset examples against the pinned jj parser."""

from __future__ import annotations

import os
import re
import subprocess
import sys
from html.parser import HTMLParser
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
BOOK = ROOT / "src/book.html"
REPO = ROOT / "build/validation/revsets/repo"
JJ = os.environ.get("JJ_BIN", str(ROOT / ".toolchain/bin/jj"))


class BlockParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.in_pre = False
        self.blocks: list[str] = []
        self.current: list[str] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        if tag == "pre":
            self.in_pre = True
            self.current = []

    def handle_endtag(self, tag: str) -> None:
        if tag == "pre" and self.in_pre:
            self.blocks.append("".join(self.current))
            self.in_pre = False

    def handle_data(self, data: str) -> None:
        if self.in_pre:
            self.current.append(data)


def candidates(blocks: list[str]) -> list[str]:
    option = re.compile(
        r"(?:^|\s)(?:-r|--revision|--revisions|--source|--branch|"
        r"--onto|--destination|--changes-in|--from|--to)\s+"
        r"(?:'([^']*)'|\"([^\"]*)\"|(\S+))"
    )
    result: list[str] = []
    for block in blocks:
        for match in option.finditer(block):
            result.append(next(value for value in match.groups() if value is not None))
    return result


def declared_aliases(blocks: list[str]) -> set[str]:
    """Return parameterised aliases declared in reader-facing examples.

    An alias is valid only in the configuration block that declares it.  The
    validator uses this list to avoid trying to parse an alias invocation in
    the deliberately configuration-free validation repository.
    """
    declaration = re.compile(r"^\s*([A-Za-z][A-Za-z0-9_-]*)\([^=]*\)\s*=", re.M)
    return {name for block in blocks for name in declaration.findall(block)}


def is_teaching_placeholder(expression: str, aliases: set[str]) -> bool:
    """Exclude examples that intentionally cannot be run literally.

    The book uses symbolic prefixes and shell variables when teaching the
    language, and includes two examples whose purpose is to demonstrate Rust
    regex features rejected by jj.  Those are checked by source assertions,
    not treated as real executable examples.
    """
    if "$" in expression or "..." in expression:
        return True
    if re.search(r"\b(?:PREFIX|CHANGE|API_CHANGE|METRICS_CHANGE|CACHE_CHANGE|A_CHANGE)\b", expression):
        return True
    if re.search(r"(?:commit_id|change_id)\((?:\"prefix\"|prefix|exact:\"(?:a1b2|qwer)\")", expression):
        return True
    if re.search(r"\b(?:important|abc|qxy|3f0)\b", expression):
        return True
    if "(?=" in expression or "\\\\1" in expression:
        return True
    alias_call = re.match(r"([A-Za-z][A-Za-z0-9_-]*)\(", expression)
    return bool(alias_call and alias_call.group(1) in aliases)


def main() -> int:
    source = BOOK.read_text()
    parser = BlockParser()
    parser.feed(source)

    forbidden = re.compile(r"\b(?:bookmark|tag|conflicted|evolution|workspaces|file)\s*\((?!s\))")
    bad = [(m.group(0), source.count("\n", 0, m.start()) + 1) for m in forbidden.finditer(source)]
    if bad:
        for name, line in bad:
            print(f"unsupported revset spelling {name!r} at src/book.html:{line}", file=sys.stderr)
        return 1
    if "at_operation()" in source:
        print("at_operation() without required arguments remains in src/book.html", file=sys.stderr)
        return 1
    if 'diff_contains(pattern)</code> <span class="tag">deprecated' not in source:
        print("diff_contains() is not labelled deprecated in the reference", file=sys.stderr)
        return 1
    if not REPO.is_dir():
        print(f"missing validation repository: {REPO}", file=sys.stderr)
        return 1

    failures: list[tuple[str, str]] = []
    expressions = candidates(parser.blocks)
    aliases = declared_aliases(parser.blocks)
    for expression in expressions:
        if is_teaching_placeholder(expression, aliases):
            continue
        result = subprocess.run(
            [JJ, "--ignore-working-copy", "log", "--no-graph", "-r", expression],
            cwd=REPO,
            env={**os.environ, "JJ_CONFIG": "/dev/null"},
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
        )
        # Unknown symbolic revisions are expected in documentation. Parser,
        # function, and argument-count errors are not.
        if re.search(
            r"Failed to parse revset|Invalid (?:revset|string pattern)|"
            r"Function `[^`]+` doesn't exist|Expected \d+ arguments",
            result.stdout,
        ):
            failures.append((expression, result.stdout.strip().splitlines()[0]))

    if failures:
        for expression, error in failures:
            print(f"revset parse failure for {expression!r}: {error}", file=sys.stderr)
        return 1
    print(f"revset surface validation passed: {len(expressions)} extracted expressions")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
