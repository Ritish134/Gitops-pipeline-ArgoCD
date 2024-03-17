# Using official Nginx image
FROM nginx:alpine

# Copy index.html to the nginx web server root
COPY index.html /usr/share/nginx/html
