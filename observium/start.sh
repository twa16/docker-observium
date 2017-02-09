#!/bin/bash
/bin/install-observium.sh
service apache2 restart
tail -f /var/log/dmesg > /dev/null
