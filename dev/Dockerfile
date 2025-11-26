FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create data directory
RUN mkdir -p /app/data

# Collect static files
RUN python manage.py collectstatic --noinput

# Run migrations and start server
CMD ["sh", "-c", "python manage.py migrate && python manage.py start_system && python manage.py runserver 0.0.0.0:8000"]