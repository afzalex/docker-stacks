#!/bin/bash

# Get the absolute path of the repository
REPO_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# Create symbolic link to docker-stack in /usr/local/bin
if [[ "$OSTYPE" == "darwin"* ]]; then
    # MacOS
    echo "Installing for MacOS..."
    sudo ln -sf "$REPO_PATH/docker-stack" /usr/local/bin/docker-stack
    
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    echo "Installing for Linux..."
    sudo ln -sf "$REPO_PATH/docker-stack" /usr/local/bin/docker-stack
fi

# Make docker-stack executable
chmod +x "$REPO_PATH/docker-stack"

echo "Installation completed!"
echo "You can now use 'docker-stack' command from anywhere" 