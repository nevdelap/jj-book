#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J=${JJ_BIN:-"$ROOT/.toolchain/bin/jj"}
G=${GIT_BIN:-git}
FIX="$ROOT/build/validation/workspaces"
rm -rf "$FIX"; mkdir -p "$FIX"
export JJ_CONFIG="$FIX/config.toml"
printf '%s\n' "user.name = 'Workspace Validator'" "user.email = 'workspace@example.test'" "ui.editor = 'true'" > "$JJ_CONFIG"
repo="$FIX/repo"; "$G" init "$repo" >/dev/null
"$G" -C "$repo" config user.name 'Workspace Validator'; "$G" -C "$repo" config user.email 'workspace@example.test'
printf 'root\n' > "$repo/README"; "$G" -C "$repo" add README; "$G" -C "$repo" commit -m root >/dev/null
"$J" git init --colocate "$repo" >/dev/null; cd "$repo"; "$J" describe -m root >/dev/null
printf 'source\n' > source; "$J" new -m source >/dev/null
"$J" workspace add --name build -r @ "../build-workspace" >/dev/null
"$J" workspace add --name review -r @ "../review-workspace" >/dev/null
"$J" workspace list >/dev/null
test -d "$FIX/build-workspace"; test -d "$FIX/review-workspace"
"$J" workspace root >/dev/null
"$J" workspace rename review-ci >/dev/null
names=$("$J" workspace list)
grep -F 'review-ci' <<<"$names" >/dev/null
"$J" workspace update-stale >/dev/null

# An external edit is a live, unrecorded filesystem change, not stale
# workspace metadata.  update-stale must leave it present and report that the
# recorded workspace checkout is not stale.
printf 'external edit\n' >> "$FIX/review-workspace/source"
external_status=$("$J" -R "$FIX/review-workspace" status)
grep -E 'M .*source' <<<"$external_status" >/dev/null
stale_attempt=$("$J" -R "$FIX/review-workspace" workspace update-stale 2>&1)
grep -F 'not stale' <<<"$stale_attempt" >/dev/null
grep -F 'external edit' "$FIX/review-workspace/source" >/dev/null
"$J" workspace forget build >/dev/null
names=$("$J" workspace list)
if grep -Fq 'build' <<<"$names"; then
  echo "forgotten workspace still listed" >&2
  exit 1
fi
echo "workspace validation passed for $($J version)"
