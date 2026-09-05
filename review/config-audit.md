# Configuration audit

## Baseline

The repository includes 0.44.0 and 0.45.1 config help/schema snapshots and a human configuration section. Local 0.44 help states that configuration layers load built-ins, user, repo, workspace, then command-line settings, with later values overriding earlier values.

## Finding

**M-006 — ineffective immutable-head example.** `src/book.html:2102-2107` presents:

```toml
[revsets]
immutable_heads = 'main@origin | tags() | root()'
```

The target configuration is the `revset-aliases."immutable_heads()"` alias. The book’s key is accepted as an arbitrary unknown setting but does not change the built-in `immutable_heads()` query. A direct experiment on the validation repository showed the wrong key still returned the default protected set, while the correctly named alias returned the configured result. This is safety-sensitive and is recorded as MAJOR.

## Other observations

- The configuration tutorial is substantially more developed than the initial skeleton, but still contains many “validate against schema/help” caveats instead of a complete human reference.
- `gerrit.*` version distinctions are called out; keep exact 0.44/0.45 schema evidence beside every key.
- TOML syntax examples should be parsed and then applied to an isolated config, not merely syntax-checked. Unknown keys and semantically inert keys are particularly important.

## Suggested validation

For every promoted config example: parse TOML, load it with `JJ_CONFIG`/`--config-file`, query the effective value, and exercise the behavior it is meant to control. Add precedence tests for user/repo/workspace/CLI layers, immutable heads, aliases, pager/editor, Git publication, Gerrit defaults, signing, fixers, and snapshot settings.

