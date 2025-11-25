from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
import os

app = FastAPI(
    title="Tutor Control",
    description="Tutor Control Application",
    version="1.0.0"
)

# Serve static files (CSS, JS, images)
app.mount("/static", StaticFiles(directory="static"), name="static")

# Serve the main HTML file
@app.get("/")
async def serve_frontend():
    if os.path.exists("templates/index.html"):
        return FileResponse("templates/index.html")
    elif os.path.exists("static/index.html"):
        return FileResponse("static/index.html")
    else:
        return {"message": "Tutor Control API is running - frontend files not found"}

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

# Your API routes
@app.get("/api/status")
async def api_status():
    return {"status": "API is running"}