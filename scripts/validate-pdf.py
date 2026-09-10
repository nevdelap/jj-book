import re
from pathlib import Path
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[1]
pdf = ROOT / "build" / "jj-book.pdf"
if not pdf.is_file() or pdf.stat().st_size < 10000:
    raise SystemExit(f"missing or implausibly small PDF: {pdf}")
reader = PdfReader(str(pdf))
source = (ROOT / "src" / "book.html").read_text(encoding="utf-8")
legacy_diagram_chars = "─├└│┤┘┐┌₁₂₀₃ₙ▶►↘"
remaining_legacy = {char: source.count(char) for char in legacy_diagram_chars if char in source}
if remaining_legacy:
    raise SystemExit(f"source still contains PDF-unsafe box-drawing characters: {remaining_legacy}")
metadata = reader.metadata or {}
for key in ("/Title", "/Author", "/Subject", "/Keywords"):
    if not str(metadata.get(key, "")).strip():
        raise SystemExit(f"PDF metadata field is missing: {key}")
pages = len(reader.pages)
if pages < 10:
    raise SystemExit(f"unexpectedly short PDF: {pages} pages")
box = reader.pages[0].mediabox
width, height = float(box.width), float(box.height)
if not (abs(width - 540) < 2 and abs(height - 720) < 2):
    raise SystemExit(f"unexpected Kindle-Scribe page box: {width} x {height} pt")
for index, page in enumerate(reader.pages, start=1):
    page_box = page.mediabox
    page_width, page_height = float(page_box.width), float(page_box.height)
    if not (abs(page_width - width) < 2 and abs(page_height - height) < 2):
        raise SystemExit(f"page {index} has inconsistent page box: {page_width} x {page_height} pt")
text_pages = sum(bool((page.extract_text() or "").strip()) for page in reader.pages)
if text_pages != pages:
    raise SystemExit(f"{pages - text_pages} PDF pages contain no extractable text")
footer_pages = sum(
    bool(re.search(r"Jujutsu for Git Experts.*\d+ / \d+", page.extract_text() or ""))
    for page in reader.pages
)
if footer_pages != pages:
    raise SystemExit(f"page-number footer missing from {pages - footer_pages} pages")
toc_text = " ".join((reader.pages[index].extract_text() or "") for index in range(min(25, pages)))
for appendix in "ABCDEFGHIJK":
    if f"Appendix {appendix} —" not in toc_text:
        raise SystemExit(f"printed contents is missing Appendix {appendix}")
body_marker = "This book assumes that you already know Git"
body_start = next(
    (index for index, page in enumerate(reader.pages) if body_marker in (page.extract_text() or "")),
    None,
)
if body_start is None or body_start < 2:
    raise SystemExit(f"printed contents/body boundary is not isolated: body_start={body_start}")

# A heading at the foot of a page is especially damaging in a reference book.
# Check representative major transitions against the text stream. The pinned
# renderer uses -pdf-keep-with-next, so each heading should have body text on
# its destination page rather than ending the previous page.
for heading in (
    "Part II — The jj mental model for Git experts",
    "Part XI — Operation log, undo, and recovery",
    "Part XVII — Complete real workflows",
    "Part XVIII — Practice, reference, and fieldbooks",
    "Appendix D — Complete fileset reference",
    "Appendix E — Complete template types and methods",
    "Appendix F — Complete configuration families",
    "Appendix H — GitHub recipes fieldbook",
):
    destination = next(
        (index for index, page in enumerate(reader.pages[body_start:], body_start) if heading in (page.extract_text() or "")),
        None,
    )
    if destination is None:
        raise SystemExit(f"required heading is absent from the body: {heading}")
    lines = (reader.pages[destination].extract_text() or "").splitlines()
    heading_line = next(index for index, line in enumerate(lines) if heading in line)
    following = [line.strip() for line in lines[heading_line + 1:] if line.strip()]
    following = [line for line in following if not re.search(r"Jujutsu for Git Experts.*\d+ / \d+", line)]
    if len(following) < 2:
        raise SystemExit(f"heading has no following body material on its page: {heading} (page {destination + 1})")
try:
    outline = reader.outline
except Exception as error:
    raise SystemExit(f"PDF outline cannot be read: {error}") from error

def outline_count(items):
    count = 0
    for item in items:
        if isinstance(item, list):
            count += outline_count(item)
        else:
            count += 1
    return count

outline_count_value = outline_count(outline)
if outline_count_value < 20:
    raise SystemExit(f"PDF contains too few outline entries: {outline_count_value}")

def outline_titles(items):
    titles = []
    for item in items:
        if isinstance(item, list):
            titles.extend(outline_titles(item))
        else:
            titles.append(item.title)
    return titles

outline_title_set = set(outline_titles(outline))
for required_title in (
    "D.1 — Fileset grammar and consumer matrix",
    "E.1 — Template type and method map",
    "F.1 — Configuration reference by task",
):
    if required_title not in outline_title_set:
        raise SystemExit(f"PDF outline is missing required reference destination: {required_title}")
font_names = set()
uri_links = 0
black_square_occurrences = 0
replacement_occurrences = 0
for page in reader.pages:
    page_text = page.extract_text() or ""
    black_square_occurrences += page_text.count("■")
    replacement_occurrences += page_text.count("�")
    resources = page.get("/Resources")
    if resources and resources.get("/Font"):
        font_names.update(resources["/Font"].keys())
    for annotation in page.get("/Annots", []):
        action = annotation.get_object().get("/A")
        if action and action.get("/URI"):
            uri_links += 1
if not font_names:
    raise SystemExit("PDF contains no selectable font resources")
if uri_links < 10:
    raise SystemExit(f"PDF contains too few source links: {uri_links}")
if black_square_occurrences or replacement_occurrences:
    raise SystemExit(
        "PDF contains missing-glyph substitutions: "
        f"black squares={black_square_occurrences}, replacements={replacement_occurrences}"
    )
print(f"PDF valid: {pages} pages, {width:g} x {height:g} pt, {pdf.stat().st_size} bytes, {len(font_names)} fonts, {uri_links} links, {outline_count_value} outline entries")
