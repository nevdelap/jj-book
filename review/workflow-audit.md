# Workflow audit

## Findings

- **M-009 — GitHub is too short for the requested lifecycle.** Part VII is about 810 prose words. It has useful branchless framing and publication-bookmark distinctions, but not enough stateful single-PR/stacked-PR lifecycle evidence, review iteration, early-stack rewrites, main movement, rejection, merge/close/replace, fork/upstream, or `gh` interaction detail.
- **M-010 — Gerrit is too short and server boundaries are not developed enough.** Part VIII is about 1,672 prose words. The jj Change ID versus Gerrit Change-Id distinction is correct and important, but the requested three-change/two-review/partial-landing/re-upload/recovery narrative is not fully demonstrated.
- **M-011 — conflicts, operations, and workspaces remain compact.** Parts IX–XI measure approximately 838, 1,869, and 171 prose words respectively. The text names the right concepts but does not supply the complete laboratories required by the brief.

## Technical spot checks

- `jj workspace rename build ci` fails against 0.44.0; the command accepts only `<NEW_WORKSPACE_NAME>` for the current workspace. This is M-005.
- `jj sparse edit 'root-glob:tests/**'` fails against 0.44.0; `sparse edit` opens an editor and accepts no fileset argument. This is M-004.
- The local validation scripts do not test the full workflows they claim: no live GitHub/Gerrit writes were attempted, appropriately, but local fixtures should assert each transport/ref transition and server-dependent claims should be documentation-verified.

## Required workflow shape

For each major workflow show start graph, local mutable graph, commands, commit/change/bookmark/remote state after each transition, review/upstream event, conflict/rejection branch, recovery, final state, and cleanup. Reuse the named fixtures from `research/expansion-plan.md` rather than resetting to anonymous linear examples.

