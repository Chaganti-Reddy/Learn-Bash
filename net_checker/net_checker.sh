#!/usr/bin/env bash 

args="$@"
server="8.8.8.8"
interval="10"
once="false"
notify="false"

while [ "$#" -gt 0 ]; do
  case $1 in
    -h | --help)
      echo "Usage: net_checker.sh [--server|-s '8.8.8.8'] [--interval|-i '10'] [--once|-o] [--notify|-n]"
      exit 0
      ;;
    -s=* | --server=*)
      server="${1#*=}"
      shift
      ;;
    -s | --server)
      server="${2}"
      shift 2
      ;;
    -i=* | --interval=*)
      interval="${1#*=}"
      shift
      ;;
    -i | --interval)
      interval="${2}"
      shift 2
      ;;
    -o | --once)
      once="true"
      shift
      ;;
    -n | --notify)
      notify="true"
      shift
      ;;
    -*)
      echo "Invalid Command"
      echo "Usage: net_checker.sh [--server|-s '8.8.8.8'] [--interval|-i '10'] [--once|-o] [--notify|-n]"
      exit 1
      ;;
  esac
done


log="logs/net_log.txt"
status="offline"

net_check() {
  if ping -c 1 -W 1 "$server" >> "$log" 2>&1; then
    if [ "$status" = "offline" ]; then
      status="online"
      if [ "$notify" = "true" ]; then
        notify-send "Network Status" "Online"
      fi 
      echo "🟢 $date +'%Y-%m-%d %H:%M:%S' Internet is Online"
    fi
  else 
    if [ "$status" = "online" ]; then
      status="offline"
      if [ "$notify" = "true" ]; then 
        notify-send "Network Status" "Offline"
      fi 
      echo "🔴 $date +'%Y-%m-%d %H:%M:%S' Internet is Offline"
    fi 
  fi

  if [ "$once" = "true" ]; then
    if [ "$notify" = "true" ]; then
      ping -c 1 "$server" >> "$log" 2>&1
      notify-send "Network Status" "$(cat "$log")"
    else 
      ping -c 1 "$server" >> "$log" 2>&1
    fi
  else 
    while true; do 
      if [ "$notify" = "true" ]; then
        ping -c 1 "$server" >> "$log" 2>&1
        notify-send "Network Status" "$(cat "$log")"
      else 
        ping -c 1 "$server" >> "$log" 2>&1
      fi 
      sleep "$interval"
    done
  fi 
}

main() {
  if [ ! -d "logs" ]; then
    mkdir "logs"
  fi

  if [ ! -f "$log" ]; then
    touch "$log"
  fi

  net_check
}

main
