#!/usr/bin/env bash

set -euo pipefail

# Directory containing the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to execute or source a script
execute_script() {
  local script="$1"
  echo "Executing script: $script"
  
  if [[ -x "$script" ]]; then
    # If the script is executable, run it directly
    "$script" || echo "Script $script failed" >&2
  else
    # If the script is not executable, source it
    source "$script" || echo "Script $script failed" >&2
  fi
}

# Find all Bash scripts in the directory (excluding this script)
find "$SCRIPT_DIR" -maxdepth 1 -type f -name "*.sh" ! -name "$(basename "$0")" | while read -r script; do
  execute_script "$script"
done
