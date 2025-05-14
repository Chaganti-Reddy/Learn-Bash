# 📓 Vim Git Logger – Dev Diary

## What it does:
- Creates a markdown journal for the day (or a given date)
- Fills it with a journaling template
- Opens the file in Vim for you to edit
- Commits the journal entry to Git with a smart message
- Logs all entries in the `logs/` directory

## How to use:
```bash
chmod +x daily_logger.sh
./daily_logger.sh              # Logs today's date
./daily_logger.sh 2025-05-12   # Logs custom date
```

## Example Entry 

```bash
## 🧠 Tasks I Did
- Improved my shell script rotation logic

## 🐛 Problems I Faced
- Read command outside the loop caused a bug

## 🔧 Commands I Learned
- `tput`, `awk`, `ps`

## 📚 Kernel Concepts Explored
- Process scheduling basics
```

---

## 📦 Submission Checklist

- ✅ One `daily_logger.sh` script
- ✅ README with what it does, how to use, and example
- ✅ One actual log file (e.g., today’s date `.md`)
- ✅ Git initialized + `git log` showing at least one commit

## Oneliner Tip 
### Print the last weeks number of git commits using oneline bash script.

```bash
git log --since="last monday" --oneline | wc -l
```
