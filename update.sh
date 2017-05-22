#!/bin/bash
set -e
timedatectl set-timezone "Europe/Berlin"
apt-get update -y

apt-get install -y vim
install -m 644 files/barcodescanner.cfg /etc/barcodescanner
install -m 700 ./update-barcodescanner /usr/sbin/update-barcodescanner
/usr/sbin/update-barcodescanner

