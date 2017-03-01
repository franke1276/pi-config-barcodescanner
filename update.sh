#!/bin/bash
set -e
apt-get update -y

apt-get install -y python3 python3-pip python-virtualenv redis-server vim
if [ ! -e /venv ]; then
    /usr/bin/virtualenv /venv --python=/usr/bin/python3
fi
source /venv/bin/activate
pip install PyBarCodeScan --upgrade

/bin/systemctl daemon-reload

/bin/systemctl enable barcodescanner_server.service
/bin/systemctl restart barcodescanner_server.service

/bin/systemctl enable barcodescanner_reader.service
/bin/systemctl restart barcodescanner_reader.service

/bin/systemctl enable redis-server.service
/bin/systemctl restart redis-server.service
