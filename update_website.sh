#!/bin/bash

REPO_URL="https://github.com/Manjyyot/Building-CI-CD-Pipeline-Tool.git"
REPO_DIR="/mnt/c/Users/tarun/devops/python/CI_CD/Building-CI-CD-Pipeline-Tool"  
WEBSITE_DIR="/var/www/html"

# Pull the latest changes from GitHub
cd $REPO_DIR || exit
git pull origin main  # Make sure you are pulling from the correct branch

# Copy the updated website to Nginx's web root
sudo rsync -av --delete $REPO_DIR/ $WEBSITE_DIR/

# Restart Nginx to apply changes
sudo systemctl restart nginx

echo "Website updated successfully"
