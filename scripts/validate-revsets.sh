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
for expr in \
  'author_date(after:"2026-01-01")' \
  'committer_date(before:"2026-09-01")' \
  'author_date(after:"2024-02-01T12:00:00")' \
  'author_date(after:"2024-02-01T12:00:00-08:00")' \
  'author_date(after:"2024-02-01 12:00:00")' \
  'author_date(after:"2 days ago")' \
  'author_date(after:"yesterday")' \
  'author_date(after:"yesterday 5pm")' \
  'author_date(after:"yesterday 10:30")' \
  'author_date(after:"2026-08-01") & author_date(before:"2026-09-01")' \
  'author_date(after:"2026-08-01T00:00:00+00:00") & author_date(before:"2026-09-01T00:00:00+00:00")'; do
    "$J" log -r "$expr" --no-graph >/dev/null
done

# Directional reachability is easy to get wrong while replacing a local
# alias. Keep @ on an interior node of a mutable linear stack and assert the
# result sets, not merely that both expressions parse. The book's explicit
# spelling for the configured stack(x) policy is x:: & mutable().
"$J" edit 'description(substring:"A")' >/dev/null
descendants=$(
  "$J" log --no-graph --reversed \
    -r 'description(substring:"A"):: & mutable()' \
    -T 'description.first_line() ++ "\n"'
)
ancestors=$(
  "$J" log --no-graph --reversed \
    -r '::description(substring:"A") & mutable() & description(regex:"A")' \
    -T 'description.first_line() ++ "\n"'
)
heads=$(
  "$J" log --no-graph -r 'heads(description(substring:"A"):: & mutable())' \
    -T 'description.first_line() ++ "\n"'
)
roots=$(
  "$J" log --no-graph -r 'roots(description(substring:"A"):: & mutable())' \
    -T 'description.first_line() ++ "\n"'
)
test "$descendants" = $'A\nB\nC\nD'
test "$ancestors" = A
test "$heads" = D
test "$roots" = A
printf '%s\n' \
  'directional revset assertions:' \
  '  A:: & mutable()        => A B C D (cardinality 4; descendant stack)' \
  '  ::A & mutable()        => A     (cardinality 1; ancestor closure)' \
  '  heads(A:: & mutable()) => D' \
  '  roots(A:: & mutable()) => A'

# Source-level guardrails catch the two failure modes that a parse-only test
# cannot see: treating stack(@) as a builtin, and describing the ancestor
# operator as a descendant closure. Intentional ancestor queries remain
# legal; this audit only rejects the unambiguous stack-policy mistakes.
if bad_stack_source=$(rg -n \
  'stack\(@\)|::X &amp; mutable\(\)|descendant closure[^<]{0,160}::@|complete stack[^<]{0,160}::@' \
  "$ROOT/src/book.html"); then
  printf '%s\n' 'invalid standalone stack selection in src/book.html:' >&2
  printf '%s\n' "$bad_stack_source" >&2
  exit 1
fi
echo "revset validation passed for $($J version)"
