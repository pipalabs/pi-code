#!/bin/bash

TASK_CODE=$1
ACTION=$2
VALUE=$3
REPLACEMENT=$4

if [ -z "$TASK_CODE" ] || [ -z "$ACTION" ] || [ -z "$VALUE" ]; then
    echo "Usage: $0 <TASK_CODE> <ACTION> <VALUE> [REPLACEMENT]"
    echo "Actions:"
    echo "  append    : Append text to the end of the body"
    echo "  replace   : Replace first occurrence of <VALUE> with <REPLACEMENT>"
    echo "  set       : Overwrite the entire body with <VALUE>"
    echo "Example: $0 JUBA-39 append '\n## Notas\nNova nota.'"
    echo "Example: $0 JUBA-39 replace 'velho texto' 'novo texto'"
    echo "Example: $0 JUBA-39 set '# Novo Conteúdo\nCorpo total novo.'"
    exit 1
fi

BACKLOG_DIR=".context/project/backlog"

# Find the file that contains the task code in frontmatter
FILE=$(find "$BACKLOG_DIR" -name "TASK.md" -exec grep -l "code: $TASK_CODE" {} + | head -n 1)

if [ -z "$FILE" ]; then
    echo "Error: Task $TASK_CODE not found in backlog."
    exit 1
fi

echo "Updating body of task $TASK_CODE in $FILE using action '$ACTION'..."

# Temporary files
TEMP_YAML=$(mktemp)
TEMP_BODY=$(mktemp)

# Extract frontmatter
awk '/^---$/ { count++; next } count == 1' "$FILE" > "$TEMP_YAML"

# Extract body
awk '/^---$/ { count++; next } count > 1' "$FILE" > "$TEMP_BODY"

case "$ACTION" in
    append)
        echo -e "$VALUE" >> "$TEMP_BODY"
        ;;
    replace)
        if [ -z "$REPLACEMENT" ]; then
            echo "Error: Replacement string is required for 'replace' action."
            exit 1
        fi
        # Use sd for a clean, reliable replacement
        sd "$VALUE" "$REPLACEMENT" "$TEMP_BODY"
        ;;
    set)
        echo -e "$VALUE" > "$TEMP_BODY"
        ;;
    *)
        echo "Error: Invalid action '$ACTION'."
        exit 1
        ;;
esac

# Reconstruct the file
# Update last_updated timestamp in frontmatter before reconstructing
yq -i ".last_updated = \"$(date +%Y-%m-%d)\"" "$TEMP_YAML"

echo "---" > "$FILE"
cat "$TEMP_YAML" >> "$FILE"
echo "---" >> "$FILE"
cat "$TEMP_BODY" >> "$FILE"

rm "$TEMP_YAML" "$TEMP_BODY"

echo "Successfully updated body for $TASK_CODE."
