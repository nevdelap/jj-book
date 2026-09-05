# Row-level provenance inventory

This ledger covers external sources and shipped generated/copy-like material.
The authored book is original prose and diagrams; sources below informed
technical claims and are paraphrased. “Final inclusion” distinguishes the
source from material actually embedded in the HTML/PDF distribution.

| ID | Source URL/repository | Owner/author | Version/date consulted | Material/use | Licence/terms source | Attribution/modification/redistribution obligation | Final inclusion | Status |
|---|---|---|---|---|---|---|---|---|
| JJ-DOC | https://docs.jj-vcs.dev/latest/ | jj-vcs contributors | latest site, consulted 2026-09-06; release syntax verified locally | Graph model, Git comparison, bookmarks, revsets, filesets, templates, config, workflows, conflicts, operations, workspaces, signing, completion | Jujutsu project licence: https://github.com/jj-vcs/jj/blob/main/LICENSE; paraphrase only | Preserve source link when redistributing this research/book; no long quotation or modified source text claimed | Links and original paraphrase in HTML; no page copied | compliant by design |
| JJ-CLI-044 | local `.toolchain/bin/jj`, version 0.44.0 | Jujutsu project | `jj version` and recursive help captured 2026-09-06 | Command names, options, defaults, revset/fileset/template help | Apache 2.0, source URL above | Retain Apache notice for generated captures; generated output is labelled/versioned | Raw captures/inventories in research; short syntax in HTML | notice included |
| JJ-CLI-045 | local `.toolchain/jj-0.45/bin/jj`, version 0.45.1 | Jujutsu project | `jj version` and recursive help captured 2026-09-06 | Comparison-only command/options/revset/config notes | Apache 2.0, source URL above | Retain Apache notice; label 0.45.1 and do not present as 0.44 | Raw captures/inventory and labelled HTML notes | notice included |
| JJ-SOURCE | https://github.com/jj-vcs/jj | Jujutsu contributors | repository consulted 2026-09-06 | Architecture/source/tests used to resolve behaviour where docs were ambiguous | Apache 2.0, repository LICENSE | No source code copied into book; retain link | Not embedded; research source only | compliant |
| GIT-DOC | https://git-scm.com/docs | Git contributors | consulted 2026-09-06 | Git object/ref/interoperability background | File-specific Git documentation terms; no text copied | Link and paraphrase; no screenshots/assets | Original explanation and URL only | compliant by design |
| GH-DOC | https://docs.github.com/ | GitHub | consulted 2026-09-06 | PR/ref/server boundary and `gh` workflow context | GitHub terms/policy: https://docs.github.com/en/site-policy/github-terms/github-terms-of-service | No logo/screenshot/long quotation; service claims marked server-dependent | Original prose and links only | compliant by design |
| GERRIT-DOC | https://gerrit-review.googlesource.com/Documentation/ | Gerrit project | consulted 2026-09-06 | `refs/for`, Change-Id, topics, patch-set/upload context | Gerrit licence page: https://gerrit-review.googlesource.com/Documentation/licenses.html | No branding asset or long quotation; server-dependent claims labelled | Original prose and links only | compliant by design |
| JJ-IMG | https://github.com/jj-vcs/jj/blob/main/docs/images/LICENSE | J. Jennings/Lucas Garron where applicable | checked 2026-09-06 | Logo/favicon licence reviewed | CC BY 4.0 | Attribution required if used | Not included | no action |
| PY-BUILD | https://pypi.org/project/xhtml2pdf/ and https://pypi.org/project/pypdf/ | respective package maintainers | locked versions in `uv.lock` | Build-time renderer/parser only | Package metadata/licences in uv environment | No package code copied; dependencies are not embedded in PDF | Not included in book content; declared build dependencies | recorded |
| FONTS | system fonts, no bundled URL | system/distribution providers | renderer environment | CSS font family fallback only | Provider terms apply to local system fonts | No font redistributed by this project | Not bundled; PDF uses renderer environment | documented |

## Page-level source map for substantive chapters

The broad JJ-DOC row above is supplemented here so a redistributor can trace a
claim to the page that supplied the terminology or behaviour. All use in the
HTML is paraphrase, original explanation, or a short command example; no page
is reproduced as a chapter.

| Chapter area | Exact source page | Version/branch | Use type | Licence/notice treatment | Status |
|---|---|---|---|---|---|
| Graph model and Git comparison | https://docs.jj-vcs.dev/latest/git-comparison/ | latest site consulted 2026-09-06; syntax checked 0.44.0 | terminology and conceptual comparison | paraphrase; source link retained | compliant |
| Bookmarks/publication | https://docs.jj-vcs.dev/latest/bookmarks/ | latest site; local commands 0.44.0/0.45.1 | ref/tracking semantics | paraphrase and original diagrams | compliant |
| Revsets | https://docs.jj-vcs.dev/latest/revsets/ | latest site; local help normative for target releases | language concepts and examples | no copied tables/passages; source link retained | compliant |
| Filesets | https://docs.jj-vcs.dev/latest/filesets/ | latest site; local help normative for target releases | path grammar and aliases | original tree examples; no copied prose | compliant |
| Templates | https://docs.jj-vcs.dev/latest/templates/ | latest site; local help normative for target releases | type/method model and formatting | original examples; no copied source | compliant |
| Configuration | https://docs.jj-vcs.dev/latest/config/ | latest site; schemas captured for 0.44.0/0.45.1 | layering, keys, migration | paraphrase; schema captures carry Apache notice where applicable | compliant |
| Git compatibility | https://docs.jj-vcs.dev/latest/git-compatibility/ | latest site; local Git 2.53 fixture | colocation/import/export | original interoperability procedure | compliant |
| GitHub workflow | https://docs.jj-vcs.dev/latest/github/ | latest site; server claims marked dependent | host/ref boundary and workflow context | no GitHub assets or screenshots | compliant |
| Gerrit workflow | https://docs.jj-vcs.dev/latest/gerrit/ | latest site; local Git transport fixture | upload/ref context | no Gerrit assets; server claims marked dependent | compliant |
| Conflicts | https://docs.jj-vcs.dev/latest/conflicts/ | latest site; local 0.44 conflict fixture | stored conflict model | original diagrams and procedures | compliant |
| Operation log | https://docs.jj-vcs.dev/latest/operation-log/ | latest site; local operation fixtures | operation/recovery semantics | original exercises; no copied prose | compliant |
| Workspaces/sparse | https://docs.jj-vcs.dev/latest/workspaces/ and https://docs.jj-vcs.dev/latest/sparse-patterns/ | latest site; local 0.44 fixture | workspace and materialisation semantics | original scenarios | compliant |
| Signing/completion/install | https://docs.jj-vcs.dev/latest/signing/, https://docs.jj-vcs.dev/latest/shell-completion/, https://docs.jj-vcs.dev/latest/install-and-setup/ | latest site; command surface checked locally | Linux field procedures | paraphrase; no external assets | compliant |

## Distribution mapping

The HTML and PDF distribution carries the original-book CC BY notice through
`THIRD_PARTY_NOTICES` and the linked project licence. The research directory is
distributed with the Apache notice for generated Jujutsu captures. No image,
font, logo, JavaScript library, screenshot, or long quotation is embedded in
the final book artefacts. If a future edition adds such material, it must add a
new row here before publication.
