FROM ubuntu:latest
RUN  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apache2 \
    mysql-server \
    php7.0 \
    php7.0-bcmath \
    php7.0-mcrypt
COPY start-script.sh /root/
RUN chmod +x /root/start-script.sh 
CMD /root/start-script.sh





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
