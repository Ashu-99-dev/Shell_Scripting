#!/bin/bash

# Check if a file was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <textfile>"
    exit 1
fi
# Define the input file
input_file="$1"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "The file '$input_file' does not exist."
    exit 1
fi

# Count lines, words, and characters
line_count=$(wc -l < "$input_file")
word_count=$(wc -w < "$input_file")
char_count=$(wc -m < "$input_file")

# Find the longest word
longest_word=$(tr -c '[:alnum:]' '[\n*]' < "$input_file" | awk '{ if (length > max) { max = length; word = $0 } } END { print word }')

# Display results
echo "File: $input_file"
echo "Number of lines: $line_count"
echo "Number of words: $word_count"
echo "Number of characters: $char_count"
echo "Longest word: $longest_word"
