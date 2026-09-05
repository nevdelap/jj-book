#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J=${JJ_BIN:-"$ROOT/.toolchain/bin/jj"}; G=${GIT_BIN:-git}
FIX="$ROOT/build/validation/semantics"
rm -rf "$FIX"; mkdir -p "$FIX"
export JJ_CONFIG="$FIX/config.toml"
printf '%s\n' "user.name = 'Semantic Validator'" "user.email = 'semantic@example.test'" "ui.editor = 'true'" > "$JJ_CONFIG"
repo="$FIX/repo"; "$G" init "$repo" >/dev/null
"$G" -C "$repo" config user.name 'Semantic Validator'; "$G" -C "$repo" config user.email 'semantic@example.test'
printf 'root\n' > "$repo/README"; "$G" -C "$repo" add README; "$G" -C "$repo" commit -m root >/dev/null
"$J" git init --colocate "$repo" >/dev/null; cd "$repo"; "$J" describe -m root >/dev/null

new() { "$J" new -m "$1" >/dev/null; }
new A; new B; b_tip=$("$J" log -r 'subject(exact:"B")' --no-graph -T 'commit_id')
new C; c_tip=$("$J" log -r 'subject(exact:"C")' --no-graph -T 'commit_id')
"$J" new "$b_tip" -m D >/dev/null; d_tip=$("$J" log -r 'subject(exact:"D")' --no-graph -T 'commit_id')
"$J" new "$c_tip" "$d_tip" -m G >/dev/null; g_tip=$("$J" log -r 'subject(exact:"G")' --no-graph -T 'commit_id')

heads=$("$J" log -r "heads($b_tip::$g_tip)" --no-graph -T 'description.first_line() ++ "\n"')
test "$heads" = G
parents=$("$J" log -r "$g_tip" --no-graph -T 'parents.map(|p| p.commit_id().short()).join(",")')
test "$(tr ',' '\n' <<<"$parents" | wc -l)" -eq 2

"$J" bookmark set review -r "$g_tip" >/dev/null
bookmark=$("$J" log -r 'bookmarks()' --no-graph -T 'description.first_line() ++ "\n"')
grep -Fx G <<<"$bookmark" >/dev/null
before_change=$("$J" log -r "$g_tip" --no-graph -T 'change_id')
"$J" describe -r "$g_tip" -m 'G revised' >/dev/null
after_commit=$("$J" log -r 'subject(exact:"G revised")' --no-graph -T 'commit_id')
after_change=$("$J" log -r 'subject(exact:"G revised")' --no-graph -T 'change_id')
test "$before_change" = "$after_change"
test "$before_change" != "$after_commit"
"$J" log -r 'subject(exact:"G revised")' --no-graph -T 'commit_id ++ " " ++ change_id ++ " " ++ description.first_line() ++ "\n"' | grep -F 'G revised' >/dev/null
echo "semantic validation passed for $($J version)"
