#!/usr/bin/env bash
set -euo pipefail

# This is deliberately a small black-box experiment rather than a prose-only
# assertion. It documents the 0.44 Git-backend boundary that is easy to miss:
# a jj snapshot is already a Git object, but need not be reachable from Git's
# ordinary HEAD/branch refs.
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
J="${JJ_BIN:-$ROOT/.toolchain/bin/jj}"
BASE="$ROOT/build/validation/git-backend"
STAMP="$(date +%s%N)"
COLOCATED="$BASE/colocated-$STAMP"
NONCOLOCATED="$BASE/non-colocated-$STAMP"
DEFAULT_INIT="$BASE/default-init-$STAMP"
CONFIG_FALSE="$BASE/config-false-$STAMP.toml"
SAME_PATH="$BASE/same-path-$STAMP"
EXTERNAL_BACKING="$BASE/external-backing-$STAMP"
EXTERNAL_DEST="$BASE/external-dest-$STAMP"
mkdir -p "$COLOCATED" "$NONCOLOCATED"

# Verify the normative default independently of the explicit-colocation lab.
mkdir -p "$DEFAULT_INIT"
(cd "$DEFAULT_INIT" && JJ_CONFIG=/dev/null "$J" git init >/dev/null)
test -d "$DEFAULT_INIT/.git"
printf '%s\n' '[git]' 'colocate = false' > "$CONFIG_FALSE"
(cd "$BASE" && JJ_CONFIG="$CONFIG_FALSE" "$J" git init "$(basename "$NONCOLOCATED")-config" >/dev/null)
test ! -e "$BASE/${NONCOLOCATED##*/}-config/.git"
test -d "$BASE/${NONCOLOCATED##*/}-config/.jj/repo"

git -c init.defaultBranch=main init "$COLOCATED" >/dev/null
git -C "$COLOCATED" config user.name "jj validation"
git -C "$COLOCATED" config user.email "jj-validation@example.invalid"
printf '%s\n' base > "$COLOCATED/note"
git -C "$COLOCATED" add note
git -C "$COLOCATED" commit -m base >/dev/null
(cd "$COLOCATED" && "$J" git init --colocate >/dev/null)

printf '%s\n' jj-snapshot >> "$COLOCATED/note"
(cd "$COLOCATED" && "$J" status >/dev/null)
JJ_COMMIT=$(cd "$COLOCATED" && "$J" log --no-graph -r @ -T 'commit_id')
test "$(git -C "$COLOCATED" cat-file -t "$JJ_COMMIT")" = commit
test "$(git -C "$COLOCATED" symbolic-ref HEAD)" = refs/heads/main
RAW=$(git -C "$COLOCATED" cat-file -p "$JJ_COMMIT")
grep -q '^change-id ' <<<"$RAW"

# The snapshot is not exported to main, so ordinary Git HEAD does not reach
# the new object. Git may expose a jj retention ref; that is not a publication
# bookmark and its spelling/lifetime is intentionally not part of the contract.
HEAD_COMMIT=$(git -C "$COLOCATED" rev-parse HEAD)
test "$HEAD_COMMIT" != "$JJ_COMMIT"
git -C "$COLOCATED" log --oneline >/dev/null
git -C "$COLOCATED" log --all --oneline >/dev/null
git -C "$COLOCATED" show-ref >/dev/null
if git -C "$COLOCATED" log --format='%H' | grep -qx "$JJ_COMMIT"; then
    echo "jj snapshot unexpectedly became reachable from Git HEAD" >&2
    exit 1
fi

# jj snapshots the worktree independently of the Git index. The exact status
# letter is Git-version/index-state dependent; the command must remain usable.
git -C "$COLOCATED" status --short >/dev/null

# A named jj bookmark is the deliberate publication boundary. Export makes
# the corresponding Git ref visible; it does not change the jj workspace symbol.
(cd "$COLOCATED" && "$J" bookmark create review -r @ >/dev/null)
(cd "$COLOCATED" && "$J" git export >/dev/null)
test "$(git -C "$COLOCATED" rev-parse refs/heads/review)" = "$JJ_COMMIT"
test "$(git -C "$COLOCATED" symbolic-ref HEAD)" = refs/heads/main

# In a non-colocated repository the Git backend is under .jj/repo; top-level
# Git commands therefore have no ordinary .git directory to operate on.
(cd "$NONCOLOCATED" && "$J" git init --no-colocate >/dev/null)
test ! -e "$NONCOLOCATED/.git"
test -d "$NONCOLOCATED/.jj/repo"
(cd "$NONCOLOCATED" && "$J" status >/dev/null)

# --git-repo has a same-path exception. An existing Git repository used as
# the jj destination is colocated; an existing Git repository at a different
# path produces a non-colocated jj workspace whose Git directory is external.
git -c init.defaultBranch=main init "$SAME_PATH" >/dev/null
(cd "$SAME_PATH" && "$J" git init --git-repo "$SAME_PATH" "$SAME_PATH" >/dev/null)
test -d "$SAME_PATH/.git"
test -d "$SAME_PATH/.jj"
git -c init.defaultBranch=main init "$EXTERNAL_BACKING" >/dev/null
(cd "$BASE" && "$J" git init --git-repo "$EXTERNAL_BACKING" "$EXTERNAL_DEST" >/dev/null)
test ! -e "$EXTERNAL_DEST/.git"
test -d "$EXTERNAL_DEST/.jj"
test "$("$J" -R "$EXTERNAL_DEST" git root)" = "$EXTERNAL_BACKING/.git"
git --git-dir="$EXTERNAL_BACKING/.git" show-ref >/dev/null

echo "Git backend validation valid: jj 0.44 snapshot object=$JJ_COMMIT; HEAD=$HEAD_COMMIT; change-id header present; colocated export and non-colocated layout verified"
