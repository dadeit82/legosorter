#!/bin/bash
# Build script for LEGO Sorter project
# This script installs all dependencies in the virtual environment

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$SCRIPT_DIR/venv"

echo "==================================="
echo "LEGO Sorter - Build Dependencies"
echo "==================================="

# Check if virtual environment exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Virtual environment not found. Running setup first..."
    bash "$SCRIPT_DIR/setup.sh"
fi

# Activate virtual environment
echo "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Upgrade pip to latest version
echo "Upgrading pip..."
pip install --upgrade pip

# Install dependencies
if [ -f "$SCRIPT_DIR/requirements.txt" ]; then
    echo "Installing dependencies from requirements.txt..."
    pip install -r "$SCRIPT_DIR/requirements.txt"
    echo ""
    echo "Dependencies installed successfully!"
else
    echo "Error: requirements.txt not found!"
    exit 1
fi

echo ""
echo "Build complete!"
echo ""
echo "Installed packages:"
pip list

echo ""
echo "To run the server, use: ./run.sh"
