#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    exit 1
fi

# Check if the path exists
if [ ! -e "$1" ]; then
    echo "Error: The specified path does not exist."
    exit 1
fi

# If argument is a file
if [ -f "$1" ]; then
    echo "File analysis for: $1"
    wc "$1"

# If argument is a directory
elif [ -d "$1" ]; then
    echo "Directory analysis for: $1"
    total_files=$(find "$1" -type f | wc -l)
    txt_files=$(find "$1" -type f -name "*.txt" | wc -l)

    echo "Total files: $total_files"
    echo "Text (.txt) files: $txt_files"
else
    echo "Error: Unsupported file type."
fi
