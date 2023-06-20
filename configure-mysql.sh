#!/bin/bash
set -e

# Start MySQL service
service mysql start

# Wait for MySQL service to be available
until mysqladmin ping >/dev/null 2>&1; do
    sleep 1
done

# Alter root user with provided password and flush privileges
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${prajeetkumar}'; FLUSH PRIVILEGES;"

# Stop MySQL service
service mysql stop
