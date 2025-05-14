# 🖥️ Process Watcher – Real-Time CPU Logger

## What it does:
- Monitors top 5 CPU-heavy processes every X seconds
- Saves logs in `logs/` directory
- Rotates between 5 logs (`log_1.txt` to `log_5.txt`)
- Stops instantly when `q` is pressed

## How to run:
```bash
chmod +x process_watcher.sh
./process_watcher.sh [interval_in_seconds]
```

## Sample Output

```bash
    PID    PPID CMD                         %MEM %CPU
1098633 1098617 /home/karna/.codeium/bin/37  0.9 10.5
1098546       1 /usr/bin/kitty nvim /home/k  1.4  6.7
 915031  914949 /opt/zen-browser-bin/zen-bi  1.9  5.0
 914949    1762 /opt/zen-browser-bin/zen-bi  4.0  4.8
1098567 1098565 nvim --embed /home/karna/Do  0.1  3.5 
```

---

## ✅ Checklist for Future Reference

| Task                                | Status |
|-------------------------------------|--------|
| Correct logging rotation            | ✅     |
| Graceful quit on `q`                | ✅     |
| Log interval as CLI arg             | ✅     |
| Colored hint / UX additions         | ✅     |
| Timestamp in each log               | ✅     |
| Modular and clean script structure  | ✅     |
| Documented in a neat README         | ✅     |
