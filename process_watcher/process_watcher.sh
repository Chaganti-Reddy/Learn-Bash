#!/usr/bin/env bash

# Directory to store logs
dir=logs

# Create logs directory if it doesn't exist
if [ ! -d "$dir" ]; then
  mkdir "$dir"
fi 

# Default values
times=5
interval=${1:-10}  # Take user input or default to 10s

# Infinite loop
while true
do
  # Read one character with timeout of 1s
  read -r -t 1 -n 1 key
  if [[ $key == "q" ]]; then 
    break 
  fi

  # Loop to write into log files (rotate every 5 files)
  for (( i=0; i < times; i++ ))
  do 
    val=$(( (i % times) + 1 ))
    log_file="logs/log_$val.txt"

    # Write timestamp + process info to the file
    echo "=== $(date) ===" > "$log_file"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 >> "$log_file"
  done

  # Show quit hint
  tput setaf 1
  echo "Press q to quit"
  tput sgr0

  sleep "$interval"
done

