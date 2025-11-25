"""
Simple FastAPI application for Tutor Control
"""
from fastapi import FastAPI
import uvicorn

app = FastAPI(
    title="Tutor Control API",
    description="Backend API for Tutor Control application",
    version="1.0.0"
)

@app.get("/")
async def root():
    return {"message": "Tutor Control API is running"}

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

@app.get("/docs")
async def docs_redirect():
    return {"message": "API documentation available at /docs"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)