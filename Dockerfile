# Use the nginx:alpine base image
FROM nginx:alpine

# Install curl for downloading NGINX Prometheus exporter binary
RUN apk add --no-cache curl

# Download NGINX Prometheus exporter binary and extract it
RUN curl -LO https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v1.1.0/nginx-prometheus-exporter_1.1.0_linux_amd64.tar.gz \
    && tar -xzf nginx-prometheus-exporter_1.1.0_linux_amd64.tar.gz \
    && mv nginx-prometheus-exporter /usr/local/bin/ \
    && rm nginx-prometheus-exporter_1.1.0_linux_amd64.tar.gz
    
# Copy custom Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the video file into the container (if necessary)
COPY *.mp4 /usr/share/nginx/html/video.mp4

# Expose port 80
EXPOSE 80 9113

# Start NGINX and NGINX Prometheus exporter
CMD ["sh", "-c", "nginx && nginx-prometheus-exporter --nginx.scrape-uri=http://localhost/stub_status"]