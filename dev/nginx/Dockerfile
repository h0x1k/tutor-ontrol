FROM nginx:alpine

# Копируем конфигурацию nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Создаем папку для статических файлов
RUN mkdir -p /app/static

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]