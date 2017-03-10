#!/bin/bash
set -e
timedatectl set-timezone "Europe/Berlin"
apt-get update -y

apt-get install -y python3 python3-pip python-virtualenv redis-server vim
if [ ! -e /venv ]; then
    /usr/bin/virtualenv /venv --python=/usr/bin/python3
fi
/bin/systemctl enable redis-server.service
/bin/systemctl restart redis-server.service
install -m 644 files/.barcodescanner.cfg /home/pi/.barcodescanner.cfg
install -m 700 ./update-barcodescanner /usr/sbin/update-barcodescanner
/usr/sbin/update-barcodescanner

