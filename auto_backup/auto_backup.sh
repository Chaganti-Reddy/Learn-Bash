#!/usr/bin/env bash
set -euo pipefail

# Colors and formatting
BOLD=$(tput bold)
RED=$(tput setaf 1)
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)

# Messaging helpers
die() {
  echo -e "${BOLD}${RED}ERROR:${RESET} $*" >&2
  exit 1
}

info() {
  echo -e "${BOLD}${BLUE}INFO:${RESET} $*"
}

success() {
  echo -e "${BOLD}${GREEN}SUCCESS:${RESET} $*"
}

warning() {
  echo -e "${BOLD}${CYAN}WARNING:${RESET} $*"
}

date=$(date +%Y-%m-%d-%H-%M-%S)

# Backup function
create_backup() {
  local dir="$1"
  local isdry="${2:-}"

  if [ "$isdry" = "--dry-run" ]; then
    info "Dry running backup of $dir"
    if [ ! -d "$dir" ]; then
      die "$dir does not exist — Dry run failed"
    fi
  else
    info "Creating backup of $dir"
    if [ ! -d "$dir" ]; then
      die "$dir does not exist — Backup failed"
    fi
  fi

  if [ ! -d "backups" ]; then
    info "Creating backups directory"
    mkdir -p backups
  fi

  local dir_name_sanitized
  dir_name_sanitized=$(basename "$dir")
  local tar_file="backups/${dir_name_sanitized}_${date}.tar.gz"

  if [ "$isdry" = "--dry-run" ]; then
    if ! tar -zcf "$tar_file" "$dir"; then
      die "Dry run tar command failed"
    fi
    success "Dry run completed"
    rm -f "$tar_file"
    if [ -n "backups" ]; then
      rm -rf backups
    fi
  else
    tar -zcf "$tar_file" "$dir"
    success "Backup of $dir completed and saved as $tar_file"
  fi
}

# Entry point
main() {
  local arg1="${1:-}"
  local arg2="${2:-}"

  if [ "$arg1" = "--help" ]; then
    echo "Usage:"
    echo "  auto_backup.sh <dir_name>           # Create actual backup"
    echo "  auto_backup.sh --dry-run <dir_name> # Test backup process without saving"
    exit 0

  elif [ "$arg1" = "--dry-run" ]; then
    if [ -z "$arg2" ]; then
      die "Missing directory name for dry run"
    fi
    create_backup "$arg2" "$arg1"

  elif [ -n "$arg1" ]; then
    create_backup "$arg1"

  else
    die "Missing arguments. Use --help for usage instructions."
  fi
}

main "$@"

