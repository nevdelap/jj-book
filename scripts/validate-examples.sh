#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J=${JJ_BIN:-"$ROOT/.toolchain/bin/jj"}
G=${GIT_BIN:-git}
FIX="$ROOT/build/validation"
rm -rf "$FIX"; mkdir -p "$FIX"
printf '%s\n' "user.name = 'Validation User'" "user.email = 'validation@example.test'" "ui.editor = 'true'" > "$FIX/config.toml"
export JJ_CONFIG="$FIX/config.toml"
run() { echo "+ $*"; "$@"; }
repo="$FIX/repo"
run "$G" init "$repo"
run "$G" -C "$repo" config user.name "Validation User"
run "$G" -C "$repo" config user.email "validation@example.test"
printf 'initial\n' > "$repo/README"
run "$G" -C "$repo" add README
run "$G" -C "$repo" commit -m initial
run "$J" git init --colocate "$repo"; cd "$repo"
run "$J" describe -m root
printf 'one\n' > one.txt; run "$J" new -m one
printf 'two\n' > two.txt; run "$J" new -m two
run "$J" bookmark create main -r @-
run "$J" log -r 'all()' --no-graph >/dev/null
run "$J" log -r 'description(exact:"one")' --no-graph >/dev/null
run "$J" diff -r 'main..@'; run "$J" file list; run "$J" status
run "$J" op log --no-graph >/dev/null; run "$J" undo; run "$J" redo
run "$J" edit @-
printf 'three\n' > three.txt
run "$J" squash --into @ -- 'glob:*.txt'
run "$J" split -r @ -m 'split selection' -- 'glob:one.txt'
run "$G" -C "$repo" status --short; run "$G" -C "$repo" show-ref >/dev/null
bare="$FIX/remote.git"; run "$G" init --bare "$bare"
run "$J" git remote add origin "file://$bare"
run "$J" git push --bookmark main --remote origin
local_main=$("$J" log -r main --no-graph -T 'commit_id')
git_main=$("$G" --git-dir "$bare" rev-parse refs/heads/main)
test "$local_main" = "$git_main"
run "$J" git push --remote origin --named review=@-
review_commit=$("$J" log -r review --no-graph -T 'commit_id')
git_review=$("$G" --git-dir "$bare" rev-parse refs/heads/review)
test "$review_commit" = "$git_review"
run "$J" git push --remote origin --change main --dry-run
run "$J" git fetch --remote origin
remote_main=$("$J" log -r main@origin --no-graph -T 'commit_id')
test "$remote_main" = "$git_main"
run "$J" bookmark track main --remote origin
run "$J" bookmark list
echo "validation passed for $("$J" version)"
