import os
import re
from html.parser import HTMLParser
from pathlib import Path
from xhtml2pdf import pisa
from pypdf import PdfReader, PdfWriter

if os.environ.get("PYTHONHASHSEED") != "0":
    raise SystemExit(
        "render-pdf.py requires PYTHONHASHSEED=0 for reproducible PDF resource names; "
        "run it through `just pdf` or set PYTHONHASHSEED=0 explicitly"
    )

ROOT = Path(__file__).resolve().parents[1]
source = ROOT / "src" / "book.html"
output = ROOT / "build" / "jj-book.pdf"
output.parent.mkdir(parents=True, exist_ok=True)
build_timestamp = (ROOT / "research" / "build-timestamp.txt").read_text(encoding="utf-8").strip()
if not re.fullmatch(r"\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z", build_timestamp):
    raise SystemExit(
        "research/build-timestamp.txt must contain an ISO-8601 UTC timestamp "
        "such as 2026-09-11T00:49:43Z"
    )
pdf_timestamp = "D:" + build_timestamp[:19].replace("-", "").replace(":", "").replace("T", "") + "Z"


class HeadingParser(HTMLParser):
    """Collect the curated headings used for the PDF outline.

    Chapter headings marked ``toc-entry`` form the curated sequence. Every
    command-reference article is also a navigable h4 entry, so the printed
    command reference can be used without searching through the PDF.
    """

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.current = None
        self.headings = []
        self.in_command_entry = False

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag == "article" and "command-entry" in attrs.get("class", "").split():
            self.in_command_entry = True
        selected_heading = (
            tag in {"h2", "h3"}
            and "toc-entry" in attrs.get("class", "").split()
        )
        selected_h4 = tag == "h4" and (
            "pdf-outline" in attrs.get("class", "").split() or self.in_command_entry
        )
        if selected_heading or selected_h4:
            self.current = [int(tag[1]), attrs.get("id", ""), []]

    def handle_endtag(self, tag):
        if self.current and tag == f"h{self.current[0]}":
            level, ident, parts = self.current
            title = re.sub(r"\s+", " ", "".join(parts)).strip()
            if title and ident:
                self.headings.append((level, ident, title))
            self.current = None
        if tag == "article" and self.in_command_entry:
            self.in_command_entry = False

    def handle_data(self, data):
        if self.current:
            self.current[2].append(data)


def compact(value):
    return re.sub(r"\s+", " ", value).strip()


def heading_pages(html_path, pdf_reader):
    parser = HeadingParser()
    parser.feed(html_path.read_text(encoding="utf-8"))
    page_text = [compact(page.extract_text() or "") for page in pdf_reader.pages]
    # The generated TOC repeats heading text before the actual body. Start at
    # the page containing the preface prose so a TOC occurrence cannot become
    # the destination of a chapter outline item.
    body_start = 0
    marker = "This book assumes that you already know Git"
    for index, text in enumerate(page_text):
        if marker in text:
            body_start = index
            break
    cursor = body_start
    located = []
    for level, ident, title in parser.headings:
        if ident == "print-contents-heading":
            continue
        needle = compact(title)
        found = None
        for index in range(cursor, len(page_text)):
            if needle in page_text[index]:
                found = index
                break
        if found is None:
            continue
        located.append((level, ident, title, found))
        cursor = found
    return located

html_text = source.read_text(encoding="utf-8")
# xhtml2pdf's printed ``pdf:toc`` honours the explicit outline class more
# reliably than a compound CSS selector. Keep the authored HTML unchanged and
# add the class only to the renderer input for command-reference h4 headings.
html_text = re.sub(
    r'(<article\s+class="command-entry"[^>]*>\s*<h4)(\s+id=)',
    r'\1 class="pdf-outline"\2',
    html_text,
)
html = html_text.encode("utf-8")
with output.open("wb") as stream:
    result = pisa.CreatePDF(html, dest=stream, path=str(source), encoding="utf-8")
if result.err:
    raise SystemExit(f"xhtml2pdf reported {result.err} error(s)")

# Set stable document metadata after rendering.  The page geometry comes from
# the authored @page rule and is checked by validate-pdf.py.
reader = PdfReader(str(output))
writer = PdfWriter()
for page in reader.pages:
    writer.add_page(page)

# Add navigable PDF outline entries after pagination is known. xhtml2pdf's
# generated TOC supplies printed contents; pypdf supplies durable PDF-reader
# bookmarks. The page numbers are therefore derived from this exact build.
outline_items = heading_pages(source, reader)
current_h2 = None
current_h3 = None
for level, _ident, title, page_number in outline_items:
    if level == 2:
        current_h2 = writer.add_outline_item(title, page_number)
        current_h3 = None
    elif level == 3:
        parent = current_h2
        current_h3 = writer.add_outline_item(title, page_number, parent=parent)
    elif level == 4:
        parent = current_h3 or current_h2
        writer.add_outline_item(title, page_number, parent=parent)
print(f"Added {len(outline_items)} PDF outline entries")
writer.add_metadata({
    "/Title": "Jujutsu for Git Experts: Graph-First Version Control",
    "/Author": "Jujutsu for Git Experts project",
    "/Subject": "Advanced jj reference for Git experts",
    "/Keywords": "jj, jujutsu, Git, revsets, filesets, templates",
    "/BuildTimestamp": build_timestamp,
    "/CreationDate": pdf_timestamp,
    "/ModDate": pdf_timestamp,
})
with output.open("wb") as stream:
    writer.write(stream)

print(output)
