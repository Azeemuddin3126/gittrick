#!/bin/bash

repopath=$(pwd)
read -p "Enter the file name to use for commits (e.g., random_commits.txt): " filename

read -p "Enter the number of random commits to create: " ncommits

read -p "Enter the branch name to push commits (e.g., main): " branhn

[[ ! -d .git ]] && { echo "not a git repo " ; exit 1; }
[[ ! -f $filename ]] && { 
    echo "Initializing $filename"; 
    touch "$filenanme"; git add .; 
    git commit "init $filename"; }

for ((i=1; i<=ncommits; i++)); do
    date=$(date -d "@$(( $(date +%s) - RANDOM % 31536000 ))" +"%Y-%m-%dT%H:%M:%S")
    echo "commit at $date">> "$filename"
    gitauth="$date" gitcommit="$date" gitadd="$date" &&
    git commit -m "commit in $date"
done

git push origin "$branchn"