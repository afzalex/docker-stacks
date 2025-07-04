#!/bin/bash

# Installer for post-commit hook with force push support (normal + submodule aware)

REMOTE_NAME="auto"

# Determine actual .git folder (for submodules too)
GIT_DIR=$(git rev-parse --git-dir 2>/dev/null)

if [ ! $? -eq 0 ]; then
  echo "❌ Not inside a Git repository or submodule."
  exit 1
fi

HOOK_PATH="$GIT_DIR/hooks/post-commit"

echo "📍 Detected Git directory: $GIT_DIR"

# Check if remote exists
REMOTE_URL=$(git remote get-url "$REMOTE_NAME" 2>/dev/null)

if [ -z "$REMOTE_URL" ]; then
  echo "⚠️  No remote named '$REMOTE_NAME' found."

  read -p "Enter the Git remote URL (e.g. http://localhost:3000/youruser/repo.git): " USER_REMOTE
  git remote add "$REMOTE_NAME" "$USER_REMOTE"
  echo "✅ Remote '$REMOTE_NAME' added: $USER_REMOTE"
else
  echo "✅ Remote '$REMOTE_NAME' already exists: $REMOTE_URL"
fi

# Write the post-commit hook
cat > "$HOOK_PATH" << EOF
#!/bin/bash
branch=\$(git symbolic-ref --short HEAD)
echo "--------------------------------"
echo "Running post-commit hook: Force pushing to '$REMOTE_NAME' (\$branch)..."
git push $REMOTE_NAME "\$branch" --force
echo "--------------------------------"
echo ""
echo ""
EOF

chmod +x "$HOOK_PATH"

echo "✅ Post-commit hook installed at: $HOOK_PATH"
