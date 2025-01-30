#!/bin/bash

# Get the absolute path of the repository
REPO_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# Determine which rc file to use based on OS and shell
if [ -f "$HOME/.zshrc" ]; then
    RC_FILE="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    RC_FILE="$HOME/.bashrc"
else
    RC_FILE="$HOME/.profile"
fi

# Add repository path to rc file if not already present
EXPORT_PATH="export PATH=\"$REPO_PATH:\$PATH\""

if ! grep -q "export PATH=\"$REPO_PATH:" "$RC_FILE" 2>/dev/null; then
    echo "" >> "$RC_FILE"
    echo "# Added by docker-stack installer" >> "$RC_FILE"
    echo "$EXPORT_PATH" >> "$RC_FILE"
    echo "Docker stack path added to $RC_FILE"
else
    echo "Docker stack path already exists in $RC_FILE"
fi

# Make docker-stack executable
chmod +x "$REPO_PATH/docker-stack"

echo "Installation completed!"
echo "You can now use 'docker-stack' command from anywhere"
echo "Note: You may need to restart your terminal or run 'source $RC_FILE' for changes to take effect" 