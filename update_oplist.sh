#!/bin/bash

# Loop through each line in oplist.txt and update the operator list
while read op; do
  mcrcon -H $RCON_HOST -P $RCON_PORT -p $RCON_PASSWORD "op $op"
done </oplist.txt
