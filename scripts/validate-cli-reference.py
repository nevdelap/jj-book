import re
from pathlib import Path

root = Path(__file__).resolve().parents[1]
inventory = root / "research" / "command-inventory.md"
html = root / "src" / "book.html"
expected = set(re.findall(r"^\| (jj .+?) \|", inventory.read_text(encoding="utf-8"), re.M))
text = html.read_text(encoding="utf-8")
headings = set(re.findall(r"<h4[^>]*><code>(jj [^<]+)</code>", text))
missing = sorted(expected - headings)
if missing:
    raise SystemExit("canonical command entries missing: " + ", ".join(missing))
converge = re.search(r"<h4[^>]*><code>jj converge</code>.*?0\.45\.x", text, re.S)
if not converge:
    raise SystemExit("0.45.x converge entry is not explicitly version-labelled")
print(f"CLI reference valid: {len(expected)} canonical 0.44 paths; 0.45-only converge labelled")
