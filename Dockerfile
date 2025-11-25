FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy all files
COPY . .

# Debug: List files to see what's actually in the container
RUN ls -la

# Debug: Check if main.py exists and can be imported
RUN python -c "import os; print('Files in /app:', os.listdir('.')); import main; print('main.py imported successfully')"

EXPOSE 8000

CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]