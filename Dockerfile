# Base image
FROM ubuntu:20.04



# Install Git, Apache, MySQL, and PHP
RUN apt-get update && apt-get install -y apache2
RUN apt install git

# Clone the code from GitHub repository
RUN git clone https://github.com/prajeet1000/simple-php-form.git

# Remove default content in the document root directory
RUN rm -r /var/www/html/*

# Copy the cloned folder to the Apache web root
RUN chmod -R 755 /var/www/html/
RUN cp -r simple-php-form/* /var/www/html/

# Expose port 80 for Apache
EXPOSE 80

# Start Apache when the container starts
CMD ["apache2ctl", "-D", "FOREGROUND"]
