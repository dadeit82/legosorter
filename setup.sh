#!/bin/bash
# Setup script for LEGO Sorter project
# This script creates a Python virtual environment for dependency isolation

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$SCRIPT_DIR/venv"

echo "==================================="
echo "LEGO Sorter - Environment Setup"
echo "==================================="

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
echo "Python version: $PYTHON_VERSION"

# Create virtual environment if it doesn't exist
if [ -d "$VENV_DIR" ]; then
    echo "Virtual environment already exists at: $VENV_DIR"
    echo "To recreate it, run: ./clean.sh && ./setup.sh"
else
    echo "Creating virtual environment at: $VENV_DIR"
    python3 -m venv "$VENV_DIR"
    echo "Virtual environment created successfully!"
fi

echo ""
echo "Setup complete!"
echo ""
echo "To activate the virtual environment manually, run:"
echo "  source venv/bin/activate"
echo ""
echo "Or use the helper scripts:"
echo "  ./build.sh  - Install dependencies"
echo "  ./run.sh    - Run the server"
echo "  ./clean.sh  - Remove the virtual environment"
