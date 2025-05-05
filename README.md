# auto-committer by Mike

A little bash script I made for fun that auto-generates Git commits between two dates.  
It’s designed to make your GitHub contribution graph look a bit more alive (or chaotic, depending on how you use it).

Repo: https://github.com/pilot2254/auto-committer

## What it does

- Commits between `start_date` and `end_date`  
- You can set how often it commits (e.g. every day, every 3 days, etc.)
- Skips weekends (optional)
- Generates random commit times between working hours
- Uses legit-looking commit messages
- Supports custom timezones
- No actual file changes needed — it uses `--allow-empty` commits

## Setup

Just clone the repo and run the script:

```bash
git clone https://github.com/pilot2254/auto-committer.git
cd auto-committer
chmod +x auto-committer.sh
./auto-committer.sh
````

Before running it, make sure you're inside a Git repo (`git init` if you're not).

## Configuration

All the options are at the top of `auto-committer.sh`:

```bash
start_date="2020-01-01"
end_date="2024-12-31"
min_hour=8
max_hour=18
commit_every_n_days=1
ignore_weekends=true
timezone="Europe/Prague"
dry_run=false
```

You can toggle `dry_run=true` if you just want to see what it *would* do without actually making commits.

## Example output

```
Starting commit generation in timezone: Europe/Prague
Commit on 2023-11-22 at 2023-11-22T14:32:51 — 'Code cleanup'
Commit on 2023-11-22 at 2023-11-22T17:45:20 — 'Added new feature'
...
Completed. Total fake commits created: 142
```

## A word of caution

This script is meant for testing, demos, portfolio polish, or just messing around.
Don't use it to fake open-source contributions or inflate stats—GitHub doesn’t like that, and honestly, neither do real devs.

---

MIT licensed. Do whatever you want with it.