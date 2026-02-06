#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Error: Please provide a text file."
    exit 1
fi

file="$1"

if [ ! -f "$file" ]; then
    echo "Error: File not found."
    exit 1
fi

words=$(tr -c 'A-Za-z' '\n' < "$file" | tr 'A-Z' 'a-z' | grep -v '^$')

echo "$words" | grep -E '^[aeiou]+$' > vowels.txt
echo "$words" | grep -E '^[^aeiou]+$' > consonants.txt
echo "$words" | grep -E '^[^aeiou][a-z]*[aeiou][a-z]*$' > mixed.txt

echo "Pattern extraction completed."
