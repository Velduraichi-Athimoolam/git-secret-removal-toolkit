#!/bin/bash

FILE_PATH="path/to/sensitive_file.ps1"

BRANCHES=(
  "feature-a"
  "feature-b"
  "main"
)

delete_file_from_branch() {
  local BRANCH=$1
  echo "Processing branch: $BRANCH"

  git fetch origin $BRANCH
  git checkout $BRANCH || git checkout -b $BRANCH origin/$BRANCH
  git pull origin $BRANCH

  git filter-repo --path "$FILE_PATH" --invert-paths --force
  git push origin $BRANCH --force
}

for BRANCH in "${BRANCHES[@]}"; do
  delete_file_from_branch "$BRANCH"
done
