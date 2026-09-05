# Pinned toolchain checksums

Generated: 2026-09-06 UTC by `scripts/write-completeness-report.sh`.

| Binary | Version | SHA-256 | Provisioning/verification |
|---|---|---|---|
| `.toolchain/bin/jj` | 0.44.0 | acab2e0f7f9e8ade7ade6b58ef6ad1195d575e544dd7cfe308cdbe740f7d6e2b | `just setup`; version assertion and `cargo install --locked jj-cli --version 0.44.0` |
| `.toolchain/jj-0.45/bin/jj` | 0.45.1 | 2de6e388037b80ac7e1770e9538c97fbb70056700429b1061d35c17bfa7ee1b5 | `just setup-045`; version assertion and `cargo install --locked jj-cli --version 0.45.1` |

The comparison binary is a required part of the two-release inventory pass;
the comparison recipe fails if it cannot provision or verify it. These hashes
identify the local executables used to generate the corresponding help
captures and inventories; they are not a substitute for verifying the
upstream package provenance.
