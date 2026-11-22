# trunk-code-quality-plugins

Shared [Trunk](https://docs.trunk.io/) configuration: enabled linters,
custom linter definitions and actions.

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
      ref: v0.1.0
      uri: https://github.com/3ware/trunk-code-quality-plugins
```

Trunk's upgrade action bumps `ref` when a new release is published.

## Kept in each repository

- `cli.version`
- `plugins.sources`
- `runtimes`
- `lint.ignore`
- Any linter version or setting that overrides the plugin

## Maintenance

Update pinned versions in `plugin.yaml` with:

```bash
trunk upgrade --apply-to=plugin.yaml
```

Releases are created by release-please from conventional commits.
