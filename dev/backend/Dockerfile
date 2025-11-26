FROM python:3.9-slim

WORKDIR /app

# Копируем requirements первыми для кэширования
COPY requirements.txt .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код
COPY . .

# Создаем папку для данных
RUN mkdir -p /app/data

# Запускаем приложение
CMD ["sh", "-c", "python manage.py migrate && python manage.py start_system && python manage.py runserver 0.0.0.0:8000"]