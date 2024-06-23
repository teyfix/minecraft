#!/usr/bin/env bash

set -euo pipefail

# Ensure necessary environment variables are set
: "${RCON_HOST:?Environment variable RCON_HOST is required}"
: "${RCON_PORT:?Environment variable RCON_PORT is required}"
: "${RCON_PASSWORD:?Environment variable RCON_PASSWORD is required}"

# Path to the oplist file
OPLIST_FILE="${OPLIST_FILE:-/rcon-updater/oplist.txt}"
SLEEP_TIME="${SLEEP_TIME:-60}"

while true; do
  # Check if oplist.txt exists
  if [[ ! -f "$OPLIST_FILE" ]]; then
    echo "Error: File $OPLIST_FILE does not exist."
    exit 1
  fi

  # Loop through each line in oplist.txt and update the operator list
  while IFS= read -r op; do
    if [[ -n "$op" ]]; then
      echo "Adding operator: $op"

      if ! echo "op $op" | rcon-cli --host="$RCON_HOST" --port="$RCON_PORT" --password="$RCON_PASSWORD"; then
        echo "Failed to add operator: $op" >&2
      fi
    fi
  done <"$OPLIST_FILE"

  # Keep the script running indefinitely
  echo "Script completed. Sleeping for $SLEEP_TIME second(s)..."
  sleep "$SLEEP_TIME"
done
