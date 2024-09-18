#!/bin/bash

# Define the backup directory path
BACKUP_DIR="$C/Users/Ashutosh/backup"

# Create the backup directory if it does not exist
mkdir -p "$BACKUP_DIR"

# Get the current date and time
CURRENT_DATE_TIME=$(date +"%Y-%m-%d_%H-%M-%S")

# Loop through all .txt files in the current directory
for file in *.txt; do
    if [[ -f $file ]]; then
        # Define the new filename with date and time appended
        BASE_NAME=$(basename "$file" .txt)
        NEW_FILE_NAME="${BASE_NAME}_${CURRENT_DATE_TIME}.txt"

        # Copy the file to the backup directory with the new name
        cp "$file" "$BACKUP_DIR/$NEW_FILE_NAME"
    fi
done

echo "Backup completed successfully."
