FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy ALL files from current directory to /app in container
COPY . .

# Check what files were copied
RUN ls -la /app/

# Create necessary directories
RUN mkdir -p /app/data /app/static /app/media

# Make sure manage.py is executable
RUN chmod +x manage.py

# Check if manage.py exists before running
RUN ls -la manage.py

# Simple command
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]