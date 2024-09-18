#!/bin/bash

# Define file paths
packages_file="packages.txt"
log_file="installation.log"

# Check if the packages file exists
if [ ! -f "$packages_file" ]; then
    echo "The packages file '$packages_file' does not exist."
    exit 1
fi

# Create or clear the log file
> "$log_file"

# Function to install packages using apt
install_with_apt() {
    local package=$1
    echo "Installing $package using apt..."
    if sudo apt-get install -y "$package" >> "$log_file" 2>&1; then
        echo "Successfully installed $package" >> "$log_file"
    else
        echo "Failed to install $package" >> "$log_file"
    fi
}

# Function to install packages using yum
install_with_yum() {
    local package=$1
    echo "Installing $package using yum..."
    if sudo yum install -y "$package" >> "$log_file" 2>&1; then
        echo "Successfully installed $package" >> "$log_file"
    else
        echo "Failed to install $package" >> "$log_file"
    fi
}

# Detect the package manager and install packages
if command -v apt-get &> /dev/null; then
    # Using apt-get
    while IFS= read -r package; do
        # Skip empty lines and comments
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        install_with_apt "$package"
    done < "$packages_file"

elif command -v yum &> /dev/null; then
    # Using yum
    while IFS= read -r package; do
        # Skip empty lines and comments
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        install_with_yum "$package"
    done < "$packages_file"

else
    echo "Neither apt-get nor yum is available. Unable to install packages." | tee -a "$log_file"
    exit 1
fi

echo "Package installation process completed. Check '$log_file' for details."
