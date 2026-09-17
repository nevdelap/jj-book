# Review issue: `jj evolog` needs dedicated comprehensive coverage

Reviewed author revision:

```text
jj change/revision: xpopuppvykyrspnunuvzqnvwuyyrolyo
Git commit:         1d7daa1aeefbf06b3ff1d9762db305bd2aea4bf9
Description:        Record review reports and audit findings
```

ID: EVO45-M-001
Severity: MAJOR
Area: Evolution history, recovery, Gerrit/Git comparison, advanced-reader workflow
File: `src/book.html`
Section: Part II mental model; Part XI operation log and recovery; Part XV `jj evolog` reference; Part XVII workflows; Appendices G and J

Claim or issue: The book mentions and demonstrates `jj evolog`, and the CLI
entry correctly lists its main 0.45.1 options. However, it does not yet give
`jj evolog` its own comprehensive treatment as the primary tool for answering:

> How has this logical change changed over time?

The current material is distributed across identity explanations, short
experiments, divergence notes, recovery material, and Gerrit prose. The command
entry itself is a compact reference entry, not a lifecycle chapter. This is
particularly insufficient for the intended reader, who already uses Gerrit
patch-set history and Git reflog as practical historical evidence.

Evidence: Existing material includes:

- `src/book.html:466-480` — change/commit identity and a brief divergence model;
- `src/book.html:522-532` — a short describe/evolution experiment;
- `src/book.html:569-575` — a short divergence query sequence;
- `src/book.html:4861-4870` — the command entry and option list;
- `src/book.html:2744-2797` — Gerrit patch-stack lifecycle;
- `src/book.html:8189` — a compact Git reflog comparison.

These passages establish the vocabulary, but they do not walk through a
single persistent change across a realistic sequence such as:

```text
initial change
description/content amendment
ancestor rebase
descendant rebase
conflict-producing rewrite
conflict resolution
divergence from independent operations
convergence/selection or abandonment
publication as a new Git commit/patch set
```

The installed jj 0.45.1 help makes the missing reader-facing surface explicit:

```text
jj evolog [OPTIONS]
  -r, --revisions REVSETS
  -n, --limit LIMIT
  --reversed
  -G, --no-graph
  -T, --template TEMPLATE
  -p, --patch
```

In particular, `-p/--patch` shows the inter-diff between successive versions,
and jj warns that the previous version may be temporarily rebased to the new
version's parents so that unrelated parent changes do not contaminate the
comparison. The book lists `-p` but does not teach this important behavior or
show how it answers the “what changed between review iterations?” question.

Why it matters: A Git expert will naturally ask whether `evolog` is the jj
equivalent of a reflog, Gerrit's patch-set history, `git log --reflog`, or a
commit range. The current book says these are different, but does not provide
the concrete historical workflow needed to make the distinction operational.
Without that treatment, one of jj's most important explanations of mutable
change identity remains easy to understand abstractly but difficult to use
during review, incident analysis, or recovery.

Required fix: Add a dedicated, prominently named section or chapter such as
“Evolution history: following one change through time”. It should stand in the
contents as its own subsection, not only as an entry in the alphabetical CLI
reference. It should include, at minimum:

1. A precise model of change evolution versus commit objects, bookmarks,
   operation records, remote Git commits, and Gerrit Change-Ids.
2. One reusable fixture repository with a named logical change and recorded
   full commit/change IDs at every stage.
3. A before/operation/after table for each rewrite, showing the commit DAG,
   change ID, commit ID, parent IDs, description, bookmark target, and
   operation ID.
4. A worked `jj evolog -r CHANGE` example in normal and `--reversed` order,
   including `-n`, `-G`, and a useful `-T` template.
5. A worked `jj evolog -p` example showing the inter-diff between two
   successive versions, including the parent-rebase caveat from target help.
6. A divergence case where two successors of one change are visible, showing
   how to inspect, compare, select, converge, duplicate, or abandon them
   without treating the change ID as a unique commit.
7. A recovery case showing how `evolog` is combined with `jj op log`,
   `jj op show`, `jj op diff`, `jj undo`, and operation restore/revert. Explain
   which questions each history answers and which evidence each cannot recover.
8. A direct crosswalk to Git reflog and Gerrit patch sets:

   | Question | jj evidence | Git evidence | Gerrit evidence |
   |---|---|---|---|
   | How did this logical change evolve locally? | `jj evolog` | no direct equivalent | not applicable |
   | Which repository-wide operation caused it? | `jj op log/show/diff` | reflog/related logs | server audit, if available |
   | Which exported object was reviewed? | commit ID and bookmark | commit/ref history | patch set and Gerrit `Change-Id` |
   | What changed between two versions? | `jj evolog -p` or explicit comparison | commit/range diff | patch-set comparison |

9. Explicitly show what transfers through Git publication and what does not:
   commit IDs and refs can travel; jj operation history and complete evolution
   metadata do not become Gerrit history automatically.
10. A practical incident exercise: “The reviewer mentions patch set 4, the
    local bookmark now points at commit 5, and an old CI result names commit 2.”
    The reader should use `evolog`, operation history, exported IDs, and the
    Gerrit footer to reconstruct the mapping.

Suggested validation: Add an executable disposable fixture that creates at
least three successive versions of one change, a descendant rewrite, and a
divergent successor. Assert the expected evolution entries and `-p` comparison
against full IDs. Capture the output used in the book, then validate all
displayed templates and IDs against jj 0.45.1. Build the PDF and verify the new
section appears in the contents and has readable graph/code layout.

Acceptance condition: An advanced Git/Gerrit user can answer “what happened to
this change, what did each version contain, which repository operation caused
the change, and which Gerrit patch set or exported Git commit corresponds to
it?” using the book alone, without being redirected to installed help or
companion research.
