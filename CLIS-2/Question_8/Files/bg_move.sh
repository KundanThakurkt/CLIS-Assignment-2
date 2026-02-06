#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Error: Provide one directory path."
    exit 1
fi

dir="$1"

if [ ! -d "$dir" ]; then
    echo "Error: Invalid directory."
    exit 1
fi

mkdir -p "$dir/backup"

for file in "$dir"/*; do
    if [ -f "$file" ]; then
        mv "$file" "$dir/backup/" &
        echo "Moved $(basename "$file") with PID $!"
    fi
done

wait
echo "All background move operations completed."
