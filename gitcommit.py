import os
import random
from datetime import datetime, timedelta

def generate_random_date(start_date, end_date):
    """Generate a random date between start_date and end_date."""
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    random_seconds = random.randint(0, 86399)  # Random time within the day
    return start_date + timedelta(days=random_days, seconds=random_seconds)

def make_commit_on_date(commit_date, file_name, repo_path):
    """Make a Git commit on a specific date."""
    os.chdir(repo_path)  # Change to the repository directory

    # Update the file to create a change
    with open(file_name, 'a') as file:
        file.write(f"Commit on {commit_date}\n")  # Add a line to the file

    # Set the date for the commit
    commit_date_str = commit_date.strftime('%Y-%m-%dT%H:%M:%S')
    os.environ['GIT_AUTHOR_DATE'] = commit_date_str
    os.environ['GIT_COMMITTER_DATE'] = commit_date_str

    # Git add and commit
    os.system(f'git add {file_name}')
    os.system(f'git commit -m "Commit on {commit_date.strftime("%Y-%m-%d")}"')

def push_commits():
    """Push all commits to the remote repository."""
    os.system('git push')  # Replace 'main' with your branch name if different

def generate_random_commits(num_commits, repo_path):
    """Generate random Git commits."""
    file_name = 'random_commits.txt'  # File to modify for commits
    end_date = datetime.now()
    start_date = end_date - timedelta(days=365)  # Last 365 days

    for _ in range(num_commits):
        random_date = generate_random_date(start_date, end_date)
        make_commit_on_date(random_date, file_name, repo_path)

    print(f"{num_commits} random commits created.")

# Configuration
repository_path = r'C:\Users\azeem\Desktop\GitTrick\gittrick'  # Replace with your local repo path
number_of_commits = int(input('Enter number of commits'))  # Adjust the number of commits you want

# Run the script
generate_random_commits(number_of_commits, repository_path)
push_commits()  # Push the commits to the remote repository
