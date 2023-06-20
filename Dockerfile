# Base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable Apache modules
RUN a2enmod rewrite

# Copy Apache configuration file
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Enable PHP module in # Start MySQL service
RUN service mysql start

# Secure MySQL installation
RUN mysql_secure_installation --use-default
Apache
RUN a2enmod php7.4



# Clone the code from the GitHub repository
RUN git clone https://github.com/prajeet1000/demo.git

# Copy the cloned folder to the Apache web root
RUN cp -r demo/* /var/www/html/

# Remove default content in the document root directory
RUN rm -rf /var/www/html/index.html

# Expose port 80 for Apache
EXPOSE 80

# Start Apache service
CMD ["apachectl", "-D", "FOREGROUND"]




