# Licensing and attribution ledger

This book is an original technical work. It paraphrases behaviour, uses short command examples, and links to primary documentation. It does not reproduce long passages, screenshots, logos, or source files from the materials below. The diagrams and prose in `src/book.html` were written for this project. The row-level provenance inventory is `research/provenance.md`; it records owner, exact source/version, material/use, licence source, obligations, final inclusion, and status for each source/material class.

## Source materials

| Material | Licence/terms | Treatment in this book |
|---|---|---|
| Jujutsu source and documentation, `jj-vcs/jj` | Apache License 2.0; see [LICENSE](https://github.com/jj-vcs/jj/blob/main/LICENSE). The repository identifies Jujutsu as Apache-2.0 software. | Behaviour was researched and paraphrased. No Jujutsu logo or documentation image is redistributed. The normal name “Jujutsu”/`jj` is used descriptively. |
| Jujutsu logo/favicon | CC BY 4.0; see [docs/images/LICENSE](https://github.com/jj-vcs/jj/blob/main/docs/images/LICENSE). | Not included. |
| Git documentation | Git project documentation/licensing varies by file and distribution. | No Git documentation text or images copied; only original explanations and links to Git concepts. |
| GitHub documentation/service | GitHub documentation and service terms apply to their materials; see [GitHub Terms](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service). | GitHub behaviour is described in original prose, with links; no GitHub screenshots, logos, or copied documentation. |
| Gerrit documentation | Gerrit documentation is maintained by the Gerrit project; consult the [current documentation](https://gerrit-review.googlesource.com/Documentation/) and its repository notices for the page being used. | Gerrit protocol concepts are paraphrased; no Gerrit branding assets or long excerpts are included. |
| Rust crates used only to build validation binaries | Each crate retains its own licence and notices. | No crate source is embedded in the book; the installed binary is a validation tool, not book content. |
| PDF build dependencies (`xhtml2pdf`, `pypdf`) | Their package metadata and licences are retained in the locked `uv` environment. | Used only by `scripts/render-pdf.py` and `scripts/validate-pdf.py`; no package source is copied into the book or PDF. |
| Independent PDFium inspection dependency (`pypdfium2==5.13.0`) | Package metadata reports BSD-3-Clause/Apache-2.0 and dependent licence terms; see the package source and bundled notices. | Used only by `scripts/render-visual-samples.py` for independent acceptance rendering; its engine is not embedded in the book or PDF. |

## Distribution statement

The book's original prose, diagrams, CSS, scripts, and HTML are released by this project under **CC BY 4.0**; see `research/book-license.md`. That project licence does not relicense third-party materials. The complete Apache 2.0 text is distributed in `LICENSES/Apache-2.0.txt` for the Jujutsu-derived generated help/inventory material. When redistributing the HTML, retain this ledger, the source links, and the attribution notice; provide the third-party licences when redistributing any third-party material.

The HTML contains no third-party images, bundled fonts, JavaScript libraries, copied documentation blocks, or logo artwork. External links are references, not embedded content. This design keeps the Kindle Scribe PDF output clear of additional asset licences. Distribution notices are in `THIRD_PARTY_NOTICES` and the root `LICENSE`.

## Copyright caution

A fact, command name, or short command example is not treated as a substitute for copying a documentation work. Readers and redistributors remain responsible for checking the current licence and trademark terms of any source material they add later, including screenshots, quotations, or copied configuration tables.
