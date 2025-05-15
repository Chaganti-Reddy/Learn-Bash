# auto_backup.sh

## What it does:
- Creates a `.tar.gz` backup of a folder
- Stores it in `./backups` with a timestamped filename

## Usage
```bash
chmod +x auto_backup.sh
./auto_backup.sh /path/to/folder
```

## Flags 
- `--dry-run`: Don't actually create backups instead check whether that will pass or not.
- `--help`: Shows the usage of script

## File Structure

```bash
auto_backup/
├── auto_backup.sh
├── README.md
```
