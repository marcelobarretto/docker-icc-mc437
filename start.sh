#!/bin/bash
/usr/bin/mysqld_safe & 
sleep 10s

mysql -u root -e "CREATE DATABASE mc437;"
mysql -u root -e "GRANT ALL ON mc437.* TO 'mc437'@'localhost' IDENTIFIED BY 'mc437';"

# start tomcat
/bin/sh -c "$CATALINA_HOME/bin/catalina.sh run"
