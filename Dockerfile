# Use an official Nginx image as the base
FROM nginx:alpine

# Remove default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy your static files to the Nginx public directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Use the default Nginx CMD
CMD ["nginx", "-g", "daemon off;"]