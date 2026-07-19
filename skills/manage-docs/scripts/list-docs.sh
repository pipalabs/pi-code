#!/bin/bash
# list-docs.sh - List all markdown files in the project documentation directory.

DOCS_DIR=".context/project/product/"

if [ ! -d "$DOCS_DIR" ]; then
  echo "Error: Documentation directory $DOCS_DIR not found."
  exit 1
fi

find "$DOCS_DIR" -name "*.md" | sed "s|$DOCS_DIR||"
