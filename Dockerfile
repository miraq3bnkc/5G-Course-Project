# Use the nginx:alpine base image
FROM nginx:alpine

# Copy custom Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the video file into the container (if necessary)
COPY video.mp4 /usr/share/nginx/html

# Expose port 80
EXPOSE 80
