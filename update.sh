#!/bin/bash
set -e
timedatectl set-timezone "Europe/Berlin"
apt-get update -y

install -m 700 ./update-barcodescanner /usr/sbin/update-barcodescanner
install -m 700 ./files/pm2-pi.service /etc/systemd/system/pm2-pi.service
systemctl enable pm2-pi.service
systemctl start pm2-pi.service
npm install pm2 -g
if [ ! -e /home/pi/barcodescanner-js ];then
    git clone https://github.com/franke1276/barcodescanner-js.git /home/pi/barcodescanner-js
fi
/usr/sbin/update-barcodescanner

