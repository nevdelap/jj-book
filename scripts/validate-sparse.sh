#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J=${JJ_BIN:-"$ROOT/.toolchain/bin/jj"}; G=${GIT_BIN:-git}
FIX="$ROOT/build/validation/sparse"
rm -rf "$FIX"; mkdir -p "$FIX"
export JJ_CONFIG="$FIX/config.toml"
printf '%s\n' "user.name = 'Sparse Validator'" "user.email = 'sparse@example.test'" "ui.editor = 'true'" > "$JJ_CONFIG"
repo="$FIX/repo"; "$G" init "$repo" >/dev/null
"$G" -C "$repo" config user.name 'Sparse Validator'; "$G" -C "$repo" config user.email 'sparse@example.test'
mkdir -p "$repo/src" "$repo/tests"; printf 'source\n' > "$repo/src/main.rs"; printf 'test\n' > "$repo/tests/main.rs"
"$G" -C "$repo" add .; "$G" -C "$repo" commit -m root >/dev/null
"$J" git init --colocate "$repo" >/dev/null; cd "$repo"; "$J" describe -m root >/dev/null
"$J" sparse set --clear --add src >/dev/null
test -f src/main.rs; test ! -e tests/main.rs
"$J" sparse list | grep -F 'src' >/dev/null
"$J" sparse reset >/dev/null
test -f src/main.rs; test -f tests/main.rs
echo "sparse validation passed for $($J version)"
