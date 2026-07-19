#!/bin/bash

BACKLOG_DIR=".context/project/backlog"

# Use fd to find all TASK.md files
# Use rg to extract the code and title from the frontmatter
# Then use fzf for interactive selection
SELECTED=$(fd "TASK.md" "$BACKLOG_DIR" -x rg '^code: (.*)' | \
    sed 's/.*code: //' | \
    fzf --header "Select a Task" --prompt "Search Task: " --delimiter ' ' --with-nth 1)

if [ -z "$SELECTED" ]; then
    echo "No task selected."
    exit 1
fi

echo "$SELECTED"
