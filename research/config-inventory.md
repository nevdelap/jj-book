# Configuration inventory

The target-release machine-readable schema is captured with `jj util config-schema` as `config-schema-0.45.1.json`. The public configuration command surface in jj 0.45.1 is `edit`, `gc`, `get`, `list`, `path`, `set`, and `unset`.

Namespaces deliberately covered in the book are: `user`, `operation`, `ui`, `git`, `gerrit`, `revsets`, `revset-aliases`, `templates`, `template-aliases`, `fileset-aliases`, command aliases, `merge-tools`, `fix.tools`, `signing`, filesystem monitoring/snapshot settings, `run`, immutable-head configuration, and repository/workspace scope.

Use `jj config list --include-defaults` and the schema for exact key descriptions. A prose list is not a safe substitute for the versioned schema because configuration keys and defaults evolve more frequently than core graph semantics.
