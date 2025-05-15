#!/usr/bin/env bash

# Usage: ./file_cleaner.sh [path] [--size X] [--days Y] [--pattern "*.log"] [--dry-run] [--force]

size=0
days=0
pattern="*"
dry_run=false
force=false
path="."

# Function to print usage
print_usage() {
  echo "Usage: $0 [path] [--size X] [--days Y] [--pattern \"*.log\"] [--dry-run] [--force]"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --size)
      size="$2"
      shift 2
      ;;
    --size=*)
      size="${1#*=}"
      shift
      ;;
    --days)
      days="$2"
      shift 2
      ;;
    --days=*)
      days="${1#*=}"
      shift
      ;;
    --pattern)
      pattern="$2"
      shift 2
      ;;
    --pattern=*)
      pattern="${1#*=}"
      shift
      ;;
    --dry-run)
      dry_run=true
      shift
      ;;
    --force)
      force=true
      shift
      ;;
    -*)
      echo "Unknown option: $1"
      print_usage
      exit 1
      ;;
    *)
      path="$1"
      shift
      ;;
  esac
done

# Ensure path exists
if [[ ! -d "$path" ]]; then
  echo "Error: Path '$path' does not exist or is not a directory."
  exit 1
fi

# Perform file cleanup
file_clean() {
  echo "Searching in: $path"
  echo "Pattern: $pattern | Size > ${size} bytes | Older than ${days} days"
  files=$(find "$path" -type f -name "$pattern" -mtime +"$days" -size +"$size"c 2>/dev/null)

  if [[ -z "$files" ]]; then
    echo "No matching files found."
    return
  fi

  if $dry_run; then
    echo "Dry-run mode: Would remove the following files:"
    echo "$files"
  else
    if $force; then
      echo "Force deleting the following files:"
      echo "$files"
      echo "$files" | xargs -d '\n' rm -f
    else
      echo "$files" | xargs -d '\n' rm -i
    fi
  fi
}

file_clean

