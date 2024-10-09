#!/bin/bash

# Variables
REPO_DIR="/mnt/c/Users/tarun/devops/python/CI_CD/Building-CI-CD-Pipeline-Tool"
GITHUB_REPO="https://github.com/Manjyyot/Building-CI-CD-Pipeline-Tool.git"  #GitHub repository

# Navigate to the repository directory
cd $REPO_DIR || { echo "Directory not found: $REPO_DIR"; exit 1; }

# Pull the latest changes from the GitHub repository
echo "Checking for updates in the repository..."
git pull $GITHUB_REPO

# Check if there were any changes made
if [ "$(git diff --stat HEAD@{1} HEAD)" != "" ]; then
    echo "New changes detected, restarting Nginx..."
    # Restart the Nginx service to apply the changes
    sudo systemctl restart nginx
    echo "Nginx has been restarted successfully."
else
    echo "No new changes to deploy."
fi
