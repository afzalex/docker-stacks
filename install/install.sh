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

elif [[ "$OSTYPE" == "msys" ]]; then
    # Git Bash for Windows
    echo "Installing for Git Bash (Windows)..."
    
    # Add repository path to .bashrc if not already present
    BASHRC_PATH="$HOME/.bashrc"
    EXPORT_PATH="export PATH=\"$REPO_PATH:\$PATH\""
    
    if ! grep -q "export PATH=\"$REPO_PATH:" "$BASHRC_PATH" 2>/dev/null; then
        echo "" >> "$BASHRC_PATH"
        echo "# Added by docker-stack installer" >> "$BASHRC_PATH"
        echo "$EXPORT_PATH" >> "$BASHRC_PATH"
        echo "Docker stack path added to .bashrc"
    else
        echo "Docker stack path already exists in .bashrc"
    fi
    
    # Source .bashrc to make changes take effect in current session
    source "$BASHRC_PATH"
fi

# Make docker-stack executable
chmod +x "$REPO_PATH/docker-stack"

echo "Installation completed!"
echo "You can now use 'docker-stack' command from anywhere"
if [[ "$OSTYPE" == "msys" ]]; then
    echo "Note: You may need to restart your Git Bash terminal or run 'source ~/.bashrc' for changes to take effect"
fi 