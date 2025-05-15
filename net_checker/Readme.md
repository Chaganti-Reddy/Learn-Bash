# net_checker.sh

## What it does:
- Pings a given host repeatedly
- Logs when the internet goes offline or comes back

## Usage
```bash
chmod +x net_checker.sh
./net_checker.sh google.com 5
```

## Flags
- `-h` or `--help` for help
- `-s` or `--server` for the server to ping
- `-i` or `--interval` for the interval between pings
- `-o` or `--once` for a single ping
- `-n` or `--notify` for a notification when the internet goes offline/online

### 📝 Tip:
To check connection:
```bash
ping -c 1 -W 1 8.8.8.8 > /dev/null
```
