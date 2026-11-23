# jsonvet

Custom linter definition for [jsonvet](https://pypi.org/project/jsonvet/), which
verifies that `.json` files are valid JSON5.

JSON files with comments (for example `tsconfig.json` or `.vscode/*.json`) fail
the standard `check-json` pre-commit hook - so `jsonvet` is used instead.

The linter reports a single pass or fail result per file.
