#!/bin/bash

# Repository path
REPO_PATH="/mnt/c/Users/azeem/Desktop/GitTrick/gittrick"  # Replace with your local repository path
FILE_NAME="random_commits.txt"        # File to modify for commits
NUM_COMMITS=50                        # Number of random commits to create
BRANCH_NAME="main"                    # Replace with your target branch

# Navigate to the repository
cd "$REPO_PATH" || { echo "Repository not found!"; exit 1; }

# Create the file if it doesn't exist
if [[ ! -f $FILE_NAME ]]; then
    touch "$FILE_NAME"
    git add "$FILE_NAME"
    git commit -m "Initialize $FILE_NAME for random commits"
fi

# Generate random commits
for ((i = 1; i <= NUM_COMMITS; i++)); do
    # Generate a random timestamp in the past year
    RANDOM_TIMESTAMP=$(( $(date +%s) - RANDOM % 31536000 ))  # Random date within 1 year
    RANDOM_DATE=$(date -d @"$RANDOM_TIMESTAMP" +"%Y-%m-%dT%H:%M:%S")

    # Modify the file
    echo "Random commit on $RANDOM_DATE" >> "$FILE_NAME"

    # Stage and commit with the backdated timestamp
    GIT_AUTHOR_DATE="$RANDOM_DATE" GIT_COMMITTER_DATE="$RANDOM_DATE" \
    git add "$FILE_NAME" && \
    git commit -m "Commit on $(date -d @"$RANDOM_TIMESTAMP" +"%Y-%m-%d")"
done

# Push the changes to the remote repository
git push origin "$BRANCH_NAME"

echo "$NUM_COMMITS random commits created and pushed to the '$BRANCH_NAME' branch!"
