#!/usr/bin/env bash

set -euo pipefail

# Ensure necessary environment variables are set
: "${OPLIST:?Environment variable OPLIST is required}"
: "${RCON_HOST:?Environment variable RCON_HOST is required}"
: "${RCON_PASSWORD:?Environment variable RCON_PASSWORD is required}"
: "${RCON_PORT:?Environment variable RCON_PORT is required}"
: "${SLEEP_TIME:-60}"

while true; do
  # Split the OPLIST environment variable into an array
  IFS=',' read -r -a ops <<< "$OPLIST"

  # Loop through each operator in the array and update the operator list
  for op in "${ops[@]}"; do
    if [[ -n "$op" ]]; then
      echo "op $op" | rcon-cli --host="$RCON_HOST" --port="$RCON_PORT" --password="$RCON_PASSWORD" || echo "Failed to update operator list for $op" >&2
    fi
  done

  # Keep the script running indefinitely
  echo "Script completed. Sleeping for $SLEEP_TIME second(s)..."
  sleep "$SLEEP_TIME"
done
