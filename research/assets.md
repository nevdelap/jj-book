# Asset provenance and distribution register

This register covers every raster asset present in the repository, whether it
is embedded in the canonical HTML/PDF or retained as an unused source
candidate. It is separate from the text/source licence ledger because an image
has its own provenance and distribution question.

| Asset | SHA-256 | Source/creator and acquisition | Material used | Licence/permission evidence | Attribution | Modification notice | Redistribution conditions | Included in final HTML/PDF | Status and notes |
|---|---|---|---|---|---|---|---|---|---|
| `assets/cover.png` | `80b52af2c30c6e935e425cd0b1bd91d5c585ff42f308ca86a3c8a040809d0605` | Supplied by the project owner as the selected cover image; copied into the repository from the owner-provided file before the cover was composed. | The monochrome DAG illustration embedded by `src/book.html` and therefore present in the PDF cover. | Project-owner supplied material; the owner authorised its inclusion and redistribution with this book. The PNG metadata records OpenAI Media Service generation provenance; it is retained as evidence, not treated as a substitute for the owner’s permission. | Credit the project owner if the image is redistributed separately; no third-party creator attribution is asserted. | The image is embedded/laid out as part of the cover; adaptations should identify that the cover image was placed or resized. | May be redistributed as part of this book and its HTML/PDF under the project owner’s permission; do not imply endorsement by OpenAI or jj. | Yes | Pass for this project distribution. The image is not a Jujutsu logo or documentation image. |
| `assets/cover-dag.png` | `26c966a86f055127201976755f6370f1ed2e6c2ef80a74f557f758e5d6917a7c` | Earlier project-generated cover candidate retained in the source tree; no longer referenced by the canonical HTML. | None in the final book. | No independent third-party licence is asserted; it is retained only as an unused project candidate pending deletion or separate permission review. | N/A while undistributed. | N/A while undistributed. | Do not redistribute this unused candidate until its provenance is confirmed. | No | Excluded from the final HTML/PDF; retained only to make the exclusion explicit. |

## Audit method

The hashes above were calculated from the files in `assets/`. The canonical
HTML was searched for image references and the generated PDF was checked by
the print validation pipeline. No other image, logo, icon, bundled font, or
third-party screenshot is embedded in the final deliverables. If a future
edition changes the cover, replace the row rather than inheriting its
permission assumptions.
