FROM ubuntu:16.04

ENV WAITFORIT_VERSION="v1.3.1"

# Install necessary packages
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y --no-install-recommends libapache2-mod-php7.0 php7.0-cli php7.0-mysql php7.0-mysqli php7.0-gd php7.0-mcrypt php7.0-json \
php-pear snmp fping mysql-client python-mysqldb rrdtool subversion whois mtr-tiny ipmitool \
graphviz imagemagick apache2 libvirt-bin wget tar

# Install SSL Certificates
RUN apt-get install -y ca-certificates

#Copy in wait-for-it
RUN wget -q -O /bin/waitforit https://github.com/maxcnunes/waitforit/releases/download/$WAITFORIT_VERSION/waitforit-linux_amd64 
RUN chmod +x /bin/waitforit    

#Copy Install File
COPY install-observium.sh /bin/
RUN chmod +x /bin/install-observium.sh

#Download Observium Latest
RUN cd /root
RUN wget http://www.observium.org/observium-community-latest.tar.gz
RUN tar zxvf observium-community-latest.tar.gz -C /root

#Create necessary folders
RUN mkdir /root/observium/logs
RUN mkdir /root/observium/rrd
RUN chown www-data:www-data /root/observium/rrd

#Add Apache Config
RUN rm /etc/apache2/sites-available/000-default.conf
COPY observium-apache-conf /etc/apache2/sites-available/000-default.conf
RUN phpenmod mcrypt
RUN a2dismod mpm_event
RUN a2enmod mpm_prefork
RUN a2enmod php7.0
RUN a2enmod rewrite

#Add cron
COPY observium-cron  /etc/cron.d/observium

#COPY start.sh
COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
