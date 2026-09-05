from html.parser import HTMLParser
from pathlib import Path


class HeadingParser(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.headings = []
        self.current = None

    def handle_starttag(self, tag, attrs):
        if tag in {"h2", "h3", "h4"}:
            self.current = [tag, "", []]

    def handle_endtag(self, tag):
        if self.current and self.current[0] == tag:
            self.headings.append((tag, self.current[1].strip()))
            self.current = None

    def handle_data(self, data):
        if self.current:
            self.current[2].append(data)
            self.current[1] = "".join(self.current[2])


root = Path(__file__).resolve().parents[1]
source = root / "src" / "book.html"
source_text = source.read_text(encoding="utf-8")
for invalid in ("@A", "@B", "@default", "@review", "@dev", "@build", "@/workspace-name"):
    if invalid in source_text:
        raise SystemExit(f"reversed workspace notation remains in source: {invalid}")
parser = HeadingParser()
parser.feed(source_text)

headings = parser.headings
part_xii = next((i for i, (_, title) in enumerate(headings) if title.startswith("Part XII —")), None)
part_xiii = next((i for i, (_, title) in enumerate(headings) if title.startswith("Part XIII —")), None)
part_xiv = next((i for i, (_, title) in enumerate(headings) if title.startswith("Part XIV —")), None)
if part_xii is None or part_xiii is None or part_xiv is None or part_xii >= part_xiii:
    raise SystemExit("could not establish Part XII/Part XIII heading order")

workspace_titles = [
    title for _, title in headings[part_xii + 1 : part_xiii]
    if "workspace" in title.lower()
]
if not workspace_titles:
    raise SystemExit("Part XII has no workspace subsections")

misplaced = [
    title for _, title in headings[part_xiii + 1 : part_xiv]
    if any(marker in title.lower() for marker in ("workspace laboratory", "two machines:", "sparse working copies"))
]
if misplaced:
    raise SystemExit("workspace heading appears after Part XIII begins: " + "; ".join(misplaced))

required = {
    "Workspace laboratory: one store, several materialisations",
    "Build and review workspace invariants",
    "Stale workspaces and repair",
    "Two machines and unfinished work",
    "Sparse build workspace",
}
present = {title for _, title in headings}
missing = sorted(required - present)
if missing:
    raise SystemExit("consolidated workspace sections missing: " + "; ".join(missing))

print(
    "structure valid: Part XII workspace material precedes contiguous Part XIII "
    f"({len(workspace_titles)} workspace headings before configuration)"
)
