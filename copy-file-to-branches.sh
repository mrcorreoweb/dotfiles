#!/bin/bash
#===============================================================================
# Script: copy-file-to-branches.sh
# Description: This script copies a specified file from the active branch
#              to all other local and remote branches using `git restore`.
#
# Usage: ./copy-file-to-branches.sh <file-to-copy>
#        <file-to-copy>: The file that will be restored to all branches.
#
# Example: ./copy-file-to-branches.sh README.md
#          This will restore the README.md file from the active branch to all
#          other branches, commit, and push the changes to their respective remote branches.
#
#===============================================================================

if [ $# -ne 1 ]; then
  echo "Usage: $0 <file-to-restore>"
  exit 1
fi

file_to_restore=$1

# Ensure the file exists in the current branch
if [ ! -f "$file_to_restore" ]; then
  echo "Error: File $file_to_restore does not exist in the current branch."
  exit 1
fi

# Get the current branch name
source_branch=$(git branch --show-current)

# If not on any branch, exit the script
if [ -z "$source_branch" ]; then
  echo "Error: Not on any branch. Please run this script inside a Git repository."
  exit 1
fi

# Fetch all remote branches
git fetch --all

# Get a list of all branches excluding the current branch and HEAD
branches=$(git branch -a | grep -v "\*" | grep -v "HEAD" | sed 's/^[ \t]*//')

# Loop through each branch and perform operations
for branch in $branches; do
  # Get the local branch name
  if [[ "$branch" == remotes/* ]]; then
    local_branch=${branch#remotes/origin/}
  else
    local_branch=$branch
  fi

  # Skip the source branch
  if [ "$local_branch" == "$source_branch" ]; then
    continue
  fi

  echo "Switching to branch $local_branch..."
  
  # Check if the local branch exists; if not, create and track the remote branch
  if git show-ref --verify --quiet refs/heads/"$local_branch"; then
    git checkout "$local_branch"
  else
    git checkout -b "$local_branch" --track "$branch"
  fi

  # Restore the file from the source branch
  git restore --source="$source_branch" "$file_to_restore"

  # Check if the file has changed after the restore
  if ! git diff --quiet "$file_to_restore"; then
    echo "File $file_to_restore has changed. Committing and pushing changes."
    git add "$file_to_restore"
    git commit -m "Restored $file_to_restore from $source_branch"
    git push origin "$local_branch"
  else
    echo "File $file_to_restore is the same in branch $local_branch. Skipping commit."
  fi
done

# Switch back to the original branch
git checkout "$source_branch"
echo "Switched back to the original branch $source_branch."
