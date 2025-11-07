#!/bin/sh
set -eu

# The path to the temporary commit message file is the first argument
COMMIT_MSG_FILE=$1

# 1. Get the current branch name (or HEAD if detached)
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

# 2. Clean up the branch name (replace slashes/non-alphanumeric with hyphens)
#    e.g., "feature/new-login" becomes "feature-new-login"
CLEAN_BRANCH_NAME=$(echo "$BRANCH_NAME" | sed 's/[^a-zA-Z0-9_-]/-/g')

# 3. Check if the branch name is already present (now checking for the "name:" format)
# We check if the line starts with the branch name followed by a colon and a space.
if ! grep -q "^$CLEAN_BRANCH_NAME: " "$COMMIT_MSG_FILE"; then
    # Prepend the formatted branch name to the first line of the commit message file
    # The formatting string is changed from "[...]" to "...: "
    sed -i.bak "1s/^/$CLEAN_BRANCH_NAME: /" "$COMMIT_MSG_FILE"
fi

exit 0
