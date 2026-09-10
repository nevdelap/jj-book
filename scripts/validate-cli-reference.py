import html
import re
from pathlib import Path

root = Path(__file__).resolve().parents[1]
inventory = root / "research" / "command-inventory.md"
book = root / "src" / "book.html"
expected = set(re.findall(r"^\| (jj .+?) \|", inventory.read_text(encoding="utf-8"), re.M))
text = book.read_text(encoding="utf-8")
headings = set(re.findall(r"<h4[^>]*><code>(jj [^<]+)</code>", text))
top_level = {path.split()[1] for path in expected}
count_claim = re.search(
    r"reports (\d+) top-level commands and (\d+) public command paths",
    text,
)
if not count_claim:
    raise SystemExit("reader-facing CLI totals are missing")
claimed = tuple(map(int, count_claim.groups()))
actual = (len(top_level), len(expected))
if claimed != actual:
    raise SystemExit(
        f"reader-facing CLI totals are stale: prose claims {claimed}, inventory has {actual}"
    )
missing = sorted(expected - headings)
if missing:
    raise SystemExit("canonical command entries missing: " + ", ".join(missing))
if "<code>jj converge</code>" not in text:
    raise SystemExit("jj converge entry is missing")
print(f"CLI reference valid: {len(expected)} canonical jj 0.45.1 paths")

start = text.index('<h3 id="cli-command-reference-alphabetical">')
end = text.index('<h3 id="cli-global-detail">', start)
entries = re.findall(
    r'<article class="command-entry".*?</article>', text[start:end], re.S
)


def command_key(entry: str) -> str:
    heading = re.search(r"<h4[^>]*>(.*?)</h4>", entry, re.S)
    code = re.search(r"<code>(.*?)</code>", heading.group(1), re.S)
    return html.unescape(re.sub(r"<[^>]+>", "", code.group(1))).casefold()


keys = [command_key(entry) for entry in entries]
if keys != sorted(keys):
    for previous, current in zip(keys, keys[1:]):
        if previous > current:
            raise SystemExit(
                f"Part XV command entries are not alphabetical: {previous!r} "
                f"precedes {current!r}"
            )
    raise SystemExit("Part XV command entries are not alphabetical")
print(f"Part XV command order valid: {len(keys)} entries")
