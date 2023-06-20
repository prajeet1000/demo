# Base image
FROM ubuntu:20.04

# Set debconf to automatically select Indian geographic area
RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
    && echo "tzdata tzdata/Areas select Indian" | debconf-set-selections \
    && echo "tzdata tzdata/Zones/Indian select Kolkata" | debconf-set-selections

# Install Git, Apache, MySQL, and PHP
RUN apt-get update && apt-get install -y git apache2
RUN apt-get install -y mysql-server
RUN echo "default_authentication_plugin=mysql_native_password" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Copy a script to configure MySQL and set the root password
COPY configure-mysql.sh /tmp/
RUN chmod +x /tmp/configure-mysql.sh
RUN /tmp/configure-mysql.sh

RUN apt-get install -y php libapache2-mod-php php-mysql



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
