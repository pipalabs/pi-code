#!/bin/bash

BACKLOG_DIR=".context/project/backlog"

# Parse arguments
FILTERS=""
SORT_FIELD=""
SORT_ORDER="asc"
LIMIT=""

for arg in "$@"; do
    case $arg in
        sort=*)
            SORT_VAL=${arg#sort=}
            SORT_FIELD=${SORT_VAL%:*}
            SORT_ORDER=${SORT_VAL#*:}
            [ "$SORT_ORDER" == "$SORT_FIELD" ] && SORT_ORDER="asc" # Default if no :asc/desc
            ;;
        limit=*)
            LIMIT=${arg#limit=}
            ;;
        *=*)
            FIELD=${arg%=*}
            VAL=${arg#*=}
            # Build jq filter string: select((.field | ascii_downcase) == ("val" | ascii_downcase))
            if [ -z "$FILTERS" ]; then
                FILTERS="select((.$FIELD | ascii_downcase) == (\"$VAL\" | ascii_downcase))"
            else
                FILTERS="$FILTERS and select((.$FIELD | ascii_downcase) == (\"$VAL\" | ascii_downcase))"
            fi
            ;;
        *)
            # Treat as status filter for backward compatibility
            if [ -z "$FILTERS" ]; then
                FILTERS="select((.status | ascii_downcase) == (\"$arg\" | ascii_downcase))"
            fi
            ;;
    esac
done

# Extract all tasks into a JSON array
TASK_FILES=$(fd "TASK.md" "$BACKLOG_DIR")
if [ -z "$TASK_FILES" ]; then
    echo "No tasks found in $BACKLOG_DIR"
    exit 0
fi

# Use sed to extract frontmatter, yq to convert to JSON, and jq to add the path
DATA=$(while IFS= read -r file; do
    sed -n '1,/^---$/p' "$file" | sed '1d;$d' | yq -o=json | jq --arg path "$file" '. + {path: $path}'
done < <(fd "TASK.md" "$BACKLOG_DIR") | jq -s '.')

# Build the jq query
QUERY="."

# 1. Apply Filters
if [ -n "$FILTERS" ]; then
    QUERY="$QUERY | map($FILTERS)"
else
    QUERY="$QUERY | map(.)"
fi

# 2. Apply Sorting
if [ -n "$SORT_FIELD" ]; then
    if [ "$SORT_ORDER" == "desc" ]; then
        QUERY="$QUERY | sort_by(.$SORT_FIELD) | reverse"
    else
        QUERY="$QUERY | sort_by(.$SORT_FIELD)"
    fi
fi

# 3. Apply Limit
if [ -n "$LIMIT" ]; then
    QUERY="$QUERY | .[0:$LIMIT]"
fi

# Execute jq and format output
# We use @tsv or a custom format to print the table
# First, we get the keys from the first item to determine columns
# But for consistency with the old script, we'll use CODE, STATUS, TITLE, PATH

RESULT=$(echo "$DATA" | jq -r "$QUERY | .[] | [ .code, .status, .title, .path ] | @tsv")

if [ -z "$RESULT" ]; then
    echo "No tasks found matching the criteria."
    exit 0
fi

echo "--------------------------------------------------------------------------------"
printf "%-10s | %-10s | %-50s | %s\n" "CODE" "STATUS" "TITLE" "PATH"
echo "--------------------------------------------------------------------------------"

while IFS=$'\t' read -r code status title path; do
    printf "%-10s | %-10s | %-50s | %s\n" "$code" "$status" "$title" "$path"
done <<< "$RESULT"

echo "--------------------------------------------------------------------------------"
COUNT=$(echo "$RESULT" | wc -l)
echo "Total: $COUNT"
