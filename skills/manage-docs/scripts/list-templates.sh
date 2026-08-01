#!/bin/bash
# list-templates.sh - Informs about the standard documentation template and usage.

echo "Standard Template: DOC.template.md"
echo "----------------------------------"
echo "The project now uses a single standard template for all documentation."
echo ""
echo "To define the structure and purpose of the document, use the 'type' field in the frontmatter:"
echo ""
echo " - index: Module summary, dependency map, and links to sub-documents."
echo " - rule: Business rules table (ID | Rule | Justification) and exception flows."
echo " - architecture: Technical decisions (ADR), component diagrams, and data flows."
echo " - guide: Step-by-step tutorials, configuration guides, or user manuals."
echo " - api: Contract definitions, endpoints, requests, and responses."
echo ""
echo "Usage example: just doc-create .context/project/docs/my-module/index.md"
