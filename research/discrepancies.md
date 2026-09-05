# 0.44.0 versus 0.45.1 discrepancies

Compared by recursive local help capture on 2026-09-06. 0.44.0 is the NixOS baseline; 0.45.1 is the newer comparison binary. This is a release-surface comparison, not a claim that every current-main documentation change belongs to 0.45.1.

| Area | 0.44.0 | 0.45.1 | Book decision |
|---|---|---|---|
| Command tree | No `converge` command. | Adds `jj converge`, with `-r/--revision` and `--no-interactive`, to resolve divergent changes. | The convergence discussion is marked 0.45.x; 0.44 guidance uses `evolog`, manual editing, and `undo`. |
| Config file targeting | `config edit/set/unset` target user/repo/workspace scopes. | Adds `--file PATH` to those subcommands. | Document as 0.45.x; 0.44 uses the scope flags and `--config-file` for loading an extra file. |
| Remote tag revsets | No `tracked_remote_tags()` or `untracked_remote_tags()`. | Adds both functions; default immutable heads include untracked remote tags. | Mark tag predicates and immutable-head default as version-sensitive. |
| Pager default | Official 0.44 config help says `less -FRX` on non-Windows. | Official 0.45.1 config help says `less -FRXK`. | Avoid hard-coding the default; the book recommends explicit `ui.pager` in configuration. |
| Gerrit settings | `jj gerrit upload` has remote/branch options and mentions repository settings in command help; the 0.44 config keyword page does not expose the newer dedicated section. | Documents `gerrit.default-remote`, `gerrit.default-remote-branch`, `gerrit.review-url`, and related Gerrit configuration. | 0.45.x callout for the documented config section; always pass `--remote`/`--remote-branch` when portability matters. |
| Templates/config display | Basic label discovery is documented. | Adds expanded guidance for default colour inspection and `config list --include-defaults --include-overridden`. | Treat as 0.45.x convenience; use `--color=debug` and local help on 0.44. |

No top-level command was removed in the recursive 0.45.1 help capture. Full raw snapshots and the generated command inventories are shipped beside this file.
