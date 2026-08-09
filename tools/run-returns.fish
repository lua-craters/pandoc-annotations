#!/usr/bin/env fish

set -l script_dir (dirname (status filename))
set -l project_dir (realpath "$script_dir/..")
set -l fixture "$project_dir/tests/fixtures/inspect-metadata.md"

pandoc \
    "$fixture" \
    --lua-filter="$project_dir/tools/inspect-returns.lua" \
    -o /dev/null
