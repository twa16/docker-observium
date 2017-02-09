FROM ubuntu:16.04

# Install necessary packages
RUN apt-get update
RUN apt-get upgrade

RUN apt-get install -y libapache2-mod-php7.0 php7.0-cli php7.0-mysql php7.0-mysqli php7.0-gd php7.0-mcrypt php7.0-json \
php-pear snmp fping mysql-client python-mysqldb rrdtool subversion whois mtr-tiny ipmitool \
graphviz imagemagick apache2 libvirt-bin

#Create necessary folders
RUN mkdir -p /opt/observium && cd /opt




