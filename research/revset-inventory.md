# Revset inventory

Generated from the installed help keyword pages. The 0.44.0 public surface is in `help-revsets-0.44.0.md`; 0.45.1 is in the corresponding versioned file. The source page is intentionally retained because signatures and edge-case prose are more authoritative than a lossy table.

## Operators captured in 0.44.0

`f(x)`, `x-`, `x+`, `p:x`, `x::`, `::x`, `x..`, `..x`, `x::y`, `x..y`, `::`, `..`, `~x`, `x & y`, `x ~ y`, and `x | y`, with parenthesised grouping and documented precedence.

## Function names captured in 0.44.0

The machine extraction is kept as a line-oriented list below. Functions with optional arguments retain their complete signature in the help snapshot.

* `all`, `none`, `root`, `heads`, `roots`, `visible_heads`, `immutable_heads`, `builtin_immutable_heads`
* `ancestors`, `descendants`, `connected`, `present`, `reachable`, `merges`, `empty`, `conflicted`, `mutable`, `immutable`, `divergent`
* `author`, `committer`, `author_date`, `committer_date`, `description`, `commit_id`, `change_id`
* `bookmarks`, `remote_bookmarks`, `tracked_remote_bookmarks`, `untracked_remote_bookmarks`, `tags`, `remote_tags`, `git_refs`
* `workspaces`, `working_copies`, `at_operation`, `evolution`
* `file`, `files`, `diff_contains`, `diff_lines_added`, `diff_lines_removed`
* configured alias functions and typed string/date pattern forms

## 0.45.1 additions

`tracked_remote_tags` and `untracked_remote_tags` are present in 0.45.1 and are used by its default immutable-head definition. See `discrepancies.md`.
