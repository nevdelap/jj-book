#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J=${JJ_BIN:-"$ROOT/.toolchain/bin/jj"}
R="$ROOT/build/validation/repo"

test -d "$R/.jj" || {
  echo "run scripts/validate-examples.sh first" >&2
  exit 1
}

run_template() {
  local name=$1
  shift
  echo "+ template $name"
  local output
  output=$("$J" -R "$R" --ignore-working-copy --no-pager --color=never "$@")
  test -n "$output"
  printf '%s\n' "$output"
}

run_template ids log -r 'all()' -T 'commit_id ++ " " ++ change_id ++ "\n"'
run_template subjects log -r 'all()' -T 'description.first_line() ++ "\n"'
run_template lists log -r 'all()' -T 'parents.map(|p| p.commit_id().short()).join(",") ++ "\n"'
run_template state log -r 'all()' -T 'if(conflict, "conflict", "clean") ++ " " ++ if(empty, "empty", "nonempty") ++ "\n"'
run_template json log -r 'all()' -T 'json(commit_id) ++ "\n"'
run_template operations op log -T 'id.short() ++ " " ++ description ++ "\n"'
run_template workspaces log -r 'working_copies()' -T 'working_copies.map(|w| w.name()).join(",") ++ "\n"'

test "$("$J" -R "$R" --ignore-working-copy --no-pager --color=never log --no-graph -r 'all()' -T 'commit_id ++ "\n"' | wc -l)" -ge 1
"$J" -R "$R" --ignore-working-copy --no-pager --color=never log --no-graph -r 'all()' -T 'json(commit_id) ++ "\n"' | grep -Eq '^"[^"]+"$'

echo "template validation passed for $("$J" version)"
