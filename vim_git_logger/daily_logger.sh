#!/usr/bin/env bash 

filename=$(date +"%Y-%m-%d") # Take the formatted date as a file name
commitmsg=""

# Touch the file if not exists but with the pre content
if [ ! -e  "$filename.md" ]; then
  cat << EOF > $filename.md
  ## 🧠 Tasks I Did

  ## 🐛 Problems I Faced

  ## 🔧 Commands I Learned

  ## 📚 Kernel Concepts Explored
  EOF

  commitmsg="Created $filename.md file and entried to day's journal."
fi

# Open the file in vim 
commitmsg="Modified today's journal file $filename.md "
vim $filename

# Check if the folder is already in git repo or in the repo itself
if [ "$(git rev-parse --is-inside-work-tree)" != "false" ]; then
  git add $filename.md
  git commit -m "$commitmsg"
else 
  git init .
  git add $filename.md
  git commit -m "$commitmsg"
fi

# Show git log 
git log --oneline | head
