FROM nginx:alpine

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create static directory
RUN mkdir -p /app/static

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]