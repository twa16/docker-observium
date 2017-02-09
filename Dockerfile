FROM ubuntu:16.04

# Install necessary packages
RUN apt-get update
RUN apt-get upgrade

RUN apt-get install -y libapache2-mod-php7.0 php7.0-cli php7.0-mysql php7.0-mysqli php7.0-gd php7.0-mcrypt php7.0-json \
php-pear snmp fping mysql-client python-mysqldb rrdtool subversion whois mtr-tiny ipmitool \
graphviz imagemagick apache2 libvirt-bin wget tar

#Create necessary folders
RUN mkdir -p /opt/observium && cd /opt

#Create Database
RUN mysql -u root -p $MYSQL_ROOT_PASSWORD -e "CREATE DATABASE observium DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

#Download Observium Latest
RUN cd /opt
RUN wget http://www.observium.org/observium-community-latest.tar.gz
RUN tar zxvf observium-community-latest.tar.gz

#Copy default config
RUN cd observium
RUN cp config.php.default config.php

#Setup Schema
./discovery.php -u root -p $MYSQL_ROOT_PASSWORD

