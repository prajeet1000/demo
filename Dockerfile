
FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y apache2 
RUN apt-get install -y php 
RUN apt-get install -y php-dev 
RUN apt-get install -y php-mysql 
RUN apt-get install -y libapache2-mod-php 
RUN apt-get install -y php-curl 
RUN apt-get install -y php-json 
RUN apt-get install -y php-common 
RUN apt-get install -y php-mbstring 
RUN apt-get install -y composer




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
