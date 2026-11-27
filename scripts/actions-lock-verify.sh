#!/usr/bin/env bash

# Check for any GitHub Action workflow changes. If none, exit early.
# Otherwise, install the GitHub CLI gh-actions-lock extension (if missing or not the pinned version)
# and verify the actions lock file.

set -euo pipefail

if git diff --cached --quiet -- .github/workflows/ ':(glob)**/action.yml' ':(glob)**/action.yaml'; then
	exit 0
fi

read -r version <.github/gh-actions-lock.version
installed=$(gh extension list | awk -F'\t' '$2 == "github/gh-actions-lock" {print $3}')

if [[ ${installed} != "${version}" ]]; then
	if [[ -n ${installed} ]]; then
		gh extension remove actions-lock
	fi
	# --upgrade would upgrade to latest and ignore --pin, so remove and reinstall instead
	gh extension install github/gh-actions-lock --pin "${version}"
fi

gh actions-lock --verify-local --no-fix
