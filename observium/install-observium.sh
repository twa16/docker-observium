#!/bin/bash

if [ -f /opt/observium/observium-install-started ]; then
    echo "Installation Exists!"
    exit 0
fi

# Create file so we know we already started install
touch /opt/observium/observium-install-started

# Move Install Files
echo Moving Observium Files
mv /root/observium/* /opt/observium/

# Wait for DB
echo "Waiting up to 1 minute for DB to come online"
/bin/waitforit -host=mysqldb -port=3306 -timeout=60

#Create DB
echo Creating DB
mysql -h mysqldb -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE observium DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

#Setup MYSQL Configuration
echo "Configuring observium DB configuration"
sed "/^.config\[\'db/ d" /opt/observium/config.php.default > /opt/observium/config.php

echo "\$config['db_extension'] = 'mysqli';" >> /opt/observium/config.php
echo "\$config['db_host']      = 'mysqldb';" >> /opt/observium/config.php
echo "\$config['db_user']      = 'root';" >> /opt/observium/config.php
echo "\$config['db_pass']      = '$MYSQL_ROOT_PASSWORD';" >> /opt/observium/config.php
echo "\$config['db_name']      = 'observium';" >> /opt/observium/config.php

#Migrate DB
/opt/observium/discovery.php -u

# Add Initial User
/opt/observium/adduser.php admin nimda 10

#Run discovery
/opt/observium/discovery.php -h all
/opt/observium/discovery.php -h all

