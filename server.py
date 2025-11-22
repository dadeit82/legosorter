"""
FastAPI server for LEGO classifier with camera preview.
Serves a mobile page and provides classification endpoint.
"""

import io
import random
from typing import List, Dict
from fastapi import FastAPI, File, UploadFile, Form
from fastapi.responses import HTMLResponse
from PIL import Image

app = FastAPI(title="LEGO Sorter")


@app.get("/", response_class=HTMLResponse)
async def index():
    """Serve the main mobile page."""
    with open("index.html", "r") as f:
        return f.read()


@app.post("/classify")
async def classify(
    image: UploadFile = File(...),
    numClasses: int = Form(...)
):
    """
    Classify LEGO pieces in the image.
    
    Currently returns random classifications in a 3x3 grid.
    Recognition model will be added later.
    
    Args:
        image: JPEG image from camera
        numClasses: Number of classes to classify
        
    Returns:
        List of 9 detections with bounding boxes and labels
    """
    # Read the image to validate it's a valid image
    image_data = await image.read()
    img = Image.open(io.BytesIO(image_data))
    width, height = img.size
    
    # Generate 9 random classifications for 3x3 grid
    detections = []
    grid_width = width / 3
    grid_height = height / 3
    
    for row in range(3):
        for col in range(3):
            # Calculate bounding box for this grid cell
            x1 = col * grid_width
            y1 = row * grid_height
            x2 = (col + 1) * grid_width
            y2 = (row + 1) * grid_height
            
            # Add some random variation to the boxes
            padding = 10
            x1 += random.uniform(-padding, padding)
            y1 += random.uniform(-padding, padding)
            x2 += random.uniform(-padding, padding)
            y2 += random.uniform(-padding, padding)
            
            # Ensure boxes stay within image bounds
            x1 = max(0, min(x1, width))
            y1 = max(0, min(y1, height))
            x2 = max(0, min(x2, width))
            y2 = max(0, min(y2, height))
            
            # Random class label
            class_id = random.randint(1, numClasses)
            confidence = random.uniform(0.5, 0.99)
            
            detections.append({
                "bbox": [x1, y1, x2, y2],
                "class": class_id,
                "confidence": confidence,
                "label": f"Class {class_id}"
            })
    
    return {"detections": detections}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
