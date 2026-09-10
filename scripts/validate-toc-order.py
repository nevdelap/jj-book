from html.parser import HTMLParser
from pathlib import Path
import re


SOURCE = Path(__file__).resolve().parents[1] / "src" / "book.html"
source = SOURCE.read_text(encoding="utf-8")
positions = {
    match.group(1): match.start()
    for match in re.finditer(r'\bid="([^"]+)"', source)
}


class NavigationParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.in_navigation = False
        self.current_href = None
        self.current_text = []
        self.links = []

    def handle_starttag(self, tag, attrs):
        if tag == "nav":
            self.in_navigation = True
        if self.in_navigation and tag == "a":
            self.current_href = dict(attrs).get("href")
            self.current_text = []

    def handle_data(self, data):
        if self.in_navigation and self.current_href is not None:
            self.current_text.append(data)

    def handle_endtag(self, tag):
        if self.in_navigation and tag == "a" and self.current_href is not None:
            self.links.append(("".join(self.current_text).strip(), self.current_href))
            self.current_href = None
        if tag == "nav":
            self.in_navigation = False


parser = NavigationParser()
parser.feed(source)
last_position = -1
for title, href in parser.links:
    if not href or not href.startswith("#"):
        raise SystemExit(f"contents link is not an internal anchor: {title!r} -> {href!r}")
    ident = href[1:]
    if ident not in positions:
        raise SystemExit(f"contents link has no target: {title!r} -> {href!r}")
    position = positions[ident]
    if position < last_position:
        raise SystemExit(f"contents entry is out of source order: {title!r} -> {href!r}")
    last_position = position

print(f"contents order valid: {len(parser.links)} entries follow source order")
