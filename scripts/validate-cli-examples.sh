#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J=${JJ_BIN:-"$ROOT/.toolchain/bin/jj"}
G=${GIT_BIN:-git}
FIX=$(mktemp -d "${TMPDIR:-/tmp}/jj-cli-examples.XXXXXX")

fail=0
if rg -n "^jj fix -r|<pre[^>]*>[^<]*jj fix[^<]*--dry-run|^jj bisect --range|jj bisect run --revision|^jj bisect (log|reset)" "$ROOT/src/book.html"; then
  echo "invalid target-release command form remains in the HTML" >&2
  fail=1
fi
test "$fail" -eq 0

printf '%s\n' \
  "user.name = 'CLI Example Validator'" \
  "user.email = 'cli-example@example.test'" \
  "ui.editor = 'true'" \
  '[fix.tools.cat]' \
  'command = ["cat"]' \
  'patterns = ["glob:**/*.txt"]' > "$FIX/config.toml"
export JJ_CONFIG="$FIX/config.toml"

repo="$FIX/repo"
"$G" init -q "$repo"
"$G" -C "$repo" config user.name 'CLI Example Validator'
"$G" -C "$repo" config user.email 'cli-example@example.test'
printf 'root\n' > "$repo/README"
"$G" -C "$repo" add README
"$G" -C "$repo" commit -qm root
mkdir -p "$repo/src" "$repo/scripts"
printf 'TODO\n' > "$repo/src/example.txt"
printf '#!/bin/sh\n' > "$repo/scripts/check.sh"

"$J" git init --colocate "$repo" >/dev/null
cd "$repo"
"$J" describe -m root >/dev/null

"$J" file search -r @ --pattern TODO -- 'root-glob:src/**' | grep -F 'src/example.txt:TODO' >/dev/null
"$J" file chmod x -- 'root-file:scripts/check.sh' >/dev/null
"$J" fix -s @ -- 'root-glob:src/**' >/dev/null

"$J" new -m good >/dev/null
printf 'good\n' > src/example.txt
"$J" new -m bad >/dev/null
"$J" bisect run --range 'root()..@' -- sh -c 'exit 1' > "$FIX/bisect.log"
grep -F 'Search complete.' "$FIX/bisect.log" >/dev/null

echo "CLI example validation passed for $($J version)"
