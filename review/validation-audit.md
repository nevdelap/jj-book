# Validation audit

## Executions

`BASH_ENV=/dev/null just validate` completed successfully for the 0.44.0 fixture scripts. The suite creates disposable repositories under `build/validation` and exercises colocated Git init, snapshots/new, log/diff/files/status, bookmark/push/fetch/tracking, undo/redo, representative revsets, templates, and basic workspaces.

## Limitations

- `validate-revsets.sh` sends query output to `/dev/null` and asserts only that expressions parse/run; it does not assert expected IDs or set membership.
- `validate-templates.sh` sends all rendered output to `/dev/null`; it does not assert field values, labels, JSON shape, or operation/workspace semantics.
- `validate-examples.sh` checks command success and only basic filesystem/ref command success; it does not assert exact DAG topology, bookmark targets, remote state, or descendant IDs.
- `validate-examples.sh` uses a fallback `squash` invocation with `||`, which can mask a failure in the documented first form.
- `validate-workspaces.sh` ignores `workspace update-stale` failure using `|| true`.
- The completeness report explicitly says conflict, sparse, fixer, signing, and interactive-TUI laboratories are not locally validated.

## Finding

**M-007 — semantic validation is insufficient.** Passing exit statuses did not catch the invalid language examples or the incorrect `heads()` arithmetic. The validation suite must assert meaning, not only parseability/success.

## Required outcome

Add fixture assertions for topology, IDs/change IDs, bookmark/remote targets, conflict state, operation transitions, workspace-local `@`, sparse materialization, and rendered template output. Isolate config and keep network-dependent behavior documentation-verified without live writes.

