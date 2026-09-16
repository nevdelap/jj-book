# Superseded historical revset audit

> The current authoritative audit is [`current-revset-audit-3.md`](current-revset-audit-3.md).

# Current revset audit

## Result

**PASS**

The prior revset finding is closed in author revision
`xmnlpsusmvzmkxyzopwmmvouxwktosvy` / commit
`2ddb7adeca0f09a0a60f8ffc57db4aadef87b72d`.

The source now consistently uses `x:: & mutable()` for the configured
`stack(x)` descendant policy where a standalone expression is required. The
remaining `mutable() & ::@` forms are intentional ancestor-bounded queries,
and the source-level guard leaves those valid forms permitted.

The target help and an independent disposable fixture confirm the distinction:

```text
@:: & mutable()  => current commit and its mutable descendants
::@ & mutable()  => current commit and its mutable ancestors
```

The new validator asserts exact symbolic sets on an interior stack and checks
`heads()` and `roots()` results. It passes directly and through `just review`.
No additional revset issue was found in this delta.
