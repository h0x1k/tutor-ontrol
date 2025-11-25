from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="Tutor Control API",
    description="Backend API for Tutor Control application",
    version="1.0.0"
)

# Add CORS for frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost", "http://frontend", "http://client"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

@app.get("/api/status")
async def api_status():
    return {"status": "API is running"}

# Add your API routes here
@app.get("/api/test")
async def test_endpoint():
    return {"message": "Backend API is working"}

# Your other existing routes...