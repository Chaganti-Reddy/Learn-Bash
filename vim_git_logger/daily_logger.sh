#!/usr/bin/env bash

# Folder for logs
mkdir -p logs
cd logs || exit

# Set filename to today's date or custom arg
filename=${1:-$(date +"%Y-%m-%d")}
commitmsg=""

# Create the file if it doesn't exist
if [ ! -f "$filename.md" ]; then
  cat << EOF > "$filename.md"
## 🧠 Tasks I Did

## 🐛 Problems I Faced

## 🔧 Commands I Learned

## 📚 Kernel Concepts Explored
EOF

  commitmsg="journal: created entry for $filename"
else
  commitmsg="journal: updated entry for $filename"
fi

# Open the file in Vim
vim "$filename.md"

# Git commit logic
cd ..
if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
  git add "logs/$filename.md"
  git commit -m "$commitmsg"
else
  git init
  git add "logs/$filename.md"
  git commit -m "$commitmsg"
fi

# Show recent log summary
echo -e "\n🧾 Recent Journal History:"
git log --oneline | head

