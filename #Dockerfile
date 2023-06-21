# Base image
FROM linode/lamp

# Set debconf to automatically select Indian geographic area
RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections \
    && echo "tzdata tzdata/Areas select Indian" | debconf-set-selections \
    && echo "tzdata tzdata/Zones/Indian select Kolkata" | debconf-set-selections



# Clone the code from GitHub repository
RUN apt update && apt install -y git
RUN git clone https://github.com/prajeet1000/demo.git

# Copy the cloned folder to the Apache web root
RUN rm -rf /var/www/example.com/public_html/index.html
RUN cp -r demo/* /var/www/example.com/public_html/

# Expose port 80 for Apache
EXPOSE 80

# Start Apache and MySQL services
CMD service apache2 start && service mysql start && tail -f /dev/null
