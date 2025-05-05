#!/bin/bash

# ======================== CONFIGURATION ========================

start_date="2020-01-01"
end_date="2024-12-31"

min_hour=8
max_hour=18

commit_every_n_days=1
ignore_weekends=true
dry_run=false                 # Set to true for a test run
timezone="Europe/Prague"      # Set your desired timezone (e.g., UTC, America/New_York)

# Commit messages
commit_messages=(
    "Work in progress"
    "Update"
    "Bug fixes"
    "Refactor code"
    "Random commit"
    "Code cleanup"
    "Added new feature"
    "Improved performance"
    "Fixed typos"
    "Updated documentation"
    "Enhanced user experience"
    "Simplified logic"
    "Refactored modules"
    "Optimized loop"
)

# ======================== SAFETY CHECK ========================

if [ ! -d .git ]; then
    echo "Error: Not a Git repository. Run 'git init' first."
    exit 1
fi

read -p "This script will generate fake commit history. Proceed? (y/n): " confirm
[[ "$confirm" != "y" ]] && echo "Aborted." && exit 0

if [ "$commit_every_n_days" -lt 1 ]; then
    echo "Error: commit_every_n_days must be 1 or greater."
    exit 1
fi

# ======================== DATE UTILITIES ========================

export TZ="$timezone"

if [[ "$OSTYPE" == "darwin"* ]]; then
    date_to_epoch() { date -j -f "%Y-%m-%d" "$1" "+%s"; }
    epoch_to_date() { date -j -f "%s" "$1" "+%Y-%m-%d"; }
    get_weekday()   { date -j -f "%s" "$1" "+%u"; }
    format_datetime() { date -j -f "%s" "$1" "+%Y-%m-%dT%H:%M:%S"; }
else
    date_to_epoch() { date -d "$1" "+%s"; }
    epoch_to_date() { date -d "@$1" "+%Y-%m-%d"; }
    get_weekday()   { date -d "@$1" "+%u"; }
    format_datetime() { date -d "@$1" "+%Y-%m-%dT%H:%M:%S"; }
fi

# ======================== MAIN LOOP ========================

start=$(date_to_epoch "$start_date")
end=$(date_to_epoch "$end_date")
current=$start
commits_made=0

echo "Starting commit generation in timezone: $timezone"
echo "------------------------------------------------"

while [ "$current" -le "$end" ]; do
    if $ignore_weekends; then
        day_of_week=$(get_weekday "$current")
        if [ "$day_of_week" -eq 6 ] || [ "$day_of_week" -eq 7 ]; then
            current=$((current + 86400))
            continue
        fi
    fi

    commits_today=$((RANDOM % 4 + 1))

    for ((i = 0; i < commits_today; i++)); do
        hour=$((RANDOM % (max_hour - min_hour + 1) + min_hour))
        minute=$((RANDOM % 60))
        second=$((RANDOM % 60))

        commit_epoch=$((current + hour * 3600 + minute * 60 + second))
        commit_time=$(format_datetime "$commit_epoch")
        message=${commit_messages[RANDOM % ${#commit_messages[@]}]}

        echo "Commit on $(epoch_to_date "$current") at $commit_time — '$message'"

        if ! $dry_run; then
            GIT_AUTHOR_DATE="$commit_time" GIT_COMMITTER_DATE="$commit_time" \
            git commit --allow-empty -m "$message"
            ((commits_made++))
        fi
    done

    current=$((current + commit_every_n_days * 86400))
done

echo "------------------------------------------------"
echo "Completed. Total fake commits created: $commits_made"