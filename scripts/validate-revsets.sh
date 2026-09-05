#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J=${JJ_BIN:-"$ROOT/.toolchain/bin/jj"}
G=${GIT_BIN:-git}
FIX="$ROOT/build/validation/revsets"
rm -rf "$FIX"; mkdir -p "$FIX"
export JJ_CONFIG="$FIX/config.toml"
printf '%s\n' "user.name = 'Revset Validator'" "user.email = 'revset@example.test'" "ui.editor = 'true'" > "$JJ_CONFIG"
repo="$FIX/repo"
"$G" init "$repo" >/dev/null
"$G" -C "$repo" config user.name 'Revset Validator'
"$G" -C "$repo" config user.email 'revset@example.test'
printf 'root\n' > "$repo/README"; "$G" -C "$repo" add README; "$G" -C "$repo" commit -m root >/dev/null
"$J" git init --colocate "$repo" >/dev/null
cd "$repo"
"$J" describe -m root >/dev/null
printf 'a\n' > a; "$J" new -m A >/dev/null
printf 'b\n' > b; "$J" new -m B >/dev/null
base=$("$J" log -r 'description(substring:"A")' --no-graph -T 'commit_id ++ "\\n"')
printf 'c\n' > c; "$J" new -m C >/dev/null
printf 'd\n' > d; "$J" new -m D >/dev/null
test -n "$base"
"$J" log -r '::@' --no-graph >/dev/null
"$J" log -r 'ancestors(@) & mutable()' --no-graph >/dev/null
"$J" log -r 'heads(::@)' --no-graph >/dev/null
"$J" log -r 'roots(::@)' --no-graph >/dev/null
"$J" log -r 'description(substring:"C")' --no-graph >/dev/null
"$J" log -r 'description(regex:"^[A-D]$")' --no-graph >/dev/null
"$J" log -r 'empty() | conflicts()' --no-graph >/dev/null
"$J" log -r 'all() ~ hidden()' --no-graph >/dev/null
echo "revset validation passed for $($J version)"
