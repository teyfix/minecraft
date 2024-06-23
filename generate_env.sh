#!/bin/bash

# Function to generate a secret
secret() {
  dd if=/dev/urandom bs=2 count=64 2>/dev/null | base64 -w 0 | sed 's/\W//g' | cut -c1-32
}

# Main function to replace "changeme!" with the generated secret
main() {
  while IFS= read -r line; do
    if [[ "$line" == *"changeme!"* ]]; then
      new_secret="$(secret)"
      line="${line//changeme!/$new_secret}"
    fi
    echo "$line"
  done < .example.env
}

# Run the main function
main | tee .env
