#!/bin/bash

# Prompt the user to enter a directory path
read -p "Enter the directory path to compress: " dir_path

# Check if the entered directory exists
if [ ! -d "$dir_path" ]; then
    echo "The directory does not exist. Please enter a valid directory path."
    exit 1
fi

# Get the current date in YYYY-MM-DD format
current_date=$(date +"%Y-%m-%d")

# Extract the directory name from the path
dir_name=$(basename "$dir_path")

# Create the name for the compressed file
backup_file="backup_${dir_name}_${current_date}.tar.gz"

# Compress the directory into a .tar.gz file
tar -czf "$backup_file" -C "$(dirname "$dir_path")" "$dir_name"

# Inform the user that the compression is complete
echo "The directory has been compressed into the file: $backup_file"


