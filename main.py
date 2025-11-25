from fastapi import FastAPI

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