#!/bin/bash

# Check for exactly two arguments
if [ "$#" -ne 2 ]; then
    echo "Error: Please provide exactly two directory paths."
    exit 1
fi

dirA="$1"
dirB="$2"

# Validate directories
if [ ! -d "$dirA" ] || [ ! -d "$dirB" ]; then
    echo "Error: One or both paths are not valid directories."
    exit 1
fi

echo "Files only in $dirA:"
echo "-------------------"
for file in "$dirA"/*; do
    name=$(basename "$file")
    if [ ! -f "$dirB/$name" ]; then
        echo "$name"
    fi
done

echo
echo "Files only in $dirB:"
echo "-------------------"
for file in "$dirB"/*; do
    name=$(basename "$file")
    if [ ! -f "$dirA/$name" ]; then
        echo "$name"
    fi
done

echo
echo "Common files comparison:"
echo "------------------------"
for file in "$dirA"/*; do
    name=$(basename "$file")
    if [ -f "$dirB/$name" ]; then
        if cmp -s "$dirA/$name" "$dirB/$name"; then
            echo "$name : MATCH"
        else
            echo "$name : DIFFER"
        fi
    fi
done
