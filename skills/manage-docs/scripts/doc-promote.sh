#!/bin/bash
# doc-promote.sh - Promote a draft to a formal documentation file.

DRAFT_NAME=$1
DESTINATION_PATH=$2
DRAFTS_DIR=".context/project/docs/drafts/"
DOCS_ROOT=".context/project/docs/"

# 1. Validation: Arguments
if [ -z "$DRAFT_NAME" ] || [ -z "$DESTINATION_PATH" ]; then
  echo "Error: Missing arguments."
  echo "Usage: doc-promote.sh <draft_name> <destination_path>"
  exit 1
fi

# 2. Validation: Draft existence
# Check for both raw name and normalized name (since we store normalized)
# For simplicity, we assume the user provides the normalized name or we normalize it
NORMALIZED_DRAFT=$(echo "$DRAFT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
DRAFT_FILE="$DRAFTS_DIR$NORMALIZED_DRAFT.md"

if [ ! -f "$DRAFT_FILE" ]; then
  echo "Error: Draft file not found at $DRAFT_FILE"
  exit 1
fi

# 3. Validation: Destination Security
if [[ "$DESTINATION_PATH" != "$DOCS_ROOT"* ]]; then
  echo "Error: Security violation. Destination path must start with $DOCS_ROOT."
  exit 1
fi

# 4. Implementation: Promote
# Ensure destination directory exists
mkdir -p "$(dirname "$DESTINATION_PATH")"

# Avoid overwrite
if [ -f "$DESTINATION_PATH" ]; then
  echo "Error: Destination file already exists at $DESTINATION_PATH."
  exit 1
fi

mv "$DRAFT_FILE" "$DESTINATION_PATH"

echo "Success: Draft promoted from $DRAFT_FILE to $DESTINATION_PATH"
exit 0
