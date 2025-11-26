FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy our nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy Vue.js frontend build files
COPY . /usr/share/nginx/html/

# Set proper permissions
RUN chmod -R 644 /usr/share/nginx/html/* && \
    chmod 755 /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]