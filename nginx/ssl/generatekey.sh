#!/bin/sh

prompt_key_location() {
    read -ep "Enter the key location: " file_path
    if [ -z "$file_path" ]; then
        echo "Key location cannot be empty. Exiting."
        exit 1
    fi
    key_location="$file_path"
}


# Check if key location is provided as an argument
if [ -z "$1" ]; then
    prompt_key_location
else
    key_location=$1
fi

# Extract the output file name by removing the .enc extension
output_file="${key_location%.enc}"

# Execute the OpenSSL command with the provided or prompted key location
openssl aes-256-cbc -d -in "$key_location" -iter 1000 -a -out "$output_file"
