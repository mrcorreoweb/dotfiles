#!/bin/bash

#===============================================================================
# Script: copy-file-to-branches.sh
# Description: Copies a specified file from the current branch
#              to all other local and remote branches.
# Usage: ./copy-file-to-branches.sh <file-to-copy>
#===============================================================================

# Check if argument is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <file-to-copy>"
  exit 1
fi

file_to_copy=$1

# Ensure the file exists in the current branch
if [ ! -f "$file_to_copy" ]; then
  echo "Error: File $file_to_copy does not exist in the current branch."
  exit 1
fi

# Get the current branch name
current_branch=$(git branch --show-current)

if [ -z "$current_branch" ]; then
  echo "Error: Not on any branch. Please run this script inside a Git repository."
  exit 1
fi

# Fetch all remote branches
git fetch --all

# Get a list of all local branches excluding the current branch
branches=$(git branch | grep -v "\*" | sed 's/^[ \t]*//')

# Loop through each branch and copy the file
for branch in $branches; do
  echo "Switching to branch $branch..."
  git checkout "$branch"

  # Restore the file from the current branch
  git restore --source="$current_branch" "$file_to_copy"

  # Commit and push if the file has changed
  if ! git diff --quiet "$file_to_copy"; then
    echo "File $file_to_copy has changed. Committing and pushing changes."
    git add "$file_to_copy"
    git commit -m "Restored $file_to_copy from $current_branch"
    git push origin "$branch"
  else
    echo "File $file_to_copy is the same in branch $branch. Skipping commit."
  fi

done

# Switch back to the original branch
git checkout "$current_branch"
echo "Switched back to the original branch $current_branch."
