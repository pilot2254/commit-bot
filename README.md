# Mike's commit-bot

Automate git commit history with customizable fake commits.  
Useful for educational purposes, contribution graph generation, and learning Git internals.

> [!IMPORTANT]
> This tool is intended **only for educational use**. Do not use it to misrepresent activity or manipulate public metrics. You are responsible for how you use it.

<br><br>
## Features

- Define commit date range
- Set commit frequency and hours
- Auto-skips weekends (optional)
- Commits contain only timestamp (ISO-8601)
- Dry-run mode for previewing output
- Timezone support

<br><br>
## Usage

### 1. Create a New Git Repository

```bash
mkdir my-fake-repo && cd my-fake-repo
git init
```

<br><br>
### 2. Download the Script

```bash
curl -O https://raw.githubusercontent.com/pilot2254/commit-bot/main/commit-bot.sh
chmod +x commit-bot.sh
```

Or copy the script manually from [commit-bot.sh](https://github.com/pilot2254/commit-bot/blob/main/commit-bot.sh).

<br><br>
### 3. Configure the Script

Open `commit-bot.sh` in your editor. Adjust:

```bash
start_date="2023-01-01"
end_date="2024-01-01"
min_hour=8
max_hour=18
commit_every_n_days=1
ignore_weekends=true
dry_run=false
timezone="Europe/Prague"
```

<br><br>
### 4. Run the Script

```bash
./commit-bot.sh
```

You will be asked to confirm execution.
If `dry_run=true`, it will simulate commits without writing them.

<br><br>
### 5. Inspect Commits

Check commit history:

```bash
git log --pretty=fuller
```

<br><br>
### 6. Push to GitHub

Create a GitHub repository. Then:

```bash
git remote add origin https://github.com/your-username/your-repo.git
git branch -M main
git push -u origin main
```

<br><br>
## Example Output

```bash
Commit on 2023-01-02 at 2023-01-02T09:34:18
Commit on 2023-01-02 at 2023-01-02T14:12:52
Commit on 2023-01-02 at 2023-01-02T16:48:01
...
Completed. Total fake commits created: 186
```

<br><br>
## Testing

Set `dry_run=true` to preview commits without writing them.
Set short date ranges and hours to verify correctness.

## Cleanup

To remove fake commits:

```bash
rm -rf .git
```

Or selectively reset using:

```bash
git reset --hard HEAD~N
```
