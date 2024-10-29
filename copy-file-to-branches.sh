#!/bin/bash

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

if [ -z "$source_branch" ]; then
  echo "Error: Not on any branch. Please run this script inside a Git repository."
  exit 1
fi

# Fetch all remote branches
git fetch --all

# Get a list of all branches excluding the current branch and HEAD, removing duplicates
branches=$(git branch -a | grep -v "\*" | grep -v "HEAD" | sed 's/^[ \t]*//' | sort -u)

visited_branches=()

for branch in $branches; do
  if [[ "$branch" == remotes/* ]]; then
    local_branch=${branch#remotes/origin/}
  else
    local_branch=$branch
  fi

  # Skip the source branch and duplicates
  if [ "$local_branch" == "$source_branch" ] || [[ " ${visited_branches[@]} " =~ " ${local_branch} " ]]; then
    continue
  fi

  visited_branches+=("$local_branch")

  echo "Switching to branch $local_branch..."

  if git show-ref --verify --quiet refs/heads/"$local_branch"; then
    git checkout "$local_branch"
  else
    git checkout -b "$local_branch" --track "$branch"
  fi

  git restore --source="$source_branch" "$file_to_restore"

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
