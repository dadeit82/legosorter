#!/bin/bash
# Clean script for LEGO Sorter project
# This script removes the virtual environment and cached files

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$SCRIPT_DIR/venv"

echo "==================================="
echo "LEGO Sorter - Clean Environment"
echo "==================================="

# Remove virtual environment
if [ -d "$VENV_DIR" ]; then
    echo "Removing virtual environment at: $VENV_DIR"
    rm -rf "$VENV_DIR"
    echo "Virtual environment removed!"
else
    echo "No virtual environment found at: $VENV_DIR"
fi

# Remove Python cache files
echo "Removing Python cache files..."
find "$SCRIPT_DIR" -type d -name "__pycache__" -delete 2>/dev/null || true
find "$SCRIPT_DIR" -type f -name "*.pyc" -delete 2>/dev/null || true
find "$SCRIPT_DIR" -type f -name "*.pyo" -delete 2>/dev/null || true

echo ""
echo "Clean complete!"
echo ""
echo "To recreate the environment, run: ./setup.sh"
