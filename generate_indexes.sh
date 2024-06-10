#!/bin/bash

# Define the HTML header and footer
html_header='<!DOCTYPE html>
<html>
<head><title>Index of /</title></head>
<body>
<h1>Index of /</h1><hr><pre><a href="../">../</a>'

html_footer='</pre><hr></body>
</html>'

# Function to generate index.html for a given directory
generate_index() {
  local dir="$1"
  local index_file="$dir/index.html"

  # Write the header to the index.html file
  echo "$html_header" > "$index_file"

  # List all files and directories in the directory
  for entry in "$dir"/*; do
    if [[ -d "$entry" ]]; then
      # If it's a directory, append it with a trailing slash
      echo "<a href=\"$(basename "$entry")/\">$(basename "$entry")/</a>" >> "$index_file"
    else
      # If it's a file, append it without a trailing slash
      echo "<a href=\"$(basename "$entry")\">$(basename "$entry")</a>" >> "$index_file"
    fi
  done

  # Write the footer to the index.html file
  echo "$html_footer" >> "$index_file"
}

# Export the function so it can be used with 'find -exec'
export -f generate_index
export html_header
export html_footer

# Find all directories under the root directory and generate index.html in each
find "$(pwd)" \( -name ".*" -prune \) -o -type d -print -exec bash -c 'generate_index "$0"' {} \;
