# Trunk Code Quality Plugins

[![GitHub release](https://img.shields.io/github/release/3ware/trunk-code-quality-plugins?include_prereleases=&sort=semver&color=green)](https://github.com/3ware/trunk-code-quality-plugins/releases/) [![issues - workflows](https://img.shields.io/github/issues/3ware/trunk-code-quality-plugins)](https://github.com/3ware/trunk-code-quality-plugins/issues) [![CI](https://img.shields.io/github/actions/workflow/status/3ware/trunk-code-quality-plugins/pr-check.yaml?label=CI&logo=githubactions&logoColor=white)](https://github.com/3ware/trunk-code-quality-plugins/actions/workflows/pr-check.yaml)

Shared [Trunk](https://docs.trunk.io/) configuration.

[Trunk Code Quality](https://docs.trunk.io/code-quality) is the standard
linting and formatting tool across 3ware repositories. This repository
provides the custom configuration required in addition to the upstream
[trunk-io/plugins](https://github.com/trunk-io/plugins), so all 3ware
repositories share a consistent set of linters, definitions and actions.

Per-repository overrides can still be made in the local `.trunk/trunk.yaml`.

## Configuration

See [plugin.yaml](../plugin.yaml) for the full configuration. In summary:

### Linters

actionlint, checkov, cspell, git-diff-check, jsonvet, markdownlint,
pre-commit-hooks, prettier, renovate, shellcheck, shfmt, trufflehog, yamllint
and zizmor.

pinact is disabled in favour of `gh actions-lock`.

### Custom definitions

- `actionlint` enables [shellcheck integration](https://github.com/rhysd/actionlint/blob/main/docs/checks.md#shellcheck-integration-for-run) enables all checks.
- `jsonvet` validates JSON5; replaces `check-json` pre-commit hook which does not allow comments.
- `zizmor` runs with the `pedantic` persona against workflows and
  `action.y*ml` files.

### Exported configs

These configs are shared with every consuming repository. Add a file with the
same name to a repository to override it.

- [actionlint.yaml](actionlint.yaml) and [zizmor.yaml](zizmor.yaml) are
  customised for 3ware.
- [.markdownlint.yaml](../configs/.markdownlint.yaml),
  [.shellcheckrc](../configs/.shellcheckrc) and
  [.yamllint.yaml](../configs/.yamllint.yaml) are the Trunk defaults, exported
  so consuming repositories do not need their own copies.

### Actions

- `actions-lock-verify` (pre-commit) verifies the GitHub Actions lock file
  when workflows or actions change.
- `trunk-check-pre-push`, `trunk-fmt-pre-commit` and
  `trunk-upgrade-available` are enabled.
- `trunk-announce` is disabled.

### Tools

- `gh`

## Requirements

- Trunk CLI `>=1.25.0`. The [Trunk VS Code extension](https://marketplace.visualstudio.com/items?itemName=Trunk.io), recommended in `.vscode/extensions.json`, installs the CLI.
- `gh` authenticated (`gh auth login`). The `actions-lock-verify` hook
  installs the `github/gh-actions-lock` extension on first use.
- A `.github/gh-actions-lock.version` file in the consuming repository
  containing the `gh-actions-lock` version to pin, for example `v0.4.0`.
  Without it the pre-commit hook fails whenever workflows or actions change.
- **Optional:** Set an environment variable for `ZIZMOR_GITHUB_TOKEN` to enable zizmor online mode. Add this to your shell profile:

  ```sh
  export ZIZMOR_GITHUB_TOKEN="$(gh auth token)"
  ```

  Avoid setting `GH_TOKEN` or `GITHUB_TOKEN` locally, because `gh` uses them
  for git authentication. Online mode always run in CI.

## Usage

Source this repository after `trunk-io/plugins` in `.trunk/trunk.yaml`.
Later sources override earlier ones.

```yaml
plugins:
  sources:
    - id: trunk
      ref: v1.11.0
      uri: https://github.com/trunk-io/plugins
    - id: 3ware
      ref: v1.0.0
      uri: https://github.com/3ware/trunk-code-quality-plugins

lint:
  # Add additional linters if required
  enabled:
    - hadolint@2.12.0
  # Disable a linter enabled by this plugin
  disabled:
    - cspell
```

## Maintenance

The [Trunk Upgrade](workflows/trunk-upgrade.yaml) workflow runs on the 1st of
each month and opens separate pull requests to update `plugin.yaml` and
`.trunk/trunk.yaml`.

Renovate keeps other dependencies up to date. Releases are created by
release-please.
