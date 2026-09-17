#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J=${JJ_BIN:-"$ROOT/.toolchain/bin/jj"}
FIX="$ROOT/build/validation/evolog"
rm -rf "$FIX"
mkdir -p "$FIX"
export JJ_CONFIG="$FIX/config.toml"
printf '%s\n' \
  "user.name = 'Evolog Validator'" \
  "user.email = 'evolog@example.test'" \
  "ui.editor = 'true'" > "$JJ_CONFIG"

repo="$FIX/repo"
"$J" git init --colocate "$repo" >/dev/null
cd "$repo"
printf 'one\n' > api.txt
"$J" describe -m 'API: initial contract' >/dev/null
change=$("$J" log -r @ --no-graph -T 'change_id ++ "\n"')
c0=$("$J" log -r @ --no-graph -T 'commit_id ++ "\n"')

printf 'two\n' > api.txt
"$J" describe -m 'API: second contract' >/dev/null
c1=$("$J" log -r @ --no-graph -T 'commit_id ++ "\n"')
printf 'three\n' > api.txt
"$J" describe -m 'API: third contract' >/dev/null
c2=$("$J" log -r @ --no-graph -T 'commit_id ++ "\n"')

"$J" new -m 'Tests: cover API' >/dev/null
printf 'test\n' > test.txt
"$J" status >/dev/null
child=$("$J" log -r @ --no-graph -T 'change_id ++ "\n"')

"$J" edit "$change" >/dev/null
printf 'four\n' > api.txt
"$J" describe -m 'API: fourth contract' >/dev/null
c3=$("$J" log -r @ --no-graph -T 'commit_id ++ "\n"')

test -n "$change" -a -n "$c0" -a -n "$c1" -a -n "$c2" -a -n "$c3" -a -n "$child"
test "$c0" != "$c1"
test "$c1" != "$c2"
test "$c2" != "$c3"

normal=$("$J" evolog -G -r "$change" -T 'commit.commit_id() ++ "\n"')
reversed=$("$J" evolog --reversed -G -r "$change" -T 'commit.commit_id() ++ "\n"')
multiline=$("$J" evolog -G -r "$change" -T \
  'commit.commit_id() ++ " " ++
   commit.change_id() ++ " " ++
   operation.id() ++ " " ++
   commit.description().first_line() ++ "\n"')
test -n "$multiline"
test "$(printf '%s\n' "$normal" | tail -n 1)" = "$(printf '%s\n' "$reversed" | head -n 1)"
test "$(printf '%s\n' "$normal" | head -n 1)" = "$c3"
test "$(printf '%s\n' "$normal" | wc -l)" -ge 4
test "$(printf '%s\n' "$("$J" evolog -G -r "$change" -n 2 -T 'commit.commit_id() ++ "\n"')" | wc -l)" -eq 2
"$J" evolog -G -r "$change" -p --name-only | grep -F 'api.txt' >/dev/null
test "$(printf '%s\n' "$("$J" evolog -G -r "$child" -T 'commit.commit_id() ++ "\n"')" | wc -l)" -ge 2

# Create two successor operations from one common operation head, then
# integrate both. This exercises the divergent-change path used in the book.
base_op=$("$J" op log -n 1 --no-graph -T 'id')
op1=$("$J" describe -m 'successor one' --no-integrate-operation 2>&1 |
  sed -n 's/.*requested: \([^ ]*\).*/\1/p')
op2=$("$J" --at-op "$base_op" describe -m 'successor two' --no-integrate-operation 2>&1 |
  sed -n 's/.*requested: \([^ ]*\).*/\1/p')
test -n "$op1" -a -n "$op2" -a "$op1" != "$op2"
"$J" op integrate "$op1" >/dev/null
"$J" op integrate "$op2" >/dev/null
divergent=$("$J" log -r 'divergent()' --no-graph -T 'change_id ++ "\n"')
test "$(printf '%s\n' "$divergent" | sed '/^$/d' | wc -l)" -ge 2
"$J" evolog -G -r 'divergent()' >/dev/null
divergent_change=$(printf '%s\n' "$divergent" | sed '/^$/d' | head -n 1)
test -n "$divergent_change"
test -n "$("$J" log -r "$divergent_change/0" --no-graph -T 'commit_id')"
test -n "$("$J" log -r "$divergent_change/1" --no-graph -T 'commit_id')"

# Reader-facing shell examples must remain copy/pasteable. In particular,
# -T must have its template on the same shell command, and a change offset
# must be applied to a bare change-ID symbol rather than change_id(...).
if rg -n -U --pcre2 '(?m)-T\s*\n\s*[^<\n]' "$ROOT/src/book.html"; then
  echo "reader-facing template option is split across shell lines" >&2
  exit 1
fi
if rg -n 'change_id\([^\n]*\)/[0-9]+' "$ROOT/src/book.html"; then
  echo "reader-facing change offset is incorrectly appended to change_id()" >&2
  exit 1
fi
if rg -n 'if\(current_working_copy\(\)|working_copies\(\)\.map' "$ROOT/src/book.html"; then
  echo "reader-facing template uses a nonexistent unqualified template function" >&2
  exit 1
fi
json_output=$("$J" log --color=never --no-pager -r @ -T '"{\"commit_id\": " ++ json(commit_id) ++ ", \"change_id\": " ++ json(change_id) ++ ", \"description\": " ++ json(description) ++ ", \"empty\": " ++ json(empty) ++ ", \"conflict\": " ++ json(conflict) ++ "}\n"')
grep -F '"commit_id": "' <<<"$json_output" >/dev/null

printf '%s\n' "evolog validation passed for $("$J" version)"
