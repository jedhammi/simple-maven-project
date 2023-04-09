#!/bin/bash

# Add changes to staging area
git add .

# Prompt user to enter commit message
read -p "Enter commit message: " commit_message

# Commit changes with the entered commit message
git commit -m "$commit_message"

# Push changes to remote repository
git push

