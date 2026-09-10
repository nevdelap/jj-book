# Revset inventory

Generated from the jj 0.45.1 installed help keyword pages. The source page is intentionally retained because signatures and edge-case prose are more authoritative than a lossy table.

## Operators captured in jj 0.45.1

`f(x)`, `x-`, `x+`, `p:x`, `x::`, `::x`, `x..`, `..x`, `x::y`, `x..y`, `::`, `..`, `~x`, `x & y`, `x ~ y`, and `x | y`, with parenthesised grouping and documented precedence.

## Function names captured in jj 0.45.1

The machine extraction is kept as a line-oriented list below. Functions with optional arguments retain their complete signature in the help snapshot.

* `all`, `none`, `root`, `heads`, `roots`, `visible_heads`, `immutable_heads`, `builtin_immutable_heads`
* `ancestors`, `descendants`, `connected`, `present`, `reachable`, `merges`, `empty`, `conflicted`, `mutable`, `immutable`, `divergent`
* `author`, `committer`, `author_date`, `committer_date`, `description`, `commit_id`, `change_id`
* `bookmarks`, `remote_bookmarks`, `tracked_remote_bookmarks`, `untracked_remote_bookmarks`, `tags`, `remote_tags`, `tracked_remote_tags`, `untracked_remote_tags`, `git_refs`
* `workspaces`, `working_copies`, `at_operation`, `evolution`
* `file`, `files`, `diff_contains`, `diff_lines_added`, `diff_lines_removed`
* configured alias functions and typed string/date pattern forms
