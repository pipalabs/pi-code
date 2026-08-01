#!/bin/bash
# create-doc.sh - Automates the creation of documentation files from templates.

# Handle arguments
if [ "$#" -eq 1 ]; then
  TEMPLATE_NAME=""
  DESTINATION_PATH=$1
elif [ "$#" -eq 2 ]; then
  TEMPLATE_NAME=$1
  DESTINATION_PATH=$2
else
  echo "Error: Invalid number of arguments."
  echo "Usage: create-doc.sh [template_name] <destination_path>"
  exit 1
fi

REFERENCES_DIR=".pi/skills/manage-docs/references"
DOCS_ROOT=".context/project/product/"

# 1. Validation: Destination path provided
if [ -z "$DESTINATION_PATH" ]; then
  echo "Error: Missing destination path."
  echo "Usage: create-doc.sh [template_name] <destination_path>"
  exit 1
fi

# 2. Validation: Template resolution and existence
if [ -z "$TEMPLATE_NAME" ]; then
  TEMPLATE_FILE="$REFERENCES_DIR/DOC.guide.md"
else
  TEMPLATE_FILE="$REFERENCES_DIR/DOC.$TEMPLATE_NAME.md"
fi

if [ ! -f "$TEMPLATE_FILE" ]; then
  echo "Error: Template not found at $TEMPLATE_FILE."
  exit 2
fi

# 3. Validation: Security (Directory Restriction)
# Check if destination path starts with DOCS_ROOT
if [[ "$DESTINATION_PATH" != "$DOCS_ROOT"* ]]; then
  echo "Error: Security violation. Destination path must start with $DOCS_ROOT."
  exit 3
fi

# 4. Validation: Avoid overwrite
if [ -f "$DESTINATION_PATH" ]; then
  echo "Error: File already exists at $DESTINATION_PATH. Overwrite is prohibited."
  exit 4
fi

# 5. Implementation: Create directory and copy template
mkdir -p "$(dirname "$DESTINATION_PATH")"
cp "$TEMPLATE_FILE" "$DESTINATION_PATH"

echo "Success: Documentation created at $DESTINATION_PATH using template $(basename "$TEMPLATE_FILE")."
exit 0
