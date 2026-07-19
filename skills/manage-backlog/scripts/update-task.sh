#!/bin/bash

TASK_CODE=$1
FIELD=$2
VALUE=$3

if [ -z "$TASK_CODE" ] || [ -z "$FIELD" ] || [ -z "$VALUE" ]; then
    echo "Usage: $0 <TASK_CODE> <FIELD> <VALUE>"
    echo "Example: $0 JUBA-39 status in_progress"
    exit 1
fi

BACKLOG_DIR=".context/project/backlog"

# Find the file that contains the task code in frontmatter
FILE=$(find "$BACKLOG_DIR" -name "TASK.md" -exec grep -l "code: $TASK_CODE" {} + | head -n 1)

if [ -z "$FILE" ]; then
    echo "Error: Task $TASK_CODE not found in backlog."
    exit 1
fi

echo "Updating $FIELD to '$VALUE' for task $TASK_CODE in $FILE..."

# Temporary files
TEMP_YAML=$(mktemp)
TEMP_BODY=$(mktemp)

# Extract frontmatter (everything between the first and second ---)
awk '/^---$/ { count++; next } count == 1' "$FILE" > "$TEMP_YAML"

# Extract body (everything after the second ---)
awk '/^---$/ { count++; next } count > 1' "$FILE" > "$TEMP_BODY"

# Use yq to update the field in the YAML part
yq -i ".$FIELD = \"$VALUE\"" "$TEMP_YAML"

# Reconstruct the file
echo "---" > "$FILE"
cat "$TEMP_YAML" >> "$FILE"
echo "---" >> "$FILE"
cat "$TEMP_BODY" >> "$FILE"

rm "$TEMP_YAML" "$TEMP_BODY"

echo "Successfully updated $FIELD to '$VALUE' for $TASK_CODE."
