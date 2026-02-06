#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one input file."
    exit 1
fi

file="$1"

if [ ! -f "$file" ] || [ ! -r "$file" ]; then
    echo "Error: File does not exist or is not readable."
    exit 1
fi

words=$(tr -c 'A-Za-z' '\n' < "$file" | tr 'A-Z' 'a-z' | grep -v '^$')

longest=$(echo "$words" | awk '{ print length, $0 }' | sort -nr | head -1 | cut -d' ' -f2)
shortest=$(echo "$words" | awk '{ print length, $0 }' | sort -n | head -1 | cut -d' ' -f2)

avg=$(echo "$words" | awk '{ total+=length; count++ } END { if (count>0) print total/count }')

unique=$(echo "$words" | sort | uniq | wc -l)

echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average word length: $avg"
echo "Total unique words: $unique"
