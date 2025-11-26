FROM python:3.9-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create data directory
RUN mkdir -p /app/data

# Run migrations and start server
CMD ["sh", "-c", "python manage.py migrate && python manage.py start_system && python manage.py runserver 0.0.0.0:8000"]