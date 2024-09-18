#!/bin/bash

# File containing the list of usernames
user_list="user_list.txt"

# File to store the usernames and generated passwords
credentials_file="credentials.txt"

# Clear the credentials file if it exists
> "$credentials_file"

# Function to generate a random password
generate_password() {
    # Generates a 12-character password with letters and numbers
    tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 12
}

# Simulated user creation in Git Bash
create_user() {
    username=$1
    echo "Simulating user creation for : $username in Git Bash"
}

# Read the usernames from the file
while IFS= read -r username
do
    # Check if the username is not empty
    if [[ -n "$username" ]]; then
        # Simulate user creation
        create_user "$username"

        # Generate a random password
        password=$(generate_password)

        # Append the username and password to the credentials file
        echo "Username: $username, Password: $password" >> "$credentials_file"
        
        echo "User : $username created with password : $password"
    fi
done < "$user_list"

echo "All users processed. Credentials saved in $credentials_file."
