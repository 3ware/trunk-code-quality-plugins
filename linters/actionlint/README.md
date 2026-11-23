# actionlint

Overrides the upstream trunk `actionlint` definition to use
[kjanat/actionlint](https://github.com/kjanat/actionlint) - a maintained fork of
the stale [rhysd/actionlint](https://github.com/rhysd/actionlint).

This override can be reduced once
[trunk-io/plugins#1181](https://github.com/trunk-io/plugins/pull/1181) is merged
and the trunk plugin `ref` is bumped. At that point, remove the `downloads` and
`tools` sections and keep only the `lint` customisations below.

## Customisations

- `shellcheck` is installed alongside `actionlint` so that scripts in `run:`
  steps are checked.
- `SHELLCHECK_OPTS=--enable=all` is set because actionlint runs shellcheck with
  `--norc` - so `.shellcheckrc` is ignored.
