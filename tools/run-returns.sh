#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT"

pandoc --lua-filter=tools/inspect-returns.lua \
    --from=markdown \
    --to=plain \
    /dev/null \
    -o /dev/null
