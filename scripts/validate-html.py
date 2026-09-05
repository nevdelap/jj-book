from html.parser import HTMLParser
from pathlib import Path


class Validator(HTMLParser):
    void = {"area", "base", "br", "col", "embed", "hr", "img", "input", "link", "meta", "param", "source", "track", "wbr"}

    def __init__(self):
        super().__init__()
        self.stack = []
        self.ids = set()
        self.fragments = []
        self.errors = []

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        ident = attrs.get("id")
        if ident:
            if ident in self.ids:
                self.errors.append(f"duplicate id: {ident}")
            self.ids.add(ident)
        href = attrs.get("href", "")
        if href.startswith("#"):
            self.fragments.append(href[1:])
        if tag not in self.void:
            self.stack.append(tag)

    def handle_startendtag(self, tag, attrs):
        self.handle_starttag(tag, attrs)
        if tag not in self.void and self.stack and self.stack[-1] == tag:
            self.stack.pop()

    def handle_endtag(self, tag):
        if tag not in self.stack:
            self.errors.append(f"unmatched end tag: {tag}")
            return
        while self.stack:
            current = self.stack.pop()
            if current == tag:
                break


root = Path(__file__).resolve().parents[1]
source = root / "src" / "book.html"
parser = Validator()
parser.feed(source.read_text(encoding="utf-8"))
missing = sorted(set(parser.fragments) - parser.ids)
if parser.stack or parser.errors or missing:
    raise SystemExit(f"HTML validation failed: stack={parser.stack}, errors={parser.errors}, missing={missing}")
print(f"HTML valid: {len(parser.ids)} ids and {len(parser.fragments)} internal links")
