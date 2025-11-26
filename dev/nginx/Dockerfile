FROM nginx:alpine

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy frontend files
COPY . /app/

# Fix permissions - nginx runs as user nginx
RUN chown -R nginx:nginx /app && \
    chmod -R 755 /app && \
    chmod 644 /app/index.html

# Create nginx user directory
RUN mkdir -p /var/cache/nginx && \
    chown -R nginx:nginx /var/cache/nginx

EXPOSE 80

# Run as nginx user
CMD ["nginx", "-g", "daemon off;"]