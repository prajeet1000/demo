# Base image
FROM ubuntu:20.04

# Set debconf to automatically select Indian geographic area
RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
    && echo "tzdata tzdata/Areas select Indian" | debconf-set-selections \
    && echo "tzdata tzdata/Zones/Indian select Kolkata" | debconf-set-selections

# Install Apache, MySQL, and PHP
RUN apt-get update && apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql git

# Secure MySQL installation and start MySQL service
RUN service mysql start \
    && mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'prajeetkumar'; FLUSH PRIVILEGES;"

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite

# Cleanup unnecessary files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Start Apache and MySQL services
CMD service apache2 start && service mysql start && tail -f /var/log/apache2/error.log

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
