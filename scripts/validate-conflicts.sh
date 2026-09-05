#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J=${JJ_BIN:-"$ROOT/.toolchain/bin/jj"}; G=${GIT_BIN:-git}
FIX="$ROOT/build/validation/conflicts"
rm -rf "$FIX"; mkdir -p "$FIX"
export JJ_CONFIG="$FIX/config.toml"
printf '%s\n' "user.name = 'Conflict Validator'" "user.email = 'conflict@example.test'" "ui.editor = 'true'" > "$JJ_CONFIG"
repo="$FIX/repo"; "$G" init "$repo" >/dev/null
"$G" -C "$repo" config user.name 'Conflict Validator'
"$G" -C "$repo" config user.email 'conflict@example.test'
printf 'base\n' > "$repo/value.txt"; "$G" -C "$repo" add value.txt
"$G" -C "$repo" commit -m root >/dev/null
"$J" git init --colocate "$repo" >/dev/null
cd "$repo"; "$J" describe -m root >/dev/null
"$J" new -m branch-a >/dev/null
printf 'A\n' > value.txt; "$J" status >/dev/null
a=$("$J" log -r @ --no-graph -T 'commit_id')
"$J" new 'root()' -m branch-b >/dev/null
printf 'B\n' > value.txt; "$J" status >/dev/null
b=$("$J" log -r @ --no-graph -T 'commit_id')
"$J" new "$a" "$b" -m merge >/dev/null
conflicted=$("$J" log -r 'conflicts()' --no-graph -T 'description.first_line() ++ "\n"')
grep -Fx merge <<<"$conflicted" >/dev/null
grep -q '<<<<<<<' value.txt
printf 'resolved\n' > value.txt
"$J" status >/dev/null
remaining=$("$J" log -r 'conflicts()' --no-graph -T 'description.first_line() ++ "\n"')
test -z "$remaining"
test "$("$J" log -r @ --no-graph -T 'parents.len()')" -eq 2
echo "conflict validation passed"
