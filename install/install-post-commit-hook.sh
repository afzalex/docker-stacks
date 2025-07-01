#!/bin/bash

HOOK_PATH=".git/hooks/post-commit"
REMOTE_NAME="auto"

# Ensure we're inside a Git repo
if ! git rev-parse --is-inside-work-tree &> /dev/null; then
  echo "❌ Not inside a Git repository."
  exit 1
fi

# Check if any remote exists
REMOTE_URL=$(git remote get-url $REMOTE_NAME 2>/dev/null)

if [ -z "$REMOTE_URL" ]; then
  echo "⚠️  No remote named '$REMOTE_NAME' found."

  # Ask user for remote URL
  read -p "Enter the Git remote URL (e.g. http://localhost:3000/youruser/repo.git): " USER_REMOTE

  # Add the remote
  git remote add $REMOTE_NAME "$USER_REMOTE"

  echo "✅ Remote '$REMOTE_NAME' added: $USER_REMOTE"
else
  echo "✅ Remote '$REMOTE_NAME' already exists: $REMOTE_URL"
fi

# Write the post-commit hook
cat > "$HOOK_PATH" << EOF
#!/bin/bash
echo "--------------------------------"
branch=\$(git symbolic-ref --short HEAD)

echo "Running post-commit hook: Force pushing to '$REMOTE_NAME' (\$branch)..."

# Force push to $REMOTE_NAME
git push $REMOTE_NAME "\$branch" --force

echo "--------------------------------"
echo ""
EOF

# Make it executable
chmod +x "$HOOK_PATH"

echo "✅ Post-commit hook installed successfully. It will force-push to '$REMOTE_NAME' after each commit."
