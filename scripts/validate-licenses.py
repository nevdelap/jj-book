from __future__ import annotations

import re
from pathlib import Path


root = Path(__file__).resolve().parents[1]
licenses = (root / "research" / "licenses.md").read_text(encoding="utf-8")
inventory = (root / "research" / "license-package-inventory.md").read_text(encoding="utf-8")
notices = (root / "THIRD_PARTY_NOTICES").read_text(encoding="utf-8")
lock = (root / "uv.lock").read_text(encoding="utf-8")

required_source_fields = (
    "Source and owner",
    "Exact material used",
    "Use type",
    "Licence and authoritative licence evidence",
    "Attribution required",
    "Modification notice required",
    "Redistribution conditions",
    "Included in final distribution",
    "Compliance status",
    "Notes",
)
for field in required_source_fields:
    if field not in licenses:
        raise SystemExit(f"licence source register is missing field: {field}")

required_package_fields = (
    "Package/version",
    "Source and owner",
    "Material/use type",
    "Licence and evidence",
    "Attribution/modification/redistribution obligations",
    "Included in HTML/PDF",
    "Compliance status",
    "Installed status",
)
for field in required_package_fields:
    if field not in inventory:
        raise SystemExit(f"package licence inventory is missing field: {field}")

locked = set(re.findall(r'^name = "([^"\\]+)"\nversion = "([^"\\]+)"', lock, re.M))
locked.discard(("jj-book-build", "0.1.0"))
package_rows = set(
    (name, version)
    for name, version in re.findall(r'^\| ([^ |]+) ([0-9][^ |]*) \|', inventory, re.M)
)
if locked != package_rows:
    missing = sorted(locked - package_rows)
    extra = sorted(package_rows - locked)
    raise SystemExit(f"package licence inventory mismatch; missing={missing}, extra={extra}")

for required in ("research/license-package-inventory.md", "LICENSES/Apache-2.0.txt", "research/licenses.md"):
    if required not in notices and required != "research/licenses.md":
        raise SystemExit(f"third-party notices do not point to {required}")

print(f"licence records valid: {len(locked)} locked distributions and all required source fields")
