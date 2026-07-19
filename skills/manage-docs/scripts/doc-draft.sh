#!/bin/bash
# doc-draft.sh - Create a quick draft note in the documentation directory.

DRAFT_NAME=$1
DRAFTS_DIR=".context/project/docs/drafts/"
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M")

# 1. Validation: Arguments
if [ -z "$DRAFT_NAME" ]; then
  echo "Error: Missing draft name."
  echo "Usage: doc-draft.sh <draft_name>"
  exit 1
fi

# 2. Implementation: Sanitization
# - Convert to lowercase
# - Replace spaces with hyphens
# - Remove characters that are not alphanumeric or hyphens
NORMALIZED_NAME=$(echo "$DRAFT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')

if [ -z "$NORMALIZED_NAME" ]; then
  echo "Error: Draft name is invalid after sanitization."
  exit 1
fi

# 3. Preparation: Ensure drafts directory exists
mkdir -p "$DRAFTS_DIR"

# 4. Implementation: Create file with template
FILE_PATH="$DRAFTS_DIR$NORMALIZED_NAME.md"

if [ -f "$FILE_PATH" ]; then
  echo "Error: Draft '$NORMALIZED_NAME' already exists."
  exit 1
fi

cat <<EOF > "$FILE_PATH"
# $DRAFT_NAME
Criado em: $CURRENT_DATE

## Notas
EOF

echo "Success: Draft created at $FILE_PATH"
exit 0
