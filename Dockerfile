# Use the official Ubuntu 16.04 base image
FROM ubuntu:16.04

# Update the package lists
RUN apt-get update

# Install Apache, MySQL, and PHP
RUN apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql

# Configure MySQL
RUN service mysql start




# Clone the code from GitHub repository
RUN apt update && apt install -y git
RUN git clone https://github.com/prajeet1000/demo.git

# Copy the cloned folder to the Apache web root
RUN rm -rf /var/www/example.com/public_html/index.html
RUN cp -r demo/* /var/www/example.com/public_html/

# Expose port 80 for Apache
EXPOSE 80 443

# Start Apache and MySQL services
CMD service apache2 start && service mysql start && tail -f /dev/null
