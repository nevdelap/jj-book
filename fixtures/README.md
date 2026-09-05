# Validation fixtures

The validation scripts create disposable repositories under `build/validation/` rather than storing large binary or Git object fixtures in the source tree. This keeps the HTML book reproducible and license-clean while still exercising real repositories.

* `validate-examples.sh` covers a colocated repository, snapshots, rewrites, bookmarks, a bare Git remote, and undo/redo.
* `validate-templates.sh` covers commit, operation, workspace, state, list, and JSON templates.
* `validate-revsets.sh` covers topology, state, description-pattern, and visibility queries.
* `validate-workspaces.sh` creates, lists, renames, updates, and forgets workspaces.

The fixture names used in the book—rewrite lab, query lab, fileset lab, GitHub/Gerrit transport lab, recovery lab, and workspace lab—are generated variants of these disposable scenarios. Run `just validate` to recreate them.
