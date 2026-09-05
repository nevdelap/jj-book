# Command audit

## Method

The normative binary was `.toolchain/bin/jj` 0.44.0. I ran its `jj version`, `jj help`, and `jj help --help`, then independently ran `scripts/inventory-cli.sh` into a disposable `/tmp` directory. The independent inventory captured 46 top-level commands and 120 canonical command paths. The comparison binary reports jj 0.45.1 and its stored inventory contains the 0.45-only `converge` and other deltas.

## Results

- The target version policy is explicit and the raw 0.44.0/0.45.1 help snapshots are useful evidence.
- The reader-facing CLI has 121 command articles, but exact canonical-path comparison found the seven `jj operation ...` paths missing: `abandon`, `diff`, `integrate`, `log`, `restore`, `revert`, and `show`. They are represented under the `op` alias. This is not equivalent to proving canonical reference coverage unless the reference explicitly maps aliases to canonical names.
- `jj converge` is included as a clearly marked 0.45.x entry and is not itself a 0.44 defect.
- The option reference is intentionally compact and explicitly delegates authoritative defaults/options to raw help. That fails the stated reader-facing exhaustive-reference requirement for important commands.

## Required follow-up

Add canonical/alias/version columns to the inventory comparison, add reader-facing entries for every canonical path or an explicit canonical-to-alias mapping, and verify important options and state effects from 0.44 help. Do not count a raw help snapshot or a grouped table as explanatory coverage.

## Reproducible commands

```bash
.toolchain/bin/jj version
.toolchain/bin/jj help
.toolchain/bin/jj help --help
TMP_REVIEW=$(mktemp -d /tmp/jj-review-inventory.XXXXXX)
JJ_BIN="$PWD/.toolchain/bin/jj" bash scripts/inventory-cli.sh \
  "$TMP_REVIEW/command-inventory.md" "$TMP_REVIEW/cli-help.txt"
```

