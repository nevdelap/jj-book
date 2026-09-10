# Research sources

This is the source trail for the manuscript. Official jj documentation is the normative external source; the installed jj 0.45.1 CLI and its help output are the normative syntax source.

## Official Jujutsu documentation

The following pages are consulted and paraphrased rather than copied:

* Jujutsu documentation home — https://docs.jj-vcs.dev/latest/
* Git comparison — https://docs.jj-vcs.dev/latest/git-comparison/
* Git experts guide — https://docs.jj-vcs.dev/latest/git-comparison/
* Git compatibility — https://docs.jj-vcs.dev/latest/git-compatibility/
* Git compatibility source — https://github.com/jj-vcs/jj/blob/main/docs/git-compatibility.md
* Bookmarks — https://docs.jj-vcs.dev/latest/bookmarks/
* Revsets — https://docs.jj-vcs.dev/latest/revsets/
* Filesets — https://docs.jj-vcs.dev/latest/filesets/
* Templates — https://docs.jj-vcs.dev/latest/templates/
* Configuration — https://docs.jj-vcs.dev/latest/config/
* GitHub — https://docs.jj-vcs.dev/latest/github/
* Gerrit — https://docs.jj-vcs.dev/latest/gerrit/
* Conflicts — https://docs.jj-vcs.dev/latest/conflicts/
* Operation log — https://docs.jj-vcs.dev/latest/operation-log/
* Workspaces — https://docs.jj-vcs.dev/latest/workspaces/
* Sparse working copies — https://docs.jj-vcs.dev/latest/sparse-patterns/
* Signing — https://docs.jj-vcs.dev/latest/signing/
* Shell completion — https://docs.jj-vcs.dev/latest/shell-completion/
* Installation — https://docs.jj-vcs.dev/latest/install-and-setup/
* CLI reference — https://docs.jj-vcs.dev/latest/cli-reference/
* Release notes — https://github.com/jj-vcs/jj/releases
* Source repository and tests — https://github.com/jj-vcs/jj
* Jujutsu software licence — https://github.com/jj-vcs/jj/blob/main/LICENSE
* Jujutsu image licence — https://github.com/jj-vcs/jj/blob/main/docs/images/LICENSE
* Licensing ledger for this book — `research/licenses.md`

## Local evidence

The scripts capture `jj version`, `jj help`, `jj help --help`, and recursive command help for jj 0.45.1. Fixture repositories validate DAG rewrites, revsets, bookmarks, Git transport, conflicts, workspaces, sparse patterns, operation recovery, and colocated Git use.

## Page/version notes

The `docs.jj-vcs.dev/latest/` site was consulted on 2026-09-06. Its home page exposes separate links for the latest released documentation and unreleased `main` documentation; the current site is therefore treated as a research source, not as the 0.45.1 syntax authority. The jj 0.45.1 CLI help snapshot in this repository is the release-specific source for command names, flags, defaults, and signatures.

Topics extracted include the DAG/working-copy model, Git comparison and compatibility, bookmarks/remotes, revset operators/functions/patterns/aliases, fileset paths/operators/aliases, template objects/operators/methods/aliases/colours, configuration layers/schema, GitHub and Gerrit transport, conflicts, operation DAG/recovery, workspaces, sparse patterns, signing, completion, architecture, concurrency, and release practice.

## Version note

The documentation site is a moving target and may describe the current main branch. The version matrix therefore takes precedence for release-specific claims. In particular, the book never uses an unlabelled command or option merely because it appears in `latest` docs.
