# legosorter

A FastAPI-based web application for real-time LEGO classification using camera preview.

## Features

- 📱 Mobile-optimized interface
- 📷 Real-time camera preview
- 🎯 Automatic frame capture every 800ms
- 🎨 Visual bounding boxes and labels overlay
- 📊 Live statistics (detections, frames, FPS)

## Setup

The project uses a virtual environment to keep dependencies isolated. Use the provided scripts for easy setup:

### Quick Start (Recommended)

1. Run the setup and build script:
```bash
./setup.sh
./build.sh
```

2. Run the server:
```bash
./run.sh
```

3. Open your browser and navigate to:
```
http://localhost:8000
```

### Helper Scripts

- **`./setup.sh`** - Creates a Python virtual environment
- **`./build.sh`** - Installs all dependencies in the virtual environment
- **`./run.sh`** - Runs the FastAPI server using the virtual environment
- **`./clean.sh`** - Removes the virtual environment and cache files

### Manual Setup (Alternative)

If you prefer to manage dependencies manually:

1. Create and activate a virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Run the server:
```bash
python server.py
```

## Usage

1. Enter the number of classes you want to classify (1-100)
2. Click "Start" to begin camera capture
3. The application will:
   - Capture frames every 800ms
   - Send them to the `/classify` endpoint
   - Display bounding boxes and labels for detected objects
4. Click "Stop" to end the session

## API Endpoints

### `GET /`
Returns the mobile-optimized HTML interface.

### `POST /classify`
Classifies LEGO pieces in the uploaded image.

**Parameters:**
- `image`: JPEG image file (multipart/form-data)
- `numClasses`: Integer representing the number of classes

**Returns:**
```json
{
  "detections": [
    {
      "bbox": [x1, y1, x2, y2],
      "class": 1,
      "confidence": 0.95,
      "label": "Class 1"
    }
  ]
}
```

## Current Implementation

The current version uses a 3×3 grid with random classifications. This is a placeholder for the actual recognition model which will be added later.

## Notes

- No CORS configuration (single-origin application)
- No database required
- No authentication required
- Works best on mobile devices with camera access