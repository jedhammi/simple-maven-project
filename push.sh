#!/bin/bash

# Add changes to staging area
git add .

# Commit changes with commit ID as commit message
commit_id=$(git rev-parse --short HEAD)
git commit -m "Changes with commit ID $commit_id"

# Push changes to remote repository
git push

