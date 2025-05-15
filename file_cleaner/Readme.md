# file_cleaner.sh

## What it does:
- Scans and deletes files based on size, age, or pattern
- Has dry-run and confirmation modes

## Usage:
```bash
chmod +x file_cleaner.sh
./file_cleaner.sh /path --size=50 --days=10 --pattern=*.log --dry-run
```

## Flags

- `--size=X` → only files larger than X MB
- `--days=Y` → only files older than Y days
- `--pattern=PATTERN` → match filename
- `--dry-run` → no deletion
- `--force` → delete without asking
