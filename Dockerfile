# Base image
FROM alpine:latest

# Install necessary packages
RUN apk update && \
    apk add --no-cache git apache2 mysql-server php7-apache2 php7-mysqli

# Clone the code from GitHub repository
RUN git clone https://github.com/prajeet1000/website-deploy.git

# Copy the cloned folder to the Apache web root
RUN rm -rf /var/www/localhost/htdocs
RUN cp -r website-deploy/* /var/www/localhost/htdocs

# Expose port 80 for Apache
EXPOSE 80

# Start Apache service when the container starts
CMD ["httpd", "-D", "FOREGROUND"]
