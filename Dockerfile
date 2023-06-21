# Base image
FROM debian

# Set debconf to automatically select Indian geographic area
RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
    && echo "tzdata tzdata/Areas select Indian" | debconf-set-selections \
    && echo "tzdata tzdata/Zones/Indian select Kolkata" | debconf-set-selections

# Install necessary packages
RUN apt-get update && apt-get install -y git apache2 mysql-server php libapache2-mod-php php-mysql

# Clone the code from GitHub repository
RUN git clone https://github.com/prajeet1000/website-deploy.git

# Copy the cloned folder to the Apache web root
RUN rm -rf /var/www/html/
RUN cp -r website-deploy/* /var/www/html/

# Expose port 80 for Apache
EXPOSE 80

# Start Apache service when the container starts
CMD ["apache2ctl", "-D", "FOREGROUND"]
