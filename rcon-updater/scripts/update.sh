#!/usr/bin/env bash

set -euo pipefail

main() {
  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  find "$script_dir" -maxdepth 1 -type f -name "*.sh" ! -name "$(basename "$0")" | while read -r script; do
    echo "Executing script: $script"
    source "$script" || echo "Script $script failed" >&2
  done
}

main
wait
