import shutil
from pathlib import Path

import pypdfium2
from pypdf import PdfReader


ROOT = Path(__file__).resolve().parents[1]
PDF = ROOT / "build" / "jj-book.pdf"
OUTPUT = ROOT / "build" / "visual-inspection"
FIXED_SAMPLE_PAGES = (1, 2, 3, 4, 109, 147, 313, 450, 475, 495)
HEADING_SAMPLES = (
    "Part XII — Workspaces and multiple machines",
    "Workspace laboratory: one store, several materialisations",
    "Part XIII — Configuration",
    "Configuration laboratory: construct policy without losing the layers",
    "Configuration reference: the keys that shape daily behaviour",
)

if not PDF.is_file():
    raise SystemExit(f"missing PDF: {PDF}")
if OUTPUT.exists():
    shutil.rmtree(OUTPUT)
OUTPUT.mkdir(parents=True, exist_ok=True)
document = pypdfium2.PdfDocument(str(PDF))

# Fixed page numbers cover front matter and a stable spread of the book.  The
# changed-section samples are located from the current PDF text so pagination
# changes do not silently leave visual acceptance pointed at old pages.
reader = PdfReader(str(PDF))
sample_pages = set(FIXED_SAMPLE_PAGES)
body_start = next(
    (index for index, page in enumerate(reader.pages) if "This book assumes that you already know Git" in (page.extract_text() or "")),
    0,
)
for needle in HEADING_SAMPLES:
    for index, page in enumerate(reader.pages[body_start:], start=body_start + 1):
        if needle in (page.extract_text() or ""):
            sample_pages.add(index)
            break
    else:
        raise SystemExit(f"could not locate current heading in PDF: {needle}")

for page_number in sorted(sample_pages):
    if page_number > len(document):
        raise SystemExit(f"sample page {page_number} exceeds PDF length {len(document)}")
    try:
        bitmap = document[page_number - 1].render(scale=1.0)
    except Exception as error:
        raise SystemExit(f"could not render sample page {page_number}: {error}") from error
    bitmap.to_pil().save(OUTPUT / f"page-{page_number:03d}.png")
print(f"Rendered {len(sample_pages)} independent PDFium samples in {OUTPUT}")
