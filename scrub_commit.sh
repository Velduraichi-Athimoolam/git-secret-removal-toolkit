#!/bin/bash

COMMIT_ID="<COMMIT_ID_HERE>"

BRANCHES=(
  "feature-1"
  "feature-2"
)

delete_commit_from_branch() {
  local BRANCH=$1
  echo "Processing branch: $BRANCH"

  git fetch origin $BRANCH
  git checkout $BRANCH || git checkout -b $BRANCH origin/$BRANCH
  git pull origin $BRANCH

  git filter-repo --force --commit-callback "
if commit.original_id == b\"$COMMIT_ID\":
    commit.skip()
"

  git push origin $BRANCH --force
}

for BRANCH in "${BRANCHES[@]}"; do
  delete_commit_from_branch "$BRANCH"
done
