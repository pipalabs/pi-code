#!/bin/bash

# Headless Task Creator for Juba Backlog
# Usage: ./create-task.sh <TYPE> <TITLE> <RELATIVE_PATH> <BODY_FILE> [PARENT]

if [ "$#" -lt 4 ]; then
    echo "Usage: $0 <TYPE> <TITLE> <RELATIVE_PATH> <BODY_FILE> [PARENT]"
    exit 1
fi

TYPE=$1
TITLE=$2
RELATIVE_PATH=$3
BODY_FILE=$4
PARENT=$5

COUNTER_FILE=".pi/skills/manage-backlog/.state/counter"
BACKLOG_DIR=".context/project/backlog"

# Mandatory Auto-generation of Code
if [ ! -f "$COUNTER_FILE" ]; then
    echo "Error: Counter file not found at $COUNTER_FILE"
    exit 1
fi

CODE_NUM=$(cat "$COUNTER_FILE")
CODE="JUBA-$CODE_NUM"

# Increment counter for next time
NEXT_VAL=$((CODE_NUM + 1))
echo "$NEXT_VAL" > "$COUNTER_FILE"

FULL_PATH="$BACKLOG_DIR/$RELATIVE_PATH"

# Ensure directory exists
mkdir -p "$FULL_PATH"

if [ ! -f "$BODY_FILE" ]; then
    echo "Error: Body file not found at $BODY_FILE"
    exit 1
fi

# Use draft file content
DRAFT_CONTENT=$(cat "$BODY_FILE")

# Replace code: PENDING with generated code
FINAL_CONTENT=$(echo "$DRAFT_CONTENT" | sed "s/code: PENDING/code: $CODE/")

# Ensure parent is set if provided and not present in frontmatter
if [ -n "$PARENT" ] && ! echo "$FINAL_CONTENT" | grep -q "parent:"; then
    # Insert parent before the end of frontmatter (---)
    FINAL_CONTENT=$(echo "$FINAL_CONTENT" | sed "s/^---$/parent: $PARENT\n---/")
fi

echo "$FINAL_CONTENT" > "$FULL_PATH/TASK.md"

if [ $? -eq 0 ]; then
    echo "✅ Task $CODE created successfully at $FULL_PATH/TASK.md"
else
    echo "❌ Failed to create task $CODE"
    exit 1
fi
