#!/bin/bash

for entry in "$1"/*; do
    echo  $(basename "$entry")
    echo "<a href=\"./$(basename "$entry")/\">$(basename "$entry")/</a>"
done