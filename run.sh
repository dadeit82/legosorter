#!/bin/bash
# Run script for LEGO Sorter project
# This script runs the FastAPI server using the virtual environment

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$SCRIPT_DIR/venv"

echo "==================================="
echo "LEGO Sorter - Starting Server"
echo "==================================="

# Check if virtual environment exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Virtual environment not found. Running setup and build first..."
    bash "$SCRIPT_DIR/setup.sh"
    bash "$SCRIPT_DIR/build.sh"
fi

# Activate virtual environment
source "$VENV_DIR/bin/activate"

# Check if dependencies are installed
if ! python -c "import fastapi" 2>/dev/null; then
    echo "Dependencies not installed. Running build..."
    bash "$SCRIPT_DIR/build.sh"
fi

# Run the server
echo "Starting server on http://0.0.0.0:8000"
echo "Press Ctrl+C to stop the server"
echo ""

python "$SCRIPT_DIR/server.py"
