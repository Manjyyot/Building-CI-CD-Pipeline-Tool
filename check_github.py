#!/usr/bin/env python3

import requests
import os
import sys

REPO_OWNER = 'Manjyyot'
REPO_NAME = 'Building-CI-CD-Pipeline-Tool'
GITHUB_API_URL = f'https://api.github.com/repos/{REPO_OWNER}/{REPO_NAME}/commits'

# Update this path to your desired location
LAST_COMMIT_FILE = '/mnt/c/Users/tarun/devops/python/CI_CD/Building-CI-CD-Pipeline-Tool/last_commit.txt'

def get_latest_commit():
    response = requests.get(GITHUB_API_URL)
    if response.status_code == 200:
        commits = response.json()
        return commits[0]['sha']
    else:
        print(f"Failed to fetch commits: {response.status_code}")
        return None

def get_stored_commit():
    if os.path.exists(LAST_COMMIT_FILE):
        with open(LAST_COMMIT_FILE, 'r') as f:
            return f.read().strip()
    return None

def update_stored_commit(sha):
    with open(LAST_COMMIT_FILE, 'w') as f:
        f.write(sha)

def main():
    latest_commit = get_latest_commit()
    if not latest_commit:
        sys.exit(1)
    stored_commit = get_stored_commit()
    if latest_commit != stored_commit:
        print("New changes detected")
        update_stored_commit(latest_commit)
        sys.exit(0)
    else:
        print("No new changes")
        sys.exit(1)

if __name__ == "__main__":
    main()
