"""Generate a per-distribution licence/obligation register for the frozen uv environment."""

from __future__ import annotations

import re
from datetime import UTC, datetime
from importlib.metadata import PackageNotFoundError, distribution
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
LOCK = ROOT / "uv.lock"
OUT = ROOT / "research" / "license-package-inventory.md"

LICENSES = {
    "aiohappyeyeballs": "Python Software Foundation License (license file in wheel)",
    "aiohttp": "Apache-2.0; bundled llhttp is MIT",
    "aiosignal": "Apache-2.0",
    "arabic-reshaper": "MIT",
    "asn1crypto": "MIT",
    "attrs": "MIT",
    "certifi": "MPL-2.0 for the certificate bundle; package terms in wheel",
    "cffi": "MIT No Attribution",
    "charset-normalizer": "MIT",
    "cryptography": "Apache-2.0 OR BSD-3-Clause",
    "cssselect2": "BSD-3-Clause",
    "frozenlist": "Apache-2.0",
    "html5lib": "MIT",
    "idna": "BSD-3-Clause",
    "lxml": "BSD-3-Clause with documented exceptions",
    "multidict": "Apache-2.0",
    "oscrypto": "MIT",
    "pillow": "MIT-CMU",
    "propcache": "Apache-2.0",
    "pycparser": "BSD-3-Clause",
    "pyhanko": "MIT; includes a PyPDF2 licence file for reproduced elements",
    "pyhanko-certvalidator": "MIT",
    "pypdf": "BSD-3-Clause",
    "pypdfium2": "Apache-2.0 / BSD-3-Clause; PDFium dependency licences are shipped in the wheel",
    "python-bidi": "GPL-3.0-or-later / LGPL-3.0-or-later files in the wheel",
    "reportlab": "BSD-style ReportLab licence; bundled fonts have separate notices",
    "six": "MIT",
    "svglib": "LGPL-3.0-or-later",
    "tinycss2": "BSD-3-Clause",
    "typing-extensions": "Python Software Foundation License",
    "tzdata": "Apache-2.0; timezone data terms in the wheel",
    "tzlocal": "MIT",
    "uritools": "MIT",
    "webencodings": "BSD-3-Clause",
    "xhtml2pdf": "Apache-2.0",
    "yarl": "Apache-2.0",
}

OBLIGATIONS = {
    "Apache": (
        "Retain copyright, attribution, patent, and trademark notices; include the "
        "licence; mark modified files; preserve any NOTICE file."
    ),
    "MIT": "Retain the copyright and permission notice; no endorsement is implied.",
    "BSD": "Retain copyright, conditions, and disclaimer; do not use names for endorsement.",
    "MPL": "Retain notices; distributed modifications to covered files remain subject to MPL terms.",
    "LGPL": "Retain notices and licence; comply with LGPL source/relinking obligations if distributed.",
    "GPL": "Retain notices and licence; comply with GPL source and redistribution obligations if distributed.",
    "PSF": "Retain the package licence and notices when redistributing the package.",
    "mixed": "Retain every licence and notice shipped by the wheel, including embedded dependency notices.",
}


def package_names() -> list[tuple[str, str]]:
    text = LOCK.read_text(encoding="utf-8")
    pairs = re.findall(r'^name = "([^"\\]+)"\nversion = "([^"\\]+)"', text, re.M)
    return [(name, version) for name, version in pairs if name != "jj-book-build"]


def source_url(name: str, metadata) -> str:
    urls = metadata.get_all("Project-URL") or []
    labelled = [(item.partition(",")[0].casefold(), item.partition(",")[2].strip()) for item in urls]
    for keyword in ("source", "repository", "repo", "homepage"):
        for label, url in labelled:
            if keyword in label and url:
                return url
    for label, url in labelled:
        if "github" in label and url:
            return url
    return f"https://pypi.org/project/{name}/{metadata.get('Version', '')}/"


def obligation_for(licence: str) -> str:
    value = licence.casefold()
    if "pypdfium2" in value or "/" in value and "bsd" in value and "apache" in value:
        return OBLIGATIONS["mixed"]
    if "apache" in value:
        return OBLIGATIONS["Apache"]
    if "lgpl" in value:
        return OBLIGATIONS["LGPL"]
    if "gpl" in value:
        return OBLIGATIONS["GPL"]
    if "mpl" in value:
        return OBLIGATIONS["MPL"]
    if "bsd" in value:
        return OBLIGATIONS["BSD"]
    if "mit" in value:
        return OBLIGATIONS["MIT"]
    return OBLIGATIONS["PSF"]


def license_files(dist) -> str:
    files = []
    for file in dist.files or []:
        lower = str(file).casefold()
        if any(word in lower for word in ("license", "copying", "notice")):
            files.append(str(file))
    return "; ".join(files[:8]) or "No licence filename exposed by metadata; inspect the source URL and wheel metadata."


rows: list[str] = []
missing: list[str] = []
for name, locked_version in package_names():
    try:
        dist = distribution(name)
        installed_version = dist.version
        owner = dist.metadata.get("Author") or dist.metadata.get("Maintainer") or "package maintainers"
        url = source_url(name, dist.metadata)
        evidence = license_files(dist)
    except PackageNotFoundError:
        installed_version = "not installed under current platform markers"
        owner = "package maintainers"
        url = f"https://pypi.org/project/{name}/{locked_version}/"
        evidence = "Licence file not available in the current platform environment; inspect the locked wheel/sdist before redistributing the environment."
        missing.append(name)
    licence = LICENSES.get(name, "See the exact licence file in the locked wheel")
    obligation = obligation_for(licence)
    rows.append(
        "| {name} {locked} | {owner}; [{url}]({url}) | Build/inspection dependency; no source or runtime asset is copied into HTML/PDF. | {licence}; local evidence: `{evidence}` | {obligation} | No — build environment only. | Pass for HTML/PDF; retain this package's notices if the toolchain is redistributed. | {installed} |".format(
            name=name,
            locked=locked_version,
            owner=owner.replace("|", "\\|"),
            url=url,
            licence=licence,
            evidence=evidence.replace("|", "\\|"),
            obligation=obligation,
            installed=installed_version,
        )
    )

header = """# Frozen build-environment licence inventory

Generated by `scripts/inventory-licenses.py` from `uv.lock` and the installed
wheel metadata. Generated: {date} UTC.

This inventory is not a claim that build dependencies are embedded in the
book. It is a per-distribution evidence record for the reproducible toolchain.
Every row records the exact locked version, source/owner, material/use type,
licence evidence, attribution/modification/redistribution obligations,
final-distribution status, compliance result, and platform-install status.

The HTML and PDF contain no dependency source, bundled fonts, JavaScript, or
runtime package assets. If the build environment itself is redistributed, the
listed wheel licence files and notices must travel with it.

| Package/version | Source and owner | Material/use type | Licence and evidence | Attribution/modification/redistribution obligations | Included in HTML/PDF | Compliance status | Installed status |
|---|---|---|---|---|---|---|---|
""".format(date=datetime.now(UTC).date())
OUT.write_text(header + "\n".join(rows) + "\n", encoding="utf-8")
if missing:
    print("platform-marker packages not installed: " + ", ".join(missing))
print(f"wrote {OUT} ({len(rows)} locked distributions)")
