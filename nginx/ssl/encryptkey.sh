#!/bin/bash

prompt_file_location() {
    read -ep "Enter the file location to encrypt: " file_path
    if [ -z "$file_path" ]; then
        echo "File location cannot be empty. Exiting."
        exit 1
    fi
    file_location="$file_path"
}

# Check if file location is provided as an argument
if [ -z "$1" ]; then
    prompt_file_location
else
    file_location=$1
fi

# Ensure the provided file exists
if [ ! -f "$file_location" ]; then
    echo "The file '$file_location' does not exist. Exiting."
    exit 1
fi

# Extract the output file name by adding the .enc extension
output_file="${file_location}.enc"

# Execute the OpenSSL command to encrypt the file
openssl aes-256-cbc -e -in "$file_location" -iter 1000 -a -out "$output_file"

echo "Encryption complete. The encrypted file has been saved to '$output_file'."
