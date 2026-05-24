#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
    echo "Loop commit -a -m. Usage: $0 'commit message'"
    exit 1
fi

git submodule foreach "git add -A && git diff --cached --quiet || git commit -m '$1'"
