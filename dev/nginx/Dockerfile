FROM nginx:alpine

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy frontend files
COPY . /app/

# Copy backend static files (will be mounted from volume)
RUN mkdir -p /app/static

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]