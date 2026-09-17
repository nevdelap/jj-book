# Part XI history-structure issues

Reviewed author revision:

```text
jj change/revision: smukqzyvlvumzrlklsooyypzynvqrlnq
Git commit: d9636852a0259dcf2ef12159c0b9d71dcb9eb25e
Description: Refresh PDF build timestamp and acceptance records
```

## XI-M-001 — Part XI title omits change evolution

```text
ID: XI-M-001
Severity: MAJOR
Area: Book structure, contents, evolog coverage
File: src/book.html:76-77, 3242, 3260
Section: Part XI and Evolution history: following one change through time
Claim or issue: The Part XI title presents the part as being about operation logs, undo, and recovery, while a substantial first-class subject in the part is the evolution log and following one logical change through time.
Evidence: The contents calls Part XI “Operation log and recovery” and lists “Evolution history: following one change through time” beneath it. The Part heading says “Operation log, undo, and recovery”; the first substantial section then introduces jj evolog as a distinct evidence model.
Why it matters: The title understates a major subject and makes the reader approach evolog as an incidental subsection of operation-log recovery, despite the book's requirement for comprehensive coverage of change evolution and its distinction from operation history.
Required fix: Rename Part XI to include both operation history and change evolution, and make the contents entry identical. A suitable direction is “Operation history, change evolution, undo, and recovery.”
Suggested validation: Rebuild the HTML/PDF, verify the contents and Part heading match, and check that the resulting title accurately advertises both `jj op log` and `jj evolog` coverage.
```

## XI-M-002 — Operation history and change evolution lack parallel top-level sections

```text
ID: XI-M-002
Severity: MAJOR
Area: Book structure, ordering, conceptual navigation
File: src/book.html:3242-3722
Section: Part XI — Operation log, undo, and recovery
Claim or issue: Part XI does not give operation history and change evolution clearly separated sibling sections. Evolution is presented first as one named section, while operation-log material is split across multiple later “operation laboratory” sections, with correlation and recovery interleaved.
Evidence: `evolution-history-laboratory` begins at line 3259; later operation material begins at `operation-laboratory-undo-is-a-graph-operation` and is repeated/extended by `operation-depth-lab` and `operation-depth-laboratory`. The current hierarchy does not provide corresponding top-level sections such as “Operation log: repository-wide transformations” and “Evolution log: one logical change over time.”
Why it matters: The manuscript correctly teaches that the two histories answer different questions, but the chapter structure makes that distinction harder to discover and increases the risk that readers treat `jj evolog` as another operation-log view. It also weakens ordering: the operation model is introduced, deferred to a later laboratory, and then revisited, instead of being taught as one coherent subject alongside evolution history.
Required fix: Reorganize Part XI around explicit sibling sections, for example:

1. Operation log: repository-wide transformations.
2. Evolution log (`jj evolog`): one logical change over time.
3. Correlating operation history with change evolution.
4. Recovery laboratory.
5. Concurrency, retention, and cross-machine limits.

Preserve the technically useful material, but consolidate duplicate operation-laboratory material and cross-reference the two models deliberately.
Suggested validation: Inspect the generated contents and PDF outline for both named log sections; confirm that each section has its own model, commands, experiments, edge cases, and recovery implications, followed by an explicit correlation section.
```

These are structural findings; they do not claim that the prose currently gives the two logs identical semantics. The prose generally distinguishes them correctly, but the Part title and hierarchy do not communicate that distinction as clearly as the content requires.
