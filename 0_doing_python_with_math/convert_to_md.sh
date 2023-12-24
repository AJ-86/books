#!/bin/bash

# Loop through all HTML files in the HTML directory
for file in *.html; do
    # Set the output filename by replacing '.html' with '.md'
    outfile="$(basename "$file" .html).md"
    
    # Convert the file
    pandoc "$file" -o "$outfile"
    
    echo "Converted $file to $outfile"
done
