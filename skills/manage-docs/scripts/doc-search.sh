#!/bin/bash
# doc-search.sh - Search for a term across all documentation markdown files.

SEARCH_TERM=$1
DOCS_ROOT=".context/project/docs/"

# 1. Validation: Arguments
if [ -z "$SEARCH_TERM" ]; then
  echo "Error: Missing search term."
  echo "Usage: doc-search.sh <search_term>"
  exit 1
fi

# 2. Validation: Directory existence
if [ ! -d "$DOCS_ROOT" ]; then
  echo "Error: Documentation directory $DOCS_ROOT not found."
  exit 1
fi

# 3. Implementation: Search using grep
# -r: recursive
# -n: line number
# -I: ignore binary files
# --include="*.md": only markdown files
RESULTS=$(grep -rnI --include="*.md" "$SEARCH_TERM" "$DOCS_ROOT")

if [ -z "$RESULTS" ]; then
  echo "Nenhum resultado encontrado para: $SEARCH_TERM"
  exit 0
fi

# 4. Formatting: Convert 'file:line:content' to 'Arquivo:Linha -> Conteúdo'
echo "$RESULTS" | while read -r line; do
  file=$(echo "$line" | cut -d: -f1)
  line_num=$(echo "$line" | cut -d: -f2)
  content=$(echo "$line" | cut -d: -f3-)
  
  # Make path relative to DOCS_ROOT
  rel_file=${file#$DOCS_ROOT}
  
  echo "$rel_file:$line_num -> $content"
done

exit 0
